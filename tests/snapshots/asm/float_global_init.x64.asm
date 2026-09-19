
float_global_init.x64:	file format elf64-x86-64

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
               	movss	(%rax), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm15
               	movapd	%xmm0, %xmm1
               	subsd	%xmm15, %xmm1
               	movabsq	$0x3f50624dd2f1a9fc, %rax # imm = 0x3F50624DD2F1A9FC
               	movq	%rax, %xmm15
               	ucomisd	%xmm1, %xmm15
               	jbe	<addr>
               	movq	%rax, %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	ucomisd	%xmm0, %xmm1
               	ja	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rdx
               	movss	(%rdx), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rcx, %xmm15
               	subsd	%xmm15, %xmm1
               	movq	%rax, %xmm15
               	ucomisd	%xmm1, %xmm15
               	jbe	<addr>
               	ucomisd	%xmm0, %xmm1
               	ja	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rdx
               	movss	(%rdx), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movabsq	$0x4004000000000000, %rdx # imm = 0x4004000000000000
               	movq	%rdx, %xmm15
               	subsd	%xmm15, %xmm1
               	movq	%rax, %xmm15
               	ucomisd	%xmm1, %xmm15
               	jbe	<addr>
               	ucomisd	%xmm0, %xmm1
               	ja	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax
               	movss	(%rax), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rcx, %xmm15
               	movapd	%xmm0, %xmm1
               	subsd	%xmm15, %xmm1
               	movabsq	$0x3f50624dd2f1a9fc, %rax # imm = 0x3F50624DD2F1A9FC
               	movq	%rax, %xmm15
               	ucomisd	%xmm1, %xmm15
               	jbe	<addr>
               	movq	%rax, %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	ucomisd	%xmm0, %xmm1
               	ja	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rcx
               	movss	(%rcx), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm15
               	subsd	%xmm15, %xmm1
               	movq	%rax, %xmm15
               	ucomisd	%xmm1, %xmm15
               	jbe	<addr>
               	ucomisd	%xmm0, %xmm1
               	ja	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rsi
               	movsd	(%rsi), %xmm1
               	movq	%rcx, %xmm15
               	subsd	%xmm15, %xmm1
               	movq	%rax, %xmm15
               	ucomisd	%xmm1, %xmm15
               	jbe	<addr>
               	ucomisd	%xmm0, %xmm1
               	ja	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rcx
               	movsd	(%rcx), %xmm0
               	movq	%rdx, %xmm15
               	subsd	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$0x3f50624dd2f1a9fc, %rax # imm = 0x3F50624DD2F1A9FC
               	movq	%rax, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	ja	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rax
               	movsd	(%rax), %xmm0
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	subsd	%xmm15, %xmm0
               	movabsq	$0x3f50624dd2f1a9fc, %rax # imm = 0x3F50624DD2F1A9FC
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movq	%rax, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	ja	<addr>
               	movl	$0x8, %eax
               	retq
               	xorl	%eax, %eax
               	retq
