
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
               	subq	$0x80, %rsp
               	movq	%r13, (%rsp)
               	movl	$0x1, %edx
               	cvtsi2sd	%rdx, %xmm0
               	movsd	%xmm0, -0x20(%rbp,%riz)
               	jmp	<addr>
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x20(%rbp,%riz)
               	movsd	-0x20(%rbp,%riz), %xmm0
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xb, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x1, %edx
               	cvtsi2sd	%rdx, %xmm0
               	movsd	%xmm0, -0x28(%rbp,%riz)
               	jmp	<addr>
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x28(%rbp,%riz)
               	movsd	-0x28(%rbp,%riz), %xmm0
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xc, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x30(%rbp,%riz)
               	jmp	<addr>
               	movl	$0x2, %edx
               	cvtsi2sd	%rdx, %xmm0
               	movsd	%xmm0, -0x30(%rbp,%riz)
               	movsd	-0x30(%rbp,%riz), %xmm0
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xd, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x38(%rbp,%riz)
               	jmp	<addr>
               	movl	$0x2, %edx
               	cvtsi2sd	%rdx, %xmm0
               	movsd	%xmm0, -0x38(%rbp,%riz)
               	movsd	-0x38(%rbp,%riz), %xmm0
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xe, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x40(%rbp,%riz)
               	jmp	<addr>
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x40(%rbp,%riz)
               	movsd	-0x40(%rbp,%riz), %xmm0
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xf, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x48(%rbp,%riz)
               	jmp	<addr>
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x48(%rbp,%riz)
               	movsd	-0x48(%rbp,%riz), %xmm0
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x10, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x50(%rbp,%riz)
               	jmp	<addr>
               	movl	$0x2, %edx
               	cvtsi2sd	%rdx, %xmm0
               	movsd	%xmm0, -0x50(%rbp,%riz)
               	movsd	-0x50(%rbp,%riz), %xmm0
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x11, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x58(%rbp,%riz)
               	jmp	<addr>
               	movl	$0x2, %edx
               	cvtsi2sd	%rdx, %xmm0
               	movsd	%xmm0, -0x58(%rbp,%riz)
               	movsd	-0x58(%rbp,%riz), %xmm0
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x12, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %edx
               	jmp	<addr>
               	movl	$0x14, %edx
               	cmpq	$0xa, %rdx
               	je	<addr>
               	movl	$0x15, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	movl	$0x2, %ecx
               	cmpq	$0x2, %rcx
               	je	<addr>
               	movl	$0x16, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
