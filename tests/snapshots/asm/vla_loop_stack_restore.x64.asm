
vla_loop_stack_restore.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	movl	$0x1, %eax
               	movl	%eax, -0x8(%rbp)
               	xorq	%rax, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movl	%eax, -0x20(%rbp)
               	jmp	<addr>
               	movq	%rsp, %rax
               	movq	%rax, -0x40(%rbp)
               	movslq	-0x8(%rbp), %rax
               	shlq	$0x12, %rax
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	movq	%rax, -0x38(%rbp)
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	movq	%rax, %rsp
               	movq	%rax, -0x30(%rbp)
               	movq	-0x30(%rbp), %rcx
               	movslq	-0x20(%rbp), %rax
               	movb	%al, (%rcx)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rcx
               	decq	%rcx
               	leaq	(%rax,%rcx), %rdx
               	movslq	-0x20(%rbp), %rax
               	incq	%rax
               	movslq	%eax, %rcx
               	movb	%cl, (%rdx)
               	movslq	-0x20(%rbp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x30(%rbp), %rax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x18(%rbp), %rcx
               	movq	-0x30(%rbp), %rax
               	movsbq	(%rax), %rdx
               	movq	-0x28(%rbp), %rsi
               	decq	%rsi
               	addq	%rsi, %rax
               	movsbq	(%rax), %rax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	movq	%rax, -0x18(%rbp)
               	movq	-0x40(%rbp), %rax
               	movq	%rax, %rsp
               	jmp	<addr>
               	movq	-0x30(%rbp), %rax
               	movq	-0x10(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x20(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x20(%rbp)
               	movslq	-0x20(%rbp), %rax
               	cmpq	$0x40, %rax
               	jl	<addr>
               	movq	-0x18(%rbp), %rax
               	cmpq	$0x1000, %rax           # imm = 0x1000
               	jne	<addr>
               	movl	$0x2a, %eax
               	movq	%rax, -0x50(%rbp)
               	movq	-0x50(%rbp), %rax
               	movslq	%eax, %rax
               	leaq	-0x50(%rbp), %rsp
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	movq	%rax, -0x50(%rbp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	leaq	-0x50(%rbp), %rsp
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
