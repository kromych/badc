
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
               	subq	$0xa0, %rsp
               	subq	$0xc0, %rsp
               	andq	$-0x40, %rsp
               	leaq	(%rsp), %rcx
               	movq	%rcx, %rdx
               	andq	$0x3f, %rdx
               	leaq	0x60(%rsp), %rax
               	movq	%rax, %rsi
               	andq	$0x1f, %rsi
               	orq	%rdx, %rsi
               	leaq	0x40(%rsp), %rdi
               	andq	$0x3f, %rdi
               	orq	%rsi, %rdi
               	leaq	0x80(%rsp), %rsi
               	movq	%rsi, %r8
               	andq	$0x1f, %r8
               	orq	%r8, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0xa0(%rbp), %rsp
               	leave
               	retq
               	movl	$0xb, %edi
               	movb	%dil, (%rcx)
               	movl	$0x16, %edi
               	movl	%edi, 0xc(%rax)
               	movl	$0x21, %edi
               	movq	%rdi, 0x40(%rsp)
               	movl	$0x2c, %edi
               	movl	%edi, (%rsi)
               	movsbq	(%rcx), %rsi
               	cmpl	$0xb, %esi
               	jne	<addr>
               	movslq	0xc(%rax), %rax
               	cmpl	$0x16, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x40(%rsp), %rax
               	cmpq	$0x21, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	leaq	0x40(%rsp), %rcx
               	andq	$0x3f, %rcx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	leaq	-0xa0(%rbp), %rsp
               	leave
               	retq
               	leaq	-0xa0(%rbp), %rsp
               	leave
               	retq
               	movl	$0x2, %eax
               	leaq	-0xa0(%rbp), %rsp
               	leave
               	retq
