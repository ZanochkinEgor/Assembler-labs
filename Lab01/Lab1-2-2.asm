include \masm64\include64\masm64rt.inc          ; подключение библиотеки

.data                                           ; секция данных
arrA dq -43, -12, -8, -30, 9, 23, 56, 72         ; массив А
arrB dq 52, -32, 12, 12, 40, -32, 7, 2          ; массив В
arrC dq 8 dup(?)                                ; массив С
len1 dq 8                                       ; длинна массива А
len2 dq 8                                       ; длинна массива В
count1 dq 0                                     ; кол-во циклов
res1 dq 0                                       ; переменная результата
res2 dq 0                                       ; переменная результата
res3 dq 0                                       ; переменная результата
res4 dq 0                                       ; переменная результата
 
title1 db "Лабораторная работа 1-2-2. Процедуры с параметрами. Массивы",0       ; заголовок окна вывода
txt1 db "Заданы массивы А и B с числом элементов больше 7. Написать программу формирования массива С по такому правилу: если Аi – Вi <= 0, то Сj = Aі.",10,10,
"Результат: ",10,
"arrC[0]: %d",10,
"arrC[1]: %d",10,
"arrC[2]: %d",10,
"arrC[3]: %d",10,10,
"Автор: Заночкин Е.Д., КИТ-119а",0
buf1 dq 3 dup(0),0

.code           ; директива сегмента кода
entry_point proc
xor rax,rax     ; очистка регистра RAX
xor rsi,rsi     ; очистка регистра RSI
xor rdi,rdi     ; очистка регистра RDI
xor rbp,rbp     ; очистка регистра RBP
xor rcx,rcx     ; очистка регистра RCX
xor rbx,rbx     ; очистка регистра RBX
xor r10,r10     ; очистка регистра R10

mov rcx,count1          ; указание кол-ва циклов
lea rsi,byte ptr arrA   ; установка указателя в начало массива А
lea rdi,byte ptr arrB   ; установка указателя в начало массива В
lea rbp,byte ptr arrC   ; установка указателя в начало массива С

@1: 
mov rax,[rsi]           ; запись элемента массива А в RAX
mov rbx,[rdi]           ; запись элемента массива B в RBX
inc r10                 ; инкремент регистра R10
sub rax,rbx             ; отнимание элементов массивов
cmp rax,0               ; сравнение разницы элементов с нулём
jle BelowOrEquelZero    ; если сумма элементов <= 0, переход в ф-ию BelowOrEquelZero
jmp CheckArr            ; переход на проверку на выход за грани массива

BelowOrEquelZero:
mov rcx,[rsi]           ; запись элемента Ai в регистр RCX
mov [rbp],rcx           ; запись элемента в массив C
add rbp,type arrC       ; перемещение на следующий элемент массива C
jmp CheckArr            ; переход на проверку на выход за грани массива

CheckArr:
add rsi,type arrA       ; перемещение на следующий элемент массива А
add rdi,type arrB       ; перемещение на следующий элемент массива В
cmp r10,len1            ; проверка на выход за грани массива А
je _end                 ; если массив А пройден, то перейти в конец программы
cmp r10,len2            ; проверка на выход за грани массива В
je _end                 ; если массив В пройден, то перейти в конец программы
jmp @1                  ; переход в начало цикла

_end:                   ; конец программы
xor rax,rax             ; очистка регистра RAX
xor rbp,rbp             ; очистка регистра RBP
lea rbp,byte ptr arrC   ; установка указателя в начало массива С
mov rax,[rbp]           ; запись из массива С в регистр RAX
mov res1,rax            ; запись из RAX в переменную res1
xor rax,rax             ; очистка регистра RAX
add rbp,type arrC       ; переместиться на следующий элемент массива
mov rax,[rbp]           ; запись из массива С в регистр RAX
mov res2,rax            ; запись из RAX в переменную res2
xor rax,rax             ; очистка регистра RAX
add rbp,type arrC       ; переместиться на следующий элемент массива
mov rax,[rbp]           ; запись из массива С в регистр RAX
mov res3,rax            ; запись из RAX в переменную res3
xor rax,rax             ; очистка регистра RAX
add rbp,type arrC       ; переместиться на следующий элемент массива
mov rax,[rbp]           ; запись из массива С в регистр RAX
mov res4,rax            ; запись из RAX в переменную res4

invoke wsprintf,ADDR buf1,ADDR txt1, res1, res2, res3, res4
invoke MessageBox,0,ADDR buf1,ADDR title1,MB_ICONINFORMATION
invoke ExitProcess,0

entry_point endp        ; точка выхода
end