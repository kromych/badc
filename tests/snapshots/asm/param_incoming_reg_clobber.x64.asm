
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
               	leaq	(%rax), %rcx
               	movl	$0x1, %edx
               	movb	%dl, (%rcx)
               	movl	$0x2, %ecx
               	movb	%cl, 0x1(%rax)
               	movl	$0x3, %ecx
               	movb	%cl, 0x2(%rax)
               	movl	$0x4, %ecx
               	movb	%cl, 0x3(%rax)
               	movl	$0x5, %ecx
               	movb	%cl, 0x4(%rax)
               	movl	$0x6, %ecx
               	movb	%cl, 0x5(%rax)
               	movl	$0x7, %ecx
               	movb	%cl, 0x6(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x8, %ecx
               	movb	%cl, 0x7(%rax)
               	leaq	-0x8(%rbp), %rdx
               	addq	$0x7, %rdx
               	jmp	<addr>
               	leaq	-0x1(%rdx), %rsi
               	leaq	0x1(%rax), %rdi
               	movsbq	(%rax), %rax
               	movb	%al, (%rdx)
               	movq	%rsi, %rdx
               	movq	%rdi, %rax
               	movl	%ecx, %esi
               	leaq	-0x1(%rsi), %rcx
               	testq	%rsi, %rsi
               	jne	<addr>
               	xorq	%rcx, %rcx
               	leaq	-0x8(%rbp), %rax
               	leaq	(%rax), %rdx
               	movsbq	(%rdx), %rdx
               	cmpl	$0x8, %edx
               	je	<addr>
               	leaq	0xa(%rcx), %rax
               	movslq	%eax, %rax
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
               	xorq	%rdi, %rdi
               	movl	$0x8, %edx
               	jmp	<addr>
               	leaq	0x1(%rax), %rsi
               	leaq	0x1(%rcx), %r8
               	movsbq	(%rcx), %rcx
               	movb	%cl, (%rax)
               	movq	%rsi, %rax
               	movq	%r8, %rcx
               	movl	%edx, %esi
               	leaq	-0x1(%rsi), %rdx
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	leaq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	leaq	0x14(%rdi), %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	movl	$0x1, %edi
               	movsbq	0x1(%rax), %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movl	$0x2, %edi
               	movsbq	0x2(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	$0x3, %edi
               	movsbq	0x3(%rax), %rcx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movl	$0x4, %edi
               	movsbq	0x4(%rax), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	$0x5, %edi
               	movsbq	0x5(%rax), %rcx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movl	$0x6, %edi
               	movsbq	0x6(%rax), %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movl	$0x7, %edi
               	leaq	-0x8(%rbp), %rax
               	movsbq	0x7(%rax), %rax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	xorq	%rax, %rax
               	leave
               	retq
