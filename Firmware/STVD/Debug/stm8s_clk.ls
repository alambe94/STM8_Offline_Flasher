   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.12 - 20 Jun 2018
   3                     ; Generator (Limited) V4.4.8 - 20 Jun 2018
  15                     .const:	section	.text
  16  0000               _HSIDivFactor:
  17  0000 01            	dc.b	1
  18  0001 02            	dc.b	2
  19  0002 04            	dc.b	4
  20  0003 08            	dc.b	8
  21  0004               _CLKPrescTable:
  22  0004 01            	dc.b	1
  23  0005 02            	dc.b	2
  24  0006 04            	dc.b	4
  25  0007 08            	dc.b	8
  26  0008 0a            	dc.b	10
  27  0009 10            	dc.b	16
  28  000a 14            	dc.b	20
  29  000b 28            	dc.b	40
  58                     ; 66 void CLK_DeInit(void)
  58                     ; 67 {
  60                     	switch	.text
  61  0000               _CLK_DeInit:
  65                     ; 69     CLK->ICKR = CLK_ICKR_RESET_VALUE;
  67  0000 350150c0      	mov	20672,#1
  68                     ; 70     CLK->ECKR = CLK_ECKR_RESET_VALUE;
  70  0004 725f50c1      	clr	20673
  71                     ; 71     CLK->SWR  = CLK_SWR_RESET_VALUE;
  73  0008 35e150c4      	mov	20676,#225
  74                     ; 72     CLK->SWCR = CLK_SWCR_RESET_VALUE;
  76  000c 725f50c5      	clr	20677
  77                     ; 73     CLK->CKDIVR = CLK_CKDIVR_RESET_VALUE;
  79  0010 351850c6      	mov	20678,#24
  80                     ; 74     CLK->PCKENR1 = CLK_PCKENR1_RESET_VALUE;
  82  0014 35ff50c7      	mov	20679,#255
  83                     ; 75     CLK->PCKENR2 = CLK_PCKENR2_RESET_VALUE;
  85  0018 35ff50ca      	mov	20682,#255
  86                     ; 76     CLK->CSSR = CLK_CSSR_RESET_VALUE;
  88  001c 725f50c8      	clr	20680
  89                     ; 77     CLK->CCOR = CLK_CCOR_RESET_VALUE;
  91  0020 725f50c9      	clr	20681
  93  0024               L52:
  94                     ; 78     while ((CLK->CCOR & CLK_CCOR_CCOEN)!= 0)
  96  0024 c650c9        	ld	a,20681
  97  0027 a501          	bcp	a,#1
  98  0029 26f9          	jrne	L52
  99                     ; 80     CLK->CCOR = CLK_CCOR_RESET_VALUE;
 101  002b 725f50c9      	clr	20681
 102                     ; 81     CLK->HSITRIMR = CLK_HSITRIMR_RESET_VALUE;
 104  002f 725f50cc      	clr	20684
 105                     ; 82     CLK->SWIMCCR = CLK_SWIMCCR_RESET_VALUE;
 107  0033 725f50cd      	clr	20685
 108                     ; 84 }
 111  0037 81            	ret
 168                     ; 95 void CLK_FastHaltWakeUpCmd(FunctionalState NewState)
 168                     ; 96 {
 169                     	switch	.text
 170  0038               _CLK_FastHaltWakeUpCmd:
 172  0038 88            	push	a
 173       00000000      OFST:	set	0
 176                     ; 99     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 178  0039 4d            	tnz	a
 179  003a 2704          	jreq	L21
 180  003c a101          	cp	a,#1
 181  003e 2603          	jrne	L01
 182  0040               L21:
 183  0040 4f            	clr	a
 184  0041 2010          	jra	L41
 185  0043               L01:
 186  0043 ae0063        	ldw	x,#99
 187  0046 89            	pushw	x
 188  0047 ae0000        	ldw	x,#0
 189  004a 89            	pushw	x
 190  004b ae000c        	ldw	x,#L75
 191  004e cd0000        	call	_assert_failed
 193  0051 5b04          	addw	sp,#4
 194  0053               L41:
 195                     ; 101     if (NewState != DISABLE)
 197  0053 0d01          	tnz	(OFST+1,sp)
 198  0055 2706          	jreq	L16
 199                     ; 104         CLK->ICKR |= CLK_ICKR_FHWU;
 201  0057 721450c0      	bset	20672,#2
 203  005b 2004          	jra	L36
 204  005d               L16:
 205                     ; 109         CLK->ICKR &= (uint8_t)(~CLK_ICKR_FHWU);
 207  005d 721550c0      	bres	20672,#2
 208  0061               L36:
 209                     ; 112 }
 212  0061 84            	pop	a
 213  0062 81            	ret
 249                     ; 119 void CLK_HSECmd(FunctionalState NewState)
 249                     ; 120 {
 250                     	switch	.text
 251  0063               _CLK_HSECmd:
 253  0063 88            	push	a
 254       00000000      OFST:	set	0
 257                     ; 123     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 259  0064 4d            	tnz	a
 260  0065 2704          	jreq	L22
 261  0067 a101          	cp	a,#1
 262  0069 2603          	jrne	L02
 263  006b               L22:
 264  006b 4f            	clr	a
 265  006c 2010          	jra	L42
 266  006e               L02:
 267  006e ae007b        	ldw	x,#123
 268  0071 89            	pushw	x
 269  0072 ae0000        	ldw	x,#0
 270  0075 89            	pushw	x
 271  0076 ae000c        	ldw	x,#L75
 272  0079 cd0000        	call	_assert_failed
 274  007c 5b04          	addw	sp,#4
 275  007e               L42:
 276                     ; 125     if (NewState != DISABLE)
 278  007e 0d01          	tnz	(OFST+1,sp)
 279  0080 2706          	jreq	L301
 280                     ; 128         CLK->ECKR |= CLK_ECKR_HSEEN;
 282  0082 721050c1      	bset	20673,#0
 284  0086 2004          	jra	L501
 285  0088               L301:
 286                     ; 133         CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
 288  0088 721150c1      	bres	20673,#0
 289  008c               L501:
 290                     ; 136 }
 293  008c 84            	pop	a
 294  008d 81            	ret
 330                     ; 143 void CLK_HSICmd(FunctionalState NewState)
 330                     ; 144 {
 331                     	switch	.text
 332  008e               _CLK_HSICmd:
 334  008e 88            	push	a
 335       00000000      OFST:	set	0
 338                     ; 147     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 340  008f 4d            	tnz	a
 341  0090 2704          	jreq	L23
 342  0092 a101          	cp	a,#1
 343  0094 2603          	jrne	L03
 344  0096               L23:
 345  0096 4f            	clr	a
 346  0097 2010          	jra	L43
 347  0099               L03:
 348  0099 ae0093        	ldw	x,#147
 349  009c 89            	pushw	x
 350  009d ae0000        	ldw	x,#0
 351  00a0 89            	pushw	x
 352  00a1 ae000c        	ldw	x,#L75
 353  00a4 cd0000        	call	_assert_failed
 355  00a7 5b04          	addw	sp,#4
 356  00a9               L43:
 357                     ; 149     if (NewState != DISABLE)
 359  00a9 0d01          	tnz	(OFST+1,sp)
 360  00ab 2706          	jreq	L521
 361                     ; 152         CLK->ICKR |= CLK_ICKR_HSIEN;
 363  00ad 721050c0      	bset	20672,#0
 365  00b1 2004          	jra	L721
 366  00b3               L521:
 367                     ; 157         CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
 369  00b3 721150c0      	bres	20672,#0
 370  00b7               L721:
 371                     ; 160 }
 374  00b7 84            	pop	a
 375  00b8 81            	ret
 411                     ; 167 void CLK_LSICmd(FunctionalState NewState)
 411                     ; 168 {
 412                     	switch	.text
 413  00b9               _CLK_LSICmd:
 415  00b9 88            	push	a
 416       00000000      OFST:	set	0
 419                     ; 171     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 421  00ba 4d            	tnz	a
 422  00bb 2704          	jreq	L24
 423  00bd a101          	cp	a,#1
 424  00bf 2603          	jrne	L04
 425  00c1               L24:
 426  00c1 4f            	clr	a
 427  00c2 2010          	jra	L44
 428  00c4               L04:
 429  00c4 ae00ab        	ldw	x,#171
 430  00c7 89            	pushw	x
 431  00c8 ae0000        	ldw	x,#0
 432  00cb 89            	pushw	x
 433  00cc ae000c        	ldw	x,#L75
 434  00cf cd0000        	call	_assert_failed
 436  00d2 5b04          	addw	sp,#4
 437  00d4               L44:
 438                     ; 173     if (NewState != DISABLE)
 440  00d4 0d01          	tnz	(OFST+1,sp)
 441  00d6 2706          	jreq	L741
 442                     ; 176         CLK->ICKR |= CLK_ICKR_LSIEN;
 444  00d8 721650c0      	bset	20672,#3
 446  00dc 2004          	jra	L151
 447  00de               L741:
 448                     ; 181         CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
 450  00de 721750c0      	bres	20672,#3
 451  00e2               L151:
 452                     ; 184 }
 455  00e2 84            	pop	a
 456  00e3 81            	ret
 492                     ; 192 void CLK_CCOCmd(FunctionalState NewState)
 492                     ; 193 {
 493                     	switch	.text
 494  00e4               _CLK_CCOCmd:
 496  00e4 88            	push	a
 497       00000000      OFST:	set	0
 500                     ; 196     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 502  00e5 4d            	tnz	a
 503  00e6 2704          	jreq	L25
 504  00e8 a101          	cp	a,#1
 505  00ea 2603          	jrne	L05
 506  00ec               L25:
 507  00ec 4f            	clr	a
 508  00ed 2010          	jra	L45
 509  00ef               L05:
 510  00ef ae00c4        	ldw	x,#196
 511  00f2 89            	pushw	x
 512  00f3 ae0000        	ldw	x,#0
 513  00f6 89            	pushw	x
 514  00f7 ae000c        	ldw	x,#L75
 515  00fa cd0000        	call	_assert_failed
 517  00fd 5b04          	addw	sp,#4
 518  00ff               L45:
 519                     ; 198     if (NewState != DISABLE)
 521  00ff 0d01          	tnz	(OFST+1,sp)
 522  0101 2706          	jreq	L171
 523                     ; 201         CLK->CCOR |= CLK_CCOR_CCOEN;
 525  0103 721050c9      	bset	20681,#0
 527  0107 2004          	jra	L371
 528  0109               L171:
 529                     ; 206         CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOEN);
 531  0109 721150c9      	bres	20681,#0
 532  010d               L371:
 533                     ; 209 }
 536  010d 84            	pop	a
 537  010e 81            	ret
 573                     ; 218 void CLK_ClockSwitchCmd(FunctionalState NewState)
 573                     ; 219 {
 574                     	switch	.text
 575  010f               _CLK_ClockSwitchCmd:
 577  010f 88            	push	a
 578       00000000      OFST:	set	0
 581                     ; 222     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 583  0110 4d            	tnz	a
 584  0111 2704          	jreq	L26
 585  0113 a101          	cp	a,#1
 586  0115 2603          	jrne	L06
 587  0117               L26:
 588  0117 4f            	clr	a
 589  0118 2010          	jra	L46
 590  011a               L06:
 591  011a ae00de        	ldw	x,#222
 592  011d 89            	pushw	x
 593  011e ae0000        	ldw	x,#0
 594  0121 89            	pushw	x
 595  0122 ae000c        	ldw	x,#L75
 596  0125 cd0000        	call	_assert_failed
 598  0128 5b04          	addw	sp,#4
 599  012a               L46:
 600                     ; 224     if (NewState != DISABLE )
 602  012a 0d01          	tnz	(OFST+1,sp)
 603  012c 2706          	jreq	L312
 604                     ; 227         CLK->SWCR |= CLK_SWCR_SWEN;
 606  012e 721250c5      	bset	20677,#1
 608  0132 2004          	jra	L512
 609  0134               L312:
 610                     ; 232         CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWEN);
 612  0134 721350c5      	bres	20677,#1
 613  0138               L512:
 614                     ; 235 }
 617  0138 84            	pop	a
 618  0139 81            	ret
 655                     ; 245 void CLK_SlowActiveHaltWakeUpCmd(FunctionalState NewState)
 655                     ; 246 {
 656                     	switch	.text
 657  013a               _CLK_SlowActiveHaltWakeUpCmd:
 659  013a 88            	push	a
 660       00000000      OFST:	set	0
 663                     ; 249     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 665  013b 4d            	tnz	a
 666  013c 2704          	jreq	L27
 667  013e a101          	cp	a,#1
 668  0140 2603          	jrne	L07
 669  0142               L27:
 670  0142 4f            	clr	a
 671  0143 2010          	jra	L47
 672  0145               L07:
 673  0145 ae00f9        	ldw	x,#249
 674  0148 89            	pushw	x
 675  0149 ae0000        	ldw	x,#0
 676  014c 89            	pushw	x
 677  014d ae000c        	ldw	x,#L75
 678  0150 cd0000        	call	_assert_failed
 680  0153 5b04          	addw	sp,#4
 681  0155               L47:
 682                     ; 251     if (NewState != DISABLE)
 684  0155 0d01          	tnz	(OFST+1,sp)
 685  0157 2706          	jreq	L532
 686                     ; 254         CLK->ICKR |= CLK_ICKR_SWUAH;
 688  0159 721a50c0      	bset	20672,#5
 690  015d 2004          	jra	L732
 691  015f               L532:
 692                     ; 259         CLK->ICKR &= (uint8_t)(~CLK_ICKR_SWUAH);
 694  015f 721b50c0      	bres	20672,#5
 695  0163               L732:
 696                     ; 262 }
 699  0163 84            	pop	a
 700  0164 81            	ret
 860                     ; 272 void CLK_PeripheralClockConfig(CLK_Peripheral_TypeDef CLK_Peripheral, FunctionalState NewState)
 860                     ; 273 {
 861                     	switch	.text
 862  0165               _CLK_PeripheralClockConfig:
 864  0165 89            	pushw	x
 865       00000000      OFST:	set	0
 868                     ; 276     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 870  0166 9f            	ld	a,xl
 871  0167 4d            	tnz	a
 872  0168 2705          	jreq	L201
 873  016a 9f            	ld	a,xl
 874  016b a101          	cp	a,#1
 875  016d 2603          	jrne	L001
 876  016f               L201:
 877  016f 4f            	clr	a
 878  0170 2010          	jra	L401
 879  0172               L001:
 880  0172 ae0114        	ldw	x,#276
 881  0175 89            	pushw	x
 882  0176 ae0000        	ldw	x,#0
 883  0179 89            	pushw	x
 884  017a ae000c        	ldw	x,#L75
 885  017d cd0000        	call	_assert_failed
 887  0180 5b04          	addw	sp,#4
 888  0182               L401:
 889                     ; 277     assert_param(IS_CLK_PERIPHERAL_OK(CLK_Peripheral));
 891  0182 0d01          	tnz	(OFST+1,sp)
 892  0184 274e          	jreq	L011
 893  0186 7b01          	ld	a,(OFST+1,sp)
 894  0188 a101          	cp	a,#1
 895  018a 2748          	jreq	L011
 896  018c 7b01          	ld	a,(OFST+1,sp)
 897  018e a103          	cp	a,#3
 898  0190 2742          	jreq	L011
 899  0192 7b01          	ld	a,(OFST+1,sp)
 900  0194 a103          	cp	a,#3
 901  0196 273c          	jreq	L011
 902  0198 7b01          	ld	a,(OFST+1,sp)
 903  019a a103          	cp	a,#3
 904  019c 2736          	jreq	L011
 905  019e 7b01          	ld	a,(OFST+1,sp)
 906  01a0 a104          	cp	a,#4
 907  01a2 2730          	jreq	L011
 908  01a4 7b01          	ld	a,(OFST+1,sp)
 909  01a6 a105          	cp	a,#5
 910  01a8 272a          	jreq	L011
 911  01aa 7b01          	ld	a,(OFST+1,sp)
 912  01ac a105          	cp	a,#5
 913  01ae 2724          	jreq	L011
 914  01b0 7b01          	ld	a,(OFST+1,sp)
 915  01b2 a104          	cp	a,#4
 916  01b4 271e          	jreq	L011
 917  01b6 7b01          	ld	a,(OFST+1,sp)
 918  01b8 a106          	cp	a,#6
 919  01ba 2718          	jreq	L011
 920  01bc 7b01          	ld	a,(OFST+1,sp)
 921  01be a107          	cp	a,#7
 922  01c0 2712          	jreq	L011
 923  01c2 7b01          	ld	a,(OFST+1,sp)
 924  01c4 a117          	cp	a,#23
 925  01c6 270c          	jreq	L011
 926  01c8 7b01          	ld	a,(OFST+1,sp)
 927  01ca a113          	cp	a,#19
 928  01cc 2706          	jreq	L011
 929  01ce 7b01          	ld	a,(OFST+1,sp)
 930  01d0 a112          	cp	a,#18
 931  01d2 2603          	jrne	L601
 932  01d4               L011:
 933  01d4 4f            	clr	a
 934  01d5 2010          	jra	L211
 935  01d7               L601:
 936  01d7 ae0115        	ldw	x,#277
 937  01da 89            	pushw	x
 938  01db ae0000        	ldw	x,#0
 939  01de 89            	pushw	x
 940  01df ae000c        	ldw	x,#L75
 941  01e2 cd0000        	call	_assert_failed
 943  01e5 5b04          	addw	sp,#4
 944  01e7               L211:
 945                     ; 279     if (((uint8_t)CLK_Peripheral & (uint8_t)0x10) == 0x00)
 947  01e7 7b01          	ld	a,(OFST+1,sp)
 948  01e9 a510          	bcp	a,#16
 949  01eb 2633          	jrne	L323
 950                     ; 281         if (NewState != DISABLE)
 952  01ed 0d02          	tnz	(OFST+2,sp)
 953  01ef 2717          	jreq	L523
 954                     ; 284             CLK->PCKENR1 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 956  01f1 7b01          	ld	a,(OFST+1,sp)
 957  01f3 a40f          	and	a,#15
 958  01f5 5f            	clrw	x
 959  01f6 97            	ld	xl,a
 960  01f7 a601          	ld	a,#1
 961  01f9 5d            	tnzw	x
 962  01fa 2704          	jreq	L411
 963  01fc               L611:
 964  01fc 48            	sll	a
 965  01fd 5a            	decw	x
 966  01fe 26fc          	jrne	L611
 967  0200               L411:
 968  0200 ca50c7        	or	a,20679
 969  0203 c750c7        	ld	20679,a
 971  0206 2049          	jra	L133
 972  0208               L523:
 973                     ; 289             CLK->PCKENR1 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 975  0208 7b01          	ld	a,(OFST+1,sp)
 976  020a a40f          	and	a,#15
 977  020c 5f            	clrw	x
 978  020d 97            	ld	xl,a
 979  020e a601          	ld	a,#1
 980  0210 5d            	tnzw	x
 981  0211 2704          	jreq	L021
 982  0213               L221:
 983  0213 48            	sll	a
 984  0214 5a            	decw	x
 985  0215 26fc          	jrne	L221
 986  0217               L021:
 987  0217 43            	cpl	a
 988  0218 c450c7        	and	a,20679
 989  021b c750c7        	ld	20679,a
 990  021e 2031          	jra	L133
 991  0220               L323:
 992                     ; 294         if (NewState != DISABLE)
 994  0220 0d02          	tnz	(OFST+2,sp)
 995  0222 2717          	jreq	L333
 996                     ; 297             CLK->PCKENR2 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 998  0224 7b01          	ld	a,(OFST+1,sp)
 999  0226 a40f          	and	a,#15
1000  0228 5f            	clrw	x
1001  0229 97            	ld	xl,a
1002  022a a601          	ld	a,#1
1003  022c 5d            	tnzw	x
1004  022d 2704          	jreq	L421
1005  022f               L621:
1006  022f 48            	sll	a
1007  0230 5a            	decw	x
1008  0231 26fc          	jrne	L621
1009  0233               L421:
1010  0233 ca50ca        	or	a,20682
1011  0236 c750ca        	ld	20682,a
1013  0239 2016          	jra	L133
1014  023b               L333:
1015                     ; 302             CLK->PCKENR2 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
1017  023b 7b01          	ld	a,(OFST+1,sp)
1018  023d a40f          	and	a,#15
1019  023f 5f            	clrw	x
1020  0240 97            	ld	xl,a
1021  0241 a601          	ld	a,#1
1022  0243 5d            	tnzw	x
1023  0244 2704          	jreq	L031
1024  0246               L231:
1025  0246 48            	sll	a
1026  0247 5a            	decw	x
1027  0248 26fc          	jrne	L231
1028  024a               L031:
1029  024a 43            	cpl	a
1030  024b c450ca        	and	a,20682
1031  024e c750ca        	ld	20682,a
1032  0251               L133:
1033                     ; 306 }
1036  0251 85            	popw	x
1037  0252 81            	ret
1226                     ; 319 ErrorStatus CLK_ClockSwitchConfig(CLK_SwitchMode_TypeDef CLK_SwitchMode, CLK_Source_TypeDef CLK_NewClock, FunctionalState ITState, CLK_CurrentClockState_TypeDef CLK_CurrentClockState)
1226                     ; 320 {
1227                     	switch	.text
1228  0253               _CLK_ClockSwitchConfig:
1230  0253 89            	pushw	x
1231  0254 5204          	subw	sp,#4
1232       00000004      OFST:	set	4
1235                     ; 323     uint16_t DownCounter = CLK_TIMEOUT;
1237  0256 ae0491        	ldw	x,#1169
1238  0259 1f03          	ldw	(OFST-1,sp),x
1240                     ; 324     ErrorStatus Swif = ERROR;
1242                     ; 327     assert_param(IS_CLK_SOURCE_OK(CLK_NewClock));
1244  025b 7b06          	ld	a,(OFST+2,sp)
1245  025d a1e1          	cp	a,#225
1246  025f 270c          	jreq	L041
1247  0261 7b06          	ld	a,(OFST+2,sp)
1248  0263 a1d2          	cp	a,#210
1249  0265 2706          	jreq	L041
1250  0267 7b06          	ld	a,(OFST+2,sp)
1251  0269 a1b4          	cp	a,#180
1252  026b 2603          	jrne	L631
1253  026d               L041:
1254  026d 4f            	clr	a
1255  026e 2010          	jra	L241
1256  0270               L631:
1257  0270 ae0147        	ldw	x,#327
1258  0273 89            	pushw	x
1259  0274 ae0000        	ldw	x,#0
1260  0277 89            	pushw	x
1261  0278 ae000c        	ldw	x,#L75
1262  027b cd0000        	call	_assert_failed
1264  027e 5b04          	addw	sp,#4
1265  0280               L241:
1266                     ; 328     assert_param(IS_CLK_SWITCHMODE_OK(CLK_SwitchMode));
1268  0280 0d05          	tnz	(OFST+1,sp)
1269  0282 2706          	jreq	L641
1270  0284 7b05          	ld	a,(OFST+1,sp)
1271  0286 a101          	cp	a,#1
1272  0288 2603          	jrne	L441
1273  028a               L641:
1274  028a 4f            	clr	a
1275  028b 2010          	jra	L051
1276  028d               L441:
1277  028d ae0148        	ldw	x,#328
1278  0290 89            	pushw	x
1279  0291 ae0000        	ldw	x,#0
1280  0294 89            	pushw	x
1281  0295 ae000c        	ldw	x,#L75
1282  0298 cd0000        	call	_assert_failed
1284  029b 5b04          	addw	sp,#4
1285  029d               L051:
1286                     ; 329     assert_param(IS_FUNCTIONALSTATE_OK(ITState));
1288  029d 0d09          	tnz	(OFST+5,sp)
1289  029f 2706          	jreq	L451
1290  02a1 7b09          	ld	a,(OFST+5,sp)
1291  02a3 a101          	cp	a,#1
1292  02a5 2603          	jrne	L251
1293  02a7               L451:
1294  02a7 4f            	clr	a
1295  02a8 2010          	jra	L651
1296  02aa               L251:
1297  02aa ae0149        	ldw	x,#329
1298  02ad 89            	pushw	x
1299  02ae ae0000        	ldw	x,#0
1300  02b1 89            	pushw	x
1301  02b2 ae000c        	ldw	x,#L75
1302  02b5 cd0000        	call	_assert_failed
1304  02b8 5b04          	addw	sp,#4
1305  02ba               L651:
1306                     ; 330     assert_param(IS_CLK_CURRENTCLOCKSTATE_OK(CLK_CurrentClockState));
1308  02ba 0d0a          	tnz	(OFST+6,sp)
1309  02bc 2706          	jreq	L261
1310  02be 7b0a          	ld	a,(OFST+6,sp)
1311  02c0 a101          	cp	a,#1
1312  02c2 2603          	jrne	L061
1313  02c4               L261:
1314  02c4 4f            	clr	a
1315  02c5 2010          	jra	L461
1316  02c7               L061:
1317  02c7 ae014a        	ldw	x,#330
1318  02ca 89            	pushw	x
1319  02cb ae0000        	ldw	x,#0
1320  02ce 89            	pushw	x
1321  02cf ae000c        	ldw	x,#L75
1322  02d2 cd0000        	call	_assert_failed
1324  02d5 5b04          	addw	sp,#4
1325  02d7               L461:
1326                     ; 333     clock_master = (CLK_Source_TypeDef)CLK->CMSR;
1328  02d7 c650c3        	ld	a,20675
1329  02da 6b01          	ld	(OFST-3,sp),a
1331                     ; 336     if (CLK_SwitchMode == CLK_SWITCHMODE_AUTO)
1333  02dc 7b05          	ld	a,(OFST+1,sp)
1334  02de a101          	cp	a,#1
1335  02e0 2639          	jrne	L744
1336                     ; 340         CLK->SWCR |= CLK_SWCR_SWEN;
1338  02e2 721250c5      	bset	20677,#1
1339                     ; 343         if (ITState != DISABLE)
1341  02e6 0d09          	tnz	(OFST+5,sp)
1342  02e8 2706          	jreq	L154
1343                     ; 345             CLK->SWCR |= CLK_SWCR_SWIEN;
1345  02ea 721450c5      	bset	20677,#2
1347  02ee 2004          	jra	L354
1348  02f0               L154:
1349                     ; 349             CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1351  02f0 721550c5      	bres	20677,#2
1352  02f4               L354:
1353                     ; 353         CLK->SWR = (uint8_t)CLK_NewClock;
1355  02f4 7b06          	ld	a,(OFST+2,sp)
1356  02f6 c750c4        	ld	20676,a
1358  02f9 2007          	jra	L164
1359  02fb               L554:
1360                     ; 357             DownCounter--;
1362  02fb 1e03          	ldw	x,(OFST-1,sp)
1363  02fd 1d0001        	subw	x,#1
1364  0300 1f03          	ldw	(OFST-1,sp),x
1366  0302               L164:
1367                     ; 355         while ((((CLK->SWCR & CLK_SWCR_SWBSY) != 0 )&& (DownCounter != 0)))
1369  0302 c650c5        	ld	a,20677
1370  0305 a501          	bcp	a,#1
1371  0307 2704          	jreq	L564
1373  0309 1e03          	ldw	x,(OFST-1,sp)
1374  030b 26ee          	jrne	L554
1375  030d               L564:
1376                     ; 360         if (DownCounter != 0)
1378  030d 1e03          	ldw	x,(OFST-1,sp)
1379  030f 2706          	jreq	L764
1380                     ; 362             Swif = SUCCESS;
1382  0311 a601          	ld	a,#1
1383  0313 6b02          	ld	(OFST-2,sp),a
1386  0315 201b          	jra	L374
1387  0317               L764:
1388                     ; 366             Swif = ERROR;
1390  0317 0f02          	clr	(OFST-2,sp)
1392  0319 2017          	jra	L374
1393  031b               L744:
1394                     ; 374         if (ITState != DISABLE)
1396  031b 0d09          	tnz	(OFST+5,sp)
1397  031d 2706          	jreq	L574
1398                     ; 376             CLK->SWCR |= CLK_SWCR_SWIEN;
1400  031f 721450c5      	bset	20677,#2
1402  0323 2004          	jra	L774
1403  0325               L574:
1404                     ; 380             CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1406  0325 721550c5      	bres	20677,#2
1407  0329               L774:
1408                     ; 384         CLK->SWR = (uint8_t)CLK_NewClock;
1410  0329 7b06          	ld	a,(OFST+2,sp)
1411  032b c750c4        	ld	20676,a
1412                     ; 388         Swif = SUCCESS;
1414  032e a601          	ld	a,#1
1415  0330 6b02          	ld	(OFST-2,sp),a
1417  0332               L374:
1418                     ; 393     if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSI))
1420  0332 0d0a          	tnz	(OFST+6,sp)
1421  0334 260c          	jrne	L105
1423  0336 7b01          	ld	a,(OFST-3,sp)
1424  0338 a1e1          	cp	a,#225
1425  033a 2606          	jrne	L105
1426                     ; 395         CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
1428  033c 721150c0      	bres	20672,#0
1430  0340 201e          	jra	L305
1431  0342               L105:
1432                     ; 397     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_LSI))
1434  0342 0d0a          	tnz	(OFST+6,sp)
1435  0344 260c          	jrne	L505
1437  0346 7b01          	ld	a,(OFST-3,sp)
1438  0348 a1d2          	cp	a,#210
1439  034a 2606          	jrne	L505
1440                     ; 399         CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
1442  034c 721750c0      	bres	20672,#3
1444  0350 200e          	jra	L305
1445  0352               L505:
1446                     ; 401     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSE))
1448  0352 0d0a          	tnz	(OFST+6,sp)
1449  0354 260a          	jrne	L305
1451  0356 7b01          	ld	a,(OFST-3,sp)
1452  0358 a1b4          	cp	a,#180
1453  035a 2604          	jrne	L305
1454                     ; 403         CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
1456  035c 721150c1      	bres	20673,#0
1457  0360               L305:
1458                     ; 406     return(Swif);
1460  0360 7b02          	ld	a,(OFST-2,sp)
1463  0362 5b06          	addw	sp,#6
1464  0364 81            	ret
1603                     ; 416 void CLK_HSIPrescalerConfig(CLK_Prescaler_TypeDef HSIPrescaler)
1603                     ; 417 {
1604                     	switch	.text
1605  0365               _CLK_HSIPrescalerConfig:
1607  0365 88            	push	a
1608       00000000      OFST:	set	0
1611                     ; 420     assert_param(IS_CLK_HSIPRESCALER_OK(HSIPrescaler));
1613  0366 4d            	tnz	a
1614  0367 270c          	jreq	L271
1615  0369 a108          	cp	a,#8
1616  036b 2708          	jreq	L271
1617  036d a110          	cp	a,#16
1618  036f 2704          	jreq	L271
1619  0371 a118          	cp	a,#24
1620  0373 2603          	jrne	L071
1621  0375               L271:
1622  0375 4f            	clr	a
1623  0376 2010          	jra	L471
1624  0378               L071:
1625  0378 ae01a4        	ldw	x,#420
1626  037b 89            	pushw	x
1627  037c ae0000        	ldw	x,#0
1628  037f 89            	pushw	x
1629  0380 ae000c        	ldw	x,#L75
1630  0383 cd0000        	call	_assert_failed
1632  0386 5b04          	addw	sp,#4
1633  0388               L471:
1634                     ; 423     CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
1636  0388 c650c6        	ld	a,20678
1637  038b a4e7          	and	a,#231
1638  038d c750c6        	ld	20678,a
1639                     ; 426     CLK->CKDIVR |= (uint8_t)HSIPrescaler;
1641  0390 c650c6        	ld	a,20678
1642  0393 1a01          	or	a,(OFST+1,sp)
1643  0395 c750c6        	ld	20678,a
1644                     ; 428 }
1647  0398 84            	pop	a
1648  0399 81            	ret
1784                     ; 439 void CLK_CCOConfig(CLK_Output_TypeDef CLK_CCO)
1784                     ; 440 {
1785                     	switch	.text
1786  039a               _CLK_CCOConfig:
1788  039a 88            	push	a
1789       00000000      OFST:	set	0
1792                     ; 443     assert_param(IS_CLK_OUTPUT_OK(CLK_CCO));
1794  039b 4d            	tnz	a
1795  039c 2730          	jreq	L202
1796  039e a104          	cp	a,#4
1797  03a0 272c          	jreq	L202
1798  03a2 a102          	cp	a,#2
1799  03a4 2728          	jreq	L202
1800  03a6 a108          	cp	a,#8
1801  03a8 2724          	jreq	L202
1802  03aa a10a          	cp	a,#10
1803  03ac 2720          	jreq	L202
1804  03ae a10c          	cp	a,#12
1805  03b0 271c          	jreq	L202
1806  03b2 a10e          	cp	a,#14
1807  03b4 2718          	jreq	L202
1808  03b6 a110          	cp	a,#16
1809  03b8 2714          	jreq	L202
1810  03ba a112          	cp	a,#18
1811  03bc 2710          	jreq	L202
1812  03be a114          	cp	a,#20
1813  03c0 270c          	jreq	L202
1814  03c2 a116          	cp	a,#22
1815  03c4 2708          	jreq	L202
1816  03c6 a118          	cp	a,#24
1817  03c8 2704          	jreq	L202
1818  03ca a11a          	cp	a,#26
1819  03cc 2603          	jrne	L002
1820  03ce               L202:
1821  03ce 4f            	clr	a
1822  03cf 2010          	jra	L402
1823  03d1               L002:
1824  03d1 ae01bb        	ldw	x,#443
1825  03d4 89            	pushw	x
1826  03d5 ae0000        	ldw	x,#0
1827  03d8 89            	pushw	x
1828  03d9 ae000c        	ldw	x,#L75
1829  03dc cd0000        	call	_assert_failed
1831  03df 5b04          	addw	sp,#4
1832  03e1               L402:
1833                     ; 446     CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOSEL);
1835  03e1 c650c9        	ld	a,20681
1836  03e4 a4e1          	and	a,#225
1837  03e6 c750c9        	ld	20681,a
1838                     ; 449     CLK->CCOR |= (uint8_t)CLK_CCO;
1840  03e9 c650c9        	ld	a,20681
1841  03ec 1a01          	or	a,(OFST+1,sp)
1842  03ee c750c9        	ld	20681,a
1843                     ; 452     CLK->CCOR |= CLK_CCOR_CCOEN;
1845  03f1 721050c9      	bset	20681,#0
1846                     ; 454 }
1849  03f5 84            	pop	a
1850  03f6 81            	ret
1916                     ; 464 void CLK_ITConfig(CLK_IT_TypeDef CLK_IT, FunctionalState NewState)
1916                     ; 465 {
1917                     	switch	.text
1918  03f7               _CLK_ITConfig:
1920  03f7 89            	pushw	x
1921       00000000      OFST:	set	0
1924                     ; 468     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1926  03f8 9f            	ld	a,xl
1927  03f9 4d            	tnz	a
1928  03fa 2705          	jreq	L212
1929  03fc 9f            	ld	a,xl
1930  03fd a101          	cp	a,#1
1931  03ff 2603          	jrne	L012
1932  0401               L212:
1933  0401 4f            	clr	a
1934  0402 2010          	jra	L412
1935  0404               L012:
1936  0404 ae01d4        	ldw	x,#468
1937  0407 89            	pushw	x
1938  0408 ae0000        	ldw	x,#0
1939  040b 89            	pushw	x
1940  040c ae000c        	ldw	x,#L75
1941  040f cd0000        	call	_assert_failed
1943  0412 5b04          	addw	sp,#4
1944  0414               L412:
1945                     ; 469     assert_param(IS_CLK_IT_OK(CLK_IT));
1947  0414 7b01          	ld	a,(OFST+1,sp)
1948  0416 a10c          	cp	a,#12
1949  0418 2706          	jreq	L022
1950  041a 7b01          	ld	a,(OFST+1,sp)
1951  041c a11c          	cp	a,#28
1952  041e 2603          	jrne	L612
1953  0420               L022:
1954  0420 4f            	clr	a
1955  0421 2010          	jra	L222
1956  0423               L612:
1957  0423 ae01d5        	ldw	x,#469
1958  0426 89            	pushw	x
1959  0427 ae0000        	ldw	x,#0
1960  042a 89            	pushw	x
1961  042b ae000c        	ldw	x,#L75
1962  042e cd0000        	call	_assert_failed
1964  0431 5b04          	addw	sp,#4
1965  0433               L222:
1966                     ; 471     if (NewState != DISABLE)
1968  0433 0d02          	tnz	(OFST+2,sp)
1969  0435 271a          	jreq	L707
1970                     ; 473         switch (CLK_IT)
1972  0437 7b01          	ld	a,(OFST+1,sp)
1974                     ; 481         default:
1974                     ; 482             break;
1975  0439 a00c          	sub	a,#12
1976  043b 270a          	jreq	L346
1977  043d a010          	sub	a,#16
1978  043f 2624          	jrne	L517
1979                     ; 475         case CLK_IT_SWIF: /* Enable the clock switch interrupt */
1979                     ; 476             CLK->SWCR |= CLK_SWCR_SWIEN;
1981  0441 721450c5      	bset	20677,#2
1982                     ; 477             break;
1984  0445 201e          	jra	L517
1985  0447               L346:
1986                     ; 478         case CLK_IT_CSSD: /* Enable the clock security system detection interrupt */
1986                     ; 479             CLK->CSSR |= CLK_CSSR_CSSDIE;
1988  0447 721450c8      	bset	20680,#2
1989                     ; 480             break;
1991  044b 2018          	jra	L517
1992  044d               L546:
1993                     ; 481         default:
1993                     ; 482             break;
1995  044d 2016          	jra	L517
1996  044f               L317:
1998  044f 2014          	jra	L517
1999  0451               L707:
2000                     ; 487         switch (CLK_IT)
2002  0451 7b01          	ld	a,(OFST+1,sp)
2004                     ; 495         default:
2004                     ; 496             break;
2005  0453 a00c          	sub	a,#12
2006  0455 270a          	jreq	L156
2007  0457 a010          	sub	a,#16
2008  0459 260a          	jrne	L517
2009                     ; 489         case CLK_IT_SWIF: /* Disable the clock switch interrupt */
2009                     ; 490             CLK->SWCR  &= (uint8_t)(~CLK_SWCR_SWIEN);
2011  045b 721550c5      	bres	20677,#2
2012                     ; 491             break;
2014  045f 2004          	jra	L517
2015  0461               L156:
2016                     ; 492         case CLK_IT_CSSD: /* Disable the clock security system detection interrupt */
2016                     ; 493             CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSDIE);
2018  0461 721550c8      	bres	20680,#2
2019                     ; 494             break;
2020  0465               L517:
2021                     ; 500 }
2024  0465 85            	popw	x
2025  0466 81            	ret
2026  0467               L356:
2027                     ; 495         default:
2027                     ; 496             break;
2029  0467 20fc          	jra	L517
2030  0469               L127:
2031  0469 20fa          	jra	L517
2067                     ; 507 void CLK_SYSCLKConfig(CLK_Prescaler_TypeDef CLK_Prescaler)
2067                     ; 508 {
2068                     	switch	.text
2069  046b               _CLK_SYSCLKConfig:
2071  046b 88            	push	a
2072       00000000      OFST:	set	0
2075                     ; 511     assert_param(IS_CLK_PRESCALER_OK(CLK_Prescaler));
2077  046c 4d            	tnz	a
2078  046d 272c          	jreq	L032
2079  046f a108          	cp	a,#8
2080  0471 2728          	jreq	L032
2081  0473 a110          	cp	a,#16
2082  0475 2724          	jreq	L032
2083  0477 a118          	cp	a,#24
2084  0479 2720          	jreq	L032
2085  047b a180          	cp	a,#128
2086  047d 271c          	jreq	L032
2087  047f a181          	cp	a,#129
2088  0481 2718          	jreq	L032
2089  0483 a182          	cp	a,#130
2090  0485 2714          	jreq	L032
2091  0487 a183          	cp	a,#131
2092  0489 2710          	jreq	L032
2093  048b a184          	cp	a,#132
2094  048d 270c          	jreq	L032
2095  048f a185          	cp	a,#133
2096  0491 2708          	jreq	L032
2097  0493 a186          	cp	a,#134
2098  0495 2704          	jreq	L032
2099  0497 a187          	cp	a,#135
2100  0499 2603          	jrne	L622
2101  049b               L032:
2102  049b 4f            	clr	a
2103  049c 2010          	jra	L232
2104  049e               L622:
2105  049e ae01ff        	ldw	x,#511
2106  04a1 89            	pushw	x
2107  04a2 ae0000        	ldw	x,#0
2108  04a5 89            	pushw	x
2109  04a6 ae000c        	ldw	x,#L75
2110  04a9 cd0000        	call	_assert_failed
2112  04ac 5b04          	addw	sp,#4
2113  04ae               L232:
2114                     ; 513     if (((uint8_t)CLK_Prescaler & (uint8_t)0x80) == 0x00) /* Bit7 = 0 means HSI divider */
2116  04ae 7b01          	ld	a,(OFST+1,sp)
2117  04b0 a580          	bcp	a,#128
2118  04b2 2614          	jrne	L147
2119                     ; 515         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
2121  04b4 c650c6        	ld	a,20678
2122  04b7 a4e7          	and	a,#231
2123  04b9 c750c6        	ld	20678,a
2124                     ; 516         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_HSIDIV);
2126  04bc 7b01          	ld	a,(OFST+1,sp)
2127  04be a418          	and	a,#24
2128  04c0 ca50c6        	or	a,20678
2129  04c3 c750c6        	ld	20678,a
2131  04c6 2012          	jra	L347
2132  04c8               L147:
2133                     ; 520         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_CPUDIV);
2135  04c8 c650c6        	ld	a,20678
2136  04cb a4f8          	and	a,#248
2137  04cd c750c6        	ld	20678,a
2138                     ; 521         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_CPUDIV);
2140  04d0 7b01          	ld	a,(OFST+1,sp)
2141  04d2 a407          	and	a,#7
2142  04d4 ca50c6        	or	a,20678
2143  04d7 c750c6        	ld	20678,a
2144  04da               L347:
2145                     ; 524 }
2148  04da 84            	pop	a
2149  04db 81            	ret
2206                     ; 531 void CLK_SWIMConfig(CLK_SWIMDivider_TypeDef CLK_SWIMDivider)
2206                     ; 532 {
2207                     	switch	.text
2208  04dc               _CLK_SWIMConfig:
2210  04dc 88            	push	a
2211       00000000      OFST:	set	0
2214                     ; 535     assert_param(IS_CLK_SWIMDIVIDER_OK(CLK_SWIMDivider));
2216  04dd 4d            	tnz	a
2217  04de 2704          	jreq	L042
2218  04e0 a101          	cp	a,#1
2219  04e2 2603          	jrne	L632
2220  04e4               L042:
2221  04e4 4f            	clr	a
2222  04e5 2010          	jra	L242
2223  04e7               L632:
2224  04e7 ae0217        	ldw	x,#535
2225  04ea 89            	pushw	x
2226  04eb ae0000        	ldw	x,#0
2227  04ee 89            	pushw	x
2228  04ef ae000c        	ldw	x,#L75
2229  04f2 cd0000        	call	_assert_failed
2231  04f5 5b04          	addw	sp,#4
2232  04f7               L242:
2233                     ; 537     if (CLK_SWIMDivider != CLK_SWIMDIVIDER_2)
2235  04f7 0d01          	tnz	(OFST+1,sp)
2236  04f9 2706          	jreq	L377
2237                     ; 540         CLK->SWIMCCR |= CLK_SWIMCCR_SWIMDIV;
2239  04fb 721050cd      	bset	20685,#0
2241  04ff 2004          	jra	L577
2242  0501               L377:
2243                     ; 545         CLK->SWIMCCR &= (uint8_t)(~CLK_SWIMCCR_SWIMDIV);
2245  0501 721150cd      	bres	20685,#0
2246  0505               L577:
2247                     ; 548 }
2250  0505 84            	pop	a
2251  0506 81            	ret
2275                     ; 557 void CLK_ClockSecuritySystemEnable(void)
2275                     ; 558 {
2276                     	switch	.text
2277  0507               _CLK_ClockSecuritySystemEnable:
2281                     ; 560     CLK->CSSR |= CLK_CSSR_CSSEN;
2283  0507 721050c8      	bset	20680,#0
2284                     ; 561 }
2287  050b 81            	ret
2312                     ; 569 CLK_Source_TypeDef CLK_GetSYSCLKSource(void)
2312                     ; 570 {
2313                     	switch	.text
2314  050c               _CLK_GetSYSCLKSource:
2318                     ; 571     return((CLK_Source_TypeDef)CLK->CMSR);
2320  050c c650c3        	ld	a,20675
2323  050f 81            	ret
2386                     ; 579 uint32_t CLK_GetClockFreq(void)
2386                     ; 580 {
2387                     	switch	.text
2388  0510               _CLK_GetClockFreq:
2390  0510 5209          	subw	sp,#9
2391       00000009      OFST:	set	9
2394                     ; 582     uint32_t clockfrequency = 0;
2396                     ; 583     CLK_Source_TypeDef clocksource = CLK_SOURCE_HSI;
2398                     ; 584     uint8_t tmp = 0, presc = 0;
2402                     ; 587     clocksource = (CLK_Source_TypeDef)CLK->CMSR;
2404  0512 c650c3        	ld	a,20675
2405  0515 6b09          	ld	(OFST+0,sp),a
2407                     ; 589     if (clocksource == CLK_SOURCE_HSI)
2409  0517 7b09          	ld	a,(OFST+0,sp)
2410  0519 a1e1          	cp	a,#225
2411  051b 2641          	jrne	L1501
2412                     ; 591         tmp = (uint8_t)(CLK->CKDIVR & CLK_CKDIVR_HSIDIV);
2414  051d c650c6        	ld	a,20678
2415  0520 a418          	and	a,#24
2416  0522 6b09          	ld	(OFST+0,sp),a
2418                     ; 592         tmp = (uint8_t)(tmp >> 3);
2420  0524 0409          	srl	(OFST+0,sp)
2421  0526 0409          	srl	(OFST+0,sp)
2422  0528 0409          	srl	(OFST+0,sp)
2424                     ; 593         presc = HSIDivFactor[tmp];
2426  052a 7b09          	ld	a,(OFST+0,sp)
2427  052c 5f            	clrw	x
2428  052d 97            	ld	xl,a
2429  052e d60000        	ld	a,(_HSIDivFactor,x)
2430  0531 6b09          	ld	(OFST+0,sp),a
2432                     ; 594         clockfrequency = HSI_VALUE / presc;
2434  0533 7b09          	ld	a,(OFST+0,sp)
2435  0535 b703          	ld	c_lreg+3,a
2436  0537 3f02          	clr	c_lreg+2
2437  0539 3f01          	clr	c_lreg+1
2438  053b 3f00          	clr	c_lreg
2439  053d 96            	ldw	x,sp
2440  053e 1c0001        	addw	x,#OFST-8
2441  0541 cd0000        	call	c_rtol
2444  0544 ae2400        	ldw	x,#9216
2445  0547 bf02          	ldw	c_lreg+2,x
2446  0549 ae00f4        	ldw	x,#244
2447  054c bf00          	ldw	c_lreg,x
2448  054e 96            	ldw	x,sp
2449  054f 1c0001        	addw	x,#OFST-8
2450  0552 cd0000        	call	c_ludv
2452  0555 96            	ldw	x,sp
2453  0556 1c0005        	addw	x,#OFST-4
2454  0559 cd0000        	call	c_rtol
2458  055c 201c          	jra	L3501
2459  055e               L1501:
2460                     ; 596     else if ( clocksource == CLK_SOURCE_LSI)
2462  055e 7b09          	ld	a,(OFST+0,sp)
2463  0560 a1d2          	cp	a,#210
2464  0562 260c          	jrne	L5501
2465                     ; 598         clockfrequency = LSI_VALUE;
2467  0564 aef400        	ldw	x,#62464
2468  0567 1f07          	ldw	(OFST-2,sp),x
2469  0569 ae0001        	ldw	x,#1
2470  056c 1f05          	ldw	(OFST-4,sp),x
2473  056e 200a          	jra	L3501
2474  0570               L5501:
2475                     ; 602         clockfrequency = HSE_VALUE;
2477  0570 ae2400        	ldw	x,#9216
2478  0573 1f07          	ldw	(OFST-2,sp),x
2479  0575 ae00f4        	ldw	x,#244
2480  0578 1f05          	ldw	(OFST-4,sp),x
2482  057a               L3501:
2483                     ; 605     return((uint32_t)clockfrequency);
2485  057a 96            	ldw	x,sp
2486  057b 1c0005        	addw	x,#OFST-4
2487  057e cd0000        	call	c_ltor
2491  0581 5b09          	addw	sp,#9
2492  0583 81            	ret
2592                     ; 616 void CLK_AdjustHSICalibrationValue(CLK_HSITrimValue_TypeDef CLK_HSICalibrationValue)
2592                     ; 617 {
2593                     	switch	.text
2594  0584               _CLK_AdjustHSICalibrationValue:
2596  0584 88            	push	a
2597       00000000      OFST:	set	0
2600                     ; 620     assert_param(IS_CLK_HSITRIMVALUE_OK(CLK_HSICalibrationValue));
2602  0585 4d            	tnz	a
2603  0586 271c          	jreq	L652
2604  0588 a101          	cp	a,#1
2605  058a 2718          	jreq	L652
2606  058c a102          	cp	a,#2
2607  058e 2714          	jreq	L652
2608  0590 a103          	cp	a,#3
2609  0592 2710          	jreq	L652
2610  0594 a104          	cp	a,#4
2611  0596 270c          	jreq	L652
2612  0598 a105          	cp	a,#5
2613  059a 2708          	jreq	L652
2614  059c a106          	cp	a,#6
2615  059e 2704          	jreq	L652
2616  05a0 a107          	cp	a,#7
2617  05a2 2603          	jrne	L452
2618  05a4               L652:
2619  05a4 4f            	clr	a
2620  05a5 2010          	jra	L062
2621  05a7               L452:
2622  05a7 ae026c        	ldw	x,#620
2623  05aa 89            	pushw	x
2624  05ab ae0000        	ldw	x,#0
2625  05ae 89            	pushw	x
2626  05af ae000c        	ldw	x,#L75
2627  05b2 cd0000        	call	_assert_failed
2629  05b5 5b04          	addw	sp,#4
2630  05b7               L062:
2631                     ; 623     CLK->HSITRIMR = (uint8_t)( (uint8_t)(CLK->HSITRIMR & (uint8_t)(~CLK_HSITRIMR_HSITRIM))|((uint8_t)CLK_HSICalibrationValue));
2633  05b7 c650cc        	ld	a,20684
2634  05ba a4f8          	and	a,#248
2635  05bc 1a01          	or	a,(OFST+1,sp)
2636  05be c750cc        	ld	20684,a
2637                     ; 625 }
2640  05c1 84            	pop	a
2641  05c2 81            	ret
2665                     ; 636 void CLK_SYSCLKEmergencyClear(void)
2665                     ; 637 {
2666                     	switch	.text
2667  05c3               _CLK_SYSCLKEmergencyClear:
2671                     ; 638     CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWBSY);
2673  05c3 721150c5      	bres	20677,#0
2674                     ; 639 }
2677  05c7 81            	ret
2831                     ; 648 FlagStatus CLK_GetFlagStatus(CLK_Flag_TypeDef CLK_FLAG)
2831                     ; 649 {
2832                     	switch	.text
2833  05c8               _CLK_GetFlagStatus:
2835  05c8 89            	pushw	x
2836  05c9 5203          	subw	sp,#3
2837       00000003      OFST:	set	3
2840                     ; 651     uint16_t statusreg = 0;
2842                     ; 652     uint8_t tmpreg = 0;
2844                     ; 653     FlagStatus bitstatus = RESET;
2846                     ; 656     assert_param(IS_CLK_FLAG_OK(CLK_FLAG));
2848  05cb a30110        	cpw	x,#272
2849  05ce 2728          	jreq	L072
2850  05d0 a30102        	cpw	x,#258
2851  05d3 2723          	jreq	L072
2852  05d5 a30202        	cpw	x,#514
2853  05d8 271e          	jreq	L072
2854  05da a30308        	cpw	x,#776
2855  05dd 2719          	jreq	L072
2856  05df a30301        	cpw	x,#769
2857  05e2 2714          	jreq	L072
2858  05e4 a30408        	cpw	x,#1032
2859  05e7 270f          	jreq	L072
2860  05e9 a30402        	cpw	x,#1026
2861  05ec 270a          	jreq	L072
2862  05ee a30504        	cpw	x,#1284
2863  05f1 2705          	jreq	L072
2864  05f3 a30502        	cpw	x,#1282
2865  05f6 2603          	jrne	L662
2866  05f8               L072:
2867  05f8 4f            	clr	a
2868  05f9 2010          	jra	L272
2869  05fb               L662:
2870  05fb ae0290        	ldw	x,#656
2871  05fe 89            	pushw	x
2872  05ff ae0000        	ldw	x,#0
2873  0602 89            	pushw	x
2874  0603 ae000c        	ldw	x,#L75
2875  0606 cd0000        	call	_assert_failed
2877  0609 5b04          	addw	sp,#4
2878  060b               L272:
2879                     ; 659     statusreg = (uint16_t)((uint16_t)CLK_FLAG & (uint16_t)0xFF00);
2881  060b 7b04          	ld	a,(OFST+1,sp)
2882  060d 97            	ld	xl,a
2883  060e 7b05          	ld	a,(OFST+2,sp)
2884  0610 9f            	ld	a,xl
2885  0611 a4ff          	and	a,#255
2886  0613 97            	ld	xl,a
2887  0614 4f            	clr	a
2888  0615 02            	rlwa	x,a
2889  0616 1f01          	ldw	(OFST-2,sp),x
2890  0618 01            	rrwa	x,a
2892                     ; 662     if (statusreg == 0x0100) /* The flag to check is in ICKRregister */
2894  0619 1e01          	ldw	x,(OFST-2,sp)
2895  061b a30100        	cpw	x,#256
2896  061e 2607          	jrne	L3221
2897                     ; 664         tmpreg = CLK->ICKR;
2899  0620 c650c0        	ld	a,20672
2900  0623 6b03          	ld	(OFST+0,sp),a
2903  0625 202f          	jra	L5221
2904  0627               L3221:
2905                     ; 666     else if (statusreg == 0x0200) /* The flag to check is in ECKRregister */
2907  0627 1e01          	ldw	x,(OFST-2,sp)
2908  0629 a30200        	cpw	x,#512
2909  062c 2607          	jrne	L7221
2910                     ; 668         tmpreg = CLK->ECKR;
2912  062e c650c1        	ld	a,20673
2913  0631 6b03          	ld	(OFST+0,sp),a
2916  0633 2021          	jra	L5221
2917  0635               L7221:
2918                     ; 670     else if (statusreg == 0x0300) /* The flag to check is in SWIC register */
2920  0635 1e01          	ldw	x,(OFST-2,sp)
2921  0637 a30300        	cpw	x,#768
2922  063a 2607          	jrne	L3321
2923                     ; 672         tmpreg = CLK->SWCR;
2925  063c c650c5        	ld	a,20677
2926  063f 6b03          	ld	(OFST+0,sp),a
2929  0641 2013          	jra	L5221
2930  0643               L3321:
2931                     ; 674     else if (statusreg == 0x0400) /* The flag to check is in CSS register */
2933  0643 1e01          	ldw	x,(OFST-2,sp)
2934  0645 a30400        	cpw	x,#1024
2935  0648 2607          	jrne	L7321
2936                     ; 676         tmpreg = CLK->CSSR;
2938  064a c650c8        	ld	a,20680
2939  064d 6b03          	ld	(OFST+0,sp),a
2942  064f 2005          	jra	L5221
2943  0651               L7321:
2944                     ; 680         tmpreg = CLK->CCOR;
2946  0651 c650c9        	ld	a,20681
2947  0654 6b03          	ld	(OFST+0,sp),a
2949  0656               L5221:
2950                     ; 683     if ((tmpreg & (uint8_t)CLK_FLAG) != (uint8_t)RESET)
2952  0656 7b05          	ld	a,(OFST+2,sp)
2953  0658 1503          	bcp	a,(OFST+0,sp)
2954  065a 2706          	jreq	L3421
2955                     ; 685         bitstatus = SET;
2957  065c a601          	ld	a,#1
2958  065e 6b03          	ld	(OFST+0,sp),a
2961  0660 2002          	jra	L5421
2962  0662               L3421:
2963                     ; 689         bitstatus = RESET;
2965  0662 0f03          	clr	(OFST+0,sp)
2967  0664               L5421:
2968                     ; 693     return((FlagStatus)bitstatus);
2970  0664 7b03          	ld	a,(OFST+0,sp)
2973  0666 5b05          	addw	sp,#5
2974  0668 81            	ret
3021                     ; 703 ITStatus CLK_GetITStatus(CLK_IT_TypeDef CLK_IT)
3021                     ; 704 {
3022                     	switch	.text
3023  0669               _CLK_GetITStatus:
3025  0669 88            	push	a
3026  066a 88            	push	a
3027       00000001      OFST:	set	1
3030                     ; 706     ITStatus bitstatus = RESET;
3032                     ; 709     assert_param(IS_CLK_IT_OK(CLK_IT));
3034  066b a10c          	cp	a,#12
3035  066d 2704          	jreq	L003
3036  066f a11c          	cp	a,#28
3037  0671 2603          	jrne	L672
3038  0673               L003:
3039  0673 4f            	clr	a
3040  0674 2010          	jra	L203
3041  0676               L672:
3042  0676 ae02c5        	ldw	x,#709
3043  0679 89            	pushw	x
3044  067a ae0000        	ldw	x,#0
3045  067d 89            	pushw	x
3046  067e ae000c        	ldw	x,#L75
3047  0681 cd0000        	call	_assert_failed
3049  0684 5b04          	addw	sp,#4
3050  0686               L203:
3051                     ; 711     if (CLK_IT == CLK_IT_SWIF)
3053  0686 7b02          	ld	a,(OFST+1,sp)
3054  0688 a11c          	cp	a,#28
3055  068a 2613          	jrne	L1721
3056                     ; 714         if ((CLK->SWCR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
3058  068c c650c5        	ld	a,20677
3059  068f 1402          	and	a,(OFST+1,sp)
3060  0691 a10c          	cp	a,#12
3061  0693 2606          	jrne	L3721
3062                     ; 716             bitstatus = SET;
3064  0695 a601          	ld	a,#1
3065  0697 6b01          	ld	(OFST+0,sp),a
3068  0699 2015          	jra	L7721
3069  069b               L3721:
3070                     ; 720             bitstatus = RESET;
3072  069b 0f01          	clr	(OFST+0,sp)
3074  069d 2011          	jra	L7721
3075  069f               L1721:
3076                     ; 726         if ((CLK->CSSR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
3078  069f c650c8        	ld	a,20680
3079  06a2 1402          	and	a,(OFST+1,sp)
3080  06a4 a10c          	cp	a,#12
3081  06a6 2606          	jrne	L1031
3082                     ; 728             bitstatus = SET;
3084  06a8 a601          	ld	a,#1
3085  06aa 6b01          	ld	(OFST+0,sp),a
3088  06ac 2002          	jra	L7721
3089  06ae               L1031:
3090                     ; 732             bitstatus = RESET;
3092  06ae 0f01          	clr	(OFST+0,sp)
3094  06b0               L7721:
3095                     ; 737     return bitstatus;
3097  06b0 7b01          	ld	a,(OFST+0,sp)
3100  06b2 85            	popw	x
3101  06b3 81            	ret
3138                     ; 747 void CLK_ClearITPendingBit(CLK_IT_TypeDef CLK_IT)
3138                     ; 748 {
3139                     	switch	.text
3140  06b4               _CLK_ClearITPendingBit:
3142  06b4 88            	push	a
3143       00000000      OFST:	set	0
3146                     ; 751     assert_param(IS_CLK_IT_OK(CLK_IT));
3148  06b5 a10c          	cp	a,#12
3149  06b7 2704          	jreq	L013
3150  06b9 a11c          	cp	a,#28
3151  06bb 2603          	jrne	L603
3152  06bd               L013:
3153  06bd 4f            	clr	a
3154  06be 2010          	jra	L213
3155  06c0               L603:
3156  06c0 ae02ef        	ldw	x,#751
3157  06c3 89            	pushw	x
3158  06c4 ae0000        	ldw	x,#0
3159  06c7 89            	pushw	x
3160  06c8 ae000c        	ldw	x,#L75
3161  06cb cd0000        	call	_assert_failed
3163  06ce 5b04          	addw	sp,#4
3164  06d0               L213:
3165                     ; 753     if (CLK_IT == (uint8_t)CLK_IT_CSSD)
3167  06d0 7b01          	ld	a,(OFST+1,sp)
3168  06d2 a10c          	cp	a,#12
3169  06d4 2606          	jrne	L3231
3170                     ; 756         CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSD);
3172  06d6 721750c8      	bres	20680,#3
3174  06da 2004          	jra	L5231
3175  06dc               L3231:
3176                     ; 761         CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIF);
3178  06dc 721750c5      	bres	20677,#3
3179  06e0               L5231:
3180                     ; 764 }
3183  06e0 84            	pop	a
3184  06e1 81            	ret
3219                     	xdef	_CLKPrescTable
3220                     	xdef	_HSIDivFactor
3221                     	xdef	_CLK_ClearITPendingBit
3222                     	xdef	_CLK_GetITStatus
3223                     	xdef	_CLK_GetFlagStatus
3224                     	xdef	_CLK_GetSYSCLKSource
3225                     	xdef	_CLK_GetClockFreq
3226                     	xdef	_CLK_AdjustHSICalibrationValue
3227                     	xdef	_CLK_SYSCLKEmergencyClear
3228                     	xdef	_CLK_ClockSecuritySystemEnable
3229                     	xdef	_CLK_SWIMConfig
3230                     	xdef	_CLK_SYSCLKConfig
3231                     	xdef	_CLK_ITConfig
3232                     	xdef	_CLK_CCOConfig
3233                     	xdef	_CLK_HSIPrescalerConfig
3234                     	xdef	_CLK_ClockSwitchConfig
3235                     	xdef	_CLK_PeripheralClockConfig
3236                     	xdef	_CLK_SlowActiveHaltWakeUpCmd
3237                     	xdef	_CLK_FastHaltWakeUpCmd
3238                     	xdef	_CLK_ClockSwitchCmd
3239                     	xdef	_CLK_CCOCmd
3240                     	xdef	_CLK_LSICmd
3241                     	xdef	_CLK_HSICmd
3242                     	xdef	_CLK_HSECmd
3243                     	xdef	_CLK_DeInit
3244                     	xref	_assert_failed
3245                     	switch	.const
3246  000c               L75:
3247  000c 2e2e5c73746d  	dc.b	"..\stm8s_stdperiph"
3248  001e 5f6472697665  	dc.b	"_driver\src\stm8s_"
3249  0030 636c6b2e6300  	dc.b	"clk.c",0
3250                     	xref.b	c_lreg
3251                     	xref.b	c_x
3271                     	xref	c_ltor
3272                     	xref	c_ludv
3273                     	xref	c_rtol
3274                     	end
