
inline_asm_m_operand_array_cast.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sum_two_quads>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	xorq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rbx, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	%rdi, -0x20(%rbp)
               	movq	%rdi, -0x18(%rbp)
               	movq	-0x28(%rbp), %r11
               	movq	(%r11), %rax
               	movq	-0x20(%rbp), %rbx
               	movq	-0x18(%rbp), %rcx
               	addq	(%rbx), %rax
               	adcq	0x8(%rbx), %rax
               	adcq	$0x0, %rax
               	movq	-0x28(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rcx
               	movq	-0x30(%rbp), %rbx
               	movq	-0x8(%rbp), %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<fill_region>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rax, -0x20(%rbp)
               	movq	%rbx, -0x18(%rbp)
               	movq	%rdi, -0x10(%rbp)
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x10(%rbp), %rax
               	movq	-0x8(%rbp), %rbx
               	movq	$0x0, (%rbx)
               	movq	$0x0, 0x8(%rbx)
               	movq	-0x20(%rbp), %rax
               	movq	-0x18(%rbp), %rbx
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x10(%rbp), %rbx
               	leaq	-0x10(%rbp), %rax
               	movabsq	$0x1111111111111111, %rcx # imm = 0x1111111111111111
               	movq	%rcx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movabsq	$0x2222222222222222, %rcx # imm = 0x2222222222222222
               	movq	%rcx, 0x8(%rax)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	$0x5, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x9, %ecx
               	movq	%rcx, 0x8(%rax)
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0xe, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
