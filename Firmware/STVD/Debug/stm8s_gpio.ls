   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
 111                     ; 47 void GPIO_DeInit(GPIO_TypeDef* GPIOx)
 111                     ; 48 {
 113                     .text:	section	.text,new
 114  0000               _GPIO_DeInit:
 118                     ; 49     GPIOx->ODR = GPIO_ODR_RESET_VALUE; /* Reset Output Data Register */
 120  0000 7f            	clr	(x)
 121                     ; 50     GPIOx->DDR = GPIO_DDR_RESET_VALUE; /* Reset Data Direction Register */
 123  0001 6f02          	clr	(2,x)
 124                     ; 51     GPIOx->CR1 = GPIO_CR1_RESET_VALUE; /* Reset Control Register 1 */
 126  0003 6f03          	clr	(3,x)
 127                     ; 52     GPIOx->CR2 = GPIO_CR2_RESET_VALUE; /* Reset Control Register 2 */
 129  0005 6f04          	clr	(4,x)
 130                     ; 53 }
 133  0007 81            	ret
 374                     ; 65 void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, GPIO_Mode_TypeDef GPIO_Mode)
 374                     ; 66 {
 375                     .text:	section	.text,new
 376  0000               _GPIO_Init:
 378  0000 89            	pushw	x
 379       00000000      OFST:	set	0
 382                     ; 71     assert_param(IS_GPIO_MODE_OK(GPIO_Mode));
 384  0001 0d06          	tnz	(OFST+6,sp)
 385  0003 2742          	jreq	L21
 386  0005 7b06          	ld	a,(OFST+6,sp)
 387  0007 a140          	cp	a,#64
 388  0009 273c          	jreq	L21
 389  000b 7b06          	ld	a,(OFST+6,sp)
 390  000d a120          	cp	a,#32
 391  000f 2736          	jreq	L21
 392  0011 7b06          	ld	a,(OFST+6,sp)
 393  0013 a160          	cp	a,#96
 394  0015 2730          	jreq	L21
 395  0017 7b06          	ld	a,(OFST+6,sp)
 396  0019 a1a0          	cp	a,#160
 397  001b 272a          	jreq	L21
 398  001d 7b06          	ld	a,(OFST+6,sp)
 399  001f a1e0          	cp	a,#224
 400  0021 2724          	jreq	L21
 401  0023 7b06          	ld	a,(OFST+6,sp)
 402  0025 a180          	cp	a,#128
 403  0027 271e          	jreq	L21
 404  0029 7b06          	ld	a,(OFST+6,sp)
 405  002b a1c0          	cp	a,#192
 406  002d 2718          	jreq	L21
 407  002f 7b06          	ld	a,(OFST+6,sp)
 408  0031 a1b0          	cp	a,#176
 409  0033 2712          	jreq	L21
 410  0035 7b06          	ld	a,(OFST+6,sp)
 411  0037 a1f0          	cp	a,#240
 412  0039 270c          	jreq	L21
 413  003b 7b06          	ld	a,(OFST+6,sp)
 414  003d a190          	cp	a,#144
 415  003f 2706          	jreq	L21
 416  0041 7b06          	ld	a,(OFST+6,sp)
 417  0043 a1d0          	cp	a,#208
 418  0045 2603          	jrne	L01
 419  0047               L21:
 420  0047 4f            	clr	a
 421  0048 2010          	jra	L41
 422  004a               L01:
 423  004a ae0047        	ldw	x,#71
 424  004d 89            	pushw	x
 425  004e ae0000        	ldw	x,#0
 426  0051 89            	pushw	x
 427  0052 ae0000        	ldw	x,#L771
 428  0055 cd0000        	call	_assert_failed
 430  0058 5b04          	addw	sp,#4
 431  005a               L41:
 432                     ; 72     assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 434  005a 0d05          	tnz	(OFST+5,sp)
 435  005c 2703          	jreq	L61
 436  005e 4f            	clr	a
 437  005f 2010          	jra	L02
 438  0061               L61:
 439  0061 ae0048        	ldw	x,#72
 440  0064 89            	pushw	x
 441  0065 ae0000        	ldw	x,#0
 442  0068 89            	pushw	x
 443  0069 ae0000        	ldw	x,#L771
 444  006c cd0000        	call	_assert_failed
 446  006f 5b04          	addw	sp,#4
 447  0071               L02:
 448                     ; 75   GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 450  0071 1e01          	ldw	x,(OFST+1,sp)
 451  0073 7b05          	ld	a,(OFST+5,sp)
 452  0075 43            	cpl	a
 453  0076 e404          	and	a,(4,x)
 454  0078 e704          	ld	(4,x),a
 455                     ; 81     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x80) != (uint8_t)0x00) /* Output mode */
 457  007a 7b06          	ld	a,(OFST+6,sp)
 458  007c a580          	bcp	a,#128
 459  007e 271f          	jreq	L102
 460                     ; 83         if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x10) != (uint8_t)0x00) /* High level */
 462  0080 7b06          	ld	a,(OFST+6,sp)
 463  0082 a510          	bcp	a,#16
 464  0084 2708          	jreq	L302
 465                     ; 85             GPIOx->ODR |= (uint8_t)GPIO_Pin;
 467  0086 1e01          	ldw	x,(OFST+1,sp)
 468  0088 f6            	ld	a,(x)
 469  0089 1a05          	or	a,(OFST+5,sp)
 470  008b f7            	ld	(x),a
 472  008c 2007          	jra	L502
 473  008e               L302:
 474                     ; 89             GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
 476  008e 1e01          	ldw	x,(OFST+1,sp)
 477  0090 7b05          	ld	a,(OFST+5,sp)
 478  0092 43            	cpl	a
 479  0093 f4            	and	a,(x)
 480  0094 f7            	ld	(x),a
 481  0095               L502:
 482                     ; 92         GPIOx->DDR |= (uint8_t)GPIO_Pin;
 484  0095 1e01          	ldw	x,(OFST+1,sp)
 485  0097 e602          	ld	a,(2,x)
 486  0099 1a05          	or	a,(OFST+5,sp)
 487  009b e702          	ld	(2,x),a
 489  009d 2009          	jra	L702
 490  009f               L102:
 491                     ; 97         GPIOx->DDR &= (uint8_t)(~(GPIO_Pin));
 493  009f 1e01          	ldw	x,(OFST+1,sp)
 494  00a1 7b05          	ld	a,(OFST+5,sp)
 495  00a3 43            	cpl	a
 496  00a4 e402          	and	a,(2,x)
 497  00a6 e702          	ld	(2,x),a
 498  00a8               L702:
 499                     ; 104     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x40) != (uint8_t)0x00) /* Pull-Up or Push-Pull */
 501  00a8 7b06          	ld	a,(OFST+6,sp)
 502  00aa a540          	bcp	a,#64
 503  00ac 270a          	jreq	L112
 504                     ; 106         GPIOx->CR1 |= (uint8_t)GPIO_Pin;
 506  00ae 1e01          	ldw	x,(OFST+1,sp)
 507  00b0 e603          	ld	a,(3,x)
 508  00b2 1a05          	or	a,(OFST+5,sp)
 509  00b4 e703          	ld	(3,x),a
 511  00b6 2009          	jra	L312
 512  00b8               L112:
 513                     ; 110         GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
 515  00b8 1e01          	ldw	x,(OFST+1,sp)
 516  00ba 7b05          	ld	a,(OFST+5,sp)
 517  00bc 43            	cpl	a
 518  00bd e403          	and	a,(3,x)
 519  00bf e703          	ld	(3,x),a
 520  00c1               L312:
 521                     ; 117     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x20) != (uint8_t)0x00) /* Interrupt or Slow slope */
 523  00c1 7b06          	ld	a,(OFST+6,sp)
 524  00c3 a520          	bcp	a,#32
 525  00c5 270a          	jreq	L512
 526                     ; 119         GPIOx->CR2 |= (uint8_t)GPIO_Pin;
 528  00c7 1e01          	ldw	x,(OFST+1,sp)
 529  00c9 e604          	ld	a,(4,x)
 530  00cb 1a05          	or	a,(OFST+5,sp)
 531  00cd e704          	ld	(4,x),a
 533  00cf 2009          	jra	L712
 534  00d1               L512:
 535                     ; 123         GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 537  00d1 1e01          	ldw	x,(OFST+1,sp)
 538  00d3 7b05          	ld	a,(OFST+5,sp)
 539  00d5 43            	cpl	a
 540  00d6 e404          	and	a,(4,x)
 541  00d8 e704          	ld	(4,x),a
 542  00da               L712:
 543                     ; 125 }
 546  00da 85            	popw	x
 547  00db 81            	ret
 593                     ; 135 void GPIO_Write(GPIO_TypeDef* GPIOx, uint8_t PortVal)
 593                     ; 136 {
 594                     .text:	section	.text,new
 595  0000               _GPIO_Write:
 597  0000 89            	pushw	x
 598       00000000      OFST:	set	0
 601                     ; 137     GPIOx->ODR = PortVal;
 603  0001 7b05          	ld	a,(OFST+5,sp)
 604  0003 1e01          	ldw	x,(OFST+1,sp)
 605  0005 f7            	ld	(x),a
 606                     ; 138 }
 609  0006 85            	popw	x
 610  0007 81            	ret
 657                     ; 148 void GPIO_WriteHigh(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 657                     ; 149 {
 658                     .text:	section	.text,new
 659  0000               _GPIO_WriteHigh:
 661  0000 89            	pushw	x
 662       00000000      OFST:	set	0
 665                     ; 150     GPIOx->ODR |= (uint8_t)PortPins;
 667  0001 f6            	ld	a,(x)
 668  0002 1a05          	or	a,(OFST+5,sp)
 669  0004 f7            	ld	(x),a
 670                     ; 151 }
 673  0005 85            	popw	x
 674  0006 81            	ret
 721                     ; 161 void GPIO_WriteLow(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 721                     ; 162 {
 722                     .text:	section	.text,new
 723  0000               _GPIO_WriteLow:
 725  0000 89            	pushw	x
 726       00000000      OFST:	set	0
 729                     ; 163     GPIOx->ODR &= (uint8_t)(~PortPins);
 731  0001 7b05          	ld	a,(OFST+5,sp)
 732  0003 43            	cpl	a
 733  0004 f4            	and	a,(x)
 734  0005 f7            	ld	(x),a
 735                     ; 164 }
 738  0006 85            	popw	x
 739  0007 81            	ret
 786                     ; 174 void GPIO_WriteReverse(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 786                     ; 175 {
 787                     .text:	section	.text,new
 788  0000               _GPIO_WriteReverse:
 790  0000 89            	pushw	x
 791       00000000      OFST:	set	0
 794                     ; 176     GPIOx->ODR ^= (uint8_t)PortPins;
 796  0001 f6            	ld	a,(x)
 797  0002 1805          	xor	a,	(OFST+5,sp)
 798  0004 f7            	ld	(x),a
 799                     ; 177 }
 802  0005 85            	popw	x
 803  0006 81            	ret
 841                     ; 185 uint8_t GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
 841                     ; 186 {
 842                     .text:	section	.text,new
 843  0000               _GPIO_ReadOutputData:
 847                     ; 187     return ((uint8_t)GPIOx->ODR);
 849  0000 f6            	ld	a,(x)
 852  0001 81            	ret
 889                     ; 196 uint8_t GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
 889                     ; 197 {
 890                     .text:	section	.text,new
 891  0000               _GPIO_ReadInputData:
 895                     ; 198     return ((uint8_t)GPIOx->IDR);
 897  0000 e601          	ld	a,(1,x)
 900  0002 81            	ret
 968                     ; 207 BitStatus GPIO_ReadInputPin(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
 968                     ; 208 {
 969                     .text:	section	.text,new
 970  0000               _GPIO_ReadInputPin:
 972  0000 89            	pushw	x
 973       00000000      OFST:	set	0
 976                     ; 209     return ((BitStatus)(GPIOx->IDR & (uint8_t)GPIO_Pin));
 978  0001 e601          	ld	a,(1,x)
 979  0003 1405          	and	a,(OFST+5,sp)
 982  0005 85            	popw	x
 983  0006 81            	ret
1062                     ; 219 void GPIO_ExternalPullUpConfig(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, FunctionalState NewState)
1062                     ; 220 {
1063                     .text:	section	.text,new
1064  0000               _GPIO_ExternalPullUpConfig:
1066  0000 89            	pushw	x
1067       00000000      OFST:	set	0
1070                     ; 222     assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
1072  0001 0d05          	tnz	(OFST+5,sp)
1073  0003 2703          	jreq	L24
1074  0005 4f            	clr	a
1075  0006 2010          	jra	L44
1076  0008               L24:
1077  0008 ae00de        	ldw	x,#222
1078  000b 89            	pushw	x
1079  000c ae0000        	ldw	x,#0
1080  000f 89            	pushw	x
1081  0010 ae0000        	ldw	x,#L771
1082  0013 cd0000        	call	_assert_failed
1084  0016 5b04          	addw	sp,#4
1085  0018               L44:
1086                     ; 223     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1088  0018 0d06          	tnz	(OFST+6,sp)
1089  001a 2706          	jreq	L05
1090  001c 7b06          	ld	a,(OFST+6,sp)
1091  001e a101          	cp	a,#1
1092  0020 2603          	jrne	L64
1093  0022               L05:
1094  0022 4f            	clr	a
1095  0023 2010          	jra	L25
1096  0025               L64:
1097  0025 ae00df        	ldw	x,#223
1098  0028 89            	pushw	x
1099  0029 ae0000        	ldw	x,#0
1100  002c 89            	pushw	x
1101  002d ae0000        	ldw	x,#L771
1102  0030 cd0000        	call	_assert_failed
1104  0033 5b04          	addw	sp,#4
1105  0035               L25:
1106                     ; 225     if (NewState != DISABLE) /* External Pull-Up Set*/
1108  0035 0d06          	tnz	(OFST+6,sp)
1109  0037 270a          	jreq	L574
1110                     ; 227         GPIOx->CR1 |= (uint8_t)GPIO_Pin;
1112  0039 1e01          	ldw	x,(OFST+1,sp)
1113  003b e603          	ld	a,(3,x)
1114  003d 1a05          	or	a,(OFST+5,sp)
1115  003f e703          	ld	(3,x),a
1117  0041 2009          	jra	L774
1118  0043               L574:
1119                     ; 230         GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
1121  0043 1e01          	ldw	x,(OFST+1,sp)
1122  0045 7b05          	ld	a,(OFST+5,sp)
1123  0047 43            	cpl	a
1124  0048 e403          	and	a,(3,x)
1125  004a e703          	ld	(3,x),a
1126  004c               L774:
1127                     ; 232 }
1130  004c 85            	popw	x
1131  004d 81            	ret
1144                     	xdef	_GPIO_ExternalPullUpConfig
1145                     	xdef	_GPIO_ReadInputPin
1146                     	xdef	_GPIO_ReadOutputData
1147                     	xdef	_GPIO_ReadInputData
1148                     	xdef	_GPIO_WriteReverse
1149                     	xdef	_GPIO_WriteLow
1150                     	xdef	_GPIO_WriteHigh
1151                     	xdef	_GPIO_Write
1152                     	xdef	_GPIO_Init
1153                     	xdef	_GPIO_DeInit
1154                     	xref	_assert_failed
1155                     .const:	section	.text
1156  0000               L771:
1157  0000 2e2e5c73746d  	dc.b	"..\stm8s_stdperiph"
1158  0012 5f6472697665  	dc.b	"_driver\src\stm8s_"
1159  0024 6770696f2e63  	dc.b	"gpio.c",0
1179                     	end
