
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
               	subq	$0x60, %rsp
               	leaq	<rip>, %r9
               	xorq	%rcx, %rcx
               	movl	%ecx, (%r9)
               	leaq	-0x40(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movq	%rcx, 0x20(%rax)
               	movq	%rcx, 0x28(%rax)
               	movq	%rcx, 0x30(%rax)
               	movq	%rcx, 0x38(%rax)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	movl	$0xd, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x9, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	0x10(%rax), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	0x20(%rax), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movl	$0x5, %ecx
               	movl	%ecx, 0x30(%rax)
               	movl	$0x6, %eax
               	leaq	-0x40(%rbp), %rdi
               	movq	%rax, 0x38(%rdi)
               	movslq	(%r9), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x65, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	movq	%rcx, %r8
               	shlq	$0x4, %r8
               	leaq	(%rdi,%r8), %rsi
               	movslq	(%rsi), %rdx
               	cmpq	$0xd, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	0x8(%rsi), %rdx
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
               	leaq	-0x40(%rbp), %rax
               	movslq	0x30(%rax), %rcx
               	cmpq	$0x5, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x38(%rax), %rax
               	cmpq	$0x6, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x50(%rbp), %rax
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
               	movslq	(%r9), %rcx
               	incq	%rcx
               	movl	%ecx, (%r9)
               	movl	$0xd, %ecx
               	movl	%ecx, 0x10(%rax)
               	movl	$0x9, %ecx
               	movq	%rcx, 0x18(%rax)
               	leaq	0x20(%rax), %rdx
               	leaq	0x10(%rax), %rcx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	0x30(%rax), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	movl	$0x5, %ecx
               	movl	%ecx, 0x40(%rax)
               	movl	$0x6, %eax
               	leaq	-0x50(%rbp), %rdi
               	movq	%rax, 0x48(%rdi)
               	movslq	(%r9), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x67, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movslq	(%rdi), %rcx
               	testq	%rcx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x8(%rdi), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	movq	%rcx, %r8
               	shlq	$0x4, %r8
               	leaq	(%rdi,%r8), %rsi
               	movslq	(%rsi), %rdx
               	cmpq	$0xd, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	0x8(%rsi), %rdx
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
               	leaq	-0x50(%rbp), %rax
               	movslq	0x40(%rax), %rcx
               	cmpq	$0x5, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x48(%rax), %rax
               	cmpq	$0x6, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x60, %rsp
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
               	movslq	(%r9), %rcx
               	incq	%rcx
               	movl	%ecx, (%r9)
               	movl	$0xd, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x1, %edx
               	movq	%rdx, 0x8(%rax)
               	leaq	0x10(%rax), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	0x20(%rax), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movslq	(%r9), %rcx
               	incq	%rcx
               	movl	%ecx, (%r9)
               	movl	$0x11, %ecx
               	movl	%ecx, 0x10(%rax)
               	movl	$0x2, %ecx
               	leaq	-0x30(%rbp), %rax
               	movq	%rcx, 0x18(%rax)
               	movslq	(%r9), %rcx
               	cmpq	$0x4, %rcx
               	je	<addr>
               	movl	$0x68, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movslq	(%rax), %rcx
               	cmpq	$0xd, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	cmpq	$0x1, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	0x20(%rax), %rcx
               	cmpq	$0xd, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x28(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movslq	0x10(%rax), %rcx
               	cmpq	$0x11, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x18(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x4, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq

<check_member_range>:
               	leaq	<rip>, %rcx
               	xorq	%rax, %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rsi
               	incq	%rsi
               	movl	%esi, (%rdx)
               	movslq	(%rcx), %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x69, %eax
               	retq
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	retq

<check_row_range>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	<rip>, %rdx
               	xorq	%rax, %rax
               	movl	%eax, (%rdx)
               	leaq	-0x20(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	movq	%rax, 0x10(%rcx)
               	movq	%rax, 0x18(%rcx)
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rdi
               	incq	%rdi
               	movl	%edi, (%rsi)
               	movl	$0x1d, %esi
               	movl	%esi, (%rcx)
               	movl	$0x5, %esi
               	movl	%esi, 0x4(%rcx)
               	movq	(%rcx), %rsi
               	movq	%rsi, 0x8(%rcx)
               	movq	%rsi, 0x10(%rcx)
               	movslq	(%rdx), %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x6a, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rdi
               	movq	%rcx, %r8
               	shlq	$0x3, %r8
               	leaq	(%rdi,%r8), %rsi
               	movslq	(%rsi), %rdx
               	cmpq	$0x1d, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	0x4(%rsi), %rdx
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
               	movslq	0x18(%rax), %rdx
               	testq	%rdx, %rdx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	0x1c(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
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
