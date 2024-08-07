.section .rodata
    msg: .asciz "Hello, World!"
    title: .asciz "Message"
    format: .asciz "MessageBoxA returned %d: "
    abort: .asciz  "Abort  \n"
    retry: .asciz  "Retry  \n"
    ignore: .asciz "Ignore \n"
    unknown: .asciz "Unknown\n"

.section .data
    buffer: .space 128

.section .text
    .extern MessageBoxA
    .extern ExitProcess
    .extern GetStdHandle
    .extern wsprintfA
    .extern WriteConsoleA
    .global _start

_start:
    sub $0x28, %rsp

    mov $0x00000002L, %r9             # uType (MB_OK)
    mov $title, %r8                   # lpCaption
    mov $msg, %rdx                    # lpText
    mov $0, %rcx                      # hWnd
    call MessageBoxA

    mov %rax, %rbx

    mov $-11, %rcx
    call GetStdHandle
    mov %rax, %rdi

    mov %rbx, %r8
    mov $format, %rdx
    mov $buffer, %rcx
    call wsprintfA

    push $0
    mov $0, %r9
    mov $128, %r8
    mov $buffer, %rdx
    mov %rdi, %rcx
    call WriteConsoleA

    push $0
    mov $0, %r9
    mov $8, %r8

    cmp $3, %rbx
    je print_abort

    cmp $4, %rbx
    je print_retry

    cmp $5, %rbx
    je print_ignore

    mov $unknown, %rdx
    jmp print_call

print_abort:
    mov $abort, %rdx
    jmp print_call

print_retry:
    mov $retry, %rdx
    jmp print_call

print_ignore:
    mov $ignore, %rdx
    jmp print_call

print_call:
    mov %rdi, %rcx
    call WriteConsoleA

exit:
    mov $0, %rcx                        # uExitCode
    call ExitProcess
    hlt
