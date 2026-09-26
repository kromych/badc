
gcc_vector_state_array_update.x64:	file format elf64-x86-64

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

<load16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	movzbq	(%rdi), %rcx
               	movb	%cl, (%rax)
               	movzbq	0x1(%rdi), %rcx
               	movb	%cl, 0x1(%rax)
               	movzbq	0x2(%rdi), %rcx
               	movb	%cl, 0x2(%rax)
               	movzbq	0x3(%rdi), %rcx
               	movb	%cl, 0x3(%rax)
               	movzbq	0x4(%rdi), %rcx
               	movb	%cl, 0x4(%rax)
               	movzbq	0x5(%rdi), %rcx
               	movb	%cl, 0x5(%rax)
               	leaq	-0x10(%rbp), %rax
               	movzbq	0x6(%rdi), %rcx
               	movb	%cl, 0x6(%rax)
               	movzbq	0x7(%rdi), %rcx
               	movb	%cl, 0x7(%rax)
               	movzbq	0x8(%rdi), %rcx
               	movb	%cl, 0x8(%rax)
               	movzbq	0x9(%rdi), %rcx
               	movb	%cl, 0x9(%rax)
               	movzbq	0xa(%rdi), %rcx
               	movb	%cl, 0xa(%rax)
               	movzbq	0xb(%rdi), %rcx
               	movb	%cl, 0xb(%rax)
               	leaq	-0x10(%rbp), %rax
               	movzbq	0xc(%rdi), %rcx
               	movb	%cl, 0xc(%rax)
               	movzbq	0xd(%rdi), %rcx
               	movb	%cl, 0xd(%rax)
               	movzbq	0xe(%rdi), %rcx
               	movb	%cl, 0xe(%rax)
               	movzbq	0xf(%rdi), %rcx
               	movb	%cl, 0xf(%rax)
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<store16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movzbq	(%rax), %rcx
               	movb	%cl, (%rdi)
               	movzbq	0x1(%rax), %rcx
               	movb	%cl, 0x1(%rdi)
               	movzbq	0x2(%rax), %rcx
               	movb	%cl, 0x2(%rdi)
               	movzbq	0x3(%rax), %rcx
               	movb	%cl, 0x3(%rdi)
               	movzbq	0x4(%rax), %rcx
               	movb	%cl, 0x4(%rdi)
               	movzbq	0x5(%rax), %rcx
               	movb	%cl, 0x5(%rdi)
               	movzbq	0x6(%rax), %rax
               	movb	%al, 0x6(%rdi)
               	leaq	-0x10(%rbp), %rax
               	movzbq	0x7(%rax), %rcx
               	movb	%cl, 0x7(%rdi)
               	movzbq	0x8(%rax), %rcx
               	movb	%cl, 0x8(%rdi)
               	movzbq	0x9(%rax), %rcx
               	movb	%cl, 0x9(%rdi)
               	movzbq	0xa(%rax), %rcx
               	movb	%cl, 0xa(%rdi)
               	movzbq	0xb(%rax), %rcx
               	movb	%cl, 0xb(%rdi)
               	movzbq	0xc(%rax), %rcx
               	movb	%cl, 0xc(%rdi)
               	movzbq	0xd(%rax), %rax
               	movb	%al, 0xd(%rdi)
               	leaq	-0x10(%rbp), %rax
               	movzbq	0xe(%rax), %rcx
               	movb	%cl, 0xe(%rdi)
               	movzbq	0xf(%rax), %rax
               	movb	%al, 0xf(%rdi)
               	leave
               	retq

<mix>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movups	%xmm0, -0xa0(%rbp)
               	leaq	-0xa0(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	movzbq	(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0x2(%rcx)
               	movzbq	0x3(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0x3(%rcx)
               	movzbq	0x4(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0x4(%rcx)
               	movzbq	0x5(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0x5(%rcx)
               	movzbq	0x6(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0x6(%rcx)
               	movzbq	0x7(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0x7(%rcx)
               	movzbq	0x8(%rax), %rdx
               	shlq	%rdx
               	leaq	0x8(%rcx), %rsi
               	movb	%dl, (%rsi)
               	movzbq	0x9(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0x9(%rcx)
               	movzbq	0xa(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0xa(%rcx)
               	movzbq	0xb(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0xb(%rcx)
               	movzbq	0xc(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0xc(%rcx)
               	movzbq	0xd(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0xd(%rcx)
               	movzbq	0xe(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0xe(%rcx)
               	movzbq	0xf(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0xf(%rcx)
               	movzbq	(%rax), %rdx
               	movq	%rdx, %rdi
               	shrq	$0x7, %rdi
               	movzbq	0x1(%rax), %rdx
               	movq	%rdx, %r8
               	shrq	$0x7, %r8
               	movzbq	0x2(%rax), %rdx
               	movq	%rdx, %r9
               	shrq	$0x7, %r9
               	movzbq	0x3(%rax), %rdx
               	movq	%rdx, %rbx
               	shrq	$0x7, %rbx
               	movzbq	0x4(%rax), %rdx
               	movq	%rdx, %r12
               	shrq	$0x7, %r12
               	movzbq	0x5(%rax), %rdx
               	movq	%rdx, %r13
               	shrq	$0x7, %r13
               	movzbq	0x6(%rax), %rdx
               	movq	%rdx, %r14
               	shrq	$0x7, %r14
               	movzbq	0x7(%rax), %rdx
               	movq	%rdx, %r15
               	shrq	$0x7, %r15
               	movzbq	0x8(%rax), %rdx
               	movq	%rdx, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0xc8(%rsp)
               	movzbq	0x9(%rax), %rdx
               	movq	%rdx, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0xc0(%rsp)
               	movzbq	0xa(%rax), %rdx
               	movq	%rdx, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0xb8(%rsp)
               	movzbq	0xb(%rax), %rdx
               	movq	%rdx, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0xb0(%rsp)
               	movzbq	0xc(%rax), %rdx
               	movq	%rdx, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0xa8(%rsp)
               	movzbq	0xd(%rax), %rdx
               	movq	%rdx, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0xa0(%rsp)
               	movzbq	0xe(%rax), %rdx
               	movq	%rdx, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0x98(%rsp)
               	movzbq	0xf(%rax), %rax
               	movq	%rax, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0x90(%rsp)
               	movl	$0x1b, %edx
               	leaq	-0x80(%rbp), %rax
               	imulq	%rdx, %rdi
               	movb	%dil, (%rax)
               	movq	%r8, %rdi
               	imulq	%rdx, %rdi
               	movb	%dil, 0x1(%rax)
               	movq	%r9, %rdi
               	imulq	%rdx, %rdi
               	movb	%dil, 0x2(%rax)
               	movq	%rbx, %rdi
               	imulq	%rdx, %rdi
               	movb	%dil, 0x3(%rax)
               	movq	%r12, %rdi
               	imulq	%rdx, %rdi
               	movb	%dil, 0x4(%rax)
               	movq	%r13, %rdi
               	imulq	%rdx, %rdi
               	movb	%dil, 0x5(%rax)
               	movq	%r14, %rdi
               	imulq	%rdx, %rdi
               	movb	%dil, 0x6(%rax)
               	movq	%r15, %rdi
               	imulq	%rdx, %rdi
               	movb	%dil, 0x7(%rax)
               	movq	0xc8(%rsp), %r8
               	imulq	%rdx, %r8
               	leaq	0x8(%rax), %rdi
               	movb	%r8b, (%rdi)
               	movq	0xc0(%rsp), %r8
               	imulq	%rdx, %r8
               	movb	%r8b, 0x9(%rax)
               	movq	0xb8(%rsp), %r8
               	imulq	%rdx, %r8
               	movb	%r8b, 0xa(%rax)
               	movq	0xb0(%rsp), %r8
               	imulq	%rdx, %r8
               	movb	%r8b, 0xb(%rax)
               	movq	0xa8(%rsp), %r8
               	imulq	%rdx, %r8
               	movb	%r8b, 0xc(%rax)
               	movq	0xa0(%rsp), %r8
               	imulq	%rdx, %r8
               	movb	%r8b, 0xd(%rax)
               	movq	0x98(%rsp), %r8
               	imulq	%rdx, %r8
               	movb	%r8b, 0xe(%rax)
               	movq	%rdx, %r10
               	movq	0x90(%rsp), %rdx
               	imulq	%r10, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	-0x70(%rbp), %rdx
               	movq	(%rcx), %rcx
               	movq	(%rax), %rax
               	xorq	%rcx, %rax
               	movq	%rax, (%rdx)
               	leaq	0x8(%rdx), %r8
               	movq	(%rsi), %rax
               	movq	(%rdi), %rcx
               	xorq	%rcx, %rax
               	movq	%rax, (%r8)
               	movl	$0x63, %ecx
               	leaq	-0x60(%rbp), %rax
               	movzbq	(%rdx), %rsi
               	xorq	%rcx, %rsi
               	movb	%sil, (%rax)
               	movzbq	0x1(%rdx), %rsi
               	xorq	%rcx, %rsi
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rdx), %rsi
               	xorq	%rcx, %rsi
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rdx), %rsi
               	xorq	%rcx, %rsi
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rdx), %rsi
               	xorq	%rcx, %rsi
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rdx), %rsi
               	xorq	%rcx, %rsi
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rdx), %rsi
               	xorq	%rcx, %rsi
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rdx), %rsi
               	xorq	%rcx, %rsi
               	movb	%sil, 0x7(%rax)
               	movzbq	(%r8), %rsi
               	xorq	%rcx, %rsi
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rdx), %rsi
               	xorq	%rcx, %rsi
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rdx), %rsi
               	xorq	%rcx, %rsi
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rdx), %rsi
               	xorq	%rcx, %rsi
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rdx), %rsi
               	xorq	%rcx, %rsi
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rdx), %rsi
               	xorq	%rcx, %rsi
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rdx), %rsi
               	xorq	%rcx, %rsi
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rdx), %rdx
               	xorq	%rdx, %rcx
               	movb	%cl, 0xf(%rax)
               	movq	%rax, %rcx
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	movups	(%rcx), %xmm0
               	leave
               	retq

<update>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, -0x20(%rbp)
               	movups	%xmm0, -0x40(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x90(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x88(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x80(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x78(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x70(%rbp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, -0x68(%rbp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, -0x60(%rbp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, -0x58(%rbp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, -0x50(%rbp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, -0x48(%rbp)
               	leaq	-0x90(%rbp), %rax
               	leaq	0x40(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rcx
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	(%rcx), %rsi
               	movq	%rdx, %rbx
               	xorq	%rsi, %rbx
               	movq	0x8(%rax), %rdx
               	movq	0x8(%rcx), %rcx
               	movq	%rdx, %r12
               	xorq	%rcx, %r12
               	movq	%rbx, (%rax)
               	movq	%r12, 0x8(%rax)
               	leaq	-0x90(%rbp), %rax
               	leaq	0x30(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	movq	0x40(%rcx), %rdx
               	movq	(%rax), %rsi
               	xorq	%rsi, %rdx
               	movq	0x48(%rcx), %rcx
               	movq	0x8(%rax), %rax
               	xorq	%rax, %rcx
               	leaq	-0x90(%rbp), %rax
               	addq	$0x40, %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x90(%rbp), %rax
               	leaq	0x20(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	movq	0x30(%rcx), %rdx
               	movq	(%rax), %rsi
               	xorq	%rsi, %rdx
               	movq	0x38(%rcx), %rcx
               	movq	0x8(%rax), %rax
               	xorq	%rax, %rcx
               	leaq	-0x90(%rbp), %rax
               	addq	$0x30, %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x90(%rbp), %rax
               	leaq	0x10(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	movq	0x20(%rcx), %rdx
               	movq	(%rax), %rsi
               	xorq	%rsi, %rdx
               	movq	0x28(%rcx), %rcx
               	movq	0x8(%rax), %rax
               	xorq	%rax, %rcx
               	leaq	-0x90(%rbp), %rax
               	addq	$0x20, %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x90(%rbp), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	movq	0x10(%rcx), %rdx
               	movq	(%rax), %rsi
               	xorq	%rsi, %rdx
               	movq	0x18(%rcx), %rcx
               	movq	0x8(%rax), %rax
               	xorq	%rax, %rcx
               	leaq	-0x90(%rbp), %rax
               	addq	$0x10, %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x90(%rbp), %rcx
               	movq	(%rcx), %rax
               	xorq	%rbx, %rax
               	movq	0x8(%rcx), %rdx
               	xorq	%r12, %rdx
               	movq	%rax, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	movq	-0x20(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	movups	0x30(%rcx), %xmm14
               	movups	%xmm14, 0x30(%rax)
               	movups	0x40(%rcx), %xmm14
               	movups	%xmm14, 0x40(%rax)
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<update_scalar>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movzbq	(%rsi), %rdx
               	leaq	0x40(%rdi), %rax
               	movzbq	(%rax), %rcx
               	movq	%rcx, %r8
               	shlq	%r8
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%r8, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	movq	%rdx, %r9
               	xorq	%rcx, %r9
               	movzbq	0x1(%rsi), %rdx
               	movzbq	0x1(%rax), %rcx
               	movq	%rcx, %r8
               	shlq	%r8
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%r8, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	movq	%rdx, %rbx
               	xorq	%rcx, %rbx
               	movzbq	0x2(%rsi), %rdx
               	movzbq	0x2(%rax), %rcx
               	movq	%rcx, %r8
               	shlq	%r8
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%r8, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	movq	%rdx, %r12
               	xorq	%rcx, %r12
               	movzbq	0x3(%rsi), %rdx
               	movzbq	0x3(%rax), %rcx
               	movq	%rcx, %r8
               	shlq	%r8
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%r8, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	movq	%rdx, %r13
               	xorq	%rcx, %r13
               	movzbq	0x4(%rsi), %rdx
               	movzbq	0x4(%rax), %rcx
               	movq	%rcx, %r8
               	shlq	%r8
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%r8, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	movq	%rdx, %r14
               	xorq	%rcx, %r14
               	movzbq	0x5(%rsi), %rcx
               	movzbq	0x5(%rax), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r15
               	xorq	%rax, %r15
               	movzbq	0x6(%rsi), %rcx
               	leaq	0x40(%rdi), %rax
               	movzbq	0x6(%rax), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x88(%rsp)
               	movzbq	0x7(%rsi), %rcx
               	leaq	0x40(%rdi), %rax
               	movzbq	0x7(%rax), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x80(%rsp)
               	movzbq	0x8(%rsi), %rcx
               	leaq	0x40(%rdi), %rax
               	movzbq	0x8(%rax), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x78(%rsp)
               	movzbq	0x9(%rsi), %rcx
               	leaq	0x40(%rdi), %rax
               	movzbq	0x9(%rax), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x70(%rsp)
               	movzbq	0xa(%rsi), %rcx
               	leaq	0x40(%rdi), %rax
               	movzbq	0xa(%rax), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x68(%rsp)
               	movzbq	0xb(%rsi), %rcx
               	leaq	0x40(%rdi), %rax
               	movzbq	0xb(%rax), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x60(%rsp)
               	movzbq	0xc(%rsi), %rcx
               	leaq	0x40(%rdi), %rax
               	movzbq	0xc(%rax), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x58(%rsp)
               	movzbq	0xd(%rsi), %rcx
               	leaq	0x40(%rdi), %rax
               	movzbq	0xd(%rax), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x50(%rsp)
               	movzbq	0xe(%rsi), %rcx
               	leaq	0x40(%rdi), %rax
               	movzbq	0xe(%rax), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x48(%rsp)
               	movzbq	0xf(%rsi), %rcx
               	leaq	0x40(%rdi), %rax
               	movzbq	0xf(%rax), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, (%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x1(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x1(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0x1(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x2(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x2(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0x2(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x3(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x3(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0x3(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x4(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x4(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0x4(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x5(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x5(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0x5(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x6(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x6(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0x6(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x7(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x7(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0x7(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x8(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x8(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0x8(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x9(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x9(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0x9(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xa(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xa(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0xa(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xb(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xb(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0xb(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xc(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xc(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0xc(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xd(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xd(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0xd(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xe(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xe(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0xe(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xf(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xf(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0xf(%rcx)
               	decq	%rax
               	testl	%eax, %eax
               	jg	<addr>
               	movzbq	(%rdi), %rax
               	xorq	%r9, %rax
               	movb	%al, (%rdi)
               	movzbq	0x1(%rdi), %rax
               	xorq	%rbx, %rax
               	movb	%al, 0x1(%rdi)
               	movzbq	0x2(%rdi), %rax
               	xorq	%r12, %rax
               	movb	%al, 0x2(%rdi)
               	movzbq	0x3(%rdi), %rax
               	xorq	%r13, %rax
               	movb	%al, 0x3(%rdi)
               	movzbq	0x4(%rdi), %rax
               	xorq	%r14, %rax
               	movb	%al, 0x4(%rdi)
               	movzbq	0x5(%rdi), %rax
               	xorq	%r15, %rax
               	movb	%al, 0x5(%rdi)
               	movzbq	0x6(%rdi), %rax
               	xorq	0x88(%rsp), %rax
               	movb	%al, 0x6(%rdi)
               	movzbq	0x7(%rdi), %rax
               	xorq	0x80(%rsp), %rax
               	movb	%al, 0x7(%rdi)
               	movzbq	0x8(%rdi), %rax
               	xorq	0x78(%rsp), %rax
               	movb	%al, 0x8(%rdi)
               	movzbq	0x9(%rdi), %rax
               	xorq	0x70(%rsp), %rax
               	movb	%al, 0x9(%rdi)
               	movzbq	0xa(%rdi), %rax
               	xorq	0x68(%rsp), %rax
               	movb	%al, 0xa(%rdi)
               	movzbq	0xb(%rdi), %rax
               	xorq	0x60(%rsp), %rax
               	movb	%al, 0xb(%rdi)
               	movzbq	0xc(%rdi), %rax
               	xorq	0x58(%rsp), %rax
               	movb	%al, 0xc(%rdi)
               	movzbq	0xd(%rdi), %rax
               	xorq	0x50(%rsp), %rax
               	movb	%al, 0xd(%rdi)
               	movzbq	0xe(%rdi), %rax
               	xorq	0x48(%rsp), %rax
               	movb	%al, 0xe(%rdi)
               	movzbq	0xf(%rdi), %rax
               	xorq	0x40(%rsp), %rax
               	movb	%al, 0xf(%rdi)
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<run_chunk>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x118, %rsp            # imm = 0x118
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r13
               	movq	%rdx, %r15
               	movq	%rsi, %r14
               	leaq	-0x70(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movq	%r13, %rdi
               	callq	<addr>
               	movups	%xmm0, -0x110(%rbp)
               	leaq	-0x110(%rbp), %rax
               	leaq	-0x70(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x10(%r13), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x110(%rbp)
               	leaq	-0x110(%rbp), %rax
               	leaq	-0x70(%rbp), %rcx
               	addq	$0x10, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%r13), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x110(%rbp)
               	leaq	-0x110(%rbp), %rax
               	leaq	-0x70(%rbp), %rcx
               	addq	$0x20, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x30(%r13), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x110(%rbp)
               	leaq	-0x110(%rbp), %rax
               	leaq	-0x70(%rbp), %rcx
               	addq	$0x30, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%r13), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x110(%rbp)
               	leaq	-0x110(%rbp), %rcx
               	leaq	-0x70(%rbp), %rax
               	leaq	0x40(%rax), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	0x10(%rax), %rsi
               	movq	0x18(%rax), %rdi
               	movq	0x20(%rax), %r8
               	movq	0x28(%rax), %r9
               	movq	0x30(%rax), %rbx
               	movq	0x38(%rax), %r12
               	movq	0x40(%rax), %r10
               	movq	%r10, 0x138(%rsp)
               	movq	0x48(%rax), %r10
               	movq	%r10, 0x130(%rsp)
               	leaq	-0x110(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	movq	%r8, 0x20(%rax)
               	movq	%r9, 0x28(%rax)
               	movq	%rbx, 0x30(%rax)
               	movq	%r12, 0x38(%rax)
               	movq	0x138(%rsp), %r11
               	movq	%r11, 0x40(%rax)
               	movq	0x130(%rsp), %r11
               	movq	%r11, 0x48(%rax)
               	xorl	%ebx, %ebx
               	cmpl	%r15d, %ebx
               	jge	<addr>
               	leaq	-0x110(%rbp), %r12
               	leaq	-0xc0(%rbp), %r10
               	movq	%r10, 0x138(%rsp)
               	movq	%rbx, %rax
               	shlq	$0x4, %rax
               	movslq	%eax, %rax
               	leaq	(%r14,%rax), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x70(%rbp)
               	leaq	-0x70(%rbp), %r9
               	subq	$0x50, %rsp
               	movq	%r12, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x20(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x28(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x30(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x38(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	0x40(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x48(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	0x188(%rsp), %rdi
               	callq	<addr>
               	addq	$0x50, %rsp
               	leaq	-0xc0(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r12)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r12)
               	movups	0x20(%rax), %xmm14
               	movups	%xmm14, 0x20(%r12)
               	movups	0x30(%rax), %xmm14
               	movups	%xmm14, 0x30(%r12)
               	movups	0x40(%rax), %xmm14
               	movups	%xmm14, 0x40(%r12)
               	incq	%rbx
               	cmpl	%r15d, %ebx
               	jl	<addr>
               	leaq	-0x110(%rbp), %rax
               	leaq	-0x70(%rbp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	movups	0x20(%rax), %xmm14
               	movups	%xmm14, 0x20(%r9)
               	movups	0x30(%rax), %xmm14
               	movups	%xmm14, 0x30(%r9)
               	movups	0x40(%rax), %xmm14
               	movups	%xmm14, 0x40(%r9)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%r13, %rdi
               	callq	<addr>
               	leaq	0x10(%r13), %rdi
               	leaq	-0x70(%rbp), %rax
               	leaq	0x10(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	0x20(%r13), %rdi
               	leaq	-0x70(%rbp), %rax
               	leaq	0x20(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	0x30(%r13), %rdi
               	leaq	-0x70(%rbp), %rax
               	leaq	0x30(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	0x40(%r13), %rdi
               	leaq	-0x70(%rbp), %rax
               	leaq	0x40(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x360, %rsp            # imm = 0x360
               	pushq	%r12
               	pushq	%rbx
               	xorl	%eax, %eax
               	leaq	-0x218(%rbp), %rcx
               	imulq	$0x7, %rax, %rdx
               	incq	%rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x50, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x1c8(%rbp), %rcx
               	imulq	$0x1f, %rax, %rdx
               	addq	$0x9, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x80, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x148(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	-0x218(%rbp), %rdx
               	movzbq	(%rdx,%rcx), %rdx
               	movb	%dl, (%rsi)
               	leaq	-0x218(%rbp), %rdx
               	leaq	0x1(%rcx), %rdi
               	movzbq	(%rdx,%rdi), %rdi
               	movb	%dil, 0x1(%rsi)
               	leaq	-0x148(%rbp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0x2(%rcx), %r8
               	movzbq	(%rdx,%r8), %r8
               	movb	%r8b, 0x2(%rdi)
               	addq	%rcx, %rsi
               	leaq	0x3(%rcx), %rdi
               	movzbq	(%rdx,%rdi), %rdx
               	movb	%dl, 0x3(%rsi)
               	leaq	-0x148(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	-0x218(%rbp), %rsi
               	addq	$0x4, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	movb	%cl, 0x4(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	0x5(%rcx), %rdx
               	movzbq	(%rsi,%rdx), %rdx
               	movb	%dl, 0x5(%rdi)
               	leaq	-0x218(%rbp), %rdx
               	leaq	0x6(%rcx), %rsi
               	movzbq	(%rdx,%rsi), %rsi
               	movb	%sil, 0x6(%rdi)
               	leaq	-0x148(%rbp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0x7(%rcx), %r8
               	movzbq	(%rdx,%r8), %r8
               	movb	%r8b, 0x7(%rdi)
               	addq	%rcx, %rsi
               	leaq	0x8(%rcx), %rdi
               	movzbq	(%rdx,%rdi), %rdx
               	movb	%dl, 0x8(%rsi)
               	leaq	-0x148(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	-0x218(%rbp), %rsi
               	addq	$0x9, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	movb	%cl, 0x9(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	0xa(%rcx), %rdx
               	movzbq	(%rsi,%rdx), %rdx
               	movb	%dl, 0xa(%rdi)
               	leaq	-0x218(%rbp), %rdx
               	leaq	0xb(%rcx), %rsi
               	movzbq	(%rdx,%rsi), %rsi
               	movb	%sil, 0xb(%rdi)
               	leaq	-0x148(%rbp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0xc(%rcx), %r8
               	movzbq	(%rdx,%r8), %r8
               	movb	%r8b, 0xc(%rdi)
               	addq	%rcx, %rsi
               	leaq	0xd(%rcx), %rdi
               	movzbq	(%rdx,%rdi), %rdx
               	movb	%dl, 0xd(%rsi)
               	leaq	-0x148(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	-0x218(%rbp), %rsi
               	addq	$0xe, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	movb	%cl, 0xe(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rdx
               	addq	$0xf, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	movb	%cl, 0xf(%rdx)
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	leaq	-0x148(%rbp), %rdi
               	leaq	-0x1c8(%rbp), %rsi
               	callq	<addr>
               	leaq	-0x148(%rbp), %rdi
               	leaq	-0x1c8(%rbp), %rax
               	leaq	0x10(%rax), %rsi
               	callq	<addr>
               	leaq	-0x148(%rbp), %rdi
               	leaq	-0x1c8(%rbp), %rax
               	leaq	0x20(%rax), %rsi
               	callq	<addr>
               	leaq	-0x148(%rbp), %rdi
               	leaq	-0x1c8(%rbp), %rax
               	leaq	0x30(%rax), %rsi
               	callq	<addr>
               	leaq	-0x148(%rbp), %rdi
               	leaq	-0x1c8(%rbp), %rax
               	leaq	0x40(%rax), %rsi
               	callq	<addr>
               	leaq	-0x148(%rbp), %rdi
               	leaq	-0x1c8(%rbp), %rax
               	leaq	0x50(%rax), %rsi
               	callq	<addr>
               	leaq	-0x148(%rbp), %rdi
               	leaq	-0x1c8(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	callq	<addr>
               	leaq	-0x148(%rbp), %rbx
               	leaq	-0x1c8(%rbp), %rax
               	leaq	0x70(%rax), %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	leaq	-0xf8(%rbp), %rcx
               	leaq	-0x218(%rbp), %rdx
               	movzbq	(%rdx,%rax), %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x50, %eax
               	jl	<addr>
               	leaq	-0xf8(%rbp), %r12
               	leaq	-0x1c8(%rbp), %rsi
               	movl	$0x8, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	movq	%rdx, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rcx,%rax), %rsi
               	movzbq	(%r12,%rsi), %rsi
               	addq	%rbx, %rcx
               	movzbq	(%rcx,%rax), %rcx
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x5, %edx
               	jl	<addr>
               	xorl	%ebx, %ebx
               	xorl	%eax, %eax
               	leaq	-0x268(%rbp), %rcx
               	leaq	-0x218(%rbp), %rdx
               	movzbq	(%rdx,%rax), %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x50, %eax
               	jl	<addr>
               	leaq	-0x268(%rbp), %rdi
               	leaq	-0x1c8(%rbp), %rsi
               	movq	%rbx, %rdx
               	callq	<addr>
               	leaq	-0x268(%rbp), %rdi
               	leaq	-0x1c8(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rax,%rcx), %rsi
               	movl	$0x8, %eax
               	movq	%rax, %rdx
               	subq	%rbx, %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	leaq	-0x268(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rcx
               	leaq	-0xf8(%rbp), %rdx
               	movzbq	(%rdx,%rax), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x50, %eax
               	jl	<addr>
               	incq	%rbx
               	cmpl	$0x8, %ebx
               	jle	<addr>
               	leaq	-0x218(%rbp), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x310(%rbp)
               	leaq	-0x310(%rbp), %rax
               	leaq	-0x360(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x218(%rbp), %rax
               	leaq	0x10(%rax), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x310(%rbp)
               	leaq	-0x310(%rbp), %rax
               	leaq	-0x350(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x218(%rbp), %rax
               	leaq	0x20(%rax), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x310(%rbp)
               	leaq	-0x310(%rbp), %rax
               	leaq	-0x340(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x218(%rbp), %rax
               	leaq	0x30(%rax), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x310(%rbp)
               	leaq	-0x310(%rbp), %rax
               	leaq	-0x330(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x218(%rbp), %rax
               	leaq	0x40(%rax), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x310(%rbp)
               	leaq	-0x310(%rbp), %rax
               	leaq	-0x320(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x310(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	leaq	-0x360(%rbp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x350(%rbp), %rdx
               	leaq	0x10(%rax), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0x340(%rbp), %rdx
               	leaq	0x20(%rax), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0x330(%rbp), %rdx
               	leaq	0x30(%rax), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	addq	$0x40, %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x1c8(%rbp), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x320(%rbp)
               	leaq	-0x320(%rbp), %r9
               	leaq	-0x2c0(%rbp), %rdi
               	leaq	-0x310(%rbp), %rax
               	subq	$0x50, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x20(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x28(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x30(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x38(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	0x40(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x48(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	addq	$0x50, %rsp
               	leaq	-0x2c0(%rbp), %rax
               	leaq	-0xa8(%rbp), %rdi
               	leaq	-0x310(%rbp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	movups	0x20(%rax), %xmm14
               	movups	%xmm14, 0x20(%r9)
               	movups	0x30(%rax), %xmm14
               	movups	%xmm14, 0x30(%r9)
               	movups	0x40(%rax), %xmm14
               	movups	%xmm14, 0x40(%r9)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	-0xa8(%rbp), %rax
               	leaq	0x10(%rax), %rdi
               	leaq	-0x310(%rbp), %rax
               	leaq	0x10(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	-0xa8(%rbp), %rax
               	leaq	0x20(%rax), %rdi
               	leaq	-0x310(%rbp), %rax
               	leaq	0x20(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	-0xa8(%rbp), %rax
               	leaq	0x30(%rax), %rdi
               	leaq	-0x310(%rbp), %rax
               	leaq	0x30(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	-0xa8(%rbp), %rax
               	leaq	0x40(%rax), %rdi
               	leaq	-0x310(%rbp), %rax
               	leaq	0x40(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	xorl	%eax, %eax
               	leaq	-0x50(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	-0x218(%rbp), %rdx
               	movzbq	(%rdx,%rcx), %rdx
               	movb	%dl, (%rsi)
               	leaq	-0x218(%rbp), %rdx
               	leaq	0x1(%rcx), %rdi
               	movzbq	(%rdx,%rdi), %rdi
               	movb	%dil, 0x1(%rsi)
               	leaq	-0x50(%rbp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0x2(%rcx), %r8
               	movzbq	(%rdx,%r8), %r8
               	movb	%r8b, 0x2(%rdi)
               	addq	%rcx, %rsi
               	leaq	0x3(%rcx), %rdi
               	movzbq	(%rdx,%rdi), %rdx
               	movb	%dl, 0x3(%rsi)
               	leaq	-0x50(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	-0x218(%rbp), %rsi
               	addq	$0x4, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	movb	%cl, 0x4(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	0x5(%rcx), %rdx
               	movzbq	(%rsi,%rdx), %rdx
               	movb	%dl, 0x5(%rdi)
               	leaq	-0x218(%rbp), %rdx
               	leaq	0x6(%rcx), %rsi
               	movzbq	(%rdx,%rsi), %rsi
               	movb	%sil, 0x6(%rdi)
               	leaq	-0x50(%rbp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0x7(%rcx), %r8
               	movzbq	(%rdx,%r8), %r8
               	movb	%r8b, 0x7(%rdi)
               	addq	%rcx, %rsi
               	leaq	0x8(%rcx), %rdi
               	movzbq	(%rdx,%rdi), %rdx
               	movb	%dl, 0x8(%rsi)
               	leaq	-0x50(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	-0x218(%rbp), %rsi
               	addq	$0x9, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	movb	%cl, 0x9(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	0xa(%rcx), %rdx
               	movzbq	(%rsi,%rdx), %rdx
               	movb	%dl, 0xa(%rdi)
               	leaq	-0x218(%rbp), %rdx
               	leaq	0xb(%rcx), %rsi
               	movzbq	(%rdx,%rsi), %rsi
               	movb	%sil, 0xb(%rdi)
               	leaq	-0x50(%rbp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0xc(%rcx), %r8
               	movzbq	(%rdx,%r8), %r8
               	movb	%r8b, 0xc(%rdi)
               	addq	%rcx, %rsi
               	leaq	0xd(%rcx), %rdi
               	movzbq	(%rdx,%rdi), %rdx
               	movb	%dl, 0xd(%rsi)
               	leaq	-0x50(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	-0x218(%rbp), %rsi
               	addq	$0xe, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	movb	%cl, 0xe(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rdx
               	addq	$0xf, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	movb	%cl, 0xf(%rdx)
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rbx
               	leaq	-0x1c8(%rbp), %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	leaq	-0xa8(%rbp), %rsi
               	movq	%rdx, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rcx,%rax), %rdi
               	movzbq	(%rsi,%rdi), %rsi
               	addq	%rbx, %rcx
               	movzbq	(%rcx,%rax), %rcx
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x5, %edx
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x14, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	0x2(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
