
float_register_resident.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<fma3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%r13, (%rsp)
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm0
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movq	(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r13, 0x8(%rsp)
               	xorq	%rbx, %rbx
               	movq	%rbx, %xmm14
               	cvtsd2ss	%xmm14, %xmm14
               	movsd	%xmm14, 0x18(%rsp)
               	movslq	%ebx, %rax
               	cmpq	$0xa, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rax
               	movq	%rax, %rbx
               	incq	%rbx
               	jmp	<addr>
               	movslq	%ebx, %rax
               	cvtsi2sd	%rax, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm1
               	movsd	0x18(%rsp), %xmm2
               	callq	<addr>
               	movsd	%xmm0, 0x18(%rsp)
               	jmp	<addr>
               	movsd	0x18(%rsp), %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	cvttsd2si	%xmm0, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
