
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
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x18(%rbp), %rax
               	movl	%ecx, (%rax)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rax
               	leaq	-0x18(%rbp), %rdx
               	movq	%rax, 0x8(%rdx)
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rax
               	movslq	%ecx, %rdx
               	cmpq	%rdx, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movq	0x8(%rax), %rax
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movq	%rcx, %rax
               	shlq	$0x1, %rax
               	leaq	-0x28(%rbp), %rdx
               	movl	%eax, (%rdx)
               	leaq	0x3(%rcx), %rax
               	movslq	%eax, %rax
               	leaq	-0x28(%rbp), %rdx
               	movq	%rax, 0x8(%rdx)
               	leaq	-0x28(%rbp), %rax
               	movslq	(%rax), %rax
               	movq	%rcx, %rdx
               	shlq	$0x1, %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movq	0x8(%rax), %rax
               	leaq	0x3(%rcx), %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x38(%rbp), %rax
               	movl	%ecx, (%rax)
               	movq	%rcx, %rax
               	shlq	$0x1, %rax
               	leaq	-0x38(%rbp), %rdx
               	movl	%eax, 0x4(%rdx)
               	leaq	0x5(%rcx), %rax
               	movslq	%eax, %rax
               	leaq	-0x38(%rbp), %rdx
               	movq	%rax, 0x8(%rdx)
               	leaq	-0x38(%rbp), %rax
               	movslq	(%rax), %rax
               	movslq	%ecx, %rdx
               	cmpq	%rdx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %esi
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	movq	%rcx, %rdx
               	shlq	$0x1, %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	0x8(%rax), %rax
               	leaq	0x5(%rcx), %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movzbq	0x8(%rdx), %rcx
               	movb	%cl, 0x8(%rax)
               	movzbq	0x9(%rdx), %rcx
               	movb	%cl, 0x9(%rax)
               	movzbq	0xa(%rdx), %rcx
               	movb	%cl, 0xa(%rax)
               	movzbq	0xb(%rdx), %rcx
               	movb	%cl, 0xb(%rax)
               	popq	%rcx
               	leaq	-0x48(%rbp), %rax
               	movl	%ecx, (%rax)
               	leaq	0x1(%rcx), %rax
               	leaq	-0x48(%rbp), %rdx
               	movl	%eax, 0x4(%rdx)
               	leaq	0x2(%rcx), %rax
               	leaq	-0x48(%rbp), %rdx
               	movl	%eax, 0x8(%rdx)
               	leaq	-0x48(%rbp), %rax
               	movslq	(%rax), %rax
               	movslq	%ecx, %rdx
               	cmpq	%rdx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %esi
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x48(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x48(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	leaq	0x2(%rcx), %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x14, %rax
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
