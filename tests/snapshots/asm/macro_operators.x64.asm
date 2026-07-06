
macro_operators.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sum>:
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rcx
               	cmpq	$0x68, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movsbq	0x1(%rax), %rcx
               	cmpq	$0x65, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movsbq	0x2(%rax), %rcx
               	cmpq	$0x6c, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movsbq	0x3(%rax), %rcx
               	cmpq	$0x6c, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movsbq	0x4(%rax), %rcx
               	cmpq	$0x6f, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movsbq	0x5(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x7, %esi
               	movl	$0x8, %edx
               	movl	$0x9, %ecx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
