
layout_nested_loops.x64:	file format elf64-x86-64

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
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rax), %rsi
               	movslq	%esi, %rsi
               	imulq	$0x55555556, %rsi, %rdi # imm = 0x55555556
               	sarq	$0x20, %rdi
               	movq	%rdi, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rdi
               	leaq	(%rdi,%rdi,2), %rdi
               	subq	%rdi, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	jmp	<addr>
               	cmpl	$0x4, %eax
               	jne	<addr>
               	jmp	<addr>
               	addq	%rax, %rcx
               	movslq	%eax, %rax
               	incq	%rax
               	cmpl	%edx, %eax
               	jl	<addr>
               	addq	%rdx, %rcx
               	movslq	%edx, %rax
               	leaq	0x1(%rax), %rdx
               	cmpl	$0x6, %edx
               	jl	<addr>
               	movslq	%ecx, %rax
               	retq
