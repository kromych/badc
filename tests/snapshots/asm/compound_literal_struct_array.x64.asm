
compound_literal_struct_array.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	(%rax), %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movslq	0xc(%rcx), %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	(%rax), %rcx
               	movslq	0x10(%rcx), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	movslq	0x14(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movq	(%rax), %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpl	$0x8, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movq	(%rax), %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpl	$0x9, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movq	(%rax), %rcx
               	cmpl	$0x0, 0x8(%rcx)
               	jne	<addr>
               	movq	(%rax), %rcx
               	cmpl	$0x0, 0xc(%rcx)
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movq	(%rax), %rcx
               	cmpl	$0x0, 0x10(%rcx)
               	jne	<addr>
               	movq	(%rax), %rax
               	cmpl	$0x0, 0x14(%rax)
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movq	(%rax), %rcx
               	cmpl	$0x0, 0x4(%rcx)
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movq	(%rax), %rcx
               	cmpl	$0x0, 0x8(%rcx)
               	jne	<addr>
               	movq	(%rax), %rcx
               	cmpl	$0x0, 0xc(%rcx)
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movq	(%rax), %rcx
               	movslq	0x10(%rcx), %rcx
               	cmpl	$0x9, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	movslq	0x14(%rax), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movq	(%rax), %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movslq	0xc(%rcx), %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	movq	(%rax), %rcx
               	movslq	0x10(%rcx), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movslq	0x14(%rcx), %rcx
               	cmpl	$0x6, %ecx
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movq	(%rax), %rcx
               	movslq	0x18(%rcx), %rcx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	movslq	0x1c(%rax), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movsbq	0x8(%rcx), %rcx
               	cmpl	$0x78, %ecx
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	movq	(%rax), %rcx
               	movslq	0xc(%rcx), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movslq	0x10(%rcx), %rcx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	movsbq	0x14(%rax), %rax
               	cmpl	$0x79, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movq	(%rax), %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpl	$0x2a, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	cmpl	$0x0, 0x10(%rax)
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movslq	0xc(%rcx), %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	movq	(%rax), %rcx
               	movslq	0x10(%rcx), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	movslq	0x1c(%rax), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x18, %eax
               	je	<addr>
               	movl	$0x1b, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	popq	%rdx
               	leaq	-0x40(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	popq	%rdx
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	popq	%rdx
               	leaq	-0x50(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	movq	0x10(%rdx), %rax
               	movq	%rax, 0x10(%rcx)
               	movq	0x18(%rdx), %rax
               	movq	%rax, 0x18(%rcx)
               	popq	%rax
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%rdx), %rcx
               	movq	%rcx, 0x10(%rax)
               	popq	%rcx
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%rdx), %rcx
               	movq	%rcx, 0x10(%rax)
               	popq	%rcx
               	leaq	<rip>, %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	movq	0x18(%rax), %rdx
               	movq	%rdx, 0x18(%rcx)
               	popq	%rdx
               	leaq	-0x30(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movl	$0x3, (%rsi)
               	movl	$0x4, 0x4(%rsi)
               	movl	$0x5, 0x8(%rsi)
               	movl	$0x6, 0xc(%rsi)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rsi, %rdx
               	movslq	(%rdx), %rdi
               	imulq	$0xa, %rdi, %rdi
               	movslq	0x4(%rdx), %rdx
               	addq	%rdi, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	cmpl	$0x5a, %ecx
               	je	<addr>
               	movl	$0x36, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rsi)
               	popq	%rcx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rsi, %rdx
               	movslq	(%rdx), %rdi
               	imulq	$0xa, %rdi, %rdi
               	movslq	0x4(%rdx), %rdx
               	addq	%rdi, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpl	$0x66, %ecx
               	je	<addr>
               	movl	$0x38, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
