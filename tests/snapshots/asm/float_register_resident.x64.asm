
float_register_resident.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	xorq	%rax, %rax
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x10(%rbp,%riz)
               	xorq	%rax, %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movl	$0x3f000000, %ecx       # imm = 0x3F000000
               	movq	%rcx, %xmm15
               	mulss	%xmm15, %xmm0
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movss	-0x10(%rbp,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movss	%xmm0, -0x10(%rbp,%riz)
               	movl	$0x1, %edx
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rdx, %xmm0
               	movq	%rcx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	-0x10(%rbp,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movss	%xmm0, -0x10(%rbp,%riz)
               	movl	$0x2, %edx
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rdx, %xmm0
               	movq	%rcx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	-0x10(%rbp,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movss	%xmm0, -0x10(%rbp,%riz)
               	movl	$0x3, %edx
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rdx, %xmm0
               	movq	%rcx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	-0x10(%rbp,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movss	%xmm0, -0x10(%rbp,%riz)
               	movl	$0x4, %eax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movq	%rcx, %xmm15
               	mulss	%xmm15, %xmm0
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movss	-0x10(%rbp,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movss	%xmm0, -0x10(%rbp,%riz)
               	movl	$0x5, %ecx
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rcx, %xmm0
               	movl	$0x3f000000, %ecx       # imm = 0x3F000000
               	movq	%rcx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	-0x10(%rbp,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movss	%xmm0, -0x10(%rbp,%riz)
               	movl	$0x6, %edx
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rdx, %xmm0
               	movq	%rcx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	-0x10(%rbp,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movss	%xmm0, -0x10(%rbp,%riz)
               	movl	$0x7, %edx
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rdx, %xmm0
               	movq	%rcx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	-0x10(%rbp,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movss	%xmm0, -0x10(%rbp,%riz)
               	movl	$0x8, %edx
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rdx, %xmm0
               	movq	%rcx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	-0x10(%rbp,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movss	%xmm0, -0x10(%rbp,%riz)
               	movl	$0x9, %eax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movl	$0x3f000000, %eax       # imm = 0x3F000000
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movss	-0x10(%rbp,%riz), %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movss	%xmm0, -0x10(%rbp,%riz)
               	movss	-0x10(%rbp,%riz), %xmm0
               	cvttss2si	%xmm0, %rax
               	movslq	%eax, %rax
               	leave
               	retq
