
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
               	subq	$0x98, %rsp
               	pushq	%rbx
               	leaq	-0x28(%rbp), %rcx
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, (%rcx,%riz)
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, 0x8(%rcx,%riz)
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0x10(%rcx,%riz)
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0x18(%rcx,%riz)
               	movabsq	$0x4014000000000000, %rax # imm = 0x4014000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0x20(%rcx,%riz)
               	movsd	0x20(%rcx,%riz), %xmm0
               	movl	$0x3, %eax
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	addq	%rcx, %rsi
               	movsd	(%rsi,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rdx, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
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
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x28(%rbp), %rdx
               	movsd	0x20(%rdx,%riz), %xmm0
               	movl	$0x3, %eax
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	addq	%rdx, %rsi
               	movsd	(%rsi,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rcx, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movabsq	$0x3ff0000000000000, %r9 # imm = 0x3FF0000000000000
               	movq	%r9, %xmm15
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
               	popq	%rbx
               	leave
               	retq
               	xorl	%esi, %esi
               	movq	%rsi, %rax
               	leaq	-0x90(%rbp), %rdx
               	imulq	$0x18, %rcx, %rdi
               	addq	%rdi, %rdx
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	leaq	(%rdx,%r8), %rbx
               	leaq	(%rcx,%rcx,2), %rdx
               	addq	%rax, %rdx
               	incq	%rdx
               	movslq	%edx, %rdx
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rdx, %xmm0
               	movsd	%xmm0, (%rbx,%riz)
               	leaq	-0x48(%rbp), %rdx
               	addq	%rdi, %rdx
               	addq	%r8, %rdx
               	cmpl	%eax, %ecx
               	jne	<addr>
               	movabsq	$0x3ff0000000000000, %r11 # imm = 0x3FF0000000000000
               	movq	%r11, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movsd	%xmm0, (%rdx,%riz)
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	incq	%rcx
               	cmpl	$0x3, %ecx
               	jl	<addr>
               	xorl	%r8d, %r8d
               	movq	%r8, %rax
               	leaq	-0x90(%rbp), %rdi
               	leaq	-0x48(%rbp), %rdx
               	imulq	$0x18, %rax, %rsi
               	leaq	(%rdi,%rsi), %rcx
               	movsd	(%rcx,%riz), %xmm0
               	movsd	(%rdx,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movq	%r8, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movsd	0x8(%rcx,%riz), %xmm0
               	leaq	0x18(%rdx), %r9
               	movsd	(%r9,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movsd	0x10(%rcx,%riz), %xmm0
               	leaq	0x30(%rdx), %rcx
               	movsd	(%rcx,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	leaq	-0x90(%rbp), %rdx
               	leaq	(%rdx,%rsi), %rcx
               	movsd	(%rcx,%riz), %xmm1
               	subsd	%xmm1, %xmm0
               	xorl	%r9d, %r9d
               	movq	%r9, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3e112e0be826d695, %rcx # imm = 0x3E112E0BE826D695
               	movq	%rcx, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	leaq	-0x48(%rbp), %rsi
               	imulq	$0x18, %rax, %rdi
               	leaq	(%rdx,%rdi), %rcx
               	movsd	(%rcx,%riz), %xmm0
               	movsd	0x8(%rsi,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movq	%r9, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movsd	0x8(%rcx,%riz), %xmm0
               	leaq	0x18(%rsi), %r9
               	movsd	0x8(%r9,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movsd	0x10(%rcx,%riz), %xmm0
               	leaq	0x30(%rsi), %rcx
               	movsd	0x8(%rcx,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	leaq	-0x90(%rbp), %rdx
               	leaq	(%rdx,%rdi), %rcx
               	movsd	0x8(%rcx,%riz), %xmm1
               	subsd	%xmm1, %xmm0
               	xorl	%r9d, %r9d
               	movq	%r9, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3e112e0be826d695, %rcx # imm = 0x3E112E0BE826D695
               	movq	%rcx, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	leaq	-0x48(%rbp), %rsi
               	imulq	$0x18, %rax, %rdi
               	leaq	(%rdx,%rdi), %rcx
               	movsd	(%rcx,%riz), %xmm0
               	movsd	0x10(%rsi,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movq	%r9, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movsd	0x8(%rcx,%riz), %xmm0
               	leaq	0x18(%rsi), %r9
               	movsd	0x10(%r9,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movsd	0x10(%rcx,%riz), %xmm0
               	leaq	0x30(%rsi), %rcx
               	movsd	0x10(%rcx,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	leaq	-0x90(%rbp), %rcx
               	addq	%rdi, %rcx
               	movsd	0x10(%rcx,%riz), %xmm1
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
               	xorl	%edx, %edx
               	movsd	0x18(%rax,%riz), %xmm0
               	movsd	0x10(%rax,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movq	%rdx, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	leaq	0x18(%rax), %rcx
               	movsd	0x8(%rcx,%riz), %xmm1
               	movsd	0x10(%rcx,%riz), %xmm0
               	movapd	%xmm1, %xmm14
               	movapd	%xmm0, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	addq	$0x30, %rax
               	movsd	0x10(%rax,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movabsq	$0x4058000000000000, %rax # imm = 0x4058000000000000
               	movq	%rax, %xmm15
               	subsd	%xmm15, %xmm0
               	movq	%rdx, %xmm15
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
               	popq	%rbx
               	leave
               	retq
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movabsq	$0x4030000000000000, %rax # imm = 0x4030000000000000
               	movq	%rax, %xmm15
               	movq	%rcx, %xmm0
               	divsd	%xmm15, %xmm0
               	movabsq	$0x3fe0000000000000, %rdx # imm = 0x3FE0000000000000
               	movq	%rdx, %xmm15
               	movapd	%xmm0, %xmm1
               	mulsd	%xmm15, %xmm1
               	movapd	%xmm1, %xmm14
               	movq	%rcx, %xmm15
               	movq	%rcx, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movapd	%xmm1, %xmm14
               	movapd	%xmm2, %xmm15
               	movq	%rcx, %xmm4
               	vfmadd231sd	%xmm15, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm15) + xmm4
               	movapd	%xmm0, %xmm14
               	movapd	%xmm4, %xmm15
               	movq	%rcx, %xmm5
               	vfmadd231sd	%xmm15, %xmm14, %xmm5 # xmm5 = (xmm14 * xmm15) + xmm5
               	movabsq	$0x4018000000000000, %rsi # imm = 0x4018000000000000
               	movq	%rsi, %xmm15
               	movapd	%xmm0, %xmm3
               	divsd	%xmm15, %xmm3
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	movapd	%xmm2, %xmm15
               	movq	%rcx, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movq	%rax, %xmm14
               	movapd	%xmm4, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	addsd	%xmm5, %xmm2
               	movapd	%xmm3, %xmm14
               	movapd	%xmm2, %xmm15
               	movq	%rcx, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movapd	%xmm1, %xmm14
               	movapd	%xmm2, %xmm15
               	movapd	%xmm2, %xmm4
               	vfmadd231sd	%xmm15, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm15) + xmm4
               	movapd	%xmm1, %xmm14
               	movapd	%xmm4, %xmm15
               	movapd	%xmm2, %xmm1
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm5
               	vfmadd231sd	%xmm15, %xmm14, %xmm5 # xmm5 = (xmm14 * xmm15) + xmm5
               	movq	%rax, %xmm14
               	movapd	%xmm4, %xmm15
               	movapd	%xmm2, %xmm4
               	vfmadd231sd	%xmm15, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm15) + xmm4
               	movq	%rax, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm4, %xmm1
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	addsd	%xmm5, %xmm1
               	movapd	%xmm3, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm1
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movq	%rdx, %xmm15
               	movapd	%xmm0, %xmm2
               	mulsd	%xmm15, %xmm2
               	movapd	%xmm2, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm1, %xmm4
               	vfmadd231sd	%xmm15, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm15) + xmm4
               	movapd	%xmm2, %xmm14
               	movapd	%xmm4, %xmm15
               	movapd	%xmm1, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movapd	%xmm0, %xmm14
               	movapd	%xmm2, %xmm15
               	movapd	%xmm1, %xmm5
               	vfmadd231sd	%xmm15, %xmm14, %xmm5 # xmm5 = (xmm14 * xmm15) + xmm5
               	movq	%rax, %xmm14
               	movapd	%xmm4, %xmm15
               	movapd	%xmm1, %xmm4
               	vfmadd231sd	%xmm15, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm15) + xmm4
               	movq	%rax, %xmm14
               	movapd	%xmm2, %xmm15
               	movapd	%xmm4, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	addsd	%xmm5, %xmm2
               	movapd	%xmm3, %xmm14
               	movapd	%xmm2, %xmm15
               	movapd	%xmm1, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	movq	%rcx, %xmm15
               	movapd	%xmm0, %xmm1
               	mulsd	%xmm15, %xmm1
               	movapd	%xmm1, %xmm14
               	movapd	%xmm2, %xmm15
               	movapd	%xmm2, %xmm3
               	vfmadd231sd	%xmm15, %xmm14, %xmm3 # xmm3 = (xmm14 * xmm15) + xmm3
               	movapd	%xmm1, %xmm14
               	movapd	%xmm3, %xmm15
               	movapd	%xmm2, %xmm4
               	vfmadd231sd	%xmm15, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm15) + xmm4
               	movapd	%xmm0, %xmm14
               	movapd	%xmm4, %xmm15
               	movapd	%xmm2, %xmm6
               	vfmadd231sd	%xmm15, %xmm14, %xmm6 # xmm6 = (xmm14 * xmm15) + xmm6
               	movabsq	$0x4018000000000000, %rdx # imm = 0x4018000000000000
               	movq	%rdx, %xmm15
               	movapd	%xmm0, %xmm5
               	divsd	%xmm15, %xmm5
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	movapd	%xmm3, %xmm15
               	movapd	%xmm2, %xmm3
               	vfmadd231sd	%xmm15, %xmm14, %xmm3 # xmm3 = (xmm14 * xmm15) + xmm3
               	movq	%rax, %xmm14
               	movapd	%xmm4, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm3 # xmm3 = (xmm14 * xmm15) + xmm3
               	addsd	%xmm6, %xmm3
               	movapd	%xmm5, %xmm14
               	movapd	%xmm3, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movapd	%xmm1, %xmm14
               	movapd	%xmm2, %xmm15
               	movapd	%xmm2, %xmm3
               	vfmadd231sd	%xmm15, %xmm14, %xmm3 # xmm3 = (xmm14 * xmm15) + xmm3
               	movapd	%xmm1, %xmm14
               	movapd	%xmm3, %xmm15
               	movapd	%xmm2, %xmm1
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm4
               	vfmadd231sd	%xmm15, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm15) + xmm4
               	movq	%rax, %xmm14
               	movapd	%xmm3, %xmm15
               	movapd	%xmm2, %xmm3
               	vfmadd231sd	%xmm15, %xmm14, %xmm3 # xmm3 = (xmm14 * xmm15) + xmm3
               	movq	%rax, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm3, %xmm1
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	addsd	%xmm4, %xmm1
               	movapd	%xmm5, %xmm14
               	movapd	%xmm1, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movq	%rcx, %xmm15
               	movapd	%xmm0, %xmm1
               	mulsd	%xmm15, %xmm1
               	movapd	%xmm1, %xmm14
               	movapd	%xmm2, %xmm15
               	movapd	%xmm2, %xmm3
               	vfmadd231sd	%xmm15, %xmm14, %xmm3 # xmm3 = (xmm14 * xmm15) + xmm3
               	movapd	%xmm1, %xmm14
               	movapd	%xmm3, %xmm15
               	movapd	%xmm2, %xmm4
               	vfmadd231sd	%xmm15, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm15) + xmm4
               	movapd	%xmm0, %xmm14
               	movapd	%xmm4, %xmm15
               	movapd	%xmm2, %xmm6
               	vfmadd231sd	%xmm15, %xmm14, %xmm6 # xmm6 = (xmm14 * xmm15) + xmm6
               	movq	%rdx, %xmm15
               	movapd	%xmm0, %xmm5
               	divsd	%xmm15, %xmm5
               	movq	%rax, %xmm14
               	movapd	%xmm3, %xmm15
               	movapd	%xmm2, %xmm3
               	vfmadd231sd	%xmm15, %xmm14, %xmm3 # xmm3 = (xmm14 * xmm15) + xmm3
               	movq	%rax, %xmm14
               	movapd	%xmm4, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm3 # xmm3 = (xmm14 * xmm15) + xmm3
               	addsd	%xmm6, %xmm3
               	movapd	%xmm5, %xmm14
               	movapd	%xmm3, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movapd	%xmm1, %xmm14
               	movapd	%xmm2, %xmm15
               	movapd	%xmm2, %xmm4
               	vfmadd231sd	%xmm15, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm15) + xmm4
               	movapd	%xmm1, %xmm14
               	movapd	%xmm4, %xmm15
               	movapd	%xmm2, %xmm1
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm5
               	vfmadd231sd	%xmm15, %xmm14, %xmm5 # xmm5 = (xmm14 * xmm15) + xmm5
               	movabsq	$0x4018000000000000, %rcx # imm = 0x4018000000000000
               	movq	%rcx, %xmm15
               	movapd	%xmm0, %xmm3
               	divsd	%xmm15, %xmm3
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	movapd	%xmm4, %xmm15
               	movapd	%xmm2, %xmm4
               	vfmadd231sd	%xmm15, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm15) + xmm4
               	movq	%rax, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm4, %xmm1
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	addsd	%xmm5, %xmm1
               	movapd	%xmm3, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm1
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movabsq	$0x3fe0000000000000, %rdx # imm = 0x3FE0000000000000
               	movq	%rdx, %xmm15
               	movapd	%xmm0, %xmm2
               	mulsd	%xmm15, %xmm2
               	movapd	%xmm2, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm1, %xmm4
               	vfmadd231sd	%xmm15, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm15) + xmm4
               	movapd	%xmm2, %xmm14
               	movapd	%xmm4, %xmm15
               	movapd	%xmm1, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movapd	%xmm0, %xmm14
               	movapd	%xmm2, %xmm15
               	movapd	%xmm1, %xmm5
               	vfmadd231sd	%xmm15, %xmm14, %xmm5 # xmm5 = (xmm14 * xmm15) + xmm5
               	movq	%rax, %xmm14
               	movapd	%xmm4, %xmm15
               	movapd	%xmm1, %xmm4
               	vfmadd231sd	%xmm15, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm15) + xmm4
               	movq	%rax, %xmm14
               	movapd	%xmm2, %xmm15
               	movapd	%xmm4, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	addsd	%xmm5, %xmm2
               	movapd	%xmm3, %xmm14
               	movapd	%xmm2, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movq	%rdx, %xmm15
               	movapd	%xmm0, %xmm2
               	mulsd	%xmm15, %xmm2
               	movapd	%xmm2, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm1, %xmm4
               	vfmadd231sd	%xmm15, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm15) + xmm4
               	movapd	%xmm2, %xmm14
               	movapd	%xmm4, %xmm15
               	movapd	%xmm1, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movapd	%xmm0, %xmm14
               	movapd	%xmm2, %xmm15
               	movapd	%xmm1, %xmm5
               	vfmadd231sd	%xmm15, %xmm14, %xmm5 # xmm5 = (xmm14 * xmm15) + xmm5
               	movq	%rax, %xmm14
               	movapd	%xmm4, %xmm15
               	movapd	%xmm1, %xmm4
               	vfmadd231sd	%xmm15, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm15) + xmm4
               	movq	%rax, %xmm14
               	movapd	%xmm2, %xmm15
               	movapd	%xmm4, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	addsd	%xmm5, %xmm2
               	movapd	%xmm3, %xmm14
               	movapd	%xmm2, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movq	%rdx, %xmm15
               	movapd	%xmm0, %xmm2
               	mulsd	%xmm15, %xmm2
               	movapd	%xmm2, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm1, %xmm3
               	vfmadd231sd	%xmm15, %xmm14, %xmm3 # xmm3 = (xmm14 * xmm15) + xmm3
               	movapd	%xmm2, %xmm14
               	movapd	%xmm3, %xmm15
               	movapd	%xmm1, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movapd	%xmm0, %xmm14
               	movapd	%xmm2, %xmm15
               	movapd	%xmm1, %xmm5
               	vfmadd231sd	%xmm15, %xmm14, %xmm5 # xmm5 = (xmm14 * xmm15) + xmm5
               	movq	%rcx, %xmm15
               	movapd	%xmm0, %xmm4
               	divsd	%xmm15, %xmm4
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	movapd	%xmm3, %xmm15
               	movapd	%xmm1, %xmm3
               	vfmadd231sd	%xmm15, %xmm14, %xmm3 # xmm3 = (xmm14 * xmm15) + xmm3
               	movq	%rax, %xmm14
               	movapd	%xmm2, %xmm15
               	movapd	%xmm3, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	addsd	%xmm5, %xmm2
               	movapd	%xmm4, %xmm14
               	movapd	%xmm2, %xmm15
               	movapd	%xmm1, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	movq	%rcx, %xmm15
               	movapd	%xmm0, %xmm1
               	mulsd	%xmm15, %xmm1
               	movapd	%xmm1, %xmm14
               	movapd	%xmm2, %xmm15
               	movapd	%xmm2, %xmm3
               	vfmadd231sd	%xmm15, %xmm14, %xmm3 # xmm3 = (xmm14 * xmm15) + xmm3
               	movapd	%xmm1, %xmm14
               	movapd	%xmm3, %xmm15
               	movapd	%xmm2, %xmm4
               	vfmadd231sd	%xmm15, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm15) + xmm4
               	movapd	%xmm0, %xmm14
               	movapd	%xmm4, %xmm15
               	movapd	%xmm2, %xmm6
               	vfmadd231sd	%xmm15, %xmm14, %xmm6 # xmm6 = (xmm14 * xmm15) + xmm6
               	movabsq	$0x4018000000000000, %rdx # imm = 0x4018000000000000
               	movq	%rdx, %xmm15
               	movapd	%xmm0, %xmm5
               	divsd	%xmm15, %xmm5
               	movq	%rax, %xmm14
               	movapd	%xmm3, %xmm15
               	movapd	%xmm2, %xmm3
               	vfmadd231sd	%xmm15, %xmm14, %xmm3 # xmm3 = (xmm14 * xmm15) + xmm3
               	movq	%rax, %xmm14
               	movapd	%xmm4, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm3 # xmm3 = (xmm14 * xmm15) + xmm3
               	addsd	%xmm6, %xmm3
               	movapd	%xmm5, %xmm14
               	movapd	%xmm3, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movapd	%xmm1, %xmm14
               	movapd	%xmm2, %xmm15
               	movapd	%xmm2, %xmm3
               	vfmadd231sd	%xmm15, %xmm14, %xmm3 # xmm3 = (xmm14 * xmm15) + xmm3
               	movapd	%xmm1, %xmm14
               	movapd	%xmm3, %xmm15
               	movapd	%xmm2, %xmm1
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm4
               	vfmadd231sd	%xmm15, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm15) + xmm4
               	movq	%rax, %xmm14
               	movapd	%xmm3, %xmm15
               	movapd	%xmm2, %xmm3
               	vfmadd231sd	%xmm15, %xmm14, %xmm3 # xmm3 = (xmm14 * xmm15) + xmm3
               	movq	%rax, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm3, %xmm1
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	addsd	%xmm4, %xmm1
               	movapd	%xmm5, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm1
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movq	%rcx, %xmm15
               	movapd	%xmm0, %xmm2
               	mulsd	%xmm15, %xmm2
               	movapd	%xmm2, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm1, %xmm3
               	vfmadd231sd	%xmm15, %xmm14, %xmm3 # xmm3 = (xmm14 * xmm15) + xmm3
               	movapd	%xmm2, %xmm14
               	movapd	%xmm3, %xmm15
               	movapd	%xmm1, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movapd	%xmm0, %xmm14
               	movapd	%xmm2, %xmm15
               	movapd	%xmm1, %xmm5
               	vfmadd231sd	%xmm15, %xmm14, %xmm5 # xmm5 = (xmm14 * xmm15) + xmm5
               	movq	%rdx, %xmm15
               	movapd	%xmm0, %xmm4
               	divsd	%xmm15, %xmm4
               	movq	%rax, %xmm14
               	movapd	%xmm3, %xmm15
               	movapd	%xmm1, %xmm3
               	vfmadd231sd	%xmm15, %xmm14, %xmm3 # xmm3 = (xmm14 * xmm15) + xmm3
               	movq	%rax, %xmm14
               	movapd	%xmm2, %xmm15
               	movapd	%xmm3, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	addsd	%xmm5, %xmm2
               	movapd	%xmm4, %xmm14
               	movapd	%xmm2, %xmm15
               	movapd	%xmm1, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	movq	%rcx, %xmm15
               	movapd	%xmm0, %xmm1
               	mulsd	%xmm15, %xmm1
               	movapd	%xmm1, %xmm14
               	movapd	%xmm2, %xmm15
               	movapd	%xmm2, %xmm3
               	vfmadd231sd	%xmm15, %xmm14, %xmm3 # xmm3 = (xmm14 * xmm15) + xmm3
               	movapd	%xmm1, %xmm14
               	movapd	%xmm3, %xmm15
               	movapd	%xmm2, %xmm4
               	vfmadd231sd	%xmm15, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm15) + xmm4
               	movapd	%xmm0, %xmm14
               	movapd	%xmm4, %xmm15
               	movapd	%xmm2, %xmm6
               	vfmadd231sd	%xmm15, %xmm14, %xmm6 # xmm6 = (xmm14 * xmm15) + xmm6
               	movabsq	$0x4018000000000000, %rdx # imm = 0x4018000000000000
               	movq	%rdx, %xmm15
               	movapd	%xmm0, %xmm5
               	divsd	%xmm15, %xmm5
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	movapd	%xmm3, %xmm15
               	movapd	%xmm2, %xmm3
               	vfmadd231sd	%xmm15, %xmm14, %xmm3 # xmm3 = (xmm14 * xmm15) + xmm3
               	movq	%rax, %xmm14
               	movapd	%xmm4, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm3 # xmm3 = (xmm14 * xmm15) + xmm3
               	addsd	%xmm6, %xmm3
               	movapd	%xmm5, %xmm14
               	movapd	%xmm3, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movapd	%xmm1, %xmm14
               	movapd	%xmm2, %xmm15
               	movapd	%xmm2, %xmm3
               	vfmadd231sd	%xmm15, %xmm14, %xmm3 # xmm3 = (xmm14 * xmm15) + xmm3
               	movapd	%xmm1, %xmm14
               	movapd	%xmm3, %xmm15
               	movapd	%xmm2, %xmm1
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm4
               	vfmadd231sd	%xmm15, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm15) + xmm4
               	movq	%rax, %xmm14
               	movapd	%xmm3, %xmm15
               	movapd	%xmm2, %xmm3
               	vfmadd231sd	%xmm15, %xmm14, %xmm3 # xmm3 = (xmm14 * xmm15) + xmm3
               	movq	%rax, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm3, %xmm1
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	addsd	%xmm4, %xmm1
               	movapd	%xmm5, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm1
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movq	%rcx, %xmm15
               	movapd	%xmm0, %xmm2
               	mulsd	%xmm15, %xmm2
               	movapd	%xmm2, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm1, %xmm3
               	vfmadd231sd	%xmm15, %xmm14, %xmm3 # xmm3 = (xmm14 * xmm15) + xmm3
               	movapd	%xmm2, %xmm14
               	movapd	%xmm3, %xmm15
               	movapd	%xmm1, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movapd	%xmm0, %xmm14
               	movapd	%xmm2, %xmm15
               	movapd	%xmm1, %xmm4
               	vfmadd231sd	%xmm15, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm15) + xmm4
               	movq	%rdx, %xmm15
               	divsd	%xmm15, %xmm0
               	movq	%rax, %xmm14
               	movapd	%xmm3, %xmm15
               	movapd	%xmm1, %xmm3
               	vfmadd231sd	%xmm15, %xmm14, %xmm3 # xmm3 = (xmm14 * xmm15) + xmm3
               	movq	%rax, %xmm14
               	movapd	%xmm2, %xmm15
               	movapd	%xmm3, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	addsd	%xmm4, %xmm2
               	movapd	%xmm0, %xmm14
               	movapd	%xmm2, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
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
               	popq	%rbx
               	leave
               	retq
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
