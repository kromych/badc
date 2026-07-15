
indexed_load_store.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
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
               	leaq	-0x20(%rbp), %r9
               	leaq	-0x40(%rbp), %rsi
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movq	%rcx, %r8
               	shlq	$0x2, %r8
               	leaq	(%r9,%r8), %rbx
               	movslq	(%rbx), %rdi
               	addq	$0x3, %rdi
               	addq	%rsi, %r8
               	movslq	(%r8), %r8
               	subq	$0x3, %r8
               	movl	%r8d, (%rbx)
               	movl	%edi, (%rsi,%rcx,4)
               	movq	%rcx, %rdi
               	shlq	$0x2, %rdi
               	leaq	(%r9,%rdi), %r8
               	movslq	(%r8), %r8
               	addq	%rsi, %rdi
               	movslq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rdx
               	movslq	%edx, %rdx
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	movslq	%edx, %rax
               	movslq	%eax, %rax
               	cmpq	$0xb7c, %rax            # imm = 0xB7C
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
