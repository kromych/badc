
overaligned_automatic.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	andq	$-0x40, %rsp
               	leaq	(%rsp), %rax
               	movq	%rax, %rdx
               	andq	$0x3f, %rdx
               	leaq	0x60(%rsp), %rcx
               	movq	%rcx, %rsi
               	andq	$0x1f, %rsi
               	orq	%rdx, %rsi
               	leaq	0x40(%rsp), %rdi
               	andq	$0x3f, %rdi
               	orq	%rsi, %rdi
               	leaq	0x80(%rsp), %rsi
               	movq	%rsi, %r8
               	andq	$0x1f, %r8
               	orq	%r8, %rdi
               	testl	%edi, %edi
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	(%rbp), %rsp
               	popq	%rbp
               	retq
               	movb	$0xb, (%rax)
               	movl	$0x16, 0xc(%rcx)
               	movq	$0x21, 0x40(%rsp)
               	movl	$0x2c, (%rsi)
               	movsbq	(%rax), %rax
               	cmpl	$0xb, %eax
               	jne	<addr>
               	movslq	0xc(%rcx), %rax
               	cmpl	$0x16, %eax
               	jne	<addr>
               	movq	0x40(%rsp), %rax
               	cmpq	$0x21, %rax
               	jne	<addr>
               	leaq	0x40(%rsp), %rax
               	andq	$0x3f, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leaq	(%rbp), %rsp
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	leaq	(%rbp), %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	leaq	(%rbp), %rsp
               	popq	%rbp
               	retq
