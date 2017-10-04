   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  17                     .const:	section	.text
  18  0000               _HSIDivFactor:
  19  0000 01            	dc.b	1
  20  0001 02            	dc.b	2
  21  0002 04            	dc.b	4
  22  0003 08            	dc.b	8
  23  0004               _CLKPrescTable:
  24  0004 01            	dc.b	1
  25  0005 02            	dc.b	2
  26  0006 04            	dc.b	4
  27  0007 08            	dc.b	8
  28  0008 0a            	dc.b	10
  29  0009 10            	dc.b	16
  30  000a 14            	dc.b	20
  31  000b 28            	dc.b	40
  60                     ; 66 void CLK_DeInit(void)
  60                     ; 67 {
  62                     .text:	section	.text,new
  63  0000               _CLK_DeInit:
  67                     ; 69     CLK->ICKR = CLK_ICKR_RESET_VALUE;
  69  0000 350150c0      	mov	20672,#1
  70                     ; 70     CLK->ECKR = CLK_ECKR_RESET_VALUE;
  72  0004 725f50c1      	clr	20673
  73                     ; 71     CLK->SWR  = CLK_SWR_RESET_VALUE;
  75  0008 35e150c4      	mov	20676,#225
  76                     ; 72     CLK->SWCR = CLK_SWCR_RESET_VALUE;
  78  000c 725f50c5      	clr	20677
  79                     ; 73     CLK->CKDIVR = CLK_CKDIVR_RESET_VALUE;
  81  0010 351850c6      	mov	20678,#24
  82                     ; 74     CLK->PCKENR1 = CLK_PCKENR1_RESET_VALUE;
  84  0014 35ff50c7      	mov	20679,#255
  85                     ; 75     CLK->PCKENR2 = CLK_PCKENR2_RESET_VALUE;
  87  0018 35ff50ca      	mov	20682,#255
  88                     ; 76     CLK->CSSR = CLK_CSSR_RESET_VALUE;
  90  001c 725f50c8      	clr	20680
  91                     ; 77     CLK->CCOR = CLK_CCOR_RESET_VALUE;
  93  0020 725f50c9      	clr	20681
  95  0024               L52:
  96                     ; 78     while ((CLK->CCOR & CLK_CCOR_CCOEN)!= 0)
  98  0024 c650c9        	ld	a,20681
  99  0027 a501          	bcp	a,#1
 100  0029 26f9          	jrne	L52
 101                     ; 80     CLK->CCOR = CLK_CCOR_RESET_VALUE;
 103  002b 725f50c9      	clr	20681
 104                     ; 81     CLK->HSITRIMR = CLK_HSITRIMR_RESET_VALUE;
 106  002f 725f50cc      	clr	20684
 107                     ; 82     CLK->SWIMCCR = CLK_SWIMCCR_RESET_VALUE;
 109  0033 725f50cd      	clr	20685
 110                     ; 84 }
 113  0037 81            	ret
 170                     ; 95 void CLK_FastHaltWakeUpCmd(FunctionalState NewState)
 170                     ; 96 {
 171                     .text:	section	.text,new
 172  0000               _CLK_FastHaltWakeUpCmd:
 174  0000 88            	push	a
 175       00000000      OFST:	set	0
 178                     ; 99     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 180  0001 4d            	tnz	a
 181  0002 2704          	jreq	L21
 182  0004 a101          	cp	a,#1
 183  0006 2603          	jrne	L01
 184  0008               L21:
 185  0008 4f            	clr	a
 186  0009 2010          	jra	L41
 187  000b               L01:
 188  000b ae0063        	ldw	x,#99
 189  000e 89            	pushw	x
 190  000f ae0000        	ldw	x,#0
 191  0012 89            	pushw	x
 192  0013 ae000c        	ldw	x,#L75
 193  0016 cd0000        	call	_assert_failed
 195  0019 5b04          	addw	sp,#4
 196  001b               L41:
 197                     ; 101     if (NewState != DISABLE)
 199  001b 0d01          	tnz	(OFST+1,sp)
 200  001d 2706          	jreq	L16
 201                     ; 104         CLK->ICKR |= CLK_ICKR_FHWU;
 203  001f 721450c0      	bset	20672,#2
 205  0023 2004          	jra	L36
 206  0025               L16:
 207                     ; 109         CLK->ICKR &= (uint8_t)(~CLK_ICKR_FHWU);
 209  0025 721550c0      	bres	20672,#2
 210  0029               L36:
 211                     ; 112 }
 214  0029 84            	pop	a
 215  002a 81            	ret
 251                     ; 119 void CLK_HSECmd(FunctionalState NewState)
 251                     ; 120 {
 252                     .text:	section	.text,new
 253  0000               _CLK_HSECmd:
 255  0000 88            	push	a
 256       00000000      OFST:	set	0
 259                     ; 123     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 261  0001 4d            	tnz	a
 262  0002 2704          	jreq	L22
 263  0004 a101          	cp	a,#1
 264  0006 2603          	jrne	L02
 265  0008               L22:
 266  0008 4f            	clr	a
 267  0009 2010          	jra	L42
 268  000b               L02:
 269  000b ae007b        	ldw	x,#123
 270  000e 89            	pushw	x
 271  000f ae0000        	ldw	x,#0
 272  0012 89            	pushw	x
 273  0013 ae000c        	ldw	x,#L75
 274  0016 cd0000        	call	_assert_failed
 276  0019 5b04          	addw	sp,#4
 277  001b               L42:
 278                     ; 125     if (NewState != DISABLE)
 280  001b 0d01          	tnz	(OFST+1,sp)
 281  001d 2706          	jreq	L301
 282                     ; 128         CLK->ECKR |= CLK_ECKR_HSEEN;
 284  001f 721050c1      	bset	20673,#0
 286  0023 2004          	jra	L501
 287  0025               L301:
 288                     ; 133         CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
 290  0025 721150c1      	bres	20673,#0
 291  0029               L501:
 292                     ; 136 }
 295  0029 84            	pop	a
 296  002a 81            	ret
 332                     ; 143 void CLK_HSICmd(FunctionalState NewState)
 332                     ; 144 {
 333                     .text:	section	.text,new
 334  0000               _CLK_HSICmd:
 336  0000 88            	push	a
 337       00000000      OFST:	set	0
 340                     ; 147     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 342  0001 4d            	tnz	a
 343  0002 2704          	jreq	L23
 344  0004 a101          	cp	a,#1
 345  0006 2603          	jrne	L03
 346  0008               L23:
 347  0008 4f            	clr	a
 348  0009 2010          	jra	L43
 349  000b               L03:
 350  000b ae0093        	ldw	x,#147
 351  000e 89            	pushw	x
 352  000f ae0000        	ldw	x,#0
 353  0012 89            	pushw	x
 354  0013 ae000c        	ldw	x,#L75
 355  0016 cd0000        	call	_assert_failed
 357  0019 5b04          	addw	sp,#4
 358  001b               L43:
 359                     ; 149     if (NewState != DISABLE)
 361  001b 0d01          	tnz	(OFST+1,sp)
 362  001d 2706          	jreq	L521
 363                     ; 152         CLK->ICKR |= CLK_ICKR_HSIEN;
 365  001f 721050c0      	bset	20672,#0
 367  0023 2004          	jra	L721
 368  0025               L521:
 369                     ; 157         CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
 371  0025 721150c0      	bres	20672,#0
 372  0029               L721:
 373                     ; 160 }
 376  0029 84            	pop	a
 377  002a 81            	ret
 413                     ; 167 void CLK_LSICmd(FunctionalState NewState)
 413                     ; 168 {
 414                     .text:	section	.text,new
 415  0000               _CLK_LSICmd:
 417  0000 88            	push	a
 418       00000000      OFST:	set	0
 421                     ; 171     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 423  0001 4d            	tnz	a
 424  0002 2704          	jreq	L24
 425  0004 a101          	cp	a,#1
 426  0006 2603          	jrne	L04
 427  0008               L24:
 428  0008 4f            	clr	a
 429  0009 2010          	jra	L44
 430  000b               L04:
 431  000b ae00ab        	ldw	x,#171
 432  000e 89            	pushw	x
 433  000f ae0000        	ldw	x,#0
 434  0012 89            	pushw	x
 435  0013 ae000c        	ldw	x,#L75
 436  0016 cd0000        	call	_assert_failed
 438  0019 5b04          	addw	sp,#4
 439  001b               L44:
 440                     ; 173     if (NewState != DISABLE)
 442  001b 0d01          	tnz	(OFST+1,sp)
 443  001d 2706          	jreq	L741
 444                     ; 176         CLK->ICKR |= CLK_ICKR_LSIEN;
 446  001f 721650c0      	bset	20672,#3
 448  0023 2004          	jra	L151
 449  0025               L741:
 450                     ; 181         CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
 452  0025 721750c0      	bres	20672,#3
 453  0029               L151:
 454                     ; 184 }
 457  0029 84            	pop	a
 458  002a 81            	ret
 494                     ; 192 void CLK_CCOCmd(FunctionalState NewState)
 494                     ; 193 {
 495                     .text:	section	.text,new
 496  0000               _CLK_CCOCmd:
 498  0000 88            	push	a
 499       00000000      OFST:	set	0
 502                     ; 196     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 504  0001 4d            	tnz	a
 505  0002 2704          	jreq	L25
 506  0004 a101          	cp	a,#1
 507  0006 2603          	jrne	L05
 508  0008               L25:
 509  0008 4f            	clr	a
 510  0009 2010          	jra	L45
 511  000b               L05:
 512  000b ae00c4        	ldw	x,#196
 513  000e 89            	pushw	x
 514  000f ae0000        	ldw	x,#0
 515  0012 89            	pushw	x
 516  0013 ae000c        	ldw	x,#L75
 517  0016 cd0000        	call	_assert_failed
 519  0019 5b04          	addw	sp,#4
 520  001b               L45:
 521                     ; 198     if (NewState != DISABLE)
 523  001b 0d01          	tnz	(OFST+1,sp)
 524  001d 2706          	jreq	L171
 525                     ; 201         CLK->CCOR |= CLK_CCOR_CCOEN;
 527  001f 721050c9      	bset	20681,#0
 529  0023 2004          	jra	L371
 530  0025               L171:
 531                     ; 206         CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOEN);
 533  0025 721150c9      	bres	20681,#0
 534  0029               L371:
 535                     ; 209 }
 538  0029 84            	pop	a
 539  002a 81            	ret
 575                     ; 218 void CLK_ClockSwitchCmd(FunctionalState NewState)
 575                     ; 219 {
 576                     .text:	section	.text,new
 577  0000               _CLK_ClockSwitchCmd:
 579  0000 88            	push	a
 580       00000000      OFST:	set	0
 583                     ; 222     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 585  0001 4d            	tnz	a
 586  0002 2704          	jreq	L26
 587  0004 a101          	cp	a,#1
 588  0006 2603          	jrne	L06
 589  0008               L26:
 590  0008 4f            	clr	a
 591  0009 2010          	jra	L46
 592  000b               L06:
 593  000b ae00de        	ldw	x,#222
 594  000e 89            	pushw	x
 595  000f ae0000        	ldw	x,#0
 596  0012 89            	pushw	x
 597  0013 ae000c        	ldw	x,#L75
 598  0016 cd0000        	call	_assert_failed
 600  0019 5b04          	addw	sp,#4
 601  001b               L46:
 602                     ; 224     if (NewState != DISABLE )
 604  001b 0d01          	tnz	(OFST+1,sp)
 605  001d 2706          	jreq	L312
 606                     ; 227         CLK->SWCR |= CLK_SWCR_SWEN;
 608  001f 721250c5      	bset	20677,#1
 610  0023 2004          	jra	L512
 611  0025               L312:
 612                     ; 232         CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWEN);
 614  0025 721350c5      	bres	20677,#1
 615  0029               L512:
 616                     ; 235 }
 619  0029 84            	pop	a
 620  002a 81            	ret
 657                     ; 245 void CLK_SlowActiveHaltWakeUpCmd(FunctionalState NewState)
 657                     ; 246 {
 658                     .text:	section	.text,new
 659  0000               _CLK_SlowActiveHaltWakeUpCmd:
 661  0000 88            	push	a
 662       00000000      OFST:	set	0
 665                     ; 249     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 667  0001 4d            	tnz	a
 668  0002 2704          	jreq	L27
 669  0004 a101          	cp	a,#1
 670  0006 2603          	jrne	L07
 671  0008               L27:
 672  0008 4f            	clr	a
 673  0009 2010          	jra	L47
 674  000b               L07:
 675  000b ae00f9        	ldw	x,#249
 676  000e 89            	pushw	x
 677  000f ae0000        	ldw	x,#0
 678  0012 89            	pushw	x
 679  0013 ae000c        	ldw	x,#L75
 680  0016 cd0000        	call	_assert_failed
 682  0019 5b04          	addw	sp,#4
 683  001b               L47:
 684                     ; 251     if (NewState != DISABLE)
 686  001b 0d01          	tnz	(OFST+1,sp)
 687  001d 2706          	jreq	L532
 688                     ; 254         CLK->ICKR |= CLK_ICKR_SWUAH;
 690  001f 721a50c0      	bset	20672,#5
 692  0023 2004          	jra	L732
 693  0025               L532:
 694                     ; 259         CLK->ICKR &= (uint8_t)(~CLK_ICKR_SWUAH);
 696  0025 721b50c0      	bres	20672,#5
 697  0029               L732:
 698                     ; 262 }
 701  0029 84            	pop	a
 702  002a 81            	ret
 862                     ; 272 void CLK_PeripheralClockConfig(CLK_Peripheral_TypeDef CLK_Peripheral, FunctionalState NewState)
 862                     ; 273 {
 863                     .text:	section	.text,new
 864  0000               _CLK_PeripheralClockConfig:
 866  0000 89            	pushw	x
 867       00000000      OFST:	set	0
 870                     ; 276     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 872  0001 9f            	ld	a,xl
 873  0002 4d            	tnz	a
 874  0003 2705          	jreq	L201
 875  0005 9f            	ld	a,xl
 876  0006 a101          	cp	a,#1
 877  0008 2603          	jrne	L001
 878  000a               L201:
 879  000a 4f            	clr	a
 880  000b 2010          	jra	L401
 881  000d               L001:
 882  000d ae0114        	ldw	x,#276
 883  0010 89            	pushw	x
 884  0011 ae0000        	ldw	x,#0
 885  0014 89            	pushw	x
 886  0015 ae000c        	ldw	x,#L75
 887  0018 cd0000        	call	_assert_failed
 889  001b 5b04          	addw	sp,#4
 890  001d               L401:
 891                     ; 277     assert_param(IS_CLK_PERIPHERAL_OK(CLK_Peripheral));
 893  001d 0d01          	tnz	(OFST+1,sp)
 894  001f 274e          	jreq	L011
 895  0021 7b01          	ld	a,(OFST+1,sp)
 896  0023 a101          	cp	a,#1
 897  0025 2748          	jreq	L011
 898  0027 7b01          	ld	a,(OFST+1,sp)
 899  0029 a103          	cp	a,#3
 900  002b 2742          	jreq	L011
 901  002d 7b01          	ld	a,(OFST+1,sp)
 902  002f a103          	cp	a,#3
 903  0031 273c          	jreq	L011
 904  0033 7b01          	ld	a,(OFST+1,sp)
 905  0035 a103          	cp	a,#3
 906  0037 2736          	jreq	L011
 907  0039 7b01          	ld	a,(OFST+1,sp)
 908  003b a104          	cp	a,#4
 909  003d 2730          	jreq	L011
 910  003f 7b01          	ld	a,(OFST+1,sp)
 911  0041 a105          	cp	a,#5
 912  0043 272a          	jreq	L011
 913  0045 7b01          	ld	a,(OFST+1,sp)
 914  0047 a105          	cp	a,#5
 915  0049 2724          	jreq	L011
 916  004b 7b01          	ld	a,(OFST+1,sp)
 917  004d a104          	cp	a,#4
 918  004f 271e          	jreq	L011
 919  0051 7b01          	ld	a,(OFST+1,sp)
 920  0053 a106          	cp	a,#6
 921  0055 2718          	jreq	L011
 922  0057 7b01          	ld	a,(OFST+1,sp)
 923  0059 a107          	cp	a,#7
 924  005b 2712          	jreq	L011
 925  005d 7b01          	ld	a,(OFST+1,sp)
 926  005f a117          	cp	a,#23
 927  0061 270c          	jreq	L011
 928  0063 7b01          	ld	a,(OFST+1,sp)
 929  0065 a113          	cp	a,#19
 930  0067 2706          	jreq	L011
 931  0069 7b01          	ld	a,(OFST+1,sp)
 932  006b a112          	cp	a,#18
 933  006d 2603          	jrne	L601
 934  006f               L011:
 935  006f 4f            	clr	a
 936  0070 2010          	jra	L211
 937  0072               L601:
 938  0072 ae0115        	ldw	x,#277
 939  0075 89            	pushw	x
 940  0076 ae0000        	ldw	x,#0
 941  0079 89            	pushw	x
 942  007a ae000c        	ldw	x,#L75
 943  007d cd0000        	call	_assert_failed
 945  0080 5b04          	addw	sp,#4
 946  0082               L211:
 947                     ; 279     if (((uint8_t)CLK_Peripheral & (uint8_t)0x10) == 0x00)
 949  0082 7b01          	ld	a,(OFST+1,sp)
 950  0084 a510          	bcp	a,#16
 951  0086 2633          	jrne	L323
 952                     ; 281         if (NewState != DISABLE)
 954  0088 0d02          	tnz	(OFST+2,sp)
 955  008a 2717          	jreq	L523
 956                     ; 284             CLK->PCKENR1 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 958  008c 7b01          	ld	a,(OFST+1,sp)
 959  008e a40f          	and	a,#15
 960  0090 5f            	clrw	x
 961  0091 97            	ld	xl,a
 962  0092 a601          	ld	a,#1
 963  0094 5d            	tnzw	x
 964  0095 2704          	jreq	L411
 965  0097               L611:
 966  0097 48            	sll	a
 967  0098 5a            	decw	x
 968  0099 26fc          	jrne	L611
 969  009b               L411:
 970  009b ca50c7        	or	a,20679
 971  009e c750c7        	ld	20679,a
 973  00a1 2049          	jra	L133
 974  00a3               L523:
 975                     ; 289             CLK->PCKENR1 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 977  00a3 7b01          	ld	a,(OFST+1,sp)
 978  00a5 a40f          	and	a,#15
 979  00a7 5f            	clrw	x
 980  00a8 97            	ld	xl,a
 981  00a9 a601          	ld	a,#1
 982  00ab 5d            	tnzw	x
 983  00ac 2704          	jreq	L021
 984  00ae               L221:
 985  00ae 48            	sll	a
 986  00af 5a            	decw	x
 987  00b0 26fc          	jrne	L221
 988  00b2               L021:
 989  00b2 43            	cpl	a
 990  00b3 c450c7        	and	a,20679
 991  00b6 c750c7        	ld	20679,a
 992  00b9 2031          	jra	L133
 993  00bb               L323:
 994                     ; 294         if (NewState != DISABLE)
 996  00bb 0d02          	tnz	(OFST+2,sp)
 997  00bd 2717          	jreq	L333
 998                     ; 297             CLK->PCKENR2 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
1000  00bf 7b01          	ld	a,(OFST+1,sp)
1001  00c1 a40f          	and	a,#15
1002  00c3 5f            	clrw	x
1003  00c4 97            	ld	xl,a
1004  00c5 a601          	ld	a,#1
1005  00c7 5d            	tnzw	x
1006  00c8 2704          	jreq	L421
1007  00ca               L621:
1008  00ca 48            	sll	a
1009  00cb 5a            	decw	x
1010  00cc 26fc          	jrne	L621
1011  00ce               L421:
1012  00ce ca50ca        	or	a,20682
1013  00d1 c750ca        	ld	20682,a
1015  00d4 2016          	jra	L133
1016  00d6               L333:
1017                     ; 302             CLK->PCKENR2 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
1019  00d6 7b01          	ld	a,(OFST+1,sp)
1020  00d8 a40f          	and	a,#15
1021  00da 5f            	clrw	x
1022  00db 97            	ld	xl,a
1023  00dc a601          	ld	a,#1
1024  00de 5d            	tnzw	x
1025  00df 2704          	jreq	L031
1026  00e1               L231:
1027  00e1 48            	sll	a
1028  00e2 5a            	decw	x
1029  00e3 26fc          	jrne	L231
1030  00e5               L031:
1031  00e5 43            	cpl	a
1032  00e6 c450ca        	and	a,20682
1033  00e9 c750ca        	ld	20682,a
1034  00ec               L133:
1035                     ; 306 }
1038  00ec 85            	popw	x
1039  00ed 81            	ret
1228                     ; 319 ErrorStatus CLK_ClockSwitchConfig(CLK_SwitchMode_TypeDef CLK_SwitchMode, CLK_Source_TypeDef CLK_NewClock, FunctionalState ITState, CLK_CurrentClockState_TypeDef CLK_CurrentClockState)
1228                     ; 320 {
1229                     .text:	section	.text,new
1230  0000               _CLK_ClockSwitchConfig:
1232  0000 89            	pushw	x
1233  0001 5204          	subw	sp,#4
1234       00000004      OFST:	set	4
1237                     ; 323     uint16_t DownCounter = CLK_TIMEOUT;
1239  0003 ae0491        	ldw	x,#1169
1240  0006 1f03          	ldw	(OFST-1,sp),x
1241                     ; 324     ErrorStatus Swif = ERROR;
1243                     ; 327     assert_param(IS_CLK_SOURCE_OK(CLK_NewClock));
1245  0008 7b06          	ld	a,(OFST+2,sp)
1246  000a a1e1          	cp	a,#225
1247  000c 270c          	jreq	L041
1248  000e 7b06          	ld	a,(OFST+2,sp)
1249  0010 a1d2          	cp	a,#210
1250  0012 2706          	jreq	L041
1251  0014 7b06          	ld	a,(OFST+2,sp)
1252  0016 a1b4          	cp	a,#180
1253  0018 2603          	jrne	L631
1254  001a               L041:
1255  001a 4f            	clr	a
1256  001b 2010          	jra	L241
1257  001d               L631:
1258  001d ae0147        	ldw	x,#327
1259  0020 89            	pushw	x
1260  0021 ae0000        	ldw	x,#0
1261  0024 89            	pushw	x
1262  0025 ae000c        	ldw	x,#L75
1263  0028 cd0000        	call	_assert_failed
1265  002b 5b04          	addw	sp,#4
1266  002d               L241:
1267                     ; 328     assert_param(IS_CLK_SWITCHMODE_OK(CLK_SwitchMode));
1269  002d 0d05          	tnz	(OFST+1,sp)
1270  002f 2706          	jreq	L641
1271  0031 7b05          	ld	a,(OFST+1,sp)
1272  0033 a101          	cp	a,#1
1273  0035 2603          	jrne	L441
1274  0037               L641:
1275  0037 4f            	clr	a
1276  0038 2010          	jra	L051
1277  003a               L441:
1278  003a ae0148        	ldw	x,#328
1279  003d 89            	pushw	x
1280  003e ae0000        	ldw	x,#0
1281  0041 89            	pushw	x
1282  0042 ae000c        	ldw	x,#L75
1283  0045 cd0000        	call	_assert_failed
1285  0048 5b04          	addw	sp,#4
1286  004a               L051:
1287                     ; 329     assert_param(IS_FUNCTIONALSTATE_OK(ITState));
1289  004a 0d09          	tnz	(OFST+5,sp)
1290  004c 2706          	jreq	L451
1291  004e 7b09          	ld	a,(OFST+5,sp)
1292  0050 a101          	cp	a,#1
1293  0052 2603          	jrne	L251
1294  0054               L451:
1295  0054 4f            	clr	a
1296  0055 2010          	jra	L651
1297  0057               L251:
1298  0057 ae0149        	ldw	x,#329
1299  005a 89            	pushw	x
1300  005b ae0000        	ldw	x,#0
1301  005e 89            	pushw	x
1302  005f ae000c        	ldw	x,#L75
1303  0062 cd0000        	call	_assert_failed
1305  0065 5b04          	addw	sp,#4
1306  0067               L651:
1307                     ; 330     assert_param(IS_CLK_CURRENTCLOCKSTATE_OK(CLK_CurrentClockState));
1309  0067 0d0a          	tnz	(OFST+6,sp)
1310  0069 2706          	jreq	L261
1311  006b 7b0a          	ld	a,(OFST+6,sp)
1312  006d a101          	cp	a,#1
1313  006f 2603          	jrne	L061
1314  0071               L261:
1315  0071 4f            	clr	a
1316  0072 2010          	jra	L461
1317  0074               L061:
1318  0074 ae014a        	ldw	x,#330
1319  0077 89            	pushw	x
1320  0078 ae0000        	ldw	x,#0
1321  007b 89            	pushw	x
1322  007c ae000c        	ldw	x,#L75
1323  007f cd0000        	call	_assert_failed
1325  0082 5b04          	addw	sp,#4
1326  0084               L461:
1327                     ; 333     clock_master = (CLK_Source_TypeDef)CLK->CMSR;
1329  0084 c650c3        	ld	a,20675
1330  0087 6b01          	ld	(OFST-3,sp),a
1331                     ; 336     if (CLK_SwitchMode == CLK_SWITCHMODE_AUTO)
1333  0089 7b05          	ld	a,(OFST+1,sp)
1334  008b a101          	cp	a,#1
1335  008d 2639          	jrne	L744
1336                     ; 340         CLK->SWCR |= CLK_SWCR_SWEN;
1338  008f 721250c5      	bset	20677,#1
1339                     ; 343         if (ITState != DISABLE)
1341  0093 0d09          	tnz	(OFST+5,sp)
1342  0095 2706          	jreq	L154
1343                     ; 345             CLK->SWCR |= CLK_SWCR_SWIEN;
1345  0097 721450c5      	bset	20677,#2
1347  009b 2004          	jra	L354
1348  009d               L154:
1349                     ; 349             CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1351  009d 721550c5      	bres	20677,#2
1352  00a1               L354:
1353                     ; 353         CLK->SWR = (uint8_t)CLK_NewClock;
1355  00a1 7b06          	ld	a,(OFST+2,sp)
1356  00a3 c750c4        	ld	20676,a
1358  00a6 2007          	jra	L164
1359  00a8               L554:
1360                     ; 357             DownCounter--;
1362  00a8 1e03          	ldw	x,(OFST-1,sp)
1363  00aa 1d0001        	subw	x,#1
1364  00ad 1f03          	ldw	(OFST-1,sp),x
1365  00af               L164:
1366                     ; 355         while ((((CLK->SWCR & CLK_SWCR_SWBSY) != 0 )&& (DownCounter != 0)))
1368  00af c650c5        	ld	a,20677
1369  00b2 a501          	bcp	a,#1
1370  00b4 2704          	jreq	L564
1372  00b6 1e03          	ldw	x,(OFST-1,sp)
1373  00b8 26ee          	jrne	L554
1374  00ba               L564:
1375                     ; 360         if (DownCounter != 0)
1377  00ba 1e03          	ldw	x,(OFST-1,sp)
1378  00bc 2706          	jreq	L764
1379                     ; 362             Swif = SUCCESS;
1381  00be a601          	ld	a,#1
1382  00c0 6b02          	ld	(OFST-2,sp),a
1384  00c2 201b          	jra	L374
1385  00c4               L764:
1386                     ; 366             Swif = ERROR;
1388  00c4 0f02          	clr	(OFST-2,sp)
1389  00c6 2017          	jra	L374
1390  00c8               L744:
1391                     ; 374         if (ITState != DISABLE)
1393  00c8 0d09          	tnz	(OFST+5,sp)
1394  00ca 2706          	jreq	L574
1395                     ; 376             CLK->SWCR |= CLK_SWCR_SWIEN;
1397  00cc 721450c5      	bset	20677,#2
1399  00d0 2004          	jra	L774
1400  00d2               L574:
1401                     ; 380             CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1403  00d2 721550c5      	bres	20677,#2
1404  00d6               L774:
1405                     ; 384         CLK->SWR = (uint8_t)CLK_NewClock;
1407  00d6 7b06          	ld	a,(OFST+2,sp)
1408  00d8 c750c4        	ld	20676,a
1409                     ; 388         Swif = SUCCESS;
1411  00db a601          	ld	a,#1
1412  00dd 6b02          	ld	(OFST-2,sp),a
1413  00df               L374:
1414                     ; 393     if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSI))
1416  00df 0d0a          	tnz	(OFST+6,sp)
1417  00e1 260c          	jrne	L105
1419  00e3 7b01          	ld	a,(OFST-3,sp)
1420  00e5 a1e1          	cp	a,#225
1421  00e7 2606          	jrne	L105
1422                     ; 395         CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
1424  00e9 721150c0      	bres	20672,#0
1426  00ed 201e          	jra	L305
1427  00ef               L105:
1428                     ; 397     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_LSI))
1430  00ef 0d0a          	tnz	(OFST+6,sp)
1431  00f1 260c          	jrne	L505
1433  00f3 7b01          	ld	a,(OFST-3,sp)
1434  00f5 a1d2          	cp	a,#210
1435  00f7 2606          	jrne	L505
1436                     ; 399         CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
1438  00f9 721750c0      	bres	20672,#3
1440  00fd 200e          	jra	L305
1441  00ff               L505:
1442                     ; 401     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSE))
1444  00ff 0d0a          	tnz	(OFST+6,sp)
1445  0101 260a          	jrne	L305
1447  0103 7b01          	ld	a,(OFST-3,sp)
1448  0105 a1b4          	cp	a,#180
1449  0107 2604          	jrne	L305
1450                     ; 403         CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
1452  0109 721150c1      	bres	20673,#0
1453  010d               L305:
1454                     ; 406     return(Swif);
1456  010d 7b02          	ld	a,(OFST-2,sp)
1459  010f 5b06          	addw	sp,#6
1460  0111 81            	ret
1599                     ; 416 void CLK_HSIPrescalerConfig(CLK_Prescaler_TypeDef HSIPrescaler)
1599                     ; 417 {
1600                     .text:	section	.text,new
1601  0000               _CLK_HSIPrescalerConfig:
1603  0000 88            	push	a
1604       00000000      OFST:	set	0
1607                     ; 420     assert_param(IS_CLK_HSIPRESCALER_OK(HSIPrescaler));
1609  0001 4d            	tnz	a
1610  0002 270c          	jreq	L271
1611  0004 a108          	cp	a,#8
1612  0006 2708          	jreq	L271
1613  0008 a110          	cp	a,#16
1614  000a 2704          	jreq	L271
1615  000c a118          	cp	a,#24
1616  000e 2603          	jrne	L071
1617  0010               L271:
1618  0010 4f            	clr	a
1619  0011 2010          	jra	L471
1620  0013               L071:
1621  0013 ae01a4        	ldw	x,#420
1622  0016 89            	pushw	x
1623  0017 ae0000        	ldw	x,#0
1624  001a 89            	pushw	x
1625  001b ae000c        	ldw	x,#L75
1626  001e cd0000        	call	_assert_failed
1628  0021 5b04          	addw	sp,#4
1629  0023               L471:
1630                     ; 423     CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
1632  0023 c650c6        	ld	a,20678
1633  0026 a4e7          	and	a,#231
1634  0028 c750c6        	ld	20678,a
1635                     ; 426     CLK->CKDIVR |= (uint8_t)HSIPrescaler;
1637  002b c650c6        	ld	a,20678
1638  002e 1a01          	or	a,(OFST+1,sp)
1639  0030 c750c6        	ld	20678,a
1640                     ; 428 }
1643  0033 84            	pop	a
1644  0034 81            	ret
1780                     ; 439 void CLK_CCOConfig(CLK_Output_TypeDef CLK_CCO)
1780                     ; 440 {
1781                     .text:	section	.text,new
1782  0000               _CLK_CCOConfig:
1784  0000 88            	push	a
1785       00000000      OFST:	set	0
1788                     ; 443     assert_param(IS_CLK_OUTPUT_OK(CLK_CCO));
1790  0001 4d            	tnz	a
1791  0002 2730          	jreq	L202
1792  0004 a104          	cp	a,#4
1793  0006 272c          	jreq	L202
1794  0008 a102          	cp	a,#2
1795  000a 2728          	jreq	L202
1796  000c a108          	cp	a,#8
1797  000e 2724          	jreq	L202
1798  0010 a10a          	cp	a,#10
1799  0012 2720          	jreq	L202
1800  0014 a10c          	cp	a,#12
1801  0016 271c          	jreq	L202
1802  0018 a10e          	cp	a,#14
1803  001a 2718          	jreq	L202
1804  001c a110          	cp	a,#16
1805  001e 2714          	jreq	L202
1806  0020 a112          	cp	a,#18
1807  0022 2710          	jreq	L202
1808  0024 a114          	cp	a,#20
1809  0026 270c          	jreq	L202
1810  0028 a116          	cp	a,#22
1811  002a 2708          	jreq	L202
1812  002c a118          	cp	a,#24
1813  002e 2704          	jreq	L202
1814  0030 a11a          	cp	a,#26
1815  0032 2603          	jrne	L002
1816  0034               L202:
1817  0034 4f            	clr	a
1818  0035 2010          	jra	L402
1819  0037               L002:
1820  0037 ae01bb        	ldw	x,#443
1821  003a 89            	pushw	x
1822  003b ae0000        	ldw	x,#0
1823  003e 89            	pushw	x
1824  003f ae000c        	ldw	x,#L75
1825  0042 cd0000        	call	_assert_failed
1827  0045 5b04          	addw	sp,#4
1828  0047               L402:
1829                     ; 446     CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOSEL);
1831  0047 c650c9        	ld	a,20681
1832  004a a4e1          	and	a,#225
1833  004c c750c9        	ld	20681,a
1834                     ; 449     CLK->CCOR |= (uint8_t)CLK_CCO;
1836  004f c650c9        	ld	a,20681
1837  0052 1a01          	or	a,(OFST+1,sp)
1838  0054 c750c9        	ld	20681,a
1839                     ; 452     CLK->CCOR |= CLK_CCOR_CCOEN;
1841  0057 721050c9      	bset	20681,#0
1842                     ; 454 }
1845  005b 84            	pop	a
1846  005c 81            	ret
1912                     ; 464 void CLK_ITConfig(CLK_IT_TypeDef CLK_IT, FunctionalState NewState)
1912                     ; 465 {
1913                     .text:	section	.text,new
1914  0000               _CLK_ITConfig:
1916  0000 89            	pushw	x
1917       00000000      OFST:	set	0
1920                     ; 468     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1922  0001 9f            	ld	a,xl
1923  0002 4d            	tnz	a
1924  0003 2705          	jreq	L212
1925  0005 9f            	ld	a,xl
1926  0006 a101          	cp	a,#1
1927  0008 2603          	jrne	L012
1928  000a               L212:
1929  000a 4f            	clr	a
1930  000b 2010          	jra	L412
1931  000d               L012:
1932  000d ae01d4        	ldw	x,#468
1933  0010 89            	pushw	x
1934  0011 ae0000        	ldw	x,#0
1935  0014 89            	pushw	x
1936  0015 ae000c        	ldw	x,#L75
1937  0018 cd0000        	call	_assert_failed
1939  001b 5b04          	addw	sp,#4
1940  001d               L412:
1941                     ; 469     assert_param(IS_CLK_IT_OK(CLK_IT));
1943  001d 7b01          	ld	a,(OFST+1,sp)
1944  001f a10c          	cp	a,#12
1945  0021 2706          	jreq	L022
1946  0023 7b01          	ld	a,(OFST+1,sp)
1947  0025 a11c          	cp	a,#28
1948  0027 2603          	jrne	L612
1949  0029               L022:
1950  0029 4f            	clr	a
1951  002a 2010          	jra	L222
1952  002c               L612:
1953  002c ae01d5        	ldw	x,#469
1954  002f 89            	pushw	x
1955  0030 ae0000        	ldw	x,#0
1956  0033 89            	pushw	x
1957  0034 ae000c        	ldw	x,#L75
1958  0037 cd0000        	call	_assert_failed
1960  003a 5b04          	addw	sp,#4
1961  003c               L222:
1962                     ; 471     if (NewState != DISABLE)
1964  003c 0d02          	tnz	(OFST+2,sp)
1965  003e 271a          	jreq	L707
1966                     ; 473         switch (CLK_IT)
1968  0040 7b01          	ld	a,(OFST+1,sp)
1970                     ; 481         default:
1970                     ; 482             break;
1971  0042 a00c          	sub	a,#12
1972  0044 270a          	jreq	L346
1973  0046 a010          	sub	a,#16
1974  0048 2624          	jrne	L517
1975                     ; 475         case CLK_IT_SWIF: /* Enable the clock switch interrupt */
1975                     ; 476             CLK->SWCR |= CLK_SWCR_SWIEN;
1977  004a 721450c5      	bset	20677,#2
1978                     ; 477             break;
1980  004e 201e          	jra	L517
1981  0050               L346:
1982                     ; 478         case CLK_IT_CSSD: /* Enable the clock security system detection interrupt */
1982                     ; 479             CLK->CSSR |= CLK_CSSR_CSSDIE;
1984  0050 721450c8      	bset	20680,#2
1985                     ; 480             break;
1987  0054 2018          	jra	L517
1988  0056               L546:
1989                     ; 481         default:
1989                     ; 482             break;
1991  0056 2016          	jra	L517
1992  0058               L317:
1994  0058 2014          	jra	L517
1995  005a               L707:
1996                     ; 487         switch (CLK_IT)
1998  005a 7b01          	ld	a,(OFST+1,sp)
2000                     ; 495         default:
2000                     ; 496             break;
2001  005c a00c          	sub	a,#12
2002  005e 270a          	jreq	L156
2003  0060 a010          	sub	a,#16
2004  0062 260a          	jrne	L517
2005                     ; 489         case CLK_IT_SWIF: /* Disable the clock switch interrupt */
2005                     ; 490             CLK->SWCR  &= (uint8_t)(~CLK_SWCR_SWIEN);
2007  0064 721550c5      	bres	20677,#2
2008                     ; 491             break;
2010  0068 2004          	jra	L517
2011  006a               L156:
2012                     ; 492         case CLK_IT_CSSD: /* Disable the clock security system detection interrupt */
2012                     ; 493             CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSDIE);
2014  006a 721550c8      	bres	20680,#2
2015                     ; 494             break;
2016  006e               L517:
2017                     ; 500 }
2020  006e 85            	popw	x
2021  006f 81            	ret
2022  0070               L356:
2023                     ; 495         default:
2023                     ; 496             break;
2025  0070 20fc          	jra	L517
2026  0072               L127:
2027  0072 20fa          	jra	L517
2063                     ; 507 void CLK_SYSCLKConfig(CLK_Prescaler_TypeDef CLK_Prescaler)
2063                     ; 508 {
2064                     .text:	section	.text,new
2065  0000               _CLK_SYSCLKConfig:
2067  0000 88            	push	a
2068       00000000      OFST:	set	0
2071                     ; 511     assert_param(IS_CLK_PRESCALER_OK(CLK_Prescaler));
2073  0001 4d            	tnz	a
2074  0002 272c          	jreq	L032
2075  0004 a108          	cp	a,#8
2076  0006 2728          	jreq	L032
2077  0008 a110          	cp	a,#16
2078  000a 2724          	jreq	L032
2079  000c a118          	cp	a,#24
2080  000e 2720          	jreq	L032
2081  0010 a180          	cp	a,#128
2082  0012 271c          	jreq	L032
2083  0014 a181          	cp	a,#129
2084  0016 2718          	jreq	L032
2085  0018 a182          	cp	a,#130
2086  001a 2714          	jreq	L032
2087  001c a183          	cp	a,#131
2088  001e 2710          	jreq	L032
2089  0020 a184          	cp	a,#132
2090  0022 270c          	jreq	L032
2091  0024 a185          	cp	a,#133
2092  0026 2708          	jreq	L032
2093  0028 a186          	cp	a,#134
2094  002a 2704          	jreq	L032
2095  002c a187          	cp	a,#135
2096  002e 2603          	jrne	L622
2097  0030               L032:
2098  0030 4f            	clr	a
2099  0031 2010          	jra	L232
2100  0033               L622:
2101  0033 ae01ff        	ldw	x,#511
2102  0036 89            	pushw	x
2103  0037 ae0000        	ldw	x,#0
2104  003a 89            	pushw	x
2105  003b ae000c        	ldw	x,#L75
2106  003e cd0000        	call	_assert_failed
2108  0041 5b04          	addw	sp,#4
2109  0043               L232:
2110                     ; 513     if (((uint8_t)CLK_Prescaler & (uint8_t)0x80) == 0x00) /* Bit7 = 0 means HSI divider */
2112  0043 7b01          	ld	a,(OFST+1,sp)
2113  0045 a580          	bcp	a,#128
2114  0047 2614          	jrne	L147
2115                     ; 515         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
2117  0049 c650c6        	ld	a,20678
2118  004c a4e7          	and	a,#231
2119  004e c750c6        	ld	20678,a
2120                     ; 516         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_HSIDIV);
2122  0051 7b01          	ld	a,(OFST+1,sp)
2123  0053 a418          	and	a,#24
2124  0055 ca50c6        	or	a,20678
2125  0058 c750c6        	ld	20678,a
2127  005b 2012          	jra	L347
2128  005d               L147:
2129                     ; 520         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_CPUDIV);
2131  005d c650c6        	ld	a,20678
2132  0060 a4f8          	and	a,#248
2133  0062 c750c6        	ld	20678,a
2134                     ; 521         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_CPUDIV);
2136  0065 7b01          	ld	a,(OFST+1,sp)
2137  0067 a407          	and	a,#7
2138  0069 ca50c6        	or	a,20678
2139  006c c750c6        	ld	20678,a
2140  006f               L347:
2141                     ; 524 }
2144  006f 84            	pop	a
2145  0070 81            	ret
2202                     ; 531 void CLK_SWIMConfig(CLK_SWIMDivider_TypeDef CLK_SWIMDivider)
2202                     ; 532 {
2203                     .text:	section	.text,new
2204  0000               _CLK_SWIMConfig:
2206  0000 88            	push	a
2207       00000000      OFST:	set	0
2210                     ; 535     assert_param(IS_CLK_SWIMDIVIDER_OK(CLK_SWIMDivider));
2212  0001 4d            	tnz	a
2213  0002 2704          	jreq	L042
2214  0004 a101          	cp	a,#1
2215  0006 2603          	jrne	L632
2216  0008               L042:
2217  0008 4f            	clr	a
2218  0009 2010          	jra	L242
2219  000b               L632:
2220  000b ae0217        	ldw	x,#535
2221  000e 89            	pushw	x
2222  000f ae0000        	ldw	x,#0
2223  0012 89            	pushw	x
2224  0013 ae000c        	ldw	x,#L75
2225  0016 cd0000        	call	_assert_failed
2227  0019 5b04          	addw	sp,#4
2228  001b               L242:
2229                     ; 537     if (CLK_SWIMDivider != CLK_SWIMDIVIDER_2)
2231  001b 0d01          	tnz	(OFST+1,sp)
2232  001d 2706          	jreq	L377
2233                     ; 540         CLK->SWIMCCR |= CLK_SWIMCCR_SWIMDIV;
2235  001f 721050cd      	bset	20685,#0
2237  0023 2004          	jra	L577
2238  0025               L377:
2239                     ; 545         CLK->SWIMCCR &= (uint8_t)(~CLK_SWIMCCR_SWIMDIV);
2241  0025 721150cd      	bres	20685,#0
2242  0029               L577:
2243                     ; 548 }
2246  0029 84            	pop	a
2247  002a 81            	ret
2271                     ; 557 void CLK_ClockSecuritySystemEnable(void)
2271                     ; 558 {
2272                     .text:	section	.text,new
2273  0000               _CLK_ClockSecuritySystemEnable:
2277                     ; 560     CLK->CSSR |= CLK_CSSR_CSSEN;
2279  0000 721050c8      	bset	20680,#0
2280                     ; 561 }
2283  0004 81            	ret
2308                     ; 569 CLK_Source_TypeDef CLK_GetSYSCLKSource(void)
2308                     ; 570 {
2309                     .text:	section	.text,new
2310  0000               _CLK_GetSYSCLKSource:
2314                     ; 571     return((CLK_Source_TypeDef)CLK->CMSR);
2316  0000 c650c3        	ld	a,20675
2319  0003 81            	ret
2382                     ; 579 uint32_t CLK_GetClockFreq(void)
2382                     ; 580 {
2383                     .text:	section	.text,new
2384  0000               _CLK_GetClockFreq:
2386  0000 5209          	subw	sp,#9
2387       00000009      OFST:	set	9
2390                     ; 582     uint32_t clockfrequency = 0;
2392                     ; 583     CLK_Source_TypeDef clocksource = CLK_SOURCE_HSI;
2394                     ; 584     uint8_t tmp = 0, presc = 0;
2398                     ; 587     clocksource = (CLK_Source_TypeDef)CLK->CMSR;
2400  0002 c650c3        	ld	a,20675
2401  0005 6b09          	ld	(OFST+0,sp),a
2402                     ; 589     if (clocksource == CLK_SOURCE_HSI)
2404  0007 7b09          	ld	a,(OFST+0,sp)
2405  0009 a1e1          	cp	a,#225
2406  000b 2641          	jrne	L1501
2407                     ; 591         tmp = (uint8_t)(CLK->CKDIVR & CLK_CKDIVR_HSIDIV);
2409  000d c650c6        	ld	a,20678
2410  0010 a418          	and	a,#24
2411  0012 6b09          	ld	(OFST+0,sp),a
2412                     ; 592         tmp = (uint8_t)(tmp >> 3);
2414  0014 0409          	srl	(OFST+0,sp)
2415  0016 0409          	srl	(OFST+0,sp)
2416  0018 0409          	srl	(OFST+0,sp)
2417                     ; 593         presc = HSIDivFactor[tmp];
2419  001a 7b09          	ld	a,(OFST+0,sp)
2420  001c 5f            	clrw	x
2421  001d 97            	ld	xl,a
2422  001e d60000        	ld	a,(_HSIDivFactor,x)
2423  0021 6b09          	ld	(OFST+0,sp),a
2424                     ; 594         clockfrequency = HSI_VALUE / presc;
2426  0023 7b09          	ld	a,(OFST+0,sp)
2427  0025 b703          	ld	c_lreg+3,a
2428  0027 3f02          	clr	c_lreg+2
2429  0029 3f01          	clr	c_lreg+1
2430  002b 3f00          	clr	c_lreg
2431  002d 96            	ldw	x,sp
2432  002e 1c0001        	addw	x,#OFST-8
2433  0031 cd0000        	call	c_rtol
2435  0034 ae2400        	ldw	x,#9216
2436  0037 bf02          	ldw	c_lreg+2,x
2437  0039 ae00f4        	ldw	x,#244
2438  003c bf00          	ldw	c_lreg,x
2439  003e 96            	ldw	x,sp
2440  003f 1c0001        	addw	x,#OFST-8
2441  0042 cd0000        	call	c_ludv
2443  0045 96            	ldw	x,sp
2444  0046 1c0005        	addw	x,#OFST-4
2445  0049 cd0000        	call	c_rtol
2448  004c 201c          	jra	L3501
2449  004e               L1501:
2450                     ; 596     else if ( clocksource == CLK_SOURCE_LSI)
2452  004e 7b09          	ld	a,(OFST+0,sp)
2453  0050 a1d2          	cp	a,#210
2454  0052 260c          	jrne	L5501
2455                     ; 598         clockfrequency = LSI_VALUE;
2457  0054 aef400        	ldw	x,#62464
2458  0057 1f07          	ldw	(OFST-2,sp),x
2459  0059 ae0001        	ldw	x,#1
2460  005c 1f05          	ldw	(OFST-4,sp),x
2462  005e 200a          	jra	L3501
2463  0060               L5501:
2464                     ; 602         clockfrequency = HSE_VALUE;
2466  0060 ae2400        	ldw	x,#9216
2467  0063 1f07          	ldw	(OFST-2,sp),x
2468  0065 ae00f4        	ldw	x,#244
2469  0068 1f05          	ldw	(OFST-4,sp),x
2470  006a               L3501:
2471                     ; 605     return((uint32_t)clockfrequency);
2473  006a 96            	ldw	x,sp
2474  006b 1c0005        	addw	x,#OFST-4
2475  006e cd0000        	call	c_ltor
2479  0071 5b09          	addw	sp,#9
2480  0073 81            	ret
2580                     ; 616 void CLK_AdjustHSICalibrationValue(CLK_HSITrimValue_TypeDef CLK_HSICalibrationValue)
2580                     ; 617 {
2581                     .text:	section	.text,new
2582  0000               _CLK_AdjustHSICalibrationValue:
2584  0000 88            	push	a
2585       00000000      OFST:	set	0
2588                     ; 620     assert_param(IS_CLK_HSITRIMVALUE_OK(CLK_HSICalibrationValue));
2590  0001 4d            	tnz	a
2591  0002 271c          	jreq	L652
2592  0004 a101          	cp	a,#1
2593  0006 2718          	jreq	L652
2594  0008 a102          	cp	a,#2
2595  000a 2714          	jreq	L652
2596  000c a103          	cp	a,#3
2597  000e 2710          	jreq	L652
2598  0010 a104          	cp	a,#4
2599  0012 270c          	jreq	L652
2600  0014 a105          	cp	a,#5
2601  0016 2708          	jreq	L652
2602  0018 a106          	cp	a,#6
2603  001a 2704          	jreq	L652
2604  001c a107          	cp	a,#7
2605  001e 2603          	jrne	L452
2606  0020               L652:
2607  0020 4f            	clr	a
2608  0021 2010          	jra	L062
2609  0023               L452:
2610  0023 ae026c        	ldw	x,#620
2611  0026 89            	pushw	x
2612  0027 ae0000        	ldw	x,#0
2613  002a 89            	pushw	x
2614  002b ae000c        	ldw	x,#L75
2615  002e cd0000        	call	_assert_failed
2617  0031 5b04          	addw	sp,#4
2618  0033               L062:
2619                     ; 623     CLK->HSITRIMR = (uint8_t)( (uint8_t)(CLK->HSITRIMR & (uint8_t)(~CLK_HSITRIMR_HSITRIM))|((uint8_t)CLK_HSICalibrationValue));
2621  0033 c650cc        	ld	a,20684
2622  0036 a4f8          	and	a,#248
2623  0038 1a01          	or	a,(OFST+1,sp)
2624  003a c750cc        	ld	20684,a
2625                     ; 625 }
2628  003d 84            	pop	a
2629  003e 81            	ret
2653                     ; 636 void CLK_SYSCLKEmergencyClear(void)
2653                     ; 637 {
2654                     .text:	section	.text,new
2655  0000               _CLK_SYSCLKEmergencyClear:
2659                     ; 638     CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWBSY);
2661  0000 721150c5      	bres	20677,#0
2662                     ; 639 }
2665  0004 81            	ret
2819                     ; 648 FlagStatus CLK_GetFlagStatus(CLK_Flag_TypeDef CLK_FLAG)
2819                     ; 649 {
2820                     .text:	section	.text,new
2821  0000               _CLK_GetFlagStatus:
2823  0000 89            	pushw	x
2824  0001 5203          	subw	sp,#3
2825       00000003      OFST:	set	3
2828                     ; 651     uint16_t statusreg = 0;
2830                     ; 652     uint8_t tmpreg = 0;
2832                     ; 653     FlagStatus bitstatus = RESET;
2834                     ; 656     assert_param(IS_CLK_FLAG_OK(CLK_FLAG));
2836  0003 a30110        	cpw	x,#272
2837  0006 2728          	jreq	L072
2838  0008 a30102        	cpw	x,#258
2839  000b 2723          	jreq	L072
2840  000d a30202        	cpw	x,#514
2841  0010 271e          	jreq	L072
2842  0012 a30308        	cpw	x,#776
2843  0015 2719          	jreq	L072
2844  0017 a30301        	cpw	x,#769
2845  001a 2714          	jreq	L072
2846  001c a30408        	cpw	x,#1032
2847  001f 270f          	jreq	L072
2848  0021 a30402        	cpw	x,#1026
2849  0024 270a          	jreq	L072
2850  0026 a30504        	cpw	x,#1284
2851  0029 2705          	jreq	L072
2852  002b a30502        	cpw	x,#1282
2853  002e 2603          	jrne	L662
2854  0030               L072:
2855  0030 4f            	clr	a
2856  0031 2010          	jra	L272
2857  0033               L662:
2858  0033 ae0290        	ldw	x,#656
2859  0036 89            	pushw	x
2860  0037 ae0000        	ldw	x,#0
2861  003a 89            	pushw	x
2862  003b ae000c        	ldw	x,#L75
2863  003e cd0000        	call	_assert_failed
2865  0041 5b04          	addw	sp,#4
2866  0043               L272:
2867                     ; 659     statusreg = (uint16_t)((uint16_t)CLK_FLAG & (uint16_t)0xFF00);
2869  0043 7b04          	ld	a,(OFST+1,sp)
2870  0045 97            	ld	xl,a
2871  0046 7b05          	ld	a,(OFST+2,sp)
2872  0048 9f            	ld	a,xl
2873  0049 a4ff          	and	a,#255
2874  004b 97            	ld	xl,a
2875  004c 4f            	clr	a
2876  004d 02            	rlwa	x,a
2877  004e 1f01          	ldw	(OFST-2,sp),x
2878  0050 01            	rrwa	x,a
2879                     ; 662     if (statusreg == 0x0100) /* The flag to check is in ICKRregister */
2881  0051 1e01          	ldw	x,(OFST-2,sp)
2882  0053 a30100        	cpw	x,#256
2883  0056 2607          	jrne	L3221
2884                     ; 664         tmpreg = CLK->ICKR;
2886  0058 c650c0        	ld	a,20672
2887  005b 6b03          	ld	(OFST+0,sp),a
2889  005d 202f          	jra	L5221
2890  005f               L3221:
2891                     ; 666     else if (statusreg == 0x0200) /* The flag to check is in ECKRregister */
2893  005f 1e01          	ldw	x,(OFST-2,sp)
2894  0061 a30200        	cpw	x,#512
2895  0064 2607          	jrne	L7221
2896                     ; 668         tmpreg = CLK->ECKR;
2898  0066 c650c1        	ld	a,20673
2899  0069 6b03          	ld	(OFST+0,sp),a
2901  006b 2021          	jra	L5221
2902  006d               L7221:
2903                     ; 670     else if (statusreg == 0x0300) /* The flag to check is in SWIC register */
2905  006d 1e01          	ldw	x,(OFST-2,sp)
2906  006f a30300        	cpw	x,#768
2907  0072 2607          	jrne	L3321
2908                     ; 672         tmpreg = CLK->SWCR;
2910  0074 c650c5        	ld	a,20677
2911  0077 6b03          	ld	(OFST+0,sp),a
2913  0079 2013          	jra	L5221
2914  007b               L3321:
2915                     ; 674     else if (statusreg == 0x0400) /* The flag to check is in CSS register */
2917  007b 1e01          	ldw	x,(OFST-2,sp)
2918  007d a30400        	cpw	x,#1024
2919  0080 2607          	jrne	L7321
2920                     ; 676         tmpreg = CLK->CSSR;
2922  0082 c650c8        	ld	a,20680
2923  0085 6b03          	ld	(OFST+0,sp),a
2925  0087 2005          	jra	L5221
2926  0089               L7321:
2927                     ; 680         tmpreg = CLK->CCOR;
2929  0089 c650c9        	ld	a,20681
2930  008c 6b03          	ld	(OFST+0,sp),a
2931  008e               L5221:
2932                     ; 683     if ((tmpreg & (uint8_t)CLK_FLAG) != (uint8_t)RESET)
2934  008e 7b05          	ld	a,(OFST+2,sp)
2935  0090 1503          	bcp	a,(OFST+0,sp)
2936  0092 2706          	jreq	L3421
2937                     ; 685         bitstatus = SET;
2939  0094 a601          	ld	a,#1
2940  0096 6b03          	ld	(OFST+0,sp),a
2942  0098 2002          	jra	L5421
2943  009a               L3421:
2944                     ; 689         bitstatus = RESET;
2946  009a 0f03          	clr	(OFST+0,sp)
2947  009c               L5421:
2948                     ; 693     return((FlagStatus)bitstatus);
2950  009c 7b03          	ld	a,(OFST+0,sp)
2953  009e 5b05          	addw	sp,#5
2954  00a0 81            	ret
3001                     ; 703 ITStatus CLK_GetITStatus(CLK_IT_TypeDef CLK_IT)
3001                     ; 704 {
3002                     .text:	section	.text,new
3003  0000               _CLK_GetITStatus:
3005  0000 88            	push	a
3006  0001 88            	push	a
3007       00000001      OFST:	set	1
3010                     ; 706     ITStatus bitstatus = RESET;
3012                     ; 709     assert_param(IS_CLK_IT_OK(CLK_IT));
3014  0002 a10c          	cp	a,#12
3015  0004 2704          	jreq	L003
3016  0006 a11c          	cp	a,#28
3017  0008 2603          	jrne	L672
3018  000a               L003:
3019  000a 4f            	clr	a
3020  000b 2010          	jra	L203
3021  000d               L672:
3022  000d ae02c5        	ldw	x,#709
3023  0010 89            	pushw	x
3024  0011 ae0000        	ldw	x,#0
3025  0014 89            	pushw	x
3026  0015 ae000c        	ldw	x,#L75
3027  0018 cd0000        	call	_assert_failed
3029  001b 5b04          	addw	sp,#4
3030  001d               L203:
3031                     ; 711     if (CLK_IT == CLK_IT_SWIF)
3033  001d 7b02          	ld	a,(OFST+1,sp)
3034  001f a11c          	cp	a,#28
3035  0021 2613          	jrne	L1721
3036                     ; 714         if ((CLK->SWCR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
3038  0023 c650c5        	ld	a,20677
3039  0026 1402          	and	a,(OFST+1,sp)
3040  0028 a10c          	cp	a,#12
3041  002a 2606          	jrne	L3721
3042                     ; 716             bitstatus = SET;
3044  002c a601          	ld	a,#1
3045  002e 6b01          	ld	(OFST+0,sp),a
3047  0030 2015          	jra	L7721
3048  0032               L3721:
3049                     ; 720             bitstatus = RESET;
3051  0032 0f01          	clr	(OFST+0,sp)
3052  0034 2011          	jra	L7721
3053  0036               L1721:
3054                     ; 726         if ((CLK->CSSR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
3056  0036 c650c8        	ld	a,20680
3057  0039 1402          	and	a,(OFST+1,sp)
3058  003b a10c          	cp	a,#12
3059  003d 2606          	jrne	L1031
3060                     ; 728             bitstatus = SET;
3062  003f a601          	ld	a,#1
3063  0041 6b01          	ld	(OFST+0,sp),a
3065  0043 2002          	jra	L7721
3066  0045               L1031:
3067                     ; 732             bitstatus = RESET;
3069  0045 0f01          	clr	(OFST+0,sp)
3070  0047               L7721:
3071                     ; 737     return bitstatus;
3073  0047 7b01          	ld	a,(OFST+0,sp)
3076  0049 85            	popw	x
3077  004a 81            	ret
3114                     ; 747 void CLK_ClearITPendingBit(CLK_IT_TypeDef CLK_IT)
3114                     ; 748 {
3115                     .text:	section	.text,new
3116  0000               _CLK_ClearITPendingBit:
3118  0000 88            	push	a
3119       00000000      OFST:	set	0
3122                     ; 751     assert_param(IS_CLK_IT_OK(CLK_IT));
3124  0001 a10c          	cp	a,#12
3125  0003 2704          	jreq	L013
3126  0005 a11c          	cp	a,#28
3127  0007 2603          	jrne	L603
3128  0009               L013:
3129  0009 4f            	clr	a
3130  000a 2010          	jra	L213
3131  000c               L603:
3132  000c ae02ef        	ldw	x,#751
3133  000f 89            	pushw	x
3134  0010 ae0000        	ldw	x,#0
3135  0013 89            	pushw	x
3136  0014 ae000c        	ldw	x,#L75
3137  0017 cd0000        	call	_assert_failed
3139  001a 5b04          	addw	sp,#4
3140  001c               L213:
3141                     ; 753     if (CLK_IT == (uint8_t)CLK_IT_CSSD)
3143  001c 7b01          	ld	a,(OFST+1,sp)
3144  001e a10c          	cp	a,#12
3145  0020 2606          	jrne	L3231
3146                     ; 756         CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSD);
3148  0022 721750c8      	bres	20680,#3
3150  0026 2004          	jra	L5231
3151  0028               L3231:
3152                     ; 761         CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIF);
3154  0028 721750c5      	bres	20677,#3
3155  002c               L5231:
3156                     ; 764 }
3159  002c 84            	pop	a
3160  002d 81            	ret
3195                     	xdef	_CLKPrescTable
3196                     	xdef	_HSIDivFactor
3197                     	xdef	_CLK_ClearITPendingBit
3198                     	xdef	_CLK_GetITStatus
3199                     	xdef	_CLK_GetFlagStatus
3200                     	xdef	_CLK_GetSYSCLKSource
3201                     	xdef	_CLK_GetClockFreq
3202                     	xdef	_CLK_AdjustHSICalibrationValue
3203                     	xdef	_CLK_SYSCLKEmergencyClear
3204                     	xdef	_CLK_ClockSecuritySystemEnable
3205                     	xdef	_CLK_SWIMConfig
3206                     	xdef	_CLK_SYSCLKConfig
3207                     	xdef	_CLK_ITConfig
3208                     	xdef	_CLK_CCOConfig
3209                     	xdef	_CLK_HSIPrescalerConfig
3210                     	xdef	_CLK_ClockSwitchConfig
3211                     	xdef	_CLK_PeripheralClockConfig
3212                     	xdef	_CLK_SlowActiveHaltWakeUpCmd
3213                     	xdef	_CLK_FastHaltWakeUpCmd
3214                     	xdef	_CLK_ClockSwitchCmd
3215                     	xdef	_CLK_CCOCmd
3216                     	xdef	_CLK_LSICmd
3217                     	xdef	_CLK_HSICmd
3218                     	xdef	_CLK_HSECmd
3219                     	xdef	_CLK_DeInit
3220                     	xref	_assert_failed
3221                     	switch	.const
3222  000c               L75:
3223  000c 2e2e5c73746d  	dc.b	"..\stm8s_stdperiph"
3224  001e 5f6472697665  	dc.b	"_driver\src\stm8s_"
3225  0030 636c6b2e6300  	dc.b	"clk.c",0
3226                     	xref.b	c_lreg
3227                     	xref.b	c_x
3247                     	xref	c_ltor
3248                     	xref	c_ludv
3249                     	xref	c_rtol
3250                     	end
