/*
1.�ֱ���STC15�Ķ�ʱ��/������T0��ģʽ0����ѯ��ʽ��
��ʱ��/������T1��ģʽ1���жϷ�ʽ�����������źţ�
Ƶ��Ϊ�����Լ�����λ�ż���4kHz���ҳ������޿ڵ�ַ��
*/
	//��ѯ��ʽ
	ORG 0000H
	LJMP MAIN

	ORG 0100H
MAIN:
	AUXR2 EQU 8FH
	MOV TMOD, #00H	    ; ģʽ0��16λ�Զ�����
	ORL AUXR2, #01H     ;T1(P3.5)ʾ����������
	MOV TH0,#0FFH		; ���ø��ֽڼ�����ֵ
	MOV TL0,#8DH		; ���õ��ֽڼ�����ֵ
	SETB P1.0			; ʾ���������˿�
	SETB TR0			; ����T0��ʱ��
	
LOOP:
	JNB TF0, LOOP		; ��ʱ��T0δ���������ѭ����ѯ
	//CPL P1.0			; �����תP1.0
	CLR TF0				; �����־λ����
	SJMP LOOP			; ѭ����ѯ
	SJMP $
	END




	//�жϷ�ʽ
	ORG 0000H
	LJMP MAIN
	ORG 001BH			  ; �жϷ��������ڵ�ַ
    LJMP INTT1			  ; ��ת���жϷ������

	ORG 0100H
MAIN:
	MOV SP, #60H		; ���ö�ջ����
	MOV TMOD, #10H		; ����T1Ϊģʽ1��16λ��ʱ����������ʽ1
	MOV TH1,#0FFH		; ���ø��ֽڼ�����ֵ
	MOV TL1,#8DH		; ���õ��ֽڼ�����ֵ
	SETB P1.0			; ʾ���������˿�

	SETB EA				; �����ж�
	SETB ET1			; ������ʱ��T1�ж�

	SETB TR1			; ����T1��ʱ��
   	SJMP $

	ORG 0200H 
INTT1:
	//CLR TF1 			; �����ʱ��T1�жϱ�־
	PUSH ACC
	PUSH DPL
	PUSH DPH
	MOV TH1,#0FAH		; ���ø��ֽڼ�����ֵ
	MOV TL1,#9AH		; ���õ��ֽڼ�����ֵ
	CPL P1.0
	POP DPH
	POP DPL
	POP ACC
	RETI

	END