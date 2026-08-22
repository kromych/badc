
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorq	%rax, %rax
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x10(%rbp,%riz)
               	movsd	-0x10(%rbp,%riz), %xmm1
               	movapd	%xmm1, %xmm0
               	divsd	%xmm1, %xmm0
               	movabsq	$0x4014000000000000, %rax # imm = 0x4014000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x10(%rbp,%riz)
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movapd	%xmm1, %xmm15
               	movq	%rax, %xmm1
               	divsd	%xmm15, %xmm1
               	ucomisd	%xmm0, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movsd	-0x10(%rbp,%riz), %xmm2
               	ucomisd	%xmm2, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movsd	-0x10(%rbp,%riz), %xmm2
               	ucomisd	%xmm0, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movl	$0x3, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	ucomisd	%xmm0, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0xa, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movsd	-0x10(%rbp,%riz), %xmm2
               	ucomisd	%xmm2, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0xb, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movsd	-0x10(%rbp,%riz), %xmm2
               	ucomisd	%xmm0, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movl	$0xc, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0xd, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movsd	-0x10(%rbp,%riz), %xmm2
               	ucomisd	%xmm0, %xmm2
               	jbe	<addr>
               	movl	$0x14, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movsd	-0x10(%rbp,%riz), %xmm2
               	ucomisd	%xmm2, %xmm0
               	jbe	<addr>
               	movl	$0x15, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movsd	-0x10(%rbp,%riz), %xmm2
               	ucomisd	%xmm0, %xmm2
               	jb	<addr>
               	movl	$0x16, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movsd	-0x10(%rbp,%riz), %xmm2
               	ucomisd	%xmm2, %xmm0
               	jb	<addr>
               	movl	$0x17, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movsd	-0x10(%rbp,%riz), %xmm2
               	ucomisd	%xmm2, %xmm0
               	jbe	<addr>
               	movl	$0x18, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movsd	-0x10(%rbp,%riz), %xmm2
               	ucomisd	%xmm0, %xmm2
               	jbe	<addr>
               	movl	$0x19, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movsd	-0x10(%rbp,%riz), %xmm2
               	ucomisd	%xmm2, %xmm0
               	jb	<addr>
               	movl	$0x1a, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movsd	-0x10(%rbp,%riz), %xmm2
               	ucomisd	%xmm0, %xmm2
               	jb	<addr>
               	movl	$0x1b, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	ucomisd	%xmm0, %xmm0
               	jbe	<addr>
               	movl	$0x1c, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	ucomisd	%xmm0, %xmm0
               	jb	<addr>
               	movl	$0x1d, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	ucomisd	%xmm0, %xmm0
               	jb	<addr>
               	movl	$0x1e, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movsd	-0x10(%rbp,%riz), %xmm0
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	ja	<addr>
               	movl	$0x28, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movsd	-0x10(%rbp,%riz), %xmm0
               	movabsq	$0x4014000000000000, %rax # imm = 0x4014000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x29, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movsd	-0x10(%rbp,%riz), %xmm0
               	ucomisd	%xmm0, %xmm1
               	ja	<addr>
               	movl	$0x2a, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x7e37e43c8800759c, %rax # imm = 0x7E37E43C8800759C
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	ja	<addr>
               	movl	$0x2b, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	ucomisd	%xmm1, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x2c, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
