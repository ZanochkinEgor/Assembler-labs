include \masm64\include64\masm64rt.inc ; ����������
count PROTO arg_a:QWORD,arg_b:QWORD,arg_c:QWORD,arg_d:QWORD,arg_e:QWORD, arg_f:QWORD, arg_g:QWORD

.data
_a dq 16     ; �������� �
_b dq 4      ; �������� b
_c dq 64     ; �������� c
_d dq 32     ; �������� d
_e dq 128    ; �������� e
_f dq 256    ; �������� f
_g dq 512    ; �������� g
_res dq 0    ; ���������� ����������
_res1 dq 0   ; ���������� ����������
_res2 dq 0   ; ���������� ����������
_res3 dq 0   ; ���������� ����������
_title db "������������ ������ 2-1. ������� ������.",0
_text db "��������� ab + cd/e + f � g",0ah,"��������� ���������� �����. ������: %d",0ah,"����� ������: %d",0ah,0ah,
"��������� ���������� ������ c�����: %d",0ah,"����� ������: %d",0ah,0ah,
"�����: �������� �. �., ���-119�",0
buf1 dq 3 dup(0),0 ; ����� ��� ������

.code
count proc arg_a:QWORD,arg_b:QWORD,arg_c:QWORD,arg_d:QWORD,arg_e:QWORD,arg_f:QWORD,arg_g:QWORD
mov r10,rdx    ; ������� � r10 �������� b
rdtsc          ; rdx,rax � ��������� ����� ������
xchg rdi,rax   ; ����� ���������� ��������� rdi � rax
mov rax,rcx    ; ������� � rax �������� a
mul r10        ; �������� � �� b
mov rsi,rax    ; ������� � rsi �������� a*b 
mov rax,r8     ; ������� � rax �������� c
mul r9         ; �������� c �� d
xor rdx,rdx    ; �������� rdx
div arg_e      ; (c*d)/e
add rax,rsi    ; ��������� a*b � (c*d)/e
add rax, arg_f ; ��������� �������� f
sub rax, arg_g ; �������� �������� g
mov _res,rax   ; ������� ��������� � _res
rdtsc          ; ��������� ����� ������
sub rax,rdi    ; ��������� �� ���������� ����� ������ ����������� �����
mov _res1,rax  ; ������� ����� ������ � _res1
ret
count endp

count2 proc arg_a:QWORD,arg_b:QWORD,arg_c:QWORD,arg_d:QWORD,arg_e:QWORD,arg_f:QWORD,arg_g:QWORD
rdtsc          ; rdx,rax � ��������� ����� ������
xchg rdi,rax   ; ����� ���������� ��������� rdi � rax
sal rcx,2      ; �������������� ����� ����� (���������) ��������� a �� 2 (a*b)
mov rsi,rcx    ; ������� � rsi �������� a*b
sal r8,5       ; �������������� ����� ����� (���������) ��������� c �� 5 (c*d)
sar r8,7       ; �������������� ����� ������ (�������) ������� c*d �� 7 (c*d/e)
add r8,rsi     ; ��������� a*b � (c*d)/e
add r8,arg_f   ; ��������� �������� f
sub r8,arg_g   ; �������� �������� g
mov _res2,r8   ; ������� ��������� � _res2
rdtsc          ; ��������� ����� ������
sub rax, rdi   ; ��������� �� ���������� ����� ������ ����������� �����
mov _res3,rax  ; ������� ����� ������ � _res3
ret
count2 endp

entry_point proc
invoke count,_a,_b,_c,_d,_e,_f,_g
invoke count2,_a,_b,_c,_d,_e,_f,_g
invoke wsprintf, ADDR buf1, ADDR _text, _res, _res1,_res2,_res3
invoke MessageBox,0, addr buf1, addr _title, MB_ICONINFORMATION
invoke ExitProcess,0
entry_point endp
end