
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
               	subq	$0x48, %rsp
               	pushq	%rbx
               	leaq	-0x40(%rbp), %rax
               	movl	$0x1, (%rax)
               	leaq	-0x20(%rbp), %rcx
               	movl	$0xa, (%rcx)
               	movl	$0x2, 0x4(%rax)
               	movl	$0x14, 0x4(%rcx)
               	movl	$0x3, 0x8(%rax)
               	movl	$0x1e, 0x8(%rcx)
               	movl	$0x4, 0xc(%rax)
               	movl	$0x28, 0xc(%rcx)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x5, 0x10(%rax)
               	leaq	-0x20(%rbp), %rcx
               	movl	$0x32, 0x10(%rcx)
               	movl	$0x6, 0x14(%rax)
               	movl	$0x3c, 0x14(%rcx)
               	movl	$0x7, 0x18(%rax)
               	movl	$0x46, 0x18(%rcx)
               	movl	$0x8, 0x1c(%rax)
               	movl	$0x50, 0x1c(%rcx)
               	leaq	-0x40(%rbp), %r8
               	leaq	-0x20(%rbp), %rsi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	leaq	(%r8,%rdi), %rdx
               	movslq	(%rdx), %r9
               	addq	$0x3, %r9
               	addq	%rsi, %rdi
               	movslq	(%rdi), %rbx
               	subq	$0x3, %rbx
               	movl	%ebx, (%rdx)
               	movl	%r9d, (%rsi,%rax,4)
               	movslq	(%rdx), %rdx
               	movslq	(%rdi), %rdi
               	imulq	%rdi, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	cmpl	$0xb7c, %ecx            # imm = 0xB7C
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
