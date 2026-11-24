
fma_contraction.x64:	file format elf64-x86-64

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
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	movsd	<rip>, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	movsd	<rip>, %xmm2
               	movsd	<rip>, %xmm1
               	movsd	<rip>, %xmm3
               	vfmadd213sd	%xmm3, %xmm1, %xmm2 # xmm2 = (xmm1 * xmm2) + xmm3
               	ucomisd	%xmm1, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	movss	<rip>, %xmm1
               	movss	<rip>, %xmm2
               	movss	<rip>, %xmm3
               	vfmadd213ss	%xmm3, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + xmm3
               	ucomiss	<rip>, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	xorl	%eax, %eax
               	retq
