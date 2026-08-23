
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
               	leaq	<rip>, %r12
               	jmp	<addr>
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
               	leaq	<rip>, %r12
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rdi
               	imulq	$0x30, %rax, %rax
               	addq	%r12, %rax
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
               	movl	%eax, 0x4(%rcx)
               	movl	%eax, 0x8(%rcx)
               	movl	%eax, 0xc(%rcx)
               	leaq	-0x50(%rbp), %rdi
               	movslq	%ebx, %rdx
               	imulq	$0x30, %rdx, %rsi
               	leaq	(%r12,%rsi), %rax
               	movq	0x10(%rax), %r8
               	movl	$0x2, %r9d
               	movslq	0x18(%rax), %rax
               	movq	%r8, %rsi
               	movq	%rax, %r8
               	movq	%r9, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rcx
               	movslq	%ebx, %rdx
               	imulq	$0x30, %rdx, %rsi
               	leaq	(%r12,%rsi), %rdi
               	movslq	0x1c(%rdi), %rdi
               	cmpq	%rdi, %rcx
               	jne	<addr>
               	testq	%rcx, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rdi
               	leaq	(%r12,%rsi), %rcx
               	movslq	0x20(%rcx), %rcx
               	cmpq	%rcx, %rdi
               	movl	$0x1, %ecx
               	jne	<addr>
               	movslq	0x4(%rax), %rdi
               	leaq	(%r12,%rsi), %rax
               	movslq	0x24(%rax), %rax
               	cmpq	%rax, %rdi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	0x8(%rax), %rcx
               	movslq	%ebx, %rax
               	imulq	$0x30, %rax, %rax
               	addq	%r12, %rax
               	movslq	0x28(%rax), %rax
               	cmpq	%rax, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	0xc(%rax), %rcx
               	movslq	%ebx, %rax
               	imulq	$0x30, %rax, %rax
               	addq	%r12, %rax
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
               	movq	%rcx, %rax
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
