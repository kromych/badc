
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
               	leaq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	shrq	$0x3e, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movzwq	(%rax), %r10
               	movw	%r10w, (%rdi)
               	movl	<rip>, %ecx # <addr>
               	movzbq	0x2(%rax), %rdx
               	addq	%rdx, %rcx
               	movl	%ecx, <rip> # <addr>
               	movzbq	0x3(%rax), %rax
               	retq

<use_widen>:
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	incq	%rax
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	imulq	$0x64, %rdx, %rcx
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
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%rcx, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	cmpl	$0x1e, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movzwq	-0x8(%rbp), %rax
               	cmpl	$0x3333, %eax           # imm = 0x3333
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
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
               	movq	<rip>, %rax # <addr>
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
