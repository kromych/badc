
block_lifetime_storage.x64:	file format elf64-x86-64

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

<volatiles>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x1, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	movl	$0x3, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rcx
               	incq	%rcx
               	movl	%ecx, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x1, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	movslq	(%rax), %rdx
               	addq	$0xa, %rdx
               	movl	%edx, (%rax)
               	movslq	-0x8(%rbp), %rdx
               	movl	$0x2, -0x8(%rbp)
               	movq	%rax, (%rcx)
               	movslq	(%rax), %rsi
               	addq	$0x14, %rsi
               	movl	%esi, (%rax)
               	movslq	-0x8(%rbp), %rsi
               	addq	%rsi, %rdx
               	movl	$0x3, -0x8(%rbp)
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movslq	(%rcx), %rsi
               	addq	$0x1e, %rsi
               	movl	%esi, (%rcx)
               	movslq	-0x8(%rbp), %rcx
               	addq	%rcx, %rdx
               	movl	$0x4, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	%rcx, (%rax)
               	movslq	(%rcx), %rsi
               	addq	$0x28, %rsi
               	movl	%esi, (%rcx)
               	movslq	-0x8(%rbp), %rsi
               	addq	%rsi, %rdx
               	cmpl	$0x6e, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x5, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	%rdx, (%rax)
               	movl	$0x6, -0x8(%rbp)
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movslq	(%rcx), %rsi
               	incq	%rsi
               	movl	%esi, (%rcx)
               	movslq	-0x8(%rbp), %rcx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	%rdx, (%rax)
               	movslq	(%rdx), %rcx
               	addq	$0x64, %rcx
               	movl	%ecx, (%rdx)
               	movslq	-0x10(%rbp), %rcx
               	cmpl	$0x69, %ecx
               	jne	<addr>
               	movl	$0x7, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	movq	%rdi, (%rax)
               	movslq	(%rdi), %rcx
               	shlq	%rcx
               	movl	%ecx, (%rdi)
               	movslq	-0x8(%rbp), %rdx
               	movabsq	$0x1122334455667788, %rcx # imm = 0x1122334455667788
               	movq	%rcx, -0x8(%rbp)
               	leaq	<rip>, %rcx
               	movq	%rdi, (%rcx)
               	movq	(%rdi), %rsi
               	xorq	$0x1, %rsi
               	movq	%rsi, (%rdi)
               	movq	(%rcx), %rcx
               	movq	(%rcx), %rcx
               	addq	%rdx, %rcx
               	movl	$0x9, -0x8(%rbp)
               	movq	%rdi, (%rax)
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	movslq	-0x8(%rbp), %rax
               	addq	%rcx, %rax
               	movabsq	$0x11223344556677a1, %r11 # imm = 0x11223344556677A1
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	movl	%eax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	movq	%rcx, (%rdx)
               	movslq	(%rcx), %r9
               	incq	%r9
               	movl	%r9d, (%rcx)
               	movslq	-0x10(%rbp), %rcx
               	addq	%rcx, %rsi
               	movl	%eax, -0x8(%rbp)
               	movq	%rdi, (%rdx)
               	movq	(%r8), %rcx
               	movslq	(%rcx), %r9
               	addq	$0x2, %r9
               	movl	%r9d, (%rcx)
               	movslq	-0x8(%rbp), %rcx
               	addq	%rcx, %rsi
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpl	$0xf, %esi
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	callq	<addr>
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
