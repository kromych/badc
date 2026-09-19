
strength_reduce_magic_divmod.x64:	file format elf64-x86-64

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

<fill>:
               	leaq	<rip>, %rax
               	movq	$0x0, (%rax)
               	movq	$0x1, 0x8(%rax)
               	movq	$-0x1, 0x10(%rax)
               	movq	$0x2, 0x18(%rax)
               	movq	$-0x2, 0x20(%rax)
               	movq	$0x7fffffff, 0x28(%rax) # imm = 0x7FFFFFFF
               	movq	$-0x80000000, 0x30(%rax) # imm = 0x80000000
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rcx, 0x38(%rax)
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%rcx, 0x40(%rax)
               	movq	$0x3b9aca07, 0x48(%rax) # imm = 0x3B9ACA07
               	movq	$-0x3b9aca07, 0x50(%rax) # imm = 0xC46535F9
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movq	%rcx, 0x58(%rax)
               	movabsq	$0x2ceaee21bf46bc00, %rcx # imm = 0x2CEAEE21BF46BC00
               	movq	%rcx, 0x60(%rax)
               	movabsq	$-0x557f8ab2e5e572b1, %rcx # imm = 0xAA80754D1A1A8D4F
               	movq	%rcx, 0x68(%rax)
               	movabsq	$-0x4c3b6fb592d876ce, %rcx # imm = 0xB3C4904A6D278932
               	movq	%rcx, 0x70(%rax)
               	movabsq	$-0x439630bd897b92e7, %rcx # imm = 0xBC69CF4276846D19
               	movq	%rcx, 0x78(%rax)
               	movabsq	$0x377b2fd56a5b15b4, %rcx # imm = 0x377B2FD56A5B15B4
               	movq	%rcx, 0x80(%rax)
               	movabsq	$0x64d815deeaf29df3, %rcx # imm = 0x64D815DEEAF29DF3
               	movq	%rcx, 0x88(%rax)
               	movabsq	$-0x991eff24d282dfa, %rax # imm = 0xF66E100DB2D7D206
               	leaq	<rip>, %rcx
               	movq	%rax, 0x90(%rcx)
               	movabsq	$0x1069e6a57e06665d, %rax # imm = 0x1069E6A57E06665D
               	movq	%rax, 0x98(%rcx)
               	xorl	%eax, %eax
               	leaq	<rip>, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdi
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%r8,%rdx), %r9
               	addq	%rcx, %rdx
               	movq	(%rdx), %rdx
               	movq	%rdx, (%r9)
               	movq	(%rcx,%rax,8), %rdx
               	movl	%edx, (%rsi,%rax,4)
               	movq	(%rcx,%rax,8), %rdx
               	movl	%edx, (%rdi,%rax,4)
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1b8, %rsp            # imm = 0x1B8
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	callq	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x3, -0x1a8(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x55555556, %rsi, %r8  # imm = 0x55555556
               	movq	%r8, %rdi
               	sarq	$0x20, %rdi
               	movq	%rdi, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdi,%r9), %rax
               	movslq	-0x1a8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	leaq	(%rax,%rax,2), %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movslq	-0x1a8(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x5, -0x1a0(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x66666667, %rsi, %r8  # imm = 0x66666667
               	movq	%r8, %rdi
               	sarq	$0x21, %rdi
               	movq	%rdi, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdi,%r9), %rax
               	movslq	-0x1a0(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	leaq	(%rax,%rax,4), %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movslq	-0x1a0(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x6, -0x198(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x2aaaaaab, %rsi, %r8  # imm = 0x2AAAAAAB
               	movq	%r8, %rdi
               	sarq	$0x20, %rdi
               	movq	%rdi, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdi,%r9), %rax
               	movslq	-0x198(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	imulq	$0x6, %rax, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movslq	-0x198(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x7, -0x190(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	movl	$0x92492493, %r8d       # imm = 0x92492493
               	imulq	%rsi, %r8
               	movq	%r8, %rdi
               	sarq	$0x22, %rdi
               	movq	%rdi, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdi,%r9), %rax
               	movslq	-0x190(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	imulq	$0x7, %rax, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movslq	-0x190(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0xa, -0x188(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x66666667, %rsi, %r8  # imm = 0x66666667
               	movq	%r8, %rdi
               	sarq	$0x22, %rdi
               	movq	%rdi, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdi,%r9), %rax
               	movslq	-0x188(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	imulq	$0xa, %rax, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movslq	-0x188(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x64, -0x180(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x51eb851f, %rsi, %r8  # imm = 0x51EB851F
               	movq	%r8, %rdi
               	sarq	$0x25, %rdi
               	movq	%rdi, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdi,%r9), %rax
               	movslq	-0x180(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	imulq	$0x64, %rax, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movslq	-0x180(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x3e8, -0x178(%rbp)    # imm = 0x3E8
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x10624dd3, %rsi, %r8  # imm = 0x10624DD3
               	movq	%r8, %rdi
               	sarq	$0x26, %rdi
               	movq	%rdi, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdi,%r9), %rax
               	movslq	-0x178(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movslq	-0x178(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0xffff, -0x170(%rbp)   # imm = 0xFFFF
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	movl	$0x80008001, %r8d       # imm = 0x80008001
               	imulq	%rsi, %r8
               	movq	%r8, %rdi
               	sarq	$0x2f, %rdi
               	movq	%rdi, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdi,%r9), %rax
               	movslq	-0x170(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	imulq	$0xffff, %rax, %rax     # imm = 0xFFFF
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movslq	-0x170(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x10001, -0x168(%rbp)  # imm = 0x10001
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x7fff8001, %rsi, %r8  # imm = 0x7FFF8001
               	movq	%r8, %rdi
               	sarq	$0x2f, %rdi
               	movq	%rdi, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdi,%r9), %rax
               	movslq	-0x168(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	imulq	$0x10001, %rax, %rax    # imm = 0x10001
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movslq	-0x168(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x7fffffff, -0x160(%rbp) # imm = 0x7FFFFFFF
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x40000001, %rsi, %r8  # imm = 0x40000001
               	movq	%r8, %rdi
               	sarq	$0x3d, %rdi
               	movq	%rdi, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdi,%r9), %rax
               	movslq	-0x160(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	imulq	$0x7fffffff, %rax, %rax # imm = 0x7FFFFFFF
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movslq	-0x160(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%r8d, %r8d
               	movq	%r8, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0xfffffffd, -0x158(%rbp) # imm = 0xFFFFFFFD
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x55555556, %rsi, %r9  # imm = 0x55555556
               	movq	%r9, %rdi
               	sarq	$0x20, %rdi
               	movq	%rdi, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdi,%rax), %rdx
               	movq	%r8, %rbx
               	subq	%rdx, %rbx
               	movslq	-0x158(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rbx
               	jne	<addr>
               	xorl	%eax, %eax
               	subq	%rdx, %rax
               	imulq	$-0x3, %rax, %rax
               	movq	%rsi, %r9
               	subq	%rax, %r9
               	movslq	-0x158(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r9
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%r8d, %r8d
               	movq	%r8, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0xfffffff9, -0x150(%rbp) # imm = 0xFFFFFFF9
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	movl	$0x92492493, %r9d       # imm = 0x92492493
               	imulq	%rsi, %r9
               	movq	%r9, %rdi
               	sarq	$0x22, %rdi
               	movq	%rdi, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdi,%rax), %rdx
               	movq	%r8, %rbx
               	subq	%rdx, %rbx
               	movslq	-0x150(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rbx
               	jne	<addr>
               	xorl	%eax, %eax
               	subq	%rdx, %rax
               	imulq	$-0x7, %rax, %rax
               	movq	%rsi, %r9
               	subq	%rax, %r9
               	movslq	-0x150(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r9
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%r8d, %r8d
               	movq	%r8, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0xffffff9c, -0x148(%rbp) # imm = 0xFFFFFF9C
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x51eb851f, %rsi, %r9  # imm = 0x51EB851F
               	movq	%r9, %rdi
               	sarq	$0x25, %rdi
               	movq	%rdi, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdi,%rax), %rdx
               	movq	%r8, %rbx
               	subq	%rdx, %rbx
               	movslq	-0x148(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rbx
               	jne	<addr>
               	xorl	%eax, %eax
               	subq	%rdx, %rax
               	imulq	$-0x64, %rax, %rax
               	movq	%rsi, %r9
               	subq	%rax, %r9
               	movslq	-0x148(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r9
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%r8d, %r8d
               	movq	%r8, %rsi
               	cmpl	$0x14, %esi
               	jge	<addr>
               	movl	$0x80000000, -0x140(%rbp) # imm = 0x80000000
               	leaq	<rip>, %rax
               	movslq	(%rax,%rsi,4), %rcx
               	movq	%rcx, %rdi
               	shrq	$0x21, %rdi
               	leaq	(%rcx,%rdi), %r9
               	movq	%r9, %rax
               	sarq	$0x1f, %rax
               	negq	%rax
               	addq	%r8, %rax
               	movslq	-0x140(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movq	%r9, %rax
               	andq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	movq	%rax, %r9
               	subq	%rdi, %r9
               	movslq	-0x140(%rbp), %rdi
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r9
               	jne	<addr>
               	incq	%rsi
               	cmpl	$0x14, %esi
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x1, -0x138(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	movslq	-0x138(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rax, %rsi
               	jne	<addr>
               	movslq	-0x138(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	testq	%rdx, %rdx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x8, -0x130(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3d, %rdi
               	leaq	(%rsi,%rdi), %r8
               	movq	%r8, %r9
               	sarq	$0x3, %r9
               	movslq	-0x130(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %r9
               	jne	<addr>
               	movq	%r8, %rax
               	andq	$0x7, %rax
               	movq	%rax, %r8
               	subq	%rdi, %r8
               	movslq	-0x130(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%r8d, %r8d
               	movq	%r8, %rsi
               	cmpl	$0x14, %esi
               	jge	<addr>
               	movl	$0xfffffff8, -0x128(%rbp) # imm = 0xFFFFFFF8
               	leaq	<rip>, %rax
               	movslq	(%rax,%rsi,4), %rcx
               	movq	%rcx, %rdi
               	shrq	$0x3d, %rdi
               	leaq	(%rcx,%rdi), %r9
               	movq	%r9, %rax
               	sarq	$0x3, %rax
               	negq	%rax
               	addq	%r8, %rax
               	movslq	-0x128(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movq	%r9, %rax
               	andq	$0x7, %rax
               	movq	%rax, %r9
               	subq	%rdi, %r9
               	movslq	-0x128(%rbp), %rdi
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r9
               	jne	<addr>
               	incq	%rsi
               	cmpl	$0x14, %esi
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x40000000, -0x120(%rbp) # imm = 0x40000000
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	movq	%rsi, %rdi
               	shrq	$0x22, %rdi
               	leaq	(%rsi,%rdi), %r8
               	movq	%r8, %r9
               	sarq	$0x1e, %r9
               	movslq	-0x120(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %r9
               	jne	<addr>
               	movq	%r8, %rax
               	andq	$0x3fffffff, %rax       # imm = 0x3FFFFFFF
               	movq	%rax, %r8
               	subq	%rdi, %r8
               	movslq	-0x120(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x3, -0x118(%rbp)
               	leaq	<rip>, %rax
               	movl	(%rax,%rcx,4), %esi
               	movl	$0xaaaaaaab, %edi       # imm = 0xAAAAAAAB
               	imulq	%rsi, %rdi
               	movq	%rdi, %r8
               	shrq	$0x21, %r8
               	movl	-0x118(%rbp), %r9d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	cmpl	%eax, %r8d
               	jne	<addr>
               	leaq	(%r8,%r8,2), %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movl	-0x118(%rbp), %edi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%esi, %esi
               	cmpl	$0x14, %esi
               	jge	<addr>
               	movl	$0x7, -0x110(%rbp)
               	leaq	<rip>, %rax
               	movl	(%rax,%rsi,4), %ecx
               	imulq	$0x24924925, %rcx, %r8  # imm = 0x24924925
               	movq	%r8, %rdi
               	shrq	$0x20, %rdi
               	movq	%rcx, %r9
               	subq	%rdi, %r9
               	movq	%r9, %rax
               	shrq	%rax
               	leaq	(%rax,%rdi), %rdx
               	movq	%rdx, %rbx
               	shrq	$0x2, %rbx
               	movl	-0x110(%rbp), %r12d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpl	%r12d, %ebx
               	jne	<addr>
               	imulq	$0x7, %rbx, %rax
               	movq	%rcx, %r8
               	subq	%rax, %r8
               	movl	-0x110(%rbp), %edi
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rsi
               	cmpl	$0x14, %esi
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0xa, -0x108(%rbp)
               	leaq	<rip>, %rax
               	movl	(%rax,%rcx,4), %esi
               	movq	%rsi, %rdi
               	shrq	%rdi
               	imulq	$0x66666667, %rdi, %r8  # imm = 0x66666667
               	movq	%r8, %r9
               	shrq	$0x21, %r9
               	movl	-0x108(%rbp), %eax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpl	%eax, %r9d
               	jne	<addr>
               	imulq	$0xa, %r9, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movl	-0x108(%rbp), %edi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0xe, -0x100(%rbp)
               	leaq	<rip>, %rax
               	movl	(%rax,%rcx,4), %esi
               	movq	%rsi, %rdi
               	shrq	%rdi
               	movl	$0x92492493, %r8d       # imm = 0x92492493
               	imulq	%rdi, %r8
               	movq	%r8, %r9
               	shrq	$0x22, %r9
               	movl	-0x100(%rbp), %eax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpl	%eax, %r9d
               	jne	<addr>
               	imulq	$0xe, %r9, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movl	-0x100(%rbp), %edi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x64, -0xf8(%rbp)
               	leaq	<rip>, %rax
               	movl	(%rax,%rcx,4), %esi
               	movq	%rsi, %rdi
               	shrq	$0x2, %rdi
               	imulq	$0xa3d70a4, %rdi, %r8   # imm = 0xA3D70A4
               	movq	%r8, %r9
               	shrq	$0x20, %r9
               	movl	-0xf8(%rbp), %eax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpl	%eax, %r9d
               	jne	<addr>
               	imulq	$0x64, %r9, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movl	-0xf8(%rbp), %edi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x3e8, -0xf0(%rbp)     # imm = 0x3E8
               	leaq	<rip>, %rax
               	movl	(%rax,%rcx,4), %esi
               	movq	%rsi, %rdi
               	shrq	$0x3, %rdi
               	imulq	$0x10624dd3, %rdi, %r8  # imm = 0x10624DD3
               	movq	%r8, %r9
               	shrq	$0x23, %r9
               	movl	-0xf0(%rbp), %eax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpl	%eax, %r9d
               	jne	<addr>
               	imulq	$0x3e8, %r9, %rax       # imm = 0x3E8
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movl	-0xf0(%rbp), %edi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%esi, %esi
               	cmpl	$0x14, %esi
               	jge	<addr>
               	movl	$0x7fffffff, -0xe8(%rbp) # imm = 0x7FFFFFFF
               	leaq	<rip>, %rax
               	movl	(%rax,%rsi,4), %ecx
               	leaq	(%rcx,%rcx,2), %r8
               	movq	%r8, %rdi
               	shrq	$0x20, %rdi
               	movq	%rcx, %r9
               	subq	%rdi, %r9
               	movq	%r9, %rax
               	shrq	%rax
               	leaq	(%rax,%rdi), %rdx
               	movq	%rdx, %rbx
               	shrq	$0x1e, %rbx
               	movl	-0xe8(%rbp), %r12d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpl	%r12d, %ebx
               	jne	<addr>
               	imulq	$0x7fffffff, %rbx, %rax # imm = 0x7FFFFFFF
               	movq	%rcx, %r8
               	subq	%rax, %r8
               	movl	-0xe8(%rbp), %edi
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rsi
               	cmpl	$0x14, %esi
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x80000001, -0xe0(%rbp) # imm = 0x80000001
               	leaq	<rip>, %rax
               	movl	(%rax,%rcx,4), %esi
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	movq	%rsi, %rdi
               	cmpl	%r11d, %esi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	-0xe0(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpl	%eax, %edi
               	jne	<addr>
               	movl	$0x80000001, %eax       # imm = 0x80000001
               	imulq	%rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movl	-0xe0(%rbp), %edi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0xfffffffb, -0xd8(%rbp) # imm = 0xFFFFFFFB
               	leaq	<rip>, %rax
               	movl	(%rax,%rcx,4), %esi
               	movl	$0xfffffffb, %r11d      # imm = 0xFFFFFFFB
               	movq	%rsi, %rdi
               	cmpl	%r11d, %esi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	-0xd8(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpl	%eax, %edi
               	jne	<addr>
               	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
               	imulq	%rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movl	-0xd8(%rbp), %edi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x1, -0xd0(%rbp)
               	leaq	<rip>, %rax
               	movl	(%rax,%rcx,4), %esi
               	movl	-0xd0(%rbp), %edi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpl	%eax, %esi
               	jne	<addr>
               	movl	-0xd0(%rbp), %edi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	testq	%rdx, %rdx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x10, -0xc8(%rbp)
               	leaq	<rip>, %rax
               	movl	(%rax,%rcx,4), %esi
               	movq	%rsi, %rdi
               	shrq	$0x4, %rdi
               	movl	-0xc8(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpl	%eax, %edi
               	jne	<addr>
               	movq	%rsi, %r8
               	andq	$0xf, %r8
               	movl	-0xc8(%rbp), %edi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movq	$0x3, -0xc0(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555556, %r8 # imm = 0x5555555555555556
               	movq	%rsi, %rax
               	imulq	%r8
               	movq	%rdx, %rdi
               	movq	%rdi, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdi,%r9), %rax
               	movq	-0xc0(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	leaq	(%rax,%rax,2), %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0xc0(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movq	$0x7, -0xb8(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x4924924924924925, %r8 # imm = 0x4924924924924925
               	movq	%rsi, %rax
               	imulq	%r8
               	movq	%rdx, %r9
               	movq	%r9, %rdi
               	sarq	%rdi
               	movq	%rdi, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdi,%rax), %rdx
               	movq	-0xb8(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %rdx
               	jne	<addr>
               	imulq	$0x7, %rdx, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0xb8(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movq	$0xa, -0xb0(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x6666666666666667, %r8 # imm = 0x6666666666666667
               	movq	%rsi, %rax
               	imulq	%r8
               	movq	%rdx, %r9
               	movq	%r9, %rdi
               	sarq	$0x2, %rdi
               	movq	%rdi, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdi,%rax), %rdx
               	movq	-0xb0(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %rdx
               	jne	<addr>
               	imulq	$0xa, %rdx, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0xb0(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movq	$0x3e8, -0xa8(%rbp)     # imm = 0x3E8
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x20c49ba5e353f7cf, %r8 # imm = 0x20C49BA5E353F7CF
               	movq	%rsi, %rax
               	imulq	%r8
               	movq	%rdx, %r9
               	movq	%r9, %rdi
               	sarq	$0x7, %rdi
               	movq	%rdi, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdi,%rax), %rdx
               	movq	-0xa8(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %rdx
               	jne	<addr>
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0xa8(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movq	$0x3b9aca07, -0xa0(%rbp) # imm = 0x3B9ACA07
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$-0x768fa0ceed5d701b, %r8 # imm = 0x89705F3112A28FE5
               	movq	%rsi, %rax
               	imulq	%r8
               	movq	%rdx, %r9
               	leaq	(%r9,%rsi), %rax
               	movq	%rax, %rdi
               	sarq	$0x1d, %rdi
               	movq	%rdi, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rdi,%rdx), %rbx
               	movq	-0xa0(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rbx
               	jne	<addr>
               	imulq	$0x3b9aca07, %rbx, %rax # imm = 0x3B9ACA07
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0xa0(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rax, -0x98(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x4000000000000001, %r8 # imm = 0x4000000000000001
               	movq	%rsi, %rax
               	imulq	%r8
               	movq	%rdx, %r9
               	movq	%r9, %rdi
               	sarq	$0x3d, %rdi
               	movq	%rdi, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdi,%rax), %rdx
               	movq	-0x98(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %rdx
               	jne	<addr>
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	imulq	%rdx, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x98(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%r8d, %r8d
               	movq	%r8, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movq	$-0x3, -0x90(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555556, %r9 # imm = 0x5555555555555556
               	movq	%rsi, %rax
               	imulq	%r9
               	movq	%rdx, %rdi
               	movq	%rdi, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdi,%rax), %rdx
               	movq	%r8, %rbx
               	subq	%rdx, %rbx
               	movq	-0x90(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rbx
               	jne	<addr>
               	xorl	%eax, %eax
               	subq	%rdx, %rax
               	imulq	$-0x3, %rax, %rax
               	movq	%rsi, %r9
               	subq	%rax, %r9
               	movq	-0x90(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r9
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%r8d, %r8d
               	movq	%r8, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movq	$-0x7, -0x88(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x4924924924924925, %r9 # imm = 0x4924924924924925
               	movq	%rsi, %rax
               	imulq	%r9
               	movq	%rdx, %rdi
               	sarq	%rdi
               	movq	%rdi, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdi,%rax), %rbx
               	movq	%r8, %r12
               	subq	%rbx, %r12
               	movq	-0x88(%rbp), %r13
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r13
               	movq	%rax, %r13
               	popq	%rdx
               	popq	%rax
               	cmpq	%r13, %r12
               	jne	<addr>
               	xorl	%eax, %eax
               	subq	%rbx, %rax
               	imulq	$-0x7, %rax, %rax
               	movq	%rsi, %r9
               	subq	%rax, %r9
               	movq	-0x88(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r9
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%r8d, %r8d
               	movq	%r8, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movq	$-0x3b9aca07, -0x80(%rbp) # imm = 0xC46535F9
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$-0x768fa0ceed5d701b, %r9 # imm = 0x89705F3112A28FE5
               	movq	%rsi, %rax
               	imulq	%r9
               	leaq	(%rdx,%rsi), %rax
               	movq	%rax, %rdi
               	sarq	$0x1d, %rdi
               	movq	%rdi, %rbx
               	shrq	$0x3f, %rbx
               	leaq	(%rdi,%rbx), %r12
               	negq	%r12
               	addq	%r8, %r12
               	movq	-0x80(%rbp), %r13
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r13
               	movq	%rax, %r13
               	popq	%rdx
               	popq	%rax
               	cmpq	%r13, %r12
               	jne	<addr>
               	leaq	(%rdi,%rbx), %rax
               	xorl	%edx, %edx
               	subq	%rax, %rdx
               	imulq	$-0x3b9aca07, %rdx, %rax # imm = 0xC46535F9
               	movq	%rsi, %r9
               	subq	%rax, %r9
               	movq	-0x80(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r9
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%r8d, %r8d
               	movq	%r8, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, -0x78(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movq	%rsi, %r9
               	sarq	$0x3f, %r9
               	movq	%r9, %rdi
               	shrq	%rdi
               	leaq	(%rsi,%rdi), %rax
               	movq	%rax, %rdx
               	sarq	$0x3f, %rdx
               	negq	%rdx
               	addq	%r8, %rdx
               	movq	-0x78(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %rdx
               	jne	<addr>
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%r11, %rax
               	movq	%rax, %r9
               	subq	%rdi, %r9
               	movq	-0x78(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r9
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movq	$0x1, -0x70(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movq	-0x70(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rax, %rsi
               	jne	<addr>
               	movq	-0x70(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	testq	%rdx, %rdx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movq	$0x400, -0x68(%rbp)     # imm = 0x400
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movq	%rsi, %r8
               	sarq	$0x3f, %r8
               	movq	%r8, %rdi
               	shrq	$0x36, %rdi
               	leaq	(%rsi,%rdi), %r9
               	movq	%r9, %rax
               	sarq	$0xa, %rax
               	movq	-0x68(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movq	%r9, %rax
               	andq	$0x3ff, %rax            # imm = 0x3FF
               	movq	%rax, %r8
               	subq	%rdi, %r8
               	movq	-0x68(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%r8d, %r8d
               	movq	%r8, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movq	$-0x400, -0x60(%rbp)    # imm = 0xFC00
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movq	%rsi, %r9
               	sarq	$0x3f, %r9
               	movq	%r9, %rdi
               	shrq	$0x36, %rdi
               	leaq	(%rsi,%rdi), %rax
               	movq	%rax, %rdx
               	sarq	$0xa, %rdx
               	negq	%rdx
               	addq	%r8, %rdx
               	movq	-0x60(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %rdx
               	jne	<addr>
               	andq	$0x3ff, %rax            # imm = 0x3FF
               	movq	%rax, %r9
               	subq	%rdi, %r9
               	movq	-0x60(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r9
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movq	$0x3, -0x58(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$-0x5555555555555555, %rdi # imm = 0xAAAAAAAAAAAAAAAB
               	movq	%rsi, %rax
               	mulq	%rdi
               	movq	%rdx, %r8
               	movq	%r8, %r9
               	shrq	%r9
               	movq	-0x58(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpq	%rax, %r9
               	jne	<addr>
               	leaq	(%r9,%r9,2), %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x58(%rbp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movq	$0x7, -0x50(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x2492492492492493, %r8 # imm = 0x2492492492492493
               	movq	%rsi, %rax
               	mulq	%r8
               	movq	%rdx, %rdi
               	movq	%rsi, %r9
               	subq	%rdi, %r9
               	movq	%r9, %rax
               	shrq	%rax
               	leaq	(%rax,%rdi), %rdx
               	movq	%rdx, %rbx
               	shrq	$0x2, %rbx
               	movq	-0x50(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rbx
               	jne	<addr>
               	imulq	$0x7, %rbx, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x50(%rbp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movq	$0xa, -0x48(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movq	%rsi, %rdi
               	shrq	%rdi
               	movabsq	$0x6666666666666667, %r8 # imm = 0x6666666666666667
               	movq	%rdi, %rax
               	mulq	%r8
               	movq	%rdx, %r9
               	movq	%r9, %rax
               	shrq	%rax
               	movq	-0x48(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	imulq	$0xa, %rax, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x48(%rbp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movq	$0xe, -0x40(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movq	%rsi, %rdi
               	shrq	%rdi
               	movabsq	$0x4924924924924925, %r8 # imm = 0x4924924924924925
               	movq	%rdi, %rax
               	mulq	%r8
               	movq	%rdx, %r9
               	movq	%r9, %rax
               	shrq	%rax
               	movq	-0x40(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	imulq	$0xe, %rax, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x40(%rbp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movq	$0x3b9aca07, -0x38(%rbp) # imm = 0x3B9ACA07
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$-0x768fa0ceed5d701b, %rdi # imm = 0x89705F3112A28FE5
               	movq	%rsi, %rax
               	mulq	%rdi
               	movq	%rdx, %r8
               	movq	%r8, %r9
               	shrq	$0x1d, %r9
               	movq	-0x38(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpq	%rax, %r9
               	jne	<addr>
               	imulq	$0x3b9aca07, %r9, %rax  # imm = 0x3B9ACA07
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x38(%rbp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movabsq	$-0x7fffffffffffffff, %rax # imm = 0x8000000000000001
               	movq	%rax, -0x30(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$-0x7fffffffffffffff, %r11 # imm = 0x8000000000000001
               	movq	%rsi, %rdi
               	cmpq	%r11, %rsi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	-0x30(%rbp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	movabsq	$-0x7fffffffffffffff, %rax # imm = 0x8000000000000001
               	imulq	%rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x30(%rbp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movq	$-0x5, -0x28(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	cmpq	$-0x5, %rsi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	-0x28(%rbp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$-0x5, %rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x28(%rbp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movq	$0x1, -0x20(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movq	-0x20(%rbp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rax, %rsi
               	jne	<addr>
               	movq	-0x20(%rbp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	testq	%rdx, %rdx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movq	$0x400, -0x18(%rbp)     # imm = 0x400
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movq	%rsi, %rdi
               	shrq	$0xa, %rdi
               	movq	-0x18(%rbp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	movq	%rsi, %r8
               	andq	$0x3ff, %r8             # imm = 0x3FF
               	movq	-0x18(%rbp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	$0xffffcfc7, -0x10(%rbp) # imm = 0xFFFFCFC7
               	movabsq	$-0x11f71fb04cb, %rax   # imm = 0xFFFFFEE08E04FB35
               	movq	%rax, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	cmpq	$0x3039, %rdx           # imm = 0x3039
               	jne	<addr>
               	movslq	-0x10(%rbp), %rcx
               	movq	-0x8(%rbp), %rcx
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	movabsq	$0x11f71fb04cb, %r11    # imm = 0x11F71FB04CB
               	movq	%rdx, %rcx
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movq	-0x8(%rbp), %rcx
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x5b, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x5a, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
