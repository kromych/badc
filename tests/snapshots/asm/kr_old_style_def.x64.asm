
kr_old_style_def.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<mix>:
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	subq	%rdx, %rax
               	movq	%rsi, %rcx
               	andq	$0xff, %rcx
               	addq	%rcx, %rax
               	retq

<first>:
               	movzbq	(%rdi), %rax
               	retq

<main>:
               	movl	$0x1, %eax
               	xorq	%rcx, %rcx
               	movq	%rax, %r10
               	subq	%r10, %rax
               	andq	$0xff, %rcx
               	addq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0xa, %eax
               	movl	$0x5, %ecx
               	movl	$0x3, %edx
               	subq	%rdx, %rax
               	andq	$0xff, %rcx
               	addq	%rcx, %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x5a, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%rax, %rax
               	retq
