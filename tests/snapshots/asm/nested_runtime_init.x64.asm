
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
               	xorq	%rdi, %rdi
               	movq	%rdi, %rax
               	jmp	<addr>
               	leaq	0x1(%rax), %rcx
               	cmpl	%eax, %eax
               	jne	<addr>
               	cmpl	%ecx, %ecx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rax, %rdx
               	shlq	%rdx
               	leaq	0x3(%rax), %rsi
               	cmpl	%edx, %edx
               	jne	<addr>
               	cmpl	%esi, %esi
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x5(%rax), %rdx
               	movq	%rdi, %rsi
               	cmpl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x2(%rax), %rdx
               	cmpl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpl	%edx, %edx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	%eax, %rax
               	incq	%rax
               	cmpl	$0x14, %eax
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
