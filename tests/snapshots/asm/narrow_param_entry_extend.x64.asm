
narrow_param_entry_extend.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	movslq	%esi, %rax
               	movsbq	%al, %rdi
               	movswq	%ax, %r8
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rdx
               	addq	%rax, %rdx
               	movl	%edx, -0x8(%rbp)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x3, %rcx
               	jl	<addr>
               	movslq	-0x8(%rbp), %rax
               	imulq	$0x186a0, %rdi, %rax    # imm = 0x186A0
               	imulq	$0xa, %r8, %rcx
               	addq	%rcx, %rax
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	cmpq	$0x6bcd17, %rax         # imm = 0x6BCD17
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rdx
               	addq	%rax, %rdx
               	movl	%edx, -0x8(%rbp)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x3, %rcx
               	jl	<addr>
               	movslq	-0x8(%rbp), %rax
               	movq	%rsi, %rax
               	andq	$0xff, %rax
               	imulq	$0x186a0, %rax, %rax    # imm = 0x186A0
               	movl	%eax, %eax
               	movq	%rsi, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	cmpq	$0x696c65, %rax         # imm = 0x696C65
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
