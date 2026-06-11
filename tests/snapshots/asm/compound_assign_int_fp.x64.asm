
compound_assign_int_fp.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	movl	$0xa, %eax
               	movabsq	$0x400f333333333333, %r13 # imm = 0x400F333333333333
               	addq	%r13, %rax
               	cmpq	$0xd, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	movabsq	$0x4004000000000000, %r13 # imm = 0x4004000000000000
               	subq	%r13, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	movabsq	$0x4004000000000000, %r13 # imm = 0x4004000000000000
               	imulq	%r13, %rax
               	cmpq	$0x19, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %eax
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	pushq	%rdx
               	cqto
               	idivq	%rcx
               	popq	%rdx
               	cmpq	$0x21, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	movabsq	$0x4007333333333333, %r13 # imm = 0x4007333333333333
               	addq	%r13, %rax
               	movslq	%eax, %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0xa, %rax
               	movabsq	$0x40592ccccccccccd, %r13 # imm = 0x40592CCCCCCCCCCD
               	addq	%r13, %rax
               	cmpq	$0x5a, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	movabsq	$0x400c000000000000, %r13 # imm = 0x400C000000000000
               	imulq	%r13, %rax
               	cmpq	$0x11, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %eax
               	movabsq	$0x40494ccccccccccd, %r13 # imm = 0x40494CCCCCCCCCCD
               	addq	%r13, %rax
               	movswq	%ax, %rax
               	cmpq	$0x96, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %eax
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x90(%rbp,%riz)
               	movl	$0x1, %ecx
               	cvtsi2sd	%rcx, %xmm0
               	movsd	-0x90(%rbp,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movq	%xmm0, %r10
               	addq	%r10, %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0xa8(%rbp,%riz)
               	movl	$0x3, %eax
               	movsd	-0xa8(%rbp,%riz), %xmm0
               	cvtsi2sd	%rax, %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm0
               	movl	$0x2, %eax
               	cvtsi2sd	%rax, %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, -0xa8(%rbp,%riz)
               	movsd	-0xa8(%rbp,%riz), %xmm0
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
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
