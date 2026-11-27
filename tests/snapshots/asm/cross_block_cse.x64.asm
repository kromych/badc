
cross_block_cse.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x38, %rsp
               	movabsq	$0x100000000, %rax      # imm = 0x100000000
               	movq	%rax, 0x8(%rsp)
               	movabsq	$0x900000004, %rax      # imm = 0x900000004
               	movq	%rax, 0x10(%rsp)
               	movabsq	$0x1900000010, %rax     # imm = 0x1900000010
               	movq	%rax, 0x18(%rsp)
               	movabsq	$0x3100000024, %rax     # imm = 0x3100000024
               	movq	%rax, 0x20(%rsp)
               	movabsq	$0x5100000040, %rax     # imm = 0x5100000040
               	movq	%rax, 0x28(%rsp)
               	movl	$0x99, %eax
               	xorl	%ecx, %ecx
               	imulq	$0x1999999a, %rax, %rdx # imm = 0x1999999A
               	shrq	$0x20, %rdx
               	imulq	$0xa, %rdx, %rdi
               	subq	%rdi, %rax
               	movl	0x8(%rsp,%rax,4), %eax
               	addq	%rax, %rcx
               	cmpl	$0xc8, %ecx
               	jg	<addr>
               	movq	%rdx, %rax
               	nopl	(%rax)
               	testl	%eax, %eax
               	jg	<addr>
               	cmpl	$0x23, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	$0xf423f, %eax          # imm = 0xF423F
               	xorl	%ecx, %ecx
               	imulq	$0x1999999a, %rax, %rdx # imm = 0x1999999A
               	shrq	$0x20, %rdx
               	imulq	$0xa, %rdx, %rdi
               	subq	%rdi, %rax
               	movl	0x8(%rsp,%rax,4), %eax
               	addq	%rax, %rcx
               	nopw	%cs:(%rax,%rax)
               	cmpl	$0xc8, %ecx
               	jg	<addr>
               	movq	%rdx, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	cmpl	$-0x1, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	(%rsp), %rdi
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
               	movq	(%rsp,%rax,8), %rsi
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
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x38, %rsp
               	retq
