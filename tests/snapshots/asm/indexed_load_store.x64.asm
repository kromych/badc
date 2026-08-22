
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
               	leaq	-0x40(%rbp), %rax
               	addq	$0x0, %rax
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x20(%rbp), %rax
               	addq	$0x0, %rax
               	movl	$0xa, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x2, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x14, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x3, %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x1e, %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x4, %ecx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x28, %ecx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x5, %ecx
               	movl	%ecx, 0x10(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x32, %ecx
               	movl	%ecx, 0x10(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x6, %ecx
               	movl	%ecx, 0x14(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x3c, %ecx
               	movl	%ecx, 0x14(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x7, %ecx
               	movl	%ecx, 0x18(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x46, %ecx
               	movl	%ecx, 0x18(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x8, %ecx
               	movl	%ecx, 0x1c(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x50, %ecx
               	movl	%ecx, 0x1c(%rax)
               	leaq	-0x40(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movq	%rcx, %r8
               	shlq	$0x2, %r8
               	leaq	(%rdi,%r8), %r9
               	movslq	(%r9), %rbx
               	addq	$0x3, %rbx
               	addq	%rsi, %r8
               	movslq	(%r8), %r8
               	subq	$0x3, %r8
               	movl	%r8d, (%r9)
               	movl	%ebx, (%rsi,%rcx,4)
               	movq	%rcx, %r8
               	shlq	$0x2, %r8
               	leaq	(%rdi,%r8), %r9
               	movslq	(%r9), %r9
               	addq	%rsi, %r8
               	movslq	(%r8), %r8
               	imulq	%r9, %r8
               	addq	%r8, %rdx
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
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
