#ifndef _AT24CXX_H
#define _AT24CXX_H

#include "stm8s.h"
#include "i2c.h"


#define EEPROM_ADDR 0xA6

#define Address_Width_16 16 
#define Address_Width_8  8

#define Page_Length_8   8
#define Page_Length_16  16
#define Page_Length_64  64



void AT24CXX_Write_Byte(uint16_t Address, uint8_t data);
uint8_t AT24CXX_Read_Byte(uint16_t Address);
uint8_t AT24CXX_Write_Page(uint16_t Address, uint8_t *buf, uint16_t len);
uint8_t AT24CXX_Read_Buffer(uint16_t Address, uint8_t *buf, uint16_t len);
void AT24CXX_Write_Buffer(uint16_t Address, uint8_t *buf, uint16_t len);
















#endif 
