
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
               	subq	$0xc0, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x28(%rbp), %rax
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, (%rax,%riz)
               	leaq	-0x28(%rbp), %rax
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, 0x8(%rax,%riz)
               	leaq	-0x28(%rbp), %rax
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, 0x10(%rax,%riz)
               	leaq	-0x28(%rbp), %rax
               	movabsq	$0x4010000000000000, %rcx # imm = 0x4010000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, 0x18(%rax,%riz)
               	leaq	-0x28(%rbp), %rax
               	movabsq	$0x4014000000000000, %rcx # imm = 0x4014000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, 0x20(%rax,%riz)
               	leaq	-0x28(%rbp), %rsi
               	movsd	0x20(%rsi,%riz), %xmm0
               	movl	$0x3, %eax
               	jmp	<addr>
               	movq	%rcx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rsi, %rdi
               	movsd	(%rdi,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rdx, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	leaq	-0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rsi
               	xorq	%rdx, %rdx
               	movsd	0x20(%rsi,%riz), %xmm0
               	movl	$0x3, %eax
               	jmp	<addr>
               	movq	%rcx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rsi, %rdi
               	movsd	(%rdi,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rdx, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	leaq	-0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x90(%rbp), %rsi
               	imulq	$0x18, %rdx, %r8
               	addq	%r8, %rsi
               	movq	%rcx, %r8
               	shlq	$0x3, %r8
               	addq	%rsi, %r8
               	leaq	(%rdx,%rdx,2), %rsi
               	addq	%rcx, %rsi
               	incq	%rsi
               	movslq	%esi, %rsi
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rsi, %xmm0
               	movsd	%xmm0, (%r8,%riz)
               	leaq	-0x48(%rbp), %rsi
               	imulq	$0x18, %rdx, %r8
               	addq	%r8, %rsi
               	movq	%rcx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rsi
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	movabsq	$0x3ff0000000000000, %r8 # imm = 0x3FF0000000000000
               	movq	%r8, %xmm14
               	movsd	%xmm14, -0x98(%rbp,%riz)
               	movsd	-0x98(%rbp,%riz), %xmm0
               	movsd	%xmm0, (%rsi,%riz)
               	jmp	<addr>
               	xorq	%r8, %r8
               	movq	%r8, %xmm14
               	movsd	%xmm14, -0x98(%rbp,%riz)
               	jmp	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x3, %rcx
               	jl	<addr>
               	leaq	0x1(%rdx), %rdi
               	movslq	%edi, %rdx
               	cmpq	$0x3, %rdx
               	jl	<addr>
               	xorq	%r8, %r8
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x90(%rbp), %rsi
               	leaq	-0x48(%rbp), %rdi
               	xorq	%r9, %r9
               	movq	%r9, %xmm14
               	movsd	%xmm14, -0x98(%rbp,%riz)
               	movsd	-0x98(%rbp,%riz), %xmm2
               	imulq	$0x18, %rdx, %r9
               	addq	%rsi, %r9
               	addq	$0x0, %r9
               	movsd	(%r9,%riz), %xmm0
               	leaq	(%rdi), %r9
               	movq	%rcx, %rbx
               	shlq	$0x3, %rbx
               	addq	%rbx, %r9
               	movsd	(%r9,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movsd	%xmm0, -0x98(%rbp,%riz)
               	movsd	-0x98(%rbp,%riz), %xmm2
               	imulq	$0x18, %rdx, %r9
               	addq	%rsi, %r9
               	movsd	0x8(%r9,%riz), %xmm0
               	leaq	0x18(%rdi), %r9
               	movq	%rcx, %rbx
               	shlq	$0x3, %rbx
               	addq	%rbx, %r9
               	movsd	(%r9,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movsd	%xmm0, -0x98(%rbp,%riz)
               	movsd	-0x98(%rbp,%riz), %xmm2
               	imulq	$0x18, %rdx, %r9
               	addq	%r9, %rsi
               	movsd	0x10(%rsi,%riz), %xmm0
               	leaq	0x30(%rdi), %rsi
               	movq	%rcx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movsd	(%rsi,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movsd	%xmm0, -0x98(%rbp,%riz)
               	movsd	-0x98(%rbp,%riz), %xmm1
               	leaq	-0x90(%rbp), %rsi
               	imulq	$0x18, %rdx, %rdi
               	addq	%rdi, %rsi
               	movq	%rcx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movsd	(%rsi,%riz), %xmm0
               	movapd	%xmm0, %xmm15
               	movapd	%xmm1, %xmm0
               	subsd	%xmm15, %xmm0
               	xorq	%rsi, %rsi
               	movq	%rsi, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3e112e0be826d695, %rsi # imm = 0x3E112E0BE826D695
               	movq	%rsi, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setb	%sil
               	movzbq	%sil, %rsi
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rsi
               	movslq	%esi, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x3, %rcx
               	jl	<addr>
               	leaq	0x1(%rdx), %r8
               	movslq	%r8d, %rdx
               	cmpq	$0x3, %rdx
               	jl	<addr>
               	leaq	-0x90(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x98(%rbp,%riz)
               	movsd	-0x98(%rbp,%riz), %xmm2
               	leaq	0x18(%rax), %rdx
               	addq	$0x0, %rdx
               	movsd	(%rdx,%riz), %xmm0
               	leaq	(%rcx), %rdx
               	movsd	0x10(%rdx,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movsd	%xmm0, -0x98(%rbp,%riz)
               	movsd	-0x98(%rbp,%riz), %xmm2
               	leaq	0x18(%rax), %rdx
               	movsd	0x8(%rdx,%riz), %xmm0
               	leaq	0x18(%rcx), %rdx
               	movsd	0x10(%rdx,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movsd	%xmm0, -0x98(%rbp,%riz)
               	movsd	-0x98(%rbp,%riz), %xmm2
               	addq	$0x18, %rax
               	movsd	0x10(%rax,%riz), %xmm0
               	leaq	0x30(%rcx), %rax
               	movsd	0x10(%rax,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movsd	%xmm0, -0x98(%rbp,%riz)
               	movsd	-0x98(%rbp,%riz), %xmm0
               	movabsq	$0x4058000000000000, %rax # imm = 0x4058000000000000
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0xa8(%rbp,%riz)
               	movabsq	$0x4030000000000000, %rcx # imm = 0x4030000000000000
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	divsd	%xmm15, %xmm0
               	movsd	-0xa8(%rbp,%riz), %xmm1
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
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
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
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
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movsd	%xmm1, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm1
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
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
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
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
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movsd	%xmm1, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm1
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
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
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
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
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movsd	%xmm1, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm1
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
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
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
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
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movsd	%xmm1, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm1
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
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
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
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
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movsd	%xmm1, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm1
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
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
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
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
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movsd	%xmm1, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm1
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
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
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
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
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movsd	%xmm1, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm1
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
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
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
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
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movsd	%xmm1, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm1
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
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
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
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
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movsd	%xmm1, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm1
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
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
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
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
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movsd	%xmm1, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm1
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
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
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
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
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movsd	%xmm1, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm1
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
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
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
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
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movsd	%xmm1, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm1
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
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
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
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
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movsd	%xmm1, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm1
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
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
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
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
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movsd	%xmm1, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm1
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
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
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
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
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movsd	%xmm1, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm1
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
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
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
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
               	movsd	%xmm0, -0xa8(%rbp,%riz)
               	movabsq	$0x4005bf0a8b145769, %rax # imm = 0x4005BF0A8B145769
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x98(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm0
               	movsd	-0x98(%rbp,%riz), %xmm1
               	subsd	%xmm1, %xmm0
               	xorq	%rax, %rax
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3eb0c6f7a0b5ed8d, %rax # imm = 0x3EB0C6F7A0B5ED8D
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
