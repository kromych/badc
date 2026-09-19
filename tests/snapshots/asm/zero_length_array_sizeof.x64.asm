
zero_length_array_sizeof.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	xorq	%rax, %rax
               	leaq	<rip>, %rdi
               	movq	%rax, %rdx
               	leaq	-0x8(%rbp), %r9
               	movl	%eax, %esi
               	cmpl	$0x4, %esi
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testl	%r8d, %r8d
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%r8, %r8
               	jne	<addr>
               	movq	%rsi, %r8
               	andq	$0x7, %r8
               	movzbq	(%rdi,%r8), %r8
               	movb	%r8b, (%r9)
               	leaq	0x1(%rsi), %rax
               	testl	%ecx, %ecx
               	je	<addr>
               	leaq	-0x10(%rbp), %rsi
               	movslq	%edx, %rcx
               	leaq	0x1(%rcx), %rdx
               	movzbq	-0x8(%rbp), %r8
               	movb	%r8b, (%rsi,%rcx)
               	cmpl	$0x4, %edx
               	jl	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	cmpl	$0x4, %edx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rcx
               	movzbq	(%rcx), %rdx
               	xorq	$0x42, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	0x1(%rcx), %rdx
               	xorq	$0x41, %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x2(%rcx), %rdx
               	xorq	$0x44, %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x3(%rcx), %rcx
               	xorq	$0x43, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	%eax, %eax
               	xorq	$0x4, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
