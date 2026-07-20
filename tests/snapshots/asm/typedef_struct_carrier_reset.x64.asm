
typedef_struct_carrier_reset.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<zero_and_sum>:
               	xorq	%rax, %rax
               	leaq	(%rdi), %rcx
               	movl	%eax, (%rcx)
               	leaq	0x28(%rdi), %rax
               	addq	$0x0, %rax
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	leaq	(%rdi), %rax
               	movslq	(%rax), %rax
               	leaq	0x28(%rdi), %rcx
               	addq	$0x0, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	addq	$0x0, %rax
               	movl	$0x1, %ecx
               	movl	%ecx, 0x4(%rdi)
               	leaq	0x28(%rdi), %rcx
               	movl	$0x2, %edx
               	movl	%edx, 0x4(%rcx)
               	movslq	0x4(%rdi), %rdx
               	leaq	0x28(%rdi), %rcx
               	movslq	0x4(%rcx), %rcx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movl	$0x2, %ecx
               	movl	%ecx, 0x8(%rdi)
               	leaq	0x28(%rdi), %rcx
               	movl	$0x3, %edx
               	movl	%edx, 0x8(%rcx)
               	movslq	0x8(%rdi), %rdx
               	leaq	0x28(%rdi), %rcx
               	movslq	0x8(%rcx), %rcx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movl	$0x3, %ecx
               	movl	%ecx, 0xc(%rdi)
               	leaq	0x28(%rdi), %rcx
               	movl	$0x4, %edx
               	movl	%edx, 0xc(%rcx)
               	movslq	0xc(%rdi), %rdx
               	leaq	0x28(%rdi), %rcx
               	movslq	0xc(%rcx), %rcx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movl	$0x4, %ecx
               	movl	%ecx, 0x10(%rdi)
               	leaq	0x28(%rdi), %rcx
               	movl	$0x5, %edx
               	movl	%edx, 0x10(%rcx)
               	movslq	0x10(%rdi), %rdx
               	leaq	0x28(%rdi), %rcx
               	movslq	0x10(%rcx), %rcx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movl	$0x5, %ecx
               	movl	%ecx, 0x14(%rdi)
               	leaq	0x28(%rdi), %rcx
               	movl	$0x6, %edx
               	movl	%edx, 0x14(%rcx)
               	movslq	0x14(%rdi), %rdx
               	leaq	0x28(%rdi), %rcx
               	movslq	0x14(%rcx), %rcx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movl	$0x6, %ecx
               	movl	%ecx, 0x18(%rdi)
               	leaq	0x28(%rdi), %rcx
               	movl	$0x7, %edx
               	movl	%edx, 0x18(%rcx)
               	movslq	0x18(%rdi), %rdx
               	leaq	0x28(%rdi), %rcx
               	movslq	0x18(%rcx), %rcx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movl	$0x7, %ecx
               	movl	%ecx, 0x1c(%rdi)
               	leaq	0x28(%rdi), %rcx
               	movl	$0x8, %edx
               	movl	%edx, 0x1c(%rcx)
               	movslq	0x1c(%rdi), %rdx
               	leaq	0x28(%rdi), %rcx
               	movslq	0x1c(%rcx), %rcx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movl	$0x8, %ecx
               	movl	%ecx, 0x20(%rdi)
               	leaq	0x28(%rdi), %rcx
               	movl	$0x9, %edx
               	movl	%edx, 0x20(%rcx)
               	movslq	0x20(%rdi), %rdx
               	leaq	0x28(%rdi), %rcx
               	movslq	0x20(%rcx), %rcx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movl	$0x9, %ecx
               	movl	%ecx, 0x24(%rdi)
               	leaq	0x28(%rdi), %rcx
               	movl	$0xa, %edx
               	movl	%edx, 0x24(%rcx)
               	movslq	0x24(%rdi), %rdx
               	leaq	0x28(%rdi), %rcx
               	movslq	0x24(%rcx), %rcx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movl	%eax, 0xa0(%rdi)
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	leaq	-0xa8(%rbp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rax
               	movslq	0x14(%rax), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rax
               	movslq	0x3c(%rax), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rax
               	movslq	0xa0(%rax), %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
