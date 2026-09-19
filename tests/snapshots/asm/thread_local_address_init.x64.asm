
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
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x68, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movsbq	0x1(%rcx), %rcx
               	cmpl	$0x69, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	cmpb	$0x0, 0x2(%rax)
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x48, %rax
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rcx
               	addq	$-0x40, %rcx
               	movq	(%rcx), %rdx
               	leaq	0x4(%rax), %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movq	(%rcx), %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rcx
               	addq	$-0x38, %rcx
               	movq	(%rcx), %rdx
               	addq	$0x8, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	movq	(%rcx), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x30, %rax
               	movq	(%rax), %rcx
               	leaq	<rip>, %rdx
               	addq	$0x4, %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x28, %rax
               	movq	(%rax), %rdx
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	movq	(%rax), %rdx
               	movslq	(%rdx), %rdx
               	cmpl	$0x7, %edx
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rsi
               	addq	$-0x20, %rsi
               	movq	(%rsi), %rdi
               	leaq	<rip>, %rdx
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	movq	(%rsi), %rsi
               	movslq	(%rsi), %rsi
               	cmpl	$0x8, %esi
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rsi
               	addq	$-0x18, %rsi
               	movq	(%rsi), %rsi
               	cmpq	%rcx, %rsi
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rsi
               	addq	$-0x10, %rsi
               	cmpq	$0x0, (%rsi)
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rsi
               	addq	$-0x8, %rsi
               	movq	(%rsi), %rsi
               	cmpq	$0x2a, %rsi
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	movq	%rdx, (%rax)
               	movslq	(%rdx), %rax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movslq	(%rcx), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
