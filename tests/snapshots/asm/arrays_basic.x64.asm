
arrays_basic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<sum_n>:
               	movslq	%esi, %rsi
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movslq	%ecx, %rdx
               	cmpq	%rsi, %rdx
               	jge	<addr>
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	movslq	(%rdi,%rcx,4), %rdx
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	incq	%rcx
               	movslq	%ecx, %rcx
               	jmp	<addr>
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	incq	%rsi
               	movl	%esi, (%rax,%rdx,4)
               	movslq	%ecx, %rax
               	incq	%rax
               	movslq	%eax, %rcx
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rdi
               	movl	$0x5, %esi
               	callq	<addr>
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x2, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	imulq	$0xa, %rdx, %rsi
               	movl	%esi, (%rax,%rdx,4)
               	movslq	%ecx, %rax
               	incq	%rax
               	movslq	%eax, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movslq	0x8(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movslq	0xc(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movslq	0x10(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x4, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x5, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	xorq	%rcx, %rcx
               	movl	$0x68, %edx
               	movb	%dl, (%rax)
               	movl	$0x69, %edx
               	movb	%dl, 0x1(%rax)
               	movb	%cl, 0x2(%rax)
               	movzbq	(%rax), %rax
               	xorq	$0x68, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movzbq	0x1(%rax), %rax
               	xorq	$0x69, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movzbq	0x2(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	leaq	-0x40(%rbp), %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rax
               	movl	%edx, (%rax)
               	leaq	-0x40(%rbp), %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rax
               	imulq	$0x64, %rdx, %rdx
               	movl	%edx, 0x4(%rax)
               	movslq	%ecx, %rax
               	incq	%rax
               	movslq	%eax, %rcx
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	movslq	0x14(%rax), %rax
               	cmpq	$0xc8, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0xc, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, 0x20(%rax)
               	movslq	%ecx, %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	leaq	-0x68(%rbp), %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	incq	%rsi
               	movl	%esi, (%rax,%rdx,4)
               	leaq	-0x68(%rbp), %rax
               	leaq	-0x68(%rbp), %rdx
               	movslq	0x20(%rdx), %rdx
               	leaq	-0x68(%rbp), %rsi
               	movslq	%ecx, %rdi
               	movslq	(%rsi,%rdi,4), %rsi
               	addq	%rsi, %rdx
               	movl	%edx, 0x20(%rax)
               	movslq	%ecx, %rax
               	incq	%rax
               	movslq	%eax, %rcx
               	jmp	<addr>
               	leaq	-0x68(%rbp), %rax
               	movslq	0x20(%rax), %rax
               	cmpq	$0x24, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	leaq	-0x70(%rbp), %rax
               	movslq	%ecx, %rdx
               	addq	%rdx, %rax
               	addq	$0x41, %rdx
               	movb	%dl, (%rax)
               	movslq	%ecx, %rax
               	incq	%rax
               	movslq	%eax, %rcx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x41, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	movzbq	0x7(%rax), %rax
               	xorq	$0x48, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movslq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
