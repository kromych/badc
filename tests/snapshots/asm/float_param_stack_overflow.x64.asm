
float_param_stack_overflow.x64:	file format elf64-x86-64

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

<wsum>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movss	0x10(%rbp), %xmm8
               	movss	0x18(%rbp), %xmm9
               	movss	<rip>, %xmm10
               	movss	<rip>, %xmm11
               	mulss	%xmm11, %xmm1
               	vfmadd213ss	%xmm1, %xmm10, %xmm0 # xmm0 = (xmm10 * xmm0) + xmm1
               	movss	<rip>, %xmm1
               	vfmadd231ss	%xmm1, %xmm2, %xmm0 # xmm0 = (xmm2 * xmm1) + xmm0
               	movss	<rip>, %xmm1
               	vfmadd231ss	%xmm1, %xmm3, %xmm0 # xmm0 = (xmm3 * xmm1) + xmm0
               	movss	<rip>, %xmm1
               	vfmadd231ss	%xmm1, %xmm4, %xmm0 # xmm0 = (xmm4 * xmm1) + xmm0
               	movss	<rip>, %xmm1
               	vfmadd231ss	%xmm1, %xmm5, %xmm0 # xmm0 = (xmm5 * xmm1) + xmm0
               	movss	<rip>, %xmm1
               	vfmadd231ss	%xmm1, %xmm6, %xmm0 # xmm0 = (xmm6 * xmm1) + xmm0
               	movss	<rip>, %xmm1
               	vfmadd231ss	%xmm1, %xmm7, %xmm0 # xmm0 = (xmm7 * xmm1) + xmm0
               	movss	<rip>, %xmm1
               	vfmadd231ss	%xmm1, %xmm8, %xmm0 # xmm0 = (xmm8 * xmm1) + xmm0
               	movss	<rip>, %xmm1
               	vfmadd231ss	%xmm1, %xmm9, %xmm0 # xmm0 = (xmm9 * xmm1) + xmm0
               	cvttss2si	%xmm0, %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movss	<rip>, %xmm0 # <addr>
               	movsd	%xmm0, 0x8(%rsp)
               	subq	$0x10, %rsp
               	movq	%xmm0, %r10
               	movq	%r10, (%rsp)
               	movq	%xmm0, %r10
               	movq	%r10, 0x8(%rsp)
               	movapd	%xmm0, %xmm1
               	movapd	%xmm0, %xmm7
               	movapd	%xmm0, %xmm6
               	movapd	%xmm0, %xmm5
               	movapd	%xmm0, %xmm4
               	movapd	%xmm0, %xmm3
               	movapd	%xmm0, %xmm2
               	callq	<addr>
               	addq	$0x10, %rsp
               	movsd	0x8(%rsp), %xmm0
               	cmpl	$0x3ff, %eax            # imm = 0x3FF
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movss	<rip>, %xmm1
               	movss	<rip>, %xmm2
               	subq	$0x10, %rsp
               	movq	%xmm1, %r10
               	movq	%r10, (%rsp)
               	movq	%xmm2, %r10
               	movq	%r10, 0x8(%rsp)
               	movapd	%xmm0, %xmm1
               	movapd	%xmm0, %xmm7
               	movapd	%xmm0, %xmm6
               	movapd	%xmm0, %xmm5
               	movapd	%xmm0, %xmm4
               	movapd	%xmm0, %xmm3
               	movapd	%xmm0, %xmm2
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpl	$0x37f, %eax            # imm = 0x37F
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
