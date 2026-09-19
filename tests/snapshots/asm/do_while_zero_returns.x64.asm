
do_while_zero_returns.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
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

<from_value>:
               	testl	%edi, %edi
               	jge	<addr>
               	imulq	$-0x1, %rdi, %rax
               	movslq	%eax, %rax
               	retq
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<classify>:
               	movslq	%edi, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	xorq	%rax, %rax
               	retq
               	testl	%edi, %edi
               	jle	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	retq
               	movabsq	$-0x1, %rax
               	jmp	<addr>

<main>:
               	xorq	%rax, %rax
               	retq
