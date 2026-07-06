
variadic_agg_return_classes.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<mkp>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	movq	%rdi, -0xc0(%rbp)
               	movq	%rsi, -0xb8(%rbp)
               	movq	%rdx, -0xb0(%rbp)
               	movq	%rcx, -0xa8(%rbp)
               	movq	%r8, -0xa0(%rbp)
               	movq	%r9, -0x98(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movsd	%xmm0, -0x90(%rbp,%riz)
               	movsd	%xmm1, -0x80(%rbp,%riz)
               	movsd	%xmm2, -0x70(%rbp,%riz)
               	movsd	%xmm3, -0x60(%rbp,%riz)
               	movsd	%xmm4, -0x50(%rbp,%riz)
               	movsd	%xmm5, -0x40(%rbp,%riz)
               	movsd	%xmm6, -0x30(%rbp,%riz)
               	movsd	%xmm7, -0x20(%rbp,%riz)
               	leaq	-0x10(%rbp), %rax
               	movabsq	$0x3ff8000000000000, %rcx # imm = 0x3FF8000000000000
               	movslq	-0xc0(%rbp), %rdx
               	cvtsi2sd	%rdx, %xmm0
               	movapd	%xmm0, %xmm15
               	movq	%rcx, %xmm0
               	mulsd	%xmm15, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	leaq	-0x10(%rbp), %rax
               	movabsq	$0x4002000000000000, %rcx # imm = 0x4002000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, 0x8(%rax,%riz)
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	movsd	(%rcx,%riz), %xmm0
               	movsd	0x8(%rcx,%riz), %xmm1
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq

<mkm>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	movq	%rdi, -0xc0(%rbp)
               	movq	%rsi, -0xb8(%rbp)
               	movq	%rdx, -0xb0(%rbp)
               	movq	%rcx, -0xa8(%rbp)
               	movq	%r8, -0xa0(%rbp)
               	movq	%r9, -0x98(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movsd	%xmm0, -0x90(%rbp,%riz)
               	movsd	%xmm1, -0x80(%rbp,%riz)
               	movsd	%xmm2, -0x70(%rbp,%riz)
               	movsd	%xmm3, -0x60(%rbp,%riz)
               	movsd	%xmm4, -0x50(%rbp,%riz)
               	movsd	%xmm5, -0x40(%rbp,%riz)
               	movsd	%xmm6, -0x30(%rbp,%riz)
               	movsd	%xmm7, -0x20(%rbp,%riz)
               	leaq	-0x10(%rbp), %rax
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, (%rax,%riz)
               	leaq	-0x10(%rbp), %rax
               	movslq	-0xc0(%rbp), %rcx
               	addq	$0x29, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	movsd	(%rcx,%riz), %xmm0
               	movq	0x8(%rcx), %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movl	$0x2, %edi
               	movb	$0x0, %al
               	callq	<addr>
               	movsd	%xmm0, -0x58(%rbp,%riz)
               	movsd	%xmm1, -0x50(%rbp,%riz)
               	leaq	-0x58(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x10(%rbp), %rax
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$0x4002000000000000, %rax # imm = 0x4002000000000000
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
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movb	$0x0, %al
               	callq	<addr>
               	movsd	%xmm0, -0x70(%rbp,%riz)
               	movq	%rax, -0x68(%rbp)
               	leaq	-0x70(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x30(%rbp), %rax
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x2a, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
