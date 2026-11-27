
values_saved_around_loops.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<direct>:
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	%rdi, 0x48(%rsp)
               	movq	%r8, %rax
               	movq	%rcx, %r15
               	movq	%rdx, 0x40(%rsp)
               	movq	%rsi, %rbp
               	xorl	%r10d, %r10d
               	movq	%r10, 0x58(%rsp)
               	movq	(%rax), %r9
               	movq	0x8(%rax), %r13
               	movq	0x10(%rax), %r12
               	movq	0x18(%rax), %rbx
               	movq	0x20(%rax), %r8
               	movq	0x28(%rax), %rdi
               	movq	0x30(%rax), %rsi
               	movq	0x38(%rax), %rdx
               	movq	0x40(%rax), %rcx
               	movq	0x48(%rax), %r14
               	movq	0x58(%rsp), %r11
               	movq	%r11, 0x50(%rsp)
               	jmp	<addr>
               	movq	0x38(%rsp), %rcx
               	movq	0x30(%rsp), %rdx
               	movq	0x58(%rsp), %r10
               	incq	%r10
               	imulq	%rax, %r10
               	movq	0x50(%rsp), %r11
               	addq	%r10, %r11
               	movq	%r11, 0x50(%rsp)
               	xorq	%rax, %r9
               	addq	$0x1, 0x58(%rsp)
               	movq	0x58(%rsp), %rax
               	cmpq	0x40(%rsp), %rax
               	jge	<addr>
               	xorl	%eax, %eax
               	nopw	(%rax,%rax)
               	cmpq	%r15, %rax
               	jge	<addr>
               	addq	%rax, %r9
               	xorq	%r9, %r13
               	addq	%r13, %r12
               	xorq	%r12, %rbx
               	addq	%rbx, %r8
               	xorq	%r8, %rdi
               	addq	%rdi, %rsi
               	xorq	%rsi, %rdx
               	addq	%rdx, %rcx
               	xorq	%rcx, %r14
               	incq	%rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	movq	0x48(%rsp), %r10
               	addq	0x58(%rsp), %r10
               	xorl	%eax, %eax
               	movq	%rcx, 0x38(%rsp)
               	movq	%rdx, 0x30(%rsp)
               	movq	%rbp, %r11
               	cmpq	%r15, %rax
               	jge	<addr>
               	incq	%r10
               	movzbq	-0x1(%r10), %rcx
               	incq	%r11
               	movzbq	-0x1(%r11), %rdx
               	nopl	(%rax)
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	jmp	<addr>
               	movq	0x50(%rsp), %rax
               	addq	%r9, %rax
               	leaq	(%r13,%r13,2), %r9
               	addq	%r9, %rax
               	leaq	(%r12,%r12,4), %r9
               	addq	%r9, %rax
               	imulq	$0x7, %rbx, %r9
               	addq	%r9, %rax
               	leaq	(%r8,%r8,8), %r8
               	addq	%r8, %rax
               	imulq	$0xb, %rdi, %rdi
               	addq	%rdi, %rax
               	imulq	$0xd, %rsi, %rsi
               	addq	%rsi, %rax
               	imulq	$0xf, %rdx, %rdx
               	addq	%rdx, %rax
               	imulq	$0x11, %rcx, %rcx
               	addq	%rcx, %rax
               	imulq	$0x13, %r14, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x38, %rsp
               	retq

<reference>:
               	subq	$0x60, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rsi, %rbx
               	movq	%rdx, %r13
               	movq	%rcx, %rdx
               	xorl	%eax, %eax
               	leaq	0x20(%rsp), %rsi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rsi
               	addq	%r8, %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rsi)
               	incq	%rax
               	cmpl	$0xa, %eax
               	jl	<addr>
               	xorl	%esi, %esi
               	movq	%rsi, %r12
               	jmp	<addr>
               	incq	%rsi
               	movq	%r8, %rax
               	imulq	%rsi, %rax
               	addq	%rax, %r12
               	movq	0x20(%rsp), %rax
               	xorq	%r8, %rax
               	movq	%rax, 0x20(%rsp)
               	cmpq	%r13, %rsi
               	jge	<addr>
               	xorl	%r11d, %r11d
               	cmpq	%rdx, %r11
               	jge	<addr>
               	movq	0x20(%rsp), %rcx
               	addq	%r11, %rcx
               	movq	%rcx, 0x20(%rsp)
               	movl	$0x1, %r8d
               	nopl	(%rax)
               	jmp	<addr>
               	movq	%r9, (%rax)
               	incq	%r8
               	cmpl	$0xa, %r8d
               	jge	<addr>
               	leaq	0x20(%rsp), %rax
               	movq	%r8, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %rax
               	nopl	(%rax)
               	testb	$0x1, %r8b
               	je	<addr>
               	leaq	0x20(%rsp), %r10
               	addq	%r10, %r9
               	movq	(%r9), %r9
               	leaq	0x20(%rsp), %rcx
               	leaq	-0x1(%r8), %r10
               	shlq	$0x3, %r10
               	addq	%rcx, %r10
               	movq	(%r10), %r10
               	xorq	%r10, %r9
               	jmp	<addr>
               	leaq	0x20(%rsp), %r10
               	addq	%r10, %r9
               	movq	(%r9), %r10
               	leaq	0x20(%rsp), %rcx
               	leaq	-0x1(%r8), %r9
               	shlq	$0x3, %r9
               	addq	%rcx, %r9
               	movq	(%r9), %r9
               	addq	%r10, %r9
               	jmp	<addr>
               	incq	%r11
               	cmpq	%rdx, %r11
               	jl	<addr>
               	xorl	%r8d, %r8d
               	nop
               	cmpq	%rdx, %r8
               	jge	<addr>
               	leaq	(%rsi,%r8), %rcx
               	movzbq	(%rdi,%rcx), %rcx
               	movzbq	(%rbx,%r8), %r9
               	nopw	(%rax,%rax)
               	cmpl	%r9d, %ecx
               	jne	<addr>
               	incq	%r8
               	cmpq	%rdx, %r8
               	jl	<addr>
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	leaq	0x20(%rsp), %rax
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rax
               	movq	(%rax), %rax
               	movq	%rcx, %rdx
               	shlq	%rdx
               	incq	%rdx
               	imulq	%rdx, %rax
               	addq	%rax, %r12
               	incq	%rcx
               	nopl	(%rax)
               	cmpl	$0xa, %ecx
               	jl	<addr>
               	movq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq

<two_exits>:
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	%rdi, 0x38(%rsp)
               	movq	%rdx, %rbp
               	movq	%rsi, 0x30(%rsp)
               	xorl	%r10d, %r10d
               	movq	%r10, 0x48(%rsp)
               	movq	(%rcx), %r15
               	movq	0x8(%rcx), %r14
               	movq	0x10(%rcx), %r13
               	movq	0x18(%rcx), %r9
               	movq	0x20(%rcx), %r12
               	movq	0x28(%rcx), %rbx
               	movq	0x30(%rcx), %rdi
               	movq	0x38(%rcx), %r8
               	movq	0x40(%rcx), %rsi
               	movq	0x48(%rcx), %rdx
               	movq	0x50(%rcx), %rcx
               	movq	0x48(%rsp), %r11
               	movq	%r11, 0x40(%rsp)
               	jmp	<addr>
               	leaq	(%r10,%rax), %r11
               	movq	%r11, 0x40(%rsp)
               	addq	$0x1, 0x48(%rsp)
               	movq	0x48(%rsp), %rax
               	cmpq	0x30(%rsp), %rax
               	jge	<addr>
               	xorl	%eax, %eax
               	nopl	(%rax,%rax)
               	cmpq	%rbp, %rax
               	jge	<addr>
               	movq	%rax, %r10
               	xorq	%rcx, %r10
               	addq	%r10, %r15
               	addq	%r15, %r14
               	xorq	%r14, %r13
               	addq	%r13, %r9
               	xorq	%r9, %r12
               	addq	%r12, %rbx
               	xorq	%rbx, %rdi
               	addq	%rdi, %r8
               	xorq	%r8, %rsi
               	addq	%rsi, %rdx
               	xorq	%rdx, %rcx
               	incq	%rax
               	cmpq	%rbp, %rax
               	jl	<addr>
               	movq	0x38(%rsp), %r10
               	addq	0x48(%rsp), %r10
               	xorl	%eax, %eax
               	cmpq	%rbp, %rax
               	jge	<addr>
               	cmpb	$0x0, (%r10,%rax)
               	je	<addr>
               	incq	%rax
               	cmpq	%rbp, %rax
               	jl	<addr>
               	movq	0x40(%rsp), %r10
               	addq	%r9, %r10
               	nopl	(%rax)
               	jmp	<addr>
               	movq	0x40(%rsp), %r10
               	xorq	%r8, %r10
               	jmp	<addr>
               	movq	0x40(%rsp), %rax
               	addq	%r15, %rax
               	addq	%r14, %rax
               	addq	%r13, %rax
               	addq	%r12, %rax
               	addq	%rbx, %rax
               	addq	%rdi, %rax
               	addq	%rsi, %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x28, %rsp
               	retq

<two_exits_reference>:
               	subq	$0x68, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rsi, %r12
               	xorl	%eax, %eax
               	leaq	0x18(%rsp), %rsi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rsi
               	addq	%rcx, %r8
               	movq	(%r8), %r8
               	movq	%r8, (%rsi)
               	incq	%rax
               	cmpl	$0xb, %eax
               	jl	<addr>
               	xorl	%esi, %esi
               	movq	%rsi, %rbx
               	jmp	<addr>
               	leaq	(%rax,%rcx), %rbx
               	incq	%rsi
               	nopw	(%rax,%rax)
               	cmpq	%r12, %rsi
               	jge	<addr>
               	xorl	%r11d, %r11d
               	cmpq	%rdx, %r11
               	jge	<addr>
               	movq	0x18(%rsp), %r8
               	movq	0x68(%rsp), %rcx
               	xorq	%r11, %rcx
               	addq	%r8, %rcx
               	movq	%rcx, 0x18(%rsp)
               	movl	$0x1, %ecx
               	jmp	<addr>
               	movq	%r8, (%r9)
               	incq	%rcx
               	nopw	(%rax,%rax)
               	cmpl	$0xb, %ecx
               	jge	<addr>
               	leaq	0x18(%rsp), %r8
               	movq	%rcx, %r9
               	shlq	$0x3, %r9
               	addq	%r8, %r9
               	testb	$0x1, %cl
               	je	<addr>
               	movq	(%r9), %r10
               	leaq	0x18(%rsp), %rax
               	leaq	-0x1(%rcx), %r8
               	shlq	$0x3, %r8
               	addq	%rax, %r8
               	movq	(%r8), %r8
               	addq	%r10, %r8
               	jmp	<addr>
               	leaq	0x18(%rsp), %r8
               	movq	%rcx, %r10
               	shlq	$0x3, %r10
               	addq	%r10, %r8
               	movq	(%r8), %r8
               	leaq	0x18(%rsp), %rax
               	leaq	-0x1(%rcx), %r10
               	shlq	$0x3, %r10
               	addq	%rax, %r10
               	movq	(%r10), %r10
               	xorq	%r10, %r8
               	nopl	(%rax)
               	jmp	<addr>
               	incq	%r11
               	cmpq	%rdx, %r11
               	jl	<addr>
               	xorl	%ecx, %ecx
               	cmpq	%rdx, %rcx
               	jge	<addr>
               	leaq	(%rsi,%rcx), %r8
               	nopl	(%rax)
               	cmpb	$0x0, (%rdi,%r8)
               	je	<addr>
               	incq	%rcx
               	cmpq	%rdx, %rcx
               	jl	<addr>
               	movq	0x30(%rsp), %rax
               	addq	%rbx, %rax
               	jmp	<addr>
               	movq	0x50(%rsp), %rax
               	xorq	%rbx, %rax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0xb, %eax
               	jge	<addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	nopw	(%rax,%rax)
               	cmpl	$0x7, %eax
               	je	<addr>
               	leaq	0x18(%rsp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rbx
               	jmp	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	addq	$0x68, %rsp
               	retq

<main>:
               	subq	$0x100, %rsp            # imm = 0x100
               	pushq	%rbx
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movb	%cl, 0xa0(%rsp,%rax)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x60, %eax
               	jge	<addr>
               	imulq	$0x7, %rax, %rcx
               	imulq	$0x33333334, %rcx, %rsi # imm = 0x33333334
               	shrq	$0x20, %rsi
               	leaq	(%rsi,%rsi,4), %rsi
               	subq	%rsi, %rcx
               	nop
               	testl	%ecx, %ecx
               	jne	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	imulq	$0x55555556, %rax, %rcx # imm = 0x55555556
               	shrq	$0x20, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	movq	%rax, %rsi
               	subq	%rcx, %rsi
               	leaq	0x1(%rsi), %rcx
               	jmp	<addr>
               	xorl	%eax, %eax
               	imulq	$0x55555556, %rax, %rcx # imm = 0x55555556
               	shrq	$0x20, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	movq	%rax, %rsi
               	subq	%rcx, %rsi
               	leaq	0x1(%rsi), %rcx
               	movb	%cl, 0x18(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x30, %eax
               	jl	<addr>
               	movq	$0x1234567, 0x48(%rsp)  # imm = 0x1234567
               	movq	$0x2568ace, 0x50(%rsp)  # imm = 0x2568ACE
               	movq	$0x349d035, 0x58(%rsp)  # imm = 0x349D035
               	movq	$0x4bd159c, 0x60(%rsp)  # imm = 0x4BD159C
               	movq	$0x5f05b03, 0x68(%rsp)  # imm = 0x5F05B03
               	movq	$0x683a06a, 0x70(%rsp)  # imm = 0x683A06A
               	movq	$0x796e5d1, 0x78(%rsp)  # imm = 0x796E5D1
               	movq	$0x96a2b38, 0x80(%rsp)  # imm = 0x96A2B38
               	movq	$0xabd709f, 0x88(%rsp)  # imm = 0xABD709F
               	movq	$0xbf0b606, 0x90(%rsp)  # imm = 0xBF0B606
               	movq	$0xc23fb6d, 0x98(%rsp)  # imm = 0xC23FB6D
               	leaq	0xa0(%rsp), %rdi
               	leaq	0x18(%rsp), %rsi
               	movl	$0x28, %edx
               	movl	$0x28, %ecx
               	leaq	0x48(%rsp), %r8
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0xa0(%rsp), %rdi
               	leaq	0x18(%rsp), %rsi
               	movl	$0x28, %edx
               	movl	$0x28, %ecx
               	leaq	0x48(%rsp), %r8
               	callq	<addr>
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0x100, %rsp            # imm = 0x100
               	retq
               	leaq	0xa0(%rsp), %rdi
               	leaq	0x18(%rsp), %rsi
               	movl	$0x7, %edx
               	xorl	%ecx, %ecx
               	leaq	0x48(%rsp), %r8
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0xa0(%rsp), %rdi
               	leaq	0x18(%rsp), %rsi
               	movl	$0x7, %edx
               	xorl	%ecx, %ecx
               	leaq	0x48(%rsp), %r8
               	callq	<addr>
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0x100, %rsp            # imm = 0x100
               	retq
               	leaq	0xa0(%rsp), %rdi
               	movl	$0x28, %esi
               	movl	$0x28, %edx
               	leaq	0x48(%rsp), %rcx
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0xa0(%rsp), %rdi
               	movl	$0x28, %esi
               	movl	$0x28, %edx
               	leaq	0x48(%rsp), %rcx
               	callq	<addr>
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	addq	$0x100, %rsp            # imm = 0x100
               	retq
               	leaq	0xa0(%rsp), %rdi
               	movl	$0x9, %esi
               	movl	$0x3, %edx
               	leaq	0x48(%rsp), %rcx
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0xa0(%rsp), %rdi
               	movl	$0x9, %esi
               	movl	$0x3, %edx
               	leaq	0x48(%rsp), %rcx
               	callq	<addr>
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	addq	$0x100, %rsp            # imm = 0x100
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x100, %rsp            # imm = 0x100
               	retq
