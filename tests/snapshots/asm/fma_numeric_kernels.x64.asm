
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
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
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
               	testl	%eax, %eax
               	jl	<addr>
               	movslq	%eax, %rsi
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
               	xorq	%rax, %rax
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3e112e0be826d695, %rax # imm = 0x3E112E0BE826D695
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x28(%rbp), %rdx
               	xorq	%rcx, %rcx
               	movsd	0x20(%rdx,%riz), %xmm0
               	movl	$0x3, %eax
               	testl	%eax, %eax
               	jl	<addr>
               	movslq	%eax, %rsi
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
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	subsd	%xmm15, %xmm0
               	xorq	%rax, %rax
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3e112e0be826d695, %rax # imm = 0x3E112E0BE826D695
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rdi, %rdi
               	cmpl	$0x3, %edi
               	jge	<addr>
               	xorq	%rax, %rax
               	cmpl	$0x3, %eax
               	jge	<addr>
               	leaq	-0x90(%rbp), %rdx
               	movslq	%edi, %rcx
               	imulq	$0x18, %rcx, %r8
               	leaq	(%rdx,%r8), %rsi
               	movslq	%eax, %rdx
               	movq	%rdx, %r9
               	shlq	$0x3, %r9
               	leaq	(%rsi,%r9), %rbx
               	leaq	(%rcx,%rcx,2), %rsi
               	addq	%rdx, %rsi
               	incq	%rsi
               	movslq	%esi, %rsi
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rsi, %xmm0
               	movsd	%xmm0, (%rbx,%riz)
               	leaq	-0x48(%rbp), %rsi
               	addq	%r8, %rsi
               	addq	%r9, %rsi
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movabsq	$0x3ff0000000000000, %r11 # imm = 0x3FF0000000000000
               	movq	%r11, %xmm0
               	movsd	%xmm0, (%rsi,%riz)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	xorq	%r11, %r11
               	movq	%r11, %xmm0
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	incq	%rdi
               	cmpl	$0x3, %edi
               	jl	<addr>
               	xorq	%rcx, %rcx
               	cmpl	$0x3, %ecx
               	jge	<addr>
               	leaq	-0x90(%rbp), %rsi
               	leaq	-0x48(%rbp), %rdi
               	movslq	%ecx, %rax
               	xorq	%r9, %r9
               	imulq	$0x18, %rax, %r8
               	leaq	(%rsi,%r8), %rdx
               	leaq	(%rdx), %rbx
               	movsd	(%rbx,%riz), %xmm0
               	leaq	(%rdi), %rbx
               	addq	$0x0, %rbx
               	movsd	(%rbx,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movq	%r9, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movsd	0x8(%rdx,%riz), %xmm0
               	leaq	0x18(%rdi), %r9
               	addq	$0x0, %r9
               	movsd	(%r9,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movsd	0x10(%rdx,%riz), %xmm0
               	leaq	0x30(%rdi), %rdx
               	addq	$0x0, %rdx
               	movsd	(%rdx,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm1
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	leaq	-0x90(%rbp), %rdx
               	imulq	$0x18, %rax, %rsi
               	leaq	(%rdx,%rsi), %r8
               	leaq	(%r8), %r9
               	movsd	(%r9,%riz), %xmm0
               	movapd	%xmm0, %xmm15
               	movapd	%xmm1, %xmm0
               	subsd	%xmm15, %xmm0
               	xorq	%rbx, %rbx
               	movq	%rbx, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3e112e0be826d695, %rdi # imm = 0x3E112E0BE826D695
               	movq	%rdi, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setb	%dil
               	movzbq	%dil, %rdi
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	-0x48(%rbp), %rdi
               	movsd	(%r9,%riz), %xmm0
               	leaq	(%rdi), %r8
               	movsd	0x8(%r8,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movq	%rbx, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	addq	%rdx, %rsi
               	movsd	0x8(%rsi,%riz), %xmm0
               	leaq	0x18(%rdi), %rsi
               	movsd	0x8(%rsi,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	imulq	$0x18, %rax, %rsi
               	addq	%rsi, %rdx
               	movsd	0x10(%rdx,%riz), %xmm0
               	leaq	0x30(%rdi), %rdx
               	movsd	0x8(%rdx,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm1
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	leaq	-0x90(%rbp), %rdx
               	imulq	$0x18, %rax, %rsi
               	leaq	(%rdx,%rsi), %rdi
               	movsd	0x8(%rdi,%riz), %xmm0
               	movapd	%xmm0, %xmm15
               	movapd	%xmm1, %xmm0
               	subsd	%xmm15, %xmm0
               	xorq	%r9, %r9
               	movq	%r9, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3e112e0be826d695, %r8 # imm = 0x3E112E0BE826D695
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setb	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %r8
               	testq	%r8, %r8
               	je	<addr>
               	leaq	-0x48(%rbp), %r8
               	addq	$0x0, %rdi
               	movsd	(%rdi,%riz), %xmm0
               	leaq	(%r8), %rdi
               	movsd	0x10(%rdi,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movq	%r9, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	leaq	(%rdx,%rsi), %rdi
               	movsd	0x8(%rdi,%riz), %xmm0
               	leaq	0x18(%r8), %r9
               	movsd	0x10(%r9,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movsd	0x10(%rdi,%riz), %xmm0
               	leaq	0x30(%r8), %rdx
               	movsd	0x10(%rdx,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm1
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	leaq	-0x90(%rbp), %rdx
               	imulq	$0x18, %rax, %rax
               	addq	%rdx, %rax
               	movsd	0x10(%rax,%riz), %xmm0
               	movapd	%xmm0, %xmm15
               	movapd	%xmm1, %xmm0
               	subsd	%xmm15, %xmm0
               	xorq	%rax, %rax
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3e112e0be826d695, %rax # imm = 0x3E112E0BE826D695
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	incq	%rcx
               	cmpl	$0x3, %ecx
               	jl	<addr>
               	leaq	-0x90(%rbp), %rcx
               	xorq	%rdx, %rdx
               	leaq	0x18(%rcx), %rax
               	leaq	(%rax), %rsi
               	movsd	(%rsi,%riz), %xmm0
               	leaq	(%rcx), %rsi
               	movsd	0x10(%rsi,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movq	%rdx, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movsd	0x8(%rax,%riz), %xmm1
               	movsd	0x10(%rax,%riz), %xmm0
               	movapd	%xmm1, %xmm14
               	movapd	%xmm0, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	leaq	0x30(%rcx), %rax
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
               	ucomisd	%xmm15, %xmm0
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
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
               	xorq	%rax, %rax
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
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
