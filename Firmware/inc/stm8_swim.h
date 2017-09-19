#ifndef __STM8_SWIM_H
#define __STM8_SWIM_H

/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"
#include "millis.h"
#include "stdlib.h"



/* Private defines -----------------------------------------------------------*/
#define MOSI_pin                         GPIO_PIN_6
#define MOSI_port                        GPIOC

#define MISO_pin                         GPIO_PIN_7
#define MISO_port                        GPIOC

#define SWIM_NRST_pin                    GPIO_PIN_4
#define SWIM_NRST_port                   GPIOC

#define SWIM_INT_port                    GPIOC
#define SWIM_INT_pin                     GPIO_PIN_3



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
#define	SWIM_ROP_OPTIONBYTE    0x480


#define	Enable_SWIM_INT()     (SWIM_INT_port->CR2 |= (uint8_t)SWIM_INT_pin)    
#define	Disable_SWIM_INT()    (SWIM_INT_port->CR2 &= (uint8_t)(~(SWIM_INT_pin)))    



/* Private function prototypes -----------------------------------------------*/

void SWIM_setup(void);
uint8_t SWIM_Enter(void);
uint8_t SWIM_Send_Data(uint8_t data,uint8_t len,uint8_t retry);
uint8_t SWIM_WOTF(uint32_t addr, uint8_t *buf, uint16_t size);
uint8_t SWIM_ROTF(uint32_t addr, uint8_t *buf, uint16_t size);













#endif /* __STM8_SWIM_H */

