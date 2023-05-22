;/* Usage: nasm -f (for file) elf64 (its 64 bit binary) calculator.asm(the file name) -o (for the outpur) calculator.o (the object file ) */

  ;/* ld calculator.o (object file) -o (for the output) calculator */




%include "util.asm"
global _start   ; from here the codes starts
section .text ; all the code writtem is under section .text section
_start:
      mov rdi,num1  ; we are putting num1 variable in rdi register
      call printstr ; this function simply print the value which is stored in num1
      call readint  ;  this function get integers input from the user
      mov [user_num1],rax ; the user first input is stored in rax register
      mov rdi,num2
      call printstr
      call readint
      mov [user_num2],rax
      mov rdi,operators
      call printstr
      mov rdi,user_operator ; the user chosen operator are stored in rdi register
      mov rsi,2
      call readstr

cmp:  ; this function is used to compare 2 registers

      mov rdi,[user_operator] ; putting the value of user_operator in rdi register
      cmp rdi,43 ;+ ; 43 is asci code for + if rdi = + 
      je addition ; then if it is equal it will jump to addition
      cmp rdi,45 ;- ; 45 is asci value for minus -
      je substraction
      cmp rdi,42 ;*  ; 42 is asci value for multiply *
      je multiply
      cmp rdi,47 ;/  ; 47 is asci value for division /
      je division

exception:  ; if the user choose any other operator the code will jump to exception block

          mov rdi,error_msg  ; we are putting the value of error_msg to rdi register
          call printstr ; then printing this to the screen
          call endl ; ending that line
          call exit0  ; exit0 is used  to exit the program
addition:
         
         mov rdi,[user_num1] ; putting user_first input in rdi register
         add rdi,[user_num2] ; adding rdi with the second input from the user
         call results  ; then we are jumping to the results function
         



substraction:
         
          mov rdi,[user_num1] ; Same as here as the addition function
          sub rdi,[user_num2]
          call results



multiply:

          mov rdi,[user_num1] ;same we are putting first input in rdi
          imul rdi,[user_num2] ; multiply rdi with 2_input and the result will be stored in rdi
          call results


division:

        mov rdx,0 
        ;/*we have to set the value of rdx to zero in division because when user puts the first value it will be added in rax register and by default the rdx value will be added to this e.g the user adds 10 in rax register and want to divide it with 2 and the rdx register has the value of 1 then this will be considered as 110 not 10 */

        mov rax,[user_num1]
        ;/*in division we have to specify both  registers whats the first value it will be stored in rax register then calling the second value then telling the program to divide the second value by first the results will be stored in rax register*/

        mov rbx,[user_num2]
        idiv rbx
        mov rdi,rax 
        ;/* we are moving the results from the rax register to rdi register and then jumping to results function */
        call results

results:

        call printint
        call endl
        call exit0


section .data  ; all the variables which value we know are stored in section .data

  num1: db "Enter Number 1  ",0
  num2: db "Enter Number 2  ",0
  operators: db "Enter Operations to Perform(  +,  -,  *,  /  )",0
  error_msg: db "Can not Perform This Operation",0







section .bss   ; user input stored in section .bss  

user_num1: resb 8
user_num2: resb 8
user_operator: resb 2
