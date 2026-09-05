
runtime_anon_struct_init.x64:	file format elf64-x86-64

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
               	leave
               	retq

<check_anon_struct>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%rdi, %r13
               	movq	%rsi, %r14
               	leaq	-0x40(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movl	$0x1, %r12d
               	movl	%r12d, (%rax)
               	movq	%r13, 0x8(%rax)
               	movq	%r14, 0x10(%rax)
               	movl	$0x7, %edx
               	leaq	-0x40(%rbp), %rax
               	movl	%edx, 0x18(%rax)
               	leaq	-0x20(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movl	$0x2, %ecx
               	movl	%ecx, (%rax)
               	movq	%r13, 0x8(%rax)
               	movq	%r14, 0x10(%rax)
               	movl	$0x8, %ecx
               	leaq	-0x20(%rbp), %rax
               	movl	%ecx, 0x18(%rax)
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	movslq	(%rbx), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movq	0x8(%rbx), %rcx
               	cmpq	%r13, %rcx
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movl	$0x1, %edx
               	testq	%r12, %r12
               	jne	<addr>
               	movq	0x10(%rbx), %rcx
               	cmpq	%r14, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x18(%rbx), %rcx
               	cmpl	$0x7, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	%rdx, %rax
               	leave
               	retq
               	movslq	(%rax), %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	cmpq	%r13, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	0x10(%rax), %rcx
               	cmpq	%r14, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x18(%rax), %rax
               	cmpl	$0x8, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>

<check_nested>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%rdi, %r12
               	movq	%rsi, %r13
               	leaq	-0x28(%rbp), %rax
               	xorq	%rbx, %rbx
               	movq	%rbx, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movq	%rbx, 0x10(%rax)
               	movq	%rbx, 0x18(%rax)
               	movq	%rbx, 0x20(%rax)
               	movl	$0x9, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x4, %ecx
               	movl	%ecx, 0x8(%rax)
               	movq	%r12, 0x10(%rax)
               	leaq	-0x28(%rbp), %rdi
               	movq	%r13, 0x18(%rdi)
               	movl	$0x5, %eax
               	movl	%eax, 0x20(%rdi)
               	callq	<addr>
               	movslq	(%rax), %rcx
               	cmpl	$0x9, %ecx
               	jne	<addr>
               	movslq	0x8(%rax), %rcx
               	cmpl	$0x4, %ecx
               	sete	%bl
               	movzbq	%bl, %rbx
               	xorq	%rdx, %rdx
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	0x10(%rax), %rcx
               	cmpq	%r12, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x18(%rax), %rcx
               	cmpq	%r13, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	0x20(%rax), %rax
               	cmpl	$0x5, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%edx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x4, %edx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rax, %rax
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, -0x28(%rbp)
               	movl	$0x10, %eax
               	movq	%rax, -0x20(%rbp)
               	movq	-0x28(%rbp), %rbx
               	movq	-0x20(%rbp), %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	xorq	%rax, %rax
               	movq	%rax, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movl	$0x3, %eax
               	movl	%eax, (%rdi)
               	movq	%rbx, 0x8(%rdi)
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	(%rcx), %rax
               	cmpl	$0x3, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	0x8(%rcx), %rax
               	cmpq	%rbx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x18, %eax
               	movq	%rax, -0x20(%rbp)
               	movq	-0x20(%rbp), %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x3, %eax
               	jmp	<addr>
               	jmp	<addr>
