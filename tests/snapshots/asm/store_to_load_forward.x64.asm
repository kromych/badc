
store_to_load_forward.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<use_struct>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%r13, (%rsp)
               	movslq	%edx, %rdx
               	movq	%rsi, (%rdi)
               	movl	%edx, 0x8(%rdi)
               	movw	%dx, 0xc(%rdi)
               	movb	%dl, 0xe(%rdi)
               	movq	%rdx, %rax
               	andq	$0xff, %rax
               	movb	%al, 0xf(%rdi)
               	movq	(%rdi), %rax
               	movslq	0x8(%rdi), %rcx
               	movswq	0xc(%rdi), %rsi
               	movsbq	%dl, %rdx
               	movzbq	0xf(%rdi), %rdi
               	addq	%rcx, %rax
               	addq	%rsi, %rax
               	addq	%rdx, %rax
               	movq	%rdi, %rcx
               	andq	$0xff, %rcx
               	addq	%rcx, %rax
               	movq	(%rsp), %r13
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<deref_twice>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	movq	%rsi, (%rdi)
               	movq	%rsi, %rax
               	addq	%rsi, %rax
               	movq	(%rsp), %r13
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<no_forward_across_call>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%rdi, %rbx
               	xorq	%r12, %r12
               	movq	%rsi, (%rbx)
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	%r12, %rax
               	movq	(%rbx), %rcx
               	addq	%rcx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%r13, (%rsp)
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x3e8, %esi            # imm = 0x3E8
               	movl	$0x7, %edx
               	callq	<addr>
               	cmpq	$0x404, %rax            # imm = 0x404
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %r13
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x15, %esi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %r13
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rdi
               	movl	$0x9, %esi
               	callq	<addr>
               	cmpq	$0x1b, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %r13
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %r13
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
