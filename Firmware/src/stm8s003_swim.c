

/**********************Device Specific File************************/
/**********************Device Specific File************************/
/**********************Device Specific File************************/
/**********************Device Specific File************************/

#include "stm8s003_swim.h"
#include "stm8_swim.h"
#include "millis.h"
#include "at24cxx.h"


uint8_t RAM_Buffer[STM8S003_BLOCK_SIZE];
uint8_t Compare_Buffer[STM8S003_BLOCK_SIZE];

uint8_t STM8S003_Default_OPT[10]={0};


uint8_t SWIM_Unlock_OptionByte(uint8_t swim_pin)
{
  uint8_t temp[2];
  if(SWIM_ROTF(swim_pin, SWIM_FLASH_CR2, temp, 2))
  {
    temp[0]|=(uint8_t)(0x80);  // OPT = 1 and NOPT = 0
    temp[1]&=(uint8_t)(0x7F);
    
    if(SWIM_WOTF(swim_pin, SWIM_FLASH_CR2, temp, 2))
    {
      return  SWIM_Unlock_EEPROM(swim_pin);//opt unlock sequence 
    }  
  }
  return 0;
}


uint8_t SWIM_Lock_OptionByte(uint8_t swim_pin)
{
  uint8_t temp[2];
  if(SWIM_ROTF(swim_pin, SWIM_FLASH_CR2,temp,2))
  {
    temp[0]&=(uint8_t)(0x7F); // OPT = 0 and NOPT = 1
    temp[1]|=(uint8_t)(0x80); // enable opt
    
    if(SWIM_WOTF(swim_pin, SWIM_FLASH_CR2, temp, 2))
    {
      return SWIM_Lock_EEPROM(swim_pin);
    }
  }
  return 0;
}


uint8_t SWIM_Unlock_EEPROM(uint8_t swim_pin)
{
  uint8_t temp[1];
  temp[0]=SWIM_FLASH_DUKR_KEY1;
  if(SWIM_WOTF(swim_pin, SWIM_FLASH_DUKR ,temp, 1))
  {
    temp[0]=SWIM_FLASH_DUKR_KEY2;
    return SWIM_WOTF(swim_pin, SWIM_FLASH_DUKR, temp, 1);
  }
  return 0;
}


uint8_t SWIM_Lock_EEPROM(uint8_t swim_pin)
{
  uint8_t temp[1];
  if(SWIM_ROTF(swim_pin, SWIM_FLASH_IAPSR, temp, 1))
  {
    temp[0]&= (uint8_t)0xF7; //
    return SWIM_WOTF(swim_pin, SWIM_FLASH_IAPSR, temp, 1);
  }
  return 0;
}


uint8_t SWIM_Unlock_Flash(uint8_t swim_pin)
{
  uint8_t temp[1];
  temp[0]=SWIM_FLASH_PUKR_KEY1;
  if(SWIM_WOTF(swim_pin, SWIM_FLASH_PUKR, temp, 1))
  {
    temp[0]=SWIM_FLASH_PUKR_KEY2;
    return SWIM_WOTF(swim_pin, SWIM_FLASH_PUKR, temp, 1);
  }
  return 0;
}


uint8_t SWIM_Lock_Flash(uint8_t swim_pin)
{
  uint8_t temp[1];
  if(SWIM_ROTF(swim_pin, SWIM_FLASH_IAPSR,temp,1))
  {
    temp[0] &= 0xFD; //
    return SWIM_WOTF(swim_pin, SWIM_FLASH_IAPSR,temp,1);
  }
  return 0;
}


uint8_t SWIM_Enable_Block_Programming(uint8_t swim_pin)
{
  uint8_t temp[2];
  if(SWIM_ROTF(swim_pin, SWIM_FLASH_CR2, temp, 2))
  {
    temp[0] |= 0x01;  //Flash_CR2  standard block programming
    temp[1] &= 0xFE;  //Flash_NCR2
    return SWIM_WOTF(swim_pin, SWIM_FLASH_CR2, temp, 2); 
  }
  return 0;
}


uint8_t SWIM_Wait_For_EOP(uint8_t swim_pin)
{
  uint8_t flagstatus[1]= {0};
  uint32_t timeout = 100000; 
  
  while ((flagstatus[0] == 0x00) && --timeout)
  {
    if(timeout % 10000 == 0)
    {
    SWIM_ROTF(swim_pin, SWIM_FLASH_IAPSR, flagstatus, 1);
    flagstatus[0] = (uint8_t)(flagstatus[0] & FLASH_IAPSR_EOP);
    }
  }
  
  if (timeout)
  {
    return 1;
  }
  
  return 0;
}


uint8_t SWIM_Unlock_OptionByte_All(void)
{
  uint8_t devices;
  
  devices = Get_SWIM_Devices();  
  
  if(devices & SWIM_PIN_1)
  {
    SWIM_Unlock_OptionByte(SWIM_PIN_1);
  }
  if(devices & SWIM_PIN_2)
  {
    SWIM_Unlock_OptionByte(SWIM_PIN_2);
  }
  if(devices & SWIM_PIN_3)
  {
    SWIM_Unlock_OptionByte(SWIM_PIN_3);
  }
  if(devices & SWIM_PIN_4)
  {
    SWIM_Unlock_OptionByte(SWIM_PIN_4);
  }
  if(devices & SWIM_PIN_5)
  {
    SWIM_Unlock_OptionByte(SWIM_PIN_5);
  }
  if(devices & SWIM_PIN_6)
  {
    SWIM_Unlock_OptionByte(SWIM_PIN_6);
  }
  else
  {
    //zero mcu to copy
    return 0;
  }
  
  return 1;
}

uint8_t SWIM_Lock_OptionByte_All(void)
{
  uint8_t devices;
  
  devices = Get_SWIM_Devices();  
  
  if(devices & SWIM_PIN_1)
  {
    SWIM_Lock_OptionByte(SWIM_PIN_1);
  }
  if(devices & SWIM_PIN_2)
  {
    SWIM_Lock_OptionByte(SWIM_PIN_2);
  }
  if(devices & SWIM_PIN_3)
  {
    SWIM_Lock_OptionByte(SWIM_PIN_3);
  }
  if(devices & SWIM_PIN_4)
  {
    SWIM_Lock_OptionByte(SWIM_PIN_4);
  }
  if(devices & SWIM_PIN_5)
  {
    SWIM_Lock_OptionByte(SWIM_PIN_5);
  }
  if(devices & SWIM_PIN_6)
  {
    SWIM_Lock_OptionByte(SWIM_PIN_6);
  }
  else
  {
    //zero mcu to copy
    return 0;
  }
  
  return 1;
}



uint8_t SWIM_Unlock_EEPROM_All(void)
{      
  uint8_t temp[1];
  temp[0]=SWIM_FLASH_DUKR_KEY1;
  if(SWIM_WOTF_All(SWIM_FLASH_DUKR,temp,1))
  {
    temp[0]=SWIM_FLASH_DUKR_KEY2;
    return SWIM_WOTF_All(SWIM_FLASH_DUKR,temp,1);
  }
  return 0;
}

uint8_t SWIM_Lock_EEPROM_All(void)
{
  uint8_t devices;
  
  devices = Get_SWIM_Devices();  
  
  if(devices & SWIM_PIN_1)
  {
    SWIM_Lock_EEPROM(SWIM_PIN_1);
  }
  if(devices & SWIM_PIN_2)
  {
    SWIM_Lock_EEPROM(SWIM_PIN_2);
  }
  if(devices & SWIM_PIN_3)
  {
    SWIM_Lock_EEPROM(SWIM_PIN_3);
  }
  if(devices & SWIM_PIN_4)
  {
    SWIM_Lock_EEPROM(SWIM_PIN_4);
  }
  if(devices & SWIM_PIN_5)
  {
    SWIM_Lock_EEPROM(SWIM_PIN_5);
  }
  if(devices & SWIM_PIN_6)
  {
    SWIM_Lock_EEPROM(SWIM_PIN_6);
  }
  else
  {
    //zero mcu to copy
    return 0;
  }
  
  return 1;
}



uint8_t SWIM_Unlock_Flash_All(void)
{
  uint8_t temp[1];
  temp[0]=SWIM_FLASH_PUKR_KEY1;
  if(SWIM_WOTF_All(SWIM_FLASH_PUKR,temp,1))
  {
    temp[0]=SWIM_FLASH_PUKR_KEY2;
    return SWIM_WOTF_All(SWIM_FLASH_PUKR,temp,1);
  }
  return 0;
}

uint8_t SWIM_Lock_Flash_All(void)
{
  uint8_t devices;
  
  devices = Get_SWIM_Devices();  
  
  if(devices & SWIM_PIN_1)
  {
    SWIM_Lock_Flash(SWIM_PIN_1);
  }
  if(devices & SWIM_PIN_2)
  {
    SWIM_Lock_Flash(SWIM_PIN_2);
  }
  if(devices & SWIM_PIN_3)
  {
    SWIM_Lock_Flash(SWIM_PIN_3);
  }
  if(devices & SWIM_PIN_4)
  {
    SWIM_Lock_Flash(SWIM_PIN_4);
  }
  if(devices & SWIM_PIN_5)
  {
    SWIM_Lock_Flash(SWIM_PIN_5);
  }
  if(devices & SWIM_PIN_6)
  {
    SWIM_Lock_Flash(SWIM_PIN_6);
  }
  else
  {
    //zero mcu to copy
    return 0;
  }
  
  return 1;
}


uint8_t SWIM_Enable_Block_Programming_All(void)
{
  uint8_t devices;
  
  devices = Get_SWIM_Devices();  
  
  if(devices & SWIM_PIN_1)
  {
    SWIM_Enable_Block_Programming(SWIM_PIN_1);
  }
  if(devices & SWIM_PIN_2)
  {
    SWIM_Enable_Block_Programming(SWIM_PIN_2);
  }
  if(devices & SWIM_PIN_3)
  {
    SWIM_Enable_Block_Programming(SWIM_PIN_3);
  }
  if(devices & SWIM_PIN_4)
  {
    SWIM_Enable_Block_Programming(SWIM_PIN_4);
  }
  if(devices & SWIM_PIN_5)
  {
    SWIM_Enable_Block_Programming(SWIM_PIN_5);
  }
  if(devices & SWIM_PIN_6)
  {
    SWIM_Enable_Block_Programming(SWIM_PIN_6);
  }
  else
  {
    //zero mcu to copy
    return 0;
  }
  
  return 1;
}








uint8_t Copy_STM8S003_To_AT24CXX(void)
{
  uint8_t for_index;
  uint8_t status;
  uint16_t address_offset = 0;
  uint8_t device;
  
  status = SWIM_Enter();
  
  device = Get_SWIM_Devices();  
  
  if(device & SWIM_PIN_1)
  {
    device = SWIM_PIN_1; // mcu found on pin1
  }
  else if(device & SWIM_PIN_2)
  {
    device = SWIM_PIN_2; // mcu found on pin2
  }
  else if(device & SWIM_PIN_3)
  {
    device = SWIM_PIN_3; // mcu found on pin3
  }
  else  if(device & SWIM_PIN_4)
  {
    device = SWIM_PIN_4; // mcu found on pin4
  }
  else  if(device & SWIM_PIN_5)
  {
    device = SWIM_PIN_5; // mcu found on pin5
  }
  else  if(device & SWIM_PIN_6)
  {
    device = SWIM_PIN_6; // mcu found on pin6
  }
  else
  {
    //zero mcu to copy
    return 0;
  }
  
  
  /****************************read flash data from stm8 start********************************/
  for (for_index=0; for_index<STM8S003_FLASH_PAGES; for_index++)
  {
    address_offset = (for_index*STM8S003_BLOCK_SIZE);
    
    if(status)
    {
      status=SWIM_ROTF(device, STM8_FLASH_START_ADDRESS+address_offset, RAM_Buffer, STM8S003_BLOCK_SIZE);
    }
    
    if(status)
    {
      //status=AT24CXX_Write_Page(FLASH_STORE_ADDRESS+address_offset, RAM_Buffer, STM8S003_BLOCK_SIZE); 
      //delay_ms(1);// read from stm8 takes 2.9ms // wait for EOP
    }
    
    if(status)
    {
      //LED_GREEN_TOGGLE(); // signal write cycle success 
    } 
    
  }
  /****************************read flash data from stm8 end********************************/
  
  
  
  /*****************************read EEPROM data from stm8 start************************************/
  for (for_index=0; for_index<STM8S003_EEPROM_PAGES; for_index++)
  {
    address_offset = (for_index*STM8S003_BLOCK_SIZE);
    
    if(status)
    {
      status=SWIM_ROTF(device, STM8_EEPROM_START_ADDRESS+ address_offset,RAM_Buffer, STM8S003_BLOCK_SIZE);
    }
    
    if(status)
    {
      //status=AT24CXX_Write_Page(EEPROM_STORE_ADDRESS+address_offset, RAM_Buffer, STM8S003_BLOCK_SIZE);
      //delay_ms(1);// read from stm8 takes 2.9ms // wait for EOP
    }
    
    if(status)
    {
      //LED_GREEN_TOGGLE();     // signal write cycle success 
    } 
    
  }
  /*****************************read EEPROM data from stm8 end************************************/
  
  
  
  /***************************read Option bytes data from stm8 start*************************/
  if(status)
  {
    status=SWIM_ROTF(device, SWIM_OPT1,RAM_Buffer,10); // stm8s003 has 10 option bytes
  }
  
  if(status)
  {
    delay_ms(3);// wait for last EEPROM write // wait for EOP
    //status=AT24CXX_Write_Page(OPTION_BYTE_STORE_ADDRESS,RAM_Buffer,10);
    delay_ms(3);// // wait for EOP
  }
  
  return status;
}
/***************************read Option bytes data from stm8 end*************************/







/****************************** AT24C256_To_STM8 start*******************************************/
uint8_t AT24CXX_To_STM8S003(void)
{
  uint8_t for_index = 0;
  uint8_t status = 0;
  uint16_t address_offset = 0;
  
  status = SWIM_Enter();
  
  
  /********************************write flash data to stm8 start*************************/
  if(status)
  {
    status = SWIM_Unlock_Flash_All();
  }
  
  for (for_index =0; for_index<STM8S003_FLASH_PAGES; for_index++)
  {
    address_offset = (for_index*STM8S003_BLOCK_SIZE);
    
    if(status)
    {
      //status = AT24CXX_Read_Buffer(FLASH_STORE_ADDRESS+address_offset, RAM_Buffer, STM8S003_BLOCK_SIZE); 
    }  
    
    if(status)
    {
      status = SWIM_Enable_Block_Programming_All(); //standard block programming
    }
    
    if(status)
    {
      status = SWIM_WOTF_All(STM8_FLASH_START_ADDRESS+address_offset, RAM_Buffer,STM8S003_BLOCK_SIZE);
      delay_ms(4); //5ms delay after block write  //read from 24cxx takes 1.5 // wait for EOP
    }
    
    if(status)
    {
      //LED_RED_TOGGLE();
    } 
    
  }
  
  if(status)
  {
    status=SWIM_Lock_Flash_All();
  }
  /********************************write flash data to stm8 end*************************/
  
  /*************************write EEPROM data to stm8 start*********************************/
  if(status)
  {
    status=SWIM_Unlock_EEPROM_All();
  }
  
  for (for_index=0; for_index<STM8S003_EEPROM_PAGES; for_index++)
  {
    address_offset = (for_index*STM8S003_BLOCK_SIZE);
    
    if(status)
    {
      //status=AT24CXX_Read_Buffer(EEPROM_STORE_ADDRESS+address_offset, RAM_Buffer, STM8S003_BLOCK_SIZE);
    }
    
    if(status)
    {
      status=SWIM_Enable_Block_Programming_All(); //standard block programming
    }
    
    if(status)
    {
      status=SWIM_WOTF_All(STM8_EEPROM_START_ADDRESS+address_offset, RAM_Buffer, STM8S003_BLOCK_SIZE);
      delay_ms(4); //5ms delay after block write  //read from 24cxx takes 1.5 // wait for EOP
    }
    
    if(status)
    {
      //LED_RED_TOGGLE();
    } 
    
  }
  
  if(status)
  {
    //status=SWIM_Lock_EEPROM();
  }
  /*************************write EEPROM data to stm8 end*********************************/
  
  
  
  /************************write Option bytes data to stm8 start******************************/
  
  delay_ms(1); //wait for EOP
  
  if(status)
  {
    status=SWIM_Unlock_OptionByte_All();
  }
  
  if(status)
  {
    //status=AT24CXX_Read_Buffer(OPTION_BYTE_STORE_ADDRESS,RAM_Buffer,10);
  }
  
  if(status)
  {
    status=SWIM_WOTF_All(SWIM_OPT1,RAM_Buffer,2);
    delay_ms(10);// wait for EOP
  }
  
  if(status)
  {
    status=SWIM_WOTF_All(SWIM_OPT2,RAM_Buffer+2,2);
    delay_ms(10);// wait for EOP
  }
  
  if(status)
  {
    status=SWIM_WOTF_All(SWIM_OPT3,RAM_Buffer+4,2);
    delay_ms(10);// wait for EOP
  }
  
  if(status)
  {
    status=SWIM_WOTF_All(SWIM_OPT4,RAM_Buffer+6,2);
    delay_ms(10);// wait for EOP
  }
  
  if(status)
  {
    status=SWIM_WOTF_All(SWIM_OPT5,RAM_Buffer+8,2);
    delay_ms(10);// wait for EOP
  }
  
  if(status)
  {
    //status=SWIM_Lock_OptionByte();
  }
  /************************write Option bytes data to stm8 end******************************/
  
  return status;
}
/****************************** AT24C256_To_STM8 end*******************************************/






uint8_t OPT_Read_Write_Test(void)
{
  uint8_t for_index;
  uint8_t status;
  
  status = SWIM_Enter();
  
  if(status)
  {
    status=SWIM_Unlock_OptionByte(SWIM_PIN_6);
  }
    
  if(status)
  {
    status=SWIM_WOTF(SWIM_PIN_6, SWIM_OPT1, STM8S003_Default_OPT, 2);
    delay_ms(10);// wait for EOP
  }
  
  if(status)
  {
    status=SWIM_WOTF(SWIM_PIN_6, SWIM_OPT2, STM8S003_Default_OPT+2, 2);
    delay_ms(10);// wait for EOP
  }
  
  if(status)
  {
    status=SWIM_WOTF(SWIM_PIN_6, SWIM_OPT3, STM8S003_Default_OPT+4, 2);
    delay_ms(10);// wait for EOP
  }
  
  if(status)
  {
    status=SWIM_WOTF(SWIM_PIN_6, SWIM_OPT4, STM8S003_Default_OPT+6, 2);
    delay_ms(10);// wait for EOP
  }
  
  if(status)
  {
    status=SWIM_WOTF(SWIM_PIN_6, SWIM_OPT5, STM8S003_Default_OPT+8, 2);
    delay_ms(10);// wait for EOP
  }
  
  if(status)
  {
    status = SWIM_Lock_OptionByte(SWIM_PIN_6);
  }
  
  if(status)
  {
    status = SWIM_ROTF(SWIM_PIN_6, SWIM_OPT1, Compare_Buffer, 10); // stm8s003 has 10 option bytes
  }
  
  for(for_index=0; for_index<10; for_index++)
  {
    if(STM8S003_Default_OPT[for_index] != Compare_Buffer[for_index])
    {
      status = 0;
      break;
    }
  }
  
  return status;
}



uint8_t Flash_Read_Write_Test(void)
{
  uint8_t for_index;
  uint8_t status;
  uint16_t address = STM8_FLASH_START_ADDRESS;
  
  status = SWIM_Enter();
  
  for(for_index=0; for_index<STM8S003_BLOCK_SIZE; for_index++ )
  {
    RAM_Buffer[for_index] = for_index;
  }
  
  if(status)
  {
    status = SWIM_Unlock_Flash(SWIM_PIN_6);
  }
  
  for (for_index =0; for_index<STM8S003_FLASH_PAGES; for_index++)
  {
    
    if(status)
    {
      status = SWIM_Enable_Block_Programming(SWIM_PIN_6); //standard block programming
    }
    
    if(status)
    {
      status = SWIM_WOTF(SWIM_PIN_6, address, RAM_Buffer, STM8S003_BLOCK_SIZE);
      address += STM8S003_BLOCK_SIZE;
      delay_ms(5); //5ms delay after block write  //read from 24cxx takes 1.5 // wait for EOP
      SWIM_Wait_For_EOP(SWIM_PIN_6);
    }
    else
    {
      break;
    }
      
  }
  
  
  address = STM8_FLASH_START_ADDRESS;
  
  for (for_index =0; for_index<STM8S003_FLASH_PAGES; for_index++)
  {
    
    if(status)
    {
      status = SWIM_ROTF(SWIM_PIN_6, address, Compare_Buffer, STM8S003_BLOCK_SIZE);
      address += STM8S003_BLOCK_SIZE;
    }
    
    if(status)
    {
      for(for_index=0; for_index<STM8S003_BLOCK_SIZE; for_index++ )
      {
        if(RAM_Buffer[for_index] != Compare_Buffer[for_index])
        {
         status = 0;
         break;
        }
      }
    }
  }
  if(status)
  {
    status = SWIM_Lock_Flash(SWIM_PIN_6);
  }
  return status;
}



uint8_t EEPROM_Read_Write_Test(void)
{
  uint8_t for_index;
  uint8_t status;
  uint16_t address = STM8_EEPROM_START_ADDRESS;
  
  status = SWIM_Enter();
  
  for(for_index=0; for_index<STM8S003_BLOCK_SIZE; for_index++ )
  {
    RAM_Buffer[for_index] = for_index;
  }
  
  if(status)
  {
    status = SWIM_Unlock_EEPROM(SWIM_PIN_6);
  }
  
  for (for_index =0; for_index<STM8S003_EEPROM_PAGES; for_index++)
  {
    
    if(status)
    {
      status = SWIM_Enable_Block_Programming(SWIM_PIN_6); //standard block programming
    }
    
    if(status)
    {
      status = SWIM_WOTF(SWIM_PIN_6, address, RAM_Buffer, STM8S003_BLOCK_SIZE);
      address += STM8S003_BLOCK_SIZE;
      delay_ms(5); //5ms delay after block write  //read from 24cxx takes 1.5 // wait for EOP
      SWIM_Wait_For_EOP(SWIM_PIN_6);
    }
    else
    {
      break;
    }
      
  }
  
  
  address = STM8_EEPROM_START_ADDRESS;
  
  for (for_index =0; for_index<STM8S003_FLASH_PAGES; for_index++)
  {
    
    if(status)
    {
      status = SWIM_ROTF(SWIM_PIN_6, address, Compare_Buffer, STM8S003_BLOCK_SIZE);
      address += STM8S003_BLOCK_SIZE;
    }
    
    if(status)
    {
      for(for_index=0; for_index<STM8S003_BLOCK_SIZE; for_index++ )
      {
        if(RAM_Buffer[for_index] != Compare_Buffer[for_index])
        {
         status = 0;
         break;
        }
      }
    }
  }
  
  SWIM_Lock_EEPROM(SWIM_PIN_6);
  return status;
}


uint8_t AT24CXX_Read_Write_Test(void)
{
  uint8_t for_index_i;
  uint8_t for_index_j;
  uint8_t status;
  uint16_t address = 0;
  
  for(for_index_i=0; for_index_i<STM8S003_BLOCK_SIZE; for_index_i++ )
  {
    RAM_Buffer[for_index_i] = for_index_i;
  }
  
  for(for_index_i=0; for_index_i<AT24CXX_PAGES; for_index_i++ )
  {
    status = AT24CXX_Write_Page(address, RAM_Buffer, STM8S003_BLOCK_SIZE);
    address += STM8S003_BLOCK_SIZE;
  }
  
  for(address = for_index_i=0; for_index_i<AT24CXX_PAGES; for_index_i++ )
  {
    if(status)
    {
      status = AT24CXX_Read_Buffer(address, Compare_Buffer, STM8S003_BLOCK_SIZE);
      address += STM8S003_BLOCK_SIZE;
    }
    
    for(for_index_j=0; for_index_j<STM8S003_BLOCK_SIZE; for_index_j++ )
    {
      if(RAM_Buffer[for_index_j] != Compare_Buffer[for_index_j])
      {
        status = 0;
        break;
      }
    }
    
    if(!status)
    {
      break;
    }
  }
  
  return status;
}


