
layout_nested_loops.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rax), %rdi
               	movslq	%edi, %rdi
               	movl	$0x3, %r9d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r9
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	testq	%rdi, %rdi
               	jne	<addr>
               	jmp	<addr>
               	cmpq	$0x4, %rsi
               	jne	<addr>
               	jmp	<addr>
               	addq	%rax, %rcx
               	leaq	0x1(%rsi), %rax
               	movslq	%eax, %rsi
               	cmpq	%r8, %rsi
               	jl	<addr>
               	addq	%rdx, %rcx
               	leaq	0x1(%r8), %rdx
               	movslq	%edx, %r8
               	cmpq	$0x6, %r8
               	jl	<addr>
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	retq
