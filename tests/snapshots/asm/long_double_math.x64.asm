
long_double_math.x64:	file format elf64-x86-64

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
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x90(%rbp)
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x80(%rbp)
               	movabsq	$-0x3ffc000000000000, %rax # imm = 0xC004000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x70(%rbp)
               	fldt	-0x90(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	leaq	-0x28(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	fldt	-0x70(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	-0x28(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	fldt	-0x80(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movl	$0x4, %edi
               	leaq	-0x28(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	fldt	-0x90(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	leaq	-0x8(%rbp), %rdi
               	leaq	-0x28(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x3fe8000000000000, %rax # imm = 0x3FE8000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	fldt	-0x70(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	-0x60(%rbp), %rdi
               	leaq	-0x28(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$-0x4020000000000000, %rax # imm = 0xBFE0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	-0x60(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$-0x4000000000000000, %rax # imm = 0xC000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	fldt	-0x90(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4024000000000000, %rcx # imm = 0x4024000000000000
               	leaq	-0x38(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	leaq	-0x28(%rbp), %rax
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rax)
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
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4090000000000000, %rax # imm = 0x4090000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	fldt	-0x70(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	-0x28(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$-0x3ff8000000000000, %rax # imm = 0xC008000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	-0x70(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	-0x28(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$-0x4000000000000000, %rax # imm = 0xC000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	-0x70(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	-0x28(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$-0x4000000000000000, %rax # imm = 0xC000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	fldt	-0x70(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	-0x28(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x18(%rbp)
               	leaq	-0x18(%rbp), %r9
               	fldt	(%r9)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$-0x3ff8000000000000, %rax # imm = 0xC008000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	-0x70(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpq	$-0x3, %rax
               	jne	<addr>
               	fldt	-0x80(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	-0x18(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	fldt	-0x70(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	-0x28(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x18(%rbp)
               	leaq	-0x18(%rbp), %r9
               	fldt	(%r9)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$-0x4000000000000000, %rax # imm = 0xC000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	-0x70(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpq	$-0x2, %rax
               	jne	<addr>
               	fldt	-0x90(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	-0x18(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	fldt	-0x80(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	-0x28(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	fldt	-0x90(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4014000000000000, %rax # imm = 0x4014000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	leaq	-0x38(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	leaq	-0x28(%rbp), %rax
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rax)
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
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	-0x90(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4014000000000000, %rax # imm = 0x4014000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	leaq	-0x38(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	leaq	-0x28(%rbp), %rax
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rax)
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
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movabsq	$0x4010000000000000, %rcx # imm = 0x4010000000000000
               	leaq	-0x38(%rbp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	leaq	-0x28(%rbp), %rax
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rax)
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
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4014000000000000, %rax # imm = 0x4014000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	fldt	-0x90(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	fldt	-0x80(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	leaq	-0x38(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	leaq	-0x28(%rbp), %rax
               	movsd	%xmm1, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rax)
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
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	-0x90(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	fldt	-0x80(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	leaq	-0x38(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	leaq	-0x28(%rbp), %rax
               	movsd	%xmm1, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rax)
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
               	fstpt	-0x18(%rbp)
               	leaq	-0x18(%rbp), %r9
               	fldt	(%r9)
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
               	fldt	-0x90(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	fldt	-0x90(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	leaq	-0x28(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0x28(%rbp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	-0x28(%rbp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	-0x90(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	leaq	-0x28(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	-0x28(%rbp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	movabsq	$0x4059000000000000, %rax # imm = 0x4059000000000000
               	leaq	-0x28(%rbp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0x28(%rbp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	-0x28(%rbp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	xorl	%ecx, %ecx
               	leaq	-0x38(%rbp), %r9
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	leaq	-0x28(%rbp), %rcx
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rcx)
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
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	fldt	-0x90(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	fldt	-0x90(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	leaq	-0x38(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	leaq	-0x28(%rbp), %rax
               	movsd	%xmm1, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rax)
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
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	fldt	-0x90(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	fldt	-0x70(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	leaq	-0x38(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	leaq	-0x28(%rbp), %rax
               	movsd	%xmm1, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rax)
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
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$-0x4000000000000000, %rax # imm = 0xC000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	-0x90(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	fldt	-0x80(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	leaq	-0x38(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	leaq	-0x28(%rbp), %rax
               	movsd	%xmm1, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rax)
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
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	fldt	-0x80(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movl	$0x3, %edi
               	leaq	-0x28(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	-0x80(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movl	$0x2, %edi
               	leaq	-0x28(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	fldt	-0x90(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	fldt	-0x90(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	fldt	-0x80(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm2
               	leaq	-0x48(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	leaq	-0x38(%rbp), %rax
               	movsd	%xmm1, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rax)
               	leaq	-0x28(%rbp), %rcx
               	movsd	%xmm2, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rcx)
               	subq	$0x30, %rsp
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
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x30, %rsp
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4012000000000000, %rax # imm = 0x4012000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	movabsq	$0x7fe1ccf385ebc8a0, %rax # imm = 0x7FE1CCF385EBC8A0
               	movabsq	$0x4024000000000000, %rcx # imm = 0x4024000000000000
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	mulsd	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jbe	<addr>
               	movq	<rip>, %rax      # <addr>
               	fldt	-0x70(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	-0x28(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	*%rax
               	addq	$0x10, %rsp
               	fstpt	-0x18(%rbp)
               	fldt	-0x18(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x17, %eax
               	leave
               	retq
