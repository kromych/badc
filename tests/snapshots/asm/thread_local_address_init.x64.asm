
thread_local_address_init.x64:	file format elf64-x86-64

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

<fn>:
               	movl	$0x4, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%fs:0x0, %rax
               	addq	$-0x58, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x50, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x68, %eax
               	jne	<addr>
               	movq	%fs:0x0, %rax
               	addq	$-0x50, %rax
               	movq	(%rax), %rax
               	movsbq	0x1(%rax), %rax
               	cmpl	$0x69, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%fs:0x0, %rax
               	addq	$-0x50, %rax
               	movq	(%rax), %rax
               	movsbq	0x2(%rax), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x48, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x40, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	addq	$0x4, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	%fs:0x0, %rax
               	addq	$-0x40, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x38, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	addq	$0x8, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	%fs:0x0, %rax
               	addq	$-0x38, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x3, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x30, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	addq	$0x4, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	%fs:0x0, %rax
               	addq	$-0x30, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x6, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x28, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	%fs:0x0, %rax
               	addq	$-0x28, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x7, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x20, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	%fs:0x0, %rax
               	addq	$-0x20, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x8, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x18, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x10, %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x28, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	movslq	(%rcx), %rax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x7, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
