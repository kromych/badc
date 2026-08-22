
array_initializers.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	leaq	-0x8(%rbp), %rcx
               	leaq	<rip>, %rax
               	pushq	%rdx
               	movzbq	(%rax), %rdx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rax), %rdx
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rax), %rdx
               	movb	%dl, 0x2(%rcx)
               	movzbq	0x3(%rax), %rdx
               	movb	%dl, 0x3(%rcx)
               	movzbq	0x4(%rax), %rdx
               	movb	%dl, 0x4(%rcx)
               	movzbq	0x5(%rax), %rdx
               	movb	%dl, 0x5(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x18(%rbp), %rdx
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movzbq	0x8(%rax), %rcx
               	movb	%cl, 0x8(%rdx)
               	movzbq	0x9(%rax), %rcx
               	movb	%cl, 0x9(%rdx)
               	movzbq	0xa(%rax), %rcx
               	movb	%cl, 0xa(%rdx)
               	movzbq	0xb(%rax), %rcx
               	movb	%cl, 0xb(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	popq	%rcx
               	leaq	-0x38(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	movzbq	0x10(%rsi), %rcx
               	movb	%cl, 0x10(%rax)
               	movzbq	0x11(%rsi), %rcx
               	movb	%cl, 0x11(%rax)
               	movzbq	0x12(%rsi), %rcx
               	movb	%cl, 0x12(%rax)
               	movzbq	0x13(%rsi), %rcx
               	movb	%cl, 0x13(%rax)
               	popq	%rcx
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rsi
               	cmpq	$0x68, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movsbq	0x4(%rax), %rsi
               	cmpq	$0x6f, %rsi
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movsbq	0x5(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	movslq	0x4(%rax), %rdi
               	addq	%rdi, %rsi
               	movslq	0x8(%rax), %rdi
               	addq	%rdi, %rsi
               	movslq	0xc(%rax), %rdi
               	addq	%rdi, %rsi
               	movslq	0x10(%rax), %rax
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	cmpq	$0x1c, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x68, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movsbq	0x1(%rax), %rax
               	cmpq	$0x69, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movsbq	0x2(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movsbq	0xf(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	0xc(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	0x10(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x61, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x62, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	0x10(%rax), %rax
               	movsbq	0x4(%rax), %rax
               	cmpq	$0x61, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movsbq	(%rcx), %rax
               	cmpq	$0x77, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movsbq	0x4(%rcx), %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movsbq	0x5(%rcx), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	(%rdx), %rax
               	movslq	0x4(%rdx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x18(%rbp), %rcx
               	movslq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x258, %rax            # imm = 0x258
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movsbq	(%rax), %rcx
               	cmpq	$0x6f, %rcx
               	je	<addr>
               	movl	$0x19, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movsbq	0x1(%rax), %rcx
               	cmpq	$0x6b, %rcx
               	je	<addr>
               	movl	$0x1a, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movsbq	0x2(%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1b, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	cmpq	$0x64, %rdx
               	je	<addr>
               	movl	$0x1c, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	0x8(%rcx), %rdx
               	cmpq	$0x12c, %rdx            # imm = 0x12C
               	je	<addr>
               	movl	$0x1d, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	0xc(%rcx), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1e, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	0x10(%rcx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1f, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movsbq	0x3(%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x20, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movsbq	0x7(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
