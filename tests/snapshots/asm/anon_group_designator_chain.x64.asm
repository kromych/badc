
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
               	leaq	-0x30(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movq	%rcx, 0x20(%rax)
               	movq	%rcx, 0x28(%rax)
               	movl	$0x1, %edi
               	movl	%edi, (%rax)
               	movl	%edx, 0x8(%rax)
               	movl	%esi, 0xc(%rax)
               	leaq	-0x38(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movq	%rcx, 0x20(%rax)
               	movq	%rcx, 0x28(%rax)
               	movl	%ecx, 0x30(%rax)
               	movl	$0x2, %ecx
               	movl	%ecx, (%rax)
               	movl	%edx, 0xc(%rax)
               	movl	%esi, 0x10(%rax)
               	movl	%edx, 0x2c(%rax)
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
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
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	leaq	-0x38(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	movq	0x10(%rdx), %rax
               	movq	%rax, 0x10(%rcx)
               	movq	0x18(%rdx), %rax
               	movq	%rax, 0x18(%rcx)
               	movq	0x20(%rdx), %rax
               	movq	%rax, 0x20(%rcx)
               	movq	0x28(%rdx), %rax
               	movq	%rax, 0x28(%rcx)
               	movzbq	0x30(%rdx), %rax
               	movb	%al, 0x30(%rcx)
               	movzbq	0x31(%rdx), %rax
               	movb	%al, 0x31(%rcx)
               	movzbq	0x32(%rdx), %rax
               	movb	%al, 0x32(%rcx)
               	movzbq	0x33(%rdx), %rax
               	movb	%al, 0x33(%rcx)
               	popq	%rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movl	$0x14, %edi
               	movl	$0x16, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
