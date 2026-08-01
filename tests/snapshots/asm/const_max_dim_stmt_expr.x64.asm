
const_max_dim_stmt_expr.x64:	file format elf64-x86-64

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
               	subq	$0x80, %rsp
               	movl	$0x20, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rax, %rsp
               	movl	$0x7, %ecx
               	movq	%rcx, (%rax)
               	movq	(%rax), %rax
               	subq	$0x7, %rax
               	addq	$0x0, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x80(%rbp), %rsp
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
