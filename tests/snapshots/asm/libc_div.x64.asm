
libc_div.x64:	file format elf64-x86-64

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

<rti>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	leave
               	retq

<rtl>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	leave
               	retq

<rtll>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x11, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	%ebx, %rax
               	movslq	%ecx, %rcx
               	pushq	%rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rdx
               	popq	%rax
               	imulq	%rdx, %rcx
               	subq	%rcx, %rax
               	cmpl	$0x3, %edx
               	jne	<addr>
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movabsq	$-0x11, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x5, %edi
               	callq	<addr>
               	movslq	%ebx, %rcx
               	movslq	%eax, %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	popq	%rdx
               	imulq	%rax, %rdx
               	subq	%rdx, %rcx
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	cmpl	$-0x2, %ecx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	(%rax,%rax,4), %rax
               	addq	%rcx, %rax
               	cmpl	$-0x11, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x64, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x7, %edi
               	callq	<addr>
               	movq	%rax, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rbx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	imulq	%rcx, %rax
               	movq	%rax, %r10
               	movq	%rbx, %rax
               	subq	%r10, %rax
               	cmpq	$0xe, %rcx
               	jne	<addr>
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x3e8, %edi            # imm = 0x3E8
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rbx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	imulq	%rcx, %rax
               	movq	%rax, %r10
               	movq	%rbx, %rax
               	subq	%r10, %rax
               	cmpq	$0x14d, %rcx            # imm = 0x14D
               	jne	<addr>
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
