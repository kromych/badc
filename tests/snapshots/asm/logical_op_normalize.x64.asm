
logical_op_normalize.x64:	file format elf64-x86-64

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

<or_ll>:
               	movl	$0x1, %eax
               	testq	%rdi, %rdi
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	retq
               	jmp	<addr>

<or_rr>:
               	testq	%rsi, %rsi
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	retq

<and_ll>:
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	retq

<and_rr>:
               	movslq	%esi, %rsi
               	testq	%rsi, %rsi
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rbx
               	xorq	%rsi, %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movl	$0x5, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %edi
               	movl	$0x7, %esi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %edi
               	xorq	%rsi, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x8(%rbp), %r12
               	xorq	%rsi, %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	(%r12,%rax,4), %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r12
               	xorq	%rdi, %rdi
               	movl	$0x9, %esi
               	callq	<addr>
               	movslq	(%r12,%rax,4), %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	testq	%rbx, %rbx
               	jne	<addr>
               	xorq	%rax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rcx, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
