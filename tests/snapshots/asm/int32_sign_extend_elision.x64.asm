
int32_sign_extend_elision.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sum4>:
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<widen>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	(%rdi,%rsi), %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<sgn>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %rax
               	imulq	%rsi, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setl	%al
               	movzbq	%al, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<pick>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	(%rsi,%rdx), %rax
               	movslq	%eax, %rax
               	movslq	(%rdi,%rax,4), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<uwrap>:
               	movl	%edi, %eax
               	movl	%esi, %ecx
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
               	movabsq	$-0x80000000, %rcx      # imm = 0x80000000
               	movl	$0x1, %edx
               	movabsq	$-0x1, %rsi
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x77359400, %eax       # imm = 0x77359400
               	addq	%rax, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x1194d800, %rax      # imm = 0xEE6B2800
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x3, %rax
               	movl	$0x4, %edx
               	imulq	%rdx, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setl	%al
               	movzbq	%al, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	imulq	%rcx, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setl	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	$0x2, %ecx
               	movl	%eax, %eax
               	movl	%ecx, %ecx
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movzbq	0x10(%rcx), %rdx
               	movb	%dl, 0x10(%rax)
               	movzbq	0x11(%rcx), %rdx
               	movb	%dl, 0x11(%rax)
               	movzbq	0x12(%rcx), %rdx
               	movb	%dl, 0x12(%rax)
               	movzbq	0x13(%rcx), %rdx
               	movb	%dl, 0x13(%rax)
               	popq	%rdx
               	leaq	-0x28(%rbp), %rax
               	addq	$0x8, %rax
               	movabsq	$-0x1, %rcx
               	addq	%rcx, %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rax,%rcx,4), %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
