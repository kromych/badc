
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%rdi, %r13
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movslq	%ecx, %rdx
               	imulq	$0x55555556, %rdx, %rdi # imm = 0x55555556
               	movq	%rdi, %rsi
               	sarq	$0x20, %rsi
               	movq	%rsi, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rsi,%r8), %r9
               	leaq	(%r9,%r9,2), %rbx
               	movq	%rdx, %r12
               	subq	%rbx, %r12
               	testq	%r12, %r12
               	jne	<addr>
               	addq	%rcx, %rax
               	jmp	<addr>
               	movq	%rdx, %rsi
               	subq	%rbx, %rsi
               	cmpq	$0x1, %rsi
               	jne	<addr>
               	decq	%rax
               	jmp	<addr>
               	addq	$0x2, %rax
               	jmp	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	%r13d, %ecx
               	jl	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movslq	%ecx, %rdx
               	imulq	$0x55555556, %rdx, %r8  # imm = 0x55555556
               	movq	%r8, %rsi
               	sarq	$0x20, %rsi
               	movq	%rsi, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rsi,%r9), %rbx
               	leaq	(%rbx,%rbx,2), %r12
               	movq	%rdx, %rdi
               	subq	%r12, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	addq	%rcx, %rax
               	jmp	<addr>
               	cmpq	$0x1, %rdi
               	jne	<addr>
               	decq	%rax
               	jmp	<addr>
               	addq	$0x2, %rax
               	jmp	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0xa, %ecx
               	jl	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
