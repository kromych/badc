
kr_old_style_def.x64:	file format elf64-x86-64

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

<mix>:
               	movsbq	%sil, %rsi
               	subq	%rdx, %rdi
               	leaq	(%rdi,%rsi), %rax
               	retq

<first>:
               	movsbq	(%rdi), %rax
               	retq

<scale>:
               	movslq	%edi, %rdi
               	movsbq	%sil, %rsi
               	cvtsd2ss	%xmm0, %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rdi, %xmm1
               	movss	<rip>, %xmm2
               	vfmadd213ss	%xmm1, %xmm2, %xmm0 # xmm0 = (xmm2 * xmm0) + xmm1
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rsi, %xmm1
               	addss	%xmm1, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	retq

<halve>:
               	movsbq	%dil, %rdi
               	cvtsd2ss	%xmm0, %xmm0
               	movss	<rip>, %xmm1
               	divss	%xmm1, %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rdi, %xmm1
               	addss	%xmm1, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	retq

<main>:
               	xorl	%eax, %eax
               	retq
