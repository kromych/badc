
runtime_range_designator_struct.x64:	file format elf64-x86-64

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

<check_struct_ranges>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	leaq	<rip>, %rsi
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rsi)
               	leaq	-0xc0(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movq	%rcx, 0x20(%rax)
               	movq	%rcx, 0x28(%rax)
               	movq	%rcx, 0x30(%rax)
               	movq	%rcx, 0x38(%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movl	$0xd, %eax
               	leaq	-0xc0(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movl	$0x9, %ecx
               	leaq	-0xc0(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xc0(%rbp), %rax
               	leaq	0x10(%rax), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xc0(%rbp), %rax
               	leaq	0x20(%rax), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movl	$0x5, %ecx
               	leaq	-0xc0(%rbp), %rax
               	movl	%ecx, 0x30(%rax)
               	movl	$0x6, %ecx
               	leaq	-0xc0(%rbp), %rax
               	movq	%rcx, 0x38(%rax)
               	movslq	(%rsi), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x65, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xc0(%rbp), %rdx
               	movq	%rcx, %rdi
               	shlq	$0x4, %rdi
               	addq	%rdi, %rdx
               	movslq	(%rdx), %rdx
               	cmpq	$0xd, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0xc0(%rbp), %rdx
               	movq	%rcx, %rdi
               	shlq	$0x4, %rdi
               	addq	%rdi, %rdx
               	movq	0x8(%rdx), %rdx
               	cmpq	$0x9, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x3, %rcx
               	jl	<addr>
               	leaq	-0xc0(%rbp), %rax
               	movslq	0x30(%rax), %rax
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xc0(%rbp), %rax
               	movq	0x38(%rax), %rax
               	cmpq	$0x6, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movq	%rcx, 0x20(%rax)
               	movq	%rcx, 0x28(%rax)
               	movq	%rcx, 0x30(%rax)
               	movq	%rcx, 0x38(%rax)
               	movq	%rcx, 0x40(%rax)
               	movq	%rcx, 0x48(%rax)
               	movslq	(%rsi), %rax
               	incq	%rax
               	movl	%eax, (%rsi)
               	movl	$0xd, %ecx
               	leaq	-0x80(%rbp), %rax
               	movl	%ecx, 0x10(%rax)
               	movl	$0x9, %ecx
               	leaq	-0x80(%rbp), %rax
               	movq	%rcx, 0x18(%rax)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x20(%rax), %rcx
               	addq	$0x10, %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x80(%rbp), %rax
               	leaq	0x30(%rax), %rcx
               	addq	$0x10, %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movl	$0x5, %ecx
               	leaq	-0x80(%rbp), %rax
               	movl	%ecx, 0x40(%rax)
               	movl	$0x6, %ecx
               	leaq	-0x80(%rbp), %rax
               	movq	%rcx, 0x48(%rax)
               	movslq	(%rsi), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x67, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x80(%rbp), %rax
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rdx
               	movq	%rcx, %rdi
               	shlq	$0x4, %rdi
               	addq	%rdi, %rdx
               	movslq	(%rdx), %rdx
               	cmpq	$0xd, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x80(%rbp), %rdx
               	movq	%rcx, %rdi
               	shlq	$0x4, %rdi
               	addq	%rdi, %rdx
               	movq	0x8(%rdx), %rdx
               	cmpq	$0x9, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x3, %rcx
               	jle	<addr>
               	leaq	-0x80(%rbp), %rax
               	movslq	0x40(%rax), %rax
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x80(%rbp), %rax
               	movq	0x48(%rax), %rax
               	cmpq	$0x6, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movq	%rcx, 0x20(%rax)
               	movq	%rcx, 0x28(%rax)
               	movslq	(%rsi), %rax
               	incq	%rax
               	movl	%eax, (%rsi)
               	movl	$0xd, %eax
               	leaq	-0x30(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movl	$0x1, %ecx
               	leaq	-0x30(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x30(%rbp), %rax
               	leaq	0x10(%rax), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x30(%rbp), %rax
               	leaq	0x20(%rax), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movslq	(%rsi), %rax
               	incq	%rax
               	movl	%eax, (%rsi)
               	movl	$0x11, %ecx
               	leaq	-0x30(%rbp), %rax
               	movl	%ecx, 0x10(%rax)
               	movl	$0x2, %ecx
               	leaq	-0x30(%rbp), %rax
               	movq	%rcx, 0x18(%rax)
               	movslq	(%rsi), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x68, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0xd, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movslq	0x20(%rax), %rax
               	cmpq	$0xd, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movq	0x28(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movslq	0x10(%rax), %rax
               	cmpq	$0x11, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x4, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq

<check_member_range>:
               	leaq	<rip>, %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x69, %eax
               	retq
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	retq

<check_row_range>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	<rip>, %rdx
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rdx)
               	leaq	-0x20(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movl	$0x1d, %eax
               	leaq	-0x20(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movl	$0x5, %ecx
               	leaq	-0x20(%rbp), %rax
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	%rcx, 0x10(%rax)
               	movslq	(%rdx), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x6a, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rdx
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movslq	(%rdx), %rdx
               	cmpq	$0x1d, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdx
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movslq	0x4(%rdx), %rdx
               	cmpq	$0x5, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x3, %rcx
               	jl	<addr>
               	leaq	-0x20(%rbp), %rax
               	movslq	0x18(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movslq	0x1c(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0xb, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0xd, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	movl	$0x11, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	movl	$0x1d, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
