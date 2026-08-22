
member_name_space_keeps_object_shape.x64:	file format elf64-x86-64

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
               	xorq	%rdx, %rdx
               	xorq	%rax, %rax
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	<rip>, %r8
               	imulq	$0x30, %rdi, %r9
               	addq	%r9, %r8
               	movq	%rcx, %r9
               	shlq	$0x4, %r9
               	addq	%r9, %r8
               	leaq	(%r8), %r9
               	leaq	0x1(%rdx), %r8
               	movl	%edx, (%r9)
               	leaq	<rip>, %rdx
               	imulq	$0x30, %rdi, %r9
               	addq	%r9, %rdx
               	movq	%rcx, %r9
               	shlq	$0x4, %r9
               	addq	%rdx, %r9
               	leaq	0x1(%r8), %rdx
               	movl	%r8d, 0x4(%r9)
               	leaq	<rip>, %r8
               	imulq	$0x30, %rdi, %r9
               	addq	%r9, %r8
               	movq	%rcx, %r9
               	shlq	$0x4, %r9
               	addq	%r8, %r9
               	leaq	0x1(%rdx), %r8
               	movl	%edx, 0x8(%r9)
               	leaq	<rip>, %rdx
               	imulq	$0x30, %rdi, %r9
               	addq	%r9, %rdx
               	movq	%rcx, %r9
               	shlq	$0x4, %r9
               	addq	%rdx, %r9
               	leaq	0x1(%r8), %rdx
               	movl	%r8d, 0xc(%r9)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x3, %rcx
               	jl	<addr>
               	leaq	0x1(%rdi), %rsi
               	movslq	%esi, %rdi
               	cmpq	$0x2, %rdi
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	0x5c(%rax), %rax
               	cmpq	$0x17, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	leaq	(%rdx), %rsi
               	imulq	$0xa, %rax, %rdx
               	addq	$0x0, %rdx
               	movl	%edx, (%rsi)
               	leaq	<rip>, %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	addq	%rdx, %rsi
               	imulq	$0xa, %rax, %rdx
               	incq	%rdx
               	movl	%edx, 0x4(%rsi)
               	leaq	<rip>, %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	addq	%rdx, %rsi
               	imulq	$0xa, %rax, %rdx
               	addq	$0x2, %rdx
               	movl	%edx, 0x8(%rsi)
               	leaq	<rip>, %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	addq	%rdx, %rsi
               	imulq	$0xa, %rax, %rdx
               	addq	$0x3, %rdx
               	movl	%edx, 0xc(%rsi)
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	0x1c(%rax), %rax
               	cmpq	$0x17, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
