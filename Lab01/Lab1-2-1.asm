include \masm64\include64\masm64rt.inc  ; библиотеки
count PROTO arg_a:QWORD,arg_b:QWORD,arg_c:QWORD,arg_d:QWORD, arg_e:QWORD,arg_f:QWORD,arg_g:QWORD

.data
_a1 dq 5    ; аргумент а
_b1 dq 2    ; аргумент b
_c1 dq 4    ; аргумент c 
_d1 dq 1    ; аргумент d
_e1 dq 2    ; аргумент e
_f1 dq 3    ; аргумент f
_g1 dq 4    ; аргумент g
_res1 dq 0  ; переменная для результата 
_title db "ЛР1-2. Процедуры.",0
_text db "Уравнение a/d + c/b + efg",10,"Результат: %d",10,"Адрес переменной в памяти: %p",10,10,
"Автор: Заночкин Е.Д., КИТ-119а, Вариант 7",0
buf1 dq 3 dup(0),0 ; буфер для вывода

.code
count proc arg_a:QWORD, arg_b:QWORD, arg_c:QWORD, arg_d:QWORD, arg_e:QWORD, arg_f:QWORD, arg_g:QWORD
mov rbx,rdx     ; заносим в rbx аргумент b  
mov rax,rcx     ; заносим в rаx аргумент а
xor rdx,rdx     ; обнуление регистра rdx
div r9          ; деление аргумента а на аргумент d
mov r10,rax     ; заносим результат a/d в регистр r10
mov rax,r8      ; заносим в rаx аргумент c
mov r11, rbx    ; заносим в r11 аргумент b
xor rdx,rdx     ; обнуление регистра rdx
div r11         ; деление аргумента c на аргумент b
mov r12,rax     ; заносим результат c/b в регистр r12
add r10,r12     ; суммируем a/d и c/b
mov rax,arg_e   ; заносим в rаx аргумент e
mov r13,arg_f   ; заносим в r13 аргумент f
mul r13         ; умножаем e на f
mov r14,arg_g   ; заносим в r14 аргумент g
mul r14         ; умножаем rax на аргумент f
add r10,rax     ; суммируем a/d и c/b и efg 
mov _res1, r10  ; заносим результат в _res1
ret
count endp
entry_point proc

invoke count,_a1,_b1,_c1,_d1,_e1,_f1,_g1
invoke wsprintf,ADDR buf1,ADDR _text,_res1,ADDR _res1
invoke MessageBox,0,addr buf1, addr _title, MB_ICONINFORMATION
invoke ExitProcess,0
entry_point endp
end