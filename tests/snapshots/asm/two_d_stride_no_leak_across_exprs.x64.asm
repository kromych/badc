
two_d_stride_no_leak_across_exprs.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sum_one>:
               	movzwq	(%rdi), %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x520, %rsp            # imm = 0x520
               	leaq	-0x400(%rbp), %rax
               	movl	$0x7, %ecx
               	movw	%cx, (%rax)
               	leaq	-0x400(%rbp), %rax
               	movl	$0xb, %ecx
               	movw	%cx, 0x2(%rax)
               	leaq	-0x400(%rbp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x520, %rsp            # imm = 0x520
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x40, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	leaq	-0x508(%rbp), %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rax
               	cvtsi2sd	%rdx, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movabsq	$0x3fd0000000000000, %rdx # imm = 0x3FD0000000000000
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rdx, %xmm15
               	mulsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	jmp	<addr>
               	leaq	-0x508(%rbp), %rax
               	addq	$0x20, %rax
               	movss	(%rax,%riz), %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
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
               	movl	$0x2, %eax
               	addq	$0x520, %rsp            # imm = 0x520
               	popq	%rbp
               	retq
               	leaq	-0x400(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x508(%rbp), %rax
               	movabsq	$0x4058c00000000000, %rcx # imm = 0x4058C00000000000
               	movq	%rcx, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	leaq	-0x508(%rbp), %rax
               	movss	(%rax,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x520, %rsp            # imm = 0x520
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x520, %rsp            # imm = 0x520
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
