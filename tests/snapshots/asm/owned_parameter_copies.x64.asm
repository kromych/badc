
owned_parameter_copies.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<through>:
               	movq	0x8(%rdi), %rax
               	addq	$0xa, %rax
               	movq	%rax, 0x8(%rdi)
               	movq	(%rdi), %rcx
               	addq	%rcx, %rax
               	retq

<escaped>:
               	subq	$0x28, %rsp
               	movq	0x30(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x38(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x40(%rsp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	$0x5, 0x8(%rsp)
               	leaq	0x8(%rsp), %rdi
               	callq	<addr>
               	movq	0x10(%rsp), %rcx
               	addq	%rcx, %rax
               	addq	$0x28, %rsp
               	retq

<read_after>:
               	subq	$0x28, %rsp
               	movq	0x30(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x38(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x40(%rsp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	0x8(%rsp), %rdi
               	callq	<addr>
               	movq	0x10(%rsp), %rcx
               	addq	%rcx, %rax
               	addq	$0x28, %rsp
               	retq

<sum>:
               	subq	$0x28, %rsp
               	movq	0x30(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x38(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x40(%rsp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x8(%rsp), %rax
               	movq	0x10(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rsp), %rcx
               	addq	%rcx, %rax
               	addq	$0x28, %rsp
               	retq

<bump>:
               	subq	$0x28, %rsp
               	movq	0x30(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x38(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x40(%rsp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x8(%rsp), %rax
               	incq	%rax
               	movq	%rax, 0x8(%rsp)
               	movq	0x10(%rsp), %rcx
               	imulq	%rcx, %rax
               	addq	$0x28, %rsp
               	retq

<loop>:
               	subq	$0x28, %rsp
               	movq	0x30(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x38(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x40(%rsp), %r10
               	movq	%r10, 0x18(%rsp)
               	xorl	%eax, %eax
               	movq	0x18(%rsp), %rdx
               	movq	0x10(%rsp), %rsi
               	movq	0x8(%rsp), %rcx
               	cmpq	%rsi, %rcx
               	jge	<addr>
               	addq	%rdx, %rax
               	incq	%rcx
               	movq	%rcx, 0x8(%rsp)
               	movq	0x8(%rsp), %rcx
               	cmpq	%rsi, %rcx
               	jl	<addr>
               	addq	$0x28, %rsp
               	retq

<forward>:
               	subq	$0x30, %rsp
               	pushq	%rbx
               	subq	$0x20, %rsp
               	movq	0x60(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x68(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x70(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	leaq	0x38(%rsp), %r9
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x38(%rsp), %r9
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	callq	<addr>
               	addq	%rbx, %rax
               	incq	%rax
               	addq	$0x20, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq

<kept>:
               	subq	$0x28, %rsp
               	movq	0x30(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x38(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x40(%rsp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	0x8(%rsp), %rax
               	movq	%rax, <rip> # <addr>
               	movq	0x10(%rax), %rcx
               	shlq	%rcx
               	movq	%rcx, 0x10(%rax)
               	movq	0x18(%rsp), %rax
               	addq	$0x28, %rsp
               	retq

<chars>:
               	subq	$0x28, %rsp
               	movq	0x30(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x38(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movzwq	0x40(%rsp), %r10
               	movw	%r10w, 0x18(%rsp)
               	movzbq	0x42(%rsp), %r10
               	movb	%r10b, 0x1a(%rsp)
               	movsbq	0x1a(%rsp), %rax
               	xorq	$0x1, %rax
               	movb	%al, 0x1a(%rsp)
               	movsbq	0x8(%rsp), %rcx
               	addq	%rcx, %rax
               	addq	$0x28, %rsp
               	retq

<chars_escaped>:
               	subq	$0x28, %rsp
               	movq	0x30(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x38(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movzwq	0x40(%rsp), %r10
               	movw	%r10w, 0x18(%rsp)
               	movzbq	0x42(%rsp), %r10
               	movb	%r10b, 0x1a(%rsp)
               	movb	$0x7a, 0xb(%rsp)
               	movsbq	0x1a(%rsp), %rax
               	addq	$0x7a, %rax
               	movsbq	0xa(%rsp), %rcx
               	addq	%rcx, %rax
               	addq	$0x28, %rsp
               	retq

<main>:
               	subq	$0x28, %rsp
               	subq	$0x20, %rsp
               	leaq	0x28(%rsp), %r9
               	movq	$0x1, 0x28(%rsp)
               	movq	$0x14, 0x30(%rsp)
               	movq	$0x3, 0x38(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	callq	<addr>
               	cmpq	$0x41, %rax
               	jne	<addr>
               	leaq	0x28(%rsp), %r9
               	movq	$0x1, 0x28(%rsp)
               	movq	$0x14, 0x30(%rsp)
               	movq	$0x3, 0x38(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	callq	<addr>
               	cmpq	$0x3d, %rax
               	jne	<addr>
               	leaq	0x28(%rsp), %r9
               	movq	$0x1, 0x28(%rsp)
               	movq	$0x14, 0x30(%rsp)
               	movq	$0x3, 0x38(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	callq	<addr>
               	cmpq	$0x18, %rax
               	jne	<addr>
               	leaq	0x28(%rsp), %r9
               	movq	$0x1, 0x28(%rsp)
               	movq	$0x14, 0x30(%rsp)
               	movq	$0x3, 0x38(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	callq	<addr>
               	cmpq	$0x28, %rax
               	jne	<addr>
               	leaq	0x28(%rsp), %r9
               	movq	$0x1, 0x28(%rsp)
               	movq	$0x14, 0x30(%rsp)
               	movq	$0x3, 0x38(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	callq	<addr>
               	cmpq	$0x39, %rax
               	jne	<addr>
               	leaq	0x28(%rsp), %r9
               	movq	$0x1, 0x28(%rsp)
               	movq	$0x14, 0x30(%rsp)
               	movq	$0x3, 0x38(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	callq	<addr>
               	cmpq	$0x5a, %rax
               	jne	<addr>
               	leaq	0x28(%rsp), %r9
               	movq	$0x1, 0x28(%rsp)
               	movq	$0x14, 0x30(%rsp)
               	movq	$0x3, 0x38(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	callq	<addr>
               	cmpq	$0x6, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	leaq	0x1(%rax), %rcx
               	movb	%cl, 0x28(%rsp,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x13, %eax
               	jl	<addr>
               	leaq	0x28(%rsp), %r9
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movzbq	0x10(%r10), %r11
               	movb	%r11b, 0x10(%rsp)
               	movzbq	0x11(%r10), %r11
               	movb	%r11b, 0x11(%rsp)
               	movzbq	0x12(%r10), %r11
               	movb	%r11b, 0x12(%rsp)
               	callq	<addr>
               	cmpl	$0x13, %eax
               	jne	<addr>
               	leaq	0x28(%rsp), %r9
               	movsbq	0x3a(%rsp), %rax
               	cmpl	$0x13, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x20, %rsp
               	addq	$0x28, %rsp
               	retq
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movzbq	0x10(%r10), %r11
               	movb	%r11b, 0x10(%rsp)
               	movzbq	0x11(%r10), %r11
               	movb	%r11b, 0x11(%rsp)
               	movzbq	0x12(%r10), %r11
               	movb	%r11b, 0x12(%rsp)
               	callq	<addr>
               	cmpl	$0x90, %eax
               	jne	<addr>
               	movsbq	0x2b(%rsp), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x20, %rsp
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x20, %rsp
               	addq	$0x28, %rsp
               	retq
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	addq	$0x28, %rsp
               	retq
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	addq	$0x28, %rsp
               	retq
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	addq	$0x28, %rsp
               	retq
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	addq	$0x28, %rsp
               	retq
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	addq	$0x28, %rsp
               	retq
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	addq	$0x28, %rsp
               	retq
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	addq	$0x28, %rsp
               	retq
