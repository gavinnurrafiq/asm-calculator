bits 64

section .text

global add_numbers
global sub_numbers
global mul_numbers
global div_numbers

add_numbers:
    mov rax, rcx
    add rax, rdx
    ret

sub_numbers:
    mov rax, rcx
    sub rax, rdx
    ret

mul_numbers:
    mov rax, rcx
    imul rax, rdx
    ret

div_numbers:
    mov r8, rdx
    mov rax, rcx
    cqo
    idiv r8
    ret