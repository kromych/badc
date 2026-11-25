
long_double_math.x64:	file format elf64-x86-64

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
               	subq	$0x98, %rsp
               	subq	$0x30, %rsp
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x30(%rsp)
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x40(%rsp)
               	movabsq	$-0x3ffc000000000000, %rax # imm = 0xC004000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x50(%rsp)
               	fldt	0x30(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	vmulsd	<rip>, %xmm0, %xmm0
               	leaq	0x70(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	addq	$0x98, %rsp
               	retq
               	fldt	0x50(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	0x70(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	addq	$0x98, %rsp
               	retq
               	fldt	0x40(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	0x70(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movl	$0x4, %edi
               	callq	<addr>
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	addq	$0x98, %rsp
               	retq
               	fldt	0x30(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	vmulsd	<rip>, %xmm0, %xmm0
               	leaq	0x70(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	leaq	0xb8(%rsp), %rdi
               	callq	<addr>
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	0xb8(%rsp), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	addq	$0x98, %rsp
               	retq
               	fldt	0x50(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	0x70(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	leaq	0x60(%rsp), %rdi
               	callq	<addr>
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	0x60(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x30, %rsp
               	addq	$0x98, %rsp
               	retq
               	fldt	0x30(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	leaq	0x90(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x90(%rsp)
               	leaq	0x70(%rsp), %rcx
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
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
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x30, %rsp
               	addq	$0x98, %rsp
               	retq
               	fldt	0x50(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	0x70(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	0x50(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	0x70(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	0x50(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	0x70(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x30, %rsp
               	addq	$0x98, %rsp
               	retq
               	fldt	0x50(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	0x70(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	0x50(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	0x80(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x80(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	cmpq	$-0x3, %rax
               	jne	<addr>
               	fldt	0x40(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	0x80(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x80(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x30, %rsp
               	addq	$0x98, %rsp
               	retq
               	fldt	0x50(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	0x70(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	0x50(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	0x80(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x80(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	cmpq	$-0x2, %rax
               	jne	<addr>
               	fldt	0x30(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	0x80(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x80(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x30, %rsp
               	addq	$0x98, %rsp
               	retq
               	fldt	0x40(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	0x70(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	xorps	%xmm1, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x30, %rsp
               	addq	$0x98, %rsp
               	retq
               	fldt	0x30(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	vmulsd	<rip>, %xmm0, %xmm0
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	leaq	0x90(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x90(%rsp)
               	leaq	0x70(%rsp), %rcx
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
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
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	0x30(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	vmulsd	<rip>, %xmm0, %xmm0
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	leaq	0x90(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x90(%rsp)
               	leaq	0x70(%rsp), %rcx
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
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
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x30, %rsp
               	addq	$0x98, %rsp
               	retq
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movabsq	$0x4010000000000000, %rcx # imm = 0x4010000000000000
               	leaq	0x90(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x90(%rsp)
               	leaq	0x70(%rsp), %rax
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
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
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x30, %rsp
               	addq	$0x98, %rsp
               	retq
               	fldt	0x30(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	fldt	0x40(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	leaq	0x90(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x90(%rsp)
               	leaq	0x70(%rsp), %rax
               	movsd	%xmm1, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
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
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	0x30(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	fldt	0x40(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	leaq	0x90(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x90(%rsp)
               	leaq	0x70(%rsp), %rax
               	movsd	%xmm1, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
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
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x30, %rsp
               	addq	$0x98, %rsp
               	retq
               	fldt	0x30(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	vmulsd	<rip>, %xmm0, %xmm0
               	leaq	0x80(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x80(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x30, %rsp
               	addq	$0x98, %rsp
               	retq
               	fldt	0x30(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	vmulsd	<rip>, %xmm0, %xmm0
               	leaq	0x70(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x30, %rsp
               	addq	$0x98, %rsp
               	retq
               	xorl	%eax, %eax
               	leaq	0x70(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	0x70(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	xorps	%xmm1, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	0x30(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	vmulsd	<rip>, %xmm0, %xmm0
               	leaq	0x70(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	0x70(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x30, %rsp
               	addq	$0x98, %rsp
               	retq
               	movabsq	$0x4059000000000000, %rax # imm = 0x4059000000000000
               	leaq	0x70(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x30, %rsp
               	addq	$0x98, %rsp
               	retq
               	xorl	%eax, %eax
               	leaq	0x70(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	0x70(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	xorl	%ecx, %ecx
               	leaq	0x90(%rsp), %r9
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x90(%rsp)
               	leaq	0x70(%rsp), %rcx
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
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
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	xorps	%xmm1, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x30, %rsp
               	addq	$0x98, %rsp
               	retq
               	fldt	0x30(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	fldt	0x30(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	leaq	0x90(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x90(%rsp)
               	leaq	0x70(%rsp), %rax
               	movsd	%xmm1, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
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
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x30, %rsp
               	addq	$0x98, %rsp
               	retq
               	fldt	0x30(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	fldt	0x50(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	leaq	0x90(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x90(%rsp)
               	leaq	0x70(%rsp), %rax
               	movsd	%xmm1, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
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
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	0x30(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	fldt	0x40(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	leaq	0x90(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x90(%rsp)
               	leaq	0x70(%rsp), %rax
               	movsd	%xmm1, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
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
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x30, %rsp
               	addq	$0x98, %rsp
               	retq
               	fldt	0x40(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	0x70(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movl	$0x3, %edi
               	callq	<addr>
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	0x40(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	0x70(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movl	$0x2, %edi
               	callq	<addr>
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x30, %rsp
               	addq	$0x98, %rsp
               	retq
               	fldt	0x30(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	fldt	0x30(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	fldt	0x40(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm2
               	leaq	0xa0(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xa0(%rsp)
               	leaq	0x90(%rsp), %rax
               	movsd	%xmm1, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x90(%rsp)
               	leaq	0x70(%rsp), %rcx
               	movsd	%xmm2, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
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
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	callq	<addr>
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x30, %rsp
               	addq	$0x98, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	fldt	0x50(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	0x70(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x70(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	*%rax
               	fstpt	0x80(%rsp)
               	fldt	0x80(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x18, %eax
               	addq	$0x30, %rsp
               	addq	$0x98, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x30, %rsp
               	addq	$0x98, %rsp
               	retq
