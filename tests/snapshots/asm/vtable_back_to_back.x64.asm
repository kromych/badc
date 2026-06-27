
vtable_back_to_back.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<my_init>:
               	leaq	<rip>, %rax
               	movq	%rax, (%rdi)
               	leaq	(%rdx,%rcx), %rax
               	movl	%eax, 0x8(%rdi)
               	xorq	%rax, %rax
               	retq

<my_generate>:
               	movq	%rdx, %rax
               	movslq	%eax, %rax
               	movslq	0x8(%rdi), %rcx
               	movl	%ecx, (%rsi)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	-0x10(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x2a, %edx
               	movl	$0x8, %ecx
               	callq	*%rax
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	movq	0x8(%rax), %rax
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x1, %edx
               	callq	*%rax
               	leaq	<rip>, %rdi
               	movslq	-0x40(%rbp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	-0x40(%rbp), %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
