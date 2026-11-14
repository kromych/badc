
inline_struct_param_returned.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	movq	-0x18(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movq	%rcx, -0x10(%rbp)
               	movq	-0x20(%rbp), %rcx
               	movq	%rcx, -0x8(%rbp)
               	testl	%esi, %esi
               	cmoveq	%rdx, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %rdi # <addr>
               	movq	$0x7, <rip> # <addr>
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	callq	<addr>
               	cmpq	$0x22, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
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
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	callq	<addr>
               	cmpq	$0x59, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x59, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpq	$0x59, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpq	$0x62, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
