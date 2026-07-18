
scalar_compound_literal_lvalue.x64:	file format elf64-x86-64

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
               	movl	$0x5, %eax
               	movl	%eax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rcx
               	cmpq	$0x5, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %ecx
               	movl	%ecx, (%rax)
               	movslq	%ecx, %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x9, %eax
               	movl	%eax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x30(%rbp,%riz)
               	leaq	-0x30(%rbp), %rcx
               	movsd	(%rcx,%riz), %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x41, %eax
               	movb	%al, -0x40(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x41, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	movl	%eax, -0x58(%rbp)
               	leaq	-0x58(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	movl	%eax, -0x60(%rbp)
               	leaq	-0x60(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x70(%rbp), %rax
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movzbq	0x8(%rcx), %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	movb	%dl, 0xb(%rax)
               	popq	%rdx
               	leaq	-0x88(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
