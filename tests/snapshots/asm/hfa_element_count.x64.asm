
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
               	subq	$0x50, %rsp
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movl	0x8(%rcx), %r10d
               	movl	%r10d, 0x8(%rax)
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, -0x30(%rbp)
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rcx, -0x28(%rbp)
               	movabsq	$0x4008000000000000, %rdx # imm = 0x4008000000000000
               	movq	%rdx, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	-0x48(%rbp), %xmm0
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	$0x3f800000, -0x40(%rbp) # imm = 0x3F800000
               	movl	$0x40000000, -0x3c(%rbp) # imm = 0x40000000
               	movl	$0x40400000, -0x38(%rbp) # imm = 0x40400000
               	movss	-0x40(%rbp), %xmm0
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x3c(%rbp), %xmm0
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x38(%rbp), %xmm0
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movabsq	$0x4008000000000000, %rdx # imm = 0x4008000000000000
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movsd	-0x30(%rbp), %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x28(%rbp), %xmm0
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x20(%rbp), %xmm0
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movabsq	$0x4008000000000000, %rdx # imm = 0x4008000000000000
               	movq	%rax, -0x18(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movsd	-0x18(%rbp), %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x10(%rbp), %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x8(%rbp), %xmm0
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movabsq	$0x3fe8000000000000, %rax # imm = 0x3FE8000000000000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movsd	-0x8(%rbp), %xmm0
               	movabsq	$0x4024000000000000, %rcx # imm = 0x4024000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	vfmadd132sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm0 * xmm15) + xmm14
               	movabsq	$0x4044400000000000, %rdx # imm = 0x4044400000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	movl	0x8(%rsi), %r10d
               	movl	%r10d, 0x8(%rdx)
               	movss	-0x10(%rbp), %xmm0
               	movl	$0x42c80000, %edx       # imm = 0x42C80000
               	movss	-0xc(%rbp), %xmm1
               	movl	$0x41200000, %esi       # imm = 0x41200000
               	movq	%rsi, %xmm15
               	mulss	%xmm15, %xmm1
               	movq	%rdx, %xmm15
               	vfmadd132ss	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm0 * xmm15) + xmm1
               	movss	-0x8(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	movabsq	$0x405ee00000000000, %rdx # imm = 0x405EE00000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rsi
               	leaq	<rip>, %rdi
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	0x10(%rdi), %r10
               	movq	%r10, 0x10(%rsi)
               	movsd	-0x18(%rbp), %xmm0
               	movabsq	$0x4059000000000000, %rdi # imm = 0x4059000000000000
               	movsd	-0x10(%rbp), %xmm1
               	movq	%rcx, %xmm15
               	mulsd	%xmm15, %xmm1
               	movq	%rdi, %xmm15
               	vfmadd132sd	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm0 * xmm15) + xmm1
               	movsd	-0x8(%rbp), %xmm1
               	addsd	%xmm1, %xmm0
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%rsi)
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movsd	-0x18(%rbp), %xmm0
               	movabsq	$0x4059000000000000, %rdx # imm = 0x4059000000000000
               	movsd	-0x10(%rbp), %xmm1
               	movabsq	$0x4024000000000000, %rcx # imm = 0x4024000000000000
               	movq	%rcx, %xmm15
               	mulsd	%xmm15, %xmm1
               	movq	%rdx, %xmm15
               	vfmadd132sd	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm0 * xmm15) + xmm1
               	movsd	-0x8(%rbp), %xmm1
               	addsd	%xmm1, %xmm0
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	movabsq	$0x405ee00000000000, %rdx # imm = 0x405EE00000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	movl	$0x3f800000, %edx       # imm = 0x3F800000
               	movl	$0x40000000, %esi       # imm = 0x40000000
               	movl	$0x41200000, %edi       # imm = 0x41200000
               	movq	%rdx, %xmm0
               	movq	%rsi, %xmm14
               	movq	%rdi, %xmm15
               	vfmadd132ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm0 * xmm15) + xmm14
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	movabsq	$0x4029000000000000, %rdx # imm = 0x4029000000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movabsq	$0x3fd0000000000000, %rdx # imm = 0x3FD0000000000000
               	movq	%rax, %xmm0
               	movq	%rdx, %xmm14
               	movq	%rcx, %xmm15
               	vfmadd132sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm0 * xmm15) + xmm14
               	movabsq	$0x4015000000000000, %rax # imm = 0x4015000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
