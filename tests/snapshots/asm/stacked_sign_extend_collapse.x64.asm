
stacked_sign_extend_collapse.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	%al, %rcx
               	cmpl	$-0x11, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movswq	%ax, %rdx
               	cmpl	$0xffffcdef, %edx       # imm = 0xFFFFCDEF
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpl	$-0x11, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	cmpl	$0xffffcdef, %edx       # imm = 0xFFFFCDEF
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpl	$0xee6b2800, %eax       # imm = 0xEE6B2800
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	testl	%eax, %eax
               	jl	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$-0x1194d800, %rax      # imm = 0xEE6B2800
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	xorq	%rax, %rax
               	retq
