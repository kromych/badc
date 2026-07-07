
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
               	subq	$0x30, %rsp
               	movl	$0x3f000000, %ecx       # imm = 0x3F000000
               	movq	%rcx, %xmm14
               	movss	%xmm14, -0x8(%rbp,%riz)
               	movabsq	$0x3fd0000000000000, %rax # imm = 0x3FD0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x10(%rbp,%riz)
               	movabsq	$0x4039000000000000, %rax # imm = 0x4039000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x18(%rbp,%riz)
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	movl	$0x1, %eax
               	movss	-0x8(%rbp,%riz), %xmm1
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm1
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rax, %rax
               	movsd	-0x10(%rbp,%riz), %xmm1
               	movabsq	$0x3fd0000000000000, %rcx # imm = 0x3FD0000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm1
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rax, %rax
               	movsd	-0x18(%rbp,%riz), %xmm1
               	movabsq	$0x4039000000000000, %rcx # imm = 0x4039000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm1
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rax, %rax
               	movl	$0x3f000000, %ecx       # imm = 0x3F000000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
