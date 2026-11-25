
tgmath_selects_by_argument_type.x64:	file format elf64-x86-64

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
               	subq	$0x48, %rsp
               	subq	$0x10, %rsp
               	movss	<rip>, %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x10(%rsp)
               	movl	$0x0, 0x48(%rsp)
               	callq	<addr>
               	movsd	%xmm0, 0x38(%rsp)
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	movsd	0x38(%rsp), %xmm14
               	ucomiss	%xmm0, %xmm14
               	jp	<addr>
               	jne	<addr>
               	fldt	0x10(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	vxorpd	<rip>, %xmm0, %xmm0
               	leaq	0x20(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x20(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fstpt	0x10(%rsp)
               	fldt	0x10(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	movsd	<rip>, %xmm0
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movsd	<rip>, %xmm1
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x10, %rsp
               	addq	$0x48, %rsp
               	retq
               	movss	<rip>, %xmm0
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	0x48(%rsp), %eax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movss	<rip>, %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x10, %rsp
               	addq	$0x48, %rsp
               	retq
               	movss	<rip>, %xmm0
               	callq	<addr>
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movss	<rip>, %xmm0
               	callq	<addr>
               	ucomiss	<rip>, %xmm0
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
