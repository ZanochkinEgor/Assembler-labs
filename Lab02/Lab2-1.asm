include \masm64\include64\masm64rt.inc ; библиотеки
count PROTO arg_a:QWORD,arg_b:QWORD,arg_c:QWORD,arg_d:QWORD,arg_e:QWORD, arg_f:QWORD, arg_g:QWORD

.data
_a dq 16     ; аргумент а
_b dq 4      ; аргумент b
_c dq 64     ; аргумент c
_d dq 32     ; аргумент d
_e dq 128    ; аргумент e
_f dq 256    ; аргумент f
_g dq 512    ; аргумент g
_res dq 0    ; переменная результата
_res1 dq 0   ; переменная результата
_res2 dq 0   ; переменная результата
_res3 dq 0   ; переменная результата
_title db "Лабораторная работа 2-1. Команды сдвига.",0
_text db "Уравнение ab + cd/e + f — g",0ah,"Результат выполнения арифм. команд: %d",0ah,"Число тактов: %d",0ah,0ah,
"Результат выполнения команд cдвига: %d",0ah,"Число тактов: %d",0ah,0ah,
"Автор: Заночкин Е. Д., КИТ-119а",0
buf1 dq 3 dup(0),0 ; буфер для вывода

.code
count proc arg_a:QWORD,arg_b:QWORD,arg_c:QWORD,arg_d:QWORD,arg_e:QWORD,arg_f:QWORD,arg_g:QWORD
mov r10,rdx    ; заносим в r10 аргумент b
rdtsc          ; rdx,rax — получение числа тактов
xchg rdi,rax   ; обмен значениями регистров rdi и rax
mov rax,rcx    ; заносим в rax аргумент a
mul r10        ; умножаем а на b
mov rsi,rax    ; заносим в rsi значение a*b 
mov rax,r8     ; заносим в rax аргумент c
mul r9         ; умножаем c на d
xor rdx,rdx    ; обнуляем rdx
div arg_e      ; (c*d)/e
add rax,rsi    ; суммируем a*b и (c*d)/e
add rax, arg_f ; добавляем аргумент f
sub rax, arg_g ; отнимаем аргумент g
mov _res,rax   ; заносим результат в _res
rdtsc          ; получение числа тактов
sub rax,rdi    ; вычитание из последнего числа тактов предыдущего числа
mov _res1,rax  ; заносим число тактов в _res1
ret
count endp

count2 proc arg_a:QWORD,arg_b:QWORD,arg_c:QWORD,arg_d:QWORD,arg_e:QWORD,arg_f:QWORD,arg_g:QWORD
rdtsc          ; rdx,rax — получение числа тактов
xchg rdi,rax   ; обмен значениями регистров rdi и rax
sal rcx,2      ; арифметический сдвиг влево (умножение) аргумента a на 2 (a*b)
mov rsi,rcx    ; заносим в rsi значение a*b
sal r8,5       ; арифметический сдвиг влево (умножение) аргумента c на 5 (c*d)
sar r8,7       ; арифметический сдвиг вправо (деление) значния c*d на 7 (c*d/e)
add r8,rsi     ; суммируем a*b и (c*d)/e
add r8,arg_f   ; добавляем аргумент f
sub r8,arg_g   ; отнимаем аргумент g
mov _res2,r8   ; заносим результат в _res2
rdtsc          ; получение числа тактов
sub rax, rdi   ; вычитание из последнего числа тактов предыдущего числа
mov _res3,rax  ; заносим число тактов в _res3
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