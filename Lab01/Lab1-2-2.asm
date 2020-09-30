include \masm64\include64\masm64rt.inc          ; ����������� ����������

.data                                           ; ������ ������
arrA dq -43, -12, -8, -30, 9, 23, 56, 72         ; ������ �
arrB dq 52, -32, 12, 12, 40, -32, 7, 2          ; ������ �
arrC dq 8 dup(?)                                ; ������ �
len1 dq 8                                       ; ������ ������� �
len2 dq 8                                       ; ������ ������� �
count1 dq 0                                     ; ���-�� ������
res1 dq 0                                       ; ���������� ����������
res2 dq 0                                       ; ���������� ����������
res3 dq 0                                       ; ���������� ����������
res4 dq 0                                       ; ���������� ����������
 
title1 db "������������ ������ 1-2-2. ��������� � �����������. �������",0       ; ��������� ���� ������
txt1 db "������ ������� � � B � ������ ��������� ������ 7. �������� ��������� ������������ ������� � �� ������ �������: ���� �i � �i <= 0, �� �j = A�.",10,10,
"���������: ",10,
"arrC[0]: %d",10,
"arrC[1]: %d",10,
"arrC[2]: %d",10,
"arrC[3]: %d",10,10,
"�����: �������� �.�., ���-119�",0
buf1 dq 3 dup(0),0

.code           ; ��������� �������� ����
entry_point proc
xor rax,rax     ; ������� �������� RAX
xor rsi,rsi     ; ������� �������� RSI
xor rdi,rdi     ; ������� �������� RDI
xor rbp,rbp     ; ������� �������� RBP
xor rcx,rcx     ; ������� �������� RCX
xor rbx,rbx     ; ������� �������� RBX
xor r10,r10     ; ������� �������� R10

mov rcx,count1          ; �������� ���-�� ������
lea rsi,byte ptr arrA   ; ��������� ��������� � ������ ������� �
lea rdi,byte ptr arrB   ; ��������� ��������� � ������ ������� �
lea rbp,byte ptr arrC   ; ��������� ��������� � ������ ������� �

@1: 
mov rax,[rsi]           ; ������ �������� ������� � � RAX
mov rbx,[rdi]           ; ������ �������� ������� B � RBX
inc r10                 ; ��������� �������� R10
sub rax,rbx             ; ��������� ��������� ��������
cmp rax,0               ; ��������� ������� ��������� � ����
jle BelowOrEquelZero    ; ���� ����� ��������� <= 0, ������� � �-�� BelowOrEquelZero
jmp CheckArr            ; ������� �� �������� �� ����� �� ����� �������

BelowOrEquelZero:
mov rcx,[rsi]           ; ������ �������� Ai � ������� RCX
mov [rbp],rcx           ; ������ �������� � ������ C
add rbp,type arrC       ; ����������� �� ��������� ������� ������� C
jmp CheckArr            ; ������� �� �������� �� ����� �� ����� �������

CheckArr:
add rsi,type arrA       ; ����������� �� ��������� ������� ������� �
add rdi,type arrB       ; ����������� �� ��������� ������� ������� �
cmp r10,len1            ; �������� �� ����� �� ����� ������� �
je _end                 ; ���� ������ � �������, �� ������� � ����� ���������
cmp r10,len2            ; �������� �� ����� �� ����� ������� �
je _end                 ; ���� ������ � �������, �� ������� � ����� ���������
jmp @1                  ; ������� � ������ �����

_end:                   ; ����� ���������
xor rax,rax             ; ������� �������� RAX
xor rbp,rbp             ; ������� �������� RBP
lea rbp,byte ptr arrC   ; ��������� ��������� � ������ ������� �
mov rax,[rbp]           ; ������ �� ������� � � ������� RAX
mov res1,rax            ; ������ �� RAX � ���������� res1
xor rax,rax             ; ������� �������� RAX
add rbp,type arrC       ; ������������� �� ��������� ������� �������
mov rax,[rbp]           ; ������ �� ������� � � ������� RAX
mov res2,rax            ; ������ �� RAX � ���������� res2
xor rax,rax             ; ������� �������� RAX
add rbp,type arrC       ; ������������� �� ��������� ������� �������
mov rax,[rbp]           ; ������ �� ������� � � ������� RAX
mov res3,rax            ; ������ �� RAX � ���������� res3
xor rax,rax             ; ������� �������� RAX
add rbp,type arrC       ; ������������� �� ��������� ������� �������
mov rax,[rbp]           ; ������ �� ������� � � ������� RAX
mov res4,rax            ; ������ �� RAX � ���������� res4

invoke wsprintf,ADDR buf1,ADDR txt1, res1, res2, res3, res4
invoke MessageBox,0,ADDR buf1,ADDR title1,MB_ICONINFORMATION
invoke ExitProcess,0

entry_point endp        ; ����� ������
end