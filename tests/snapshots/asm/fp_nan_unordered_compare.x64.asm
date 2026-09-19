
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
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm15
               	movq	%rcx, %xmm0
               	divsd	%xmm15, %xmm0
               	movabsq	$0x4014000000000000, %rax # imm = 0x4014000000000000
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm15
               	movq	%rdx, %xmm1
               	divsd	%xmm15, %xmm1
               	ucomisd	%xmm0, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	%rax, %xmm14
               	ucomisd	%xmm0, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	%rcx, %xmm15
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
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0xb, %eax
               	retq
               	movq	%rax, %xmm14
               	ucomisd	%xmm0, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movl	$0xc, %eax
               	retq
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0xd, %eax
               	retq
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movl	$0x14, %eax
               	retq
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x15, %eax
               	retq
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jb	<addr>
               	movl	$0x16, %eax
               	retq
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jb	<addr>
               	movl	$0x17, %eax
               	retq
               	movq	%rax, %xmm14
               	ucomisd	%xmm14, %xmm0
               	jbe	<addr>
               	movl	$0x18, %eax
               	retq
               	movq	%rax, %xmm14
               	ucomisd	%xmm0, %xmm14
               	jbe	<addr>
               	movl	$0x19, %eax
               	retq
               	movq	%rax, %xmm14
               	ucomisd	%xmm14, %xmm0
               	jb	<addr>
               	movl	$0x1a, %eax
               	retq
               	movq	%rax, %xmm14
               	ucomisd	%xmm0, %xmm14
               	jb	<addr>
               	movl	$0x1b, %eax
               	retq
               	ucomisd	%xmm0, %xmm0
               	jbe	<addr>
               	movl	$0x1c, %eax
               	retq
               	ucomisd	%xmm0, %xmm0
               	jb	<addr>
               	movl	$0x1d, %eax
               	retq
               	ucomisd	%xmm0, %xmm0
               	jb	<addr>
               	movl	$0x1e, %eax
               	retq
               	movabsq	$0x4018000000000000, %rdx # imm = 0x4018000000000000
               	movq	%rax, %xmm14
               	movq	%rdx, %xmm15
               	ucomisd	%xmm14, %xmm15
               	ja	<addr>
               	movl	$0x28, %eax
               	retq
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x29, %eax
               	retq
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	ja	<addr>
               	movl	$0x2a, %eax
               	retq
               	movabsq	$0x7e37e43c8800759c, %rax # imm = 0x7E37E43C8800759C
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	ja	<addr>
               	movl	$0x2b, %eax
               	retq
               	ucomisd	%xmm1, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x2c, %eax
               	retq
               	movq	%rcx, %rax
               	retq
