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



/* Private defines -----------------------------------------------------------*/



uint8_t WRITE_BUFFER[64]={0};
uint8_t READ_BUFFER[64]={0xFF};

extern uint32_t delay;


/* Private function prototypes -----------------------------------------------*/


/* Private functions ---------------------------------------------------------*/




void main(void)
{
  
  SWIM_setup();
  
  delay=10000;
  while(delay--);
  
  
  for(uint8_t i=0;i<64;i++)
  {
    //WRITE_BUFFER[i]=0xff;
  }
  
  
  uint8_t status,temp[2],blk;
  status=SWIM_Enter();
  
  delay=10;
  while(delay--);
  if(status)
  status=SWIM_Soft_Reset();
  
  if(status)
  status=SWIM_Stall_CPU();
 /* 
  if(status)
  status=SWIM_Unlock_Flash();
  
  if(status)
  {
    for (blk=0;blk<128;blk++)
    {
      temp[0]=0x01;					//Flash_CR2  standard block programming
      temp[1]=0xFE;				        //Flash_NCR2
      if(status)
      status=SWIM_WOTF(SWIM_FLASH_CR2,temp,2);      
      
      if(status)
      status=SWIM_WOTF(0x00008000+(blk*64),WRITE_BUFFER,64);
      delay=1000;
      while(delay--);
      
    }
  }
  */
  if(status)
    status=SWIM_ROTF(0x00008000, READ_BUFFER, 64);
  
  
  
  delay=10000;
  
  
  
  /* Infinite loop */
  while (1)
  {
    
    
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
