; SPDX-License-Identifier: BSD-3-Clause

%include "printf64.asm"

%define ARRAY_SIZE    10

section .data
    byte_array db 8, 19, 12, 3, 6, 200, 128, 19, 78, 102
    word_array dw 1893, 9773, 892, 891, 3921, 8929, 7299, 720, 2590, 28891
    dword_array dd 1392, 12544, 7992, 6992, 7202, 27187, 28789, 17897, 12988, 17992
    qword_array dq 1392849893, 1254400000, 8799230000, 8799279000, 7202277000, 9718720000, 2878929200, 1789789200, 1298800000, 8799201000
    big_qword_array dq 9223372036854775800, 8223372036854775800, 7223372036854775800

section .text
extern printf
global main
main:
    push rbp
    mov rbp, rsp

    ; Byte array sum
    mov rcx, ARRAY_SIZE     ; Use rcx as loop counter
    xor rax, rax            ; Use rax to store the sum
    xor rdx, rdx            ; Store current value in dl; zero entire rdx

add_byte_array_element:
    mov dl, byte [byte_array + rcx - 1]
    add rax, rdx
    loop add_byte_array_element

    PRINTF64 `Byte array sum: %u\n\x0`, rax

    mov rcx, ARRAY_SIZE
    xor rax, rax
    xor rdx, rdx

add_word_array_element:
    mov dx, word [word_array + (rcx - 1) * 2]
    add rax, rdx
    loop add_word_array_element

    PRINTF64 `Word array sum: %u\n\x0`, rax
    mov rcx, ARRAY_SIZE
    xor rax, rax
    xor rdx, rdx

add_dword_array_element:
    mov edx, dword [dword_array + (rcx - 1) * 4]
    add rax, rdx
    loop add_dword_array_element

    PRINTF64 `Dword array sum: %u\n\x0`, rax
    mov rcx, ARRAY_SIZE
    xor rax, rax
    xor rdx, rdx

add_qword_array_element:
    mov rdx, qword [qword_array + (rcx - 1) * 8]
    add rax, rdx
    loop add_qword_array_element

    PRINTF64 `Qword array sum: %lu\n\x0`, rax
    mov rcx, ARRAY_SIZE
    xor rax, rax
    xor rdx, rdx

    xor r8, r8

add_big_qword_array_element:
    mov rdx, qword [big_qword_array + (rcx - 1) * 8]
    add rax, rdx
    jo big_sum_carry
big_sum_continue:
    loop add_big_qword_array_element
    PRINTF64 `128-bit addition example: 0x%lx%016lx\n\x0`, r8, rax
    jmp end

big_sum_carry:
    inc r8
    jmp big_sum_continue

end:
    leave
    ret
