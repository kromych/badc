
anon_member_designated_init.x64:	file format elf64-x86-64

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

<opaque>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	xorq	%rbx, %rbx
               	movl	%ebx, -0x70(%rbp)
               	movl	$0x7, %eax
               	movl	%eax, -0x88(%rbp)
               	movl	$0x10, %eax
               	movq	%rax, -0x80(%rbp)
               	leaq	-0x70(%rbp), %rax
               	movq	%rax, -0x78(%rbp)
               	movslq	-0x88(%rbp), %r12
               	movq	-0x78(%rbp), %r13
               	movq	-0x80(%rbp), %r14
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movq	%rbx, 0x10(%rax)
               	movl	%r12d, (%rax)
               	movq	%r13, 0x8(%rax)
               	leaq	-0x18(%rbp), %rdi
               	movq	%r14, 0x10(%rdi)
               	callq	<addr>
               	movslq	(%rax), %rcx
               	cmpl	%r12d, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	cmpq	%r13, %rcx
               	sete	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	0x10(%rax), %rax
               	cmpq	%r14, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rdi
               	xorq	%rax, %rax
               	movq	%rax, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movq	%rax, 0x10(%rdi)
               	movl	$0x3, %eax
               	movl	%eax, (%rdi)
               	leaq	-0x70(%rbp), %rax
               	movq	%rax, 0x8(%rdi)
               	movl	$0x8, %eax
               	movq	%rax, 0x10(%rdi)
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	(%rcx), %rax
               	cmpl	$0x3, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	movq	0x8(%rcx), %rax
               	leaq	-0x70(%rbp), %rdx
               	cmpq	%rdx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x10(%rcx), %rax
               	cmpq	$0x8, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x50(%rbp), %rdi
               	xorq	%rax, %rax
               	movq	%rax, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movq	%rax, 0x10(%rdi)
               	movq	%rax, 0x18(%rdi)
               	movl	$0x5, %eax
               	movl	%eax, (%rdi)
               	leaq	-0x70(%rbp), %rax
               	movq	%rax, 0x8(%rdi)
               	movl	$0x4, %eax
               	movq	%rax, 0x10(%rdi)
               	movl	$0x9, %eax
               	movl	%eax, 0x18(%rdi)
               	callq	<addr>
               	movslq	(%rax), %rcx
               	cmpl	$0x5, %ecx
               	movl	$0x1, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rdx
               	leaq	-0x70(%rbp), %rsi
               	cmpq	%rsi, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	0x10(%rax), %rcx
               	cmpq	$0x4, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x18(%rax), %rax
               	cmpl	$0x9, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	(%rcx), %rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x8(%rcx), %rax
               	cmpq	$0x2a, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
