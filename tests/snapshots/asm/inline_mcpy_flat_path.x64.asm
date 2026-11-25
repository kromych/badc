
inline_mcpy_flat_path.x64:	file format elf64-x86-64

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

<use_decode>:
               	leaq	<rip>, %rcx # <addr>
               	movq	<rip>, %rax # <addr>
               	shrq	$0x3e, %rax
               	shlq	$0x2, %rax
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
               	subq	$0x18, %rsp
               	movw	$0x0, 0x8(%rsp)
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%rcx, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	leaq	0x8(%rsp), %rdi
               	callq	<addr>
               	cmpl	$0x1e, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	movzwq	0x8(%rsp), %rax
               	cmpl	$0x3333, %eax           # imm = 0x3333
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x18, %rsp
               	retq
               	callq	<addr>
               	cmpq	$0x435, %rax            # imm = 0x435
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0xb, %edi
               	callq	<addr>
               	cmpq	$0x475, %rax            # imm = 0x475
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
