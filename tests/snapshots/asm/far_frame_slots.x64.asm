
far_frame_slots.x64:	file format elf64-x86-64

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

<fill>:
               	xorl	%eax, %eax
               	cmpq	%rsi, %rax
               	jae	<addr>
               	leaq	(%rdx,%rax), %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdi,%rax)
               	incq	%rax
               	cmpq	%rsi, %rax
               	jb	<addr>
               	retq

<bump>:
               	movq	(%rdi), %rax
               	addq	$0xb, %rax
               	movq	%rax, (%rdi)
               	retq

<make>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rdi, -0x60(%rbp)
               	addq	%rsi, %rdx
               	addq	%r8, %rcx
               	movq	0x10(%rbp), %rax
               	leaq	(%r9,%rax), %rsi
               	movq	0x18(%rbp), %rax
               	movq	0x20(%rbp), %rdi
               	addq	%rax, %rdi
               	movq	0x28(%rbp), %rax
               	movq	0x30(%rbp), %r8
               	addq	%rax, %r8
               	movq	-0x60(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	movq	%r8, 0x20(%rax)
               	leave
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
               	movb	%al, -0x1038(%rbp)
               	imulq	$-0x12c, %rbx, %rax     # imm = 0xFED4
               	movswq	%ax, %rax
               	movw	%ax, -0x1030(%rbp)
               	imulq	$0x186a0, %rbx, %rax    # imm = 0x186A0
               	movl	%eax, -0x1028(%rbp)
               	movabsq	$0x100000001, %rax      # imm = 0x100000001
               	imulq	%rbx, %rax
               	movq	%rax, -0x1020(%rbp)
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rbx, %xmm0
               	movl	$0x3f000000, %eax       # imm = 0x3F000000
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, -0x1018(%rbp)
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rbx, %xmm0
               	movabsq	$0x3fd0000000000000, %rax # imm = 0x3FD0000000000000
               	movq	%rax, %xmm15
               	movapd	%xmm0, %xmm1
               	mulsd	%xmm15, %xmm1
               	movsd	%xmm1, -0x1010(%rbp)
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x1050(%rbp)
               	movq	%rbx, -0x8(%rbp)
               	leaq	-0x1008(%rbp), %rdi
               	movl	$0x1000, %esi           # imm = 0x1000
               	movq	%rbx, %rdx
               	callq	<addr>
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	movsbq	-0x1038(%rbp), %rax
               	incq	%rax
               	movb	%al, -0x1038(%rbp)
               	movswq	-0x1030(%rbp), %rax
               	subq	$0x2, %rax
               	movw	%ax, -0x1030(%rbp)
               	movslq	-0x1028(%rbp), %rax
               	xorq	$0x55, %rax
               	movl	%eax, -0x1028(%rbp)
               	movq	-0x1020(%rbp), %rcx
               	leaq	-0x1008(%rbp), %rax
               	addq	$0x740, %rax            # imm = 0x740
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x10(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x18(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x20(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x28(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x30(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x38(%rax), %rsi
               	addq	%rsi, %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, -0x1020(%rbp)
               	movss	-0x1018(%rbp), %xmm0
               	movl	$0x3f800000, %ecx       # imm = 0x3F800000
               	movq	%rcx, %xmm15
               	addss	%xmm15, %xmm0
               	movss	%xmm0, -0x1018(%rbp)
               	movsd	-0x1010(%rbp), %xmm0
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm15
               	mulsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x1010(%rbp)
               	fldt	-0x1050(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	movq	%rcx, %xmm15
               	subsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x1050(%rbp)
               	movsbq	-0x1038(%rbp), %rcx
               	leaq	-0x63(%rbx), %rdx
               	movsbq	%dl, %rdx
               	cmpl	%edx, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movswq	-0x1030(%rbp), %rcx
               	imulq	$-0x12c, %rbx, %rdx     # imm = 0xFED4
               	subq	$0x2, %rdx
               	movswq	%dx, %rdx
               	cmpl	%edx, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movslq	-0x1028(%rbp), %rcx
               	imulq	$0x186a0, %rbx, %rdx    # imm = 0x186A0
               	movslq	%edx, %rdx
               	xorq	$0x55, %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	0x7(%rdx), %rdi
               	movzbq	(%rax,%rdi), %rdi
               	shlq	$0x8, %rdi
               	leaq	0x6(%rdx), %r8
               	movzbq	(%rax,%r8), %r8
               	orq	%r8, %rdi
               	shlq	$0x8, %rdi
               	leaq	0x5(%rdx), %r8
               	movzbq	(%rax,%r8), %r8
               	orq	%r8, %rdi
               	shlq	$0x8, %rdi
               	leaq	0x4(%rdx), %r8
               	movzbq	(%rax,%r8), %r8
               	orq	%r8, %rdi
               	shlq	$0x8, %rdi
               	addq	$0x3, %rdx
               	movzbq	(%rax,%rdx), %rdx
               	orq	%rdi, %rdx
               	movq	%rdx, %rdi
               	shlq	$0x8, %rdi
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	0x2(%rdx), %r8
               	movzbq	(%rax,%r8), %r8
               	orq	%r8, %rdi
               	shlq	$0x8, %rdi
               	leaq	0x1(%rdx), %r8
               	movzbq	(%rax,%r8), %r8
               	orq	%r8, %rdi
               	shlq	$0x8, %rdi
               	movzbq	(%rax,%rdx), %rdx
               	orq	%rdi, %rdx
               	addq	%rdx, %rsi
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jl	<addr>
               	movq	-0x1020(%rbp), %rax
               	movabsq	$0x100000001, %rcx      # imm = 0x100000001
               	imulq	%rbx, %rcx
               	addq	%rsi, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movss	-0x1018(%rbp), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rbx, %xmm1
               	movl	$0x3f000000, %eax       # imm = 0x3F000000
               	movl	$0x3f800000, %ecx       # imm = 0x3F800000
               	movapd	%xmm1, %xmm14
               	movq	%rax, %xmm15
               	movq	%rcx, %xmm1
               	vfmadd231ss	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movsd	-0x1010(%rbp), %xmm1
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rbx, %xmm0
               	movabsq	$0x3fe8000000000000, %rax # imm = 0x3FE8000000000000
               	movq	%rax, %xmm15
               	movapd	%xmm0, %xmm2
               	mulsd	%xmm15, %xmm2
               	ucomisd	%xmm2, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	-0x8(%rbp), %rax
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
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movq	%rcx, %xmm0
               	vfmsub231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) - xmm0
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
               	movl	%eax, -0x1028(%rbp)
               	movq	%rbx, %rax
               	shlq	$0x28, %rax
               	movq	%rax, -0x1020(%rbp)
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rbx, %xmm0
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x1018(%rbp)
               	movq	%rbx, %rax
               	shlq	%rax
               	movslq	%eax, %rax
               	movq	%rax, -0x8(%rbp)
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
               	leaq	-0x1008(%rbp), %rdi
               	movl	$0x1000, %esi           # imm = 0x1000
               	leaq	0x1(%rbx), %rdx
               	callq	<addr>
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	movslq	-0x1028(%rbp), %rax
               	movzbq	0x3(%r12), %rcx
               	addq	%rcx, %rax
               	movl	%eax, -0x1028(%rbp)
               	movq	-0x1020(%rbp), %rcx
               	leaq	-0x1008(%rbp), %rax
               	movq	0xff8(%rax), %rdx
               	subq	%rdx, %rcx
               	movq	%rcx, -0x1020(%rbp)
               	movsd	-0x1018(%rbp), %xmm0
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x1018(%rbp)
               	movslq	-0x1028(%rbp), %rdx
               	leaq	(%rbx,%rbx,2), %rsi
               	leaq	0x3(%rbx), %rdi
               	andq	$0xff, %rdi
               	addq	%rdi, %rsi
               	cmpl	%esi, %edx
               	je	<addr>
               	movl	$0xb, %eax
               	leaq	-0x1040(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x1020(%rbp), %rdx
               	movq	%rbx, %rsi
               	shlq	$0x28, %rsi
               	movq	0xff8(%rax), %rax
               	subq	%rax, %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0xc, %eax
               	leaq	-0x1040(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movsd	-0x1018(%rbp), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rbx, %xmm1
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm1
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	leaq	-0x1040(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x8(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	%rcx
               	addq	$0xb, %rcx
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
               	movq	%rbx, -0x10100(%rbp)
               	movq	%rbx, %rax
               	negq	%rax
               	movl	%eax, -0x100f8(%rbp)
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rbx, %xmm0
               	movss	%xmm0, -0x100f0(%rbp)
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rbx, %xmm0
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x19d50(%rbp)
               	leaq	-0x100e8(%rbp), %rdi
               	movl	$0x80e8, %esi           # imm = 0x80E8
               	movq	%rbx, %rdx
               	callq	<addr>
               	leaq	-0x19d40(%rbp), %rdi
               	movl	$0x9c40, %esi           # imm = 0x9C40
               	leaq	0x1(%rbx), %rdx
               	callq	<addr>
               	leaq	-0x8000(%rbp), %rdi
               	movl	$0x8000, %esi           # imm = 0x8000
               	leaq	0x2(%rbx), %rdx
               	callq	<addr>
               	movq	-0x10100(%rbp), %rax
               	leaq	-0x100e8(%rbp), %rcx
               	addq	$0x80e7, %rcx           # imm = 0x80E7
               	movzbq	(%rcx), %rcx
               	imulq	%rcx, %rax
               	movq	%rax, -0x10100(%rbp)
               	movslq	-0x100f8(%rbp), %rax
               	leaq	-0x19d40(%rbp), %rcx
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movzbq	(%rcx), %rcx
               	subq	%rcx, %rax
               	movl	%eax, -0x100f8(%rbp)
               	movss	-0x100f0(%rbp), %xmm0
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, -0x100f0(%rbp)
               	fldt	-0x19d50(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x19d50(%rbp)
               	movq	-0x10100(%rbp), %rdx
               	leaq	0x80e7(%rbx), %rsi
               	andq	$0xff, %rsi
               	imulq	%rbx, %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	leave
               	retq
               	movslq	-0x100f8(%rbp), %rdx
               	movq	%rbx, %rsi
               	negq	%rsi
               	leaq	0x1(%rbx), %rdi
               	addq	$0x3039, %rdi           # imm = 0x3039
               	andq	$0xff, %rdi
               	subq	%rdi, %rsi
               	cmpl	%esi, %edx
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	leave
               	retq
               	movss	-0x100f0(%rbp), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rbx, %xmm1
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm1
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
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm1
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x18, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x8000(%rbp), %rax
               	leaq	0x6458(%rax), %rcx
               	movzbq	(%rcx), %rdx
               	leaq	0x2(%rbx), %rsi
               	subq	%rax, %rcx
               	leaq	(%rsi,%rcx), %rax
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
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movslq	%edi, %rbx
               	leaq	-0x1028(%rbp), %rdi
               	movl	$0x1000, %esi           # imm = 0x1000
               	movq	%rbx, %rdx
               	callq	<addr>
               	leaq	-0x28(%rbp), %rdi
               	leaq	0x1(%rbx), %rdx
               	leaq	0x2(%rbx), %rcx
               	leaq	0x3(%rbx), %r8
               	leaq	0x4(%rbx), %r9
               	leaq	0x5(%rbx), %rax
               	leaq	0x6(%rbx), %rsi
               	leaq	0x7(%rbx), %r12
               	leaq	0x8(%rbx), %r13
               	leaq	0x9(%rbx), %r14
               	subq	$0x30, %rsp
               	movq	%rax, (%rsp)
               	movq	%rsi, 0x8(%rsp)
               	movq	%r12, 0x10(%rsp)
               	movq	%r13, 0x18(%rsp)
               	movq	%r14, 0x20(%rsp)
               	movq	%rbx, %rsi
               	callq	<addr>
               	addq	$0x30, %rsp
               	leaq	-0x28(%rbp), %rax
               	movq	(%rax), %r12
               	movq	0x8(%rax), %r13
               	movq	0x10(%rax), %r14
               	movq	0x18(%rax), %r15
               	movq	0x20(%rax), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x1028(%rbp), %rax
               	leaq	(%rbx,%rax), %rdi
               	callq	<addr>
               	movq	%rax, -0x1038(%rbp)
               	leaq	-0x1038(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x1038(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	%rbx, %rax
               	shlq	%rax
               	leaq	0x1(%rax), %rsi
               	cmpq	%rsi, %r12
               	jne	<addr>
               	addq	$0x5, %rax
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rax
               	shlq	%rax
               	leaq	0x9(%rax), %rsi
               	cmpq	%rsi, %r14
               	jne	<addr>
               	leaq	0xd(%rax), %rsi
               	cmpq	%rsi, %r15
               	jne	<addr>
               	addq	$0x11, %rax
               	movq	%rax, %r10
               	movq	0x38(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	-0x1028(%rbp), %rax
               	movq	(%rax), %rsi
               	addq	%rbx, %rsi
               	cmpq	%rsi, %rcx
               	jne	<addr>
               	movq	(%rax), %rax
               	addq	%rbx, %rax
               	leaq	(%rax,%rax,2), %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x20, %eax
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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	popq	%rbx
               	leave
               	retq
