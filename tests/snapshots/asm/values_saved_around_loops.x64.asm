
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
               	subq	$0x58, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	%rdi, 0x58(%rsp)
               	movq	%r8, %rax
               	movq	%rcx, 0x78(%rsp)
               	movq	%rdx, 0x50(%rsp)
               	movq	%rsi, 0x70(%rsp)
               	xorl	%r10d, %r10d
               	movq	%r10, 0x68(%rsp)
               	movq	(%rax), %r9
               	movq	0x8(%rax), %r13
               	movq	0x10(%rax), %r12
               	movq	0x18(%rax), %rbx
               	movq	0x20(%rax), %r8
               	movq	0x28(%rax), %rdi
               	movq	0x30(%rax), %rsi
               	movq	0x38(%rax), %rdx
               	movq	0x40(%rax), %rcx
               	movq	0x48(%rax), %r15
               	movq	0x68(%rsp), %r11
               	movq	%r11, 0x60(%rsp)
               	jmp	<addr>
               	movq	0x40(%rsp), %rcx
               	movq	0x38(%rsp), %rdx
               	movq	0x68(%rsp), %r14
               	leaq	0x1(%r14), %rbp
               	imulq	%rax, %rbp
               	movq	0x60(%rsp), %r10
               	addq	%rbp, %r10
               	movq	%r10, 0x60(%rsp)
               	xorq	%rax, %r9
               	leaq	0x1(%r14), %r10
               	movq	%r10, 0x68(%rsp)
               	nopw	%cs:(%rax,%rax)
               	nopl	(%rax,%rax)
               	movq	0x68(%rsp), %rax
               	cmpq	0x50(%rsp), %rax
               	jge	<addr>
               	xorl	%eax, %eax
               	cmpq	0x78(%rsp), %rax
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
               	xorq	%rcx, %r15
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpq	0x78(%rsp), %rax
               	jl	<addr>
               	movq	0x58(%rsp), %r14
               	addq	0x68(%rsp), %r14
               	xorl	%eax, %eax
               	movq	%rcx, 0x40(%rsp)
               	movq	%rdx, 0x38(%rsp)
               	movq	0x70(%rsp), %rbp
               	cmpq	0x78(%rsp), %rax
               	jge	<addr>
               	incq	%r14
               	movzbq	-0x1(%r14), %rcx
               	incq	%rbp
               	movzbq	-0x1(%rbp), %rdx
               	nopl	(%rax)
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpq	0x78(%rsp), %rax
               	jl	<addr>
               	jmp	<addr>
               	movq	0x60(%rsp), %rax
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
               	imulq	$0x13, %r15, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x58, %rsp
               	retq

<reference>:
               	subq	$0x60, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	movq	%rcx, %rdi
               	movq	%rdx, %r15
               	movq	%rsi, %r13
               	xorl	%eax, %eax
               	leaq	0x30(%rsp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rdx
               	addq	%r8, %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rdx)
               	incq	%rax
               	cmpl	$0xa, %eax
               	jl	<addr>
               	xorl	%ebx, %ebx
               	movq	%rbx, %r14
               	jmp	<addr>
               	incq	%rbx
               	movq	%r8, %rax
               	imulq	%rbx, %rax
               	addq	%rax, %r14
               	movq	0x30(%rsp), %rax
               	xorq	%r8, %rax
               	movq	%rax, 0x30(%rsp)
               	nopl	(%rax)
               	cmpq	%r15, %rbx
               	jge	<addr>
               	xorl	%ecx, %ecx
               	cmpq	%rdi, %rcx
               	jge	<addr>
               	movq	0x30(%rsp), %rsi
               	addq	%rcx, %rsi
               	movq	%rsi, 0x30(%rsp)
               	movl	$0x1, %r8d
               	jmp	<addr>
               	movq	%r9, (%rax)
               	incq	%r8
               	cmpl	$0xa, %r8d
               	jge	<addr>
               	leaq	0x30(%rsp), %r9
               	movq	%r8, %rax
               	shlq	$0x3, %rax
               	addq	%r9, %rax
               	testb	$0x1, %r8b
               	je	<addr>
               	leaq	0x30(%rsp), %r9
               	movq	%r8, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r9
               	movq	(%r9), %r9
               	leaq	0x30(%rsp), %rdx
               	leaq	-0x1(%r8), %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rdx
               	xorq	%rdx, %r9
               	jmp	<addr>
               	leaq	0x30(%rsp), %r9
               	movq	%r8, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r9
               	movq	(%r9), %r9
               	leaq	0x30(%rsp), %rdx
               	leaq	-0x1(%r8), %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rdx
               	addq	%rdx, %r9
               	jmp	<addr>
               	incq	%rcx
               	cmpq	%rdi, %rcx
               	jl	<addr>
               	xorl	%r8d, %r8d
               	cmpq	%rdi, %r8
               	jge	<addr>
               	leaq	(%rbx,%r8), %rcx
               	movzbq	(%r12,%rcx), %rcx
               	movzbq	(%r13,%r8), %rsi
               	cmpl	%esi, %ecx
               	jne	<addr>
               	incq	%r8
               	nopw	(%rax,%rax)
               	cmpq	%rdi, %r8
               	jl	<addr>
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	leaq	0x30(%rsp), %rax
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rax
               	movq	(%rax), %rax
               	movq	%rcx, %rdx
               	shlq	%rdx
               	incq	%rdx
               	imulq	%rdx, %rax
               	addq	%rax, %r14
               	incq	%rcx
               	cmpl	$0xa, %ecx
               	jl	<addr>
               	movq	%r14, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x60, %rsp
               	retq

<two_exits>:
               	subq	$0x48, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	%rdi, 0x50(%rsp)
               	movq	%rdx, %rbp
               	movq	%rsi, 0x48(%rsp)
               	xorl	%r10d, %r10d
               	movq	%r10, 0x60(%rsp)
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
               	movq	0x60(%rsp), %r11
               	movq	%r11, 0x58(%rsp)
               	jmp	<addr>
               	movq	0x68(%rsp), %r10
               	addq	%rax, %r10
               	movq	%r10, 0x58(%rsp)
               	addq	$0x1, 0x60(%rsp)
               	movq	0x60(%rsp), %rax
               	cmpq	0x48(%rsp), %rax
               	jge	<addr>
               	xorl	%eax, %eax
               	nop
               	cmpq	%rbp, %rax
               	jge	<addr>
               	movq	%rax, %r10
               	xorq	%rcx, %r10
               	movq	%r10, 0x68(%rsp)
               	addq	0x68(%rsp), %r15
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
               	movq	0x50(%rsp), %r10
               	addq	0x60(%rsp), %r10
               	movq	%r10, 0x68(%rsp)
               	xorl	%eax, %eax
               	movq	%rcx, 0x38(%rsp)
               	cmpq	%rbp, %rax
               	jge	<addr>
               	nopw	%cs:(%rax,%rax)
               	movq	0x68(%rsp), %r10
               	cmpb	$0x0, (%r10,%rax)
               	je	<addr>
               	incq	%rax
               	cmpq	%rbp, %rax
               	jl	<addr>
               	movq	0x38(%rsp), %rcx
               	movq	0x58(%rsp), %r10
               	addq	%r9, %r10
               	movq	%r10, 0x68(%rsp)
               	jmp	<addr>
               	movq	0x38(%rsp), %rcx
               	movq	0x58(%rsp), %r10
               	xorq	%r8, %r10
               	movq	%r10, 0x68(%rsp)
               	nopl	(%rax)
               	jmp	<addr>
               	movq	0x58(%rsp), %rax
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
               	addq	$0x48, %rsp
               	retq

<two_exits_reference>:
               	subq	$0x68, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	movq	%rdx, %rdi
               	movq	%rsi, %r14
               	xorl	%eax, %eax
               	leaq	0x28(%rsp), %rsi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rsi
               	addq	%rcx, %rdx
               	movq	(%rdx), %rdx
               	movq	%rdx, (%rsi)
               	incq	%rax
               	cmpl	$0xb, %eax
               	jl	<addr>
               	xorl	%ebx, %ebx
               	movq	%rbx, %r13
               	jmp	<addr>
               	leaq	(%rax,%rcx), %r13
               	incq	%rbx
               	cmpq	%r14, %rbx
               	jge	<addr>
               	xorl	%eax, %eax
               	cmpq	%rdi, %rax
               	jge	<addr>
               	movq	0x28(%rsp), %rcx
               	movq	0x78(%rsp), %rdx
               	xorq	%rax, %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, 0x28(%rsp)
               	movl	$0x1, %ecx
               	jmp	<addr>
               	movq	%r8, (%r9)
               	incq	%rcx
               	nopw	(%rax,%rax)
               	cmpl	$0xb, %ecx
               	jge	<addr>
               	leaq	0x28(%rsp), %r8
               	movq	%rcx, %r9
               	shlq	$0x3, %r9
               	addq	%r8, %r9
               	nopl	(%rax,%rax)
               	testb	$0x1, %cl
               	je	<addr>
               	leaq	0x28(%rsp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	leaq	0x28(%rsp), %rdx
               	leaq	-0x1(%rcx), %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rdx
               	addq	%rdx, %r8
               	jmp	<addr>
               	leaq	0x28(%rsp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	leaq	0x28(%rsp), %rdx
               	leaq	-0x1(%rcx), %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rdx
               	xorq	%rdx, %r8
               	jmp	<addr>
               	incq	%rax
               	nop
               	cmpq	%rdi, %rax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	cmpq	%rdi, %rcx
               	jge	<addr>
               	leaq	(%rbx,%rcx), %rdx
               	cmpb	$0x0, (%r12,%rdx)
               	je	<addr>
               	incq	%rcx
               	nop
               	cmpq	%rdi, %rcx
               	jl	<addr>
               	movq	0x40(%rsp), %rax
               	addq	%r13, %rax
               	jmp	<addr>
               	movq	0x60(%rsp), %rax
               	xorq	%r13, %rax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0xb, %eax
               	jge	<addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	leaq	0x28(%rsp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %r13
               	jmp	<addr>
               	movq	%r13, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	addq	$0x68, %rsp
               	retq

<main>:
               	subq	$0x100, %rsp            # imm = 0x100
               	pushq	%rbx
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movb	%dl, 0xa0(%rsp,%rax)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x60, %eax
               	jge	<addr>
               	imulq	$0x7, %rax, %rdx
               	imulq	$0x33333334, %rdx, %rdi # imm = 0x33333334
               	shrq	$0x20, %rdi
               	leaq	(%rdi,%rdi,4), %rdi
               	subq	%rdi, %rdx
               	nop
               	testl	%edx, %edx
               	jne	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	leaq	0x1(%rdi), %rdx
               	jmp	<addr>
               	xorl	%eax, %eax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	leaq	0x1(%rsi), %rdx
               	movb	%dl, 0x18(%rsp,%rax)
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
               	leaq	0x48(%rsp), %r8
               	movq	$0x96a2b38, 0x80(%rsp)  # imm = 0x96A2B38
               	movq	$0xabd709f, 0x88(%rsp)  # imm = 0xABD709F
               	movq	$0xbf0b606, 0x90(%rsp)  # imm = 0xBF0B606
               	movq	$0xc23fb6d, 0x98(%rsp)  # imm = 0xC23FB6D
               	leaq	0xa0(%rsp), %rdi
               	leaq	0x18(%rsp), %rsi
               	movl	$0x28, %edx
               	movq	%rdx, %rcx
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0xa0(%rsp), %rdi
               	leaq	0x18(%rsp), %rsi
               	movl	$0x28, %edx
               	leaq	0x48(%rsp), %r8
               	movq	%rdx, %rcx
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
               	leaq	0x48(%rsp), %rcx
               	movq	%rsi, %rdx
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0xa0(%rsp), %rdi
               	movl	$0x28, %esi
               	leaq	0x48(%rsp), %rcx
               	movq	%rsi, %rdx
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
