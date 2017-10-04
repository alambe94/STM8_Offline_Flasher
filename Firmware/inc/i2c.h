#ifndef _I2C_H
#define _I2C_H

#include "stm8s.h"


void I2C_setup();
uint8_t I2C_Start();
uint8_t I2C_Stop();
uint8_t I2C_Write_Byte(uint8_t data);
uint8_t I2C_Write_Address(uint8_t addr);
uint8_t I2C_Read_Byte();
void I2C_Read_Buffer(uint8_t *buf, uint16_t len);







#endif 
