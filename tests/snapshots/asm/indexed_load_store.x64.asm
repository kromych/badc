
indexed_load_store.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x40(%rbp), %rax
               	leaq	(%rax), %rcx
               	movl	$0x1, %edx
               	movl	%edx, (%rcx)
               	leaq	-0x20(%rbp), %rcx
               	leaq	(%rcx), %rdx
               	movl	$0xa, %esi
               	movl	%esi, (%rdx)
               	movl	$0x2, %edx
               	movl	%edx, 0x4(%rax)
               	movl	$0x14, %edx
               	movl	%edx, 0x4(%rcx)
               	movl	$0x3, %edx
               	movl	%edx, 0x8(%rax)
               	movl	$0x1e, %edx
               	movl	%edx, 0x8(%rcx)
               	movl	$0x4, %edx
               	movl	%edx, 0xc(%rax)
               	movl	$0x28, %eax
               	movl	%eax, 0xc(%rcx)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x5, %ecx
               	movl	%ecx, 0x10(%rax)
               	leaq	-0x20(%rbp), %rcx
               	movl	$0x32, %edx
               	movl	%edx, 0x10(%rcx)
               	movl	$0x6, %edx
               	movl	%edx, 0x14(%rax)
               	movl	$0x3c, %edx
               	movl	%edx, 0x14(%rcx)
               	movl	$0x7, %edx
               	movl	%edx, 0x18(%rax)
               	movl	$0x46, %edx
               	movl	%edx, 0x18(%rcx)
               	movl	$0x8, %edx
               	movl	%edx, 0x1c(%rax)
               	movl	$0x50, %eax
               	movl	%eax, 0x1c(%rcx)
               	leaq	-0x40(%rbp), %r9
               	leaq	-0x20(%rbp), %rsi
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movq	%rcx, %rdi
               	shlq	$0x2, %rdi
               	leaq	(%r9,%rdi), %r8
               	movslq	(%r8), %rbx
               	addq	$0x3, %rbx
               	leaq	(%rsi,%rdi), %r12
               	movslq	(%r12), %r12
               	subq	$0x3, %r12
               	movl	%r12d, (%r8)
               	movl	%ebx, (%rsi,%rcx,4)
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
               	cmpq	$0xb7c, %rax            # imm = 0xB7C
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
