   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  53                     ; 54 void main(void)
  53                     ; 55 {
  55                     .text:	section	.text,new
  56  0000               _main:
  60                     ; 56   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
  62  0000 4f            	clr	a
  63  0001 cd0000        	call	_CLK_HSIPrescalerConfig
  65                     ; 58   GPIO_Init(SWIM_OUT_PORT, SWIM_OUT, GPIO_MODE_OUT_OD_HIZ_FAST); //pwm
  67  0004 4bb0          	push	#176
  68  0006 4b10          	push	#16
  69  0008 ae500f        	ldw	x,#20495
  70  000b cd0000        	call	_GPIO_Init
  72  000e 85            	popw	x
  73                     ; 60   TIM2_GenerateEvent(TIM2_EVENTSOURCE_CC1);
  75  000f a602          	ld	a,#2
  76  0011 cd0000        	call	_TIM2_GenerateEvent
  78                     ; 62   TIM2_TimeBaseInit(TIM2_PRESCALER_1, 43);  //(16Mhz/22*2) swim period
  80  0014 ae002b        	ldw	x,#43
  81  0017 89            	pushw	x
  82  0018 4f            	clr	a
  83  0019 cd0000        	call	_TIM2_TimeBaseInit
  85  001c 85            	popw	x
  86                     ; 66   TIM2_OC1Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE,0, TIM2_OCPOLARITY_LOW ); 
  88  001d 4b22          	push	#34
  89  001f 5f            	clrw	x
  90  0020 89            	pushw	x
  91  0021 ae6011        	ldw	x,#24593
  92  0024 cd0000        	call	_TIM2_OC1Init
  94  0027 5b03          	addw	sp,#3
  95                     ; 67   TIM2_OC1PreloadConfig(ENABLE);
  97  0029 a601          	ld	a,#1
  98  002b cd0000        	call	_TIM2_OC1PreloadConfig
 100                     ; 70   TIM2_ARRPreloadConfig(ENABLE);
 102  002e a601          	ld	a,#1
 103  0030 cd0000        	call	_TIM2_ARRPreloadConfig
 105                     ; 71   TIM2_Cmd(ENABLE);
 107  0033 a601          	ld	a,#1
 108  0035 cd0000        	call	_TIM2_Cmd
 110                     ; 76    TIM2->CCR1L = (uint8_t)(4);
 112  0038 35045312      	mov	21266,#4
 114  003c               L52:
 115                     ; 77    while(!(TIM2->SR1 & (uint8_t)TIM2_FLAG_CC1));
 117  003c c65304        	ld	a,21252
 118  003f a502          	bcp	a,#2
 119  0041 27f9          	jreq	L52
 120                     ; 78    TIM2->CCR1L = (uint8_t)(40);
 122  0043 35285312      	mov	21266,#40
 124  0047               L53:
 125                     ; 79    while(!(TIM2->SR1 & (uint8_t)TIM2_FLAG_CC1));
 127  0047 c65304        	ld	a,21252
 128  004a a502          	bcp	a,#2
 129  004c 27f9          	jreq	L53
 130                     ; 80    TIM2->CCR1L = (uint8_t)(4);
 132  004e 35045312      	mov	21266,#4
 134  0052               L54:
 135                     ; 81    while(!(TIM2->SR1 & (uint8_t)TIM2_FLAG_CC1));
 137  0052 c65304        	ld	a,21252
 138  0055 a502          	bcp	a,#2
 139  0057 27f9          	jreq	L54
 140                     ; 82    TIM2->CCR1L = (uint8_t)(0);
 142  0059 725f5312      	clr	21266
 143  005d               L15:
 145  005d 20fe          	jra	L15
 180                     ; 103 void assert_failed(u8* file, u32 line)
 180                     ; 104 { 
 181                     .text:	section	.text,new
 182  0000               _assert_failed:
 186  0000               L37:
 187  0000 20fe          	jra	L37
 200                     	xdef	_main
 201                     	xdef	_assert_failed
 202                     	xref	_TIM2_GenerateEvent
 203                     	xref	_TIM2_OC1PreloadConfig
 204                     	xref	_TIM2_ARRPreloadConfig
 205                     	xref	_TIM2_Cmd
 206                     	xref	_TIM2_OC1Init
 207                     	xref	_TIM2_TimeBaseInit
 208                     	xref	_GPIO_Init
 209                     	xref	_CLK_HSIPrescalerConfig
 228                     	end
