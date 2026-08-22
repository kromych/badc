
compound_literal_pointer_field.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rcx
               	movq	(%rcx), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x68, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpl	$0x4, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	0x8(%rax), %rcx
               	movslq	0x18(%rcx), %rcx
               	cmpl	$0x8, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	0x8(%rax), %rcx
               	movq	0x20(%rcx), %rdx
               	testq	%rdx, %rdx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	movslq	0x28(%rax), %rax
               	testl	%eax, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x78, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
