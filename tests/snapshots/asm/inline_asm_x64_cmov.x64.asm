
inline_asm_x64_cmov.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<max_asm>:
               	popq	%r10
               	subq	$0x20, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, 0x10(%rbp)
               	leaq	0x10(%rbp), %rax
               	movq	%rax, -0x20(%rbp)
               	movq	%rbx, -0x18(%rbp)
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x10(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x8(%rbp), %rbx
               	cmpq	%rbx, %rax
               	cmovlq	%rbx, %rax
               	movq	-0x10(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x20(%rbp), %rax
               	movq	-0x18(%rbp), %rbx
               	movq	0x10(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<min_asm>:
               	popq	%r10
               	subq	$0x20, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, 0x10(%rbp)
               	leaq	0x10(%rbp), %rax
               	movq	%rax, -0x20(%rbp)
               	movq	%rbx, -0x18(%rbp)
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x10(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x8(%rbp), %rbx
               	cmpq	%rbx, %rax
               	cmovgq	%rbx, %rax
               	movq	-0x10(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x20(%rbp), %rax
               	movq	-0x18(%rbp), %rbx
               	movq	0x10(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movl	$0x14, %edi
               	movl	$0x2a, %ebx
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0xa, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movl	$0x64, %edi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	%rax, %r14
               	movl	$0x63, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rdx
               	cmpq	$0x2a, %r12
               	sete	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0x2a, %r13
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpq	$0x2a, %r14
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0x2a, %rdx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
