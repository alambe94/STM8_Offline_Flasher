#include "stm8_swim.h"
#include "stm8s_it.h"
#include "millis.h"



/**********************Device Independent File************************/
/**********************Device Independent File************************/
/**********************Device Independent File************************/
/**********************Device Independent File************************/
/**********************Device Independent File************************/


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


//inline did not work
//function call overhead causing timing issues
#define SWIM_Write_Bit(bit)\
{\
  if(bit)\
  {\
    SWIM_PIN_LOW();\
    SWIM_DELAY_1_BIT();\
    SWIM_PIN_HIGH();\
    SWIM_DELAY_0_BIT();\
  }else\
  {\
    SWIM_PIN_LOW();\
    SWIM_DELAY_0_BIT();\
    SWIM_PIN_HIGH();\
    SWIM_DELAY_1_BIT();\
  }\
}

//parity or ack bit
#define SWIM_Write_Parity_Ack_Bit(bit)\
{\
  if(bit)\
  {\
    SWIM_PIN_LOW();\
    SWIM_DELAY_1_BIT();\
    SWIM_PIN_IN_INT();\
  }else\
  {\
    SWIM_PIN_LOW();\
    SWIM_DELAY_0_BIT();\
    SWIM_PIN_IN_INT();\
  }\
}


volatile uint8_t INT_Count = 0;
uint8_t RX_Frame[15] = {0};

/* Initially all swim ports are enabled. If device did not responds to swim sequence, then that port will be disabled*/
uint8_t SWIM_PIN_Mask = (SWIM_PIN_1|SWIM_PIN_2|SWIM_PIN_3|SWIM_PIN_4|SWIM_PIN_5|SWIM_PIN_6);
uint8_t SWIM_Devices = 0; // discovred devices on swim pin, ie response to swim sequence;



INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
{
  if(SWIM_PIN_READ())
  {
    RX_Frame[INT_Count++] = 0x01;
  }
  else
  {
    RX_Frame[INT_Count++] = 0x00;
  }
}


void NRST_Low()
{
  if(SWIM_PIN_Mask & SWIM_PIN_1)
  {
    NRST_PIN_LOW(NRST_PIN_1_PORT, NRST_PIN_1);
  }
  if(SWIM_PIN_Mask & SWIM_PIN_2)
  {
    NRST_PIN_LOW(NRST_PIN_2_PORT, NRST_PIN_2);
  }
  if(SWIM_PIN_Mask & SWIM_PIN_3)
  {
    NRST_PIN_LOW(NRST_PIN_3_PORT, NRST_PIN_3);
  }
  if(SWIM_PIN_Mask & SWIM_PIN_4)
  {
    NRST_PIN_LOW(NRST_PIN_4_PORT, NRST_PIN_4);
  }
  if(SWIM_PIN_Mask & SWIM_PIN_5)
  {
    NRST_PIN_LOW(NRST_PIN_5_PORT, NRST_PIN_5);
  }
  if(SWIM_PIN_Mask & SWIM_PIN_6)
  {
    NRST_PIN_LOW(NRST_PIN_6_PORT, NRST_PIN_6);
  }
}


void NRST_High()
{
  
  if(SWIM_PIN_Mask & SWIM_PIN_1)
  {
    NRST_PIN_HIGH(NRST_PIN_1_PORT, NRST_PIN_1);
  }
  if(SWIM_PIN_Mask & SWIM_PIN_2)
  {
    NRST_PIN_HIGH(NRST_PIN_2_PORT, NRST_PIN_2);
  }
  if(SWIM_PIN_Mask & SWIM_PIN_3)
  {
    NRST_PIN_HIGH(NRST_PIN_3_PORT, NRST_PIN_3);
  }
  if(SWIM_PIN_Mask & SWIM_PIN_4)
  {
    NRST_PIN_HIGH(NRST_PIN_4_PORT, NRST_PIN_4);
  }
  if(SWIM_PIN_Mask & SWIM_PIN_5)
  {
    NRST_PIN_HIGH(NRST_PIN_5_PORT, NRST_PIN_5);
  }
  if(SWIM_PIN_Mask & SWIM_PIN_6)
  {
    NRST_PIN_HIGH(NRST_PIN_6_PORT, NRST_PIN_6);
  }
  
}

void SWIM_Setup(void)
{
  CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
  
  /* Initialise all SWIM pins to open drain out, for now dont enable interrupts*/
  GPIO_Init(SWIM_PINS_PORT, (GPIO_Pin_TypeDef)SWIM_PIN_Mask, GPIO_MODE_OUT_OD_HIZ_SLOW);
  
  /* Interrupts on falling edge*/
  EXTI_SetExtIntSensitivity(SWIM_PINS_EXTI_PORT, EXTI_SENSITIVITY_FALL_ONLY);
  
  GPIO_Init(NRST_PIN_1_PORT, NRST_PIN_1, GPIO_MODE_OUT_OD_HIZ_SLOW);
  GPIO_Init(NRST_PIN_2_PORT, NRST_PIN_2, GPIO_MODE_OUT_OD_HIZ_SLOW);
  GPIO_Init(NRST_PIN_3_PORT, NRST_PIN_3, GPIO_MODE_OUT_OD_HIZ_SLOW);
  GPIO_Init(NRST_PIN_4_PORT, NRST_PIN_4, GPIO_MODE_OUT_OD_HIZ_SLOW);
  GPIO_Init(NRST_PIN_5_PORT, NRST_PIN_5, GPIO_MODE_OUT_OD_HIZ_SLOW);
  GPIO_Init(NRST_PIN_6_PORT, NRST_PIN_6, GPIO_MODE_OUT_OD_HIZ_SLOW);
  
  enableInterrupts();
}


uint8_t SWIM_Enter()
{
  uint16_t timeout = 0;
  uint8_t swim_port = 0;
  
  SWIM_Devices = SWIM_PIN_Mask;
  
  SWIM_Reset_Devices();
 
  NRST_Low();
  delay_ms(1);
  
  /*1. To make the SWIM active, the SWIM pin must be forced low during a period of 16 µs.*/
  SWIM_PIN_LOW();
  delay_ms(1);
  
  /*2. Four pulses at 1 kHz followed by four pulses at 2 kHz*/
  for (uint8_t i=0; i<4; i++) 
  {
    SWIM_PIN_HIGH();
    delay_us(500);
    SWIM_PIN_LOW();
    delay_us(500);
  }
  for (uint8_t i=0; i<4; i++) 
  {
    SWIM_PIN_HIGH();
    delay_us(250);
    SWIM_PIN_LOW();
    delay_us(250);
  }
  
  /*3. After the entry sequence, the SWIM enters in SWIM active state, and the HSI oscillator
  is automatically turned ON. */
  
  
  
  /*4. SWIM sends a synchronization frame to the host 128 x SWIM clocks = 16us */
  SWIM_PIN_IN_INT();
  // approx 30us to give sync pulse of 16us
  
  timeout = 1000; // approx (1000/16) us for 16mhz clk
  while(!INT_Count && --timeout);
  swim_port = SWIM_PIN_READ();
  SWIM_PIN_OUT();
  INT_Count = 0;
  
  //disable swim pin if device did not responds.
  SWIM_Devices = (SWIM_PIN_Mask ^ swim_port);
  SWIM_PIN_Mask = SWIM_Devices;
  
  if(!timeout)
  {
    NRST_High();
    return 0;
  }
    
  /*5. SWIM line must be released at 1 to guarantee that the SWIM is ready for communication (at least 300 ns).*/
  delay_us(500);
  
  
  /*6. Write 0xA0h in the SWIM_CSR:*/
  uint8_t csr = 0xA0;
  if(!SWIM_WOTF_All(SWIM_CSR, &csr, 1))
  {
    NRST_High();
    return 0;
  }
  
  
  /*6. Release the reset which starts the option byte loading sequence. Wait 1 ms for
  stabilization*/  
  NRST_High();
  delay_ms(1);
  
  SWIM_PIN_LOW();
  delay_us(50);
  SWIM_PIN_HIGH();
  
  delay_ms(20);
  
  return 1;
  
}


uint8_t SWIM_Write_Cammand(uint8_t cammand)
{
  uint8_t timeout = 255;
  uint8_t data_frame[3] = "0";
  uint8_t parity = 0;
  
  data_frame[2] = cammand>>2 & 0x01;
  data_frame[1] = cammand>>1 & 0x01;
  data_frame[0] = cammand>>0 & 0x01;
  
  for (uint8_t i = 0; i <=2; i++) 
  {
    parity += data_frame[i];
  }
  parity &= 0x01;
  
  SWIM_PIN_OUT();
  
  SWIM_Write_Bit(0);// start bit
  SWIM_Write_Bit(data_frame[2]);
  SWIM_Write_Bit(data_frame[1]);
  SWIM_Write_Bit(data_frame[0]);
  SWIM_Write_Parity_Ack_Bit(parity);
  
  while(!INT_Count && --timeout);
  SWIM_PIN_OUT();
  INT_Count = 0;
  if(timeout)
  {
    return RX_Frame[0]; 
  }  
  return 0;
}


uint8_t SWIM_Write_Data(uint8_t data)
{
  uint8_t timeout = 255;
  uint8_t data_frame[8];
  uint8_t parity = 0;
  
  //unroll for loop for faster execution
  data_frame[7] = data>>7 & 0x01;
  data_frame[6] = data>>6 & 0x01;
  data_frame[5] = data>>5 & 0x01;
  data_frame[4] = data>>4 & 0x01;
  data_frame[3] = data>>3 & 0x01;
  data_frame[2] = data>>2 & 0x01;
  data_frame[1] = data>>1 & 0x01;
  data_frame[0] = data>>0 & 0x01;
  
  //unroll for loop for faster execution
  parity  = data_frame[7];
  parity += data_frame[6];
  parity += data_frame[5];
  parity += data_frame[4];
  parity += data_frame[3];
  parity += data_frame[2];
  parity += data_frame[1];
  parity += data_frame[0];
  parity &= 0x01;// XOR of all frame bits
  
  
  SWIM_PIN_OUT();
  SWIM_Write_Bit(0);// start bit
  SWIM_Write_Bit(data_frame[7]);
  SWIM_Write_Bit(data_frame[6]);
  SWIM_Write_Bit(data_frame[5]);
  SWIM_Write_Bit(data_frame[4]);
  SWIM_Write_Bit(data_frame[3]);
  SWIM_Write_Bit(data_frame[2]);
  SWIM_Write_Bit(data_frame[1]);
  SWIM_Write_Bit(data_frame[0]);
  SWIM_Write_Parity_Ack_Bit(parity);
  
  while(!INT_Count && --timeout);
  SWIM_PIN_OUT();
  INT_Count = 0;
  if(timeout)
  {
    return RX_Frame[0]; 
  }  
  return 0;
}


uint8_t SWIM_WOTF(uint8_t swim_pin, uint32_t addr, uint8_t *buf, uint8_t size) 
{
  
  if (!buf || !size) {
    return 0;
  }
  
  SWIM_PIN_Mask = swim_pin;
  
  if(SWIM_Write_Cammand(SWIM_CMD_WOTF))
  {
    if(SWIM_Write_Data(size))
    {
      if(SWIM_Write_Data((addr >> 16) & 0xFF))
      {
        if(SWIM_Write_Data((addr >> 8) & 0xFF))
        {
          if(SWIM_Write_Data((addr >> 0) & 0xFF))
          {
            while(size--)
            {
              if(!SWIM_Write_Data(*buf++))
              {
                return 0;
              }
            }
            return 1;
          }
        }
      }
    }
  }
  
  return 0;
}


uint8_t SWIM_WOTF_All(uint32_t addr, uint8_t *buf, uint8_t size) 
{
  
  if (!buf || !size) {
    return 0;
  }
  
  SWIM_PIN_Mask = SWIM_Devices;
  
  if(SWIM_Write_Cammand(SWIM_CMD_WOTF))
  {
    if(SWIM_Write_Data(size))
    {
      if(SWIM_Write_Data((addr >> 16) & 0xFF))
      {
        if(SWIM_Write_Data((addr >> 8) & 0xFF))
        {
          if(SWIM_Write_Data((addr >> 0) & 0xFF))
          {
            while(size--)
            {
              if(!SWIM_Write_Data(*buf++))
              {
                return 0;
              }
            }
            return 1;
          }
        }
      }
    }
  }
  
  return 0;
}


uint8_t SWIM_ROTF(uint8_t swim_pin, uint32_t addr, uint8_t *buf, uint8_t size) 
{
  uint8_t timeout = 255;
  uint8_t start_bit = 0;
  uint8_t parity = 0;
  uint8_t parity_bit = 0;
  uint8_t rx_data = 0;  
  
  SWIM_PIN_Mask = swim_pin;
  
  if (!buf || !size) {
    return 0;
  }
  
  if(SWIM_Write_Cammand(SWIM_CMD_ROTF))
  {
    if(SWIM_Write_Data(size))
    {
      if(SWIM_Write_Data((addr >> 16) & 0xFF))
      {
        if(SWIM_Write_Data((addr >> 8) & 0xFF))
        {
          if(SWIM_Write_Data((addr >> 0) & 0xFF))
          {
            
            delay_us(50); //dicard first frame
            SWIM_Write_Parity_Ack_Bit(0);//send nack
            
            while(size) 
            {
              
              while(INT_Count<10 && --timeout);
              INT_Count = 0;
              if(timeout)
              {
                timeout = 255;
                start_bit = RX_Frame[0];
                parity_bit = RX_Frame[9]?1:0;
                
                /*
                for(uint8_t i=1; i<=8; i++)
                {
                if(RX_Frame[i])
                {
                rx_data |= 1 << (8-i);
                parity++;
              }
              }
                */
                
                //unroll for loop for faster execution
                rx_data  = RX_Frame[1]<<7;
                rx_data |= RX_Frame[2]<<6;
                rx_data |= RX_Frame[3]<<5;
                rx_data |= RX_Frame[4]<<4;
                rx_data |= RX_Frame[5]<<3;
                rx_data |= RX_Frame[6]<<2;
                rx_data |= RX_Frame[7]<<1;
                rx_data |= RX_Frame[8]<<0;
                
                //unroll for loop for faster execution
                parity  = RX_Frame[1];
                parity += RX_Frame[2];
                parity += RX_Frame[3];
                parity += RX_Frame[4];
                parity += RX_Frame[5];
                parity += RX_Frame[6];
                parity += RX_Frame[7];
                parity += RX_Frame[8];
                parity &= 0x01;// XOR of all frame bits
                
                if(parity == parity_bit && start_bit)
                {
                  *buf++ = rx_data;
                  size--;
                  SWIM_PIN_OUT();
                  SWIM_Write_Parity_Ack_Bit(1);//send ack
                }
                else
                {
                  break;
                }
              }
              else
              {
                break;
              }
              
            }
          }
        }
      } 
    }
  }
  
  SWIM_PIN_OUT();
  if(!size)
  {
    return 1;
  }
  
  return 0; 
}


uint8_t SWIM_Soft_Reset(uint8_t swim_pin)
{
  SWIM_PIN_Mask = swim_pin;
  return SWIM_Write_Cammand(SWIM_CMD_SRST);
}

uint8_t SWIM_Soft_Reset_All(void)
{
  SWIM_PIN_Mask = SWIM_Devices;
  return SWIM_Write_Cammand(SWIM_CMD_SRST);
}

uint8_t SWIM_Reset_Devices(void)
{
  uint8_t temp[1]={0xA4};
  if(SWIM_WOTF_All(SWIM_CSR, temp, 1))
  {
    SWIM_Soft_Reset_All();
    NRST_Low();
    delay_ms(2);
    NRST_High();
    return 1;
  }
  return 0;
}

uint8_t Get_SWIM_Devices(void)
{
  return SWIM_Devices;
}

