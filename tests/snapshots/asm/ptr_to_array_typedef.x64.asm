
ptr_to_array_typedef.x64:	file format elf64-x86-64

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
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rdx, %rdx
               	movq	%rdx, -0x88(%rbp)
               	jmp	<addr>
               	leaq	-0x60(%rbp), %r8
               	movq	%rax, %rsi
               	shlq	$0x5, %rsi
               	leaq	(%r8,%rsi), %rdi
               	leaq	(%rdi), %rbx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rcx), %r9
               	movslq	%r9d, %r9
               	movq	%r9, (%rbx)
               	leaq	0x1(%rcx), %r8
               	movslq	%r8d, %r8
               	movq	%r8, 0x8(%rdi)
               	leaq	-0x60(%rbp), %rdi
               	addq	%rdi, %rsi
               	addq	$0x2, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, 0x10(%rsi)
               	movq	%rax, %rcx
               	shlq	$0x5, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, 0x18(%rsi)
               	leaq	0x1(%rax), %rdx
               	movslq	%edx, %rax
               	cmpq	$0x3, %rax
               	jl	<addr>
               	leaq	-0x88(%rbp), %rcx
               	leaq	<rip>, %rax
               	movl	$0x2, %edx
               	movq	%rdx, 0x18(%rax)
               	movq	%rax, (%rcx)
               	movq	-0x88(%rbp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movq	-0x88(%rbp), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x88(%rbp), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movq	-0x88(%rbp), %rax
               	movq	0x18(%rax), %rax
               	leaq	0x1e(%rax), %rcx
               	leaq	-0x60(%rbp), %rax
               	movq	0x30(%rax), %rdx
               	movq	0x58(%rax), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	subq	$0x7, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
