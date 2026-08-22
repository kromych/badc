
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rax), %rdi
               	movslq	%edi, %rdi
               	imulq	$0x55555556, %rdi, %r8  # imm = 0x55555556
               	sarq	$0x20, %r8
               	movq	%r8, %rbx
               	shrq	$0x3f, %rbx
               	addq	%rbx, %r8
               	leaq	(%r8,%r8,2), %r8
               	subq	%r8, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	jmp	<addr>
               	cmpq	$0x4, %rsi
               	jne	<addr>
               	jmp	<addr>
               	addq	%rax, %rcx
               	leaq	0x1(%rsi), %rax
               	movslq	%eax, %rsi
               	cmpq	%r9, %rsi
               	jl	<addr>
               	addq	%rdx, %rcx
               	leaq	0x1(%r9), %rdx
               	movslq	%edx, %r9
               	cmpq	$0x6, %r9
               	jl	<addr>
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
