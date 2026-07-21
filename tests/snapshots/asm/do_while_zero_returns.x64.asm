
do_while_zero_returns.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<from_value>:
               	movslq	%edi, %rdi
               	testq	%rdi, %rdi
               	jge	<addr>
               	imulq	$-0x1, %rdi, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<classify>:
               	movslq	%edi, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	xorq	%rax, %rax
               	retq
               	testq	%rdi, %rdi
               	jle	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	retq
               	movabsq	$-0x1, %rax
               	jmp	<addr>

<main>:
               	movl	$0x2a, %eax
               	movl	$0x5, %eax
               	xorq	%rax, %rax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	movabsq	$-0x1, %rax
               	movabsq	$-0x1, %rax
               	xorq	%rax, %rax
               	retq
