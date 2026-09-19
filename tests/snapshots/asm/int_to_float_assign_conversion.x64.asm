
int_to_float_assign_conversion.x64:	file format elf64-x86-64

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
               	movl	$0xa, %eax
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rax, %xmm1
               	movl	$0x64, %eax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movl	$0xc8, %eax
               	xorps	%xmm2, %xmm2
               	cvtsi2ss	%rax, %xmm2
               	movl	$0x41200000, %eax       # imm = 0x41200000
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm3
               	mulss	%xmm15, %xmm3
               	cvttss2si	%xmm3, %rcx
               	cmpq	$0x64, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	%rax, %xmm15
               	movapd	%xmm0, %xmm3
               	mulss	%xmm15, %xmm3
               	cvttss2si	%xmm3, %rcx
               	cmpq	$0x3e8, %rcx            # imm = 0x3E8
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movq	%rax, %xmm15
               	movapd	%xmm2, %xmm3
               	mulss	%xmm15, %xmm3
               	cvttss2si	%xmm3, %rax
               	cmpq	$0x7d0, %rax            # imm = 0x7D0
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x42c80000, %eax       # imm = 0x42C80000
               	movq	%rax, %xmm15
               	movapd	%xmm0, %xmm3
               	mulss	%xmm15, %xmm3
               	cvttss2si	%xmm3, %rax
               	cmpq	$0x2710, %rax           # imm = 0x2710
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x3e991687, %eax       # imm = 0x3E991687
               	movl	$0x3f1645a2, %ecx       # imm = 0x3F1645A2
               	movapd	%xmm0, %xmm15
               	movq	%rcx, %xmm0
               	mulss	%xmm15, %xmm0
               	movq	%rax, %xmm14
               	movapd	%xmm1, %xmm15
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movl	$0x3de978d5, %eax       # imm = 0x3DE978D5
               	movq	%rax, %xmm14
               	movapd	%xmm2, %xmm15
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movl	$0x43000000, %eax       # imm = 0x43000000
               	movq	%rax, %xmm15
               	subss	%xmm15, %xmm0
               	movl	$0xc22c0000, %eax       # imm = 0xC22C0000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	ja	<addr>
               	movl	$0xc2300000, %eax       # imm = 0xC2300000
               	movq	%rax, %xmm15
               	ucomiss	%xmm0, %xmm15
               	jbe	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movl	$0x40e00000, %eax       # imm = 0x40E00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
