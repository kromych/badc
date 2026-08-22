
multidim_array_init.x64:	file format elf64-x86-64

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
               	movslq	0x10(%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movslq	0x14(%rax), %rcx
               	cmpq	$0x1, %rcx
               	movl	$0x1, %ecx
               	jne	<addr>
               	movslq	0x20(%rax), %rdx
               	cmpq	$0x6, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	0x24(%rax), %rdx
               	cmpq	$0x7, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movslq	0x28(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movslq	0x3c(%rax), %rdx
               	cmpq	$0x1, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	0x40(%rax), %rdx
               	cmpq	$0x2, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movslq	0x60(%rax), %rdx
               	cmpq	$0x7, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	0x50(%rax), %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rdx
               	movslq	0x24(%rdx), %rdx
               	movslq	0x24(%rax), %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rdx
               	movslq	0x60(%rdx), %rdx
               	movslq	0x60(%rax), %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0xc(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x18(%rax), %rax
               	cmpq	$0x9, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x10(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x20(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
