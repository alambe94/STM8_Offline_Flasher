#ifndef __STM8_SWIM_H
#define __STM8_SWIM_H

/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"
#include "millis.h"
#include "stdlib.h"



/* Private defines -----------------------------------------------------------*/

/* all swim pin must be on the same port */
#define SWIM_PINS_PORT          GPIOD
#define SWIM_PINS_EXTI_PORT     EXTI_PORT_GPIOD

#define SWIM_PIN_1              GPIO_PIN_1
#define SWIM_PIN_2              GPIO_PIN_2
#define SWIM_PIN_3              GPIO_PIN_3 
#define SWIM_PIN_4              GPIO_PIN_4 
#define SWIM_PIN_5              GPIO_PIN_5 
#define SWIM_PIN_6              GPIO_PIN_6 


#define NRST_PIN_1              GPIO_PIN_3
#define NRST_PIN_1_PORT         GPIOC

#define NRST_PIN_2              GPIO_PIN_4
#define NRST_PIN_2_PORT         GPIOC

#define NRST_PIN_3              GPIO_PIN_5
#define NRST_PIN_3_PORT         GPIOC

#define NRST_PIN_4              GPIO_PIN_6
#define NRST_PIN_4_PORT         GPIOC

#define NRST_PIN_5              GPIO_PIN_7
#define NRST_PIN_5_PORT         GPIOC

#define NRST_PIN_6              GPIO_PIN_3
#define NRST_PIN_6_PORT         GPIOA


#define NRST_PIN_HIGH(PORT, PIN)        PORT->ODR |=  PIN     
#define NRST_PIN_LOW(PORT, PIN)         PORT->ODR &=  ~PIN   



#define SWIM_PIN_OUT()         SWIM_PINS_PORT->ODR |=  SWIM_PIN_Mask;\
                               SWIM_PINS_PORT->CR1 &= ~SWIM_PIN_Mask;\
                               SWIM_PINS_PORT->DDR |=  SWIM_PIN_Mask

#define SWIM_PIN_IN_INT()      SWIM_PINS_PORT->DDR &=  ~SWIM_PIN_Mask;\
                               SWIM_PINS_PORT->CR1 |=   SWIM_PIN_Mask;\
                               SWIM_PINS_PORT->CR2 |=   SWIM_PIN_Mask 


#define SWIM_PIN_HIGH()        SWIM_PINS_PORT->ODR |=  SWIM_PIN_Mask     
#define SWIM_PIN_LOW()         SWIM_PINS_PORT->ODR &= ~SWIM_PIN_Mask   
#define SWIM_PIN_READ()        SWIM_PINS_PORT->IDR &   SWIM_PIN_Mask


#define SWIM_DELAY_1_BIT()     nop(); nop()
#define SWIM_DELAY_0_BIT()     SWIM_DELAY_1_BIT();SWIM_DELAY_1_BIT();SWIM_DELAY_1_BIT();SWIM_DELAY_1_BIT();\
                               SWIM_DELAY_1_BIT();SWIM_DELAY_1_BIT();SWIM_DELAY_1_BIT();SWIM_DELAY_1_BIT();\
                               SWIM_DELAY_1_BIT();SWIM_DELAY_1_BIT();SWIM_DELAY_1_BIT();SWIM_DELAY_1_BIT();\
                               SWIM_DELAY_1_BIT();SWIM_DELAY_1_BIT();SWIM_DELAY_1_BIT();SWIM_DELAY_1_BIT();\
                               SWIM_DELAY_1_BIT();SWIM_DELAY_1_BIT()

#define SWIM_CMD_LEN                    3
#define SWIM_CMD_SRST                   0x00
#define SWIM_CMD_ROTF                   0x01
#define SWIM_CMD_WOTF                   0x02
#define SWIM_MAX_RESEND_CNT             20

#define SWIM_CSR               0x7F80
#define SWIM_DM_CSR2	       0x7F99
#define SWIM_FLASH             0x00505a
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

/* Private function prototypes -----------------------------------------------*/

void SWIM_Setup(void);

uint8_t SWIM_Write_Cammand(uint8_t cammand);
uint8_t SWIM_Write_Data(uint8_t data);

uint8_t SWIM_Enter(void);

uint8_t SWIM_WOTF(uint32_t addr, uint8_t *buf, uint8_t size);
uint8_t SWIM_ROTF(uint32_t addr, uint8_t *buf, uint8_t size);

uint8_t SWIM_Soft_Reset(void);
uint8_t SWIM_Stall_CPU(void);

uint8_t SWIM_Unlock_OptionByte(void);
uint8_t SWIM_Lock_OptionByte(void);

uint8_t SWIM_Unlock_EEPROM(void);
uint8_t SWIM_Lock_EEPROM(void);

uint8_t SWIM_Unlock_Flash(void);
uint8_t SWIM_Lock_Flash(void);

uint8_t SWIM_Enable_Block_Programming(void);
uint8_t SWIM_Wait_For_EOP(void);

uint8_t SWIM_Reset_Device(void);


void NRST_Low(void);

void NRST_High(void);


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

