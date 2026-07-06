
indexed_load_store.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<work>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movslq	%edx, %rdx
               	xorq	%r8, %r8
               	movq	%r8, %rax
               	jmp	<addr>
               	movq	%r9, %rbx
               	shlq	$0x2, %rbx
               	leaq	(%rdi,%rbx), %r12
               	movslq	(%r12), %r13
               	addq	%rcx, %r13
               	addq	%rsi, %rbx
               	movslq	(%rbx), %rbx
               	subq	%rcx, %rbx
               	movl	%ebx, (%r12)
               	movl	%r13d, (%rsi,%r9,4)
               	movq	%r9, %rbx
               	shlq	$0x2, %rbx
               	leaq	(%rdi,%rbx), %r12
               	movslq	(%r12), %r12
               	addq	%rsi, %rbx
               	movslq	(%rbx), %rbx
               	imulq	%r12, %rbx
               	addq	%rbx, %r8
               	movslq	%r8d, %r8
               	leaq	0x1(%r9), %rax
               	movslq	%eax, %r9
               	cmpq	%rdx, %r9
               	jl	<addr>
               	movslq	%r8d, %rax
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
               	subq	$0x70, %rsp
               	leaq	-0x20(%rbp), %rax
               	addq	$0x0, %rax
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x40(%rbp), %rax
               	addq	$0x0, %rax
               	movl	$0xa, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x2, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x14, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x3, %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x1e, %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x4, %ecx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x28, %ecx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x5, %ecx
               	movl	%ecx, 0x10(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x32, %ecx
               	movl	%ecx, 0x10(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x6, %ecx
               	movl	%ecx, 0x14(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x3c, %ecx
               	movl	%ecx, 0x14(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x7, %ecx
               	movl	%ecx, 0x18(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x46, %ecx
               	movl	%ecx, 0x18(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x8, %ecx
               	movl	%ecx, 0x1c(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x50, %ecx
               	movl	%ecx, 0x1c(%rax)
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x8, %edx
               	movl	$0x3, %ecx
               	callq	<addr>
               	cmpq	$0xb7c, %rax            # imm = 0xB7C
               	jne	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %ecx
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
