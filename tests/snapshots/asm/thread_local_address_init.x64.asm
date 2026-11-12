
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
               	movsbq	(%rax), %rcx
               	cmpl	$0x68, %ecx
               	jne	<addr>
               	movsbq	0x1(%rax), %rcx
               	cmpl	$0x69, %ecx
               	jne	<addr>
               	cmpb	$0x0, 0x2(%rax)
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x48, %rax
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax # <addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rcx
               	addq	$-0x40, %rcx
               	movq	(%rcx), %rcx
               	leaq	0x4(%rax), %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movl	(%rcx), %ecx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rcx
               	addq	$-0x38, %rcx
               	movq	(%rcx), %rcx
               	addq	$0x8, %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movl	(%rcx), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x30, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x4, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x28, %rax
               	movq	(%rax), %rcx
               	leaq	<rip>, %rdx # <addr>
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movl	(%rcx), %ecx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rcx
               	addq	$-0x20, %rcx
               	movq	(%rcx), %rcx
               	leaq	<rip>, %rsi # <addr>
               	cmpq	%rsi, %rcx
               	jne	<addr>
               	movl	(%rcx), %ecx
               	cmpl	$0x8, %ecx
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rcx
               	addq	$-0x18, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rcx
               	addq	$-0x8, %rcx
               	cmpq	$0x0, (%rcx)
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rcx
               	addq	$-0x10, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x2a, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	movq	%rsi, (%rax)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
