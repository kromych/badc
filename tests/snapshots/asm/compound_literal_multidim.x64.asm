
compound_literal_multidim.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rdi
               	leaq	(%rdx,%rdx,2), %rsi
               	addq	%rsi, %rdi
               	addq	$0x0, %rdi
               	movsbq	(%rdi), %rdi
               	addq	%rdi, %rax
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	addq	%rsi, %rdi
               	movsbq	0x1(%rdi), %rdi
               	addq	%rdi, %rax
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	addq	%rdi, %rsi
               	movsbq	0x2(%rsi), %rsi
               	addq	%rsi, %rax
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x2, %rdx
               	jl	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x15, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	0x5(%rax), %rax
               	cmpq	$0x6, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpq	$0xa, %rax
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0xc(%rax), %rax
               	cmpq	$0xd, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x10(%rax), %rax
               	cmpq	$0xe, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rdx
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movzbq	(%rax), %rcx
               	movb	%cl, (%rdx)
               	movzbq	0x1(%rax), %rcx
               	movb	%cl, 0x1(%rdx)
               	movzbq	0x2(%rax), %rcx
               	movb	%cl, 0x2(%rdx)
               	movzbq	0x3(%rax), %rcx
               	movb	%cl, 0x3(%rdx)
               	movzbq	0x4(%rax), %rcx
               	movb	%cl, 0x4(%rdx)
               	movzbq	0x5(%rax), %rcx
               	movb	%cl, 0x5(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	movq	%rax, %rcx
               	leaq	<rip>, %rcx
               	pushq	%rax
               	movzbq	(%rcx), %rax
               	movb	%al, (%rdx)
               	movzbq	0x1(%rcx), %rax
               	movb	%al, 0x1(%rdx)
               	movzbq	0x2(%rcx), %rax
               	movb	%al, 0x2(%rdx)
               	movzbq	0x3(%rcx), %rax
               	movb	%al, 0x3(%rdx)
               	movzbq	0x4(%rcx), %rax
               	movb	%al, 0x4(%rdx)
               	movzbq	0x5(%rcx), %rax
               	movb	%al, 0x5(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x28(%rbp), %rdx
               	leaq	<rip>, %rcx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	movq	0x10(%rcx), %rax
               	movq	%rax, 0x10(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	movq	%rax, %rsi
               	movq	%rax, %rsi
               	movq	%rax, %rcx
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	popq	%rcx
               	movq	%rcx, %rsi
               	movq	%rcx, %rax
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	movq	%rcx, %rax
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x15, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x16, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x18, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%rdx), %rcx
               	movq	%rcx, 0x10(%rax)
               	popq	%rcx
               	leaq	-0x20(%rbp), %rax
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
               	movq	%rcx, %rax
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x4, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x10(%rax), %rax
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x9, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x6, %rax
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x4, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x6, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
