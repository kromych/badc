
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
               	subq	$0x20, %rsp
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
               	movq	%rcx, -0x18(%rbp)
               	movl	-0x18(%rbp), %ecx
               	decq	%rcx
               	movl	%ecx, %ecx
               	addq	%rdx, %rcx
               	jmp	<addr>
               	leaq	-0x1(%rcx), %rdx
               	leaq	0x1(%rax), %rsi
               	movsbq	(%rax), %rax
               	movb	%al, (%rcx)
               	movq	%rdx, %rcx
               	movq	%rsi, %rax
               	movl	-0x18(%rbp), %edx
               	leaq	-0x1(%rdx), %rsi
               	movl	%esi, -0x18(%rbp)
               	testq	%rdx, %rdx
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
               	je	<addr>
               	jmp	<addr>
               	movl	$0x2, %ecx
               	movsbq	0x2(%rax), %rdx
               	cmpl	$0x6, %edx
               	je	<addr>
               	jmp	<addr>
               	movl	$0x3, %ecx
               	movsbq	0x3(%rax), %rdx
               	cmpl	$0x5, %edx
               	je	<addr>
               	jmp	<addr>
               	movl	$0x4, %ecx
               	movsbq	0x4(%rax), %rdx
               	cmpl	$0x4, %edx
               	je	<addr>
               	jmp	<addr>
               	movl	$0x5, %ecx
               	movsbq	0x5(%rax), %rdx
               	cmpl	$0x3, %edx
               	je	<addr>
               	jmp	<addr>
               	movl	$0x6, %ecx
               	movsbq	0x6(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	jmp	<addr>
               	movl	$0x7, %ecx
               	leaq	-0x8(%rbp), %rax
               	movsbq	0x7(%rax), %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movl	$0x8, %edx
               	xorq	%rsi, %rsi
               	movq	%rdx, -0x18(%rbp)
               	movl	-0x18(%rbp), %edx
               	movq	%rdx, -0x18(%rbp)
               	jmp	<addr>
               	leaq	0x1(%rax), %rdx
               	leaq	0x1(%rcx), %rdi
               	movsbq	(%rcx), %rcx
               	movb	%cl, (%rax)
               	movq	%rdx, %rax
               	movq	%rdi, %rcx
               	movl	-0x18(%rbp), %edx
               	leaq	-0x1(%rdx), %rdi
               	movl	%edi, -0x18(%rbp)
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	leaq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	leaq	0x14(%rsi), %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	movl	$0x1, %esi
               	movsbq	0x1(%rax), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	jmp	<addr>
               	movl	$0x2, %esi
               	movsbq	0x2(%rax), %rcx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	jmp	<addr>
               	movl	$0x3, %esi
               	movsbq	0x3(%rax), %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	jmp	<addr>
               	movl	$0x4, %esi
               	movsbq	0x4(%rax), %rcx
               	cmpl	$0x5, %ecx
               	je	<addr>
               	jmp	<addr>
               	movl	$0x5, %esi
               	movsbq	0x5(%rax), %rcx
               	cmpl	$0x6, %ecx
               	je	<addr>
               	jmp	<addr>
               	movl	$0x6, %esi
               	movsbq	0x6(%rax), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	jmp	<addr>
               	movl	$0x7, %esi
               	leaq	-0x8(%rbp), %rax
               	movsbq	0x7(%rax), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	leave
               	retq
