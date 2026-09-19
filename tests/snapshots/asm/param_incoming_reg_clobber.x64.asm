
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
               	leaq	-0x10(%rbp), %rax
               	movb	$0x1, (%rax)
               	movb	$0x2, 0x1(%rax)
               	movb	$0x3, 0x2(%rax)
               	movb	$0x4, 0x3(%rax)
               	movb	$0x5, 0x4(%rax)
               	movb	$0x6, 0x5(%rax)
               	movb	$0x7, 0x6(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x8, %ecx
               	movb	%cl, 0x7(%rax)
               	leaq	-0x8(%rbp), %rdx
               	addq	$0x7, %rdx
               	leaq	-0x1(%rcx), %rsi
               	leaq	-0x1(%rdx), %rcx
               	leaq	0x1(%rax), %rdi
               	movsbq	(%rax), %rax
               	movb	%al, (%rdx)
               	movq	%rcx, %rdx
               	movq	%rsi, %rcx
               	movq	%rdi, %rax
               	leaq	-0x1(%rcx), %rsi
               	testl	%ecx, %ecx
               	jne	<addr>
               	xorl	%ecx, %ecx
               	leaq	-0x8(%rbp), %rax
               	movsbq	(%rax), %rdx
               	cmpl	$0x8, %edx
               	je	<addr>
               	leaq	0xa(%rcx), %rax
               	leave
               	retq
               	movl	$0x1, %ecx
               	movsbq	0x1(%rax), %rdx
               	cmpl	$0x7, %edx
               	jne	<addr>
               	movl	$0x2, %ecx
               	movsbq	0x2(%rax), %rdx
               	cmpl	$0x6, %edx
               	jne	<addr>
               	movl	$0x3, %ecx
               	movsbq	0x3(%rax), %rdx
               	cmpl	$0x5, %edx
               	jne	<addr>
               	movl	$0x4, %ecx
               	movsbq	0x4(%rax), %rdx
               	cmpl	$0x4, %edx
               	jne	<addr>
               	movl	$0x5, %ecx
               	movsbq	0x5(%rax), %rdx
               	cmpl	$0x3, %edx
               	jne	<addr>
               	movl	$0x6, %ecx
               	movsbq	0x6(%rax), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movl	$0x7, %ecx
               	leaq	-0x8(%rbp), %rax
               	movsbq	0x7(%rax), %rdx
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
               	leaq	-0x8(%rbp), %rcx
               	movsbq	(%rcx), %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	addq	$0x14, %rax
               	leave
               	retq
               	movl	$0x1, %eax
               	movsbq	0x1(%rcx), %rdx
               	cmpl	$0x2, %edx
               	jne	<addr>
               	movl	$0x2, %eax
               	movsbq	0x2(%rcx), %rdx
               	cmpl	$0x3, %edx
               	jne	<addr>
               	movl	$0x3, %eax
               	movsbq	0x3(%rcx), %rdx
               	cmpl	$0x4, %edx
               	jne	<addr>
               	movl	$0x4, %eax
               	movsbq	0x4(%rcx), %rdx
               	cmpl	$0x5, %edx
               	jne	<addr>
               	movl	$0x5, %eax
               	movsbq	0x5(%rcx), %rdx
               	cmpl	$0x6, %edx
               	jne	<addr>
               	movl	$0x6, %eax
               	movsbq	0x6(%rcx), %rcx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movl	$0x7, %eax
               	leaq	-0x8(%rbp), %rcx
               	movsbq	0x7(%rcx), %rcx
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
