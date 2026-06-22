
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
               	subq	$0x80, %rsp
               	movq	%r13, (%rsp)
               	movl	$0xa, %eax
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x400f333333333333, %rax # imm = 0x400F333333333333
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rax
               	cmpq	$0xd, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	subsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rax
               	cmpq	$0x19, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %eax
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rax
               	cmpq	$0x21, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x4007333333333333, %rax # imm = 0x4007333333333333
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rax
               	movslq	%eax, %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0xa, %rax
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x40592ccccccccccd, %rax # imm = 0x40592CCCCCCCCCCD
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rax
               	cmpq	$0x5a, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x400c000000000000, %rax # imm = 0x400C000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rax
               	cmpq	$0x11, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %eax
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x40494ccccccccccd, %rax # imm = 0x40494CCCCCCCCCCD
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rax
               	movswq	%ax, %rax
               	cmpq	$0x96, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %eax
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x50(%rbp,%riz)
               	cvtsi2sd	%rax, %xmm0
               	movl	$0x1, %eax
               	cvtsi2sd	%rax, %xmm1
               	movsd	-0x50(%rbp,%riz), %xmm2
               	divsd	%xmm2, %xmm1
               	addsd	%xmm1, %xmm0
               	cvttsd2si	%xmm0, %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x60(%rbp,%riz)
               	movl	$0x3, %eax
               	movsd	-0x60(%rbp,%riz), %xmm0
               	cvtsi2sd	%rax, %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x60(%rbp,%riz)
               	movsd	-0x60(%rbp,%riz), %xmm0
               	movl	$0x2, %eax
               	cvtsi2sd	%rax, %xmm1
               	mulsd	%xmm1, %xmm0
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
               	movq	(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
