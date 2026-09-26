
variadic_hfa_va_arg.x64:	file format elf64-x86-64

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

<sum_d2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	movq	%rdi, -0xf0(%rbp)
               	movq	%rsi, -0xe8(%rbp)
               	movq	%rdx, -0xe0(%rbp)
               	movq	%rcx, -0xd8(%rbp)
               	movq	%r8, -0xd0(%rbp)
               	movq	%r9, -0xc8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xc0(%rbp)
               	movups	%xmm1, -0xb0(%rbp)
               	movups	%xmm2, -0xa0(%rbp)
               	movups	%xmm3, -0x90(%rbp)
               	movups	%xmm4, -0x80(%rbp)
               	movups	%xmm5, -0x70(%rbp)
               	movups	%xmm6, -0x60(%rbp)
               	movups	%xmm7, -0x50(%rbp)
               	xorl	%eax, %eax
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	movl	$0x8, (%rcx)
               	movl	$0x30, 0x4(%rcx)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rcx)
               	leaq	-0xf0(%rbp), %r10
               	movq	%r10, 0x10(%rcx)
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movslq	-0xf0(%rbp), %rcx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movq	%rcx, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0x90, %r10
               	ja	<addr>
               	pushq	%rax
               	movl	0x4(%r11), %r10d
               	addq	0x10(%r11), %r10
               	movq	(%r10), %r10
               	movq	%r10, (%rdx)
               	addl	$0x10, 0x4(%r11)
               	movl	0x4(%r11), %r10d
               	addq	0x10(%r11), %r10
               	movq	(%r10), %r10
               	movq	%r10, 0x8(%rdx)
               	addl	$0x10, 0x4(%r11)
               	movq	%rdx, %r10
               	popq	%rax
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x10, 0x8(%r11)
               	movq	%r10, %rdx
               	leaq	-0x38(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movabsq	$0x4059000000000000, %rdx # imm = 0x4059000000000000
               	movsd	(%rcx), %xmm1
               	movabsq	$0x4024000000000000, %rsi # imm = 0x4024000000000000
               	movq	%rsi, %xmm15
               	mulsd	%xmm15, %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rdx, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movsd	0x8(%rcx), %xmm1
               	addsd	%xmm1, %xmm0
               	incq	%rax
               	movslq	-0xf0(%rbp), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	leaq	-0x28(%rbp), %rax
               	leave
               	retq

<sum_f4>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	movq	%rdi, -0xf0(%rbp)
               	movq	%rsi, -0xe8(%rbp)
               	movq	%rdx, -0xe0(%rbp)
               	movq	%rcx, -0xd8(%rbp)
               	movq	%r8, -0xd0(%rbp)
               	movq	%r9, -0xc8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xc0(%rbp)
               	movups	%xmm1, -0xb0(%rbp)
               	movups	%xmm2, -0xa0(%rbp)
               	movups	%xmm3, -0x90(%rbp)
               	movups	%xmm4, -0x80(%rbp)
               	movups	%xmm5, -0x70(%rbp)
               	movups	%xmm6, -0x60(%rbp)
               	movups	%xmm7, -0x50(%rbp)
               	xorl	%eax, %eax
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	movl	$0x8, (%rcx)
               	movl	$0x30, 0x4(%rcx)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rcx)
               	leaq	-0xf0(%rbp), %r10
               	movq	%r10, 0x10(%rcx)
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movslq	-0xf0(%rbp), %rcx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movq	%rcx, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0x90, %r10
               	ja	<addr>
               	pushq	%rax
               	movl	0x4(%r11), %r10d
               	addq	0x10(%r11), %r10
               	movq	(%r10), %r10
               	movq	%r10, (%rdx)
               	addl	$0x10, 0x4(%r11)
               	movl	0x4(%r11), %r10d
               	addq	0x10(%r11), %r10
               	movq	(%r10), %r10
               	movq	%r10, 0x8(%rdx)
               	addl	$0x10, 0x4(%r11)
               	movq	%rdx, %r10
               	popq	%rax
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x10, 0x8(%r11)
               	movq	%r10, %rdx
               	leaq	-0x38(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movabsq	$0x40c3880000000000, %rdx # imm = 0x40C3880000000000
               	movss	(%rcx), %xmm1
               	movl	$0x447a0000, %esi       # imm = 0x447A0000
               	movq	%rsi, %xmm15
               	mulss	%xmm15, %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rdx, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movss	0x4(%rcx), %xmm1
               	movl	$0x42c80000, %edx       # imm = 0x42C80000
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	addsd	%xmm1, %xmm0
               	movss	0x8(%rcx), %xmm1
               	movl	$0x41200000, %edx       # imm = 0x41200000
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	addsd	%xmm1, %xmm0
               	movss	0xc(%rcx), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	addsd	%xmm1, %xmm0
               	incq	%rax
               	movslq	-0xf0(%rbp), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	leaq	-0x28(%rbp), %rax
               	leave
               	retq

<straddle>:
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
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xe0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xe0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, 0x4(%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rax
               	movsd	(%rax), %xmm0
               	xorl	%eax, %eax
               	movslq	-0xe0(%rbp), %rcx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, %r11
               	movq	0x8(%r11), %r10
               	addq	$0x18, 0x8(%r11)
               	movq	%r10, %rdx
               	leaq	-0x30(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	0x10(%rdx), %r10
               	movq	%r10, 0x10(%rcx)
               	movabsq	$0x408f400000000000, %rdx # imm = 0x408F400000000000
               	movsd	(%rcx), %xmm1
               	movabsq	$0x4059000000000000, %rsi # imm = 0x4059000000000000
               	movq	%rsi, %xmm15
               	mulsd	%xmm15, %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rdx, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movsd	0x8(%rcx), %xmm1
               	movabsq	$0x4024000000000000, %rdx # imm = 0x4024000000000000
               	movapd	%xmm1, %xmm14
               	movq	%rdx, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movsd	0x10(%rcx), %xmm1
               	addsd	%xmm1, %xmm0
               	incq	%rax
               	movslq	-0xe0(%rbp), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, 0x4(%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rcx
               	movsd	(%rcx), %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	leaq	-0x18(%rbp), %rax
               	leave
               	retq

<last_ld>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
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
               	leaq	-0xf0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x28(%rbp), %rax
               	leaq	-0xe0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xe0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	xorl	%eax, %eax
               	movslq	-0xe0(%rbp), %rcx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	leaq	-0xf0(%rbp), %rcx
               	leaq	-0x28(%rbp), %rdx
               	movq	%rdx, %r11
               	movq	0x8(%r11), %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	movq	%r10, 0x8(%r11)
               	addq	$0x10, 0x8(%r11)
               	movq	%r10, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	incq	%rax
               	movslq	-0xe0(%rbp), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	leaq	-0x28(%rbp), %rax
               	fldt	-0xf0(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	-0x10(%rbp), %rax
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rax)
               	movq	%rax, %rcx
               	fldt	(%rcx)
               	leave
               	retq

<mixed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
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
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rcx
               	movslq	(%rcx), %rdx
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, 0x4(%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rsi
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rsi), %r10
               	movq	%r10, (%rcx)
               	movabsq	$0x4059000000000000, %rsi # imm = 0x4059000000000000
               	imulq	$0xa, %rdx, %rdx
               	movslq	%edx, %rdx
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rdx, %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rsi, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movsd	(%rcx), %xmm1
               	addsd	%xmm1, %xmm0
               	incq	%rax
               	movslq	-0xd0(%rbp), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	leave
               	retq

<twice>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x110, %rsp            # imm = 0x110
               	movq	%rdi, -0x110(%rbp)
               	movq	%rsi, -0x108(%rbp)
               	movq	%rdx, -0x100(%rbp)
               	movq	%rcx, -0xf8(%rbp)
               	movq	%r8, -0xf0(%rbp)
               	movq	%r9, -0xe8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xe0(%rbp)
               	movups	%xmm1, -0xd0(%rbp)
               	movups	%xmm2, -0xc0(%rbp)
               	movups	%xmm3, -0xb0(%rbp)
               	movups	%xmm4, -0xa0(%rbp)
               	movups	%xmm5, -0x90(%rbp)
               	movups	%xmm6, -0x80(%rbp)
               	movups	%xmm7, -0x70(%rbp)
               	xorl	%eax, %eax
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x110(%rbp), %rdx
               	movl	$0x8, (%rcx)
               	movl	$0x30, 0x4(%rcx)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rcx)
               	leaq	-0x110(%rbp), %r10
               	movq	%r10, 0x10(%rcx)
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x50(%rbp), %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	movq	0x10(%rdx), %rax
               	movq	%rax, 0x10(%rcx)
               	popq	%rax
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movslq	-0x110(%rbp), %rcx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	movq	%rcx, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0x90, %r10
               	ja	<addr>
               	pushq	%rax
               	movl	0x4(%r11), %r10d
               	addq	0x10(%r11), %r10
               	movq	(%r10), %r10
               	movq	%r10, (%rdx)
               	addl	$0x10, 0x4(%r11)
               	movl	0x4(%r11), %r10d
               	addq	0x10(%r11), %r10
               	movq	(%r10), %r10
               	movq	%r10, 0x8(%rdx)
               	addl	$0x10, 0x4(%r11)
               	movq	%rdx, %r10
               	popq	%rax
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x10, 0x8(%r11)
               	movq	%r10, %rdx
               	leaq	-0x60(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movabsq	$0x4059000000000000, %rdx # imm = 0x4059000000000000
               	movsd	(%rcx), %xmm1
               	movabsq	$0x4024000000000000, %rsi # imm = 0x4024000000000000
               	movq	%rsi, %xmm15
               	mulsd	%xmm15, %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rdx, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movsd	0x8(%rcx), %xmm1
               	addsd	%xmm1, %xmm0
               	incq	%rax
               	movslq	-0x110(%rbp), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	movslq	-0x110(%rbp), %rcx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movq	%rcx, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0x90, %r10
               	ja	<addr>
               	pushq	%rax
               	movl	0x4(%r11), %r10d
               	addq	0x10(%r11), %r10
               	movq	(%r10), %r10
               	movq	%r10, (%rdx)
               	addl	$0x10, 0x4(%r11)
               	movl	0x4(%r11), %r10d
               	addq	0x10(%r11), %r10
               	movq	(%r10), %r10
               	movq	%r10, 0x8(%rdx)
               	addl	$0x10, 0x4(%r11)
               	movq	%rdx, %r10
               	popq	%rax
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x10, 0x8(%r11)
               	movq	%r10, %rdx
               	leaq	-0x60(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movabsq	$0x4059000000000000, %rdx # imm = 0x4059000000000000
               	movsd	(%rcx), %xmm2
               	movabsq	$0x4024000000000000, %rsi # imm = 0x4024000000000000
               	movq	%rsi, %xmm15
               	mulsd	%xmm15, %xmm2
               	movapd	%xmm1, %xmm14
               	movq	%rdx, %xmm15
               	movapd	%xmm2, %xmm1
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movsd	0x8(%rcx), %xmm2
               	addsd	%xmm2, %xmm1
               	incq	%rax
               	movslq	-0x110(%rbp), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x50(%rbp), %rax
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leave
               	retq
               	movabsq	$-0x4010000000000000, %r11 # imm = 0xBFF0000000000000
               	movq	%r11, %xmm0
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	leaq	-0x98(%rbp), %r9
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	-0x88(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x78(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x68(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x58(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xd0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xc0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xa8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0xa0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movl	$0x1, %edi
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movsd	0x8(%r10), %xmm1
               	movb	$0x2, %al
               	callq	<addr>
               	movabsq	$0x4028000000000000, %rax # imm = 0x4028000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x2, %edi
               	leaq	-0x98(%rbp), %r9
               	leaq	-0x88(%rbp), %rax
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movsd	0x8(%r10), %xmm1
               	movq	%rax, %r10
               	movsd	(%r10), %xmm2
               	movsd	0x8(%r10), %xmm3
               	movb	$0x4, %al
               	callq	<addr>
               	movabsq	$0x4093480000000000, %rax # imm = 0x4093480000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x5, %edi
               	leaq	-0x98(%rbp), %r9
               	leaq	-0x88(%rbp), %rax
               	leaq	-0x78(%rbp), %rcx
               	leaq	-0x68(%rbp), %rdx
               	leaq	-0x58(%rbp), %rsi
               	subq	$0x10, %rsp
               	movq	%rsi, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movsd	0x8(%r10), %xmm1
               	movq	%rax, %r10
               	movsd	(%r10), %xmm2
               	movsd	0x8(%r10), %xmm3
               	movq	%rcx, %r10
               	movsd	(%r10), %xmm4
               	movsd	0x8(%r10), %xmm5
               	movq	%rdx, %r10
               	movsd	(%r10), %xmm6
               	movsd	0x8(%r10), %xmm7
               	movb	$0x8, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movabsq	$0x41d26580b4c00000, %rax # imm = 0x41D26580B4C00000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	leaq	-0x40(%rbp), %r9
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movsd	0x8(%r10), %xmm1
               	movb	$0x2, %al
               	callq	<addr>
               	movabsq	$0x4093480000000000, %rax # imm = 0x4093480000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x3, %edi
               	leaq	-0x40(%rbp), %r9
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movsd	0x8(%r10), %xmm1
               	movq	%rax, %r10
               	movsd	(%r10), %xmm2
               	movsd	0x8(%r10), %xmm3
               	movq	%rcx, %r10
               	movsd	(%r10), %xmm4
               	movsd	0x8(%r10), %xmm5
               	movb	$0x6, %al
               	callq	<addr>
               	movabsq	$0x423cbe991d740000, %rax # imm = 0x423CBE991D740000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x48(%rbp), %r9
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%r9)
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	-0x18(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	0x10(%rdx), %r10
               	movq	%r10, 0x10(%rcx)
               	movl	$0x3, %edi
               	movabsq	$0x3fe0000000000000, %rdx # imm = 0x3FE0000000000000
               	movabsq	$0x4000000000000000, %rsi # imm = 0x4000000000000000
               	subq	$0x50, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	%rdx, %xmm0
               	movq	%rsi, %xmm1
               	movb	$0x2, %al
               	callq	<addr>
               	addq	$0x50, %rsp
               	movabsq	$0x41f739bf4d400000, %rax # imm = 0x41F739BF4D400000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x2, %edi
               	leaq	-0xd0(%rbp), %r9
               	leaq	-0xc0(%rbp), %rax
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x20, %rsp
               	fstpt	-0x10(%rbp)
               	fldt	-0x10(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x401d000000000000, %rax # imm = 0x401D000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	$0x9, %edi
               	leaq	-0xd0(%rbp), %r9
               	leaq	-0xd0(%rbp), %rax
               	leaq	-0xd0(%rbp), %rcx
               	leaq	-0xc0(%rbp), %rdx
               	subq	$0x90, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x60(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x68(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x70(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x78(%rsp)
               	movq	%rdx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x80(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x88(%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x90, %rsp
               	fstpt	-0x10(%rbp)
               	fldt	-0x10(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x401d000000000000, %rax # imm = 0x401D000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	leaq	-0xa8(%rbp), %r9
               	leaq	-0xa0(%rbp), %rax
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movq	%rax, %r10
               	movsd	(%r10), %xmm1
               	movq	%rdi, %rdx
               	movb	$0x2, %al
               	callq	<addr>
               	movabsq	$0x4094b00000000000, %rax # imm = 0x4094B00000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x5, %edi
               	leaq	-0x98(%rbp), %r9
               	leaq	-0x88(%rbp), %rax
               	leaq	-0x78(%rbp), %rcx
               	leaq	-0x68(%rbp), %rdx
               	leaq	-0x58(%rbp), %rsi
               	subq	$0x10, %rsp
               	movq	%rsi, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movsd	0x8(%r10), %xmm1
               	movq	%rax, %r10
               	movsd	(%r10), %xmm2
               	movsd	0x8(%r10), %xmm3
               	movq	%rcx, %r10
               	movsd	(%r10), %xmm4
               	movsd	0x8(%r10), %xmm5
               	movq	%rdx, %r10
               	movsd	(%r10), %xmm6
               	movsd	0x8(%r10), %xmm7
               	movb	$0x8, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movabsq	$0x41d26580b4c00000, %rax # imm = 0x41D26580B4C00000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
