
fma_numeric_kernels.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	leaq	-0x28(%rbp), %rdx
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x28(%rbp)
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x20(%rbp)
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x18(%rbp)
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	movabsq	$0x4014000000000000, %rax # imm = 0x4014000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm0
               	movl	$0x3, %eax
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	addq	%rdx, %rsi
               	movsd	(%rsi), %xmm1
               	movq	%rcx, %xmm15
               	vfmadd132sd	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm0 * xmm15) + xmm1
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movabsq	$0x4060200000000000, %rax # imm = 0x4060200000000000
               	movq	%rax, %xmm15
               	subsd	%xmm15, %xmm0
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3e112e0be826d695, %rax # imm = 0x3E112E0BE826D695
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	ja	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %rdx
               	movsd	-0x8(%rbp), %xmm0
               	movl	$0x3, %eax
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	addq	%rdx, %rsi
               	movsd	(%rsi), %xmm1
               	movq	%rcx, %xmm15
               	vfmadd132sd	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm0 * xmm15) + xmm1
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	subsd	%xmm15, %xmm0
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3e112e0be826d695, %rax # imm = 0x3E112E0BE826D695
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	ja	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0x90(%rbp), %rsi
               	imulq	$0x18, %rcx, %rdx
               	leaq	(%rsi,%rdx), %rdi
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdi
               	leaq	(%rcx,%rcx,2), %r8
               	addq	%rax, %r8
               	incq	%r8
               	movslq	%r8d, %r8
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%r8, %xmm0
               	movsd	%xmm0, (%rdi)
               	leaq	-0x48(%rbp), %rdi
               	addq	%rdi, %rdx
               	addq	%rsi, %rdx
               	cmpl	%eax, %ecx
               	jne	<addr>
               	movabsq	$0x3ff0000000000000, %r11 # imm = 0x3FF0000000000000
               	movq	%r11, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movsd	%xmm0, (%rdx)
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	incq	%rcx
               	cmpl	$0x3, %ecx
               	jl	<addr>
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x48(%rbp), %rsi
               	imulq	$0x18, %rax, %rdi
               	addq	%rdi, %rcx
               	movsd	(%rcx), %xmm0
               	movsd	-0x48(%rbp), %xmm1
               	movq	%rdx, %xmm15
               	vfmadd213sd	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm15
               	movsd	0x8(%rcx), %xmm1
               	leaq	0x18(%rsi), %r8
               	movsd	(%r8), %xmm2
               	vfmadd231sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm2) + xmm0
               	movsd	0x10(%rcx), %xmm1
               	leaq	0x30(%rsi), %rcx
               	movsd	(%rcx), %xmm2
               	vfmadd231sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm2) + xmm0
               	leaq	-0x90(%rbp), %rcx
               	leaq	(%rcx,%rdi), %rsi
               	movsd	(%rsi), %xmm1
               	subsd	%xmm1, %xmm0
               	xorl	%esi, %esi
               	movq	%rsi, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3e112e0be826d695, %rdi # imm = 0x3E112E0BE826D695
               	movq	%rdi, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	leaq	-0x48(%rbp), %rdi
               	imulq	$0x18, %rax, %r8
               	addq	%r8, %rcx
               	movsd	(%rcx), %xmm0
               	movsd	-0x40(%rbp), %xmm1
               	movq	%rsi, %xmm15
               	vfmadd213sd	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm15
               	movsd	0x8(%rcx), %xmm1
               	leaq	0x18(%rdi), %rsi
               	movsd	0x8(%rsi), %xmm2
               	vfmadd231sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm2) + xmm0
               	movsd	0x10(%rcx), %xmm1
               	leaq	0x30(%rdi), %rcx
               	movsd	0x8(%rcx), %xmm2
               	vfmadd231sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm2) + xmm0
               	leaq	-0x90(%rbp), %rcx
               	leaq	(%rcx,%r8), %rsi
               	movsd	0x8(%rsi), %xmm1
               	subsd	%xmm1, %xmm0
               	xorl	%esi, %esi
               	movq	%rsi, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3e112e0be826d695, %rdi # imm = 0x3E112E0BE826D695
               	movq	%rdi, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	leaq	-0x48(%rbp), %rdi
               	imulq	$0x18, %rax, %r8
               	addq	%r8, %rcx
               	movsd	(%rcx), %xmm0
               	movsd	-0x38(%rbp), %xmm1
               	movq	%rsi, %xmm15
               	vfmadd213sd	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm15
               	movsd	0x8(%rcx), %xmm1
               	leaq	0x18(%rdi), %rsi
               	movsd	0x10(%rsi), %xmm2
               	vfmadd231sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm2) + xmm0
               	movsd	0x10(%rcx), %xmm1
               	leaq	0x30(%rdi), %rcx
               	movsd	0x10(%rcx), %xmm2
               	vfmadd231sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm2) + xmm0
               	leaq	-0x90(%rbp), %rcx
               	addq	%r8, %rcx
               	movsd	0x10(%rcx), %xmm1
               	subsd	%xmm1, %xmm0
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3e112e0be826d695, %rcx # imm = 0x3E112E0BE826D695
               	movq	%rcx, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	leaq	-0x90(%rbp), %rax
               	xorl	%ecx, %ecx
               	movsd	-0x78(%rbp), %xmm0
               	movsd	-0x80(%rbp), %xmm1
               	movq	%rcx, %xmm15
               	vfmadd213sd	%xmm15, %xmm0, %xmm1 # xmm1 = (xmm0 * xmm1) + xmm15
               	leaq	0x18(%rax), %rdx
               	movsd	0x8(%rdx), %xmm2
               	movsd	0x10(%rdx), %xmm0
               	vfmadd231sd	%xmm0, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm0) + xmm1
               	addq	$0x30, %rax
               	movsd	0x10(%rax), %xmm2
               	vfmadd213sd	%xmm1, %xmm2, %xmm0 # xmm0 = (xmm2 * xmm0) + xmm1
               	movabsq	$0x4058000000000000, %rax # imm = 0x4058000000000000
               	movq	%rax, %xmm15
               	subsd	%xmm15, %xmm0
               	movq	%rcx, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3e112e0be826d695, %rax # imm = 0x3E112E0BE826D695
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	ja	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movabsq	$0x4030000000000000, %rcx # imm = 0x4030000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	vdivsd	%xmm15, %xmm14, %xmm0
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	movq	%rcx, %xmm15
               	vmulsd	%xmm15, %xmm0, %xmm1
               	movq	%rax, %xmm2
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm1, %xmm2 # xmm2 = (xmm1 * xmm15) + xmm2
               	movq	%rax, %xmm4
               	vfmadd231sd	%xmm2, %xmm1, %xmm4 # xmm4 = (xmm1 * xmm2) + xmm4
               	movq	%rax, %xmm5
               	vfmadd231sd	%xmm4, %xmm0, %xmm5 # xmm5 = (xmm0 * xmm4) + xmm5
               	movabsq	$0x4018000000000000, %rcx # imm = 0x4018000000000000
               	movq	%rcx, %xmm15
               	vdivsd	%xmm15, %xmm0, %xmm3
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	vfmadd132sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm2 * xmm15) + xmm14
               	movq	%rcx, %xmm14
               	vfmadd231sd	%xmm4, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm4) + xmm2
               	addsd	%xmm5, %xmm2
               	movq	%rax, %xmm15
               	vfmadd213sd	%xmm15, %xmm3, %xmm2 # xmm2 = (xmm3 * xmm2) + xmm15
               	movapd	%xmm2, %xmm4
               	vfmadd231sd	%xmm2, %xmm1, %xmm4 # xmm4 = (xmm1 * xmm2) + xmm4
               	movapd	%xmm2, %xmm5
               	vfmadd231sd	%xmm4, %xmm1, %xmm5 # xmm5 = (xmm1 * xmm4) + xmm5
               	movapd	%xmm2, %xmm6
               	vfmadd231sd	%xmm5, %xmm0, %xmm6 # xmm6 = (xmm0 * xmm5) + xmm6
               	movq	%rcx, %xmm15
               	vfmadd132sd	%xmm15, %xmm2, %xmm4 # xmm4 = (xmm4 * xmm15) + xmm2
               	movq	%rcx, %xmm14
               	vfmadd231sd	%xmm5, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm5) + xmm4
               	addsd	%xmm6, %xmm4
               	vfmadd231sd	%xmm4, %xmm3, %xmm2 # xmm2 = (xmm3 * xmm4) + xmm2
               	movapd	%xmm2, %xmm4
               	vfmadd231sd	%xmm2, %xmm1, %xmm4 # xmm4 = (xmm1 * xmm2) + xmm4
               	vfmadd213sd	%xmm2, %xmm4, %xmm1 # xmm1 = (xmm4 * xmm1) + xmm2
               	movapd	%xmm2, %xmm5
               	vfmadd231sd	%xmm1, %xmm0, %xmm5 # xmm5 = (xmm0 * xmm1) + xmm5
               	movq	%rcx, %xmm15
               	vfmadd132sd	%xmm15, %xmm2, %xmm4 # xmm4 = (xmm4 * xmm15) + xmm2
               	movq	%rcx, %xmm15
               	vfmadd132sd	%xmm15, %xmm4, %xmm1 # xmm1 = (xmm1 * xmm15) + xmm4
               	addsd	%xmm5, %xmm1
               	vfmadd231sd	%xmm1, %xmm3, %xmm2 # xmm2 = (xmm3 * xmm1) + xmm2
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	vmulsd	%xmm15, %xmm0, %xmm1
               	movapd	%xmm2, %xmm4
               	vfmadd231sd	%xmm2, %xmm1, %xmm4 # xmm4 = (xmm1 * xmm2) + xmm4
               	movapd	%xmm2, %xmm5
               	vfmadd231sd	%xmm4, %xmm1, %xmm5 # xmm5 = (xmm1 * xmm4) + xmm5
               	movapd	%xmm2, %xmm6
               	vfmadd231sd	%xmm5, %xmm0, %xmm6 # xmm6 = (xmm0 * xmm5) + xmm6
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
               	vdivsd	%xmm15, %xmm0, %xmm3
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	vfmadd132sd	%xmm15, %xmm2, %xmm4 # xmm4 = (xmm4 * xmm15) + xmm2
               	movq	%rax, %xmm14
               	vfmadd231sd	%xmm5, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm5) + xmm4
               	addsd	%xmm6, %xmm4
               	vfmadd231sd	%xmm4, %xmm3, %xmm2 # xmm2 = (xmm3 * xmm4) + xmm2
               	movapd	%xmm2, %xmm4
               	vfmadd231sd	%xmm2, %xmm1, %xmm4 # xmm4 = (xmm1 * xmm2) + xmm4
               	movapd	%xmm2, %xmm5
               	vfmadd231sd	%xmm4, %xmm1, %xmm5 # xmm5 = (xmm1 * xmm4) + xmm5
               	movapd	%xmm2, %xmm6
               	vfmadd231sd	%xmm5, %xmm0, %xmm6 # xmm6 = (xmm0 * xmm5) + xmm6
               	movq	%rax, %xmm15
               	vfmadd132sd	%xmm15, %xmm2, %xmm4 # xmm4 = (xmm4 * xmm15) + xmm2
               	movq	%rax, %xmm14
               	vfmadd231sd	%xmm5, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm5) + xmm4
               	addsd	%xmm6, %xmm4
               	vfmadd231sd	%xmm4, %xmm3, %xmm2 # xmm2 = (xmm3 * xmm4) + xmm2
               	movapd	%xmm2, %xmm4
               	vfmadd231sd	%xmm2, %xmm1, %xmm4 # xmm4 = (xmm1 * xmm2) + xmm4
               	movapd	%xmm2, %xmm5
               	vfmadd231sd	%xmm4, %xmm1, %xmm5 # xmm5 = (xmm1 * xmm4) + xmm5
               	movapd	%xmm2, %xmm6
               	vfmadd231sd	%xmm5, %xmm0, %xmm6 # xmm6 = (xmm0 * xmm5) + xmm6
               	movq	%rax, %xmm15
               	vfmadd132sd	%xmm15, %xmm2, %xmm4 # xmm4 = (xmm4 * xmm15) + xmm2
               	movq	%rax, %xmm14
               	vfmadd231sd	%xmm5, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm5) + xmm4
               	addsd	%xmm6, %xmm4
               	vfmadd231sd	%xmm4, %xmm3, %xmm2 # xmm2 = (xmm3 * xmm4) + xmm2
               	movapd	%xmm2, %xmm4
               	vfmadd231sd	%xmm2, %xmm1, %xmm4 # xmm4 = (xmm1 * xmm2) + xmm4
               	vfmadd213sd	%xmm2, %xmm4, %xmm1 # xmm1 = (xmm4 * xmm1) + xmm2
               	movapd	%xmm2, %xmm5
               	vfmadd231sd	%xmm1, %xmm0, %xmm5 # xmm5 = (xmm0 * xmm1) + xmm5
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
               	vdivsd	%xmm15, %xmm0, %xmm3
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	vfmadd132sd	%xmm15, %xmm2, %xmm4 # xmm4 = (xmm4 * xmm15) + xmm2
               	movq	%rax, %xmm15
               	vfmadd132sd	%xmm15, %xmm4, %xmm1 # xmm1 = (xmm1 * xmm15) + xmm4
               	addsd	%xmm5, %xmm1
               	vfmadd213sd	%xmm2, %xmm3, %xmm1 # xmm1 = (xmm3 * xmm1) + xmm2
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	movq	%rcx, %xmm15
               	vmulsd	%xmm15, %xmm0, %xmm2
               	movapd	%xmm1, %xmm4
               	vfmadd231sd	%xmm1, %xmm2, %xmm4 # xmm4 = (xmm2 * xmm1) + xmm4
               	movapd	%xmm1, %xmm5
               	vfmadd231sd	%xmm4, %xmm2, %xmm5 # xmm5 = (xmm2 * xmm4) + xmm5
               	movapd	%xmm1, %xmm6
               	vfmadd231sd	%xmm5, %xmm0, %xmm6 # xmm6 = (xmm0 * xmm5) + xmm6
               	movq	%rax, %xmm15
               	vfmadd132sd	%xmm15, %xmm1, %xmm4 # xmm4 = (xmm4 * xmm15) + xmm1
               	movq	%rax, %xmm14
               	vfmadd231sd	%xmm5, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm5) + xmm4
               	addsd	%xmm6, %xmm4
               	vfmadd231sd	%xmm4, %xmm3, %xmm1 # xmm1 = (xmm3 * xmm4) + xmm1
               	movapd	%xmm1, %xmm4
               	vfmadd231sd	%xmm1, %xmm2, %xmm4 # xmm4 = (xmm2 * xmm1) + xmm4
               	movapd	%xmm1, %xmm5
               	vfmadd231sd	%xmm4, %xmm2, %xmm5 # xmm5 = (xmm2 * xmm4) + xmm5
               	movapd	%xmm1, %xmm6
               	vfmadd231sd	%xmm5, %xmm0, %xmm6 # xmm6 = (xmm0 * xmm5) + xmm6
               	movq	%rax, %xmm15
               	vfmadd132sd	%xmm15, %xmm1, %xmm4 # xmm4 = (xmm4 * xmm15) + xmm1
               	movq	%rax, %xmm14
               	vfmadd231sd	%xmm5, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm5) + xmm4
               	addsd	%xmm6, %xmm4
               	vfmadd231sd	%xmm4, %xmm3, %xmm1 # xmm1 = (xmm3 * xmm4) + xmm1
               	movapd	%xmm1, %xmm4
               	vfmadd231sd	%xmm1, %xmm2, %xmm4 # xmm4 = (xmm2 * xmm1) + xmm4
               	vfmadd213sd	%xmm1, %xmm4, %xmm2 # xmm2 = (xmm4 * xmm2) + xmm1
               	movapd	%xmm1, %xmm5
               	vfmadd231sd	%xmm2, %xmm0, %xmm5 # xmm5 = (xmm0 * xmm2) + xmm5
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	vfmadd132sd	%xmm15, %xmm1, %xmm4 # xmm4 = (xmm4 * xmm15) + xmm1
               	movq	%rax, %xmm15
               	vfmadd132sd	%xmm15, %xmm4, %xmm2 # xmm2 = (xmm2 * xmm15) + xmm4
               	addsd	%xmm5, %xmm2
               	vfmadd231sd	%xmm2, %xmm3, %xmm1 # xmm1 = (xmm3 * xmm2) + xmm1
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	movq	%rcx, %xmm15
               	vmulsd	%xmm15, %xmm0, %xmm2
               	movapd	%xmm1, %xmm4
               	vfmadd231sd	%xmm1, %xmm2, %xmm4 # xmm4 = (xmm2 * xmm1) + xmm4
               	movapd	%xmm1, %xmm5
               	vfmadd231sd	%xmm4, %xmm2, %xmm5 # xmm5 = (xmm2 * xmm4) + xmm5
               	movapd	%xmm1, %xmm6
               	vfmadd231sd	%xmm5, %xmm0, %xmm6 # xmm6 = (xmm0 * xmm5) + xmm6
               	movabsq	$0x4018000000000000, %rcx # imm = 0x4018000000000000
               	movq	%rcx, %xmm15
               	vdivsd	%xmm15, %xmm0, %xmm3
               	movq	%rax, %xmm15
               	vfmadd132sd	%xmm15, %xmm1, %xmm4 # xmm4 = (xmm4 * xmm15) + xmm1
               	movq	%rax, %xmm14
               	vfmadd231sd	%xmm5, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm5) + xmm4
               	addsd	%xmm6, %xmm4
               	vfmadd231sd	%xmm4, %xmm3, %xmm1 # xmm1 = (xmm3 * xmm4) + xmm1
               	movapd	%xmm1, %xmm4
               	vfmadd231sd	%xmm1, %xmm2, %xmm4 # xmm4 = (xmm2 * xmm1) + xmm4
               	movapd	%xmm1, %xmm5
               	vfmadd231sd	%xmm4, %xmm2, %xmm5 # xmm5 = (xmm2 * xmm4) + xmm5
               	movapd	%xmm1, %xmm6
               	vfmadd231sd	%xmm5, %xmm0, %xmm6 # xmm6 = (xmm0 * xmm5) + xmm6
               	movq	%rax, %xmm15
               	vfmadd132sd	%xmm15, %xmm1, %xmm4 # xmm4 = (xmm4 * xmm15) + xmm1
               	movq	%rax, %xmm14
               	vfmadd231sd	%xmm5, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm5) + xmm4
               	addsd	%xmm6, %xmm4
               	vfmadd231sd	%xmm4, %xmm3, %xmm1 # xmm1 = (xmm3 * xmm4) + xmm1
               	movapd	%xmm1, %xmm4
               	vfmadd231sd	%xmm1, %xmm2, %xmm4 # xmm4 = (xmm2 * xmm1) + xmm4
               	vfmadd213sd	%xmm1, %xmm4, %xmm2 # xmm2 = (xmm4 * xmm2) + xmm1
               	movapd	%xmm1, %xmm5
               	vfmadd231sd	%xmm2, %xmm0, %xmm5 # xmm5 = (xmm0 * xmm2) + xmm5
               	movq	%rax, %xmm15
               	vfmadd132sd	%xmm15, %xmm1, %xmm4 # xmm4 = (xmm4 * xmm15) + xmm1
               	movq	%rax, %xmm15
               	vfmadd132sd	%xmm15, %xmm4, %xmm2 # xmm2 = (xmm2 * xmm15) + xmm4
               	addsd	%xmm5, %xmm2
               	vfmadd231sd	%xmm2, %xmm3, %xmm1 # xmm1 = (xmm3 * xmm2) + xmm1
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	vmulsd	%xmm15, %xmm0, %xmm2
               	movapd	%xmm1, %xmm4
               	vfmadd231sd	%xmm1, %xmm2, %xmm4 # xmm4 = (xmm2 * xmm1) + xmm4
               	movapd	%xmm1, %xmm5
               	vfmadd231sd	%xmm4, %xmm2, %xmm5 # xmm5 = (xmm2 * xmm4) + xmm5
               	movapd	%xmm1, %xmm6
               	vfmadd231sd	%xmm5, %xmm0, %xmm6 # xmm6 = (xmm0 * xmm5) + xmm6
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
               	vdivsd	%xmm15, %xmm0, %xmm3
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	vfmadd132sd	%xmm15, %xmm1, %xmm4 # xmm4 = (xmm4 * xmm15) + xmm1
               	movq	%rax, %xmm14
               	vfmadd231sd	%xmm5, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm5) + xmm4
               	addsd	%xmm6, %xmm4
               	vfmadd231sd	%xmm4, %xmm3, %xmm1 # xmm1 = (xmm3 * xmm4) + xmm1
               	movapd	%xmm1, %xmm4
               	vfmadd231sd	%xmm1, %xmm2, %xmm4 # xmm4 = (xmm2 * xmm1) + xmm4
               	movapd	%xmm1, %xmm5
               	vfmadd231sd	%xmm4, %xmm2, %xmm5 # xmm5 = (xmm2 * xmm4) + xmm5
               	movapd	%xmm1, %xmm6
               	vfmadd231sd	%xmm5, %xmm0, %xmm6 # xmm6 = (xmm0 * xmm5) + xmm6
               	movq	%rax, %xmm15
               	vfmadd132sd	%xmm15, %xmm1, %xmm4 # xmm4 = (xmm4 * xmm15) + xmm1
               	movq	%rax, %xmm14
               	vfmadd231sd	%xmm5, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm5) + xmm4
               	addsd	%xmm6, %xmm4
               	vfmadd231sd	%xmm4, %xmm3, %xmm1 # xmm1 = (xmm3 * xmm4) + xmm1
               	movapd	%xmm1, %xmm4
               	vfmadd231sd	%xmm1, %xmm2, %xmm4 # xmm4 = (xmm2 * xmm1) + xmm4
               	vfmadd213sd	%xmm1, %xmm4, %xmm2 # xmm2 = (xmm4 * xmm2) + xmm1
               	vfmadd213sd	%xmm1, %xmm2, %xmm0 # xmm0 = (xmm2 * xmm0) + xmm1
               	movq	%rax, %xmm15
               	vfmadd132sd	%xmm15, %xmm1, %xmm4 # xmm4 = (xmm4 * xmm15) + xmm1
               	movq	%rax, %xmm15
               	vfmadd132sd	%xmm15, %xmm4, %xmm2 # xmm2 = (xmm2 * xmm15) + xmm4
               	vaddsd	%xmm0, %xmm2, %xmm0
               	vfmadd213sd	%xmm1, %xmm3, %xmm0 # xmm0 = (xmm3 * xmm0) + xmm1
               	movabsq	$0x4005bf0a8b145769, %rax # imm = 0x4005BF0A8B145769
               	movq	%rax, %xmm15
               	subsd	%xmm15, %xmm0
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3eb0c6f7a0b5ed8d, %rcx # imm = 0x3EB0C6F7A0B5ED8D
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leave
               	retq
               	movl	$0x3, %eax
               	leave
               	retq
