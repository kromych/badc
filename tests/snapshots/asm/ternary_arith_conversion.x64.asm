
ternary_arith_conversion.x64:	file format elf64-x86-64

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
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x20(%rbp,%riz)
               	movsd	-0x20(%rbp,%riz), %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x28(%rbp,%riz)
               	movsd	-0x28(%rbp,%riz), %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x30(%rbp,%riz)
               	movsd	-0x30(%rbp,%riz), %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x38(%rbp,%riz)
               	movsd	-0x38(%rbp,%riz), %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movq	%rax, %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movsd	%xmm0, -0x40(%rbp,%riz)
               	movsd	-0x40(%rbp,%riz), %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x48(%rbp,%riz)
               	movsd	-0x48(%rbp,%riz), %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x50(%rbp,%riz)
               	movss	-0x50(%rbp,%riz), %xmm0
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x58(%rbp,%riz)
               	movss	-0x58(%rbp,%riz), %xmm0
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	movl	$0x2, %eax
               	xorq	%rax, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
