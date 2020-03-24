#include "tests.h"
#include "stm8s003_swim.h"
#include "stm8_swim.h"
#include "millis.h"
#include "at24cxx.h"

extern uint8_t RAM_Buffer[STM8S003_BLOCK_SIZE];
extern uint8_t Compare_Buffer[STM8S003_BLOCK_SIZE];
extern uint8_t STM8S003_Default_OPT[10];

uint8_t OPT_Read_Write_Test(void)
{
  uint8_t for_index;
  uint8_t status;

  status = SWIM_Enter();

  if (status)
  {
    status = SWIM_Unlock_OptionByte();
  }

  if (status)
  {
    status = SWIM_WOTF(SWIM_OPT1, STM8S003_Default_OPT, 2);
    status = SWIM_Wait_For_EOP();
  }

  if (status)
  {
    status = SWIM_WOTF(SWIM_OPT2, STM8S003_Default_OPT + 2, 2);
    status = SWIM_Wait_For_EOP();
  }

  if (status)
  {
    status = SWIM_WOTF(SWIM_OPT3, STM8S003_Default_OPT + 4, 2);
    status = SWIM_Wait_For_EOP();
  }

  if (status)
  {
    status = SWIM_WOTF(SWIM_OPT4, STM8S003_Default_OPT + 6, 2);
    status = SWIM_Wait_For_EOP();
  }

  if (status)
  {
    status = SWIM_WOTF(SWIM_OPT5, STM8S003_Default_OPT + 8, 2);
    status = SWIM_Wait_For_EOP();
  }

  if (status)
  {
    status = SWIM_Lock_OptionByte();
  }

  if (status)
  {
    status = SWIM_ROTF(SWIM_OPT1, Compare_Buffer, 10); // stm8s003 has 10 option bytes
  }

  for (for_index = 0; for_index < 10; for_index++)
  {
    if (STM8S003_Default_OPT[for_index] != Compare_Buffer[for_index])
    {
      status = 0;
      break;
    }
  }

  return status;
}

uint8_t Flash_Read_Write_Test(void)
{
  uint8_t for_index_i; // outer for loop, stvd cosmic compatible
  uint8_t for_index_j; // inner for loop, stvd cosmic compatible;
  uint8_t status;
  uint16_t address = STM8_FLASH_START_ADDRESS;

  status = SWIM_Enter();

  for (for_index_i = 0; for_index_i < STM8S003_BLOCK_SIZE; for_index_i++)
  {
    RAM_Buffer[for_index_i] = for_index_i;
  }

  if (status)
  {
    status = SWIM_Unlock_Flash();
  }

  for (for_index_i = 0; for_index_i < STM8S003_FLASH_PAGES; for_index_i++)
  {

    if (status)
    {
      status = SWIM_Enable_Block_Programming(); //standard block programming
    }

    if (status)
    {
      status = SWIM_WOTF(address, RAM_Buffer, STM8S003_BLOCK_SIZE);
      address += STM8S003_BLOCK_SIZE;
      status = SWIM_Wait_For_EOP();
    }
    else
    {
      break;
    }
  }

  address = STM8_FLASH_START_ADDRESS;

  for (for_index_i = 0; for_index_i < STM8S003_FLASH_PAGES; for_index_i++)
  {

    if (status)
    {
      status = SWIM_ROTF(address, Compare_Buffer, STM8S003_BLOCK_SIZE);
      address += STM8S003_BLOCK_SIZE;
    }

    if (status)
    {
      for (for_index_j = 0; for_index_j < STM8S003_BLOCK_SIZE; for_index_j++)
      {
        if (RAM_Buffer[for_index_j] != Compare_Buffer[for_index_j])
        {
          status = 0;
          break;
        }
      }
    }
  }
  if (status)
  {
    status = SWIM_Lock_Flash();
  }
  return status;
}

uint8_t EEPROM_Read_Write_Test(void)
{
  uint8_t for_index_i; // outer for loop, stvd cosmic compatible
  uint8_t for_index_j; // inner for loop, stvd cosmic compatible;
  uint8_t status;
  uint16_t address = STM8_EEPROM_START_ADDRESS;

  status = SWIM_Enter();

  for (for_index_i = 0; for_index_i < STM8S003_BLOCK_SIZE; for_index_i++)
  {
    RAM_Buffer[for_index_i] = for_index_i;
  }

  if (status)
  {
    status = SWIM_Unlock_EEPROM();
  }

  for (for_index_i = 0; for_index_i < STM8S003_EEPROM_PAGES; for_index_i++)
  {

    if (status)
    {
      status = SWIM_Enable_Block_Programming(); //standard block programming
    }

    if (status)
    {
      status = SWIM_WOTF(address, RAM_Buffer, STM8S003_BLOCK_SIZE);
      address += STM8S003_BLOCK_SIZE;
      SWIM_Wait_For_EOP();
    }
    else
    {
      break;
    }
  }

  address = STM8_EEPROM_START_ADDRESS;

  for (for_index_i = 0; for_index_i < STM8S003_EEPROM_PAGES; for_index_i++)
  {

    if (status)
    {
      status = SWIM_ROTF(address, Compare_Buffer, STM8S003_BLOCK_SIZE);
      address += STM8S003_BLOCK_SIZE;
    }

    if (status)
    {
      for (for_index_j = 0; for_index_j < STM8S003_BLOCK_SIZE; for_index_j++)
      {
        if (RAM_Buffer[for_index_j] != Compare_Buffer[for_index_j])
        {
          status = 0;
          break;
        }
      }
    }
  }

  if (status)
  {
    status = SWIM_Lock_EEPROM();
  }
  return status;
}

uint8_t AT24CXX_Read_Write_Test(void)
{
  uint8_t for_index_i; // outer for loop, stvd cosmic compatible
  uint8_t for_index_j; // inner for loop, stvd cosmic compatible
  uint8_t status;
  uint16_t address = 0;

  for (for_index_i = 0; for_index_i < STM8S003_BLOCK_SIZE; for_index_i++)
  {
    RAM_Buffer[for_index_i] = for_index_i;
  }

  for (for_index_i = 0; for_index_i < AT24CXX_PAGES; for_index_i++)
  {
    status = AT24CXX_Write_Page(address, RAM_Buffer, STM8S003_BLOCK_SIZE);
    address += STM8S003_BLOCK_SIZE;
  }

  for (address = for_index_i = 0; for_index_i < AT24CXX_PAGES; for_index_i++)
  {

    for (for_index_j = 0; for_index_j < STM8S003_BLOCK_SIZE; for_index_j++)
    {
      Compare_Buffer[for_index_j] = 0x00;
    }

    if (status)
    {
      status = AT24CXX_Read_Buffer(address, Compare_Buffer, STM8S003_BLOCK_SIZE);
      address += STM8S003_BLOCK_SIZE;
    }

    for (for_index_j = 0; for_index_j < STM8S003_BLOCK_SIZE; for_index_j++)
    {
      if (RAM_Buffer[for_index_j] != Compare_Buffer[for_index_j])
      {
        status = 0;
        break;
      }
    }

    if (!status)
    {
      break;
    }
  }

  return status;
}
