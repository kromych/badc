
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
               	movsd	<rip>, %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rsi, %xmm1
               	mulsd	%xmm1, %xmm0
               	retq

<main>:
               	xorl	%eax, %eax
               	retq
