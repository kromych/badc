
compound_assign_float_register_resident.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	movl	$0x42c80000, %eax       # imm = 0x42C80000
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x8(%rbp,%riz)
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x10(%rbp,%riz)
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	jmp	<addr>
               	movss	-0x8(%rbp,%riz), %xmm0
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	subss	%xmm15, %xmm0
               	movss	%xmm0, -0x8(%rbp,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	movss	-0x10(%rbp,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x8(%rbp,%riz)
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	cvtss2sd	%xmm1, %xmm0
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, -0x10(%rbp,%riz)
               	jmp	<addr>
               	movss	-0x8(%rbp,%riz), %xmm0
               	movl	$0x42f00000, %eax       # imm = 0x42F00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movss	-0x10(%rbp,%riz), %xmm0
               	movl	$0x41100000, %eax       # imm = 0x41100000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3f000000, %eax       # imm = 0x3F000000
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x20(%rbp,%riz)
               	movss	-0x20(%rbp,%riz), %xmm0
               	movabsq	$-0x4010000000000000, %rcx # imm = 0xBFF0000000000000
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, -0x20(%rbp,%riz)
               	movss	-0x20(%rbp,%riz), %xmm0
               	movq	%rax, %xmm1
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x28(%rbp,%riz)
               	movss	-0x28(%rbp,%riz), %xmm0
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, -0x28(%rbp,%riz)
               	movss	-0x28(%rbp,%riz), %xmm0
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	divss	%xmm15, %xmm0
               	movss	%xmm0, -0x28(%rbp,%riz)
               	movss	-0x28(%rbp,%riz), %xmm0
               	movl	$0x40c00000, %eax       # imm = 0x40C00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
