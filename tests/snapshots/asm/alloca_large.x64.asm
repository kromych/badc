
alloca_large.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	movl	$0x100000, %eax         # imm = 0x100000
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	movq	%rax, %rsp
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	movl	$0x1, %ecx
               	movb	%cl, (%rax)
               	movq	-0x10(%rbp), %rax
               	movq	-0x8(%rbp), %rcx
               	decq	%rcx
               	addq	%rcx, %rax
               	movl	$0x2, %ecx
               	movb	%cl, (%rax)
               	movl	$0x1000, %eax           # imm = 0x1000
               	movq	%rax, -0x18(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rax
               	movq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movl	$0x3, %ecx
               	movb	%cl, (%rax)
               	movq	-0x18(%rbp), %rax
               	addq	$0x1000, %rax           # imm = 0x1000
               	movq	%rax, -0x18(%rbp)
               	movq	-0x18(%rbp), %rax
               	movq	-0x8(%rbp), %rcx
               	decq	%rcx
               	cmpq	%rcx, %rax
               	jl	<addr>
               	movq	-0x10(%rbp), %rax
               	movsbq	(%rax), %rcx
               	movq	-0x8(%rbp), %rdx
               	decq	%rdx
               	addq	%rdx, %rax
               	movsbq	(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movl	$0x2a, %eax
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	movslq	%eax, %rax
               	leaq	-0x30(%rbp), %rsp
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	%rax, -0x28(%rbp)
               	jmp	<addr>
