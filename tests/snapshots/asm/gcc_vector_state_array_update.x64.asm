
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
               	leaq	(%rax), %rcx
               	leaq	(%rdi), %rdx
               	movzbq	(%rdx), %rdx
               	movb	%dl, (%rcx)
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
               	leaq	(%rdi), %rcx
               	leaq	-0x20(%rbp), %rax
               	leaq	(%rax), %rdx
               	movzbq	(%rdx), %rdx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rax), %rcx
               	movb	%cl, 0x1(%rdi)
               	movzbq	0x2(%rax), %rcx
               	movb	%cl, 0x2(%rdi)
               	movzbq	0x3(%rax), %rcx
               	movb	%cl, 0x3(%rdi)
               	movzbq	0x4(%rax), %rcx
               	movb	%cl, 0x4(%rdi)
               	movzbq	0x5(%rax), %rax
               	movb	%al, 0x5(%rdi)
               	leaq	-0x20(%rbp), %rax
               	movzbq	0x6(%rax), %rcx
               	movb	%cl, 0x6(%rdi)
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
               	movzbq	0xc(%rax), %rax
               	movb	%al, 0xc(%rdi)
               	leaq	-0x20(%rbp), %rax
               	movzbq	0xd(%rax), %rcx
               	movb	%cl, 0xd(%rdi)
               	movzbq	0xe(%rax), %rcx
               	movb	%cl, 0xe(%rdi)
               	movzbq	0xf(%rax), %rax
               	movb	%al, 0xf(%rdi)
               	leave
               	retq

<mix>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movups	%xmm0, -0xa0(%rbp,%riz)
               	leaq	-0xa0(%rbp), %rax
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
               	movq	%r10, 0x78(%rsp)
               	movzbq	0x9(%rax), %rdx
               	movq	%rdx, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0x70(%rsp)
               	movzbq	0xa(%rax), %rdx
               	movq	%rdx, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0x68(%rsp)
               	movzbq	0xb(%rax), %rdx
               	movq	%rdx, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0x60(%rsp)
               	movzbq	0xc(%rax), %rdx
               	movq	%rdx, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0x58(%rsp)
               	movzbq	0xd(%rax), %rdx
               	movq	%rdx, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0x50(%rsp)
               	movzbq	0xe(%rax), %rdx
               	movq	%rdx, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0x48(%rsp)
               	movzbq	0xf(%rax), %rax
               	movq	%rax, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0x40(%rsp)
               	movl	$0x1b, %edx
               	leaq	-0x40(%rbp), %rax
               	andq	$0xff, %rdi
               	imulq	%rdx, %rdi
               	movb	%dil, (%rax)
               	movq	%r8, %rdi
               	andq	$0xff, %rdi
               	imulq	%rdx, %rdi
               	movb	%dil, 0x1(%rax)
               	movq	%r9, %rdi
               	andq	$0xff, %rdi
               	imulq	%rdx, %rdi
               	movb	%dil, 0x2(%rax)
               	movq	%rbx, %rdi
               	andq	$0xff, %rdi
               	imulq	%rdx, %rdi
               	movb	%dil, 0x3(%rax)
               	movq	%r12, %rdi
               	andq	$0xff, %rdi
               	imulq	%rdx, %rdi
               	movb	%dil, 0x4(%rax)
               	movq	%r13, %rdi
               	andq	$0xff, %rdi
               	imulq	%rdx, %rdi
               	movb	%dil, 0x5(%rax)
               	movq	%r14, %rdi
               	andq	$0xff, %rdi
               	imulq	%rdx, %rdi
               	movb	%dil, 0x6(%rax)
               	movq	%r15, %rdi
               	andq	$0xff, %rdi
               	imulq	%rdx, %rdi
               	movb	%dil, 0x7(%rax)
               	movq	0x78(%rsp), %rdi
               	andq	$0xff, %rdi
               	movq	%rdi, %r8
               	imulq	%rdx, %r8
               	leaq	0x8(%rax), %rdi
               	movb	%r8b, (%rdi)
               	movq	0x70(%rsp), %r8
               	andq	$0xff, %r8
               	imulq	%rdx, %r8
               	movb	%r8b, 0x9(%rax)
               	movq	0x68(%rsp), %r8
               	andq	$0xff, %r8
               	imulq	%rdx, %r8
               	movb	%r8b, 0xa(%rax)
               	movq	0x60(%rsp), %r8
               	andq	$0xff, %r8
               	imulq	%rdx, %r8
               	movb	%r8b, 0xb(%rax)
               	movq	0x58(%rsp), %r8
               	andq	$0xff, %r8
               	imulq	%rdx, %r8
               	movb	%r8b, 0xc(%rax)
               	movq	0x50(%rsp), %r8
               	andq	$0xff, %r8
               	imulq	%rdx, %r8
               	movb	%r8b, 0xd(%rax)
               	movq	0x48(%rsp), %r8
               	andq	$0xff, %r8
               	imulq	%rdx, %r8
               	movb	%r8b, 0xe(%rax)
               	movq	0x40(%rsp), %r8
               	andq	$0xff, %r8
               	imulq	%r8, %rdx
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	movups	(%rcx,%riz), %xmm0
               	leave
               	retq

<update>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x110, %rsp            # imm = 0x110
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%rdi, -0x90(%rbp)
               	movq	%rsi, -0x80(%rbp)
               	movq	%rdx, -0x70(%rbp)
               	leaq	-0xf0(%rbp), %rax
               	movq	-0x80(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x20(%rax)
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	movq	0x30(%rcx), %rdx
               	movq	%rdx, 0x30(%rax)
               	movq	0x38(%rcx), %rdx
               	movq	%rdx, 0x38(%rax)
               	movq	0x40(%rcx), %rdx
               	movq	%rdx, 0x40(%rax)
               	movq	0x48(%rcx), %rdx
               	movq	%rdx, 0x48(%rax)
               	popq	%rdx
               	movq	-0x70(%rbp), %rcx
               	movq	(%rcx), %rbx
               	movq	0x8(%rcx), %r12
               	leaq	0x40(%rax), %rdi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	movups	%xmm0, -0x60(%rbp,%riz)
               	leaq	-0x60(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	%rbx, %r13
               	xorq	%rcx, %r13
               	movq	0x8(%rax), %rax
               	movq	%r12, %r14
               	xorq	%rax, %r14
               	leaq	-0xf0(%rbp), %rbx
               	leaq	0x40(%rbx), %r12
               	leaq	0x30(%rbx), %rdi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	movups	%xmm0, -0x60(%rbp,%riz)
               	leaq	-0x60(%rbp), %rax
               	movq	0x40(%rbx), %rcx
               	movq	(%rax), %rdx
               	xorq	%rdx, %rcx
               	movq	0x48(%rbx), %rdx
               	movq	0x8(%rax), %rax
               	xorq	%rdx, %rax
               	movq	%rcx, (%r12)
               	movq	%rax, 0x8(%r12)
               	leaq	-0xf0(%rbp), %rbx
               	leaq	0x30(%rbx), %r12
               	leaq	0x20(%rbx), %rdi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	movups	%xmm0, -0x60(%rbp,%riz)
               	leaq	-0x60(%rbp), %rax
               	movq	0x30(%rbx), %rcx
               	movq	(%rax), %rdx
               	xorq	%rdx, %rcx
               	movq	0x38(%rbx), %rdx
               	movq	0x8(%rax), %rax
               	xorq	%rdx, %rax
               	movq	%rcx, (%r12)
               	movq	%rax, 0x8(%r12)
               	leaq	-0xf0(%rbp), %rbx
               	leaq	0x20(%rbx), %r12
               	leaq	0x10(%rbx), %rdi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	movups	%xmm0, -0x60(%rbp,%riz)
               	leaq	-0x60(%rbp), %rax
               	movq	0x20(%rbx), %rcx
               	movq	(%rax), %rdx
               	xorq	%rdx, %rcx
               	movq	0x28(%rbx), %rdx
               	movq	0x8(%rax), %rax
               	xorq	%rdx, %rax
               	movq	%rcx, (%r12)
               	movq	%rax, 0x8(%r12)
               	leaq	-0xf0(%rbp), %rbx
               	leaq	0x10(%rbx), %r12
               	movq	%rbx, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	movups	%xmm0, -0x60(%rbp,%riz)
               	leaq	-0x60(%rbp), %rax
               	movq	0x10(%rbx), %rcx
               	movq	(%rax), %rdx
               	xorq	%rdx, %rcx
               	movq	0x18(%rbx), %rdx
               	movq	0x8(%rax), %rax
               	xorq	%rdx, %rax
               	movq	%rcx, (%r12)
               	movq	%rax, 0x8(%r12)
               	leaq	-0xf0(%rbp), %rax
               	movq	(%rax), %rcx
               	xorq	%r13, %rcx
               	movq	0x8(%rax), %rdx
               	xorq	%r14, %rdx
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	%rcx, %rax
               	leave
               	retq

<update_scalar>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	leaq	(%rsi), %rax
               	movzbq	(%rax), %r8
               	leaq	0x40(%rdi), %rax
               	leaq	(%rax), %rcx
               	movzbq	(%rcx), %rcx
               	andq	$0xff, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%rdx, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	movq	%r8, %rbx
               	xorq	%rcx, %rbx
               	movzbq	0x1(%rsi), %r8
               	movzbq	0x1(%rax), %rcx
               	andq	$0xff, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%rdx, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	movq	%r8, %r12
               	xorq	%rcx, %r12
               	movzbq	0x2(%rsi), %r8
               	movzbq	0x2(%rax), %rcx
               	andq	$0xff, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%rdx, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	movq	%r8, %r13
               	xorq	%rcx, %r13
               	movzbq	0x3(%rsi), %r8
               	movzbq	0x3(%rax), %rcx
               	andq	$0xff, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%rdx, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	movq	%r8, %r14
               	xorq	%rcx, %r14
               	movzbq	0x4(%rsi), %r8
               	movzbq	0x4(%rax), %rcx
               	andq	$0xff, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%rdx, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	movq	%r8, %r15
               	xorq	%rcx, %r15
               	movzbq	0x5(%rsi), %rdx
               	movzbq	0x5(%rax), %rax
               	andq	$0xff, %rax
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
               	movzbq	0x6(%rsi), %rdx
               	leaq	0x40(%rdi), %rax
               	movzbq	0x6(%rax), %rax
               	andq	$0xff, %rax
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
               	movzbq	0x7(%rsi), %rdx
               	leaq	0x40(%rdi), %rax
               	movzbq	0x7(%rax), %rax
               	andq	$0xff, %rax
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
               	movzbq	0x8(%rsi), %rdx
               	leaq	0x40(%rdi), %rax
               	movzbq	0x8(%rax), %rax
               	andq	$0xff, %rax
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
               	movzbq	0x9(%rsi), %rdx
               	leaq	0x40(%rdi), %rax
               	movzbq	0x9(%rax), %rax
               	andq	$0xff, %rax
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
               	movzbq	0xa(%rsi), %rdx
               	leaq	0x40(%rdi), %rax
               	movzbq	0xa(%rax), %rax
               	andq	$0xff, %rax
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
               	movzbq	0xb(%rsi), %rdx
               	leaq	0x40(%rdi), %rax
               	movzbq	0xb(%rax), %rax
               	andq	$0xff, %rax
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
               	movzbq	0xc(%rsi), %rdx
               	leaq	0x40(%rdi), %rax
               	movzbq	0xc(%rax), %rax
               	andq	$0xff, %rax
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
               	movzbq	0xd(%rsi), %rdx
               	leaq	0x40(%rdi), %rax
               	movzbq	0xd(%rax), %rax
               	andq	$0xff, %rax
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
               	movzbq	0xe(%rsi), %rdx
               	leaq	0x40(%rdi), %rax
               	movzbq	0xe(%rax), %rax
               	andq	$0xff, %rax
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
               	movzbq	0xf(%rsi), %rdx
               	leaq	0x40(%rdi), %rax
               	movzbq	0xf(%rax), %rax
               	andq	$0xff, %rax
               	movq	%rax, %rcx
               	shlq	%rcx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rcx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rdx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x38(%rsp)
               	movl	$0x4, %ecx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	addq	$0x0, %rdx
               	movzbq	(%rdx), %r9
               	leaq	-0x1(%rax), %rsi
               	movslq	%esi, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdi, %rsi
               	addq	$0x0, %rsi
               	movzbq	(%rsi), %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, %r8
               	shlq	%r8
               	shrq	$0x7, %rsi
               	imulq	$0x1b, %rsi, %rsi
               	xorq	%r8, %rsi
               	xorq	$0x63, %rsi
               	andq	$0xff, %rsi
               	xorq	%r9, %rsi
               	movb	%sil, (%rdx)
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x1(%rdx), %r9
               	leaq	-0x1(%rax), %rsi
               	movslq	%esi, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdi, %rsi
               	movzbq	0x1(%rsi), %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, %r8
               	shlq	%r8
               	shrq	$0x7, %rsi
               	imulq	$0x1b, %rsi, %rsi
               	xorq	%r8, %rsi
               	xorq	$0x63, %rsi
               	andq	$0xff, %rsi
               	xorq	%r9, %rsi
               	movb	%sil, 0x1(%rdx)
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x2(%rdx), %r9
               	leaq	-0x1(%rax), %rsi
               	movslq	%esi, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdi, %rsi
               	movzbq	0x2(%rsi), %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, %r8
               	shlq	%r8
               	shrq	$0x7, %rsi
               	imulq	$0x1b, %rsi, %rsi
               	xorq	%r8, %rsi
               	xorq	$0x63, %rsi
               	andq	$0xff, %rsi
               	xorq	%r9, %rsi
               	movb	%sil, 0x2(%rdx)
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x3(%rdx), %r9
               	leaq	-0x1(%rax), %rsi
               	movslq	%esi, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdi, %rsi
               	movzbq	0x3(%rsi), %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, %r8
               	shlq	%r8
               	shrq	$0x7, %rsi
               	imulq	$0x1b, %rsi, %rsi
               	xorq	%r8, %rsi
               	xorq	$0x63, %rsi
               	andq	$0xff, %rsi
               	xorq	%r9, %rsi
               	movb	%sil, 0x3(%rdx)
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x4(%rdx), %r9
               	leaq	-0x1(%rax), %rsi
               	movslq	%esi, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdi, %rsi
               	movzbq	0x4(%rsi), %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, %r8
               	shlq	%r8
               	shrq	$0x7, %rsi
               	imulq	$0x1b, %rsi, %rsi
               	xorq	%r8, %rsi
               	xorq	$0x63, %rsi
               	andq	$0xff, %rsi
               	xorq	%r9, %rsi
               	movb	%sil, 0x4(%rdx)
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x5(%rdx), %r9
               	leaq	-0x1(%rax), %rsi
               	movslq	%esi, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdi, %rsi
               	movzbq	0x5(%rsi), %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, %r8
               	shlq	%r8
               	shrq	$0x7, %rsi
               	imulq	$0x1b, %rsi, %rsi
               	xorq	%r8, %rsi
               	xorq	$0x63, %rsi
               	andq	$0xff, %rsi
               	xorq	%r9, %rsi
               	movb	%sil, 0x5(%rdx)
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x6(%rdx), %r9
               	leaq	-0x1(%rax), %rsi
               	movslq	%esi, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdi, %rsi
               	movzbq	0x6(%rsi), %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, %r8
               	shlq	%r8
               	shrq	$0x7, %rsi
               	imulq	$0x1b, %rsi, %rsi
               	xorq	%r8, %rsi
               	xorq	$0x63, %rsi
               	andq	$0xff, %rsi
               	xorq	%r9, %rsi
               	movb	%sil, 0x6(%rdx)
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x7(%rdx), %r9
               	leaq	-0x1(%rax), %rsi
               	movslq	%esi, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdi, %rsi
               	movzbq	0x7(%rsi), %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, %r8
               	shlq	%r8
               	shrq	$0x7, %rsi
               	imulq	$0x1b, %rsi, %rsi
               	xorq	%r8, %rsi
               	xorq	$0x63, %rsi
               	andq	$0xff, %rsi
               	xorq	%r9, %rsi
               	movb	%sil, 0x7(%rdx)
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x8(%rdx), %r9
               	leaq	-0x1(%rax), %rsi
               	movslq	%esi, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdi, %rsi
               	movzbq	0x8(%rsi), %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, %r8
               	shlq	%r8
               	shrq	$0x7, %rsi
               	imulq	$0x1b, %rsi, %rsi
               	xorq	%r8, %rsi
               	xorq	$0x63, %rsi
               	andq	$0xff, %rsi
               	xorq	%r9, %rsi
               	movb	%sil, 0x8(%rdx)
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x9(%rdx), %r9
               	leaq	-0x1(%rax), %rsi
               	movslq	%esi, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdi, %rsi
               	movzbq	0x9(%rsi), %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, %r8
               	shlq	%r8
               	shrq	$0x7, %rsi
               	imulq	$0x1b, %rsi, %rsi
               	xorq	%r8, %rsi
               	xorq	$0x63, %rsi
               	andq	$0xff, %rsi
               	xorq	%r9, %rsi
               	movb	%sil, 0x9(%rdx)
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xa(%rdx), %r9
               	leaq	-0x1(%rax), %rsi
               	movslq	%esi, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdi, %rsi
               	movzbq	0xa(%rsi), %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, %r8
               	shlq	%r8
               	shrq	$0x7, %rsi
               	imulq	$0x1b, %rsi, %rsi
               	xorq	%r8, %rsi
               	xorq	$0x63, %rsi
               	andq	$0xff, %rsi
               	xorq	%r9, %rsi
               	movb	%sil, 0xa(%rdx)
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xb(%rdx), %r9
               	leaq	-0x1(%rax), %rsi
               	movslq	%esi, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdi, %rsi
               	movzbq	0xb(%rsi), %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, %r8
               	shlq	%r8
               	shrq	$0x7, %rsi
               	imulq	$0x1b, %rsi, %rsi
               	xorq	%r8, %rsi
               	xorq	$0x63, %rsi
               	andq	$0xff, %rsi
               	xorq	%r9, %rsi
               	movb	%sil, 0xb(%rdx)
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xc(%rdx), %r9
               	leaq	-0x1(%rax), %rsi
               	movslq	%esi, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdi, %rsi
               	movzbq	0xc(%rsi), %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, %r8
               	shlq	%r8
               	shrq	$0x7, %rsi
               	imulq	$0x1b, %rsi, %rsi
               	xorq	%r8, %rsi
               	xorq	$0x63, %rsi
               	andq	$0xff, %rsi
               	xorq	%r9, %rsi
               	movb	%sil, 0xc(%rdx)
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xd(%rdx), %r9
               	leaq	-0x1(%rax), %rsi
               	movslq	%esi, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdi, %rsi
               	movzbq	0xd(%rsi), %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, %r8
               	shlq	%r8
               	shrq	$0x7, %rsi
               	imulq	$0x1b, %rsi, %rsi
               	xorq	%r8, %rsi
               	xorq	$0x63, %rsi
               	andq	$0xff, %rsi
               	xorq	%r9, %rsi
               	movb	%sil, 0xd(%rdx)
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xe(%rdx), %r9
               	leaq	-0x1(%rax), %rsi
               	movslq	%esi, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdi, %rsi
               	movzbq	0xe(%rsi), %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, %r8
               	shlq	%r8
               	shrq	$0x7, %rsi
               	imulq	$0x1b, %rsi, %rsi
               	xorq	%r8, %rsi
               	xorq	$0x63, %rsi
               	andq	$0xff, %rsi
               	xorq	%r9, %rsi
               	movb	%sil, 0xe(%rdx)
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xf(%rdx), %r9
               	leaq	-0x1(%rax), %rsi
               	movslq	%esi, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdi, %rsi
               	movzbq	0xf(%rsi), %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, %r8
               	shlq	%r8
               	shrq	$0x7, %rsi
               	imulq	$0x1b, %rsi, %rsi
               	xorq	%r8, %rsi
               	xorq	$0x63, %rsi
               	andq	$0xff, %rsi
               	xorq	%r9, %rsi
               	movb	%sil, 0xf(%rdx)
               	leaq	-0x1(%rax), %rcx
               	testl	%ecx, %ecx
               	jg	<addr>
               	leaq	(%rdi), %rax
               	movzbq	(%rax), %rcx
               	movq	%rbx, %rdx
               	andq	$0xff, %rdx
               	xorq	%rdx, %rcx
               	movb	%cl, (%rax)
               	movzbq	0x1(%rdi), %rax
               	movq	%r12, %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0x1(%rdi)
               	movzbq	0x2(%rdi), %rax
               	movq	%r13, %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0x2(%rdi)
               	movzbq	0x3(%rdi), %rax
               	movq	%r14, %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0x3(%rdi)
               	movzbq	0x4(%rdi), %rax
               	movq	%r15, %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0x4(%rdi)
               	movzbq	0x5(%rdi), %rax
               	movq	0x88(%rsp), %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0x5(%rdi)
               	movzbq	0x6(%rdi), %rax
               	movq	0x80(%rsp), %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0x6(%rdi)
               	movzbq	0x7(%rdi), %rax
               	movq	0x78(%rsp), %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0x7(%rdi)
               	movzbq	0x8(%rdi), %rax
               	movq	0x70(%rsp), %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0x8(%rdi)
               	movzbq	0x9(%rdi), %rax
               	movq	0x68(%rsp), %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0x9(%rdi)
               	movzbq	0xa(%rdi), %rax
               	movq	0x60(%rsp), %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0xa(%rdi)
               	movzbq	0xb(%rdi), %rax
               	movq	0x58(%rsp), %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0xb(%rdi)
               	movzbq	0xc(%rdi), %rax
               	movq	0x50(%rsp), %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0xc(%rdi)
               	movzbq	0xd(%rdi), %rax
               	movq	0x48(%rsp), %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0xd(%rdi)
               	movzbq	0xe(%rdi), %rax
               	movq	0x40(%rsp), %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0xe(%rdi)
               	movzbq	0xf(%rdi), %rax
               	movq	0x38(%rsp), %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0xf(%rdi)
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq

<run_chunk>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2a0, %rsp            # imm = 0x2A0
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movq	%rdi, %r13
               	movq	%rdx, %r15
               	movq	%rsi, %r14
               	leaq	-0x220(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movq	%r13, %rdi
               	callq	<addr>
               	movups	%xmm0, -0x160(%rbp,%riz)
               	leaq	-0x160(%rbp), %rax
               	leaq	-0x220(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	0x10(%r13), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x160(%rbp,%riz)
               	leaq	-0x160(%rbp), %rax
               	leaq	-0x220(%rbp), %rcx
               	addq	$0x10, %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	0x20(%r13), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x160(%rbp,%riz)
               	leaq	-0x160(%rbp), %rax
               	leaq	-0x220(%rbp), %rcx
               	addq	$0x20, %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	0x30(%r13), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x160(%rbp,%riz)
               	leaq	-0x160(%rbp), %rax
               	leaq	-0x220(%rbp), %rcx
               	addq	$0x30, %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	0x40(%r13), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x160(%rbp,%riz)
               	leaq	-0x160(%rbp), %rcx
               	leaq	-0x220(%rbp), %rax
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
               	leaq	-0x270(%rbp), %rax
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
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	leaq	-0x270(%rbp), %r12
               	leaq	-0x100(%rbp), %r10
               	movq	%r10, 0x138(%rsp)
               	movq	%rbx, %rax
               	shlq	$0x4, %rax
               	movslq	%eax, %rax
               	leaq	(%r14,%rax), %rdi
               	callq	<addr>
               	movups	%xmm0, -0xb0(%rbp,%riz)
               	leaq	-0xb0(%rbp), %rdx
               	movq	%r12, %rsi
               	movq	0x138(%rsp), %rdi
               	callq	<addr>
               	leaq	-0x100(%rbp), %rax
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
               	movslq	%ebx, %rax
               	leaq	0x1(%rax), %rbx
               	cmpl	%r15d, %ebx
               	jl	<addr>
               	leaq	-0x270(%rbp), %rcx
               	leaq	-0x1d0(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x20(%rax)
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	movq	0x30(%rcx), %rdx
               	movq	%rdx, 0x30(%rax)
               	movq	0x38(%rcx), %rdx
               	movq	%rdx, 0x38(%rax)
               	movq	0x40(%rcx), %rdx
               	movq	%rdx, 0x40(%rax)
               	movq	0x48(%rcx), %rdx
               	movq	%rdx, 0x48(%rax)
               	popq	%rdx
               	leaq	(%r13), %rdi
               	leaq	(%rax), %rsi
               	movq	%rsi, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	leaq	0x10(%r13), %rdi
               	leaq	-0x1d0(%rbp), %rax
               	leaq	0x10(%rax), %rsi
               	movq	%rsi, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	leaq	0x20(%r13), %rdi
               	leaq	-0x1d0(%rbp), %rax
               	leaq	0x20(%rax), %rsi
               	movq	%rsi, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	leaq	0x30(%r13), %rdi
               	leaq	-0x1d0(%rbp), %rax
               	leaq	0x30(%rax), %rsi
               	movq	%rsi, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	leaq	0x40(%r13), %rdi
               	leaq	-0x1d0(%rbp), %rax
               	leaq	0x40(%rax), %rsi
               	movq	%rsi, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x4d0, %rsp            # imm = 0x4D0
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x3b8(%rbp), %rdx
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	imulq	$0x7, %rcx, %rdx
               	incq	%rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x50, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x368(%rbp), %rdx
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	imulq	$0x1f, %rcx, %rdx
               	addq	$0x9, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x80, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x2e8(%rbp), %r8
               	movslq	%eax, %rcx
               	movq	%rcx, %rsi
               	shlq	$0x4, %rsi
               	leaq	(%r8,%rsi), %rdi
               	leaq	(%rdi), %rbx
               	leaq	-0x3b8(%rbp), %r12
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	(%rdx), %r9
               	movslq	%r9d, %r9
               	addq	%r12, %r9
               	movzbq	(%r9), %r9
               	movb	%r9b, (%rbx)
               	leaq	-0x3b8(%rbp), %r8
               	incq	%rdx
               	movslq	%edx, %rdx
               	addq	%r8, %rdx
               	movzbq	(%rdx), %rdx
               	movb	%dl, 0x1(%rdi)
               	leaq	-0x2e8(%rbp), %rdi
               	addq	%rdi, %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	0x2(%rdx), %r9
               	movslq	%r9d, %r9
               	addq	%r9, %r8
               	movzbq	(%r8), %r8
               	movb	%r8b, 0x2(%rsi)
               	movq	%rcx, %r8
               	shlq	$0x4, %r8
               	leaq	(%rdi,%r8), %rsi
               	leaq	-0x3b8(%rbp), %rbx
               	leaq	0x3(%rdx), %r9
               	movslq	%r9d, %r9
               	addq	%rbx, %r9
               	movzbq	(%r9), %r9
               	movb	%r9b, 0x3(%rsi)
               	leaq	-0x3b8(%rbp), %r8
               	addq	$0x4, %rdx
               	movslq	%edx, %rdx
               	addq	%r8, %rdx
               	movzbq	(%rdx), %rdx
               	movb	%dl, 0x4(%rsi)
               	leaq	-0x2e8(%rbp), %r9
               	movq	%rcx, %rdi
               	shlq	$0x4, %rdi
               	leaq	(%r9,%rdi), %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	0x5(%rdx), %rbx
               	movslq	%ebx, %rbx
               	addq	%rbx, %r8
               	movzbq	(%r8), %r8
               	movb	%r8b, 0x5(%rsi)
               	leaq	-0x3b8(%rbp), %r9
               	addq	$0x6, %rdx
               	movslq	%edx, %rdx
               	addq	%r9, %rdx
               	movzbq	(%rdx), %rdx
               	movb	%dl, 0x6(%rsi)
               	leaq	-0x2e8(%rbp), %r8
               	leaq	(%r8,%rdi), %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	0x7(%rdx), %rdi
               	movslq	%edi, %rdi
               	addq	%r9, %rdi
               	movzbq	(%rdi), %rdi
               	movb	%dil, 0x7(%rsi)
               	movq	%rcx, %rdi
               	shlq	$0x4, %rdi
               	leaq	(%r8,%rdi), %rsi
               	leaq	-0x3b8(%rbp), %rbx
               	leaq	0x8(%rdx), %r9
               	movslq	%r9d, %r9
               	addq	%rbx, %r9
               	movzbq	(%r9), %r9
               	movb	%r9b, 0x8(%rsi)
               	leaq	-0x3b8(%rbp), %r8
               	addq	$0x9, %rdx
               	movslq	%edx, %rdx
               	addq	%r8, %rdx
               	movzbq	(%rdx), %rdx
               	movb	%dl, 0x9(%rsi)
               	leaq	-0x2e8(%rbp), %r9
               	movq	%rcx, %rdi
               	shlq	$0x4, %rdi
               	leaq	(%r9,%rdi), %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	0xa(%rdx), %rbx
               	movslq	%ebx, %rbx
               	addq	%rbx, %r8
               	movzbq	(%r8), %r8
               	movb	%r8b, 0xa(%rsi)
               	leaq	-0x3b8(%rbp), %r9
               	addq	$0xb, %rdx
               	movslq	%edx, %rdx
               	addq	%r9, %rdx
               	movzbq	(%rdx), %rdx
               	movb	%dl, 0xb(%rsi)
               	leaq	-0x2e8(%rbp), %r8
               	leaq	(%r8,%rdi), %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	0xc(%rdx), %rdi
               	movslq	%edi, %rdi
               	addq	%r9, %rdi
               	movzbq	(%rdi), %rdi
               	movb	%dil, 0xc(%rsi)
               	movq	%rcx, %rdi
               	shlq	$0x4, %rdi
               	leaq	(%r8,%rdi), %rsi
               	leaq	-0x3b8(%rbp), %rbx
               	leaq	0xd(%rdx), %r9
               	movslq	%r9d, %r9
               	addq	%rbx, %r9
               	movzbq	(%r9), %r9
               	movb	%r9b, 0xd(%rsi)
               	leaq	-0x3b8(%rbp), %rdi
               	addq	$0xe, %rdx
               	movslq	%edx, %rdx
               	addq	%rdi, %rdx
               	movzbq	(%rdx), %rdx
               	movb	%dl, 0xe(%rsi)
               	leaq	-0x2e8(%rbp), %rdx
               	movq	%rcx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdx, %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	$0xf, %rdx
               	movslq	%edx, %rdx
               	addq	%rdi, %rdx
               	movzbq	(%rdx), %rdx
               	movb	%dl, 0xf(%rsi)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	leaq	-0x2e8(%rbp), %rdi
               	leaq	-0x368(%rbp), %rax
               	leaq	(%rax), %rsi
               	callq	<addr>
               	leaq	-0x2e8(%rbp), %rdi
               	leaq	-0x368(%rbp), %rax
               	leaq	0x10(%rax), %rsi
               	callq	<addr>
               	leaq	-0x2e8(%rbp), %rdi
               	leaq	-0x368(%rbp), %rax
               	leaq	0x20(%rax), %rsi
               	callq	<addr>
               	leaq	-0x2e8(%rbp), %rdi
               	leaq	-0x368(%rbp), %rax
               	leaq	0x30(%rax), %rsi
               	callq	<addr>
               	leaq	-0x2e8(%rbp), %rdi
               	leaq	-0x368(%rbp), %rax
               	leaq	0x40(%rax), %rsi
               	callq	<addr>
               	leaq	-0x2e8(%rbp), %rdi
               	leaq	-0x368(%rbp), %rax
               	leaq	0x50(%rax), %rsi
               	callq	<addr>
               	leaq	-0x2e8(%rbp), %rdi
               	leaq	-0x368(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	callq	<addr>
               	leaq	-0x2e8(%rbp), %rbx
               	leaq	-0x368(%rbp), %rax
               	leaq	0x70(%rax), %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x298(%rbp), %rdx
               	movslq	%eax, %rcx
               	addq	%rcx, %rdx
               	leaq	-0x3b8(%rbp), %rsi
               	addq	%rcx, %rsi
               	movzbq	(%rsi), %rsi
               	movb	%sil, (%rdx)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x50, %eax
               	jl	<addr>
               	leaq	-0x298(%rbp), %r12
               	leaq	-0x368(%rbp), %rsi
               	movl	$0x8, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x4, %rdx
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	addq	%r12, %rdx
               	movzbq	(%rdx), %rsi
               	movslq	%ecx, %rdx
               	shlq	$0x4, %rdx
               	leaq	(%rbx,%rdx), %rdi
               	movslq	%eax, %rdx
               	addq	%rdx, %rdi
               	movzbq	(%rdi), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	cmpl	$0x5, %ecx
               	jl	<addr>
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x248(%rbp), %rdx
               	movslq	%eax, %rcx
               	addq	%rcx, %rdx
               	leaq	-0x3b8(%rbp), %rsi
               	addq	%rsi, %rcx
               	movzbq	(%rcx), %rcx
               	movb	%cl, (%rdx)
               	movslq	%eax, %rax
               	incq	%rax
               	cmpl	$0x50, %eax
               	jl	<addr>
               	leaq	-0x248(%rbp), %rdi
               	leaq	-0x368(%rbp), %rsi
               	movq	%rbx, %rdx
               	callq	<addr>
               	leaq	-0x248(%rbp), %rdi
               	leaq	-0x368(%rbp), %rcx
               	movq	%rbx, %rax
               	shlq	$0x4, %rax
               	movslq	%eax, %rax
               	leaq	(%rcx,%rax), %rsi
               	movl	$0x8, %eax
               	movq	%rax, %rdx
               	subq	%rbx, %rdx
               	callq	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x248(%rbp), %rdx
               	movslq	%eax, %rcx
               	addq	%rcx, %rdx
               	movzbq	(%rdx), %rdx
               	leaq	-0x298(%rbp), %rsi
               	addq	%rsi, %rcx
               	movzbq	(%rcx), %rcx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	movslq	%eax, %rax
               	incq	%rax
               	cmpl	$0x50, %eax
               	jl	<addr>
               	movslq	%ebx, %rax
               	leaq	0x1(%rax), %rbx
               	cmpl	$0x8, %ebx
               	jle	<addr>
               	leaq	-0x3b8(%rbp), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x3c8(%rbp,%riz)
               	leaq	-0x3c8(%rbp), %rax
               	leaq	-0x4c0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x3b8(%rbp), %rax
               	leaq	0x10(%rax), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x3c8(%rbp,%riz)
               	leaq	-0x3c8(%rbp), %rax
               	leaq	-0x4b0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x3b8(%rbp), %rax
               	leaq	0x20(%rax), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x3c8(%rbp,%riz)
               	leaq	-0x3c8(%rbp), %rax
               	leaq	-0x4a0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x3b8(%rbp), %rax
               	leaq	0x30(%rax), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x3c8(%rbp,%riz)
               	leaq	-0x3c8(%rbp), %rax
               	leaq	-0x490(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x3b8(%rbp), %rax
               	leaq	0x40(%rax), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x3c8(%rbp,%riz)
               	leaq	-0x3c8(%rbp), %rax
               	leaq	-0x480(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x470(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	leaq	-0x4c0(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x4b0(%rbp), %rdx
               	leaq	0x10(%rax), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	leaq	-0x4a0(%rbp), %rdx
               	leaq	0x20(%rax), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	leaq	-0x490(%rbp), %rdx
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
               	leaq	-0xb0(%rbp), %rbx
               	leaq	-0x470(%rbp), %r12
               	leaq	-0x368(%rbp), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x60(%rbp,%riz)
               	leaq	-0x60(%rbp), %rdx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x158(%rbp), %rbx
               	leaq	-0x420(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x20(%rax)
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	movq	0x30(%rcx), %rdx
               	movq	%rdx, 0x30(%rax)
               	movq	0x38(%rcx), %rdx
               	movq	%rdx, 0x38(%rax)
               	movq	0x40(%rcx), %rdx
               	movq	%rdx, 0x40(%rax)
               	movq	0x48(%rcx), %rdx
               	movq	%rdx, 0x48(%rax)
               	popq	%rdx
               	leaq	(%rbx), %rdi
               	leaq	(%rax), %rsi
               	movq	%rsi, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	leaq	0x10(%rbx), %rdi
               	leaq	-0x420(%rbp), %rax
               	leaq	0x10(%rax), %rsi
               	movq	%rsi, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	leaq	0x20(%rbx), %rdi
               	leaq	-0x420(%rbp), %rax
               	leaq	0x20(%rax), %rsi
               	movq	%rsi, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	leaq	0x30(%rbx), %rdi
               	leaq	-0x420(%rbp), %rax
               	leaq	0x30(%rax), %rsi
               	movq	%rsi, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	leaq	0x40(%rbx), %rdi
               	leaq	-0x420(%rbp), %rax
               	leaq	0x40(%rax), %rsi
               	movq	%rsi, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x100(%rbp), %r8
               	movslq	%eax, %rcx
               	movq	%rcx, %rsi
               	shlq	$0x4, %rsi
               	leaq	(%r8,%rsi), %rdi
               	leaq	(%rdi), %rbx
               	leaq	-0x3b8(%rbp), %r12
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	(%rdx), %r9
               	movslq	%r9d, %r9
               	addq	%r12, %r9
               	movzbq	(%r9), %r9
               	movb	%r9b, (%rbx)
               	leaq	-0x3b8(%rbp), %r8
               	incq	%rdx
               	movslq	%edx, %rdx
               	addq	%r8, %rdx
               	movzbq	(%rdx), %rdx
               	movb	%dl, 0x1(%rdi)
               	leaq	-0x100(%rbp), %rdi
               	addq	%rdi, %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	0x2(%rdx), %r9
               	movslq	%r9d, %r9
               	addq	%r9, %r8
               	movzbq	(%r8), %r8
               	movb	%r8b, 0x2(%rsi)
               	movq	%rcx, %r8
               	shlq	$0x4, %r8
               	leaq	(%rdi,%r8), %rsi
               	leaq	-0x3b8(%rbp), %rbx
               	leaq	0x3(%rdx), %r9
               	movslq	%r9d, %r9
               	addq	%rbx, %r9
               	movzbq	(%r9), %r9
               	movb	%r9b, 0x3(%rsi)
               	leaq	-0x3b8(%rbp), %r8
               	addq	$0x4, %rdx
               	movslq	%edx, %rdx
               	addq	%r8, %rdx
               	movzbq	(%rdx), %rdx
               	movb	%dl, 0x4(%rsi)
               	leaq	-0x100(%rbp), %r9
               	movq	%rcx, %rdi
               	shlq	$0x4, %rdi
               	leaq	(%r9,%rdi), %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	0x5(%rdx), %rbx
               	movslq	%ebx, %rbx
               	addq	%rbx, %r8
               	movzbq	(%r8), %r8
               	movb	%r8b, 0x5(%rsi)
               	leaq	-0x3b8(%rbp), %r9
               	addq	$0x6, %rdx
               	movslq	%edx, %rdx
               	addq	%r9, %rdx
               	movzbq	(%rdx), %rdx
               	movb	%dl, 0x6(%rsi)
               	leaq	-0x100(%rbp), %r8
               	leaq	(%r8,%rdi), %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	0x7(%rdx), %rdi
               	movslq	%edi, %rdi
               	addq	%r9, %rdi
               	movzbq	(%rdi), %rdi
               	movb	%dil, 0x7(%rsi)
               	movq	%rcx, %rdi
               	shlq	$0x4, %rdi
               	leaq	(%r8,%rdi), %rsi
               	leaq	-0x3b8(%rbp), %rbx
               	leaq	0x8(%rdx), %r9
               	movslq	%r9d, %r9
               	addq	%rbx, %r9
               	movzbq	(%r9), %r9
               	movb	%r9b, 0x8(%rsi)
               	leaq	-0x3b8(%rbp), %r8
               	addq	$0x9, %rdx
               	movslq	%edx, %rdx
               	addq	%r8, %rdx
               	movzbq	(%rdx), %rdx
               	movb	%dl, 0x9(%rsi)
               	leaq	-0x100(%rbp), %r9
               	movq	%rcx, %rdi
               	shlq	$0x4, %rdi
               	leaq	(%r9,%rdi), %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	0xa(%rdx), %rbx
               	movslq	%ebx, %rbx
               	addq	%rbx, %r8
               	movzbq	(%r8), %r8
               	movb	%r8b, 0xa(%rsi)
               	leaq	-0x3b8(%rbp), %r9
               	addq	$0xb, %rdx
               	movslq	%edx, %rdx
               	addq	%r9, %rdx
               	movzbq	(%rdx), %rdx
               	movb	%dl, 0xb(%rsi)
               	leaq	-0x100(%rbp), %r8
               	leaq	(%r8,%rdi), %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	0xc(%rdx), %rdi
               	movslq	%edi, %rdi
               	addq	%r9, %rdi
               	movzbq	(%rdi), %rdi
               	movb	%dil, 0xc(%rsi)
               	movq	%rcx, %rdi
               	shlq	$0x4, %rdi
               	leaq	(%r8,%rdi), %rsi
               	leaq	-0x3b8(%rbp), %rbx
               	leaq	0xd(%rdx), %r9
               	movslq	%r9d, %r9
               	addq	%rbx, %r9
               	movzbq	(%r9), %r9
               	movb	%r9b, 0xd(%rsi)
               	leaq	-0x3b8(%rbp), %rdi
               	addq	$0xe, %rdx
               	movslq	%edx, %rdx
               	addq	%rdi, %rdx
               	movzbq	(%rdx), %rdx
               	movb	%dl, 0xe(%rsi)
               	leaq	-0x100(%rbp), %rdx
               	movq	%rcx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdx, %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	$0xf, %rdx
               	movslq	%edx, %rdx
               	addq	%rdi, %rdx
               	movzbq	(%rdx), %rdx
               	movb	%dl, 0xf(%rsi)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	leaq	-0x100(%rbp), %rbx
               	leaq	-0x368(%rbp), %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x158(%rbp), %rsi
               	movq	%rcx, %rdx
               	shlq	$0x4, %rdx
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	addq	%rsi, %rdx
               	movzbq	(%rdx), %rsi
               	movslq	%ecx, %rdx
               	shlq	$0x4, %rdx
               	leaq	(%rbx,%rdx), %rdi
               	movslq	%eax, %rdx
               	addq	%rdx, %rdi
               	movzbq	(%rdi), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	cmpl	$0x5, %ecx
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x14, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	0x2(%rbx), %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
