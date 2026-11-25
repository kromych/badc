
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
               	pushq	%r12
               	pushq	%rbx
               	movq	%rcx, %r10
               	leaq	(%rdi,%rdi,2), %rax
               	addq	%rsi, %rax
               	leaq	(%rdx,%rdx,4), %rcx
               	addq	%r10, %rcx
               	imulq	$0x7, %r8, %r11
               	addq	%r9, %r11
               	xorq	%rdx, %rdi
               	xorq	%r10, %rsi
               	xorq	%r9, %r8
               	leaq	(%rax,%rcx), %rdx
               	movq	%r11, %r9
               	orq	$0x1, %r9
               	movq	%rax, -0x18(%rsp)
               	movq	%rdx, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %rdx
               	movq	-0x18(%rsp), %rax
               	movq	%rax, %r10
               	imulq	%rcx, %r10
               	movq	%rax, -0x18(%rsp)
               	movq	%rdx, -0x20(%rsp)
               	movq	%r10, %rax
               	cqto
               	idivq	%r9
               	movq	%rdx, %rbx
               	movq	-0x20(%rsp), %rdx
               	movq	-0x18(%rsp), %rax
               	imulq	$0x3d1, %r10, %r9       # imm = 0x3D1
               	movq	%rsi, %r10
               	orq	$0x1, %r10
               	movq	%rax, -0x18(%rsp)
               	movq	%rdx, -0x20(%rsp)
               	movq	%r9, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	movq	%rax, %r10
               	movq	-0x20(%rsp), %rdx
               	movq	-0x18(%rsp), %rax
               	imulq	$0x10001, %rax, %r9     # imm = 0x10001
               	imulq	$0x3001, %rcx, %r12     # imm = 0x3001
               	imulq	%r12, %r9
               	shrq	$0x7, %r9
               	addq	%rbx, %rdx
               	addq	%r10, %rdx
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	addq	%r9, %rdx
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r11, %rax
               	addq	%rdi, %rax
               	addq	%rsi, %rax
               	addq	%r8, %rax
               	popq	%rbx
               	popq	%r12
               	retq

<shifts>:
               	leaq	(%rdi,%rdi,4), %r8
               	leaq	(%rsi,%rsi,8), %r9
               	movq	%rdi, %r10
               	xorq	%rsi, %r10
               	addq	%rdi, %rsi
               	movq	%rdx, %rax
               	andq	$0x3f, %rax
               	shlxq	%rax, %r8, %rax
               	movq	%rcx, %rdi
               	andq	$0x3f, %rdi
               	shrxq	%rdi, %r9, %rdi
               	addq	%rcx, %rdx
               	andq	$0x3f, %rdx
               	shlxq	%rdx, %r10, %rdx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	orq	%rsi, %r11
               	andq	$0x1f, %rcx
               	sarxq	%rcx, %r11, %rcx
               	xorq	%rdi, %rax
               	xorq	%rdx, %rax
               	xorq	%rcx, %rax
               	xorq	%r8, %rax
               	xorq	%r9, %rax
               	xorq	%r10, %rax
               	xorq	%rsi, %rax
               	retq

<divq>:
               	movq	%rdx, %rcx
               	xorl	%r8d, %r8d
               	orq	%rsi, %r8
               	testq	%rdi, %rdi
               	je	<addr>
               	cmpq	%rcx, %rdi
               	jb	<addr>
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%r8, %rax
               	divq	%rcx
               	movq	%rax, %rsi
               	testq	%rdi, %rdi
               	je	<addr>
               	cmpq	%rcx, %rdi
               	jb	<addr>
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rdx, %rdi
               	movq	%rdi, %rdx
               	movq	%r8, %rax
               	divq	%rcx
               	imulq	%rcx, %rax
               	movq	%r8, %rdx
               	subq	%rax, %rdx
               	xorq	%rsi, %rdx
               	movq	%rdx, %rax
               	retq
               	movq	%r8, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	jmp	<addr>
               	movq	%rdi, %rdx
               	jmp	<addr>
               	movq	%r8, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rax, %rsi
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
               	movq	0x40(%rsp), %rcx
               	movq	%rbx, %rax
               	andq	$0x1, %rax
               	shlq	$0x3, %rax
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
               	subq	$0x20, %rsp
               	pushq	%rbx
               	movq	%rdx, %rbx
               	leaq	(%rsi,%rbx), %r11
               	leaq	(%rcx,%r8), %r10
               	imulq	%rsi, %r8
               	xorl	%ecx, %ecx
               	leaq	(%rsi,%rcx), %rax
               	movq	%r10, 0x10(%rsp)
               	lock
               	xaddq	%rax, (%rdi)
               	addq	%rax, %r11
               	movl	$0x1, %eax
               	shlxq	%rcx, %rax, %rdx
               	movq	(%rdi), %rax
               	movq	%rax, %r9
               	orq	%rdx, %r9
               	lock
               	cmpxchgq	%r9, (%rdi)
               	jne	<addr>
               	movq	0x10(%rsp), %r10
               	xorq	%rax, %r10
               	movq	(%rdi), %r9
               	movq	%r9, %rax
               	shlq	%rax
               	leaq	(%rax,%rbx), %rdx
               	movq	%r10, 0x18(%rsp)
               	movq	%r11, 0x10(%rsp)
               	movq	%r9, %rax
               	lock
               	cmpxchgq	%rdx, (%rdi)
               	cmpq	%r9, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	cmovneq	%r9, %rax
               	movq	0x18(%rsp), %r10
               	movq	0x10(%rsp), %r11
               	addq	%r8, %rax
               	testq	%rdx, %rdx
               	cmovneq	%rax, %r8
               	incq	%rcx
               	cmpl	$0x5, %ecx
               	jl	<addr>
               	leaq	(%r11,%r10), %rax
               	addq	%r8, %rax
               	movq	(%rdi), %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq

<copies>:
               	testl	%edx, %edx
               	jle	<addr>
               	pushq	%rbx
               	leaq	(%rcx,%r8), %rax
               	addq	%r9, %rax
               	xorl	%r10d, %r10d
               	leaq	-0x1(%rdx), %rbx
               	imulq	%r9, %r8
               	imulq	$0x28, %r10, %r9
               	addq	%rdi, %r9
               	movq	%rbx, %r11
               	subq	%r10, %r11
               	movslq	%r11d, %r11
               	imulq	$0x28, %r11, %r11
               	addq	%rsi, %r11
               	movq	%r10, -0x50(%rsp)
               	movups	(%r11), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%r11), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	movq	0x20(%r11), %r10
               	movq	%r10, 0x20(%r9)
               	movq	-0x50(%rsp), %r10
               	imulq	$0x66666667, %r10, %r11 # imm = 0x66666667
               	shrq	$0x21, %r11
               	leaq	(%r11,%r11,4), %r11
               	negq	%r11
               	addq	%r10, %r11
               	movq	(%r9,%r11,8), %r9
               	imulq	%rcx, %r9
               	addq	%r8, %r9
               	addq	%r9, %rax
               	incq	%r10
               	cmpl	%edx, %r10d
               	jl	<addr>
               	popq	%rbx
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
               	addq	%rax, %rcx
               	movq	0x10(%rsp), %rax
               	shlq	$0x3, %rax
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
               	movq	0x40(%rsp), %rsi
               	movslq	%esi, %rdx
               	imulq	$0x2aaaaaab, %rdx, %rcx # imm = 0x2AAAAAAB
               	sarq	$0x20, %rcx
               	movq	%rcx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rcx
               	imulq	$0x6, %rcx, %rcx
               	subq	%rcx, %rdx
               	movq	(%rsp,%rdx,8), %r8
               	movq	0x48(%rsp), %rdi
               	imulq	%rdi, %r8
               	leaq	0x1(%rsi), %rcx
               	movslq	%ecx, %rdx
               	imulq	$0x2aaaaaab, %rdx, %rcx # imm = 0x2AAAAAAB
               	sarq	$0x20, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rcx
               	imulq	$0x6, %rcx, %rcx
               	subq	%rcx, %rdx
               	movq	(%rsp,%rdx,8), %rcx
               	leaq	0x1(%rdi), %rdx
               	imulq	%rdx, %rcx
               	addq	%rcx, %r8
               	movq	0x40(%rsp), %rsi
               	leaq	0x2(%rsi), %rcx
               	movslq	%ecx, %rdx
               	imulq	$0x2aaaaaab, %rdx, %rcx # imm = 0x2AAAAAAB
               	sarq	$0x20, %rcx
               	movq	%rcx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rcx
               	imulq	$0x6, %rcx, %rcx
               	subq	%rcx, %rdx
               	movq	(%rsp,%rdx,8), %rcx
               	movq	0x48(%rsp), %rdi
               	leaq	0x2(%rdi), %rdx
               	imulq	%rdx, %rcx
               	addq	%rcx, %r8
               	leaq	0x3(%rsi), %rcx
               	movslq	%ecx, %rdx
               	imulq	$0x2aaaaaab, %rdx, %rcx # imm = 0x2AAAAAAB
               	sarq	$0x20, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rcx
               	imulq	$0x6, %rcx, %rcx
               	subq	%rcx, %rdx
               	movq	(%rsp,%rdx,8), %rcx
               	leaq	0x3(%rdi), %rdx
               	imulq	%rdx, %rcx
               	addq	%rcx, %r8
               	movq	0x40(%rsp), %rsi
               	leaq	0x4(%rsi), %rcx
               	movslq	%ecx, %rdx
               	imulq	$0x2aaaaaab, %rdx, %rcx # imm = 0x2AAAAAAB
               	sarq	$0x20, %rcx
               	movq	%rcx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rcx
               	imulq	$0x6, %rcx, %rcx
               	subq	%rcx, %rdx
               	movq	(%rsp,%rdx,8), %rcx
               	movq	0x48(%rsp), %rdi
               	leaq	0x4(%rdi), %rdx
               	imulq	%rdx, %rcx
               	addq	%rcx, %r8
               	leaq	0x5(%rsi), %rcx
               	movslq	%ecx, %rdx
               	imulq	$0x2aaaaaab, %rdx, %rcx # imm = 0x2AAAAAAB
               	sarq	$0x20, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rcx
               	imulq	$0x6, %rcx, %rcx
               	subq	%rcx, %rdx
               	movq	(%rsp,%rdx,8), %rax
               	leaq	0x5(%rdi), %rcx
               	imulq	%rcx, %rax
               	addq	%r8, %rax
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
               	xorq	%rsi, %rdi
               	xorq	%rdx, %rdi
               	xorq	%rcx, %rdi
               	xorq	%r8, %rdi
               	xorq	%r9, %rdi
               	movq	%rdi, %rax
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
               	movq	%rbx, %rdi
               	movabsq	$-0x123456789abcdef, %rdx # imm = 0xFEDCBA9876543211
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
               	movq	0x30(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	%rbx, %rsi
               	movq	%r12, %rdx
               	leaq	<rip>, %rdi # <addr>
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
               	movq	%rbx, %rsi
               	movq	%r12, %rdx
               	leaq	<rip>, %rdi # <addr>
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
               	movq	%rbx, %rcx
               	movq	%r12, %r8
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x3, %edx
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
               	movq	%rbx, %rsi
               	movq	%r12, %rdx
               	leaq	<rip>, %rdi # <addr>
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
