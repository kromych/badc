
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
               	comisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3e112e0be826d695, %rax # imm = 0x3E112E0BE826D695
               	movq	%rax, %xmm15
               	comisd	%xmm0, %xmm15
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
               	xorl	%esi, %esi
               	movq	%rsi, %xmm15
               	comisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3e112e0be826d695, %rax # imm = 0x3E112E0BE826D695
               	movq	%rax, %xmm15
               	comisd	%xmm0, %xmm15
               	ja	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	imulq	$0x18, %rsi, %rcx
               	leaq	(%rsi,%rsi,2), %rdi
               	jmp	<addr>
               	movsd	%xmm0, (%rdx)
               	incq	%rax
               	cmpl	$0x3, %eax
               	jge	<addr>
               	leaq	-0x90(%rbp), %rdx
               	leaq	(%rdx,%rcx), %r8
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	leaq	(%rdi,%rax), %r9
               	incq	%r9
               	movslq	%r9d, %r9
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%r9, %xmm0
               	movsd	%xmm0, (%r8)
               	leaq	-0x48(%rbp), %r8
               	addq	%rcx, %r8
               	addq	%r8, %rdx
               	cmpl	%eax, %esi
               	jne	<addr>
               	movabsq	$0x3ff0000000000000, %r11 # imm = 0x3FF0000000000000
               	movq	%r11, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
               	incq	%rsi
               	cmpl	$0x3, %esi
               	jl	<addr>
               	xorl	%edx, %edx
               	movsd	-0x48(%rbp), %xmm1
               	movsd	-0x30(%rbp), %xmm2
               	movsd	-0x18(%rbp), %xmm3
               	movsd	-0x40(%rbp), %xmm4
               	movsd	-0x28(%rbp), %xmm5
               	movsd	-0x10(%rbp), %xmm6
               	movsd	-0x38(%rbp), %xmm7
               	movsd	-0x20(%rbp), %xmm8
               	movsd	-0x8(%rbp), %xmm9
               	movq	%rdx, %rax
               	leaq	-0x90(%rbp), %rcx
               	imulq	$0x18, %rax, %rsi
               	addq	%rsi, %rcx
               	movsd	(%rcx), %xmm0
               	movq	%rdx, %xmm15
               	vfmadd213sd	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm15
               	movsd	0x8(%rcx), %xmm10
               	vfmadd231sd	%xmm2, %xmm10, %xmm0 # xmm0 = (xmm10 * xmm2) + xmm0
               	movsd	0x10(%rcx), %xmm10
               	vfmadd231sd	%xmm3, %xmm10, %xmm0 # xmm0 = (xmm10 * xmm3) + xmm0
               	leaq	-0x90(%rbp), %rcx
               	addq	%rcx, %rsi
               	movsd	(%rsi), %xmm10
               	subsd	%xmm10, %xmm0
               	xorl	%esi, %esi
               	movq	%rsi, %xmm15
               	comisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3e112e0be826d695, %rdi # imm = 0x3E112E0BE826D695
               	movq	%rdi, %xmm15
               	comisd	%xmm0, %xmm15
               	jbe	<addr>
               	imulq	$0x18, %rax, %rdi
               	addq	%rdi, %rcx
               	movsd	(%rcx), %xmm0
               	movq	%rsi, %xmm15
               	vfmadd213sd	%xmm15, %xmm4, %xmm0 # xmm0 = (xmm4 * xmm0) + xmm15
               	movsd	0x8(%rcx), %xmm10
               	vfmadd231sd	%xmm5, %xmm10, %xmm0 # xmm0 = (xmm10 * xmm5) + xmm0
               	movsd	0x10(%rcx), %xmm10
               	vfmadd231sd	%xmm6, %xmm10, %xmm0 # xmm0 = (xmm10 * xmm6) + xmm0
               	leaq	-0x90(%rbp), %rcx
               	leaq	(%rcx,%rdi), %rsi
               	movsd	0x8(%rsi), %xmm10
               	subsd	%xmm10, %xmm0
               	xorl	%esi, %esi
               	movq	%rsi, %xmm15
               	comisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3e112e0be826d695, %rdi # imm = 0x3E112E0BE826D695
               	movq	%rdi, %xmm15
               	comisd	%xmm0, %xmm15
               	jbe	<addr>
               	imulq	$0x18, %rax, %rdi
               	addq	%rdi, %rcx
               	movsd	(%rcx), %xmm0
               	movq	%rsi, %xmm15
               	vfmadd213sd	%xmm15, %xmm7, %xmm0 # xmm0 = (xmm7 * xmm0) + xmm15
               	movsd	0x8(%rcx), %xmm10
               	vfmadd231sd	%xmm8, %xmm10, %xmm0 # xmm0 = (xmm10 * xmm8) + xmm0
               	movsd	0x10(%rcx), %xmm10
               	vfmadd231sd	%xmm9, %xmm10, %xmm0 # xmm0 = (xmm10 * xmm9) + xmm0
               	leaq	-0x90(%rbp), %rcx
               	addq	%rdi, %rcx
               	movsd	0x10(%rcx), %xmm10
               	subsd	%xmm10, %xmm0
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm15
               	comisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3e112e0be826d695, %rcx # imm = 0x3E112E0BE826D695
               	movq	%rcx, %xmm15
               	comisd	%xmm0, %xmm15
               	jbe	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movsd	-0x78(%rbp), %xmm0
               	movsd	-0x80(%rbp), %xmm1
               	movq	%rax, %xmm15
               	vfmadd213sd	%xmm15, %xmm0, %xmm1 # xmm1 = (xmm0 * xmm1) + xmm15
               	movsd	-0x70(%rbp), %xmm2
               	movsd	-0x68(%rbp), %xmm0
               	vfmadd231sd	%xmm0, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm0) + xmm1
               	movsd	-0x50(%rbp), %xmm2
               	vfmadd213sd	%xmm1, %xmm2, %xmm0 # xmm0 = (xmm2 * xmm0) + xmm1
               	movabsq	$0x4058000000000000, %rcx # imm = 0x4058000000000000
               	movq	%rcx, %xmm15
               	subsd	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	comisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3e112e0be826d695, %rcx # imm = 0x3E112E0BE826D695
               	movq	%rcx, %xmm15
               	comisd	%xmm0, %xmm15
               	ja	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leave
               	retq
               	movl	$0x3, %eax
               	leave
               	retq
