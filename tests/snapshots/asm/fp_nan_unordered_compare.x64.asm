
fp_nan_unordered_compare.x64:	file format elf64-x86-64

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
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	vdivsd	%xmm15, %xmm14, %xmm0
               	movabsq	$0x4014000000000000, %rcx # imm = 0x4014000000000000
               	ucomisd	%xmm0, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	%rcx, %xmm14
               	ucomisd	%xmm0, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x4, %eax
               	retq
               	ucomisd	%xmm0, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0xa, %eax
               	retq
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0xb, %eax
               	retq
               	movq	%rcx, %xmm14
               	ucomisd	%xmm0, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movl	$0xc, %eax
               	retq
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0xd, %eax
               	retq
               	movq	%rcx, %xmm15
               	comisd	%xmm0, %xmm15
               	jbe	<addr>
               	movl	$0x14, %eax
               	retq
               	movq	%rcx, %xmm15
               	comisd	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x15, %eax
               	retq
               	movq	%rcx, %xmm15
               	comisd	%xmm0, %xmm15
               	jb	<addr>
               	movl	$0x16, %eax
               	retq
               	movq	%rcx, %xmm15
               	comisd	%xmm15, %xmm0
               	jb	<addr>
               	movl	$0x17, %eax
               	retq
               	movq	%rcx, %xmm14
               	comisd	%xmm14, %xmm0
               	jbe	<addr>
               	movl	$0x18, %eax
               	retq
               	movq	%rcx, %xmm14
               	comisd	%xmm0, %xmm14
               	jbe	<addr>
               	movl	$0x19, %eax
               	retq
               	movq	%rcx, %xmm14
               	comisd	%xmm14, %xmm0
               	jb	<addr>
               	movl	$0x1a, %eax
               	retq
               	movq	%rcx, %xmm14
               	comisd	%xmm0, %xmm14
               	jb	<addr>
               	movl	$0x1b, %eax
               	retq
               	comisd	%xmm0, %xmm0
               	jbe	<addr>
               	movl	$0x1c, %eax
               	retq
               	comisd	%xmm0, %xmm0
               	jb	<addr>
               	movl	$0x1d, %eax
               	retq
               	comisd	%xmm0, %xmm0
               	jb	<addr>
               	movl	$0x1e, %eax
               	retq
               	retq
