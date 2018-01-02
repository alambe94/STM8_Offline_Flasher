#ifndef _AT24CXX_H
#define _AT24CXX_H

#include "stm8s.h"
#include "i2c.h"
#include "stm8s.h"
#include "millis.h"
#include "stdlib.h"


#define EEPROM_ADDR 0xA0

#define Address_Width_16 16u 
#define Address_Width_8  8u

#define Page_Length_8   8u
#define Page_Length_16  16u
#define Page_Length_64  64u

#define Address_Width Address_Width_16
#define Page_Length   Page_Length_64

void AT24CXX_Write_Byte(uint16_t Address, uint8_t data);
uint8_t AT24CXX_Read_Byte(uint16_t Address);
uint8_t AT24CXX_Write_Page(uint16_t Address, uint8_t *buf, uint16_t len);
uint8_t AT24CXX_Read_Buffer(uint16_t Address, uint8_t *buf, uint16_t len);
void AT24CXX_Write_Buffer(uint16_t Address, uint8_t *buf, uint16_t len);
















#endif 
