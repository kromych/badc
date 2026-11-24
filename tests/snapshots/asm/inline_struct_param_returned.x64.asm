
inline_struct_param_returned.x64:	file format elf64-x86-64

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

<use_word>:
               	movq	(%rdi), %rax
               	retq

<use_pair>:
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	$0xa, %rax, %rax
               	addq	%rcx, %rax
               	retq

<use_big>:
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	imulq	$0x64, %rdx, %rcx
               	addq	%rcx, %rax
               	imulq	$0x3e8, %rsi, %rcx      # imm = 0x3E8
               	addq	%rcx, %rax
               	imulq	$0x2710, %rdi, %rcx     # imm = 0x2710
               	addq	%rcx, %rax
               	retq

<use_hint>:
               	movq	(%rdi), %rax
               	movq	0x8(%rdi), %rcx
               	imulq	$0xa, %rax, %rax
               	addq	%rcx, %rax
               	retq

<use_twice>:
               	movq	(%rdi), %rax
               	movq	0x8(%rdi), %rcx
               	imulq	$0xa, %rax, %rax
               	addq	%rcx, %rax
               	retq

<use_pick>:
               	movq	(%rdi), %rax
               	movq	0x8(%rdi), %rcx
               	testl	%esi, %esi
               	movq	%rax, %rdx
               	cmovneq	%rcx, %rdx
               	testl	%esi, %esi
               	cmoveq	%rcx, %rax
               	imulq	$0xa, %rax, %rax
               	addq	%rdx, %rax
               	retq

<main>:
               	subq	$0x18, %rsp
               	leaq	<rip>, %rdi # <addr>
               	movq	$0x7, <rip> # <addr>
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	callq	<addr>
               	cmpq	$0x22, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	$0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x5, <rip> # <addr>
               	callq	<addr>
               	cmpq	$0xd431, %rax           # imm = 0xD431
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	(%rsp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	callq	<addr>
               	cmpq	$0x59, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	cmpq	$0x59, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	(%rsp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpq	$0x59, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	(%rsp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpq	$0x62, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
