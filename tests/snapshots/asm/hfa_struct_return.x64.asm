
hfa_struct_return.x64:	file format elf64-x86-64

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

<mkd3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rdi, -0x40(%rbp)
               	movq	%rsi, -0x30(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	movsd	-0x30(%rbp,%riz), %xmm0
               	movsd	-0x20(%rbp,%riz), %xmm1
               	movsd	-0x10(%rbp,%riz), %xmm2
               	movq	-0x40(%rbp), %rax
               	movsd	%xmm0, (%rax,%riz)
               	movsd	%xmm1, 0x8(%rax,%riz)
               	movsd	%xmm2, 0x10(%rax,%riz)
               	leave
               	retq

<mkd4>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x40(%rbp)
               	movq	%rdx, -0x30(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	%r8, -0x10(%rbp)
               	movsd	-0x40(%rbp,%riz), %xmm0
               	movsd	-0x30(%rbp,%riz), %xmm1
               	movsd	-0x20(%rbp,%riz), %xmm2
               	movsd	-0x10(%rbp,%riz), %xmm3
               	movq	-0x50(%rbp), %rax
               	movsd	%xmm0, (%rax,%riz)
               	movsd	%xmm1, 0x8(%rax,%riz)
               	movsd	%xmm2, 0x10(%rax,%riz)
               	movsd	%xmm3, 0x18(%rax,%riz)
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movabsq	$0x401c000000000000, %rax # imm = 0x401C000000000000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movabsq	$0x3fd0000000000000, %rbx # imm = 0x3FD0000000000000
               	movabsq	$0x3fe0000000000000, %r12 # imm = 0x3FE0000000000000
               	movq	%rbx, %xmm14
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%r12, %xmm14
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm14
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
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	movabsq	$0x3ff0000000000000, %r13 # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%r13, %rsi
               	callq	<addr>
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x50(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	popq	%rdx
               	movsd	(%rax,%riz), %xmm0
               	movq	%r13, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movsd	0x10(%rax,%riz), %xmm0
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x20(%rbp), %rdi
               	movabsq	$0x4024000000000000, %r13 # imm = 0x4024000000000000
               	movabsq	$0x4034000000000000, %rdx # imm = 0x4034000000000000
               	movabsq	$0x403e000000000000, %rcx # imm = 0x403E000000000000
               	movabsq	$0x4044000000000000, %r8 # imm = 0x4044000000000000
               	movq	%r13, %rsi
               	callq	<addr>
               	leaq	-0x20(%rbp), %rcx
               	leaq	-0x58(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	popq	%rdx
               	movsd	(%rax,%riz), %xmm0
               	movq	%r13, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$0x4034000000000000, %rcx # imm = 0x4034000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movsd	0x10(%rax,%riz), %xmm0
               	movabsq	$0x403e000000000000, %rax # imm = 0x403E000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x58(%rbp), %rax
               	movsd	0x18(%rax,%riz), %xmm0
               	movabsq	$0x4044000000000000, %rcx # imm = 0x4044000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x3fc00000, %ecx       # imm = 0x3FC00000
               	movl	$0x40200000, %edx       # imm = 0x40200000
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%rdx, %xmm14
               	movq	%rdx, %xmm15
               	ucomiss	%xmm15, %xmm14
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x68(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movq	%r12, %xmm15
               	movq	%rbx, %xmm0
               	addsd	%xmm15, %xmm0
               	movabsq	$0x3fe8000000000000, %rdx # imm = 0x3FE8000000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movsd	(%rax,%riz), %xmm0
               	movsd	0x8(%rax,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	0x10(%rax,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	0x18(%rax,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movabsq	$0x4059000000000000, %rax # imm = 0x4059000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movss	(%rcx,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movl	$0x41200000, %eax       # imm = 0x41200000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
