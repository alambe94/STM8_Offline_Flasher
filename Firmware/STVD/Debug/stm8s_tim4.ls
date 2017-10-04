   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  45                     ; 43 void TIM4_DeInit(void)
  45                     ; 44 {
  47                     .text:	section	.text,new
  48  0000               _TIM4_DeInit:
  52                     ; 45     TIM4->CR1 = TIM4_CR1_RESET_VALUE;
  54  0000 725f5340      	clr	21312
  55                     ; 46     TIM4->IER = TIM4_IER_RESET_VALUE;
  57  0004 725f5343      	clr	21315
  58                     ; 47     TIM4->CNTR = TIM4_CNTR_RESET_VALUE;
  60  0008 725f5346      	clr	21318
  61                     ; 48     TIM4->PSCR = TIM4_PSCR_RESET_VALUE;
  63  000c 725f5347      	clr	21319
  64                     ; 49     TIM4->ARR = TIM4_ARR_RESET_VALUE;
  66  0010 35ff5348      	mov	21320,#255
  67                     ; 50     TIM4->SR1 = TIM4_SR1_RESET_VALUE;
  69  0014 725f5344      	clr	21316
  70                     ; 51 }
  73  0018 81            	ret
 180                     ; 59 void TIM4_TimeBaseInit(TIM4_Prescaler_TypeDef TIM4_Prescaler, uint8_t TIM4_Period)
 180                     ; 60 {
 181                     .text:	section	.text,new
 182  0000               _TIM4_TimeBaseInit:
 184  0000 89            	pushw	x
 185       00000000      OFST:	set	0
 188                     ; 62     assert_param(IS_TIM4_PRESCALER_OK(TIM4_Prescaler));
 190  0001 9e            	ld	a,xh
 191  0002 4d            	tnz	a
 192  0003 2723          	jreq	L21
 193  0005 9e            	ld	a,xh
 194  0006 a101          	cp	a,#1
 195  0008 271e          	jreq	L21
 196  000a 9e            	ld	a,xh
 197  000b a102          	cp	a,#2
 198  000d 2719          	jreq	L21
 199  000f 9e            	ld	a,xh
 200  0010 a103          	cp	a,#3
 201  0012 2714          	jreq	L21
 202  0014 9e            	ld	a,xh
 203  0015 a104          	cp	a,#4
 204  0017 270f          	jreq	L21
 205  0019 9e            	ld	a,xh
 206  001a a105          	cp	a,#5
 207  001c 270a          	jreq	L21
 208  001e 9e            	ld	a,xh
 209  001f a106          	cp	a,#6
 210  0021 2705          	jreq	L21
 211  0023 9e            	ld	a,xh
 212  0024 a107          	cp	a,#7
 213  0026 2603          	jrne	L01
 214  0028               L21:
 215  0028 4f            	clr	a
 216  0029 2010          	jra	L41
 217  002b               L01:
 218  002b ae003e        	ldw	x,#62
 219  002e 89            	pushw	x
 220  002f ae0000        	ldw	x,#0
 221  0032 89            	pushw	x
 222  0033 ae0000        	ldw	x,#L76
 223  0036 cd0000        	call	_assert_failed
 225  0039 5b04          	addw	sp,#4
 226  003b               L41:
 227                     ; 64     TIM4->PSCR = (uint8_t)(TIM4_Prescaler);
 229  003b 7b01          	ld	a,(OFST+1,sp)
 230  003d c75347        	ld	21319,a
 231                     ; 66     TIM4->ARR = (uint8_t)(TIM4_Period);
 233  0040 7b02          	ld	a,(OFST+2,sp)
 234  0042 c75348        	ld	21320,a
 235                     ; 67 }
 238  0045 85            	popw	x
 239  0046 81            	ret
 295                     ; 77 void TIM4_Cmd(FunctionalState NewState)
 295                     ; 78 {
 296                     .text:	section	.text,new
 297  0000               _TIM4_Cmd:
 299  0000 88            	push	a
 300       00000000      OFST:	set	0
 303                     ; 80     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 305  0001 4d            	tnz	a
 306  0002 2704          	jreq	L22
 307  0004 a101          	cp	a,#1
 308  0006 2603          	jrne	L02
 309  0008               L22:
 310  0008 4f            	clr	a
 311  0009 2010          	jra	L42
 312  000b               L02:
 313  000b ae0050        	ldw	x,#80
 314  000e 89            	pushw	x
 315  000f ae0000        	ldw	x,#0
 316  0012 89            	pushw	x
 317  0013 ae0000        	ldw	x,#L76
 318  0016 cd0000        	call	_assert_failed
 320  0019 5b04          	addw	sp,#4
 321  001b               L42:
 322                     ; 83     if (NewState != DISABLE)
 324  001b 0d01          	tnz	(OFST+1,sp)
 325  001d 2706          	jreq	L711
 326                     ; 85         TIM4->CR1 |= TIM4_CR1_CEN;
 328  001f 72105340      	bset	21312,#0
 330  0023 2004          	jra	L121
 331  0025               L711:
 332                     ; 89         TIM4->CR1 &= (uint8_t)(~TIM4_CR1_CEN);
 334  0025 72115340      	bres	21312,#0
 335  0029               L121:
 336                     ; 91 }
 339  0029 84            	pop	a
 340  002a 81            	ret
 399                     ; 103 void TIM4_ITConfig(TIM4_IT_TypeDef TIM4_IT, FunctionalState NewState)
 399                     ; 104 {
 400                     .text:	section	.text,new
 401  0000               _TIM4_ITConfig:
 403  0000 89            	pushw	x
 404       00000000      OFST:	set	0
 407                     ; 106     assert_param(IS_TIM4_IT_OK(TIM4_IT));
 409  0001 9e            	ld	a,xh
 410  0002 a101          	cp	a,#1
 411  0004 2603          	jrne	L03
 412  0006 4f            	clr	a
 413  0007 2010          	jra	L23
 414  0009               L03:
 415  0009 ae006a        	ldw	x,#106
 416  000c 89            	pushw	x
 417  000d ae0000        	ldw	x,#0
 418  0010 89            	pushw	x
 419  0011 ae0000        	ldw	x,#L76
 420  0014 cd0000        	call	_assert_failed
 422  0017 5b04          	addw	sp,#4
 423  0019               L23:
 424                     ; 107     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 426  0019 0d02          	tnz	(OFST+2,sp)
 427  001b 2706          	jreq	L63
 428  001d 7b02          	ld	a,(OFST+2,sp)
 429  001f a101          	cp	a,#1
 430  0021 2603          	jrne	L43
 431  0023               L63:
 432  0023 4f            	clr	a
 433  0024 2010          	jra	L04
 434  0026               L43:
 435  0026 ae006b        	ldw	x,#107
 436  0029 89            	pushw	x
 437  002a ae0000        	ldw	x,#0
 438  002d 89            	pushw	x
 439  002e ae0000        	ldw	x,#L76
 440  0031 cd0000        	call	_assert_failed
 442  0034 5b04          	addw	sp,#4
 443  0036               L04:
 444                     ; 109     if (NewState != DISABLE)
 446  0036 0d02          	tnz	(OFST+2,sp)
 447  0038 270a          	jreq	L351
 448                     ; 112         TIM4->IER |= (uint8_t)TIM4_IT;
 450  003a c65343        	ld	a,21315
 451  003d 1a01          	or	a,(OFST+1,sp)
 452  003f c75343        	ld	21315,a
 454  0042 2009          	jra	L551
 455  0044               L351:
 456                     ; 117         TIM4->IER &= (uint8_t)(~TIM4_IT);
 458  0044 7b01          	ld	a,(OFST+1,sp)
 459  0046 43            	cpl	a
 460  0047 c45343        	and	a,21315
 461  004a c75343        	ld	21315,a
 462  004d               L551:
 463                     ; 119 }
 466  004d 85            	popw	x
 467  004e 81            	ret
 504                     ; 127 void TIM4_UpdateDisableConfig(FunctionalState NewState)
 504                     ; 128 {
 505                     .text:	section	.text,new
 506  0000               _TIM4_UpdateDisableConfig:
 508  0000 88            	push	a
 509       00000000      OFST:	set	0
 512                     ; 130     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 514  0001 4d            	tnz	a
 515  0002 2704          	jreq	L64
 516  0004 a101          	cp	a,#1
 517  0006 2603          	jrne	L44
 518  0008               L64:
 519  0008 4f            	clr	a
 520  0009 2010          	jra	L05
 521  000b               L44:
 522  000b ae0082        	ldw	x,#130
 523  000e 89            	pushw	x
 524  000f ae0000        	ldw	x,#0
 525  0012 89            	pushw	x
 526  0013 ae0000        	ldw	x,#L76
 527  0016 cd0000        	call	_assert_failed
 529  0019 5b04          	addw	sp,#4
 530  001b               L05:
 531                     ; 133     if (NewState != DISABLE)
 533  001b 0d01          	tnz	(OFST+1,sp)
 534  001d 2706          	jreq	L571
 535                     ; 135         TIM4->CR1 |= TIM4_CR1_UDIS;
 537  001f 72125340      	bset	21312,#1
 539  0023 2004          	jra	L771
 540  0025               L571:
 541                     ; 139         TIM4->CR1 &= (uint8_t)(~TIM4_CR1_UDIS);
 543  0025 72135340      	bres	21312,#1
 544  0029               L771:
 545                     ; 141 }
 548  0029 84            	pop	a
 549  002a 81            	ret
 608                     ; 151 void TIM4_UpdateRequestConfig(TIM4_UpdateSource_TypeDef TIM4_UpdateSource)
 608                     ; 152 {
 609                     .text:	section	.text,new
 610  0000               _TIM4_UpdateRequestConfig:
 612  0000 88            	push	a
 613       00000000      OFST:	set	0
 616                     ; 154     assert_param(IS_TIM4_UPDATE_SOURCE_OK(TIM4_UpdateSource));
 618  0001 4d            	tnz	a
 619  0002 2704          	jreq	L65
 620  0004 a101          	cp	a,#1
 621  0006 2603          	jrne	L45
 622  0008               L65:
 623  0008 4f            	clr	a
 624  0009 2010          	jra	L06
 625  000b               L45:
 626  000b ae009a        	ldw	x,#154
 627  000e 89            	pushw	x
 628  000f ae0000        	ldw	x,#0
 629  0012 89            	pushw	x
 630  0013 ae0000        	ldw	x,#L76
 631  0016 cd0000        	call	_assert_failed
 633  0019 5b04          	addw	sp,#4
 634  001b               L06:
 635                     ; 157     if (TIM4_UpdateSource != TIM4_UPDATESOURCE_GLOBAL)
 637  001b 0d01          	tnz	(OFST+1,sp)
 638  001d 2706          	jreq	L722
 639                     ; 159         TIM4->CR1 |= TIM4_CR1_URS;
 641  001f 72145340      	bset	21312,#2
 643  0023 2004          	jra	L132
 644  0025               L722:
 645                     ; 163         TIM4->CR1 &= (uint8_t)(~TIM4_CR1_URS);
 647  0025 72155340      	bres	21312,#2
 648  0029               L132:
 649                     ; 165 }
 652  0029 84            	pop	a
 653  002a 81            	ret
 711                     ; 175 void TIM4_SelectOnePulseMode(TIM4_OPMode_TypeDef TIM4_OPMode)
 711                     ; 176 {
 712                     .text:	section	.text,new
 713  0000               _TIM4_SelectOnePulseMode:
 715  0000 88            	push	a
 716       00000000      OFST:	set	0
 719                     ; 178     assert_param(IS_TIM4_OPM_MODE_OK(TIM4_OPMode));
 721  0001 a101          	cp	a,#1
 722  0003 2703          	jreq	L66
 723  0005 4d            	tnz	a
 724  0006 2603          	jrne	L46
 725  0008               L66:
 726  0008 4f            	clr	a
 727  0009 2010          	jra	L07
 728  000b               L46:
 729  000b ae00b2        	ldw	x,#178
 730  000e 89            	pushw	x
 731  000f ae0000        	ldw	x,#0
 732  0012 89            	pushw	x
 733  0013 ae0000        	ldw	x,#L76
 734  0016 cd0000        	call	_assert_failed
 736  0019 5b04          	addw	sp,#4
 737  001b               L07:
 738                     ; 181     if (TIM4_OPMode != TIM4_OPMODE_REPETITIVE)
 740  001b 0d01          	tnz	(OFST+1,sp)
 741  001d 2706          	jreq	L162
 742                     ; 183         TIM4->CR1 |= TIM4_CR1_OPM;
 744  001f 72165340      	bset	21312,#3
 746  0023 2004          	jra	L362
 747  0025               L162:
 748                     ; 187         TIM4->CR1 &= (uint8_t)(~TIM4_CR1_OPM);
 750  0025 72175340      	bres	21312,#3
 751  0029               L362:
 752                     ; 190 }
 755  0029 84            	pop	a
 756  002a 81            	ret
 825                     ; 212 void TIM4_PrescalerConfig(TIM4_Prescaler_TypeDef Prescaler, TIM4_PSCReloadMode_TypeDef TIM4_PSCReloadMode)
 825                     ; 213 {
 826                     .text:	section	.text,new
 827  0000               _TIM4_PrescalerConfig:
 829  0000 89            	pushw	x
 830       00000000      OFST:	set	0
 833                     ; 215     assert_param(IS_TIM4_PRESCALER_RELOAD_OK(TIM4_PSCReloadMode));
 835  0001 9f            	ld	a,xl
 836  0002 4d            	tnz	a
 837  0003 2705          	jreq	L67
 838  0005 9f            	ld	a,xl
 839  0006 a101          	cp	a,#1
 840  0008 2603          	jrne	L47
 841  000a               L67:
 842  000a 4f            	clr	a
 843  000b 2010          	jra	L001
 844  000d               L47:
 845  000d ae00d7        	ldw	x,#215
 846  0010 89            	pushw	x
 847  0011 ae0000        	ldw	x,#0
 848  0014 89            	pushw	x
 849  0015 ae0000        	ldw	x,#L76
 850  0018 cd0000        	call	_assert_failed
 852  001b 5b04          	addw	sp,#4
 853  001d               L001:
 854                     ; 216     assert_param(IS_TIM4_PRESCALER_OK(Prescaler));
 856  001d 0d01          	tnz	(OFST+1,sp)
 857  001f 272a          	jreq	L401
 858  0021 7b01          	ld	a,(OFST+1,sp)
 859  0023 a101          	cp	a,#1
 860  0025 2724          	jreq	L401
 861  0027 7b01          	ld	a,(OFST+1,sp)
 862  0029 a102          	cp	a,#2
 863  002b 271e          	jreq	L401
 864  002d 7b01          	ld	a,(OFST+1,sp)
 865  002f a103          	cp	a,#3
 866  0031 2718          	jreq	L401
 867  0033 7b01          	ld	a,(OFST+1,sp)
 868  0035 a104          	cp	a,#4
 869  0037 2712          	jreq	L401
 870  0039 7b01          	ld	a,(OFST+1,sp)
 871  003b a105          	cp	a,#5
 872  003d 270c          	jreq	L401
 873  003f 7b01          	ld	a,(OFST+1,sp)
 874  0041 a106          	cp	a,#6
 875  0043 2706          	jreq	L401
 876  0045 7b01          	ld	a,(OFST+1,sp)
 877  0047 a107          	cp	a,#7
 878  0049 2603          	jrne	L201
 879  004b               L401:
 880  004b 4f            	clr	a
 881  004c 2010          	jra	L601
 882  004e               L201:
 883  004e ae00d8        	ldw	x,#216
 884  0051 89            	pushw	x
 885  0052 ae0000        	ldw	x,#0
 886  0055 89            	pushw	x
 887  0056 ae0000        	ldw	x,#L76
 888  0059 cd0000        	call	_assert_failed
 890  005c 5b04          	addw	sp,#4
 891  005e               L601:
 892                     ; 219     TIM4->PSCR = (uint8_t)Prescaler;
 894  005e 7b01          	ld	a,(OFST+1,sp)
 895  0060 c75347        	ld	21319,a
 896                     ; 222     TIM4->EGR = (uint8_t)TIM4_PSCReloadMode;
 898  0063 7b02          	ld	a,(OFST+2,sp)
 899  0065 c75345        	ld	21317,a
 900                     ; 223 }
 903  0068 85            	popw	x
 904  0069 81            	ret
 941                     ; 231 void TIM4_ARRPreloadConfig(FunctionalState NewState)
 941                     ; 232 {
 942                     .text:	section	.text,new
 943  0000               _TIM4_ARRPreloadConfig:
 945  0000 88            	push	a
 946       00000000      OFST:	set	0
 949                     ; 234     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 951  0001 4d            	tnz	a
 952  0002 2704          	jreq	L411
 953  0004 a101          	cp	a,#1
 954  0006 2603          	jrne	L211
 955  0008               L411:
 956  0008 4f            	clr	a
 957  0009 2010          	jra	L611
 958  000b               L211:
 959  000b ae00ea        	ldw	x,#234
 960  000e 89            	pushw	x
 961  000f ae0000        	ldw	x,#0
 962  0012 89            	pushw	x
 963  0013 ae0000        	ldw	x,#L76
 964  0016 cd0000        	call	_assert_failed
 966  0019 5b04          	addw	sp,#4
 967  001b               L611:
 968                     ; 237     if (NewState != DISABLE)
 970  001b 0d01          	tnz	(OFST+1,sp)
 971  001d 2706          	jreq	L533
 972                     ; 239         TIM4->CR1 |= TIM4_CR1_ARPE;
 974  001f 721e5340      	bset	21312,#7
 976  0023 2004          	jra	L733
 977  0025               L533:
 978                     ; 243         TIM4->CR1 &= (uint8_t)(~TIM4_CR1_ARPE);
 980  0025 721f5340      	bres	21312,#7
 981  0029               L733:
 982                     ; 245 }
 985  0029 84            	pop	a
 986  002a 81            	ret
1036                     ; 254 void TIM4_GenerateEvent(TIM4_EventSource_TypeDef TIM4_EventSource)
1036                     ; 255 {
1037                     .text:	section	.text,new
1038  0000               _TIM4_GenerateEvent:
1040  0000 88            	push	a
1041       00000000      OFST:	set	0
1044                     ; 257     assert_param(IS_TIM4_EVENT_SOURCE_OK(TIM4_EventSource));
1046  0001 a101          	cp	a,#1
1047  0003 2603          	jrne	L221
1048  0005 4f            	clr	a
1049  0006 2010          	jra	L421
1050  0008               L221:
1051  0008 ae0101        	ldw	x,#257
1052  000b 89            	pushw	x
1053  000c ae0000        	ldw	x,#0
1054  000f 89            	pushw	x
1055  0010 ae0000        	ldw	x,#L76
1056  0013 cd0000        	call	_assert_failed
1058  0016 5b04          	addw	sp,#4
1059  0018               L421:
1060                     ; 260     TIM4->EGR = (uint8_t)(TIM4_EventSource);
1062  0018 7b01          	ld	a,(OFST+1,sp)
1063  001a c75345        	ld	21317,a
1064                     ; 261 }
1067  001d 84            	pop	a
1068  001e 81            	ret
1102                     ; 270 void TIM4_SetCounter(uint8_t Counter)
1102                     ; 271 {
1103                     .text:	section	.text,new
1104  0000               _TIM4_SetCounter:
1108                     ; 273     TIM4->CNTR = (uint8_t)(Counter);
1110  0000 c75346        	ld	21318,a
1111                     ; 274 }
1114  0003 81            	ret
1148                     ; 283 void TIM4_SetAutoreload(uint8_t Autoreload)
1148                     ; 284 {
1149                     .text:	section	.text,new
1150  0000               _TIM4_SetAutoreload:
1154                     ; 286     TIM4->ARR = (uint8_t)(Autoreload);
1156  0000 c75348        	ld	21320,a
1157                     ; 287 }
1160  0003 81            	ret
1183                     ; 294 uint8_t TIM4_GetCounter(void)
1183                     ; 295 {
1184                     .text:	section	.text,new
1185  0000               _TIM4_GetCounter:
1189                     ; 297     return (uint8_t)(TIM4->CNTR);
1191  0000 c65346        	ld	a,21318
1194  0003 81            	ret
1218                     ; 305 TIM4_Prescaler_TypeDef TIM4_GetPrescaler(void)
1218                     ; 306 {
1219                     .text:	section	.text,new
1220  0000               _TIM4_GetPrescaler:
1224                     ; 308     return (TIM4_Prescaler_TypeDef)(TIM4->PSCR);
1226  0000 c65347        	ld	a,21319
1229  0003 81            	ret
1309                     ; 318 FlagStatus TIM4_GetFlagStatus(TIM4_FLAG_TypeDef TIM4_FLAG)
1309                     ; 319 {
1310                     .text:	section	.text,new
1311  0000               _TIM4_GetFlagStatus:
1313  0000 88            	push	a
1314  0001 88            	push	a
1315       00000001      OFST:	set	1
1318                     ; 320     FlagStatus bitstatus = RESET;
1320                     ; 323     assert_param(IS_TIM4_GET_FLAG_OK(TIM4_FLAG));
1322  0002 a101          	cp	a,#1
1323  0004 2603          	jrne	L041
1324  0006 4f            	clr	a
1325  0007 2010          	jra	L241
1326  0009               L041:
1327  0009 ae0143        	ldw	x,#323
1328  000c 89            	pushw	x
1329  000d ae0000        	ldw	x,#0
1330  0010 89            	pushw	x
1331  0011 ae0000        	ldw	x,#L76
1332  0014 cd0000        	call	_assert_failed
1334  0017 5b04          	addw	sp,#4
1335  0019               L241:
1336                     ; 325   if ((TIM4->SR1 & (uint8_t)TIM4_FLAG)  != 0)
1338  0019 c65344        	ld	a,21316
1339  001c 1502          	bcp	a,(OFST+1,sp)
1340  001e 2706          	jreq	L105
1341                     ; 327     bitstatus = SET;
1343  0020 a601          	ld	a,#1
1344  0022 6b01          	ld	(OFST+0,sp),a
1346  0024 2002          	jra	L305
1347  0026               L105:
1348                     ; 331     bitstatus = RESET;
1350  0026 0f01          	clr	(OFST+0,sp)
1351  0028               L305:
1352                     ; 333   return ((FlagStatus)bitstatus);
1354  0028 7b01          	ld	a,(OFST+0,sp)
1357  002a 85            	popw	x
1358  002b 81            	ret
1394                     ; 343 void TIM4_ClearFlag(TIM4_FLAG_TypeDef TIM4_FLAG)
1394                     ; 344 {
1395                     .text:	section	.text,new
1396  0000               _TIM4_ClearFlag:
1398  0000 88            	push	a
1399       00000000      OFST:	set	0
1402                     ; 346     assert_param(IS_TIM4_GET_FLAG_OK(TIM4_FLAG));
1404  0001 a101          	cp	a,#1
1405  0003 2603          	jrne	L641
1406  0005 4f            	clr	a
1407  0006 2010          	jra	L051
1408  0008               L641:
1409  0008 ae015a        	ldw	x,#346
1410  000b 89            	pushw	x
1411  000c ae0000        	ldw	x,#0
1412  000f 89            	pushw	x
1413  0010 ae0000        	ldw	x,#L76
1414  0013 cd0000        	call	_assert_failed
1416  0016 5b04          	addw	sp,#4
1417  0018               L051:
1418                     ; 349     TIM4->SR1 = (uint8_t)(~TIM4_FLAG);
1420  0018 7b01          	ld	a,(OFST+1,sp)
1421  001a 43            	cpl	a
1422  001b c75344        	ld	21316,a
1423                     ; 351 }
1426  001e 84            	pop	a
1427  001f 81            	ret
1492                     ; 360 ITStatus TIM4_GetITStatus(TIM4_IT_TypeDef TIM4_IT)
1492                     ; 361 {
1493                     .text:	section	.text,new
1494  0000               _TIM4_GetITStatus:
1496  0000 88            	push	a
1497  0001 89            	pushw	x
1498       00000002      OFST:	set	2
1501                     ; 362     ITStatus bitstatus = RESET;
1503                     ; 364   uint8_t itstatus = 0x0, itenable = 0x0;
1507                     ; 367   assert_param(IS_TIM4_IT_OK(TIM4_IT));
1509  0002 a101          	cp	a,#1
1510  0004 2603          	jrne	L451
1511  0006 4f            	clr	a
1512  0007 2010          	jra	L651
1513  0009               L451:
1514  0009 ae016f        	ldw	x,#367
1515  000c 89            	pushw	x
1516  000d ae0000        	ldw	x,#0
1517  0010 89            	pushw	x
1518  0011 ae0000        	ldw	x,#L76
1519  0014 cd0000        	call	_assert_failed
1521  0017 5b04          	addw	sp,#4
1522  0019               L651:
1523                     ; 369   itstatus = (uint8_t)(TIM4->SR1 & (uint8_t)TIM4_IT);
1525  0019 c65344        	ld	a,21316
1526  001c 1403          	and	a,(OFST+1,sp)
1527  001e 6b01          	ld	(OFST-1,sp),a
1528                     ; 371   itenable = (uint8_t)(TIM4->IER & (uint8_t)TIM4_IT);
1530  0020 c65343        	ld	a,21315
1531  0023 1403          	and	a,(OFST+1,sp)
1532  0025 6b02          	ld	(OFST+0,sp),a
1533                     ; 373   if ((itstatus != (uint8_t)RESET ) && (itenable != (uint8_t)RESET ))
1535  0027 0d01          	tnz	(OFST-1,sp)
1536  0029 270a          	jreq	L555
1538  002b 0d02          	tnz	(OFST+0,sp)
1539  002d 2706          	jreq	L555
1540                     ; 375     bitstatus = (ITStatus)SET;
1542  002f a601          	ld	a,#1
1543  0031 6b02          	ld	(OFST+0,sp),a
1545  0033 2002          	jra	L755
1546  0035               L555:
1547                     ; 379     bitstatus = (ITStatus)RESET;
1549  0035 0f02          	clr	(OFST+0,sp)
1550  0037               L755:
1551                     ; 381   return ((ITStatus)bitstatus);
1553  0037 7b02          	ld	a,(OFST+0,sp)
1556  0039 5b03          	addw	sp,#3
1557  003b 81            	ret
1594                     ; 391 void TIM4_ClearITPendingBit(TIM4_IT_TypeDef TIM4_IT)
1594                     ; 392 {
1595                     .text:	section	.text,new
1596  0000               _TIM4_ClearITPendingBit:
1598  0000 88            	push	a
1599       00000000      OFST:	set	0
1602                     ; 394     assert_param(IS_TIM4_IT_OK(TIM4_IT));
1604  0001 a101          	cp	a,#1
1605  0003 2603          	jrne	L261
1606  0005 4f            	clr	a
1607  0006 2010          	jra	L461
1608  0008               L261:
1609  0008 ae018a        	ldw	x,#394
1610  000b 89            	pushw	x
1611  000c ae0000        	ldw	x,#0
1612  000f 89            	pushw	x
1613  0010 ae0000        	ldw	x,#L76
1614  0013 cd0000        	call	_assert_failed
1616  0016 5b04          	addw	sp,#4
1617  0018               L461:
1618                     ; 397     TIM4->SR1 = (uint8_t)(~TIM4_IT);
1620  0018 7b01          	ld	a,(OFST+1,sp)
1621  001a 43            	cpl	a
1622  001b c75344        	ld	21316,a
1623                     ; 398 }
1626  001e 84            	pop	a
1627  001f 81            	ret
1640                     	xdef	_TIM4_ClearITPendingBit
1641                     	xdef	_TIM4_GetITStatus
1642                     	xdef	_TIM4_ClearFlag
1643                     	xdef	_TIM4_GetFlagStatus
1644                     	xdef	_TIM4_GetPrescaler
1645                     	xdef	_TIM4_GetCounter
1646                     	xdef	_TIM4_SetAutoreload
1647                     	xdef	_TIM4_SetCounter
1648                     	xdef	_TIM4_GenerateEvent
1649                     	xdef	_TIM4_ARRPreloadConfig
1650                     	xdef	_TIM4_PrescalerConfig
1651                     	xdef	_TIM4_SelectOnePulseMode
1652                     	xdef	_TIM4_UpdateRequestConfig
1653                     	xdef	_TIM4_UpdateDisableConfig
1654                     	xdef	_TIM4_ITConfig
1655                     	xdef	_TIM4_Cmd
1656                     	xdef	_TIM4_TimeBaseInit
1657                     	xdef	_TIM4_DeInit
1658                     	xref	_assert_failed
1659                     .const:	section	.text
1660  0000               L76:
1661  0000 2e2e5c73746d  	dc.b	"..\stm8s_stdperiph"
1662  0012 5f6472697665  	dc.b	"_driver\src\stm8s_"
1663  0024 74696d342e63  	dc.b	"tim4.c",0
1683                     	end
