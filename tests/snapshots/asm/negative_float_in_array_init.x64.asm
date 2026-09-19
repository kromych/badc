
negative_float_in_array_init.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	movsd	(%rax), %xmm0
               	movabsq	$0x3ff8000000000000, %rcx # imm = 0x3FF8000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movsd	0x8(%rax), %xmm0
               	movabsq	$0x4004000000000000, %rdx # imm = 0x4004000000000000
               	movq	%rdx, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movsd	0x10(%rax), %xmm1
               	movabsq	$0x421e449a94000000, %rdx # imm = 0x421E449A94000000
               	movq	%rdx, %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movsd	(%rax), %xmm1
               	movsd	0x8(%rax), %xmm2
               	addsd	%xmm2, %xmm1
               	movsd	0x10(%rax), %xmm2
               	addsd	%xmm2, %xmm1
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	movapd	%xmm0, %xmm2
               	addsd	%xmm15, %xmm2
               	ucomisd	%xmm2, %xmm1
               	ja	<addr>
               	movq	%rcx, %xmm15
               	subsd	%xmm15, %xmm0
               	ucomisd	%xmm1, %xmm0
               	jbe	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%eax, %eax
               	retq
