
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
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	xorl	%ecx, %ecx
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	(%rdx,%rcx), %rsi
               	movslq	%esi, %rsi
               	imulq	$0x55555556, %rsi, %rdi # imm = 0x55555556
               	sarq	$0x20, %rdi
               	movq	%rdi, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rdi
               	leaq	(%rdi,%rdi,2), %rdi
               	subq	%rdi, %rsi
               	testl	%esi, %esi
               	je	<addr>
               	cmpl	$0x4, %ecx
               	je	<addr>
               	addq	%rcx, %rax
               	incq	%rcx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	addq	%rdx, %rax
               	incq	%rdx
               	cmpl	$0x6, %edx
               	jl	<addr>
               	retq
