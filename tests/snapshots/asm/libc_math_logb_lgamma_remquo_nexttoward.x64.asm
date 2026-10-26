
libc_math_logb_lgamma_remquo_nexttoward.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	movl	$0x0, -0x8(%rbp)
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	movq	%rax, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movabsq	$0x3fd8000000000000, %rax # imm = 0x3FD8000000000000
               	movq	%rax, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$-0x4000000000000000, %rax # imm = 0xC000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x41000000, %eax       # imm = 0x41000000
               	movq	%rax, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	leaq	-0x50(%rbp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x50(%rbp)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x40(%rbp)
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	%xmm0, 0x38(%rsp)
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	0x38(%rsp), %xmm14
               	vsubsd	%xmm0, %xmm14, %xmm1
               	movapd	%xmm1, %xmm0
               	movabsq	$0x7fffffffffffffff, %r10 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%r10, %xmm15
               	andpd	%xmm15, %xmm0
               	movabsq	$0x3d719799812dea11, %rax # imm = 0x3D719799812DEA11
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x40800000, %eax       # imm = 0x40800000
               	movq	%rax, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	%xmm0, 0x38(%rsp)
               	movl	$0x40c00000, %eax       # imm = 0x40C00000
               	movq	%rax, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	0x38(%rsp), %xmm14
               	vsubss	%xmm0, %xmm14, %xmm1
               	movapd	%xmm1, %xmm0
               	movl	$0x7fffffff, %r10d      # imm = 0x7FFFFFFF
               	movq	%r10, %xmm15
               	andpd	%xmm15, %xmm0
               	movl	$0x3727c5ac, %eax       # imm = 0x3727C5AC
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	leaq	-0x50(%rbp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x50(%rbp)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x40(%rbp)
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm14
               	movsd	%xmm14, 0x38(%rsp)
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	leaq	-0x50(%rbp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x50(%rbp)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x40(%rbp)
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	0x38(%rsp), %xmm14
               	vsubsd	%xmm0, %xmm14, %xmm1
               	leaq	-0x50(%rbp), %r9
               	movsd	%xmm1, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x50(%rbp)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x40(%rbp)
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x3d719799812dea11, %rax # imm = 0x3D719799812DEA11
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movabsq	$0x401c000000000000, %rax # imm = 0x401C000000000000
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	leaq	-0x8(%rbp), %rdi
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$-0x4010000000000000, %rax # imm = 0xBFF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rcx, %rax
               	andq	$0x7, %rax
               	subq	%rcx, %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0xc0e00000, %eax       # imm = 0xC0E00000
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	leaq	-0x8(%rbp), %rdi
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rcx, %rax
               	andq	$0x7, %rax
               	subq	%rcx, %rax
               	cmpl	$-0x4, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movabsq	$0x401c000000000000, %rax # imm = 0x401C000000000000
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	leaq	-0x8(%rbp), %rdi
               	leaq	-0x30(%rbp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x30(%rbp)
               	leaq	-0x50(%rbp), %rax
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x50(%rbp)
               	subq	$0x20, %rsp
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
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x20, %rsp
               	fstpt	-0x40(%rbp)
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$-0x4010000000000000, %rax # imm = 0xBFF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rcx, %rax
               	andq	$0x7, %rax
               	subq	%rcx, %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	leaq	-0x40(%rbp), %r9
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x40(%rbp)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%rax, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movabsq	$0x3cb0000000000000, %rcx # imm = 0x3CB0000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	vaddsd	%xmm15, %xmm14, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorl	%ecx, %ecx
               	leaq	-0x40(%rbp), %r9
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x40(%rbp)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%rax, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movabsq	$0x3cb0000000000000, %rdx # imm = 0x3CB0000000000000
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rdx, %xmm14
               	movq	%rax, %xmm15
               	vdivsd	%xmm15, %xmm14, %xmm1
               	movq	%rcx, %xmm14
               	vsubsd	%xmm1, %xmm14, %xmm2
               	ucomisd	%xmm2, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	$0x3f800000, %ecx       # imm = 0x3F800000
               	leaq	-0x40(%rbp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x40(%rbp)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%rcx, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movl	$0x34000000, %ecx       # imm = 0x34000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	vaddss	%xmm15, %xmm14, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movabsq	$-0x4000000000000000, %rcx # imm = 0xC000000000000000
               	leaq	-0x40(%rbp), %r9
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x40(%rbp)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%rax, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movl	$0x34000000, %ecx       # imm = 0x34000000
               	movl	$0x40000000, %edx       # imm = 0x40000000
               	movq	%rcx, %xmm14
               	movq	%rdx, %xmm15
               	vdivss	%xmm15, %xmm14, %xmm1
               	movq	%rax, %xmm14
               	vsubss	%xmm1, %xmm14, %xmm2
               	ucomiss	%xmm2, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	leaq	-0x30(%rbp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x30(%rbp)
               	leaq	-0x50(%rbp), %rax
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x50(%rbp)
               	subq	$0x20, %rsp
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
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x20, %rsp
               	fstpt	-0x40(%rbp)
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	ja	<addr>
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	leaq	-0x30(%rbp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x30(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x50(%rbp)
               	subq	$0x20, %rsp
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
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x20, %rsp
               	fstpt	-0x40(%rbp)
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movabsq	$0x4030000000000000, %rax # imm = 0x4030000000000000
               	movq	<rip>, %rcx # <addr>
               	movq	%rax, %xmm0
               	callq	*%rcx
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	<rip>, %rcx # <addr>
               	movq	%rax, %xmm0
               	callq	*%rcx
               	movsd	%xmm0, 0x38(%rsp)
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	0x38(%rsp), %xmm14
               	vsubss	%xmm0, %xmm14, %xmm1
               	movapd	%xmm1, %xmm0
               	movl	$0x7fffffff, %r10d      # imm = 0x7FFFFFFF
               	movq	%r10, %xmm15
               	andpd	%xmm15, %xmm0
               	movl	$0x3727c5ac, %eax       # imm = 0x3727C5AC
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movabsq	$0x4022000000000000, %rax # imm = 0x4022000000000000
               	movabsq	$0x4010000000000000, %rcx # imm = 0x4010000000000000
               	leaq	-0x8(%rbp), %rdi
               	leaq	-0x30(%rbp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x30(%rbp)
               	leaq	-0x50(%rbp), %rax
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x50(%rbp)
               	movq	<rip>, %rcx # <addr>
               	subq	$0x20, %rsp
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
               	addq	$0x20, %rsp
               	fstpt	-0x40(%rbp)
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rcx, %rax
               	andq	$0x7, %rax
               	subq	%rcx, %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movabsq	$0x4020000000000000, %rcx # imm = 0x4020000000000000
               	leaq	-0x40(%rbp), %r9
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x40(%rbp)
               	movq	<rip>, %rcx # <addr>
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%rax, %xmm0
               	callq	*%rcx
               	addq	$0x10, %rsp
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movabsq	$0x3cb0000000000000, %rcx # imm = 0x3CB0000000000000
               	movq	%rax, %xmm1
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	vfmadd132sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm1 * xmm15) + xmm14
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
