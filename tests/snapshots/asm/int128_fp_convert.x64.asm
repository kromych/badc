
int128_fp_convert.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<mk>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x10(%rbp), %rax
               	movq	%rdi, (%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x20(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdi, 0x8(%rax)
               	movq	%rcx, %rdx
               	orq	%rsi, %rdx
               	orq	%rdi, %rcx
               	leaq	-0x30(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<dbits>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movsd	%xmm0, (%rax,%riz)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<fbits>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<chk_to_fp>:
               	popq	%r10
               	subq	$0x70, %rsp
               	movq	0x70(%rsp), %rax
               	movq	%rax, 0x60(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movq	%rdx, %r14
               	movq	%r9, 0x40(%rsp)
               	movq	%r8, 0x48(%rsp)
               	movq	%rcx, %r15
               	leaq	<rip>, %rbx
               	movq	%rdi, (%rbx)
               	leaq	<rip>, %r12
               	movq	%rsi, (%r12)
               	movq	(%rbx), %rdi
               	movq	(%r12), %rsi
               	callq	<addr>
               	movq	%rax, -0x38(%rbp)
               	movq	%rdx, -0x30(%rbp)
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	xorq	%rdx, %rdx
               	testq	%rax, %rax
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x5, %rcx
               	leaq	0x1(%rcx), %r9
               	movq	%rcx, %r10
               	movq	%rax, %rcx
               	movq	%rcx, %r11
               	movq	%r10, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x10, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %r9
               	movq	%rcx, %r11
               	movq	%rsi, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x8, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %r9
               	movq	%rcx, %r11
               	movq	%rsi, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x4, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %r9
               	movq	%rcx, %r11
               	movq	%rsi, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x2, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	%rsi
               	addq	%rsi, %r9
               	movq	%rcx, %r11
               	movq	%rsi, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movq	%rcx, %rsi
               	shrq	%rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	addq	%rsi, %r9
               	movq	%r9, %rcx
               	imulq	%rdi, %rcx
               	movl	$0x40, %esi
               	subq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	movabsq	$-0x1, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	testq	%rcx, %rcx
               	setne	%dil
               	movzbq	%dil, %rdi
               	imulq	%rdi, %rsi
               	andq	%r8, %rsi
               	testq	%rsi, %rsi
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rcx, %rdi
               	andq	$0x7f, %rdi
               	movq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %r9d
               	movq	%r9, %r10
               	subq	%rsi, %r10
               	movq	%r10, 0x30(%rsp)
               	shrq	$0x6, %rdi
               	movq	%rdi, %r10
               	movq	%rdx, %rdi
               	subq	%r10, %rdi
               	movq	%rdi, %r9
               	xorq	$-0x1, %r9
               	movq	%rax, %r13
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %r13
               	popq	%rcx
               	movq	0x30(%rsp), %r10
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rax
               	popq	%rcx
               	shlq	%rax
               	movq	%rsi, %r10
               	movq	%r8, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	orq	%rsi, %rax
               	andq	%r9, %rax
               	movq	%r13, %rsi
               	andq	%rdi, %rsi
               	orq	%rsi, %rax
               	orq	0x38(%rsp), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	leaq	0x3ff(%rcx), %rax
               	shlq	$0x34, %rax
               	movq	%rax, %rcx
               	orq	%rdx, %rcx
               	leaq	-0x40(%rbp), %rax
               	movq	%rcx, (%rax)
               	movsd	(%rax,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	callq	<addr>
               	cmpq	%r14, %rax
               	je	<addr>
               	movslq	0x70(%rbp), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xe0, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x70, %rsp
               	pushq	%r11
               	retq
               	movq	(%rbx), %rdi
               	movq	(%r12), %rsi
               	callq	<addr>
               	movq	%rax, -0x50(%rbp)
               	movq	%rdx, -0x48(%rbp)
               	leaq	-0x50(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	xorq	%rdx, %rdx
               	testq	%rax, %rax
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x5, %rcx
               	leaq	0x1(%rcx), %r9
               	movq	%rcx, %r10
               	movq	%rax, %rcx
               	movq	%rcx, %r11
               	movq	%r10, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x10, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %r9
               	movq	%rcx, %r11
               	movq	%rsi, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x8, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %r9
               	movq	%rcx, %r11
               	movq	%rsi, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x4, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %r9
               	movq	%rcx, %r11
               	movq	%rsi, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x2, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	%rsi
               	addq	%rsi, %r9
               	movq	%rcx, %r11
               	movq	%rsi, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movq	%rcx, %rsi
               	shrq	%rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	addq	%rsi, %r9
               	movq	%r9, %rcx
               	imulq	%rdi, %rcx
               	movl	$0x40, %esi
               	subq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	movabsq	$-0x1, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	testq	%rcx, %rcx
               	setne	%dil
               	movzbq	%dil, %rdi
               	imulq	%rdi, %rsi
               	andq	%r8, %rsi
               	testq	%rsi, %rsi
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%rcx, %rdi
               	andq	$0x7f, %rdi
               	movq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %r9d
               	movq	%r9, %r10
               	subq	%rsi, %r10
               	movq	%r10, 0x38(%rsp)
               	shrq	$0x6, %rdi
               	movq	%rdi, %r10
               	movq	%rdx, %rdi
               	subq	%r10, %rdi
               	movq	%rdi, %r9
               	xorq	$-0x1, %r9
               	movq	%rax, %r13
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %r13
               	popq	%rcx
               	movq	0x38(%rsp), %r10
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rax
               	popq	%rcx
               	shlq	%rax
               	movq	%rsi, %r10
               	movq	%r8, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	orq	%rsi, %rax
               	andq	%r9, %rax
               	movq	%r13, %rsi
               	andq	%rdi, %rsi
               	orq	%rsi, %rax
               	orq	%r14, %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	leaq	0x3ff(%rcx), %rax
               	shlq	$0x34, %rax
               	movq	%rax, %rcx
               	orq	%rdx, %rcx
               	leaq	-0x58(%rbp), %rax
               	movq	%rcx, (%rax)
               	movsd	(%rax,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	callq	<addr>
               	movl	%r15d, %ecx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movslq	0x70(%rbp), %rax
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xe0, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x70, %rsp
               	pushq	%r11
               	retq
               	movq	(%rbx), %rdi
               	movq	(%r12), %rsi
               	callq	<addr>
               	movq	%rax, -0x68(%rbp)
               	movq	%rdx, -0x60(%rbp)
               	leaq	-0x68(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rcx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	xorq	%rax, %rdx
               	xorq	%rax, %rcx
               	cmpq	%rax, %rdx
               	setb	%sil
               	movzbq	%sil, %rsi
               	movq	%rdx, %rdi
               	subq	%rax, %rdi
               	subq	%rax, %rcx
               	subq	%rsi, %rcx
               	movabsq	$-0x8000000000000000, %r14 # imm = 0x8000000000000000
               	andq	%rax, %r14
               	testq	%rcx, %rcx
               	setne	%sil
               	movzbq	%sil, %rsi
               	movq	%rcx, %rax
               	shrq	$0x20, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x5, %rax
               	leaq	0x1(%rax), %r8
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rax
               	popq	%rcx
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %r8
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rax
               	popq	%rcx
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rax
               	popq	%rcx
               	movq	%rax, %rdx
               	shrq	$0x4, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rax
               	popq	%rcx
               	movq	%rax, %rdx
               	shrq	$0x2, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	addq	%rdx, %r8
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rax
               	popq	%rcx
               	movq	%rax, %rdx
               	shrq	%rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	addq	%rdx, %r8
               	movq	%r8, %rax
               	imulq	%rsi, %rax
               	movl	$0x40, %edx
               	subq	%rax, %rdx
               	andq	$0x3f, %rdx
               	movabsq	$-0x1, %rsi
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	testq	%rax, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	andq	%rdi, %rdx
               	testq	%rdx, %rdx
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movq	%rax, %rsi
               	andq	$0x7f, %rsi
               	movq	%rax, %rdx
               	andq	$0x3f, %rdx
               	movl	$0x3f, %r8d
               	movq	%r8, %r10
               	subq	%rdx, %r10
               	movq	%r10, 0x38(%rsp)
               	shrq	$0x6, %rsi
               	xorq	%r8, %r8
               	movq	%rsi, %r10
               	movq	%r8, %rsi
               	subq	%r10, %rsi
               	movq	%rsi, %r9
               	xorq	$-0x1, %r9
               	movq	%rcx, %r13
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %r13
               	popq	%rcx
               	movq	0x38(%rsp), %r10
               	movq	%rcx, %r11
               	movq	%r10, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	shlq	%rcx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	orq	%rdx, %rcx
               	andq	%r9, %rcx
               	movq	%r13, %rdx
               	andq	%rsi, %rdx
               	orq	%rdx, %rcx
               	orq	%r15, %rcx
               	xorps	%xmm0, %xmm0
               	movq	%rcx, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	addq	$0x3ff, %rax            # imm = 0x3FF
               	shlq	$0x34, %rax
               	movq	%rax, %rcx
               	orq	%r14, %rcx
               	leaq	-0x70(%rbp), %rax
               	movq	%rcx, (%rax)
               	movsd	(%rax,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	callq	<addr>
               	cmpq	0x48(%rsp), %rax
               	je	<addr>
               	movslq	0x70(%rbp), %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xe0, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x70, %rsp
               	pushq	%r11
               	retq
               	movq	(%rbx), %rdi
               	movq	(%r12), %rsi
               	callq	<addr>
               	movq	%rax, -0x80(%rbp)
               	movq	%rdx, -0x78(%rbp)
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rcx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	xorq	%rax, %rdx
               	xorq	%rax, %rcx
               	cmpq	%rax, %rdx
               	setb	%sil
               	movzbq	%sil, %rsi
               	movq	%rdx, %rdi
               	subq	%rax, %rdi
               	subq	%rax, %rcx
               	subq	%rsi, %rcx
               	movabsq	$-0x8000000000000000, %r12 # imm = 0x8000000000000000
               	andq	%rax, %r12
               	testq	%rcx, %rcx
               	setne	%sil
               	movzbq	%sil, %rsi
               	movq	%rcx, %rax
               	shrq	$0x20, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x5, %rax
               	leaq	0x1(%rax), %r8
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rax
               	popq	%rcx
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %r8
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rax
               	popq	%rcx
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rax
               	popq	%rcx
               	movq	%rax, %rdx
               	shrq	$0x4, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rax
               	popq	%rcx
               	movq	%rax, %rdx
               	shrq	$0x2, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	addq	%rdx, %r8
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rax
               	popq	%rcx
               	movq	%rax, %rdx
               	shrq	%rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	addq	%rdx, %r8
               	movq	%r8, %rax
               	imulq	%rsi, %rax
               	movl	$0x40, %edx
               	subq	%rax, %rdx
               	andq	$0x3f, %rdx
               	movabsq	$-0x1, %rsi
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	testq	%rax, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	andq	%rdi, %rdx
               	testq	%rdx, %rdx
               	setne	%r13b
               	movzbq	%r13b, %r13
               	movq	%rax, %rsi
               	andq	$0x7f, %rsi
               	movq	%rax, %rdx
               	andq	$0x3f, %rdx
               	movl	$0x3f, %r8d
               	movq	%r8, %r14
               	subq	%rdx, %r14
               	shrq	$0x6, %rsi
               	xorq	%r8, %r8
               	movq	%rsi, %r10
               	movq	%r8, %rsi
               	subq	%r10, %rsi
               	movq	%rsi, %r9
               	xorq	$-0x1, %r9
               	movq	%rcx, %rbx
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rbx
               	popq	%rcx
               	movq	%rcx, %r11
               	movq	%r14, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	shlq	%rcx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	orq	%rdx, %rcx
               	andq	%r9, %rcx
               	movq	%rbx, %rdx
               	andq	%rsi, %rdx
               	orq	%rdx, %rcx
               	orq	%r13, %rcx
               	xorps	%xmm0, %xmm0
               	movq	%rcx, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	addq	$0x3ff, %rax            # imm = 0x3FF
               	shlq	$0x34, %rax
               	movq	%rax, %rcx
               	orq	%r12, %rcx
               	leaq	-0x88(%rbp), %rax
               	movq	%rcx, (%rax)
               	movsd	(%rax,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	callq	<addr>
               	movq	0x40(%rsp), %rcx
               	movl	%ecx, %ecx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movslq	0x70(%rbp), %rax
               	addq	$0x3, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xe0, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x70, %rsp
               	pushq	%r11
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xe0, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x70, %rsp
               	pushq	%r11
               	retq

<chk_from_fp>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movq	%rdi, %r13
               	movq	%rdx, %rbx
               	movq	%rsi, %r14
               	leaq	<rip>, %r9
               	movsd	%xmm0, (%r9,%riz)
               	leaq	-0x10(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movsd	(%r9,%riz), %xmm0
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0x38(%rbp), %rax
               	movsd	%xmm0, (%rax,%riz)
               	movq	(%rax), %rax
               	movq	%rax, %r10
               	sarq	$0x3f, %r10
               	movq	%r10, 0x48(%rsp)
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rax, %rcx
               	shrq	$0x34, %rcx
               	leaq	-0x3ff(%rcx), %r15
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x10000000000000, %r12 # imm = 0x10000000000000
               	orq	%rax, %r12
               	leaq	-0x433(%rcx), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	xorq	%rax, %rax
               	movq	%rdx, %rdi
               	andq	$0x7f, %rdi
               	andq	$0x3f, %rdx
               	movl	$0x3f, %r8d
               	movq	%r8, %r10
               	subq	%rdx, %r10
               	movq	%r10, 0x68(%rsp)
               	shrq	$0x6, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movq	%rdi, %r8
               	xorq	$-0x1, %r8
               	movq	%r12, %r10
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shlq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x60(%rsp)
               	movq	0x68(%rsp), %r11
               	movq	%r12, %r10
               	pushq	%rcx
               	movq	%r11, %rcx
               	shrq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	shrq	%r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rax, %r10
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shlq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	orq	0x58(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x60(%rsp), %r10
               	andq	%r8, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x38(%rsp), %r10
               	orq	0x58(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rsp), %r10
               	andq	%r8, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x60(%rsp), %r10
               	andq	%rdi, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x40(%rsp), %r10
               	orq	0x60(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%rax, %r10
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x60(%rsp)
               	movq	0x68(%rsp), %r11
               	movq	%rax, %r10
               	pushq	%rcx
               	movq	%r11, %rcx
               	shlq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x68(%rsp)
               	movq	0x68(%rsp), %r10
               	shlq	%r10
               	movq	%r10, 0x68(%rsp)
               	movq	%rdx, %r10
               	movq	%r12, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	orq	0x68(%rsp), %rdx
               	andq	%r8, %rdx
               	movq	%rdi, %r10
               	movq	0x60(%rsp), %rdi
               	andq	%r10, %rdi
               	orq	%rdx, %rdi
               	movq	0x60(%rsp), %rdx
               	andq	%r8, %rdx
               	movq	%rdx, %r8
               	orq	0x58(%rsp), %r8
               	movq	%rcx, %rdx
               	xorq	$-0x1, %rdx
               	movq	0x38(%rsp), %r12
               	andq	%rdx, %r12
               	andq	%rcx, %rdi
               	orq	%r12, %rdi
               	movq	%rdx, %r10
               	movq	0x40(%rsp), %rdx
               	andq	%r10, %rdx
               	andq	%r8, %rcx
               	orq	%rcx, %rdx
               	movq	%r15, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rdi
               	movq	%rdx, %r8
               	andq	%rcx, %r8
               	cmpq	$0x80, %r15
               	setge	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r10
               	movq	%rax, %rcx
               	subq	%r10, %rcx
               	movq	%rcx, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdx, %rdi
               	andq	$-0x1, %rcx
               	orq	%rcx, %rdi
               	andq	%r8, %rdx
               	orq	%rcx, %rdx
               	movq	0x48(%rsp), %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rdi
               	andq	%rdx, %rcx
               	movq	%rdi, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movq	0x50(%rsp), %r10
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%r10)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%r10)
               	popq	%rax
               	movq	%r10, %rcx
               	leaq	-0x10(%rbp), %rcx
               	movq	0x8(%rcx), %rdx
               	leaq	-0x50(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	cmpq	%r13, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	%r14, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%ebx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movsd	(%r9,%riz), %xmm0
               	leaq	-0x60(%rbp), %rdi
               	leaq	-0x68(%rbp), %rax
               	movsd	%xmm0, (%rax,%riz)
               	movq	(%rax), %rcx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rdx
               	shrq	$0x34, %rdx
               	leaq	-0x3ff(%rdx), %r15
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x10000000000000, %r12 # imm = 0x10000000000000
               	orq	%rcx, %r12
               	leaq	-0x433(%rdx), %rcx
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	xorq	%rdx, %rcx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	xorq	%rcx, %rcx
               	movq	%rsi, %r8
               	andq	$0x7f, %r8
               	andq	$0x3f, %rsi
               	movl	$0x3f, %r9d
               	movq	%r9, %r10
               	subq	%rsi, %r10
               	movq	%r10, 0x68(%rsp)
               	shrq	$0x6, %r8
               	movq	%r8, %r10
               	movq	%rcx, %r8
               	subq	%r10, %r8
               	movq	%r8, %r9
               	xorq	$-0x1, %r9
               	movq	%r12, %r10
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x60(%rsp)
               	movq	0x68(%rsp), %r11
               	movq	%r12, %r10
               	pushq	%rcx
               	movq	%r11, %rcx
               	shrq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	shrq	%r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rcx, %r10
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	orq	0x58(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rsp), %r10
               	andq	%r9, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%rcx, %r10
               	andq	%r8, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x40(%rsp), %r10
               	orq	0x58(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x48(%rsp), %r10
               	andq	%r9, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rsp), %r10
               	andq	%r8, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x48(%rsp), %r10
               	orq	0x60(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%rcx, %r10
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x60(%rsp)
               	movq	0x68(%rsp), %r11
               	movq	%rcx, %r10
               	pushq	%rcx
               	movq	%r11, %rcx
               	shlq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x68(%rsp)
               	movq	0x68(%rsp), %r10
               	shlq	%r10
               	movq	%r10, 0x68(%rsp)
               	movq	%rsi, %r10
               	movq	%r12, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	orq	0x68(%rsp), %rsi
               	andq	%r9, %rsi
               	movq	%r8, %r10
               	movq	0x60(%rsp), %r8
               	andq	%r10, %r8
               	orq	%rsi, %r8
               	movq	0x60(%rsp), %rsi
               	andq	%r9, %rsi
               	movq	%rsi, %r9
               	orq	0x58(%rsp), %r9
               	movq	%rdx, %rsi
               	xorq	$-0x1, %rsi
               	movq	0x40(%rsp), %r12
               	andq	%rsi, %r12
               	andq	%rdx, %r8
               	orq	%r12, %r8
               	movq	%rsi, %r10
               	movq	0x48(%rsp), %rsi
               	andq	%r10, %rsi
               	andq	%r9, %rdx
               	orq	%rdx, %rsi
               	movq	%r15, %rdx
               	sarq	$0x3f, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdx, %r8
               	movq	%rsi, %r9
               	andq	%rdx, %r9
               	cmpq	$0x80, %r15
               	setge	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rcx, %rdx
               	subq	%r10, %rdx
               	movq	%r8, %rsi
               	xorq	%rax, %rsi
               	movq	%r9, %r8
               	xorq	%rax, %r8
               	cmpq	%rax, %rsi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	subq	%rax, %rsi
               	subq	%rax, %r8
               	subq	%r9, %r8
               	movq	%rax, %r9
               	xorq	$-0x1, %r9
               	movabsq	$0x7fffffffffffffff, %r12 # imm = 0x7FFFFFFFFFFFFFFF
               	xorq	%rax, %r12
               	movq	%rdx, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %rsi
               	andq	%rdx, %r9
               	orq	%r9, %rsi
               	andq	%r8, %rax
               	andq	%r12, %rdx
               	orq	%rdx, %rax
               	movq	%rsi, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movq	0x50(%rsp), %r10
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%r10)
               	movq	0x8(%rdi), %rax
               	movq	%rax, 0x8(%r10)
               	popq	%rax
               	movq	%r10, %rax
               	leaq	-0x20(%rbp), %rax
               	movq	0x8(%rax), %rdx
               	leaq	-0x80(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	cmpq	%r13, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	%r14, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	0x1(%rbx), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>

<chk_from_fp_neg>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movq	%rdi, 0x50(%rsp)
               	movq	%rdx, %r12
               	movq	%rsi, 0x48(%rsp)
               	leaq	<rip>, %rax
               	movsd	%xmm0, (%rax,%riz)
               	leaq	-0x10(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movsd	(%rax,%riz), %xmm0
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x28(%rbp), %rax
               	movsd	%xmm0, (%rax,%riz)
               	movq	(%rax), %rcx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rdx
               	shrq	$0x34, %rdx
               	leaq	-0x3ff(%rdx), %r13
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x10000000000000, %rbx # imm = 0x10000000000000
               	orq	%rcx, %rbx
               	leaq	-0x433(%rdx), %rcx
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	xorq	%rdx, %rcx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	xorq	%rcx, %rcx
               	movq	%rsi, %r8
               	andq	$0x7f, %r8
               	andq	$0x3f, %rsi
               	movl	$0x3f, %r9d
               	movq	%r9, %r14
               	subq	%rsi, %r14
               	shrq	$0x6, %r8
               	movq	%r8, %r10
               	movq	%rcx, %r8
               	subq	%r10, %r8
               	movq	%r8, %r9
               	xorq	$-0x1, %r9
               	movq	%rbx, %r15
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %r15
               	popq	%rcx
               	movq	%rbx, %r10
               	pushq	%rcx
               	movq	%r14, %rcx
               	shrq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	shrq	%r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rcx, %r10
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	orq	0x58(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%r15, %r10
               	andq	%r9, %r10
               	movq	%r10, 0x30(%rsp)
               	movq	%rcx, %r10
               	andq	%r8, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x30(%rsp), %r10
               	orq	0x58(%rsp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x38(%rsp), %r10
               	andq	%r9, %r10
               	movq	%r10, 0x38(%rsp)
               	andq	%r8, %r15
               	movq	0x38(%rsp), %r10
               	orq	%r15, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rcx, %r15
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %r15
               	popq	%rcx
               	movq	%r14, %r10
               	movq	%rcx, %r14
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r14
               	popq	%rcx
               	shlq	%r14
               	movq	%rsi, %r10
               	movq	%rbx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	orq	%r14, %rsi
               	andq	%r9, %rsi
               	andq	%r15, %r8
               	orq	%rsi, %r8
               	movq	%r15, %rsi
               	andq	%r9, %rsi
               	movq	%rsi, %r9
               	orq	0x58(%rsp), %r9
               	movq	%rdx, %rsi
               	xorq	$-0x1, %rsi
               	movq	0x30(%rsp), %rbx
               	andq	%rsi, %rbx
               	andq	%rdx, %r8
               	orq	%rbx, %r8
               	movq	%rsi, %r10
               	movq	0x38(%rsp), %rsi
               	andq	%r10, %rsi
               	andq	%r9, %rdx
               	orq	%rdx, %rsi
               	movq	%r13, %rdx
               	sarq	$0x3f, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdx, %r8
               	movq	%rsi, %r9
               	andq	%rdx, %r9
               	cmpq	$0x80, %r13
               	setge	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rcx, %rdx
               	subq	%r10, %rdx
               	movq	%r8, %rsi
               	xorq	%rax, %rsi
               	movq	%r9, %r8
               	xorq	%rax, %r8
               	cmpq	%rax, %rsi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	subq	%rax, %rsi
               	subq	%rax, %r8
               	subq	%r9, %r8
               	movq	%rax, %r9
               	xorq	$-0x1, %r9
               	movabsq	$0x7fffffffffffffff, %rbx # imm = 0x7FFFFFFFFFFFFFFF
               	xorq	%rax, %rbx
               	movq	%rdx, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %rsi
               	andq	%rdx, %r9
               	orq	%r9, %rsi
               	andq	%r8, %rax
               	andq	%rbx, %rdx
               	orq	%rdx, %rax
               	movq	%rsi, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movq	0x40(%rsp), %r10
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%r10)
               	movq	0x8(%rdi), %rax
               	movq	%rax, 0x8(%r10)
               	popq	%rax
               	movq	%r10, %rax
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rdx
               	leaq	-0x40(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	cmpq	0x50(%rsp), %rdx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	0x48(%rsp), %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%r12d, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1d0, %rsp            # imm = 0x1D0
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	xorq	%rdi, %rdi
               	movl	$0x1, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdi, %rsi
               	movq	%rdi, %r9
               	movq	%rdi, %r8
               	movq	%rdi, %rcx
               	movq	%rdi, %rdx
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movl	$0x1, %esi
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movl	$0x3f800000, %ecx       # imm = 0x3F800000
               	movl	$0x5, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movl	$0x5, %esi
               	movabsq	$0x4014000000000000, %rdx # imm = 0x4014000000000000
               	movl	$0x40a00000, %ecx       # imm = 0x40A00000
               	movl	$0x9, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movabsq	$0x20000000000000, %rsi # imm = 0x20000000000000
               	movabsq	$0x4340000000000000, %rdx # imm = 0x4340000000000000
               	movl	$0x5a000000, %ecx       # imm = 0x5A000000
               	movl	$0xd, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movabsq	$0x20000000000001, %rsi # imm = 0x20000000000001
               	movabsq	$0x4340000000000000, %rdx # imm = 0x4340000000000000
               	movl	$0x5a000000, %ecx       # imm = 0x5A000000
               	movl	$0x11, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movabsq	$0x20000000000003, %rsi # imm = 0x20000000000003
               	movabsq	$0x4340000000000002, %rdx # imm = 0x4340000000000002
               	movl	$0x5a000000, %ecx       # imm = 0x5A000000
               	movl	$0x15, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movabsq	$-0x1, %rsi
               	movabsq	$0x43f0000000000000, %rdx # imm = 0x43F0000000000000
               	movl	$0x5f800000, %ecx       # imm = 0x5F800000
               	movl	$0x19, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	movabsq	$0x43e0000000000000, %rdx # imm = 0x43E0000000000000
               	movl	$0x5f000000, %ecx       # imm = 0x5F000000
               	movl	$0x1d, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	xorq	%rsi, %rsi
               	movabsq	$0x43f0000000000000, %rdx # imm = 0x43F0000000000000
               	movl	$0x5f800000, %ecx       # imm = 0x5F800000
               	movl	$0x21, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	movl	$0x5, %edi
               	xorq	%rsi, %rsi
               	movabsq	$0x4414000000000000, %rdx # imm = 0x4414000000000000
               	movl	$0x60a00000, %ecx       # imm = 0x60A00000
               	movl	$0x25, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	movabsq	$0x1000000000000, %rdi  # imm = 0x1000000000000
               	movl	$0x1, %esi
               	movabsq	$0x46f0000000000000, %rdx # imm = 0x46F0000000000000
               	movl	$0x77800000, %ecx       # imm = 0x77800000
               	movl	$0x29, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	movabsq	$0x1000000000001, %rdi  # imm = 0x1000000000001
               	movl	$0x1, %esi
               	movabsq	$0x46f0000000000010, %rdx # imm = 0x46F0000000000010
               	movl	$0x77800000, %ecx       # imm = 0x77800000
               	movl	$0x2d, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rdi
               	movabsq	$0x47f0000000000000, %rdx # imm = 0x47F0000000000000
               	movl	$0x7f800000, %ecx       # imm = 0x7F800000
               	movabsq	$-0x4010000000000000, %r8 # imm = 0xBFF0000000000000
               	movl	$0xbf800000, %r9d       # imm = 0xBF800000
               	movl	$0x31, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdi, %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	movabsq	$-0x8000000000000000, %rdi # imm = 0x8000000000000000
               	xorq	%rsi, %rsi
               	movabsq	$0x47e0000000000000, %rdx # imm = 0x47E0000000000000
               	movl	$0x7f000000, %ecx       # imm = 0x7F000000
               	movabsq	$-0x3820000000000000, %r8 # imm = 0xC7E0000000000000
               	movl	$0xff000000, %r9d       # imm = 0xFF000000
               	movl	$0x35, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	movabsq	$0x7fffffffffffffff, %rdi # imm = 0x7FFFFFFFFFFFFFFF
               	movabsq	$-0x1, %rsi
               	movabsq	$0x47e0000000000000, %rdx # imm = 0x47E0000000000000
               	movl	$0x7f000000, %ecx       # imm = 0x7F000000
               	movl	$0x39, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	movabsq	$0x11223344556677, %rdi # imm = 0x11223344556677
               	movabsq	$-0x7766554433221101, %rsi # imm = 0x8899AABBCCDDEEFF
               	movabsq	$0x4731223344556678, %rdx # imm = 0x4731223344556678
               	movl	$0x7989119a, %ecx       # imm = 0x7989119A
               	movl	$0x3d, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movl	$0x41, %ecx
               	movq	%rdi, %xmm0
               	movq	%rdi, %rsi
               	movq	%rcx, %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	movabsq	$0x400ffdf3b645a1cb, %rdi # imm = 0x400FFDF3B645A1CB
               	xorq	%rsi, %rsi
               	movl	$0x3, %edx
               	movl	$0x43, %ecx
               	movq	%rdi, %xmm0
               	movq	%rsi, %rdi
               	movq	%rdx, %rsi
               	movq	%rcx, %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	movabsq	$0x3fe0000000000000, %rdi # imm = 0x3FE0000000000000
               	xorq	%rsi, %rsi
               	movl	$0x45, %ecx
               	movq	%rdi, %xmm0
               	movq	%rsi, %rdi
               	movq	%rcx, %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	xorq	%rdi, %rdi
               	movl	$0x47, %edx
               	movq	%rdi, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	movabsq	$0x400ffdf3b645a1cb, %rax # imm = 0x400FFDF3B645A1CB
               	movq	%rax, %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$-0x1, %rdi
               	movabsq	$-0x3, %rsi
               	movl	$0x49, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	movabsq	$0x43ea055690d9db80, %rdi # imm = 0x43EA055690D9DB80
               	xorq	%rsi, %rsi
               	movabsq	$-0x2fd54b7931240000, %rdx # imm = 0xD02AB486CEDC0000
               	movl	$0x4b, %ecx
               	movq	%rdi, %xmm0
               	movq	%rsi, %rdi
               	movq	%rdx, %rsi
               	movq	%rcx, %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	movabsq	$0x43f0000000000000, %rdi # imm = 0x43F0000000000000
               	movl	$0x1, %esi
               	xorq	%rdx, %rdx
               	movl	$0x4d, %ecx
               	movq	%rdi, %xmm0
               	movq	%rsi, %rdi
               	movq	%rdx, %rsi
               	movq	%rcx, %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	movabsq	$0x45c0000000000000, %rdi # imm = 0x45C0000000000000
               	movl	$0x20000000, %esi       # imm = 0x20000000
               	xorq	%rdx, %rdx
               	movl	$0x4f, %ecx
               	movq	%rdi, %xmm0
               	movq	%rsi, %rdi
               	movq	%rdx, %rsi
               	movq	%rcx, %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	movabsq	$0x47e0000000000000, %rax # imm = 0x47E0000000000000
               	movq	%rax, %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$-0x8000000000000000, %rdi # imm = 0x8000000000000000
               	xorq	%rsi, %rsi
               	movl	$0x51, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x40200000, %ecx       # imm = 0x40200000
               	movq	%rcx, %xmm14
               	movss	%xmm14, (%rax,%riz)
               	movss	(%rax,%riz), %xmm0
               	leaq	-0x68(%rbp), %rsi
               	cvtss2sd	%xmm0, %xmm0
               	leaq	-0x70(%rbp), %rax
               	movsd	%xmm0, (%rax,%riz)
               	movq	(%rax), %rax
               	movq	%rax, %r15
               	sarq	$0x3f, %r15
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rax, %rcx
               	shrq	$0x34, %rcx
               	leaq	-0x3ff(%rcx), %rbx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x10000000000000, %r9  # imm = 0x10000000000000
               	orq	%rax, %r9
               	leaq	-0x433(%rcx), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	xorq	%rax, %rax
               	movq	%rdx, %rdi
               	andq	$0x7f, %rdi
               	andq	$0x3f, %rdx
               	movl	$0x3f, %r8d
               	movq	%r8, %r12
               	subq	%rdx, %r12
               	shrq	$0x6, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movq	%rdi, %r8
               	xorq	$-0x1, %r8
               	movq	%r9, %r13
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shlq	%cl, %r13
               	popq	%rcx
               	movq	%r9, %r14
               	pushq	%rcx
               	movq	%r12, %rcx
               	shrq	%cl, %r14
               	popq	%rcx
               	shrq	%r14
               	movq	%rax, %r10
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shlq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	orq	%r14, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%r13, %r10
               	andq	%r8, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%rax, %r14
               	andq	%rdi, %r14
               	movq	0x40(%rsp), %r10
               	orq	%r14, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x48(%rsp), %r10
               	andq	%r8, %r10
               	movq	%r10, 0x48(%rsp)
               	andq	%rdi, %r13
               	movq	0x48(%rsp), %r10
               	orq	%r13, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%rax, %r13
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %r13
               	popq	%rcx
               	movq	%r12, %r10
               	movq	%rax, %r12
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r12
               	popq	%rcx
               	shlq	%r12
               	movq	%rdx, %r10
               	movq	%r9, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	orq	%r12, %rdx
               	andq	%r8, %rdx
               	andq	%r13, %rdi
               	orq	%rdx, %rdi
               	movq	%r13, %rdx
               	andq	%r8, %rdx
               	movq	%rdx, %r8
               	orq	%r14, %r8
               	movq	%rcx, %rdx
               	xorq	$-0x1, %rdx
               	movq	0x40(%rsp), %r9
               	andq	%rdx, %r9
               	andq	%rcx, %rdi
               	orq	%r9, %rdi
               	movq	%rdx, %r10
               	movq	0x48(%rsp), %rdx
               	andq	%r10, %rdx
               	andq	%r8, %rcx
               	orq	%rcx, %rdx
               	movq	%rbx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rdi
               	andq	%rcx, %rdx
               	cmpq	$0x80, %rbx
               	setge	%cl
               	movzbq	%cl, %rcx
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rdi
               	andq	$-0x1, %rax
               	orq	%rax, %rdi
               	andq	%rdx, %rcx
               	movq	%rcx, %rdx
               	orq	%rax, %rdx
               	movq	%r15, %rax
               	xorq	$-0x1, %rax
               	movq	%rdi, %rcx
               	andq	%rax, %rcx
               	andq	%rdx, %rax
               	movq	%rcx, (%rsi)
               	movq	%rax, 0x8(%rsi)
               	cmpq	$0x2, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movss	(%rax,%riz), %xmm0
               	leaq	-0x80(%rbp), %rcx
               	cvtss2sd	%xmm0, %xmm0
               	leaq	-0x88(%rbp), %rax
               	movsd	%xmm0, (%rax,%riz)
               	movq	(%rax), %rax
               	movq	%rax, %r15
               	sarq	$0x3f, %r15
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rax, %rdx
               	shrq	$0x34, %rdx
               	leaq	-0x3ff(%rdx), %rbx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x10000000000000, %r9  # imm = 0x10000000000000
               	orq	%rax, %r9
               	leaq	-0x433(%rdx), %rax
               	movq	%rax, %rdx
               	sarq	$0x3f, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	xorq	%rax, %rax
               	movq	%rsi, %rdi
               	andq	$0x7f, %rdi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %r8d
               	movq	%r8, %r12
               	subq	%rsi, %r12
               	shrq	$0x6, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movq	%rdi, %r8
               	xorq	$-0x1, %r8
               	movq	%r9, %r13
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %r13
               	popq	%rcx
               	movq	%r9, %r14
               	pushq	%rcx
               	movq	%r12, %rcx
               	shrq	%cl, %r14
               	popq	%rcx
               	shrq	%r14
               	movq	%rax, %r10
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	orq	%r14, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%r13, %r10
               	andq	%r8, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%rax, %r14
               	andq	%rdi, %r14
               	movq	0x40(%rsp), %r10
               	orq	%r14, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x48(%rsp), %r10
               	andq	%r8, %r10
               	movq	%r10, 0x48(%rsp)
               	andq	%rdi, %r13
               	movq	0x48(%rsp), %r10
               	orq	%r13, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%rax, %r13
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %r13
               	popq	%rcx
               	movq	%r12, %r10
               	movq	%rax, %r12
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r12
               	popq	%rcx
               	shlq	%r12
               	movq	%rsi, %r10
               	movq	%r9, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	orq	%r12, %rsi
               	andq	%r8, %rsi
               	andq	%r13, %rdi
               	orq	%rsi, %rdi
               	movq	%r13, %rsi
               	andq	%r8, %rsi
               	movq	%rsi, %r8
               	orq	%r14, %r8
               	movq	%rdx, %rsi
               	xorq	$-0x1, %rsi
               	movq	0x40(%rsp), %r9
               	andq	%rsi, %r9
               	andq	%rdx, %rdi
               	orq	%r9, %rdi
               	movq	%rsi, %r10
               	movq	0x48(%rsp), %rsi
               	andq	%r10, %rsi
               	andq	%r8, %rdx
               	orq	%rdx, %rsi
               	movq	%rbx, %rdx
               	sarq	$0x3f, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdx, %rdi
               	movq	%rsi, %r8
               	andq	%rdx, %r8
               	cmpq	$0x80, %rbx
               	setge	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movq	%rdx, %rsi
               	xorq	$-0x1, %rsi
               	andq	%rsi, %rdi
               	andq	$-0x1, %rdx
               	orq	%rdx, %rdi
               	andq	%r8, %rsi
               	orq	%rdx, %rsi
               	movq	%r15, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdx, %rdi
               	andq	%rsi, %rdx
               	movq	%rdi, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x98(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	testq	%rdx, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x53, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x40600000, %ecx       # imm = 0x40600000
               	movq	%rcx, %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	movss	(%rax,%riz), %xmm0
               	leaq	-0xb0(%rbp), %rdi
               	cvtss2sd	%xmm0, %xmm0
               	leaq	-0xb8(%rbp), %rax
               	movsd	%xmm0, (%rax,%riz)
               	movq	(%rax), %rcx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rdx
               	shrq	$0x34, %rdx
               	leaq	-0x3ff(%rdx), %r12
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x10000000000000, %rbx # imm = 0x10000000000000
               	orq	%rcx, %rbx
               	leaq	-0x433(%rdx), %rcx
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	xorq	%rdx, %rcx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	xorq	%rcx, %rcx
               	movq	%rsi, %r8
               	andq	$0x7f, %r8
               	andq	$0x3f, %rsi
               	movl	$0x3f, %r9d
               	movq	%r9, %r13
               	subq	%rsi, %r13
               	shrq	$0x6, %r8
               	movq	%r8, %r10
               	movq	%rcx, %r8
               	subq	%r10, %r8
               	movq	%r8, %r9
               	xorq	$-0x1, %r9
               	movq	%rbx, %r14
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %r14
               	popq	%rcx
               	movq	%rbx, %r15
               	pushq	%rcx
               	movq	%r13, %rcx
               	shrq	%cl, %r15
               	popq	%rcx
               	shrq	%r15
               	movq	%rcx, %r10
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	orq	%r15, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%r14, %r10
               	andq	%r9, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%rcx, %r15
               	andq	%r8, %r15
               	movq	0x40(%rsp), %r10
               	orq	%r15, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x48(%rsp), %r10
               	andq	%r9, %r10
               	movq	%r10, 0x48(%rsp)
               	andq	%r8, %r14
               	movq	0x48(%rsp), %r10
               	orq	%r14, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%rcx, %r14
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %r14
               	popq	%rcx
               	movq	%r13, %r10
               	movq	%rcx, %r13
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r13
               	popq	%rcx
               	shlq	%r13
               	movq	%rsi, %r10
               	movq	%rbx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	orq	%r13, %rsi
               	andq	%r9, %rsi
               	andq	%r14, %r8
               	orq	%rsi, %r8
               	movq	%r14, %rsi
               	andq	%r9, %rsi
               	movq	%rsi, %r9
               	orq	%r15, %r9
               	movq	%rdx, %rsi
               	xorq	$-0x1, %rsi
               	movq	0x40(%rsp), %rbx
               	andq	%rsi, %rbx
               	andq	%rdx, %r8
               	orq	%rbx, %r8
               	movq	%rsi, %r10
               	movq	0x48(%rsp), %rsi
               	andq	%r10, %rsi
               	andq	%r9, %rdx
               	orq	%rdx, %rsi
               	movq	%r12, %rdx
               	sarq	$0x3f, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdx, %r8
               	andq	%rdx, %rsi
               	cmpq	$0x80, %r12
               	setge	%dl
               	movzbq	%dl, %rdx
               	subq	%rdx, %rcx
               	movq	%r8, %rdx
               	xorq	%rax, %rdx
               	xorq	%rax, %rsi
               	cmpq	%rax, %rdx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	subq	%rax, %rdx
               	subq	%rax, %rsi
               	subq	%r8, %rsi
               	movq	%rax, %r8
               	xorq	$-0x1, %r8
               	movabsq	$0x7fffffffffffffff, %r9 # imm = 0x7FFFFFFFFFFFFFFF
               	xorq	%rax, %r9
               	movq	%rcx, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %rdx
               	andq	%rcx, %r8
               	orq	%r8, %rdx
               	andq	%rsi, %rax
               	andq	%r9, %rcx
               	orq	%rcx, %rax
               	movq	%rdx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	cmpq	$-0x3, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movss	(%rax,%riz), %xmm0
               	leaq	-0xc8(%rbp), %rdx
               	cvtss2sd	%xmm0, %xmm0
               	leaq	-0xd0(%rbp), %rax
               	movsd	%xmm0, (%rax,%riz)
               	movq	(%rax), %rcx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	movabsq	$0x7fffffffffffffff, %rsi # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rsi
               	shrq	$0x34, %rsi
               	leaq	-0x3ff(%rsi), %r12
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x10000000000000, %rbx # imm = 0x10000000000000
               	orq	%rcx, %rbx
               	leaq	-0x433(%rsi), %rcx
               	movq	%rcx, %rsi
               	sarq	$0x3f, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	xorq	%rcx, %rcx
               	movq	%rdi, %r8
               	andq	$0x7f, %r8
               	andq	$0x3f, %rdi
               	movl	$0x3f, %r9d
               	movq	%r9, %r13
               	subq	%rdi, %r13
               	shrq	$0x6, %r8
               	movq	%r8, %r10
               	movq	%rcx, %r8
               	subq	%r10, %r8
               	movq	%r8, %r9
               	xorq	$-0x1, %r9
               	movq	%rbx, %r14
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %r14
               	popq	%rcx
               	movq	%rbx, %r15
               	pushq	%rcx
               	movq	%r13, %rcx
               	shrq	%cl, %r15
               	popq	%rcx
               	shrq	%r15
               	movq	%rcx, %r10
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	orq	%r15, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%r14, %r10
               	andq	%r9, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%rcx, %r15
               	andq	%r8, %r15
               	movq	0x40(%rsp), %r10
               	orq	%r15, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x48(%rsp), %r10
               	andq	%r9, %r10
               	movq	%r10, 0x48(%rsp)
               	andq	%r8, %r14
               	movq	0x48(%rsp), %r10
               	orq	%r14, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%rcx, %r14
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %r14
               	popq	%rcx
               	movq	%r13, %r10
               	movq	%rcx, %r13
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r13
               	popq	%rcx
               	shlq	%r13
               	movq	%rdi, %r10
               	movq	%rbx, %rdi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	orq	%r13, %rdi
               	andq	%r9, %rdi
               	andq	%r14, %r8
               	orq	%rdi, %r8
               	movq	%r14, %rdi
               	andq	%r9, %rdi
               	movq	%rdi, %r9
               	orq	%r15, %r9
               	movq	%rsi, %rdi
               	xorq	$-0x1, %rdi
               	movq	0x40(%rsp), %rbx
               	andq	%rdi, %rbx
               	andq	%rsi, %r8
               	orq	%rbx, %r8
               	movq	%rdi, %r10
               	movq	0x48(%rsp), %rdi
               	andq	%r10, %rdi
               	andq	%r9, %rsi
               	orq	%rsi, %rdi
               	movq	%r12, %rsi
               	sarq	$0x3f, %rsi
               	xorq	$-0x1, %rsi
               	andq	%rsi, %r8
               	movq	%rdi, %r9
               	andq	%rsi, %r9
               	cmpq	$0x80, %r12
               	setge	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, %r10
               	movq	%rcx, %rsi
               	subq	%r10, %rsi
               	movq	%r8, %rdi
               	xorq	%rax, %rdi
               	movq	%r9, %r8
               	xorq	%rax, %r8
               	cmpq	%rax, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	subq	%rax, %rdi
               	subq	%rax, %r8
               	subq	%r9, %r8
               	movq	%rax, %r9
               	xorq	$-0x1, %r9
               	movabsq	$0x7fffffffffffffff, %rbx # imm = 0x7FFFFFFFFFFFFFFF
               	xorq	%rax, %rbx
               	movq	%rsi, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %rdi
               	andq	%rsi, %r9
               	orq	%r9, %rdi
               	andq	%r8, %rax
               	andq	%rbx, %rsi
               	orq	%rax, %rsi
               	movq	%rdi, (%rdx)
               	movq	%rsi, 0x8(%rdx)
               	leaq	-0xe0(%rbp), %rax
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	cmpq	$-0x1, %rsi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x54, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	xorq	%rbx, %rbx
               	movq	%rbx, (%rax)
               	leaq	<rip>, %rcx
               	movabsq	$0x10000000000000, %rdx # imm = 0x10000000000000
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rdi
               	movq	(%rcx), %rsi
               	callq	<addr>
               	movq	%rax, -0xf0(%rbp)
               	movq	%rdx, -0xe8(%rbp)
               	leaq	-0xf0(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x5, %rcx
               	leaq	0x1(%rcx), %r8
               	movq	%rcx, %r10
               	movq	%rax, %rcx
               	movq	%rcx, %r11
               	movq	%r10, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x10, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %r8
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x8, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x4, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x2, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	addq	%rdx, %r8
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movq	%rcx, %rdx
               	shrq	%rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	addq	%rdx, %r8
               	movq	%r8, %rcx
               	imulq	%rsi, %rcx
               	movl	$0x40, %edx
               	subq	%rcx, %rdx
               	andq	$0x3f, %rdx
               	movabsq	$-0x1, %r9
               	movq	%rdx, %r10
               	movq	%r9, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	testq	%rcx, %rcx
               	setne	%sil
               	movzbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	andq	%rdi, %rdx
               	testq	%rdx, %rdx
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%rcx, %rsi
               	andq	$0x7f, %rsi
               	movq	%rcx, %rdx
               	andq	$0x3f, %rdx
               	movl	$0x3f, %r12d
               	movq	%r12, %r15
               	subq	%rdx, %r15
               	shrq	$0x6, %rsi
               	movq	%rsi, %r10
               	movq	%rbx, %rsi
               	subq	%r10, %rsi
               	movq	%rsi, %r8
               	xorq	$-0x1, %r8
               	movq	%rax, %r13
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %r13
               	popq	%rcx
               	pushq	%rcx
               	movq	%r15, %rcx
               	shlq	%cl, %rax
               	popq	%rcx
               	shlq	%rax
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	orq	%rdx, %rax
               	andq	%r8, %rax
               	movq	%r13, %rdx
               	andq	%rsi, %rdx
               	orq	%rdx, %rax
               	orq	%r14, %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	leaq	0x3ff(%rcx), %rax
               	shlq	$0x34, %rax
               	movq	%rax, %rcx
               	orq	%rbx, %rcx
               	leaq	-0xf8(%rbp), %rax
               	movq	%rcx, (%rax)
               	movsd	(%rax,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	leaq	-0x108(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movsd	%xmm0, (%rax,%riz)
               	movq	(%rax), %rax
               	movq	%rax, %r10
               	sarq	$0x3f, %r10
               	movq	%r10, 0x48(%rsp)
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rax, %rcx
               	shrq	$0x34, %rcx
               	leaq	-0x3ff(%rcx), %r13
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x10000000000000, %r8  # imm = 0x10000000000000
               	orq	%rax, %r8
               	subq	$0x433, %rcx            # imm = 0x433
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	xorq	%rax, %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %rsi
               	andq	$0x7f, %rsi
               	andq	$0x3f, %rcx
               	subq	%rcx, %r12
               	shrq	$0x6, %rsi
               	movq	%rsi, %r10
               	movq	%rbx, %rsi
               	subq	%r10, %rsi
               	movq	%rsi, %rdi
               	xorq	$-0x1, %rdi
               	movq	%r8, %r14
               	shlq	%cl, %r14
               	movq	%r8, %r15
               	pushq	%rcx
               	movq	%r12, %rcx
               	shrq	%cl, %r15
               	popq	%rcx
               	shrq	%r15
               	movq	%rbx, %r10
               	shlq	%cl, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	orq	%r15, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%r14, %r10
               	andq	%rdi, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rbx, %r15
               	andq	%rsi, %r15
               	movq	0x38(%rsp), %r10
               	orq	%r15, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rsp), %r10
               	andq	%rdi, %r10
               	movq	%r10, 0x40(%rsp)
               	andq	%rsi, %r14
               	movq	0x40(%rsp), %r10
               	orq	%r14, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%rbx, %r14
               	shrq	%cl, %r14
               	movq	%r12, %r10
               	movq	%rbx, %r12
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r12
               	popq	%rcx
               	shlq	%r12
               	movq	%rcx, %r10
               	movq	%r8, %rcx
               	movq	%rcx, %r11
               	movq	%r10, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	orq	%r12, %rcx
               	andq	%rdi, %rcx
               	andq	%r14, %rsi
               	orq	%rcx, %rsi
               	movq	%r14, %rcx
               	andq	%rdi, %rcx
               	movq	%rcx, %rdi
               	orq	%r15, %rdi
               	movq	%rax, %rcx
               	xorq	$-0x1, %rcx
               	movq	0x38(%rsp), %r8
               	andq	%rcx, %r8
               	andq	%rax, %rsi
               	orq	%r8, %rsi
               	movq	%rcx, %r10
               	movq	0x40(%rsp), %rcx
               	andq	%r10, %rcx
               	andq	%rdi, %rax
               	orq	%rax, %rcx
               	movq	%r13, %rax
               	sarq	$0x3f, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %rsi
               	movq	%rcx, %rdi
               	andq	%rax, %rdi
               	cmpq	$0x80, %r13
               	setge	%al
               	movzbq	%al, %rax
               	movq	%rax, %r10
               	movq	%rbx, %rax
               	subq	%r10, %rax
               	movq	%rax, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rsi
               	andq	%r9, %rax
               	orq	%rax, %rsi
               	andq	%rdi, %rcx
               	movq	%rcx, %rdi
               	orq	%rax, %rdi
               	movq	0x48(%rsp), %rax
               	xorq	$-0x1, %rax
               	movq	%rsi, %rcx
               	andq	%rax, %rcx
               	andq	%rdi, %rax
               	movq	%rcx, (%rdx)
               	movq	%rax, 0x8(%rdx)
               	movabsq	$0x10000000000000, %r11 # imm = 0x10000000000000
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x55, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x5, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rcx
               	xorq	%rbx, %rbx
               	movq	%rbx, (%rcx)
               	movq	(%rax), %rdi
               	movq	(%rcx), %rsi
               	callq	<addr>
               	movq	%rax, -0x120(%rbp)
               	movq	%rdx, -0x118(%rbp)
               	leaq	-0x120(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x5, %rcx
               	leaq	0x1(%rcx), %r8
               	movq	%rcx, %r10
               	movq	%rax, %rcx
               	movq	%rcx, %r11
               	movq	%r10, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x10, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %r8
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x8, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x4, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x2, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	addq	%rdx, %r8
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movq	%rcx, %rdx
               	shrq	%rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	addq	%rdx, %r8
               	movq	%r8, %rcx
               	imulq	%rsi, %rcx
               	movl	$0x40, %edx
               	subq	%rcx, %rdx
               	andq	$0x3f, %rdx
               	movabsq	$-0x1, %r9
               	movq	%rdx, %r10
               	movq	%r9, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	testq	%rcx, %rcx
               	setne	%sil
               	movzbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	andq	%rdi, %rdx
               	testq	%rdx, %rdx
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%rcx, %rsi
               	andq	$0x7f, %rsi
               	movq	%rcx, %rdx
               	andq	$0x3f, %rdx
               	movl	$0x3f, %r12d
               	movq	%r12, %r15
               	subq	%rdx, %r15
               	shrq	$0x6, %rsi
               	movq	%rsi, %r10
               	movq	%rbx, %rsi
               	subq	%r10, %rsi
               	movq	%rsi, %r8
               	xorq	$-0x1, %r8
               	movq	%rax, %r13
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %r13
               	popq	%rcx
               	pushq	%rcx
               	movq	%r15, %rcx
               	shlq	%cl, %rax
               	popq	%rcx
               	shlq	%rax
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	orq	%rdx, %rax
               	andq	%r8, %rax
               	movq	%r13, %rdx
               	andq	%rsi, %rdx
               	orq	%rdx, %rax
               	orq	%r14, %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	leaq	0x3ff(%rcx), %rax
               	shlq	$0x34, %rax
               	movq	%rax, %rcx
               	orq	%rbx, %rcx
               	leaq	-0x128(%rbp), %rax
               	movq	%rcx, (%rax)
               	movsd	(%rax,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	leaq	-0x138(%rbp), %rax
               	leaq	-0x140(%rbp), %rcx
               	movsd	%xmm0, (%rcx,%riz)
               	movq	(%rcx), %rcx
               	movq	%rcx, %r10
               	sarq	$0x3f, %r10
               	movq	%r10, 0x48(%rsp)
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rdx
               	shrq	$0x34, %rdx
               	leaq	-0x3ff(%rdx), %r13
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x10000000000000, %r8  # imm = 0x10000000000000
               	orq	%rcx, %r8
               	subq	$0x433, %rdx            # imm = 0x433
               	movq	%rdx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	%rcx, %rdx
               	subq	%rcx, %rdx
               	movq	%rdx, %rsi
               	andq	$0x7f, %rsi
               	andq	$0x3f, %rdx
               	subq	%rdx, %r12
               	shrq	$0x6, %rsi
               	movq	%rsi, %r10
               	movq	%rbx, %rsi
               	subq	%r10, %rsi
               	movq	%rsi, %rdi
               	xorq	$-0x1, %rdi
               	movq	%r8, %r14
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shlq	%cl, %r14
               	popq	%rcx
               	movq	%r8, %r15
               	pushq	%rcx
               	movq	%r12, %rcx
               	shrq	%cl, %r15
               	popq	%rcx
               	shrq	%r15
               	movq	%rbx, %r10
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shlq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	orq	%r15, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%r14, %r10
               	andq	%rdi, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rbx, %r15
               	andq	%rsi, %r15
               	movq	0x38(%rsp), %r10
               	orq	%r15, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rsp), %r10
               	andq	%rdi, %r10
               	movq	%r10, 0x40(%rsp)
               	andq	%rsi, %r14
               	movq	0x40(%rsp), %r10
               	orq	%r14, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%rbx, %r14
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %r14
               	popq	%rcx
               	movq	%r12, %r10
               	movq	%rbx, %r12
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r12
               	popq	%rcx
               	shlq	%r12
               	movq	%rdx, %r10
               	movq	%r8, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	orq	%r12, %rdx
               	andq	%rdi, %rdx
               	andq	%r14, %rsi
               	orq	%rdx, %rsi
               	movq	%r14, %rdx
               	andq	%rdi, %rdx
               	movq	%rdx, %rdi
               	orq	%r15, %rdi
               	movq	%rcx, %rdx
               	xorq	$-0x1, %rdx
               	movq	0x38(%rsp), %r8
               	andq	%rdx, %r8
               	andq	%rcx, %rsi
               	orq	%r8, %rsi
               	movq	%rdx, %r10
               	movq	0x40(%rsp), %rdx
               	andq	%r10, %rdx
               	andq	%rdi, %rcx
               	orq	%rcx, %rdx
               	movq	%r13, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rsi
               	movq	%rdx, %rdi
               	andq	%rcx, %rdi
               	cmpq	$0x80, %r13
               	setge	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r10
               	movq	%rbx, %rcx
               	subq	%r10, %rcx
               	movq	%rcx, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdx, %rsi
               	andq	%r9, %rcx
               	orq	%rcx, %rsi
               	andq	%rdi, %rdx
               	orq	%rcx, %rdx
               	movq	0x48(%rsp), %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rsi
               	andq	%rdx, %rcx
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x150(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rbx, 0x8(%rax)
               	cmpq	$0x5, %rcx
               	je	<addr>
               	movl	$0x56, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	xorq	%rbx, %rbx
               	movq	%rbx, (%rax)
               	leaq	<rip>, %rcx
               	movl	$0x3, %edx
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %r12
               	movabsq	$0x3ff8000000000000, %rdx # imm = 0x3FF8000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, (%r12)
               	movq	(%rax), %rdi
               	movq	(%rcx), %rsi
               	callq	<addr>
               	movq	%rax, -0x160(%rbp)
               	movq	%rdx, -0x158(%rbp)
               	leaq	-0x160(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x5, %rcx
               	leaq	0x1(%rcx), %r8
               	movq	%rcx, %r10
               	movq	%rax, %rcx
               	movq	%rcx, %r11
               	movq	%r10, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x10, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %r8
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x8, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x4, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x2, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	addq	%rdx, %r8
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movq	%rcx, %rdx
               	shrq	%rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	addq	%rdx, %r8
               	movq	%r8, %rcx
               	imulq	%rsi, %rcx
               	movl	$0x40, %edx
               	subq	%rcx, %rdx
               	andq	$0x3f, %rdx
               	movabsq	$-0x1, %rsi
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	testq	%rcx, %rcx
               	setne	%sil
               	movzbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	andq	%rdi, %rdx
               	testq	%rdx, %rdx
               	setne	%r13b
               	movzbq	%r13b, %r13
               	movq	%rcx, %rsi
               	andq	$0x7f, %rsi
               	movq	%rcx, %rdx
               	andq	$0x3f, %rdx
               	movl	$0x3f, %r8d
               	movq	%r8, %r14
               	subq	%rdx, %r14
               	shrq	$0x6, %rsi
               	movq	%rsi, %r10
               	movq	%rbx, %rsi
               	subq	%r10, %rsi
               	movq	%rsi, %r8
               	xorq	$-0x1, %r8
               	movq	%rax, %r9
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %r9
               	popq	%rcx
               	pushq	%rcx
               	movq	%r14, %rcx
               	shlq	%cl, %rax
               	popq	%rcx
               	shlq	%rax
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	orq	%rdx, %rax
               	andq	%r8, %rax
               	movq	%r9, %rdx
               	andq	%rsi, %rdx
               	orq	%rdx, %rax
               	orq	%r13, %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	leaq	0x3ff(%rcx), %rax
               	shlq	$0x34, %rax
               	movq	%rax, %rcx
               	orq	%rbx, %rcx
               	leaq	-0x168(%rbp), %rax
               	movq	%rcx, (%rax)
               	movsd	(%rax,%riz), %xmm1
               	movsd	(%r12), %xmm2
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	callq	<addr>
               	movabsq	$0x4012000000000000, %r11 # imm = 0x4012000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x57, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	callq	<addr>
               	movq	%rax, -0x178(%rbp)
               	movq	%rdx, -0x170(%rbp)
               	leaq	-0x178(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rcx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	xorq	%rax, %rdx
               	xorq	%rax, %rcx
               	cmpq	%rax, %rdx
               	setb	%sil
               	movzbq	%sil, %rsi
               	movq	%rdx, %rdi
               	subq	%rax, %rdi
               	subq	%rax, %rcx
               	subq	%rsi, %rcx
               	movabsq	$-0x8000000000000000, %r12 # imm = 0x8000000000000000
               	andq	%rax, %r12
               	testq	%rcx, %rcx
               	setne	%sil
               	movzbq	%sil, %rsi
               	movq	%rcx, %rax
               	shrq	$0x20, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x5, %rax
               	leaq	0x1(%rax), %r8
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rax
               	popq	%rcx
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %r8
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rax
               	popq	%rcx
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rax
               	popq	%rcx
               	movq	%rax, %rdx
               	shrq	$0x4, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rax
               	popq	%rcx
               	movq	%rax, %rdx
               	shrq	$0x2, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	addq	%rdx, %r8
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rax
               	popq	%rcx
               	movq	%rax, %rdx
               	shrq	%rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	addq	%rdx, %r8
               	movq	%r8, %rax
               	imulq	%rsi, %rax
               	movl	$0x40, %edx
               	subq	%rax, %rdx
               	andq	$0x3f, %rdx
               	movabsq	$-0x1, %rsi
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	testq	%rax, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	andq	%rdi, %rdx
               	testq	%rdx, %rdx
               	setne	%r13b
               	movzbq	%r13b, %r13
               	movq	%rax, %rsi
               	andq	$0x7f, %rsi
               	movq	%rax, %rdx
               	andq	$0x3f, %rdx
               	movl	$0x3f, %r8d
               	movq	%r8, %r14
               	subq	%rdx, %r14
               	shrq	$0x6, %rsi
               	xorq	%r8, %r8
               	movq	%rsi, %r10
               	movq	%r8, %rsi
               	subq	%r10, %rsi
               	movq	%rsi, %r9
               	xorq	$-0x1, %r9
               	movq	%rcx, %rbx
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rbx
               	popq	%rcx
               	movq	%rcx, %r11
               	movq	%r14, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	shlq	%rcx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	orq	%rdx, %rcx
               	andq	%r9, %rcx
               	movq	%rbx, %rdx
               	andq	%rsi, %rdx
               	orq	%rdx, %rcx
               	orq	%r13, %rcx
               	xorps	%xmm0, %xmm0
               	movq	%rcx, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	addq	$0x3ff, %rax            # imm = 0x3FF
               	shlq	$0x34, %rax
               	movq	%rax, %rcx
               	orq	%r12, %rcx
               	leaq	-0x180(%rbp), %rax
               	movq	%rcx, (%rax)
               	movsd	(%rax,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	leaq	<rip>, %rax
               	movsd	(%rax,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	callq	<addr>
               	movabsq	$0x4012000000000000, %r11 # imm = 0x4012000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x58, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
