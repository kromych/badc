
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
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %edx
               	movsbq	%dl, %rsi
               	movswq	%dx, %rdi
               	xorl	%eax, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %ecx
               	addq	%rax, %rcx
               	movl	%ecx, -0x8(%rbp)
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movl	-0x8(%rbp), %eax
               	imulq	$0x186a0, %rsi, %rax    # imm = 0x186A0
               	imulq	$0xa, %rdi, %rcx
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	cmpl	$0x6bcd17, %eax         # imm = 0x6BCD17
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %ecx
               	addq	%rax, %rcx
               	movl	%ecx, -0x8(%rbp)
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movl	-0x8(%rbp), %eax
               	movq	%rdx, %rax
               	andq	$0xff, %rax
               	imulq	$0x186a0, %rax, %rax    # imm = 0x186A0
               	movq	%rdx, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	addq	%rcx, %rax
               	cmpl	$0x696c65, %eax         # imm = 0x696C65
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
