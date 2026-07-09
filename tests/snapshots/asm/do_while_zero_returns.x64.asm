
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
               	testq	%rdi, %rdi
               	jle	<addr>
               	movl	$0x1, %eax
               	retq
               	movabsq	$-0x1, %rax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x29, %edi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movabsq	$-0x5, %rdi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x9, %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movabsq	$-0x9, %rdi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
