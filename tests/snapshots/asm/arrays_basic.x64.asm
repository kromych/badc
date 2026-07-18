
arrays_basic.x64:	file format elf64-x86-64

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
               	subq	$0x90, %rsp
               	leaq	-0x18(%rbp), %rax
               	addq	$0x0, %rax
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x2, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x3, %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x4, %ecx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x5, %ecx
               	movl	%ecx, 0x10(%rax)
               	leaq	-0x18(%rbp), %rsi
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movslq	(%rsi,%rdx,4), %rcx
               	addq	%rcx, %rax
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x5, %rdx
               	jl	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0xa, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	<rip>, %rax
               	movl	$0x14, %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	<rip>, %rax
               	movl	$0x1e, %ecx
               	movl	%ecx, 0xc(%rax)
               	leaq	<rip>, %rax
               	movl	$0x28, %ecx
               	movl	%ecx, 0x10(%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x8(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0xc(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x10(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	xorq	%rdx, %rdx
               	movl	$0x68, %ecx
               	movb	%cl, (%rax)
               	movl	$0x69, %esi
               	movb	%sil, 0x1(%rax)
               	movb	%dl, 0x2(%rax)
               	movsbq	%cl, %rax
               	cmpq	$0x68, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movsbq	0x1(%rax), %rax
               	cmpq	$0x69, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movsbq	0x2(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	xorq	%rcx, %rcx
               	addq	$0x0, %rax
               	movl	%ecx, (%rax)
               	leaq	-0x40(%rbp), %rax
               	addq	$0x0, %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x1, %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x40(%rbp), %rax
               	addq	$0x8, %rax
               	movl	$0x64, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x2, %ecx
               	movl	%ecx, 0x10(%rax)
               	leaq	-0x40(%rbp), %rax
               	addq	$0x10, %rax
               	movl	$0xc8, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x40(%rbp), %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	movslq	0x14(%rax), %rax
               	cmpq	$0xc8, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, 0x20(%rax)
               	leaq	-0x68(%rbp), %rax
               	addq	$0x0, %rax
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x68(%rbp), %rcx
               	leaq	-0x68(%rbp), %rax
               	movslq	0x20(%rax), %rax
               	leaq	-0x68(%rbp), %rdx
               	addq	$0x0, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rax
               	movl	%eax, 0x20(%rcx)
               	leaq	-0x68(%rbp), %rax
               	movl	$0x2, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x68(%rbp), %rcx
               	leaq	-0x68(%rbp), %rax
               	movslq	0x20(%rax), %rdx
               	leaq	-0x68(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	addq	%rdx, %rax
               	movl	%eax, 0x20(%rcx)
               	leaq	-0x68(%rbp), %rax
               	movl	$0x3, %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x68(%rbp), %rcx
               	leaq	-0x68(%rbp), %rax
               	movslq	0x20(%rax), %rdx
               	leaq	-0x68(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	addq	%rdx, %rax
               	movl	%eax, 0x20(%rcx)
               	leaq	-0x68(%rbp), %rax
               	movl	$0x4, %ecx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x68(%rbp), %rcx
               	leaq	-0x68(%rbp), %rax
               	movslq	0x20(%rax), %rdx
               	leaq	-0x68(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	addq	%rdx, %rax
               	movl	%eax, 0x20(%rcx)
               	leaq	-0x68(%rbp), %rax
               	movl	$0x5, %ecx
               	movl	%ecx, 0x10(%rax)
               	leaq	-0x68(%rbp), %rcx
               	leaq	-0x68(%rbp), %rax
               	movslq	0x20(%rax), %rdx
               	leaq	-0x68(%rbp), %rax
               	movslq	0x10(%rax), %rax
               	addq	%rdx, %rax
               	movl	%eax, 0x20(%rcx)
               	leaq	-0x68(%rbp), %rax
               	movl	$0x6, %ecx
               	movl	%ecx, 0x14(%rax)
               	leaq	-0x68(%rbp), %rcx
               	leaq	-0x68(%rbp), %rax
               	movslq	0x20(%rax), %rdx
               	leaq	-0x68(%rbp), %rax
               	movslq	0x14(%rax), %rax
               	addq	%rdx, %rax
               	movl	%eax, 0x20(%rcx)
               	leaq	-0x68(%rbp), %rax
               	movl	$0x7, %ecx
               	movl	%ecx, 0x18(%rax)
               	leaq	-0x68(%rbp), %rcx
               	leaq	-0x68(%rbp), %rax
               	movslq	0x20(%rax), %rdx
               	leaq	-0x68(%rbp), %rax
               	movslq	0x18(%rax), %rax
               	addq	%rdx, %rax
               	movl	%eax, 0x20(%rcx)
               	leaq	-0x68(%rbp), %rax
               	movl	$0x8, %ecx
               	movl	%ecx, 0x1c(%rax)
               	leaq	-0x68(%rbp), %rcx
               	leaq	-0x68(%rbp), %rax
               	movslq	0x20(%rax), %rdx
               	leaq	-0x68(%rbp), %rax
               	movslq	0x1c(%rax), %rax
               	addq	%rdx, %rax
               	movl	%eax, 0x20(%rcx)
               	leaq	-0x68(%rbp), %rax
               	movslq	0x20(%rax), %rax
               	cmpq	$0x24, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x0, %rax
               	movl	$0x41, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x70(%rbp), %rax
               	movl	$0x42, %ecx
               	movb	%cl, 0x1(%rax)
               	leaq	-0x70(%rbp), %rax
               	movl	$0x43, %ecx
               	movb	%cl, 0x2(%rax)
               	leaq	-0x70(%rbp), %rax
               	movl	$0x44, %ecx
               	movb	%cl, 0x3(%rax)
               	leaq	-0x70(%rbp), %rax
               	movl	$0x45, %ecx
               	movb	%cl, 0x4(%rax)
               	leaq	-0x70(%rbp), %rax
               	movl	$0x46, %ecx
               	movb	%cl, 0x5(%rax)
               	leaq	-0x70(%rbp), %rax
               	movl	$0x47, %ecx
               	movb	%cl, 0x6(%rax)
               	leaq	-0x70(%rbp), %rax
               	movl	$0x48, %ecx
               	movb	%cl, 0x7(%rax)
               	leaq	-0x70(%rbp), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x41, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	movsbq	0x7(%rax), %rax
               	cmpq	$0x48, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
