
hfa_struct_return.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<mkd1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%r13, (%rsp)
               	leaq	-0x8(%rbp), %rax
               	movsd	%xmm0, (%rax,%riz)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movsd	(%rcx,%riz), %xmm0
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<mkd2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%r13, (%rsp)
               	leaq	-0x10(%rbp), %rax
               	movsd	%xmm0, (%rax,%riz)
               	leaq	-0x10(%rbp), %rax
               	addq	$0x8, %rax
               	movsd	%xmm1, (%rax,%riz)
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movsd	(%rcx,%riz), %xmm0
               	movsd	0x8(%rcx,%riz), %xmm1
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<mkd3>:
               	popq	%r10
               	subq	$0x40, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	movq	%rdx, 0x20(%rsp)
               	movq	%rcx, 0x30(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%r13, (%rsp)
               	leaq	-0x18(%rbp), %rax
               	movsd	0x20(%rbp,%riz), %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	movsd	0x30(%rbp,%riz), %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x10, %rax
               	movsd	0x40(%rbp,%riz), %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movq	0x10(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%rcx), %r11
               	movq	%r11, 0x10(%rax)
               	popq	%r11
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq

<mkd4>:
               	popq	%r10
               	subq	$0x50, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	movq	%rdx, 0x20(%rsp)
               	movq	%rcx, 0x30(%rsp)
               	movq	%r8, 0x40(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%r13, (%rsp)
               	leaq	-0x20(%rbp), %rax
               	movsd	0x20(%rbp,%riz), %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	leaq	-0x20(%rbp), %rax
               	addq	$0x8, %rax
               	movsd	0x30(%rbp,%riz), %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	leaq	-0x20(%rbp), %rax
               	addq	$0x10, %rax
               	movsd	0x40(%rbp,%riz), %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	leaq	-0x20(%rbp), %rax
               	addq	$0x18, %rax
               	movsd	0x50(%rbp,%riz), %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movq	0x10(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%rcx), %r11
               	movq	%r11, 0x10(%rax)
               	movq	0x18(%rcx), %r11
               	movq	%r11, 0x18(%rax)
               	popq	%r11
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x50, %rsp
               	pushq	%r11
               	retq

<mkf2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%r13, (%rsp)
               	leaq	-0x18(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x4, %rax
               	movss	%xmm1, (%rax,%riz)
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movsd	(%rcx,%riz), %xmm0
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<sumd2>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%r13, (%rsp)
               	leaq	-0x10(%rbp), %rax
               	movq	0x10(%rbp), %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	popq	%r11
               	leaq	-0x10(%rbp), %rax
               	movsd	(%rax,%riz), %xmm0
               	leaq	-0x10(%rbp), %rax
               	addq	$0x8, %rax
               	movsd	(%rax,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movq	(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<sumd4>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%r13, (%rsp)
               	leaq	-0x20(%rbp), %rax
               	movq	0x10(%rbp), %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%rcx), %r11
               	movq	%r11, 0x10(%rax)
               	movq	0x18(%rcx), %r11
               	movq	%r11, 0x18(%rax)
               	popq	%r11
               	leaq	-0x20(%rbp), %rax
               	movsd	(%rax,%riz), %xmm0
               	leaq	-0x20(%rbp), %rax
               	addq	$0x8, %rax
               	movsd	(%rax,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	leaq	-0x20(%rbp), %rax
               	addq	$0x10, %rax
               	movsd	(%rax,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	leaq	-0x20(%rbp), %rax
               	addq	$0x18, %rax
               	movsd	(%rax,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movq	(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<sumf4>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%r13, (%rsp)
               	leaq	-0x10(%rbp), %rax
               	movq	0x10(%rbp), %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	popq	%r11
               	leaq	-0x10(%rbp), %rax
               	movss	(%rax,%riz), %xmm0
               	leaq	-0x10(%rbp), %rax
               	addq	$0x4, %rax
               	movss	(%rax,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	leaq	-0x10(%rbp), %rax
               	addq	$0x8, %rax
               	movss	(%rax,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	leaq	-0x10(%rbp), %rax
               	addq	$0xc, %rax
               	movss	(%rax,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movq	(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x190, %rsp            # imm = 0x190
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movabsq	$0x401c000000000000, %rbx # imm = 0x401C000000000000
               	movq	%rbx, %xmm0
               	callq	<addr>
               	movsd	%xmm0, -0xd0(%rbp,%riz)
               	leaq	-0xd0(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rcx)
               	popq	%r11
               	movq	%rcx, %rax
               	leaq	-0x8(%rbp), %rax
               	movsd	(%rax,%riz), %xmm0
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x190, %rsp            # imm = 0x190
               	popq	%rbp
               	retq
               	movabsq	$0x3fd0000000000000, %rbx # imm = 0x3FD0000000000000
               	movabsq	$0x3fe0000000000000, %rsi # imm = 0x3FE0000000000000
               	movq	%rbx, %xmm0
               	movq	%rsi, %xmm1
               	callq	<addr>
               	movsd	%xmm0, -0xe0(%rbp,%riz)
               	movsd	%xmm1, -0xd8(%rbp,%riz)
               	leaq	-0xe0(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rcx)
               	movq	0x8(%rax), %r11
               	movq	%r11, 0x8(%rcx)
               	popq	%r11
               	movq	%rcx, %rax
               	leaq	-0x20(%rbp), %rax
               	movsd	(%rax,%riz), %xmm0
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%bl
               	movzbq	%bl, %rbx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	addq	$0x8, %rax
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%bl
               	movzbq	%bl, %rbx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x190, %rsp            # imm = 0x190
               	popq	%rbp
               	retq
               	leaq	-0x100(%rbp), %rdi
               	movabsq	$0x3ff0000000000000, %rbx # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	-0x100(%rbp), %rax
               	leaq	-0x48(%rbp), %rcx
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rcx)
               	movq	0x8(%rax), %r11
               	movq	%r11, 0x8(%rcx)
               	movq	0x10(%rax), %r11
               	movq	%r11, 0x10(%rcx)
               	popq	%r11
               	movq	%rcx, %rax
               	leaq	-0x48(%rbp), %rax
               	movsd	(%rax,%riz), %xmm0
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	movl	$0x1, %ebx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x48(%rbp), %rax
               	addq	$0x8, %rax
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	-0x48(%rbp), %rax
               	addq	$0x10, %rax
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%bl
               	movzbq	%bl, %rbx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x190, %rsp            # imm = 0x190
               	popq	%rbp
               	retq
               	leaq	-0x138(%rbp), %rdi
               	movabsq	$0x4024000000000000, %rbx # imm = 0x4024000000000000
               	movabsq	$0x4034000000000000, %rdx # imm = 0x4034000000000000
               	movabsq	$0x403e000000000000, %rcx # imm = 0x403E000000000000
               	movabsq	$0x4044000000000000, %r8 # imm = 0x4044000000000000
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	-0x138(%rbp), %rax
               	leaq	-0x80(%rbp), %rcx
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rcx)
               	movq	0x8(%rax), %r11
               	movq	%r11, 0x8(%rcx)
               	movq	0x10(%rax), %r11
               	movq	%r11, 0x10(%rcx)
               	movq	0x18(%rax), %r11
               	movq	%r11, 0x18(%rcx)
               	popq	%r11
               	movq	%rcx, %rax
               	leaq	-0x80(%rbp), %rax
               	movsd	(%rax,%riz), %xmm0
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	movl	$0x1, %ebx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x80(%rbp), %rax
               	addq	$0x8, %rax
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$0x4034000000000000, %rax # imm = 0x4034000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	movl	$0x1, %r12d
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	-0x80(%rbp), %rax
               	addq	$0x10, %rax
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$0x403e000000000000, %rax # imm = 0x403E000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	testq	%r12, %r12
               	jne	<addr>
               	leaq	-0x80(%rbp), %rax
               	addq	$0x18, %rax
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$0x4044000000000000, %rax # imm = 0x4044000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%r12b
               	movzbq	%r12b, %r12
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r12
               	testq	%r12, %r12
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x190, %rsp            # imm = 0x190
               	popq	%rbp
               	retq
               	movabsq	$0x3ff8000000000000, %rbx # imm = 0x3FF8000000000000
               	movq	%rbx, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm1
               	callq	<addr>
               	movsd	%xmm0, -0x160(%rbp,%riz)
               	leaq	-0x160(%rbp), %rax
               	leaq	-0xa8(%rbp), %rcx
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rcx)
               	popq	%r11
               	movq	%rcx, %rax
               	leaq	-0xa8(%rbp), %rax
               	movss	(%rax,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%bl
               	movzbq	%bl, %rbx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	-0xa8(%rbp), %rax
               	addq	$0x4, %rax
               	movss	(%rax,%riz), %xmm0
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%bl
               	movzbq	%bl, %rbx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x190, %rsp            # imm = 0x190
               	popq	%rbp
               	retq
               	leaq	-0xc0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	popq	%r11
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	movabsq	$0x3fe8000000000000, %rax # imm = 0x3FE8000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x190, %rsp            # imm = 0x190
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rdi
               	callq	<addr>
               	movabsq	$0x4059000000000000, %rax # imm = 0x4059000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x190, %rsp            # imm = 0x190
               	popq	%rbp
               	retq
               	leaq	-0xc0(%rbp), %rdi
               	callq	<addr>
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
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
               	movl	$0x8, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x190, %rsp            # imm = 0x190
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x190, %rsp            # imm = 0x190
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
