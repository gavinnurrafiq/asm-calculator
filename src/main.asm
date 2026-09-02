bits 64
default rel

extern printf
extern scanf

extern add_numbers
extern sub_numbers
extern mul_numbers
extern div_numbers

global main


section .data

    title db 10, "==============================", 10
          db "      x86-64 ASM Calculator", 10
          db "==============================", 10, 0

    prompt_a db "Enter first number : ", 0
    prompt_op db "Enter operator (+ - * /): ", 0
    prompt_b db "Enter second number: ", 0

    input_number db "%lld", 0
    input_char   db " %c", 0

    result_msg db "Result: %lld", 10, 0

    error_divzero db "Error: division by zero.", 10, 0
    error_operator db "Error: unknown operator.", 10, 0


section .bss

    number_a resq 1
    number_b resq 1
    operator resb 1


section .text

main:
    sub rsp, 40

    lea rcx, [title]
    call printf

    lea rcx, [prompt_a]
    call printf

    lea rcx, [input_number]
    lea rdx, [number_a]
    call scanf

    lea rcx, [prompt_op]
    call printf

    lea rcx, [input_char]
    lea rdx, [operator]
    call scanf

    lea rcx, [prompt_b]
    call printf

    lea rcx, [input_number]
    lea rdx, [number_b]
    call scanf

    mov al, [operator]

    cmp al, '+'
    je .addition

    cmp al, '-'
    je .subtraction

    cmp al, '*'
    je .multiplication

    cmp al, '/'
    je .division

    jmp .invalid_operator

.addition:
    mov rcx, [number_a]
    mov rdx, [number_b]
    call add_numbers
    jmp .print_result

.subtraction:
    mov rcx, [number_a]
    mov rdx, [number_b]
    call sub_numbers
    jmp .print_result

.multiplication:
    mov rcx, [number_a]
    mov rdx, [number_b]
    call mul_numbers
    jmp .print_result

.division:
    cmp qword [number_b], 0
    je .division_zero

    mov rcx, [number_a]
    mov rdx, [number_b]
    call div_numbers
    jmp .print_result

.print_result:
    mov rdx, rax
    lea rcx, [result_msg]
    call printf
    xor eax, eax
    add rsp, 40
    ret

.division_zero:
    lea rcx, [error_divzero]
    call printf
    mov eax, 1
    add rsp, 40
    ret

.invalid_operator:
    lea rcx, [error_operator]
    call printf
    mov eax, 1
    add rsp, 40
    ret