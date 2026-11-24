
memset_mcmp.x64:	file format elf64-x86-64

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
               	movl	$0x5, %edi
               	callq	<addr>
               	movl	$0x41414141, (%rax)     # imm = 0x41414141
               	movb	$0x0, 0x4(%rax)
               	movl	$0x2a, %eax
               	popq	%r11
               	retq
