   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  45                     ; 46 void TIM2_DeInit(void)
  45                     ; 47 {
  47                     .text:	section	.text,new
  48  0000               _TIM2_DeInit:
  52                     ; 49     TIM2->CR1 = (uint8_t)TIM2_CR1_RESET_VALUE;
  54  0000 725f5300      	clr	21248
  55                     ; 50     TIM2->IER = (uint8_t)TIM2_IER_RESET_VALUE;
  57  0004 725f5303      	clr	21251
  58                     ; 51     TIM2->SR2 = (uint8_t)TIM2_SR2_RESET_VALUE;
  60  0008 725f5305      	clr	21253
  61                     ; 54     TIM2->CCER1 = (uint8_t)TIM2_CCER1_RESET_VALUE;
  63  000c 725f530a      	clr	21258
  64                     ; 55     TIM2->CCER2 = (uint8_t)TIM2_CCER2_RESET_VALUE;
  66  0010 725f530b      	clr	21259
  67                     ; 59     TIM2->CCER1 = (uint8_t)TIM2_CCER1_RESET_VALUE;
  69  0014 725f530a      	clr	21258
  70                     ; 60     TIM2->CCER2 = (uint8_t)TIM2_CCER2_RESET_VALUE;
  72  0018 725f530b      	clr	21259
  73                     ; 61     TIM2->CCMR1 = (uint8_t)TIM2_CCMR1_RESET_VALUE;
  75  001c 725f5307      	clr	21255
  76                     ; 62     TIM2->CCMR2 = (uint8_t)TIM2_CCMR2_RESET_VALUE;
  78  0020 725f5308      	clr	21256
  79                     ; 63     TIM2->CCMR3 = (uint8_t)TIM2_CCMR3_RESET_VALUE;
  81  0024 725f5309      	clr	21257
  82                     ; 64     TIM2->CNTRH = (uint8_t)TIM2_CNTRH_RESET_VALUE;
  84  0028 725f530c      	clr	21260
  85                     ; 65     TIM2->CNTRL = (uint8_t)TIM2_CNTRL_RESET_VALUE;
  87  002c 725f530d      	clr	21261
  88                     ; 66     TIM2->PSCR = (uint8_t)TIM2_PSCR_RESET_VALUE;
  90  0030 725f530e      	clr	21262
  91                     ; 67     TIM2->ARRH  = (uint8_t)TIM2_ARRH_RESET_VALUE;
  93  0034 35ff530f      	mov	21263,#255
  94                     ; 68     TIM2->ARRL  = (uint8_t)TIM2_ARRL_RESET_VALUE;
  96  0038 35ff5310      	mov	21264,#255
  97                     ; 69     TIM2->CCR1H = (uint8_t)TIM2_CCR1H_RESET_VALUE;
  99  003c 725f5311      	clr	21265
 100                     ; 70     TIM2->CCR1L = (uint8_t)TIM2_CCR1L_RESET_VALUE;
 102  0040 725f5312      	clr	21266
 103                     ; 71     TIM2->CCR2H = (uint8_t)TIM2_CCR2H_RESET_VALUE;
 105  0044 725f5313      	clr	21267
 106                     ; 72     TIM2->CCR2L = (uint8_t)TIM2_CCR2L_RESET_VALUE;
 108  0048 725f5314      	clr	21268
 109                     ; 73     TIM2->CCR3H = (uint8_t)TIM2_CCR3H_RESET_VALUE;
 111  004c 725f5315      	clr	21269
 112                     ; 74     TIM2->CCR3L = (uint8_t)TIM2_CCR3L_RESET_VALUE;
 114  0050 725f5316      	clr	21270
 115                     ; 75     TIM2->SR1 = (uint8_t)TIM2_SR1_RESET_VALUE;
 117  0054 725f5304      	clr	21252
 118                     ; 76 }
 121  0058 81            	ret
 289                     ; 85 void TIM2_TimeBaseInit( TIM2_Prescaler_TypeDef TIM2_Prescaler,
 289                     ; 86                         uint16_t TIM2_Period)
 289                     ; 87 {
 290                     .text:	section	.text,new
 291  0000               _TIM2_TimeBaseInit:
 293  0000 88            	push	a
 294       00000000      OFST:	set	0
 297                     ; 89     TIM2->PSCR = (uint8_t)(TIM2_Prescaler);
 299  0001 c7530e        	ld	21262,a
 300                     ; 91     TIM2->ARRH = (uint8_t)(TIM2_Period >> 8);
 302  0004 7b04          	ld	a,(OFST+4,sp)
 303  0006 c7530f        	ld	21263,a
 304                     ; 92     TIM2->ARRL = (uint8_t)(TIM2_Period);
 306  0009 7b05          	ld	a,(OFST+5,sp)
 307  000b c75310        	ld	21264,a
 308                     ; 93 }
 311  000e 84            	pop	a
 312  000f 81            	ret
 470                     ; 104 void TIM2_OC1Init(TIM2_OCMode_TypeDef TIM2_OCMode,
 470                     ; 105                   TIM2_OutputState_TypeDef TIM2_OutputState,
 470                     ; 106                   uint16_t TIM2_Pulse,
 470                     ; 107                   TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
 470                     ; 108 {
 471                     .text:	section	.text,new
 472  0000               _TIM2_OC1Init:
 474  0000 89            	pushw	x
 475  0001 88            	push	a
 476       00000001      OFST:	set	1
 479                     ; 110     assert_param(IS_TIM2_OC_MODE_OK(TIM2_OCMode));
 481  0002 9e            	ld	a,xh
 482  0003 4d            	tnz	a
 483  0004 2719          	jreq	L41
 484  0006 9e            	ld	a,xh
 485  0007 a110          	cp	a,#16
 486  0009 2714          	jreq	L41
 487  000b 9e            	ld	a,xh
 488  000c a120          	cp	a,#32
 489  000e 270f          	jreq	L41
 490  0010 9e            	ld	a,xh
 491  0011 a130          	cp	a,#48
 492  0013 270a          	jreq	L41
 493  0015 9e            	ld	a,xh
 494  0016 a160          	cp	a,#96
 495  0018 2705          	jreq	L41
 496  001a 9e            	ld	a,xh
 497  001b a170          	cp	a,#112
 498  001d 2603          	jrne	L21
 499  001f               L41:
 500  001f 4f            	clr	a
 501  0020 2010          	jra	L61
 502  0022               L21:
 503  0022 ae006e        	ldw	x,#110
 504  0025 89            	pushw	x
 505  0026 ae0000        	ldw	x,#0
 506  0029 89            	pushw	x
 507  002a ae0000        	ldw	x,#L702
 508  002d cd0000        	call	_assert_failed
 510  0030 5b04          	addw	sp,#4
 511  0032               L61:
 512                     ; 111     assert_param(IS_TIM2_OUTPUT_STATE_OK(TIM2_OutputState));
 514  0032 0d03          	tnz	(OFST+2,sp)
 515  0034 2706          	jreq	L22
 516  0036 7b03          	ld	a,(OFST+2,sp)
 517  0038 a111          	cp	a,#17
 518  003a 2603          	jrne	L02
 519  003c               L22:
 520  003c 4f            	clr	a
 521  003d 2010          	jra	L42
 522  003f               L02:
 523  003f ae006f        	ldw	x,#111
 524  0042 89            	pushw	x
 525  0043 ae0000        	ldw	x,#0
 526  0046 89            	pushw	x
 527  0047 ae0000        	ldw	x,#L702
 528  004a cd0000        	call	_assert_failed
 530  004d 5b04          	addw	sp,#4
 531  004f               L42:
 532                     ; 112     assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
 534  004f 0d08          	tnz	(OFST+7,sp)
 535  0051 2706          	jreq	L03
 536  0053 7b08          	ld	a,(OFST+7,sp)
 537  0055 a122          	cp	a,#34
 538  0057 2603          	jrne	L62
 539  0059               L03:
 540  0059 4f            	clr	a
 541  005a 2010          	jra	L23
 542  005c               L62:
 543  005c ae0070        	ldw	x,#112
 544  005f 89            	pushw	x
 545  0060 ae0000        	ldw	x,#0
 546  0063 89            	pushw	x
 547  0064 ae0000        	ldw	x,#L702
 548  0067 cd0000        	call	_assert_failed
 550  006a 5b04          	addw	sp,#4
 551  006c               L23:
 552                     ; 115     TIM2->CCER1 &= (uint8_t)(~( TIM2_CCER1_CC1E | TIM2_CCER1_CC1P));
 554  006c c6530a        	ld	a,21258
 555  006f a4fc          	and	a,#252
 556  0071 c7530a        	ld	21258,a
 557                     ; 117     TIM2->CCER1 |= (uint8_t)((uint8_t)(TIM2_OutputState & TIM2_CCER1_CC1E ) | 
 557                     ; 118                              (uint8_t)(TIM2_OCPolarity & TIM2_CCER1_CC1P));
 559  0074 7b08          	ld	a,(OFST+7,sp)
 560  0076 a402          	and	a,#2
 561  0078 6b01          	ld	(OFST+0,sp),a
 562  007a 7b03          	ld	a,(OFST+2,sp)
 563  007c a401          	and	a,#1
 564  007e 1a01          	or	a,(OFST+0,sp)
 565  0080 ca530a        	or	a,21258
 566  0083 c7530a        	ld	21258,a
 567                     ; 121     TIM2->CCMR1 = (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~TIM2_CCMR_OCM)) |
 567                     ; 122                             (uint8_t)TIM2_OCMode);
 569  0086 c65307        	ld	a,21255
 570  0089 a48f          	and	a,#143
 571  008b 1a02          	or	a,(OFST+1,sp)
 572  008d c75307        	ld	21255,a
 573                     ; 125     TIM2->CCR1H = (uint8_t)(TIM2_Pulse >> 8);
 575  0090 7b06          	ld	a,(OFST+5,sp)
 576  0092 c75311        	ld	21265,a
 577                     ; 126     TIM2->CCR1L = (uint8_t)(TIM2_Pulse);
 579  0095 7b07          	ld	a,(OFST+6,sp)
 580  0097 c75312        	ld	21266,a
 581                     ; 127 }
 584  009a 5b03          	addw	sp,#3
 585  009c 81            	ret
 650                     ; 138 void TIM2_OC2Init(TIM2_OCMode_TypeDef TIM2_OCMode,
 650                     ; 139                   TIM2_OutputState_TypeDef TIM2_OutputState,
 650                     ; 140                   uint16_t TIM2_Pulse,
 650                     ; 141                   TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
 650                     ; 142 {
 651                     .text:	section	.text,new
 652  0000               _TIM2_OC2Init:
 654  0000 89            	pushw	x
 655  0001 88            	push	a
 656       00000001      OFST:	set	1
 659                     ; 144     assert_param(IS_TIM2_OC_MODE_OK(TIM2_OCMode));
 661  0002 9e            	ld	a,xh
 662  0003 4d            	tnz	a
 663  0004 2719          	jreq	L04
 664  0006 9e            	ld	a,xh
 665  0007 a110          	cp	a,#16
 666  0009 2714          	jreq	L04
 667  000b 9e            	ld	a,xh
 668  000c a120          	cp	a,#32
 669  000e 270f          	jreq	L04
 670  0010 9e            	ld	a,xh
 671  0011 a130          	cp	a,#48
 672  0013 270a          	jreq	L04
 673  0015 9e            	ld	a,xh
 674  0016 a160          	cp	a,#96
 675  0018 2705          	jreq	L04
 676  001a 9e            	ld	a,xh
 677  001b a170          	cp	a,#112
 678  001d 2603          	jrne	L63
 679  001f               L04:
 680  001f 4f            	clr	a
 681  0020 2010          	jra	L24
 682  0022               L63:
 683  0022 ae0090        	ldw	x,#144
 684  0025 89            	pushw	x
 685  0026 ae0000        	ldw	x,#0
 686  0029 89            	pushw	x
 687  002a ae0000        	ldw	x,#L702
 688  002d cd0000        	call	_assert_failed
 690  0030 5b04          	addw	sp,#4
 691  0032               L24:
 692                     ; 145     assert_param(IS_TIM2_OUTPUT_STATE_OK(TIM2_OutputState));
 694  0032 0d03          	tnz	(OFST+2,sp)
 695  0034 2706          	jreq	L64
 696  0036 7b03          	ld	a,(OFST+2,sp)
 697  0038 a111          	cp	a,#17
 698  003a 2603          	jrne	L44
 699  003c               L64:
 700  003c 4f            	clr	a
 701  003d 2010          	jra	L05
 702  003f               L44:
 703  003f ae0091        	ldw	x,#145
 704  0042 89            	pushw	x
 705  0043 ae0000        	ldw	x,#0
 706  0046 89            	pushw	x
 707  0047 ae0000        	ldw	x,#L702
 708  004a cd0000        	call	_assert_failed
 710  004d 5b04          	addw	sp,#4
 711  004f               L05:
 712                     ; 146     assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
 714  004f 0d08          	tnz	(OFST+7,sp)
 715  0051 2706          	jreq	L45
 716  0053 7b08          	ld	a,(OFST+7,sp)
 717  0055 a122          	cp	a,#34
 718  0057 2603          	jrne	L25
 719  0059               L45:
 720  0059 4f            	clr	a
 721  005a 2010          	jra	L65
 722  005c               L25:
 723  005c ae0092        	ldw	x,#146
 724  005f 89            	pushw	x
 725  0060 ae0000        	ldw	x,#0
 726  0063 89            	pushw	x
 727  0064 ae0000        	ldw	x,#L702
 728  0067 cd0000        	call	_assert_failed
 730  006a 5b04          	addw	sp,#4
 731  006c               L65:
 732                     ; 150     TIM2->CCER1 &= (uint8_t)(~( TIM2_CCER1_CC2E |  TIM2_CCER1_CC2P ));
 734  006c c6530a        	ld	a,21258
 735  006f a4cf          	and	a,#207
 736  0071 c7530a        	ld	21258,a
 737                     ; 152     TIM2->CCER1 |= (uint8_t)((uint8_t)(TIM2_OutputState  & TIM2_CCER1_CC2E ) |
 737                     ; 153                         (uint8_t)(TIM2_OCPolarity & TIM2_CCER1_CC2P));
 739  0074 7b08          	ld	a,(OFST+7,sp)
 740  0076 a420          	and	a,#32
 741  0078 6b01          	ld	(OFST+0,sp),a
 742  007a 7b03          	ld	a,(OFST+2,sp)
 743  007c a410          	and	a,#16
 744  007e 1a01          	or	a,(OFST+0,sp)
 745  0080 ca530a        	or	a,21258
 746  0083 c7530a        	ld	21258,a
 747                     ; 157     TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~TIM2_CCMR_OCM)) | 
 747                     ; 158                             (uint8_t)TIM2_OCMode);
 749  0086 c65308        	ld	a,21256
 750  0089 a48f          	and	a,#143
 751  008b 1a02          	or	a,(OFST+1,sp)
 752  008d c75308        	ld	21256,a
 753                     ; 162     TIM2->CCR2H = (uint8_t)(TIM2_Pulse >> 8);
 755  0090 7b06          	ld	a,(OFST+5,sp)
 756  0092 c75313        	ld	21267,a
 757                     ; 163     TIM2->CCR2L = (uint8_t)(TIM2_Pulse);
 759  0095 7b07          	ld	a,(OFST+6,sp)
 760  0097 c75314        	ld	21268,a
 761                     ; 164 }
 764  009a 5b03          	addw	sp,#3
 765  009c 81            	ret
 830                     ; 175 void TIM2_OC3Init(TIM2_OCMode_TypeDef TIM2_OCMode,
 830                     ; 176                   TIM2_OutputState_TypeDef TIM2_OutputState,
 830                     ; 177                   uint16_t TIM2_Pulse,
 830                     ; 178                   TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
 830                     ; 179 {
 831                     .text:	section	.text,new
 832  0000               _TIM2_OC3Init:
 834  0000 89            	pushw	x
 835  0001 88            	push	a
 836       00000001      OFST:	set	1
 839                     ; 181     assert_param(IS_TIM2_OC_MODE_OK(TIM2_OCMode));
 841  0002 9e            	ld	a,xh
 842  0003 4d            	tnz	a
 843  0004 2719          	jreq	L46
 844  0006 9e            	ld	a,xh
 845  0007 a110          	cp	a,#16
 846  0009 2714          	jreq	L46
 847  000b 9e            	ld	a,xh
 848  000c a120          	cp	a,#32
 849  000e 270f          	jreq	L46
 850  0010 9e            	ld	a,xh
 851  0011 a130          	cp	a,#48
 852  0013 270a          	jreq	L46
 853  0015 9e            	ld	a,xh
 854  0016 a160          	cp	a,#96
 855  0018 2705          	jreq	L46
 856  001a 9e            	ld	a,xh
 857  001b a170          	cp	a,#112
 858  001d 2603          	jrne	L26
 859  001f               L46:
 860  001f 4f            	clr	a
 861  0020 2010          	jra	L66
 862  0022               L26:
 863  0022 ae00b5        	ldw	x,#181
 864  0025 89            	pushw	x
 865  0026 ae0000        	ldw	x,#0
 866  0029 89            	pushw	x
 867  002a ae0000        	ldw	x,#L702
 868  002d cd0000        	call	_assert_failed
 870  0030 5b04          	addw	sp,#4
 871  0032               L66:
 872                     ; 182     assert_param(IS_TIM2_OUTPUT_STATE_OK(TIM2_OutputState));
 874  0032 0d03          	tnz	(OFST+2,sp)
 875  0034 2706          	jreq	L27
 876  0036 7b03          	ld	a,(OFST+2,sp)
 877  0038 a111          	cp	a,#17
 878  003a 2603          	jrne	L07
 879  003c               L27:
 880  003c 4f            	clr	a
 881  003d 2010          	jra	L47
 882  003f               L07:
 883  003f ae00b6        	ldw	x,#182
 884  0042 89            	pushw	x
 885  0043 ae0000        	ldw	x,#0
 886  0046 89            	pushw	x
 887  0047 ae0000        	ldw	x,#L702
 888  004a cd0000        	call	_assert_failed
 890  004d 5b04          	addw	sp,#4
 891  004f               L47:
 892                     ; 183     assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
 894  004f 0d08          	tnz	(OFST+7,sp)
 895  0051 2706          	jreq	L001
 896  0053 7b08          	ld	a,(OFST+7,sp)
 897  0055 a122          	cp	a,#34
 898  0057 2603          	jrne	L67
 899  0059               L001:
 900  0059 4f            	clr	a
 901  005a 2010          	jra	L201
 902  005c               L67:
 903  005c ae00b7        	ldw	x,#183
 904  005f 89            	pushw	x
 905  0060 ae0000        	ldw	x,#0
 906  0063 89            	pushw	x
 907  0064 ae0000        	ldw	x,#L702
 908  0067 cd0000        	call	_assert_failed
 910  006a 5b04          	addw	sp,#4
 911  006c               L201:
 912                     ; 185     TIM2->CCER2 &= (uint8_t)(~( TIM2_CCER2_CC3E  | TIM2_CCER2_CC3P));
 914  006c c6530b        	ld	a,21259
 915  006f a4fc          	and	a,#252
 916  0071 c7530b        	ld	21259,a
 917                     ; 187     TIM2->CCER2 |= (uint8_t)((uint8_t)(TIM2_OutputState & TIM2_CCER2_CC3E) |  
 917                     ; 188                              (uint8_t)(TIM2_OCPolarity & TIM2_CCER2_CC3P));
 919  0074 7b08          	ld	a,(OFST+7,sp)
 920  0076 a402          	and	a,#2
 921  0078 6b01          	ld	(OFST+0,sp),a
 922  007a 7b03          	ld	a,(OFST+2,sp)
 923  007c a401          	and	a,#1
 924  007e 1a01          	or	a,(OFST+0,sp)
 925  0080 ca530b        	or	a,21259
 926  0083 c7530b        	ld	21259,a
 927                     ; 191     TIM2->CCMR3 = (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~TIM2_CCMR_OCM)) |
 927                     ; 192                             (uint8_t)TIM2_OCMode);
 929  0086 c65309        	ld	a,21257
 930  0089 a48f          	and	a,#143
 931  008b 1a02          	or	a,(OFST+1,sp)
 932  008d c75309        	ld	21257,a
 933                     ; 195     TIM2->CCR3H = (uint8_t)(TIM2_Pulse >> 8);
 935  0090 7b06          	ld	a,(OFST+5,sp)
 936  0092 c75315        	ld	21269,a
 937                     ; 196     TIM2->CCR3L = (uint8_t)(TIM2_Pulse);
 939  0095 7b07          	ld	a,(OFST+6,sp)
 940  0097 c75316        	ld	21270,a
 941                     ; 198 }
 944  009a 5b03          	addw	sp,#3
 945  009c 81            	ret
1139                     ; 210 void TIM2_ICInit(TIM2_Channel_TypeDef TIM2_Channel,
1139                     ; 211                  TIM2_ICPolarity_TypeDef TIM2_ICPolarity,
1139                     ; 212                  TIM2_ICSelection_TypeDef TIM2_ICSelection,
1139                     ; 213                  TIM2_ICPSC_TypeDef TIM2_ICPrescaler,
1139                     ; 214                  uint8_t TIM2_ICFilter)
1139                     ; 215 {
1140                     .text:	section	.text,new
1141  0000               _TIM2_ICInit:
1143  0000 89            	pushw	x
1144       00000000      OFST:	set	0
1147                     ; 217     assert_param(IS_TIM2_CHANNEL_OK(TIM2_Channel));
1149  0001 9e            	ld	a,xh
1150  0002 4d            	tnz	a
1151  0003 270a          	jreq	L011
1152  0005 9e            	ld	a,xh
1153  0006 a101          	cp	a,#1
1154  0008 2705          	jreq	L011
1155  000a 9e            	ld	a,xh
1156  000b a102          	cp	a,#2
1157  000d 2603          	jrne	L601
1158  000f               L011:
1159  000f 4f            	clr	a
1160  0010 2010          	jra	L211
1161  0012               L601:
1162  0012 ae00d9        	ldw	x,#217
1163  0015 89            	pushw	x
1164  0016 ae0000        	ldw	x,#0
1165  0019 89            	pushw	x
1166  001a ae0000        	ldw	x,#L702
1167  001d cd0000        	call	_assert_failed
1169  0020 5b04          	addw	sp,#4
1170  0022               L211:
1171                     ; 218     assert_param(IS_TIM2_IC_POLARITY_OK(TIM2_ICPolarity));
1173  0022 0d02          	tnz	(OFST+2,sp)
1174  0024 2706          	jreq	L611
1175  0026 7b02          	ld	a,(OFST+2,sp)
1176  0028 a144          	cp	a,#68
1177  002a 2603          	jrne	L411
1178  002c               L611:
1179  002c 4f            	clr	a
1180  002d 2010          	jra	L021
1181  002f               L411:
1182  002f ae00da        	ldw	x,#218
1183  0032 89            	pushw	x
1184  0033 ae0000        	ldw	x,#0
1185  0036 89            	pushw	x
1186  0037 ae0000        	ldw	x,#L702
1187  003a cd0000        	call	_assert_failed
1189  003d 5b04          	addw	sp,#4
1190  003f               L021:
1191                     ; 219     assert_param(IS_TIM2_IC_SELECTION_OK(TIM2_ICSelection));
1193  003f 7b05          	ld	a,(OFST+5,sp)
1194  0041 a101          	cp	a,#1
1195  0043 270c          	jreq	L421
1196  0045 7b05          	ld	a,(OFST+5,sp)
1197  0047 a102          	cp	a,#2
1198  0049 2706          	jreq	L421
1199  004b 7b05          	ld	a,(OFST+5,sp)
1200  004d a103          	cp	a,#3
1201  004f 2603          	jrne	L221
1202  0051               L421:
1203  0051 4f            	clr	a
1204  0052 2010          	jra	L621
1205  0054               L221:
1206  0054 ae00db        	ldw	x,#219
1207  0057 89            	pushw	x
1208  0058 ae0000        	ldw	x,#0
1209  005b 89            	pushw	x
1210  005c ae0000        	ldw	x,#L702
1211  005f cd0000        	call	_assert_failed
1213  0062 5b04          	addw	sp,#4
1214  0064               L621:
1215                     ; 220     assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_ICPrescaler));
1217  0064 0d06          	tnz	(OFST+6,sp)
1218  0066 2712          	jreq	L231
1219  0068 7b06          	ld	a,(OFST+6,sp)
1220  006a a104          	cp	a,#4
1221  006c 270c          	jreq	L231
1222  006e 7b06          	ld	a,(OFST+6,sp)
1223  0070 a108          	cp	a,#8
1224  0072 2706          	jreq	L231
1225  0074 7b06          	ld	a,(OFST+6,sp)
1226  0076 a10c          	cp	a,#12
1227  0078 2603          	jrne	L031
1228  007a               L231:
1229  007a 4f            	clr	a
1230  007b 2010          	jra	L431
1231  007d               L031:
1232  007d ae00dc        	ldw	x,#220
1233  0080 89            	pushw	x
1234  0081 ae0000        	ldw	x,#0
1235  0084 89            	pushw	x
1236  0085 ae0000        	ldw	x,#L702
1237  0088 cd0000        	call	_assert_failed
1239  008b 5b04          	addw	sp,#4
1240  008d               L431:
1241                     ; 221     assert_param(IS_TIM2_IC_FILTER_OK(TIM2_ICFilter));
1243  008d 7b07          	ld	a,(OFST+7,sp)
1244  008f a110          	cp	a,#16
1245  0091 2403          	jruge	L631
1246  0093 4f            	clr	a
1247  0094 2010          	jra	L041
1248  0096               L631:
1249  0096 ae00dd        	ldw	x,#221
1250  0099 89            	pushw	x
1251  009a ae0000        	ldw	x,#0
1252  009d 89            	pushw	x
1253  009e ae0000        	ldw	x,#L702
1254  00a1 cd0000        	call	_assert_failed
1256  00a4 5b04          	addw	sp,#4
1257  00a6               L041:
1258                     ; 223     if (TIM2_Channel == TIM2_CHANNEL_1)
1260  00a6 0d01          	tnz	(OFST+1,sp)
1261  00a8 2614          	jrne	L304
1262                     ; 226         TI1_Config((uint8_t)TIM2_ICPolarity,
1262                     ; 227                    (uint8_t)TIM2_ICSelection,
1262                     ; 228                    (uint8_t)TIM2_ICFilter);
1264  00aa 7b07          	ld	a,(OFST+7,sp)
1265  00ac 88            	push	a
1266  00ad 7b06          	ld	a,(OFST+6,sp)
1267  00af 97            	ld	xl,a
1268  00b0 7b03          	ld	a,(OFST+3,sp)
1269  00b2 95            	ld	xh,a
1270  00b3 cd0000        	call	L3_TI1_Config
1272  00b6 84            	pop	a
1273                     ; 231         TIM2_SetIC1Prescaler(TIM2_ICPrescaler);
1275  00b7 7b06          	ld	a,(OFST+6,sp)
1276  00b9 cd0000        	call	_TIM2_SetIC1Prescaler
1279  00bc 202c          	jra	L504
1280  00be               L304:
1281                     ; 233     else if (TIM2_Channel == TIM2_CHANNEL_2)
1283  00be 7b01          	ld	a,(OFST+1,sp)
1284  00c0 a101          	cp	a,#1
1285  00c2 2614          	jrne	L704
1286                     ; 236         TI2_Config((uint8_t)TIM2_ICPolarity,
1286                     ; 237                    (uint8_t)TIM2_ICSelection,
1286                     ; 238                    (uint8_t)TIM2_ICFilter);
1288  00c4 7b07          	ld	a,(OFST+7,sp)
1289  00c6 88            	push	a
1290  00c7 7b06          	ld	a,(OFST+6,sp)
1291  00c9 97            	ld	xl,a
1292  00ca 7b03          	ld	a,(OFST+3,sp)
1293  00cc 95            	ld	xh,a
1294  00cd cd0000        	call	L5_TI2_Config
1296  00d0 84            	pop	a
1297                     ; 241         TIM2_SetIC2Prescaler(TIM2_ICPrescaler);
1299  00d1 7b06          	ld	a,(OFST+6,sp)
1300  00d3 cd0000        	call	_TIM2_SetIC2Prescaler
1303  00d6 2012          	jra	L504
1304  00d8               L704:
1305                     ; 246         TI3_Config((uint8_t)TIM2_ICPolarity,
1305                     ; 247                    (uint8_t)TIM2_ICSelection,
1305                     ; 248                    (uint8_t)TIM2_ICFilter);
1307  00d8 7b07          	ld	a,(OFST+7,sp)
1308  00da 88            	push	a
1309  00db 7b06          	ld	a,(OFST+6,sp)
1310  00dd 97            	ld	xl,a
1311  00de 7b03          	ld	a,(OFST+3,sp)
1312  00e0 95            	ld	xh,a
1313  00e1 cd0000        	call	L7_TI3_Config
1315  00e4 84            	pop	a
1316                     ; 251         TIM2_SetIC3Prescaler(TIM2_ICPrescaler);
1318  00e5 7b06          	ld	a,(OFST+6,sp)
1319  00e7 cd0000        	call	_TIM2_SetIC3Prescaler
1321  00ea               L504:
1322                     ; 253 }
1325  00ea 85            	popw	x
1326  00eb 81            	ret
1423                     ; 265 void TIM2_PWMIConfig(TIM2_Channel_TypeDef TIM2_Channel,
1423                     ; 266                      TIM2_ICPolarity_TypeDef TIM2_ICPolarity,
1423                     ; 267                      TIM2_ICSelection_TypeDef TIM2_ICSelection,
1423                     ; 268                      TIM2_ICPSC_TypeDef TIM2_ICPrescaler,
1423                     ; 269                      uint8_t TIM2_ICFilter)
1423                     ; 270 {
1424                     .text:	section	.text,new
1425  0000               _TIM2_PWMIConfig:
1427  0000 89            	pushw	x
1428  0001 89            	pushw	x
1429       00000002      OFST:	set	2
1432                     ; 271     uint8_t icpolarity = (uint8_t)TIM2_ICPOLARITY_RISING;
1434                     ; 272     uint8_t icselection = (uint8_t)TIM2_ICSELECTION_DIRECTTI;
1436                     ; 275     assert_param(IS_TIM2_PWMI_CHANNEL_OK(TIM2_Channel));
1438  0002 9e            	ld	a,xh
1439  0003 4d            	tnz	a
1440  0004 2705          	jreq	L641
1441  0006 9e            	ld	a,xh
1442  0007 a101          	cp	a,#1
1443  0009 2603          	jrne	L441
1444  000b               L641:
1445  000b 4f            	clr	a
1446  000c 2010          	jra	L051
1447  000e               L441:
1448  000e ae0113        	ldw	x,#275
1449  0011 89            	pushw	x
1450  0012 ae0000        	ldw	x,#0
1451  0015 89            	pushw	x
1452  0016 ae0000        	ldw	x,#L702
1453  0019 cd0000        	call	_assert_failed
1455  001c 5b04          	addw	sp,#4
1456  001e               L051:
1457                     ; 276     assert_param(IS_TIM2_IC_POLARITY_OK(TIM2_ICPolarity));
1459  001e 0d04          	tnz	(OFST+2,sp)
1460  0020 2706          	jreq	L451
1461  0022 7b04          	ld	a,(OFST+2,sp)
1462  0024 a144          	cp	a,#68
1463  0026 2603          	jrne	L251
1464  0028               L451:
1465  0028 4f            	clr	a
1466  0029 2010          	jra	L651
1467  002b               L251:
1468  002b ae0114        	ldw	x,#276
1469  002e 89            	pushw	x
1470  002f ae0000        	ldw	x,#0
1471  0032 89            	pushw	x
1472  0033 ae0000        	ldw	x,#L702
1473  0036 cd0000        	call	_assert_failed
1475  0039 5b04          	addw	sp,#4
1476  003b               L651:
1477                     ; 277     assert_param(IS_TIM2_IC_SELECTION_OK(TIM2_ICSelection));
1479  003b 7b07          	ld	a,(OFST+5,sp)
1480  003d a101          	cp	a,#1
1481  003f 270c          	jreq	L261
1482  0041 7b07          	ld	a,(OFST+5,sp)
1483  0043 a102          	cp	a,#2
1484  0045 2706          	jreq	L261
1485  0047 7b07          	ld	a,(OFST+5,sp)
1486  0049 a103          	cp	a,#3
1487  004b 2603          	jrne	L061
1488  004d               L261:
1489  004d 4f            	clr	a
1490  004e 2010          	jra	L461
1491  0050               L061:
1492  0050 ae0115        	ldw	x,#277
1493  0053 89            	pushw	x
1494  0054 ae0000        	ldw	x,#0
1495  0057 89            	pushw	x
1496  0058 ae0000        	ldw	x,#L702
1497  005b cd0000        	call	_assert_failed
1499  005e 5b04          	addw	sp,#4
1500  0060               L461:
1501                     ; 278     assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_ICPrescaler));
1503  0060 0d08          	tnz	(OFST+6,sp)
1504  0062 2712          	jreq	L071
1505  0064 7b08          	ld	a,(OFST+6,sp)
1506  0066 a104          	cp	a,#4
1507  0068 270c          	jreq	L071
1508  006a 7b08          	ld	a,(OFST+6,sp)
1509  006c a108          	cp	a,#8
1510  006e 2706          	jreq	L071
1511  0070 7b08          	ld	a,(OFST+6,sp)
1512  0072 a10c          	cp	a,#12
1513  0074 2603          	jrne	L661
1514  0076               L071:
1515  0076 4f            	clr	a
1516  0077 2010          	jra	L271
1517  0079               L661:
1518  0079 ae0116        	ldw	x,#278
1519  007c 89            	pushw	x
1520  007d ae0000        	ldw	x,#0
1521  0080 89            	pushw	x
1522  0081 ae0000        	ldw	x,#L702
1523  0084 cd0000        	call	_assert_failed
1525  0087 5b04          	addw	sp,#4
1526  0089               L271:
1527                     ; 281     if (TIM2_ICPolarity != TIM2_ICPOLARITY_FALLING)
1529  0089 7b04          	ld	a,(OFST+2,sp)
1530  008b a144          	cp	a,#68
1531  008d 2706          	jreq	L164
1532                     ; 283         icpolarity = (uint8_t)TIM2_ICPOLARITY_FALLING;
1534  008f a644          	ld	a,#68
1535  0091 6b01          	ld	(OFST-1,sp),a
1537  0093 2002          	jra	L364
1538  0095               L164:
1539                     ; 287         icpolarity = (uint8_t)TIM2_ICPOLARITY_RISING;
1541  0095 0f01          	clr	(OFST-1,sp)
1542  0097               L364:
1543                     ; 291     if (TIM2_ICSelection == TIM2_ICSELECTION_DIRECTTI)
1545  0097 7b07          	ld	a,(OFST+5,sp)
1546  0099 a101          	cp	a,#1
1547  009b 2606          	jrne	L564
1548                     ; 293         icselection = (uint8_t)TIM2_ICSELECTION_INDIRECTTI;
1550  009d a602          	ld	a,#2
1551  009f 6b02          	ld	(OFST+0,sp),a
1553  00a1 2004          	jra	L764
1554  00a3               L564:
1555                     ; 297         icselection = (uint8_t)TIM2_ICSELECTION_DIRECTTI;
1557  00a3 a601          	ld	a,#1
1558  00a5 6b02          	ld	(OFST+0,sp),a
1559  00a7               L764:
1560                     ; 300     if (TIM2_Channel == TIM2_CHANNEL_1)
1562  00a7 0d03          	tnz	(OFST+1,sp)
1563  00a9 2626          	jrne	L174
1564                     ; 303         TI1_Config((uint8_t)TIM2_ICPolarity, (uint8_t)TIM2_ICSelection,
1564                     ; 304                    (uint8_t)TIM2_ICFilter);
1566  00ab 7b09          	ld	a,(OFST+7,sp)
1567  00ad 88            	push	a
1568  00ae 7b08          	ld	a,(OFST+6,sp)
1569  00b0 97            	ld	xl,a
1570  00b1 7b05          	ld	a,(OFST+3,sp)
1571  00b3 95            	ld	xh,a
1572  00b4 cd0000        	call	L3_TI1_Config
1574  00b7 84            	pop	a
1575                     ; 307         TIM2_SetIC1Prescaler(TIM2_ICPrescaler);
1577  00b8 7b08          	ld	a,(OFST+6,sp)
1578  00ba cd0000        	call	_TIM2_SetIC1Prescaler
1580                     ; 310         TI2_Config(icpolarity, icselection, TIM2_ICFilter);
1582  00bd 7b09          	ld	a,(OFST+7,sp)
1583  00bf 88            	push	a
1584  00c0 7b03          	ld	a,(OFST+1,sp)
1585  00c2 97            	ld	xl,a
1586  00c3 7b02          	ld	a,(OFST+0,sp)
1587  00c5 95            	ld	xh,a
1588  00c6 cd0000        	call	L5_TI2_Config
1590  00c9 84            	pop	a
1591                     ; 313         TIM2_SetIC2Prescaler(TIM2_ICPrescaler);
1593  00ca 7b08          	ld	a,(OFST+6,sp)
1594  00cc cd0000        	call	_TIM2_SetIC2Prescaler
1597  00cf 2024          	jra	L374
1598  00d1               L174:
1599                     ; 318         TI2_Config((uint8_t)TIM2_ICPolarity, (uint8_t)TIM2_ICSelection,
1599                     ; 319                    (uint8_t)TIM2_ICFilter);
1601  00d1 7b09          	ld	a,(OFST+7,sp)
1602  00d3 88            	push	a
1603  00d4 7b08          	ld	a,(OFST+6,sp)
1604  00d6 97            	ld	xl,a
1605  00d7 7b05          	ld	a,(OFST+3,sp)
1606  00d9 95            	ld	xh,a
1607  00da cd0000        	call	L5_TI2_Config
1609  00dd 84            	pop	a
1610                     ; 322         TIM2_SetIC2Prescaler(TIM2_ICPrescaler);
1612  00de 7b08          	ld	a,(OFST+6,sp)
1613  00e0 cd0000        	call	_TIM2_SetIC2Prescaler
1615                     ; 325         TI1_Config((uint8_t)icpolarity, icselection, (uint8_t)TIM2_ICFilter);
1617  00e3 7b09          	ld	a,(OFST+7,sp)
1618  00e5 88            	push	a
1619  00e6 7b03          	ld	a,(OFST+1,sp)
1620  00e8 97            	ld	xl,a
1621  00e9 7b02          	ld	a,(OFST+0,sp)
1622  00eb 95            	ld	xh,a
1623  00ec cd0000        	call	L3_TI1_Config
1625  00ef 84            	pop	a
1626                     ; 328         TIM2_SetIC1Prescaler(TIM2_ICPrescaler);
1628  00f0 7b08          	ld	a,(OFST+6,sp)
1629  00f2 cd0000        	call	_TIM2_SetIC1Prescaler
1631  00f5               L374:
1632                     ; 330 }
1635  00f5 5b04          	addw	sp,#4
1636  00f7 81            	ret
1692                     ; 339 void TIM2_Cmd(FunctionalState NewState)
1692                     ; 340 {
1693                     .text:	section	.text,new
1694  0000               _TIM2_Cmd:
1696  0000 88            	push	a
1697       00000000      OFST:	set	0
1700                     ; 342     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1702  0001 4d            	tnz	a
1703  0002 2704          	jreq	L002
1704  0004 a101          	cp	a,#1
1705  0006 2603          	jrne	L671
1706  0008               L002:
1707  0008 4f            	clr	a
1708  0009 2010          	jra	L202
1709  000b               L671:
1710  000b ae0156        	ldw	x,#342
1711  000e 89            	pushw	x
1712  000f ae0000        	ldw	x,#0
1713  0012 89            	pushw	x
1714  0013 ae0000        	ldw	x,#L702
1715  0016 cd0000        	call	_assert_failed
1717  0019 5b04          	addw	sp,#4
1718  001b               L202:
1719                     ; 345     if (NewState != DISABLE)
1721  001b 0d01          	tnz	(OFST+1,sp)
1722  001d 2706          	jreq	L325
1723                     ; 347         TIM2->CR1 |= (uint8_t)TIM2_CR1_CEN;
1725  001f 72105300      	bset	21248,#0
1727  0023 2004          	jra	L525
1728  0025               L325:
1729                     ; 351         TIM2->CR1 &= (uint8_t)(~TIM2_CR1_CEN);
1731  0025 72115300      	bres	21248,#0
1732  0029               L525:
1733                     ; 353 }
1736  0029 84            	pop	a
1737  002a 81            	ret
1817                     ; 369 void TIM2_ITConfig(TIM2_IT_TypeDef TIM2_IT, FunctionalState NewState)
1817                     ; 370 {
1818                     .text:	section	.text,new
1819  0000               _TIM2_ITConfig:
1821  0000 89            	pushw	x
1822       00000000      OFST:	set	0
1825                     ; 372     assert_param(IS_TIM2_IT_OK(TIM2_IT));
1827  0001 9e            	ld	a,xh
1828  0002 4d            	tnz	a
1829  0003 2708          	jreq	L602
1830  0005 9e            	ld	a,xh
1831  0006 a110          	cp	a,#16
1832  0008 2403          	jruge	L602
1833  000a 4f            	clr	a
1834  000b 2010          	jra	L012
1835  000d               L602:
1836  000d ae0174        	ldw	x,#372
1837  0010 89            	pushw	x
1838  0011 ae0000        	ldw	x,#0
1839  0014 89            	pushw	x
1840  0015 ae0000        	ldw	x,#L702
1841  0018 cd0000        	call	_assert_failed
1843  001b 5b04          	addw	sp,#4
1844  001d               L012:
1845                     ; 373     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1847  001d 0d02          	tnz	(OFST+2,sp)
1848  001f 2706          	jreq	L412
1849  0021 7b02          	ld	a,(OFST+2,sp)
1850  0023 a101          	cp	a,#1
1851  0025 2603          	jrne	L212
1852  0027               L412:
1853  0027 4f            	clr	a
1854  0028 2010          	jra	L612
1855  002a               L212:
1856  002a ae0175        	ldw	x,#373
1857  002d 89            	pushw	x
1858  002e ae0000        	ldw	x,#0
1859  0031 89            	pushw	x
1860  0032 ae0000        	ldw	x,#L702
1861  0035 cd0000        	call	_assert_failed
1863  0038 5b04          	addw	sp,#4
1864  003a               L612:
1865                     ; 375     if (NewState != DISABLE)
1867  003a 0d02          	tnz	(OFST+2,sp)
1868  003c 270a          	jreq	L565
1869                     ; 378         TIM2->IER |= (uint8_t)TIM2_IT;
1871  003e c65303        	ld	a,21251
1872  0041 1a01          	or	a,(OFST+1,sp)
1873  0043 c75303        	ld	21251,a
1875  0046 2009          	jra	L765
1876  0048               L565:
1877                     ; 383         TIM2->IER &= (uint8_t)(~TIM2_IT);
1879  0048 7b01          	ld	a,(OFST+1,sp)
1880  004a 43            	cpl	a
1881  004b c45303        	and	a,21251
1882  004e c75303        	ld	21251,a
1883  0051               L765:
1884                     ; 385 }
1887  0051 85            	popw	x
1888  0052 81            	ret
1925                     ; 394 void TIM2_UpdateDisableConfig(FunctionalState NewState)
1925                     ; 395 {
1926                     .text:	section	.text,new
1927  0000               _TIM2_UpdateDisableConfig:
1929  0000 88            	push	a
1930       00000000      OFST:	set	0
1933                     ; 397     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1935  0001 4d            	tnz	a
1936  0002 2704          	jreq	L422
1937  0004 a101          	cp	a,#1
1938  0006 2603          	jrne	L222
1939  0008               L422:
1940  0008 4f            	clr	a
1941  0009 2010          	jra	L622
1942  000b               L222:
1943  000b ae018d        	ldw	x,#397
1944  000e 89            	pushw	x
1945  000f ae0000        	ldw	x,#0
1946  0012 89            	pushw	x
1947  0013 ae0000        	ldw	x,#L702
1948  0016 cd0000        	call	_assert_failed
1950  0019 5b04          	addw	sp,#4
1951  001b               L622:
1952                     ; 400     if (NewState != DISABLE)
1954  001b 0d01          	tnz	(OFST+1,sp)
1955  001d 2706          	jreq	L706
1956                     ; 402         TIM2->CR1 |= (uint8_t)TIM2_CR1_UDIS;
1958  001f 72125300      	bset	21248,#1
1960  0023 2004          	jra	L116
1961  0025               L706:
1962                     ; 406         TIM2->CR1 &= (uint8_t)(~TIM2_CR1_UDIS);
1964  0025 72135300      	bres	21248,#1
1965  0029               L116:
1966                     ; 408 }
1969  0029 84            	pop	a
1970  002a 81            	ret
2029                     ; 418 void TIM2_UpdateRequestConfig(TIM2_UpdateSource_TypeDef TIM2_UpdateSource)
2029                     ; 419 {
2030                     .text:	section	.text,new
2031  0000               _TIM2_UpdateRequestConfig:
2033  0000 88            	push	a
2034       00000000      OFST:	set	0
2037                     ; 421     assert_param(IS_TIM2_UPDATE_SOURCE_OK(TIM2_UpdateSource));
2039  0001 4d            	tnz	a
2040  0002 2704          	jreq	L432
2041  0004 a101          	cp	a,#1
2042  0006 2603          	jrne	L232
2043  0008               L432:
2044  0008 4f            	clr	a
2045  0009 2010          	jra	L632
2046  000b               L232:
2047  000b ae01a5        	ldw	x,#421
2048  000e 89            	pushw	x
2049  000f ae0000        	ldw	x,#0
2050  0012 89            	pushw	x
2051  0013 ae0000        	ldw	x,#L702
2052  0016 cd0000        	call	_assert_failed
2054  0019 5b04          	addw	sp,#4
2055  001b               L632:
2056                     ; 424     if (TIM2_UpdateSource != TIM2_UPDATESOURCE_GLOBAL)
2058  001b 0d01          	tnz	(OFST+1,sp)
2059  001d 2706          	jreq	L146
2060                     ; 426         TIM2->CR1 |= (uint8_t)TIM2_CR1_URS;
2062  001f 72145300      	bset	21248,#2
2064  0023 2004          	jra	L346
2065  0025               L146:
2066                     ; 430         TIM2->CR1 &= (uint8_t)(~TIM2_CR1_URS);
2068  0025 72155300      	bres	21248,#2
2069  0029               L346:
2070                     ; 432 }
2073  0029 84            	pop	a
2074  002a 81            	ret
2132                     ; 443 void TIM2_SelectOnePulseMode(TIM2_OPMode_TypeDef TIM2_OPMode)
2132                     ; 444 {
2133                     .text:	section	.text,new
2134  0000               _TIM2_SelectOnePulseMode:
2136  0000 88            	push	a
2137       00000000      OFST:	set	0
2140                     ; 446     assert_param(IS_TIM2_OPM_MODE_OK(TIM2_OPMode));
2142  0001 a101          	cp	a,#1
2143  0003 2703          	jreq	L442
2144  0005 4d            	tnz	a
2145  0006 2603          	jrne	L242
2146  0008               L442:
2147  0008 4f            	clr	a
2148  0009 2010          	jra	L642
2149  000b               L242:
2150  000b ae01be        	ldw	x,#446
2151  000e 89            	pushw	x
2152  000f ae0000        	ldw	x,#0
2153  0012 89            	pushw	x
2154  0013 ae0000        	ldw	x,#L702
2155  0016 cd0000        	call	_assert_failed
2157  0019 5b04          	addw	sp,#4
2158  001b               L642:
2159                     ; 449     if (TIM2_OPMode != TIM2_OPMODE_REPETITIVE)
2161  001b 0d01          	tnz	(OFST+1,sp)
2162  001d 2706          	jreq	L376
2163                     ; 451         TIM2->CR1 |= (uint8_t)TIM2_CR1_OPM;
2165  001f 72165300      	bset	21248,#3
2167  0023 2004          	jra	L576
2168  0025               L376:
2169                     ; 455         TIM2->CR1 &= (uint8_t)(~TIM2_CR1_OPM);
2171  0025 72175300      	bres	21248,#3
2172  0029               L576:
2173                     ; 458 }
2176  0029 84            	pop	a
2177  002a 81            	ret
2246                     ; 489 void TIM2_PrescalerConfig(TIM2_Prescaler_TypeDef Prescaler,
2246                     ; 490                           TIM2_PSCReloadMode_TypeDef TIM2_PSCReloadMode)
2246                     ; 491 {
2247                     .text:	section	.text,new
2248  0000               _TIM2_PrescalerConfig:
2250  0000 89            	pushw	x
2251       00000000      OFST:	set	0
2254                     ; 493     assert_param(IS_TIM2_PRESCALER_RELOAD_OK(TIM2_PSCReloadMode));
2256  0001 9f            	ld	a,xl
2257  0002 4d            	tnz	a
2258  0003 2705          	jreq	L452
2259  0005 9f            	ld	a,xl
2260  0006 a101          	cp	a,#1
2261  0008 2603          	jrne	L252
2262  000a               L452:
2263  000a 4f            	clr	a
2264  000b 2010          	jra	L652
2265  000d               L252:
2266  000d ae01ed        	ldw	x,#493
2267  0010 89            	pushw	x
2268  0011 ae0000        	ldw	x,#0
2269  0014 89            	pushw	x
2270  0015 ae0000        	ldw	x,#L702
2271  0018 cd0000        	call	_assert_failed
2273  001b 5b04          	addw	sp,#4
2274  001d               L652:
2275                     ; 494     assert_param(IS_TIM2_PRESCALER_OK(Prescaler));
2277  001d 0d01          	tnz	(OFST+1,sp)
2278  001f 275a          	jreq	L262
2279  0021 7b01          	ld	a,(OFST+1,sp)
2280  0023 a101          	cp	a,#1
2281  0025 2754          	jreq	L262
2282  0027 7b01          	ld	a,(OFST+1,sp)
2283  0029 a102          	cp	a,#2
2284  002b 274e          	jreq	L262
2285  002d 7b01          	ld	a,(OFST+1,sp)
2286  002f a103          	cp	a,#3
2287  0031 2748          	jreq	L262
2288  0033 7b01          	ld	a,(OFST+1,sp)
2289  0035 a104          	cp	a,#4
2290  0037 2742          	jreq	L262
2291  0039 7b01          	ld	a,(OFST+1,sp)
2292  003b a105          	cp	a,#5
2293  003d 273c          	jreq	L262
2294  003f 7b01          	ld	a,(OFST+1,sp)
2295  0041 a106          	cp	a,#6
2296  0043 2736          	jreq	L262
2297  0045 7b01          	ld	a,(OFST+1,sp)
2298  0047 a107          	cp	a,#7
2299  0049 2730          	jreq	L262
2300  004b 7b01          	ld	a,(OFST+1,sp)
2301  004d a108          	cp	a,#8
2302  004f 272a          	jreq	L262
2303  0051 7b01          	ld	a,(OFST+1,sp)
2304  0053 a109          	cp	a,#9
2305  0055 2724          	jreq	L262
2306  0057 7b01          	ld	a,(OFST+1,sp)
2307  0059 a10a          	cp	a,#10
2308  005b 271e          	jreq	L262
2309  005d 7b01          	ld	a,(OFST+1,sp)
2310  005f a10b          	cp	a,#11
2311  0061 2718          	jreq	L262
2312  0063 7b01          	ld	a,(OFST+1,sp)
2313  0065 a10c          	cp	a,#12
2314  0067 2712          	jreq	L262
2315  0069 7b01          	ld	a,(OFST+1,sp)
2316  006b a10d          	cp	a,#13
2317  006d 270c          	jreq	L262
2318  006f 7b01          	ld	a,(OFST+1,sp)
2319  0071 a10e          	cp	a,#14
2320  0073 2706          	jreq	L262
2321  0075 7b01          	ld	a,(OFST+1,sp)
2322  0077 a10f          	cp	a,#15
2323  0079 2603          	jrne	L062
2324  007b               L262:
2325  007b 4f            	clr	a
2326  007c 2010          	jra	L462
2327  007e               L062:
2328  007e ae01ee        	ldw	x,#494
2329  0081 89            	pushw	x
2330  0082 ae0000        	ldw	x,#0
2331  0085 89            	pushw	x
2332  0086 ae0000        	ldw	x,#L702
2333  0089 cd0000        	call	_assert_failed
2335  008c 5b04          	addw	sp,#4
2336  008e               L462:
2337                     ; 497     TIM2->PSCR = (uint8_t)Prescaler;
2339  008e 7b01          	ld	a,(OFST+1,sp)
2340  0090 c7530e        	ld	21262,a
2341                     ; 500     TIM2->EGR = (uint8_t)TIM2_PSCReloadMode;
2343  0093 7b02          	ld	a,(OFST+2,sp)
2344  0095 c75306        	ld	21254,a
2345                     ; 501 }
2348  0098 85            	popw	x
2349  0099 81            	ret
2408                     ; 512 void TIM2_ForcedOC1Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction)
2408                     ; 513 {
2409                     .text:	section	.text,new
2410  0000               _TIM2_ForcedOC1Config:
2412  0000 88            	push	a
2413       00000000      OFST:	set	0
2416                     ; 515     assert_param(IS_TIM2_FORCED_ACTION_OK(TIM2_ForcedAction));
2418  0001 a150          	cp	a,#80
2419  0003 2704          	jreq	L272
2420  0005 a140          	cp	a,#64
2421  0007 2603          	jrne	L072
2422  0009               L272:
2423  0009 4f            	clr	a
2424  000a 2010          	jra	L472
2425  000c               L072:
2426  000c ae0203        	ldw	x,#515
2427  000f 89            	pushw	x
2428  0010 ae0000        	ldw	x,#0
2429  0013 89            	pushw	x
2430  0014 ae0000        	ldw	x,#L702
2431  0017 cd0000        	call	_assert_failed
2433  001a 5b04          	addw	sp,#4
2434  001c               L472:
2435                     ; 518     TIM2->CCMR1  =  (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~TIM2_CCMR_OCM))  
2435                     ; 519                               | (uint8_t)TIM2_ForcedAction);
2437  001c c65307        	ld	a,21255
2438  001f a48f          	and	a,#143
2439  0021 1a01          	or	a,(OFST+1,sp)
2440  0023 c75307        	ld	21255,a
2441                     ; 520 }
2444  0026 84            	pop	a
2445  0027 81            	ret
2482                     ; 531 void TIM2_ForcedOC2Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction)
2482                     ; 532 {
2483                     .text:	section	.text,new
2484  0000               _TIM2_ForcedOC2Config:
2486  0000 88            	push	a
2487       00000000      OFST:	set	0
2490                     ; 534     assert_param(IS_TIM2_FORCED_ACTION_OK(TIM2_ForcedAction));
2492  0001 a150          	cp	a,#80
2493  0003 2704          	jreq	L203
2494  0005 a140          	cp	a,#64
2495  0007 2603          	jrne	L003
2496  0009               L203:
2497  0009 4f            	clr	a
2498  000a 2010          	jra	L403
2499  000c               L003:
2500  000c ae0216        	ldw	x,#534
2501  000f 89            	pushw	x
2502  0010 ae0000        	ldw	x,#0
2503  0013 89            	pushw	x
2504  0014 ae0000        	ldw	x,#L702
2505  0017 cd0000        	call	_assert_failed
2507  001a 5b04          	addw	sp,#4
2508  001c               L403:
2509                     ; 537     TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~TIM2_CCMR_OCM))  
2509                     ; 538                             | (uint8_t)TIM2_ForcedAction);
2511  001c c65308        	ld	a,21256
2512  001f a48f          	and	a,#143
2513  0021 1a01          	or	a,(OFST+1,sp)
2514  0023 c75308        	ld	21256,a
2515                     ; 539 }
2518  0026 84            	pop	a
2519  0027 81            	ret
2556                     ; 550 void TIM2_ForcedOC3Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction)
2556                     ; 551 {
2557                     .text:	section	.text,new
2558  0000               _TIM2_ForcedOC3Config:
2560  0000 88            	push	a
2561       00000000      OFST:	set	0
2564                     ; 553     assert_param(IS_TIM2_FORCED_ACTION_OK(TIM2_ForcedAction));
2566  0001 a150          	cp	a,#80
2567  0003 2704          	jreq	L213
2568  0005 a140          	cp	a,#64
2569  0007 2603          	jrne	L013
2570  0009               L213:
2571  0009 4f            	clr	a
2572  000a 2010          	jra	L413
2573  000c               L013:
2574  000c ae0229        	ldw	x,#553
2575  000f 89            	pushw	x
2576  0010 ae0000        	ldw	x,#0
2577  0013 89            	pushw	x
2578  0014 ae0000        	ldw	x,#L702
2579  0017 cd0000        	call	_assert_failed
2581  001a 5b04          	addw	sp,#4
2582  001c               L413:
2583                     ; 556     TIM2->CCMR3  =  (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~TIM2_CCMR_OCM))
2583                     ; 557                               | (uint8_t)TIM2_ForcedAction);
2585  001c c65309        	ld	a,21257
2586  001f a48f          	and	a,#143
2587  0021 1a01          	or	a,(OFST+1,sp)
2588  0023 c75309        	ld	21257,a
2589                     ; 558 }
2592  0026 84            	pop	a
2593  0027 81            	ret
2630                     ; 567 void TIM2_ARRPreloadConfig(FunctionalState NewState)
2630                     ; 568 {
2631                     .text:	section	.text,new
2632  0000               _TIM2_ARRPreloadConfig:
2634  0000 88            	push	a
2635       00000000      OFST:	set	0
2638                     ; 570     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2640  0001 4d            	tnz	a
2641  0002 2704          	jreq	L223
2642  0004 a101          	cp	a,#1
2643  0006 2603          	jrne	L023
2644  0008               L223:
2645  0008 4f            	clr	a
2646  0009 2010          	jra	L423
2647  000b               L023:
2648  000b ae023a        	ldw	x,#570
2649  000e 89            	pushw	x
2650  000f ae0000        	ldw	x,#0
2651  0012 89            	pushw	x
2652  0013 ae0000        	ldw	x,#L702
2653  0016 cd0000        	call	_assert_failed
2655  0019 5b04          	addw	sp,#4
2656  001b               L423:
2657                     ; 573     if (NewState != DISABLE)
2659  001b 0d01          	tnz	(OFST+1,sp)
2660  001d 2706          	jreq	L1301
2661                     ; 575         TIM2->CR1 |= (uint8_t)TIM2_CR1_ARPE;
2663  001f 721e5300      	bset	21248,#7
2665  0023 2004          	jra	L3301
2666  0025               L1301:
2667                     ; 579         TIM2->CR1 &= (uint8_t)(~TIM2_CR1_ARPE);
2669  0025 721f5300      	bres	21248,#7
2670  0029               L3301:
2671                     ; 581 }
2674  0029 84            	pop	a
2675  002a 81            	ret
2712                     ; 590 void TIM2_OC1PreloadConfig(FunctionalState NewState)
2712                     ; 591 {
2713                     .text:	section	.text,new
2714  0000               _TIM2_OC1PreloadConfig:
2716  0000 88            	push	a
2717       00000000      OFST:	set	0
2720                     ; 593     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2722  0001 4d            	tnz	a
2723  0002 2704          	jreq	L233
2724  0004 a101          	cp	a,#1
2725  0006 2603          	jrne	L033
2726  0008               L233:
2727  0008 4f            	clr	a
2728  0009 2010          	jra	L433
2729  000b               L033:
2730  000b ae0251        	ldw	x,#593
2731  000e 89            	pushw	x
2732  000f ae0000        	ldw	x,#0
2733  0012 89            	pushw	x
2734  0013 ae0000        	ldw	x,#L702
2735  0016 cd0000        	call	_assert_failed
2737  0019 5b04          	addw	sp,#4
2738  001b               L433:
2739                     ; 596     if (NewState != DISABLE)
2741  001b 0d01          	tnz	(OFST+1,sp)
2742  001d 2706          	jreq	L3501
2743                     ; 598         TIM2->CCMR1 |= (uint8_t)TIM2_CCMR_OCxPE;
2745  001f 72165307      	bset	21255,#3
2747  0023 2004          	jra	L5501
2748  0025               L3501:
2749                     ; 602         TIM2->CCMR1 &= (uint8_t)(~TIM2_CCMR_OCxPE);
2751  0025 72175307      	bres	21255,#3
2752  0029               L5501:
2753                     ; 604 }
2756  0029 84            	pop	a
2757  002a 81            	ret
2794                     ; 613 void TIM2_OC2PreloadConfig(FunctionalState NewState)
2794                     ; 614 {
2795                     .text:	section	.text,new
2796  0000               _TIM2_OC2PreloadConfig:
2798  0000 88            	push	a
2799       00000000      OFST:	set	0
2802                     ; 616     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2804  0001 4d            	tnz	a
2805  0002 2704          	jreq	L243
2806  0004 a101          	cp	a,#1
2807  0006 2603          	jrne	L043
2808  0008               L243:
2809  0008 4f            	clr	a
2810  0009 2010          	jra	L443
2811  000b               L043:
2812  000b ae0268        	ldw	x,#616
2813  000e 89            	pushw	x
2814  000f ae0000        	ldw	x,#0
2815  0012 89            	pushw	x
2816  0013 ae0000        	ldw	x,#L702
2817  0016 cd0000        	call	_assert_failed
2819  0019 5b04          	addw	sp,#4
2820  001b               L443:
2821                     ; 619     if (NewState != DISABLE)
2823  001b 0d01          	tnz	(OFST+1,sp)
2824  001d 2706          	jreq	L5701
2825                     ; 621         TIM2->CCMR2 |= (uint8_t)TIM2_CCMR_OCxPE;
2827  001f 72165308      	bset	21256,#3
2829  0023 2004          	jra	L7701
2830  0025               L5701:
2831                     ; 625         TIM2->CCMR2 &= (uint8_t)(~TIM2_CCMR_OCxPE);
2833  0025 72175308      	bres	21256,#3
2834  0029               L7701:
2835                     ; 627 }
2838  0029 84            	pop	a
2839  002a 81            	ret
2876                     ; 636 void TIM2_OC3PreloadConfig(FunctionalState NewState)
2876                     ; 637 {
2877                     .text:	section	.text,new
2878  0000               _TIM2_OC3PreloadConfig:
2880  0000 88            	push	a
2881       00000000      OFST:	set	0
2884                     ; 639     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2886  0001 4d            	tnz	a
2887  0002 2704          	jreq	L253
2888  0004 a101          	cp	a,#1
2889  0006 2603          	jrne	L053
2890  0008               L253:
2891  0008 4f            	clr	a
2892  0009 2010          	jra	L453
2893  000b               L053:
2894  000b ae027f        	ldw	x,#639
2895  000e 89            	pushw	x
2896  000f ae0000        	ldw	x,#0
2897  0012 89            	pushw	x
2898  0013 ae0000        	ldw	x,#L702
2899  0016 cd0000        	call	_assert_failed
2901  0019 5b04          	addw	sp,#4
2902  001b               L453:
2903                     ; 642     if (NewState != DISABLE)
2905  001b 0d01          	tnz	(OFST+1,sp)
2906  001d 2706          	jreq	L7111
2907                     ; 644         TIM2->CCMR3 |= (uint8_t)TIM2_CCMR_OCxPE;
2909  001f 72165309      	bset	21257,#3
2911  0023 2004          	jra	L1211
2912  0025               L7111:
2913                     ; 648         TIM2->CCMR3 &= (uint8_t)(~TIM2_CCMR_OCxPE);
2915  0025 72175309      	bres	21257,#3
2916  0029               L1211:
2917                     ; 650 }
2920  0029 84            	pop	a
2921  002a 81            	ret
2995                     ; 663 void TIM2_GenerateEvent(TIM2_EventSource_TypeDef TIM2_EventSource)
2995                     ; 664 {
2996                     .text:	section	.text,new
2997  0000               _TIM2_GenerateEvent:
2999  0000 88            	push	a
3000       00000000      OFST:	set	0
3003                     ; 666     assert_param(IS_TIM2_EVENT_SOURCE_OK(TIM2_EventSource));
3005  0001 4d            	tnz	a
3006  0002 2703          	jreq	L063
3007  0004 4f            	clr	a
3008  0005 2010          	jra	L263
3009  0007               L063:
3010  0007 ae029a        	ldw	x,#666
3011  000a 89            	pushw	x
3012  000b ae0000        	ldw	x,#0
3013  000e 89            	pushw	x
3014  000f ae0000        	ldw	x,#L702
3015  0012 cd0000        	call	_assert_failed
3017  0015 5b04          	addw	sp,#4
3018  0017               L263:
3019                     ; 669     TIM2->EGR = (uint8_t)TIM2_EventSource;
3021  0017 7b01          	ld	a,(OFST+1,sp)
3022  0019 c75306        	ld	21254,a
3023                     ; 670 }
3026  001c 84            	pop	a
3027  001d 81            	ret
3064                     ; 681 void TIM2_OC1PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
3064                     ; 682 {
3065                     .text:	section	.text,new
3066  0000               _TIM2_OC1PolarityConfig:
3068  0000 88            	push	a
3069       00000000      OFST:	set	0
3072                     ; 684     assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
3074  0001 4d            	tnz	a
3075  0002 2704          	jreq	L073
3076  0004 a122          	cp	a,#34
3077  0006 2603          	jrne	L663
3078  0008               L073:
3079  0008 4f            	clr	a
3080  0009 2010          	jra	L273
3081  000b               L663:
3082  000b ae02ac        	ldw	x,#684
3083  000e 89            	pushw	x
3084  000f ae0000        	ldw	x,#0
3085  0012 89            	pushw	x
3086  0013 ae0000        	ldw	x,#L702
3087  0016 cd0000        	call	_assert_failed
3089  0019 5b04          	addw	sp,#4
3090  001b               L273:
3091                     ; 687     if (TIM2_OCPolarity != TIM2_OCPOLARITY_HIGH)
3093  001b 0d01          	tnz	(OFST+1,sp)
3094  001d 2706          	jreq	L3711
3095                     ; 689         TIM2->CCER1 |= (uint8_t)TIM2_CCER1_CC1P;
3097  001f 7212530a      	bset	21258,#1
3099  0023 2004          	jra	L5711
3100  0025               L3711:
3101                     ; 693         TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1P);
3103  0025 7213530a      	bres	21258,#1
3104  0029               L5711:
3105                     ; 695 }
3108  0029 84            	pop	a
3109  002a 81            	ret
3146                     ; 706 void TIM2_OC2PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
3146                     ; 707 {
3147                     .text:	section	.text,new
3148  0000               _TIM2_OC2PolarityConfig:
3150  0000 88            	push	a
3151       00000000      OFST:	set	0
3154                     ; 709     assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
3156  0001 4d            	tnz	a
3157  0002 2704          	jreq	L004
3158  0004 a122          	cp	a,#34
3159  0006 2603          	jrne	L673
3160  0008               L004:
3161  0008 4f            	clr	a
3162  0009 2010          	jra	L204
3163  000b               L673:
3164  000b ae02c5        	ldw	x,#709
3165  000e 89            	pushw	x
3166  000f ae0000        	ldw	x,#0
3167  0012 89            	pushw	x
3168  0013 ae0000        	ldw	x,#L702
3169  0016 cd0000        	call	_assert_failed
3171  0019 5b04          	addw	sp,#4
3172  001b               L204:
3173                     ; 712     if (TIM2_OCPolarity != TIM2_OCPOLARITY_HIGH)
3175  001b 0d01          	tnz	(OFST+1,sp)
3176  001d 2706          	jreq	L5121
3177                     ; 714         TIM2->CCER1 |= TIM2_CCER1_CC2P;
3179  001f 721a530a      	bset	21258,#5
3181  0023 2004          	jra	L7121
3182  0025               L5121:
3183                     ; 718         TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2P);
3185  0025 721b530a      	bres	21258,#5
3186  0029               L7121:
3187                     ; 720 }
3190  0029 84            	pop	a
3191  002a 81            	ret
3228                     ; 731 void TIM2_OC3PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
3228                     ; 732 {
3229                     .text:	section	.text,new
3230  0000               _TIM2_OC3PolarityConfig:
3232  0000 88            	push	a
3233       00000000      OFST:	set	0
3236                     ; 734     assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
3238  0001 4d            	tnz	a
3239  0002 2704          	jreq	L014
3240  0004 a122          	cp	a,#34
3241  0006 2603          	jrne	L604
3242  0008               L014:
3243  0008 4f            	clr	a
3244  0009 2010          	jra	L214
3245  000b               L604:
3246  000b ae02de        	ldw	x,#734
3247  000e 89            	pushw	x
3248  000f ae0000        	ldw	x,#0
3249  0012 89            	pushw	x
3250  0013 ae0000        	ldw	x,#L702
3251  0016 cd0000        	call	_assert_failed
3253  0019 5b04          	addw	sp,#4
3254  001b               L214:
3255                     ; 737     if (TIM2_OCPolarity != TIM2_OCPOLARITY_HIGH)
3257  001b 0d01          	tnz	(OFST+1,sp)
3258  001d 2706          	jreq	L7321
3259                     ; 739         TIM2->CCER2 |= (uint8_t)TIM2_CCER2_CC3P;
3261  001f 7212530b      	bset	21259,#1
3263  0023 2004          	jra	L1421
3264  0025               L7321:
3265                     ; 743         TIM2->CCER2 &= (uint8_t)(~TIM2_CCER2_CC3P);
3267  0025 7213530b      	bres	21259,#1
3268  0029               L1421:
3269                     ; 745 }
3272  0029 84            	pop	a
3273  002a 81            	ret
3319                     ; 759 void TIM2_CCxCmd(TIM2_Channel_TypeDef TIM2_Channel, FunctionalState NewState)
3319                     ; 760 {
3320                     .text:	section	.text,new
3321  0000               _TIM2_CCxCmd:
3323  0000 89            	pushw	x
3324       00000000      OFST:	set	0
3327                     ; 762     assert_param(IS_TIM2_CHANNEL_OK(TIM2_Channel));
3329  0001 9e            	ld	a,xh
3330  0002 4d            	tnz	a
3331  0003 270a          	jreq	L024
3332  0005 9e            	ld	a,xh
3333  0006 a101          	cp	a,#1
3334  0008 2705          	jreq	L024
3335  000a 9e            	ld	a,xh
3336  000b a102          	cp	a,#2
3337  000d 2603          	jrne	L614
3338  000f               L024:
3339  000f 4f            	clr	a
3340  0010 2010          	jra	L224
3341  0012               L614:
3342  0012 ae02fa        	ldw	x,#762
3343  0015 89            	pushw	x
3344  0016 ae0000        	ldw	x,#0
3345  0019 89            	pushw	x
3346  001a ae0000        	ldw	x,#L702
3347  001d cd0000        	call	_assert_failed
3349  0020 5b04          	addw	sp,#4
3350  0022               L224:
3351                     ; 763     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
3353  0022 0d02          	tnz	(OFST+2,sp)
3354  0024 2706          	jreq	L624
3355  0026 7b02          	ld	a,(OFST+2,sp)
3356  0028 a101          	cp	a,#1
3357  002a 2603          	jrne	L424
3358  002c               L624:
3359  002c 4f            	clr	a
3360  002d 2010          	jra	L034
3361  002f               L424:
3362  002f ae02fb        	ldw	x,#763
3363  0032 89            	pushw	x
3364  0033 ae0000        	ldw	x,#0
3365  0036 89            	pushw	x
3366  0037 ae0000        	ldw	x,#L702
3367  003a cd0000        	call	_assert_failed
3369  003d 5b04          	addw	sp,#4
3370  003f               L034:
3371                     ; 765     if (TIM2_Channel == TIM2_CHANNEL_1)
3373  003f 0d01          	tnz	(OFST+1,sp)
3374  0041 2610          	jrne	L5621
3375                     ; 768         if (NewState != DISABLE)
3377  0043 0d02          	tnz	(OFST+2,sp)
3378  0045 2706          	jreq	L7621
3379                     ; 770             TIM2->CCER1 |= (uint8_t)TIM2_CCER1_CC1E;
3381  0047 7210530a      	bset	21258,#0
3383  004b 202a          	jra	L3721
3384  004d               L7621:
3385                     ; 774             TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1E);
3387  004d 7211530a      	bres	21258,#0
3388  0051 2024          	jra	L3721
3389  0053               L5621:
3390                     ; 778     else if (TIM2_Channel == TIM2_CHANNEL_2)
3392  0053 7b01          	ld	a,(OFST+1,sp)
3393  0055 a101          	cp	a,#1
3394  0057 2610          	jrne	L5721
3395                     ; 781         if (NewState != DISABLE)
3397  0059 0d02          	tnz	(OFST+2,sp)
3398  005b 2706          	jreq	L7721
3399                     ; 783             TIM2->CCER1 |= (uint8_t)TIM2_CCER1_CC2E;
3401  005d 7218530a      	bset	21258,#4
3403  0061 2014          	jra	L3721
3404  0063               L7721:
3405                     ; 787             TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2E);
3407  0063 7219530a      	bres	21258,#4
3408  0067 200e          	jra	L3721
3409  0069               L5721:
3410                     ; 793         if (NewState != DISABLE)
3412  0069 0d02          	tnz	(OFST+2,sp)
3413  006b 2706          	jreq	L5031
3414                     ; 795             TIM2->CCER2 |= (uint8_t)TIM2_CCER2_CC3E;
3416  006d 7210530b      	bset	21259,#0
3418  0071 2004          	jra	L3721
3419  0073               L5031:
3420                     ; 799             TIM2->CCER2 &= (uint8_t)(~TIM2_CCER2_CC3E);
3422  0073 7211530b      	bres	21259,#0
3423  0077               L3721:
3424                     ; 802 }
3427  0077 85            	popw	x
3428  0078 81            	ret
3474                     ; 824 void TIM2_SelectOCxM(TIM2_Channel_TypeDef TIM2_Channel, TIM2_OCMode_TypeDef TIM2_OCMode)
3474                     ; 825 {
3475                     .text:	section	.text,new
3476  0000               _TIM2_SelectOCxM:
3478  0000 89            	pushw	x
3479       00000000      OFST:	set	0
3482                     ; 827     assert_param(IS_TIM2_CHANNEL_OK(TIM2_Channel));
3484  0001 9e            	ld	a,xh
3485  0002 4d            	tnz	a
3486  0003 270a          	jreq	L634
3487  0005 9e            	ld	a,xh
3488  0006 a101          	cp	a,#1
3489  0008 2705          	jreq	L634
3490  000a 9e            	ld	a,xh
3491  000b a102          	cp	a,#2
3492  000d 2603          	jrne	L434
3493  000f               L634:
3494  000f 4f            	clr	a
3495  0010 2010          	jra	L044
3496  0012               L434:
3497  0012 ae033b        	ldw	x,#827
3498  0015 89            	pushw	x
3499  0016 ae0000        	ldw	x,#0
3500  0019 89            	pushw	x
3501  001a ae0000        	ldw	x,#L702
3502  001d cd0000        	call	_assert_failed
3504  0020 5b04          	addw	sp,#4
3505  0022               L044:
3506                     ; 828     assert_param(IS_TIM2_OCM_OK(TIM2_OCMode));
3508  0022 0d02          	tnz	(OFST+2,sp)
3509  0024 272a          	jreq	L444
3510  0026 7b02          	ld	a,(OFST+2,sp)
3511  0028 a110          	cp	a,#16
3512  002a 2724          	jreq	L444
3513  002c 7b02          	ld	a,(OFST+2,sp)
3514  002e a120          	cp	a,#32
3515  0030 271e          	jreq	L444
3516  0032 7b02          	ld	a,(OFST+2,sp)
3517  0034 a130          	cp	a,#48
3518  0036 2718          	jreq	L444
3519  0038 7b02          	ld	a,(OFST+2,sp)
3520  003a a160          	cp	a,#96
3521  003c 2712          	jreq	L444
3522  003e 7b02          	ld	a,(OFST+2,sp)
3523  0040 a170          	cp	a,#112
3524  0042 270c          	jreq	L444
3525  0044 7b02          	ld	a,(OFST+2,sp)
3526  0046 a150          	cp	a,#80
3527  0048 2706          	jreq	L444
3528  004a 7b02          	ld	a,(OFST+2,sp)
3529  004c a140          	cp	a,#64
3530  004e 2603          	jrne	L244
3531  0050               L444:
3532  0050 4f            	clr	a
3533  0051 2010          	jra	L644
3534  0053               L244:
3535  0053 ae033c        	ldw	x,#828
3536  0056 89            	pushw	x
3537  0057 ae0000        	ldw	x,#0
3538  005a 89            	pushw	x
3539  005b ae0000        	ldw	x,#L702
3540  005e cd0000        	call	_assert_failed
3542  0061 5b04          	addw	sp,#4
3543  0063               L644:
3544                     ; 830     if (TIM2_Channel == TIM2_CHANNEL_1)
3546  0063 0d01          	tnz	(OFST+1,sp)
3547  0065 2610          	jrne	L3331
3548                     ; 833         TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1E);
3550  0067 7211530a      	bres	21258,#0
3551                     ; 836         TIM2->CCMR1 = (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~TIM2_CCMR_OCM))
3551                     ; 837                                | (uint8_t)TIM2_OCMode);
3553  006b c65307        	ld	a,21255
3554  006e a48f          	and	a,#143
3555  0070 1a02          	or	a,(OFST+2,sp)
3556  0072 c75307        	ld	21255,a
3558  0075 2024          	jra	L5331
3559  0077               L3331:
3560                     ; 839     else if (TIM2_Channel == TIM2_CHANNEL_2)
3562  0077 7b01          	ld	a,(OFST+1,sp)
3563  0079 a101          	cp	a,#1
3564  007b 2610          	jrne	L7331
3565                     ; 842         TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2E);
3567  007d 7219530a      	bres	21258,#4
3568                     ; 845         TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~TIM2_CCMR_OCM))
3568                     ; 846                                 | (uint8_t)TIM2_OCMode);
3570  0081 c65308        	ld	a,21256
3571  0084 a48f          	and	a,#143
3572  0086 1a02          	or	a,(OFST+2,sp)
3573  0088 c75308        	ld	21256,a
3575  008b 200e          	jra	L5331
3576  008d               L7331:
3577                     ; 851         TIM2->CCER2 &= (uint8_t)(~TIM2_CCER2_CC3E);
3579  008d 7211530b      	bres	21259,#0
3580                     ; 854         TIM2->CCMR3 = (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~TIM2_CCMR_OCM))
3580                     ; 855                                 | (uint8_t)TIM2_OCMode);
3582  0091 c65309        	ld	a,21257
3583  0094 a48f          	and	a,#143
3584  0096 1a02          	or	a,(OFST+2,sp)
3585  0098 c75309        	ld	21257,a
3586  009b               L5331:
3587                     ; 857 }
3590  009b 85            	popw	x
3591  009c 81            	ret
3625                     ; 866 void TIM2_SetCounter(uint16_t Counter)
3625                     ; 867 {
3626                     .text:	section	.text,new
3627  0000               _TIM2_SetCounter:
3631                     ; 869     TIM2->CNTRH = (uint8_t)(Counter >> 8);
3633  0000 9e            	ld	a,xh
3634  0001 c7530c        	ld	21260,a
3635                     ; 870     TIM2->CNTRL = (uint8_t)(Counter);
3637  0004 9f            	ld	a,xl
3638  0005 c7530d        	ld	21261,a
3639                     ; 872 }
3642  0008 81            	ret
3676                     ; 881 void TIM2_SetAutoreload(uint16_t Autoreload)
3676                     ; 882 {
3677                     .text:	section	.text,new
3678  0000               _TIM2_SetAutoreload:
3682                     ; 885     TIM2->ARRH = (uint8_t)(Autoreload >> 8);
3684  0000 9e            	ld	a,xh
3685  0001 c7530f        	ld	21263,a
3686                     ; 886     TIM2->ARRL = (uint8_t)(Autoreload);
3688  0004 9f            	ld	a,xl
3689  0005 c75310        	ld	21264,a
3690                     ; 888 }
3693  0008 81            	ret
3727                     ; 897 void TIM2_SetCompare1(uint16_t Compare1)
3727                     ; 898 {
3728                     .text:	section	.text,new
3729  0000               _TIM2_SetCompare1:
3733                     ; 900     TIM2->CCR1H = (uint8_t)(Compare1 >> 8);
3735  0000 9e            	ld	a,xh
3736  0001 c75311        	ld	21265,a
3737                     ; 901     TIM2->CCR1L = (uint8_t)(Compare1);
3739  0004 9f            	ld	a,xl
3740  0005 c75312        	ld	21266,a
3741                     ; 903 }
3744  0008 81            	ret
3778                     ; 912 void TIM2_SetCompare2(uint16_t Compare2)
3778                     ; 913 {
3779                     .text:	section	.text,new
3780  0000               _TIM2_SetCompare2:
3784                     ; 915     TIM2->CCR2H = (uint8_t)(Compare2 >> 8);
3786  0000 9e            	ld	a,xh
3787  0001 c75313        	ld	21267,a
3788                     ; 916     TIM2->CCR2L = (uint8_t)(Compare2);
3790  0004 9f            	ld	a,xl
3791  0005 c75314        	ld	21268,a
3792                     ; 918 }
3795  0008 81            	ret
3829                     ; 927 void TIM2_SetCompare3(uint16_t Compare3)
3829                     ; 928 {
3830                     .text:	section	.text,new
3831  0000               _TIM2_SetCompare3:
3835                     ; 930     TIM2->CCR3H = (uint8_t)(Compare3 >> 8);
3837  0000 9e            	ld	a,xh
3838  0001 c75315        	ld	21269,a
3839                     ; 931     TIM2->CCR3L = (uint8_t)(Compare3);
3841  0004 9f            	ld	a,xl
3842  0005 c75316        	ld	21270,a
3843                     ; 933 }
3846  0008 81            	ret
3883                     ; 946 void TIM2_SetIC1Prescaler(TIM2_ICPSC_TypeDef TIM2_IC1Prescaler)
3883                     ; 947 {
3884                     .text:	section	.text,new
3885  0000               _TIM2_SetIC1Prescaler:
3887  0000 88            	push	a
3888       00000000      OFST:	set	0
3891                     ; 949     assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC1Prescaler));
3893  0001 4d            	tnz	a
3894  0002 270c          	jreq	L664
3895  0004 a104          	cp	a,#4
3896  0006 2708          	jreq	L664
3897  0008 a108          	cp	a,#8
3898  000a 2704          	jreq	L664
3899  000c a10c          	cp	a,#12
3900  000e 2603          	jrne	L464
3901  0010               L664:
3902  0010 4f            	clr	a
3903  0011 2010          	jra	L074
3904  0013               L464:
3905  0013 ae03b5        	ldw	x,#949
3906  0016 89            	pushw	x
3907  0017 ae0000        	ldw	x,#0
3908  001a 89            	pushw	x
3909  001b ae0000        	ldw	x,#L702
3910  001e cd0000        	call	_assert_failed
3912  0021 5b04          	addw	sp,#4
3913  0023               L074:
3914                     ; 952     TIM2->CCMR1 = (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~TIM2_CCMR_ICxPSC))
3914                     ; 953                             | (uint8_t)TIM2_IC1Prescaler);
3916  0023 c65307        	ld	a,21255
3917  0026 a4f3          	and	a,#243
3918  0028 1a01          	or	a,(OFST+1,sp)
3919  002a c75307        	ld	21255,a
3920                     ; 954 }
3923  002d 84            	pop	a
3924  002e 81            	ret
3961                     ; 966 void TIM2_SetIC2Prescaler(TIM2_ICPSC_TypeDef TIM2_IC2Prescaler)
3961                     ; 967 {
3962                     .text:	section	.text,new
3963  0000               _TIM2_SetIC2Prescaler:
3965  0000 88            	push	a
3966       00000000      OFST:	set	0
3969                     ; 969     assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC2Prescaler));
3971  0001 4d            	tnz	a
3972  0002 270c          	jreq	L674
3973  0004 a104          	cp	a,#4
3974  0006 2708          	jreq	L674
3975  0008 a108          	cp	a,#8
3976  000a 2704          	jreq	L674
3977  000c a10c          	cp	a,#12
3978  000e 2603          	jrne	L474
3979  0010               L674:
3980  0010 4f            	clr	a
3981  0011 2010          	jra	L005
3982  0013               L474:
3983  0013 ae03c9        	ldw	x,#969
3984  0016 89            	pushw	x
3985  0017 ae0000        	ldw	x,#0
3986  001a 89            	pushw	x
3987  001b ae0000        	ldw	x,#L702
3988  001e cd0000        	call	_assert_failed
3990  0021 5b04          	addw	sp,#4
3991  0023               L005:
3992                     ; 972     TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~TIM2_CCMR_ICxPSC))
3992                     ; 973                             | (uint8_t)TIM2_IC2Prescaler);
3994  0023 c65308        	ld	a,21256
3995  0026 a4f3          	and	a,#243
3996  0028 1a01          	or	a,(OFST+1,sp)
3997  002a c75308        	ld	21256,a
3998                     ; 974 }
4001  002d 84            	pop	a
4002  002e 81            	ret
4039                     ; 986 void TIM2_SetIC3Prescaler(TIM2_ICPSC_TypeDef TIM2_IC3Prescaler)
4039                     ; 987 {
4040                     .text:	section	.text,new
4041  0000               _TIM2_SetIC3Prescaler:
4043  0000 88            	push	a
4044       00000000      OFST:	set	0
4047                     ; 990     assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC3Prescaler));
4049  0001 4d            	tnz	a
4050  0002 270c          	jreq	L605
4051  0004 a104          	cp	a,#4
4052  0006 2708          	jreq	L605
4053  0008 a108          	cp	a,#8
4054  000a 2704          	jreq	L605
4055  000c a10c          	cp	a,#12
4056  000e 2603          	jrne	L405
4057  0010               L605:
4058  0010 4f            	clr	a
4059  0011 2010          	jra	L015
4060  0013               L405:
4061  0013 ae03de        	ldw	x,#990
4062  0016 89            	pushw	x
4063  0017 ae0000        	ldw	x,#0
4064  001a 89            	pushw	x
4065  001b ae0000        	ldw	x,#L702
4066  001e cd0000        	call	_assert_failed
4068  0021 5b04          	addw	sp,#4
4069  0023               L015:
4070                     ; 992     TIM2->CCMR3 = (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~TIM2_CCMR_ICxPSC))
4070                     ; 993                             | (uint8_t)TIM2_IC3Prescaler);
4072  0023 c65309        	ld	a,21257
4073  0026 a4f3          	and	a,#243
4074  0028 1a01          	or	a,(OFST+1,sp)
4075  002a c75309        	ld	21257,a
4076                     ; 994 }
4079  002d 84            	pop	a
4080  002e 81            	ret
4132                     ; 1001 uint16_t TIM2_GetCapture1(void)
4132                     ; 1002 {
4133                     .text:	section	.text,new
4134  0000               _TIM2_GetCapture1:
4136  0000 5204          	subw	sp,#4
4137       00000004      OFST:	set	4
4140                     ; 1004     uint16_t tmpccr1 = 0;
4142                     ; 1005     uint8_t tmpccr1l=0, tmpccr1h=0;
4146                     ; 1007     tmpccr1h = TIM2->CCR1H;
4148  0002 c65311        	ld	a,21265
4149  0005 6b02          	ld	(OFST-2,sp),a
4150                     ; 1008     tmpccr1l = TIM2->CCR1L;
4152  0007 c65312        	ld	a,21266
4153  000a 6b01          	ld	(OFST-3,sp),a
4154                     ; 1010     tmpccr1 = (uint16_t)(tmpccr1l);
4156  000c 7b01          	ld	a,(OFST-3,sp)
4157  000e 5f            	clrw	x
4158  000f 97            	ld	xl,a
4159  0010 1f03          	ldw	(OFST-1,sp),x
4160                     ; 1011     tmpccr1 |= (uint16_t)((uint16_t)tmpccr1h << 8);
4162  0012 7b02          	ld	a,(OFST-2,sp)
4163  0014 5f            	clrw	x
4164  0015 97            	ld	xl,a
4165  0016 4f            	clr	a
4166  0017 02            	rlwa	x,a
4167  0018 01            	rrwa	x,a
4168  0019 1a04          	or	a,(OFST+0,sp)
4169  001b 01            	rrwa	x,a
4170  001c 1a03          	or	a,(OFST-1,sp)
4171  001e 01            	rrwa	x,a
4172  001f 1f03          	ldw	(OFST-1,sp),x
4173                     ; 1013     return (uint16_t)tmpccr1;
4175  0021 1e03          	ldw	x,(OFST-1,sp)
4178  0023 5b04          	addw	sp,#4
4179  0025 81            	ret
4231                     ; 1021 uint16_t TIM2_GetCapture2(void)
4231                     ; 1022 {
4232                     .text:	section	.text,new
4233  0000               _TIM2_GetCapture2:
4235  0000 5204          	subw	sp,#4
4236       00000004      OFST:	set	4
4239                     ; 1024     uint16_t tmpccr2 = 0;
4241                     ; 1025     uint8_t tmpccr2l=0, tmpccr2h=0;
4245                     ; 1027     tmpccr2h = TIM2->CCR2H;
4247  0002 c65313        	ld	a,21267
4248  0005 6b02          	ld	(OFST-2,sp),a
4249                     ; 1028     tmpccr2l = TIM2->CCR2L;
4251  0007 c65314        	ld	a,21268
4252  000a 6b01          	ld	(OFST-3,sp),a
4253                     ; 1030     tmpccr2 = (uint16_t)(tmpccr2l);
4255  000c 7b01          	ld	a,(OFST-3,sp)
4256  000e 5f            	clrw	x
4257  000f 97            	ld	xl,a
4258  0010 1f03          	ldw	(OFST-1,sp),x
4259                     ; 1031     tmpccr2 |= (uint16_t)((uint16_t)tmpccr2h << 8);
4261  0012 7b02          	ld	a,(OFST-2,sp)
4262  0014 5f            	clrw	x
4263  0015 97            	ld	xl,a
4264  0016 4f            	clr	a
4265  0017 02            	rlwa	x,a
4266  0018 01            	rrwa	x,a
4267  0019 1a04          	or	a,(OFST+0,sp)
4268  001b 01            	rrwa	x,a
4269  001c 1a03          	or	a,(OFST-1,sp)
4270  001e 01            	rrwa	x,a
4271  001f 1f03          	ldw	(OFST-1,sp),x
4272                     ; 1033     return (uint16_t)tmpccr2;
4274  0021 1e03          	ldw	x,(OFST-1,sp)
4277  0023 5b04          	addw	sp,#4
4278  0025 81            	ret
4330                     ; 1041 uint16_t TIM2_GetCapture3(void)
4330                     ; 1042 {
4331                     .text:	section	.text,new
4332  0000               _TIM2_GetCapture3:
4334  0000 5204          	subw	sp,#4
4335       00000004      OFST:	set	4
4338                     ; 1044     uint16_t tmpccr3 = 0;
4340                     ; 1045     uint8_t tmpccr3l=0, tmpccr3h=0;
4344                     ; 1047     tmpccr3h = TIM2->CCR3H;
4346  0002 c65315        	ld	a,21269
4347  0005 6b02          	ld	(OFST-2,sp),a
4348                     ; 1048     tmpccr3l = TIM2->CCR3L;
4350  0007 c65316        	ld	a,21270
4351  000a 6b01          	ld	(OFST-3,sp),a
4352                     ; 1050     tmpccr3 = (uint16_t)(tmpccr3l);
4354  000c 7b01          	ld	a,(OFST-3,sp)
4355  000e 5f            	clrw	x
4356  000f 97            	ld	xl,a
4357  0010 1f03          	ldw	(OFST-1,sp),x
4358                     ; 1051     tmpccr3 |= (uint16_t)((uint16_t)tmpccr3h << 8);
4360  0012 7b02          	ld	a,(OFST-2,sp)
4361  0014 5f            	clrw	x
4362  0015 97            	ld	xl,a
4363  0016 4f            	clr	a
4364  0017 02            	rlwa	x,a
4365  0018 01            	rrwa	x,a
4366  0019 1a04          	or	a,(OFST+0,sp)
4367  001b 01            	rrwa	x,a
4368  001c 1a03          	or	a,(OFST-1,sp)
4369  001e 01            	rrwa	x,a
4370  001f 1f03          	ldw	(OFST-1,sp),x
4371                     ; 1053     return (uint16_t)tmpccr3;
4373  0021 1e03          	ldw	x,(OFST-1,sp)
4376  0023 5b04          	addw	sp,#4
4377  0025 81            	ret
4411                     ; 1061 uint16_t TIM2_GetCounter(void)
4411                     ; 1062 {
4412                     .text:	section	.text,new
4413  0000               _TIM2_GetCounter:
4415  0000 89            	pushw	x
4416       00000002      OFST:	set	2
4419                     ; 1063      uint16_t tmpcntr = 0;
4421                     ; 1065     tmpcntr =  ((uint16_t)TIM2->CNTRH << 8);
4423  0001 c6530c        	ld	a,21260
4424  0004 5f            	clrw	x
4425  0005 97            	ld	xl,a
4426  0006 4f            	clr	a
4427  0007 02            	rlwa	x,a
4428  0008 1f01          	ldw	(OFST-1,sp),x
4429                     ; 1067     return (uint16_t)( tmpcntr| (uint16_t)(TIM2->CNTRL));
4431  000a c6530d        	ld	a,21261
4432  000d 5f            	clrw	x
4433  000e 97            	ld	xl,a
4434  000f 01            	rrwa	x,a
4435  0010 1a02          	or	a,(OFST+0,sp)
4436  0012 01            	rrwa	x,a
4437  0013 1a01          	or	a,(OFST-1,sp)
4438  0015 01            	rrwa	x,a
4441  0016 5b02          	addw	sp,#2
4442  0018 81            	ret
4466                     ; 1076 TIM2_Prescaler_TypeDef TIM2_GetPrescaler(void)
4466                     ; 1077 {
4467                     .text:	section	.text,new
4468  0000               _TIM2_GetPrescaler:
4472                     ; 1079     return (TIM2_Prescaler_TypeDef)(TIM2->PSCR);
4474  0000 c6530e        	ld	a,21262
4477  0003 81            	ret
4617                     ; 1096 FlagStatus TIM2_GetFlagStatus(TIM2_FLAG_TypeDef TIM2_FLAG)
4617                     ; 1097 {
4618                     .text:	section	.text,new
4619  0000               _TIM2_GetFlagStatus:
4621  0000 89            	pushw	x
4622  0001 89            	pushw	x
4623       00000002      OFST:	set	2
4626                     ; 1098     FlagStatus bitstatus = RESET;
4628                     ; 1099     uint8_t tim2_flag_l = 0, tim2_flag_h = 0;
4632                     ; 1102     assert_param(IS_TIM2_GET_FLAG_OK(TIM2_FLAG));
4634  0002 a30001        	cpw	x,#1
4635  0005 271e          	jreq	L035
4636  0007 a30002        	cpw	x,#2
4637  000a 2719          	jreq	L035
4638  000c a30004        	cpw	x,#4
4639  000f 2714          	jreq	L035
4640  0011 a30008        	cpw	x,#8
4641  0014 270f          	jreq	L035
4642  0016 a30200        	cpw	x,#512
4643  0019 270a          	jreq	L035
4644  001b a30400        	cpw	x,#1024
4645  001e 2705          	jreq	L035
4646  0020 a30800        	cpw	x,#2048
4647  0023 2603          	jrne	L625
4648  0025               L035:
4649  0025 4f            	clr	a
4650  0026 2010          	jra	L235
4651  0028               L625:
4652  0028 ae044e        	ldw	x,#1102
4653  002b 89            	pushw	x
4654  002c ae0000        	ldw	x,#0
4655  002f 89            	pushw	x
4656  0030 ae0000        	ldw	x,#L702
4657  0033 cd0000        	call	_assert_failed
4659  0036 5b04          	addw	sp,#4
4660  0038               L235:
4661                     ; 1104     tim2_flag_l = (uint8_t)(TIM2->SR1 & (uint8_t)TIM2_FLAG);
4663  0038 c65304        	ld	a,21252
4664  003b 1404          	and	a,(OFST+2,sp)
4665  003d 6b01          	ld	(OFST-1,sp),a
4666                     ; 1105     tim2_flag_h = (uint8_t)((uint16_t)TIM2_FLAG >> 8);
4668  003f 7b03          	ld	a,(OFST+1,sp)
4669  0041 6b02          	ld	(OFST+0,sp),a
4670                     ; 1107     if ((tim2_flag_l | (uint8_t)(TIM2->SR2 & tim2_flag_h)) != (uint8_t)RESET )
4672  0043 c65305        	ld	a,21253
4673  0046 1402          	and	a,(OFST+0,sp)
4674  0048 1a01          	or	a,(OFST-1,sp)
4675  004a 2706          	jreq	L7371
4676                     ; 1109         bitstatus = SET;
4678  004c a601          	ld	a,#1
4679  004e 6b02          	ld	(OFST+0,sp),a
4681  0050 2002          	jra	L1471
4682  0052               L7371:
4683                     ; 1113         bitstatus = RESET;
4685  0052 0f02          	clr	(OFST+0,sp)
4686  0054               L1471:
4687                     ; 1115     return (FlagStatus)bitstatus;
4689  0054 7b02          	ld	a,(OFST+0,sp)
4692  0056 5b04          	addw	sp,#4
4693  0058 81            	ret
4729                     ; 1132 void TIM2_ClearFlag(TIM2_FLAG_TypeDef TIM2_FLAG)
4729                     ; 1133 {
4730                     .text:	section	.text,new
4731  0000               _TIM2_ClearFlag:
4733  0000 89            	pushw	x
4734       00000000      OFST:	set	0
4737                     ; 1135     assert_param(IS_TIM2_CLEAR_FLAG_OK(TIM2_FLAG));
4739  0001 01            	rrwa	x,a
4740  0002 a4f0          	and	a,#240
4741  0004 01            	rrwa	x,a
4742  0005 a4f1          	and	a,#241
4743  0007 01            	rrwa	x,a
4744  0008 a30000        	cpw	x,#0
4745  000b 2607          	jrne	L635
4746  000d 1e01          	ldw	x,(OFST+1,sp)
4747  000f 2703          	jreq	L635
4748  0011 4f            	clr	a
4749  0012 2010          	jra	L045
4750  0014               L635:
4751  0014 ae046f        	ldw	x,#1135
4752  0017 89            	pushw	x
4753  0018 ae0000        	ldw	x,#0
4754  001b 89            	pushw	x
4755  001c ae0000        	ldw	x,#L702
4756  001f cd0000        	call	_assert_failed
4758  0022 5b04          	addw	sp,#4
4759  0024               L045:
4760                     ; 1138     TIM2->SR1 = (uint8_t)(~((uint8_t)(TIM2_FLAG)));
4762  0024 7b02          	ld	a,(OFST+2,sp)
4763  0026 43            	cpl	a
4764  0027 c75304        	ld	21252,a
4765                     ; 1139     TIM2->SR2 = (uint8_t)(~((uint8_t)((uint8_t)TIM2_FLAG >> 8)));
4767  002a 35ff5305      	mov	21253,#255
4768                     ; 1140 }
4771  002e 85            	popw	x
4772  002f 81            	ret
4837                     ; 1154 ITStatus TIM2_GetITStatus(TIM2_IT_TypeDef TIM2_IT)
4837                     ; 1155 {
4838                     .text:	section	.text,new
4839  0000               _TIM2_GetITStatus:
4841  0000 88            	push	a
4842  0001 89            	pushw	x
4843       00000002      OFST:	set	2
4846                     ; 1156     ITStatus bitstatus = RESET;
4848                     ; 1157     uint8_t TIM2_itStatus = 0, TIM2_itEnable = 0;
4852                     ; 1160     assert_param(IS_TIM2_GET_IT_OK(TIM2_IT));
4854  0002 a101          	cp	a,#1
4855  0004 270c          	jreq	L645
4856  0006 a102          	cp	a,#2
4857  0008 2708          	jreq	L645
4858  000a a104          	cp	a,#4
4859  000c 2704          	jreq	L645
4860  000e a108          	cp	a,#8
4861  0010 2603          	jrne	L445
4862  0012               L645:
4863  0012 4f            	clr	a
4864  0013 2010          	jra	L055
4865  0015               L445:
4866  0015 ae0488        	ldw	x,#1160
4867  0018 89            	pushw	x
4868  0019 ae0000        	ldw	x,#0
4869  001c 89            	pushw	x
4870  001d ae0000        	ldw	x,#L702
4871  0020 cd0000        	call	_assert_failed
4873  0023 5b04          	addw	sp,#4
4874  0025               L055:
4875                     ; 1162     TIM2_itStatus = (uint8_t)(TIM2->SR1 & TIM2_IT);
4877  0025 c65304        	ld	a,21252
4878  0028 1403          	and	a,(OFST+1,sp)
4879  002a 6b01          	ld	(OFST-1,sp),a
4880                     ; 1164     TIM2_itEnable = (uint8_t)(TIM2->IER & TIM2_IT);
4882  002c c65303        	ld	a,21251
4883  002f 1403          	and	a,(OFST+1,sp)
4884  0031 6b02          	ld	(OFST+0,sp),a
4885                     ; 1166     if ((TIM2_itStatus != (uint8_t)RESET ) && (TIM2_itEnable != (uint8_t)RESET ))
4887  0033 0d01          	tnz	(OFST-1,sp)
4888  0035 270a          	jreq	L3102
4890  0037 0d02          	tnz	(OFST+0,sp)
4891  0039 2706          	jreq	L3102
4892                     ; 1168         bitstatus = SET;
4894  003b a601          	ld	a,#1
4895  003d 6b02          	ld	(OFST+0,sp),a
4897  003f 2002          	jra	L5102
4898  0041               L3102:
4899                     ; 1172         bitstatus = RESET;
4901  0041 0f02          	clr	(OFST+0,sp)
4902  0043               L5102:
4903                     ; 1174     return (ITStatus)(bitstatus);
4905  0043 7b02          	ld	a,(OFST+0,sp)
4908  0045 5b03          	addw	sp,#3
4909  0047 81            	ret
4946                     ; 1188 void TIM2_ClearITPendingBit(TIM2_IT_TypeDef TIM2_IT)
4946                     ; 1189 {
4947                     .text:	section	.text,new
4948  0000               _TIM2_ClearITPendingBit:
4950  0000 88            	push	a
4951       00000000      OFST:	set	0
4954                     ; 1191     assert_param(IS_TIM2_IT_OK(TIM2_IT));
4956  0001 4d            	tnz	a
4957  0002 2707          	jreq	L455
4958  0004 a110          	cp	a,#16
4959  0006 2403          	jruge	L455
4960  0008 4f            	clr	a
4961  0009 2010          	jra	L655
4962  000b               L455:
4963  000b ae04a7        	ldw	x,#1191
4964  000e 89            	pushw	x
4965  000f ae0000        	ldw	x,#0
4966  0012 89            	pushw	x
4967  0013 ae0000        	ldw	x,#L702
4968  0016 cd0000        	call	_assert_failed
4970  0019 5b04          	addw	sp,#4
4971  001b               L655:
4972                     ; 1194     TIM2->SR1 = (uint8_t)(~TIM2_IT);
4974  001b 7b01          	ld	a,(OFST+1,sp)
4975  001d 43            	cpl	a
4976  001e c75304        	ld	21252,a
4977                     ; 1195 }
4980  0021 84            	pop	a
4981  0022 81            	ret
5033                     ; 1214 static void TI1_Config(uint8_t TIM2_ICPolarity,
5033                     ; 1215                        uint8_t TIM2_ICSelection,
5033                     ; 1216                        uint8_t TIM2_ICFilter)
5033                     ; 1217 {
5034                     .text:	section	.text,new
5035  0000               L3_TI1_Config:
5037  0000 89            	pushw	x
5038  0001 88            	push	a
5039       00000001      OFST:	set	1
5042                     ; 1219     TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1E);
5044  0002 7211530a      	bres	21258,#0
5045                     ; 1222     TIM2->CCMR1  = (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~(uint8_t)( TIM2_CCMR_CCxS | TIM2_CCMR_ICxF )))
5045                     ; 1223                              | (uint8_t)(((TIM2_ICSelection)) | ((uint8_t)( TIM2_ICFilter << 4))));
5047  0006 7b06          	ld	a,(OFST+5,sp)
5048  0008 97            	ld	xl,a
5049  0009 a610          	ld	a,#16
5050  000b 42            	mul	x,a
5051  000c 9f            	ld	a,xl
5052  000d 1a03          	or	a,(OFST+2,sp)
5053  000f 6b01          	ld	(OFST+0,sp),a
5054  0011 c65307        	ld	a,21255
5055  0014 a40c          	and	a,#12
5056  0016 1a01          	or	a,(OFST+0,sp)
5057  0018 c75307        	ld	21255,a
5058                     ; 1226     if (TIM2_ICPolarity != TIM2_ICPOLARITY_RISING)
5060  001b 0d02          	tnz	(OFST+1,sp)
5061  001d 2706          	jreq	L3602
5062                     ; 1228         TIM2->CCER1 |= TIM2_CCER1_CC1P;
5064  001f 7212530a      	bset	21258,#1
5066  0023 2004          	jra	L5602
5067  0025               L3602:
5068                     ; 1232         TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1P);
5070  0025 7213530a      	bres	21258,#1
5071  0029               L5602:
5072                     ; 1235     TIM2->CCER1 |= TIM2_CCER1_CC1E;
5074  0029 7210530a      	bset	21258,#0
5075                     ; 1236 }
5078  002d 5b03          	addw	sp,#3
5079  002f 81            	ret
5131                     ; 1255 static void TI2_Config(uint8_t TIM2_ICPolarity,
5131                     ; 1256                        uint8_t TIM2_ICSelection,
5131                     ; 1257                        uint8_t TIM2_ICFilter)
5131                     ; 1258 {
5132                     .text:	section	.text,new
5133  0000               L5_TI2_Config:
5135  0000 89            	pushw	x
5136  0001 88            	push	a
5137       00000001      OFST:	set	1
5140                     ; 1260     TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2E);
5142  0002 7219530a      	bres	21258,#4
5143                     ; 1263     TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~(uint8_t)( TIM2_CCMR_CCxS | TIM2_CCMR_ICxF ))) 
5143                     ; 1264                             | (uint8_t)(( (TIM2_ICSelection)) | ((uint8_t)( TIM2_ICFilter << 4))));
5145  0006 7b06          	ld	a,(OFST+5,sp)
5146  0008 97            	ld	xl,a
5147  0009 a610          	ld	a,#16
5148  000b 42            	mul	x,a
5149  000c 9f            	ld	a,xl
5150  000d 1a03          	or	a,(OFST+2,sp)
5151  000f 6b01          	ld	(OFST+0,sp),a
5152  0011 c65308        	ld	a,21256
5153  0014 a40c          	and	a,#12
5154  0016 1a01          	or	a,(OFST+0,sp)
5155  0018 c75308        	ld	21256,a
5156                     ; 1268     if (TIM2_ICPolarity != TIM2_ICPOLARITY_RISING)
5158  001b 0d02          	tnz	(OFST+1,sp)
5159  001d 2706          	jreq	L5112
5160                     ; 1270         TIM2->CCER1 |= TIM2_CCER1_CC2P;
5162  001f 721a530a      	bset	21258,#5
5164  0023 2004          	jra	L7112
5165  0025               L5112:
5166                     ; 1274         TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2P);
5168  0025 721b530a      	bres	21258,#5
5169  0029               L7112:
5170                     ; 1278     TIM2->CCER1 |= TIM2_CCER1_CC2E;
5172  0029 7218530a      	bset	21258,#4
5173                     ; 1280 }
5176  002d 5b03          	addw	sp,#3
5177  002f 81            	ret
5229                     ; 1296 static void TI3_Config(uint8_t TIM2_ICPolarity, uint8_t TIM2_ICSelection,
5229                     ; 1297                        uint8_t TIM2_ICFilter)
5229                     ; 1298 {
5230                     .text:	section	.text,new
5231  0000               L7_TI3_Config:
5233  0000 89            	pushw	x
5234  0001 88            	push	a
5235       00000001      OFST:	set	1
5238                     ; 1300     TIM2->CCER2 &=  (uint8_t)(~TIM2_CCER2_CC3E);
5240  0002 7211530b      	bres	21259,#0
5241                     ; 1303     TIM2->CCMR3 = (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~( TIM2_CCMR_CCxS | TIM2_CCMR_ICxF))) 
5241                     ; 1304                             | (uint8_t)(( (TIM2_ICSelection)) | ((uint8_t)( TIM2_ICFilter << 4))));
5243  0006 7b06          	ld	a,(OFST+5,sp)
5244  0008 97            	ld	xl,a
5245  0009 a610          	ld	a,#16
5246  000b 42            	mul	x,a
5247  000c 9f            	ld	a,xl
5248  000d 1a03          	or	a,(OFST+2,sp)
5249  000f 6b01          	ld	(OFST+0,sp),a
5250  0011 c65309        	ld	a,21257
5251  0014 a40c          	and	a,#12
5252  0016 1a01          	or	a,(OFST+0,sp)
5253  0018 c75309        	ld	21257,a
5254                     ; 1308     if (TIM2_ICPolarity != TIM2_ICPOLARITY_RISING)
5256  001b 0d02          	tnz	(OFST+1,sp)
5257  001d 2706          	jreq	L7412
5258                     ; 1310         TIM2->CCER2 |= TIM2_CCER2_CC3P;
5260  001f 7212530b      	bset	21259,#1
5262  0023 2004          	jra	L1512
5263  0025               L7412:
5264                     ; 1314         TIM2->CCER2 &= (uint8_t)(~TIM2_CCER2_CC3P);
5266  0025 7213530b      	bres	21259,#1
5267  0029               L1512:
5268                     ; 1317     TIM2->CCER2 |= TIM2_CCER2_CC3E;
5270  0029 7210530b      	bset	21259,#0
5271                     ; 1318 }
5274  002d 5b03          	addw	sp,#3
5275  002f 81            	ret
5288                     	xdef	_TIM2_ClearITPendingBit
5289                     	xdef	_TIM2_GetITStatus
5290                     	xdef	_TIM2_ClearFlag
5291                     	xdef	_TIM2_GetFlagStatus
5292                     	xdef	_TIM2_GetPrescaler
5293                     	xdef	_TIM2_GetCounter
5294                     	xdef	_TIM2_GetCapture3
5295                     	xdef	_TIM2_GetCapture2
5296                     	xdef	_TIM2_GetCapture1
5297                     	xdef	_TIM2_SetIC3Prescaler
5298                     	xdef	_TIM2_SetIC2Prescaler
5299                     	xdef	_TIM2_SetIC1Prescaler
5300                     	xdef	_TIM2_SetCompare3
5301                     	xdef	_TIM2_SetCompare2
5302                     	xdef	_TIM2_SetCompare1
5303                     	xdef	_TIM2_SetAutoreload
5304                     	xdef	_TIM2_SetCounter
5305                     	xdef	_TIM2_SelectOCxM
5306                     	xdef	_TIM2_CCxCmd
5307                     	xdef	_TIM2_OC3PolarityConfig
5308                     	xdef	_TIM2_OC2PolarityConfig
5309                     	xdef	_TIM2_OC1PolarityConfig
5310                     	xdef	_TIM2_GenerateEvent
5311                     	xdef	_TIM2_OC3PreloadConfig
5312                     	xdef	_TIM2_OC2PreloadConfig
5313                     	xdef	_TIM2_OC1PreloadConfig
5314                     	xdef	_TIM2_ARRPreloadConfig
5315                     	xdef	_TIM2_ForcedOC3Config
5316                     	xdef	_TIM2_ForcedOC2Config
5317                     	xdef	_TIM2_ForcedOC1Config
5318                     	xdef	_TIM2_PrescalerConfig
5319                     	xdef	_TIM2_SelectOnePulseMode
5320                     	xdef	_TIM2_UpdateRequestConfig
5321                     	xdef	_TIM2_UpdateDisableConfig
5322                     	xdef	_TIM2_ITConfig
5323                     	xdef	_TIM2_Cmd
5324                     	xdef	_TIM2_PWMIConfig
5325                     	xdef	_TIM2_ICInit
5326                     	xdef	_TIM2_OC3Init
5327                     	xdef	_TIM2_OC2Init
5328                     	xdef	_TIM2_OC1Init
5329                     	xdef	_TIM2_TimeBaseInit
5330                     	xdef	_TIM2_DeInit
5331                     	xref	_assert_failed
5332                     .const:	section	.text
5333  0000               L702:
5334  0000 2e2e5c73746d  	dc.b	"..\stm8s_stdperiph"
5335  0012 5f6472697665  	dc.b	"_driver\src\stm8s_"
5336  0024 74696d322e63  	dc.b	"tim2.c",0
5356                     	end
