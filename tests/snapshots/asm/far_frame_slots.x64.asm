
far_frame_slots.x64:	file format elf64-x86-64

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

<fill>:
               	xorl	%eax, %eax
               	cmpq	%rsi, %rax
               	jae	<addr>
               	leaq	(%rdx,%rax), %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdi,%rax)
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpq	%rsi, %rax
               	jb	<addr>
               	retq

<bump>:
               	addq	$0xb, (%rdi)
               	retq

<make>:
               	subq	$0x18, %rsp
               	movq	%rdi, (%rsp)
               	addq	%rsi, %rdx
               	addq	%r8, %rcx
               	movq	0x20(%rsp), %rax
               	leaq	(%r9,%rax), %rsi
               	movq	0x28(%rsp), %rax
               	movq	0x30(%rsp), %rdi
               	addq	%rax, %rdi
               	movq	0x38(%rsp), %rax
               	movq	0x40(%rsp), %r8
               	addq	%rax, %r8
               	movq	(%rsp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	movq	%r8, 0x20(%rax)
               	addq	$0x18, %rsp
               	retq

<pair>:
               	movq	%rdi, %rax
               	leaq	(%rax,%rax,2), %rdx
               	retq

<fixed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x58, %rsp
               	pushq	%rbx
               	movslq	%edi, %rbx
               	leaq	-0x64(%rbx), %rax
               	movsbq	%al, %rax
               	movb	%al, -0x30(%rbp)
               	imulq	$-0x12c, %rbx, %rax     # imm = 0xFED4
               	movswq	%ax, %rax
               	movw	%ax, -0x28(%rbp)
               	imulq	$0x186a0, %rbx, %rax    # imm = 0x186A0
               	movl	%eax, -0x20(%rbp)
               	movabsq	$0x100000001, %rax      # imm = 0x100000001
               	imulq	%rbx, %rax
               	movq	%rax, -0x18(%rbp)
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rbx, %xmm0
               	vmulss	<rip>, %xmm0, %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rbx, %xmm0
               	vmulsd	<rip>, %xmm0, %xmm1
               	movsd	%xmm1, -0x8(%rbp)
               	vmulsd	<rip>, %xmm0, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x1050(%rbp)
               	movq	%rbx, -0x1038(%rbp)
               	movq	%rbx, %rdx
               	leaq	-0x1030(%rbp), %rdi
               	movl	$0x1000, %esi           # imm = 0x1000
               	callq	<addr>
               	leaq	-0x1038(%rbp), %rdi
               	callq	<addr>
               	movsbq	-0x30(%rbp), %rax
               	incq	%rax
               	movb	%al, -0x30(%rbp)
               	movswq	-0x28(%rbp), %rax
               	subq	$0x2, %rax
               	movw	%ax, -0x28(%rbp)
               	movl	-0x20(%rbp), %eax
               	xorq	$0x55, %rax
               	movl	%eax, -0x20(%rbp)
               	movq	-0x18(%rbp), %rax
               	leaq	-0x1030(%rbp), %rsi
               	movq	-0x8f0(%rbp), %rcx
               	movq	-0x8e8(%rbp), %rdx
               	addq	%rdx, %rcx
               	movq	-0x8e0(%rbp), %rdx
               	addq	%rdx, %rcx
               	movq	-0x8d8(%rbp), %rdx
               	addq	%rdx, %rcx
               	movq	-0x8d0(%rbp), %rdx
               	addq	%rdx, %rcx
               	movq	-0x8c8(%rbp), %rdx
               	addq	%rdx, %rcx
               	movq	-0x8c0(%rbp), %rdx
               	addq	%rdx, %rcx
               	movq	-0x8b8(%rbp), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movq	%rax, -0x18(%rbp)
               	movss	-0x10(%rbp), %xmm0
               	vaddss	<rip>, %xmm0, %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movsd	-0x8(%rbp), %xmm0
               	vmulsd	<rip>, %xmm0, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	fldt	-0x1050(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	vsubsd	<rip>, %xmm0, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x1050(%rbp)
               	movsbq	-0x30(%rbp), %rax
               	leaq	-0x63(%rbx), %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movswq	-0x28(%rbp), %rax
               	imulq	$-0x12c, %rbx, %rcx     # imm = 0xFED4
               	subq	$0x2, %rcx
               	movswq	%cx, %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	-0x20(%rbp), %ecx
               	imulq	$0x186a0, %rbx, %rax    # imm = 0x186A0
               	xorq	$0x55, %rax
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	0x740(%rsi), %rcx
               	xorl	%edx, %edx
               	movq	%rdx, %rdi
               	movq	%rdx, %rsi
               	shlq	$0x3, %rsi
               	leaq	0x7(%rsi), %rax
               	movzbq	(%rcx,%rax), %rax
               	shlq	$0x8, %rax
               	leaq	0x6(%rsi), %r8
               	movzbq	(%rcx,%r8), %r8
               	orq	%r8, %rax
               	shlq	$0x8, %rax
               	leaq	0x5(%rsi), %r8
               	movzbq	(%rcx,%r8), %r8
               	orq	%r8, %rax
               	shlq	$0x8, %rax
               	leaq	0x4(%rsi), %r8
               	movzbq	(%rcx,%r8), %r8
               	orq	%r8, %rax
               	shlq	$0x8, %rax
               	leaq	0x3(%rsi), %r8
               	movzbq	(%rcx,%r8), %r8
               	orq	%r8, %rax
               	shlq	$0x8, %rax
               	leaq	0x2(%rsi), %r8
               	movzbq	(%rcx,%r8), %r8
               	orq	%r8, %rax
               	shlq	$0x8, %rax
               	incq	%rsi
               	movzbq	(%rcx,%rsi), %rsi
               	orq	%rsi, %rax
               	shlq	$0x8, %rax
               	movq	%rdx, %rsi
               	shlq	$0x3, %rsi
               	movzbq	(%rcx,%rsi), %rsi
               	orq	%rsi, %rax
               	addq	%rax, %rdi
               	incq	%rdx
               	cmpl	$0x8, %edx
               	jl	<addr>
               	movq	-0x18(%rbp), %rax
               	movabsq	$0x100000001, %rcx      # imm = 0x100000001
               	imulq	%rbx, %rcx
               	addq	%rdi, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movss	-0x10(%rbp), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rbx, %xmm1
               	movss	<rip>, %xmm2
               	movss	<rip>, %xmm3
               	vfmadd213ss	%xmm3, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + xmm3
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movsd	-0x8(%rbp), %xmm1
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rbx, %xmm0
               	vmulsd	<rip>, %xmm0, %xmm2
               	ucomisd	%xmm2, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	-0x1038(%rbp), %rax
               	leaq	0xb(%rbx), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	fldt	-0x1050(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	movsd	<rip>, %xmm2
               	movsd	<rip>, %xmm3
               	vfmsub213sd	%xmm3, %xmm2, %xmm0 # xmm0 = (xmm2 * xmm0) - xmm3
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

<moving>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x30, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movslq	%edi, %rbx
               	leaq	(%rbx,%rbx,2), %rax
               	movl	%eax, -0x20(%rbp)
               	movq	%rbx, %rax
               	shlq	$0x28, %rax
               	movq	%rax, -0x18(%rbp)
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rbx, %xmm0
               	vdivsd	<rip>, %xmm0, %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	movq	%rbx, %rax
               	shlq	%rax
               	movslq	%eax, %rax
               	movq	%rax, -0x1028(%rbp)
               	movq	%rbx, %rax
               	shlq	$0x4, %rax
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
               	movq	%rbx, %rsi
               	shlq	$0x4, %rsi
               	movq	%r12, %rdi
               	movq	%rbx, %rdx
               	callq	<addr>
               	leaq	0x1(%rbx), %rdx
               	leaq	-0x1020(%rbp), %rdi
               	movl	$0x1000, %esi           # imm = 0x1000
               	callq	<addr>
               	leaq	-0x1028(%rbp), %rdi
               	callq	<addr>
               	movl	-0x20(%rbp), %eax
               	movzbq	0x3(%r12), %rcx
               	addq	%rcx, %rax
               	movl	%eax, -0x20(%rbp)
               	movq	-0x18(%rbp), %rax
               	movq	-0x28(%rbp), %rcx
               	subq	%rcx, %rax
               	movq	%rax, -0x18(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	movl	-0x20(%rbp), %edx
               	leaq	(%rbx,%rbx,2), %rsi
               	leaq	0x3(%rbx), %rax
               	andq	$0xff, %rax
               	addq	%rsi, %rax
               	cmpl	%eax, %edx
               	je	<addr>
               	movl	$0xb, %eax
               	leaq	-0x1040(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x18(%rbp), %rdx
               	movq	%rbx, %rax
               	shlq	$0x28, %rax
               	subq	%rcx, %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0xc, %eax
               	leaq	-0x1040(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movsd	-0x10(%rbp), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rbx, %xmm1
               	vdivsd	<rip>, %xmm1, %xmm1
               	vaddsd	<rip>, %xmm1, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	leaq	-0x1040(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x1028(%rbp), %rax
               	shlq	%rbx
               	leaq	0xb(%rbx), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	leaq	-0x1040(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0x1040(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<wide>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x19, %r11d
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	subq	$0xd58, %rsp            # imm = 0xD58
               	pushq	%rbx
               	movslq	%edi, %rbx
               	movq	%rbx, -0x18(%rbp)
               	movq	%rbx, %rax
               	negq	%rax
               	movl	%eax, -0x10(%rbp)
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rbx, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rbx, %xmm0
               	vdivsd	<rip>, %xmm0, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x19d50(%rbp)
               	movq	%rbx, %rdx
               	leaq	-0x8100(%rbp), %rdi
               	movl	$0x80e8, %esi           # imm = 0x80E8
               	callq	<addr>
               	leaq	0x1(%rbx), %rdx
               	leaq	-0x19d40(%rbp), %rdi
               	movl	$0x9c40, %esi           # imm = 0x9C40
               	callq	<addr>
               	leaq	0x2(%rbx), %rdx
               	leaq	-0x10100(%rbp), %rdi
               	movl	$0x8000, %esi           # imm = 0x8000
               	callq	<addr>
               	movq	-0x18(%rbp), %rax
               	leaq	-0x8100(%rbp), %rcx
               	addq	$0x80e7, %rcx           # imm = 0x80E7
               	movzbq	(%rcx), %rcx
               	imulq	%rcx, %rax
               	movq	%rax, -0x18(%rbp)
               	movl	-0x10(%rbp), %eax
               	leaq	-0x19d40(%rbp), %rcx
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movzbq	(%rcx), %rcx
               	subq	%rcx, %rax
               	movl	%eax, -0x10(%rbp)
               	movss	-0x8(%rbp), %xmm0
               	vmulss	<rip>, %xmm0, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	fldt	-0x19d50(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x19d50(%rbp)
               	movq	-0x18(%rbp), %rcx
               	leaq	0x80e7(%rbx), %rax
               	andq	$0xff, %rax
               	imulq	%rbx, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	-0x10(%rbp), %edx
               	movq	%rbx, %rcx
               	negq	%rcx
               	leaq	0x1(%rbx), %rax
               	addq	$0x3039, %rax           # imm = 0x3039
               	andq	$0xff, %rax
               	subq	%rax, %rcx
               	cmpl	%ecx, %edx
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	leave
               	retq
               	movss	-0x8(%rbp), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rbx, %xmm1
               	vmulss	<rip>, %xmm1, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x17, %eax
               	popq	%rbx
               	leave
               	retq
               	fldt	-0x19d50(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rbx, %xmm1
               	vdivsd	<rip>, %xmm1, %xmm1
               	vaddsd	<rip>, %xmm1, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x18, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x10100(%rbp), %rcx
               	leaq	0x6458(%rcx), %rax
               	movzbq	(%rax), %rdx
               	leaq	0x2(%rbx), %rsi
               	subq	%rcx, %rax
               	addq	%rsi, %rax
               	andq	$0xff, %rax
               	cmpl	%eax, %edx
               	je	<addr>
               	movl	$0x19, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

<results>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x58, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movslq	%edi, %rbx
               	movq	%rbx, %rdx
               	leaq	-0x1000(%rbp), %rdi
               	movl	$0x1000, %esi           # imm = 0x1000
               	callq	<addr>
               	leaq	0x1(%rbx), %rdx
               	leaq	0x2(%rbx), %rcx
               	leaq	0x3(%rbx), %r8
               	leaq	0x4(%rbx), %r9
               	leaq	0x5(%rbx), %rax
               	leaq	0x6(%rbx), %rsi
               	leaq	0x7(%rbx), %rdi
               	leaq	0x8(%rbx), %r12
               	leaq	0x9(%rbx), %r13
               	subq	$0x30, %rsp
               	movq	%rax, (%rsp)
               	movq	%rsi, 0x8(%rsp)
               	movq	%rdi, 0x10(%rsp)
               	movq	%r12, 0x18(%rsp)
               	movq	%r13, 0x20(%rsp)
               	movq	%rbx, %rsi
               	leaq	-0x1028(%rbp), %rdi
               	callq	<addr>
               	addq	$0x30, %rsp
               	movq	-0x1028(%rbp), %r12
               	movq	-0x1020(%rbp), %r13
               	movq	-0x1018(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x1010(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	-0x1008(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	-0x1000(%rbp), %rax
               	leaq	(%rbx,%rax), %rdi
               	callq	<addr>
               	movq	%rbx, %rcx
               	shlq	%rcx
               	leaq	0x1(%rcx), %rsi
               	cmpq	%rsi, %r12
               	jne	<addr>
               	leaq	0x5(%rcx), %rsi
               	cmpq	%rsi, %r13
               	jne	<addr>
               	leaq	0x9(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	0x38(%rsp), %rsi
               	cmpq	%r10, %rsi
               	jne	<addr>
               	addq	$0xd, %rcx
               	movq	%rcx, %r10
               	movq	0x30(%rsp), %rcx
               	cmpq	%r10, %rcx
               	jne	<addr>
               	movq	%rbx, %rcx
               	shlq	%rcx
               	addq	$0x11, %rcx
               	movq	%rcx, %r10
               	movq	0x28(%rsp), %rcx
               	cmpq	%r10, %rcx
               	je	<addr>
               	movl	$0x1f, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	-0x1000(%rbp), %rcx
               	leaq	(%rbx,%rcx), %rsi
               	cmpq	%rsi, %rax
               	jne	<addr>
               	leaq	(%rbx,%rcx), %rax
               	leaq	(%rax,%rax,2), %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x20, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<main>:
               	pushq	%rbx
               	movl	<rip>, %ebx # <addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	retq
               	movq	%rbx, %rdi
               	popq	%rbx
               	jmp	<addr>
