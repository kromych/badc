
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
               	subq	$0x20, %rsp
               	leaq	-0x10(%rbp), %rax
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
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x3, %rcx
               	orq	$0x2, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rdx
               	movl	%ecx, %eax
               	andq	$-0x1d, %rax
               	orq	$0x14, %rax
               	movl	%eax, (%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movl	%eax, %eax
               	andq	$-0x1d, %rax
               	movq	%rax, %rcx
               	orq	$0x14, %rcx
               	movl	%ecx, (%rdx)
               	movl	%ecx, %eax
               	sarq	$0x2, %rax
               	andq	$0x7, %rax
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movzbq	(%rdx), %rcx
               	movb	%cl, (%rax)
               	movzbq	0x1(%rdx), %rcx
               	movb	%cl, 0x1(%rax)
               	movzbq	0x2(%rdx), %rcx
               	movb	%cl, 0x2(%rax)
               	movzbq	0x3(%rdx), %rcx
               	movb	%cl, 0x3(%rax)
               	popq	%rcx
               	leaq	-0x8(%rbp), %rsi
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %edx
               	andq	$-0x3, %rdx
               	orq	$0x2, %rdx
               	movl	%edx, (%rax)
               	movl	%edx, %eax
               	andq	$-0x2, %rax
               	movq	%rax, %rdx
               	orq	$0x1, %rdx
               	movl	%edx, (%rsi)
               	movl	%edx, %eax
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	%edx, %eax
               	sarq	%rax
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rdx
               	movl	%ecx, %eax
               	andq	$-0x1e1, %rax           # imm = 0xFE1F
               	orq	$0x1a0, %rax            # imm = 0x1A0
               	movl	%eax, (%rdx)
               	movl	%eax, %eax
               	sarq	$0x5, %rax
               	andq	$0xf, %rax
               	shlq	$0x3c, %rax
               	sarq	$0x3c, %rax
               	cmpq	$-0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
