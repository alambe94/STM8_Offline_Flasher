   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.13 - 05 Feb 2019
   3                     ; Generator (Limited) V4.4.9 - 06 Feb 2019
  15                     ; 53 void GPIO_DeInit(GPIO_TypeDef* GPIOx)
  15                     ; 54 {
  16                     	scross	off
  17                     .text:	section	.text,new
  18  0000               _GPIO_DeInit:
  20                     ; 55   GPIOx->ODR = GPIO_ODR_RESET_VALUE; /* Reset Output Data Register */
  21  0000 7f            	clr	(x)
  22                     ; 56   GPIOx->DDR = GPIO_DDR_RESET_VALUE; /* Reset Data Direction Register */
  23  0001 6f02          	clr	(2,x)
  24                     ; 57   GPIOx->CR1 = GPIO_CR1_RESET_VALUE; /* Reset Control Register 1 */
  25  0003 6f03          	clr	(3,x)
  26                     ; 58   GPIOx->CR2 = GPIO_CR2_RESET_VALUE; /* Reset Control Register 2 */
  27  0005 6f04          	clr	(4,x)
  28                     ; 59 }
  29  0007 81            	ret
  31                     ; 71 void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, GPIO_Mode_TypeDef GPIO_Mode)
  31                     ; 72 {
  32                     .text:	section	.text,new
  33  0000               _GPIO_Init:
  34  0000 89            	pushw	x
  35       00000000      OFST:	set	0
  37                     ; 77   assert_param(IS_GPIO_MODE_OK(GPIO_Mode));
  38  0001 0d06          	tnz	(OFST+6,sp)
  39  0003 2742          	jreq	L01
  40  0005 7b06          	ld	a,(OFST+6,sp)
  41  0007 a140          	cp	a,#64
  42  0009 273c          	jreq	L01
  43  000b 7b06          	ld	a,(OFST+6,sp)
  44  000d a120          	cp	a,#32
  45  000f 2736          	jreq	L01
  46  0011 7b06          	ld	a,(OFST+6,sp)
  47  0013 a160          	cp	a,#96
  48  0015 2730          	jreq	L01
  49  0017 7b06          	ld	a,(OFST+6,sp)
  50  0019 a1a0          	cp	a,#160
  51  001b 272a          	jreq	L01
  52  001d 7b06          	ld	a,(OFST+6,sp)
  53  001f a1e0          	cp	a,#224
  54  0021 2724          	jreq	L01
  55  0023 7b06          	ld	a,(OFST+6,sp)
  56  0025 a180          	cp	a,#128
  57  0027 271e          	jreq	L01
  58  0029 7b06          	ld	a,(OFST+6,sp)
  59  002b a1c0          	cp	a,#192
  60  002d 2718          	jreq	L01
  61  002f 7b06          	ld	a,(OFST+6,sp)
  62  0031 a1b0          	cp	a,#176
  63  0033 2712          	jreq	L01
  64  0035 7b06          	ld	a,(OFST+6,sp)
  65  0037 a1f0          	cp	a,#240
  66  0039 270c          	jreq	L01
  67  003b 7b06          	ld	a,(OFST+6,sp)
  68  003d a190          	cp	a,#144
  69  003f 2706          	jreq	L01
  70  0041 7b06          	ld	a,(OFST+6,sp)
  71  0043 a1d0          	cp	a,#208
  72  0045 2603          	jrne	L6
  73  0047               L01:
  74  0047 4f            	clr	a
  75  0048 2010          	jra	L21
  76  004a               L6:
  77  004a ae004d        	ldw	x,#77
  78  004d 89            	pushw	x
  79  004e ae0000        	ldw	x,#0
  80  0051 89            	pushw	x
  81  0052 ae0000        	ldw	x,#L3
  82  0055 cd0000        	call	_assert_failed
  84  0058 5b04          	addw	sp,#4
  85  005a               L21:
  86                     ; 78   assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
  87  005a 0d05          	tnz	(OFST+5,sp)
  88  005c 2703          	jreq	L41
  89  005e 4f            	clr	a
  90  005f 2010          	jra	L61
  91  0061               L41:
  92  0061 ae004e        	ldw	x,#78
  93  0064 89            	pushw	x
  94  0065 ae0000        	ldw	x,#0
  95  0068 89            	pushw	x
  96  0069 ae0000        	ldw	x,#L3
  97  006c cd0000        	call	_assert_failed
  99  006f 5b04          	addw	sp,#4
 100  0071               L61:
 101                     ; 81   GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 102  0071 1e01          	ldw	x,(OFST+1,sp)
 103  0073 7b05          	ld	a,(OFST+5,sp)
 104  0075 43            	cpl	a
 105  0076 e404          	and	a,(4,x)
 106  0078 e704          	ld	(4,x),a
 107                     ; 87   if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x80) != (uint8_t)0x00) /* Output mode */
 108  007a 7b06          	ld	a,(OFST+6,sp)
 109  007c a580          	bcp	a,#128
 110  007e 271f          	jreq	L5
 111                     ; 89     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x10) != (uint8_t)0x00) /* High level */
 112  0080 7b06          	ld	a,(OFST+6,sp)
 113  0082 a510          	bcp	a,#16
 114  0084 2708          	jreq	L7
 115                     ; 91       GPIOx->ODR |= (uint8_t)GPIO_Pin;
 116  0086 1e01          	ldw	x,(OFST+1,sp)
 117  0088 f6            	ld	a,(x)
 118  0089 1a05          	or	a,(OFST+5,sp)
 119  008b f7            	ld	(x),a
 121  008c 2007          	jra	L11
 122  008e               L7:
 123                     ; 95       GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
 124  008e 1e01          	ldw	x,(OFST+1,sp)
 125  0090 7b05          	ld	a,(OFST+5,sp)
 126  0092 43            	cpl	a
 127  0093 f4            	and	a,(x)
 128  0094 f7            	ld	(x),a
 129  0095               L11:
 130                     ; 98     GPIOx->DDR |= (uint8_t)GPIO_Pin;
 131  0095 1e01          	ldw	x,(OFST+1,sp)
 132  0097 e602          	ld	a,(2,x)
 133  0099 1a05          	or	a,(OFST+5,sp)
 134  009b e702          	ld	(2,x),a
 136  009d 2009          	jra	L31
 137  009f               L5:
 138                     ; 103     GPIOx->DDR &= (uint8_t)(~(GPIO_Pin));
 139  009f 1e01          	ldw	x,(OFST+1,sp)
 140  00a1 7b05          	ld	a,(OFST+5,sp)
 141  00a3 43            	cpl	a
 142  00a4 e402          	and	a,(2,x)
 143  00a6 e702          	ld	(2,x),a
 144  00a8               L31:
 145                     ; 110   if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x40) != (uint8_t)0x00) /* Pull-Up or Push-Pull */
 146  00a8 7b06          	ld	a,(OFST+6,sp)
 147  00aa a540          	bcp	a,#64
 148  00ac 270a          	jreq	L51
 149                     ; 112     GPIOx->CR1 |= (uint8_t)GPIO_Pin;
 150  00ae 1e01          	ldw	x,(OFST+1,sp)
 151  00b0 e603          	ld	a,(3,x)
 152  00b2 1a05          	or	a,(OFST+5,sp)
 153  00b4 e703          	ld	(3,x),a
 155  00b6 2009          	jra	L71
 156  00b8               L51:
 157                     ; 116     GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
 158  00b8 1e01          	ldw	x,(OFST+1,sp)
 159  00ba 7b05          	ld	a,(OFST+5,sp)
 160  00bc 43            	cpl	a
 161  00bd e403          	and	a,(3,x)
 162  00bf e703          	ld	(3,x),a
 163  00c1               L71:
 164                     ; 123   if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x20) != (uint8_t)0x00) /* Interrupt or Slow slope */
 165  00c1 7b06          	ld	a,(OFST+6,sp)
 166  00c3 a520          	bcp	a,#32
 167  00c5 270a          	jreq	L12
 168                     ; 125     GPIOx->CR2 |= (uint8_t)GPIO_Pin;
 169  00c7 1e01          	ldw	x,(OFST+1,sp)
 170  00c9 e604          	ld	a,(4,x)
 171  00cb 1a05          	or	a,(OFST+5,sp)
 172  00cd e704          	ld	(4,x),a
 174  00cf 2009          	jra	L32
 175  00d1               L12:
 176                     ; 129     GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 177  00d1 1e01          	ldw	x,(OFST+1,sp)
 178  00d3 7b05          	ld	a,(OFST+5,sp)
 179  00d5 43            	cpl	a
 180  00d6 e404          	and	a,(4,x)
 181  00d8 e704          	ld	(4,x),a
 182  00da               L32:
 183                     ; 131 }
 184  00da 85            	popw	x
 185  00db 81            	ret
 187                     ; 141 void GPIO_Write(GPIO_TypeDef* GPIOx, uint8_t PortVal)
 187                     ; 142 {
 188                     .text:	section	.text,new
 189  0000               _GPIO_Write:
 190  0000 89            	pushw	x
 191       00000000      OFST:	set	0
 193                     ; 143   GPIOx->ODR = PortVal;
 194  0001 7b05          	ld	a,(OFST+5,sp)
 195  0003 1e01          	ldw	x,(OFST+1,sp)
 196  0005 f7            	ld	(x),a
 197                     ; 144 }
 198  0006 85            	popw	x
 199  0007 81            	ret
 201                     ; 154 void GPIO_WriteHigh(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 201                     ; 155 {
 202                     .text:	section	.text,new
 203  0000               _GPIO_WriteHigh:
 204  0000 89            	pushw	x
 205       00000000      OFST:	set	0
 207                     ; 156   GPIOx->ODR |= (uint8_t)PortPins;
 208  0001 f6            	ld	a,(x)
 209  0002 1a05          	or	a,(OFST+5,sp)
 210  0004 f7            	ld	(x),a
 211                     ; 157 }
 212  0005 85            	popw	x
 213  0006 81            	ret
 215                     ; 167 void GPIO_WriteLow(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 215                     ; 168 {
 216                     .text:	section	.text,new
 217  0000               _GPIO_WriteLow:
 218  0000 89            	pushw	x
 219       00000000      OFST:	set	0
 221                     ; 169   GPIOx->ODR &= (uint8_t)(~PortPins);
 222  0001 7b05          	ld	a,(OFST+5,sp)
 223  0003 43            	cpl	a
 224  0004 f4            	and	a,(x)
 225  0005 f7            	ld	(x),a
 226                     ; 170 }
 227  0006 85            	popw	x
 228  0007 81            	ret
 230                     ; 180 void GPIO_WriteReverse(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 230                     ; 181 {
 231                     .text:	section	.text,new
 232  0000               _GPIO_WriteReverse:
 233  0000 89            	pushw	x
 234       00000000      OFST:	set	0
 236                     ; 182   GPIOx->ODR ^= (uint8_t)PortPins;
 237  0001 f6            	ld	a,(x)
 238  0002 1805          	xor	a,(OFST+5,sp)
 239  0004 f7            	ld	(x),a
 240                     ; 183 }
 241  0005 85            	popw	x
 242  0006 81            	ret
 244                     ; 191 uint8_t GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
 244                     ; 192 {
 245                     .text:	section	.text,new
 246  0000               _GPIO_ReadOutputData:
 248                     ; 193   return ((uint8_t)GPIOx->ODR);
 249  0000 f6            	ld	a,(x)
 251  0001 81            	ret
 253                     ; 202 uint8_t GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
 253                     ; 203 {
 254                     .text:	section	.text,new
 255  0000               _GPIO_ReadInputData:
 257                     ; 204   return ((uint8_t)GPIOx->IDR);
 258  0000 e601          	ld	a,(1,x)
 260  0002 81            	ret
 262                     ; 213 BitStatus GPIO_ReadInputPin(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
 262                     ; 214 {
 263                     .text:	section	.text,new
 264  0000               _GPIO_ReadInputPin:
 265  0000 89            	pushw	x
 266       00000000      OFST:	set	0
 268                     ; 215   return ((BitStatus)(GPIOx->IDR & (uint8_t)GPIO_Pin));
 269  0001 e601          	ld	a,(1,x)
 270  0003 1405          	and	a,(OFST+5,sp)
 272  0005 85            	popw	x
 273  0006 81            	ret
 275                     ; 225 void GPIO_ExternalPullUpConfig(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, FunctionalState NewState)
 275                     ; 226 {
 276                     .text:	section	.text,new
 277  0000               _GPIO_ExternalPullUpConfig:
 278  0000 89            	pushw	x
 279       00000000      OFST:	set	0
 281                     ; 228   assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 282  0001 0d05          	tnz	(OFST+5,sp)
 283  0003 2703          	jreq	L04
 284  0005 4f            	clr	a
 285  0006 2010          	jra	L24
 286  0008               L04:
 287  0008 ae00e4        	ldw	x,#228
 288  000b 89            	pushw	x
 289  000c ae0000        	ldw	x,#0
 290  000f 89            	pushw	x
 291  0010 ae0000        	ldw	x,#L3
 292  0013 cd0000        	call	_assert_failed
 294  0016 5b04          	addw	sp,#4
 295  0018               L24:
 296                     ; 229   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 297  0018 0d06          	tnz	(OFST+6,sp)
 298  001a 2706          	jreq	L64
 299  001c 7b06          	ld	a,(OFST+6,sp)
 300  001e a101          	cp	a,#1
 301  0020 2603          	jrne	L44
 302  0022               L64:
 303  0022 4f            	clr	a
 304  0023 2010          	jra	L05
 305  0025               L44:
 306  0025 ae00e5        	ldw	x,#229
 307  0028 89            	pushw	x
 308  0029 ae0000        	ldw	x,#0
 309  002c 89            	pushw	x
 310  002d ae0000        	ldw	x,#L3
 311  0030 cd0000        	call	_assert_failed
 313  0033 5b04          	addw	sp,#4
 314  0035               L05:
 315                     ; 231   if (NewState != DISABLE) /* External Pull-Up Set*/
 316  0035 0d06          	tnz	(OFST+6,sp)
 317  0037 270a          	jreq	L52
 318                     ; 233     GPIOx->CR1 |= (uint8_t)GPIO_Pin;
 319  0039 1e01          	ldw	x,(OFST+1,sp)
 320  003b e603          	ld	a,(3,x)
 321  003d 1a05          	or	a,(OFST+5,sp)
 322  003f e703          	ld	(3,x),a
 324  0041 2009          	jra	L72
 325  0043               L52:
 326                     ; 236     GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
 327  0043 1e01          	ldw	x,(OFST+1,sp)
 328  0045 7b05          	ld	a,(OFST+5,sp)
 329  0047 43            	cpl	a
 330  0048 e403          	and	a,(3,x)
 331  004a e703          	ld	(3,x),a
 332  004c               L72:
 333                     ; 238 }
 334  004c 85            	popw	x
 335  004d 81            	ret
 337                     	xdef	_GPIO_ExternalPullUpConfig
 338                     	xdef	_GPIO_ReadInputPin
 339                     	xdef	_GPIO_ReadOutputData
 340                     	xdef	_GPIO_ReadInputData
 341                     	xdef	_GPIO_WriteReverse
 342                     	xdef	_GPIO_WriteLow
 343                     	xdef	_GPIO_WriteHigh
 344                     	xdef	_GPIO_Write
 345                     	xdef	_GPIO_Init
 346                     	xdef	_GPIO_DeInit
 347                     	xref	_assert_failed
 348                     .const:	section	.text
 349  0000               L3:
 350  0000 2e2e5c73746d  	dc.b	"..\stm8s_stdperiph"
 351  0012 5f6472697665  	dc.b	"_driver\src\stm8s_"
 352  0024 6770696f2e63  	dc.b	"gpio.c",0
 353                     	end
