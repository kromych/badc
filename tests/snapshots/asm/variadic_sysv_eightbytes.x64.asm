
variadic_sysv_eightbytes.x64:	file format elf64-x86-64

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

<sum_ld>:
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
               	movl	(%r11), %r10d
               	cmpq	$0x28, %r10
               	ja	<addr>
               	movl	0x4(%r11), %r10d
               	cmpq	$0xa0, %r10
               	ja	<addr>
               	pushq	%rax
               	movl	(%r11), %r10d
               	addq	0x10(%r11), %r10
               	movq	(%r10), %r10
               	movq	%r10, (%rdx)
               	addl	$0x8, (%r11)
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
               	movq	(%rcx), %rsi
               	imulq	$0xa, %rsi, %rsi
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rsi, %xmm1
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

<mixed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x150, %rsp            # imm = 0x150
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
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x110(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0x110(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	%rax, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x28, %r10
               	ja	<addr>
               	movl	0x4(%r11), %r10d
               	cmpq	$0xa0, %r10
               	ja	<addr>
               	pushq	%rax
               	movl	0x4(%r11), %r10d
               	addq	0x10(%r11), %r10
               	movq	(%r10), %r10
               	movq	%r10, (%rcx)
               	addl	$0x10, 0x4(%r11)
               	movl	(%r11), %r10d
               	addq	0x10(%r11), %r10
               	movq	(%r10), %r10
               	movq	%r10, 0x8(%rcx)
               	addl	$0x8, (%r11)
               	movq	%rcx, %r10
               	popq	%rax
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x10, 0x8(%r11)
               	movq	%r10, %rax
               	leaq	-0x58(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	%rax, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x28, %r10
               	ja	<addr>
               	movl	0x4(%r11), %r10d
               	cmpq	$0xa0, %r10
               	ja	<addr>
               	pushq	%rax
               	movl	0x4(%r11), %r10d
               	addq	0x10(%r11), %r10
               	movq	(%r10), %r10
               	movq	%r10, (%rcx)
               	addl	$0x10, 0x4(%r11)
               	movl	(%r11), %r10d
               	addq	0x10(%r11), %r10
               	movq	(%r10), %r10
               	movq	%r10, 0x8(%rcx)
               	addl	$0x8, (%r11)
               	movq	%rcx, %r10
               	popq	%rax
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x10, 0x8(%r11)
               	movq	%r10, %rax
               	leaq	-0x48(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x38(%rbp), %rax
               	movq	%rax, %r11
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
               	movq	%r10, %rax
               	leaq	-0x150(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x140(%rbp), %rcx
               	movq	%rax, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x28, %r10
               	ja	<addr>
               	pushq	%rax
               	movl	(%r11), %r10d
               	addq	0x10(%r11), %r10
               	movq	(%r10), %r10
               	movq	%r10, (%rcx)
               	addl	$0x8, (%r11)
               	movq	%rcx, %r10
               	popq	%rax
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	movq	%r10, 0x8(%r11)
               	addq	$0x10, 0x8(%r11)
               	movq	%r10, %rax
               	movl	(%rax), %ecx
               	leaq	-0x38(%rbp), %rax
               	movq	%rax, %r11
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
               	movq	%r10, %rax
               	leaq	-0x130(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x38(%rbp), %rax
               	movq	%rax, %r11
               	movq	0x8(%r11), %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	movq	%r10, 0x8(%r11)
               	addq	$0x10, 0x8(%r11)
               	movq	%r10, %rax
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x38(%rbp), %rax
               	movq	%rax, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rax
               	movq	(%rax), %rdx
               	leaq	-0x38(%rbp), %rax
               	movslq	-0x110(%rbp), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	leaq	-0x58(%rbp), %rax
               	movsd	(%rax), %xmm1
               	movabsq	$0x4197d78400000000, %rsi # imm = 0x4197D78400000000
               	movapd	%xmm1, %xmm14
               	movq	%rsi, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movq	0x8(%rax), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	movabsq	$0x416312d000000000, %rax # imm = 0x416312D000000000
               	movapd	%xmm1, %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	leaq	-0x48(%rbp), %rax
               	movss	(%rax), %xmm1
               	movss	0x4(%rax), %xmm2
               	addss	%xmm2, %xmm1
               	movabsq	$0x412e848000000000, %rsi # imm = 0x412E848000000000
               	cvtss2sd	%xmm1, %xmm1
               	movapd	%xmm1, %xmm14
               	movq	%rsi, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movq	0x8(%rax), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	movabsq	$0x40f86a0000000000, %rax # imm = 0x40F86A0000000000
               	movapd	%xmm1, %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movsd	-0x150(%rbp), %xmm1
               	movabsq	$0x40c3880000000000, %rax # imm = 0x40C3880000000000
               	movapd	%xmm1, %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movslq	%ecx, %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	movabsq	$0x408f400000000000, %rax # imm = 0x408F400000000000
               	movapd	%xmm1, %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	leaq	-0x130(%rbp), %rax
               	movss	0xc(%rax), %xmm1
               	movl	$0x42c80000, %eax       # imm = 0x42C80000
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	addsd	%xmm1, %xmm0
               	fldt	-0x120(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	movapd	%xmm1, %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rdx, %xmm1
               	addsd	%xmm1, %xmm0
               	leave
               	retq

<after_fp>:
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
               	addsd	%xmm1, %xmm0
               	incq	%rax
               	movslq	-0xf0(%rbp), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	%rax, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x28, %r10
               	ja	<addr>
               	movl	0x4(%r11), %r10d
               	cmpq	$0xa0, %r10
               	ja	<addr>
               	pushq	%rax
               	movl	(%r11), %r10d
               	addq	0x10(%r11), %r10
               	movq	(%r10), %r10
               	movq	%r10, (%rcx)
               	addl	$0x8, (%r11)
               	movl	0x4(%r11), %r10d
               	addq	0x10(%r11), %r10
               	movq	(%r10), %r10
               	movq	%r10, 0x8(%rcx)
               	addl	$0x10, 0x4(%r11)
               	movq	%rcx, %r10
               	popq	%rax
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x10, 0x8(%r11)
               	movq	%r10, %rax
               	leaq	-0x38(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x28(%rbp), %rax
               	movq	%rax, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rax
               	movq	(%rax), %rcx
               	leaq	-0x28(%rbp), %rax
               	movabsq	$0x408f400000000000, %rdx # imm = 0x408F400000000000
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rsi
               	imulq	$0x64, %rsi, %rsi
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rsi, %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rdx, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movsd	0x8(%rax), %xmm1
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	movapd	%xmm1, %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rcx, %xmm1
               	addsd	%xmm1, %xmm0
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe8, %rsp
               	pushq	%rbx
               	leaq	-0x90(%rbp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0x80(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x70(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x60(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xe0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xd0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xb0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xc0(%rbp), %rcx
               	leaq	-0xa0(%rbp), %rax
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0x1, %edi
               	movsd	0x8(%rsi), %xmm0
               	movq	(%rsi), %rsi
               	movb	$0x1, %al
               	callq	<addr>
               	movabsq	$0x4028000000000000, %rax # imm = 0x4028000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %edi
               	leaq	-0x90(%rbp), %rsi
               	leaq	-0x80(%rbp), %rdx
               	leaq	-0x70(%rbp), %rcx
               	movsd	0x8(%rsi), %xmm0
               	movq	(%rsi), %rsi
               	movsd	0x8(%rdx), %xmm1
               	movq	(%rdx), %rdx
               	movsd	0x8(%rcx), %xmm2
               	movq	(%rcx), %rcx
               	movb	$0x3, %al
               	callq	<addr>
               	movabsq	$0x40fe240000000000, %rax # imm = 0x40FE240000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7, %edi
               	leaq	-0x90(%rbp), %rsi
               	leaq	-0x80(%rbp), %rdx
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x60(%rbp), %r8
               	leaq	-0x50(%rbp), %r9
               	leaq	-0x40(%rbp), %rax
               	leaq	-0x30(%rbp), %rbx
               	subq	$0x20, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%rbx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movsd	0x8(%rsi), %xmm0
               	movq	(%rsi), %rsi
               	movsd	0x8(%rdx), %xmm1
               	movq	(%rdx), %rdx
               	movsd	0x8(%rcx), %xmm2
               	movq	(%rcx), %rcx
               	movsd	0x8(%r8), %xmm3
               	movq	(%r8), %r8
               	movsd	0x8(%r9), %xmm4
               	movq	(%r9), %r9
               	movb	$0x5, %al
               	callq	<addr>
               	addq	$0x20, %rsp
               	movabsq	$0x42a674e79cb6b200, %rax # imm = 0x42A674E79CB6B200
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x9, %edi
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdx
               	leaq	-0xe0(%rbp), %r9
               	leaq	-0xd0(%rbp), %rcx
               	leaq	-0xc0(%rbp), %rax
               	leaq	-0xb0(%rbp), %r8
               	movl	$0x3, %ebx
               	subq	$0x10, %rsp
               	movq	%r8, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%r9, %r10
               	movsd	(%r10), %xmm2
               	movq	%rax, %r10
               	movups	(%r10), %xmm3
               	movq	%rbx, %r8
               	movsd	(%rsi), %xmm0
               	movq	0x8(%rsi), %rsi
               	movsd	(%rdx), %xmm1
               	movq	0x8(%rdx), %rdx
               	movq	(%rcx), %rcx
               	movb	$0x4, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movabsq	$0x4022000000000000, %rax # imm = 0x4022000000000000
               	movabsq	$0x4197d78400000000, %rcx # imm = 0x4197D78400000000
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm1
               	addsd	%xmm15, %xmm1
               	movabsq	$0x417312d000000000, %rax # imm = 0x417312D000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm1
               	movabsq	$0x4146e36000000000, %rax # imm = 0x4146E36000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm1
               	movabsq	$0x41186a0000000000, %rax # imm = 0x41186A0000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm1
               	movabsq	$0x40e86a0000000000, %rax # imm = 0x40E86A0000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm1
               	movabsq	$0x40b7700000000000, %rax # imm = 0x40B7700000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm1
               	movabsq	$0x4085e00000000000, %rax # imm = 0x4085E00000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm1
               	movabsq	$0x4055400000000000, %rax # imm = 0x4055400000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm1
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x8, %edi
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	leaq	-0x90(%rbp), %r9
               	movl	$0x3, %esi
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%rax, %xmm0
               	movq	%rax, %xmm1
               	movq	%rax, %xmm2
               	movq	%rax, %xmm3
               	movq	%rax, %xmm4
               	movq	%rax, %xmm5
               	movq	%rax, %xmm6
               	movq	%rax, %xmm7
               	movb	$0x8, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movabsq	$0x40bfbb0000000000, %rax # imm = 0x40BFBB0000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
