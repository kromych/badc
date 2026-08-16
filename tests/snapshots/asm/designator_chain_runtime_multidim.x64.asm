
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
               	subq	$0xa0, %rsp
               	leaq	-0x18(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movl	$0x7, %ecx
               	leaq	-0x18(%rbp), %rax
               	movl	%ecx, 0x4(%rax)
               	movl	$0x1e, %ecx
               	leaq	-0x18(%rbp), %rax
               	movl	%ecx, 0x8(%rax)
               	movl	$0x28, %ecx
               	leaq	-0x18(%rbp), %rax
               	movl	%ecx, 0xc(%rax)
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	leaq	-0x50(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movl	$0x7, %ecx
               	leaq	-0x50(%rbp), %rax
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x50(%rbp), %rax
               	movl	$0x7, %ecx
               	movl	%ecx, 0x8(%rax)
               	movl	$0x1, %ecx
               	leaq	-0x50(%rbp), %rax
               	movl	%ecx, 0x10(%rax)
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	leaq	-0x70(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movl	$0x7, %ecx
               	leaq	-0x70(%rbp), %rax
               	movl	%ecx, 0x10(%rax)
               	movl	$0x6, %ecx
               	leaq	-0x70(%rbp), %rax
               	movl	%ecx, 0x14(%rax)
               	movl	$0x8, %ecx
               	leaq	-0x70(%rbp), %rax
               	movl	%ecx, 0x18(%rax)
               	movl	$0x9, %ecx
               	leaq	-0x70(%rbp), %rax
               	movl	%ecx, 0x1c(%rax)
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	leaq	-0x90(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movl	$0x7, %ecx
               	leaq	-0x90(%rbp), %rax
               	movl	%ecx, 0xc(%rax)
               	movl	$0x2, %ecx
               	leaq	-0x90(%rbp), %rax
               	movl	%ecx, 0x10(%rax)
               	movl	$0x3, %ecx
               	leaq	-0x90(%rbp), %rax
               	movl	%ecx, 0x14(%rax)
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
