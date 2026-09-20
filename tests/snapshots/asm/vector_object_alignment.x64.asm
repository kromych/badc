
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
               	leaq	<rip>, %rdx
               	testb	$0x7, %dl
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	leaq	<rip>, %rsi
               	testb	$0xf, %sil
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	leaq	<rip>, %rdi
               	testb	$0x1f, %dil
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	leaq	<rip>, %rcx
               	testb	$0xf, %cl
               	jne	<addr>
               	leaq	0x10(%rcx), %r8
               	testb	$0xf, %r8b
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	leaq	<rip>, %rax
               	testb	$0xf, %al
               	jne	<addr>
               	leaq	0x10(%rax), %r9
               	testb	$0xf, %r9b
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	subq	%rcx, %r8
               	cmpq	$0x10, %r8
               	je	<addr>
               	movl	$0x13, %eax
               	retq
               	leaq	0x20(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x20, %rcx
               	je	<addr>
               	movl	$0x14, %eax
               	retq
               	movw	$0x3, 0x2(%rdx)
               	movl	$0x5, 0xc(%rsi)
               	movl	$0x7, 0x1c(%rdi)
               	leaq	<rip>, %rax
               	movl	$0xb, 0x10(%rax)
               	leaq	<rip>, %rcx
               	movl	$0xd, 0x24(%rcx)
               	leaq	<rip>, %rdx
               	movswq	0x2(%rdx), %rdx
               	leaq	<rip>, %rsi
               	movslq	0xc(%rsi), %rsi
               	addq	%rsi, %rdx
               	leaq	<rip>, %rsi
               	movslq	0x1c(%rsi), %rsi
               	addq	%rsi, %rdx
               	movslq	0x10(%rax), %rax
               	addq	%rdx, %rax
               	movslq	0x24(%rcx), %rcx
               	addq	%rcx, %rax
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
               	leaq	<rip>, %rax
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	leaq	<rip>, %rcx
               	testb	$0x1f, %cl
               	je	<addr>
               	movl	$0x18, %eax
               	retq
               	leaq	<rip>, %rdx
               	testb	$0x1f, %dl
               	jne	<addr>
               	leaq	0x20(%rdx), %rsi
               	testb	$0x1f, %sil
               	je	<addr>
               	movl	$0x19, %eax
               	retq
               	leaq	<rip>, %rsi
               	testb	$0xf, %sil
               	jne	<addr>
               	leaq	0x10(%rsi), %rdi
               	testb	$0xf, %dil
               	je	<addr>
               	movl	$0x1a, %eax
               	retq
               	movl	$0x1, (%rax)
               	movl	$0x2, (%rcx)
               	movl	$0x3, 0x20(%rdx)
               	movl	$0x4, 0x10(%rsi)
               	movslq	(%rax), %rax
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movslq	0x20(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movslq	0x10(%rcx), %rcx
               	addq	%rcx, %rax
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
               	leaq	-0x10(%rbp), %rcx
               	leaq	<rip>, %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movb	$0x2, -0x18(%rbp)
               	leaq	0x20(%rsp), %rdx
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movb	$0x3, -0x30(%rbp)
               	leaq	(%rsp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rsi)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rsi)
               	popq	%rcx
               	movb	$0x4, -0x58(%rbp)
               	leaq	0x30(%rsp), %rax
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
               	movb	$0x5, -0x80(%rbp)
               	leaq	0x50(%rsp), %rdi
               	leaq	<rip>, %r8
               	pushq	%rax
               	movq	(%r8), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%r8), %rax
               	movq	%rax, 0x8(%rdi)
               	movq	0x10(%r8), %rax
               	movq	%rax, 0x10(%rdi)
               	movq	0x18(%r8), %rax
               	movq	%rax, 0x18(%rdi)
               	movq	0x20(%r8), %rax
               	movq	%rax, 0x20(%rdi)
               	movq	0x28(%r8), %rax
               	movq	%rax, 0x28(%rdi)
               	popq	%rax
               	leaq	0x80(%rsp), %rdi
               	leaq	<rip>, %r8
               	pushq	%rax
               	movq	(%r8), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%r8), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	testb	$0x7, %cl
               	je	<addr>
               	movl	$0x1d, %eax
               	leaq	-0xf0(%rbp), %rsp
               	leave
               	retq
               	testb	$0xf, %dl
               	je	<addr>
               	movl	$0x1e, %eax
               	leaq	-0xf0(%rbp), %rsp
               	leave
               	retq
               	testb	$0x1f, %sil
               	je	<addr>
               	movl	$0x1f, %eax
               	leaq	-0xf0(%rbp), %rsp
               	leave
               	retq
               	testb	$0xf, %al
               	jne	<addr>
               	addq	$0x10, %rax
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x20, %eax
               	leaq	-0xf0(%rbp), %rsp
               	leave
               	retq
               	leaq	0x50(%rsp), %rax
               	testb	$0xf, %al
               	jne	<addr>
               	addq	$0x10, %rax
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x21, %eax
               	leaq	-0xf0(%rbp), %rsp
               	leave
               	retq
               	testb	$0xf, %dil
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
               	testb	$0xf, %cl
               	je	<addr>
               	movl	$0x25, %eax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
               	leaq	(%rsp), %rdx
               	testb	$0x1f, %dl
               	je	<addr>
               	movl	$0x26, %eax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
               	leaq	0x30(%rsp), %rax
               	testb	$0xf, %al
               	jne	<addr>
               	leaq	0x10(%rax), %rsi
               	testb	$0xf, %sil
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
               	movups	(%r10), %xmm0
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	-0x70(%rbp), %rsp
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	popq	%rbp
               	retq
