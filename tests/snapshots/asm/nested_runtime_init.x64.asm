
nested_runtime_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rcx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x18(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rsi
               	leaq	-0x18(%rbp), %rcx
               	movq	%rsi, 0x8(%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	cmpq	%rdx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movq	0x8(%rcx), %rsi
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rsi
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x28(%rbp), %rcx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movq	%rax, %rcx
               	shlq	$0x1, %rcx
               	leaq	-0x28(%rbp), %rsi
               	movl	%ecx, (%rsi)
               	leaq	0x3(%rax), %rcx
               	movslq	%ecx, %rsi
               	leaq	-0x28(%rbp), %rcx
               	movq	%rsi, 0x8(%rcx)
               	leaq	-0x28(%rbp), %rcx
               	movslq	(%rcx), %rsi
               	movq	%rax, %rcx
               	shlq	$0x1, %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rsi
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x28(%rbp), %rcx
               	movq	0x8(%rcx), %rsi
               	leaq	0x3(%rax), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rsi
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x38(%rbp), %rcx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x38(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movq	%rax, %rcx
               	shlq	$0x1, %rcx
               	leaq	-0x38(%rbp), %rsi
               	movl	%ecx, 0x4(%rsi)
               	leaq	0x5(%rax), %rcx
               	movslq	%ecx, %rsi
               	leaq	-0x38(%rbp), %rcx
               	movq	%rsi, 0x8(%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	cmpq	%rdx, %rcx
               	setne	%sil
               	movzbq	%sil, %rsi
               	movl	$0x1, %ecx
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x38(%rbp), %rcx
               	movslq	0x4(%rcx), %rsi
               	movq	%rax, %rcx
               	shlq	$0x1, %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rsi
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x38(%rbp), %rcx
               	movq	0x8(%rcx), %rsi
               	leaq	0x5(%rax), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rsi
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x48(%rbp), %rcx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movzbq	0x8(%rsi), %rax
               	movb	%al, 0x8(%rcx)
               	movzbq	0x9(%rsi), %rax
               	movb	%al, 0x9(%rcx)
               	movzbq	0xa(%rsi), %rax
               	movb	%al, 0xa(%rcx)
               	movzbq	0xb(%rsi), %rax
               	movb	%al, 0xb(%rcx)
               	popq	%rax
               	leaq	-0x48(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	0x1(%rax), %rcx
               	leaq	-0x48(%rbp), %rsi
               	movl	%ecx, 0x4(%rsi)
               	leaq	0x2(%rax), %rcx
               	leaq	-0x48(%rbp), %rsi
               	movl	%ecx, 0x8(%rsi)
               	leaq	-0x48(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	cmpq	%rdx, %rcx
               	setne	%sil
               	movzbq	%sil, %rsi
               	movl	$0x1, %ecx
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x48(%rbp), %rcx
               	movslq	0x4(%rcx), %rsi
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rsi
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x48(%rbp), %rcx
               	movslq	0x8(%rcx), %rsi
               	leaq	0x2(%rax), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rsi
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	xorq	%rax, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, (%rax)
