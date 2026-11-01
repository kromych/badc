
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
               	movabsq	$0x401c000000000000, %rcx # imm = 0x401C000000000000
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	vaddsd	%xmm15, %xmm14, %xmm0
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movq	%rdx, %xmm14
               	movq	%rax, %xmm15
               	vaddsd	%xmm15, %xmm14, %xmm1
               	addsd	%xmm1, %xmm0
               	movabsq	$0x4024000000000000, %rcx # imm = 0x4024000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x40400000, %esi       # imm = 0x40400000
               	movl	$0x40800000, %ecx       # imm = 0x40800000
               	movq	%rsi, %xmm14
               	movq	%rcx, %xmm15
               	vdivss	%xmm15, %xmm14, %xmm0
               	movl	$0x40a00000, %esi       # imm = 0x40A00000
               	movq	%rsi, %xmm14
               	movq	%rcx, %xmm15
               	vdivss	%xmm15, %xmm14, %xmm1
               	addss	%xmm1, %xmm0
               	movl	$0x40000000, %esi       # imm = 0x40000000
               	movq	%rsi, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movabsq	$0x3ff0000000000000, %rsi # imm = 0x3FF0000000000000
               	movq	%rsi, %xmm14
               	movq	%rax, %xmm15
               	vaddsd	%xmm15, %xmm14, %xmm0
               	movl	$0x40c00000, %eax       # imm = 0x40C00000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	vdivss	%xmm15, %xmm14, %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rdx, %xmm15
               	vfmadd132sd	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm0 * xmm15) + xmm1
               	movabsq	$0x4012000000000000, %rax # imm = 0x4012000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorl	%eax, %eax
               	retq
