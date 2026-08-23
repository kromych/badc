
ssa_fp_routing.x64:	file format elf64-x86-64

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
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movabsq	$0x4002000000000000, %rcx # imm = 0x4002000000000000
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	addsd	%xmm15, %xmm0
               	movabsq	$0x400e000000000000, %rcx # imm = 0x400E000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movabsq	$0x4014000000000000, %rdx # imm = 0x4014000000000000
               	movq	%rax, %xmm15
               	movq	%rdx, %xmm0
               	subsd	%xmm15, %xmm0
               	movabsq	$0x400c000000000000, %rax # imm = 0x400C000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movabsq	$0x4010000000000000, %rdx # imm = 0x4010000000000000
               	movq	%rdx, %xmm15
               	movq	%rax, %xmm0
               	mulsd	%xmm15, %xmm0
               	movabsq	$0x4024000000000000, %rsi # imm = 0x4024000000000000
               	movq	%rsi, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movabsq	$0x402e000000000000, %rsi # imm = 0x402E000000000000
               	movq	%rdx, %xmm15
               	movq	%rsi, %xmm0
               	divsd	%xmm15, %xmm0
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	%rax, %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	ucomisd	%xmm0, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movabsq	$0x401c000000000000, %rax # imm = 0x401C000000000000
               	movq	%rax, %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%dl
               	movzbq	%dl, %rdx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movl	$0x9, %eax
               	retq
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm14, %xmm15
               	ja	<addr>
               	movl	$0xb, %eax
               	retq
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	ja	<addr>
               	movl	$0xd, %eax
               	retq
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%dl
               	movzbq	%dl, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm14, %xmm15
               	jae	<addr>
               	movl	$0xf, %eax
               	retq
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm14, %xmm15
               	jae	<addr>
               	movl	$0x10, %eax
               	retq
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setbe	%dl
               	movzbq	%dl, %rdx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jae	<addr>
               	movl	$0x12, %eax
               	retq
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jae	<addr>
               	movl	$0x13, %eax
               	retq
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setae	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x14, %eax
               	retq
               	movl	$0x2a, %ecx
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rcx, %xmm0
               	movabsq	$0x4045000000000000, %rcx # imm = 0x4045000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	movabsq	$-0x3, %rcx
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rcx, %xmm0
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	movabsq	$0x400e000000000000, %rcx # imm = 0x400E000000000000
               	movq	%rcx, %xmm14
               	cvttsd2si	%xmm14, %rdx
               	cmpl	$0x3, %edx
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	movq	%rcx, %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rcx
               	cmpl	$-0x3, %ecx
               	je	<addr>
               	movl	$0x18, %eax
               	retq
               	movabsq	$0x3fb999999999999a, %rcx # imm = 0x3FB999999999999A
               	movq	%rcx, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x19, %eax
               	retq
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1a, %eax
               	retq
               	xorq	%rax, %rax
               	retq
