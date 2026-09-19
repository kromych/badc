
const_float_div_zero.x64:	file format elf64-x86-64

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
               	movabsq	$0x7fe1ccf385ebc8a0, %rcx # imm = 0x7FE1CCF385EBC8A0
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	ja	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	movsd	(%rax), %xmm0
               	movabsq	$-0x1e330c7a143760, %rax # imm = 0xFFE1CCF385EBC8A0
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	ja	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	movsd	(%rax), %xmm0
               	ucomisd	%xmm0, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	movq	%rdx, %xmm0
               	divsd	%xmm15, %xmm0
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	ja	<addr>
               	movl	$0x4, %eax
               	retq
               	retq
