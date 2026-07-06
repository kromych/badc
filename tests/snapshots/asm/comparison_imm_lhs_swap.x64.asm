
comparison_imm_lhs_swap.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x5, %ebx
               	xorq	%r12, %r12
               	testq	%rbx, %rbx
               	jle	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %r12
               	testq	%rbx, %rbx
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %r12
               	cmpq	$0xa, %rbx
               	jge	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %r12
               	cmpq	$0xa, %rbx
               	jg	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %r12
               	testq	%rbx, %rbx
               	jbe	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %r12
               	testq	%rbx, %rbx
               	jb	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %r12
               	cmpq	$0xa, %rbx
               	jae	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %r12
               	cmpq	$0xa, %rbx
               	ja	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %r12
               	cmpq	$0xa, %rbx
               	jle	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	testq	%rbx, %rbx
               	jge	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movslq	%r12d, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%r12d, %rax
               	cmpq	$0x8, %rax
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x3, %ecx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
