
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
               	leaq	-0x28(%rbp), %rcx
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, -0x28(%rbp)
               	movsd	<rip>, %xmm1
               	movsd	%xmm1, -0x20(%rbp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, -0x18(%rbp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm0
               	movl	$0x3, %eax
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rcx, %rdx
               	movsd	(%rdx), %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movsd	<rip>, %xmm2
               	vsubsd	%xmm2, %xmm0, %xmm1
               	xorps	%xmm0, %xmm0
               	comisd	%xmm1, %xmm0
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movsd	<rip>, %xmm2
               	comisd	%xmm1, %xmm2
               	ja	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %rcx
               	movsd	-0x8(%rbp), %xmm1
               	movl	$0x3, %eax
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rcx, %rdx
               	movsd	(%rdx), %xmm2
               	vfmadd213sd	%xmm2, %xmm0, %xmm1 # xmm1 = (xmm0 * xmm1) + xmm2
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movsd	<rip>, %xmm0
               	subsd	%xmm0, %xmm1
               	xorl	%esi, %esi
               	movq	%rsi, %xmm15
               	comisd	%xmm1, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movsd	<rip>, %xmm0
               	comisd	%xmm1, %xmm0
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
               	xorps	%xmm0, %xmm0
               	jmp	<addr>
               	incq	%rsi
               	cmpl	$0x3, %esi
               	jl	<addr>
               	xorl	%edx, %edx
               	movsd	-0x48(%rbp), %xmm2
               	movsd	-0x30(%rbp), %xmm3
               	movsd	-0x18(%rbp), %xmm4
               	movsd	-0x40(%rbp), %xmm5
               	movsd	-0x28(%rbp), %xmm6
               	movsd	-0x10(%rbp), %xmm7
               	movsd	-0x38(%rbp), %xmm8
               	movsd	-0x20(%rbp), %xmm9
               	movsd	-0x8(%rbp), %xmm10
               	movq	%rdx, %rax
               	leaq	-0x90(%rbp), %rcx
               	imulq	$0x18, %rax, %rsi
               	addq	%rsi, %rcx
               	movsd	(%rcx), %xmm0
               	movq	%rdx, %xmm15
               	vfmadd213sd	%xmm15, %xmm2, %xmm0 # xmm0 = (xmm2 * xmm0) + xmm15
               	movsd	0x8(%rcx), %xmm1
               	vfmadd231sd	%xmm3, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm3) + xmm0
               	movsd	0x10(%rcx), %xmm1
               	vfmadd231sd	%xmm4, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm4) + xmm0
               	leaq	-0x90(%rbp), %rcx
               	addq	%rcx, %rsi
               	movsd	(%rsi), %xmm1
               	subsd	%xmm1, %xmm0
               	xorps	%xmm1, %xmm1
               	comisd	%xmm0, %xmm1
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	<rip>, %xmm11
               	comisd	%xmm0, %xmm11
               	jbe	<addr>
               	imulq	$0x18, %rax, %rsi
               	addq	%rsi, %rcx
               	movsd	(%rcx), %xmm0
               	vfmadd213sd	%xmm1, %xmm5, %xmm0 # xmm0 = (xmm5 * xmm0) + xmm1
               	movsd	0x8(%rcx), %xmm1
               	vfmadd231sd	%xmm6, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm6) + xmm0
               	movsd	0x10(%rcx), %xmm1
               	vfmadd231sd	%xmm7, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm7) + xmm0
               	leaq	-0x90(%rbp), %rcx
               	addq	%rcx, %rsi
               	movsd	0x8(%rsi), %xmm1
               	subsd	%xmm1, %xmm0
               	xorps	%xmm1, %xmm1
               	comisd	%xmm0, %xmm1
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	<rip>, %xmm11
               	comisd	%xmm0, %xmm11
               	jbe	<addr>
               	imulq	$0x18, %rax, %rsi
               	addq	%rsi, %rcx
               	movsd	(%rcx), %xmm0
               	vfmadd213sd	%xmm1, %xmm8, %xmm0 # xmm0 = (xmm8 * xmm0) + xmm1
               	movsd	0x8(%rcx), %xmm1
               	vfmadd231sd	%xmm9, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm9) + xmm0
               	movsd	0x10(%rcx), %xmm1
               	vfmadd231sd	%xmm10, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm10) + xmm0
               	leaq	-0x90(%rbp), %rcx
               	addq	%rsi, %rcx
               	movsd	0x10(%rcx), %xmm1
               	subsd	%xmm1, %xmm0
               	xorps	%xmm1, %xmm1
               	comisd	%xmm0, %xmm1
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	<rip>, %xmm1
               	comisd	%xmm0, %xmm1
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
               	movsd	<rip>, %xmm1
               	subsd	%xmm1, %xmm0
               	movq	%rax, %xmm15
               	comisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	<rip>, %xmm1
               	comisd	%xmm0, %xmm1
               	ja	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leave
               	retq
               	movl	$0x3, %eax
               	leave
               	retq
