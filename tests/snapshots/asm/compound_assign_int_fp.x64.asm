
compound_assign_int_fp.x64:	file format elf64-x86-64

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
               	movl	$0xa, %eax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x400f333333333333, %rcx # imm = 0x400F333333333333
               	movq	%rcx, %xmm15
               	movapd	%xmm0, %xmm1
               	addsd	%xmm15, %xmm1
               	cvttsd2si	%xmm1, %rcx
               	cmpq	$0xd, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4004000000000000, %rcx # imm = 0x4004000000000000
               	movq	%rcx, %xmm15
               	movapd	%xmm0, %xmm1
               	subsd	%xmm15, %xmm1
               	cvttsd2si	%xmm1, %rdx
               	cmpq	$0x7, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %xmm15
               	mulsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rcx
               	cmpq	$0x19, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %ecx
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rcx, %xmm0
               	movabsq	$0x4008000000000000, %rdx # imm = 0x4008000000000000
               	movq	%rdx, %xmm15
               	movapd	%xmm0, %xmm1
               	divsd	%xmm15, %xmm1
               	cvttsd2si	%xmm1, %rsi
               	cmpq	$0x21, %rsi
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %esi
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rsi, %xmm1
               	movl	$0x4039999a, %edi       # imm = 0x4039999A
               	movq	%rdi, %xmm14
               	cvtss2sd	%xmm14, %xmm2
               	addsd	%xmm2, %xmm1
               	cvttsd2si	%xmm1, %rdi
               	cmpl	$0x9, %edi
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0xa, %rdi
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rdi, %xmm1
               	movabsq	$0x40592ccccccccccd, %rdi # imm = 0x40592CCCCCCCCCCD
               	movq	%rdi, %xmm15
               	addsd	%xmm15, %xmm1
               	cvttsd2si	%xmm1, %rdi
               	cmpq	$0x5a, %rdi
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %edi
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rdi, %xmm1
               	movabsq	$0x400c000000000000, %rdi # imm = 0x400C000000000000
               	movq	%rdi, %xmm15
               	mulsd	%xmm15, %xmm1
               	cvttsd2si	%xmm1, %rdi
               	cmpq	$0x11, %rdi
               	je	<addr>
               	movq	%rsi, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x40494ccccccccccd, %rsi # imm = 0x40494CCCCCCCCCCD
               	movq	%rsi, %xmm15
               	movapd	%xmm0, %xmm1
               	addsd	%xmm15, %xmm1
               	cvttsd2si	%xmm1, %rsi
               	movswq	%si, %rsi
               	cmpl	$0x96, %esi
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x10(%rbp,%riz)
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movsd	-0x10(%rbp,%riz), %xmm1
               	movapd	%xmm1, %xmm15
               	movq	%rcx, %xmm1
               	divsd	%xmm15, %xmm1
               	addsd	%xmm1, %xmm0
               	cvttsd2si	%xmm0, %rcx
               	cmpq	$0x64, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ff8000000000000, %rcx # imm = 0x3FF8000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x10(%rbp,%riz)
               	movl	$0x3, %ecx
               	movsd	-0x10(%rbp,%riz), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rcx, %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x10(%rbp,%riz)
               	movsd	-0x10(%rbp,%riz), %xmm0
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rcx, %xmm15
               	mulsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x10(%rbp,%riz)
               	movsd	-0x10(%rbp,%riz), %xmm0
               	movabsq	$0x4022000000000000, %rcx # imm = 0x4022000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
