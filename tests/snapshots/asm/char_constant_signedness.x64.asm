
char_constant_signedness.x64:	file format elf64-x86-64

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

<pick>:
               	movsbq	(%rdi), %rax
               	cmpl	$-0x1, %eax
               	jl	<addr>
               	cmpl	$0x28, %eax
               	jl	<addr>
               	cmpl	$0x28, %eax
               	je	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x3, %eax
               	retq
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpl	$-0x80, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0x80, %eax
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rcx
               	movsbq	%cl, %rcx
               	cmpl	$-0x80, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0xff, %ecx
               	movl	%ecx, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rcx
               	movsbq	%cl, %rcx
               	cmpl	$-0x1, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	%eax, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	movslq	-0x10(%rbp), %rax
               	movb	%al, (%rdi)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0xff, %eax
               	movl	%eax, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	movslq	-0x10(%rbp), %rax
               	movb	%al, (%rdi)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
