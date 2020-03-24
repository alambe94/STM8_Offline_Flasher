#ifndef __STM8_SWIM_H
#define __STM8_SWIM_H


/**********************Device Independent File************************/
/**********************Device Independent File************************/
/**********************Device Independent File************************/
/**********************Device Independent File************************/
/**********************Device Independent File************************/


/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"

/* Private defines -----------------------------------------------------------*/


#define SWIM_CMD_LEN           3
#define SWIM_CMD_SRST          0x00
#define SWIM_CMD_ROTF          0x01
#define SWIM_CMD_WOTF          0x02
#define SWIM_MAX_RESEND_CNT    20


#define SWIM_CSR               0x7F80
#define SWIM_DM_CSR2	       0x7F99


#define SWIM_FLASH_PUKR_KEY1    0x56
#define SWIM_FLASH_PUKR_KEY2    0xae
#define SWIM_FLASH_DUKR_KEY1    0xae
#define SWIM_FLASH_DUKR_KEY2    0x56

/* Private function prototypes -----------------------------------------------*/

void SWIM_Setup(void);

uint8_t SWIM_Write_Cammand(uint8_t cammand);
uint8_t SWIM_Write_Data(uint8_t data);
void    SWIM_Write_Data2(uint8_t data);

uint8_t SWIM_Enter(void);

uint8_t SWIM_WOTF( uint32_t addr, uint8_t *buf, uint8_t size);

uint8_t SWIM_ROTF( uint32_t addr, uint8_t *buf, uint8_t size);

uint8_t SWIM_Soft_Reset(void);
uint8_t SWIM_Reset_Device(void);
uint8_t SWIM_Stall_CPU(void);


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