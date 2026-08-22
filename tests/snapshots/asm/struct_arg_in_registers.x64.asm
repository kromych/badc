
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
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movl	$0x12c, %eax            # imm = 0x12C
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	-0x40(%rbp), %rax
               	movl	$0x3, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x5, %esi
               	movl	%esi, 0x4(%rax)
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0x8, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	(%rax), %rcx
               	imulq	$0xa, %rcx, %rcx
               	addq	$0x9, %rcx
               	movslq	0x4(%rax), %rdx
               	imulq	$0x64, %rdx, %rdx
               	addq	%rdx, %rcx
               	addq	$0x7d0, %rcx            # imm = 0x7D0
               	movslq	%ecx, %rcx
               	cmpq	$0x9eb, %rcx            # imm = 0x9EB
               	je	<addr>
               	movq	%rsi, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	(%rax), %rsi
               	movslq	0x4(%rax), %rcx
               	shlq	%rcx
               	addq	%rsi, %rcx
               	addq	$0x3, %rcx
               	addq	$0x4, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0x14, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	0x4(%rcx), %rax
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
