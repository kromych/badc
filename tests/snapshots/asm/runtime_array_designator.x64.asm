
runtime_array_designator.x64:	file format elf64-x86-64

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

<check>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0x7, %edx
               	movl	$0x3, %esi
               	movl	$0x5, %edi
               	leaq	-0x18(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movl	%edx, 0xc(%rax)
               	movl	%esi, 0x4(%rax)
               	movl	%edi, 0x8(%rax)
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x7, %edi
               	movl	$0x3, %esi
               	movl	$0x5, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
