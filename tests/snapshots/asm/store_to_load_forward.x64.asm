
store_to_load_forward.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movslq	%edx, %rdx
               	movq	%rsi, (%rdi)
               	movl	%edx, 0x8(%rdi)
               	movswq	%dx, %rax
               	movw	%ax, 0xc(%rdi)
               	movsbq	%dl, %rax
               	movb	%al, 0xe(%rdi)
               	movq	%rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0xf(%rdi)
               	movq	(%rdi), %rcx
               	movslq	0x8(%rdi), %rdx
               	movswq	0xc(%rdi), %rsi
               	movsbq	%al, %rax
               	movzbq	0xf(%rdi), %rdi
               	addq	%rdx, %rcx
               	addq	%rsi, %rcx
               	addq	%rcx, %rax
               	movq	%rdi, %rcx
               	andq	$0xff, %rcx
               	addq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%rsi, (%rdi)
               	movq	%rsi, %rax
               	addq	%rsi, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	xorq	%r12, %r12
               	movq	%rsi, (%rbx)
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	%r12, %rax
               	movq	(%rbx), %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x3e8, %esi            # imm = 0x3E8
               	movl	$0x7, %edx
               	callq	<addr>
               	cmpq	$0x404, %rax            # imm = 0x404
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
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
               	addq	$0x40, %rsp
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
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
