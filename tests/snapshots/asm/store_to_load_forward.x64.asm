
store_to_load_forward.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	xorq	%rcx, %rcx
               	movq	%rcx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x15, %edx
               	movq	%rdx, (%rax)
               	movl	$0x5, %edx
               	movq	%rdx, -0x8(%rbp)
               	movl	$0x9, %edx
               	movq	%rdx, (%rax)
               	movq	%rdx, (%rax)
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
