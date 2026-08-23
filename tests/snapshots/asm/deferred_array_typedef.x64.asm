
deferred_array_typedef.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x68, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	0x10(%rdx), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x6d, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	0x20(%rdx), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x68, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x73, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	%rax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movslq	%eax, %rsi
               	movq	%rsi, %rdi
               	shlq	$0x4, %rdi
               	addq	%rdx, %rdi
               	movslq	0xc(%rdi), %rdi
               	addq	%rdi, %rcx
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	cmpl	$0x18, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
