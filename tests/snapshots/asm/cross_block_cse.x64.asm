
cross_block_cse.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	movl	$0x0, -0x28(%rbp)
               	movl	$0x1, -0x24(%rbp)
               	movl	$0x4, -0x20(%rbp)
               	movl	$0x9, -0x1c(%rbp)
               	movl	$0x10, -0x18(%rbp)
               	movl	$0x19, -0x14(%rbp)
               	movl	$0x24, -0x10(%rbp)
               	leaq	-0x28(%rbp), %rsi
               	movl	$0x31, -0xc(%rbp)
               	movl	$0x40, -0x8(%rbp)
               	movl	$0x51, -0x4(%rbp)
               	movl	-0xc(%rbp), %eax
               	cmpl	$0xc8, %eax
               	jle	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	cmpl	$0x31, %eax
               	jne	<addr>
               	movl	$0x99, %ecx
               	xorl	%eax, %eax
               	imulq	$0x1999999a, %rcx, %rdx # imm = 0x1999999A
               	shrq	$0x20, %rdx
               	imulq	$0xa, %rdx, %rdi
               	subq	%rdi, %rcx
               	movl	(%rsi,%rcx,4), %ecx
               	addq	%rcx, %rax
               	cmpl	$0xc8, %eax
               	jg	<addr>
               	movq	%rdx, %rcx
               	testl	%ecx, %ecx
               	jg	<addr>
               	cmpl	$0x23, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %rsi
               	movl	$0xf423f, %ecx          # imm = 0xF423F
               	xorl	%eax, %eax
               	imulq	$0x1999999a, %rcx, %rdx # imm = 0x1999999A
               	shrq	$0x20, %rdx
               	imulq	$0xa, %rdx, %rdi
               	subq	%rdi, %rcx
               	movl	(%rsi,%rcx,4), %ecx
               	addq	%rcx, %rax
               	cmpl	$0xc8, %eax
               	jg	<addr>
               	movq	%rdx, %rcx
               	testl	%ecx, %ecx
               	jg	<addr>
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x30(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movups	0x20(%rax), %xmm14
               	movups	%xmm14, 0x20(%rdi)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	leaq	(%rax,%rax,2), %rdx
               	incq	%rdx
               	movq	(%rdi,%rax,8), %rsi
               	movq	%rsi, %r8
               	imulq	%rdx, %r8
               	addq	%rcx, %r8
               	subq	%rdx, %rcx
               	testq	%rsi, %rsi
               	cmovgq	%r8, %rcx
               	incq	%rax
               	cmpl	$0x6, %eax
               	jl	<addr>
               	cmpq	$0x42, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
