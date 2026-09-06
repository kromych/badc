
gettimeofday_usec_range.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rdi
               	xorq	%rsi, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	movq	0x8(%rax), %rcx
               	cmpq	$0xf4240, %rcx          # imm = 0xF4240
               	setge	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	jle	<addr>
               	movslq	%ebx, %rax
               	leaq	0x1(%rax), %rbx
               	cmpl	$0x64, %ebx
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
