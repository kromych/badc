
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
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movslq	-0xd0(%rbp), %rcx
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
               	movq	%r10, %rdx
               	leaq	-0xe0(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movabsq	$0x4059000000000000, %rdx # imm = 0x4059000000000000
               	movss	(%rcx), %xmm1
               	movl	$0x41200000, %esi       # imm = 0x41200000
               	movq	%rsi, %xmm15
               	mulss	%xmm15, %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rdx, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movss	0xc(%rcx), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	addsd	%xmm1, %xmm0
               	incq	%rax
               	movslq	-0xd0(%rbp), %rcx
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
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movslq	-0xd0(%rbp), %rcx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, %r11
               	movq	0x8(%r11), %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	movq	%r10, 0x8(%r11)
               	addq	$0x20, 0x8(%r11)
               	movq	%r10, %rdx
               	leaq	-0xf0(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movabsq	$0x408f400000000000, %rdx # imm = 0x408F400000000000
               	movss	0xc(%rcx), %xmm1
               	movl	$0x42c80000, %esi       # imm = 0x42C80000
               	movq	%rsi, %xmm15
               	mulss	%xmm15, %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rdx, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movslq	0x14(%rcx), %rdx
               	imulq	$0xa, %rdx, %rdx
               	movslq	%edx, %rdx
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rdx, %xmm1
               	addsd	%xmm1, %xmm0
               	movss	(%rcx), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	addsd	%xmm1, %xmm0
               	incq	%rax
               	movslq	-0xd0(%rbp), %rcx
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
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movslq	-0xe0(%rbp), %rcx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	leaq	-0x30(%rbp), %rcx
               	movq	%rcx, %r11
               	movq	0x8(%r11), %r10
               	addq	$0x18, 0x8(%r11)
               	movq	%r10, %rdx
               	leaq	-0x18(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	0x10(%rdx), %r10
               	movq	%r10, 0x10(%rcx)
               	movabsq	$0x408f400000000000, %rdx # imm = 0x408F400000000000
               	movss	(%rcx), %xmm1
               	movl	$0x42c80000, %esi       # imm = 0x42C80000
               	movq	%rsi, %xmm15
               	mulss	%xmm15, %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rdx, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movss	0xc(%rcx), %xmm1
               	movl	$0x41200000, %edx       # imm = 0x41200000
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	addsd	%xmm1, %xmm0
               	movss	0x10(%rcx), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	addsd	%xmm1, %xmm0
               	incq	%rax
               	movslq	-0xe0(%rbp), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	leaq	-0x30(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x80(%rbp), %rax
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xa0(%rbp), %rax
               	leaq	-0x80(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x10(%rax), %rcx
               	leaq	-0x80(%rbp), %rax
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rcx
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rax)
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	0x8(%rcx), %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rax)
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	addq	$0x10, %rcx
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rax)
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x40(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rax)
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0x8(%rcx)
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	(%rax), %xmm0
               	leaq	-0x80(%rbp), %rax
               	movups	%xmm0, (%rax)
               	movss	(%rax), %xmm0
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	-0x80(%rbp), %rax
               	movss	0xc(%rax), %xmm0
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rax
               	leaq	-0x60(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x10(%rax), %rdx
               	leaq	-0x60(%rbp), %rcx
               	leaq	<rip>, %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	0x10(%rax), %rsi
               	movq	0x18(%rax), %rdi
               	leaq	-0x80(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	movss	(%rax), %xmm0
               	movl	$0x3f800000, %ecx       # imm = 0x3F800000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0xc(%rax), %xmm0
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movslq	0x18(%rax), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rax)
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	0x8(%rcx), %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rax)
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	addq	$0x10, %rcx
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rax)
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	0x10(%rax), %rsi
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movss	(%rax), %xmm0
               	movl	$0x3f800000, %ecx       # imm = 0x3F800000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x8(%rax), %xmm0
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x10(%rax), %xmm0
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rax
               	leaq	-0x80(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	movss	(%rax), %xmm0
               	movl	$0x42c80000, %edx       # imm = 0x42C80000
               	movss	0xc(%rax), %xmm1
               	movl	$0x41200000, %eax       # imm = 0x41200000
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rdx, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	movabsq	$0x4075480000000000, %rax # imm = 0x4075480000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rax
               	leaq	-0x60(%rbp), %rsi
               	leaq	<rip>, %rdi
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x10(%rax), %rdi
               	leaq	-0x60(%rbp), %rsi
               	leaq	<rip>, %r8
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	movss	0xc(%rax), %xmm0
               	movslq	0x18(%rax), %rax
               	imulq	$0xa, %rax, %rax
               	movslq	%eax, %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rax, %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rdx, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	movabsq	$0x407c280000000000, %rax # imm = 0x407C280000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rax)
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	0x8(%rcx), %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rax)
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	addq	$0x10, %rcx
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rax)
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x18(%rbp), %rax
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	movss	(%rax), %xmm0
               	movl	$0x42c80000, %edx       # imm = 0x42C80000
               	movss	0x8(%rax), %xmm1
               	movl	$0x41200000, %esi       # imm = 0x41200000
               	movq	%rsi, %xmm15
               	mulss	%xmm15, %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rdx, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movss	0x14(%rax), %xmm1
               	addss	%xmm1, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	movabsq	$0x4075980000000000, %rax # imm = 0x4075980000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	leaq	-0x40(%rbp), %rax
               	movss	0x4(%rax), %xmm0
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movsd	0x8(%rax), %xmm1
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	movabsq	$0x406cd00000000000, %rax # imm = 0x406CD00000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
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
               	movabsq	$0x40fd97c000000000, %rax # imm = 0x40FD97C000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
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
               	movabsq	$0x41ab909dfe000000, %rax # imm = 0x41AB909DFE000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
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
               	movabsq	$0x42de7fa25ab55d80, %rax # imm = 0x42DE7FA25AB55D80
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
