
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
               	movzbq	(%rdi), %rax
               	movb	%al, -0x10(%rbp)
               	movzbq	0x1(%rdi), %rax
               	movb	%al, -0xf(%rbp)
               	movzbq	0x2(%rdi), %rax
               	movb	%al, -0xe(%rbp)
               	movzbq	0x3(%rdi), %rax
               	movb	%al, -0xd(%rbp)
               	movzbq	0x4(%rdi), %rax
               	movb	%al, -0xc(%rbp)
               	movzbq	0x5(%rdi), %rax
               	movb	%al, -0xb(%rbp)
               	movzbq	0x6(%rdi), %rax
               	movb	%al, -0xa(%rbp)
               	movzbq	0x7(%rdi), %rax
               	movb	%al, -0x9(%rbp)
               	movzbq	0x8(%rdi), %rax
               	movb	%al, -0x8(%rbp)
               	movzbq	0x9(%rdi), %rax
               	movb	%al, -0x7(%rbp)
               	movzbq	0xa(%rdi), %rax
               	movb	%al, -0x6(%rbp)
               	movzbq	0xb(%rdi), %rax
               	movb	%al, -0x5(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movzbq	0xc(%rdi), %rcx
               	movb	%cl, -0x4(%rbp)
               	movzbq	0xd(%rdi), %rcx
               	movb	%cl, -0x3(%rbp)
               	movzbq	0xe(%rdi), %rcx
               	movb	%cl, -0x2(%rbp)
               	movzbq	0xf(%rdi), %rcx
               	movb	%cl, -0x1(%rbp)
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<store16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movups	%xmm0, -0x10(%rbp)
               	movzbq	-0x10(%rbp), %rax
               	movb	%al, (%rdi)
               	movzbq	-0xf(%rbp), %rax
               	movb	%al, 0x1(%rdi)
               	movzbq	-0xe(%rbp), %rax
               	movb	%al, 0x2(%rdi)
               	movzbq	-0xd(%rbp), %rax
               	movb	%al, 0x3(%rdi)
               	movzbq	-0xc(%rbp), %rax
               	movb	%al, 0x4(%rdi)
               	movzbq	-0xb(%rbp), %rax
               	movb	%al, 0x5(%rdi)
               	movzbq	-0xa(%rbp), %rax
               	movb	%al, 0x6(%rdi)
               	movzbq	-0x9(%rbp), %rax
               	movb	%al, 0x7(%rdi)
               	movzbq	-0x8(%rbp), %rax
               	movb	%al, 0x8(%rdi)
               	movzbq	-0x7(%rbp), %rax
               	movb	%al, 0x9(%rdi)
               	movzbq	-0x6(%rbp), %rax
               	movb	%al, 0xa(%rdi)
               	movzbq	-0x5(%rbp), %rax
               	movb	%al, 0xb(%rdi)
               	movzbq	-0x4(%rbp), %rax
               	movb	%al, 0xc(%rdi)
               	movzbq	-0x3(%rbp), %rax
               	movb	%al, 0xd(%rdi)
               	movzbq	-0x2(%rbp), %rax
               	movb	%al, 0xe(%rdi)
               	movzbq	-0x1(%rbp), %rax
               	movb	%al, 0xf(%rdi)
               	leave
               	retq

<mix>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x98, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movups	%xmm0, -0x90(%rbp)
               	leaq	-0x80(%rbp), %rax
               	movzbq	-0x90(%rbp), %rcx
               	shlq	%rcx
               	movb	%cl, -0x80(%rbp)
               	movzbq	-0x8f(%rbp), %rcx
               	shlq	%rcx
               	movb	%cl, -0x7f(%rbp)
               	movzbq	-0x8e(%rbp), %rcx
               	shlq	%rcx
               	movb	%cl, -0x7e(%rbp)
               	movzbq	-0x8d(%rbp), %rcx
               	shlq	%rcx
               	movb	%cl, -0x7d(%rbp)
               	movzbq	-0x8c(%rbp), %rcx
               	shlq	%rcx
               	movb	%cl, -0x7c(%rbp)
               	movzbq	-0x8b(%rbp), %rcx
               	shlq	%rcx
               	movb	%cl, -0x7b(%rbp)
               	movzbq	-0x8a(%rbp), %rcx
               	shlq	%rcx
               	movb	%cl, -0x7a(%rbp)
               	movzbq	-0x89(%rbp), %rcx
               	shlq	%rcx
               	movb	%cl, -0x79(%rbp)
               	movzbq	-0x88(%rbp), %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	leaq	0x8(%rax), %rcx
               	movb	%dl, (%rcx)
               	movzbq	-0x87(%rbp), %rax
               	shlq	%rax
               	movb	%al, -0x77(%rbp)
               	movzbq	-0x86(%rbp), %rax
               	shlq	%rax
               	movb	%al, -0x76(%rbp)
               	movzbq	-0x85(%rbp), %rax
               	shlq	%rax
               	movb	%al, -0x75(%rbp)
               	movzbq	-0x84(%rbp), %rax
               	shlq	%rax
               	movb	%al, -0x74(%rbp)
               	movzbq	-0x83(%rbp), %rax
               	shlq	%rax
               	movb	%al, -0x73(%rbp)
               	movzbq	-0x82(%rbp), %rax
               	shlq	%rax
               	movb	%al, -0x72(%rbp)
               	movzbq	-0x81(%rbp), %rax
               	shlq	%rax
               	movb	%al, -0x71(%rbp)
               	movzbq	-0x90(%rbp), %rax
               	movq	%rax, %rdx
               	shrq	$0x7, %rdx
               	movzbq	-0x8f(%rbp), %rax
               	movq	%rax, %rsi
               	shrq	$0x7, %rsi
               	movzbq	-0x8e(%rbp), %rax
               	movq	%rax, %rdi
               	shrq	$0x7, %rdi
               	movzbq	-0x8d(%rbp), %rax
               	movq	%rax, %r8
               	shrq	$0x7, %r8
               	movzbq	-0x8c(%rbp), %rax
               	movq	%rax, %r9
               	shrq	$0x7, %r9
               	movzbq	-0x8b(%rbp), %rax
               	movq	%rax, %rbx
               	shrq	$0x7, %rbx
               	movzbq	-0x8a(%rbp), %rax
               	movq	%rax, %r12
               	shrq	$0x7, %r12
               	movzbq	-0x89(%rbp), %rax
               	movq	%rax, %r13
               	shrq	$0x7, %r13
               	movzbq	-0x88(%rbp), %rax
               	movq	%rax, %r14
               	shrq	$0x7, %r14
               	movzbq	-0x87(%rbp), %rax
               	movq	%rax, %r15
               	shrq	$0x7, %r15
               	movzbq	-0x86(%rbp), %rax
               	movq	%rax, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0xb8(%rsp)
               	movzbq	-0x85(%rbp), %rax
               	movq	%rax, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0xb0(%rsp)
               	movzbq	-0x84(%rbp), %rax
               	movq	%rax, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0xa8(%rsp)
               	movzbq	-0x83(%rbp), %rax
               	movq	%rax, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0xa0(%rsp)
               	movzbq	-0x82(%rbp), %rax
               	movq	%rax, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0x98(%rsp)
               	movzbq	-0x81(%rbp), %rax
               	movq	%rax, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0x90(%rsp)
               	movl	$0x1b, %eax
               	leaq	-0x70(%rbp), %r10
               	movq	%r10, 0x88(%rsp)
               	imulq	%rax, %rdx
               	movb	%dl, -0x70(%rbp)
               	movq	%rsi, %rdx
               	imulq	%rax, %rdx
               	movb	%dl, -0x6f(%rbp)
               	movq	%rdi, %rdx
               	imulq	%rax, %rdx
               	movb	%dl, -0x6e(%rbp)
               	movq	%r8, %rdx
               	imulq	%rax, %rdx
               	movb	%dl, -0x6d(%rbp)
               	movq	%r9, %rdx
               	imulq	%rax, %rdx
               	movb	%dl, -0x6c(%rbp)
               	movq	%rbx, %rdx
               	imulq	%rax, %rdx
               	movb	%dl, -0x6b(%rbp)
               	movq	%r12, %rdx
               	imulq	%rax, %rdx
               	movb	%dl, -0x6a(%rbp)
               	movq	%r13, %rdx
               	imulq	%rax, %rdx
               	movb	%dl, -0x69(%rbp)
               	movq	%r14, %rsi
               	imulq	%rax, %rsi
               	movq	0x88(%rsp), %rdx
               	addq	$0x8, %rdx
               	movb	%sil, (%rdx)
               	movq	%r15, %rsi
               	imulq	%rax, %rsi
               	movb	%sil, -0x67(%rbp)
               	movq	0xb8(%rsp), %rsi
               	imulq	%rax, %rsi
               	movb	%sil, -0x66(%rbp)
               	movq	0xb0(%rsp), %rsi
               	imulq	%rax, %rsi
               	movb	%sil, -0x65(%rbp)
               	movq	0xa8(%rsp), %rsi
               	imulq	%rax, %rsi
               	movb	%sil, -0x64(%rbp)
               	movq	0xa0(%rsp), %rsi
               	imulq	%rax, %rsi
               	movb	%sil, -0x63(%rbp)
               	movq	0x98(%rsp), %rsi
               	imulq	%rax, %rsi
               	movb	%sil, -0x62(%rbp)
               	movq	%rax, %r10
               	movq	0x90(%rsp), %rax
               	imulq	%r10, %rax
               	movb	%al, -0x61(%rbp)
               	leaq	-0x60(%rbp), %rax
               	movq	-0x80(%rbp), %rsi
               	movq	-0x70(%rbp), %rdi
               	xorq	%rdi, %rsi
               	movq	%rsi, -0x60(%rbp)
               	leaq	0x8(%rax), %rsi
               	movq	(%rcx), %rax
               	movq	(%rdx), %rcx
               	xorq	%rcx, %rax
               	movq	%rax, (%rsi)
               	movl	$0x63, %ecx
               	leaq	-0x50(%rbp), %rax
               	movzbq	-0x60(%rbp), %rdx
               	xorq	%rcx, %rdx
               	movb	%dl, -0x50(%rbp)
               	movzbq	-0x5f(%rbp), %rdx
               	xorq	%rcx, %rdx
               	movb	%dl, -0x4f(%rbp)
               	movzbq	-0x5e(%rbp), %rdx
               	xorq	%rcx, %rdx
               	movb	%dl, -0x4e(%rbp)
               	movzbq	-0x5d(%rbp), %rdx
               	xorq	%rcx, %rdx
               	movb	%dl, -0x4d(%rbp)
               	movzbq	-0x5c(%rbp), %rdx
               	xorq	%rcx, %rdx
               	movb	%dl, -0x4c(%rbp)
               	movzbq	-0x5b(%rbp), %rdx
               	xorq	%rcx, %rdx
               	movb	%dl, -0x4b(%rbp)
               	movzbq	-0x5a(%rbp), %rdx
               	xorq	%rcx, %rdx
               	movb	%dl, -0x4a(%rbp)
               	movzbq	-0x59(%rbp), %rdx
               	xorq	%rcx, %rdx
               	movb	%dl, -0x49(%rbp)
               	movzbq	(%rsi), %rdx
               	xorq	%rcx, %rdx
               	movb	%dl, -0x48(%rbp)
               	movzbq	-0x57(%rbp), %rdx
               	xorq	%rcx, %rdx
               	movb	%dl, -0x47(%rbp)
               	movzbq	-0x56(%rbp), %rdx
               	xorq	%rcx, %rdx
               	movb	%dl, -0x46(%rbp)
               	movzbq	-0x55(%rbp), %rdx
               	xorq	%rcx, %rdx
               	movb	%dl, -0x45(%rbp)
               	movzbq	-0x54(%rbp), %rdx
               	xorq	%rcx, %rdx
               	movb	%dl, -0x44(%rbp)
               	movzbq	-0x53(%rbp), %rdx
               	xorq	%rcx, %rdx
               	movb	%dl, -0x43(%rbp)
               	movzbq	-0x52(%rbp), %rdx
               	xorq	%rcx, %rdx
               	movb	%dl, -0x42(%rbp)
               	movzbq	-0x51(%rbp), %rdx
               	xorq	%rdx, %rcx
               	movb	%cl, -0x41(%rbp)
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
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
               	movq	-0x40(%rbp), %rax
               	movq	-0x30(%rbp), %rcx
               	movq	%rax, %rbx
               	xorq	%rcx, %rbx
               	movq	-0x38(%rbp), %rax
               	movq	-0x28(%rbp), %rcx
               	movq	%rax, %r12
               	xorq	%rcx, %r12
               	movq	%rbx, -0x40(%rbp)
               	movq	%r12, -0x38(%rbp)
               	leaq	-0x90(%rbp), %rax
               	leaq	0x30(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, -0x30(%rbp)
               	movq	-0x50(%rbp), %rax
               	movq	-0x30(%rbp), %rcx
               	xorq	%rax, %rcx
               	movq	-0x48(%rbp), %rax
               	movq	-0x28(%rbp), %rdx
               	xorq	%rax, %rdx
               	leaq	-0x90(%rbp), %rax
               	addq	$0x40, %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x90(%rbp), %rax
               	leaq	0x20(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, -0x30(%rbp)
               	movq	-0x60(%rbp), %rax
               	movq	-0x30(%rbp), %rcx
               	xorq	%rax, %rcx
               	movq	-0x58(%rbp), %rax
               	movq	-0x28(%rbp), %rdx
               	xorq	%rax, %rdx
               	leaq	-0x90(%rbp), %rax
               	addq	$0x30, %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x90(%rbp), %rax
               	leaq	0x10(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, -0x30(%rbp)
               	movq	-0x70(%rbp), %rax
               	movq	-0x30(%rbp), %rcx
               	xorq	%rax, %rcx
               	movq	-0x68(%rbp), %rax
               	movq	-0x28(%rbp), %rdx
               	xorq	%rax, %rdx
               	leaq	-0x90(%rbp), %rax
               	addq	$0x20, %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x90(%rbp), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, -0x30(%rbp)
               	movq	-0x80(%rbp), %rax
               	movq	-0x30(%rbp), %rcx
               	xorq	%rax, %rcx
               	movq	-0x78(%rbp), %rax
               	movq	-0x28(%rbp), %rdx
               	xorq	%rax, %rdx
               	leaq	-0x90(%rbp), %rax
               	addq	$0x10, %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x90(%rbp), %rcx
               	movq	-0x90(%rbp), %rax
               	xorq	%rbx, %rax
               	movq	-0x88(%rbp), %rdx
               	xorq	%r12, %rdx
               	movq	%rax, -0x90(%rbp)
               	movq	%rdx, -0x88(%rbp)
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
               	subq	$0x108, %rsp            # imm = 0x108
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r13
               	movq	%rdx, %r15
               	movq	%rsi, %r14
               	leaq	-0x60(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movq	%r13, %rdi
               	callq	<addr>
               	movups	%xmm0, -0x100(%rbp)
               	leaq	-0x100(%rbp), %rax
               	leaq	-0x60(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x10(%r13), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x100(%rbp)
               	leaq	-0x100(%rbp), %rax
               	leaq	-0x60(%rbp), %rcx
               	addq	$0x10, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%r13), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x100(%rbp)
               	leaq	-0x100(%rbp), %rax
               	leaq	-0x60(%rbp), %rcx
               	addq	$0x20, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x30(%r13), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x100(%rbp)
               	leaq	-0x100(%rbp), %rax
               	leaq	-0x60(%rbp), %rcx
               	addq	$0x30, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%r13), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x100(%rbp)
               	leaq	-0x100(%rbp), %rax
               	leaq	-0x60(%rbp), %rcx
               	addq	$0x40, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	-0x60(%rbp), %rax
               	movq	-0x58(%rbp), %rcx
               	movq	-0x50(%rbp), %rdx
               	movq	-0x48(%rbp), %rsi
               	movq	-0x40(%rbp), %rdi
               	movq	-0x38(%rbp), %r8
               	movq	-0x30(%rbp), %r9
               	movq	-0x28(%rbp), %rbx
               	movq	-0x20(%rbp), %r12
               	movq	-0x18(%rbp), %r10
               	movq	%r10, 0x128(%rsp)
               	movq	%rax, -0x100(%rbp)
               	movq	%rcx, -0xf8(%rbp)
               	movq	%rdx, -0xf0(%rbp)
               	movq	%rsi, -0xe8(%rbp)
               	movq	%rdi, -0xe0(%rbp)
               	movq	%r8, -0xd8(%rbp)
               	movq	%r9, -0xd0(%rbp)
               	movq	%rbx, -0xc8(%rbp)
               	movq	%r12, -0xc0(%rbp)
               	movq	0x128(%rsp), %r10
               	movq	%r10, -0xb8(%rbp)
               	xorl	%ebx, %ebx
               	cmpl	%r15d, %ebx
               	jge	<addr>
               	leaq	-0x100(%rbp), %r12
               	leaq	-0xb0(%rbp), %r10
               	movq	%r10, 0x128(%rsp)
               	movq	%rbx, %rax
               	shlq	$0x4, %rax
               	movslq	%eax, %rax
               	leaq	(%r14,%rax), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x60(%rbp)
               	leaq	-0x60(%rbp), %r9
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
               	movq	0x178(%rsp), %rdi
               	callq	<addr>
               	addq	$0x50, %rsp
               	leaq	-0xb0(%rbp), %rax
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
               	leaq	-0x100(%rbp), %rax
               	leaq	-0x60(%rbp), %r9
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
               	leaq	-0x60(%rbp), %rax
               	leaq	0x10(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	0x20(%r13), %rdi
               	leaq	-0x60(%rbp), %rax
               	leaq	0x20(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	0x30(%r13), %rdi
               	leaq	-0x60(%rbp), %rax
               	leaq	0x30(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	0x40(%r13), %rdi
               	leaq	-0x60(%rbp), %rax
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
               	subq	$0x310, %rsp            # imm = 0x310
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
               	leaq	-0xd8(%rbp), %rcx
               	imulq	$0x1f, %rax, %rdx
               	addq	$0x9, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x80, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x1c8(%rbp), %rdx
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
               	leaq	-0x1c8(%rbp), %rsi
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
               	leaq	-0x1c8(%rbp), %rdx
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
               	leaq	-0x1c8(%rbp), %rsi
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
               	leaq	-0x1c8(%rbp), %rdx
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
               	leaq	-0x1c8(%rbp), %rsi
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
               	leaq	-0x1c8(%rbp), %rdx
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
               	leaq	-0x1c8(%rbp), %rdi
               	leaq	-0xd8(%rbp), %rsi
               	callq	<addr>
               	leaq	-0x1c8(%rbp), %rdi
               	leaq	-0xd8(%rbp), %rax
               	leaq	0x10(%rax), %rsi
               	callq	<addr>
               	leaq	-0x1c8(%rbp), %rdi
               	leaq	-0xd8(%rbp), %rax
               	leaq	0x20(%rax), %rsi
               	callq	<addr>
               	leaq	-0x1c8(%rbp), %rdi
               	leaq	-0xd8(%rbp), %rax
               	leaq	0x30(%rax), %rsi
               	callq	<addr>
               	leaq	-0x1c8(%rbp), %rdi
               	leaq	-0xd8(%rbp), %rax
               	leaq	0x40(%rax), %rsi
               	callq	<addr>
               	leaq	-0x1c8(%rbp), %rdi
               	leaq	-0xd8(%rbp), %rax
               	leaq	0x50(%rax), %rsi
               	callq	<addr>
               	leaq	-0x1c8(%rbp), %rdi
               	leaq	-0xd8(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	callq	<addr>
               	leaq	-0x1c8(%rbp), %rbx
               	leaq	-0xd8(%rbp), %rax
               	leaq	0x70(%rax), %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	leaq	-0x178(%rbp), %rcx
               	leaq	-0x218(%rbp), %rdx
               	movzbq	(%rdx,%rax), %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x50, %eax
               	jl	<addr>
               	leaq	-0x178(%rbp), %r12
               	leaq	-0xd8(%rbp), %rsi
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
               	leaq	-0x128(%rbp), %rcx
               	leaq	-0x218(%rbp), %rdx
               	movzbq	(%rdx,%rax), %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x50, %eax
               	jl	<addr>
               	leaq	-0x128(%rbp), %rdi
               	leaq	-0xd8(%rbp), %rsi
               	movq	%rbx, %rdx
               	callq	<addr>
               	leaq	-0x128(%rbp), %rdi
               	leaq	-0xd8(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rax,%rcx), %rsi
               	movl	$0x8, %eax
               	movq	%rax, %rdx
               	subq	%rbx, %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	leaq	-0x128(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rcx
               	leaq	-0x178(%rbp), %rdx
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
               	movups	%xmm0, -0x2c0(%rbp)
               	leaq	-0x2c0(%rbp), %rax
               	leaq	-0x310(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x218(%rbp), %rax
               	leaq	0x10(%rax), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x2c0(%rbp)
               	leaq	-0x2c0(%rbp), %rax
               	leaq	-0x300(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x218(%rbp), %rax
               	leaq	0x20(%rax), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x2c0(%rbp)
               	leaq	-0x2c0(%rbp), %rax
               	leaq	-0x2f0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x218(%rbp), %rax
               	leaq	0x30(%rax), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x2c0(%rbp)
               	leaq	-0x2c0(%rbp), %rax
               	leaq	-0x2e0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x218(%rbp), %rax
               	leaq	0x40(%rax), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x2c0(%rbp)
               	leaq	-0x2c0(%rbp), %rax
               	leaq	-0x2d0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x2c0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	leaq	-0x310(%rbp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x300(%rbp), %rdx
               	leaq	0x10(%rax), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0x2f0(%rbp), %rdx
               	leaq	0x20(%rax), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0x2e0(%rbp), %rdx
               	leaq	0x30(%rax), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	addq	$0x40, %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xd8(%rbp), %rdi
               	callq	<addr>
               	movups	%xmm0, -0x2d0(%rbp)
               	leaq	-0x2d0(%rbp), %r9
               	leaq	-0x270(%rbp), %rdi
               	leaq	-0x2c0(%rbp), %rax
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
               	leaq	-0x270(%rbp), %rax
               	leaq	-0x128(%rbp), %rdi
               	leaq	-0x2c0(%rbp), %r9
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
               	leaq	-0x128(%rbp), %rax
               	leaq	0x10(%rax), %rdi
               	leaq	-0x2c0(%rbp), %rax
               	leaq	0x10(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	-0x128(%rbp), %rax
               	leaq	0x20(%rax), %rdi
               	leaq	-0x2c0(%rbp), %rax
               	leaq	0x20(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	-0x128(%rbp), %rax
               	leaq	0x30(%rax), %rdi
               	leaq	-0x2c0(%rbp), %rax
               	leaq	0x30(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	-0x128(%rbp), %rax
               	leaq	0x40(%rax), %rdi
               	leaq	-0x2c0(%rbp), %rax
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
               	leaq	-0xd8(%rbp), %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	leaq	-0x128(%rbp), %rsi
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
