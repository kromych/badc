
fma_contraction.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<dmadd>:
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	retq

<dmsub>:
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm0
               	vfmsub231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) - xmm0
               	retq

<dnmadd>:
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm0
               	vfnmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = -(xmm14 * xmm15) + xmm0
               	retq

<fmadd_>:
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm0
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	retq

<fmsub_>:
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm0
               	vfmsub231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) - xmm0
               	retq

<fnmadd_>:
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm0
               	vfnmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = -(xmm14 * xmm15) + xmm0
               	retq

<main>:
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movabsq	$0x4010000000000000, %rdx # imm = 0x4010000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	movq	%rdx, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movabsq	$0x4010000000000000, %rdx # imm = 0x4010000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	movq	%rdx, %xmm0
               	vfmsub231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) - xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movabsq	$0x4010000000000000, %rdx # imm = 0x4010000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	movq	%rdx, %xmm0
               	vfnmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = -(xmm14 * xmm15) + xmm0
               	movq	%rax, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movl	$0x40400000, %ecx       # imm = 0x40400000
               	movl	$0x40800000, %edx       # imm = 0x40800000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	movq	%rdx, %xmm0
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movl	$0x41200000, %eax       # imm = 0x41200000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movl	$0x40400000, %ecx       # imm = 0x40400000
               	movl	$0x40800000, %edx       # imm = 0x40800000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	movq	%rdx, %xmm0
               	vfmsub231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) - xmm0
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movl	$0x40400000, %ecx       # imm = 0x40400000
               	movl	$0x40800000, %edx       # imm = 0x40800000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	movq	%rdx, %xmm0
               	vfnmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = -(xmm14 * xmm15) + xmm0
               	movq	%rax, %xmm1
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	movabsq	$0x3fd0000000000000, %rax # imm = 0x3FD0000000000000
               	movabsq	$0x3fc0000000000000, %rdx # imm = 0x3FC0000000000000
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	movq	%rdx, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movl	$0x3f000000, %ecx       # imm = 0x3F000000
               	movl	$0x3e800000, %eax       # imm = 0x3E800000
               	movl	$0x3e000000, %edx       # imm = 0x3E000000
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	movq	%rdx, %xmm0
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movabsq	$0x4010000000000000, %rdx # imm = 0x4010000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	movq	%rdx, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	movabsq	$0x3fd0000000000000, %rax # imm = 0x3FD0000000000000
               	movabsq	$0x3fc0000000000000, %rdx # imm = 0x3FC0000000000000
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	movq	%rdx, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movl	$0x40400000, %ecx       # imm = 0x40400000
               	movl	$0x40800000, %edx       # imm = 0x40800000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	movq	%rdx, %xmm0
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movl	$0x41200000, %eax       # imm = 0x41200000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movabsq	$0x4010000000000000, %rdx # imm = 0x4010000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	movq	%rdx, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	xorq	%rax, %rax
               	retq
