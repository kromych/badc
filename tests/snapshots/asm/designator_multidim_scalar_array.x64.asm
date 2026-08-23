
designator_multidim_scalar_array.x64:	file format elf64-x86-64

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
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	leaq	0x20(%rsi), %rdx
               	movq	%rcx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rdx
               	movslq	(%rdx), %rdx
               	cmpq	$0x9, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x20(%rsi), %rdx
               	addq	%rdi, %rdx
               	movslq	0x4(%rdx), %rdx
               	cmpq	$0xa, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	xorq	%rax, %rax
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	movq	%rcx, %rdi
               	shlq	$0x3, %rdi
               	leaq	(%rsi,%rdi), %rdx
               	movslq	(%rdx), %r8
               	testq	%r8, %r8
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%r8, %r8
               	jne	<addr>
               	leaq	(%rsi,%rdi), %rdx
               	movslq	0x4(%rdx), %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x8, %eax
               	retq
               	movl	$0x7, %eax
               	retq
