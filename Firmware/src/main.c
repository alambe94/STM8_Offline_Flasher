/**
******************************************************************************
* @file    Project/main.c 
* @author  MCD Application Team
* @version V2.2.0
* @date    30-September-2014
* @brief   Main program body
******************************************************************************
* @attention
*
* <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
*
* Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
* You may not use this file except in compliance with the License.
* You may obtain a copy of the License at:
*
*        http://www.st.com/software_license_agreement_liberty_v2
*
* Unless required by applicable law or agreed to in writing, software 
* distributed under the License is distributed on an "AS IS" BASIS, 
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*
******************************************************************************
*/ 


/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"
#include "millis.h"
#include "stdlib.h"
#include "stm8_swim.h"
#include "soft_i2c.h"
#include "at24cxx.h"


/* Private defines -----------------------------------------------------------*/

#define PROG_SWITCH_PRESSED             0

#define LED_RED_PIN                     GPIO_PIN_2
#define LED_RED_PORT                    GPIOA

#define LED_GREEN_PIN                   GPIO_PIN_3
#define LED_GREEN_PORT                  GPIOA

#define PROG_SWITCH_PIN                 GPIO_PIN_4
#define PROG_SWITCH_PORT                GPIOD


#define LED_RED_OFF()                   (LED_RED_PORT->ODR |=LED_RED_PIN)
#define LED_RED_ON()                    (LED_RED_PORT->ODR &=~LED_RED_PIN)
#define LED_RED_TOGGLE()                (LED_RED_PORT->ODR ^=LED_RED_PIN)


#define LED_GREEN_OFF()                 (LED_GREEN_PORT->ODR  |=LED_GREEN_PIN)
#define LED_GREEN_ON()                  (LED_GREEN_PORT->ODR &=~LED_GREEN_PIN)
#define LED_GREEN_TOGGLE()              (LED_GREEN_PORT->ODR ^= LED_GREEN_PIN)


#define PROG_SWITCH_READ()              (PROG_SWITCH_PORT->IDR & PROG_SWITCH_PIN)
#define IS_PROG_SWITCH_PRESSED()        ((PROG_SWITCH_PORT->IDR & PROG_SWITCH_PIN)?0:1)



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


#define FLASH_STORE_ADDRESS             0x0000 //in 24CXX   8K flash STM8S003  0x00 to 0x2000
#define EEPROM_STORE_ADDRESS            0x3000 //in 24CXX   128B EEPROM STM8S003 0x3000 to 0x3080
#define OPTION_BYTE_STORE_ADDRESS       0x4000 //in 24CXX   10B  option byte register STM8S003

#define STM8S003_BLOCK_SIZE             64  //
#define STM8S003_FLASH_PAGES            128 //stm8s003 has 128 pages of 64 bytes
#define STM8S003_EEPROM_PAGES           2   //stm8s003 has 2 pages of 64 bytes (extra 2 page unofficial)


uint8_t RAM_BUFFER[STM8S003_BLOCK_SIZE]={0};
uint8_t COMPARE_BUFFER[STM8S003_BLOCK_SIZE]={0};

enum State
{
  IDLE,
  STM8_TO_AT24,
  AT24_TO_STM8
}Current_State;


/* Private function prototypes -----------------------------------------------*/
uint8_t STM8_To_AT24C256(void);   /*Read from stm8 device and store in 24cxx */
uint8_t AT24C256_To_STM8(void);  /*Read from 24cxx and flash stm8*/
uint8_t Compare_STM8_And_AT24C256(void);
uint8_t STM8_24Cxx_Read(void);  /*Read from 24cxx and store 24cxx*/ //todo


/* Private functions ---------------------------------------------------------*/
uint8_t STM8_To_AT24C256(void)
{
  uint8_t status;
  uint16_t address_offset = 0;
    
  status = SWIM_Enter();
  
  delay_ms(5);
  
  /****************************read flash data from stm8 start********************************/
  for (uint8_t i=0; i<STM8S003_FLASH_PAGES; i++)
  {
    address_offset = (i*STM8S003_BLOCK_SIZE);
    
    if(status)
    {
      status=SWIM_ROTF(STM8_FLASH_START_ADDRESS+address_offset, RAM_BUFFER, STM8S003_BLOCK_SIZE);
    }
    
    if(status)
    {
      status=AT24CXX_Write_Page(FLASH_STORE_ADDRESS+address_offset, RAM_BUFFER, STM8S003_BLOCK_SIZE); 
      //delay_ms(3);// read from stm8 takes 2.9ms
    }
    
    if(status)
    {
      LED_GREEN_TOGGLE();     
    } 

  }
  /****************************read flash data from stm8 end********************************/
  
  
  
  /*****************************read EEPROM data from stm8 start************************************/
  for (uint8_t i=0; i<STM8S003_EEPROM_PAGES; i++)
  {
    address_offset = (i*STM8S003_BLOCK_SIZE);
    
    if(status)
    {
      status=SWIM_ROTF(STM8_EEPROM_START_ADDRESS+ address_offset,RAM_BUFFER, STM8S003_BLOCK_SIZE);
    }
    
    if(status)
    {
      status=AT24CXX_Write_Page(EEPROM_STORE_ADDRESS+address_offset, RAM_BUFFER, STM8S003_BLOCK_SIZE);
    }
    
    if(status)
    {
      LED_GREEN_TOGGLE();     
    } 

  }
  /*****************************read EEPROM data from stm8 end************************************/
  
  
  
  /***************************read Option bytes data from stm8 start*************************/
  if(status)
  {
    status=SWIM_ROTF(SWIM_OPT1,RAM_BUFFER,10); // stm8s0033 has 10 option bytes
  }
  
  if(status)
  {
    status=AT24CXX_Write_Page(OPTION_BYTE_STORE_ADDRESS,RAM_BUFFER,10);
  }
  
  if(status)
  {
    status=SWIM_Reset_Device();
  }
  
  return status;
}
/***************************read Option bytes data from stm8 end*************************/





/****************************** AT24C256_To_STM8 start*******************************************/
uint8_t AT24C256_To_STM8(void)
{
  uint8_t status;
  uint16_t address_offset = 0;
  
  status = SWIM_Reset_Device();
  
  status = SWIM_Enter();
  
  delay_ms(5);
  
  /********************************write flash data to stm8 start*************************/
  if(status)
  {
    status=SWIM_Unlock_Flash();
  }
  
  for (uint8_t i =0; i<STM8S003_FLASH_PAGES; i++)
  {
    address_offset = (i*STM8S003_BLOCK_SIZE);
    
    if(status)
    {
      status = AT24CXX_Read_Buffer(FLASH_STORE_ADDRESS+address_offset, RAM_BUFFER, STM8S003_BLOCK_SIZE); 
    }  
    
    if(status)
    {
      status = SWIM_Enable_Block_Programming(); //standard block programming
    }
    
    if(status)
    {
      status = SWIM_WOTF(STM8_FLASH_START_ADDRESS+address_offset, RAM_BUFFER,STM8S003_BLOCK_SIZE);
      //delay_ms(5); //5ms delay after block write  //compansated in reading 24cxx
    }
   
    if(status)
    {
      LED_RED_TOGGLE();
    } 
    
  }
  
  if(status)
  {
    status=SWIM_Lock_Flash();
  }
  /********************************write flash data to stm8 end*************************/
  
  
  
  /*************************write EEPROM data to stm8 start*********************************/
  if(status)
  {
    status=SWIM_Unlock_EEPROM();
  }
  
  for (uint8_t i=0; i<STM8S003_EEPROM_PAGES; i++)
  {
    address_offset = (i*STM8S003_BLOCK_SIZE);
    
    if(status)
    {
      status=AT24CXX_Read_Buffer(EEPROM_STORE_ADDRESS+address_offset, RAM_BUFFER, STM8S003_BLOCK_SIZE);
    }
    
    if(status)
    {
      status=SWIM_Enable_Block_Programming(); //standard block programming
    }
    
    if(status)
    {
      status=SWIM_WOTF(STM8_EEPROM_START_ADDRESS+address_offset, RAM_BUFFER, STM8S003_BLOCK_SIZE);
      delay_ms(5); //5ms delay after block write  
    }
    
    if(status)
    {
      LED_RED_TOGGLE();
    } 
    
  }
  
  if(status)
  {
    status=SWIM_Lock_EEPROM();
  }
  /*************************write EEPROM data to stm8 end*********************************/
  
  
  
  /************************write Option bytes data to stm8 start******************************/
  if(status)
  {
    status=SWIM_Unlock_OptionByte();
  }
  
  if(status)
  {
    status=SWIM_Unlock_EEPROM();//same sequence for option bytes
  }
  
  if(status)
  {
    status=AT24CXX_Read_Buffer(OPTION_BYTE_STORE_ADDRESS,RAM_BUFFER,10);
  }
  
  if(status)
  {
    status=SWIM_WOTF(SWIM_OPT1,RAM_BUFFER,2);
    delay_ms(10);
  }
  
  if(status)
  {
    status=SWIM_WOTF(SWIM_OPT2,RAM_BUFFER+2,2);
    delay_ms(10);
  }
  
  if(status)
  {
    status=SWIM_WOTF(SWIM_OPT3,RAM_BUFFER+4,2);
    delay_ms(10);
  }
  
  if(status)
  {
    status=SWIM_WOTF(SWIM_OPT4,RAM_BUFFER+6,2);
    delay_ms(10);
  }
  
  if(status)
  {
    status=SWIM_WOTF(SWIM_OPT5,RAM_BUFFER+8,2);
    delay_ms(10);
  }
  
  if(status)
  {
    status=SWIM_Lock_EEPROM();
  }
  
  if(status)
  {
    status=SWIM_Lock_OptionByte();
  }
  /************************write Option bytes data to stm8 end******************************/
  
  
  if(status)
  {
    status=SWIM_Reset_Device();
  }
  
  return status;
}
/****************************** AT24C256_To_STM8 end*******************************************/





/****************************** Compare_STM8_And_AT24C256 start*******************************************/
uint8_t Compare_STM8_And_AT24C256(void)
{
  uint8_t status = 0;
  uint16_t address_offset = 0;
  
  /****************************************flash compare start**************************/
  for(uint8_t i=0; i<STM8S003_FLASH_PAGES; i++)
  {
    address_offset = (i*STM8S003_BLOCK_SIZE);
    
    if(status)
    {
      status=SWIM_ROTF(STM8_FLASH_START_ADDRESS+address_offset, RAM_BUFFER, STM8S003_BLOCK_SIZE);
    }
    if(status)
    {
      status=AT24CXX_Read_Buffer(FLASH_STORE_ADDRESS+address_offset, COMPARE_BUFFER, STM8S003_BLOCK_SIZE);
    }
    
    for(uint8_t j=0; j<STM8S003_BLOCK_SIZE; j++)
    {
      if(RAM_BUFFER[j]==COMPARE_BUFFER[j])
      {
        LED_GREEN_TOGGLE();    
        LED_RED_TOGGLE();     
      }
      else
      {
        status = 0;
        break;
      }
      
    }
    
  }
  /****************************************flash compare end**************************/
  
  
  /****************************************eeprom compare start**************************/
  for(uint8_t i=0; i<STM8S003_EEPROM_PAGES ;i++)
  {
    address_offset = (i*STM8S003_BLOCK_SIZE);
    
    if(status)
    {
      status=SWIM_ROTF(STM8_EEPROM_START_ADDRESS+address_offset, RAM_BUFFER, STM8S003_BLOCK_SIZE);
    }
    if(status)
    {
      status=AT24CXX_Read_Buffer(EEPROM_STORE_ADDRESS+address_offset, COMPARE_BUFFER, STM8S003_BLOCK_SIZE);
    }
    
    for(uint8_t j=0; j<STM8S003_BLOCK_SIZE; j++)
    {
      if(RAM_BUFFER[j]==COMPARE_BUFFER[j])
      {
        LED_GREEN_TOGGLE();    
        LED_RED_TOGGLE();     
      }
      else
      {
        status = 0;
        break;
      }
      
    }
    
  }
  /****************************************eeprom compare end**************************/
  
  
  /******************************option byte compare start*************************************/
  if(status)
  {
    status=SWIM_ROTF(SWIM_OPT1,RAM_BUFFER,10);
  }
  
  if(status)
  {
    status=AT24CXX_Read_Buffer(OPTION_BYTE_STORE_ADDRESS,COMPARE_BUFFER,10);
  }
  
  for(uint8_t j=0; j<10; j++)
  {
    if(RAM_BUFFER[j]==COMPARE_BUFFER[j])
    {
      LED_GREEN_TOGGLE();    
      LED_RED_TOGGLE();     
    }
    else
    {
      status = 0;
    }
    
  }
  /******************************option byte compare end*************************************/
  
  
  if(status)
  {
    status=SWIM_Reset_Device();
  }  
  
  return status;
}
/****************************** Compare_STM8_And_AT24C256 start*******************************************/








void main(void)
{
  uint16_t status = 0;
  
  uint16_t switch_pressed_time = 0;
  
  SWIM_Setup();
  
  Soft_I2C_Init();
  
  /*Initialise LEDs and switch */
  GPIO_Init(LED_RED_PORT, LED_RED_PIN, GPIO_MODE_OUT_PP_HIGH_SLOW);
  GPIO_Init(LED_GREEN_PORT, LED_GREEN_PIN, GPIO_MODE_OUT_PP_HIGH_SLOW);
  GPIO_Init(PROG_SWITCH_PORT, PROG_SWITCH_PIN, GPIO_MODE_IN_PU_NO_IT);
  
  while(1)
  {
  status = STM8_To_AT24C256();
  status = Compare_STM8_And_AT24C256();
  }
  
  LED_GREEN_ON(); // LED GREEN and RED ON to indicate ideal state
  LED_RED_ON();
  Current_State = IDLE; //flash mcu mode
  
  /* Infinite loop */
  while (1)
  {
    while(PROG_SWITCH_READ() == PROG_SWITCH_PRESSED)
    {
      delay_ms(1);
      switch_pressed_time++;
      
      if(switch_pressed_time > 2000)
      {
        switch_pressed_time = 0;
        
        switch(Current_State)
        {
        case IDLE:
          Current_State = AT24_TO_STM8; //read mcu mode
          LED_GREEN_ON(); // GREEN on RED off to indicate flashing mode
          LED_RED_OFF();
          break;
          
          
        case AT24_TO_STM8:
          Current_State = STM8_TO_AT24; //read mcu mode
          LED_RED_ON();
          LED_GREEN_OFF(); // GREEN off RED on to indicate reading mode
          
          
          break;
        case STM8_TO_AT24:
          Current_State = IDLE; //flash the mcu
          LED_GREEN_ON(); // LED GREEN and RED ON to indicate ideal state
          LED_RED_ON();
          
          break;
          
        }
      }
    }
    
    
    
    
    if(switch_pressed_time > 50)// 50ms debounce
    {
      switch_pressed_time = 0;
      
      switch(Current_State)
      {
      case IDLE:
        LED_GREEN_ON(); // LED GREEN and RED ON to indicate ideal state
        LED_RED_ON();
        break;
        
        
      case AT24_TO_STM8:
        //status = AT24C256_To_STM8();
        status = Compare_STM8_And_AT24C256();
        break;
        
      case STM8_TO_AT24:
        status = STM8_To_AT24C256();
        status = Compare_STM8_And_AT24C256();
        break;
        
      }
      
   
    }
    
  }
  
}

#ifdef USE_FULL_ASSERT

/**
* @brief  Reports the name of the source file and the source line number
*   where the assert_param error has occurred.
* @param file: pointer to the source file name
* @param line: assert_param error line source number
* @retval : None
*/
void assert_failed(u8* file, u32 line)
{ 
  /* User can add his own implementation to report the file name and line number,
  ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
  
  /* Infinite loop */
  while (1)
  {
  }
}
#endif


/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
