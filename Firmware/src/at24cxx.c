
#include "at24cxx.h"

uint8_t Address_Width=Address_Width_8;
uint8_t Page_Length=Page_Length_8;

void AT24CXX_Write_Byte(uint16_t Address, uint8_t data) {
  I2C_Start();
  I2C_Write_Address(EEPROM_ADDR + 0);
  
  if(Address_Width>Address_Width_8)
  {
    I2C_Write_Byte(Address>>8);
  }
  I2C_Write_Byte(Address);
  I2C_Write_Byte(data);
  I2C_Stop();
}

uint8_t AT24CXX_Read_Byte(uint16_t Address) {
  
  uint8_t temp; 
  
  I2C_Start();
  I2C_Write_Address(EEPROM_ADDR + 0);
  
  if(Address_Width>Address_Width_8)
  {
    I2C_Write_Byte(Address>>8);
  }
  I2C_Write_Byte(Address);
  
  I2C_Start();
  I2C_Write_Address(EEPROM_ADDR + 1);
  temp=I2C_Read_Byte();
  
  I2C_Stop();
  return temp;
}


uint8_t AT24CXX_Write_Page(uint16_t Address, uint8_t *buf, uint16_t len) {
  uint16_t i;
  
  uint8_t index;
  if(!len)
  {
   return 1;
  }
  
  I2C_Start();
  if(I2C_Write_Address(EEPROM_ADDR + 0))
  {
  if(Address_Width>Address_Width_8)
  {
    I2C_Write_Byte(Address>>8);
  }
  I2C_Write_Byte(Address);
  
  for(index=0; index<len; index++)
  {
    I2C_Write_Byte(*buf++);
  }
    I2C_Stop();
    i=6000;
    while(i--);
    return 1;

  }
  I2C_Stop();
  return 0;
 
}

uint8_t AT24CXX_Read_Buffer(uint16_t Address, uint8_t *buf, uint16_t len) {

  I2C_Start();
  if(I2C_Write_Address(EEPROM_ADDR + 0))
  {
  if(Address_Width>Address_Width_8)
  {
    I2C_Write_Byte(Address>>8);
  }
  I2C_Write_Byte(Address);
  
  I2C_Start();
  
  I2C_Write_Address(EEPROM_ADDR + 1);
  
  I2C_Read_Buffer(buf,len);
  
  I2C_Stop();
  
  return 1;
  }
  
  I2C_Stop();
  return 0;
}

void AT24CXX_Write_Buffer(uint16_t Address, uint8_t *buf, uint16_t len) {
  uint8_t index;
  uint8_t page_counter,byte_count;
  
  if(len<Page_Length)
  {
    for(index=0;index<len;index++)
    {
   AT24CXX_Write_Page((Address+index), buf+index, 1);
    }
  }
  else
  {
    byte_count=Page_Length-(Address%Page_Length);

    AT24CXX_Write_Page((Address), buf, byte_count);

       
    page_counter=((len-byte_count)/Page_Length);
    
    for(index=0;index<(page_counter);index++)
    {
     AT24CXX_Write_Page((Address+byte_count+(index*Page_Length)), (buf+byte_count+(index*Page_Length)), Page_Length);
    }
    
     AT24CXX_Write_Page((Address+byte_count+(page_counter*Page_Length)), (buf+byte_count+(page_counter*Page_Length)), (len-byte_count-(page_counter*Page_Length)));
  }
}