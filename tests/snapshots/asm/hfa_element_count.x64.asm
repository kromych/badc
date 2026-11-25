
hfa_element_count.x64:	file format elf64-x86-64

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
               	subq	$0x28, %rsp
               	leaq	0x10(%rsp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movl	0x8(%rcx), %r10d
               	movl	%r10d, 0x8(%rax)
               	movsd	<rip>, %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x28, %rsp
               	retq
               	movabsq	$0x400000003f800000, %rcx # imm = 0x400000003F800000
               	movq	%rcx, 0x10(%rsp)
               	movl	$0x40400000, 0x18(%rsp) # imm = 0x40400000
               	movss	0x10(%rsp), %xmm0
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x14(%rsp), %xmm0
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x18(%rsp), %xmm0
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	0x18(%rsp), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm2
               	movsd	<rip>, %xmm1
               	vfmadd213sd	%xmm0, %xmm1, %xmm2 # xmm2 = (xmm1 * xmm2) + xmm0
               	ucomisd	<rip>, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movl	0x8(%rcx), %r10d
               	movl	%r10d, 0x8(%rax)
               	movss	<rip>, %xmm2
               	movss	<rip>, %xmm3
               	vmulss	<rip>, %xmm3, %xmm3
               	vfmadd132ss	<rip>, %xmm3, %xmm2 # xmm2 = (xmm2 * mem) + xmm3
               	movss	<rip>, %xmm3
               	addss	%xmm3, %xmm2
               	cvtss2sd	%xmm2, %xmm2
               	vaddsd	%xmm0, %xmm2, %xmm3
               	ucomisd	<rip>, %xmm3
               	jp	<addr>
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	0x8(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	movsd	<rip>, %xmm3
               	movsd	<rip>, %xmm2
               	vmulsd	%xmm1, %xmm2, %xmm1
               	vfmadd231sd	<rip>, %xmm3, %xmm1 # xmm1 = (xmm3 * mem) + xmm1
               	movsd	<rip>, %xmm2
               	addsd	%xmm2, %xmm1
               	vaddsd	%xmm0, %xmm1, %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm2
               	movsd	<rip>, %xmm3
               	movsd	<rip>, %xmm1
               	mulsd	%xmm1, %xmm3
               	vfmadd132sd	<rip>, %xmm3, %xmm2 # xmm2 = (xmm2 * mem) + xmm3
               	movsd	<rip>, %xmm3
               	addsd	%xmm3, %xmm2
               	addsd	%xmm0, %xmm2
               	ucomisd	<rip>, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x28, %rsp
               	retq
               	movss	<rip>, %xmm2
               	movss	<rip>, %xmm3
               	movss	<rip>, %xmm4
               	vfmadd213ss	%xmm3, %xmm4, %xmm2 # xmm2 = (xmm4 * xmm2) + xmm3
               	cvtss2sd	%xmm2, %xmm2
               	addsd	%xmm0, %xmm2
               	ucomisd	<rip>, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x28, %rsp
               	retq
               	movsd	<rip>, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
