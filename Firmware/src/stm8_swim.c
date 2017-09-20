#include "stm8_swim.h"


uint8_t SWIM_PULSE_1=(0x7f);
uint8_t SWIM_PULSE_0=(0x01);

uint8_t INT_Capture[11]={0};
uint8_t INT_Capture_Index=0;

uint32_t delay;

void SWIM_setup(void)
{
  CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
  GPIO_Init(MOSI_port, MOSI_pin,GPIO_MODE_OUT_PP_HIGH_FAST);
  GPIO_Init(MISO_port, MISO_pin,GPIO_MODE_IN_FL_NO_IT);
  GPIO_Init(SWIM_NRST_port, SWIM_NRST_pin,GPIO_MODE_OUT_PP_HIGH_FAST);
  GPIO_Init(SWIM_INT_port, SWIM_INT_pin,GPIO_MODE_IN_PU_NO_IT);//disable interupt for now
  EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOC,EXTI_SENSITIVITY_FALL_ONLY);
  
  
  
  SPI_DeInit();
  SPI_Init(SPI_FIRSTBIT_MSB, 
           SPI_BAUDRATEPRESCALER_4, 
           SPI_MODE_MASTER, 
           SPI_CLOCKPOLARITY_HIGH, 
           SPI_CLOCKPHASE_2EDGE, 
           SPI_DATADIRECTION_2LINES_FULLDUPLEX, 
           SPI_NSS_SOFT, 
           (0x07));
  
  SPI->DR=0xFF;
  SPI_Cmd(ENABLE);
  
  while(!(SPI->SR & (uint8_t)SPI_FLAG_TXE));
  SPI->DR;
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
    INT_Capture_Index=0;
    if(len==3)
    {  
      SPI->DR=SWIM_TX[0];
      while(!(SPI->SR & (uint8_t)SPI_FLAG_TXE));
      SPI->DR;
      
      SPI->DR=SWIM_TX[1];
      while(!(SPI->SR & (uint8_t)SPI_FLAG_TXE));
      SPI->DR;
      
      SPI->DR=SWIM_TX[2];
      while(!(SPI->SR & (uint8_t)SPI_FLAG_TXE));
      SPI->DR;
      
      SPI->DR=SWIM_TX[3];
      while(!(SPI->SR & (uint8_t)SPI_FLAG_TXE));
      SPI->DR;
      
      SPI->DR=SWIM_TX[4];
      Enable_SWIM_INT(); //enable intrrupt on PC3
      enableInterrupts();//1 capture interrupt  
      while(!(SPI->SR & (uint8_t)SPI_FLAG_TXE));
      SPI->DR;
      
    }
    
    
    else if(len==8)
    {
      SPI->DR=SWIM_TX[0];
      while(!(SPI->SR & (uint8_t)SPI_FLAG_TXE));
      SPI->DR;
      
      SPI->DR=SWIM_TX[1];
      while(!(SPI->SR & (uint8_t)SPI_FLAG_TXE));
      SPI->DR;
      
      SPI->DR=SWIM_TX[2];
      while(!(SPI->SR & (uint8_t)SPI_FLAG_TXE));
      SPI->DR;
      
      SPI->DR=SWIM_TX[3];
      while(!(SPI->SR & (uint8_t)SPI_FLAG_TXE));
      SPI->DR;
      
      SPI->DR=SWIM_TX[4];
      while(!(SPI->SR & (uint8_t)SPI_FLAG_TXE));
      SPI->DR;
      
      SPI->DR=SWIM_TX[5];
      while(!(SPI->SR & (uint8_t)SPI_FLAG_TXE));
      SPI->DR;
      
      SPI->DR=SWIM_TX[6];
      while(!(SPI->SR & (uint8_t)SPI_FLAG_TXE));
      SPI->DR;
      
      SPI->DR=SWIM_TX[7];
      while(!(SPI->SR & (uint8_t)SPI_FLAG_TXE));
      SPI->DR;
      
      SPI->DR=SWIM_TX[8];
      while(!(SPI->SR & (uint8_t)SPI_FLAG_TXE));
      SPI->DR;
      
      SPI->DR=SWIM_TX[9];
      Enable_SWIM_INT(); //enable intrrupt on PC3
      enableInterrupts();//1 capture interrupt
      while(!(SPI->SR & (uint8_t)SPI_FLAG_TXE));
      SPI->DR;
    }
    else
    {
      Disable_SWIM_INT(); //disable intrrupt on PC3
      disableInterrupts();
      return 0;
    }
    
    timeout=255;
    while(INT_Capture_Index<2 && timeout--);
    Disable_SWIM_INT(); //disable intrrupt on PC3
    disableInterrupts();
    
    if(INT_Capture_Index>1)
    {
      INT_Capture_Index=0;
      return 1;
    }
    
  }
  
  while(retry--);
  return 0;
}



void delay_20us()
{
}

void  SWIM_HIGH(void)
{
  SPI->DR=0xFF;
  while(!(SPI->SR & (uint8_t)SPI_FLAG_TXE));
  SPI->DR;
  //GPIO_WriteHigh(MOSI_port,MOSI_pin);
  
}


void  SWIM_LOW(void)
{
  SPI->DR=0x00;
  while(!(SPI->SR & (uint8_t)SPI_FLAG_TXE));
  SPI->DR;
  
  //GPIO_WriteLow(MOSI_port,MOSI_pin);
  
}


void  NRST_HIGH(void)
{
  GPIO_WriteHigh(SWIM_NRST_port,SWIM_NRST_pin);
}

void  NRST_LOW(void)
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
    
    ret = SWIM_Send_Data(SWIM_CMD_WOTF, SWIM_CMD_LEN, 1);
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
    
    for (i = 0; i < cur_len; i++) {
      ret = SWIM_Send_Data(*buf++, 8, 1);
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
  uint32_t ptrTX[1];
  
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
        delay=5;
        while(delay--);
      }
      
      INT_Capture_Index=0;
      Enable_SWIM_INT(); //enable intrrupt on PC3
      enableInterrupts();
      
      
      SPI->DR=ptrTX[0];   //send ack/Nack
      while(!(SPI->SR & (uint8_t)SPI_FLAG_TXE));
      SPI->DR;
      timeout=1000;
      while(INT_Capture_Index<11 && timeout--);//capture data
      Disable_SWIM_INT(); //disable intrrupt on PC3
      disableInterrupts();
      
      
      if (INT_Capture[1] && INT_Capture_Index==11) /* start bit from mcu */
      {
        INT_Capture_Index=0;
        parity = 0;
        temp=0;
        for (i = 0; i < 8; i++) {
          if (INT_Capture[2 + i]) {
            temp |= 1 << (7 - i);
            parity++;
          }
        }
        if (INT_Capture[10] && (parity & 1)) /*parity check */
        {
          retry_count=2;
          ptrTX[0] = SWIM_PULSE_1; /*send ack */
          *buf++=temp;
          nbytes--;
        }
        else if (!INT_Capture[10] && !(parity & 1)) /*parity check */
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
        disableInterrupts();
        return 0;   
      }
      
    }while(nbytes);
    
    
    cur_addr += cur_len;
    size -= cur_len;
  }
  Disable_SWIM_INT();//disable interupt
  disableInterrupts();
  SPI->DR=SWIM_PULSE_1;   //send ack for last byte
  while(!(SPI->SR & (uint8_t)SPI_FLAG_TXE));
  SPI->DR;
  return 1;
}


uint8_t SWIM_Enter(void)
{
  
  uint8_t i,rst=0;
  uint16_t timeout=1000;
  uint8_t retry=2;
  
  while(retry--)
  {
    if(!rst)
    {
      NRST_LOW();
      delay=200;
      while(delay--);
      
      NRST_HIGH();
      delay=200;
      while(delay--);  
      
      NRST_LOW();
      delay=200;
      while(delay--);  
    }
    
    SWIM_LOW();
    delay=200;
    while(delay--);
    
    INT_Capture_Index=0;
    
    for (i = 0; i < 4; i++) {
      
      SWIM_HIGH();
      
      delay=100;
      while(delay--);    
      
      SWIM_LOW();
      
      
      delay=100;
      while(delay--);
    }
    for (i = 0; i < 4; i++) {
      
      SWIM_HIGH();
      
      delay=50;
      while(delay--); 
      
      SWIM_LOW();
      
      delay=50;
      while(delay--);
    }
    Enable_SWIM_INT(); //enable intrrupt on PC3
    SWIM_HIGH();
    enableInterrupts();
    
    while(INT_Capture_Index<1 && timeout--);//capture data
    Disable_SWIM_INT(); //disable intrrupt on PC3
    disableInterrupts();
    
    if(INT_Capture_Index)
    {
      INT_Capture_Index=0;
      delay=20;
      while(delay--);
      uint8_t temp = 0xA0;
      i=SWIM_WOTF(SWIM_CSR, &temp, 1);
      if(i)
      {
        NRST_HIGH();
        return 1;
      }
      
    }
    else
    {
      rst++;
      NRST_HIGH();
      delay=5000;
      while(delay--);
    }
  }
  NRST_HIGH();
  return 0;
}

uint8_t SWIM_Soft_Reset(void)
{
  return SWIM_Send_Data(SWIM_CMD_SRST,SWIM_CMD_LEN,1);
}


uint8_t SWIM_Stall_CPU(void)
{
  uint8_t temp[1]={0x08};
  return SWIM_WOTF(SWIM_DM_CSR2,temp,1);//stall the cpu
}

uint8_t SWIM_Unlock_Flash(void)
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

uint8_t SWIM_Unlock_EEprom(void)
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

uint8_t SWIM_Unlock_OptionByte(void)
{
  uint8_t temp[2];
  if(SWIM_ROTF(SWIM_FLASH_CR2,temp,2))
  {
    temp[0]|=(0x01);  // OPT = 1 and NOPT = 0
    temp[1]&=(~0x01);
    return SWIM_WOTF(SWIM_FLASH_CR2,temp,2);
  }
  return 0;
}
