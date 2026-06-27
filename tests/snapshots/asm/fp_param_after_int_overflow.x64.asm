
fp_param_after_int_overflow.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<tail_double>:
               	popq	%r10
               	subq	$0xa0, %rsp
               	movq	0xa0(%rsp), %rax
               	movq	%rax, 0x60(%rsp)
               	movq	0xa8(%rsp), %rax
               	movq	%rax, 0x70(%rsp)
               	movq	0xb0(%rsp), %rax
               	movq	%rax, 0x80(%rsp)
               	movq	0xb8(%rsp), %rax
               	movq	%rax, 0x90(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movslq	0x70(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	0x80(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	0x90(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cvtsi2sd	%rax, %xmm0
               	movsd	0xa0(%rbp,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	popq	%rbp
               	popq	%r11
               	addq	$0xa0, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	movl	$0x7, %eax
               	movl	$0x8, %ebx
               	movl	$0x9, %r12d
               	movabsq	$0x3fe0000000000000, %r13 # imm = 0x3FE0000000000000
               	subq	$0x20, %rsp
               	movq	%rax, (%rsp)
               	movq	%rbx, 0x8(%rsp)
               	movq	%r12, 0x10(%rsp)
               	movq	%r13, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movabsq	$0x4046c00000000000, %rax # imm = 0x4046C00000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %edi
               	movl	$0x14, %esi
               	movl	$0x1e, %edx
               	movl	$0x28, %ecx
               	movl	$0x32, %r8d
               	movl	$0x3c, %r9d
               	movl	$0x46, %eax
               	movl	$0x50, %ebx
               	movl	$0x5a, %r12d
               	movabsq	$0x3fd0000000000000, %r13 # imm = 0x3FD0000000000000
               	subq	$0x20, %rsp
               	movq	%rax, (%rsp)
               	movq	%rbx, 0x8(%rsp)
               	movq	%r12, 0x10(%rsp)
               	movq	%r13, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movabsq	$0x407c240000000000, %rax # imm = 0x407C240000000000
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
