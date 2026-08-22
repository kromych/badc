
inttypes_header.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	movabsq	$-0x4, %rax
               	movq	%rax, -0x8(%rbp)
               	movl	$0x4, %eax
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	xorq	%rcx, %rcx
               	xorq	%rax, %rax
               	xorq	%rcx, %rcx
               	xorq	%rcx, %rcx
               	xorq	%rax, %rax
               	xorq	%rcx, %rcx
               	xorq	%rcx, %rcx
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rcx, %rcx
               	xorq	%rcx, %rcx
               	xorq	%rax, %rax
               	xorq	%rcx, %rcx
               	xorq	%rax, %rax
               	xorq	%rcx, %rcx
               	xorq	%rcx, %rcx
               	xorq	%rax, %rax
               	xorq	%rcx, %rcx
               	xorq	%rcx, %rcx
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
