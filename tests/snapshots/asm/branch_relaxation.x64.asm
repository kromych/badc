
branch_relaxation.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<classify>:
               	movslq	%edi, %rdi
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movl	$0x3, %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	testq	%rsi, %rsi
               	jne	<addr>
               	addq	%rcx, %rax
               	jmp	<addr>
               	movl	$0x3, %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpq	$0x1, %rsi
               	jne	<addr>
               	decq	%rax
               	jmp	<addr>
               	addq	$0x2, %rax
               	jmp	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<main>:
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movl	$0x3, %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	testq	%rsi, %rsi
               	jne	<addr>
               	addq	%rcx, %rax
               	jmp	<addr>
               	movl	$0x3, %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpq	$0x1, %rsi
               	jne	<addr>
               	decq	%rax
               	jmp	<addr>
               	addq	$0x2, %rax
               	jmp	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0xa, %rdx
               	jl	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	retq
