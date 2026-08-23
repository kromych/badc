
local_struct_array_brace_init.x64:	file format elf64-x86-64

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
               	subq	$0x70, %rsp
               	leaq	-0x68(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdi)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rdi)
               	movq	0x20(%rax), %rcx
               	movq	%rcx, 0x20(%rdi)
               	movq	0x28(%rax), %rcx
               	movq	%rcx, 0x28(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdi, %rsi
               	movq	0x8(%rsi), %rsi
               	addq	%rsi, %rcx
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpq	$0xc, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rcx
               	movq	0x8(%rcx), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movq	0x28(%rcx), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	movq	%rax, 0x10(%rcx)
               	movq	%rax, 0x18(%rcx)
               	movq	%rax, 0x20(%rcx)
               	movq	%rax, 0x28(%rcx)
               	leaq	-0x38(%rbp), %rdx
               	movq	%rdx, (%rcx)
               	movl	$0x10, %edx
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x28(%rbp), %rdx
               	movq	%rdx, 0x10(%rcx)
               	movl	$0x20, %edx
               	movq	%rdx, 0x18(%rcx)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdx, 0x20(%rcx)
               	movl	$0x8, %ecx
               	leaq	-0x68(%rbp), %rdi
               	movq	%rcx, 0x28(%rdi)
               	movq	%rax, %rcx
               	jmp	<addr>
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdi, %rsi
               	movq	0x8(%rsi), %rsi
               	addq	%rsi, %rcx
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpq	$0x38, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rax
               	movq	(%rax), %rcx
               	leaq	-0x38(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movq	0x10(%rax), %rcx
               	leaq	-0x28(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movq	0x20(%rax), %rcx
               	leaq	-0x8(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movq	0x28(%rax), %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
