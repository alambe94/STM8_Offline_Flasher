   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.12 - 20 Jun 2018
   3                     ; Generator (Limited) V4.4.8 - 20 Jun 2018
   4                     ; Optimizer V4.4.8 - 20 Jun 2018
 117                     ; 47 void GPIO_DeInit(GPIO_TypeDef* GPIOx)
 117                     ; 48 {
 119                     .text:	section	.text,new
 120  0000               _GPIO_DeInit:
 124                     ; 49     GPIOx->ODR = GPIO_ODR_RESET_VALUE; /* Reset Output Data Register */
 126  0000 7f            	clr	(x)
 127                     ; 50     GPIOx->DDR = GPIO_DDR_RESET_VALUE; /* Reset Data Direction Register */
 129  0001 6f02          	clr	(2,x)
 130                     ; 51     GPIOx->CR1 = GPIO_CR1_RESET_VALUE; /* Reset Control Register 1 */
 132  0003 6f03          	clr	(3,x)
 133                     ; 52     GPIOx->CR2 = GPIO_CR2_RESET_VALUE; /* Reset Control Register 2 */
 135  0005 6f04          	clr	(4,x)
 136                     ; 53 }
 139  0007 81            	ret	
 380                     ; 65 void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, GPIO_Mode_TypeDef GPIO_Mode)
 380                     ; 66 {
 381                     .text:	section	.text,new
 382  0000               _GPIO_Init:
 384  0000 89            	pushw	x
 385       00000000      OFST:	set	0
 388                     ; 71     assert_param(IS_GPIO_MODE_OK(GPIO_Mode));
 390  0001 1e07          	ldw	x,(OFST+7,sp)
 391  0003 2745          	jreq	L41
 392  0005 a30040        	cpw	x,#64
 393  0008 2740          	jreq	L41
 394  000a a30020        	cpw	x,#32
 395  000d 273b          	jreq	L41
 396  000f a30060        	cpw	x,#96
 397  0012 2736          	jreq	L41
 398  0014 a300a0        	cpw	x,#160
 399  0017 2731          	jreq	L41
 400  0019 a300e0        	cpw	x,#224
 401  001c 272c          	jreq	L41
 402  001e a30080        	cpw	x,#128
 403  0021 2727          	jreq	L41
 404  0023 a300c0        	cpw	x,#192
 405  0026 2722          	jreq	L41
 406  0028 a300b0        	cpw	x,#176
 407  002b 271d          	jreq	L41
 408  002d a300f0        	cpw	x,#240
 409  0030 2718          	jreq	L41
 410  0032 a30090        	cpw	x,#144
 411  0035 2713          	jreq	L41
 412  0037 a300d0        	cpw	x,#208
 413  003a 270e          	jreq	L41
 414  003c ae0047        	ldw	x,#71
 415  003f 89            	pushw	x
 416  0040 5f            	clrw	x
 417  0041 89            	pushw	x
 418  0042 ae0000        	ldw	x,#L771
 419  0045 cd0000        	call	_assert_failed
 421  0048 5b04          	addw	sp,#4
 422  004a               L41:
 423                     ; 72     assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 425  004a 1e05          	ldw	x,(OFST+5,sp)
 426  004c 260e          	jrne	L22
 427  004e ae0048        	ldw	x,#72
 428  0051 89            	pushw	x
 429  0052 5f            	clrw	x
 430  0053 89            	pushw	x
 431  0054 ae0000        	ldw	x,#L771
 432  0057 cd0000        	call	_assert_failed
 434  005a 5b04          	addw	sp,#4
 435  005c               L22:
 436                     ; 75   GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 438  005c 1e01          	ldw	x,(OFST+1,sp)
 439  005e 7b06          	ld	a,(OFST+6,sp)
 440  0060 43            	cpl	a
 441  0061 e404          	and	a,(4,x)
 442  0063 e704          	ld	(4,x),a
 443                     ; 81     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x80) != (uint8_t)0x00) /* Output mode */
 445  0065 7b08          	ld	a,(OFST+8,sp)
 446  0067 2a14          	jrpl	L102
 447                     ; 83         if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x10) != (uint8_t)0x00) /* High level */
 449  0069 a510          	bcp	a,#16
 450  006b 2705          	jreq	L302
 451                     ; 85             GPIOx->ODR |= (uint8_t)GPIO_Pin;
 453  006d f6            	ld	a,(x)
 454  006e 1a06          	or	a,(OFST+6,sp)
 456  0070 2004          	jra	L502
 457  0072               L302:
 458                     ; 89             GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
 460  0072 7b06          	ld	a,(OFST+6,sp)
 461  0074 43            	cpl	a
 462  0075 f4            	and	a,(x)
 463  0076               L502:
 464  0076 f7            	ld	(x),a
 465                     ; 92         GPIOx->DDR |= (uint8_t)GPIO_Pin;
 467  0077 e602          	ld	a,(2,x)
 468  0079 1a06          	or	a,(OFST+6,sp)
 470  007b 2005          	jra	L702
 471  007d               L102:
 472                     ; 97         GPIOx->DDR &= (uint8_t)(~(GPIO_Pin));
 474  007d 7b06          	ld	a,(OFST+6,sp)
 475  007f 43            	cpl	a
 476  0080 e402          	and	a,(2,x)
 477  0082               L702:
 478  0082 e702          	ld	(2,x),a
 479                     ; 104     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x40) != (uint8_t)0x00) /* Pull-Up or Push-Pull */
 481  0084 7b08          	ld	a,(OFST+8,sp)
 482  0086 a540          	bcp	a,#64
 483  0088 2706          	jreq	L112
 484                     ; 106         GPIOx->CR1 |= (uint8_t)GPIO_Pin;
 486  008a e603          	ld	a,(3,x)
 487  008c 1a06          	or	a,(OFST+6,sp)
 489  008e 2005          	jra	L312
 490  0090               L112:
 491                     ; 110         GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
 493  0090 7b06          	ld	a,(OFST+6,sp)
 494  0092 43            	cpl	a
 495  0093 e403          	and	a,(3,x)
 496  0095               L312:
 497  0095 e703          	ld	(3,x),a
 498                     ; 117     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x20) != (uint8_t)0x00) /* Interrupt or Slow slope */
 500  0097 7b08          	ld	a,(OFST+8,sp)
 501  0099 a520          	bcp	a,#32
 502  009b 2708          	jreq	L512
 503                     ; 119         GPIOx->CR2 |= (uint8_t)GPIO_Pin;
 505  009d 1e01          	ldw	x,(OFST+1,sp)
 506  009f e604          	ld	a,(4,x)
 507  00a1 1a06          	or	a,(OFST+6,sp)
 509  00a3 2007          	jra	L712
 510  00a5               L512:
 511                     ; 123         GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 513  00a5 1e01          	ldw	x,(OFST+1,sp)
 514  00a7 7b06          	ld	a,(OFST+6,sp)
 515  00a9 43            	cpl	a
 516  00aa e404          	and	a,(4,x)
 517  00ac               L712:
 518  00ac e704          	ld	(4,x),a
 519                     ; 125 }
 522  00ae 85            	popw	x
 523  00af 81            	ret	
 569                     ; 135 void GPIO_Write(GPIO_TypeDef* GPIOx, uint8_t PortVal)
 569                     ; 136 {
 570                     .text:	section	.text,new
 571  0000               _GPIO_Write:
 573       fffffffe      OFST: set -2
 576                     ; 137     GPIOx->ODR = PortVal;
 578  0000 7b03          	ld	a,(OFST+5,sp)
 579  0002 f7            	ld	(x),a
 580                     ; 138 }
 583  0003 81            	ret	
 630                     ; 148 void GPIO_WriteHigh(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 630                     ; 149 {
 631                     .text:	section	.text,new
 632  0000               _GPIO_WriteHigh:
 634       fffffffe      OFST: set -2
 637                     ; 150     GPIOx->ODR |= (uint8_t)PortPins;
 639  0000 f6            	ld	a,(x)
 640  0001 1a04          	or	a,(OFST+6,sp)
 641  0003 f7            	ld	(x),a
 642                     ; 151 }
 645  0004 81            	ret	
 692                     ; 161 void GPIO_WriteLow(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 692                     ; 162 {
 693                     .text:	section	.text,new
 694  0000               _GPIO_WriteLow:
 696       fffffffe      OFST: set -2
 699                     ; 163     GPIOx->ODR &= (uint8_t)(~PortPins);
 701  0000 7b04          	ld	a,(OFST+6,sp)
 702  0002 43            	cpl	a
 703  0003 f4            	and	a,(x)
 704  0004 f7            	ld	(x),a
 705                     ; 164 }
 708  0005 81            	ret	
 755                     ; 174 void GPIO_WriteReverse(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 755                     ; 175 {
 756                     .text:	section	.text,new
 757  0000               _GPIO_WriteReverse:
 759       fffffffe      OFST: set -2
 762                     ; 176     GPIOx->ODR ^= (uint8_t)PortPins;
 764  0000 f6            	ld	a,(x)
 765  0001 1804          	xor	a,(OFST+6,sp)
 766  0003 f7            	ld	(x),a
 767                     ; 177 }
 770  0004 81            	ret	
 808                     ; 185 uint8_t GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
 808                     ; 186 {
 809                     .text:	section	.text,new
 810  0000               _GPIO_ReadOutputData:
 814                     ; 187     return ((uint8_t)GPIOx->ODR);
 816  0000 f6            	ld	a,(x)
 819  0001 81            	ret	
 856                     ; 196 uint8_t GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
 856                     ; 197 {
 857                     .text:	section	.text,new
 858  0000               _GPIO_ReadInputData:
 862                     ; 198     return ((uint8_t)GPIOx->IDR);
 864  0000 e601          	ld	a,(1,x)
 867  0002 81            	ret	
 935                     ; 207 BitStatus GPIO_ReadInputPin(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
 935                     ; 208 {
 936                     .text:	section	.text,new
 937  0000               _GPIO_ReadInputPin:
 939  0000 89            	pushw	x
 940  0001 89            	pushw	x
 941       00000002      OFST:	set	2
 944                     ; 209     return ((BitStatus)(GPIOx->IDR & (uint8_t)GPIO_Pin));
 946  0002 7b08          	ld	a,(OFST+6,sp)
 947  0004 5f            	clrw	x
 948  0005 97            	ld	xl,a
 949  0006 1f01          	ldw	(OFST-1,sp),x
 951  0008 1e03          	ldw	x,(OFST+1,sp)
 952  000a e601          	ld	a,(1,x)
 953  000c 5f            	clrw	x
 954  000d 97            	ld	xl,a
 955  000e 01            	rrwa	x,a
 956  000f 1402          	and	a,(OFST+0,sp)
 957  0011 01            	rrwa	x,a
 958  0012 1401          	and	a,(OFST-1,sp)
 959  0014 01            	rrwa	x,a
 962  0015 5b04          	addw	sp,#4
 963  0017 81            	ret	
1042                     ; 219 void GPIO_ExternalPullUpConfig(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, FunctionalState NewState)
1042                     ; 220 {
1043                     .text:	section	.text,new
1044  0000               _GPIO_ExternalPullUpConfig:
1046  0000 89            	pushw	x
1047       00000000      OFST:	set	0
1050                     ; 222     assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
1052  0001 1e05          	ldw	x,(OFST+5,sp)
1053  0003 260e          	jrne	L05
1054  0005 ae00de        	ldw	x,#222
1055  0008 89            	pushw	x
1056  0009 5f            	clrw	x
1057  000a 89            	pushw	x
1058  000b ae0000        	ldw	x,#L771
1059  000e cd0000        	call	_assert_failed
1061  0011 5b04          	addw	sp,#4
1062  0013               L05:
1063                     ; 223     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1065  0013 1e07          	ldw	x,(OFST+7,sp)
1066  0015 2711          	jreq	L06
1067  0017 5a            	decw	x
1068  0018 270e          	jreq	L06
1069  001a ae00df        	ldw	x,#223
1070  001d 89            	pushw	x
1071  001e 5f            	clrw	x
1072  001f 89            	pushw	x
1073  0020 ae0000        	ldw	x,#L771
1074  0023 cd0000        	call	_assert_failed
1076  0026 5b04          	addw	sp,#4
1077  0028               L06:
1078                     ; 225     if (NewState != DISABLE) /* External Pull-Up Set*/
1080  0028 1e07          	ldw	x,(OFST+7,sp)
1081  002a 2708          	jreq	L574
1082                     ; 227         GPIOx->CR1 |= (uint8_t)GPIO_Pin;
1084  002c 1e01          	ldw	x,(OFST+1,sp)
1085  002e e603          	ld	a,(3,x)
1086  0030 1a06          	or	a,(OFST+6,sp)
1088  0032 2007          	jra	L774
1089  0034               L574:
1090                     ; 230         GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
1092  0034 1e01          	ldw	x,(OFST+1,sp)
1093  0036 7b06          	ld	a,(OFST+6,sp)
1094  0038 43            	cpl	a
1095  0039 e403          	and	a,(3,x)
1096  003b               L774:
1097  003b e703          	ld	(3,x),a
1098                     ; 232 }
1101  003d 85            	popw	x
1102  003e 81            	ret	
1115                     	xdef	_GPIO_ExternalPullUpConfig
1116                     	xdef	_GPIO_ReadInputPin
1117                     	xdef	_GPIO_ReadOutputData
1118                     	xdef	_GPIO_ReadInputData
1119                     	xdef	_GPIO_WriteReverse
1120                     	xdef	_GPIO_WriteLow
1121                     	xdef	_GPIO_WriteHigh
1122                     	xdef	_GPIO_Write
1123                     	xdef	_GPIO_Init
1124                     	xdef	_GPIO_DeInit
1125                     	xref	_assert_failed
1126                     .const:	section	.text
1127  0000               L771:
1128  0000 2e2e5c73746d  	dc.b	"..\stm8s_stdperiph"
1129  0012 5f6472697665  	dc.b	"_driver\src\stm8s_"
1130  0024 6770696f2e63  	dc.b	"gpio.c",0
1150                     	end
