
aggregate_return_from_alloca.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	movq	%rdi, <rip> # <addr>
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
               	vaddss	0x4(%rbx), %xmm0, %xmm0
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
               	movq	%rdi, %rbx
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r12
               	subq	%r11, %r12
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%r12, %rsp
               	leaq	(%rbx,%rbx,2), %r13
               	xorl	%eax, %eax
               	cmpq	%rbx, %rax
               	jge	<addr>
               	leaq	(%rax,%r13), %rcx
               	movq	%rcx, (%r12,%rax,8)
               	incq	%rax
               	cmpq	%rbx, %rax
               	jl	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	(%r13,%rbx), %rax
               	movq	(%r12), %rcx
               	addq	%rcx, %rax
               	movq	%rax, (%r12)
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
               	nop
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
               	addl	%eax, 0x4(%rbx)
               	movq	(%rbx), %rax
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
               	leaq	(%rax,%r12), %rdx
               	movb	%dl, (%rbx,%rcx)
               	leaq	(%rbx,%rcx), %rsi
               	leaq	0x1(%rdx), %rdi
               	movb	%dil, 0x1(%rsi)
               	addq	$0x2, %rdx
               	movb	%dl, 0x2(%rsi)
               	leaq	(%rbx,%rcx), %rdx
               	leaq	(%rax,%r12), %rcx
               	leaq	0x3(%rcx), %rsi
               	movb	%sil, 0x3(%rdx)
               	imulq	$0xc, %rax, %rdx
               	leaq	(%rbx,%rdx), %rsi
               	leaq	0x4(%rcx), %rdi
               	movb	%dil, 0x4(%rsi)
               	addq	$0x5, %rcx
               	movb	%cl, 0x5(%rsi)
               	addq	%rbx, %rdx
               	leaq	(%rax,%r12), %rcx
               	leaq	0x6(%rcx), %rsi
               	movb	%sil, 0x6(%rdx)
               	imulq	$0xc, %rax, %rdx
               	leaq	(%rbx,%rdx), %rsi
               	leaq	0x7(%rcx), %rdi
               	movb	%dil, 0x7(%rsi)
               	addq	$0x8, %rcx
               	movb	%cl, 0x8(%rsi)
               	addq	%rbx, %rdx
               	leaq	(%rax,%r12), %rcx
               	leaq	0x9(%rcx), %rsi
               	movb	%sil, 0x9(%rdx)
               	imulq	$0xc, %rax, %rdx
               	addq	%rbx, %rdx
               	leaq	0xa(%rcx), %rsi
               	movb	%sil, 0xa(%rdx)
               	addq	$0xb, %rcx
               	movb	%cl, 0xb(%rdx)
               	incq	%rax
               	cmpq	%r13, %rax
               	jl	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	(%r12,%r13), %rax
               	addb	%al, (%rbx)
               	addb	%al, 0x1(%rbx)
               	addb	%al, 0x2(%rbx)
               	addb	%al, 0x3(%rbx)
               	addb	%al, 0x4(%rbx)
               	addb	%al, 0x5(%rbx)
               	addb	%al, 0x6(%rbx)
               	addb	%al, 0x7(%rbx)
               	addb	%al, 0x8(%rbx)
               	addb	%al, 0x9(%rbx)
               	addb	%al, 0xa(%rbx)
               	addb	%al, 0xb(%rbx)
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
               	subq	$0x98, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	<rip>, %rbx # <addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x78(%rsp)
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x60(%rsp)
               	imulq	$0x7, %rbx, %r12
               	movq	%rbx, %rdi
               	callq	<addr>
               	fstpt	0x20(%rsp)
               	leaq	0x20(%rsp), %rax
               	leaq	0x10(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	fldt	0x10(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%r12, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x98, %rsp
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	%xmm0, 0x98(%rsp)
               	movss	0x98(%rsp), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%r12, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x9c(%rsp), %xmm0
               	leaq	0x1(%r12), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rax, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x98, %rsp
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, 0x98(%rsp)
               	cmpq	%r12, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x98, %rsp
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, 0x98(%rsp)
               	leaq	0x88(%rsp), %rcx
               	movq	%rax, (%rcx)
               	movss	0x88(%rsp), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%r12, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	0x8c(%rsp), %eax
               	leaq	0x1(%r12), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x98, %rsp
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	%xmm0, 0x90(%rsp)
               	movq	%rax, 0x98(%rsp)
               	leaq	0x90(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x80(%rsp), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%r12, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	0x88(%rsp), %rax
               	leaq	0x2(%r12), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x98, %rsp
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, 0x90(%rsp)
               	movl	%edx, 0x98(%rsp)
               	movzbq	0x90(%rsp), %rax
               	movzbq	0x91(%rsp), %rcx
               	movzbq	0x92(%rsp), %rdx
               	movzbq	0x93(%rsp), %rsi
               	movzbq	0x94(%rsp), %rdi
               	movzbq	0x95(%rsp), %r8
               	movzbq	0x96(%rsp), %r9
               	movzbq	0x97(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movzbq	0x98(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movzbq	0x99(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movzbq	0x9a(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movzbq	0x9b(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movsbq	%al, %rax
               	movsbq	%r12b, %r10
               	movq	%r10, 0x30(%rsp)
               	cmpl	0x30(%rsp), %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x98, %rsp
               	retq
               	movsbq	%cl, %rax
               	leaq	0x1(%r12), %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movsbq	%dl, %rax
               	leaq	0x2(%r12), %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movsbq	%sil, %rax
               	leaq	0x3(%r12), %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movsbq	%dil, %rax
               	leaq	0x4(%r12), %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movsbq	%r8b, %rax
               	leaq	0x5(%r12), %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movsbq	%r9b, %rax
               	leaq	0x6(%r12), %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movq	0x58(%rsp), %rax
               	movsbq	%al, %rax
               	leaq	0x7(%r12), %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movq	0x50(%rsp), %rax
               	movsbq	%al, %rax
               	leaq	0x8(%r12), %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movq	0x48(%rsp), %rax
               	movsbq	%al, %rax
               	leaq	0x9(%r12), %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movq	0x40(%rsp), %rax
               	movsbq	%al, %rax
               	leaq	0xa(%r12), %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movq	0x38(%rsp), %rax
               	movsbq	%al, %rax
               	leaq	0xb(%r12), %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	imulq	%rbx, %rax
               	movq	%rax, %r10
               	movq	0x78(%rsp), %rax
               	cmpq	%r10, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	imulq	%rbx, %rax
               	movq	%rax, %r10
               	movq	0x70(%rsp), %rax
               	cmpq	%r10, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	imulq	%rbx, %rax
               	movq	%rax, %r10
               	movq	0x68(%rsp), %rax
               	cmpq	%r10, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	imulq	%rbx, %rax
               	movq	%rax, %r10
               	movq	0x60(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x98, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x98, %rsp
               	retq
