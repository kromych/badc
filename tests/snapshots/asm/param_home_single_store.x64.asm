
param_home_single_store.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<collect>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xa0(%rbp,%riz)
               	movups	%xmm1, -0x90(%rbp,%riz)
               	movups	%xmm2, -0x80(%rbp,%riz)
               	movups	%xmm3, -0x70(%rbp,%riz)
               	movups	%xmm4, -0x60(%rbp,%riz)
               	movups	%xmm5, -0x50(%rbp,%riz)
               	movups	%xmm6, -0x40(%rbp,%riz)
               	movups	%xmm7, -0x30(%rbp,%riz)
               	movslq	-0xd0(%rbp), %rcx
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xd0(%rbp), %rdx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	xorl	%eax, %eax
               	movslq	-0xd0(%rbp), %rdx
               	cmpl	%edx, %eax
               	jge	<addr>
               	leaq	-0x18(%rbp), %rdx
               	movq	%rdx, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rdx
               	movq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	movslq	-0xd0(%rbp), %rdx
               	cmpl	%edx, %eax
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	movq	%rcx, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movl	$0x3f000000, %ecx       # imm = 0x3F000000
               	movabsq	$0x4011000000000000, %rdx # imm = 0x4011000000000000
               	movl	$0x1, %esi
               	movl	$0x3, %edi
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rsi, %xmm0
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	movq	%rcx, %xmm14
               	cvtss2sd	%xmm14, %xmm1
               	addsd	%xmm1, %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rdi, %xmm1
               	addsd	%xmm1, %xmm0
               	movq	%rdx, %xmm15
               	addsd	%xmm15, %xmm0
               	movabsq	$0x4026800000000000, %rax # imm = 0x4026800000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x29, %eax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	cmpq	$0x2a, %rcx
               	je	<addr>
               	movq	%rdi, %rax
               	leave
               	retq
               	movl	$0xa, %esi
               	movl	$0x14, %edx
               	movl	$0x1e, %ecx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0x3f, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
