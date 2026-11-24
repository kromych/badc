
many_fp_args.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<sum10>:
               	addsd	%xmm1, %xmm0
               	addsd	%xmm2, %xmm0
               	addsd	%xmm3, %xmm0
               	addsd	%xmm4, %xmm0
               	addsd	%xmm5, %xmm0
               	addsd	%xmm6, %xmm0
               	addsd	%xmm7, %xmm0
               	movsd	0x8(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	0x10(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	retq

<main>:
               	pushq	%rax
               	subq	$0x10, %rsp
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	movsd	<rip>, %xmm2
               	movsd	<rip>, %xmm3
               	movsd	<rip>, %xmm4
               	movsd	<rip>, %xmm5
               	movsd	<rip>, %xmm6
               	movsd	<rip>, %xmm7
               	movsd	<rip>, %xmm8
               	movsd	<rip>, %xmm9
               	movq	%xmm8, %r10
               	movq	%r10, (%rsp)
               	movq	%xmm9, %r10
               	movq	%r10, 0x8(%rsp)
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%r11
               	retq
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	movsd	<rip>, %xmm2
               	movq	%xmm1, %r10
               	movq	%r10, (%rsp)
               	movq	%xmm2, %r10
               	movq	%r10, 0x8(%rsp)
               	movapd	%xmm0, %xmm1
               	movapd	%xmm0, %xmm7
               	movapd	%xmm0, %xmm6
               	movapd	%xmm0, %xmm5
               	movapd	%xmm0, %xmm4
               	movapd	%xmm0, %xmm3
               	movapd	%xmm0, %xmm2
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	addq	$0x10, %rsp
               	popq	%r11
               	retq
