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
#include "i2c.h"
#include "at24cxx.h"






/* Private defines -----------------------------------------------------------*/

#define PROG_SWITCH_pressed             0

#define LED_RED_pin                     GPIO_PIN_2
#define LED_RED_port                    GPIOA

#define LED_GREEN_pin                   GPIO_PIN_3
#define LED_GREEN_port                  GPIOA

#define PROG_SWITCH_pin                 GPIO_PIN_4
#define PROG_SWITCH_port                GPIOD


#define LED_RED_off()                   (LED_RED_port->ODR |=LED_RED_pin)
#define LED_RED_on()                    (LED_RED_port->ODR &=~LED_RED_pin)
#define LED_RED_toggle()                (LED_RED_port->ODR ^=LED_RED_pin)


#define LED_GREEN_off()                 (LED_GREEN_port->ODR  |=LED_GREEN_pin)
#define LED_GREEN_on()                  (LED_GREEN_port->ODR &=~LED_GREEN_pin)
#define LED_GREEN_toggle()              (LED_GREEN_port->ODR ^= LED_GREEN_pin)


#define PROG_SWITCH_read()              (PROG_SWITCH_port->IDR & PROG_SWITCH_pin)


#define FLASH_STORE_ADDRESS             0x0000 //in 24CXX   8K flash STM8S003  0x00 to 0x2000
#define EEPROM_STORE_ADDRESS            0x2000 //in 24CXX   128B EEprom STM8S003 0x00 to 0x3080
#define OPTION_BYTE_STORE_ADDRESS       0x3000 //in 24CXX   11B  option byte register STM8S003




uint8_t RAM_BUFFER[64]={0};
uint8_t COMPARE_BUFFER[64]={0};


uint8_t state_machine=0;/* 0->Ideal, 1->Flash, 2->Read */
uint8_t state_change_flag=0;




/* Private function prototypes -----------------------------------------------*/
void STM8_flash_read(void);   /*Read from stm8 device and store in 24cxx */
void STM8_flash_write(void);  /*Read from 24cxx and flash stm8*/

/* Private functions ---------------------------------------------------------*/
void STM8_flash_read(void)
{
  uint8_t status,blk;

  status=SWIM_Enter();
  
  delay_ms(1);
  
  if(status)
  {
    status=SWIM_Soft_Reset();
  }
  
  if(status)
  {
    //status=SWIM_Stall_CPU();
  }
  
#if 1
  /*read flash data from stm8*/
  for (blk=0;blk<128;blk++)
  {
    if(status)
    {
      status=SWIM_ROTF(SWIM_FLASH_START_ADDRESS+(blk*64),RAM_BUFFER,64);
    }
    if(status)
    {
      status=AT24CXX_Write_Page(FLASH_STORE_ADDRESS+(blk*64),RAM_BUFFER,64); 
      status=AT24CXX_Read_Buffer(FLASH_STORE_ADDRESS,COMPARE_BUFFER,64);
    }
    
    if(status==0)
    {
      LED_GREEN_on();
      LED_RED_on();
      break;
    } 
    else
    {
      LED_GREEN_toggle();     
    }
    
  }
  status=AT24CXX_Read_Buffer(FLASH_STORE_ADDRESS,COMPARE_BUFFER,64);

  /*read EEprom data from stm8*/
  
  for (blk=0;blk<2;blk++) /*128 bytes*/
  {
    if(status)
    {
      status=SWIM_ROTF(SWIM_EEPROM_START_ADDRESS+(blk*64),RAM_BUFFER,64);
    }
    if(status)
    {
      status=AT24CXX_Write_Page(EEPROM_STORE_ADDRESS+(blk*64),RAM_BUFFER,64);
      status=AT24CXX_Read_Buffer(FLASH_STORE_ADDRESS,COMPARE_BUFFER,64);
    }
    
    if(status==0)
    {
      LED_GREEN_on();
      LED_RED_on();
      break;
    } 
    
  }
 #endif

  

  /*read Option bytes data from stm8*/
  if(status)
  {
    status=SWIM_ROTF(SWIM_OPT0,RAM_BUFFER,11);
  }
  if(status)
  {
    //status=AT24CXX_Write_Page(OPTION_BYTE_STORE_ADDRESS,RAM_BUFFER,11);
    status=AT24CXX_Read_Buffer(FLASH_STORE_ADDRESS,COMPARE_BUFFER,64);
  }
  if(status==0)
  {
    LED_GREEN_on();
    LED_RED_on();
  }

 
  if(status)
  {
    LED_GREEN_on();
  }
  delay_ms(2);
  NRST_LOW(); /*reset device*/
  delay_ms(2);
  NRST_HIGH();
  
}



void STM8_flash_write(void)
{
  uint8_t status,temp[2],blk;

  status=SWIM_Enter();
  
  delay_ms(1);
  
  if(status)
  {
    status=SWIM_Soft_Reset();
  }
  
  if(status)
  {
    //status=SWIM_Stall_CPU();
  }
  
  

  /*write flash data to stm8*/
  if(status)
  {
    status=SWIM_Unlock_Flash();
  }
  for (blk=0;blk<128;blk++)
  {
    
    if(status)
    {
      status=AT24CXX_Read_Buffer(FLASH_STORE_ADDRESS+(blk*64),RAM_BUFFER,64); 
    }  
    
    temp[0]=0x01;				//Flash_CR2  standard block programming
    temp[1]=0xFE;				//Flash_NCR2
    
    if(status)
    {
      status=SWIM_WOTF(SWIM_FLASH_CR2,temp,2); 
    }
    
    if(status)
    {
      status=SWIM_WOTF(SWIM_FLASH_START_ADDRESS+(blk*64),RAM_BUFFER,64);
      delay_ms(5); //5ms delay after block write  //compansated in reading 24cxx
    }
          
    if(status==0)
    {
      LED_GREEN_on();
      LED_RED_on();
      break;
    } 
    else
    {
      LED_RED_toggle();
    }
    
  }
  
  /*write EEprom data to stm8*/
  if(status)
  {
    status=SWIM_Unlock_EEprom();
  }
  for (blk=0;blk<2;blk++) /*128 bytes*/
  {
    if(status)
    {
      status=AT24CXX_Read_Buffer(EEPROM_STORE_ADDRESS+(blk*64),RAM_BUFFER,64);
    }
    
    temp[0]=0x01;				//Flash_CR2  standard block programming
    temp[1]=0xFE;				//Flash_NCR2
    
    if(status)
    {
      status=SWIM_WOTF(SWIM_FLASH_CR2,temp,2); 
    }
    
    if(status)
    {
      status=SWIM_WOTF(SWIM_EEPROM_START_ADDRESS+(blk*64),RAM_BUFFER,64);
      delay_ms(5); //5ms delay after block write  
    }
    if(status==0)
    {
      LED_GREEN_on();
      LED_RED_on();
      break;
    }
    
  }
  
  
  /*write Option bytes data to stm8*/
  if(status)
  {
    status=SWIM_Unlock_OptionByte();
  }
  if(status)
  {
    status=AT24CXX_Read_Buffer(OPTION_BYTE_STORE_ADDRESS,RAM_BUFFER,11);
  }
  if(status)
  {
    status=SWIM_WOTF(SWIM_OPT0,RAM_BUFFER,11);
  }
  
  if(status==0)
  {
    LED_GREEN_on();
    LED_RED_on();
  }
  
  
  if(status)
  {
    LED_RED_on();
  }
  delay_ms(5);
  NRST_LOW(); /*reset device*/
  delay_ms(2);
  NRST_HIGH();

}






void STM8_Flash_Compare(void)
{
  uint8_t status;

  status=SWIM_Enter();
  
  
  delay_ms(1);
  
  if(status)
  {
    status=SWIM_Soft_Reset();
  }
  
  if(status)
  {
    //status=SWIM_Stall_CPU();
  }

  for(uint8_t i=0;i<127;i++)
  {
    if(status)
    {
      status=SWIM_ROTF(SWIM_FLASH_START_ADDRESS+(i*64),RAM_BUFFER,64);
    }
    if(status)
    {
      status=AT24CXX_Read_Buffer(FLASH_STORE_ADDRESS+(i*64),COMPARE_BUFFER,64);
    }
    
    for(uint8_t j=0;j<64;j++)
    {
      if(RAM_BUFFER[j]==COMPARE_BUFFER[j])
      {
        LED_GREEN_toggle();    
        LED_RED_toggle();     
      }
      else
      {    
        LED_GREEN_on();
        LED_RED_on();
        status=0;
        break;
      }
    }
    
  }
  
  
  /*eeprom compare*/
    for(uint8_t i=0;i<2;i++)
  {
    if(status)
    {
      status=SWIM_ROTF(SWIM_EEPROM_START_ADDRESS+(i*64),RAM_BUFFER,64);
    }
    if(status)
    {
      status=AT24CXX_Read_Buffer(EEPROM_STORE_ADDRESS+(i*64),COMPARE_BUFFER,64);
    }
    
    for(uint8_t j=0;j<64;j++)
    {
      if(RAM_BUFFER[j]==COMPARE_BUFFER[j])
      {
        LED_GREEN_toggle();    
        LED_RED_toggle();     
      }
      else
      {    
        LED_GREEN_on();
        LED_RED_on();
        status=0;
        break;
      }
    }
    
  }
  

    /*option byte compare*/
  
  if(status)
  {
    status=AT24CXX_Read_Buffer(OPTION_BYTE_STORE_ADDRESS,RAM_BUFFER,11);
  }
  if(status)
  {
    status=SWIM_ROTF(SWIM_OPT0,COMPARE_BUFFER,11);
  }
  for(uint8_t j=0;j<11;j++)
  {
    if(RAM_BUFFER[j]==COMPARE_BUFFER[j])
    {
      LED_GREEN_toggle();    
      LED_RED_toggle();     
    }
    else
    {    
      LED_GREEN_on();
      LED_RED_on();
      status=0;
    }
  }
  
  if(status)
  {
    //status=SWIM_Soft_Reset();
  for(uint8_t j=0;j<10;j++)
  {
    LED_RED_on();
    LED_GREEN_off();
    delay_ms(100);
    LED_RED_off();
    LED_GREEN_on();
    delay_ms(100);

  }
  }
  delay_ms(2);
  NRST_LOW(); /*reset device*/
  delay_ms(2);
  NRST_HIGH();
  

  
}


void main(void)
{
  
  SWIM_Setup();
  
  I2C_setup();
  
  /*Initialise LEDs and switch */
  GPIO_Init(LED_RED_port, LED_RED_pin, GPIO_MODE_OUT_PP_HIGH_SLOW);
  GPIO_Init(LED_GREEN_port, LED_GREEN_pin, GPIO_MODE_OUT_PP_HIGH_SLOW);
  GPIO_Init(PROG_SWITCH_port, PROG_SWITCH_pin, GPIO_MODE_IN_PU_NO_IT);
  
  
  
  //STM8_flash_write();
  //STM8_flash_read();
  //STM8_Flash_Compare();
  
  /* Infinite loop */
  while (1)
  {
    uint32_t timeout=0;
    if(PROG_SWITCH_read()==PROG_SWITCH_pressed)
    {
      state_change_flag=0;
      while(PROG_SWITCH_read()==PROG_SWITCH_pressed)
      {
        timeout++;
        if(timeout>500000)
        {
          timeout=0;
          state_machine++;
          state_change_flag=1;
          if(state_machine>2)
          {
            state_machine=0;
          }
          if(state_machine==1)
          {
          LED_RED_on();
          LED_GREEN_off();
          }
          if(state_machine==2)
          {
          LED_RED_off();
          LED_GREEN_on();
          }
          if(state_machine==0)
          {
          LED_RED_off();
          LED_GREEN_off();
          }
        }
      }
      
      if(state_change_flag==0)
      {
        
          if(state_machine==0)
          {
          LED_RED_on();
          LED_GREEN_on();
          delay_ms(100); 
          LED_RED_off();
          LED_GREEN_off();
          }
          
          if(state_machine==1)
          {
            STM8_flash_write();
            STM8_Flash_Compare(); 
          }
          
          if(state_machine==2)
          {
            STM8_flash_read();
            STM8_Flash_Compare();
          }
         
      }
      
    }
    
    
    
    
    if(state_machine==0)
    {
      LED_RED_off();
      LED_GREEN_off();
    }
    
    if(state_machine==1)
    {
      LED_RED_on();
      LED_GREEN_off();
    }
    
    if(state_machine==2)
    {
      LED_RED_off();
      LED_GREEN_on();
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
