/*
�ֱ��þ�����ʽ�͹�����ʽ��ʾ�Լ�����/���������֣����岻�ޣ���
     ��λ��Ϊ������ͬѧ����ɨ�裬�ҹ���ʱ��������
     ��λ��Ϊ˫����ͬѧ����ɨ�裬�ҹ���ʱ��������

	 ��ʽ��ʾ�����𽥷Ŵ��xin
*/

//zhangle
//������ʾһ
	HL EQU 70H ;���źŵ�λ�ڴ��ַ
	HH EQU 71H ;���źŸ�λ�ڴ��ַ
	LL EQU 72H ;���źŵ�λ�ڴ��ַ
	LH EQU 73H ;���źŸ�λ�ڴ��ַ
	
	DH EQU P1.0 ;���ź�����
	DL EQU P1.1 ;���ź�����
	SCK EQU P1.2 ;��λ�Ĵ���ʱ��
	OE EQU P1.3 ;���ʹ��
	RCK EQU P1.4 ;������ʱ��
	
	ORG 0000H
	LJMP MAIN
	ORG 0100H
MAIN: MOV DPTR,#WORD ;��ģ����ַ
	MOV R1,#00H ;��ַƫ����
	MOV HL,#01H ;��ɨ��һ�У���ֵ 0001H
	MOV HH,#00H
LOOP: MOV A,R1
	MOVC A,@A+DPTR
	MOV LL,A ;�����źŵͰ�λ
	INC R1 ;ƫ����+1
	MOV A,R1
	MOVC A,@A+DPTR
	MOV LH,A ;�����źŸ� 8 λ
	LCALL SEND ;�������ݴ����ӳ���
	LCALL DELAY ;��ʱ
	CLR C
	MOV A,HL ;ɨ����һ��
	RLC A
	MOV HL,A
	MOV A,HH
	RLC A
	MOV HH,A
	INC R1 ;�ߵ����θ�+1
	CJNE R1,#20H,LOOP ;�ж�һ��ɨ���Ƿ����
	LJMP MAIN
SEND: CLR OE ;ʹ�ܵ͵�ƽ��Ч
	CLR RCK
	MOV R2,#08H
	MOV R3,LH ;���źŸ� 8 λ
	MOV R4,HH ;���źŸ� 8 λ
BACK: CLR SCK
	MOV A,R3 ;���ź���λ����
	RLC A
	MOV R3,A
	MOV DL,C
	MOV A,R4 ;���ź���λ����
	RLC A
	MOV R4,A
	MOV DH,C
	SETB SCK ;SCK �����أ���������������Ĵ���
	DJNZ R2,BACK ;�ж��Ƿ� 8 λ�������
	MOV R2,#08H
	MOV R3,LL ;���źŵ� 8 λ
	MOV R4,HL ;���źŵ� 8 λ
BACK1: CLR SCK
	MOV A,R3
	RLC A
	MOV R3,A
	MOV DL,C ;���ź���λ����
	MOV A,R4 ;���ź���λ����
	RLC A
	MOV R4,A
	MOV DH,C
	SETB SCK ;SCK �����أ���������������Ĵ���
	DJNZ R2,BACK1 ;�ж��Ƿ� 8 λ�������
	SETB RCK ;RCK �����أ����Ĵ�����������������
	RET
DELAY: 
	MOV R7,#50
DELAY1: 
	MOV R6,#10
DELAY2: 
	DJNZ R6,DELAY2
	DJNZ R7,DELAY1
	RET
WORD:
	DB	0FEH,0FFH,0FEH,0FFH,0EFH,03H,0FEH,0FFH,0FEH,0FFH,0E0H,07H,0EFH,0F7H,0EFH,0F7H
	DB	0EFH,0F7H,0E0H,07H,0EFH,0F7H,0EFH,0FFH,0DFH,0FFH,0DFH,0FFH,0BFH,0FFH,7FH,0FFH
	END 


//������ʾ
//���¹���
	LL EQU  72H         ;���źŵ�λ�ڴ��ַ            
	HD EQU  P1.0         ;P1.0�������ź������  
	LD EQU  P1.1         ;P1.1�������ź������  
	SCK EQU  P1.2        ;P1.2������λ�Ĵ���  
	OE EQU  P1.3        ;P1.3����ʹ�ܶ�  
	RCK EQU  P1.4        ;P1.4����������  
	  
	ORG  0000H                 
	LJMP  MAIN  
	ORG  0100H                 
MAIN:  
	MOV   DPTR,#DISPLAY  ;��ģ����ַ  
	MOV   R1,#00H          
	MOV R7,#00H       ;R7������ʾ��ģ����ʼλ��ƫ����  
LOOP:  
	MOV   R5,#20         ;R5������ʾ��ʱ���ı�R5��ֵ�ɸı�����ٶ�                
LOOP1:  
	MOV   R6,#10H        ;R6�����ж��Ƿ�ɨ����һ��  
	MOV A,R7              ;��R7��ֵ��ֵ��R1  
	MOV R1,A  
	MOV   HL,#01H        ;��ɨ���źŵĳ�ֵ0001H  
	MOV   HL+1,#00H  
LOOP2:  
	MOV   A,R1  
	MOVC  A,@A+DPTR    
	MOV   LL,A           ;�ҵ��е�λ���ݣ������ڴ��ַ��  
	INC   R1  
	MOV   A,R1  
	MOVC  A,@A+DPTR  
	MOV   LL+1,A         ;�ҵ��и�λ���ݣ������ڴ��ַ��  

	LCALL SENDD           ;���ô������ݵĳ���  
 
	LCALL DELAY           ;������ʱ����  
 
	CLR   C               ;λ�����ۼ�������  
    MOV   A,HL  
    RLC   A               ;������ɨ���źŵͰ�λ  
	MOV   HL,A  
	MOV   A,HL+1      
	RLC   A               ;������ɨ���źŸ߰�λ  
	MOV   HL+1,A  
	INC   R1  
    DEC   R6  
	CJNE  R6,#00H,LOOP2   ;ͨ��R6�ж��Ƿ�ɨ����һ�֣�R6��Ϊ0��һ��ɨ�����  
	DJNZ  R5,LOOP1        ;ͨ��R5�ж�һ֡����ʱ�Ƿ�ﵽ  
	INC   R7              ;�ı���ģ����ƫ����  
	INC   R7              ;R7������2���൱�ڻ���  
	      
	CJNE  R7,#40H,LOOP    ;�ж���ģ���Ƿ����  
    LJMP  MAIN  
	  
SENDD:  
    CLR   OE             ;ʹ���źŵ͵�ƽ��Ч  
    CLR   RCK            ;RCK�ź���0  
    MOV   R2,#08H  
    MOV   R3,LL+1        ;���źŸ�8λ��ַ  
    MOV   R4,HL+1        ;���źŸ�8λ��ַ  
BACK:  
    CLR   SCK             ;SCK�ź���0   
    MOV   A,R3  
    RLC   A  
    MOV   R3,A  
	MOV   HD,C           ;���ź���λ����  
	MOV   A,R4  
	RLC   A  
	MOV   R4,A  
	MOV   LD,C           ;���ź���λ����  
	SETB  SCK             ;SCK�ź������ص���������������������λ�Ĵ���  
	DJNZ  R2,BACK         ;�жϸ߰�λ�ź��Ƿ������  
	MOV   R2,#08H  	  
	MOV   R3,LL          ;���źŵͰ�λ��ַ  
	MOV   R4,HL          ;���źŵͰ�λ��ַ  
BACK1:  
	CLR  SCK              ;SCK�ź���0  
	MOV  A,R3  
	RLC  A  
	MOV  R3,A  
	MOV  HD,C            ;���ź���λ����  
	MOV  A,R4  
	RLC  A  
	MOV  R4,A  
	MOV  LD,C            ;���ź���λ����  
	SETB SCK               ;SCK�ź������ص���������������������λ�Ĵ���  
	DJNZ R2,BACK1          ;�жϵͰ�λ�ź��Ƿ������  
	SETB RCK               ;RCK�ź������ص�������λ�Ĵ������������������ݼĴ���  
	RET    
DELAY:                     ;��ʱ�ӳ���  
	MOV  R2,#50    
DELAY1:  
	MOV  R3,#10  
DELAY2:  
	DJNZ R3,$  
	DJNZ R2,DELAY1  
	RET  
  
DISPLAY:  
	DB 07FH, 0FFH, 060H, 0EFH, 06FH, 0EFH, 06FH, 0F7H, 06FH, 0FBH, 061H, 0FDH, 07DH, 0FFH, 01DH, 080H;  
	DB 07DH, 0FDH, 061H, 0FBH, 06FH, 0FBH, 06FH, 0F7H, 06FH, 0EFH, 06FH, 0DDH, 075H, 0BEH, 07BH, 0FFH;"��",0  
		  
	DB 0FFH, 0FBH, 0FFH, 0F0H, 007H, 0FFH, 0F7H, 0FFH, 077H, 0FFH, 07BH, 0FFH, 07BH, 0FFH, 003H, 0C0H;  
	DB 07FH, 0FFH, 06FH, 0FBH, 06FH, 0F7H, 077H, 0EFH, 07BH, 0DFH, 07DH, 0DFH, 05FH, 0FFH, 0BFH, 0FFH;"��",0  
	
	END