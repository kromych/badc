
runtime_array_designator.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<check>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0x7, %ecx
               	movl	$0x3, %edx
               	movl	$0x5, %esi
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rdi
               	pushq	%rcx
               	movq	(%rdi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdi), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%rdi), %rcx
               	movq	%rcx, 0x10(%rax)
               	popq	%rcx
               	leaq	-0x18(%rbp), %rax
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	%edx, 0x4(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	%esi, 0x8(%rax)
               	leaq	-0x18(%rbp), %rcx
               	xorq	%rax, %rax
               	movslq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %ecx
               	xorq	%rdx, %rdx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %edx
               	xorq	%rax, %rax
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0x10(%rax), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0x14(%rax), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x7, %edi
               	movl	$0x3, %esi
               	movl	$0x5, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
