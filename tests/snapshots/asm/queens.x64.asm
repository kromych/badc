
queens.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<conflicts>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%rdx, %r8
               	movslq	%esi, %rsi
               	movslq	%r8d, %r8
               	xorq	%rax, %rax
               	jmp	<addr>
               	movq	%rsi, %rdx
               	subq	%rcx, %rdx
               	movslq	%edx, %r9
               	movslq	(%rdi,%rcx,4), %rdx
               	movq	%rdx, %r10
               	movq	%r8, %rdx
               	subq	%r10, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	imulq	$-0x1, %rdx, %rdx
               	movslq	%edx, %rdx
               	movslq	(%rdi,%rcx,4), %rcx
               	cmpq	%r8, %rcx
               	je	<addr>
               	movslq	%edx, %rcx
               	cmpq	%rcx, %r9
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %rcx
               	cmpq	%rsi, %rcx
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>

<solve>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%rdi, %r14
               	movq	%rsi, %r13
               	movslq	%r13d, %r13
               	cmpq	$0x8, %r13
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %r12
               	jmp	<addr>
               	movq	%r14, %rdi
               	movq	%rbx, %rdx
               	movq	%r13, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	movl	%ebx, (%r14,%r13,4)
               	leaq	0x1(%r13), %rsi
               	movq	%r14, %rdi
               	callq	<addr>
               	addq	%r12, %rax
               	movslq	%eax, %r12
               	leaq	0x1(%rbx), %rax
               	movslq	%eax, %rbx
               	movslq	%ebx, %rax
               	cmpq	$0x8, %rax
               	jl	<addr>
               	movslq	%r12d, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x20(%rbp), %rdi
               	xorq	%rsi, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x5c, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
