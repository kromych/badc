
leading_dot_float_literal.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	movq	%r13, (%rsp)
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	movabsq	$0x3fd0000000000000, %rcx # imm = 0x3FD0000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x10(%rbp,%riz)
               	movabsq	$0x4039000000000000, %rcx # imm = 0x4039000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x18(%rbp,%riz)
               	movl	$0x1, %edx
               	cvtss2sd	%xmm0, %xmm1
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rdx, %rdx
               	movsd	-0x10(%rbp,%riz), %xmm1
               	movabsq	$0x3fd0000000000000, %rax # imm = 0x3FD0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rdx, %rdx
               	movsd	-0x18(%rbp,%riz), %xmm1
               	movabsq	$0x4039000000000000, %rax # imm = 0x4039000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rdx, %rdx
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rdx, %rdx
               	movslq	%edx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %ecx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
