#ifndef __STM8_SWIM_H
#define __STM8_SWIM_H

/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"
#include "millis.h"
#include "stdlib.h"



/* Private defines -----------------------------------------------------------*/


#define SWIM_INT_pin                     GPIO_PIN_3
#define SWIM_INT_port                    GPIOC

#define SWIM_NRST_pin                    GPIO_PIN_4
#define SWIM_NRST_port                   GPIOC


#define SWIM_OUT_pin                     GPIO_PIN_5   
#define SWIM_OUT_PORT                    GPIOC 

#define CCRL                             CCR1L 
#define TIM                              TIM2
#define TIM_FLAG_UPDATE                  TIM2_FLAG_UPDATE 







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

#define SWIM_OPT0               0x4800 //Read-out protection (ROP)

#define OPT1                    0x4801 //User boot code(UBC)
#define NOPT1                   0x4802 

#define OPT2                    0x4803 //Alternate function remapping(AFR)
#define NOPT2                   0x4804 

#define OPT3                    0x4805 //Misc. option
#define NOPT3                   0x4806 

#define OPT4                    0x4807 //Clock option
#define NOPT4                   0x4808 

#define OPT5                    0x4809 //HSE clock startup
#define NOPT5                   0x480A 



#define	Enable_SWIM_INT()     (SWIM_INT_port->CR2 |= (uint8_t)SWIM_INT_pin)    
#define	Disable_SWIM_INT()    (SWIM_INT_port->CR2 &= (uint8_t)(~(SWIM_INT_pin)))    



/* Private function prototypes -----------------------------------------------*/

void SWIM_Setup(void);
void SWIM_HIGH(void);
void SWIM_LOW(void);
void NRST_HIGH(void);
void NRST_LOW(void);


uint8_t SWIM_Enter(void);
uint8_t SWIM_Soft_Reset(void);
uint8_t SWIM_Send_Data(uint8_t data,uint8_t len,uint8_t retry);
uint8_t SWIM_WOTF(uint32_t addr, uint8_t *buf, uint16_t size);
uint8_t SWIM_ROTF(uint32_t addr, uint8_t *buf, uint16_t size);

uint8_t SWIM_Stall_CPU(void);
uint8_t SWIM_Unlock_OptionByte(void);
uint8_t SWIM_Unlock_EEprom(void);
uint8_t SWIM_Unlock_Flash(void);



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

