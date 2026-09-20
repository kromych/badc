
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
               	movabsq	$0x3ff8000000000000, %rdx # imm = 0x3FF8000000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movsd	0x8(%rax), %xmm0
               	movabsq	$-0x3ffc000000000000, %rcx # imm = 0xC004000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movsd	0x10(%rax), %xmm0
               	movabsq	$-0x3de1bb656c000000, %rcx # imm = 0xC21E449A94000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movsd	(%rax), %xmm0
               	movsd	0x8(%rax), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	0x10(%rax), %xmm1
               	addsd	%xmm1, %xmm0
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	movq	%rcx, %xmm1
               	addsd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	ja	<addr>
               	movq	%rdx, %xmm15
               	movq	%rcx, %xmm1
               	subsd	%xmm15, %xmm1
               	ucomisd	%xmm0, %xmm1
               	jbe	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%eax, %eax
               	retq
