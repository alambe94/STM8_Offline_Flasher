#ifndef __STM8_SWIM_H
#define __STM8_SWIM_H

/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"
#include "millis.h"
#include "stdlib.h"



/* Private defines -----------------------------------------------------------*/

#define SWIM_IN_PIN            GPIO_PIN_6
#define SWIM_IN_PIN_PORT       GPIOC

#define	ENABLE_SWIM_INT()     (SWIM_IN_PIN_PORT->CR2 |= SWIM_IN_PIN)    
#define	DISABLE_SWIM_INT()    (SWIM_IN_PIN_PORT->CR2 &= ~(SWIM_IN_PIN)) 


#define NRST_PIN               GPIO_PIN_4
#define NRST_PORT              GPIOC

#define NRST_PIN_HIGH()        NRST_PORT->ODR |=  NRST_PIN     
#define NRST_PIN_LOW()         NRST_PORT->ODR &=  ~NRST_PIN   

#define SWIM_PIN               GPIO_PIN_5   
#define SWIM_PORT              GPIOC

#define SWIM_PIN_HIGH()        SWIM_PORT->ODR |=  SWIM_PIN     
#define SWIM_PIN_LOW()         SWIM_PORT->ODR &= ~SWIM_PIN   
#define SWIM_PIN_READ()        SWIM_PORT->IDR &   SWIM_PIN

#define SWIM_DELAY_250_NS()    nop(), nop(), nop()
#define SWIM_DELAY_500_NS()    SWIM_DELAY_250_NS(); SWIM_DELAY_250_NS(); 
#define SWIM_DELAY_750_NS()    SWIM_DELAY_500_NS(); SWIM_DELAY_250_NS();
#define SWIM_DELAY_1000_NS()   SWIM_DELAY_500_NS(); SWIM_DELAY_500_NS();
#define SWIM_DELAY_1250_NS()   SWIM_DELAY_1000_NS(); SWIM_DELAY_250_NS()





#define SWIM_CMD_LEN                    3
#define SWIM_CMD_SRST                   0x00
#define SWIM_CMD_ROTF                   0x01
#define SWIM_CMD_WOTF                   0x02
#define SWIM_MAX_RESEND_CNT             20

#define SWIM_CSR               0x7F80
#define SWIM_DM_CSR2	       0x7F99
#define SWIM_FLASH             0x00505a
#define SWIM_PROGRAM           0x008000
#define SWIM_FLASH_CR1         (SWIM_FLASH + 0x00)
#define SWIM_FLASH_CR2         (SWIM_FLASH + 0x01)
#define SWIM_FLASH_NCR2        (SWIM_FLASH + 0x02)
#define SWIM_FLASH_FPR         (SWIM_FLASH + 0x03)
#define SWIM_FLASH_NFPR        (SWIM_FLASH + 0x04)
#define SWIM_FLASH_IAPSR       (SWIM_FLASH + 0x05)
#define SWIM_FLASH_PUKR        (SWIM_FLASH + 0x08)
#define SWIM_FLASH_DUKR        (SWIM_FLASH + 0x0a)

#define SWIM_FLASH_PUKR_KEY1   0x56
#define SWIM_FLASH_PUKR_KEY2   0xae
#define SWIM_FLASH_DUKR_KEY1   0xae
#define SWIM_FLASH_DUKR_KEY2   0x56
#define	SWIM_ROP_OPTIONBYTE    0x4800

#define SWIM_FLASH_START_ADDRESS  0x008000 //to 0x009FFF  (8k)
#define SWIM_EEPROM_START_ADDRESS 0x004000 //to 0x00407F  (128 bytes) (total 640 bytes unofficial)
#define SWIM_RAM_START_ADDRESS    0x000000 //to 0x0003FF  (1k)

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


/* Private function prototypes -----------------------------------------------*/

void SWIM_Setup();

uint8_t SWIM_Enter(void);
uint8_t SWIM_Soft_Reset(void);
uint8_t SWIM_WOTF(uint32_t addr, uint8_t *buf, uint8_t size);
uint8_t SWIM_ROTF(uint32_t addr, uint8_t *buf, uint8_t size);

uint8_t SWIM_Stall_CPU(void);
uint8_t SWIM_Unlock_OptionByte(void);
uint8_t SWIM_Lock_OptionByte(void);

uint8_t SWIM_Unlock_EEPROM(void);
uint8_t SWIM_Lock_EEPROM(void);

uint8_t SWIM_Unlock_Flash(void);
uint8_t SWIM_Lock_Flash(void);

uint8_t SWIM_Wait_For_Write(void);
uint8_t SWIM_Enable_Block_Programming(void);
uint8_t SWIM_Reset_Device(void);



uint8_t SWIM_Write_Data(uint8_t data);
uint8_t SWIM_Write_Cammand(uint8_t cammand);

//inline did not work
//function call overhead causing timing issues
#define SWIM_Write_Bit(bit)\
{\
  if(bit)\
  {\
    SWIM_PIN_LOW();\
    SWIM_DELAY_250_NS();\
    SWIM_PIN_HIGH();\
    SWIM_DELAY_1000_NS();\
    SWIM_DELAY_1000_NS();\
    SWIM_DELAY_500_NS();\
  }else\
  {\
    SWIM_PIN_LOW();\
    SWIM_DELAY_1000_NS();\
    SWIM_DELAY_1000_NS();\
    SWIM_DELAY_500_NS();\
    SWIM_PIN_HIGH();\
    SWIM_DELAY_250_NS();\
  }\
}

//parity or ack bit
#define SWIM_Write_Parity_Ack_Bit(bit)\
{\
  if(bit)\
  {\
    SWIM_PIN_LOW();\
    SWIM_DELAY_250_NS();\
    SWIM_PIN_HIGH();\
    SWIM_DELAY_1000_NS();\
    SWIM_DELAY_1000_NS();\
    SWIM_DELAY_250_NS();\
  }else\
  {\
    SWIM_PIN_LOW();\
    SWIM_DELAY_1000_NS();\
    SWIM_DELAY_1000_NS();\
    SWIM_DELAY_500_NS();\
    SWIM_PIN_HIGH();\
  }\
}






/***************** FLASH_CR2 ********************************/
/*
Bit 7 OPT:         Write option bytes
                   This bit is set and cleared by software.
                   0: Write access to option bytes disabled
                   1: Write access to option bytes enabled

Bit 6 WPRG:        Word programming
                   This bit is set by software and cleared by hardware when the operation is completed.
                   0: Word program operation disabled
                   1: Word program operation enabled

Bit 5 ERASE(1):    Block erasing
                   This bit is set by software and cleared by hardware when the operation is completed.
                   0: Block erase operation disabled
                   1: Block erase operation enabled

Bit 4 FPRG(1):     Fast block programming
                   This bit is set by software and cleared by hardware when the operation is completed.
                   0: Fast block program operation disabled
                   1: Fast block program operation enabled
Bits 3:1 Reserved

Bit 0 PRG:         Standard block programming
                   This bit is set by software and cleared by hardware when the operation is completed.
                   0: Standard block programming operation disabled
                   1: Standard block programming operation enabled (automatically first erasing)


*/











#endif /* __STM8_SWIM_H */

