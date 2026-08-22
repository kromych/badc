
typedef_struct_carrier_reset.x64:	file format elf64-x86-64

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

<zero_and_sum>:
               	xorq	%rax, %rax
               	leaq	(%rdi), %rdx
               	movl	%eax, (%rdx)
               	leaq	0x28(%rdi), %rax
               	leaq	(%rax), %rsi
               	movl	$0x1, %ecx
               	movl	%ecx, (%rsi)
               	movslq	(%rdx), %rdx
               	movslq	%ecx, %rsi
               	addq	%rsi, %rdx
               	addq	$0x0, %rdx
               	movl	%ecx, 0x4(%rdi)
               	movl	$0x2, %ecx
               	movl	%ecx, 0x4(%rax)
               	movslq	0x4(%rdi), %rsi
               	movslq	%ecx, %r8
               	addq	%r8, %rsi
               	addq	%rsi, %rdx
               	movl	%ecx, 0x8(%rdi)
               	movl	$0x3, %esi
               	movl	%esi, 0x8(%rax)
               	movslq	0x8(%rdi), %rcx
               	leaq	0x28(%rdi), %rax
               	movslq	0x8(%rax), %r8
               	addq	%r8, %rcx
               	addq	%rdx, %rcx
               	movl	%esi, 0xc(%rdi)
               	movl	$0x4, %edx
               	movl	%edx, 0xc(%rax)
               	movslq	0xc(%rdi), %rsi
               	movslq	%edx, %r8
               	addq	%r8, %rsi
               	addq	%rsi, %rcx
               	movl	%edx, 0x10(%rdi)
               	movl	$0x5, %edx
               	movl	%edx, 0x10(%rax)
               	movslq	0x10(%rdi), %rsi
               	movslq	%edx, %r8
               	addq	%r8, %rsi
               	addq	%rsi, %rcx
               	movl	%edx, 0x14(%rdi)
               	movl	$0x6, %esi
               	movl	%esi, 0x14(%rax)
               	movslq	0x14(%rdi), %rdx
               	leaq	0x28(%rdi), %rax
               	movslq	0x14(%rax), %r8
               	addq	%r8, %rdx
               	addq	%rdx, %rcx
               	movl	%esi, 0x18(%rdi)
               	movl	$0x7, %edx
               	movl	%edx, 0x18(%rax)
               	movslq	0x18(%rdi), %rsi
               	movslq	%edx, %r8
               	addq	%r8, %rsi
               	addq	%rsi, %rcx
               	movl	%edx, 0x1c(%rdi)
               	movl	$0x8, %edx
               	movl	%edx, 0x1c(%rax)
               	movslq	0x1c(%rdi), %rsi
               	movslq	%edx, %r8
               	addq	%r8, %rsi
               	addq	%rsi, %rcx
               	movl	%edx, 0x20(%rdi)
               	movl	$0x9, %esi
               	movl	%esi, 0x20(%rax)
               	movslq	0x20(%rdi), %rdx
               	leaq	0x28(%rdi), %rax
               	movslq	0x20(%rax), %r8
               	addq	%r8, %rdx
               	addq	%rdx, %rcx
               	movl	%esi, 0x24(%rdi)
               	movl	$0xa, %edx
               	movl	%edx, 0x24(%rax)
               	movslq	0x24(%rdi), %rsi
               	movslq	%edx, %rax
               	addq	%rsi, %rax
               	addq	%rcx, %rax
               	movl	%eax, 0xa0(%rdi)
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	leaq	-0xa8(%rbp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rax
               	movslq	0x14(%rax), %rcx
               	cmpq	$0x5, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movslq	0x3c(%rax), %rcx
               	cmpq	$0x6, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movslq	0xa0(%rax), %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
