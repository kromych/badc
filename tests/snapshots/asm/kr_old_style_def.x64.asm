
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
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	vfmadd132ss	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm0 * xmm15) + xmm1
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rsi, %xmm1
               	addss	%xmm1, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	retq

<halve>:
               	movsbq	%dil, %rdi
               	cvtsd2ss	%xmm0, %xmm0
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	divss	%xmm15, %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rdi, %xmm1
               	addss	%xmm1, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	retq

<main>:
               	movl	$0x3fc00000, %eax       # imm = 0x3FC00000
               	movl	$0x3f800000, %ecx       # imm = 0x3F800000
               	movl	$0x40000000, %edx       # imm = 0x40000000
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm14
               	movq	%rdx, %xmm15
               	vfmadd132ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm0 * xmm15) + xmm14
               	movl	$0x42300000, %eax       # imm = 0x42300000
               	movq	%rax, %xmm15
               	addss	%xmm15, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movabsq	$0x4048000000000000, %rax # imm = 0x4048000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	$0x40a00000, %eax       # imm = 0x40A00000
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	vdivss	%xmm15, %xmm14, %xmm0
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movq	%rax, %xmm15
               	addss	%xmm15, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movabsq	$0x400c000000000000, %rax # imm = 0x400C000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	xorl	%eax, %eax
               	retq
