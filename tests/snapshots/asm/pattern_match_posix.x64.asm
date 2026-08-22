
pattern_match_posix.x64:	file format elf64-x86-64

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
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movslq	%ebx, %rax
               	imulq	$0x18, %rax, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	movslq	0x10(%rax), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rcx
               	movslq	%ebx, %rax
               	imulq	$0x18, %rax, %rax
               	addq	%r12, %rax
               	movslq	0x14(%rax), %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movslq	%ebx, %rax
               	leaq	0x1(%rax), %rbx
               	movslq	%ebx, %rax
               	cmpq	$0x37, %rax
               	jl	<addr>
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rdi
               	leaq	<rip>, %rax
               	movslq	%ebx, %rcx
               	imulq	$0x30, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	(%rax), %rsi
               	movslq	0x8(%rax), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movabsq	$-0x2, %rax
               	movl	%eax, (%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, 0x4(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, 0x8(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, 0xc(%rcx)
               	leaq	-0x50(%rbp), %rdi
               	leaq	<rip>, %rax
               	movslq	%ebx, %rcx
               	imulq	$0x30, %rcx, %rcx
               	addq	%rax, %rcx
               	movq	0x10(%rcx), %rsi
               	movl	$0x2, %edx
               	leaq	-0x10(%rbp), %rcx
               	movslq	%ebx, %r8
               	imulq	$0x30, %r8, %r8
               	addq	%r8, %rax
               	movslq	0x18(%rax), %r8
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rdx
               	leaq	<rip>, %rcx
               	movslq	%ebx, %rsi
               	imulq	$0x30, %rsi, %rsi
               	addq	%rsi, %rcx
               	movslq	0x1c(%rcx), %rcx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rcx
               	leaq	<rip>, %rax
               	movslq	%ebx, %rdx
               	imulq	$0x30, %rdx, %rdx
               	addq	%rdx, %rax
               	movslq	0x20(%rax), %rax
               	cmpq	%rax, %rcx
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	0x4(%rax), %rcx
               	leaq	<rip>, %rax
               	movslq	%ebx, %rdx
               	imulq	$0x30, %rdx, %rdx
               	addq	%rdx, %rax
               	movslq	0x24(%rax), %rax
               	cmpq	%rax, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	0x8(%rax), %rcx
               	leaq	<rip>, %rax
               	movslq	%ebx, %rdx
               	imulq	$0x30, %rdx, %rdx
               	addq	%rdx, %rax
               	movslq	0x28(%rax), %rax
               	cmpq	%rax, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	0xc(%rax), %rcx
               	leaq	<rip>, %rax
               	movslq	%ebx, %rdx
               	imulq	$0x30, %rdx, %rdx
               	addq	%rdx, %rax
               	movslq	0x2c(%rax), %rax
               	cmpq	%rax, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x50(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movzbq	%al, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movslq	%ebx, %rax
               	leaq	0x1(%rax), %rbx
               	movslq	%ebx, %rax
               	cmpq	$0x2f, %rax
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x50(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movzbq	%al, %rax
               	leaq	0x38(%rbx), %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x50(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movzbq	%al, %rax
               	leaq	0x38(%rbx), %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	0x38(%rbx), %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	0x1(%rbx), %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
