
fp_volatile_bank_across_calls.x64:	file format elf64-x86-64

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

<spread>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	movapd	%xmm0, %xmm2
               	addsd	%xmm15, %xmm2
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	movapd	%xmm0, %xmm3
               	addsd	%xmm15, %xmm3
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	movapd	%xmm0, %xmm4
               	addsd	%xmm15, %xmm4
               	movabsq	$0x4010000000000000, %rcx # imm = 0x4010000000000000
               	movq	%rcx, %xmm15
               	movapd	%xmm0, %xmm5
               	addsd	%xmm15, %xmm5
               	movabsq	$0x4014000000000000, %rcx # imm = 0x4014000000000000
               	movq	%rcx, %xmm15
               	movapd	%xmm1, %xmm6
               	addsd	%xmm15, %xmm6
               	movabsq	$0x4018000000000000, %rdx # imm = 0x4018000000000000
               	movq	%rdx, %xmm15
               	movapd	%xmm1, %xmm7
               	addsd	%xmm15, %xmm7
               	movabsq	$0x401c000000000000, %rdx # imm = 0x401C000000000000
               	movq	%rdx, %xmm15
               	movapd	%xmm1, %xmm8
               	addsd	%xmm15, %xmm8
               	movabsq	$0x4020000000000000, %rsi # imm = 0x4020000000000000
               	movq	%rsi, %xmm15
               	movapd	%xmm1, %xmm9
               	addsd	%xmm15, %xmm9
               	movapd	%xmm0, %xmm10
               	mulsd	%xmm1, %xmm10
               	movapd	%xmm0, %xmm11
               	subsd	%xmm1, %xmm11
               	movq	%rax, %xmm15
               	movapd	%xmm0, %xmm12
               	mulsd	%xmm15, %xmm12
               	movq	%rcx, %xmm15
               	movapd	%xmm1, %xmm14
               	mulsd	%xmm15, %xmm14
               	movsd	%xmm14, 0x18(%rsp)
               	movapd	%xmm0, %xmm14
               	addsd	%xmm1, %xmm14
               	movsd	%xmm14, 0x10(%rsp)
               	movapd	%xmm1, %xmm14
               	subsd	%xmm0, %xmm14
               	movsd	%xmm14, 0x8(%rsp)
               	movq	%rdx, %xmm15
               	mulsd	%xmm15, %xmm0
               	movabsq	$0x4022000000000000, %rax # imm = 0x4022000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm1
               	mulsd	%xmm5, %xmm4
               	movapd	%xmm2, %xmm14
               	movapd	%xmm3, %xmm15
               	movapd	%xmm4, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movapd	%xmm6, %xmm14
               	movapd	%xmm7, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movapd	%xmm8, %xmm14
               	movapd	%xmm9, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movapd	%xmm10, %xmm14
               	movapd	%xmm11, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movapd	%xmm12, %xmm14
               	movsd	0x18(%rsp), %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movsd	0x10(%rsp), %xmm14
               	movsd	0x8(%rsp), %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	leave
               	retq

<across>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x78, %rsp
               	pushq	%rbx
               	movsd	%xmm0, 0x78(%rsp)
               	movsd	%xmm1, 0x70(%rsp)
               	movabsq	$0x4000000000000000, %rbx # imm = 0x4000000000000000
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movsd	0x78(%rsp), %xmm2
               	movq	%rax, %xmm15
               	movapd	%xmm2, %xmm14
               	mulsd	%xmm15, %xmm14
               	movsd	%xmm14, 0x68(%rsp)
               	movabsq	$0x4014000000000000, %rcx # imm = 0x4014000000000000
               	movq	%rcx, %xmm15
               	movapd	%xmm2, %xmm14
               	mulsd	%xmm15, %xmm14
               	movsd	%xmm14, 0x60(%rsp)
               	movabsq	$0x401c000000000000, %rdx # imm = 0x401C000000000000
               	movq	%rdx, %xmm15
               	movapd	%xmm2, %xmm14
               	mulsd	%xmm15, %xmm14
               	movsd	%xmm14, 0x58(%rsp)
               	movsd	0x70(%rsp), %xmm3
               	movq	%rbx, %xmm15
               	movapd	%xmm3, %xmm14
               	mulsd	%xmm15, %xmm14
               	movsd	%xmm14, 0x50(%rsp)
               	movq	%rax, %xmm15
               	movapd	%xmm3, %xmm14
               	mulsd	%xmm15, %xmm14
               	movsd	%xmm14, 0x48(%rsp)
               	movq	%rcx, %xmm15
               	movapd	%xmm3, %xmm14
               	mulsd	%xmm15, %xmm14
               	movsd	%xmm14, 0x40(%rsp)
               	movq	%rdx, %xmm15
               	movapd	%xmm3, %xmm14
               	mulsd	%xmm15, %xmm14
               	movsd	%xmm14, 0x38(%rsp)
               	movapd	%xmm2, %xmm14
               	addsd	%xmm3, %xmm14
               	movsd	%xmm14, 0x30(%rsp)
               	movapd	%xmm2, %xmm14
               	subsd	%xmm3, %xmm14
               	movsd	%xmm14, 0x28(%rsp)
               	movapd	%xmm2, %xmm14
               	mulsd	%xmm3, %xmm14
               	movsd	%xmm14, 0x20(%rsp)
               	movabsq	$0x4026000000000000, %rax # imm = 0x4026000000000000
               	movq	%rax, %xmm15
               	movapd	%xmm2, %xmm14
               	addsd	%xmm15, %xmm14
               	movsd	%xmm14, 0x18(%rsp)
               	movsd	0x78(%rsp), %xmm0
               	movsd	0x70(%rsp), %xmm1
               	callq	<addr>
               	movsd	%xmm0, 0x10(%rsp)
               	movsd	0x70(%rsp), %xmm0
               	movsd	0x78(%rsp), %xmm1
               	callq	<addr>
               	movapd	%xmm0, %xmm15
               	movsd	0x10(%rsp), %xmm0
               	addsd	%xmm15, %xmm0
               	movsd	0x78(%rsp), %xmm14
               	movq	%rbx, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movsd	0x68(%rsp), %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movsd	0x60(%rsp), %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movsd	0x58(%rsp), %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movabsq	$0x4014000000000000, %rax # imm = 0x4014000000000000
               	movsd	0x50(%rsp), %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movsd	0x48(%rsp), %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movabsq	$0x401c000000000000, %rax # imm = 0x401C000000000000
               	movsd	0x40(%rsp), %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	movsd	0x38(%rsp), %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movabsq	$0x4022000000000000, %rax # imm = 0x4022000000000000
               	movsd	0x30(%rsp), %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	movsd	0x28(%rsp), %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movabsq	$0x4026000000000000, %rax # imm = 0x4026000000000000
               	movsd	0x20(%rsp), %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movabsq	$0x4028000000000000, %rax # imm = 0x4028000000000000
               	movsd	0x18(%rsp), %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	popq	%rbx
               	leave
               	retq

<across_ref>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	0x1(%rdi), %rax
               	leaq	0x2(%rdi), %rcx
               	imulq	%rcx, %rax
               	leaq	0x3(%rdi), %rcx
               	leaq	0x4(%rdi), %rdx
               	imulq	%rdx, %rcx
               	addq	%rcx, %rax
               	leaq	0x5(%rsi), %rcx
               	leaq	0x6(%rsi), %rdx
               	imulq	%rdx, %rcx
               	addq	%rcx, %rax
               	leaq	0x7(%rsi), %rcx
               	leaq	0x8(%rsi), %rdx
               	imulq	%rdx, %rcx
               	leaq	(%rax,%rcx), %rdx
               	movq	%rdi, %rax
               	imulq	%rsi, %rax
               	movq	%rdi, %rcx
               	subq	%rsi, %rcx
               	movq	%rax, %r8
               	imulq	%rcx, %r8
               	addq	%rdx, %r8
               	leaq	(%rdi,%rdi,2), %rdx
               	movq	%rdx, %r9
               	imulq	%rsi, %r9
               	leaq	(%r9,%r9,4), %r9
               	leaq	(%r8,%r9), %rbx
               	leaq	(%rdi,%rsi), %r8
               	movq	%rsi, %r9
               	subq	%rdi, %r9
               	movq	%r8, %r12
               	imulq	%r9, %r12
               	addq	%r12, %rbx
               	imulq	$0x7, %rdi, %r12
               	imulq	%rsi, %r12
               	leaq	(%r12,%r12,8), %r12
               	addq	%r12, %rbx
               	leaq	0x1(%rsi), %r12
               	leaq	0x2(%rsi), %r13
               	imulq	%r13, %r12
               	leaq	0x3(%rsi), %r13
               	leaq	0x4(%rsi), %r14
               	imulq	%r14, %r13
               	addq	%r13, %r12
               	leaq	0x5(%rdi), %r13
               	leaq	0x6(%rdi), %r14
               	imulq	%r14, %r13
               	addq	%r13, %r12
               	leaq	0x7(%rdi), %r13
               	leaq	0x8(%rdi), %r14
               	imulq	%r14, %r13
               	addq	%r13, %r12
               	imulq	%r9, %rax
               	leaq	(%r12,%rax), %r9
               	leaq	(%rsi,%rsi,2), %rax
               	movq	%rax, %r12
               	imulq	%rdi, %r12
               	leaq	(%r12,%r12,4), %r12
               	addq	%r12, %r9
               	imulq	%r8, %rcx
               	leaq	(%r9,%rcx), %r8
               	imulq	$0x7, %rsi, %rcx
               	movq	%rcx, %r9
               	imulq	%rdi, %r9
               	leaq	(%r9,%r9,8), %r9
               	addq	%r9, %r8
               	addq	%rbx, %r8
               	movq	%rdi, %r9
               	shlq	%r9
               	addq	%r9, %r8
               	shlq	%rdx
               	addq	%r8, %rdx
               	leaq	(%rdi,%rdi,4), %r8
               	leaq	(%r8,%r8,2), %r8
               	addq	%r8, %rdx
               	imulq	$0x7, %rdi, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %rdx
               	movq	%rsi, %r8
               	shlq	%r8
               	leaq	(%r8,%r8,4), %r8
               	addq	%r8, %rdx
               	imulq	$0x6, %rax, %rax
               	addq	%rdx, %rax
               	leaq	(%rsi,%rsi,4), %rdx
               	imulq	$0x7, %rdx, %rdx
               	addq	%rdx, %rax
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	leaq	(%rdi,%rsi), %rcx
               	leaq	(%rcx,%rcx,8), %rcx
               	addq	%rcx, %rax
               	movq	%rdi, %rcx
               	subq	%rsi, %rcx
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	imulq	$0xb, %rcx, %rcx
               	addq	%rcx, %rax
               	leaq	0xb(%rdi), %rcx
               	imulq	$0xc, %rcx, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	movl	$0x3, %r12d
               	movl	$0x5, %r13d
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%r12, %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%r13, %xmm1
               	callq	<addr>
               	movl	$0x5cc, %eax            # imm = 0x5CC
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movq	%rbx, %rax
               	shlq	%rax
               	incq	%rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%r12, %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%r13, %xmm1
               	callq	<addr>
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%r12, %rdi
               	movq	%r13, %rsi
               	callq	<addr>
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movsd	0x28(%rsp), %xmm14
               	ucomisd	%xmm0, %xmm14
               	jp	<addr>
               	je	<addr>
               	movq	%rbx, %rax
               	shlq	%rax
               	addq	$0x2, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %ebx
               	movq	$-0x4, %r12
               	movl	$0x9, %r13d
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%r12, %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%r13, %xmm1
               	callq	<addr>
               	movq	$-0x6fb, %rax           # imm = 0xF905
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%r12, %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%r13, %xmm1
               	callq	<addr>
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%r12, %rdi
               	movq	%r13, %rsi
               	callq	<addr>
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movsd	0x28(%rsp), %xmm14
               	ucomisd	%xmm0, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movl	$0x2, %ebx
               	movl	$0x3e8, %r12d           # imm = 0x3E8
               	movq	$-0x4d, %r13
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%r12, %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%r13, %xmm1
               	callq	<addr>
               	movq	$-0x53d62fb, %rax       # imm = 0xFAC29D05
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%r12, %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%r13, %xmm1
               	callq	<addr>
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%r12, %rdi
               	movq	%r13, %rsi
               	callq	<addr>
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movsd	0x28(%rsp), %xmm14
               	ucomisd	%xmm0, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movl	$0x3, %ebx
               	xorl	%r12d, %r12d
               	movl	$0x1, %r13d
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%r12, %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%r13, %xmm1
               	callq	<addr>
               	movl	$0x81, %eax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%r12, %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%r13, %xmm1
               	callq	<addr>
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%r12, %rdi
               	movq	%r13, %rsi
               	callq	<addr>
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movsd	0x28(%rsp), %xmm14
               	ucomisd	%xmm0, %xmm14
               	jp	<addr>
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
