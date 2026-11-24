
float_param_stack_overflow.x64:	file format elf64-x86-64

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

<wsum>:
               	movss	0x8(%rsp), %xmm8
               	movss	0x10(%rsp), %xmm9
               	vmulss	<rip>, %xmm1, %xmm1
               	vfmadd132ss	<rip>, %xmm1, %xmm0 # xmm0 = (xmm0 * mem) + xmm1
               	vfmadd231ss	<rip>, %xmm2, %xmm0 # xmm0 = (xmm2 * mem) + xmm0
               	vfmadd231ss	<rip>, %xmm3, %xmm0 # xmm0 = (xmm3 * mem) + xmm0
               	vfmadd231ss	<rip>, %xmm4, %xmm0 # xmm0 = (xmm4 * mem) + xmm0
               	vfmadd231ss	<rip>, %xmm5, %xmm0 # xmm0 = (xmm5 * mem) + xmm0
               	vfmadd231ss	<rip>, %xmm6, %xmm0 # xmm0 = (xmm6 * mem) + xmm0
               	vfmadd231ss	<rip>, %xmm7, %xmm0 # xmm0 = (xmm7 * mem) + xmm0
               	vfmadd231ss	<rip>, %xmm8, %xmm0 # xmm0 = (xmm8 * mem) + xmm0
               	vfmadd231ss	<rip>, %xmm9, %xmm0 # xmm0 = (xmm9 * mem) + xmm0
               	cvttss2si	%xmm0, %rax
               	retq

<main>:
               	subq	$0x18, %rsp
               	subq	$0x10, %rsp
               	movss	<rip>, %xmm0 # <addr>
               	movsd	%xmm0, 0x18(%rsp)
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
               	movsd	0x18(%rsp), %xmm0
               	cmpl	$0x3ff, %eax            # imm = 0x3FF
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	addq	$0x18, %rsp
               	retq
               	movss	<rip>, %xmm1
               	movss	<rip>, %xmm2
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
               	cmpl	$0x37f, %eax            # imm = 0x37F
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x10, %rsp
               	addq	$0x18, %rsp
               	retq
