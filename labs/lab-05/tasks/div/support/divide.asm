; SPDX-License-Identifier: BSD-3-Clause

%include "printf64.asm"

; https://en.wikibooks.org/wiki/X86_Assembly/Arithmetic

section .data
    dividend1 db 91
    divisor1 db 27
    dividend2 dd 67254
    divisor2 dw 1349
    dividend3 dq 69094148
    divisor3 dq 12345678
    dividend4 dq 0x00000000FFFFFFFF, 0x0000000000000000
    divisor4 dq 0x0000000000010000

section .text
extern printf
global main
main:
    push rbp
    mov rbp, rsp

    xor rax, rax

    mov al, byte [dividend1]
    mov bl, byte [divisor1]
    div bl

    xor rbx, rbx
    mov bl, al
    PRINTF64 `Quotient: %hhu\n\x0`, rbx

    xor rbx, rbx
    mov bl, ah
    PRINTF64 `Remainder: %hhu\n\x0`, rbx

    mov dx, word [dividend2 + 2]
    mov ax, word [dividend2]
    mov bx, word [divisor2]
    div bx
    PRINTF64 `Quotient: %hu\n\x0`, rax
    PRINTF64 `Remainder: %hu\n\x0`, rdx

    mov edx, dword [dividend3 + 4]
    mov eax, dword [dividend3]
    mov ebx, dword [divisor3]
    div ebx
    PRINTF64 `Quotient: %u\n\x0`, rax
    PRINTF64 `Remainder: %u\n\x0`, rdx

    mov rdx, qword [dividend4 + 8]
    mov rax, qword [dividend4]
    mov rbx, qword [divisor4]
    div rbx
    PRINTF64 `Quotient: %lu\n\x0`, rax
    PRINTF64 `Remainder: %lu\n\x0`, rdx

    leave
    ret
