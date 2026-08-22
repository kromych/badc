
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
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x20, %rcx
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x9, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x20, %rcx
               	addq	%rsi, %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpl	$0xa, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movslq	%eax, %rcx
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movslq	(%rdx), %rdi
               	testl	%edi, %edi
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdi, %rdi
               	jne	<addr>
               	leaq	<rip>, %rdx
               	addq	%rsi, %rdx
               	movslq	0x4(%rdx), %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x8, %eax
               	retq
               	movl	$0x7, %eax
               	retq
