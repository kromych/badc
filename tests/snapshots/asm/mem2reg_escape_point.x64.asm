
mem2reg_escape_point.x64:	file format elf64-x86-64

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

<bump>:
               	movslq	(%rdi), %rax
               	addq	$0x7, %rax
               	movl	%eax, (%rdi)
               	retq

<noise>:
               	leaq	(%rdi,%rdi,2), %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0xa, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rsi
               	movl	$0xf, (%rsi)
               	movslq	-0x10(%rbp), %rcx
               	subq	$0xa, %rcx
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0xa, -0x10(%rbp)
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	movq	%rax, %rcx
               	movslq	-0x10(%rbp), %rdi
               	addq	%rdi, %rdx
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rsi, %rcx
               	movslq	(%rcx), %rdi
               	incq	%rdi
               	movl	%edi, (%rcx)
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpl	$0x21, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0xa, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	movslq	-0x8(%rbp), %rax
               	subq	$0xa, %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0xa, %edi
               	movl	%edi, -0x18(%rbp)
               	callq	<addr>
               	movl	%eax, -0x18(%rbp)
               	subq	$0xa, %rax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
