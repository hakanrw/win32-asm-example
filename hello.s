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
    .extern _MessageBoxA
    .extern _ExitProcess            # Import ExitProcess function from kernel32.dll
    .extern _GetStdHandle
    .extern _wsprintfA
    .extern _WriteConsoleA
    .global _start                 # Entry point

_start:
    push $0x00000002L                        # uType (MB_OK)
    push $title                     # lpCaption
    push $msg                       # lpText
    push $0                        # hWnd
    call _MessageBoxA
    movl %eax, %ebx

    push $-11
    call _GetStdHandle
    movl %eax, %edi

    push %ebx
    push $format
    push $buffer
    call _wsprintfA

    push $0
    push $0
    push $128
    push $buffer
    push %edi
    call _WriteConsoleA

    push $0
    push $0
    push $8

    cmp $3, %ebx
    je print_abort

    cmp $4, %ebx
    je print_retry

    cmp $5, %ebx
    je print_ignore

    push $unknown

print_abort:
    push $abort
    jmp print_call

print_retry:
    push $retry
    jmp print_call

print_ignore:
    push $ignore
    jmp print_call

print_call:
    push %edi
    call _WriteConsoleA      

exit:
    push $0                        # uExitCode
    call _ExitProcess
