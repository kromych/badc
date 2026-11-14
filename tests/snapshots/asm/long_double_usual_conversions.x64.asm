
long_double_usual_conversions.x64:	file format elf64-x86-64

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

<pick>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	testl	%edi, %edi
               	je	<addr>
               	fldt	-0x20(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	-0x10(%rbp), %rax
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x10(%rbp)
               	movq	%rax, %rcx
               	fldt	(%rcx)
               	leave
               	retq

<as_double>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	fldt	-0x10(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	setg	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x48(%rsp)
               	leaq	<rip>, %rax # <addr>
               	fldt	(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	<rip>, %xmm1
               	movsd	<rip>, %xmm2 # <addr>
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x50(%rbp)
               	fldt	-0x50(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	movabsq	$0x400a000000000000, %rax # imm = 0x400A000000000000
               	movsd	<rip>, %xmm0
               	leaq	-0x20(%rbp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x20(%rbp)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x50(%rbp)
               	fldt	-0x50(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x400a000000000000, %rax # imm = 0x400A000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	xorl	%edi, %edi
               	movsd	<rip>, %xmm0
               	leaq	-0x20(%rbp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x20(%rbp)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x50(%rbp)
               	fldt	-0x50(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movq	0x48(%rsp), %r10
               	testq	%r10, %r10
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	fldt	(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x50(%rbp)
               	fldt	-0x50(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	movq	0x48(%rsp), %r10
               	testq	%r10, %r10
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	fldt	(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	<rip>, %xmm1
               	mulsd	%xmm1, %xmm0
               	movq	0x48(%rsp), %r10
               	testq	%r10, %r10
               	je	<addr>
               	movsd	<rip>, %xmm1 # <addr>
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x50(%rbp)
               	fldt	-0x50(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	fldt	(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	fldt	(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	fldt	(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	<rip>, %xmm1
               	mulsd	%xmm1, %xmm0
               	leaq	-0x50(%rbp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x50(%rbp)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	fldt	(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	<rip>, %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movups	%xmm14, 0x20(%rcx)
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x50(%rbp)
               	fldt	(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	movsd	<rip>, %xmm0
               	vmulsd	%xmm0, %xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x40(%rbp)
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x30(%rbp)
               	fldt	-0x50(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	<rip>, %xmm2
               	ucomisd	%xmm2, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	-0x30(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	<rip>, %xmm2
               	ucomisd	%xmm2, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	fldt	(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm3
               	movsd	<rip>, %xmm0
               	addsd	%xmm0, %xmm3
               	movsd	%xmm3, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x50(%rbp)
               	movsd	%xmm3, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x20(%rbp)
               	fldt	-0x20(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm4
               	movsd	<rip>, %xmm3
               	ucomisd	%xmm3, %xmm4
               	jp	<addr>
               	jne	<addr>
               	fldt	-0x50(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm4
               	ucomisd	%xmm3, %xmm4
               	jp	<addr>
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x50(%rbp)
               	fldt	-0x50(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm3
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm3
               	movsd	%xmm3, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x50(%rbp)
               	fldt	-0x50(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm3
               	vaddsd	%xmm2, %xmm3, %xmm2
               	movsd	%xmm2, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x50(%rbp)
               	fldt	-0x50(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm2
               	vaddsd	%xmm0, %xmm2, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x50(%rbp)
               	fldt	-0x50(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm2
               	movsd	<rip>, %xmm0
               	addsd	%xmm0, %xmm2
               	movsd	%xmm2, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x50(%rbp)
               	fldt	-0x50(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm2
               	ucomisd	%xmm1, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	movsd	<rip>, %xmm1 # <addr>
               	movsd	<rip>, %xmm2
               	ucomisd	%xmm2, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm1 # <addr>
               	movss	<rip>, %xmm2
               	ucomiss	%xmm2, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	fldt	(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	movsd	<rip>, %xmm2
               	ucomisd	%xmm2, %xmm1
               	jp	<addr>
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	fldt	(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	movsd	<rip>, %xmm2
               	ucomisd	%xmm2, %xmm1
               	jp	<addr>
               	jne	<addr>
               	fldt	0x10(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x1b, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x1d, %eax
               	leave
               	retq
               	movq	0x48(%rsp), %r10
               	testq	%r10, %r10
               	je	<addr>
               	movabsq	$0x3ff0000000000000, %r11 # imm = 0x3FF0000000000000
               	movq	%r11, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x20(%rbp)
               	movq	0x48(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movabsq	$0x3ff0000000000000, %r11 # imm = 0x3FF0000000000000
               	movq	%r11, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x50(%rbp)
               	fldt	-0x20(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	-0x50(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	movsd	<rip>, %xmm0
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x1e, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	fldt	(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	movsd	%xmm1, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x50(%rbp)
               	fldt	-0x50(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	movsd	<rip>, %xmm2
               	addsd	%xmm2, %xmm1
               	movsd	%xmm1, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x50(%rbp)
               	fldt	-0x50(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	vmulsd	%xmm0, %xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x50(%rbp)
               	fldt	-0x50(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x20, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movabsq	$0x4000000000000000, %r11 # imm = 0x4000000000000000
               	movq	%r11, %xmm0
               	jmp	<addr>
               	movabsq	$0x4000000000000000, %r11 # imm = 0x4000000000000000
               	movq	%r11, %xmm0
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	fldt	(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	jmp	<addr>
               	movsd	<rip>, %xmm0 # <addr>
               	jmp	<addr>
               	movsd	<rip>, %xmm0 # <addr>
               	jmp	<addr>
