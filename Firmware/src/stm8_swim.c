#include "stm8_swim.h"
#include "stm8s_it.h"


uint8_t INT_Count = 0;
uint8_t RX_Frame[15] = {0};

INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
{
  if(SWIM_PIN_READ())
  {
    RX_Frame[INT_Count++] = 0x01;
  }
  else
  {
    RX_Frame[INT_Count++] = 0x00;
  }
}


void SWIM_Setup(void)
{
  CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
  GPIO_Init(SWIM_PORT, SWIM_PIN, GPIO_MODE_OUT_OD_HIZ_SLOW);
  GPIO_Init(NRST_PORT, NRST_PIN, GPIO_MODE_OUT_PP_HIGH_SLOW);
  EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOC, EXTI_SENSITIVITY_FALL_ONLY);
  enableInterrupts();
}


uint8_t SWIM_Enter()
{
  uint8_t timeout =0xFF;
  
  NRST_PIN_LOW();
  delay_ms(1);
 
  /*1. To make the SWIM active, the SWIM pin must be forced low during a period of 16 µs.*/
  SWIM_PIN_LOW();
  delay_ms(1);
  
  /*2. Four pulses at 1 kHz followed by four pulses at 2 kHz*/
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
  
  /*3. After the entry sequence, the SWIM enters in SWIM active state, and the HSI oscillator
  is automatically turned ON. */
  
  SWIM_PIN_HIGH();
  // approx 30us to give sync pulse of 16us
  while(SWIM_PIN_READ() && --timeout); //wait on high
  
  if(!timeout)
  {
    return 0;
  }
  
  
  /*4. SWIM sends a synchronization frame to the host 128 x SWIM clocks = 16us */
  timeout = 0xFF;
  while(!SWIM_PIN_READ() && --timeout);//wait on low
  
  if(!timeout)
  {
    return 0;
  }
  
  /*5. SWIM line must be released at 1 to guarantee that the SWIM is ready for communication (at least 300 ns).*/
  delay_us(500);
  
  
  /*6. Write 0A0h in the SWIM_CSR:*/
  uint8_t csr = 0xA0;
  if(!SWIM_WOTF(SWIM_CSR, &csr, 1))
  {
    return 0;
  }
  
  /*6. Release the reset which starts the option byte loading sequence. Wait 1 ms for
  stabilization*/  
  NRST_PIN_HIGH();
  delay_ms(1);
  
  SWIM_PIN_LOW();
  delay_us(50);
  SWIM_PIN_HIGH();
  
  return 1;
  
}


uint8_t SWIM_Write_Cammand(uint8_t cammand)
{
  uint8_t timeout = 255;
  uint8_t data_frame[3] = "0";
  uint8_t parity = 0;
  
  data_frame[2] = cammand>>2 & 0x01;
  data_frame[1] = cammand>>1 & 0x01;
  data_frame[0] = cammand>>0 & 0x01;

  for (uint8_t i = 0; i <=2; i++) 
  {
    parity += data_frame[i];
  }
  parity &= 0x01;
  
  SWIM_PIN_OUT();
  
  SWIM_Write_Bit(0);// start bit
  SWIM_Write_Bit(data_frame[2]);
  SWIM_Write_Bit(data_frame[1]);
  SWIM_Write_Bit(data_frame[0]);
  SWIM_Write_Parity_Ack_Bit(parity);
  
  while(!INT_Count && --timeout);
  SWIM_PIN_OUT();
  INT_Count = 0;
  if(timeout)
  {
    return RX_Frame[0]; 
  }  
  return 0;
}


uint8_t SWIM_Write_Data(uint8_t data)
{
  uint8_t timeout = 255;
  uint8_t data_frame[8];
  uint8_t parity = 0;
  
  //unroll for loop for faster execution
  data_frame[7] = data>>7 & 0x01;
  data_frame[6] = data>>6 & 0x01;
  data_frame[5] = data>>5 & 0x01;
  data_frame[4] = data>>4 & 0x01;
  data_frame[3] = data>>3 & 0x01;
  data_frame[2] = data>>2 & 0x01;
  data_frame[1] = data>>1 & 0x01;
  data_frame[0] = data>>0 & 0x01;
  
  //unroll for loop for faster execution
  parity  = data_frame[7];
  parity += data_frame[6];
  parity += data_frame[5];
  parity += data_frame[4];
  parity += data_frame[3];
  parity += data_frame[2];
  parity += data_frame[1];
  parity += data_frame[0];
  parity &= 0x01;// XOR of all frame bits
  
  
  SWIM_PIN_OUT();
  SWIM_Write_Bit(0);// start bit
  SWIM_Write_Bit(data_frame[7]);
  SWIM_Write_Bit(data_frame[6]);
  SWIM_Write_Bit(data_frame[5]);
  SWIM_Write_Bit(data_frame[4]);
  SWIM_Write_Bit(data_frame[3]);
  SWIM_Write_Bit(data_frame[2]);
  SWIM_Write_Bit(data_frame[1]);
  SWIM_Write_Bit(data_frame[0]);
  SWIM_Write_Parity_Ack_Bit(parity);
  
  while(!INT_Count && --timeout);
  SWIM_PIN_OUT();
  INT_Count = 0;
  if(timeout)
  {
    return RX_Frame[0]; 
  }  
  return 0;
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
            while(size--)
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
  uint8_t timeout = 255;
  uint8_t start_bit = 0;
  uint8_t parity = 0;
  uint8_t parity_bit = 0;
  uint8_t rx_data = 0;  
  
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
            
            delay_us(40); //dicard first frame
            SWIM_Write_Parity_Ack_Bit(0);//send nack
            
            while (size) 
            {
              
              while(INT_Count<10 && --timeout);
              INT_Count = 0;
              if(timeout)
              {
                timeout = 255;
                start_bit = RX_Frame[0];
                parity_bit = RX_Frame[9]?1:0;
                
                /*
                for(uint8_t i=1; i<=8; i++)
                {
                if(RX_Frame[i])
                {
                rx_data |= 1 << (8-i);
                parity++;
              }
              }
                */
                
                //unroll for loop for faster execution
                rx_data  = RX_Frame[1]<<7;
                rx_data |= RX_Frame[2]<<6;
                rx_data |= RX_Frame[3]<<5;
                rx_data |= RX_Frame[4]<<4;
                rx_data |= RX_Frame[5]<<3;
                rx_data |= RX_Frame[6]<<2;
                rx_data |= RX_Frame[7]<<1;
                rx_data |= RX_Frame[8]<<0;
                
                //unroll for loop for faster execution
                parity  = RX_Frame[1];
                parity += RX_Frame[2];
                parity += RX_Frame[3];
                parity += RX_Frame[4];
                parity += RX_Frame[5];
                parity += RX_Frame[6];
                parity += RX_Frame[7];
                parity += RX_Frame[8];
                parity &= 0x01;// XOR of all frame bits
                                
                if(parity_bit == parity_bit && start_bit)
                {
                  *buf++ = rx_data;
                  size--;
                  SWIM_PIN_OUT();
                  SWIM_Write_Parity_Ack_Bit(1);//send ack
                }
                else
                {
                  break;
                }
              }
              else
              {
                break;
              }
              
            }
            
          }
        }
      } 
    }
  }
  
  SWIM_PIN_OUT();
  if(!size)
  {
    return 1;
  }
  
  return 0; 
}


uint8_t SWIM_Soft_Reset()
{
  return SWIM_Write_Cammand(SWIM_CMD_SRST);
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
    temp[1]|=(uint8_t)(0x80); // enable opt
    
    if(SWIM_WOTF(SWIM_FLASH_CR2,temp,2))
    {
      return  SWIM_Unlock_EEPROM();//opt unlock sequence 
    }
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
    temp[0] &= 0xFD; //
    return SWIM_WOTF(SWIM_FLASH_IAPSR,temp,1);
  }
  return 0;
}


uint8_t SWIM_Enable_Block_Programming()
{
  uint8_t temp[2];
  if(SWIM_ROTF(SWIM_FLASH_CR2,temp,2))
  {
    temp[0] |= 0x01;  //Flash_CR2  standard block programming
    temp[1] &= 0xFE;  //Flash_NCR2
    return SWIM_WOTF(SWIM_FLASH_CR2,temp,2); 
  }
  return 0;
}


uint8_t SWIM_Wait_For_Write_Access()
{
  uint8_t flagstatus[1]={0};
  uint16_t timeout = 0xFFFF;
  
  while ((flagstatus[0] == 0x00) && --timeout)
  {
    SWIM_ROTF(SWIM_FLASH_IAPSR,flagstatus,1);
    flagstatus[0] = (uint8_t)(flagstatus[0]&FLASH_IAPSR_EOP);
  }
  
  if (timeout)
  {
    return 1;
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
    NRST_PIN_HIGH();
    return 1;
  }
  return 0;
}


