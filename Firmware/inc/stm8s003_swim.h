#ifndef _STM8S003_SWIM_H
#define _STM8S003_SWIM_H

/**********************Device Specific File************************/
/**********************Device Specific File************************/
/**********************Device Specific File************************/
/**********************Device Specific File************************/

#include "stm8s.h"


#define STM8_FLASH_START_ADDRESS     0x008000 //to 0x009FFF  (8k)
#define STM8_EEPROM_START_ADDRESS    0x004000 //to 0x00407F  (128 bytes) (total 640 bytes unofficial)
#define STM8_RAM_START_ADDRESS       0x000000 //to 0x0003FF  (1k)

#define SWIM_OPT0                    0x4800 //Read-out protection (ROP)

#define SWIM_OPT1                    0x4801 //User boot code(UBC)
#define SWIM_NOPT1                   0x4802 

#define SWIM_OPT2                    0x4803 //Alternate function remapping(AFR)
#define SWIM_NOPT2                   0x4804 

#define SWIM_OPT3                    0x4805 //Misc. option
#define SWIM_NOPT3                   0x4806 

#define SWIM_OPT4                    0x4807 //Clock option
#define SWIM_NOPT4                   0x4808 

#define SWIM_OPT5                    0x4809 //HSE clock startup
#define SWIM_NOPT5                   0x480A 


#define FLASH_STORE_ADDRESS          0x0000 //in 24CXX   8K flash STM8S003  0x00 to 0x2000
#define EEPROM_STORE_ADDRESS         0x3000 //in 24CXX   128B EEPROM STM8S003 0x3000 to 0x3080
#define OPTION_BYTE_STORE_ADDRESS    0x4000 //in 24CXX   10B  option byte register STM8S003

#define STM8S003_BLOCK_SIZE          64u  // also look for AT24Cxx Block Size
#define STM8S003_FLASH_PAGES         128 //stm8s003 has 128 pages of 64 bytes
#define STM8S003_EEPROM_PAGES        2   //stm8s003 has 2 pages of 64 bytes (extra 2 page unofficial)



#define SWIM_FLASH                   0x00505a
#define SWIM_FLASH_CR1               (SWIM_FLASH + 0x00)
#define SWIM_FLASH_CR2               (SWIM_FLASH + 0x01)
#define SWIM_FLASH_NCR2              (SWIM_FLASH + 0x02)
#define SWIM_FLASH_FPR               (SWIM_FLASH + 0x03)
#define SWIM_FLASH_NFPR              (SWIM_FLASH + 0x04)
#define SWIM_FLASH_IAPSR             (SWIM_FLASH + 0x05)
#define SWIM_FLASH_PUKR              (SWIM_FLASH + 0x08)
#define SWIM_FLASH_DUKR              (SWIM_FLASH + 0x0a)


uint8_t SWIM_Stall_CPU(uint8_t swim_pin);

uint8_t SWIM_Unlock_OptionByte(uint8_t swim_pin);
uint8_t SWIM_Lock_OptionByte(uint8_t swim_pin);

uint8_t SWIM_Unlock_EEPROM(uint8_t swim_pin);
uint8_t SWIM_Lock_EEPROM(uint8_t swim_pin);

uint8_t SWIM_Unlock_Flash(uint8_t swim_pin);
uint8_t SWIM_Lock_Flash(uint8_t swim_pin);

uint8_t SWIM_Enable_Block_Programming(uint8_t swim_pin);
uint8_t SWIM_Wait_For_EOP(uint8_t swim_pin);




uint8_t SWIM_Unlock_OptionByte_All(void);
uint8_t SWIM_Lock_OptionByte_All(void);

uint8_t SWIM_Unlock_EEPROM_All(void);
uint8_t SWIM_Lock_EEPROM_All(void);

uint8_t SWIM_Unlock_Flash_All(void);
uint8_t SWIM_Lock_Flash_All(void);

uint8_t SWIM_Enable_Block_Programming_All(void);


uint8_t Copy_STM8S003_To_AT24CXX(void);
uint8_t AT24CXX_To_STM8S003(void);


uint8_t OPT_Read_Write_Test(void);
uint8_t Flash_Read_Write_Test(void);
uint8_t EEPROM_Read_Write_Test(void);
uint8_t AT24CXX_Read_Write_Test(void);


#endif 