   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  17                     	bsct
  18  0000               _current_millis:
  19  0000 00000000      	dc.l	0
  55                     ; 11 void Millis_Init(void)
  55                     ; 12 {
  57                     .text:	section	.text,new
  58  0000               _Millis_Init:
  62                     ; 13 	TIM4_DeInit();
  64  0000 cd0000        	call	_TIM4_DeInit
  66                     ; 15         CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1); //f_master = HSI = 16Mhz
  68  0003 4f            	clr	a
  69  0004 cd0000        	call	_CLK_HSIPrescalerConfig
  71                     ; 17 	TIM4_TimeBaseInit(TIM4_PRESCALER_128, TIM4_PERIOD);
  73  0007 ae077d        	ldw	x,#1917
  74  000a cd0000        	call	_TIM4_TimeBaseInit
  76                     ; 19 	TIM4_ClearFlag(TIM4_FLAG_UPDATE);
  78  000d a601          	ld	a,#1
  79  000f cd0000        	call	_TIM4_ClearFlag
  81                     ; 21         TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
  83  0012 ae0101        	ldw	x,#257
  84  0015 cd0000        	call	_TIM4_ITConfig
  86                     ; 23 	enableInterrupts();
  89  0018 9a            rim
  91                     ; 25 	TIM4_Cmd(ENABLE);
  94  0019 a601          	ld	a,#1
  95  001b cd0000        	call	_TIM4_Cmd
  97                     ; 26 }
 100  001e 81            	ret
 124                     ; 30 uint32_t millis(void)
 124                     ; 31 
 124                     ; 32 {
 125                     .text:	section	.text,new
 126  0000               _millis:
 130                     ; 33 	return current_millis;
 132  0000 ae0000        	ldw	x,#_current_millis
 133  0003 cd0000        	call	c_ltor
 137  0006 81            	ret
 181                     ; 36 void delay_ms(uint32_t time)
 181                     ; 37 {
 182                     .text:	section	.text,new
 183  0000               _delay_ms:
 185  0000 5204          	subw	sp,#4
 186       00000004      OFST:	set	4
 189                     ; 39 	temp =millis();
 191  0002 cd0000        	call	_millis
 193  0005 96            	ldw	x,sp
 194  0006 1c0001        	addw	x,#OFST-3
 195  0009 cd0000        	call	c_rtol
 198  000c               L75:
 199                     ; 40 	while(millis()-temp<time);
 201  000c cd0000        	call	_millis
 203  000f 96            	ldw	x,sp
 204  0010 1c0001        	addw	x,#OFST-3
 205  0013 cd0000        	call	c_lsub
 207  0016 96            	ldw	x,sp
 208  0017 1c0007        	addw	x,#OFST+3
 209  001a cd0000        	call	c_lcmp
 211  001d 25ed          	jrult	L75
 212                     ; 42 }
 215  001f 5b04          	addw	sp,#4
 216  0021 81            	ret
 242                     ; 48 INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23) 
 242                     ; 49 
 242                     ; 50 {   
 244                     .text:	section	.text,new
 245  0000               f_TIM4_UPD_OVF_IRQHandler:
 247  0000 8a            	push	cc
 248  0001 84            	pop	a
 249  0002 a4bf          	and	a,#191
 250  0004 88            	push	a
 251  0005 86            	pop	cc
 252  0006 3b0002        	push	c_x+2
 253  0009 be00          	ldw	x,c_x
 254  000b 89            	pushw	x
 255  000c 3b0002        	push	c_y+2
 256  000f be00          	ldw	x,c_y
 257  0011 89            	pushw	x
 260                     ; 52 	current_millis ++;
 262  0012 ae0000        	ldw	x,#_current_millis
 263  0015 a601          	ld	a,#1
 264  0017 cd0000        	call	c_lgadc
 266                     ; 53 	TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
 268  001a a601          	ld	a,#1
 269  001c cd0000        	call	_TIM4_ClearITPendingBit
 271                     ; 54 }
 274  001f 85            	popw	x
 275  0020 bf00          	ldw	c_y,x
 276  0022 320002        	pop	c_y+2
 277  0025 85            	popw	x
 278  0026 bf00          	ldw	c_x,x
 279  0028 320002        	pop	c_x+2
 280  002b 80            	iret
 303                     	xdef	f_TIM4_UPD_OVF_IRQHandler
 304                     	xdef	_current_millis
 305                     	xdef	_millis
 306                     	xdef	_delay_ms
 307                     	xdef	_Millis_Init
 308                     	xref	_TIM4_ClearITPendingBit
 309                     	xref	_TIM4_ClearFlag
 310                     	xref	_TIM4_ITConfig
 311                     	xref	_TIM4_Cmd
 312                     	xref	_TIM4_TimeBaseInit
 313                     	xref	_TIM4_DeInit
 314                     	xref	_CLK_HSIPrescalerConfig
 315                     	xref.b	c_x
 316                     	xref.b	c_y
 335                     	xref	c_lgadc
 336                     	xref	c_lcmp
 337                     	xref	c_lsub
 338                     	xref	c_rtol
 339                     	xref	c_ltor
 340                     	end
