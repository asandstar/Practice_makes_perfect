	ORG 0000H
	LJMP MAIN

	ORG 0100H
MAIN:
	JB P2.7,SWITCH0
	JNB P2.7,SWITCH1
LOOP:
	JB P2.7,SWITCH0
	JNB P2.7,SWITCH1
	SJMP LOOP
SWITCH0:
	MOV A,#0FEH
	LCALL WASH_LED_UP2DOWN
	SJMP LOOP
SWITCH1:
	MOV A,#7FH
	LCALL WASH_LED_DOWN2UP
	SJMP LOOP
WASH_LED_UP2DOWN:
	MOV P1,A
	RL A
	ACALL DELAY50MS
	JNB P2.7,SWITCH1
	SJMP WASH_LED_UP2DOWN
	RET

WASH_LED_DOWN2UP:
	MOV P1,A
	RR A
	ACALL DELAY50MS
	JB P2.7,SWITCH0
	SJMP WASH_LED_DOWN2UP
	RET

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
   	END

//	ORG 0000H
//	LJMP MAIN
//
//	ORG 0100H
//MAIN:
//	MOV P1,#00H	  ; 初始化P1口为0
//	MOV P2,#0FFH  ; 初始化P3口为1
//LOOP:
//	JNB P3.2,DOWNTOUP	; P3.2=0，跳DOWN;如果SWX往下则跳转到DOWN标签
//	JB P3.2,UPTODOWN ;把判断条件从UPTODOWN和DOWNTOUP中移至LOOP
//	SJMP LOOP
//DOWNTOUP:
//	LCALL SHANGXIA
//	SJMP LOOP
//SHANGXIA:
//	MOV A,#0FEH
//	MOV P1,A
//	RL A
//	SJMP SHANGXIA		;回到LOOP标签
//	RET	    
//UPTODOWN:
//	LCALL XIASHANG
//	SJMP LOOP
//XIASHANG:
//	MOV A,#0FEH
//	MOV P1,A
//	RR A
//	SJMP XIASHANG		;回到LOOP标签
//	RET
//
//DELAY500MS:			;延时函数
//	NOP
//	NOP
//	NOP
//	PUSH 30H
//	PUSH 31H
//	PUSH 32H
//	MOV 30H,#17
//	MOV 31H,#208
//	MOV 32H,#24
//NEXT:	
//	DJNZ 32H,NEXT
//	DJNZ 31H,NEXT
//	DJNZ 30H,NEXT
//	POP 32H
//	POP 31H
//	POP 30H
//	RET
//
//	END
//	