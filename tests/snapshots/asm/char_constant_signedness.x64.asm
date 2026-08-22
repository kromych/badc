
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
               	cmpq	$-0x1, %rax
               	jl	<addr>
               	cmpq	$0x28, %rax
               	jl	<addr>
               	cmpq	$0x28, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x3, %eax
               	retq
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpq	$-0x80, %rax
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
               	cmpq	$-0x80, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xff, %ecx
               	movl	%ecx, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rcx
               	movsbq	%cl, %rcx
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	%eax, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	movslq	-0x10(%rbp), %rax
               	movb	%al, (%rdi)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xff, %eax
               	movl	%eax, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	movslq	-0x10(%rbp), %rax
               	movb	%al, (%rdi)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
