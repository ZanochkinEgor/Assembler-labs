include \masm64\include64\masm64rt.inc  ; ����������
count PROTO arg_a:QWORD,arg_b:QWORD,arg_c:QWORD,arg_d:QWORD, arg_e:QWORD,arg_f:QWORD,arg_g:QWORD

.data
_a1 dq 5    ; �������� �
_b1 dq 2    ; �������� b
_c1 dq 4    ; �������� c 
_d1 dq 1    ; �������� d
_e1 dq 2    ; �������� e
_f1 dq 3    ; �������� f
_g1 dq 4    ; �������� g
_res1 dq 0  ; ���������� ��� ���������� 
_title db "��1-2. ���������.",0
_text db "��������� a/d + c/b + efg",10,"���������: %d",10,"����� ���������� � ������: %p",10,10,
"�����: �������� �.�., ���-119�, ������� 7",0
buf1 dq 3 dup(0),0 ; ����� ��� ������

.code
count proc arg_a:QWORD, arg_b:QWORD, arg_c:QWORD, arg_d:QWORD, arg_e:QWORD, arg_f:QWORD, arg_g:QWORD
mov rbx,rdx     ; ������� � rbx �������� b  
mov rax,rcx     ; ������� � r�x �������� �
xor rdx,rdx     ; ��������� �������� rdx
div r9          ; ������� ��������� � �� �������� d
mov r10,rax     ; ������� ��������� a/d � ������� r10
mov rax,r8      ; ������� � r�x �������� c
mov r11, rbx    ; ������� � r11 �������� b
xor rdx,rdx     ; ��������� �������� rdx
div r11         ; ������� ��������� c �� �������� b
mov r12,rax     ; ������� ��������� c/b � ������� r12
add r10,r12     ; ��������� a/d � c/b
mov rax,arg_e   ; ������� � r�x �������� e
mov r13,arg_f   ; ������� � r13 �������� f
mul r13         ; �������� e �� f
mov r14,arg_g   ; ������� � r14 �������� g
mul r14         ; �������� rax �� �������� f
add r10,rax     ; ��������� a/d � c/b � efg 
mov _res1, r10  ; ������� ��������� � _res1
ret
count endp
entry_point proc

invoke count,_a1,_b1,_c1,_d1,_e1,_f1,_g1
invoke wsprintf,ADDR buf1,ADDR _text,_res1,ADDR _res1
invoke MessageBox,0,addr buf1, addr _title, MB_ICONINFORMATION
invoke ExitProcess,0
entry_point endp
end