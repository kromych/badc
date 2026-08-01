
offsetof_runtime_subscript.x64:	file format elf64-x86-64

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
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	imulq	$0xc, %rcx, %rdx
               	addq	$0x58, %rdx
               	imulq	$0x6, %rcx, %rsi
               	shlq	%rsi
               	addq	$0x58, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x5, %rcx
               	jl	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x3, %eax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
