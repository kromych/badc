
hfa_element_count.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movl	0x8(%rcx), %r10d
               	movl	%r10d, 0x8(%rax)
               	leaq	-0x20(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movsd	-0x20(%rbp), %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movabsq	$0x400000003f800000, %rcx # imm = 0x400000003F800000
               	movq	%rcx, -0x10(%rbp)
               	movl	$0x40400000, -0x8(%rbp) # imm = 0x40400000
               	movss	-0x10(%rbp), %xmm0
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xc(%rbp), %xmm0
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x8(%rbp), %xmm0
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movsd	<rip>, %xmm0
               	movsd	-0x8(%rbp), %xmm2
               	movsd	<rip>, %xmm1
               	vfmadd213sd	%xmm0, %xmm1, %xmm2 # xmm2 = (xmm1 * xmm2) + xmm0
               	movsd	<rip>, %xmm3
               	ucomisd	%xmm3, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movl	0x8(%rcx), %r10d
               	movl	%r10d, 0x8(%rax)
               	movss	-0x10(%rbp), %xmm2
               	movss	<rip>, %xmm3
               	movss	-0xc(%rbp), %xmm4
               	movss	<rip>, %xmm5
               	mulss	%xmm5, %xmm4
               	vfmadd213ss	%xmm4, %xmm3, %xmm2 # xmm2 = (xmm3 * xmm2) + xmm4
               	movss	-0x8(%rbp), %xmm3
               	addss	%xmm3, %xmm2
               	cvtss2sd	%xmm2, %xmm2
               	vaddsd	%xmm0, %xmm2, %xmm3
               	movsd	<rip>, %xmm2
               	ucomisd	%xmm2, %xmm3
               	jp	<addr>
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	movsd	-0x18(%rbp), %xmm3
               	movsd	<rip>, %xmm4
               	movsd	-0x10(%rbp), %xmm5
               	vmulsd	%xmm1, %xmm5, %xmm1
               	vfmadd231sd	%xmm4, %xmm3, %xmm1 # xmm1 = (xmm3 * xmm4) + xmm1
               	movsd	-0x8(%rbp), %xmm3
               	addsd	%xmm3, %xmm1
               	vaddsd	%xmm0, %xmm1, %xmm0
               	ucomisd	%xmm2, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	movsd	<rip>, %xmm0
               	movsd	-0x18(%rbp), %xmm2
               	movsd	<rip>, %xmm3
               	movsd	-0x10(%rbp), %xmm4
               	movsd	<rip>, %xmm1
               	mulsd	%xmm1, %xmm4
               	vfmadd213sd	%xmm4, %xmm3, %xmm2 # xmm2 = (xmm3 * xmm2) + xmm4
               	movsd	-0x8(%rbp), %xmm3
               	addsd	%xmm3, %xmm2
               	addsd	%xmm0, %xmm2
               	movsd	<rip>, %xmm3
               	ucomisd	%xmm3, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	movss	<rip>, %xmm2
               	movss	<rip>, %xmm3
               	movss	<rip>, %xmm4
               	vfmadd213ss	%xmm3, %xmm4, %xmm2 # xmm2 = (xmm4 * xmm2) + xmm3
               	cvtss2sd	%xmm2, %xmm2
               	addsd	%xmm0, %xmm2
               	movsd	<rip>, %xmm3
               	ucomisd	%xmm3, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movsd	<rip>, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
