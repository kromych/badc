
two_d_array_param_indexing.x64:	file format elf64-x86-64

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
               	subq	$0x408, %rsp            # imm = 0x408
               	xorl	%eax, %eax
               	leaq	(%rsp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	movl	$0x0, (%rcx)
               	incq	%rax
               	cmpl	$0x100, %eax            # imm = 0x100
               	jl	<addr>
               	movl	$0x101234, 0x14(%rsp)   # imm = 0x101234
               	xorl	%eax, %eax
               	leaq	0x388(%rsp), %rcx
               	imulq	$0xc, %rax, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rax, %rdx
               	movl	%edx, (%rcx)
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, 0x4(%rcx)
               	addq	$0x2, %rdx
               	movl	%edx, 0x8(%rcx)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0xa, %eax
               	jl	<addr>
               	movl	0x3dc(%rsp), %eax
               	movl	0x3e0(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x3e4(%rsp), %ecx
               	addq	%rcx, %rax
               	cmpl	$0x837, %eax            # imm = 0x837
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x408, %rsp            # imm = 0x408
               	retq
               	xorl	%eax, %eax
               	leaq	0x3e0(%rsp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	leaq	0x41(%rax), %rcx
               	movb	%cl, 0x3e0(%rsp,%rsi)
               	addq	%rsi, %rdx
               	leaq	0x1(%rcx), %rsi
               	movb	%sil, 0x1(%rdx)
               	addq	$0x2, %rcx
               	movb	%cl, 0x2(%rdx)
               	leaq	0x3e0(%rsp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	leaq	0x41(%rax), %rdx
               	addq	$0x3, %rdx
               	movb	%dl, 0x3(%rcx)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movsbq	0x3ec(%rsp), %rax
               	movsbq	0x3ed(%rsp), %rcx
               	addq	%rcx, %rax
               	movsbq	0x3ee(%rsp), %rcx
               	addq	%rcx, %rax
               	movsbq	0x3ef(%rsp), %rcx
               	addq	%rcx, %rax
               	cmpl	$0x116, %eax            # imm = 0x116
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x408, %rsp            # imm = 0x408
               	retq
               	xorl	%eax, %eax
               	addq	$0x408, %rsp            # imm = 0x408
               	retq
