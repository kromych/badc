
nested_runtime_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	0x1(%rax), %rdx
               	movslq	%edx, %rdi
               	cmpq	%rcx, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x1(%rax), %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rdi
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rax, %rdx
               	shlq	%rdx
               	movslq	%edx, %rdx
               	leaq	0x3(%rax), %rsi
               	movslq	%esi, %rdi
               	movq	%rax, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x3(%rax), %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rdi
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rax, %rdx
               	shlq	%rdx
               	movslq	%edx, %rsi
               	leaq	0x5(%rax), %rdx
               	movslq	%edx, %r8
               	cmpq	%rcx, %rcx
               	setne	%dil
               	movzbq	%dil, %rdi
               	movl	$0x1, %edx
               	testq	%rdi, %rdi
               	jne	<addr>
               	movq	%rax, %rdx
               	shlq	%rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rsi
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x5(%rax), %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %r8
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x1(%rax), %rdx
               	movslq	%edx, %rsi
               	leaq	0x2(%rax), %rdx
               	movslq	%edx, %rdi
               	cmpq	%rcx, %rcx
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movl	$0x1, %edx
               	testq	%r8, %r8
               	jne	<addr>
               	leaq	0x1(%rax), %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rsi
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x2(%rax), %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rdi
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
               	retq
               	movl	$0x4, %eax
               	retq
               	movl	$0x3, %eax
               	retq
               	movl	$0x2, %eax
               	retq
               	movl	$0x1, %eax
               	retq
