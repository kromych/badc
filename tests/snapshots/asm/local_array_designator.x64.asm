
local_array_designator.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<use_auto>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movslq	%edi, %rdi
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movzbq	0x20(%rcx), %rdx
               	movb	%dl, 0x20(%rax)
               	movzbq	0x21(%rcx), %rdx
               	movb	%dl, 0x21(%rax)
               	movzbq	0x22(%rcx), %rdx
               	movb	%dl, 0x22(%rax)
               	movzbq	0x23(%rcx), %rdx
               	movb	%dl, 0x23(%rax)
               	popq	%rdx
               	leaq	-0x28(%rbp), %rax
               	movl	%edi, 0x18(%rax)
               	leaq	0x1(%rdi), %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	%eax, 0x1c(%rcx)
               	leaq	0x2(%rdi), %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	%eax, 0x20(%rcx)
               	movl	$0xa, %eax
               	leaq	-0x28(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movl	$0xb, %ecx
               	leaq	-0x28(%rbp), %rax
               	movl	%ecx, 0x4(%rax)
               	movl	$0xc, %ecx
               	leaq	-0x28(%rbp), %rax
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x28(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0xa, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0xc, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	movslq	0x18(%rax), %rax
               	cmpq	%rdi, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movslq	0x20(%rax), %rcx
               	leaq	0x2(%rdi), %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movslq	0x14(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<use_fixed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movslq	%edi, %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpq	$0x9, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x4(%rax), %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movslq	0x18(%rax), %rcx
               	cmpq	$0x9, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x1c(%rax), %rcx
               	cmpq	$0x8, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movslq	0xc(%rax), %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x24(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x20(%rax)
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	popq	%rdx
               	leaq	-0x30(%rbp), %rax
               	movl	%edi, 0x24(%rax)
               	leaq	0x1(%rdi), %rax
               	leaq	-0x30(%rbp), %rcx
               	movl	%eax, 0x28(%rcx)
               	xorq	%rcx, %rcx
               	leaq	-0x30(%rbp), %rax
               	movl	%ecx, 0x2c(%rax)
               	movl	$0x4, %ecx
               	leaq	-0x30(%rbp), %rax
               	movl	%ecx, 0xc(%rax)
               	movl	$0x5, %ecx
               	leaq	-0x30(%rbp), %rax
               	movl	%ecx, 0x10(%rax)
               	movl	$0x6, %ecx
               	leaq	-0x30(%rbp), %rax
               	movl	%ecx, 0x14(%rax)
               	leaq	-0x30(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	cmpq	$0x4, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movslq	0x14(%rax), %rax
               	cmpq	$0x6, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movslq	0x24(%rax), %rax
               	cmpq	%rdi, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movslq	0x28(%rax), %rcx
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movslq	0x18(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x384, %rax            # imm = 0x384
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x8, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	popq	%rbp
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	popq	%rbp
               	retq
               	movl	$0x7, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	0x18(%rax), %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x20(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	0xc(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x10(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
