
compound_assign_int_fp.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movl	$0xa, %eax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x400f333333333333, %rax # imm = 0x400F333333333333
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rax
               	cmpq	$0xd, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	subsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rax
               	cmpq	$0x19, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %eax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rax
               	cmpq	$0x21, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movl	$0x4039999a, %eax       # imm = 0x4039999A
               	movq	%rax, %xmm14
               	cvtss2sd	%xmm14, %xmm1
               	addsd	%xmm1, %xmm0
               	cvttsd2si	%xmm0, %rax
               	movslq	%eax, %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0xa, %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x40592ccccccccccd, %rax # imm = 0x40592CCCCCCCCCCD
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rax
               	cmpq	$0x5a, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x400c000000000000, %rax # imm = 0x400C000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rax
               	cmpq	$0x11, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %eax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x40494ccccccccccd, %rax # imm = 0x40494CCCCCCCCCCD
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rax
               	movswq	%ax, %rax
               	cmpq	$0x96, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %eax
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x50(%rbp,%riz)
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movsd	-0x50(%rbp,%riz), %xmm1
               	movapd	%xmm1, %xmm15
               	movq	%rax, %xmm1
               	divsd	%xmm15, %xmm1
               	addsd	%xmm1, %xmm0
               	cvttsd2si	%xmm0, %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x60(%rbp,%riz)
               	movl	$0x3, %eax
               	movsd	-0x60(%rbp,%riz), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x60(%rbp,%riz)
               	movsd	-0x60(%rbp,%riz), %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x60(%rbp,%riz)
               	movsd	-0x60(%rbp,%riz), %xmm0
               	movabsq	$0x4022000000000000, %rax # imm = 0x4022000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
