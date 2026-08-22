
typeof_abstract_array_type.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	movq	%rdx, %rax
               	jmp	<addr>
               	leaq	-0x18(%rbp), %r9
               	imulq	$0xc, %rcx, %rsi
               	leaq	(%r9,%rsi), %rdi
               	leaq	(%rdi), %rbx
               	imulq	$0xa, %rcx, %rax
               	leaq	(%rax), %r8
               	movl	%r8d, (%rbx)
               	leaq	0x1(%rax), %r8
               	movl	%r8d, 0x4(%rdi)
               	leaq	-0x18(%rbp), %rdi
               	addq	%rdi, %rsi
               	addq	$0x2, %rax
               	movl	%eax, 0x8(%rsi)
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	movl	$0x1, %eax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	0x14(%rcx), %rdx
               	cmpq	$0xc, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	0x8(%rcx), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x9, %ecx
               	movq	%rcx, 0x10(%rax)
               	cmpq	$0x9, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
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
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
