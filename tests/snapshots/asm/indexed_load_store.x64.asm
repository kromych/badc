
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
               	movl	$0x1, -0x40(%rbp)
               	movl	$0xa, -0x20(%rbp)
               	movl	$0x2, -0x3c(%rbp)
               	movl	$0x14, -0x1c(%rbp)
               	movl	$0x3, -0x38(%rbp)
               	movl	$0x1e, -0x18(%rbp)
               	movl	$0x4, -0x34(%rbp)
               	movl	$0x28, -0x14(%rbp)
               	movl	$0x5, -0x30(%rbp)
               	movl	$0x32, -0x10(%rbp)
               	movl	$0x6, -0x2c(%rbp)
               	movl	$0x3c, -0xc(%rbp)
               	movl	$0x7, -0x28(%rbp)
               	movl	$0x46, -0x8(%rbp)
               	movl	$0x8, -0x24(%rbp)
               	movl	$0x50, -0x4(%rbp)
               	leaq	-0x40(%rbp), %r8
               	leaq	-0x20(%rbp), %rsi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	leaq	(%r8,%rdi), %rdx
               	movl	(%rdx), %r9d
               	addq	$0x3, %r9
               	addq	%rsi, %rdi
               	movl	(%rdi), %ebx
               	subq	$0x3, %rbx
               	movl	%ebx, (%rdx)
               	movl	%r9d, (%rsi,%rax,4)
               	movl	(%rdx), %edx
               	movl	(%rdi), %edi
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
