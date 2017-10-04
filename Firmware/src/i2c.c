
#include "i2c.h"

void I2C_setup()
{
  GPIO_DeInit(GPIOB);
  GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_OUT_OD_HIZ_FAST);
  GPIO_Init(GPIOB, GPIO_PIN_5, GPIO_MODE_OUT_OD_HIZ_FAST);
  
  I2C_DeInit();
  I2C_Init(100000, 
           0xFE, 
           I2C_DUTYCYCLE_2, 
           I2C_ACK_NONE, 
           I2C_ADDMODE_7BIT, 
           16);
  I2C_Cmd(ENABLE);
}

uint8_t I2C_Start() {
  uint8_t timeout=255;
  
  I2C->CR2 |= (I2C_CR2_START);
  while (!(I2C->SR1 & (I2C_SR1_SB)) && --timeout);
    if(timeout)
  {
    return 1;
  }
    return 0;
}

uint8_t I2C_Stop() {
  uint8_t timeout=255;

  I2C->CR2 |= (I2C_CR2_STOP);
  while (!(I2C->SR3 & (I2C_SR3_MSL)) && --timeout);
   if(timeout)
  {
    return 1;
  }
    return 0;
}

uint8_t I2C_Write_Byte(uint8_t data) {
  uint8_t timeout=255;
  I2C->DR = data;
  while (!(I2C->SR1 & (I2C_SR1_TXE)) && --timeout);
  if(timeout)
  {
    return 1;
  }
    I2C_Stop();
    return 0;
}

uint8_t I2C_Write_Address(uint8_t addr) {
  uint8_t timeout=255;
  
  I2C->DR = addr;
  while (!(I2C->SR1 & (I2C_SR1_ADDR)) && --timeout);
  (void) I2C->SR3; // clear EV6
  I2C->CR2 |= (I2C_CR2_ACK);
    if(timeout)
  {
    return 1;
  }
    I2C_Stop();
    return 0;
}

uint8_t I2C_Read_Byte() {
  I2C->CR2 &= ~(I2C_CR2_ACK);
  I2C_Stop();
  while (!(I2C->SR1 & (I2C_SR1_RXNE)));
  return I2C->DR;
}

void I2C_Read_Buffer(uint8_t *buf, uint16_t len) {
  while (len-- > 1) {
    I2C->CR2 |= (I2C_CR2_ACK);
    while (!(I2C->SR1 & (I2C_SR1_RXNE)));
    *(buf++) = I2C->DR;
  }
  *buf = I2C_Read_Byte();
}