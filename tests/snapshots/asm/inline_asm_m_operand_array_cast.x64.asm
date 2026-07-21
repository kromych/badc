
inline_asm_m_operand_array_cast.x64:	file format elf64-x86-64

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
               	subq	$0x70, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movabsq	$0x1111111111111111, %rdx # imm = 0x1111111111111111
               	movq	%rdx, (%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movabsq	$0x2222222222222222, %rdx # imm = 0x2222222222222222
               	movq	%rdx, 0x8(%rcx)
               	xorq	%rcx, %rcx
               	movq	%rcx, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rcx
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rbx, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rax, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movq	-0x58(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x50(%rbp), %rbx
               	movq	-0x48(%rbp), %rcx
               	addq	(%rbx), %rax
               	adcq	0x8(%rbx), %rax
               	adcq	$0x0, %rax
               	movq	-0x58(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rcx
               	movq	-0x60(%rbp), %rbx
               	movq	-0x30(%rbp), %rcx
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rcx
               	movl	$0x5, %edx
               	movq	%rdx, (%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movl	$0x9, %edx
               	movq	%rdx, 0x8(%rcx)
               	xorq	%rcx, %rcx
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rcx
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rbx, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rax, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movq	-0x58(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x50(%rbp), %rbx
               	movq	-0x48(%rbp), %rcx
               	addq	(%rbx), %rax
               	adcq	0x8(%rbx), %rax
               	adcq	$0x0, %rax
               	movq	-0x58(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rcx
               	movq	-0x60(%rbp), %rbx
               	movq	-0x38(%rbp), %rcx
               	cmpq	$0xe, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, -0x70(%rbp)
               	movq	%rbx, -0x68(%rbp)
               	movq	%rax, -0x60(%rbp)
               	movq	%rax, -0x58(%rbp)
               	movq	-0x60(%rbp), %rax
               	movq	-0x58(%rbp), %rbx
               	movq	$0x0, (%rbx)
               	movq	$0x0, 0x8(%rbx)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rbx
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
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
