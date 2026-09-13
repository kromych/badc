
compound_assign_float_register_resident.x64:	file format elf64-x86-64

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
               	movl	$0x42c80000, %ecx       # imm = 0x42C80000
               	movl	$0x3f800000, %edx       # imm = 0x3F800000
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	movq	%rcx, %xmm0
               	subss	%xmm15, %xmm0
               	movq	%rdx, %xmm15
               	movapd	%xmm0, %xmm1
               	addss	%xmm15, %xmm1
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rdx, %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	subss	%xmm15, %xmm1
               	addss	%xmm0, %xmm1
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	subss	%xmm15, %xmm1
               	addss	%xmm0, %xmm1
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	subss	%xmm15, %xmm1
               	addss	%xmm0, %xmm1
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	subss	%xmm15, %xmm1
               	addss	%xmm0, %xmm1
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	subss	%xmm15, %xmm1
               	addss	%xmm0, %xmm1
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	subss	%xmm15, %xmm1
               	addss	%xmm0, %xmm1
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	subss	%xmm15, %xmm1
               	addss	%xmm0, %xmm1
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movl	$0x42f00000, %ecx       # imm = 0x42F00000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x41100000, %ecx       # imm = 0x41100000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0x3f000000, %ecx       # imm = 0x3F000000
               	movabsq	$-0x4010000000000000, %rdx # imm = 0xBFF0000000000000
               	movq	%rcx, %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movq	%rdx, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movq	%rcx, %xmm1
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x40400000, %ecx       # imm = 0x40400000
               	movabsq	$0x4010000000000000, %rdx # imm = 0x4010000000000000
               	movq	%rcx, %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movq	%rdx, %xmm15
               	mulsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	divss	%xmm15, %xmm0
               	movl	$0x40c00000, %eax       # imm = 0x40C00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorq	%rax, %rax
               	retq
