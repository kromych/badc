
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
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x10(%rbp)
               	testq	%rdi, %rdi
               	je	<addr>
               	fldt	-0x10(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	movapd	%xmm1, %xmm0
               	leave
               	retq

<as_double>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x10(%rbp)
               	fldt	-0x10(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	setg	%bl
               	movzbq	%bl, %rbx
               	leaq	<rip>, %rax
               	fldt	(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	leaq	<rip>, %rcx
               	movsd	(%rcx), %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x40(%rbp)
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x401a000000000000, %rax # imm = 0x401A000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	movabsq	$0x400a000000000000, %rax # imm = 0x400A000000000000
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	callq	<addr>
               	movabsq	$0x400a000000000000, %rax # imm = 0x400A000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	xorl	%edi, %edi
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	callq	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	leave
               	retq
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax
               	fldt	(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x40(%rbp)
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	leave
               	retq
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax
               	fldt	(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax
               	movsd	(%rax), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x40(%rbp)
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x401a000000000000, %rax # imm = 0x401A000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	fldt	(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	<rip>, %rax
               	fldt	(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x3fd0000000000000, %rax # imm = 0x3FD0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	fldt	(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	callq	<addr>
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rcx
               	fldt	(%rcx)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x3fd0000000000000, %rax # imm = 0x3FD0000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	movabsq	$0x4006000000000000, %rax # imm = 0x4006000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x40(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rax)
               	fldt	(%rcx)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rcx, %xmm15
               	mulsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x10(%rax)
               	leaq	<rip>, %rcx
               	movsd	(%rcx), %xmm0
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x20(%rax)
               	fldt	(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	fldt	0x10(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4014000000000000, %rdx # imm = 0x4014000000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	0x20(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x17, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdx
               	fldt	(%rdx)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movq	%rdx, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x40(%rbp)
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x10(%rbp)
               	fldt	-0x10(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x400c000000000000, %rdx # imm = 0x400C000000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x18, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edx, %edx
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x40(%rbp)
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rdx, %xmm1
               	movapd	%xmm1, %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x40(%rbp)
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movl	$0x1, %edx
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rdx, %xmm1
               	movapd	%xmm1, %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x40(%rbp)
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movl	$0x2, %edx
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rdx, %xmm1
               	movapd	%xmm1, %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x40(%rbp)
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movl	$0x3, %edx
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rdx, %xmm1
               	movapd	%xmm1, %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x40(%rbp)
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x19, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movsd	(%rax), %xmm0
               	movabsq	$0x3fc0000000000000, %rax # imm = 0x3FC0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	<rip>, %rax
               	movss	(%rax), %xmm0
               	movl	$0x40c00000, %eax       # imm = 0x40C00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x1a, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	fldt	(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x3fd0000000000000, %rax # imm = 0x3FD0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	<rip>, %rax
               	fldt	(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x3fe8000000000000, %rcx # imm = 0x3FE8000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	0x10(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x3ff8000000000000, %rcx # imm = 0x3FF8000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1b, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x1d, %eax
               	popq	%rbx
               	leave
               	retq
               	testq	%rbx, %rbx
               	je	<addr>
               	movabsq	$0x3ff0000000000000, %r11 # imm = 0x3FF0000000000000
               	movq	%r11, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x10(%rbp)
               	testl	%ebx, %ebx
               	jne	<addr>
               	movabsq	$0x3ff0000000000000, %r11 # imm = 0x3FF0000000000000
               	movq	%r11, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x40(%rbp)
               	fldt	-0x10(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1e, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdx
               	fldt	(%rdx)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x40(%rbp)
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x3fe0000000000000, %rdx # imm = 0x3FE0000000000000
               	movq	%rdx, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x40(%rbp)
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x40(%rbp)
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4018000000000000, %rdx # imm = 0x4018000000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x20, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	mulsd	%xmm15, %xmm0
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x21, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$0x4000000000000000, %r11 # imm = 0x4000000000000000
               	movq	%r11, %xmm0
               	jmp	<addr>
               	movabsq	$0x4000000000000000, %r11 # imm = 0x4000000000000000
               	movq	%r11, %xmm0
               	jmp	<addr>
               	leaq	<rip>, %rax
               	fldt	(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movsd	(%rax), %xmm0
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movsd	(%rax), %xmm0
               	jmp	<addr>
