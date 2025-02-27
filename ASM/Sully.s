section .data
    filename db "Sully_%d.s", 0
    mode db "w", 0
    source db "section .data%1$c    filename db %2$cSully_%%d.s%2$c, 0%1$c    mode db %2$cw%2$c, 0%1$c    source db %2$c%3$s%2$c, 0%1$c    x dd %4$d%1$c%1$csection .bss%1$c    filename_buf resb 30%1$c%1$csection .text%1$c    global main%1$c    extern printf%1$c    extern sprintf%1$c    extern fopen%1$c    extern fprintf%1$c    extern fclose%1$c%1$cmain:%1$c    ; init%1$c    xor rax, rax%1$c    push rbp%1$c    mov rbp, rsp%1$c    sub rsp, 32%1$c%1$c    ; check et x--%1$c    mov eax, [x]%1$c    dec eax%1$c    cmp eax, -1%1$c    jl end%1$c    mov [x], eax%1$c%1$c    ; met en place le nom du fichier%1$c    mov rdi, filename_buf ; buffer dest%1$c    mov rsi, filename ; format string%1$c    mov edx, [x] ; x%1$c    xor rax, rax%1$c    call sprintf%1$c%1$c    ; ouvre le ficher%1$c    mov rdi, filename_buf%1$c    mov rsi, mode%1$c    xor rax, rax%1$c    call fopen%1$c    mov rbx, rax ; sauvegarde%1$c%1$c    ; ecrit dans le fichier%1$c    mov rdi, rbx%1$c    mov rsi, source%1$c    mov rdx, 10 ; %%1$c ->newline%1$c    mov rcx, 34 ; %%2$c -> quote%1$c    mov r8, source ; %%3$s -> source%1$c    mov r9, [x] ; %%4$d -> x%1$c    xor rax, rax%1$c    call fprintf%1$c%1$c    ; close le fichier%1$c    mov rdi, rbx%1$c    call fclose%1$c%1$cend:%1$c    mov rsp, rbp%1$c    pop rbp%1$c    xor eax, eax%1$c    ret", 0
    x dd 5

section .bss
    filename_buf resb 30

section .text
    global main
    extern printf
    extern sprintf
    extern fopen
    extern fprintf
    extern fclose

main:
    ; init
    xor rax, rax
    push rbp
    mov rbp, rsp
    sub rsp, 32

    ; check et x--
    mov eax, [x]
    dec eax
    cmp eax, -1
    jl end
    mov [x], eax

    ; met en place le nom du fichier
    mov rdi, filename_buf ; buffer dest
    mov rsi, filename ; format string
    mov edx, [x] ; x
    xor rax, rax
    call sprintf

    ; ouvre le ficher
    mov rdi, filename_buf
    mov rsi, mode
    xor rax, rax
    call fopen
    mov rbx, rax ; sauvegarde

    ; ecrit dans le fichier
    mov rdi, rbx
    mov rsi, source
    mov rdx, 10 ; %1$c ->newline
    mov rcx, 34 ; %2$c -> quote
    mov r8, source ; %3$s -> source
    mov r9, [x] ; %4$d -> x
    xor rax, rax
    call fprintf

    ; close le fichier
    mov rdi, rbx
    call fclose

end:
    mov rsp, rbp
    pop rbp
    xor eax, eax
    ret