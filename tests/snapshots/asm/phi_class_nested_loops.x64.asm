
phi_class_nested_loops.x64:	file format elf64-x86-64

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

<test>:
               	xorq	%rsi, %rsi
               	movq	%rsi, %r8
               	cmpl	%edi, %r8d
               	jge	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	cmpl	%edi, %ecx
               	jge	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpl	%edi, %ecx
               	jl	<addr>
               	addq	%rax, %rsi
               	incq	%r8
               	cmpl	%edi, %r8d
               	jl	<addr>
               	movslq	%esi, %rax
               	retq

<main>:
               	xorq	%rsi, %rsi
               	movq	%rsi, %rdi
               	cmpl	$0x7, %edi
               	jge	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	cmpl	$0x7, %ecx
               	jge	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpl	$0x7, %ecx
               	jl	<addr>
               	addq	%rax, %rsi
               	incq	%rdi
               	cmpl	$0x7, %edi
               	jl	<addr>
               	movslq	%esi, %rax
               	retq
