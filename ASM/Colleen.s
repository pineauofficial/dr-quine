section .data ; plutot pour variable qui ne bougerons pas ?
    mode_r  db "r", 0 ; mode lecture pour fopen
    filename db __FILE__, 0

section .bss ; plutot pour variable non init ?
    file_ptr resq 1
    result resd 1

section .text
    extern fopen
    extern fclose
    extern getc
    extern putchar
    global main

main:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov dword [rbp-4], 1
    mov dword [rbp-8], 2
    mov dword [rbp-12], 0

    mov rdi, filename
    mov rsi, mode_r
    call fopen
    mov [file_ptr], rax ; sauvgarde du ptr

.boucle:
    mov rdi, [file_ptr]
    call getc

    cmp eax, -1
    je .suite

    mov edi, eax ; edi pour etre raccord avec eax (utile?)
    call putchar
    
    jmp .boucle

.suite:
    mov rdi, [file_ptr]
    call fclose
    mov eax, [rbp-4]
    add eax, [rbp-8]
    mov [result], eax

.epilogue:
    xor eax, eax
    leave
    ret
