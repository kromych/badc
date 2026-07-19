
inline_asm_a64_fp_cvt.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movl	$0x2a, %eax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	cvttsd2si	%xmm0, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq
