
branch_relaxation.x64:	file format elf64-x86-64

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

<classify>:
               	movslq	%edi, %rdi
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	imulq	$0x55555556, %rdx, %rsi # imm = 0x55555556
               	sarq	$0x20, %rsi
               	movq	%rsi, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rsi
               	leaq	(%rsi,%rsi,2), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	addq	%rcx, %rax
               	jmp	<addr>
               	imulq	$0x55555556, %rdx, %rsi # imm = 0x55555556
               	sarq	$0x20, %rsi
               	movq	%rsi, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rsi
               	leaq	(%rsi,%rsi,2), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
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
               	movslq	%eax, %rax
               	retq

<main>:
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	imulq	$0x55555556, %rdx, %rsi # imm = 0x55555556
               	sarq	$0x20, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	leaq	(%rsi,%rsi,2), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	addq	%rcx, %rax
               	jmp	<addr>
               	imulq	$0x55555556, %rdx, %rsi # imm = 0x55555556
               	sarq	$0x20, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	leaq	(%rsi,%rsi,2), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
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
               	movslq	%eax, %rax
               	retq
