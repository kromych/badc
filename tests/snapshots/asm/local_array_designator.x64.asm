
local_array_designator.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<use_auto>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0x5, %edx
               	leaq	-0x28(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movl	%ecx, 0x20(%rax)
               	leaq	-0x28(%rbp), %rax
               	movl	%edx, 0x18(%rax)
               	movl	$0x6, %ecx
               	leaq	-0x28(%rbp), %rax
               	movl	%ecx, 0x1c(%rax)
               	movl	$0x7, %ecx
               	leaq	-0x28(%rbp), %rax
               	movl	%ecx, 0x20(%rax)
               	movl	$0xa, %eax
               	leaq	-0x28(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movl	$0xb, %ecx
               	leaq	-0x28(%rbp), %rax
               	movl	%ecx, 0x4(%rax)
               	movl	$0xc, %ecx
               	leaq	-0x28(%rbp), %rax
               	movl	%ecx, 0x8(%rax)
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<use_fixed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movl	$0x7, %edx
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	leaq	-0x30(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movq	%rcx, 0x20(%rax)
               	movq	%rcx, 0x28(%rax)
               	leaq	-0x30(%rbp), %rax
               	movl	%edx, 0x24(%rax)
               	movl	$0x8, %edx
               	leaq	-0x30(%rbp), %rax
               	movl	%edx, 0x28(%rax)
               	leaq	-0x30(%rbp), %rax
               	movl	%ecx, 0x2c(%rax)
               	movl	$0x4, %ecx
               	leaq	-0x30(%rbp), %rax
               	movl	%ecx, 0xc(%rax)
               	movl	$0x5, %ecx
               	leaq	-0x30(%rbp), %rax
               	movl	%ecx, 0x10(%rax)
               	movl	$0x6, %ecx
               	leaq	-0x30(%rbp), %rax
               	movl	%ecx, 0x14(%rax)
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	movl	$0x7, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
