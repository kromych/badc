
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
               	leaq	-0x18(%rbp), %rdx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	-0x18(%rbp), %rdx
               	movl	%ecx, (%rdx)
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rdx
               	leaq	-0x18(%rbp), %rsi
               	movq	%rdx, 0x8(%rsi)
               	leaq	-0x18(%rbp), %rdx
               	movslq	(%rdx), %rdx
               	cmpq	%rax, %rdx
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x18(%rbp), %rdx
               	movq	0x8(%rdx), %rdx
               	leaq	0x1(%rcx), %rsi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rdx
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x28(%rbp), %rdx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rcx, %rdx
               	shlq	$0x1, %rdx
               	leaq	-0x28(%rbp), %rsi
               	movl	%edx, (%rsi)
               	leaq	0x3(%rcx), %rdx
               	movslq	%edx, %rdx
               	leaq	-0x28(%rbp), %rsi
               	movq	%rdx, 0x8(%rsi)
               	leaq	-0x28(%rbp), %rdx
               	movslq	(%rdx), %rdx
               	movq	%rcx, %rsi
               	shlq	$0x1, %rsi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rdx
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x28(%rbp), %rdx
               	movq	0x8(%rdx), %rdx
               	leaq	0x3(%rcx), %rsi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rdx
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x38(%rbp), %rdx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	-0x38(%rbp), %rdx
               	movl	%ecx, (%rdx)
               	movq	%rcx, %rdx
               	shlq	$0x1, %rdx
               	leaq	-0x38(%rbp), %rsi
               	movl	%edx, 0x4(%rsi)
               	leaq	0x5(%rcx), %rdx
               	movslq	%edx, %rdx
               	leaq	-0x38(%rbp), %rsi
               	movq	%rdx, 0x8(%rsi)
               	leaq	-0x38(%rbp), %rdx
               	movslq	(%rdx), %rdx
               	cmpq	%rax, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %edi
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x38(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	movq	%rcx, %rsi
               	shlq	$0x1, %rsi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	leaq	-0x38(%rbp), %rdx
               	movq	0x8(%rdx), %rdx
               	leaq	0x5(%rcx), %rsi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rdx
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	leaq	-0x48(%rbp), %rdx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movzbq	0x8(%rsi), %rax
               	movb	%al, 0x8(%rdx)
               	movzbq	0x9(%rsi), %rax
               	movb	%al, 0x9(%rdx)
               	movzbq	0xa(%rsi), %rax
               	movb	%al, 0xa(%rdx)
               	movzbq	0xb(%rsi), %rax
               	movb	%al, 0xb(%rdx)
               	popq	%rax
               	leaq	-0x48(%rbp), %rdx
               	movl	%ecx, (%rdx)
               	leaq	0x1(%rcx), %rdx
               	leaq	-0x48(%rbp), %rsi
               	movl	%edx, 0x4(%rsi)
               	leaq	0x2(%rcx), %rdx
               	leaq	-0x48(%rbp), %rsi
               	movl	%edx, 0x8(%rsi)
               	leaq	-0x48(%rbp), %rdx
               	movslq	(%rdx), %rdx
               	cmpq	%rax, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %edi
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x48(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	leaq	0x1(%rcx), %rsi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	leaq	-0x48(%rbp), %rdx
               	movslq	0x8(%rdx), %rdx
               	leaq	0x2(%rcx), %rsi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rdx
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
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
