
binary_search_tree.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<insert>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	testq	%rbx, %rbx
               	jne	<addr>
               	movl	$0x18, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorq	%rcx, %rcx
               	movq	%r12, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	(%rbx), %rax
               	cmpq	%rax, %r12
               	jge	<addr>
               	movq	0x8(%rbx), %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, 0x8(%rbx)
               	movq	%rbx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	0x10(%rbx), %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, 0x10(%rbx)
               	jmp	<addr>

<search>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	testq	%rdi, %rdi
               	jne	<addr>
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	movq	(%rdi), %rax
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	(%rdi), %rax
               	cmpq	%rax, %rsi
               	jge	<addr>
               	movq	0x8(%rdi), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	movq	0x10(%rdi), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rdi, %rdi
               	movl	$0x32, %esi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x1e, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	$0x46, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	$0x14, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movl	$0x28, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x28, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x63, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
