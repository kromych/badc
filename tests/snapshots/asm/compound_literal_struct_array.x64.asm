
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
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	-0x40(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	-0x50(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rdx), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rdx), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
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
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%rsi)
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
