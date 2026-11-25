
homogeneous_vector_aggregates.x64:	file format elf64-x86-64

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
               	movss	(%rcx), %xmm1
               	vmulss	<rip>, %xmm1, %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	vfmadd231sd	<rip>, %xmm0, %xmm1 # xmm1 = (xmm0 * mem) + xmm1
               	movss	0xc(%rcx), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	vaddsd	%xmm0, %xmm1, %xmm0
               	incq	%rax
               	movl	-0xd0(%rbp), %ecx
               	nopl	(%rax)
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
               	movss	0xc(%rcx), %xmm1
               	vmulss	<rip>, %xmm1, %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	vfmadd231sd	<rip>, %xmm0, %xmm1 # xmm1 = (xmm0 * mem) + xmm1
               	movl	0x14(%rcx), %edx
               	imulq	$0xa, %rdx, %rdx
               	movslq	%edx, %rdx
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rdx, %xmm0
               	vaddsd	%xmm0, %xmm1, %xmm0
               	movss	(%rcx), %xmm1
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
               	movss	(%rcx), %xmm1
               	vmulss	<rip>, %xmm1, %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	vfmadd231sd	<rip>, %xmm0, %xmm1 # xmm1 = (xmm0 * mem) + xmm1
               	movss	0xc(%rcx), %xmm0
               	vmulss	<rip>, %xmm0, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	vaddsd	%xmm0, %xmm1, %xmm0
               	movss	0x10(%rcx), %xmm1
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
               	subq	$0xb8, %rsp
               	subq	$0x80, %rsp
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm0
               	movups	%xmm0, 0x90(%rsp)
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm0
               	movups	%xmm0, 0xa0(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x100(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x108(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x110(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0xf0(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0xf8(%rsp)
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm1
               	vpermilps	$0x0, %xmm1, %xmm2 # xmm2 = xmm1[0,0,0,0]
               	ucomiss	<rip>, %xmm2
               	jp	<addr>
               	jne	<addr>
               	vpermilps	$0x3, %xmm1, %xmm1 # xmm1 = xmm1[3,0,0,0]
               	ucomiss	<rip>, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x80, %rsp
               	addq	$0xb8, %rsp
               	retq
               	leaq	0xd0(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm0
               	movups	%xmm0, 0xd0(%rsp)
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm0
               	movups	%xmm0, 0xe0(%rsp)
               	leaq	0xb0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movss	0xb0(%rsp), %xmm0
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0xbc(%rsp), %xmm0
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	0xc8(%rsp), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x80, %rsp
               	addq	$0xb8, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	movsd	<rip>, %xmm2
               	movsd	%xmm0, 0x118(%rsp)
               	movsd	%xmm1, 0x120(%rsp)
               	movsd	%xmm2, 0x128(%rsp)
               	movss	0x118(%rsp), %xmm0
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x120(%rsp), %xmm0
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x128(%rsp), %xmm0
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x80, %rsp
               	addq	$0xb8, %rsp
               	retq
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm0
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	movss	<rip>, %xmm1
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	vmulss	<rip>, %xmm0, %xmm0
               	vfmadd231ss	%xmm1, %xmm2, %xmm0 # xmm0 = (xmm2 * xmm1) + xmm0
               	cvtss2sd	%xmm0, %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x80, %rsp
               	addq	$0xb8, %rsp
               	retq
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm0
               	movups	%xmm0, 0xd0(%rsp)
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm2
               	movups	%xmm2, 0xe0(%rsp)
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	movss	<rip>, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	cvtss2sd	%xmm0, %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x80, %rsp
               	addq	$0xb8, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x118(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x120(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x128(%rsp)
               	movss	0x118(%rsp), %xmm1
               	movss	0x120(%rsp), %xmm0
               	vmulss	<rip>, %xmm0, %xmm0
               	vfmadd231ss	<rip>, %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
               	movss	0x12c(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x80, %rsp
               	addq	$0xb8, %rsp
               	retq
               	movss	0xf4(%rsp), %xmm0
               	vmulss	<rip>, %xmm0, %xmm0
               	movsd	0xf8(%rsp), %xmm1
               	cvtss2sd	%xmm0, %xmm0
               	vfmadd231sd	<rip>, %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x80, %rsp
               	addq	$0xb8, %rsp
               	retq
               	leaq	0x80(%rsp), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	movq	%r9, %r10
               	movups	(%r10), %xmm2
               	movl	$0x3, %edi
               	movb	$0x3, %al
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x80, %rsp
               	addq	$0xb8, %rsp
               	retq
               	leaq	0x90(%rsp), %r9
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
               	movl	$0x3, %edi
               	movb	$0x0, %al
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x80, %rsp
               	addq	$0xb8, %rsp
               	retq
               	leaq	0x100(%rsp), %r9
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
               	movl	$0x5, %edi
               	movb	$0x0, %al
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x80, %rsp
               	addq	$0xb8, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x80, %rsp
               	addq	$0xb8, %rsp
               	retq
