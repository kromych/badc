
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

<mkd1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movsd	%xmm0, (%rax,%riz)
               	movq	%rax, %rcx
               	movsd	(%rcx,%riz), %xmm0
               	leave
               	retq

<mkd2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	movsd	%xmm0, (%rax,%riz)
               	movsd	%xmm1, 0x8(%rax,%riz)
               	movq	%rax, %rcx
               	movsd	(%rcx,%riz), %xmm0
               	movsd	0x8(%rcx,%riz), %xmm1
               	leave
               	retq

<mkd3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rdi, -0x60(%rbp)
               	movq	%rsi, -0x50(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	leaq	-0x18(%rbp), %rax
               	movsd	-0x50(%rbp,%riz), %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movsd	-0x40(%rbp,%riz), %xmm0
               	movsd	%xmm0, 0x8(%rax,%riz)
               	movsd	-0x30(%rbp,%riz), %xmm0
               	movsd	%xmm0, 0x10(%rax,%riz)
               	movq	-0x60(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	leave
               	retq

<mkd4>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rdi, -0x70(%rbp)
               	movq	%rsi, -0x60(%rbp)
               	movq	%rdx, -0x50(%rbp)
               	movq	%rcx, -0x40(%rbp)
               	movq	%r8, -0x30(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movsd	-0x60(%rbp,%riz), %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movsd	-0x50(%rbp,%riz), %xmm0
               	movsd	%xmm0, 0x8(%rax,%riz)
               	movsd	-0x40(%rbp,%riz), %xmm0
               	movsd	%xmm0, 0x10(%rax,%riz)
               	movsd	-0x30(%rbp,%riz), %xmm0
               	movsd	%xmm0, 0x18(%rax,%riz)
               	movq	-0x70(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	movq	0x18(%rax), %rdx
               	movq	%rdx, 0x18(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	leave
               	retq

<mkf2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	movss	%xmm1, 0x4(%rax,%riz)
               	movq	%rax, %rcx
               	movsd	(%rcx,%riz), %xmm0
               	leave
               	retq

<sumd2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movsd	%xmm0, -0x10(%rbp,%riz)
               	movsd	%xmm1, -0x8(%rbp,%riz)
               	leaq	-0x10(%rbp), %rax
               	movsd	(%rax,%riz), %xmm0
               	movsd	0x8(%rax,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	leave
               	retq

<sumd4>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movsd	(%rax,%riz), %xmm0
               	movsd	0x8(%rax,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	0x10(%rax,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	0x18(%rax,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	leave
               	retq

<sumf4>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movsd	%xmm0, -0x10(%rbp,%riz)
               	movsd	%xmm1, -0x8(%rbp,%riz)
               	leaq	-0x10(%rbp), %rax
               	movss	(%rax,%riz), %xmm0
               	movss	0x4(%rax,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0x8(%rax,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0xc(%rax,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
               	movabsq	$0x401c000000000000, %rbx # imm = 0x401C000000000000
               	movq	%rbx, %xmm0
               	callq	<addr>
               	movsd	%xmm0, -0x40(%rbp,%riz)
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x60(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	movsd	(%rax,%riz), %xmm0
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movabsq	$0x3fd0000000000000, %rbx # imm = 0x3FD0000000000000
               	movabsq	$0x3fe0000000000000, %rsi # imm = 0x3FE0000000000000
               	movq	%rbx, %xmm0
               	movq	%rsi, %xmm1
               	callq	<addr>
               	movsd	%xmm0, -0x48(%rbp,%riz)
               	movsd	%xmm1, -0x40(%rbp,%riz)
               	leaq	-0x48(%rbp), %rcx
               	leaq	-0x78(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	movsd	(%rax,%riz), %xmm0
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
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
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	movabsq	$0x3ff0000000000000, %rbx # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rbx, %rsi
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
               	movq	%rax, %rcx
               	movsd	(%rax,%riz), %xmm0
               	movq	%rbx, %xmm15
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
               	leave
               	retq
               	leaq	-0x20(%rbp), %rdi
               	movabsq	$0x4024000000000000, %rbx # imm = 0x4024000000000000
               	movabsq	$0x4034000000000000, %rdx # imm = 0x4034000000000000
               	movabsq	$0x403e000000000000, %rcx # imm = 0x403E000000000000
               	movabsq	$0x4044000000000000, %r8 # imm = 0x4044000000000000
               	movq	%rbx, %rsi
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
               	movq	%rax, %rcx
               	movsd	(%rax,%riz), %xmm0
               	movq	%rbx, %xmm15
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
               	movabsq	$0x403e000000000000, %rcx # imm = 0x403E000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movsd	0x18(%rax,%riz), %xmm0
               	movabsq	$0x4044000000000000, %rax # imm = 0x4044000000000000
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
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x3fc00000, %ebx       # imm = 0x3FC00000
               	movl	$0x40200000, %esi       # imm = 0x40200000
               	movq	%rbx, %xmm0
               	movq	%rsi, %xmm1
               	callq	<addr>
               	movsd	%xmm0, -0x60(%rbp,%riz)
               	leaq	-0x60(%rbp), %rcx
               	leaq	-0x80(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	movss	(%rax,%riz), %xmm0
               	movq	%rbx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x4(%rax,%riz), %xmm0
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x68(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x78(%rbp), %rdi
               	movq	%rdi, %r10
               	movsd	(%r10,%riz), %xmm0
               	movsd	0x8(%r10,%riz), %xmm1
               	callq	<addr>
               	movabsq	$0x3fe8000000000000, %rax # imm = 0x3FE8000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x58(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%rdi, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movabsq	$0x4059000000000000, %rax # imm = 0x4059000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x68(%rbp), %rdi
               	movq	%rdi, %r10
               	movsd	(%r10,%riz), %xmm0
               	movsd	0x8(%r10,%riz), %xmm1
               	callq	<addr>
               	movl	$0x41200000, %eax       # imm = 0x41200000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
