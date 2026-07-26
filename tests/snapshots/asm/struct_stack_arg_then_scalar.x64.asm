
struct_stack_arg_then_scalar.x64:	file format elf64-x86-64

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
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x48(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x20(%rbp), %rsi
               	leaq	<rip>, %rdi
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdi), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	leaq	<rip>, %r8
               	pushq	%rax
               	movq	(%r8), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%r8), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	leaq	-0x10(%rbp), %rdi
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	imulq	$0xf4240, %rax, %rax    # imm = 0xF4240
               	movslq	%eax, %rax
               	movq	0x8(%rcx), %rcx
               	imulq	$0x2710, %rcx, %rcx     # imm = 0x2710
               	addq	%rcx, %rax
               	addq	$0x1b58, %rax           # imm = 0x1B58
               	movq	0x8(%rdx), %rcx
               	imulq	$0x64, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x8(%rsi), %rcx
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x8(%rdi), %rcx
               	addq	%rcx, %rax
               	addq	$0x5, %rax
               	cmpq	$0x127a9e, %rax         # imm = 0x127A9E
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
