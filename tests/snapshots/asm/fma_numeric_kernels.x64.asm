
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
               	subq	$0xd0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
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
               	jmp	<addr>
               	movslq	%eax, %rsi
               	movq	%rsi, %rdi
               	shlq	$0x3, %rdi
               	addq	%rcx, %rdi
               	movsd	(%rdi,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rdx, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	leaq	-0x1(%rsi), %rax
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rsi
               	xorq	%rcx, %rcx
               	movsd	0x20(%rsi,%riz), %xmm0
               	movl	$0x3, %eax
               	jmp	<addr>
               	movslq	%eax, %rdx
               	movq	%rdx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rsi, %rdi
               	movsd	(%rdi,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rcx, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	leaq	-0x1(%rdx), %rax
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x90(%rbp), %rcx
               	movslq	%edi, %rdx
               	imulq	$0x18, %rdx, %r8
               	leaq	(%rcx,%r8), %rsi
               	movslq	%eax, %rcx
               	movq	%rcx, %r9
               	shlq	$0x3, %r9
               	leaq	(%rsi,%r9), %rbx
               	leaq	(%rdx,%rdx,2), %rsi
               	addq	%rcx, %rsi
               	incq	%rsi
               	movslq	%esi, %rsi
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rsi, %xmm0
               	movsd	%xmm0, (%rbx,%riz)
               	leaq	-0x48(%rbp), %rsi
               	addq	%r8, %rsi
               	addq	%r9, %rsi
               	cmpl	%ecx, %edx
               	jne	<addr>
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x98(%rbp,%riz)
               	movsd	-0x98(%rbp,%riz), %xmm0
               	movsd	%xmm0, (%rsi,%riz)
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x98(%rbp,%riz)
               	jmp	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movslq	%edi, %rax
               	leaq	0x1(%rax), %rdi
               	cmpl	$0x3, %edi
               	jl	<addr>
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x90(%rbp), %rsi
               	leaq	-0x48(%rbp), %rdi
               	movslq	%ebx, %rdx
               	movslq	%eax, %rcx
               	xorq	%r8, %r8
               	movq	%r8, %xmm14
               	movsd	%xmm14, -0x98(%rbp,%riz)
               	movsd	-0x98(%rbp,%riz), %xmm2
               	imulq	$0x18, %rdx, %r8
               	leaq	(%rsi,%r8), %r9
               	leaq	(%r9), %r12
               	movsd	(%r12), %xmm0
               	leaq	(%rdi), %r12
               	movq	%rcx, %r13
               	shlq	$0x3, %r13
               	addq	%r13, %r12
               	movsd	(%r12), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movsd	%xmm0, -0x98(%rbp,%riz)
               	movsd	-0x98(%rbp,%riz), %xmm2
               	movsd	0x8(%r9,%riz), %xmm0
               	leaq	0x18(%rdi), %r12
               	movq	%rcx, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %r12
               	movsd	(%r12), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movsd	%xmm0, -0x98(%rbp,%riz)
               	movsd	-0x98(%rbp,%riz), %xmm2
               	addq	%r8, %rsi
               	movsd	0x10(%rsi,%riz), %xmm0
               	leaq	0x30(%rdi), %rsi
               	addq	%r9, %rsi
               	movsd	(%rsi,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movsd	%xmm0, -0x98(%rbp,%riz)
               	movsd	-0x98(%rbp,%riz), %xmm1
               	leaq	-0x90(%rbp), %rsi
               	imulq	$0x18, %rdx, %rdx
               	addq	%rsi, %rdx
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movsd	(%rdx,%riz), %xmm0
               	movapd	%xmm0, %xmm15
               	movapd	%xmm1, %xmm0
               	subsd	%xmm15, %xmm0
               	xorq	%rdx, %rdx
               	movq	%rdx, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3e112e0be826d695, %rdx # imm = 0x3E112E0BE826D695
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setb	%dl
               	movzbq	%dl, %rdx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movslq	%ebx, %rax
               	leaq	0x1(%rax), %rbx
               	cmpl	$0x3, %ebx
               	jl	<addr>
               	leaq	-0x90(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x98(%rbp,%riz)
               	movsd	-0x98(%rbp,%riz), %xmm2
               	leaq	0x18(%rcx), %rax
               	leaq	(%rax), %rsi
               	movsd	(%rsi,%riz), %xmm0
               	leaq	(%rcx), %rsi
               	movsd	0x10(%rsi,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movsd	%xmm0, -0x98(%rbp,%riz)
               	movsd	-0x98(%rbp,%riz), %xmm2
               	movsd	0x8(%rax,%riz), %xmm0
               	movsd	0x10(%rax,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movsd	%xmm0, -0x98(%rbp,%riz)
               	movsd	-0x98(%rbp,%riz), %xmm2
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0xa8(%rbp,%riz)
               	movabsq	$0x4030000000000000, %rcx # imm = 0x4030000000000000
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	divsd	%xmm15, %xmm0
               	movsd	-0xa8(%rbp,%riz), %xmm2
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
               	movsd	%xmm2, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm2
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
               	movsd	%xmm1, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm2
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
               	movsd	%xmm2, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm2
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
               	movsd	%xmm1, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm1
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
               	movsd	%xmm1, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm1
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
               	movsd	%xmm1, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm1
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
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movsd	%xmm1, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm2
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
               	movsd	%xmm2, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm2
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
               	movsd	%xmm1, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm1
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
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movsd	%xmm1, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm2
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
               	movsd	%xmm2, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm2
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
               	movsd	%xmm1, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm2
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
               	movsd	%xmm2, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm2
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
               	movsd	%xmm1, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm1
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
               	movsd	%xmm1, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm1
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
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movq	%rax, %xmm14
               	movapd	%xmm2, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	addsd	%xmm5, %xmm0
               	movapd	%xmm3, %xmm14
               	movapd	%xmm0, %xmm15
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
               	movabsq	$0x3eb0c6f7a0b5ed8d, %rcx # imm = 0x3EB0C6F7A0B5ED8D
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
