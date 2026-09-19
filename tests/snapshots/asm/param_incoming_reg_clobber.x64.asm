
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
               	leaq	-0x10(%rbp), %rcx
               	movl	$0x8, %eax
               	movb	%al, 0x7(%rcx)
               	leaq	-0x8(%rbp), %rdx
               	addq	$0x7, %rdx
               	leaq	-0x1(%rax), %rsi
               	leaq	-0x1(%rdx), %rax
               	leaq	0x1(%rcx), %rdi
               	movsbq	(%rcx), %rcx
               	movb	%cl, (%rdx)
               	movq	%rax, %rdx
               	movq	%rsi, %rax
               	movq	%rdi, %rcx
               	leaq	-0x1(%rax), %rsi
               	testl	%eax, %eax
               	jne	<addr>
               	xorl	%edx, %edx
               	leaq	-0x8(%rbp), %rax
               	movsbq	(%rax), %rcx
               	cmpl	$0x8, %ecx
               	je	<addr>
               	leaq	0xa(%rdx), %rax
               	leave
               	retq
               	movl	$0x1, %edx
               	movsbq	0x1(%rax), %rcx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movl	$0x2, %edx
               	movsbq	0x2(%rax), %rcx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movl	$0x3, %edx
               	movsbq	0x3(%rax), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	$0x4, %edx
               	movsbq	0x4(%rax), %rcx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movl	$0x5, %edx
               	movsbq	0x5(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	$0x6, %edx
               	movsbq	0x6(%rax), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movl	$0x7, %edx
               	leaq	-0x8(%rbp), %rcx
               	movsbq	0x7(%rcx), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rdx
               	xorl	%esi, %esi
               	movl	$0x8, %eax
               	leaq	-0x1(%rax), %rdi
               	leaq	0x1(%rcx), %rax
               	leaq	0x1(%rdx), %r8
               	movsbq	(%rdx), %rdx
               	movb	%dl, (%rcx)
               	movq	%rax, %rcx
               	movq	%rdi, %rax
               	movq	%r8, %rdx
               	leaq	-0x1(%rax), %rdi
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movsbq	(%rax), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	leaq	0x14(%rsi), %rax
               	leave
               	retq
               	movl	$0x1, %esi
               	movsbq	0x1(%rax), %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movl	$0x2, %esi
               	movsbq	0x2(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	$0x3, %esi
               	movsbq	0x3(%rax), %rcx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movl	$0x4, %esi
               	movsbq	0x4(%rax), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	$0x5, %esi
               	movsbq	0x5(%rax), %rcx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movl	$0x6, %esi
               	movsbq	0x6(%rax), %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movl	$0x7, %esi
               	leaq	-0x8(%rbp), %rax
               	movsbq	0x7(%rax), %rax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
