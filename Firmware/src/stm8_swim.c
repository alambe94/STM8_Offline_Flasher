#include "stm8_swim.h"

uint8_t SWIM_INT_Value = 0;
uint8_t SWIM_INT_Count = 0;

uint8_t SWIM_IN_Parity_Bit = 0;
uint8_t SWIM_IN_Start_Bit = 0;
uint8_t SWIM_IN_Parity = 0;
uint8_t SWIM_IN_Data = 0;


INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
{
  SWIM_INT_Value = (SWIM_IN_PIN_PORT->IDR & SWIM_IN_PIN)?1:0;
  SWIM_INT_Count++;
}

void SWIM_Setup()
{
  CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
  GPIO_Init(NRST_PORT, NRST_PIN, GPIO_MODE_OUT_PP_HIGH_SLOW);
  GPIO_Init(SWIM_PORT, SWIM_PIN, GPIO_MODE_OUT_OD_HIZ_FAST);
  GPIO_Init(SWIM_IN_PIN_PORT, SWIM_IN_PIN, GPIO_MODE_IN_PU_IT);
  EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOC, EXTI_SENSITIVITY_FALL_ONLY);
  DISABLE_SWIM_INT();
  enableInterrupts();  
}

uint8_t SWIM_WOTF(uint32_t addr, uint8_t *buf, uint8_t size) 
{
  
  if (!buf || !size) {
    return 0;
  }
  
  if(SWIM_Write_Cammand(SWIM_CMD_WOTF))
  {
    if(SWIM_Write_Data(size))
    {
      if(SWIM_Write_Data((addr >> 16) & 0xFF))
      {
        if(SWIM_Write_Data((addr >> 8) & 0xFF))
        {
          if(SWIM_Write_Data((addr >> 0) & 0xFF))
          {
            for (uint8_t i = 0; i < size; i++) 
            {
              if(!SWIM_Write_Data(*buf++))
              {
                return 0;
              }
            }
            return 1;
          }
        }
      }
    }
  }
  
  return 0;
}

uint8_t SWIM_ROTF(uint32_t addr, uint8_t *buf, uint8_t size) 
{
  uint8_t timeout = 0xFF;
  uint8_t nack_count = 0;
  
  if (!buf || !size) {
    return 0;
  }
  
  if(SWIM_Write_Cammand(SWIM_CMD_ROTF))
  {
    if(SWIM_Write_Data(size))
    {
      if(SWIM_Write_Data((addr >> 16) & 0xFF))
      {
        if(SWIM_Write_Data((addr >> 8) & 0xFF))
        {
          if(SWIM_Write_Data((addr >> 0) & 0xFF))
          {
            ENABLE_SWIM_INT();
            
            while (size) 
            {
              while(SWIM_INT_Count<10)
              {
                timeout--;
                if(!timeout)
                {
                  break;
                }
              }
              SWIM_IN_Parity &= 0x01;
              SWIM_INT_Count = 0;
              if(SWIM_IN_Parity_Bit == SWIM_IN_Parity && SWIM_IN_Start_Bit)
              {
                *buf++ = SWIM_IN_Data;
                size--;
                SWIM_IN_Parity = 0;
                SWIM_Write_Parity_Ack_Bit(1);//send ack
              }
              else
              {
                nack_count++;
                if(nack_count>1)
                {
                  break;
                }
                SWIM_Write_Parity_Ack_Bit(0);//send nack
              }
              
            }
            DISABLE_SWIM_INT();
            return 1;
          }
        }
      } 
    }
  }
  
  return 0;
  
}


uint8_t SWIM_Enter()
{
  uint16_t timeout =0xFFFF;
  
  NRST_PIN_LOW();
  delay_ms(10);
 
  SWIM_PIN_LOW();
  delay_ms(10);
  
  for (uint8_t i=0; i<4; i++) 
  {
    SWIM_PIN_HIGH();
    delay_us(500);
    SWIM_PIN_LOW();
    delay_us(500);
  }
  for (uint8_t i=0; i<4; i++) 
  {
    SWIM_PIN_HIGH();
    delay_us(250);
    SWIM_PIN_LOW();
    delay_us(250);
  }
  SWIM_PIN_HIGH();
  // approx 30us to give sync pulse of 16us
  while(SWIM_PIN_READ()) //wait on high
  {
    timeout--;
    if(!timeout)
    {
      return 0;
    }
  }
  //sync pulse
  timeout = 0xFFFF;
  while(!SWIM_PIN_READ())//wait on low
  {
    timeout--;
    if(!timeout)
    {
      return 0;
    }
  }
  
  delay_ms(1);
  
  uint8_t csr = 0xA0;
  if(!SWIM_WOTF(SWIM_CSR, &csr, 1))
  {
    return 0;
  }
 
  delay_ms(1);
  
  NRST_PIN_HIGH();
  
  delay_ms(1);
  
  return 1;
  
}


uint8_t SWIM_Stall_CPU()
{
  uint8_t temp[1];
  if(SWIM_ROTF(SWIM_DM_CSR2,temp,1))
  {
    temp[0]|=0x08;
    return SWIM_WOTF(SWIM_DM_CSR2,temp,1);//stall the cpu
  }
  return 0;
}

uint8_t SWIM_Soft_Reset()
{
  return SWIM_Write_Cammand(SWIM_CMD_SRST);
}

uint8_t SWIM_Unlock_Flash()
{
  uint8_t temp[1];
  temp[0]=SWIM_FLASH_PUKR_KEY1;
  if(SWIM_WOTF(SWIM_FLASH_PUKR,temp,1))
  {
    temp[0]=SWIM_FLASH_PUKR_KEY2;
    return SWIM_WOTF(SWIM_FLASH_PUKR,temp,1);
  }
  return 0;
}

uint8_t SWIM_Lock_Flash()
{
  uint8_t temp[1];
  if(SWIM_ROTF(SWIM_FLASH_IAPSR,temp,1))
  {
    temp[0]&= (uint8_t)0xFD; //
    return SWIM_WOTF(SWIM_FLASH_IAPSR,temp,1);
  }
  return 0;
}


uint8_t SWIM_Unlock_EEPROM()
{
  uint8_t temp[1];
  temp[0]=SWIM_FLASH_DUKR_KEY1;
  if(SWIM_WOTF(SWIM_FLASH_DUKR,temp,1))
  {
    temp[0]=SWIM_FLASH_DUKR_KEY2;
    return SWIM_WOTF(SWIM_FLASH_DUKR,temp,1);
  }
  return 0;
}


uint8_t SWIM_Lock_EEPROM()
{
  uint8_t temp[1];
  if(SWIM_ROTF(SWIM_FLASH_IAPSR,temp,1))
  {
    temp[0]&= (uint8_t)0xF7; //
    return SWIM_WOTF(SWIM_FLASH_IAPSR,temp,1);
  }
  return 0;
}


uint8_t SWIM_Unlock_OptionByte()
{
  uint8_t temp[2];
  if(SWIM_ROTF(SWIM_FLASH_CR2,temp,2))
  {
    temp[0]|=(uint8_t)(0x80);  // OPT = 1 and NOPT = 0
    temp[1]&=(uint8_t)(0x7F);
    return SWIM_WOTF(SWIM_FLASH_CR2,temp,2);
  }
  return 0;
}


uint8_t SWIM_Lock_OptionByte()
{
  uint8_t temp[2];
  if(SWIM_ROTF(SWIM_FLASH_CR2,temp,2))
  {
    temp[0]&=(uint8_t)(0x7F); // OPT = 0 and NOPT = 1
    temp[1]|=(uint8_t)(0x80); 
    return SWIM_WOTF(SWIM_FLASH_CR2,temp,2);
  }
  return 0;
}


uint8_t SWIM_Wait_For_Write()
{
  uint8_t flagstatus[1]={0};
  uint16_t timeout = 0xFFFF;
  
  while ((flagstatus[0] == 0x00) && (timeout != 0x00))
  {
    SWIM_ROTF(SWIM_FLASH_IAPSR,flagstatus,1);
    flagstatus[0] = (uint8_t)(flagstatus[0]&FLASH_IAPSR_EOP);
    timeout--;
  }
  
  if (timeout == 0x00 )
  {
    return 0;
  }
  
  return 1;
}


uint8_t SWIM_Enable_Block_Programming()
{
  uint8_t temp[2];
  if(SWIM_ROTF(SWIM_FLASH_CR2,temp,2))
  {
    temp[0]|=0x01;  //Flash_CR2  standard block programming
    temp[1]&=0xFE;  //Flash_NCR2
    return SWIM_WOTF(SWIM_FLASH_CR2,temp,2); 
  }
  return 0;
}

uint8_t SWIM_Reset_Device()
{
  uint8_t temp[1]={0xA4};
  if(SWIM_WOTF(SWIM_CSR, temp, 1))
  {
    SWIM_Soft_Reset();
    NRST_PIN_LOW();
    delay_ms(2);
    NRST_PIN_LOW();
    return 1;
    
  }
  return 0;
}




uint8_t SWIM_Write_Data(uint8_t data)
{
  uint8_t timeout = 50;
  uint8_t start_bit = 0;
  uint8_t data_frame[8];
  uint8_t parity_bit = 0;
  
  data_frame[0] = data>>7 & 0x01;
  data_frame[1] = data>>6 & 0x01;
  data_frame[2] = data>>5 & 0x01;
  data_frame[3] = data>>4 & 0x01;
  data_frame[4] = data>>3 & 0x01;
  data_frame[5] = data>>2 & 0x01;
  data_frame[6] = data>>1 & 0x01;
  data_frame[7] = data>>0 & 0x01;
  for (uint8_t i = 0; i <=7; i++) 
  {
      parity_bit += data_frame[i];
  }
  parity_bit &= 0x01;
  
  SWIM_Write_Bit(start_bit);
  SWIM_Write_Bit(data_frame[0]);
  SWIM_Write_Bit(data_frame[1]);
  SWIM_Write_Bit(data_frame[2]);
  SWIM_Write_Bit(data_frame[3]);
  SWIM_Write_Bit(data_frame[4]);
  SWIM_Write_Bit(data_frame[5]);
  SWIM_Write_Bit(data_frame[6]);
  SWIM_Write_Bit(data_frame[7]);
  SWIM_Write_Parity_Ack_Bit(parity_bit);
    
  ENABLE_SWIM_INT();
  
  while(!SWIM_INT_Count)
  {
    timeout--;
    if(!timeout)
    {
      DISABLE_SWIM_INT();
      return 0;
    }
  }
  DISABLE_SWIM_INT();
  SWIM_INT_Count = 0;
  
  return SWIM_INT_Value;

}


uint8_t SWIM_Write_Cammand(uint8_t cammand)
{
  uint8_t timeout = 255;
  uint8_t start_bit = 0;
  uint8_t data_frame[3];
  uint8_t parity_bit = 0;
  
  data_frame[0] = cammand>>2 & 0x01;
  data_frame[1] = cammand>>1 & 0x01;
  data_frame[2] = cammand>>0 & 0x01;

  for (uint8_t i = 0; i <=2; i++) 
  {
    parity_bit += data_frame[i];
  }
  parity_bit &= 0x01;
  
  SWIM_Write_Bit(start_bit);
  SWIM_Write_Bit(data_frame[0]);
  SWIM_Write_Bit(data_frame[1]);
  SWIM_Write_Bit(data_frame[2]);
  SWIM_Write_Parity_Ack_Bit(parity_bit);
  
  ENABLE_SWIM_INT();
  
  while(!SWIM_INT_Count)
  {
    timeout--;
    if(!timeout)
    {
      DISABLE_SWIM_INT();
      return 0;
    }
  }
  DISABLE_SWIM_INT();
  SWIM_INT_Count = 0;  
  
  return SWIM_INT_Value;
  
}


