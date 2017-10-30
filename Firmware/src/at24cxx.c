
#include "at24cxx.h"

uint8_t Address_Width=Address_Width_8;
uint8_t Page_Length=Page_Length_8;

void AT24CXX_Write_Byte(uint16_t Address, uint8_t data) {
  I2C_Start();
  I2C_Write_Address(EEPROM_ADDR + 0);/*Send device address + write bit */
  
  if(Address_Width>Address_Width_8)/* Only if address is 16 bit */
  {
    I2C_Write_Byte((uint8_t)Address>>8u);
  }
  I2C_Write_Byte((uint8_t)Address);/*send register address to write*/
  I2C_Write_Byte(data);
  I2C_Stop();
}

uint8_t AT24CXX_Read_Byte(uint16_t Address) {
  
  uint8_t temp; 
  
  I2C_Start();
  I2C_Write_Address(EEPROM_ADDR + 0);/*Send device address + write bit */
  
  if(Address_Width>Address_Width_8)/* Only if address is 16 bit */
  {
    I2C_Write_Byte((uint8_t)Address>>8);
  }
  I2C_Write_Byte((uint8_t)Address);/*send register address to read*/
  
  I2C_Start();/*Repeated start */
  I2C_Write_Address(EEPROM_ADDR + 1);/*Send device address + read bit */
  temp=I2C_Read_Byte();
  
  I2C_Stop();/*Explicit stop condition for single byte*/
  return temp;
}


uint8_t AT24CXX_Write_Page(uint16_t Address, uint8_t *buf, uint16_t len) {
  
  uint8_t index;
  if(len==0u)
  {
   return 1;
  }
  
  I2C_Start();
  if(I2C_Write_Address(EEPROM_ADDR + 0))/*Send device address + write bit */
  {
  if(Address_Width>Address_Width_8)/* Only if address is 16 bit */
  {
    I2C_Write_Byte((uint8_t)Address>>8);
  }
  I2C_Write_Byte((uint8_t)Address);/*send register address to write*/
  
  for(index=0; index<len; index++)
  {
    I2C_Write_Byte(*buf++);/*write data to address*/
  }
    I2C_Stop();
    delay_ms(5);/*Memory Programming Time approx 5ms*/

    return 1;

  }
  I2C_Stop();
  return 0;
 
}

uint8_t AT24CXX_Read_Buffer(uint16_t Address, uint8_t *buf, uint16_t len) {

  I2C_Start();
  if(I2C_Write_Address(EEPROM_ADDR + 0))/*Send device address + write bit */
  {
  if(Address_Width>Address_Width_8)/* Only if address is 16 bit */
  {
    I2C_Write_Byte((uint8_t)Address>>8);
  }
  I2C_Write_Byte((uint8_t)Address);/*send register address to read*/
  
  I2C_Start();/*Repeated start */
  
  I2C_Write_Address(EEPROM_ADDR + 1);/*Send device address + read bit */
  
  I2C_Read_Buffer(buf,len);
  
  I2C_Stop();
  
  return 1;
  }
  
  I2C_Stop();
  return 0;
}

/*this function can write any number of bytes in arbitary location*/
void AT24CXX_Write_Buffer(uint16_t Address, uint8_t *buf, uint16_t len) {
  uint16_t index;
  uint16_t page_counter,byte_count;
  
  
    byte_count=(Page_Length-(Address%Page_Length));
    if(len<byte_count)
    {
      byte_count=len;
    }

    AT24CXX_Write_Page((Address), buf, byte_count);

       
    page_counter=((len-byte_count)/Page_Length);
    
    for(index=0;index<(page_counter);index++)
    {
     AT24CXX_Write_Page((Address+byte_count+(index*Page_Length)), (buf+byte_count+(index*Page_Length)), Page_Length);
    }
    
     AT24CXX_Write_Page((Address+byte_count+(page_counter*Page_Length)), (buf+byte_count+(page_counter*Page_Length)), (len-byte_count-(page_counter*Page_Length)));
  
}