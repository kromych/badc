
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
               	pushq	%r14
               	pushq	%r12
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
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x10(%rax), %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x14(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpl	$0x0, 0x8(%rax)
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpl	$0x0, 0xc(%rax)
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpl	$0x0, 0x10(%rax)
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpl	$0x0, 0x14(%rax)
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpl	$0x0, 0x4(%rax)
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpl	$0x0, 0x8(%rax)
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpl	$0x0, 0xc(%rax)
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x10(%rax), %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x14(%rax), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x10(%rax), %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x14(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x18(%rax), %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x1c(%rax), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	0x8(%rax), %rax
               	cmpl	$0x78, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x10(%rax), %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	0x14(%rax), %rax
               	cmpl	$0x79, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x2a, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpl	$0x0, 0x10(%rax)
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x10(%rax), %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x1c(%rax), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x18, %eax
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x19, %eax
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0x1a, %eax
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x18, %eax
               	je	<addr>
               	movl	$0x1b, %eax
               	popq	%r12
               	popq	%r14
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
               	leaq	-0x40(%rbp), %rdx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
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
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%rsi), %rcx
               	movq	%rcx, 0x10(%rax)
               	popq	%rcx
               	leaq	-0x50(%rbp), %rax
               	leaq	<rip>, %rdi
               	pushq	%rcx
               	movq	(%rdi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdi), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%rdi), %rcx
               	movq	%rcx, 0x10(%rax)
               	movq	0x18(%rdi), %rcx
               	movq	%rcx, 0x18(%rax)
               	popq	%rcx
               	leaq	-0x48(%rbp), %rdi
               	leaq	<rip>, %r8
               	pushq	%rax
               	movq	(%r8), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%r8), %rax
               	movq	%rax, 0x8(%rdi)
               	movq	0x10(%r8), %rax
               	movq	%rax, 0x10(%rdi)
               	popq	%rax
               	leaq	-0x48(%rbp), %r8
               	leaq	<rip>, %r12
               	pushq	%rax
               	movq	(%r12), %rax
               	movq	%rax, (%r8)
               	movq	0x8(%r12), %rax
               	movq	%rax, 0x8(%r8)
               	movq	0x10(%r12), %rax
               	movq	%rax, 0x10(%r8)
               	popq	%rax
               	leaq	-0x50(%rbp), %r8
               	leaq	<rip>, %r14
               	pushq	%rax
               	movq	(%r14), %rax
               	movq	%rax, (%r8)
               	movq	0x8(%r14), %rax
               	movq	%rax, 0x8(%r8)
               	movq	0x10(%r14), %rax
               	movq	%rax, 0x10(%r8)
               	movq	0x18(%r14), %rax
               	movq	%rax, 0x18(%r8)
               	popq	%rax
               	leaq	-0x30(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x3, (%rdi)
               	movl	$0x4, 0x4(%rdi)
               	movl	$0x5, 0x8(%rdi)
               	movl	$0x6, 0xc(%rdi)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdi, %rdx
               	movslq	(%rdx), %rsi
               	imulq	$0xa, %rsi, %rsi
               	movslq	0x4(%rdx), %rdx
               	addq	%rsi, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	cmpl	$0x5a, %ecx
               	je	<addr>
               	movl	$0x36, %eax
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	-0x18(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdi)
               	popq	%rcx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	$0x3, %eax
               	jge	<addr>
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdi, %rdx
               	movslq	(%rdx), %rsi
               	imulq	$0xa, %rsi, %rsi
               	movslq	0x4(%rdx), %rdx
               	addq	%rsi, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpl	$0x66, %ecx
               	je	<addr>
               	movl	$0x38, %eax
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%r12
               	popq	%r14
               	leave
               	retq
