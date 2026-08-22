
anon_group_designator_chain.x64:	file format elf64-x86-64

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

<check_runtime>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movl	$0x14, %edx
               	movl	$0x16, %esi
               	leaq	-0x30(%rbp), %rcx
               	xorq	%rax, %rax
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	movq	%rax, 0x10(%rcx)
               	movq	%rax, 0x18(%rcx)
               	movq	%rax, 0x20(%rcx)
               	movq	%rax, 0x28(%rcx)
               	movl	$0x1, %ecx
               	leaq	-0x30(%rbp), %rdi
               	movl	%ecx, (%rdi)
               	leaq	-0x30(%rbp), %rcx
               	movl	%edx, 0x8(%rcx)
               	leaq	-0x30(%rbp), %rcx
               	movl	%esi, 0xc(%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	movq	%rax, 0x10(%rcx)
               	movq	%rax, 0x18(%rcx)
               	movq	%rax, 0x20(%rcx)
               	movq	%rax, 0x28(%rcx)
               	movl	%eax, 0x30(%rcx)
               	movl	$0x2, %eax
               	leaq	-0x38(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x38(%rbp), %rax
               	movl	%edx, 0xc(%rax)
               	leaq	-0x38(%rbp), %rax
               	movl	%esi, 0x10(%rax)
               	leaq	-0x38(%rbp), %rax
               	movl	%edx, 0x2c(%rax)
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x20(%rax)
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	popq	%rdx
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	leaq	-0x38(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x20(%rax)
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	movzbq	0x30(%rcx), %rdx
               	movb	%dl, 0x30(%rax)
               	movzbq	0x31(%rcx), %rdx
               	movb	%dl, 0x31(%rax)
               	movzbq	0x32(%rcx), %rdx
               	movb	%dl, 0x32(%rax)
               	movzbq	0x33(%rcx), %rdx
               	movb	%dl, 0x33(%rax)
               	popq	%rdx
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	movl	$0x14, %edi
               	movl	$0x16, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
