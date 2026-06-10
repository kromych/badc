
two_d_stride_no_leak_across_exprs.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x270, %esi            # imm = 0x270
               	callq	<addr>
               	ud2

<__c5_lazy_stream>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	(%r12,%rbx,8), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax,%rbx,8), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, (%r12,%rbx,8)
               	jmp	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

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
               	jmp	<addr>
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
               	cmpq	$0x0, %rax
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
               	cmpq	$0x0, %rax
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
               	addb	%al, 0x41(%rdx)
