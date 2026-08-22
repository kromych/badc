
branch_fuse_fp_nan.x64:	file format elf64-x86-64

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
               	movsd	(%rax,%riz), %xmm0
               	movsd	(%rax,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	leaq	<rip>, %rax
               	movsd	(%rax,%riz), %xmm1
               	leaq	<rip>, %rax
               	movss	(%rax,%riz), %xmm2
               	movss	(%rax,%riz), %xmm3
               	divss	%xmm3, %xmm2
               	leaq	<rip>, %rax
               	movss	(%rax,%riz), %xmm3
               	ucomisd	%xmm0, %xmm1
               	jbe	<addr>
               	movl	$0x1, %eax
               	retq
               	ucomisd	%xmm1, %xmm0
               	jbe	<addr>
               	movl	$0x2, %eax
               	retq
               	ucomisd	%xmm0, %xmm1
               	jb	<addr>
               	movl	$0x3, %eax
               	retq
               	ucomisd	%xmm1, %xmm0
               	jb	<addr>
               	movl	$0x4, %eax
               	retq
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x5, %eax
               	retq
               	ucomisd	%xmm0, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x6, %eax
               	retq
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	ucomisd	%xmm0, %xmm0
               	jp	<addr>
               	je	<addr>
               	ucomisd	%xmm1, %xmm0
               	jbe	<addr>
               	movl	$0x9, %eax
               	retq
               	ucomisd	%xmm0, %xmm1
               	jbe	<addr>
               	movl	$0xa, %eax
               	retq
               	ucomisd	%xmm1, %xmm0
               	jb	<addr>
               	movl	$0xb, %eax
               	retq
               	ucomisd	%xmm0, %xmm1
               	jb	<addr>
               	movl	$0xc, %eax
               	retq
               	ucomisd	%xmm0, %xmm1
               	ja	<addr>
               	ucomisd	%xmm1, %xmm0
               	jae	<addr>
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x10, %eax
               	retq
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm1, %xmm15
               	jbe	<addr>
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jbe	<addr>
               	movl	$0x12, %eax
               	retq
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	ucomiss	%xmm2, %xmm3
               	jbe	<addr>
               	movl	$0x14, %eax
               	retq
               	ucomiss	%xmm3, %xmm2
               	jbe	<addr>
               	movl	$0x15, %eax
               	retq
               	ucomiss	%xmm2, %xmm3
               	jb	<addr>
               	movl	$0x16, %eax
               	retq
               	ucomiss	%xmm3, %xmm2
               	jb	<addr>
               	movl	$0x17, %eax
               	retq
               	ucomiss	%xmm2, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movl	$0x18, %eax
               	retq
               	ucomiss	%xmm2, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	ucomiss	%xmm3, %xmm15
               	jbe	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x1a, %eax
               	retq
               	movl	$0x19, %eax
               	retq
               	movl	$0x13, %eax
               	retq
               	movl	$0x11, %eax
               	retq
               	movl	$0xf, %eax
               	retq
               	movl	$0xe, %eax
               	retq
               	movl	$0xd, %eax
               	retq
               	movl	$0x8, %eax
               	retq
               	movl	$0x7, %eax
               	retq
