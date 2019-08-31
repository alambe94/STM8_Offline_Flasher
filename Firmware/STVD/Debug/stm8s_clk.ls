   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.13 - 05 Feb 2019
   3                     ; Generator (Limited) V4.4.9 - 06 Feb 2019
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
  30                     ; 72 void CLK_DeInit(void)
  30                     ; 73 {
  31                     	scross	off
  32                     .text:	section	.text,new
  33  0000               _CLK_DeInit:
  35                     ; 74   CLK->ICKR = CLK_ICKR_RESET_VALUE;
  36  0000 350150c0      	mov	20672,#1
  37                     ; 75   CLK->ECKR = CLK_ECKR_RESET_VALUE;
  38  0004 725f50c1      	clr	20673
  39                     ; 76   CLK->SWR  = CLK_SWR_RESET_VALUE;
  40  0008 35e150c4      	mov	20676,#225
  41                     ; 77   CLK->SWCR = CLK_SWCR_RESET_VALUE;
  42  000c 725f50c5      	clr	20677
  43                     ; 78   CLK->CKDIVR = CLK_CKDIVR_RESET_VALUE;
  44  0010 351850c6      	mov	20678,#24
  45                     ; 79   CLK->PCKENR1 = CLK_PCKENR1_RESET_VALUE;
  46  0014 35ff50c7      	mov	20679,#255
  47                     ; 80   CLK->PCKENR2 = CLK_PCKENR2_RESET_VALUE;
  48  0018 35ff50ca      	mov	20682,#255
  49                     ; 81   CLK->CSSR = CLK_CSSR_RESET_VALUE;
  50  001c 725f50c8      	clr	20680
  51                     ; 82   CLK->CCOR = CLK_CCOR_RESET_VALUE;
  52  0020 725f50c9      	clr	20681
  54  0024               L7:
  55                     ; 83   while ((CLK->CCOR & CLK_CCOR_CCOEN)!= 0)
  56  0024 c650c9        	ld	a,20681
  57  0027 a501          	bcp	a,#1
  58  0029 26f9          	jrne	L7
  59                     ; 85   CLK->CCOR = CLK_CCOR_RESET_VALUE;
  60  002b 725f50c9      	clr	20681
  61                     ; 86   CLK->HSITRIMR = CLK_HSITRIMR_RESET_VALUE;
  62  002f 725f50cc      	clr	20684
  63                     ; 87   CLK->SWIMCCR = CLK_SWIMCCR_RESET_VALUE;
  64  0033 725f50cd      	clr	20685
  65                     ; 88 }
  66  0037 81            	ret
  68                     ; 99 void CLK_FastHaltWakeUpCmd(FunctionalState NewState)
  68                     ; 100 {
  69                     .text:	section	.text,new
  70  0000               _CLK_FastHaltWakeUpCmd:
  71  0000 88            	push	a
  72       00000000      OFST:	set	0
  74                     ; 102   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
  75  0001 4d            	tnz	a
  76  0002 2704          	jreq	L01
  77  0004 a101          	cp	a,#1
  78  0006 2603          	jrne	L6
  79  0008               L01:
  80  0008 4f            	clr	a
  81  0009 2010          	jra	L21
  82  000b               L6:
  83  000b ae0066        	ldw	x,#102
  84  000e 89            	pushw	x
  85  000f ae0000        	ldw	x,#0
  86  0012 89            	pushw	x
  87  0013 ae000c        	ldw	x,#L31
  88  0016 cd0000        	call	_assert_failed
  90  0019 5b04          	addw	sp,#4
  91  001b               L21:
  92                     ; 104   if (NewState != DISABLE)
  93  001b 0d01          	tnz	(OFST+1,sp)
  94  001d 2706          	jreq	L51
  95                     ; 107     CLK->ICKR |= CLK_ICKR_FHWU;
  96  001f 721450c0      	bset	20672,#2
  98  0023 2004          	jra	L71
  99  0025               L51:
 100                     ; 112     CLK->ICKR &= (uint8_t)(~CLK_ICKR_FHWU);
 101  0025 721550c0      	bres	20672,#2
 102  0029               L71:
 103                     ; 114 }
 104  0029 84            	pop	a
 105  002a 81            	ret
 107                     ; 121 void CLK_HSECmd(FunctionalState NewState)
 107                     ; 122 {
 108                     .text:	section	.text,new
 109  0000               _CLK_HSECmd:
 110  0000 88            	push	a
 111       00000000      OFST:	set	0
 113                     ; 124   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 114  0001 4d            	tnz	a
 115  0002 2704          	jreq	L02
 116  0004 a101          	cp	a,#1
 117  0006 2603          	jrne	L61
 118  0008               L02:
 119  0008 4f            	clr	a
 120  0009 2010          	jra	L22
 121  000b               L61:
 122  000b ae007c        	ldw	x,#124
 123  000e 89            	pushw	x
 124  000f ae0000        	ldw	x,#0
 125  0012 89            	pushw	x
 126  0013 ae000c        	ldw	x,#L31
 127  0016 cd0000        	call	_assert_failed
 129  0019 5b04          	addw	sp,#4
 130  001b               L22:
 131                     ; 126   if (NewState != DISABLE)
 132  001b 0d01          	tnz	(OFST+1,sp)
 133  001d 2706          	jreq	L12
 134                     ; 129     CLK->ECKR |= CLK_ECKR_HSEEN;
 135  001f 721050c1      	bset	20673,#0
 137  0023 2004          	jra	L32
 138  0025               L12:
 139                     ; 134     CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
 140  0025 721150c1      	bres	20673,#0
 141  0029               L32:
 142                     ; 136 }
 143  0029 84            	pop	a
 144  002a 81            	ret
 146                     ; 143 void CLK_HSICmd(FunctionalState NewState)
 146                     ; 144 {
 147                     .text:	section	.text,new
 148  0000               _CLK_HSICmd:
 149  0000 88            	push	a
 150       00000000      OFST:	set	0
 152                     ; 146   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 153  0001 4d            	tnz	a
 154  0002 2704          	jreq	L03
 155  0004 a101          	cp	a,#1
 156  0006 2603          	jrne	L62
 157  0008               L03:
 158  0008 4f            	clr	a
 159  0009 2010          	jra	L23
 160  000b               L62:
 161  000b ae0092        	ldw	x,#146
 162  000e 89            	pushw	x
 163  000f ae0000        	ldw	x,#0
 164  0012 89            	pushw	x
 165  0013 ae000c        	ldw	x,#L31
 166  0016 cd0000        	call	_assert_failed
 168  0019 5b04          	addw	sp,#4
 169  001b               L23:
 170                     ; 148   if (NewState != DISABLE)
 171  001b 0d01          	tnz	(OFST+1,sp)
 172  001d 2706          	jreq	L52
 173                     ; 151     CLK->ICKR |= CLK_ICKR_HSIEN;
 174  001f 721050c0      	bset	20672,#0
 176  0023 2004          	jra	L72
 177  0025               L52:
 178                     ; 156     CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
 179  0025 721150c0      	bres	20672,#0
 180  0029               L72:
 181                     ; 158 }
 182  0029 84            	pop	a
 183  002a 81            	ret
 185                     ; 166 void CLK_LSICmd(FunctionalState NewState)
 185                     ; 167 {
 186                     .text:	section	.text,new
 187  0000               _CLK_LSICmd:
 188  0000 88            	push	a
 189       00000000      OFST:	set	0
 191                     ; 169   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 192  0001 4d            	tnz	a
 193  0002 2704          	jreq	L04
 194  0004 a101          	cp	a,#1
 195  0006 2603          	jrne	L63
 196  0008               L04:
 197  0008 4f            	clr	a
 198  0009 2010          	jra	L24
 199  000b               L63:
 200  000b ae00a9        	ldw	x,#169
 201  000e 89            	pushw	x
 202  000f ae0000        	ldw	x,#0
 203  0012 89            	pushw	x
 204  0013 ae000c        	ldw	x,#L31
 205  0016 cd0000        	call	_assert_failed
 207  0019 5b04          	addw	sp,#4
 208  001b               L24:
 209                     ; 171   if (NewState != DISABLE)
 210  001b 0d01          	tnz	(OFST+1,sp)
 211  001d 2706          	jreq	L13
 212                     ; 174     CLK->ICKR |= CLK_ICKR_LSIEN;
 213  001f 721650c0      	bset	20672,#3
 215  0023 2004          	jra	L33
 216  0025               L13:
 217                     ; 179     CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
 218  0025 721750c0      	bres	20672,#3
 219  0029               L33:
 220                     ; 181 }
 221  0029 84            	pop	a
 222  002a 81            	ret
 224                     ; 189 void CLK_CCOCmd(FunctionalState NewState)
 224                     ; 190 {
 225                     .text:	section	.text,new
 226  0000               _CLK_CCOCmd:
 227  0000 88            	push	a
 228       00000000      OFST:	set	0
 230                     ; 192   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 231  0001 4d            	tnz	a
 232  0002 2704          	jreq	L05
 233  0004 a101          	cp	a,#1
 234  0006 2603          	jrne	L64
 235  0008               L05:
 236  0008 4f            	clr	a
 237  0009 2010          	jra	L25
 238  000b               L64:
 239  000b ae00c0        	ldw	x,#192
 240  000e 89            	pushw	x
 241  000f ae0000        	ldw	x,#0
 242  0012 89            	pushw	x
 243  0013 ae000c        	ldw	x,#L31
 244  0016 cd0000        	call	_assert_failed
 246  0019 5b04          	addw	sp,#4
 247  001b               L25:
 248                     ; 194   if (NewState != DISABLE)
 249  001b 0d01          	tnz	(OFST+1,sp)
 250  001d 2706          	jreq	L53
 251                     ; 197     CLK->CCOR |= CLK_CCOR_CCOEN;
 252  001f 721050c9      	bset	20681,#0
 254  0023 2004          	jra	L73
 255  0025               L53:
 256                     ; 202     CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOEN);
 257  0025 721150c9      	bres	20681,#0
 258  0029               L73:
 259                     ; 204 }
 260  0029 84            	pop	a
 261  002a 81            	ret
 263                     ; 213 void CLK_ClockSwitchCmd(FunctionalState NewState)
 263                     ; 214 {
 264                     .text:	section	.text,new
 265  0000               _CLK_ClockSwitchCmd:
 266  0000 88            	push	a
 267       00000000      OFST:	set	0
 269                     ; 216   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 270  0001 4d            	tnz	a
 271  0002 2704          	jreq	L06
 272  0004 a101          	cp	a,#1
 273  0006 2603          	jrne	L65
 274  0008               L06:
 275  0008 4f            	clr	a
 276  0009 2010          	jra	L26
 277  000b               L65:
 278  000b ae00d8        	ldw	x,#216
 279  000e 89            	pushw	x
 280  000f ae0000        	ldw	x,#0
 281  0012 89            	pushw	x
 282  0013 ae000c        	ldw	x,#L31
 283  0016 cd0000        	call	_assert_failed
 285  0019 5b04          	addw	sp,#4
 286  001b               L26:
 287                     ; 218   if (NewState != DISABLE )
 288  001b 0d01          	tnz	(OFST+1,sp)
 289  001d 2706          	jreq	L14
 290                     ; 221     CLK->SWCR |= CLK_SWCR_SWEN;
 291  001f 721250c5      	bset	20677,#1
 293  0023 2004          	jra	L34
 294  0025               L14:
 295                     ; 226     CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWEN);
 296  0025 721350c5      	bres	20677,#1
 297  0029               L34:
 298                     ; 228 }
 299  0029 84            	pop	a
 300  002a 81            	ret
 302                     ; 238 void CLK_SlowActiveHaltWakeUpCmd(FunctionalState NewState)
 302                     ; 239 {
 303                     .text:	section	.text,new
 304  0000               _CLK_SlowActiveHaltWakeUpCmd:
 305  0000 88            	push	a
 306       00000000      OFST:	set	0
 308                     ; 241   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 309  0001 4d            	tnz	a
 310  0002 2704          	jreq	L07
 311  0004 a101          	cp	a,#1
 312  0006 2603          	jrne	L66
 313  0008               L07:
 314  0008 4f            	clr	a
 315  0009 2010          	jra	L27
 316  000b               L66:
 317  000b ae00f1        	ldw	x,#241
 318  000e 89            	pushw	x
 319  000f ae0000        	ldw	x,#0
 320  0012 89            	pushw	x
 321  0013 ae000c        	ldw	x,#L31
 322  0016 cd0000        	call	_assert_failed
 324  0019 5b04          	addw	sp,#4
 325  001b               L27:
 326                     ; 243   if (NewState != DISABLE)
 327  001b 0d01          	tnz	(OFST+1,sp)
 328  001d 2706          	jreq	L54
 329                     ; 246     CLK->ICKR |= CLK_ICKR_SWUAH;
 330  001f 721a50c0      	bset	20672,#5
 332  0023 2004          	jra	L74
 333  0025               L54:
 334                     ; 251     CLK->ICKR &= (uint8_t)(~CLK_ICKR_SWUAH);
 335  0025 721b50c0      	bres	20672,#5
 336  0029               L74:
 337                     ; 253 }
 338  0029 84            	pop	a
 339  002a 81            	ret
 341                     ; 263 void CLK_PeripheralClockConfig(CLK_Peripheral_TypeDef CLK_Peripheral, FunctionalState NewState)
 341                     ; 264 {
 342                     .text:	section	.text,new
 343  0000               _CLK_PeripheralClockConfig:
 344  0000 89            	pushw	x
 345       00000000      OFST:	set	0
 347                     ; 266   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 348  0001 9f            	ld	a,xl
 349  0002 4d            	tnz	a
 350  0003 2705          	jreq	L001
 351  0005 9f            	ld	a,xl
 352  0006 a101          	cp	a,#1
 353  0008 2603          	jrne	L67
 354  000a               L001:
 355  000a 4f            	clr	a
 356  000b 2010          	jra	L201
 357  000d               L67:
 358  000d ae010a        	ldw	x,#266
 359  0010 89            	pushw	x
 360  0011 ae0000        	ldw	x,#0
 361  0014 89            	pushw	x
 362  0015 ae000c        	ldw	x,#L31
 363  0018 cd0000        	call	_assert_failed
 365  001b 5b04          	addw	sp,#4
 366  001d               L201:
 367                     ; 267   assert_param(IS_CLK_PERIPHERAL_OK(CLK_Peripheral));
 368  001d 0d01          	tnz	(OFST+1,sp)
 369  001f 274e          	jreq	L601
 370  0021 7b01          	ld	a,(OFST+1,sp)
 371  0023 a101          	cp	a,#1
 372  0025 2748          	jreq	L601
 373  0027 7b01          	ld	a,(OFST+1,sp)
 374  0029 a103          	cp	a,#3
 375  002b 2742          	jreq	L601
 376  002d 7b01          	ld	a,(OFST+1,sp)
 377  002f a103          	cp	a,#3
 378  0031 273c          	jreq	L601
 379  0033 7b01          	ld	a,(OFST+1,sp)
 380  0035 a103          	cp	a,#3
 381  0037 2736          	jreq	L601
 382  0039 7b01          	ld	a,(OFST+1,sp)
 383  003b a104          	cp	a,#4
 384  003d 2730          	jreq	L601
 385  003f 7b01          	ld	a,(OFST+1,sp)
 386  0041 a105          	cp	a,#5
 387  0043 272a          	jreq	L601
 388  0045 7b01          	ld	a,(OFST+1,sp)
 389  0047 a105          	cp	a,#5
 390  0049 2724          	jreq	L601
 391  004b 7b01          	ld	a,(OFST+1,sp)
 392  004d a104          	cp	a,#4
 393  004f 271e          	jreq	L601
 394  0051 7b01          	ld	a,(OFST+1,sp)
 395  0053 a106          	cp	a,#6
 396  0055 2718          	jreq	L601
 397  0057 7b01          	ld	a,(OFST+1,sp)
 398  0059 a107          	cp	a,#7
 399  005b 2712          	jreq	L601
 400  005d 7b01          	ld	a,(OFST+1,sp)
 401  005f a117          	cp	a,#23
 402  0061 270c          	jreq	L601
 403  0063 7b01          	ld	a,(OFST+1,sp)
 404  0065 a113          	cp	a,#19
 405  0067 2706          	jreq	L601
 406  0069 7b01          	ld	a,(OFST+1,sp)
 407  006b a112          	cp	a,#18
 408  006d 2603          	jrne	L401
 409  006f               L601:
 410  006f 4f            	clr	a
 411  0070 2010          	jra	L011
 412  0072               L401:
 413  0072 ae010b        	ldw	x,#267
 414  0075 89            	pushw	x
 415  0076 ae0000        	ldw	x,#0
 416  0079 89            	pushw	x
 417  007a ae000c        	ldw	x,#L31
 418  007d cd0000        	call	_assert_failed
 420  0080 5b04          	addw	sp,#4
 421  0082               L011:
 422                     ; 269   if (((uint8_t)CLK_Peripheral & (uint8_t)0x10) == 0x00)
 423  0082 7b01          	ld	a,(OFST+1,sp)
 424  0084 a510          	bcp	a,#16
 425  0086 2633          	jrne	L15
 426                     ; 271     if (NewState != DISABLE)
 427  0088 0d02          	tnz	(OFST+2,sp)
 428  008a 2717          	jreq	L35
 429                     ; 274       CLK->PCKENR1 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 430  008c 7b01          	ld	a,(OFST+1,sp)
 431  008e a40f          	and	a,#15
 432  0090 5f            	clrw	x
 433  0091 97            	ld	xl,a
 434  0092 a601          	ld	a,#1
 435  0094 5d            	tnzw	x
 436  0095 2704          	jreq	L211
 437  0097               L411:
 438  0097 48            	sll	a
 439  0098 5a            	decw	x
 440  0099 26fc          	jrne	L411
 441  009b               L211:
 442  009b ca50c7        	or	a,20679
 443  009e c750c7        	ld	20679,a
 445  00a1 2049          	jra	L75
 446  00a3               L35:
 447                     ; 279       CLK->PCKENR1 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 448  00a3 7b01          	ld	a,(OFST+1,sp)
 449  00a5 a40f          	and	a,#15
 450  00a7 5f            	clrw	x
 451  00a8 97            	ld	xl,a
 452  00a9 a601          	ld	a,#1
 453  00ab 5d            	tnzw	x
 454  00ac 2704          	jreq	L611
 455  00ae               L021:
 456  00ae 48            	sll	a
 457  00af 5a            	decw	x
 458  00b0 26fc          	jrne	L021
 459  00b2               L611:
 460  00b2 43            	cpl	a
 461  00b3 c450c7        	and	a,20679
 462  00b6 c750c7        	ld	20679,a
 463  00b9 2031          	jra	L75
 464  00bb               L15:
 465                     ; 284     if (NewState != DISABLE)
 466  00bb 0d02          	tnz	(OFST+2,sp)
 467  00bd 2717          	jreq	L16
 468                     ; 287       CLK->PCKENR2 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 469  00bf 7b01          	ld	a,(OFST+1,sp)
 470  00c1 a40f          	and	a,#15
 471  00c3 5f            	clrw	x
 472  00c4 97            	ld	xl,a
 473  00c5 a601          	ld	a,#1
 474  00c7 5d            	tnzw	x
 475  00c8 2704          	jreq	L221
 476  00ca               L421:
 477  00ca 48            	sll	a
 478  00cb 5a            	decw	x
 479  00cc 26fc          	jrne	L421
 480  00ce               L221:
 481  00ce ca50ca        	or	a,20682
 482  00d1 c750ca        	ld	20682,a
 484  00d4 2016          	jra	L75
 485  00d6               L16:
 486                     ; 292       CLK->PCKENR2 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 487  00d6 7b01          	ld	a,(OFST+1,sp)
 488  00d8 a40f          	and	a,#15
 489  00da 5f            	clrw	x
 490  00db 97            	ld	xl,a
 491  00dc a601          	ld	a,#1
 492  00de 5d            	tnzw	x
 493  00df 2704          	jreq	L621
 494  00e1               L031:
 495  00e1 48            	sll	a
 496  00e2 5a            	decw	x
 497  00e3 26fc          	jrne	L031
 498  00e5               L621:
 499  00e5 43            	cpl	a
 500  00e6 c450ca        	and	a,20682
 501  00e9 c750ca        	ld	20682,a
 502  00ec               L75:
 503                     ; 295 }
 504  00ec 85            	popw	x
 505  00ed 81            	ret
 507                     ; 309 ErrorStatus CLK_ClockSwitchConfig(CLK_SwitchMode_TypeDef CLK_SwitchMode, CLK_Source_TypeDef CLK_NewClock, FunctionalState ITState, CLK_CurrentClockState_TypeDef CLK_CurrentClockState)
 507                     ; 310 {
 508                     .text:	section	.text,new
 509  0000               _CLK_ClockSwitchConfig:
 510  0000 89            	pushw	x
 511  0001 5204          	subw	sp,#4
 512       00000004      OFST:	set	4
 514                     ; 312   uint16_t DownCounter = CLK_TIMEOUT;
 515  0003 aeffff        	ldw	x,#65535
 516  0006 1f03          	ldw	(OFST-1,sp),x
 517                     ; 313   ErrorStatus Swif = ERROR;
 518                     ; 316   assert_param(IS_CLK_SOURCE_OK(CLK_NewClock));
 519  0008 7b06          	ld	a,(OFST+2,sp)
 520  000a a1e1          	cp	a,#225
 521  000c 270c          	jreq	L631
 522  000e 7b06          	ld	a,(OFST+2,sp)
 523  0010 a1d2          	cp	a,#210
 524  0012 2706          	jreq	L631
 525  0014 7b06          	ld	a,(OFST+2,sp)
 526  0016 a1b4          	cp	a,#180
 527  0018 2603          	jrne	L431
 528  001a               L631:
 529  001a 4f            	clr	a
 530  001b 2010          	jra	L041
 531  001d               L431:
 532  001d ae013c        	ldw	x,#316
 533  0020 89            	pushw	x
 534  0021 ae0000        	ldw	x,#0
 535  0024 89            	pushw	x
 536  0025 ae000c        	ldw	x,#L31
 537  0028 cd0000        	call	_assert_failed
 539  002b 5b04          	addw	sp,#4
 540  002d               L041:
 541                     ; 317   assert_param(IS_CLK_SWITCHMODE_OK(CLK_SwitchMode));
 542  002d 0d05          	tnz	(OFST+1,sp)
 543  002f 2706          	jreq	L441
 544  0031 7b05          	ld	a,(OFST+1,sp)
 545  0033 a101          	cp	a,#1
 546  0035 2603          	jrne	L241
 547  0037               L441:
 548  0037 4f            	clr	a
 549  0038 2010          	jra	L641
 550  003a               L241:
 551  003a ae013d        	ldw	x,#317
 552  003d 89            	pushw	x
 553  003e ae0000        	ldw	x,#0
 554  0041 89            	pushw	x
 555  0042 ae000c        	ldw	x,#L31
 556  0045 cd0000        	call	_assert_failed
 558  0048 5b04          	addw	sp,#4
 559  004a               L641:
 560                     ; 318   assert_param(IS_FUNCTIONALSTATE_OK(ITState));
 561  004a 0d09          	tnz	(OFST+5,sp)
 562  004c 2706          	jreq	L251
 563  004e 7b09          	ld	a,(OFST+5,sp)
 564  0050 a101          	cp	a,#1
 565  0052 2603          	jrne	L051
 566  0054               L251:
 567  0054 4f            	clr	a
 568  0055 2010          	jra	L451
 569  0057               L051:
 570  0057 ae013e        	ldw	x,#318
 571  005a 89            	pushw	x
 572  005b ae0000        	ldw	x,#0
 573  005e 89            	pushw	x
 574  005f ae000c        	ldw	x,#L31
 575  0062 cd0000        	call	_assert_failed
 577  0065 5b04          	addw	sp,#4
 578  0067               L451:
 579                     ; 319   assert_param(IS_CLK_CURRENTCLOCKSTATE_OK(CLK_CurrentClockState));
 580  0067 0d0a          	tnz	(OFST+6,sp)
 581  0069 2706          	jreq	L061
 582  006b 7b0a          	ld	a,(OFST+6,sp)
 583  006d a101          	cp	a,#1
 584  006f 2603          	jrne	L651
 585  0071               L061:
 586  0071 4f            	clr	a
 587  0072 2010          	jra	L261
 588  0074               L651:
 589  0074 ae013f        	ldw	x,#319
 590  0077 89            	pushw	x
 591  0078 ae0000        	ldw	x,#0
 592  007b 89            	pushw	x
 593  007c ae000c        	ldw	x,#L31
 594  007f cd0000        	call	_assert_failed
 596  0082 5b04          	addw	sp,#4
 597  0084               L261:
 598                     ; 322   clock_master = (CLK_Source_TypeDef)CLK->CMSR;
 599  0084 c650c3        	ld	a,20675
 600  0087 6b01          	ld	(OFST-3,sp),a
 601                     ; 325   if (CLK_SwitchMode == CLK_SWITCHMODE_AUTO)
 602  0089 7b05          	ld	a,(OFST+1,sp)
 603  008b a101          	cp	a,#1
 604  008d 264b          	jrne	L56
 605                     ; 328     CLK->SWCR |= CLK_SWCR_SWEN;
 606  008f 721250c5      	bset	20677,#1
 607                     ; 331     if (ITState != DISABLE)
 608  0093 0d09          	tnz	(OFST+5,sp)
 609  0095 2706          	jreq	L76
 610                     ; 333       CLK->SWCR |= CLK_SWCR_SWIEN;
 611  0097 721450c5      	bset	20677,#2
 613  009b 2004          	jra	L17
 614  009d               L76:
 615                     ; 337       CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
 616  009d 721550c5      	bres	20677,#2
 617  00a1               L17:
 618                     ; 341     CLK->SWR = (uint8_t)CLK_NewClock;
 619  00a1 7b06          	ld	a,(OFST+2,sp)
 620  00a3 c750c4        	ld	20676,a
 622  00a6 2007          	jra	L77
 623  00a8               L37:
 624                     ; 346       DownCounter--;
 625  00a8 1e03          	ldw	x,(OFST-1,sp)
 626  00aa 1d0001        	subw	x,#1
 627  00ad 1f03          	ldw	(OFST-1,sp),x
 628  00af               L77:
 629                     ; 344     while((((CLK->SWCR & CLK_SWCR_SWBSY) != 0 )&& (DownCounter != 0)))
 630  00af c650c5        	ld	a,20677
 631  00b2 a501          	bcp	a,#1
 632  00b4 2704          	jreq	L301
 634  00b6 1e03          	ldw	x,(OFST-1,sp)
 635  00b8 26ee          	jrne	L37
 636  00ba               L301:
 637                     ; 349     if(DownCounter != 0)
 638  00ba 1e03          	ldw	x,(OFST-1,sp)
 639  00bc 2706          	jreq	L501
 640                     ; 351       Swif = SUCCESS;
 641  00be a601          	ld	a,#1
 642  00c0 6b02          	ld	(OFST-2,sp),a
 644  00c2 2002          	jra	L111
 645  00c4               L501:
 646                     ; 355       Swif = ERROR;
 647  00c4 0f02          	clr	(OFST-2,sp)
 648  00c6               L111:
 649                     ; 390   if(Swif != ERROR)
 650  00c6 0d02          	tnz	(OFST-2,sp)
 651  00c8 2767          	jreq	L531
 652                     ; 393     if((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSI))
 653  00ca 0d0a          	tnz	(OFST+6,sp)
 654  00cc 2645          	jrne	L731
 656  00ce 7b01          	ld	a,(OFST-3,sp)
 657  00d0 a1e1          	cp	a,#225
 658  00d2 263f          	jrne	L731
 659                     ; 395       CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
 660  00d4 721150c0      	bres	20672,#0
 662  00d8 2057          	jra	L531
 663  00da               L56:
 664                     ; 361     if (ITState != DISABLE)
 665  00da 0d09          	tnz	(OFST+5,sp)
 666  00dc 2706          	jreq	L311
 667                     ; 363       CLK->SWCR |= CLK_SWCR_SWIEN;
 668  00de 721450c5      	bset	20677,#2
 670  00e2 2004          	jra	L511
 671  00e4               L311:
 672                     ; 367       CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
 673  00e4 721550c5      	bres	20677,#2
 674  00e8               L511:
 675                     ; 371     CLK->SWR = (uint8_t)CLK_NewClock;
 676  00e8 7b06          	ld	a,(OFST+2,sp)
 677  00ea c750c4        	ld	20676,a
 679  00ed 2007          	jra	L321
 680  00ef               L711:
 681                     ; 376       DownCounter--;
 682  00ef 1e03          	ldw	x,(OFST-1,sp)
 683  00f1 1d0001        	subw	x,#1
 684  00f4 1f03          	ldw	(OFST-1,sp),x
 685  00f6               L321:
 686                     ; 374     while((((CLK->SWCR & CLK_SWCR_SWIF) != 0 ) && (DownCounter != 0)))
 687  00f6 c650c5        	ld	a,20677
 688  00f9 a508          	bcp	a,#8
 689  00fb 2704          	jreq	L721
 691  00fd 1e03          	ldw	x,(OFST-1,sp)
 692  00ff 26ee          	jrne	L711
 693  0101               L721:
 694                     ; 379     if(DownCounter != 0)
 695  0101 1e03          	ldw	x,(OFST-1,sp)
 696  0103 270a          	jreq	L131
 697                     ; 382       CLK->SWCR |= CLK_SWCR_SWEN;
 698  0105 721250c5      	bset	20677,#1
 699                     ; 383       Swif = SUCCESS;
 700  0109 a601          	ld	a,#1
 701  010b 6b02          	ld	(OFST-2,sp),a
 703  010d 20b7          	jra	L111
 704  010f               L131:
 705                     ; 387       Swif = ERROR;
 706  010f 0f02          	clr	(OFST-2,sp)
 707  0111 20b3          	jra	L111
 708  0113               L731:
 709                     ; 397     else if((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_LSI))
 710  0113 0d0a          	tnz	(OFST+6,sp)
 711  0115 260c          	jrne	L341
 713  0117 7b01          	ld	a,(OFST-3,sp)
 714  0119 a1d2          	cp	a,#210
 715  011b 2606          	jrne	L341
 716                     ; 399       CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
 717  011d 721750c0      	bres	20672,#3
 719  0121 200e          	jra	L531
 720  0123               L341:
 721                     ; 401     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSE))
 722  0123 0d0a          	tnz	(OFST+6,sp)
 723  0125 260a          	jrne	L531
 725  0127 7b01          	ld	a,(OFST-3,sp)
 726  0129 a1b4          	cp	a,#180
 727  012b 2604          	jrne	L531
 728                     ; 403       CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
 729  012d 721150c1      	bres	20673,#0
 730  0131               L531:
 731                     ; 406   return(Swif);
 732  0131 7b02          	ld	a,(OFST-2,sp)
 734  0133 5b06          	addw	sp,#6
 735  0135 81            	ret
 737                     ; 415 void CLK_HSIPrescalerConfig(CLK_Prescaler_TypeDef HSIPrescaler)
 737                     ; 416 {
 738                     .text:	section	.text,new
 739  0000               _CLK_HSIPrescalerConfig:
 740  0000 88            	push	a
 741       00000000      OFST:	set	0
 743                     ; 418   assert_param(IS_CLK_HSIPRESCALER_OK(HSIPrescaler));
 744  0001 4d            	tnz	a
 745  0002 270c          	jreq	L071
 746  0004 a108          	cp	a,#8
 747  0006 2708          	jreq	L071
 748  0008 a110          	cp	a,#16
 749  000a 2704          	jreq	L071
 750  000c a118          	cp	a,#24
 751  000e 2603          	jrne	L661
 752  0010               L071:
 753  0010 4f            	clr	a
 754  0011 2010          	jra	L271
 755  0013               L661:
 756  0013 ae01a2        	ldw	x,#418
 757  0016 89            	pushw	x
 758  0017 ae0000        	ldw	x,#0
 759  001a 89            	pushw	x
 760  001b ae000c        	ldw	x,#L31
 761  001e cd0000        	call	_assert_failed
 763  0021 5b04          	addw	sp,#4
 764  0023               L271:
 765                     ; 421   CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
 766  0023 c650c6        	ld	a,20678
 767  0026 a4e7          	and	a,#231
 768  0028 c750c6        	ld	20678,a
 769                     ; 424   CLK->CKDIVR |= (uint8_t)HSIPrescaler;
 770  002b c650c6        	ld	a,20678
 771  002e 1a01          	or	a,(OFST+1,sp)
 772  0030 c750c6        	ld	20678,a
 773                     ; 425 }
 774  0033 84            	pop	a
 775  0034 81            	ret
 777                     ; 436 void CLK_CCOConfig(CLK_Output_TypeDef CLK_CCO)
 777                     ; 437 {
 778                     .text:	section	.text,new
 779  0000               _CLK_CCOConfig:
 780  0000 88            	push	a
 781       00000000      OFST:	set	0
 783                     ; 439   assert_param(IS_CLK_OUTPUT_OK(CLK_CCO));
 784  0001 4d            	tnz	a
 785  0002 2730          	jreq	L002
 786  0004 a104          	cp	a,#4
 787  0006 272c          	jreq	L002
 788  0008 a102          	cp	a,#2
 789  000a 2728          	jreq	L002
 790  000c a108          	cp	a,#8
 791  000e 2724          	jreq	L002
 792  0010 a10a          	cp	a,#10
 793  0012 2720          	jreq	L002
 794  0014 a10c          	cp	a,#12
 795  0016 271c          	jreq	L002
 796  0018 a10e          	cp	a,#14
 797  001a 2718          	jreq	L002
 798  001c a110          	cp	a,#16
 799  001e 2714          	jreq	L002
 800  0020 a112          	cp	a,#18
 801  0022 2710          	jreq	L002
 802  0024 a114          	cp	a,#20
 803  0026 270c          	jreq	L002
 804  0028 a116          	cp	a,#22
 805  002a 2708          	jreq	L002
 806  002c a118          	cp	a,#24
 807  002e 2704          	jreq	L002
 808  0030 a11a          	cp	a,#26
 809  0032 2603          	jrne	L671
 810  0034               L002:
 811  0034 4f            	clr	a
 812  0035 2010          	jra	L202
 813  0037               L671:
 814  0037 ae01b7        	ldw	x,#439
 815  003a 89            	pushw	x
 816  003b ae0000        	ldw	x,#0
 817  003e 89            	pushw	x
 818  003f ae000c        	ldw	x,#L31
 819  0042 cd0000        	call	_assert_failed
 821  0045 5b04          	addw	sp,#4
 822  0047               L202:
 823                     ; 442   CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOSEL);
 824  0047 c650c9        	ld	a,20681
 825  004a a4e1          	and	a,#225
 826  004c c750c9        	ld	20681,a
 827                     ; 445   CLK->CCOR |= (uint8_t)CLK_CCO;
 828  004f c650c9        	ld	a,20681
 829  0052 1a01          	or	a,(OFST+1,sp)
 830  0054 c750c9        	ld	20681,a
 831                     ; 448   CLK->CCOR |= CLK_CCOR_CCOEN;
 832  0057 721050c9      	bset	20681,#0
 833                     ; 449 }
 834  005b 84            	pop	a
 835  005c 81            	ret
 837                     ; 459 void CLK_ITConfig(CLK_IT_TypeDef CLK_IT, FunctionalState NewState)
 837                     ; 460 {
 838                     .text:	section	.text,new
 839  0000               _CLK_ITConfig:
 840  0000 89            	pushw	x
 841       00000000      OFST:	set	0
 843                     ; 462   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 844  0001 9f            	ld	a,xl
 845  0002 4d            	tnz	a
 846  0003 2705          	jreq	L012
 847  0005 9f            	ld	a,xl
 848  0006 a101          	cp	a,#1
 849  0008 2603          	jrne	L602
 850  000a               L012:
 851  000a 4f            	clr	a
 852  000b 2010          	jra	L212
 853  000d               L602:
 854  000d ae01ce        	ldw	x,#462
 855  0010 89            	pushw	x
 856  0011 ae0000        	ldw	x,#0
 857  0014 89            	pushw	x
 858  0015 ae000c        	ldw	x,#L31
 859  0018 cd0000        	call	_assert_failed
 861  001b 5b04          	addw	sp,#4
 862  001d               L212:
 863                     ; 463   assert_param(IS_CLK_IT_OK(CLK_IT));
 864  001d 7b01          	ld	a,(OFST+1,sp)
 865  001f a10c          	cp	a,#12
 866  0021 2706          	jreq	L612
 867  0023 7b01          	ld	a,(OFST+1,sp)
 868  0025 a11c          	cp	a,#28
 869  0027 2603          	jrne	L412
 870  0029               L612:
 871  0029 4f            	clr	a
 872  002a 2010          	jra	L022
 873  002c               L412:
 874  002c ae01cf        	ldw	x,#463
 875  002f 89            	pushw	x
 876  0030 ae0000        	ldw	x,#0
 877  0033 89            	pushw	x
 878  0034 ae000c        	ldw	x,#L31
 879  0037 cd0000        	call	_assert_failed
 881  003a 5b04          	addw	sp,#4
 882  003c               L022:
 883                     ; 465   if (NewState != DISABLE)
 884  003c 0d02          	tnz	(OFST+2,sp)
 885  003e 271a          	jreq	L561
 886                     ; 467     switch (CLK_IT)
 887  0040 7b01          	ld	a,(OFST+1,sp)
 889                     ; 475     default:
 889                     ; 476       break;
 890  0042 a00c          	sub	a,#12
 891  0044 270a          	jreq	L351
 892  0046 a010          	sub	a,#16
 893  0048 2624          	jrne	L371
 894                     ; 469     case CLK_IT_SWIF: /* Enable the clock switch interrupt */
 894                     ; 470       CLK->SWCR |= CLK_SWCR_SWIEN;
 895  004a 721450c5      	bset	20677,#2
 896                     ; 471       break;
 897  004e 201e          	jra	L371
 898  0050               L351:
 899                     ; 472     case CLK_IT_CSSD: /* Enable the clock security system detection interrupt */
 899                     ; 473       CLK->CSSR |= CLK_CSSR_CSSDIE;
 900  0050 721450c8      	bset	20680,#2
 901                     ; 474       break;
 902  0054 2018          	jra	L371
 903  0056               L551:
 904                     ; 475     default:
 904                     ; 476       break;
 905  0056 2016          	jra	L371
 906  0058               L171:
 908  0058 2014          	jra	L371
 909  005a               L561:
 910                     ; 481     switch (CLK_IT)
 911  005a 7b01          	ld	a,(OFST+1,sp)
 913                     ; 489     default:
 913                     ; 490       break;
 914  005c a00c          	sub	a,#12
 915  005e 270a          	jreq	L161
 916  0060 a010          	sub	a,#16
 917  0062 260a          	jrne	L371
 918                     ; 483     case CLK_IT_SWIF: /* Disable the clock switch interrupt */
 918                     ; 484       CLK->SWCR  &= (uint8_t)(~CLK_SWCR_SWIEN);
 919  0064 721550c5      	bres	20677,#2
 920                     ; 485       break;
 921  0068 2004          	jra	L371
 922  006a               L161:
 923                     ; 486     case CLK_IT_CSSD: /* Disable the clock security system detection interrupt */
 923                     ; 487       CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSDIE);
 924  006a 721550c8      	bres	20680,#2
 925                     ; 488       break;
 926  006e               L371:
 927                     ; 493 }
 928  006e 85            	popw	x
 929  006f 81            	ret
 930  0070               L361:
 931                     ; 489     default:
 931                     ; 490       break;
 932  0070 20fc          	jra	L371
 933  0072               L771:
 934  0072 20fa          	jra	L371
 936                     ; 500 void CLK_SYSCLKConfig(CLK_Prescaler_TypeDef CLK_Prescaler)
 936                     ; 501 {
 937                     .text:	section	.text,new
 938  0000               _CLK_SYSCLKConfig:
 939  0000 88            	push	a
 940       00000000      OFST:	set	0
 942                     ; 503   assert_param(IS_CLK_PRESCALER_OK(CLK_Prescaler));
 943  0001 4d            	tnz	a
 944  0002 272c          	jreq	L622
 945  0004 a108          	cp	a,#8
 946  0006 2728          	jreq	L622
 947  0008 a110          	cp	a,#16
 948  000a 2724          	jreq	L622
 949  000c a118          	cp	a,#24
 950  000e 2720          	jreq	L622
 951  0010 a180          	cp	a,#128
 952  0012 271c          	jreq	L622
 953  0014 a181          	cp	a,#129
 954  0016 2718          	jreq	L622
 955  0018 a182          	cp	a,#130
 956  001a 2714          	jreq	L622
 957  001c a183          	cp	a,#131
 958  001e 2710          	jreq	L622
 959  0020 a184          	cp	a,#132
 960  0022 270c          	jreq	L622
 961  0024 a185          	cp	a,#133
 962  0026 2708          	jreq	L622
 963  0028 a186          	cp	a,#134
 964  002a 2704          	jreq	L622
 965  002c a187          	cp	a,#135
 966  002e 2603          	jrne	L422
 967  0030               L622:
 968  0030 4f            	clr	a
 969  0031 2010          	jra	L032
 970  0033               L422:
 971  0033 ae01f7        	ldw	x,#503
 972  0036 89            	pushw	x
 973  0037 ae0000        	ldw	x,#0
 974  003a 89            	pushw	x
 975  003b ae000c        	ldw	x,#L31
 976  003e cd0000        	call	_assert_failed
 978  0041 5b04          	addw	sp,#4
 979  0043               L032:
 980                     ; 505   if (((uint8_t)CLK_Prescaler & (uint8_t)0x80) == 0x00) /* Bit7 = 0 means HSI divider */
 981  0043 7b01          	ld	a,(OFST+1,sp)
 982  0045 a580          	bcp	a,#128
 983  0047 2614          	jrne	L102
 984                     ; 507     CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
 985  0049 c650c6        	ld	a,20678
 986  004c a4e7          	and	a,#231
 987  004e c750c6        	ld	20678,a
 988                     ; 508     CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_HSIDIV);
 989  0051 7b01          	ld	a,(OFST+1,sp)
 990  0053 a418          	and	a,#24
 991  0055 ca50c6        	or	a,20678
 992  0058 c750c6        	ld	20678,a
 994  005b 2012          	jra	L302
 995  005d               L102:
 996                     ; 512     CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_CPUDIV);
 997  005d c650c6        	ld	a,20678
 998  0060 a4f8          	and	a,#248
 999  0062 c750c6        	ld	20678,a
1000                     ; 513     CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_CPUDIV);
1001  0065 7b01          	ld	a,(OFST+1,sp)
1002  0067 a407          	and	a,#7
1003  0069 ca50c6        	or	a,20678
1004  006c c750c6        	ld	20678,a
1005  006f               L302:
1006                     ; 515 }
1007  006f 84            	pop	a
1008  0070 81            	ret
1010                     ; 523 void CLK_SWIMConfig(CLK_SWIMDivider_TypeDef CLK_SWIMDivider)
1010                     ; 524 {
1011                     .text:	section	.text,new
1012  0000               _CLK_SWIMConfig:
1013  0000 88            	push	a
1014       00000000      OFST:	set	0
1016                     ; 526   assert_param(IS_CLK_SWIMDIVIDER_OK(CLK_SWIMDivider));
1017  0001 4d            	tnz	a
1018  0002 2704          	jreq	L632
1019  0004 a101          	cp	a,#1
1020  0006 2603          	jrne	L432
1021  0008               L632:
1022  0008 4f            	clr	a
1023  0009 2010          	jra	L042
1024  000b               L432:
1025  000b ae020e        	ldw	x,#526
1026  000e 89            	pushw	x
1027  000f ae0000        	ldw	x,#0
1028  0012 89            	pushw	x
1029  0013 ae000c        	ldw	x,#L31
1030  0016 cd0000        	call	_assert_failed
1032  0019 5b04          	addw	sp,#4
1033  001b               L042:
1034                     ; 528   if (CLK_SWIMDivider != CLK_SWIMDIVIDER_2)
1035  001b 0d01          	tnz	(OFST+1,sp)
1036  001d 2706          	jreq	L502
1037                     ; 531     CLK->SWIMCCR |= CLK_SWIMCCR_SWIMDIV;
1038  001f 721050cd      	bset	20685,#0
1040  0023 2004          	jra	L702
1041  0025               L502:
1042                     ; 536     CLK->SWIMCCR &= (uint8_t)(~CLK_SWIMCCR_SWIMDIV);
1043  0025 721150cd      	bres	20685,#0
1044  0029               L702:
1045                     ; 538 }
1046  0029 84            	pop	a
1047  002a 81            	ret
1049                     ; 547 void CLK_ClockSecuritySystemEnable(void)
1049                     ; 548 {
1050                     .text:	section	.text,new
1051  0000               _CLK_ClockSecuritySystemEnable:
1053                     ; 550   CLK->CSSR |= CLK_CSSR_CSSEN;
1054  0000 721050c8      	bset	20680,#0
1055                     ; 551 }
1056  0004 81            	ret
1058                     ; 559 CLK_Source_TypeDef CLK_GetSYSCLKSource(void)
1058                     ; 560 {
1059                     .text:	section	.text,new
1060  0000               _CLK_GetSYSCLKSource:
1062                     ; 561   return((CLK_Source_TypeDef)CLK->CMSR);
1063  0000 c650c3        	ld	a,20675
1065  0003 81            	ret
1067                     ; 569 uint32_t CLK_GetClockFreq(void)
1067                     ; 570 {
1068                     .text:	section	.text,new
1069  0000               _CLK_GetClockFreq:
1070  0000 5209          	subw	sp,#9
1071       00000009      OFST:	set	9
1073                     ; 571   uint32_t clockfrequency = 0;
1074                     ; 572   CLK_Source_TypeDef clocksource = CLK_SOURCE_HSI;
1075                     ; 573   uint8_t tmp = 0, presc = 0;
1077                     ; 576   clocksource = (CLK_Source_TypeDef)CLK->CMSR;
1078  0002 c650c3        	ld	a,20675
1079  0005 6b09          	ld	(OFST+0,sp),a
1080                     ; 578   if (clocksource == CLK_SOURCE_HSI)
1081  0007 7b09          	ld	a,(OFST+0,sp)
1082  0009 a1e1          	cp	a,#225
1083  000b 2641          	jrne	L112
1084                     ; 580     tmp = (uint8_t)(CLK->CKDIVR & CLK_CKDIVR_HSIDIV);
1085  000d c650c6        	ld	a,20678
1086  0010 a418          	and	a,#24
1087  0012 6b09          	ld	(OFST+0,sp),a
1088                     ; 581     tmp = (uint8_t)(tmp >> 3);
1089  0014 0409          	srl	(OFST+0,sp)
1090  0016 0409          	srl	(OFST+0,sp)
1091  0018 0409          	srl	(OFST+0,sp)
1092                     ; 582     presc = HSIDivFactor[tmp];
1093  001a 7b09          	ld	a,(OFST+0,sp)
1094  001c 5f            	clrw	x
1095  001d 97            	ld	xl,a
1096  001e d60000        	ld	a,(_HSIDivFactor,x)
1097  0021 6b09          	ld	(OFST+0,sp),a
1098                     ; 583     clockfrequency = HSI_VALUE / presc;
1099  0023 7b09          	ld	a,(OFST+0,sp)
1100  0025 b703          	ld	c_lreg+3,a
1101  0027 3f02          	clr	c_lreg+2
1102  0029 3f01          	clr	c_lreg+1
1103  002b 3f00          	clr	c_lreg
1104  002d 96            	ldw	x,sp
1105  002e 1c0001        	addw	x,#OFST-8
1106  0031 cd0000        	call	c_rtol
1108  0034 ae2400        	ldw	x,#9216
1109  0037 bf02          	ldw	c_lreg+2,x
1110  0039 ae00f4        	ldw	x,#244
1111  003c bf00          	ldw	c_lreg,x
1112  003e 96            	ldw	x,sp
1113  003f 1c0001        	addw	x,#OFST-8
1114  0042 cd0000        	call	c_ludv
1116  0045 96            	ldw	x,sp
1117  0046 1c0005        	addw	x,#OFST-4
1118  0049 cd0000        	call	c_rtol
1121  004c 201c          	jra	L312
1122  004e               L112:
1123                     ; 585   else if ( clocksource == CLK_SOURCE_LSI)
1124  004e 7b09          	ld	a,(OFST+0,sp)
1125  0050 a1d2          	cp	a,#210
1126  0052 260c          	jrne	L512
1127                     ; 587     clockfrequency = LSI_VALUE;
1128  0054 aef400        	ldw	x,#62464
1129  0057 1f07          	ldw	(OFST-2,sp),x
1130  0059 ae0001        	ldw	x,#1
1131  005c 1f05          	ldw	(OFST-4,sp),x
1133  005e 200a          	jra	L312
1134  0060               L512:
1135                     ; 591     clockfrequency = HSE_VALUE;
1136  0060 ae2400        	ldw	x,#9216
1137  0063 1f07          	ldw	(OFST-2,sp),x
1138  0065 ae00f4        	ldw	x,#244
1139  0068 1f05          	ldw	(OFST-4,sp),x
1140  006a               L312:
1141                     ; 594   return((uint32_t)clockfrequency);
1142  006a 96            	ldw	x,sp
1143  006b 1c0005        	addw	x,#OFST-4
1144  006e cd0000        	call	c_ltor
1147  0071 5b09          	addw	sp,#9
1148  0073 81            	ret
1150                     ; 604 void CLK_AdjustHSICalibrationValue(CLK_HSITrimValue_TypeDef CLK_HSICalibrationValue)
1150                     ; 605 {
1151                     .text:	section	.text,new
1152  0000               _CLK_AdjustHSICalibrationValue:
1153  0000 88            	push	a
1154       00000000      OFST:	set	0
1156                     ; 607   assert_param(IS_CLK_HSITRIMVALUE_OK(CLK_HSICalibrationValue));
1157  0001 4d            	tnz	a
1158  0002 271c          	jreq	L452
1159  0004 a101          	cp	a,#1
1160  0006 2718          	jreq	L452
1161  0008 a102          	cp	a,#2
1162  000a 2714          	jreq	L452
1163  000c a103          	cp	a,#3
1164  000e 2710          	jreq	L452
1165  0010 a104          	cp	a,#4
1166  0012 270c          	jreq	L452
1167  0014 a105          	cp	a,#5
1168  0016 2708          	jreq	L452
1169  0018 a106          	cp	a,#6
1170  001a 2704          	jreq	L452
1171  001c a107          	cp	a,#7
1172  001e 2603          	jrne	L252
1173  0020               L452:
1174  0020 4f            	clr	a
1175  0021 2010          	jra	L652
1176  0023               L252:
1177  0023 ae025f        	ldw	x,#607
1178  0026 89            	pushw	x
1179  0027 ae0000        	ldw	x,#0
1180  002a 89            	pushw	x
1181  002b ae000c        	ldw	x,#L31
1182  002e cd0000        	call	_assert_failed
1184  0031 5b04          	addw	sp,#4
1185  0033               L652:
1186                     ; 610   CLK->HSITRIMR = (uint8_t)( (uint8_t)(CLK->HSITRIMR & (uint8_t)(~CLK_HSITRIMR_HSITRIM))|((uint8_t)CLK_HSICalibrationValue));
1187  0033 c650cc        	ld	a,20684
1188  0036 a4f8          	and	a,#248
1189  0038 1a01          	or	a,(OFST+1,sp)
1190  003a c750cc        	ld	20684,a
1191                     ; 611 }
1192  003d 84            	pop	a
1193  003e 81            	ret
1195                     ; 622 void CLK_SYSCLKEmergencyClear(void)
1195                     ; 623 {
1196                     .text:	section	.text,new
1197  0000               _CLK_SYSCLKEmergencyClear:
1199                     ; 624   CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWBSY);
1200  0000 721150c5      	bres	20677,#0
1201                     ; 625 }
1202  0004 81            	ret
1204                     ; 634 FlagStatus CLK_GetFlagStatus(CLK_Flag_TypeDef CLK_FLAG)
1204                     ; 635 {
1205                     .text:	section	.text,new
1206  0000               _CLK_GetFlagStatus:
1207  0000 89            	pushw	x
1208  0001 5203          	subw	sp,#3
1209       00000003      OFST:	set	3
1211                     ; 636   uint16_t statusreg = 0;
1212                     ; 637   uint8_t tmpreg = 0;
1213                     ; 638   FlagStatus bitstatus = RESET;
1214                     ; 641   assert_param(IS_CLK_FLAG_OK(CLK_FLAG));
1215  0003 a30110        	cpw	x,#272
1216  0006 2728          	jreq	L662
1217  0008 a30102        	cpw	x,#258
1218  000b 2723          	jreq	L662
1219  000d a30202        	cpw	x,#514
1220  0010 271e          	jreq	L662
1221  0012 a30308        	cpw	x,#776
1222  0015 2719          	jreq	L662
1223  0017 a30301        	cpw	x,#769
1224  001a 2714          	jreq	L662
1225  001c a30408        	cpw	x,#1032
1226  001f 270f          	jreq	L662
1227  0021 a30402        	cpw	x,#1026
1228  0024 270a          	jreq	L662
1229  0026 a30504        	cpw	x,#1284
1230  0029 2705          	jreq	L662
1231  002b a30502        	cpw	x,#1282
1232  002e 2603          	jrne	L462
1233  0030               L662:
1234  0030 4f            	clr	a
1235  0031 2010          	jra	L072
1236  0033               L462:
1237  0033 ae0281        	ldw	x,#641
1238  0036 89            	pushw	x
1239  0037 ae0000        	ldw	x,#0
1240  003a 89            	pushw	x
1241  003b ae000c        	ldw	x,#L31
1242  003e cd0000        	call	_assert_failed
1244  0041 5b04          	addw	sp,#4
1245  0043               L072:
1246                     ; 644   statusreg = (uint16_t)((uint16_t)CLK_FLAG & (uint16_t)0xFF00);
1247  0043 7b04          	ld	a,(OFST+1,sp)
1248  0045 97            	ld	xl,a
1249  0046 7b05          	ld	a,(OFST+2,sp)
1250  0048 9f            	ld	a,xl
1251  0049 a4ff          	and	a,#255
1252  004b 97            	ld	xl,a
1253  004c 4f            	clr	a
1254  004d 02            	rlwa	x,a
1255  004e 1f01          	ldw	(OFST-2,sp),x
1256  0050 01            	rrwa	x,a
1257                     ; 647   if (statusreg == 0x0100) /* The flag to check is in ICKRregister */
1258  0051 1e01          	ldw	x,(OFST-2,sp)
1259  0053 a30100        	cpw	x,#256
1260  0056 2607          	jrne	L122
1261                     ; 649     tmpreg = CLK->ICKR;
1262  0058 c650c0        	ld	a,20672
1263  005b 6b03          	ld	(OFST+0,sp),a
1265  005d 202f          	jra	L322
1266  005f               L122:
1267                     ; 651   else if (statusreg == 0x0200) /* The flag to check is in ECKRregister */
1268  005f 1e01          	ldw	x,(OFST-2,sp)
1269  0061 a30200        	cpw	x,#512
1270  0064 2607          	jrne	L522
1271                     ; 653     tmpreg = CLK->ECKR;
1272  0066 c650c1        	ld	a,20673
1273  0069 6b03          	ld	(OFST+0,sp),a
1275  006b 2021          	jra	L322
1276  006d               L522:
1277                     ; 655   else if (statusreg == 0x0300) /* The flag to check is in SWIC register */
1278  006d 1e01          	ldw	x,(OFST-2,sp)
1279  006f a30300        	cpw	x,#768
1280  0072 2607          	jrne	L132
1281                     ; 657     tmpreg = CLK->SWCR;
1282  0074 c650c5        	ld	a,20677
1283  0077 6b03          	ld	(OFST+0,sp),a
1285  0079 2013          	jra	L322
1286  007b               L132:
1287                     ; 659   else if (statusreg == 0x0400) /* The flag to check is in CSS register */
1288  007b 1e01          	ldw	x,(OFST-2,sp)
1289  007d a30400        	cpw	x,#1024
1290  0080 2607          	jrne	L532
1291                     ; 661     tmpreg = CLK->CSSR;
1292  0082 c650c8        	ld	a,20680
1293  0085 6b03          	ld	(OFST+0,sp),a
1295  0087 2005          	jra	L322
1296  0089               L532:
1297                     ; 665     tmpreg = CLK->CCOR;
1298  0089 c650c9        	ld	a,20681
1299  008c 6b03          	ld	(OFST+0,sp),a
1300  008e               L322:
1301                     ; 668   if ((tmpreg & (uint8_t)CLK_FLAG) != (uint8_t)RESET)
1302  008e 7b05          	ld	a,(OFST+2,sp)
1303  0090 1503          	bcp	a,(OFST+0,sp)
1304  0092 2706          	jreq	L142
1305                     ; 670     bitstatus = SET;
1306  0094 a601          	ld	a,#1
1307  0096 6b03          	ld	(OFST+0,sp),a
1309  0098 2002          	jra	L342
1310  009a               L142:
1311                     ; 674     bitstatus = RESET;
1312  009a 0f03          	clr	(OFST+0,sp)
1313  009c               L342:
1314                     ; 678   return((FlagStatus)bitstatus);
1315  009c 7b03          	ld	a,(OFST+0,sp)
1317  009e 5b05          	addw	sp,#5
1318  00a0 81            	ret
1320                     ; 687 ITStatus CLK_GetITStatus(CLK_IT_TypeDef CLK_IT)
1320                     ; 688 {
1321                     .text:	section	.text,new
1322  0000               _CLK_GetITStatus:
1323  0000 88            	push	a
1324  0001 88            	push	a
1325       00000001      OFST:	set	1
1327                     ; 689   ITStatus bitstatus = RESET;
1328                     ; 692   assert_param(IS_CLK_IT_OK(CLK_IT));
1329  0002 a10c          	cp	a,#12
1330  0004 2704          	jreq	L672
1331  0006 a11c          	cp	a,#28
1332  0008 2603          	jrne	L472
1333  000a               L672:
1334  000a 4f            	clr	a
1335  000b 2010          	jra	L003
1336  000d               L472:
1337  000d ae02b4        	ldw	x,#692
1338  0010 89            	pushw	x
1339  0011 ae0000        	ldw	x,#0
1340  0014 89            	pushw	x
1341  0015 ae000c        	ldw	x,#L31
1342  0018 cd0000        	call	_assert_failed
1344  001b 5b04          	addw	sp,#4
1345  001d               L003:
1346                     ; 694   if (CLK_IT == CLK_IT_SWIF)
1347  001d 7b02          	ld	a,(OFST+1,sp)
1348  001f a11c          	cp	a,#28
1349  0021 2613          	jrne	L542
1350                     ; 697     if ((CLK->SWCR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
1351  0023 c650c5        	ld	a,20677
1352  0026 1402          	and	a,(OFST+1,sp)
1353  0028 a10c          	cp	a,#12
1354  002a 2606          	jrne	L742
1355                     ; 699       bitstatus = SET;
1356  002c a601          	ld	a,#1
1357  002e 6b01          	ld	(OFST+0,sp),a
1359  0030 2015          	jra	L352
1360  0032               L742:
1361                     ; 703       bitstatus = RESET;
1362  0032 0f01          	clr	(OFST+0,sp)
1363  0034 2011          	jra	L352
1364  0036               L542:
1365                     ; 709     if ((CLK->CSSR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
1366  0036 c650c8        	ld	a,20680
1367  0039 1402          	and	a,(OFST+1,sp)
1368  003b a10c          	cp	a,#12
1369  003d 2606          	jrne	L552
1370                     ; 711       bitstatus = SET;
1371  003f a601          	ld	a,#1
1372  0041 6b01          	ld	(OFST+0,sp),a
1374  0043 2002          	jra	L352
1375  0045               L552:
1376                     ; 715       bitstatus = RESET;
1377  0045 0f01          	clr	(OFST+0,sp)
1378  0047               L352:
1379                     ; 720   return bitstatus;
1380  0047 7b01          	ld	a,(OFST+0,sp)
1382  0049 85            	popw	x
1383  004a 81            	ret
1385                     ; 729 void CLK_ClearITPendingBit(CLK_IT_TypeDef CLK_IT)
1385                     ; 730 {
1386                     .text:	section	.text,new
1387  0000               _CLK_ClearITPendingBit:
1388  0000 88            	push	a
1389       00000000      OFST:	set	0
1391                     ; 732   assert_param(IS_CLK_IT_OK(CLK_IT));
1392  0001 a10c          	cp	a,#12
1393  0003 2704          	jreq	L603
1394  0005 a11c          	cp	a,#28
1395  0007 2603          	jrne	L403
1396  0009               L603:
1397  0009 4f            	clr	a
1398  000a 2010          	jra	L013
1399  000c               L403:
1400  000c ae02dc        	ldw	x,#732
1401  000f 89            	pushw	x
1402  0010 ae0000        	ldw	x,#0
1403  0013 89            	pushw	x
1404  0014 ae000c        	ldw	x,#L31
1405  0017 cd0000        	call	_assert_failed
1407  001a 5b04          	addw	sp,#4
1408  001c               L013:
1409                     ; 734   if (CLK_IT == (uint8_t)CLK_IT_CSSD)
1410  001c 7b01          	ld	a,(OFST+1,sp)
1411  001e a10c          	cp	a,#12
1412  0020 2606          	jrne	L162
1413                     ; 737     CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSD);
1414  0022 721750c8      	bres	20680,#3
1416  0026 2004          	jra	L362
1417  0028               L162:
1418                     ; 742     CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIF);
1419  0028 721750c5      	bres	20677,#3
1420  002c               L362:
1421                     ; 745 }
1422  002c 84            	pop	a
1423  002d 81            	ret
1425                     	xdef	_CLKPrescTable
1426                     	xdef	_HSIDivFactor
1427                     	xdef	_CLK_ClearITPendingBit
1428                     	xdef	_CLK_GetITStatus
1429                     	xdef	_CLK_GetFlagStatus
1430                     	xdef	_CLK_GetSYSCLKSource
1431                     	xdef	_CLK_GetClockFreq
1432                     	xdef	_CLK_AdjustHSICalibrationValue
1433                     	xdef	_CLK_SYSCLKEmergencyClear
1434                     	xdef	_CLK_ClockSecuritySystemEnable
1435                     	xdef	_CLK_SWIMConfig
1436                     	xdef	_CLK_SYSCLKConfig
1437                     	xdef	_CLK_ITConfig
1438                     	xdef	_CLK_CCOConfig
1439                     	xdef	_CLK_HSIPrescalerConfig
1440                     	xdef	_CLK_ClockSwitchConfig
1441                     	xdef	_CLK_PeripheralClockConfig
1442                     	xdef	_CLK_SlowActiveHaltWakeUpCmd
1443                     	xdef	_CLK_FastHaltWakeUpCmd
1444                     	xdef	_CLK_ClockSwitchCmd
1445                     	xdef	_CLK_CCOCmd
1446                     	xdef	_CLK_LSICmd
1447                     	xdef	_CLK_HSICmd
1448                     	xdef	_CLK_HSECmd
1449                     	xdef	_CLK_DeInit
1450                     	xref	_assert_failed
1451                     	switch	.const
1452  000c               L31:
1453  000c 2e2e5c73746d  	dc.b	"..\stm8s_stdperiph"
1454  001e 5f6472697665  	dc.b	"_driver\src\stm8s_"
1455  0030 636c6b2e6300  	dc.b	"clk.c",0
1456                     	xref.b	c_lreg
1457                     	xref.b	c_x
1458                     	xref	c_ltor
1459                     	xref	c_ludv
1460                     	xref	c_rtol
1461                     	end
