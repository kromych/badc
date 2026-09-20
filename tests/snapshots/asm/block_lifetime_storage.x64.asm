
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
               	subq	$0x60, %rsp
               	movl	$0x1, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	leaq	<rip>, %rax
               	movq	%rcx, (%rax)
               	movslq	(%rcx), %rdx
               	addq	$0xa, %rdx
               	movl	%edx, (%rcx)
               	movslq	-0x20(%rbp), %rdx
               	movl	$0x2, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, (%rax)
               	movslq	(%rcx), %rsi
               	addq	$0x14, %rsi
               	movl	%esi, (%rcx)
               	movslq	-0x18(%rbp), %rcx
               	addq	%rcx, %rdx
               	movl	$0x3, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	movq	%rcx, (%rax)
               	movslq	(%rcx), %rsi
               	addq	$0x1e, %rsi
               	movl	%esi, (%rcx)
               	movslq	-0x10(%rbp), %rcx
               	addq	%rcx, %rdx
               	movl	$0x4, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movslq	(%rcx), %rsi
               	addq	$0x28, %rsi
               	movl	%esi, (%rcx)
               	movslq	-0x8(%rbp), %rcx
               	addq	%rdx, %rcx
               	cmpl	$0x6e, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x5, -0x58(%rbp)
               	leaq	-0x58(%rbp), %rcx
               	movq	%rcx, (%rax)
               	movl	$0x6, -0x50(%rbp)
               	leaq	-0x50(%rbp), %rdx
               	movq	%rdx, (%rax)
               	movslq	(%rdx), %rsi
               	incq	%rsi
               	movl	%esi, (%rdx)
               	movslq	-0x50(%rbp), %rdx
               	cmpl	$0x7, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	%rcx, (%rax)
               	movslq	(%rcx), %rax
               	addq	$0x64, %rax
               	movl	%eax, (%rcx)
               	movslq	-0x58(%rbp), %rax
               	cmpl	$0x69, %eax
               	jne	<addr>
               	movl	$0x7, -0x48(%rbp)
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rsi
               	movq	%rax, (%rsi)
               	movslq	(%rax), %rcx
               	shlq	%rcx
               	movl	%ecx, (%rax)
               	movslq	-0x48(%rbp), %rdx
               	movabsq	$0x1122334455667788, %rax # imm = 0x1122334455667788
               	movq	%rax, -0x40(%rbp)
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	movq	(%rax), %rdi
               	xorq	$0x1, %rdi
               	movq	%rdi, (%rax)
               	movq	(%rcx), %rax
               	movq	(%rax), %rax
               	leaq	(%rdx,%rax), %rcx
               	movl	$0x9, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rax
               	movq	%rax, (%rsi)
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	movslq	-0x38(%rbp), %rax
               	addq	%rcx, %rax
               	movabsq	$0x11223344556677a1, %r11 # imm = 0x11223344556677A1
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	movl	%eax, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rcx
               	movq	%rcx, (%rsi)
               	movslq	(%rcx), %r8
               	incq	%r8
               	movl	%r8d, (%rcx)
               	movslq	-0x30(%rbp), %rcx
               	addq	%rcx, %rdx
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rcx
               	movq	%rcx, (%rdi)
               	movslq	(%rcx), %r8
               	addq	$0x2, %r8
               	movl	%r8d, (%rcx)
               	movslq	-0x28(%rbp), %rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpl	$0xf, %edx
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
