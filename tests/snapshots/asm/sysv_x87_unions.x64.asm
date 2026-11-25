
sysv_x87_unions.x64:	file format elf64-x86-64

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

<make_u2>:
               	subq	$0x18, %rsp
               	leaq	(%rsp), %rax
               	movabsq	$0x4004000000000000, %rcx # imm = 0x4004000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rsp)
               	movq	%rax, %rcx
               	fldt	(%rcx)
               	addq	$0x18, %rsp
               	retq

<make_u1>:
               	subq	$0x18, %rsp
               	leaq	(%rsp), %rax
               	movabsq	$0x400c000000000000, %rcx # imm = 0x400C000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rsp)
               	movq	%rax, %rcx
               	fldt	(%rcx)
               	addq	$0x18, %rsp
               	retq

<make_s1>:
               	subq	$0x18, %rsp
               	leaq	(%rsp), %rax
               	movabsq	$0x4012000000000000, %rcx # imm = 0x4012000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rsp)
               	movq	%rax, %rcx
               	fldt	(%rcx)
               	addq	$0x18, %rsp
               	retq

<take_u2>:
               	subq	$0x28, %rsp
               	movq	0x30(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x38(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	fldt	(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	<rip>, %xmm1
               	movsd	<rip>, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	leaq	0x10(%rsp), %rax
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x10(%rsp)
               	movq	%rax, %rcx
               	fldt	(%rcx)
               	addq	$0x28, %rsp
               	retq

<take_s1>:
               	subq	$0x28, %rsp
               	movq	0x30(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x38(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movsd	<rip>, %xmm0
               	fldt	(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	movsd	<rip>, %xmm2
               	vfmadd231sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm2) + xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	leaq	0x10(%rsp), %rax
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x10(%rsp)
               	movq	%rax, %rcx
               	fldt	(%rcx)
               	addq	$0x28, %rsp
               	retq

<swap_m1>:
               	subq	$0x38, %rsp
               	movq	%rdi, 0x20(%rsp)
               	movq	0x40(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x48(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	leaq	0x10(%rsp), %rcx
               	fldt	(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x10(%rsp)
               	movq	0x20(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	addq	$0x38, %rsp
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
               	subq	$0x48, %rsp
               	subq	$0x10, %rsp
               	leaq	0x10(%rsp), %r9
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x10(%rsp)
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x20(%rsp)
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x30(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movl	$0x2a, %edi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	addq	$0x48, %rsp
               	retq
               	leaq	0x20(%rsp), %r9
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movl	$0x2a, %edi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	addq	$0x48, %rsp
               	retq
               	callq	<addr>
               	fstpt	0x40(%rsp)
               	fldt	0x40(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x10, %rsp
               	addq	$0x48, %rsp
               	retq
               	leaq	-<rip>, %rdi # <addr>
               	callq	<addr>
               	fstpt	0x40(%rsp)
               	fldt	0x40(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x10, %rsp
               	addq	$0x48, %rsp
               	retq
               	leaq	-<rip>, %rdi # <addr>
               	callq	<addr>
               	fstpt	0x40(%rsp)
               	fldt	0x40(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x10, %rsp
               	addq	$0x48, %rsp
               	retq
               	callq	<addr>
               	fstpt	0x40(%rsp)
               	fldt	0x40(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x10, %rsp
               	addq	$0x48, %rsp
               	retq
               	leaq	0x10(%rsp), %r9
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movl	$0x3, %edi
               	callq	<addr>
               	fstpt	0x40(%rsp)
               	fldt	0x40(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x10, %rsp
               	addq	$0x48, %rsp
               	retq
               	leaq	0x20(%rsp), %r9
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movl	$0x7, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	fstpt	0x40(%rsp)
               	fldt	0x40(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x10, %rsp
               	addq	$0x48, %rsp
               	retq
               	leaq	0x30(%rsp), %r9
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	leaq	0x40(%rsp), %rdi
               	movl	$0x2, %esi
               	callq	<addr>
               	fldt	0x40(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x10, %rsp
               	addq	$0x48, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x10, %rsp
               	addq	$0x48, %rsp
               	retq
