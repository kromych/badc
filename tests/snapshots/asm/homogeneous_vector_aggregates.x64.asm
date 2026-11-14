
homogeneous_vector_aggregates.x64:	file format elf64-x86-64

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

<sum_v1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xa0(%rbp)
               	movups	%xmm1, -0x90(%rbp)
               	movups	%xmm2, -0x80(%rbp)
               	movups	%xmm3, -0x70(%rbp)
               	movups	%xmm4, -0x60(%rbp)
               	movups	%xmm5, -0x50(%rbp)
               	movups	%xmm6, -0x40(%rbp)
               	movups	%xmm7, -0x30(%rbp)
               	xorl	%eax, %eax
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0xd0(%rbp), %rdx
               	movl	$0x8, (%rcx)
               	movl	$0x30, 0x4(%rcx)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rcx)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rcx)
               	xorps	%xmm0, %xmm0
               	movl	-0xd0(%rbp), %ecx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, 0x4(%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	movq	%r10, 0x8(%r11)
               	addq	$0x10, 0x8(%r11)
               	movq	%r10, %rcx
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movsd	<rip>, %xmm1
               	movss	-0xe0(%rbp), %xmm2
               	movss	<rip>, %xmm3
               	mulss	%xmm3, %xmm2
               	cvtss2sd	%xmm2, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	-0xd4(%rbp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	addsd	%xmm1, %xmm0
               	incq	%rax
               	movl	-0xd0(%rbp), %ecx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	leave
               	retq

<sum_s2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xa0(%rbp)
               	movups	%xmm1, -0x90(%rbp)
               	movups	%xmm2, -0x80(%rbp)
               	movups	%xmm3, -0x70(%rbp)
               	movups	%xmm4, -0x60(%rbp)
               	movups	%xmm5, -0x50(%rbp)
               	movups	%xmm6, -0x40(%rbp)
               	movups	%xmm7, -0x30(%rbp)
               	xorl	%eax, %eax
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0xd0(%rbp), %rdx
               	movl	$0x8, (%rcx)
               	movl	$0x30, 0x4(%rcx)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rcx)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rcx)
               	xorps	%xmm0, %xmm0
               	movl	-0xd0(%rbp), %ecx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, %r11
               	movq	0x8(%r11), %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	movq	%r10, 0x8(%r11)
               	addq	$0x20, 0x8(%r11)
               	movq	%r10, %rcx
               	leaq	-0xf0(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movsd	<rip>, %xmm1
               	movss	-0xe4(%rbp), %xmm2
               	movss	<rip>, %xmm3
               	mulss	%xmm3, %xmm2
               	cvtss2sd	%xmm2, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movl	-0xdc(%rbp), %ecx
               	imulq	$0xa, %rcx, %rcx
               	movslq	%ecx, %rcx
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rcx, %xmm1
               	addsd	%xmm1, %xmm0
               	movss	-0xf0(%rbp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	addsd	%xmm1, %xmm0
               	incq	%rax
               	movl	-0xd0(%rbp), %ecx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	leave
               	retq

<sum_d3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	movq	%rdi, -0xe0(%rbp)
               	movq	%rsi, -0xd8(%rbp)
               	movq	%rdx, -0xd0(%rbp)
               	movq	%rcx, -0xc8(%rbp)
               	movq	%r8, -0xc0(%rbp)
               	movq	%r9, -0xb8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xb0(%rbp)
               	movups	%xmm1, -0xa0(%rbp)
               	movups	%xmm2, -0x90(%rbp)
               	movups	%xmm3, -0x80(%rbp)
               	movups	%xmm4, -0x70(%rbp)
               	movups	%xmm5, -0x60(%rbp)
               	movups	%xmm6, -0x50(%rbp)
               	movups	%xmm7, -0x40(%rbp)
               	xorl	%eax, %eax
               	leaq	-0x30(%rbp), %rcx
               	leaq	-0xe0(%rbp), %rdx
               	movl	$0x8, (%rcx)
               	movl	$0x30, 0x4(%rcx)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rcx)
               	leaq	-0xe0(%rbp), %r10
               	movq	%r10, 0x10(%rcx)
               	xorps	%xmm0, %xmm0
               	movl	-0xe0(%rbp), %ecx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	leaq	-0x30(%rbp), %rcx
               	movq	%rcx, %r11
               	movq	0x8(%r11), %r10
               	addq	$0x18, 0x8(%r11)
               	movq	%r10, %rcx
               	leaq	-0x18(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rdx)
               	movsd	<rip>, %xmm1
               	movss	-0x18(%rbp), %xmm2
               	movss	<rip>, %xmm3
               	mulss	%xmm3, %xmm2
               	cvtss2sd	%xmm2, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	-0xc(%rbp), %xmm1
               	movss	<rip>, %xmm2
               	mulss	%xmm2, %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	addsd	%xmm1, %xmm0
               	movss	-0x8(%rbp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	addsd	%xmm1, %xmm0
               	incq	%rax
               	movl	-0xe0(%rbp), %ecx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	leaq	-0x30(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm0
               	movups	%xmm0, -0xb0(%rbp)
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm0
               	movups	%xmm0, -0xa0(%rbp)
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm0
               	movups	%xmm0, -0x90(%rbp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, -0x30(%rbp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, -0x28(%rbp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, -0x20(%rbp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, -0x40(%rbp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, -0x38(%rbp)
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm1
               	vpermilps	$0x0, %xmm1, %xmm2 # xmm2 = xmm1[0,0,0,0]
               	movss	<rip>, %xmm0
               	ucomiss	%xmm0, %xmm2
               	jp	<addr>
               	jne	<addr>
               	vpermilps	$0x3, %xmm1, %xmm2 # xmm2 = xmm1[3,0,0,0]
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm2
               	movups	%xmm2, -0x60(%rbp)
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm2
               	movups	%xmm2, -0x50(%rbp)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movss	-0x80(%rbp), %xmm2
               	ucomiss	%xmm0, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movss	-0x74(%rbp), %xmm2
               	ucomiss	%xmm1, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movl	-0x68(%rbp), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movsd	<rip>, %xmm1
               	movsd	<rip>, %xmm2
               	movsd	<rip>, %xmm3
               	movsd	%xmm1, -0x18(%rbp)
               	movsd	%xmm2, -0x10(%rbp)
               	movsd	%xmm3, -0x8(%rbp)
               	movss	-0x18(%rbp), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movss	-0x10(%rbp), %xmm0
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x8(%rbp), %xmm0
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm0
               	movsd	<rip>, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm3 # xmm3 = xmm0[0,0,0,0]
               	movss	<rip>, %xmm2
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	movss	<rip>, %xmm4
               	mulss	%xmm4, %xmm0
               	vfmadd231ss	%xmm2, %xmm3, %xmm0 # xmm0 = (xmm3 * xmm2) + xmm0
               	cvtss2sd	%xmm0, %xmm0
               	addsd	%xmm1, %xmm0
               	movsd	<rip>, %xmm3
               	ucomisd	%xmm3, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm0
               	movups	%xmm0, -0x60(%rbp)
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm3
               	movups	%xmm3, -0x50(%rbp)
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	movss	<rip>, %xmm3
               	vfmadd213ss	%xmm3, %xmm2, %xmm0 # xmm0 = (xmm2 * xmm0) + xmm3
               	cvtss2sd	%xmm0, %xmm0
               	addsd	%xmm1, %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, -0x18(%rbp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movsd	<rip>, %xmm0
               	movss	-0x18(%rbp), %xmm2
               	movss	<rip>, %xmm1
               	movss	-0x10(%rbp), %xmm3
               	movss	<rip>, %xmm4
               	mulss	%xmm4, %xmm3
               	vfmadd213ss	%xmm3, %xmm1, %xmm2 # xmm2 = (xmm1 * xmm2) + xmm3
               	movss	-0x4(%rbp), %xmm3
               	addss	%xmm3, %xmm2
               	cvtss2sd	%xmm2, %xmm2
               	addsd	%xmm0, %xmm2
               	movsd	<rip>, %xmm3
               	ucomisd	%xmm3, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movss	-0x3c(%rbp), %xmm2
               	vmulss	%xmm1, %xmm2, %xmm1
               	movsd	-0x38(%rbp), %xmm2
               	movsd	<rip>, %xmm3
               	cvtss2sd	%xmm1, %xmm1
               	vfmadd231sd	%xmm3, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm3) + xmm1
               	vaddsd	%xmm0, %xmm1, %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movl	$0x3, %edi
               	leaq	-0xb0(%rbp), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	movq	%r9, %r10
               	movups	(%r10), %xmm2
               	movb	$0x3, %al
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movl	$0x3, %edi
               	leaq	-0xa0(%rbp), %r9
               	subq	$0x60, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x60, %rsp
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movl	$0x5, %edi
               	leaq	-0x30(%rbp), %r9
               	subq	$0x80, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x60(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x68(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x70(%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x80, %rsp
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
