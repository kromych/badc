
builtin_ffs.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<eq>:
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rdi
               	sete	%al
               	movzbq	%al, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0xff0000, %eax         # imm = 0xFF0000
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	movl	%eax, %eax
               	leaq	-0x1(%rax), %rcx
               	movq	%rax, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdx, %rcx
               	movl	%ecx, %ecx
               	movq	%rcx, %rdx
               	shrq	$0x1, %rdx
               	andq	$0x55555555, %rdx       # imm = 0x55555555
               	subq	%rdx, %rcx
               	movq	%rcx, %rdx
               	andq	$0x33333333, %rdx       # imm = 0x33333333
               	shrq	$0x2, %rcx
               	andq	$0x33333333, %rcx       # imm = 0x33333333
               	addq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x4, %rdx
               	addq	%rdx, %rcx
               	andq	$0xf0f0f0f, %rcx        # imm = 0xF0F0F0F
               	movq	%rcx, %rdx
               	shrq	$0x8, %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x10, %rdx
               	addq	%rdx, %rcx
               	andq	$0x7f, %rcx
               	incq	%rcx
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	imulq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xe, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	movl	%eax, %eax
               	leaq	-0x1(%rax), %rcx
               	movq	%rax, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdx, %rcx
               	movl	%ecx, %ecx
               	movq	%rcx, %rdx
               	shrq	$0x1, %rdx
               	andq	$0x55555555, %rdx       # imm = 0x55555555
               	subq	%rdx, %rcx
               	movq	%rcx, %rdx
               	andq	$0x33333333, %rdx       # imm = 0x33333333
               	shrq	$0x2, %rcx
               	andq	$0x33333333, %rcx       # imm = 0x33333333
               	addq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x4, %rdx
               	addq	%rdx, %rcx
               	andq	$0xf0f0f0f, %rcx        # imm = 0xF0F0F0F
               	movq	%rcx, %rdx
               	shrq	$0x8, %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x10, %rdx
               	addq	%rdx, %rcx
               	andq	$0x7f, %rcx
               	incq	%rcx
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	imulq	%rcx, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xf, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
