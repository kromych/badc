
int_times_double_into_local.x64:	file format elf64-x86-64

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

<compute>:
               	movslq	%esi, %rsi
               	movabsq	$0x400921fb54442d18, %rax # imm = 0x400921FB54442D18
               	movabsq	$-0x4000000000000000, %rcx # imm = 0xC000000000000000
               	movq	%rax, %xmm15
               	movq	%rcx, %xmm0
               	mulsd	%xmm15, %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rsi, %xmm1
               	mulsd	%xmm1, %xmm0
               	retq

<main>:
               	xorl	%ecx, %ecx
               	movabsq	$0x400921fb54442d18, %rax # imm = 0x400921FB54442D18
               	movabsq	$-0x4000000000000000, %rdx # imm = 0xC000000000000000
               	movq	%rax, %xmm15
               	movq	%rdx, %xmm0
               	mulsd	%xmm15, %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rcx, %xmm1
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	mulsd	%xmm15, %xmm1
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x1, %ecx
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rcx, %xmm1
               	mulsd	%xmm1, %xmm0
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rcx, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0x2, %ecx
               	movabsq	$-0x4000000000000000, %rdx # imm = 0xC000000000000000
               	movq	%rax, %xmm15
               	movq	%rdx, %xmm0
               	mulsd	%xmm15, %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rcx, %xmm1
               	mulsd	%xmm1, %xmm0
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movabsq	$0x400921fb54442d18, %rax # imm = 0x400921FB54442D18
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorl	%eax, %eax
               	retq
