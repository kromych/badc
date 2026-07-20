
alloca_arena_in_bounds.x64:	file format elf64-x86-64

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
               	movl	$0x1f40, %edx           # imm = 0x1F40
               	movq	%rdx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	movq	%rax, %rsp
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rdi
               	movl	$0x3, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x10(%rbp)
               	movl	%eax, -0x18(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	movq	-0x8(%rbp), %rcx
               	movslq	-0x18(%rbp), %rdx
               	addq	%rdx, %rcx
               	movzbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x18(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x18(%rbp)
               	movslq	-0x18(%rbp), %rax
               	cmpq	$0x1f40, %rax           # imm = 0x1F40
               	jl	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpq	$0x5dc0, %rax           # imm = 0x5DC0
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
               	movslq	%eax, %rax
               	leaq	-0x30(%rbp), %rsp
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	%rax, -0x30(%rbp)
               	jmp	<addr>
