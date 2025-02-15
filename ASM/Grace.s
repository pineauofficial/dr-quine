; 1-st comment - linebreak: 10, quote: 34, flags: O_WRONLY 0x0001 | O_TRUNC 0x1000 | O_CREAT 0x0100, mode: rw-rw-r--

    %macro MACROS_1_STARTALL 1

        section .data
        flags: dd 1101               ; Flags pour l'ouverture du fichier
        mode: dd 110110100b          ; Permissions du fichier (rw-rw-r--)
        STR
        name: %1
        
        section .text
        global main
        extern dprintf
        
        main:
        push rbp
        mov rbp, rsp
        
        system_call_open_#2:
        mov rax, 2                   ; syscall 2 = open
        mov rdi, name                ; nom du fichier
        mov rsi, [flags]            ; flags: O_WRONLY | O_TRUNC | O_CREAT
        mov rdx, [mode]             ; permissions
        syscall
        
        extern_call_dprintf:
        mov rdi, rax                ; file descriptor
        mov rsi, str                ; pointeur vers la chaîne à écrire
        mov rdx, str                ; même pointeur (format string)
        mov rcx, 10                 ; linebreak (\n)
        mov r8, 34                  ; quote (")
        call dprintf                ; appel à dprintf pour écrire
        
        system_call_close_#3:
        mov rdi, rax
        mov rax, 3                  ; syscall 3 = close
        syscall
        
        system_call_chmod_#90:
        mov rax, 90                 ; syscall 90 = chmod
        mov rdi, name               ; nom du fichier
        mov rsi, 100100100b        ; permissions (444 en octal)
        syscall
        
        mov rax, 0
        leave
        ret
        
        %endmacro
        
        %define STR			str: db "; 1-st comment - linebreak: 10, quote: 34, flags: O_WRONLY 0x0001 | O_TRUNC 0x1000 | O_CREAT 0x0100, mode: rw-rw-r--%2$c%2$c%%macro MACROS_1_STARTALL 1%2$c%2$csection .data%2$cflags: dd 1101%2$cmode: dd 110110100b%2$cSTR%2$cname: %%1%2$c%2$csection .text%2$cglobal main%2$cextern dprintf%2$c%2$cmain:%2$cpush rbp%2$cmov rbp, rsp%2$c%2$csystem_call_open_#2:%2$cmov rax, 2%2$cmov rdi, name%2$cmov rsi, [ flags ]%2$cmov rdx, [ mode ]%2$csyscall%2$c%2$cextern_call_dprintf:%2$cmov rdi, rax ; fd%2$cmov rsi, str%2$cmov rdx, str%2$cmov rcx, 10%2$cmov r8,  34%2$ccall dprintf%2$c%2$csystem_call_close_#3:%2$cmov rdi, rax%2$cmov rax, 3%2$csyscall%2$c%2$csystem_call_chmod_#90:%2$cmov rax, 90%2$cmov rdi, name%2$cmov rsi, 100100100b%2$csyscall%2$c%2$cmov rax, 0%2$cleave%2$cret%2$c%2$c%%endmacro%2$c%2$c%%define STR			str: db %3$c%1$s%3$c, 0%2$c%%define FILENAME	{db %3$cGrace_kid.s%3$c, 0}%2$c%2$cMACROS_1_STARTALL FILENAME", 0
        %define FILENAME	{db "Grace_kid.s", 0}
        
        MACROS_1_STARTALL FILENAME