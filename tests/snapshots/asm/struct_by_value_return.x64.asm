
struct_by_value_return.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<make_pair>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movl	%edi, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	%esi, 0x4(%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<clobber>:
               	leaq	0x121589(%rdi), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<sum_pair_pair>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movq	%rsi, -0x10(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	leaq	-0x10(%rbp), %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rax
               	movl	%eax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x8(%rbp), %rax
               	movslq	0x4(%rax), %rdx
               	leaq	-0x10(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	addq	%rdx, %rax
               	movl	%eax, 0x4(%rcx)
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	leaq	-0x8(%rbp), %rcx
               	movl	$0xb, %eax
               	movl	$0x16, %edx
               	leaq	-0x90(%rbp), %rsi
               	movl	%eax, (%rsi)
               	leaq	-0x90(%rbp), %rax
               	movl	%edx, 0x4(%rax)
               	leaq	-0x90(%rbp), %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rcx
               	movl	$0x3, %eax
               	movl	$0x4, %edx
               	leaq	-0x98(%rbp), %rsi
               	movl	%eax, (%rsi)
               	leaq	-0x98(%rbp), %rax
               	movl	%edx, 0x4(%rax)
               	leaq	-0x98(%rbp), %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rcx
               	movl	$0x64, %eax
               	movl	$0xc8, %edx
               	leaq	-0xa0(%rbp), %rsi
               	movl	%eax, (%rsi)
               	leaq	-0xa0(%rbp), %rax
               	movl	%edx, 0x4(%rax)
               	leaq	-0xa0(%rbp), %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x38(%rbp), %rcx
               	movl	$0x12c, %eax            # imm = 0x12C
               	movl	$0x190, %edx            # imm = 0x190
               	leaq	-0xa8(%rbp), %rsi
               	movl	%eax, (%rsi)
               	leaq	-0xa8(%rbp), %rax
               	movl	%edx, 0x4(%rax)
               	leaq	-0xa8(%rbp), %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x30(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0xc8, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x190, %rax            # imm = 0x190
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x50(%rbp), %rsi
               	movl	$0x1, %eax
               	movl	$0x2, %ecx
               	leaq	-0xb0(%rbp), %rdx
               	movl	%eax, (%rdx)
               	leaq	-0xb0(%rbp), %rax
               	movl	%ecx, 0x4(%rax)
               	leaq	-0xb0(%rbp), %rax
               	movl	$0x3, %ecx
               	movl	$0x4, %edx
               	leaq	-0xb8(%rbp), %rdi
               	movl	%ecx, (%rdi)
               	leaq	-0xb8(%rbp), %rcx
               	movl	%edx, 0x4(%rcx)
               	leaq	-0xb8(%rbp), %rcx
               	leaq	-0xc0(%rbp), %rdi
               	movslq	(%rax), %rdx
               	movslq	(%rcx), %r8
               	addq	%r8, %rdx
               	movl	%edx, (%rdi)
               	leaq	-0xc0(%rbp), %rdx
               	movslq	0x4(%rax), %rax
               	movslq	0x4(%rcx), %rcx
               	addq	%rcx, %rax
               	movl	%eax, 0x4(%rdx)
               	leaq	-0xc0(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x50(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x50(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
