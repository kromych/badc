
vector_object_alignment.x64:	file format elf64-x86-64

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

<file_scope_objects>:
               	leaq	<rip>, %rax
               	movq	%rax, %rcx
               	andq	$0x7, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	%rcx, %rdx
               	andq	$0xf, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	leaq	<rip>, %rdx
               	movq	%rdx, %rsi
               	andq	$0x1f, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	leaq	<rip>, %rsi
               	movq	%rsi, %rdi
               	andq	$0xf, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	leaq	0x10(%rsi), %r8
               	movq	%r8, %rdi
               	andq	$0xf, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	leaq	<rip>, %rdi
               	movq	%rdi, %r9
               	andq	$0xf, %r9
               	testq	%r9, %r9
               	jne	<addr>
               	leaq	0x10(%rdi), %r9
               	andq	$0xf, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	subq	%rsi, %r8
               	cmpq	$0x10, %r8
               	je	<addr>
               	movl	$0x13, %eax
               	retq
               	leaq	0x20(%rdi), %rsi
               	subq	%rdi, %rsi
               	cmpq	$0x20, %rsi
               	je	<addr>
               	movl	$0x14, %eax
               	retq
               	movw	$0x3, 0x2(%rax)
               	movl	$0x5, 0xc(%rcx)
               	movl	$0x7, 0x1c(%rdx)
               	leaq	<rip>, %rsi
               	movl	$0xb, 0x10(%rsi)
               	leaq	<rip>, %rdi
               	movl	$0xd, 0x24(%rdi)
               	movswq	0x2(%rax), %rax
               	movslq	0xc(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	0x1c(%rdx), %rcx
               	addq	%rcx, %rax
               	movslq	0x10(%rsi), %rcx
               	addq	%rcx, %rax
               	addq	$0xd, %rax
               	cmpl	$0x27, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<static_local_objects>:
               	leaq	<rip>, %rdx
               	movq	%rdx, %rax
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	leaq	<rip>, %rsi
               	movq	%rsi, %rax
               	andq	$0x1f, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	%rax, %rcx
               	andq	$0x1f, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	0x20(%rax), %rcx
               	andq	$0x1f, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x19, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	%rcx, %rdi
               	andq	$0xf, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	leaq	0x10(%rcx), %rdi
               	andq	$0xf, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x1a, %eax
               	retq
               	movl	$0x1, (%rdx)
               	movl	$0x2, (%rsi)
               	movl	$0x3, 0x20(%rax)
               	movl	$0x4, 0x10(%rcx)
               	movslq	(%rdx), %rcx
               	movslq	(%rsi), %rdx
               	addq	%rdx, %rcx
               	movslq	0x20(%rax), %rax
               	addq	%rcx, %rax
               	addq	$0x4, %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x1b, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x1c, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<automatic_objects>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	movb	$0x1, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	popq	%rcx
               	movb	$0x2, -0x18(%rbp)
               	leaq	0x20(%rsp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movb	$0x3, -0x30(%rbp)
               	leaq	(%rsp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdi)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rdi)
               	popq	%rcx
               	movb	$0x4, -0x58(%rbp)
               	leaq	0x30(%rsp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	popq	%rdx
               	movb	$0x5, -0x80(%rbp)
               	leaq	0x50(%rsp), %rcx
               	leaq	<rip>, %r8
               	pushq	%rax
               	movq	(%r8), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%r8), %rax
               	movq	%rax, 0x8(%rcx)
               	movq	0x10(%r8), %rax
               	movq	%rax, 0x10(%rcx)
               	movq	0x18(%r8), %rax
               	movq	%rax, 0x18(%rcx)
               	movq	0x20(%r8), %rax
               	movq	%rax, 0x20(%rcx)
               	movq	0x28(%r8), %rax
               	movq	%rax, 0x28(%rcx)
               	popq	%rax
               	leaq	0x80(%rsp), %rcx
               	leaq	<rip>, %r8
               	pushq	%rax
               	movq	(%r8), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%r8), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	andq	$0x7, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %eax
               	leaq	-0xf0(%rbp), %rsp
               	leave
               	retq
               	movq	%rsi, %rdx
               	andq	$0xf, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1e, %eax
               	leaq	-0xf0(%rbp), %rsp
               	leave
               	retq
               	movq	%rdi, %rdx
               	andq	$0x1f, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1f, %eax
               	leaq	-0xf0(%rbp), %rsp
               	leave
               	retq
               	movq	%rax, %rdx
               	andq	$0xf, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	addq	$0x10, %rax
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	leaq	-0xf0(%rbp), %rsp
               	leave
               	retq
               	leaq	0x50(%rsp), %rax
               	movq	%rax, %rdx
               	andq	$0xf, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	addq	$0x10, %rax
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	leaq	-0xf0(%rbp), %rsp
               	leave
               	retq
               	movq	%rcx, %rax
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x22, %eax
               	leaq	-0xf0(%rbp), %rsp
               	leave
               	retq
               	movsbq	-0x8(%rbp), %rax
               	movsbq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movsbq	-0x30(%rbp), %rcx
               	addq	%rcx, %rax
               	movsbq	-0x58(%rbp), %rcx
               	addq	%rcx, %rax
               	movsbq	-0x80(%rbp), %rcx
               	addq	%rcx, %rax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x24, %eax
               	leaq	-0xf0(%rbp), %rsp
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0xf0(%rbp), %rsp
               	leave
               	retq

<by_value>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x90(%rbp)
               	movups	%xmm0, 0x20(%rsp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movsbq	%dil, %rdi
               	movb	%dil, -0x90(%rbp)
               	leaq	0x20(%rsp), %rcx
               	movq	%rcx, %rax
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x25, %eax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
               	leaq	(%rsp), %rdx
               	movq	%rdx, %rax
               	andq	$0x1f, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x26, %eax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
               	leaq	0x30(%rsp), %rax
               	movq	%rax, %rsi
               	andq	$0xf, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	0x10(%rax), %rsi
               	andq	$0xf, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x27, %eax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
               	movsbq	-0x90(%rbp), %rsi
               	movslq	0x4(%rcx), %rcx
               	addq	%rsi, %rcx
               	movslq	0x14(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	0x18(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0x11, %eax
               	je	<addr>
               	movl	$0x28, %eax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq

<parameters>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	leaq	0x20(%rsp), %r9
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r9)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r9)
               	popq	%rcx
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	popq	%rdx
               	leaq	0x30(%rsp), %rcx
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
               	movl	$0x1, %edi
               	subq	$0x40, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%r9, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	addq	$0x40, %rsp
               	movslq	%eax, %rax
               	leaq	-0x70(%rbp), %rsp
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
