
inline_asm_x64_segment.x64:	file format elf64-x86-64

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
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	%fs:0x0, %rax
               	movq	-0x38(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x40(%rbp), %rax
               	movq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	-0x8(%rbp), %rcx
               	movq	%rax, -0x40(%rbp)
               	movq	%rbx, -0x38(%rbp)
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	-0x28(%rbp), %rbx
               	movq	(%rbx), %rax
               	movq	-0x30(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rbx
               	movq	-0x10(%rbp), %rax
               	movq	-0x8(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rax, -0x40(%rbp)
               	movq	%rbx, -0x38(%rbp)
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	-0x28(%rbp), %rbx
               	movq	%fs:(%rbx), %rax
               	movq	-0x30(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rbx
               	movq	-0x18(%rbp), %rax
               	movq	-0x8(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
