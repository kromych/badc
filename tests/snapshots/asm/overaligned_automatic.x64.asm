
overaligned_automatic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	andq	$-0x40, %rsp
               	subq	$0xc0, %rsp
               	leaq	(%rsp), %rax
               	andq	$0x3f, %rax
               	leaq	0x60(%rsp), %rcx
               	andq	$0x1f, %rcx
               	orq	%rcx, %rax
               	leaq	0x40(%rsp), %rcx
               	andq	$0x3f, %rcx
               	orq	%rcx, %rax
               	leaq	0x80(%rsp), %rcx
               	andq	$0x1f, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0xa0(%rbp), %rsp
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	(%rsp), %rax
               	movl	$0xb, %ecx
               	movb	%cl, (%rax)
               	leaq	0x60(%rsp), %rax
               	movl	$0x16, %ecx
               	movl	%ecx, 0xc(%rax)
               	movl	$0x21, %eax
               	movq	%rax, 0x40(%rsp)
               	leaq	0x80(%rsp), %rax
               	movl	$0x2c, %ecx
               	movl	%ecx, (%rax)
               	leaq	(%rsp), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0xb, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x60(%rsp), %rax
               	movslq	0xc(%rax), %rax
               	cmpq	$0x16, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x40(%rsp), %rax
               	cmpq	$0x21, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x80(%rsp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leaq	-0xa0(%rbp), %rsp
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	(%rsp), %rax
               	andq	$0x3f, %rax
               	leaq	0x40(%rsp), %rcx
               	andq	$0x3f, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leaq	-0xa0(%rbp), %rsp
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	leaq	-0xa0(%rbp), %rsp
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
