
tgmath_selects_by_argument_type.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x40(%rbp)
               	movl	$0x0, -0x8(%rbp)
               	movq	%rax, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	%xmm0, 0x28(%rsp)
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	movsd	0x28(%rsp), %xmm14
               	ucomiss	%xmm0, %xmm14
               	jp	<addr>
               	jne	<addr>
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	leaq	-0x30(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x30(%rbp)
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
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x2, %eax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm1
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	$0x41000000, %eax       # imm = 0x41000000
               	leaq	-0x8(%rbp), %rdi
               	movq	%rax, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x3f000000, %eax       # imm = 0x3F000000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movl	$0x2, %edi
               	movl	$0x3f000000, %eax       # imm = 0x3F000000
               	movq	%rax, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movq	%rax, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	movq	%rax, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movl	$0xc0000000, %eax       # imm = 0xC0000000
               	movl	$0x40400000, %ecx       # imm = 0x40400000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	vdivss	%xmm15, %xmm14, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0xbf800000, %eax       # imm = 0xBF800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
