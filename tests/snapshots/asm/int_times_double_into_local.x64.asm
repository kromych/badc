
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
               	movabsq	$-0x3fe6de04abbbd2e8, %rax # imm = 0xC01921FB54442D18
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rsi, %xmm0
               	movq	%rax, %xmm14
               	vmulsd	%xmm0, %xmm14, %xmm0
               	retq

<main>:
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	xorl	%eax, %eax
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movabsq	$-0x3fe6de04abbbd2e8, %rcx # imm = 0xC01921FB54442D18
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movabsq	$-0x3fd6de04abbbd2e8, %rcx # imm = 0xC02921FB54442D18
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	retq
