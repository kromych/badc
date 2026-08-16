
inline_by_value_aggregate_param_copy.x64:	file format elf64-x86-64

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

<via_param_write>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movl	$0x2a, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rax
               	xorq	%rcx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x11, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	pushq	%rax
               	movzbq	(%rcx), %rax
               	movb	%al, (%rdx)
               	movzbq	0x1(%rcx), %rax
               	movb	%al, 0x1(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x18(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movw	%dx, (%rcx)
               	movzbq	(%rax), %rcx
               	addq	$0x5f4477, %rcx         # imm = 0x5F4477
               	shrq	$0x7, %rcx
               	addq	$0x3, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movzbq	(%rcx), %rcx
               	movb	%cl, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movzbq	(%rax), %rcx
               	movq	%rcx, %rax
               	andq	$0xff, %rax
               	xorq	$0x11, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x8c, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movl	$0x7, %ecx
               	movb	%cl, (%rax)
               	leaq	<rip>, %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	pushq	%rdx
               	movzbq	(%rax), %rdx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rax), %rdx
               	movb	%dl, 0x1(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movl	$0x63, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x63, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movl	$0x8, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x20(%rbp), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movl	$0x3, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x10(%rbp), %rsi
               	pushq	%rcx
               	movzbq	(%rax), %rcx
               	movb	%cl, (%rsi)
               	movzbq	0x1(%rax), %rcx
               	movb	%cl, 0x1(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x18(%rbp), %rax
               	pushq	%rdx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	popq	%rdx
               	movl	$0x37, %eax
               	movb	%al, (%rdx)
               	leaq	-0x10(%rbp), %rax
               	movzbq	(%rax), %rax
               	imulq	$0xa, %rax, %rax
               	leaq	-0x18(%rbp), %rcx
               	movzbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x21, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x37, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x4, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x10(%rbp), %rcx
               	pushq	%rdx
               	movzbq	(%rax), %rdx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rax), %rdx
               	movb	%dl, 0x1(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	<rip>, %rax
               	movl	$0x4d, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x4d, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
