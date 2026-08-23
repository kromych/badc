
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
               	leaq	(%rsp), %rax
               	movq	%rax, %rdx
               	andq	$0x3f, %rdx
               	leaq	0x60(%rsp), %rcx
               	movq	%rcx, %rsi
               	andq	$0x1f, %rsi
               	orq	%rsi, %rdx
               	leaq	0x40(%rsp), %rsi
               	andq	$0x3f, %rsi
               	orq	%rdx, %rsi
               	leaq	0x80(%rsp), %rdx
               	movq	%rdx, %rdi
               	andq	$0x1f, %rdi
               	orq	%rdi, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0xa0(%rbp), %rsp
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xb, %esi
               	movb	%sil, (%rax)
               	movl	$0x16, %esi
               	movl	%esi, 0xc(%rcx)
               	movl	$0x21, %esi
               	movq	%rsi, 0x40(%rsp)
               	movl	$0x2c, %esi
               	movl	%esi, (%rdx)
               	movsbq	(%rax), %rax
               	cmpl	$0xb, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	movslq	0xc(%rcx), %rcx
               	cmpl	$0x16, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x40(%rsp), %rax
               	cmpq	$0x21, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	(%rdx), %rax
               	cmpl	$0x2c, %eax
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
               	movq	%rax, %rcx
               	jmp	<addr>
