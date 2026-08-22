
nested_runtime_init.x64:	file format elf64-x86-64

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
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	0x1(%rax), %rdx
               	movslq	%edx, %rdi
               	cmpq	%rcx, %rcx
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	cmpq	%rdi, %rdi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	%rax, %rdx
               	shlq	%rdx
               	movslq	%edx, %rdi
               	leaq	0x3(%rax), %rsi
               	movslq	%esi, %r8
               	cmpq	%rdi, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	cmpq	%r8, %r8
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movslq	%edx, %rdi
               	leaq	0x5(%rax), %rsi
               	movslq	%esi, %r8
               	cmpq	%rcx, %rcx
               	movl	$0x1, %edx
               	jne	<addr>
               	movq	%rax, %rdx
               	shlq	%rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rdi
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	cmpq	%r8, %r8
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x1(%rax), %rsi
               	movslq	%esi, %r8
               	leaq	0x2(%rax), %rdi
               	movslq	%edi, %r9
               	cmpq	%rcx, %rcx
               	movl	$0x1, %edx
               	jne	<addr>
               	cmpq	%r8, %r8
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	cmpq	%r9, %r9
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x14, %rcx
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
