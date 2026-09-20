
inline_asm_x64_const_expr.x64:	file format elf64-x86-64

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
               	subq	$0x38, %rsp
               	pushq	%rbx
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	popq	%rdx
               	movq	$0x0, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
               	leaq	-0x20(%rbp), %rbx
               	leaq	-0x20(%rbp), %rcx
               	addq	(%rbx), %rax
               	adcq	0x8(%rbx), %rax
               	adcq	0x10(%rbx), %rax
               	adcq	0x18(%rbx), %rax
               	adcq	$0x0, %rax
               	movq	%rax, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x20(%rbp), %rax
               	movq	$0x64, 0x18(%rax)
               	movq	$0x0, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
               	leaq	-0x20(%rbp), %rbx
               	leaq	-0x20(%rbp), %rcx
               	addq	(%rbx), %rax
               	adcq	0x8(%rbx), %rax
               	adcq	0x10(%rbx), %rax
               	adcq	0x18(%rbx), %rax
               	adcq	$0x0, %rax
               	movq	%rax, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
               	cmpq	$0x6a, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$0x0, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	addq	$0x19, %rax
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x19, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
