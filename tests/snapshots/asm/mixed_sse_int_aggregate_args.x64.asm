
mixed_sse_int_aggregate_args.x64:	file format elf64-x86-64

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

<take3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movsd	%xmm0, -0x30(%rbp,%riz)
               	movq	%rdi, -0x28(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movsd	%xmm1, -0x18(%rbp,%riz)
               	movsd	%xmm3, -0x10(%rbp,%riz)
               	movsd	%xmm4, -0x8(%rbp,%riz)
               	movapd	%xmm2, %xmm0
               	leaq	-0x30(%rbp), %rax
               	movsd	(%rax,%riz), %xmm1
               	movabsq	$0x4004000000000000, %rcx # imm = 0x4004000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	cmpq	$0x4, %rsi
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rcx
               	cmpq	$0xb, %rcx
               	jne	<addr>
               	movsd	0x8(%rax,%riz), %xmm1
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movabsq	$0x3ff4000000000000, %rax # imm = 0x3FF4000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$0x400c000000000000, %rcx # imm = 0x400C000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$0x4012000000000000, %rax # imm = 0x4012000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq

<docall>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movapd	%xmm0, %xmm2
               	movq	%rcx, %r10
               	movsd	(%r10,%riz), %xmm3
               	movsd	0x8(%r10,%riz), %xmm4
               	xchgq	%rsi, %rdi
               	movsd	(%rdi,%riz), %xmm0
               	movq	0x8(%rdi), %rdi
               	movsd	0x8(%rdx,%riz), %xmm1
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x30(%rbp), %rdi
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, (%rdi,%riz)
               	movl	$0x7, %eax
               	movq	%rax, 0x8(%rdi)
               	leaq	-0x20(%rbp), %rdx
               	movl	$0xb, %eax
               	movq	%rax, (%rdx)
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0x8(%rdx,%riz)
               	leaq	-0x10(%rbp), %r8
               	movabsq	$0x400c000000000000, %rax # imm = 0x400C000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, (%r8,%riz)
               	movabsq	$0x4012000000000000, %rax # imm = 0x4012000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0x8(%r8,%riz)
               	movl	$0x4, %esi
               	movabsq	$0x3ff4000000000000, %rcx # imm = 0x3FF4000000000000
               	movq	%rcx, %xmm2
               	movq	%r8, %r10
               	movsd	(%r10,%riz), %xmm3
               	movsd	0x8(%r10,%riz), %xmm4
               	movsd	(%rdi,%riz), %xmm0
               	movq	0x8(%rdi), %rdi
               	movsd	0x8(%rdx,%riz), %xmm1
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movslq	%eax, %rax
               	leave
               	retq
