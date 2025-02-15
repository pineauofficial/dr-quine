section .data
    filename db "Sully_%d.s", 0
    mode db "w", 0
    source db "section .data%1$c    filename db %2$cSully_%%d.s%2$c, 0%1$c    mode db %2$cw%2$c, 0%1$c    source db %2$c%3$s%2$c, 0%1$c    x dd %4$d%1$c%1$csection .text%1$c    global main%1$c    extern printf%1$c    extern sprintf%1$c    extern fopen%1$c    extern fprintf%1$c    extern fclose%1$c%1$cmain:%1$c    push rbp%1$c    mov rbp, rsp%1$c%1$c    ; Décrémente x%1$c    mov eax, [x]%1$c    dec eax%1$c%1$c    ; Si x <= 0, on arrête%1$c    cmp eax, 0%1$c    jl end%1$c%1$c    ; Prépare le nom du fichier%1$c    sub rsp, 32%1$c    lea rdi, [rsp]%1$c    lea rsi, [filename]%1$c    mov edx, eax%1$c    xor eax, eax%1$c    call sprintf%1$c%1$c    ; Ouvre le fichier%1$c    lea rdi, [rsp]%1$c    lea rsi, [mode]%1$c    call fopen%1$c    mov rbx, rax%1$c%1$c    ; Écrit dans le fichier%1$c    mov rdi, rbx%1$c    lea rsi, [source]%1$c    mov edx, 10     ; newline%1$c    mov ecx, 34     ; quote%1$c    lea r8, [source]%1$c    mov r9d, [x]%1$c    dec r9d%1$c    call fprintf%1$c%1$c    ; Ferme le fichier%1$c    mov rdi, rbx%1$c    call fclose%1$c%1$c    add rsp, 32%1$c%1$cend:%1$c    mov rsp, rbp%1$c    pop rbp%1$c    xor eax, eax%1$c    ret%1$c%1$csection .bss", 0
    x dd 5

section .text
    global main
    extern printf
    extern sprintf
    extern fopen
    extern fprintf
    extern fclose

main:
    push rbp
    mov rbp, rsp

    ; Décrémente x
    mov eax, [x]
    dec eax

    ; Si x <= 0, on arrête
    cmp eax, 0
    jl end

    ; Prépare le nom du fichier
    sub rsp, 32
    lea rdi, [rsp]
    lea rsi, [filename]
    mov edx, eax
    xor eax, eax
    call sprintf

    ; Ouvre le fichier
    lea rdi, [rsp]
    lea rsi, [mode]
    call fopen
    mov rbx, rax

    ; Écrit dans le fichier
    mov rdi, rbx
    lea rsi, [source]
    mov edx, 10     ; newline
    mov ecx, 34     ; quote
    lea r8, [source]
    mov r9d, [x]
    dec r9d
    call fprintf

    ; Ferme le fichier
    mov rdi, rbx
    call fclose

    add rsp, 32

end:
    mov rsp, rbp
    pop rbp
    xor eax, eax
    ret

section .bss