//������ʾ
//���¹���           
//HD EQU  P1.0         ;P1.0�������ź������  
//LD EQU  P1.1         ;P1.1�������ź������ 
	DL EQU P1.0			;������
	DH EQU P1.1			;������ 
	SCK EQU  P1.2        ;��λ�Ĵ��� 
	RCK EQU  P1.3        ;������  
	OE EQU  P1.4         ;ʹ�ܶ�  

	HL EQU 30H ;�� ��λ
	HH EQU 31H ;�� ��λ
	LL EQU 32H ;�� ��λ
	LH EQU 33H ;�� ��λ
		  
	ORG  0000H                 
	LJMP  MAIN  
	ORG  0100H                 
MAIN:  
	MOV   DPTR,#WORDTAB  ;��ģ����ַ  
	MOV   R1,#00H          
	MOV   R7,#40H       ;R7������ʾ��ģ����ʼλ��ƫ����  
LOOP:  
	MOV   R5,#20         ;R5������ʾ��ʱ���ı�R5��ֵ�ɸı�����ٶ�                
LOOP1:  
	MOV   R6,#10H        ;R6�����ж��Ƿ�ɨ����һ��  
	MOV   A,R7              ;��R7��ֵ��ֵ��R1  
	MOV   R1,A  
	MOV   HL,#01H        ;��ɨ���źŵĳ�ֵ0001H  
	MOV   HH,#00H  
LOOP2:  
	MOV   A,R1  
	MOVC  A,@A+DPTR    
	MOV   LL,A           ;�ҵ��е�λ���ݣ������ڴ��ַ��  
	INC   R1  
	MOV   A,R1  
	MOVC  A,@A+DPTR  
	MOV   LH,A         ;�ҵ��и�λ���ݣ������ڴ��ַ��  
	LCALL HC595           ;���ô������ݵĳ���   
	LCALL DELAY           ;������ʱ����  
	CLR   C               ;λ�����ۼ�������  
    MOV   A,HL  
	RLC   A               ;������ɨ���źŵͰ�λ  
	MOV   HL,A  
	MOV   A,HH      
	RLC   A               ;������ɨ���źŸ߰�λ  
	MOV   HH,A  
	INC   R1  
    DEC   R6  
	CJNE  R6,#00H,LOOP2   ;ͨ��R6�ж��Ƿ�ɨ����һ�֣�R6��Ϊ0��һ��ɨ�����  
	DJNZ  R5,LOOP1        ;ͨ��R5�ж�һ֡����ʱ�Ƿ�ﵽ  
	DEC   R7              ;�ı���ģ����ƫ����  
	DEC   R7              ;R7������2���൱�ڻ���        
	CJNE  R7,#00H,LOOP    ;�ж���ģ���Ƿ����  
    LJMP  MAIN  
	
		  
HC595:  
	CLR   OE             ;ʹ���źŵ͵�ƽ��Ч  
	CLR   RCK            ;RCK�ź���0  
	MOV   R2,#08H  
	MOV   R3,LH        ;���źŸ�8λ��ַ  
	MOV   R4,HH        ;���źŸ�8λ��ַ  
BACK:  
	CLR   SCK             ;SCK�ź���0   
	MOV   A,R3  
	RLC   A  
	MOV   R3,A  
	MOV   DH,C           ;���ź���λ����  
	MOV   A,R4  
	RLC   A  
	MOV   R4,A  
	MOV   DL,C           ;���ź���λ����  
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
	MOV  DH,C            ;���ź���λ����  
	MOV  A,R4  
	RLC  A  
	MOV  R4,A  
	MOV  DL,C            ;���ź���λ����  
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
  
WORDTAB:
	
DB 0DFH,0FDH,0DFH,0FDH,000H,080H,0DFH,0FDH,0FFH,0FBH,0EFH,0FBH,0EFH,0FBH,0DFH,0FDH;
DB 0DFH,0FDH,0BFH,0FEH,07FH,0FFH,0BFH,0FEH,0DFH,0FDH,0EFH,0FBH,0F3H,0E7H,0FCH,09FH;"��",0

DB 0DFH,0FDH,0DFH,0FDH,000H,080H,0DFH,0FDH,0FFH,0FBH,0EFH,0FBH,0EFH,0FBH,0DFH,0FDH;
DB 0DFH,0FDH,0BFH,0FEH,07FH,0FFH,0BFH,0FEH,0DFH,0FDH,0EFH,0FBH,0F3H,0E7H,0FCH,09FH;"��",0

DB 0DFH,0FDH,0DFH,0FDH,000H,080H,0DFH,0FDH,0FFH,0FBH,0EFH,0FBH,0EFH,0FBH,0DFH,0FDH;
DB 0DFH,0FDH,0BFH,0FEH,07FH,0FFH,0BFH,0FEH,0DFH,0FDH,0EFH,0FBH,0F3H,0E7H,0FCH,09FH;"��",0

//	DB 0FBH ,0BFH ,0FBH ,0BFH ,000H ,001H ,0FBH ,0BFH ,0FFH ,0DFH ,0F7H ,0DFH ,0F7H ,0DFH ,0FBH ,0BFH;
//	DB 0FBH ,0BFH ,0FDH ,07FH ,0FEH ,0FFH ,0FDH ,07FH ,0FBH ,0BFH ,0F7H ,0DFH ,0CFH ,0E7H ,03FH ,0F9H;"��",0
//
//	DB 0FBH ,0BFH ,0FBH ,0BFH ,000H ,001H ,0FBH ,0BFH ,0FFH ,0DFH ,0F7H ,0DFH ,0F7H ,0DFH ,0FBH ,0BFH;
//	DB 0FBH ,0BFH ,0FDH ,07FH ,0FEH ,0FFH ,0FDH ,07FH ,0FBH ,0BFH ,0F7H ,0DFH ,0CFH ,0E7H ,03FH ,0F9H;"��",0
	END