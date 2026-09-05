
inline_asm_m_operand_array_cast.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	leaq	-0x18(%rbp), %rax
               	movabsq	$0x1111111111111111, %rcx # imm = 0x1111111111111111
               	movq	%rcx, (%rax)
               	movabsq	$0x2222222222222222, %rcx # imm = 0x2222222222222222
               	movq	%rcx, 0x8(%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	%rbx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rax, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	-0x38(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x30(%rbp), %rbx
               	movq	-0x28(%rbp), %rcx
               	addq	(%rbx), %rax
               	adcq	0x8(%rbx), %rax
               	adcq	$0x0, %rax
               	movq	-0x38(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rcx
               	movq	-0x40(%rbp), %rbx
               	movq	-0x8(%rbp), %rcx
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rcx
               	movl	$0x5, %edx
               	movq	%rdx, (%rcx)
               	movl	$0x9, %edx
               	movq	%rdx, 0x8(%rcx)
               	xorq	%rcx, %rcx
               	movq	%rcx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	%rbx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rax, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	-0x38(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x30(%rbp), %rbx
               	movq	-0x28(%rbp), %rcx
               	addq	(%rbx), %rax
               	adcq	0x8(%rbx), %rax
               	adcq	$0x0, %rax
               	movq	-0x38(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rcx
               	movq	-0x40(%rbp), %rbx
               	movq	-0x8(%rbp), %rcx
               	cmpq	$0xe, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	%rax, -0x50(%rbp)
               	movq	%rbx, -0x48(%rbp)
               	movq	%rax, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rbx
               	movq	$0x0, (%rbx)
               	movq	$0x0, 0x8(%rbx)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rbx
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax), %rdx
               	testq	%rdx, %rdx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
               	jmp	<addr>
