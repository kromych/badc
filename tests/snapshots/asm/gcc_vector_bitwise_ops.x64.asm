
gcc_vector_bitwise_ops.x64:	file format elf64-x86-64

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

<same16>:
               	vpextrb	$0x0, %xmm0, %eax
               	movzbq	(%rdi), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	xorl	%eax, %eax
               	retq
               	vpextrb	$0x1, %xmm0, %eax
               	movzbq	0x1(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x2, %xmm0, %eax
               	movzbq	0x2(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x3, %xmm0, %eax
               	movzbq	0x3(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x4, %xmm0, %eax
               	movzbq	0x4(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x5, %xmm0, %eax
               	movzbq	0x5(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x6, %xmm0, %eax
               	movzbq	0x6(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x7, %xmm0, %eax
               	movzbq	0x7(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x8, %xmm0, %eax
               	movzbq	0x8(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x9, %xmm0, %eax
               	movzbq	0x9(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0xa, %xmm0, %eax
               	movzbq	0xa(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0xb, %xmm0, %eax
               	movzbq	0xb(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0xc, %xmm0, %eax
               	movzbq	0xc(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0xd, %xmm0, %eax
               	movzbq	0xd(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0xe, %xmm0, %eax
               	movzbq	0xe(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0xf, %xmm0, %eax
               	movzbq	0xf(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	leaq	-0x80(%rbp), %rcx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x70(%rbp), %rdx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	leaq	-0x30(%rbp), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	movzbq	(%rdx,%rax), %r8
               	xorq	%r8, %rdi
               	movb	%dil, (%rsi,%rax)
               	leaq	-0x20(%rbp), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	movzbq	(%rdx,%rax), %r8
               	andq	%r8, %rdi
               	movb	%dil, (%rsi,%rax)
               	leaq	-0x10(%rbp), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	movzbq	(%rdx,%rax), %r8
               	orq	%r8, %rdi
               	movb	%dil, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	-0x80(%rbp), %xmm0
               	movups	-0x70(%rbp), %xmm1
               	pxor	%xmm1, %xmm0
               	leaq	-0x60(%rbp), %r9
               	movups	%xmm0, -0x60(%rbp)
               	leaq	-0x30(%rbp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movups	-0x80(%rbp), %xmm0
               	movups	-0x70(%rbp), %xmm1
               	pand	%xmm1, %xmm0
               	leaq	-0x60(%rbp), %r9
               	movups	%xmm0, -0x60(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movups	-0x80(%rbp), %xmm0
               	movups	-0x70(%rbp), %xmm1
               	por	%xmm1, %xmm0
               	leaq	-0x60(%rbp), %r9
               	movups	%xmm0, -0x60(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movups	-0x80(%rbp), %xmm1
               	movups	-0x70(%rbp), %xmm0
               	pxor	%xmm0, %xmm1
               	pxor	%xmm1, %xmm0
               	leaq	-0x60(%rbp), %r9
               	movups	%xmm0, -0x60(%rbp)
               	leaq	-0x80(%rbp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rax
               	leaq	-0x60(%rbp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	-0x80(%rbp), %xmm0
               	movups	-0x70(%rbp), %xmm1
               	pxor	%xmm1, %xmm0
               	movups	%xmm0, -0x60(%rbp)
               	leaq	-0x30(%rbp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %r9
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	-0x80(%rbp), %xmm0
               	movups	-0x70(%rbp), %xmm1
               	pand	%xmm1, %xmm0
               	movups	%xmm0, -0x60(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %r9
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	-0x80(%rbp), %xmm0
               	movups	-0x70(%rbp), %xmm1
               	por	%xmm1, %xmm0
               	movups	%xmm0, -0x60(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movups	-0x80(%rbp), %xmm0
               	movups	-0x70(%rbp), %xmm1
               	pxor	%xmm1, %xmm0
               	leaq	-0x60(%rbp), %r9
               	movups	%xmm0, -0x60(%rbp)
               	leaq	-0x30(%rbp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movabsq	$0x8f806fa04fc02fe, %rax # imm = 0x8F806FA04FC02FE
               	movq	%rax, -0x38(%rbp)
               	movzbq	-0x38(%rbp), %rax
               	cmpl	$0xfe, %eax
               	jne	<addr>
               	movzbq	-0x37(%rbp), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movzbq	-0x31(%rbp), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x70(%rbp), %rdx
               	movb	$0x1, -0x50(%rbp)
               	movb	$-0x38, -0x70(%rbp)
               	movb	$0x8, -0x4f(%rbp)
               	movb	$-0x39, -0x6f(%rbp)
               	movb	$0xf, -0x4e(%rbp)
               	movb	$-0x3a, -0x6e(%rbp)
               	movb	$0x16, -0x4d(%rbp)
               	movb	$-0x3b, -0x6d(%rbp)
               	movb	$0x1d, -0x4c(%rbp)
               	movb	$-0x3c, -0x6c(%rbp)
               	movb	$0x24, -0x4b(%rbp)
               	movb	$-0x3d, -0x6b(%rbp)
               	movb	$0x2b, -0x4a(%rbp)
               	movb	$-0x3e, -0x6a(%rbp)
               	movb	$0x32, -0x49(%rbp)
               	movb	$-0x3f, -0x69(%rbp)
               	movb	$0x39, -0x48(%rbp)
               	movb	$-0x40, -0x68(%rbp)
               	movb	$0x40, -0x47(%rbp)
               	movb	$-0x41, -0x67(%rbp)
               	movb	$0x47, -0x46(%rbp)
               	movb	$-0x42, -0x66(%rbp)
               	movb	$0x4e, -0x45(%rbp)
               	movb	$-0x43, -0x65(%rbp)
               	movb	$0x55, -0x44(%rbp)
               	movb	$-0x44, -0x64(%rbp)
               	movb	$0x5c, -0x43(%rbp)
               	movb	$-0x45, -0x63(%rbp)
               	movb	$0x63, -0x42(%rbp)
               	movb	$-0x46, -0x62(%rbp)
               	movb	$0x6a, -0x41(%rbp)
               	movb	$-0x47, -0x61(%rbp)
               	leaq	-0x60(%rbp), %rsi
               	movups	-0x50(%rbp), %xmm0
               	movups	-0x70(%rbp), %xmm1
               	pxor	%xmm1, %xmm0
               	movups	%xmm0, -0x60(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rsi,%rax), %rdi
               	movzbq	(%rcx,%rax), %r8
               	movzbq	(%rdx,%rax), %r9
               	xorq	%r9, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0xa, %eax
               	leave
               	retq
