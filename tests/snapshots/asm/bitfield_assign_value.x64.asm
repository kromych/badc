
bitfield_assign_value.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movb	%dl, 0x3(%rax)
               	popq	%rdx
               	leaq	-0x8(%rbp), %rax
               	movl	$0x1, %ecx
               	movl	(%rax), %edx
               	andq	$-0x3, %rdx
               	movl	$0x2, %esi
               	orq	%rsi, %rdx
               	movl	%edx, (%rax)
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0x5, %ecx
               	movl	(%rax), %edx
               	andq	$-0x1d, %rdx
               	movl	$0x14, %esi
               	orq	%rsi, %rdx
               	movl	%edx, (%rax)
               	cmpq	$0x5, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0x5, %ecx
               	movl	(%rax), %edx
               	andq	$-0x1d, %rdx
               	movl	$0x14, %esi
               	orq	%rsi, %rdx
               	movl	%edx, (%rax)
               	cmpq	$0x5, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x2, %rax
               	andq	$0x7, %rax
               	cmpq	$0x5, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movb	%dl, 0x3(%rax)
               	popq	%rdx
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	$0x1, %edx
               	movl	(%rcx), %esi
               	andq	$-0x3, %rsi
               	movl	$0x2, %edi
               	orq	%rdi, %rsi
               	movl	%esi, (%rcx)
               	movl	(%rax), %ecx
               	andq	$-0x2, %rcx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x28(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x1, %rax
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movabsq	$-0x3, %rcx
               	movl	(%rax), %edx
               	andq	$-0x1e1, %rdx           # imm = 0xFE1F
               	movl	$0x1a0, %esi            # imm = 0x1A0
               	orq	%rsi, %rdx
               	movl	%edx, (%rax)
               	cmpq	$-0x3, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x5, %rax
               	andq	$0xf, %rax
               	shlq	$0x3c, %rax
               	sarq	$0x3c, %rax
               	cmpq	$-0x3, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
