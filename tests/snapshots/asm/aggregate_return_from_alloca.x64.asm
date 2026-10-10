
aggregate_return_from_alloca.x64:	file format elf64-x86-64

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

<touch>:
               	leaq	<rip>, %rax      # <addr>
               	movq	%rdi, (%rax)
               	retq

<fl>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	movq	%r12, %rax
               	shlq	$0x4, %rax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rbx
               	subq	%r11, %rbx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rbx, %rsp
               	leaq	(%r12,%r12,2), %r13
               	xorl	%eax, %eax
               	cmpq	%r12, %rax
               	jge	<addr>
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rbx, %rcx
               	leaq	(%rax,%r13), %rdx
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rdx, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rcx)
               	incq	%rax
               	cmpq	%r12, %rax
               	jl	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	(%r13,%r12), %rax
               	fldt	(%rbx)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rbx)
               	movq	%rbx, %rcx
               	fldt	(%rcx)
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<ff>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	movq	%r12, %rax
               	shlq	$0x3, %rax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rbx
               	subq	%r11, %rbx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rbx, %rsp
               	leaq	(%r12,%r12,2), %r13
               	xorl	%eax, %eax
               	cmpq	%r12, %rax
               	jge	<addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rbx, %rcx
               	leaq	(%rax,%r13), %rdx
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rdx, %xmm0
               	incq	%rdx
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rdx, %xmm1
               	movss	%xmm0, (%rcx)
               	movss	%xmm1, 0x4(%rcx)
               	incq	%rax
               	cmpq	%r12, %rax
               	jl	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	(%r13,%r12), %rax
               	movss	(%rbx), %xmm1
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	addss	%xmm0, %xmm1
               	movss	%xmm1, (%rbx)
               	movss	0x4(%rbx), %xmm1
               	vaddss	%xmm0, %xmm1, %xmm0
               	movss	%xmm0, 0x4(%rbx)
               	movq	%rbx, %rcx
               	movsd	(%rcx), %xmm0
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<fu>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	movq	%r12, %rax
               	shlq	$0x3, %rax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rbx
               	subq	%r11, %rbx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rbx, %rsp
               	leaq	(%r12,%r12,2), %r13
               	xorl	%eax, %eax
               	cmpq	%r12, %rax
               	jge	<addr>
               	leaq	(%rax,%r13), %rcx
               	movq	%rcx, (%rbx,%rax,8)
               	incq	%rax
               	cmpq	%r12, %rax
               	jl	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	(%r13,%r12), %rax
               	movq	(%rbx), %rcx
               	addq	%rcx, %rax
               	movq	%rax, (%rbx)
               	movq	%rbx, %rcx
               	movq	(%rcx), %rax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<fi>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	movq	%r12, %rax
               	shlq	$0x3, %rax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rbx
               	subq	%r11, %rbx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rbx, %rsp
               	leaq	(%r12,%r12,2), %r13
               	xorl	%eax, %eax
               	cmpq	%r12, %rax
               	jge	<addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rbx, %rcx
               	leaq	(%rax,%r13), %rdx
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rdx, %xmm0
               	incq	%rdx
               	movss	%xmm0, (%rcx)
               	movl	%edx, 0x4(%rcx)
               	incq	%rax
               	cmpq	%r12, %rax
               	jl	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	(%r13,%r12), %rax
               	movss	(%rbx), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rax, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, (%rbx)
               	movl	0x4(%rbx), %ecx
               	addq	%rcx, %rax
               	movl	%eax, 0x4(%rbx)
               	movq	%rbx, %rcx
               	movq	(%rcx), %rax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<fm>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	movq	%r12, %rax
               	shlq	$0x4, %rax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rbx
               	subq	%r11, %rbx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rbx, %rsp
               	leaq	(%r12,%r12,2), %r13
               	xorl	%eax, %eax
               	cmpq	%r12, %rax
               	jge	<addr>
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rbx, %rcx
               	leaq	(%rax,%r13), %rdx
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rdx, %xmm0
               	addq	$0x2, %rdx
               	movsd	%xmm0, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	incq	%rax
               	cmpq	%r12, %rax
               	jl	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	(%r13,%r12), %rax
               	movsd	(%rbx), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rbx)
               	movsd	(%rbx), %xmm0
               	movq	0x8(%rbx), %rcx
               	addq	%rcx, %rax
               	movq	%rax, 0x8(%rbx)
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<fc>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r13
               	imulq	$0xc, %r13, %rax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rbx
               	subq	%r11, %rbx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rbx, %rsp
               	leaq	(%r13,%r13,2), %r12
               	xorl	%eax, %eax
               	cmpq	%r13, %rax
               	jge	<addr>
               	imulq	$0xc, %rax, %rcx
               	leaq	(%rbx,%rcx), %rdx
               	leaq	(%rax,%r12), %rsi
               	movb	%sil, (%rdx)
               	incq	%rsi
               	movb	%sil, 0x1(%rdx)
               	leaq	(%rbx,%rcx), %rdx
               	leaq	(%rax,%r12), %rcx
               	leaq	0x2(%rcx), %rsi
               	movb	%sil, 0x2(%rdx)
               	leaq	0x3(%rcx), %rsi
               	movb	%sil, 0x3(%rdx)
               	imulq	$0xc, %rax, %rdx
               	leaq	(%rbx,%rdx), %rsi
               	addq	$0x4, %rcx
               	movb	%cl, 0x4(%rsi)
               	leaq	(%rax,%r12), %rcx
               	leaq	0x5(%rcx), %rdi
               	movb	%dil, 0x5(%rsi)
               	addq	%rbx, %rdx
               	leaq	0x6(%rcx), %rsi
               	movb	%sil, 0x6(%rdx)
               	addq	$0x7, %rcx
               	movb	%cl, 0x7(%rdx)
               	imulq	$0xc, %rax, %rcx
               	leaq	(%rbx,%rcx), %rdx
               	leaq	(%rax,%r12), %rsi
               	leaq	0x8(%rsi), %rdi
               	movb	%dil, 0x8(%rdx)
               	addq	$0x9, %rsi
               	movb	%sil, 0x9(%rdx)
               	addq	%rbx, %rcx
               	leaq	(%rax,%r12), %rdx
               	leaq	0xa(%rdx), %rsi
               	movb	%sil, 0xa(%rcx)
               	addq	$0xb, %rdx
               	movb	%dl, 0xb(%rcx)
               	incq	%rax
               	cmpq	%r13, %rax
               	jl	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	(%r12,%r13), %rax
               	movsbq	(%rbx), %rcx
               	addq	%rax, %rcx
               	movb	%cl, (%rbx)
               	movsbq	0x1(%rbx), %rcx
               	addq	%rax, %rcx
               	movb	%cl, 0x1(%rbx)
               	movsbq	0x2(%rbx), %rcx
               	addq	%rax, %rcx
               	movb	%cl, 0x2(%rbx)
               	movsbq	0x3(%rbx), %rcx
               	addq	%rax, %rcx
               	movb	%cl, 0x3(%rbx)
               	movsbq	0x4(%rbx), %rcx
               	addq	%rax, %rcx
               	movb	%cl, 0x4(%rbx)
               	movsbq	0x5(%rbx), %rcx
               	addq	%rax, %rcx
               	movb	%cl, 0x5(%rbx)
               	movsbq	0x6(%rbx), %rcx
               	addq	%rax, %rcx
               	movb	%cl, 0x6(%rbx)
               	movsbq	0x7(%rbx), %rcx
               	addq	%rax, %rcx
               	movb	%cl, 0x7(%rbx)
               	movsbq	0x8(%rbx), %rcx
               	addq	%rax, %rcx
               	movb	%cl, 0x8(%rbx)
               	movsbq	0x9(%rbx), %rcx
               	addq	%rax, %rcx
               	movb	%cl, 0x9(%rbx)
               	movsbq	0xa(%rbx), %rcx
               	addq	%rax, %rcx
               	movb	%cl, 0xa(%rbx)
               	movsbq	0xb(%rbx), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0xb(%rbx)
               	movzbq	(%rbx), %rax
               	movzbq	0x1(%rbx), %rcx
               	shlq	$0x8, %rcx
               	orq	%rcx, %rax
               	movzbq	0x2(%rbx), %rcx
               	shlq	$0x10, %rcx
               	orq	%rcx, %rax
               	movzbq	0x3(%rbx), %rcx
               	shlq	$0x18, %rcx
               	orq	%rcx, %rax
               	movzbq	0x4(%rbx), %rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	movzbq	0x5(%rbx), %rcx
               	shlq	$0x28, %rcx
               	orq	%rcx, %rax
               	movzbq	0x6(%rbx), %rcx
               	shlq	$0x30, %rcx
               	orq	%rcx, %rax
               	movzbq	0x7(%rbx), %rcx
               	shlq	$0x38, %rcx
               	orq	%rcx, %rax
               	movzbq	0x8(%rbx), %rcx
               	movzbq	0x9(%rbx), %rdx
               	shlq	$0x8, %rdx
               	orq	%rdx, %rcx
               	movzbq	0xa(%rbx), %rdx
               	shlq	$0x10, %rdx
               	orq	%rdx, %rcx
               	movzbq	0xb(%rbx), %rdx
               	shlq	$0x18, %rdx
               	orq	%rdx, %rcx
               	movq	%rcx, %rdx
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x98, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %r12
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	movq	%r12, %r13
               	imulq	%rcx, %r13
               	movq	0x8(%rax), %rcx
               	movq	%r12, %r14
               	imulq	%rcx, %r14
               	movq	0x10(%rax), %rcx
               	movq	%r12, %r15
               	imulq	%rcx, %r15
               	movq	0x18(%rax), %rax
               	movq	%r12, %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x88(%rsp)
               	imulq	$0x7, %r12, %rbx
               	movq	%r12, %rdi
               	callq	<addr>
               	fstpt	-0x80(%rbp)
               	leaq	-0x80(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	fldt	-0x90(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rbx, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%r12, %rdi
               	callq	<addr>
               	movsd	%xmm0, -0x30(%rbp)
               	movss	-0x30(%rbp), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rbx, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x2c(%rbp), %xmm0
               	leaq	0x1(%rbx), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rax, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	movss	-0x28(%rbp), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rbx, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	-0x24(%rbp), %eax
               	leaq	0x1(%rbx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%r12, %rdi
               	callq	<addr>
               	movsd	%xmm0, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	-0x20(%rbp), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rbx, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	-0x18(%rbp), %rax
               	leaq	0x2(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movl	%edx, 0x8(%rax)
               	movzbq	-0x10(%rbp), %rax
               	movzbq	-0xf(%rbp), %rcx
               	movzbq	-0xe(%rbp), %rdx
               	movzbq	-0xd(%rbp), %rsi
               	movzbq	-0xc(%rbp), %rdi
               	movzbq	-0xb(%rbp), %r8
               	movzbq	-0xa(%rbp), %r9
               	movzbq	-0x9(%rbp), %r10
               	movq	%r10, 0x80(%rsp)
               	movzbq	-0x8(%rbp), %r10
               	movq	%r10, 0x78(%rsp)
               	movzbq	-0x7(%rbp), %r10
               	movq	%r10, 0x70(%rsp)
               	movzbq	-0x6(%rbp), %r10
               	movq	%r10, 0x68(%rsp)
               	movzbq	-0x5(%rbp), %r10
               	movq	%r10, 0x60(%rsp)
               	movsbq	%al, %rax
               	movsbq	%bl, %r10
               	movq	%r10, 0x58(%rsp)
               	cmpl	0x58(%rsp), %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movsbq	%cl, %rax
               	leaq	0x1(%rbx), %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movsbq	%dl, %rax
               	leaq	0x2(%rbx), %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movsbq	%sil, %rax
               	leaq	0x3(%rbx), %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movsbq	%dil, %rax
               	leaq	0x4(%rbx), %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movsbq	%r8b, %rax
               	leaq	0x5(%rbx), %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movsbq	%r9b, %rax
               	leaq	0x6(%rbx), %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movq	0x80(%rsp), %rax
               	movsbq	%al, %rax
               	leaq	0x7(%rbx), %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movq	0x78(%rsp), %rax
               	movsbq	%al, %rax
               	leaq	0x8(%rbx), %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movq	0x70(%rsp), %rax
               	movsbq	%al, %rax
               	leaq	0x9(%rbx), %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movq	0x68(%rsp), %rax
               	movsbq	%al, %rax
               	leaq	0xa(%rbx), %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movq	0x60(%rsp), %rax
               	movsbq	%al, %rax
               	leaq	0xb(%rbx), %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	imulq	%r12, %rcx
               	cmpq	%rcx, %r13
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	imulq	%r12, %rcx
               	cmpq	%rcx, %r14
               	jne	<addr>
               	movq	0x10(%rax), %rax
               	imulq	%r12, %rax
               	cmpq	%rax, %r15
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	0x18(%rax), %rax
               	imulq	%r12, %rax
               	movq	%rax, %r10
               	movq	0x88(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
