
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
               	movslq	(%rax), %rdx
               	movslq	%edx, %rax
               	movsbq	%al, %rsi
               	movswq	%ax, %rdi
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rcx
               	addq	%rax, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movslq	%eax, %rax
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movslq	-0x8(%rbp), %rax
               	imulq	$0x186a0, %rsi, %rax    # imm = 0x186A0
               	imulq	$0xa, %rdi, %rcx
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	cmpl	$0x6bcd17, %eax         # imm = 0x6BCD17
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rcx
               	addq	%rax, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movslq	%eax, %rax
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movslq	-0x8(%rbp), %rax
               	movq	%rdx, %rax
               	andq	$0xff, %rax
               	imulq	$0x186a0, %rax, %rax    # imm = 0x186A0
               	movl	%eax, %eax
               	movq	%rdx, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	cmpl	$0x696c65, %eax         # imm = 0x696C65
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
