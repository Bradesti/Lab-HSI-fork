; SPDX-License-Identifier: BSD-3-Clause

%include "printf64.asm"

section .data
    FIRST_SET: dq 139   ; The first set
    SECOND_SET: dq 169  ; The second set

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp

    ; The two sets can be found in the FIRST_SET and SECOND_SET variables
    mov rax, QWORD [FIRST_SET]
    mov rbx, QWORD [SECOND_SET]
    PRINTF64 `%u\n\x0`, rax ; print the first set
    PRINTF64 `%u\n\x0`, rbx ; print the second set

    xor rcx, rcx
    add rcx, rax
    or rcx, rbx
    PRINTF64 `%u\n\x0`, rcx


    add rax, 768
    PRINTF64 `%u\n\x0`, rax


    xor rcx, rcx
    add rcx, rax
    and rcx, rbx
    PRINTF64 `%u\n\x0`, rcx


    xor rcx, rcx
    add rcx, rax
    not rcx
    PRINTF64 `%u\n\x0`, rcx


    sub rax, 256
    PRINTF64 `%u\n\x0`, rax


    xor rcx, rcx
    add rcx, rax
    or rcx, rbx
    sub rcx, rbx
    PRINTF64 `%u\n\x0`, rcx

    xor rax, rax

    leave
    ret
