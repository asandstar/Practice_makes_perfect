/*
	ORG 0000H
	LJMP MAIN
	ORG 0003H
	LJMP INTT0
	ORG 0013H
	LJMP INTT1

	ORG 0100H
MAIN: 
	SETB P1.0 ;PWM输出端口
	CLR P1.6;清零INTT0 溢出标志
	SETB P1.7;设置INTT1 溢出标志	
	MOV TMOD,#11H;定时器T0，T1,模式1
	SETB EA;CPU 开放中断
	SETB IT0;边沿触发
	SETB IT1
	SETB EX0;允许外部中断
	SETB EX1
	MOV R0,#0F1H ;R0,R1 保存高电平维持时间
	MOV R1,#09AH
	MOV R2,#0C6H;R2,R3 保存低电平维持时间
	MOV R3,#66H//62+B9=1 3A	
	MOV TH0,R0
	MOV TL0,R1
//	MOV TH1,R2
//	MOV TL1,R3
	SETB TR0
	SETB TR1
START: 
	SETB TR0	
LOOP: 
	JBC TF0,NEXT0;溢出标志位为1 则跳出循环
	SJMP LOOP
NEXT0: 
	CPL P1.0;翻转P1.0
	CLR TR0
	JB P1.0,UP0;若P1.0 为高电平,则进入高电平时间赋值
	MOV TH0,R2
	MOV TL0,R3
	SJMP BACK
UP0: 
	MOV TH0,R0
	MOV TL0,R1
BACK: 
	SJMP START

	ORG 0200H
INTT0: 
	ACALL DELAY50MS
	CLR P1.7;清零INTT1 溢出位
	JB P1.6,FAIL0;如果INTT0 溢出位为1,功能失效
	CLR C;进位清零
	ACALL DUTY40
   	SETB EA;CPU 开放中断
	SETB IT0;边沿触发
	SETB IT1
	SETB EX0;允许外部中断
	JNZ FAIL0
	SETB P1.6;若A 为00H 则表明INTT0溢出,设置溢出位
FAIL0: 
	CLR IE0;关闭中断
	RETI

	ORG 0300H
INTT1: 
	ACALL DELAY50MS
	CLR P1.6;清零INTT0 溢出位
	JB P1.7,FAIL1;如果INTT1 溢出位为一,功能失效
	CLR C;进位清零
	ACALL DUTY20
	SETB EA;CPU 开放中断
	SETB IT0;边沿触发
	SETB IT1
	SETB EX1
		JNZ FAIL1
	SETB P1.7;若A 为00H 则表明INTT1 溢出,置溢出位
FAIL1: 
	CLR IE1;关闭中断
	RETI
DELAY50MS:			;@11.0592MHz
	NOP
	NOP
	NOP
	PUSH	30H
	PUSH	31H
	PUSH	32H
	MOV		30H,#2
	MOV		31H,#175
	MOV		32H,#72
NEXT50:
	DJNZ	32H,NEXT50
	DJNZ	31H,NEXT50
	DJNZ	30H,NEXT50
	POP		32H
	POP		31H
	POP		30H
	RET
DUTY40:
	MOV R0,#0E3H ;R0,R1 保存高电平维持时间
	MOV R1,#33H
	MOV R2,#0D4H;R2,R3 保存低电平维持时间
	MOV R3,#0CCH//62+B9=1 3A
	RET
DUTY20:
	MOV R0,#0F1H ;R0,R1 保存高电平维持时间
	MOV R1,#09AH
	MOV R2,#0C6H;R2,R3 保存低电平维持时间
	MOV R3,#66H//62+B9=1 3A
	RET	
	SJMP $
	END





*/


	ORG 0000H
	LJMP MAIN
	ORG 0003H
	LJMP INTT0
	ORG 0013H
	LJMP INTT1

	ORG 0100H
MAIN: 
	SETB P1.0 ;PWM输出端口
	CLR P1.6;清零INTT0 溢出标志
	SETB P1.7;设置INTT1 溢出标志
	MOV TMOD,#11H;定时器T0，T1,模式1

	SETB EA;CPU 开放中断
	SETB IT0;边沿触发
	SETB IT1
	SETB EX0;允许外部中断
	SETB EX1

//	MOV R0,#0FFH ;R0,R1 保存高电平维持时间
//	MOV R1,#0FFH
//	MOV R2,#0FCH;R2,R3 保存低电平维持时间
//	MOV R3,#62H
	MOV R0,#0FFH ;R0,R1 保存高电平维持时间
	MOV R1,#046H
	MOV R2,#0FDH;R2,R3 保存低电平维持时间
	MOV R3,#3AH//62+B9=1 3A

//80% R0 FDH R1 1BH R2 FFH R3 65H
//60% R0 FDH R1 D4H R2 FEH R3 ACH
//40% R0 FEH R1 8DH R2 FDH R3 F3H
//20% R0 FFH R1 46H R2 FFH R3 3AH


	MOV TH0,R0
	MOV TL0,R1
START: 
	SETB TR0
	SETB TR1;启动定时器	
LOOP: 
	JBC TF0,NEXT;溢出标志位为1 则跳出循环
	SJMP LOOP
NEXT: 
	CPL P1.0;翻转P1.0
	CLR TR0
	JB P1.0,UP;若P1.0 为高电平,则进入高电平时间赋值
	MOV TH0,R2
	MOV TL0,R3
	SJMP BACK
UP: 
	MOV TH0,R0
	MOV TL0,R1
BACK: 
	SJMP START

	ORG 0200H

INTT0: 
	ACALL DELAY50MS
	CLR P1.7;清零INTT1 溢出位
	JB P1.6,FAIL0;如果INTT0 溢出位为1,功能失效
	CLR C;进位清零

	MOV A,R1;高电平时钟周期数增加B9H
	SUBB A,#0B9H
	MOV R1,A

	MOV A,R0
	SUBB A,#00H
	MOV R0,A

	CLR C

	MOV A,R3;低电平时钟周期数减少B9H
	ADD A,#0B9H
	MOV R3,A

	MOV A,R2
	ADDC A,#00H
	MOV R2,A

	MOV A,R3
	ADD A,#01H;如果此时R3 为FFH 则A 此时为00H

	JNZ FAIL0
	SETB P1.6;若A 为00H 则表明INTT0溢出,设置溢出位
FAIL0: 
	CLR IE0;关闭中断
	RETI

	ORG 0300H
INTT1: 
	ACALL DELAY50MS
	CLR P1.6;清零INTT0 溢出位
	JB P1.7,FAIL1;如果INTT1 溢出位为一,功能失效
	CLR C;进位清零

	MOV A,R3;低电平时钟周期数增加B9H
	SUBB A,#0B9H
	MOV R3,A

	MOV A,R2
	SUBB A,#00H
	MOV R2,A

	CLR C

	MOV A,R1;高电平时钟周期数减少B9H
	ADD A,#0B9H
	MOV R1,A

	MOV A,R0
	ADDC A,#00H
	MOV R0,A

	MOV A,R1
	ADD A,#01H;如果此时R1 为FFH 则A 此时为00H

	JNZ FAIL1
	SETB P1.7;若A 为00H 则表明INTT1 溢出,置溢出位
FAIL1: 
	CLR IE1;关闭中断
	RETI


DELAY50MS:			;@11.0592MHz
	NOP
	NOP
	NOP
	PUSH	30H
	PUSH	31H
	PUSH	32H
	MOV		30H,#2
	MOV		31H,#175
	MOV		32H,#72
NEXT50:
	DJNZ	32H,NEXT50
	DJNZ	31H,NEXT50
	DJNZ	30H,NEXT50
	POP		32H
	POP		31H
	POP		30H
	RET

	SJMP $
	END

//	ORG 0000H
//	LJMP MAIN
//	ORG 0003H
//	LJMP INT0_KEY1
//	ORG 0013H
//	LJMP INT1_KEY2
//
//	ORG 0100H
//MAIN:
//	MOV TMOD,#11H ;定时器T0，T1,模式1之16位手动重装载
//	MOV R0, #0FFH
//	MOV R1, #046H
//	MOV R2, #0FDH
//	MOV R3, #3AH
//	MOV TH0,R0
//	MOV TL0,R1
//
//	SETB P1.0 ;pwm输出端口
//
//	SETB EA	  ;CPU 开放中断
//	SETB IT0   ;边沿触发
//	SETB IT1   ;边沿触发
//	SETB EX0  ;允许外部中断1
//	SETB EX1  ;允许外部中断2
//	CLR P1.6  ;外部中断0（按键1）标志位FLAG1
//	SETB P1.7  ;外部中断1（按键0）标志位FLAG2
//
//START0:	
//	SETB TR0
//	SETB TR1
//LOOP:
//	JBC TF0,DOWN ;TF0=1，高电平时间结束
//	SJMP LOOP	;继续保持高电平
//DOWN: 
//	CPL P1.0 
//	CLR TR0
//	JB P1.0,UP
//	MOV TH0,R2
//	MOV TL0,R3
//	SJMP RELOOP
//UP:
//	MOV TH0,R0
//	MOV TL0,R1
//RELOOP:
//	SJMP START0
//
//	ORG 0200H
//
//INT0_KEY1:
//	ACALL DELAY50MS
//	CLR P1.7 ;清零标志位2
//	JB P1.6, FAIL0
//	MOV A,R1
//	SUBB A,#01BH
//	JZ LIMIT
////	SJMP ADDSPEED 
////ADDSPEED:
//;高电平时钟周期增加
//	CLR C
//	MOV A,R1
//	SUBB A,#0B9H
//	MOV R1,A
//	MOV A,R0
//	SUBB A,#00H
//	MOV R0,A
//;低电平时钟周期减少
//	CLR C
//	MOV A,R3
//	ADD A,#0B9H
//	MOV R3,A
//	MOV A,R2
//	ADDC A,#00H
//	MOV R2,A
//	MOV A,R3
//	ADD A,#01H	  ;R1=0FFH-0B9H=36H时,A+37H=00H
//	
//	JNZ FAIL0
//	SETB P1.6
//LIMIT:
//	 MOV R0,#0FDH
//	 MOV R1,#1BH
//	 MOV R2,#0FFH
//	 MOV R3,#65H
//FAIL0:
//	CLR IE0
//	RETI
//
////80% R0 FDH R1 1BH R2 FFH R3 65H
////60% R0 FDH R1 D4H R2 FEH R3 ACH
////40% R0 FEH R1 8DH R2 FDH R3 F3H
////20% R0 FFH R1 46H R2 FFH R3 3AH
//	 
//
//	ORG 0300H
//INT1_KEY2:
//	ACALL DELAY50MS
//	CLR P1.6 ;清零标志位1 	
//	JB P1.7,FAIL1
//	MOV A,R1
//	SUBB A,#046H
//	JZ LIMIT2
//	CLR C
//	MOV A,R3
//	SUBB A,#0B9H
//	MOV R3,A
//	MOV A,R2
//	SUBB A,#00H
//	MOV R2,A
//	CLR C
//	MOV A,R1
//	ADD A,#0B9H
//	MOV R1,A
//	MOV A,R0
//	ADDC A,#00H
//	MOV R0,A
//	
//	MOV A,R1
//	ADD A,#01H	  ;R1=0FFH-0B9H=36H时,A+37H=00H
//
//	JNZ FAIL1
//	SETB P1.7
//	//SJMP SUBSPEED
////SUBSPEED:
////	CLR C
////	MOV A,R3
////	SUBB A,#0B9H
////	MOV R3,A
////	CLR C
////	MOV A,R1
////	ADD A,#0B9H
////	MOV R1,A
////	
////	MOV A,R1
////	ADD A,#37H	  ;R1=0FFH-0B9H=36H时,A+37H=00H
////
////	JNZ FAIL1
////	SETB P1.7	
//LIMIT2:
//	MOV R0, #0FFH
//	MOV R1, #46H
//	MOV R2, #0FFH
//	MOV R3, #03AH
//FAIL1:
//	CLR IE1	  ;关中断
//	RETI
//
//
////80% R0 FDH R1 1BH R2 FFH R3 65H
////60% R0 FDH R1 D4H R2 FEH R3 ACH
////40% R0 FEH R1 8DH R2 FDH R3 F3H
////20% R0 FFH R1 46H R2 FFH R3 3AH
//
//DELAY50MS:			;@11.0592MHz
//	NOP
//	NOP
//	NOP
//	PUSH	30H
//	PUSH	31H
//	PUSH	32H
//	MOV		30H,#2
//	MOV		31H,#175
//	MOV		32H,#72
//NEXT50:
//	DJNZ	32H,NEXT50
//	DJNZ	31H,NEXT50
//	DJNZ	30H,NEXT50
//	POP		32H
//	POP		31H
//	POP		30H
//	RET
//
//	SJMP $
//	END
