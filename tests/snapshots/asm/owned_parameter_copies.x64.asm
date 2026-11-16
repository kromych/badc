
owned_parameter_copies.x64:	file format elf64-x86-64

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

<through>:
               	movq	0x8(%rdi), %rax
               	addq	$0xa, %rax
               	movq	%rax, 0x8(%rdi)
               	movq	(%rdi), %rcx
               	addq	%rcx, %rax
               	retq

<escaped>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	-0x18(%rbp), %rdi
               	movq	$0x5, -0x18(%rbp)
               	callq	<addr>
               	movq	-0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<read_after>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	-0x18(%rbp), %rdi
               	callq	<addr>
               	movq	-0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<sum>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	movq	-0x18(%rbp), %rax
               	movq	-0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<bump>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	movq	-0x18(%rbp), %rax
               	incq	%rax
               	movq	%rax, -0x18(%rbp)
               	movq	-0x10(%rbp), %rcx
               	imulq	%rcx, %rax
               	leave
               	retq

<loop>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	xorl	%eax, %eax
               	movq	-0x18(%rbp), %rcx
               	movq	-0x10(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	jge	<addr>
               	movq	-0x8(%rbp), %rdx
               	addq	%rdx, %rax
               	incq	%rcx
               	movq	%rcx, -0x18(%rbp)
               	movq	-0x18(%rbp), %rcx
               	movq	-0x10(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	jl	<addr>
               	leave
               	retq

<forward>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	-0x18(%rbp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movq	%rax, %rbx
               	leaq	-0x18(%rbp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	addq	%rbx, %rax
               	incq	%rax
               	popq	%rbx
               	leave
               	retq

<kept>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, <rip> # <addr>
               	movq	0x10(%rax), %rcx
               	shlq	%rcx
               	movq	%rcx, 0x10(%rax)
               	movq	-0x8(%rbp), %rax
               	leave
               	retq

<chars>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movzwq	0x20(%rbp), %r10
               	movw	%r10w, -0x8(%rbp)
               	movzbq	0x22(%rbp), %r10
               	movb	%r10b, -0x6(%rbp)
               	movsbq	-0x6(%rbp), %rax
               	xorq	$0x1, %rax
               	movb	%al, -0x6(%rbp)
               	movsbq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<chars_escaped>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movzwq	0x20(%rbp), %r10
               	movw	%r10w, -0x8(%rbp)
               	movzbq	0x22(%rbp), %r10
               	movb	%r10b, -0x6(%rbp)
               	movb	$0x7a, -0x15(%rbp)
               	movsbq	-0x6(%rbp), %rax
               	addq	$0x7a, %rax
               	movsbq	-0x16(%rbp), %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x18(%rbp), %r9
               	movq	$0x1, -0x18(%rbp)
               	movq	$0x14, -0x10(%rbp)
               	movq	$0x3, -0x8(%rbp)
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x41, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %r9
               	movq	$0x1, -0x18(%rbp)
               	movq	$0x14, -0x10(%rbp)
               	movq	$0x3, -0x8(%rbp)
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x3d, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %r9
               	movq	$0x1, -0x18(%rbp)
               	movq	$0x14, -0x10(%rbp)
               	movq	$0x3, -0x8(%rbp)
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x18, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %r9
               	movq	$0x1, -0x18(%rbp)
               	movq	$0x14, -0x10(%rbp)
               	movq	$0x3, -0x8(%rbp)
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x28, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %r9
               	movq	$0x1, -0x18(%rbp)
               	movq	$0x14, -0x10(%rbp)
               	movq	$0x3, -0x8(%rbp)
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x39, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %r9
               	movq	$0x1, -0x18(%rbp)
               	movq	$0x14, -0x10(%rbp)
               	movq	$0x3, -0x8(%rbp)
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x5a, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %r9
               	movq	$0x1, -0x18(%rbp)
               	movq	$0x14, -0x10(%rbp)
               	movq	$0x3, -0x8(%rbp)
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x6, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	leaq	0x1(%rax), %rcx
               	movb	%cl, -0x18(%rbp,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x13, %eax
               	jl	<addr>
               	leaq	-0x18(%rbp), %r9
               	subq	$0x20, %rsp
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
               	addq	$0x20, %rsp
               	cmpl	$0x13, %eax
               	jne	<addr>
               	leaq	-0x18(%rbp), %r9
               	movsbq	-0x6(%rbp), %rax
               	cmpl	$0x13, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	subq	$0x20, %rsp
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
               	addq	$0x20, %rsp
               	cmpl	$0x90, %eax
               	jne	<addr>
               	movsbq	-0x15(%rbp), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	leave
               	retq
