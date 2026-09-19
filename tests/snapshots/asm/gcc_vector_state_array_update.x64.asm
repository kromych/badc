
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
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rax
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
               	leaq	-0x20(%rbp), %rax
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
               	leaq	-0x20(%rbp), %rax
               	movzbq	0xc(%rdi), %rcx
               	movb	%cl, 0xc(%rax)
               	movzbq	0xd(%rdi), %rcx
               	movb	%cl, 0xd(%rax)
               	movzbq	0xe(%rdi), %rcx
               	movb	%cl, 0xe(%rax)
               	movzbq	0xf(%rdi), %rcx
               	movb	%cl, 0xf(%rax)
               	movq	%rax, %rcx
               	movups	(%rcx,%riz), %xmm0
               	leave
               	retq

<store16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movups	%xmm0, -0x20(%rbp,%riz)
               	leaq	-0x20(%rbp), %rax
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
               	leaq	-0x20(%rbp), %rax
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
               	leaq	-0x20(%rbp), %rax
               	movzbq	0xe(%rax), %rcx
               	movb	%cl, 0xe(%rdi)
               	movzbq	0xf(%rax), %rax
               	movb	%al, 0xf(%rdi)
               	leave
               	retq

<mix>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movups	%xmm0, -0xb0(%rbp,%riz)
               	leaq	-0xb0(%rbp), %rax
               	leaq	-0x50(%rbp), %rcx
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
               	movq	%r10, 0x88(%rsp)
               	movzbq	0x9(%rax), %rdx
               	movq	%rdx, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0x80(%rsp)
               	movzbq	0xa(%rax), %rdx
               	movq	%rdx, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0x78(%rsp)
               	movzbq	0xb(%rax), %rdx
               	movq	%rdx, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0x70(%rsp)
               	movzbq	0xc(%rax), %rdx
               	movq	%rdx, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0x68(%rsp)
               	movzbq	0xd(%rax), %rdx
               	movq	%rdx, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0x60(%rsp)
               	movzbq	0xe(%rax), %rdx
               	movq	%rdx, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0x58(%rsp)
               	movzbq	0xf(%rax), %rax
               	movq	%rax, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0x50(%rsp)
               	movl	$0x1b, %edx
               	leaq	-0x40(%rbp), %rax
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
               	movq	0x88(%rsp), %r8
               	imulq	%rdx, %r8
               	leaq	0x8(%rax), %rdi
               	movb	%r8b, (%rdi)
               	movq	0x80(%rsp), %r8
               	imulq	%rdx, %r8
               	movb	%r8b, 0x9(%rax)
               	movq	0x78(%rsp), %r8
               	imulq	%rdx, %r8
               	movb	%r8b, 0xa(%rax)
               	movq	0x70(%rsp), %r8
               	imulq	%rdx, %r8
               	movb	%r8b, 0xb(%rax)
               	movq	0x68(%rsp), %r8
               	imulq	%rdx, %r8
               	movb	%r8b, 0xc(%rax)
               	movq	0x60(%rsp), %r8
               	imulq	%rdx, %r8
               	movb	%r8b, 0xd(%rax)
               	movq	0x58(%rsp), %r8
               	imulq	%rdx, %r8
               	movb	%r8b, 0xe(%rax)
               	movq	%rdx, %r10
               	movq	0x50(%rsp), %rdx
               	imulq	%r10, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	-0x30(%rbp), %rdx
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
               	leaq	-0x10(%rbp), %rax
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
               	movups	(%rcx,%riz), %xmm0
               	leave
               	retq

<update>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, -0x90(%rbp)
               	movups	%xmm0, -0xa0(%rbp,%riz)
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0xf0(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0xe8(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0xe0(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0xd8(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0xd0(%rbp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, -0xc8(%rbp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, -0xc0(%rbp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, -0xb8(%rbp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, -0xb0(%rbp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, -0xa8(%rbp)
               	leaq	-0xa0(%rbp), %rbx
               	leaq	-0xf0(%rbp), %rax
               	leaq	0x40(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	movups	%xmm0, -0x70(%rbp,%riz)
               	leaq	-0x70(%rbp), %rax
               	movq	(%rbx), %rcx
               	movq	(%rax), %rdx
               	movq	%rcx, %r12
               	xorq	%rdx, %r12
               	movq	0x8(%rbx), %rcx
               	movq	0x8(%rax), %rax
               	movq	%rcx, %r13
               	xorq	%rax, %r13
               	movq	%r12, (%rbx)
               	movq	%r13, 0x8(%rbx)
               	leaq	-0xf0(%rbp), %rbx
               	leaq	0x40(%rbx), %r14
               	leaq	0x30(%rbx), %r9
               	movq	%r9, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	movups	%xmm0, -0x70(%rbp,%riz)
               	leaq	-0x70(%rbp), %rax
               	movq	0x40(%rbx), %rcx
               	movq	(%rax), %rdx
               	xorq	%rdx, %rcx
               	movq	0x48(%rbx), %rdx
               	movq	0x8(%rax), %rax
               	xorq	%rdx, %rax
               	movq	%rcx, (%r14)
               	movq	%rax, 0x8(%r14)
               	leaq	-0xf0(%rbp), %rbx
               	leaq	0x30(%rbx), %r14
               	leaq	0x20(%rbx), %r9
               	movq	%r9, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	movups	%xmm0, -0x70(%rbp,%riz)
               	leaq	-0x70(%rbp), %rax
               	movq	0x30(%rbx), %rcx
               	movq	(%rax), %rdx
               	xorq	%rdx, %rcx
               	movq	0x38(%rbx), %rdx
               	movq	0x8(%rax), %rax
               	xorq	%rdx, %rax
               	movq	%rcx, (%r14)
               	movq	%rax, 0x8(%r14)
               	leaq	-0xf0(%rbp), %rbx
               	leaq	0x20(%rbx), %r14
               	leaq	0x10(%rbx), %r9
               	movq	%r9, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	movups	%xmm0, -0x70(%rbp,%riz)
               	leaq	-0x70(%rbp), %rax
               	movq	0x20(%rbx), %rcx
               	movq	(%rax), %rdx
               	xorq	%rdx, %rcx
               	movq	0x28(%rbx), %rdx
               	movq	0x8(%rax), %rax
               	xorq	%rdx, %rax
               	movq	%rcx, (%r14)
               	movq	%rax, 0x8(%r14)
               	leaq	-0xf0(%rbp), %rbx
               	leaq	0x10(%rbx), %r14
               	movq	%rbx, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	movups	%xmm0, -0x70(%rbp,%riz)
               	leaq	-0x70(%rbp), %rax
               	movq	0x10(%rbx), %rcx
               	movq	(%rax), %rdx
               	xorq	%rdx, %rcx
               	movq	0x18(%rbx), %rdx
               	movq	0x8(%rax), %rax
               	xorq	%rdx, %rax
               	movq	%rcx, (%r14)
               	movq	%rax, 0x8(%r14)
               	leaq	-0xf0(%rbp), %rax
               	movq	(%rax), %rdx
               	xorq	%r12, %rdx
               	movq	0x8(%rax), %rsi
               	movq	%rsi, %rcx
               	xorq	%r13, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	-0x90(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	movq	0x18(%rax), %rdx
               	movq	%rdx, 0x18(%rcx)
               	movq	0x20(%rax), %rdx
               	movq	%rdx, 0x20(%rcx)
               	movq	0x28(%rax), %rdx
               	movq	%rdx, 0x28(%rcx)
               	movq	0x30(%rax), %rdx
               	movq	%rdx, 0x30(%rcx)
               	movq	0x38(%rax), %rdx
               	movq	%rdx, 0x38(%rcx)
               	movq	0x40(%rax), %rdx
               	movq	%rdx, 0x40(%rcx)
               	movq	0x48(%rax), %rdx
               	movq	%rdx, 0x48(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
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
               	movzbq	(%rsi), %r8
               	leaq	0x40(%rdi), %rax
               	movzbq	(%rax), %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%rdx, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	movq	%r8, %r9
               	xorq	%rcx, %r9
               	movzbq	0x1(%rsi), %r8
               	movzbq	0x1(%rax), %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%rdx, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	movq	%r8, %rbx
               	xorq	%rcx, %rbx
               	movzbq	0x2(%rsi), %r8
               	movzbq	0x2(%rax), %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%rdx, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	movq	%r8, %r12
               	xorq	%rcx, %r12
               	movzbq	0x3(%rsi), %r8
               	movzbq	0x3(%rax), %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%rdx, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	movq	%r8, %r13
               	xorq	%rcx, %r13
               	movzbq	0x4(%rsi), %r8
               	movzbq	0x4(%rax), %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%rdx, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	movq	%r8, %r14
               	xorq	%rcx, %r14
               	movzbq	0x5(%rsi), %rdx
               	movzbq	0x5(%rax), %rax
               	movq	%rax, %rcx
               	shlq	%rcx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rcx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rdx, %r15
               	xorq	%rax, %r15
               	movzbq	0x6(%rsi), %rdx
               	leaq	0x40(%rdi), %rax
               	movzbq	0x6(%rax), %rax
               	movq	%rax, %rcx
               	shlq	%rcx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rcx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rdx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x88(%rsp)
               	movzbq	0x7(%rsi), %rdx
               	leaq	0x40(%rdi), %rax
               	movzbq	0x7(%rax), %rax
               	movq	%rax, %rcx
               	shlq	%rcx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rcx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rdx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x80(%rsp)
               	movzbq	0x8(%rsi), %rdx
               	leaq	0x40(%rdi), %rax
               	movzbq	0x8(%rax), %rax
               	movq	%rax, %rcx
               	shlq	%rcx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rcx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rdx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x78(%rsp)
               	movzbq	0x9(%rsi), %rdx
               	leaq	0x40(%rdi), %rax
               	movzbq	0x9(%rax), %rax
               	movq	%rax, %rcx
               	shlq	%rcx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rcx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rdx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x70(%rsp)
               	movzbq	0xa(%rsi), %rdx
               	leaq	0x40(%rdi), %rax
               	movzbq	0xa(%rax), %rax
               	movq	%rax, %rcx
               	shlq	%rcx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rcx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rdx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x68(%rsp)
               	movzbq	0xb(%rsi), %rdx
               	leaq	0x40(%rdi), %rax
               	movzbq	0xb(%rax), %rax
               	movq	%rax, %rcx
               	shlq	%rcx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rcx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rdx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x60(%rsp)
               	movzbq	0xc(%rsi), %rdx
               	leaq	0x40(%rdi), %rax
               	movzbq	0xc(%rax), %rax
               	movq	%rax, %rcx
               	shlq	%rcx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rcx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rdx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x58(%rsp)
               	movzbq	0xd(%rsi), %rdx
               	leaq	0x40(%rdi), %rax
               	movzbq	0xd(%rax), %rax
               	movq	%rax, %rcx
               	shlq	%rcx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rcx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rdx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x50(%rsp)
               	movzbq	0xe(%rsi), %rdx
               	leaq	0x40(%rdi), %rax
               	movzbq	0xe(%rax), %rax
               	movq	%rax, %rcx
               	shlq	%rcx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rcx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rdx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x48(%rsp)
               	movzbq	0xf(%rsi), %rdx
               	leaq	0x40(%rdi), %rax
               	movzbq	0xf(%rax), %rax
               	movq	%rax, %rcx
               	shlq	%rcx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rcx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rdx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	(%rcx), %r8
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	(%rdx), %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rsi, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%r8, %rdx
               	movb	%dl, (%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x1(%rcx), %r8
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x1(%rdx), %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rsi, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%r8, %rdx
               	movb	%dl, 0x1(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x2(%rcx), %r8
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x2(%rdx), %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rsi, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%r8, %rdx
               	movb	%dl, 0x2(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x3(%rcx), %r8
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x3(%rdx), %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rsi, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%r8, %rdx
               	movb	%dl, 0x3(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x4(%rcx), %r8
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x4(%rdx), %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rsi, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%r8, %rdx
               	movb	%dl, 0x4(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x5(%rcx), %r8
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x5(%rdx), %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rsi, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%r8, %rdx
               	movb	%dl, 0x5(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x6(%rcx), %r8
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x6(%rdx), %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rsi, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%r8, %rdx
               	movb	%dl, 0x6(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x7(%rcx), %r8
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x7(%rdx), %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rsi, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%r8, %rdx
               	movb	%dl, 0x7(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x8(%rcx), %r8
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x8(%rdx), %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rsi, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%r8, %rdx
               	movb	%dl, 0x8(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x9(%rcx), %r8
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x9(%rdx), %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rsi, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%r8, %rdx
               	movb	%dl, 0x9(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xa(%rcx), %r8
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xa(%rdx), %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rsi, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%r8, %rdx
               	movb	%dl, 0xa(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xb(%rcx), %r8
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xb(%rdx), %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rsi, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%r8, %rdx
               	movb	%dl, 0xb(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xc(%rcx), %r8
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xc(%rdx), %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rsi, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%r8, %rdx
               	movb	%dl, 0xc(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xd(%rcx), %r8
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xd(%rdx), %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rsi, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%r8, %rdx
               	movb	%dl, 0xd(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xe(%rcx), %r8
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xe(%rdx), %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rsi, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%r8, %rdx
               	movb	%dl, 0xe(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xf(%rcx), %r8
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xf(%rdx), %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rsi, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%r8, %rdx
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
               	subq	$0x268, %rsp            # imm = 0x268
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r13
               	movq	%rdx, %r15
               	movq	%rsi, %r14
               	leaq	-0x210(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movq	%r13, %rdi
               	callq	<addr>
               	movups	%xmm0, -0x150(%rbp,%riz)
               	leaq	-0x150(%rbp), %rax
               	leaq	-0x210(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	0x10(%r13), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x150(%rbp,%riz)
               	leaq	-0x150(%rbp), %rax
               	leaq	-0x210(%rbp), %rcx
               	addq	$0x10, %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	0x20(%r13), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x150(%rbp,%riz)
               	leaq	-0x150(%rbp), %rax
               	leaq	-0x210(%rbp), %rcx
               	addq	$0x20, %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	0x30(%r13), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x150(%rbp,%riz)
               	leaq	-0x150(%rbp), %rax
               	leaq	-0x210(%rbp), %rcx
               	addq	$0x30, %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	0x40(%r13), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x150(%rbp,%riz)
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x210(%rbp), %rax
               	leaq	0x40(%rax), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
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
               	leaq	-0x260(%rbp), %rax
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
               	leaq	-0x260(%rbp), %r12
               	leaq	-0xf0(%rbp), %r10
               	movq	%r10, 0x138(%rsp)
               	movq	%rbx, %rax
               	shlq	$0x4, %rax
               	movslq	%eax, %rax
               	leaq	(%r14,%rax), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x150(%rbp,%riz)
               	leaq	-0x150(%rbp), %r9
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
               	movups	(%r10,%riz), %xmm0
               	movq	0x188(%rsp), %rdi
               	callq	<addr>
               	addq	$0x50, %rsp
               	leaq	-0xf0(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r12)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r12)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%r12)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%r12)
               	movq	0x20(%rax), %rcx
               	movq	%rcx, 0x20(%r12)
               	movq	0x28(%rax), %rcx
               	movq	%rcx, 0x28(%r12)
               	movq	0x30(%rax), %rcx
               	movq	%rcx, 0x30(%r12)
               	movq	0x38(%rax), %rcx
               	movq	%rcx, 0x38(%r12)
               	movq	0x40(%rax), %rcx
               	movq	%rcx, 0x40(%r12)
               	movq	0x48(%rax), %rcx
               	movq	%rcx, 0x48(%r12)
               	popq	%rcx
               	incq	%rbx
               	cmpl	%r15d, %ebx
               	jl	<addr>
               	leaq	-0x260(%rbp), %rax
               	leaq	-0x1c0(%rbp), %r9
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r9)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r9)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%r9)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%r9)
               	movq	0x20(%rax), %rcx
               	movq	%rcx, 0x20(%r9)
               	movq	0x28(%rax), %rcx
               	movq	%rcx, 0x28(%r9)
               	movq	0x30(%rax), %rcx
               	movq	%rcx, 0x30(%r9)
               	movq	0x38(%rax), %rcx
               	movq	%rcx, 0x38(%r9)
               	movq	0x40(%rax), %rcx
               	movq	%rcx, 0x40(%r9)
               	movq	0x48(%rax), %rcx
               	movq	%rcx, 0x48(%r9)
               	popq	%rcx
               	movq	%r9, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%r13, %rdi
               	callq	<addr>
               	leaq	0x10(%r13), %rdi
               	leaq	-0x1c0(%rbp), %rax
               	leaq	0x10(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	leaq	0x20(%r13), %rdi
               	leaq	-0x1c0(%rbp), %rax
               	leaq	0x20(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	leaq	0x30(%r13), %rdi
               	leaq	-0x1c0(%rbp), %rax
               	leaq	0x30(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	leaq	0x40(%r13), %rdi
               	leaq	-0x1c0(%rbp), %rax
               	leaq	0x40(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10,%riz), %xmm0
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
               	subq	$0x4b0, %rsp            # imm = 0x4B0
               	pushq	%r12
               	pushq	%rbx
               	xorl	%eax, %eax
               	leaq	-0x3a8(%rbp), %rdx
               	imulq	$0x7, %rax, %rcx
               	incq	%rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x50, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x358(%rbp), %rdx
               	imulq	$0x1f, %rax, %rcx
               	addq	$0x9, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x80, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x2d8(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	-0x3a8(%rbp), %rdi
               	movzbq	(%rdi,%rcx), %rdi
               	movb	%dil, (%rsi)
               	leaq	-0x3a8(%rbp), %rdx
               	leaq	0x1(%rcx), %rdi
               	movzbq	(%rdx,%rdi), %rdi
               	movb	%dil, 0x1(%rsi)
               	leaq	-0x2d8(%rbp), %rdi
               	leaq	(%rdi,%rcx), %r8
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0x2(%rcx), %rsi
               	movzbq	(%rdx,%rsi), %rsi
               	movb	%sil, 0x2(%r8)
               	addq	%rcx, %rdi
               	leaq	0x3(%rcx), %rsi
               	movzbq	(%rdx,%rsi), %rdx
               	movb	%dl, 0x3(%rdi)
               	leaq	-0x2d8(%rbp), %r8
               	leaq	(%r8,%rcx), %rsi
               	leaq	-0x3a8(%rbp), %rdx
               	addq	$0x4, %rcx
               	movzbq	(%rdx,%rcx), %rcx
               	movb	%cl, 0x4(%rsi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%r8,%rcx), %rsi
               	leaq	0x5(%rcx), %rdi
               	movzbq	(%rdx,%rdi), %rdx
               	movb	%dl, 0x5(%rsi)
               	leaq	-0x3a8(%rbp), %rdx
               	leaq	0x6(%rcx), %rdi
               	movzbq	(%rdx,%rdi), %rdi
               	movb	%dil, 0x6(%rsi)
               	leaq	-0x2d8(%rbp), %rdi
               	leaq	(%rdi,%rcx), %r8
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0x7(%rcx), %rsi
               	movzbq	(%rdx,%rsi), %rsi
               	movb	%sil, 0x7(%r8)
               	addq	%rcx, %rdi
               	leaq	0x8(%rcx), %rsi
               	movzbq	(%rdx,%rsi), %rdx
               	movb	%dl, 0x8(%rdi)
               	leaq	-0x2d8(%rbp), %r8
               	leaq	(%r8,%rcx), %rsi
               	leaq	-0x3a8(%rbp), %rdx
               	addq	$0x9, %rcx
               	movzbq	(%rdx,%rcx), %rcx
               	movb	%cl, 0x9(%rsi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%r8,%rcx), %rsi
               	leaq	0xa(%rcx), %rdi
               	movzbq	(%rdx,%rdi), %rdx
               	movb	%dl, 0xa(%rsi)
               	leaq	-0x3a8(%rbp), %rdx
               	leaq	0xb(%rcx), %rdi
               	movzbq	(%rdx,%rdi), %rdi
               	movb	%dil, 0xb(%rsi)
               	leaq	-0x2d8(%rbp), %rdi
               	leaq	(%rdi,%rcx), %r8
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0xc(%rcx), %rsi
               	movzbq	(%rdx,%rsi), %rsi
               	movb	%sil, 0xc(%r8)
               	addq	%rcx, %rdi
               	leaq	0xd(%rcx), %rsi
               	movzbq	(%rdx,%rsi), %rdx
               	movb	%dl, 0xd(%rdi)
               	leaq	-0x2d8(%rbp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	leaq	-0x3a8(%rbp), %rdx
               	addq	$0xe, %rcx
               	movzbq	(%rdx,%rcx), %rcx
               	movb	%cl, 0xe(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rsi
               	addq	$0xf, %rcx
               	movzbq	(%rdx,%rcx), %rcx
               	movb	%cl, 0xf(%rsi)
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	leaq	-0x2d8(%rbp), %rdi
               	leaq	-0x358(%rbp), %rsi
               	callq	<addr>
               	leaq	-0x2d8(%rbp), %rdi
               	leaq	-0x358(%rbp), %rax
               	leaq	0x10(%rax), %rsi
               	callq	<addr>
               	leaq	-0x2d8(%rbp), %rdi
               	leaq	-0x358(%rbp), %rax
               	leaq	0x20(%rax), %rsi
               	callq	<addr>
               	leaq	-0x2d8(%rbp), %rdi
               	leaq	-0x358(%rbp), %rax
               	leaq	0x30(%rax), %rsi
               	callq	<addr>
               	leaq	-0x2d8(%rbp), %rdi
               	leaq	-0x358(%rbp), %rax
               	leaq	0x40(%rax), %rsi
               	callq	<addr>
               	leaq	-0x2d8(%rbp), %rdi
               	leaq	-0x358(%rbp), %rax
               	leaq	0x50(%rax), %rsi
               	callq	<addr>
               	leaq	-0x2d8(%rbp), %rdi
               	leaq	-0x358(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	callq	<addr>
               	leaq	-0x2d8(%rbp), %r12
               	leaq	-0x358(%rbp), %rax
               	leaq	0x70(%rax), %rsi
               	movq	%r12, %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	leaq	-0x288(%rbp), %rcx
               	leaq	-0x3a8(%rbp), %rdx
               	movzbq	(%rdx,%rax), %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x50, %eax
               	jl	<addr>
               	leaq	-0x288(%rbp), %rbx
               	leaq	-0x358(%rbp), %rsi
               	movl	$0x8, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	movq	%rcx, %rdx
               	shlq	$0x4, %rdx
               	leaq	(%rdx,%rax), %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	addq	%r12, %rdx
               	movzbq	(%rdx,%rax), %rdx
               	cmpl	%edx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	incq	%rcx
               	cmpl	$0x5, %ecx
               	jl	<addr>
               	xorl	%ebx, %ebx
               	xorl	%eax, %eax
               	leaq	-0x238(%rbp), %rcx
               	leaq	-0x3a8(%rbp), %rdx
               	movzbq	(%rdx,%rax), %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x50, %eax
               	jl	<addr>
               	leaq	-0x238(%rbp), %rdi
               	leaq	-0x358(%rbp), %rsi
               	movq	%rbx, %rdx
               	callq	<addr>
               	leaq	-0x238(%rbp), %rdi
               	leaq	-0x358(%rbp), %rcx
               	movq	%rbx, %rax
               	shlq	$0x4, %rax
               	leaq	(%rcx,%rax), %rsi
               	movl	$0x8, %eax
               	movq	%rax, %rdx
               	subq	%rbx, %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	leaq	-0x238(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rdx
               	leaq	-0x288(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rcx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x50, %eax
               	jl	<addr>
               	incq	%rbx
               	cmpl	$0x8, %ebx
               	jle	<addr>
               	leaq	-0x3a8(%rbp), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x3b8(%rbp,%riz)
               	leaq	-0x3b8(%rbp), %rax
               	leaq	-0x4b0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x3a8(%rbp), %rax
               	leaq	0x10(%rax), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x3b8(%rbp,%riz)
               	leaq	-0x3b8(%rbp), %rax
               	leaq	-0x4a0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x3a8(%rbp), %rax
               	leaq	0x20(%rax), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x3b8(%rbp,%riz)
               	leaq	-0x3b8(%rbp), %rax
               	leaq	-0x490(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x3a8(%rbp), %rax
               	leaq	0x30(%rax), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x3b8(%rbp,%riz)
               	leaq	-0x3b8(%rbp), %rax
               	leaq	-0x480(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x3a8(%rbp), %rax
               	leaq	0x40(%rax), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x3b8(%rbp,%riz)
               	leaq	-0x3b8(%rbp), %rax
               	leaq	-0x470(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x460(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	leaq	-0x4b0(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x4a0(%rbp), %rdx
               	leaq	0x10(%rax), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	leaq	-0x490(%rbp), %rdx
               	leaq	0x20(%rax), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	leaq	-0x480(%rbp), %rdx
               	leaq	0x30(%rax), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	addq	$0x40, %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xa0(%rbp), %rbx
               	leaq	-0x460(%rbp), %r12
               	leaq	-0x358(%rbp), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x3b8(%rbp,%riz)
               	leaq	-0x3b8(%rbp), %r9
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
               	movups	(%r10,%riz), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	$0x50, %rsp
               	leaq	-0xa0(%rbp), %rax
               	leaq	-0x148(%rbp), %rbx
               	leaq	-0x410(%rbp), %r9
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r9)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r9)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%r9)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%r9)
               	movq	0x20(%rax), %rcx
               	movq	%rcx, 0x20(%r9)
               	movq	0x28(%rax), %rcx
               	movq	%rcx, 0x28(%r9)
               	movq	0x30(%rax), %rcx
               	movq	%rcx, 0x30(%r9)
               	movq	0x38(%rax), %rcx
               	movq	%rcx, 0x38(%r9)
               	movq	0x40(%rax), %rcx
               	movq	%rcx, 0x40(%r9)
               	movq	0x48(%rax), %rcx
               	movq	%rcx, 0x48(%r9)
               	popq	%rcx
               	movq	%r9, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	0x10(%rbx), %rdi
               	leaq	-0x410(%rbp), %rax
               	leaq	0x10(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	leaq	0x20(%rbx), %rdi
               	leaq	-0x410(%rbp), %rax
               	leaq	0x20(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	leaq	0x30(%rbx), %rdi
               	leaq	-0x410(%rbp), %rax
               	leaq	0x30(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	leaq	0x40(%rbx), %rdi
               	leaq	-0x410(%rbp), %rax
               	leaq	0x40(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	xorl	%eax, %eax
               	leaq	-0xf0(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	-0x3a8(%rbp), %rdi
               	movzbq	(%rdi,%rcx), %rdi
               	movb	%dil, (%rsi)
               	leaq	-0x3a8(%rbp), %rdx
               	leaq	0x1(%rcx), %rdi
               	movzbq	(%rdx,%rdi), %rdi
               	movb	%dil, 0x1(%rsi)
               	leaq	-0xf0(%rbp), %rdi
               	leaq	(%rdi,%rcx), %r8
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0x2(%rcx), %rsi
               	movzbq	(%rdx,%rsi), %rsi
               	movb	%sil, 0x2(%r8)
               	addq	%rcx, %rdi
               	leaq	0x3(%rcx), %rsi
               	movzbq	(%rdx,%rsi), %rdx
               	movb	%dl, 0x3(%rdi)
               	leaq	-0xf0(%rbp), %r8
               	leaq	(%r8,%rcx), %rsi
               	leaq	-0x3a8(%rbp), %rdx
               	addq	$0x4, %rcx
               	movzbq	(%rdx,%rcx), %rcx
               	movb	%cl, 0x4(%rsi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%r8,%rcx), %rsi
               	leaq	0x5(%rcx), %rdi
               	movzbq	(%rdx,%rdi), %rdx
               	movb	%dl, 0x5(%rsi)
               	leaq	-0x3a8(%rbp), %rdx
               	leaq	0x6(%rcx), %rdi
               	movzbq	(%rdx,%rdi), %rdi
               	movb	%dil, 0x6(%rsi)
               	leaq	-0xf0(%rbp), %rdi
               	leaq	(%rdi,%rcx), %r8
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0x7(%rcx), %rsi
               	movzbq	(%rdx,%rsi), %rsi
               	movb	%sil, 0x7(%r8)
               	addq	%rcx, %rdi
               	leaq	0x8(%rcx), %rsi
               	movzbq	(%rdx,%rsi), %rdx
               	movb	%dl, 0x8(%rdi)
               	leaq	-0xf0(%rbp), %r8
               	leaq	(%r8,%rcx), %rsi
               	leaq	-0x3a8(%rbp), %rdx
               	addq	$0x9, %rcx
               	movzbq	(%rdx,%rcx), %rcx
               	movb	%cl, 0x9(%rsi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%r8,%rcx), %rsi
               	leaq	0xa(%rcx), %rdi
               	movzbq	(%rdx,%rdi), %rdx
               	movb	%dl, 0xa(%rsi)
               	leaq	-0x3a8(%rbp), %rdx
               	leaq	0xb(%rcx), %rdi
               	movzbq	(%rdx,%rdi), %rdi
               	movb	%dil, 0xb(%rsi)
               	leaq	-0xf0(%rbp), %rdi
               	leaq	(%rdi,%rcx), %r8
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0xc(%rcx), %rsi
               	movzbq	(%rdx,%rsi), %rsi
               	movb	%sil, 0xc(%r8)
               	addq	%rcx, %rdi
               	leaq	0xd(%rcx), %rsi
               	movzbq	(%rdx,%rsi), %rdx
               	movb	%dl, 0xd(%rdi)
               	leaq	-0xf0(%rbp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	leaq	-0x3a8(%rbp), %rdx
               	addq	$0xe, %rcx
               	movzbq	(%rdx,%rcx), %rcx
               	movb	%cl, 0xe(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rsi
               	addq	$0xf, %rcx
               	movzbq	(%rdx,%rcx), %rcx
               	movb	%cl, 0xf(%rsi)
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	leaq	-0xf0(%rbp), %rbx
               	leaq	-0x358(%rbp), %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	leaq	-0x148(%rbp), %rdi
               	movq	%rcx, %rdx
               	shlq	$0x4, %rdx
               	leaq	(%rdx,%rax), %rsi
               	movzbq	(%rdi,%rsi), %rsi
               	addq	%rbx, %rdx
               	movzbq	(%rdx,%rax), %rdx
               	cmpl	%edx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	incq	%rcx
               	cmpl	$0x5, %ecx
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
