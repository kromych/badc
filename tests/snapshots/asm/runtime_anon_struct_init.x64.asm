
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
               	addq	$0x10, %rsp
               	popq	%rbp
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
               	leaq	-0x40(%rbp), %rcx
               	xorq	%rax, %rax
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	movq	%rax, 0x10(%rcx)
               	movq	%rax, 0x18(%rcx)
               	movl	$0x1, %r12d
               	leaq	-0x40(%rbp), %rcx
               	movl	%r12d, (%rcx)
               	leaq	-0x40(%rbp), %rcx
               	movq	%r13, 0x8(%rcx)
               	leaq	-0x40(%rbp), %rcx
               	movq	%r14, 0x10(%rcx)
               	movl	$0x7, %edx
               	leaq	-0x40(%rbp), %rcx
               	movl	%edx, 0x18(%rcx)
               	leaq	-0x20(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	movq	%rax, 0x10(%rcx)
               	movq	%rax, 0x18(%rcx)
               	movl	$0x2, %eax
               	leaq	-0x20(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x20(%rbp), %rax
               	movq	%r13, 0x8(%rax)
               	leaq	-0x20(%rbp), %rax
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
               	cmpq	$0x1, %rcx
               	jne	<addr>
               	movq	0x8(%rbx), %rcx
               	cmpq	%r13, %rcx
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movl	$0x1, %ecx
               	testq	%r12, %r12
               	jne	<addr>
               	movq	0x10(%rbx), %rcx
               	cmpq	%r14, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x18(%rbx), %rcx
               	cmpq	$0x7, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movslq	(%rax), %rcx
               	cmpq	$0x2, %rcx
               	movl	$0x1, %edx
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
               	cmpq	$0x8, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	xorq	%rax, %rax
               	movl	%eax, -0x40(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movq	%rax, -0x50(%rbp)
               	movl	$0x10, %eax
               	movq	%rax, -0x48(%rbp)
               	movq	-0x50(%rbp), %r12
               	movq	-0x48(%rbp), %rsi
               	movq	%r12, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movl	$0x3, %eax
               	leaq	-0x38(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x38(%rbp), %rax
               	movq	%r12, 0x8(%rax)
               	leaq	-0x38(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0x3, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	0x8(%rcx), %rax
               	cmpq	%r12, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x18, %eax
               	movq	%rax, -0x48(%rbp)
               	movq	-0x48(%rbp), %r13
               	leaq	-0x28(%rbp), %rax
               	xorq	%rbx, %rbx
               	movq	%rbx, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movq	%rbx, 0x10(%rax)
               	movq	%rbx, 0x18(%rax)
               	movq	%rbx, 0x20(%rax)
               	movl	$0x9, %eax
               	leaq	-0x28(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movl	$0x4, %ecx
               	leaq	-0x28(%rbp), %rax
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x28(%rbp), %rax
               	movq	%r12, 0x10(%rax)
               	leaq	-0x28(%rbp), %rax
               	movq	%r13, 0x18(%rax)
               	movl	$0x5, %ecx
               	leaq	-0x28(%rbp), %rax
               	movl	%ecx, 0x20(%rax)
               	leaq	-0x28(%rbp), %rdi
               	callq	<addr>
               	movslq	(%rax), %rcx
               	cmpq	$0x9, %rcx
               	jne	<addr>
               	movslq	0x8(%rax), %rcx
               	cmpq	$0x4, %rcx
               	sete	%bl
               	movzbq	%bl, %rbx
               	xorq	%rdx, %rdx
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	0x10(%rax), %rcx
               	cmpq	%r12, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rcx, %rcx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	0x18(%rax), %rcx
               	cmpq	%r13, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	0x20(%rax), %rax
               	cmpq	$0x5, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	jmp	<addr>
