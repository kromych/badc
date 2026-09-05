
struct_arg_in_registers.x64:	file format elf64-x86-64

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

<mutate>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movl	$0x12c, %eax            # imm = 0x12C
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	-0x40(%rbp), %rax
               	movl	$0x3, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x5, %edx
               	movl	%edx, 0x4(%rax)
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rsi
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	cmpl	$0x8, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movslq	(%rax), %rcx
               	imulq	$0xa, %rcx, %rcx
               	addq	$0x9, %rcx
               	movslq	0x4(%rax), %rsi
               	imulq	$0x64, %rsi, %rsi
               	addq	%rsi, %rcx
               	addq	$0x7d0, %rcx            # imm = 0x7D0
               	movslq	%ecx, %rcx
               	cmpl	$0x9eb, %ecx            # imm = 0x9EB
               	je	<addr>
               	movq	%rdx, %rax
               	leave
               	retq
               	movslq	(%rax), %rcx
               	addq	$0xa, %rcx
               	addq	$0x3, %rcx
               	addq	$0x4, %rcx
               	movslq	%ecx, %rcx
               	cmpl	$0x14, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movq	%rax, %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x40(%rbp), %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movslq	0x4(%rax), %rax
               	cmpl	$0x5, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
