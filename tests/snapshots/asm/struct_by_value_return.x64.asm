
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
               	movslq	%eax, %rax
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
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	addq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
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
               	leaq	-0x8(%rbp), %rax
               	movl	$0xb, %ecx
               	movl	$0x16, %edx
               	leaq	-0x90(%rbp), %rsi
               	movl	%ecx, (%rsi)
               	leaq	-0x90(%rbp), %rcx
               	movl	%edx, 0x4(%rcx)
               	leaq	-0x90(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
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
               	leaq	-0x20(%rbp), %rax
               	movl	$0x3, %ecx
               	movl	$0x4, %edx
               	leaq	-0x98(%rbp), %rsi
               	movl	%ecx, (%rsi)
               	leaq	-0x98(%rbp), %rcx
               	movl	%edx, 0x4(%rcx)
               	leaq	-0x98(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
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
               	leaq	-0x30(%rbp), %rax
               	movl	$0x64, %ecx
               	movl	$0xc8, %edx
               	leaq	-0xa0(%rbp), %rsi
               	movl	%ecx, (%rsi)
               	leaq	-0xa0(%rbp), %rcx
               	movl	%edx, 0x4(%rcx)
               	leaq	-0xa0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x38(%rbp), %rax
               	movl	$0x12c, %ecx            # imm = 0x12C
               	movl	$0x190, %edx            # imm = 0x190
               	leaq	-0xa8(%rbp), %rsi
               	movl	%ecx, (%rsi)
               	leaq	-0xa8(%rbp), %rcx
               	movl	%edx, 0x4(%rcx)
               	leaq	-0xa8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
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
               	leaq	-0x50(%rbp), %rax
               	movl	$0x1, %ecx
               	movl	$0x2, %edx
               	leaq	-0xb0(%rbp), %rsi
               	movl	%ecx, (%rsi)
               	leaq	-0xb0(%rbp), %rcx
               	movl	%edx, 0x4(%rcx)
               	leaq	-0xb0(%rbp), %rcx
               	movl	$0x3, %edx
               	movl	$0x4, %esi
               	leaq	-0xb8(%rbp), %rdi
               	movl	%edx, (%rdi)
               	leaq	-0xb8(%rbp), %rdx
               	movl	%esi, 0x4(%rdx)
               	leaq	-0xb8(%rbp), %rdx
               	leaq	-0xc0(%rbp), %rsi
               	movslq	(%rcx), %rdi
               	movslq	(%rdx), %r8
               	addq	%r8, %rdi
               	movl	%edi, (%rsi)
               	leaq	-0xc0(%rbp), %rsi
               	movslq	0x4(%rcx), %rcx
               	movslq	0x4(%rdx), %rdx
               	addq	%rdx, %rcx
               	movl	%ecx, 0x4(%rsi)
               	leaq	-0xc0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
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
               	movl	$0x63, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
