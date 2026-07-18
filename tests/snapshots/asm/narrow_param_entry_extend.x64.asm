
narrow_param_entry_extend.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	movslq	%esi, %rax
               	movsbq	%al, %rdi
               	movswq	%ax, %r8
               	xorq	%rax, %rax
               	movl	%eax, -0x28(%rbp)
               	jmp	<addr>
               	movslq	-0x28(%rbp), %rcx
               	addq	%rax, %rcx
               	movl	%ecx, -0x28(%rbp)
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x3, %rdx
               	jl	<addr>
               	movslq	-0x28(%rbp), %rax
               	imulq	$0x186a0, %rdi, %rax    # imm = 0x186A0
               	imulq	$0xa, %r8, %rcx
               	addq	%rcx, %rax
               	addq	%rsi, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x6bcd17, %rax         # imm = 0x6BCD17
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x38(%rbp)
               	jmp	<addr>
               	movslq	-0x38(%rbp), %rcx
               	addq	%rax, %rcx
               	movl	%ecx, -0x38(%rbp)
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x3, %rdx
               	jl	<addr>
               	movslq	-0x38(%rbp), %rax
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
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
