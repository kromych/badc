
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
               	movl	$0x5, %eax
               	xorq	%rbx, %rbx
               	testq	%rax, %rax
               	jle	<addr>
               	leaq	0x1(%rbx), %rcx
               	movslq	%ecx, %rbx
               	testq	%rax, %rax
               	jl	<addr>
               	leaq	0x1(%rbx), %rcx
               	movslq	%ecx, %rbx
               	cmpq	$0xa, %rax
               	jge	<addr>
               	leaq	0x1(%rbx), %rcx
               	movslq	%ecx, %rbx
               	cmpq	$0xa, %rax
               	jg	<addr>
               	leaq	0x1(%rbx), %rcx
               	movslq	%ecx, %rbx
               	testq	%rax, %rax
               	jbe	<addr>
               	leaq	0x1(%rbx), %rcx
               	movslq	%ecx, %rbx
               	testq	%rax, %rax
               	jb	<addr>
               	leaq	0x1(%rbx), %rcx
               	movslq	%ecx, %rbx
               	cmpq	$0xa, %rax
               	jae	<addr>
               	leaq	0x1(%rbx), %rcx
               	movslq	%ecx, %rbx
               	cmpq	$0xa, %rax
               	ja	<addr>
               	leaq	0x1(%rbx), %rcx
               	movslq	%ecx, %rbx
               	cmpq	$0xa, %rax
               	jle	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movslq	%ebx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%ebx, %rax
               	cmpq	$0x8, %rax
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x3, %ecx
               	movq	(%rsp), %rbx
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
