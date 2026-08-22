
fp_return_value.x64:	file format elf64-x86-64

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
               	movl	$0x7, %eax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	movl	$0x2, %edx
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rdx, %xmm1
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm1
               	addsd	%xmm1, %xmm0
               	movabsq	$0x4024000000000000, %rcx # imm = 0x4024000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x3, %esi
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rsi, %xmm0
               	movl	$0x40800000, %ecx       # imm = 0x40800000
               	movq	%rcx, %xmm15
               	divss	%xmm15, %xmm0
               	movl	$0x5, %edi
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rdi, %xmm1
               	movq	%rcx, %xmm15
               	divss	%xmm15, %xmm1
               	addss	%xmm1, %xmm0
               	movl	$0x40000000, %edi       # imm = 0x40000000
               	movq	%rdi, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movq	%rdx, %rax
               	retq
               	movl	$0x1, %edx
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rdx, %xmm0
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movl	$0x6, %edx
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rdx, %xmm1
               	movq	%rcx, %xmm15
               	divss	%xmm15, %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movabsq	$0x4012000000000000, %rax # imm = 0x4012000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movq	%rsi, %rax
               	retq
               	xorq	%rax, %rax
               	retq
