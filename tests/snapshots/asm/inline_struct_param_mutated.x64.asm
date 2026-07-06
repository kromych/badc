
inline_struct_param_mutated.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<bump>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	$0x64, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %rax
               	movl	$0x5, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x8(%rbp), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpq	$0x19a2d, %rax          # imm = 0x19A2D
               	jne	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %ecx
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
