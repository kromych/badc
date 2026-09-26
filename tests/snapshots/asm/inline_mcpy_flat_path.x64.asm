
inline_mcpy_flat_path.x64:	file format elf64-x86-64

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

<use_decode>:
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rax), %rdx
               	shrq	$0x3e, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	movzwq	(%rcx), %r10
               	movw	%r10w, (%rdi)
               	movslq	0x8(%rax), %rdx
               	movzbq	0x2(%rcx), %rsi
               	addq	%rsi, %rdx
               	movl	%edx, 0x8(%rax)
               	movzbq	0x3(%rcx), %rax
               	retq

<use_widen>:
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	0x20(%rax), %rax
               	incq	%rcx
               	imulq	$0xa, %rdx, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rax, %rax
               	addq	%rcx, %rax
               	retq

<use_preset>:
               	movl	$0x475, %eax            # imm = 0x475
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movw	$0x0, -0x8(%rbp)
               	leaq	<rip>, %rcx
               	movabsq	$-0x8000000000000000, %rdx # imm = 0x8000000000000000
               	movq	%rdx, (%rcx)
               	movl	$0x0, 0x8(%rcx)
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	xorq	$0x1e, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movzwq	-0x8(%rbp), %rax
               	xorq	$0x3333, %rax           # imm = 0x3333
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	callq	<addr>
               	cmpq	$0x435, %rax            # imm = 0x435
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0xb, %edi
               	callq	<addr>
               	cmpq	$0x475, %rax            # imm = 0x475
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
