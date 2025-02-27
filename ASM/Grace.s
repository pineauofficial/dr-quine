%define FILE "Grace_kid.s"
%define CODE "%%define FILE %3$cGrace_kid.s%3$c%1$c%%define CODE %3$c%4$s%3$c%1$c%%define FONCTION main%1$c%1$cextern fprintf%1$cextern fopen%1$cextern fclose%1$c; commentaire%1$csection .data%1$c%2$ccode db CODE, 0%1$c%2$cfile db FILE, 0%1$c%2$cmode db %3$cw%3$c, 0%1$c%2$cfile_ptr db 0%1$c%1$csection .text%1$c%2$cglobal FONCTION%1$c%1$cFONCTION:%1$c%2$cpush rbp%1$c%2$cmov rbp, rsp%1$c%1$c%2$cmov rdi, file%1$c%2$cmov rsi, mode%1$c%2$ccall fopen%1$c%1$c%2$cmov [file_ptr], rax%1$c%1$c%2$cmov rdi, [file_ptr]%1$c%2$cmov rsi, code%1$c%2$cmov rdx, 10%1$c%2$cmov rcx, 9%1$c%2$cmov r8, 0x22%1$c%2$cmov r9, code%1$c%2$ccall fprintf%1$c%1$c%2$cmov rdi, [file_ptr]%1$c%2$ccall fclose%1$c%1$c%2$cleave%1$c%2$cret"
%define FONCTION main

extern fprintf
extern fopen
extern fclose
; commentaire
section .data
	code db CODE, 0
	file db FILE, 0
	mode db "w", 0
	file_ptr db 0

section .text
	global FONCTION

FONCTION:
	push rbp
	mov rbp, rsp

	mov rdi, file
	mov rsi, mode
	call fopen

	mov [file_ptr], rax

	mov rdi, [file_ptr]
	mov rsi, code
	mov rdx, 10
	mov rcx, 9
	mov r8, 0x22
	mov r9, code
	call fprintf

	mov rdi, [file_ptr]
	call fclose

	leave
	ret