#include "at24cxx.h"
#include "soft_i2c.h"

void AT24CXX_Init(void)
{
  Soft_I2C_Init();
}

uint8_t AT24CXX_Write_Byte(uint16_t register_address, uint8_t data)
{
  if (Soft_I2C_Start() == SOFT_I2C_ERR) /*generate star condition*/
  {
    Soft_I2C_Stop();
    return AT24CXX_ERR;
  }

  if (Soft_I2C_Send_Byte(AT24CXX_EEPROM_ADDR + 0) == SOFT_I2C_ERR) /*Send device address + write bit */
  {
    return AT24CXX_ERR;
  }

  if (AT24CXX_ADDRESS_WIDTH > 8) /* Only if address is 16 bit */
  {
    if (Soft_I2C_Send_Byte((uint8_t)(register_address >> 8)) == SOFT_I2C_ERR)
    {
      return AT24CXX_ERR;
    }
  }

  if (Soft_I2C_Send_Byte((uint8_t)register_address) == SOFT_I2C_ERR) /*send register address to write*/
  {
    return AT24CXX_ERR;
  }

  if (Soft_I2C_Send_Byte(data) == SOFT_I2C_ERR)
  {
    return AT24CXX_ERR;
  }

  Soft_I2C_Stop();

  //delay_ms(AT24CXX_WRITE_DELAY);/*Memory Programming Time approx 5ms*//*3ms for BL24CXX */

  return AT24CXX_OK;
}

uint8_t AT24CXX_Read_Byte(uint16_t register_address, uint8_t *data)
{

  if (Soft_I2C_Start() == SOFT_I2C_ERR) /*generate star condition*/
  {
    Soft_I2C_Stop();
    return AT24CXX_ERR;
  }

  if (Soft_I2C_Send_Byte((uint8_t)(AT24CXX_EEPROM_ADDR + 0)) == SOFT_I2C_ERR) /*Send device address + write bit */
  {
    return AT24CXX_ERR;
  }

  if (AT24CXX_ADDRESS_WIDTH > 8) /* Only if address is 16 bit */
  {
    if (Soft_I2C_Send_Byte((uint8_t)(register_address >> 8)) == SOFT_I2C_ERR)
    {
      return AT24CXX_ERR;
    }
  }
  if (Soft_I2C_Send_Byte((uint8_t)register_address) == SOFT_I2C_ERR) /*send register address to write*/
  {
    return AT24CXX_ERR;
  }

  if (Soft_I2C_Start() == SOFT_I2C_ERR) //repeated start
  {
    Soft_I2C_Stop();
    return AT24CXX_ERR;
  }

  if (Soft_I2C_Send_Byte(AT24CXX_EEPROM_ADDR + 1) == SOFT_I2C_ERR) /*Send device address + read bit */
  {
    return AT24CXX_ERR;
  }

  *data = Soft_I2C_Receive_Byte();

  Soft_I2C_Stop(); /*Explicit stop condition for single byte*/

  return AT24CXX_OK;
}

uint8_t AT24CXX_Write_Page(uint16_t start_address, const uint8_t *buf, uint16_t len)
{

  if (len == 0)
  {
    return AT24CXX_OK;
  }

  if (Soft_I2C_Start() == SOFT_I2C_ERR) /*generate star condition*/
  {
    Soft_I2C_Stop();
    return AT24CXX_ERR;
  }

  if (Soft_I2C_Send_Byte(AT24CXX_EEPROM_ADDR + 0) == SOFT_I2C_ERR) /*Send device address + write bit */
  {
    return AT24CXX_ERR;
  }

  if (AT24CXX_ADDRESS_WIDTH > 8) /* Only if address is 16 bit */
  {
    if (Soft_I2C_Send_Byte((uint8_t)(start_address >> 8)) == SOFT_I2C_ERR)
    {
      return AT24CXX_ERR;
    }
  }
  if (Soft_I2C_Send_Byte((uint8_t)start_address) == SOFT_I2C_ERR) /*send register address to write*/
  {
    return AT24CXX_ERR;
  }

  while (len--)
  {
    if (Soft_I2C_Send_Byte(*buf++) == SOFT_I2C_ERR) /*write data to address*/
    {
      return AT24CXX_ERR;
    }
  }

  Soft_I2C_Stop();

  delay_ms(AT24CXX_WRITE_DELAY); /*Memory Programming Time approx 5ms*/ /*3ms for BL24CXX */

  return AT24CXX_OK;
}

uint8_t AT24CXX_Read_Buffer(uint16_t start_address, uint8_t *buf, uint16_t len)
{

  if (Soft_I2C_Start() == SOFT_I2C_ERR) /*generate star condition*/
  {
    Soft_I2C_Stop();
    return AT24CXX_ERR;
  }

  if (Soft_I2C_Send_Byte(AT24CXX_EEPROM_ADDR + 0) == SOFT_I2C_ERR) /*Send device address + write bit */
  {
    return AT24CXX_ERR;
  }

  if (AT24CXX_ADDRESS_WIDTH > 8) /* Only if address is 16 bit */
  {
    if (Soft_I2C_Send_Byte((uint8_t)(start_address >> 8)) == SOFT_I2C_ERR)
    {
      return AT24CXX_ERR;
    }
  }

  if (Soft_I2C_Send_Byte((uint8_t)start_address) == SOFT_I2C_ERR) /*send register address to write*/
  {
    return AT24CXX_ERR;
  }

  if (Soft_I2C_Start() == SOFT_I2C_ERR) //repeated start
  {
    Soft_I2C_Stop();
    return AT24CXX_ERR;
  }

  if (Soft_I2C_Send_Byte(AT24CXX_EEPROM_ADDR + 1) == SOFT_I2C_ERR) //read bit
  {
    return AT24CXX_ERR;
  }

  while (len--)
  {
    *buf++ = Soft_I2C_Receive_Byte();

    if (len == 0)
    {
      Soft_I2C_NACK();
    }
    else
    {
      Soft_I2C_ACK();
    }
  }

  Soft_I2C_Stop();

  return AT24CXX_OK;
}

/*this function can write any number of bytes from arbitrary location*/
uint8_t AT24CXX_Write_Buffer(uint16_t start_address, const uint8_t *buf, uint16_t len)
{

  uint16_t page_counter;
  uint16_t byte_counter;

  byte_counter = (AT24CXX_PAGE_LENGTH - (start_address % AT24CXX_PAGE_LENGTH));
  if (len < byte_counter)
  {
    byte_counter = len;
  }

  if (AT24CXX_Write_Page(start_address, buf, byte_counter) == AT24CXX_ERR)
  {
    return AT24CXX_ERR;
  }

  len -= byte_counter;
  page_counter = (len / AT24CXX_PAGE_LENGTH);
  start_address += byte_counter;
  buf += byte_counter;

  for (uint16_t i = 0; i < page_counter; i++)
  {
    if (AT24CXX_Write_Page(start_address,
                           buf,
                           AT24CXX_PAGE_LENGTH) == AT24CXX_ERR)
    {
      return AT24CXX_ERR;
    }

    start_address += AT24CXX_PAGE_LENGTH;
    buf += AT24CXX_PAGE_LENGTH;
    len -= AT24CXX_PAGE_LENGTH;
  }

  if (AT24CXX_Write_Page(start_address,
                         buf,
                         len) == AT24CXX_ERR)
  {
    return AT24CXX_ERR;
  }

  return AT24CXX_OK;
}
