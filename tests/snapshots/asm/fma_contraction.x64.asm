
fma_contraction.x64:	file format elf64-x86-64

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

<dmadd>:
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	retq

<dmsub>:
               	vfmsub213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) - xmm2
               	retq

<dnmadd>:
               	vfnmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = -(xmm1 * xmm0) + xmm2
               	retq

<fmadd_>:
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	retq

<fmsub_>:
               	vfmsub213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) - xmm2
               	retq

<fnmadd_>:
               	vfnmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = -(xmm1 * xmm0) + xmm2
               	retq

<main>:
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movabsq	$0x4010000000000000, %rdx # imm = 0x4010000000000000
               	movq	%rax, %xmm0
               	movq	%rdx, %xmm14
               	movq	%rcx, %xmm15
               	vfmadd132sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm0 * xmm15) + xmm14
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	movabsq	$0x3fe0000000000000, %rdx # imm = 0x3FE0000000000000
               	movabsq	$0x3fd0000000000000, %rcx # imm = 0x3FD0000000000000
               	movabsq	$0x3fc0000000000000, %rsi # imm = 0x3FC0000000000000
               	movq	%rdx, %xmm1
               	movq	%rsi, %xmm14
               	movq	%rcx, %xmm15
               	vfmadd132sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm1 * xmm15) + xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movl	$0x40400000, %edx       # imm = 0x40400000
               	movl	$0x40800000, %esi       # imm = 0x40800000
               	movq	%rcx, %xmm1
               	movq	%rsi, %xmm14
               	movq	%rdx, %xmm15
               	vfmadd132ss	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm1 * xmm15) + xmm14
               	movl	$0x41200000, %ecx       # imm = 0x41200000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	xorl	%eax, %eax
               	retq
