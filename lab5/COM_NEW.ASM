	AUXR EQU 8EH
	ORG 0000H
	LJMP MAIN
	ORG 0023H
	LJMP INT_ISR
	ORG 0100H

MAIN:
	MOV TMOD, #20H  ;��ʱ��1Ϊ��ʽ2
	MOV TH1,#0E8H	;������2400
	MOV TL1,#0E8H
	SETB TR1	;��ʱ��1��ʼ��ʱ

	MOV AUXR,#00H    ;��ʱ��1��Ϊ�����ʷ�����
	MOV SCON,#11010000B   ;��������Ϊ������ʽ3,�������գ���TB8��ΪżУ��λ'0'
	MOV PCON,#10000000B	  ;�����ʼӱ�

	SETB ES
	SETB EA		;���п��ж�����	
	SJMP $

INT_ISR:
	CLR EA	   ;���ж�
	CLR RI	   ;������п�1�жϱ�־
	PUSH DPL   ;�����ֳ�
	PUSH DPH
	PUSH ACC
	MOV A,SBUF	;�յ�Сд��ĸ
	MOV C,P	;��ȡУ��λ
	MOV TB8,C
	CLR C
	SUBB A,#20H	;��ɴ�д��ĸ
	MOV SBUF,A	;���ش�д��ĸ
CHECK:
	JNB TI,CHECK   ;�ȴ����ͽ���
	CLR TI		   ;����ָ��ֳ�
	POP ACC
	POP DPH
	POP DPL
	SETB EA		   ;���ж�
	RETI
	END