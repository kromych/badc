
ptr_to_incomplete_array.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	<rip>, %rbx
               	leaq	<rip>, %r12
               	leaq	<rip>, %rsi
               	xorq	%r8, %r8
               	jmp	<addr>
               	movslq	%r8d, %r9
               	movq	%r9, %rax
               	shlq	$0x4, %rax
               	addq	%r12, %rax
               	movq	0x8(%rax), %rax
               	movq	%rsi, %rdx
               	movsbq	(%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rax), %rcx
               	movsbq	(%rdx), %rdi
               	cmpl	%edi, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	incq	%rax
               	incq	%rdx
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rdx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	leaq	0x1(%r9), %r8
               	cmpl	$0x2, %r8d
               	jl	<addr>
               	movabsq	$-0x1, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rsi
               	xorq	%r8, %r8
               	jmp	<addr>
               	movslq	%r8d, %r9
               	movq	%r9, %rax
               	shlq	$0x4, %rax
               	addq	%rbx, %rax
               	movq	0x8(%rax), %rax
               	movq	%rsi, %rdx
               	movsbq	(%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rax), %rcx
               	movsbq	(%rdx), %rdi
               	cmpl	%edi, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	incq	%rax
               	incq	%rdx
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rdx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	leaq	0x1(%r9), %r8
               	cmpl	$0x2, %r8d
               	jl	<addr>
               	movabsq	$-0x1, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%r9, %rax
               	shlq	$0x4, %rax
               	addq	%rbx, %rax
               	movslq	(%rax), %rax
               	jmp	<addr>
               	movq	%r9, %rax
               	shlq	$0x4, %rax
               	addq	%r12, %rax
               	movslq	(%rax), %rax
               	jmp	<addr>
