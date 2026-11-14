
parenthesized_address_constant.x64:	file format elf64-x86-64

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
               	leaq	0x64(%rdi), %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rax # <addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movl	(%rcx), %ecx
               	cmpl	$0xb, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rcx # <addr>
               	addq	$0x4, %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movl	(%rcx), %eax
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rax # <addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x4(%rcx), %rdx
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x2c, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rax # <addr>
               	leaq	<rip>, %rdx # <addr>
               	leaq	0x8(%rdx), %rsi
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rax # <addr>
               	addq	$0x14, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rax # <addr>
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x14, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movl	0x4(%rax), %eax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rax # <addr>
               	leaq	-<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	*%rax
               	cmpl	$0x65, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rdx # <addr>
               	leaq	0x4(%rax), %rcx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rcx # <addr>
               	movl	(%rcx), %edx
               	cmpl	$0x4d, %edx
               	jne	<addr>
               	movl	0x4(%rcx), %ecx
               	cmpl	$0x58, %ecx
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rcx # <addr>
               	movl	(%rcx), %edx
               	cmpl	$0x63, %edx
               	jne	<addr>
               	movl	0x4(%rcx), %ecx
               	cmpl	$0x6f, %ecx
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x15, %eax
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movl	(%rcx), %ecx
               	cmpl	$0xb, %ecx
               	je	<addr>
               	movl	$0x16, %eax
               	jmp	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x17, %eax
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x4, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0x18, %eax
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x4(%rcx), %rdx
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x2c, %eax
               	je	<addr>
               	movl	$0x19, %eax
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	leaq	<rip>, %rdx # <addr>
               	leaq	0x8(%rdx), %rsi
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x1a, %eax
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x14, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x1b, %eax
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x14, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x1c, %eax
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movl	0x4(%rax), %eax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x1d, %eax
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	leaq	-<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x2, %edi
               	callq	*%rax
               	cmpl	$0x66, %eax
               	je	<addr>
               	movl	$0x1e, %eax
               	jmp	<addr>
               	movq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x1f, %eax
               	jmp	<addr>
               	movq	<rip>, %rdx # <addr>
               	leaq	0x4(%rax), %rcx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x20, %eax
               	jmp	<addr>
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x21, %eax
               	jmp	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x22, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
