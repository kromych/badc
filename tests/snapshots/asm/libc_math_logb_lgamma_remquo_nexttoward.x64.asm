
libc_math_logb_lgamma_remquo_nexttoward.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x58, %rsp
               	subq	$0x20, %rsp
               	movl	$0x0, 0x68(%rsp)
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	addq	$0x58, %rsp
               	retq
               	movss	<rip>, %xmm0
               	callq	<addr>
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	leaq	0x20(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x20(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fstpt	0x30(%rsp)
               	fldt	0x30(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	addq	$0x58, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x58(%rsp)
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	0x58(%rsp), %xmm14
               	vsubsd	%xmm0, %xmm14, %xmm1
               	vandpd	<rip>, %xmm1, %xmm0
               	movsd	<rip>, %xmm1
               	comisd	%xmm1, %xmm0
               	jbe	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	addq	$0x58, %rsp
               	retq
               	movss	<rip>, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x58(%rsp)
               	movss	<rip>, %xmm0
               	callq	<addr>
               	movsd	0x58(%rsp), %xmm14
               	vsubss	%xmm0, %xmm14, %xmm1
               	vandpd	<rip>, %xmm1, %xmm0
               	movss	<rip>, %xmm1
               	comiss	%xmm1, %xmm0
               	jbe	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	addq	$0x58, %rsp
               	retq
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	leaq	0x20(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x20(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fstpt	0x30(%rsp)
               	fldt	0x30(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm14
               	movsd	%xmm14, 0x58(%rsp)
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	leaq	0x20(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x20(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fstpt	0x30(%rsp)
               	fldt	0x30(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	0x58(%rsp), %xmm14
               	vsubsd	%xmm0, %xmm14, %xmm1
               	leaq	0x20(%rsp), %r9
               	movsd	%xmm1, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x20(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fstpt	0x30(%rsp)
               	fldt	0x30(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	<rip>, %xmm1
               	comisd	%xmm1, %xmm0
               	jbe	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	addq	$0x58, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	leaq	0x68(%rsp), %rdi
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movslq	0x68(%rsp), %rax
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rcx, %rax
               	andq	$0x7, %rax
               	subq	%rcx, %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	addq	$0x58, %rsp
               	retq
               	movss	<rip>, %xmm0
               	movss	<rip>, %xmm1
               	leaq	0x68(%rsp), %rdi
               	callq	<addr>
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movslq	0x68(%rsp), %rax
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rcx, %rax
               	andq	$0x7, %rax
               	subq	%rcx, %rax
               	cmpl	$-0x4, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	addq	$0x58, %rsp
               	retq
               	movabsq	$0x401c000000000000, %rax # imm = 0x401C000000000000
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	leaq	0x68(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x40(%rsp)
               	leaq	0x20(%rsp), %rax
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x20(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	fstpt	0x30(%rsp)
               	fldt	0x30(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movslq	0x68(%rsp), %rax
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rcx, %rax
               	andq	$0x7, %rax
               	subq	%rcx, %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x20, %rsp
               	addq	$0x58, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	leaq	0x30(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x30(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x20, %rsp
               	addq	$0x58, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	xorl	%eax, %eax
               	leaq	0x30(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x30(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x20, %rsp
               	addq	$0x58, %rsp
               	retq
               	movss	<rip>, %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	leaq	0x30(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x30(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	addq	$0x58, %rsp
               	retq
               	movss	<rip>, %xmm0
               	movabsq	$-0x4000000000000000, %rax # imm = 0xC000000000000000
               	leaq	0x30(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x30(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x20, %rsp
               	addq	$0x58, %rsp
               	retq
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	leaq	0x40(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x40(%rsp)
               	leaq	0x20(%rsp), %rax
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x20(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	fstpt	0x30(%rsp)
               	fldt	0x30(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	<rip>, %xmm1
               	comisd	%xmm0, %xmm1
               	ja	<addr>
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	leaq	0x40(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x40(%rsp)
               	leaq	0x20(%rsp), %rcx
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x20(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	fstpt	0x30(%rsp)
               	fldt	0x30(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	addq	$0x58, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movsd	%xmm0, 0x58(%rsp)
               	movss	<rip>, %xmm0
               	callq	<addr>
               	movsd	0x58(%rsp), %xmm14
               	vsubss	%xmm0, %xmm14, %xmm1
               	vandpd	<rip>, %xmm1, %xmm0
               	movss	<rip>, %xmm1
               	comiss	%xmm1, %xmm0
               	jbe	<addr>
               	movl	$0xe, %eax
               	addq	$0x20, %rsp
               	addq	$0x58, %rsp
               	retq
               	movabsq	$0x4022000000000000, %rax # imm = 0x4022000000000000
               	movabsq	$0x4010000000000000, %rcx # imm = 0x4010000000000000
               	leaq	0x68(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x40(%rsp)
               	leaq	0x20(%rsp), %rax
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	*%rcx
               	fstpt	0x30(%rsp)
               	fldt	0x30(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movslq	0x68(%rsp), %rax
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rcx, %rax
               	andq	$0x7, %rax
               	subq	%rcx, %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x20, %rsp
               	addq	$0x58, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	leaq	0x30(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x30(%rsp)
               	movq	<rip>, %rax # <addr>
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	*%rax
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x20, %rsp
               	addq	$0x58, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x20, %rsp
               	addq	$0x58, %rsp
               	retq
