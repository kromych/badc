
designator_chain_runtime_multidim.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x30(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movl	$0x7, %edx
               	movl	%edx, 0x4(%rax)
               	movl	$0x1e, %edx
               	movl	%edx, 0x8(%rax)
               	movl	$0x28, %edx
               	movl	%edx, 0xc(%rax)
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	leaq	-0x38(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movl	$0x7, %edx
               	movl	%edx, 0x4(%rax)
               	movl	%edx, 0x8(%rax)
               	movl	$0x1, %edx
               	movl	%edx, 0x10(%rax)
               	movq	%rcx, %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	leaq	-0x38(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movl	$0x7, %edx
               	movl	%edx, 0x10(%rax)
               	movl	$0x6, %esi
               	movl	%esi, 0x14(%rax)
               	movl	$0x8, %esi
               	movl	%esi, 0x18(%rax)
               	movl	$0x9, %esi
               	movl	%esi, 0x1c(%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	leaq	-0x38(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movl	%edx, 0xc(%rax)
               	movl	$0x2, %edx
               	movl	%edx, 0x10(%rax)
               	movl	$0x3, %edx
               	movl	%edx, 0x14(%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
