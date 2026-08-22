
array_field_designator_local.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x38(%rbp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movzbq	0x10(%rcx), %rdx
               	movb	%dl, 0x10(%rax)
               	movzbq	0x11(%rcx), %rdx
               	movb	%dl, 0x11(%rax)
               	movzbq	0x12(%rcx), %rdx
               	movb	%dl, 0x12(%rax)
               	movzbq	0x13(%rcx), %rdx
               	movb	%dl, 0x13(%rax)
               	popq	%rdx
               	leaq	<rip>, %rax
               	movl	(%rax), %ecx
               	andq	$0xff, %rcx
               	cmpq	$0x1, %rcx
               	movl	$0x1, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %edx
               	andq	$0xff, %rdx
               	cmpq	$0x2, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	0x10(%rax), %edx
               	andq	$0xff, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	0x18(%rax), %edx
               	andq	$0xff, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	(%rax), %edx
               	sarq	$0x8, %rdx
               	movq	%rdx, %rdi
               	andq	$0xff, %rdi
               	testq	%rdi, %rdi
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdi, %rdi
               	jne	<addr>
               	movslq	0x4(%rax), %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	(%rsi), %eax
               	andq	$0xff, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movslq	0xc(%rsi), %rax
               	cmpq	$0x4, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movl	0x8(%rax), %eax
               	andq	$0xff, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	movslq	0x4(%rax), %rcx
               	cmpq	$0x9, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0xc(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	andq	$0xff, %rax
               	cmpq	$0x9, %rax
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movl	0x18(%rcx), %ecx
               	andq	$0xff, %rcx
               	cmpq	$0x9, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x14(%rcx), %rcx
               	cmpq	$0x5, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0xc(%rcx), %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	0x4(%rcx), %rdx
               	cmpq	$0x6, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	0xc(%rcx), %rax
               	cmpq	$0x6, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	0x10(%rcx), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
