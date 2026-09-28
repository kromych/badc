
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
               	movq	%rdi, %rax
               	subq	%rdx, %rax
               	addq	%rsi, %rax
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
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
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
               	movq	%rax, %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movl	$0x1, %eax
               	movl	$0x2c, %ecx
               	cvtsd2ss	%xmm0, %xmm1
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movapd	%xmm1, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm0, %xmm1
               	vfmadd231ss	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	xorps	%xmm2, %xmm2
               	cvtsi2ss	%rcx, %xmm2
               	addss	%xmm2, %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movabsq	$0x4048000000000000, %rax # imm = 0x4048000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movabsq	$0x4014000000000000, %rax # imm = 0x4014000000000000
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm1
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	divss	%xmm15, %xmm1
               	movapd	%xmm0, %xmm15
               	movapd	%xmm1, %xmm0
               	addss	%xmm15, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movabsq	$0x400c000000000000, %rax # imm = 0x400C000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movl	$0x1, %ecx
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rcx, %xmm0
               	movapd	%xmm0, %xmm15
               	movapd	%xmm1, %xmm0
               	addss	%xmm15, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	xorl	%eax, %eax
               	retq
