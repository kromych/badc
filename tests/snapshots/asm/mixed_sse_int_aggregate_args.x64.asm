
mixed_sse_int_aggregate_args.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<take3>:
               	popq	%r10
               	subq	$0x50, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movsd	%xmm0, -0x10(%rbp,%riz)
               	movq	%rdi, -0x8(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movsd	%xmm1, -0x18(%rbp,%riz)
               	movsd	%xmm3, -0x30(%rbp,%riz)
               	movsd	%xmm4, -0x28(%rbp,%riz)
               	movapd	%xmm2, %xmm0
               	leaq	-0x10(%rbp), %rax
               	movsd	(%rax,%riz), %xmm1
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x50, %rsp
               	pushq	%r11
               	retq
               	cmpq	$0x4, %rsi
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x50, %rsp
               	pushq	%r11
               	retq
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0xb, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movsd	0x8(%rax,%riz), %xmm1
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x50, %rsp
               	pushq	%r11
               	retq
               	movabsq	$0x3ff4000000000000, %rax # imm = 0x3FF4000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x50, %rsp
               	pushq	%r11
               	retq
               	leaq	-0x30(%rbp), %rax
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$0x400c000000000000, %rax # imm = 0x400C000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$0x4012000000000000, %rax # imm = 0x4012000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x50, %rsp
               	pushq	%r11
               	retq
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x50, %rsp
               	pushq	%r11
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

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
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	-0x10(%rbp), %rax
               	movabsq	$0x4004000000000000, %rcx # imm = 0x4004000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, (%rax,%riz)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x7, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0xb, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x20(%rbp), %rax
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, 0x8(%rax,%riz)
               	leaq	-0x30(%rbp), %rax
               	movabsq	$0x400c000000000000, %rcx # imm = 0x400C000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, (%rax,%riz)
               	leaq	-0x30(%rbp), %rax
               	movabsq	$0x4012000000000000, %rcx # imm = 0x4012000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, 0x8(%rax,%riz)
               	movl	$0x4, %edi
               	leaq	-0x10(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x30(%rbp), %rcx
               	movabsq	$0x3ff4000000000000, %r8 # imm = 0x3FF4000000000000
               	movq	%r8, %xmm0
               	callq	<addr>
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
