
frame_without_pointer_borrows.x64:	file format elf64-x86-64

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

<divs>:
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rcx, %rbx
               	leaq	(%rdi,%rdi,2), %rax
               	addq	%rsi, %rax
               	leaq	(%rdx,%rdx,4), %rcx
               	addq	%rbx, %rcx
               	imulq	$0x7, %r8, %r12
               	addq	%r9, %r12
               	xorq	%rdi, %rdx
               	xorq	%rbx, %rsi
               	xorq	%r8, %r9
               	leaq	(%rax,%rcx), %r8
               	movq	%r12, %rdi
               	orq	$0x1, %rdi
               	movq	%rax, -0x18(%rsp)
               	movq	%rdx, -0x20(%rsp)
               	movq	%r8, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rbx
               	movq	-0x20(%rsp), %rdx
               	movq	-0x18(%rsp), %rax
               	movq	%rax, %r8
               	imulq	%rcx, %r8
               	movq	%rax, -0x18(%rsp)
               	movq	%rdx, -0x20(%rsp)
               	movq	%r8, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rdi
               	movq	-0x20(%rsp), %rdx
               	movq	-0x18(%rsp), %rax
               	imulq	$0x3d1, %r8, %r8        # imm = 0x3D1
               	movq	%rsi, %r13
               	orq	$0x1, %r13
               	movq	%rax, -0x18(%rsp)
               	movq	%rdx, -0x20(%rsp)
               	movq	%r8, %rax
               	xorl	%edx, %edx
               	divq	%r13
               	movq	%rax, %r8
               	movq	-0x20(%rsp), %rdx
               	movq	-0x18(%rsp), %rax
               	imulq	$0x10001, %rax, %r13    # imm = 0x10001
               	imulq	$0x3001, %rcx, %r14     # imm = 0x3001
               	imulq	%r14, %r13
               	shrq	$0x7, %r13
               	addq	%rbx, %rdi
               	addq	%r8, %rdi
               	andq	$0xffff, %r13           # imm = 0xFFFF
               	addq	%r13, %rdi
               	addq	%rdi, %rax
               	addq	%rcx, %rax
               	addq	%r12, %rax
               	addq	%rdx, %rax
               	addq	%rsi, %rax
               	addq	%r9, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	retq

<shifts>:
               	pushq	%r12
               	pushq	%rbx
               	leaq	(%rdi,%rdi,4), %rax
               	leaq	(%rsi,%rsi,8), %r8
               	movq	%rdi, %r9
               	xorq	%rsi, %r9
               	addq	%rdi, %rsi
               	movq	%rdx, %rdi
               	andq	$0x3f, %rdi
               	shlxq	%rdi, %rax, %rdi
               	movq	%rcx, %rbx
               	andq	$0x3f, %rbx
               	shrxq	%rbx, %r8, %rbx
               	addq	%rcx, %rdx
               	andq	$0x3f, %rdx
               	shlxq	%rdx, %r9, %rdx
               	movabsq	$-0x8000000000000000, %r12 # imm = 0x8000000000000000
               	orq	%rsi, %r12
               	andq	$0x1f, %rcx
               	sarxq	%rcx, %r12, %rcx
               	xorq	%rbx, %rdi
               	xorq	%rdi, %rdx
               	xorq	%rdx, %rcx
               	xorq	%rcx, %rax
               	xorq	%r8, %rax
               	xorq	%r9, %rax
               	xorq	%rsi, %rax
               	popq	%rbx
               	popq	%r12
               	retq

<divq>:
               	movq	%rdx, %rcx
               	xorl	%eax, %eax
               	orq	%rax, %rsi
               	testq	%rdi, %rdi
               	je	<addr>
               	cmpq	%rcx, %rdi
               	jb	<addr>
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rsi, %rax
               	divq	%rcx
               	movq	%rax, %r8
               	testq	%rdi, %rdi
               	je	<addr>
               	cmpq	%rcx, %rdi
               	jb	<addr>
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rdx, %rdi
               	movq	%rdi, %rdx
               	movq	%rsi, %rax
               	divq	%rcx
               	imulq	%rcx, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movq	%r8, %rax
               	xorq	%rdx, %rax
               	retq
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	jmp	<addr>
               	movq	%rdi, %rdx
               	jmp	<addr>
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rax, %r8
               	jmp	<addr>

<add6>:
               	shlq	%rsi
               	leaq	(%rdi,%rsi), %rax
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	%rdx, %rax
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	leaq	(%r8,%r8,4), %rcx
               	addq	%rcx, %rax
               	imulq	$0x6, %r9, %rcx
               	addq	%rcx, %rax
               	retq

<sub6>:
               	subq	%rsi, %rdi
               	leaq	(%rdi,%rdx), %rax
               	subq	%rcx, %rax
               	addq	%r8, %rax
               	subq	%r9, %rax
               	retq

<indirect>:
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	%rsi, %r13
               	movq	%r9, 0x38(%rsp)
               	movq	%r8, %rbp
               	movq	%rcx, %r15
               	movq	%rdx, %r14
               	movq	%rdi, 0x40(%rsp)
               	xorl	%ebx, %ebx
               	movq	%rbx, %r12
               	movq	0x40(%rsp), %rax
               	movq	%rbx, %rcx
               	andq	$0x1, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movq	(%rax), %rax
               	leaq	(%r13,%rbx), %rdi
               	movq	%r14, %rsi
               	imulq	%rbx, %rsi
               	movq	%r15, %rdx
               	subq	%rbx, %rdx
               	leaq	(%rbp,%r12), %rcx
               	movq	0x38(%rsp), %r8
               	xorq	%rbx, %r8
               	movq	0x60(%rsp), %r9
               	shlq	%r9
               	callq	*%rax
               	movq	%r13, %rcx
               	imulq	%r14, %rcx
               	addq	%rcx, %rax
               	addq	%rax, %r12
               	incq	%rbx
               	nopl	(%rax,%rax)
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	movq	%r12, %rax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x28, %rsp
               	retq

<atomics>:
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdx, %r13
               	leaq	(%rsi,%r13), %r12
               	leaq	(%rcx,%r8), %rbx
               	imulq	%rsi, %r8
               	xorl	%ecx, %ecx
               	leaq	(%rsi,%rcx), %rax
               	lock
               	xaddq	%rax, (%rdi)
               	addq	%rax, %r12
               	movl	$0x1, %eax
               	shlxq	%rcx, %rax, %rdx
               	movq	(%rdi), %rax
               	movq	%rax, %r10
               	orq	%rdx, %r10
               	lock
               	cmpxchgq	%r10, (%rdi)
               	jne	<addr>
               	xorq	%rax, %rbx
               	movq	(%rdi), %r9
               	movq	%r9, %rax
               	shlq	%rax
               	leaq	(%rax,%r13), %rdx
               	movq	%r9, %rax
               	lock
               	cmpxchgq	%rdx, (%rdi)
               	cmpq	%r9, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	cmovneq	%r9, %rax
               	addq	%r8, %rax
               	testq	%rdx, %rdx
               	cmovneq	%rax, %r8
               	incq	%rcx
               	cmpl	$0x5, %ecx
               	jl	<addr>
               	leaq	(%r12,%rbx), %rax
               	addq	%r8, %rax
               	movq	(%rdi), %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	retq

<copies>:
               	testl	%edx, %edx
               	jle	<addr>
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rsi, %rbx
               	movq	%r9, %r12
               	movq	%rcx, %rsi
               	leaq	(%rsi,%r8), %rax
               	leaq	(%rax,%r12), %rcx
               	xorl	%eax, %eax
               	leaq	-0x1(%rdx), %r9
               	imulq	%r8, %r12
               	imulq	$0x28, %rax, %r8
               	leaq	(%rdi,%r8), %r13
               	movq	%r9, %r14
               	subq	%rax, %r14
               	movslq	%r14d, %r14
               	imulq	$0x28, %r14, %r14
               	addq	%rbx, %r14
               	movups	(%r14), %xmm14
               	movups	%xmm14, (%r13)
               	movups	0x10(%r14), %xmm14
               	movups	%xmm14, 0x10(%r13)
               	movq	0x20(%r14), %r10
               	movq	%r10, 0x20(%r13)
               	addq	%rdi, %r8
               	imulq	$0x66666667, %rax, %r13 # imm = 0x66666667
               	shrq	$0x21, %r13
               	leaq	(%r13,%r13,4), %r13
               	negq	%r13
               	addq	%rax, %r13
               	movq	(%r8,%r13,8), %r8
               	imulq	%rsi, %r8
               	addq	%r12, %r8
               	addq	%r8, %rcx
               	incq	%rax
               	cmpl	%edx, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	retq
               	movq	%rcx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	retq

<x87>:
               	xorps	%xmm1, %xmm1
               	xorps	%xmm2, %xmm2
               	cvtsi2sd	%rdx, %xmm2
               	vdivsd	<rip>, %xmm2, %xmm2
               	movsd	%xmm2, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rdi)
               	fldt	0x30(%rdi)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	vaddsd	%xmm0, %xmm1, %xmm0
               	leaq	(%rsi,%rdx), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	vdivsd	<rip>, %xmm1, %xmm1
               	movsd	%xmm1, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x10(%rdi)
               	fldt	(%rdi)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	movq	%rsi, %rax
               	shlq	%rax
               	addq	%rdx, %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	vdivsd	<rip>, %xmm1, %xmm1
               	movsd	%xmm1, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x20(%rdi)
               	fldt	0x10(%rdi)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	leaq	(%rsi,%rsi,2), %rax
               	addq	%rdx, %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	vdivsd	<rip>, %xmm1, %xmm1
               	movsd	%xmm1, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x30(%rdi)
               	fldt	0x20(%rdi)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	vmulsd	<rip>, %xmm0, %xmm0
               	cvttsd2si	%xmm0, %rax
               	retq

<eight>:
               	shlq	%rsi
               	leaq	(%rdi,%rsi), %rax
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	%rdx, %rax
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	leaq	(%r8,%r8,4), %rcx
               	addq	%rcx, %rax
               	imulq	$0x6, %r9, %rcx
               	addq	%rcx, %rax
               	movq	0x8(%rsp), %rcx
               	imulq	$0x7, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x10(%rsp), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	retq

<eight_local>:
               	subq	$0x38, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x8(%rsp)
               	movq	%rdx, 0x10(%rsp)
               	movq	%rcx, 0x18(%rsp)
               	movq	%r8, 0x20(%rsp)
               	movq	%r9, 0x28(%rsp)
               	movq	0x40(%rsp), %rcx
               	movslq	%ecx, %rdx
               	imulq	$0x2aaaaaab, %rdx, %rsi # imm = 0x2AAAAAAB
               	sarq	$0x20, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	imulq	$0x6, %rsi, %rsi
               	subq	%rsi, %rdx
               	movq	(%rsp,%rdx,8), %rsi
               	movq	0x48(%rsp), %rdx
               	movq	%rsi, %rdi
               	imulq	%rdx, %rdi
               	incq	%rcx
               	movslq	%ecx, %rcx
               	imulq	$0x2aaaaaab, %rcx, %rsi # imm = 0x2AAAAAAB
               	sarq	$0x20, %rsi
               	movq	%rsi, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rsi
               	imulq	$0x6, %rsi, %rsi
               	subq	%rsi, %rcx
               	movq	(%rsp,%rcx,8), %rcx
               	incq	%rdx
               	imulq	%rdx, %rcx
               	addq	%rcx, %rdi
               	movq	0x40(%rsp), %rcx
               	leaq	0x2(%rcx), %rdx
               	movslq	%edx, %rdx
               	imulq	$0x2aaaaaab, %rdx, %rsi # imm = 0x2AAAAAAB
               	sarq	$0x20, %rsi
               	movq	%rsi, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rsi
               	imulq	$0x6, %rsi, %rsi
               	subq	%rsi, %rdx
               	movq	(%rsp,%rdx,8), %rsi
               	movq	0x48(%rsp), %rdx
               	leaq	0x2(%rdx), %r8
               	imulq	%r8, %rsi
               	addq	%rsi, %rdi
               	addq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	imulq	$0x2aaaaaab, %rcx, %rsi # imm = 0x2AAAAAAB
               	sarq	$0x20, %rsi
               	movq	%rsi, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rsi
               	imulq	$0x6, %rsi, %rsi
               	subq	%rsi, %rcx
               	movq	(%rsp,%rcx,8), %rcx
               	addq	$0x3, %rdx
               	imulq	%rdx, %rcx
               	addq	%rcx, %rdi
               	movq	0x40(%rsp), %rcx
               	leaq	0x4(%rcx), %rdx
               	movslq	%edx, %rdx
               	imulq	$0x2aaaaaab, %rdx, %rsi # imm = 0x2AAAAAAB
               	sarq	$0x20, %rsi
               	movq	%rsi, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rsi
               	imulq	$0x6, %rsi, %rsi
               	subq	%rsi, %rdx
               	movq	(%rsp,%rdx,8), %rdx
               	movq	0x48(%rsp), %rax
               	leaq	0x4(%rax), %rsi
               	imulq	%rsi, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	addq	$0x5, %rcx
               	movslq	%ecx, %rcx
               	imulq	$0x2aaaaaab, %rcx, %rdx # imm = 0x2AAAAAAB
               	sarq	$0x20, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rdx
               	imulq	$0x6, %rdx, %rdx
               	subq	%rdx, %rcx
               	movq	(%rsp,%rcx,8), %rcx
               	addq	$0x5, %rax
               	imulq	%rcx, %rax
               	addq	%rsi, %rax
               	addq	$0x38, %rsp
               	retq

<tail>:
               	pushq	%rax
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	0x1(%rbx), %rdx
               	leaq	0x1(%r12), %rcx
               	leaq	0x2(%rbx), %r8
               	leaq	0x2(%r12), %r9
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	(%rax,%rbx), %rcx
               	leaq	(%rax,%r12), %rdx
               	movq	%rbx, %rsi
               	imulq	%r12, %rsi
               	subq	%rbx, %rax
               	addq	%r12, %rax
               	subq	%rcx, %rax
               	addq	%rdx, %rax
               	subq	%rsi, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r11
               	retq

<leaf6>:
               	xorq	%rdi, %rsi
               	xorq	%rsi, %rdx
               	xorq	%rdx, %rcx
               	movq	%rcx, %rax
               	xorq	%r8, %rax
               	xorq	%r9, %rax
               	retq

<mid6>:
               	pushq	%rax
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%r9, %rbp
               	movq	%r8, %r15
               	movq	%rcx, %r14
               	movq	%rdx, %r13
               	movq	%rsi, %r12
               	movq	%rbp, %rdi
               	movq	%rbx, %r9
               	movq	%r12, %r8
               	movq	%r13, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	callq	<addr>
               	leaq	(%rbx,%rbx,2), %rcx
               	addq	%rcx, %rax
               	leaq	(%r12,%r12,4), %rcx
               	addq	%rcx, %rax
               	imulq	$0x7, %r13, %rcx
               	addq	%rcx, %rax
               	imulq	$0xb, %r14, %rcx
               	addq	%rcx, %rax
               	imulq	$0xd, %r15, %rcx
               	addq	%rcx, %rax
               	imulq	$0x11, %rbp, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	popq	%r11
               	retq

<top6>:
               	subq	$0x18, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%r9, %rbp
               	movq	%r8, %r15
               	movq	%rcx, %r14
               	movq	%rdx, %r13
               	movq	%rsi, %r12
               	leaq	0x1(%rbx), %rdi
               	leaq	0x1(%r12), %rsi
               	leaq	0x1(%r13), %rdx
               	leaq	0x1(%r14), %rcx
               	leaq	0x1(%r15), %r8
               	leaq	0x1(%rbp), %r9
               	callq	<addr>
               	movq	%rax, 0x38(%rsp)
               	movq	%r12, %rdi
               	movq	%rbx, %r9
               	movq	%rbp, %r8
               	movq	%r15, %rcx
               	movq	%r14, %rdx
               	movq	%r13, %rsi
               	callq	<addr>
               	movq	0x38(%rsp), %rcx
               	subq	%rax, %rcx
               	imulq	%r12, %rbx
               	leaq	(%rcx,%rbx), %rax
               	imulq	%r14, %r13
               	addq	%r13, %rax
               	imulq	%rbp, %r15
               	addq	%r15, %rax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x38, %rsp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x10, %rsp
               	movq	<rip>, %rbx # <addr>
               	movq	<rip>, %r12 # <addr>
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %r8 # <addr>
               	movq	<rip>, %r9 # <addr>
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x28(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x20(%rsp)
               	movq	%rdx, 0x48(%rsp)
               	movq	%rcx, 0x40(%rsp)
               	movq	%r8, 0x38(%rsp)
               	movq	%r9, 0x30(%rsp)
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	$0x192e7, %rax          # imm = 0x192E7
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	movabsq	$0x123456789, %rdi      # imm = 0x123456789
               	imulq	%rbx, %rdi
               	movabsq	$0x987654321, %rsi      # imm = 0x987654321
               	imulq	%r12, %rsi
               	movq	0x48(%rsp), %rdx
               	movq	0x40(%rsp), %rcx
               	callq	<addr>
               	movabsq	$-0x41d961da9cfedfee, %r11 # imm = 0xBE269E2563012012
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	movabsq	$0x1111111111111111, %rsi # imm = 0x1111111111111111
               	imulq	%r12, %rsi
               	movabsq	$-0x123456789abcdef, %rdx # imm = 0xFEDCBA9876543211
               	movq	%rbx, %rdi
               	callq	<addr>
               	movabsq	$0x7ae147ae147ae147, %r11 # imm = 0x7AE147AE147AE147
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movq	0x30(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	%rbx, %rsi
               	movq	%r12, %rdx
               	movq	0x48(%rsp), %rcx
               	movq	0x40(%rsp), %r8
               	movq	0x38(%rsp), %r9
               	callq	<addr>
               	cmpq	$-0x13, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movq	%rbx, %rsi
               	movq	%r12, %rdx
               	movq	0x48(%rsp), %rcx
               	movq	0x40(%rsp), %r8
               	callq	<addr>
               	cmpq	$0x994, %rax            # imm = 0x994
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x3, %edx
               	movq	%rbx, %rcx
               	movq	%r12, %r8
               	movq	0x48(%rsp), %r9
               	callq	<addr>
               	cmpq	$0x13b, %rax            # imm = 0x13B
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0xf, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movq	%rbx, %rsi
               	movq	%r12, %rdx
               	callq	<addr>
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	movq	0x28(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x20(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movq	0x48(%rsp), %rdx
               	movq	0x40(%rsp), %rcx
               	movq	0x38(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	callq	<addr>
               	cmpq	$0x2b6, %rax            # imm = 0x2B6
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	movq	0x28(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x20(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movq	0x48(%rsp), %rdx
               	movq	0x40(%rsp), %rcx
               	movq	0x38(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	callq	<addr>
               	cmpq	$0x8a9, %rax            # imm = 0x8A9
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	$0x9a96, %rax           # imm = 0x9A96
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movq	0x48(%rsp), %rdx
               	movq	0x40(%rsp), %rcx
               	movq	0x38(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	callq	<addr>
               	cmpq	$0x2c3, %rax            # imm = 0x2C3
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
