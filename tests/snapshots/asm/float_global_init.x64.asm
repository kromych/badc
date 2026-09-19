
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
               	subsd	%xmm15, %xmm0
               	movabsq	$0x3f50624dd2f1a9fc, %rax # imm = 0x3F50624DD2F1A9FC
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x40af9db22d0e5604, %rdx # imm = 0xBF50624DD2F1A9FC
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	ja	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rsi
               	movss	(%rsi), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rcx, %xmm15
               	subsd	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	ja	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rsi
               	movss	(%rsi), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movabsq	$0x4004000000000000, %rsi # imm = 0x4004000000000000
               	movq	%rsi, %xmm15
               	subsd	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	ja	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rdx
               	movss	(%rdx), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rcx, %xmm15
               	subsd	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x40af9db22d0e5604, %rax # imm = 0xBF50624DD2F1A9FC
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	ja	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rcx
               	movss	(%rcx), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movq	%rdx, %xmm15
               	subsd	%xmm15, %xmm0
               	movabsq	$0x3f50624dd2f1a9fc, %rcx # imm = 0x3F50624DD2F1A9FC
               	movq	%rcx, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	ja	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rdi
               	movsd	(%rdi), %xmm0
               	movq	%rdx, %xmm15
               	subsd	%xmm15, %xmm0
               	movq	%rcx, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	ja	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rdx
               	movsd	(%rdx), %xmm0
               	movq	%rsi, %xmm15
               	subsd	%xmm15, %xmm0
               	movq	%rcx, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
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
               	movabsq	$-0x40af9db22d0e5604, %rax # imm = 0xBF50624DD2F1A9FC
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	ja	<addr>
               	movl	$0x8, %eax
               	retq
               	xorl	%eax, %eax
               	retq
