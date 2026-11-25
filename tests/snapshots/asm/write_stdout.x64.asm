
write_stdout.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	pushq	%rax
               	movl	$0x4, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	movl	$0xa6968, (%rsi)        # imm = 0xA6968
               	movl	$0x1, %edi
               	movl	$0x3, %edx
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%r11
               	retq
