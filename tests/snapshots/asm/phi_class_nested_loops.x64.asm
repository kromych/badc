
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
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	incq	%rcx
               	cmpl	%edi, %ecx
               	jl	<addr>
               	addq	%rsi, %rax
               	movslq	%eax, %rsi
               	movslq	%r8d, %rax
               	leaq	0x1(%rax), %r8
               	cmpl	%edi, %r8d
               	jl	<addr>
               	movslq	%esi, %rax
               	retq

<main>:
               	xorq	%rsi, %rsi
               	movq	%rsi, %rdi
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	incq	%rcx
               	cmpl	$0x7, %ecx
               	jl	<addr>
               	addq	%rsi, %rax
               	movslq	%eax, %rsi
               	movslq	%edi, %rax
               	leaq	0x1(%rax), %rdi
               	cmpl	$0x7, %edi
               	jl	<addr>
               	movslq	%esi, %rax
               	retq
