
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
               	xorq	%rax, %rax
               	movl	%eax, -0x88(%rbp)
               	movl	$0x7, %eax
               	movl	%eax, -0x80(%rbp)
               	movl	$0x10, %eax
               	movq	%rax, -0x78(%rbp)
               	leaq	-0x88(%rbp), %rax
               	movq	%rax, -0x70(%rbp)
               	movslq	-0x80(%rbp), %r12
               	movq	-0x70(%rbp), %r13
               	movq	-0x78(%rbp), %r14
               	leaq	-0x18(%rbp), %rax
               	xorq	%rbx, %rbx
               	movq	%rbx, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movq	%rbx, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	%r12d, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%r13, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%r14, 0x10(%rax)
               	leaq	-0x18(%rbp), %rdi
               	callq	<addr>
               	movslq	(%rax), %rcx
               	cmpq	%r12, %rcx
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
               	leaq	-0x68(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movl	$0x3, %eax
               	leaq	-0x68(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x88(%rbp), %rcx
               	leaq	-0x68(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	movl	$0x8, %ecx
               	leaq	-0x68(%rbp), %rax
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x68(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0x3, %rax
               	movl	$0x1, %eax
               	jne	<addr>
               	movq	0x8(%rcx), %rax
               	leaq	-0x88(%rbp), %rdx
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
               	leaq	-0x50(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movl	$0x5, %eax
               	leaq	-0x50(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x88(%rbp), %rcx
               	leaq	-0x50(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	movl	$0x4, %ecx
               	leaq	-0x50(%rbp), %rax
               	movq	%rcx, 0x10(%rax)
               	movl	$0x9, %ecx
               	leaq	-0x50(%rbp), %rax
               	movl	%ecx, 0x18(%rax)
               	leaq	-0x50(%rbp), %rdi
               	callq	<addr>
               	movslq	(%rax), %rcx
               	cmpq	$0x5, %rcx
               	movl	$0x1, %edx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	leaq	-0x88(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	0x10(%rax), %rcx
               	cmpq	$0x4, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x18(%rax), %rax
               	cmpq	$0x9, %rax
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
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	popq	%rdx
               	leaq	-0x30(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0x1, %rax
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
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
