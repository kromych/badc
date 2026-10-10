
param_incoming_reg_clobber.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	movb	$0x1, -0x10(%rbp)
               	movb	$0x2, -0xf(%rbp)
               	movb	$0x3, -0xe(%rbp)
               	movb	$0x4, -0xd(%rbp)
               	movb	$0x5, -0xc(%rbp)
               	movb	$0x6, -0xb(%rbp)
               	movb	$0x7, -0xa(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movl	$0x8, %eax
               	movb	%al, -0x9(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	addq	$0x7, %rcx
               	leaq	-0x1(%rax), %rsi
               	leaq	-0x1(%rcx), %rax
               	leaq	0x1(%rdx), %rdi
               	movsbq	(%rdx), %rdx
               	movb	%dl, (%rcx)
               	movq	%rax, %rcx
               	movq	%rsi, %rax
               	movq	%rdi, %rdx
               	leaq	-0x1(%rax), %rsi
               	testl	%eax, %eax
               	jne	<addr>
               	xorl	%ecx, %ecx
               	movsbq	-0x8(%rbp), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	leaq	0xa(%rcx), %rax
               	leave
               	retq
               	movl	$0x1, %ecx
               	movsbq	-0x7(%rbp), %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movl	$0x2, %ecx
               	movsbq	-0x6(%rbp), %rax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movl	$0x3, %ecx
               	movsbq	-0x5(%rbp), %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movl	$0x4, %ecx
               	movsbq	-0x4(%rbp), %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movl	$0x5, %ecx
               	movsbq	-0x3(%rbp), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movl	$0x6, %ecx
               	movsbq	-0x2(%rbp), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movl	$0x7, %ecx
               	leaq	-0x8(%rbp), %rax
               	movsbq	-0x1(%rbp), %rdx
               	cmpl	$0x1, %edx
               	jne	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movl	$0x8, %edx
               	leaq	-0x1(%rdx), %rsi
               	leaq	0x1(%rax), %rdx
               	leaq	0x1(%rcx), %rdi
               	movsbq	(%rcx), %rcx
               	movb	%cl, (%rax)
               	movq	%rdx, %rax
               	movq	%rsi, %rdx
               	movq	%rdi, %rcx
               	leaq	-0x1(%rdx), %rsi
               	testl	%edx, %edx
               	jne	<addr>
               	xorl	%eax, %eax
               	movsbq	-0x8(%rbp), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	addq	$0x14, %rax
               	leave
               	retq
               	movl	$0x1, %eax
               	movsbq	-0x7(%rbp), %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movl	$0x2, %eax
               	movsbq	-0x6(%rbp), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	$0x3, %eax
               	movsbq	-0x5(%rbp), %rcx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movl	$0x4, %eax
               	movsbq	-0x4(%rbp), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	$0x5, %eax
               	movsbq	-0x3(%rbp), %rcx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movl	$0x6, %eax
               	movsbq	-0x2(%rbp), %rcx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movl	$0x7, %eax
               	movsbq	-0x1(%rbp), %rcx
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
