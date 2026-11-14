
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
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rsi, %xmm0
               	vmulsd	<rip>, %xmm0, %xmm0
               	retq

<main>:
               	xorl	%eax, %eax
               	retq
