;ʵ���˹���
/*2.��̬��ʾС���㣬�м����ⲿ�жϷ�ʽ�����룬����ܾ�̬��ʾ��8������ܸ��ݰ���ͬʱ��ʾ��ֵ*/
	ORG 0000H
	LJMP MAIN
	ORG 0003H  				;�ⲿ�ж�0��ڵ�ַ
	LJMP INT0_ISR
	
	ORG 0100H  
MAIN:
	MOV 93H,#00H
	MOV 94H,#0FFH			;P0����Ϊ����ģʽ
	MOV 91H,#00H
	MOV 92H,#0FFH			;P1����Ϊ����ģʽ
	MOV 95H,#00H
	MOV 96H,#0FFH			;P2����Ϊ����ģʽ
	MOV SP,#50H				;���ö�ջ
	
	SETB IT0				;�ⲿ�ж�0�½��ش���
	SETB PX0				;�ж�0����
	SETB EX0				;�����ⲿ�ж�0
	SETB EA					;�������ж�

	MOV P2,#00H				;ѡͨ����8��
	MOV P1,#0F0H			;�п���

INT0_ISR:
	CLR EA					;���ж�
	LCALL DELAY10MS			;��������
	MOV A,#11111110B		;��ɨ��
	MOV R3,#04H

KEYSCAN:
	MOV P0,#80H
	MOV P1,A 				;��ɨ�踳ֵ
	MOV B,P1 				;���µ�ǰ��ɨ��ֵ
	CJNE A,B,FIND   		;���������֤���м�����
	RL A		    		;�����û�а������£�������ɨ��
	DJNZ R3,KEYSCAN			;4�ж�ɨ��
	SJMP EXIT				;ɨ�������û�м����£��˳��ж�

FIND:	
	MOV DPTR,#KEY  			;��ֵ���׼��
	MOV R0,#0FFH   			;Ϊ����ʾ׼��

KEYSELECT:
	INC R0	   				;R0��ֵ0����ӦKEY0
	CJNE R0,#16,SEGSELECT	;��KEY15��ת�Ƶ���ѡͨ
	SJMP EXIT

SEGSELECT:	
	MOV A,R0   				;��A�����ҵ��ļ�ֵ�������
	MOVC A,@A+DPTR			;���������Ѱ��ʵ�ʼ�ֵ
	CJNE A,B,KEYSELECT		;���������֤���м����£��Ҽ������
	MOV DPTR,#SEG			;��ѡͨ���׼��
	MOV A,R0				;��A�����ҵ��ļ�ֵ�������
	MOVC A,@A+DPTR	 		;���������Ѱ�Ҷ�ѡֵͨ
	MOV P0,A		 		;�Ѽ�ֵ��Ӧ��ѡֵͨ�͸�P0
	SJMP EXIT

EXIT:
	CLR IE0					;����ⲿ�ж�INT0�������־λ
	SETB EA					;�����ж�
	MOV P1,#0F0H			;�п���
	RETI					;�жϷ���

//DELAY20MS:					;������������
//	PUSH 30H
//	PUSH 31H
//	MOV 30H,#173
//	MOV 31H,#27
//NEXT:
//	DJNZ 31H,NEXT
//	DJNZ 30H,NEXT
//	POP 31H
//	POP 30H
//	RET

DELAY10MS:          ;@11.0592MHz  
	NOP  
	NOP  
	NOP  
	PUSH 30H  
	PUSH 31H  
	MOV 30H,#87  
	MOV 31H,#10  
NEXT:  
	DJNZ 31H,NEXT  
	DJNZ 30H,NEXT  
	POP 31H  
	POP 30H  
	RET  

	ORG 1000H
KEY:					;������
//	DB 0EEH,0DEH,0BEH,7EH,0EDH,0DDH,0BDH,7DH
//	DB 0EBH,0DBH,0BBH,7BH,0E7H,0D7H,0B7H,77H
	DB 07EH,0BEH,0DEH,0EEH	;3,2,1,0
	DB 07DH,0BDH,0DDH,0EDH	;7,6,5,4
	DB 07BH,0BBH,0DBH,0EBH	;B,A,9,8
	DB 077H,0B7H,0D7H,0E7H	;F,E,D,C

	ORG 1100H
SEG:				;����
	DB 3FH,06H,5BH,4FH,66H,6DH,7DH,07H
	DB 7FH,6FH,77H,7CH,39H,5EH,79H,71H
	END




//	ORG 0000H
//	LJMP MAIN
//	ORG 0003H  			;�ⲿ�ж�0�жϷ���������ڵ�ַ
//	LJMP INT01
//	
//	ORG 0100H  
//MAIN:
//	MOV 93H,#00H
//	MOV 94H,#0FFH			;P0����Ϊ����ģʽ
//	MOV 91H,#00H
//	MOV 92H,#0FFH			;P1����Ϊ����ģʽ
//	MOV 95H,#00H
//	MOV 96H,#0FFH			;P2����Ϊ����ģʽ
//	MOV SP,#50H				;��ջ
//	
//	SETB IT0				;�ⲿ�ж�0�½��ش���
//	SETB PX0
//	SETB EX0
//	SETB EA				;�����ⲿ�ж�0
//
//	MOV P2,#00H			;ͬʱѡͨ8�������
//	MOV P1,#0F0H			;�п��ţ�P0.0-P0.3��Ϊ0��
//
//INT01:
//	CLR EA					;�ر��ж�
//	LCALL DELAY20MS		;��ʱ20������������������
//	MOV A,#11111110B		;��ʼ����ɨ��
//	MOV R3,#04H
//
//LOOP1:
//	MOV P0,#80H
//	MOV P1,A
//	MOV 30H,P1
//	CJNE A,30H,FINDKEY
//	RL A
//	DJNZ R3,LOOP1
//	SJMP RETURN
//
//FINDKEY:	
//	MOV DPTR,#KEY_CODE
//	MOV R0,#0FFH
//
//LOOP2:
//	INC R0
//	CJNE R0,#16,LOOP3	
//;���������ת��LOOP3���������
//	SJMP RETURN
//
//LOOP3:
//	
//	MOV A,R0
//	MOVC A,@A+DPTR
//	CJNE A,30H,LOOP2
//	MOV DPTR,#CODE_TABLE
//	MOV A,R0
//	MOVC A,@A+DPTR
//	MOV P0,A
//	SJMP RETURN
//
//RETURN:
//	CLR IE0
//	SETB EA				;�����ж�
//	MOV P1,#0F0H			;�п��ţ�P0.0-P0.3��Ϊ0��
//	RETI					;�жϷ���
//
//DELAY20MS:					;����������������ʱ�ӳ���
//	PUSH 30H
//	PUSH 31H
//	MOV 30H,#173
//	MOV 31H,#27
//NEXT:
//	DJNZ 31H,NEXT
//	DJNZ 30H,NEXT
//	POP 31H
//	POP 30H
//	RET
//
//	ORG 1000H
//KEY_CODE:					;������
////	DB 0EEH,0DEH,0BEH,7EH,0EDH,0DDH,0BDH,7DH
////	DB 0EBH,0DBH,0BBH,7BH,0E7H,0D7H,0B7H,77H
//	DB 07EH,0BEH,0DEH,0EEH	;3,2,1,0
//	DB 07DH,0BDH,0DDH,0EDH	;7,6,5,4
//	DB 07BH,0BBH,0DBH,0EBH	;B,A,9,8
//	DB 077H,0B7H,0D7H,0E7H	;F,E,D,C
//
//	ORG 1100H
//CODE_TABLE:				;����
//	DB 3FH,06H,5BH,4FH,66H,6DH,7DH,07H
//	DB 7FH,6FH,77H,7CH,39H,5EH,79H,71H
//	END
//
//

