#include "stm8_swim.h"
#include "stm8s_it.h"
#include "millis.h"

/**********************Device Independent File************************/
/**********************Device Independent File************************/
/**********************Device Independent File************************/
/**********************Device Independent File************************/
/**********************Device Independent File************************/

#define SWIM_PIN_PORT GPIOD
#define SWIM_PIN_EXTI_PORT EXTI_PORT_GPIOD
#define SWIM_PIN GPIO_PIN_2

#define NRST_PIN GPIO_PIN_3
#define NRST_PIN_PORT GPIOC

#define NRST_PIN_HIGH() (NRST_PIN_PORT->ODR |= (uint8_t)NRST_PIN)
#define NRST_PIN_LOW() (NRST_PIN_PORT->ODR &= (uint8_t)~NRST_PIN)

#define SWIM_PIN_OUT()                      \
  SWIM_PIN_PORT->ODR |= (uint8_t)SWIM_PIN;  \
  SWIM_PIN_PORT->CR1 &= (uint8_t)~SWIM_PIN; \
  SWIM_PIN_PORT->DDR |= (uint8_t)SWIM_PIN

#define SWIM_PIN_IN_INT()                   \
  SWIM_PIN_PORT->DDR &= (uint8_t)~SWIM_PIN; \
  SWIM_PIN_PORT->CR1 |= (uint8_t)SWIM_PIN;  \
  SWIM_PIN_PORT->CR2 |= (uint8_t)SWIM_PIN

#define SWIM_PIN_HIGH() (SWIM_PIN_PORT->ODR |= (uint8_t)SWIM_PIN)
#define SWIM_PIN_LOW() (SWIM_PIN_PORT->ODR &= (uint8_t)~SWIM_PIN)
#define SWIM_PIN_READ() (uint8_t)(SWIM_PIN_PORT->IDR & SWIM_PIN)

#define SWIM_DELAY_1_BIT() \
  nop();                   \
  nop()

#define SWIM_DELAY_0_BIT() \
  SWIM_DELAY_1_BIT();      \
  SWIM_DELAY_1_BIT();      \
  SWIM_DELAY_1_BIT();      \
  SWIM_DELAY_1_BIT();      \
  SWIM_DELAY_1_BIT();      \
  SWIM_DELAY_1_BIT();      \
  SWIM_DELAY_1_BIT();      \
  SWIM_DELAY_1_BIT();      \
  SWIM_DELAY_1_BIT();      \
  SWIM_DELAY_1_BIT();      \
  SWIM_DELAY_1_BIT();      \
  SWIM_DELAY_1_BIT();      \
  SWIM_DELAY_1_BIT();      \
  SWIM_DELAY_1_BIT();      \
  SWIM_DELAY_1_BIT();      \
  SWIM_DELAY_1_BIT();      \
  SWIM_DELAY_1_BIT();      \
  SWIM_DELAY_1_BIT()

//inline did not work
//function call overhead causing timing issues
#define SWIM_Write_Bit(bit) \
  {                         \
    if (bit)                \
    {                       \
      SWIM_PIN_LOW();       \
      SWIM_DELAY_1_BIT();   \
      SWIM_PIN_HIGH();      \
      SWIM_DELAY_0_BIT();   \
    }                       \
    else                    \
    {                       \
      SWIM_PIN_LOW();       \
      SWIM_DELAY_0_BIT();   \
      SWIM_PIN_HIGH();      \
      SWIM_DELAY_1_BIT();   \
    }                       \
  }

//parity or ack bit
#define SWIM_Write_Parity_Ack_Bit(bit) \
  {                                    \
    if (bit)                           \
    {                                  \
      SWIM_PIN_LOW();                  \
      SWIM_DELAY_1_BIT();              \
      SWIM_PIN_IN_INT();               \
    }                                  \
    else                               \
    {                                  \
      SWIM_PIN_LOW();                  \
      SWIM_DELAY_0_BIT();              \
      SWIM_PIN_IN_INT();               \
    }                                  \
  }

uint8_t INT_Count = 0;
uint8_t RX_Frame[15] = {0};

INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
{
  RX_Frame[INT_Count++] = SWIM_PIN_READ();
}

static uint8_t Wait_For_Int(uint8_t count, uint16_t timeout)
{
  while (count != INT_Count && --timeout)
  {
    delay_us(1);
  }
  INT_Count = 0;

  if (timeout)
  {
    return 1;
  }
  return 0;
}

void SWIM_Setup(void)
{
  CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);

  /* Initialise all SWIM pins to open drain out, for now dont enable interrupts*/
  GPIO_Init(SWIM_PIN_PORT, (GPIO_Pin_TypeDef)SWIM_PIN, GPIO_MODE_OUT_OD_HIZ_SLOW);

  /* Interrupts on falling edge*/
  EXTI_SetExtIntSensitivity(SWIM_PIN_EXTI_PORT, EXTI_SENSITIVITY_FALL_ONLY);

  GPIO_Init(NRST_PIN_PORT, NRST_PIN, GPIO_MODE_OUT_OD_HIZ_SLOW);

  enableInterrupts();
}

uint8_t SWIM_Enter()
{
  uint8_t temp;

  SWIM_Reset_Device();

  NRST_PIN_LOW();
  delay_ms(1);

  /*1. To make the SWIM active, the SWIM pin must be forced low during a period of 16 �s.*/
  SWIM_PIN_LOW();
  delay_ms(1);

  /*2. Four pulses at 1 kHz followed by four pulses at 2 kHz*/
  for (uint8_t i = 0; i < 4; i++)
  {
    SWIM_PIN_HIGH();
    delay_us(500);
    SWIM_PIN_LOW();
    delay_us(500);
  }
  for (uint8_t i = 0; i < 4; i++)
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

  temp = Wait_For_Int(1, 1000);

  SWIM_PIN_OUT();

  if (!temp)
  {
    NRST_PIN_HIGH();
    return 0;
  }

  /*5. SWIM line must be released at 1 to guarantee that the SWIM is ready for communication (at least 300 ns).*/
  delay_ms(1);

  /*6. Write 0xA0h in the SWIM_CSR:*/
  temp = 0xA0;
  if (!SWIM_WOTF(SWIM_CSR, &temp, 1))
  {
    NRST_PIN_HIGH();
    return 0;
  }

  /*6. Release the reset which starts the option byte loading sequence. Wait 1 ms for
  stabilization*/
  delay_us(500);
  NRST_PIN_HIGH();
  delay_ms(20); /*as seen on logic analyzer*/

  /*Sync Pulse, as seen on logic analyzer*/
  SWIM_PIN_LOW();
  delay_us(20);
  SWIM_PIN_HIGH();

  delay_us(500);

  /*6. Stall CPU*/
  if (!SWIM_Stall_CPU())
  {
    return 0;
  }

  return 1;
}

uint8_t SWIM_Write_Cammand(uint8_t cammand)
{
  uint8_t temp;
  uint8_t data_frame[3] = "0";
  uint8_t calc_parity = 0;

  data_frame[2] = (uint8_t)(cammand >> 2 & 0x01);
  data_frame[1] = (uint8_t)(cammand >> 1 & 0x01);
  data_frame[0] = (uint8_t)(cammand >> 0 & 0x01);

  for (uint8_t i = 0; i < 3; i++)
  {
    calc_parity += data_frame[i];
  }
  calc_parity &= 0x01;

  SWIM_PIN_OUT();

  SWIM_Write_Bit(0); // start bit
  SWIM_Write_Bit(data_frame[2]);
  SWIM_Write_Bit(data_frame[1]);
  SWIM_Write_Bit(data_frame[0]);
  SWIM_Write_Parity_Ack_Bit(calc_parity);

  temp = Wait_For_Int(1, 255);

  SWIM_PIN_OUT();
  if (temp)
  {
    if (SWIM_PIN & RX_Frame[0])
    {
      return 1;
    }
  }
  return 0;
}

uint8_t SWIM_Write_Data(uint8_t data)
{
  uint8_t temp;
  uint8_t data_frame[8];
  uint8_t calc_parity = 0;

  //unroll for loop for faster execution
  data_frame[7] = (uint8_t)(data >> 7 & 0x01);
  data_frame[6] = (uint8_t)(data >> 6 & 0x01);
  data_frame[5] = (uint8_t)(data >> 5 & 0x01);
  data_frame[4] = (uint8_t)(data >> 4 & 0x01);
  data_frame[3] = (uint8_t)(data >> 3 & 0x01);
  data_frame[2] = (uint8_t)(data >> 2 & 0x01);
  data_frame[1] = (uint8_t)(data >> 1 & 0x01);
  data_frame[0] = (uint8_t)(data >> 0 & 0x01);

  //unroll for loop for faster execution
  calc_parity = data_frame[7];
  calc_parity += data_frame[6];
  calc_parity += data_frame[5];
  calc_parity += data_frame[4];
  calc_parity += data_frame[3];
  calc_parity += data_frame[2];
  calc_parity += data_frame[1];
  calc_parity += data_frame[0];

  calc_parity &= 0x01; // XOR of all frame bits

  SWIM_PIN_OUT();
  SWIM_Write_Bit(0); // start bit
  SWIM_Write_Bit(data_frame[7]);
  SWIM_Write_Bit(data_frame[6]);
  SWIM_Write_Bit(data_frame[5]);
  SWIM_Write_Bit(data_frame[4]);
  SWIM_Write_Bit(data_frame[3]);
  SWIM_Write_Bit(data_frame[2]);
  SWIM_Write_Bit(data_frame[1]);
  SWIM_Write_Bit(data_frame[0]);
  SWIM_Write_Parity_Ack_Bit(calc_parity);

  temp = Wait_For_Int(1, 255);

  SWIM_PIN_OUT();

  if (temp)
  {
    if (SWIM_PIN & RX_Frame[0])
    {
      return 1;
    }
  }
  return 0;
}

void SWIM_Write_Data2(uint8_t data)
{

  uint8_t data_frame[8];
  uint8_t calc_parity = 0;

  //unroll for loop for faster execution
  data_frame[7] = (uint8_t)(data >> 7 & 0x01);
  data_frame[6] = (uint8_t)(data >> 6 & 0x01);
  data_frame[5] = (uint8_t)(data >> 5 & 0x01);
  data_frame[4] = (uint8_t)(data >> 4 & 0x01);
  data_frame[3] = (uint8_t)(data >> 3 & 0x01);
  data_frame[2] = (uint8_t)(data >> 2 & 0x01);
  data_frame[1] = (uint8_t)(data >> 1 & 0x01);
  data_frame[0] = (uint8_t)(data >> 0 & 0x01);

  //unroll for loop for faster execution
  calc_parity = data_frame[7];
  calc_parity += data_frame[6];
  calc_parity += data_frame[5];
  calc_parity += data_frame[4];
  calc_parity += data_frame[3];
  calc_parity += data_frame[2];
  calc_parity += data_frame[1];
  calc_parity += data_frame[0];

  calc_parity &= 0x01; // XOR of all frame bits

  SWIM_PIN_OUT();
  SWIM_Write_Bit(0); // start bit
  SWIM_Write_Bit(data_frame[7]);
  SWIM_Write_Bit(data_frame[6]);
  SWIM_Write_Bit(data_frame[5]);
  SWIM_Write_Bit(data_frame[4]);
  SWIM_Write_Bit(data_frame[3]);
  SWIM_Write_Bit(data_frame[2]);
  SWIM_Write_Bit(data_frame[1]);
  SWIM_Write_Bit(data_frame[0]);
  SWIM_Write_Parity_Ack_Bit(calc_parity);
}

uint8_t SWIM_WOTF(uint32_t addr, uint8_t *buf, uint8_t size)
{

  if (!buf || !size)
  {
    return 0;
  }

  if (SWIM_Write_Cammand(SWIM_CMD_WOTF))
  {
    if (SWIM_Write_Data(size))
    {
      if (SWIM_Write_Data((uint8_t)((addr >> 16) & 0xFF)))
      {
        if (SWIM_Write_Data((uint8_t)((addr >> 8) & 0xFF)))
        {
          if (SWIM_Write_Data((uint8_t)((addr >> 0) & 0xFF)))
          {
            while (size--)
            {
              if (!SWIM_Write_Data(*buf++))
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

uint8_t SWIM_ROTF(uint32_t addr, uint8_t *buf, uint8_t size)
{
  uint8_t temp;
  uint8_t start_bit = 0;
  uint8_t calc_parity = 0;
  uint8_t recvd_parity = 0;
  uint8_t rx_data = 0;

  if (!buf || !size)
  {
    return 0;
  }

  if (SWIM_Write_Cammand(SWIM_CMD_ROTF))
  {
    if (SWIM_Write_Data(size))
    {
      if (SWIM_Write_Data((uint8_t)((addr >> 16) & 0xFF)))
      {
        if (SWIM_Write_Data((uint8_t)((addr >> 8) & 0xFF)))
        {
          SWIM_Write_Data2((uint8_t)((addr >> 0) & 0xFF));

          /*  first byte capture, first bit is ACK of SWIM_Write_Data2*/
          temp = Wait_For_Int(11, 255);

          if (temp)
          {
            for (uint8_t i = 2; i <= 9; i++)
            {
              if (RX_Frame[i])
              {
                rx_data |= (uint8_t)(1 << (9 - i));
                calc_parity++;
              }
            }
          }
          /*  first byte capture*/

          calc_parity &= 0x01; // XOR of all frame bits
          start_bit = RX_Frame[1];
          recvd_parity = (uint8_t)(RX_Frame[10] ? 1 : 0);

          if (calc_parity == recvd_parity && start_bit && RX_Frame[0])
          {
            *buf++ = rx_data;
            size--;
            SWIM_PIN_OUT();
            SWIM_Write_Parity_Ack_Bit(1); //send ack

            while (size)
            {

              temp = Wait_For_Int(10, 255);

              if (temp)
              {
                start_bit = RX_Frame[0];
                recvd_parity = (uint8_t)(RX_Frame[9] ? 1 : 0);

                /*
                  for(uint8_t i=1; i<=8; i++)
                  {
                  if(RX_Frame[i])
                  {
                  rx_data |= 1 << (8-i);
                  calc_parity++;
                }
                }
                  */

                //unroll for loop for faster execution
                if (RX_Frame[1])
                {
                  rx_data = 1 << (7);
                  calc_parity++;
                }
                if (RX_Frame[2])
                {
                  rx_data |= 1 << (6);
                  calc_parity++;
                }
                if (RX_Frame[3])
                {
                  rx_data |= 1 << (5);
                  calc_parity++;
                }
                if (RX_Frame[4])
                {
                  rx_data |= 1 << (4);
                  calc_parity++;
                }
                if (RX_Frame[5])
                {
                  rx_data |= 1 << (3);
                  calc_parity++;
                }
                if (RX_Frame[6])
                {
                  rx_data |= 1 << (2);
                  calc_parity++;
                }
                if (RX_Frame[7])
                {
                  rx_data |= 1 << (1);
                  calc_parity++;
                }
                if (RX_Frame[8])
                {
                  rx_data |= 1 << (0);
                  calc_parity++;
                }

                calc_parity &= 0x01; // XOR of all frame bits

                if (calc_parity == recvd_parity && start_bit)
                {
                  *buf++ = rx_data;
                  rx_data = 0; //reset
                  calc_parity = 0;
                  size--;
                  SWIM_PIN_OUT();
                  SWIM_Write_Parity_Ack_Bit(1); //send ack
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

  if (!size)
  {
    return 1;
  }

  return 0;
}

uint8_t SWIM_Soft_Reset()
{
  return SWIM_Write_Cammand(SWIM_CMD_SRST);
}

uint8_t SWIM_Reset_Device()
{
  uint8_t temp[1] = {0xA4};
  if (SWIM_WOTF(SWIM_CSR, temp, 1))
  {
    SWIM_Soft_Reset();
    NRST_PIN_LOW();
    delay_ms(2);
    NRST_PIN_HIGH();
    return 1;
  }
  return 0;
}

uint8_t SWIM_Stall_CPU()
{
  uint8_t temp[1];
  temp[0] = 0x08;
  return SWIM_WOTF(SWIM_DM_CSR2, temp, 1); //stall the cpu
}