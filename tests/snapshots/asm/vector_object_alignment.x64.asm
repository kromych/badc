
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
               	subq	$0x30, %rsp
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	movb	$0x1, -0x30(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movb	$0x2, -0x28(%rbp)
               	leaq	0x20(%rsp), %rdx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movb	$0x3, -0x20(%rbp)
               	leaq	(%rsp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movb	$0x4, -0x18(%rbp)
               	leaq	0x30(%rsp), %rax
               	leaq	<rip>, %rdi
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movb	$0x5, -0x10(%rbp)
               	leaq	0x50(%rsp), %rdi
               	leaq	<rip>, %r8
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%r8), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movups	0x20(%r8), %xmm14
               	movups	%xmm14, 0x20(%rdi)
               	leaq	0x80(%rsp), %rdi
               	leaq	<rip>, %r8
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rdi)
               	testb	$0x7, %cl
               	je	<addr>
               	movl	$0x1d, %eax
               	leaq	-0x30(%rbp), %rsp
               	leave
               	retq
               	testb	$0xf, %dl
               	je	<addr>
               	movl	$0x1e, %eax
               	leaq	-0x30(%rbp), %rsp
               	leave
               	retq
               	testb	$0x1f, %sil
               	je	<addr>
               	movl	$0x1f, %eax
               	leaq	-0x30(%rbp), %rsp
               	leave
               	retq
               	testb	$0xf, %al
               	jne	<addr>
               	addq	$0x10, %rax
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x20, %eax
               	leaq	-0x30(%rbp), %rsp
               	leave
               	retq
               	leaq	0x50(%rsp), %rax
               	testb	$0xf, %al
               	jne	<addr>
               	addq	$0x10, %rax
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x21, %eax
               	leaq	-0x30(%rbp), %rsp
               	leave
               	retq
               	testb	$0xf, %dil
               	je	<addr>
               	movl	$0x22, %eax
               	leaq	-0x30(%rbp), %rsp
               	leave
               	retq
               	movsbq	-0x30(%rbp), %rax
               	movsbq	-0x28(%rbp), %rcx
               	addq	%rcx, %rax
               	movsbq	-0x20(%rbp), %rcx
               	addq	%rcx, %rax
               	movsbq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movsbq	-0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x24, %eax
               	leaq	-0x30(%rbp), %rsp
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0x30(%rbp), %rsp
               	leave
               	retq

<by_value>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
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
               	movb	%dil, -0x20(%rbp)
               	leaq	0x20(%rsp), %rcx
               	testb	$0xf, %cl
               	je	<addr>
               	movl	$0x25, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
               	leaq	(%rsp), %rdx
               	testb	$0x1f, %dl
               	je	<addr>
               	movl	$0x26, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
               	leaq	0x30(%rsp), %rax
               	testb	$0xf, %al
               	jne	<addr>
               	leaq	0x10(%rax), %rsi
               	testb	$0xf, %sil
               	je	<addr>
               	movl	$0x27, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
               	movsbq	-0x20(%rbp), %rsi
               	movslq	0x4(%rcx), %rcx
               	addq	%rsi, %rcx
               	movslq	0x14(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	0x18(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0x11, %eax
               	je	<addr>
               	movl	$0x28, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq

<parameters>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	leaq	0x20(%rsp), %r9
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x30(%rsp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
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
               	leaq	(%rbp), %rsp
               	popq	%rbp
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
