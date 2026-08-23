
fd_set_macros.x64:	file format elf64-x86-64

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
               	subq	$0x90, %rsp
               	leaq	-0x80(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movslq	%eax, %rsi
               	addq	%rcx, %rsi
               	movb	%dl, (%rsi)
               	incq	%rax
               	movslq	%eax, %rax
               	cmpl	$0x80, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rdx
               	addq	%rcx, %rdx
               	movsbq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	incq	%rax
               	movslq	%eax, %rax
               	cmpl	$0x80, %eax
               	jl	<addr>
               	leaq	-0x80(%rbp), %rax
               	leaq	(%rax), %rcx
               	movzbq	(%rcx), %rdx
               	orq	$0x1, %rdx
               	movb	%dl, (%rcx)
               	movzbq	(%rcx), %rdx
               	orq	$0x80, %rdx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rax), %rdx
               	orq	$0x1, %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0xc(%rax), %rdx
               	orq	$0x10, %rdx
               	movb	%dl, 0xc(%rax)
               	movzbq	(%rcx), %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	leaq	(%rax), %rcx
               	movzbq	(%rcx), %rdx
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0x3, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movzbq	0x1(%rax), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movzbq	0xc(%rax), %rdx
               	andq	$0x10, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movzbq	(%rcx), %rdx
               	andq	$0x2, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movzbq	0x6(%rax), %rdx
               	andq	$0x4, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movzbq	(%rax), %rdx
               	xorq	$0x81, %rdx
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movzbq	0x1(%rax), %rdx
               	xorq	$0x1, %rdx
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movzbq	0xc(%rax), %rdx
               	xorq	$0x10, %rdx
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movzbq	(%rcx), %rax
               	movq	%rax, %rdx
               	andq	$-0x81, %rdx
               	movb	%dl, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	(%rax), %rcx
               	movzbq	(%rcx), %rdx
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movzbq	(%rcx), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0x16, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movzbq	0x1(%rax), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0x17, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movzbq	(%rcx), %rdx
               	orq	$0x1, %rdx
               	movb	%dl, (%rcx)
               	movzbq	(%rcx), %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x18, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rdx
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movslq	%eax, %rsi
               	addq	%rdx, %rsi
               	movb	%cl, (%rsi)
               	incq	%rax
               	movslq	%eax, %rax
               	cmpl	$0x80, %eax
               	jl	<addr>
               	leaq	-0x80(%rbp), %rax
               	leaq	(%rax), %rcx
               	movzbq	(%rcx), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x19, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movzbq	0xc(%rax), %rax
               	andq	$0x10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1a, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
