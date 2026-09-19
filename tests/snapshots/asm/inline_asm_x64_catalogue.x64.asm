
inline_asm_x64_catalogue.x64:	file format elf64-x86-64

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
               	movq	$-0x14, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	negq	%rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	movq	$-0x8, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	notq	%rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rdx
               	movl	$0x64, %eax
               	movq	%rax, -0x28(%rbp)
               	movl	$0xf, %eax
               	movq	%rax, -0x20(%rbp)
               	movq	-0x28(%rbp), %rax
               	movq	-0x20(%rbp), %rbx
               	xchgq	%rbx, %rax
               	movq	%rax, -0x28(%rbp)
               	movq	%rbx, -0x20(%rbp)
               	movl	$0x5, %eax
               	movq	%rax, -0x18(%rbp)
               	movq	-0x18(%rbp), %rax
               	rolq	%rax
               	movq	%rax, -0x18(%rbp)
               	movl	$0x14, %eax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	movl	$0x16, %ebx
               	addq	$0x0, %rax
               	adcq	%rbx, %rax
               	movq	%rax, -0x10(%rbp)
               	cmpq	$0x14, %rcx
               	jne	<addr>
               	cmpq	$0x7, %rdx
               	jne	<addr>
               	movq	-0x28(%rbp), %rax
               	cmpq	$0xf, %rax
               	jne	<addr>
               	movq	-0x20(%rbp), %rax
               	cmpq	$0x64, %rax
               	jne	<addr>
               	movq	-0x18(%rbp), %rax
               	cmpq	$0xa, %rax
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x2a, %rax
               	jne	<addr>
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
