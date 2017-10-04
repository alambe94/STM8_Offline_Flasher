   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  46                     ; 47 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  46                     ; 48 {
  47                     .text:	section	.text,new
  48  0000               f_NonHandledInterrupt:
  52                     ; 52 }
  55  0000 80            	iret
  77                     ; 60 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  77                     ; 61 {
  78                     .text:	section	.text,new
  79  0000               f_TRAP_IRQHandler:
  83                     ; 65 }
  86  0000 80            	iret
 108                     ; 72 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 108                     ; 73 
 108                     ; 74 {
 109                     .text:	section	.text,new
 110  0000               f_TLI_IRQHandler:
 114                     ; 78 }
 117  0000 80            	iret
 139                     ; 85 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 139                     ; 86 {
 140                     .text:	section	.text,new
 141  0000               f_AWU_IRQHandler:
 145                     ; 90 }
 148  0000 80            	iret
 170                     ; 97 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 170                     ; 98 {
 171                     .text:	section	.text,new
 172  0000               f_CLK_IRQHandler:
 176                     ; 102 }
 179  0000 80            	iret
 202                     ; 109 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 202                     ; 110 {
 203                     .text:	section	.text,new
 204  0000               f_EXTI_PORTA_IRQHandler:
 208                     ; 114 }
 211  0000 80            	iret
 234                     ; 121 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 234                     ; 122 {
 235                     .text:	section	.text,new
 236  0000               f_EXTI_PORTB_IRQHandler:
 240                     ; 126 }
 243  0000 80            	iret
 266                     ; 133 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 266                     ; 134 {
 267                     .text:	section	.text,new
 268  0000               f_EXTI_PORTC_IRQHandler:
 272                     ; 138 }
 275  0000 80            	iret
 298                     ; 145 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 298                     ; 146 {
 299                     .text:	section	.text,new
 300  0000               f_EXTI_PORTD_IRQHandler:
 304                     ; 150 }
 307  0000 80            	iret
 330                     ; 157 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 330                     ; 158 {
 331                     .text:	section	.text,new
 332  0000               f_EXTI_PORTE_IRQHandler:
 336                     ; 162 }
 339  0000 80            	iret
 361                     ; 209 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 361                     ; 210 {
 362                     .text:	section	.text,new
 363  0000               f_SPI_IRQHandler:
 367                     ; 214 }
 370  0000 80            	iret
 393                     ; 221 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 393                     ; 222 {
 394                     .text:	section	.text,new
 395  0000               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 399                     ; 226 }
 402  0000 80            	iret
 425                     ; 233 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 425                     ; 234 {
 426                     .text:	section	.text,new
 427  0000               f_TIM1_CAP_COM_IRQHandler:
 431                     ; 238 }
 434  0000 80            	iret
 457                     ; 271  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 457                     ; 272  {
 458                     .text:	section	.text,new
 459  0000               f_TIM2_UPD_OVF_BRK_IRQHandler:
 463                     ; 276  }
 466  0000 80            	iret
 489                     ; 283  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 489                     ; 284  {
 490                     .text:	section	.text,new
 491  0000               f_TIM2_CAP_COM_IRQHandler:
 495                     ; 288  }
 498  0000 80            	iret
 521                     ; 325  INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 521                     ; 326  {
 522                     .text:	section	.text,new
 523  0000               f_UART1_TX_IRQHandler:
 527                     ; 330  }
 530  0000 80            	iret
 553                     ; 337  INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 553                     ; 338  {
 554                     .text:	section	.text,new
 555  0000               f_UART1_RX_IRQHandler:
 559                     ; 342  }
 562  0000 80            	iret
 584                     ; 350 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 584                     ; 351 {
 585                     .text:	section	.text,new
 586  0000               f_I2C_IRQHandler:
 590                     ; 355 }
 593  0000 80            	iret
 615                     ; 429  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
 615                     ; 430  {
 616                     .text:	section	.text,new
 617  0000               f_ADC1_IRQHandler:
 621                     ; 434  }
 624  0000 80            	iret
 647                     ; 468 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 647                     ; 469 {
 648                     .text:	section	.text,new
 649  0000               f_EEPROM_EEC_IRQHandler:
 653                     ; 473 }
 656  0000 80            	iret
 668                     	xdef	f_EEPROM_EEC_IRQHandler
 669                     	xdef	f_ADC1_IRQHandler
 670                     	xdef	f_I2C_IRQHandler
 671                     	xdef	f_UART1_RX_IRQHandler
 672                     	xdef	f_UART1_TX_IRQHandler
 673                     	xdef	f_TIM2_CAP_COM_IRQHandler
 674                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
 675                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
 676                     	xdef	f_TIM1_CAP_COM_IRQHandler
 677                     	xdef	f_SPI_IRQHandler
 678                     	xdef	f_EXTI_PORTE_IRQHandler
 679                     	xdef	f_EXTI_PORTD_IRQHandler
 680                     	xdef	f_EXTI_PORTC_IRQHandler
 681                     	xdef	f_EXTI_PORTB_IRQHandler
 682                     	xdef	f_EXTI_PORTA_IRQHandler
 683                     	xdef	f_CLK_IRQHandler
 684                     	xdef	f_AWU_IRQHandler
 685                     	xdef	f_TLI_IRQHandler
 686                     	xdef	f_TRAP_IRQHandler
 687                     	xdef	f_NonHandledInterrupt
 706                     	end
