
optimizer_fp_arg_mask_remap.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x18(%rsp)
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x10(%rsp)
               	movsd	<rip>, %xmm0
               	sqrtsd	%xmm0, %xmm14
               	movsd	%xmm14, 0x8(%rsp)
               	xorps	%xmm0, %xmm0
               	callq	<addr>
               	movsd	<rip>, %xmm2
               	movsd	0x18(%rsp), %xmm1
               	comisd	%xmm1, %xmm2
               	ja	<addr>
               	movsd	<rip>, %xmm2
               	comisd	%xmm2, %xmm1
               	jbe	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movsd	<rip>, %xmm2
               	movsd	0x10(%rsp), %xmm1
               	comisd	%xmm1, %xmm2
               	ja	<addr>
               	movsd	<rip>, %xmm2
               	comisd	%xmm2, %xmm1
               	jbe	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movsd	<rip>, %xmm1
               	movsd	0x8(%rsp), %xmm14
               	ucomisd	%xmm1, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movsd	<rip>, %xmm1
               	comisd	%xmm0, %xmm1
               	ja	<addr>
               	movsd	<rip>, %xmm1
               	comisd	%xmm1, %xmm0
               	jbe	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x13, %eax
               	leave
               	retq
