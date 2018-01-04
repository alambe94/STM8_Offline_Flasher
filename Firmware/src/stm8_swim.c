#include "stm8_swim.h"


uint8_t SWIM_PULSE_1=(4); 
uint8_t SWIM_PULSE_0=(40);  

uint8_t INT_Capture[11]={0};
uint8_t INT_Capture_Index=0;

void SWIM_Setup()
{
  CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
  
  GPIO_Init(SWIM_NRST_port, SWIM_NRST_pin, GPIO_MODE_OUT_PP_HIGH_SLOW);
  
  GPIO_Init(SWIM_INT_port, SWIM_INT_pin, GPIO_MODE_IN_PU_NO_IT);//disable interupt for now
  EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOC, EXTI_SENSITIVITY_FALL_ONLY);
  
  GPIO_Init(SWIM_OUT_PORT, SWIM_OUT_pin, GPIO_MODE_OUT_PP_HIGH_FAST); //pwm
  
  TIM2_TimeBaseInit(TIM2_PRESCALER_1, 43);  //  (8Mhz/22) swim period
  
  /* Channel 1 PWM configuration */ 
  TIM2_OC1Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, 0x00, TIM2_OCPOLARITY_LOW ); 
  TIM2_OC1PreloadConfig(ENABLE);
  
  /* Enables TIM peripheral Preload register on ARR */
  TIM2_ARRPreloadConfig(ENABLE);
  TIM2_Cmd(ENABLE);
  
  enableInterrupts();//globle interrupt enable 
  
}



uint8_t SWIM_Send_Data(uint8_t data,uint8_t len,uint8_t retry)
{
  uint8_t SWIM_TX[10]={0};
  uint8_t m,parity,timeout;
  uint8_t* ptr=SWIM_TX;
  int8_t i;
  
  parity=0;
  *ptr++=SWIM_PULSE_0;//start bit
  for (i = len - 1; i >= 0; i--) 
  {
    m = (data >> i) & 1;
    if (m) {
      *ptr++ = SWIM_PULSE_1;
    } else {
      *ptr++ = SWIM_PULSE_0;
    }
    parity += m;
  }
  if (parity & 1) {
    *ptr++ = SWIM_PULSE_1;
  } else {
    *ptr++ = SWIM_PULSE_0;
  }
  
  do
  {
    TIM->CNTRH=0x00;
    TIM->CNTRL=0x00;
    INT_Capture_Index=0;
    if(len==3)
    {  
      TIM->SR1 &= (uint8_t)~TIM_FLAG_UPDATE; 
      TIM->CCRL = SWIM_TX[0];
      while(!(TIM->SR1 & (uint8_t)TIM_FLAG_UPDATE));
      TIM->SR1 &= (uint8_t)~TIM_FLAG_UPDATE; 
      
      TIM->CCRL = SWIM_TX[1];
      while(!(TIM->SR1 & (uint8_t)TIM_FLAG_UPDATE));
      TIM->SR1 &= (uint8_t)~TIM_FLAG_UPDATE;
      
      TIM->CCRL = SWIM_TX[2];
      while(!(TIM->SR1 & (uint8_t)TIM_FLAG_UPDATE));
      TIM->SR1 &= (uint8_t)~TIM_FLAG_UPDATE;
      
      TIM->CCRL = SWIM_TX[3];
      while(!(TIM->SR1 & (uint8_t)TIM_FLAG_UPDATE));
      TIM->SR1 &= (uint8_t)~TIM_FLAG_UPDATE;
      
      TIM->CCRL = SWIM_TX[4];
      while(!(TIM->SR1 & (uint8_t)TIM_FLAG_UPDATE));
      TIM->SR1 &= (uint8_t)~TIM_FLAG_UPDATE;
      
      TIM->CCRL = 0x00;
      Enable_SWIM_INT(); //enable intrrupt on SWIM_INT
      while(!(TIM->SR1 & (uint8_t)TIM_FLAG_UPDATE));
      TIM->SR1 &= (uint8_t)~TIM_FLAG_UPDATE;
      
      
    }
    
    
    else if(len==8)
    {
      TIM->SR1 &= (uint8_t)~TIM_FLAG_UPDATE; 
      
      TIM->CCRL = SWIM_TX[0];
      while(!(TIM->SR1 & (uint8_t)TIM_FLAG_UPDATE));
      TIM->SR1 &= (uint8_t)~TIM_FLAG_UPDATE; 
      
      TIM->CCRL = SWIM_TX[1];
      while(!(TIM->SR1 & (uint8_t)TIM_FLAG_UPDATE));
      TIM->SR1 &= (uint8_t)~TIM_FLAG_UPDATE; 
      
      TIM->CCRL = SWIM_TX[2];
      while(!(TIM->SR1 & (uint8_t)TIM_FLAG_UPDATE));
      TIM->SR1 &= (uint8_t)~TIM_FLAG_UPDATE; 
      
      TIM->CCRL = SWIM_TX[3];
      while(!(TIM->SR1 & (uint8_t)TIM_FLAG_UPDATE));
      TIM->SR1 &= (uint8_t)~TIM_FLAG_UPDATE; 
      
      TIM->CCRL = SWIM_TX[4];
      while(!(TIM->SR1 & (uint8_t)TIM_FLAG_UPDATE));
      TIM->SR1 &= (uint8_t)~TIM_FLAG_UPDATE; 
      
      TIM->CCRL = SWIM_TX[5];
      while(!(TIM->SR1 & (uint8_t)TIM_FLAG_UPDATE));
      TIM->SR1 &= (uint8_t)~TIM_FLAG_UPDATE; 
      
      TIM->CCRL = SWIM_TX[6];
      while(!(TIM->SR1 & (uint8_t)TIM_FLAG_UPDATE));
      TIM->SR1 &= (uint8_t)~TIM_FLAG_UPDATE; 
      
      TIM->CCRL = SWIM_TX[7];
      while(!(TIM->SR1 & (uint8_t)TIM_FLAG_UPDATE));
      TIM->SR1 &= (uint8_t)~TIM_FLAG_UPDATE; 
      
      TIM->CCRL = SWIM_TX[8];
      while(!(TIM->SR1 & (uint8_t)TIM_FLAG_UPDATE));
      TIM->SR1 &= (uint8_t)~TIM_FLAG_UPDATE; 
      
      TIM->CCRL=SWIM_TX[9];
      while(!(TIM->SR1 & (uint8_t)TIM_FLAG_UPDATE));      
      TIM->SR1 &= (uint8_t)~TIM_FLAG_UPDATE;
      
      TIM->CCRL = 0x00;
      Enable_SWIM_INT(); //enable intrrupt on SWIM_INT
      while(!(TIM->SR1 & (uint8_t)TIM_FLAG_UPDATE));
      TIM->SR1 &= (uint8_t)~TIM_FLAG_UPDATE;
      
    }
    else
    {
      Disable_SWIM_INT(); //disable interrupt on SWIM_INT
      return 0;
    }
    
    timeout=255;
    while(INT_Capture_Index<1 && timeout--);
    Disable_SWIM_INT(); //disable interrupt on SWIM_INT
    
    if(INT_Capture_Index==1 && INT_Capture[0])
    {
      INT_Capture_Index=0;
      return 1;
    }
    
  }  while(retry--);
  
  
  return 0;
}


void  SWIM_HIGH()
{
  
  TIM->CCRL = (uint8_t)(0x00);
  while(!(TIM->SR1 & (uint8_t)TIM_FLAG_UPDATE));
  TIM->SR1 &= (uint8_t)~TIM_FLAG_UPDATE;
  //GPIO_WriteHigh(SWIM_OUT_PORT,SWIM_OUT_pin);
}


void  SWIM_LOW()
{
  TIM->CCRL = (uint8_t)(0xFF);
  while(!(TIM->SR1 & (uint8_t)TIM_FLAG_UPDATE));
  TIM->SR1 &= (uint8_t)~TIM_FLAG_UPDATE;
  //GPIO_WriteLow(SWIM_OUT_PORT,SWIM_OUT_pin);
}


void  NRST_HIGH()
{
  GPIO_WriteHigh(SWIM_NRST_port,SWIM_NRST_pin);
}

void  NRST_LOW()
{
  GPIO_WriteLow(SWIM_NRST_port,SWIM_NRST_pin);
}




uint8_t SWIM_WOTF(uint32_t addr, uint8_t *buf, uint16_t size) {
  uint8_t cur_len, i;
  uint32_t cur_addr = addr;
  uint8_t ret = 1;
  
  if (!buf || !size) {
    return 0;
  }
  
  while (size) {
    cur_len = (size > 255) ? 255 : size;
    
    ret = SWIM_Send_Data(SWIM_CMD_WOTF, SWIM_CMD_LEN, 0);
    if (!ret) {
      return 0;
    }
    ret = SWIM_Send_Data(cur_len, 8, 0);
    if (!ret) {
      return 0;
    }
    ret = SWIM_Send_Data((cur_addr >> 16) & 0xFF, 8, 0);
    if (!ret) {
      return 0;
      
    }
    ret = SWIM_Send_Data((cur_addr >> 8) & 0xFF, 8, 0);
    if (!ret) {
      return 0;
      
    }
    ret = SWIM_Send_Data((cur_addr >> 0) & 0xFF, 8, 0);
    if (!ret) {
      return 0;
    }
    
    for (i = 0; i < cur_len; i++) {
      ret = SWIM_Send_Data(*buf++, 8, 0);
      if (!ret) {
        return 0;
      }
    }
    cur_addr += cur_len;
    size -= cur_len;
  }
  
  return ret;
}



uint8_t SWIM_ROTF(uint32_t addr, uint8_t *buf, uint16_t size) {
  uint8_t cur_len,retry_count=2;
  uint32_t cur_addr = addr;
  uint8_t ret = 0;
  uint8_t ptrTX[1];
  
  uint8_t first_byte = 1, parity = 0, i;
  uint8_t nbytes;
  uint16_t timeout;
  uint8_t temp;
  
  if (!buf || !size) {
    return 0;
  }
  
  while (size) {
    cur_len = (size > 255) ? 255 : size;
    nbytes=cur_len;
    
    ret = SWIM_Send_Data(SWIM_CMD_ROTF, SWIM_CMD_LEN, 1);
    if (!ret) {
      return 0;
      
    }
    ret = SWIM_Send_Data(cur_len, 8, 1);
    if (!ret) {
      return 0;
      
    }
    ret = SWIM_Send_Data((cur_addr >> 16) & 0xFF, 8, 1);
    if (!ret) {
      return 0;
      
    }
    ret = SWIM_Send_Data((cur_addr >> 8) & 0xFF, 8, 1);
    if (!ret) {
      return 0;
      
    }
    
    ret = SWIM_Send_Data((cur_addr >> 0) & 0xFF, 8, 1);
    if (!ret) {
      return 0;
      
    }
    
    do {
      
      if (first_byte)
      {
        first_byte = 0;
        ptrTX[0] = SWIM_PULSE_0; /*send Nack */
        delay_us(50);
      }
      
      INT_Capture_Index=0;
      
      TIM->CNTRH=0x00;
      TIM->CNTRL=0x00;
      TIM->SR1 &= (uint8_t)~TIM_FLAG_UPDATE; 
      TIM->CCRL = ptrTX[0];
      while(!(TIM->SR1 & (uint8_t)TIM_FLAG_UPDATE));
      TIM->SR1 &= (uint8_t)~TIM_FLAG_UPDATE; 
      
      TIM->CCRL = 0x00;
      
      Enable_SWIM_INT(); //enable intrrupt on SWIM_INT
      
      while(!(TIM->SR1 & (uint8_t)TIM_FLAG_UPDATE));
      TIM->SR1 &= (uint8_t)~TIM_FLAG_UPDATE; 
      
      timeout=1000;
      while(INT_Capture_Index<10 && timeout--);//capture data
      Disable_SWIM_INT(); //disable interrupt on SWIM_INT
      
      
      if (INT_Capture[0] && INT_Capture_Index==10) /* start bit from mcu */
      {
        INT_Capture_Index=0;
        parity = 0;
        temp=0;
        for (i = 0; i < 8; i++) {
          if (INT_Capture[1 + i]) {
            temp |= 1 << (7 - i);
            parity++;
          }
        }
        if (INT_Capture[9] && (parity & 1)) /*parity check */
        {
          retry_count=2;
          ptrTX[0] = SWIM_PULSE_1; /*send ack */
          *buf++=temp;
          nbytes--;
        }
        else if (!INT_Capture[9] && !(parity & 1)) /*parity check */
        {
          retry_count=2;
          ptrTX[0] = SWIM_PULSE_1; /*send ack */
          *buf++=temp;
          nbytes--;
        }
        else
        {
          ptrTX[0] = SWIM_PULSE_0; /*send Nack */
          retry_count--;
          
        }
        
      }
      
      else
      {
        retry_count--;
        ptrTX[0] = SWIM_PULSE_0; /*send Nack */
      }
      
      if(!retry_count)
      {
        Disable_SWIM_INT();//disable interupt
        return 0;   
      }
      
    }while(nbytes);
    
    
    cur_addr += cur_len;
    size -= cur_len;
  }
  Disable_SWIM_INT();//disable interupt
  
  TIM->CNTRH=0x00;
  TIM->CNTRL=0x00;
  TIM->SR1 &= (uint8_t)~TIM_FLAG_UPDATE;
  TIM->CCRL = SWIM_PULSE_1; //send ack for last byte
  while(!(TIM->SR1 & (uint8_t)TIM_FLAG_UPDATE));
  TIM->SR1 &= (uint8_t)~TIM_FLAG_UPDATE;
  TIM->CCRL = 0x00;
  
  
  return 1;
}


uint8_t SWIM_Enter()
{
  uint8_t i;
  uint16_t timeout=1000;
  uint8_t retry=2;
  
  while(retry--)
  {
    NRST_LOW();
    delay_ms(10);
    
    NRST_HIGH();
    delay_ms(30);
 
    
    NRST_LOW();
    delay_ms(10);
 
    
    SWIM_LOW();
    delay_ms(2);

    
    INT_Capture_Index=0;
    
    for (i = 0; i < 4u; i++) {
      
      SWIM_HIGH();
     
      delay_us(500);
  
      SWIM_LOW();
      
      delay_us(500);

    }
    for (i = 0; i < 4u; i++) {
      
      SWIM_HIGH();
      
      delay_us(250);

      
      SWIM_LOW();
      
      delay_us(250);

    }
    Enable_SWIM_INT(); //enable intrrupt on SWIM_INT
    SWIM_HIGH();
    
    while(INT_Capture_Index<1u && --timeout);//capture data
    Disable_SWIM_INT(); //disable interrupt on SWIM_INT
    
    if(INT_Capture_Index==1u && !INT_Capture[0])
    {
      INT_Capture_Index=0;
      delay_ms(10);
      uint8_t temp = 0xA0;
      i=SWIM_WOTF(SWIM_CSR, &temp, 1);
      if(i)
      {
        NRST_HIGH();
        return 1;
      }
      
    }
  }
  NRST_HIGH();
  return 0;
}

uint8_t SWIM_Stall_CPU()
{
  uint8_t temp[1];
  if(SWIM_ROTF(SWIM_DM_CSR2,temp,1))
  {
    temp[0]=0x08;
    return SWIM_WOTF(SWIM_DM_CSR2,temp,1);//stall the cpu
  }
  return 0;
}

uint8_t SWIM_Soft_Reset()
{
  return SWIM_Send_Data(SWIM_CMD_SRST,SWIM_CMD_LEN,1);
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


uint8_t SWIM_Unlock_EEprom()
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


uint8_t SWIM_Lock_EEprom()
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
    NRST_LOW();
    delay_ms(2);
    NRST_HIGH();
    return 1;
    
  }
  return 0;
}


