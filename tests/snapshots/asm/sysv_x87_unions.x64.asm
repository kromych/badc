
sysv_x87_unions.x64:	file format elf64-x86-64

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

<make_u2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	movabsq	$0x4004000000000000, %rcx # imm = 0x4004000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rax)
               	movq	%rax, %rcx
               	fldt	(%rcx)
               	leave
               	retq

<make_u1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	movabsq	$0x400c000000000000, %rcx # imm = 0x400C000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rax)
               	movq	%rax, %rcx
               	fldt	(%rcx)
               	leave
               	retq

<make_s1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	movabsq	$0x4012000000000000, %rcx # imm = 0x4012000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rax)
               	movq	%rax, %rcx
               	fldt	(%rcx)
               	leave
               	retq

<take_u2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movl	$0x3, %eax
               	fldt	-0x20(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4024000000000000, %rcx # imm = 0x4024000000000000
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rcx, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	leaq	-0x10(%rbp), %rax
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rax)
               	movq	%rax, %rcx
               	fldt	(%rcx)
               	leave
               	retq

<take_s1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movl	$0x3, %eax
               	movl	$0x2bc, %ecx            # imm = 0x2BC
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rcx, %xmm0
               	fldt	-0x20(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	movabsq	$0x4024000000000000, %rcx # imm = 0x4024000000000000
               	movapd	%xmm1, %xmm14
               	movq	%rcx, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	addsd	%xmm1, %xmm0
               	leaq	-0x10(%rbp), %rax
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rax)
               	movq	%rax, %rcx
               	fldt	(%rcx)
               	leave
               	retq

<swap_m1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x40(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x38(%rbp)
               	movl	$0x2, %eax
               	leaq	-0x30(%rbp), %rcx
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rcx)
               	movq	-0x20(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leave
               	retq

<after_u2>:
               	movq	%rdi, %rax
               	retq

<after_s1>:
               	movq	%rdi, %rax
               	retq

<ret_u2>:
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	retq

<via_u2>:
               	movq	%rdi, %rax
               	subq	$0x18, %rsp
               	movq	%rsp, %rdi
               	callq	*%rax
               	addq	$0x18, %rsp
               	retq

<via_s1>:
               	movq	%rdi, %rax
               	subq	$0x18, %rsp
               	movq	%rsp, %rdi
               	callq	*%rax
               	addq	$0x18, %rsp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	-0x50(%rbp), %r9
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x40(%rbp)
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x30(%rbp)
               	movl	$0x2a, %edi
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x40(%rbp), %r9
               	movl	$0x2a, %edi
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	callq	<addr>
               	fstpt	-0x20(%rbp)
               	fldt	-0x20(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-<rip>, %rdi      # <addr>
               	callq	<addr>
               	fstpt	-0x20(%rbp)
               	fldt	-0x20(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-<rip>, %rdi      # <addr>
               	callq	<addr>
               	fstpt	-0x20(%rbp)
               	fldt	-0x20(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4012000000000000, %rax # imm = 0x4012000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	callq	<addr>
               	fstpt	-0x20(%rbp)
               	fldt	-0x20(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x400c000000000000, %rax # imm = 0x400C000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %r9
               	movl	$0x3, %edi
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x20(%rbp)
               	fldt	-0x20(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4032000000000000, %rax # imm = 0x4032000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	$0x7, %edi
               	leaq	-0x40(%rbp), %r9
               	movl	$0x3, %esi
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x20(%rbp)
               	fldt	-0x20(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4086c00000000000, %rax # imm = 0x4086C00000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x30(%rbp), %r9
               	movl	$0x2, %esi
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	fldt	-0x10(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
