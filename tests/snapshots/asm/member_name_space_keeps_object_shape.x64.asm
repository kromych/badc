
member_name_space_keeps_object_shape.x64:	file format elf64-x86-64

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
               	xorl	%edx, %edx
               	leaq	<rip>, %rax
               	movq	%rdx, %rcx
               	imulq	$0x30, %rcx, %rdi
               	leaq	(%rax,%rdi), %rsi
               	leaq	0x1(%rdx), %r8
               	movl	%edx, (%rsi)
               	leaq	0x1(%r8), %rdx
               	movl	%r8d, 0x4(%rsi)
               	leaq	0x1(%rdx), %r8
               	movl	%edx, 0x8(%rsi)
               	leaq	(%rax,%rdi), %rdx
               	leaq	0x1(%r8), %rsi
               	movl	%r8d, 0xc(%rdx)
               	imulq	$0x30, %rcx, %rdx
               	leaq	(%rax,%rdx), %rdi
               	addq	$0x10, %rdi
               	leaq	0x1(%rsi), %r8
               	movl	%esi, (%rdi)
               	leaq	0x1(%r8), %rsi
               	movl	%r8d, 0x4(%rdi)
               	leaq	(%rax,%rdx), %rdi
               	addq	$0x10, %rdi
               	leaq	0x1(%rsi), %r8
               	movl	%esi, 0x8(%rdi)
               	leaq	0x1(%r8), %rsi
               	movl	%r8d, 0xc(%rdi)
               	addq	%rax, %rdx
               	leaq	0x20(%rdx), %rdi
               	leaq	0x1(%rsi), %rdx
               	movl	%esi, (%rdi)
               	imulq	$0x30, %rcx, %rsi
               	leaq	(%rax,%rsi), %rdi
               	addq	$0x20, %rdi
               	leaq	0x1(%rdx), %r8
               	movl	%edx, 0x4(%rdi)
               	leaq	0x1(%r8), %r9
               	movl	%r8d, 0x8(%rdi)
               	leaq	(%rax,%rsi), %rdx
               	leaq	0x20(%rdx), %rsi
               	leaq	0x1(%r9), %rdx
               	movl	%r9d, 0xc(%rsi)
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	0x5c(%rax), %rcx
               	cmpl	$0x17, %ecx
               	jne	<addr>
               	movslq	0x4(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	$0x0, (%rax)
               	movl	$0x1, 0x4(%rax)
               	movl	$0x2, 0x8(%rax)
               	movl	$0x3, 0xc(%rax)
               	addq	$0x8, %rax
               	movl	$0xa, (%rax)
               	movl	$0xb, 0x4(%rax)
               	movl	$0xc, 0x8(%rax)
               	leaq	<rip>, %rax
               	leaq	0x8(%rax), %rcx
               	movl	$0xd, 0xc(%rcx)
               	addq	$0x10, %rax
               	movl	$0x14, (%rax)
               	movl	$0x15, 0x4(%rax)
               	movl	$0x16, 0x8(%rax)
               	movl	$0x17, 0xc(%rax)
               	leaq	<rip>, %rax
               	movslq	0x1c(%rax), %rcx
               	cmpl	$0x17, %ecx
               	jne	<addr>
               	movslq	0x4(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorl	%eax, %eax
               	retq
