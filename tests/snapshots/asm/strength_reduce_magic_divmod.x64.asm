
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
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdi
               	leaq	<rip>, %r8
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rsi,%rdx), %r9
               	addq	%rcx, %rdx
               	movq	(%rdx), %rdx
               	movq	%rdx, (%r9)
               	movq	(%rcx,%rax,8), %rdx
               	movl	%edx, (%rdi,%rax,4)
               	movq	(%rcx,%rax,8), %rdx
               	movl	%edx, (%r8,%rax,4)
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1b0, %rsp            # imm = 0x1B0
               	callq	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x3, -0x1a8(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x55555556, %rsi, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movslq	-0x1a8(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	(%rdi,%rdi,2), %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movslq	-0x1a8(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x5, -0x1a0(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x66666667, %rsi, %rax # imm = 0x66666667
               	sarq	$0x21, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movslq	-0x1a0(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	(%rdi,%rdi,4), %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movslq	-0x1a0(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x6, -0x198(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x2aaaaaab, %rsi, %rax # imm = 0x2AAAAAAB
               	sarq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movslq	-0x198(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0x6, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movslq	-0x198(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x7, -0x190(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	movl	$0x92492493, %eax       # imm = 0x92492493
               	imulq	%rsi, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movslq	-0x190(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0x7, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movslq	-0x190(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0xa, -0x188(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x66666667, %rsi, %rax # imm = 0x66666667
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movslq	-0x188(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0xa, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movslq	-0x188(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x64, -0x180(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x51eb851f, %rsi, %rax # imm = 0x51EB851F
               	sarq	$0x25, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movslq	-0x180(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0x64, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movslq	-0x180(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x3e8, -0x178(%rbp)    # imm = 0x3E8
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x10624dd3, %rsi, %rax # imm = 0x10624DD3
               	sarq	$0x26, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movslq	-0x178(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0x3e8, %rdi, %rax      # imm = 0x3E8
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movslq	-0x178(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0xffff, -0x170(%rbp)   # imm = 0xFFFF
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	movl	$0x80008001, %eax       # imm = 0x80008001
               	imulq	%rsi, %rax
               	sarq	$0x2f, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movslq	-0x170(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0xffff, %rdi, %rax     # imm = 0xFFFF
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movslq	-0x170(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x10001, -0x168(%rbp)  # imm = 0x10001
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x7fff8001, %rsi, %rax # imm = 0x7FFF8001
               	sarq	$0x2f, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movslq	-0x168(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0x10001, %rdi, %rax    # imm = 0x10001
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movslq	-0x168(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x7fffffff, -0x160(%rbp) # imm = 0x7FFFFFFF
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x40000001, %rsi, %rax # imm = 0x40000001
               	sarq	$0x3d, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movslq	-0x160(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0x7fffffff, %rdi, %rax # imm = 0x7FFFFFFF
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movslq	-0x160(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rcx
               	movl	$0xfffffffd, -0x158(%rbp) # imm = 0xFFFFFFFD
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x55555556, %rsi, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %r8
               	movq	%rdi, %r9
               	subq	%r8, %r9
               	movslq	-0x158(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %r9
               	jne	<addr>
               	xorl	%eax, %eax
               	subq	%r8, %rax
               	imulq	$-0x3, %rax, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movslq	-0x158(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rcx
               	movl	$0xfffffff9, -0x150(%rbp) # imm = 0xFFFFFFF9
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	movl	$0x92492493, %eax       # imm = 0x92492493
               	imulq	%rsi, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %r8
               	movq	%rdi, %r9
               	subq	%r8, %r9
               	movslq	-0x150(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %r9
               	jne	<addr>
               	xorl	%eax, %eax
               	subq	%r8, %rax
               	imulq	$-0x7, %rax, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movslq	-0x150(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rcx
               	movl	$0xffffff9c, -0x148(%rbp) # imm = 0xFFFFFF9C
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x51eb851f, %rsi, %rax # imm = 0x51EB851F
               	sarq	$0x25, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %r8
               	movq	%rdi, %r9
               	subq	%r8, %r9
               	movslq	-0x148(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %r9
               	jne	<addr>
               	xorl	%eax, %eax
               	subq	%r8, %rax
               	imulq	$-0x64, %rax, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movslq	-0x148(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rcx
               	movl	$0x80000000, -0x140(%rbp) # imm = 0x80000000
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	movq	%rsi, %r8
               	shrq	$0x21, %r8
               	leaq	(%rsi,%r8), %r9
               	movq	%r9, %rax
               	sarq	$0x1f, %rax
               	negq	%rax
               	addq	%rdi, %rax
               	movslq	-0x140(%rbp), %rdx
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
               	andq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	movq	%rax, %r9
               	subq	%r8, %r9
               	movslq	-0x140(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
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
               	xorl	%edi, %edi
               	movq	%rdi, %rcx
               	movl	$0xfffffff8, -0x128(%rbp) # imm = 0xFFFFFFF8
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rsi
               	movq	%rsi, %r8
               	shrq	$0x3d, %r8
               	leaq	(%rsi,%r8), %r9
               	movq	%r9, %rax
               	sarq	$0x3, %rax
               	negq	%rax
               	addq	%rdi, %rax
               	movslq	-0x128(%rbp), %rdx
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
               	andq	$0x7, %rax
               	movq	%rax, %r9
               	subq	%r8, %r9
               	movslq	-0x128(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
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
               	movl	$0x3, -0x118(%rbp)
               	leaq	<rip>, %rax
               	movl	(%rax,%rcx,4), %esi
               	movl	$0xaaaaaaab, %eax       # imm = 0xAAAAAAAB
               	imulq	%rsi, %rax
               	movq	%rax, %rdi
               	shrq	$0x21, %rdi
               	movl	-0x118(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpl	%eax, %edi
               	jne	<addr>
               	leaq	(%rdi,%rdi,2), %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	-0x118(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x7, -0x110(%rbp)
               	leaq	<rip>, %rax
               	movl	(%rax,%rcx,4), %esi
               	imulq	$0x24924925, %rsi, %rax # imm = 0x24924925
               	shrq	$0x20, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	shrq	%rdx
               	addq	%rdx, %rax
               	movq	%rax, %rdi
               	shrq	$0x2, %rdi
               	movl	-0x110(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0x7, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	-0x110(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0xa, -0x108(%rbp)
               	leaq	<rip>, %rax
               	movl	(%rax,%rcx,4), %esi
               	movq	%rsi, %rax
               	shrq	%rax
               	imulq	$0x66666667, %rax, %rax # imm = 0x66666667
               	movq	%rax, %rdi
               	shrq	$0x21, %rdi
               	movl	-0x108(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0xa, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	-0x108(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0xe, -0x100(%rbp)
               	leaq	<rip>, %rax
               	movl	(%rax,%rcx,4), %esi
               	movq	%rsi, %rax
               	shrq	%rax
               	movl	$0x92492493, %r11d      # imm = 0x92492493
               	imulq	%r11, %rax
               	movq	%rax, %rdi
               	shrq	$0x22, %rdi
               	movl	-0x100(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0xe, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	-0x100(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x64, -0xf8(%rbp)
               	leaq	<rip>, %rax
               	movl	(%rax,%rcx,4), %esi
               	movq	%rsi, %rax
               	shrq	$0x2, %rax
               	imulq	$0xa3d70a4, %rax, %rax  # imm = 0xA3D70A4
               	movq	%rax, %rdi
               	shrq	$0x20, %rdi
               	movl	-0xf8(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0x64, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	-0xf8(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x3e8, -0xf0(%rbp)     # imm = 0x3E8
               	leaq	<rip>, %rax
               	movl	(%rax,%rcx,4), %esi
               	movq	%rsi, %rax
               	shrq	$0x3, %rax
               	imulq	$0x10624dd3, %rax, %rax # imm = 0x10624DD3
               	movq	%rax, %rdi
               	shrq	$0x23, %rdi
               	movl	-0xf0(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0x3e8, %rdi, %rax      # imm = 0x3E8
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	-0xf0(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x7fffffff, -0xe8(%rbp) # imm = 0x7FFFFFFF
               	leaq	<rip>, %rax
               	movl	(%rax,%rcx,4), %esi
               	leaq	(%rsi,%rsi,2), %rax
               	shrq	$0x20, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	shrq	%rdx
               	addq	%rdx, %rax
               	movq	%rax, %rdi
               	shrq	$0x1e, %rdi
               	movl	-0xe8(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0x7fffffff, %rdi, %rax # imm = 0x7FFFFFFF
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	-0xe8(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
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
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	-0xe0(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
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
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	-0xd8(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
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
               	movq	%rsi, %rdi
               	andq	$0xf, %rdi
               	movl	-0xc8(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movq	$0x3, -0xc0(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555556, %rdi # imm = 0x5555555555555556
               	movq	%rsi, %rax
               	imulq	%rdi
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdx,%rax), %rdi
               	movq	-0xc0(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	(%rdi,%rdi,2), %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	-0xc0(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movq	$0x7, -0xb8(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x4924924924924925, %rdi # imm = 0x4924924924924925
               	movq	%rsi, %rax
               	imulq	%rdi
               	movq	%rdx, %rax
               	sarq	%rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movq	-0xb8(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0x7, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	-0xb8(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movq	$0xa, -0xb0(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x6666666666666667, %rdi # imm = 0x6666666666666667
               	movq	%rsi, %rax
               	imulq	%rdi
               	movq	%rdx, %rax
               	sarq	$0x2, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movq	-0xb0(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0xa, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	-0xb0(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movq	$0x3e8, -0xa8(%rbp)     # imm = 0x3E8
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x20c49ba5e353f7cf, %rdi # imm = 0x20C49BA5E353F7CF
               	movq	%rsi, %rax
               	imulq	%rdi
               	movq	%rdx, %rax
               	sarq	$0x7, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movq	-0xa8(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0x3e8, %rdi, %rax      # imm = 0x3E8
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	-0xa8(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movq	$0x3b9aca07, -0xa0(%rbp) # imm = 0x3B9ACA07
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$-0x768fa0ceed5d701b, %rdi # imm = 0x89705F3112A28FE5
               	movq	%rsi, %rax
               	imulq	%rdi
               	leaq	(%rdx,%rsi), %rax
               	sarq	$0x1d, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movq	-0xa0(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0x3b9aca07, %rdi, %rax # imm = 0x3B9ACA07
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	-0xa0(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rax, -0x98(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x4000000000000001, %rdi # imm = 0x4000000000000001
               	movq	%rsi, %rax
               	imulq	%rdi
               	movq	%rdx, %rax
               	sarq	$0x3d, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movq	-0x98(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	imulq	%rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	-0x98(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rcx
               	movq	$-0x3, -0x90(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555556, %r8 # imm = 0x5555555555555556
               	movq	%rsi, %rax
               	imulq	%r8
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdx,%rax), %r8
               	movq	%rdi, %r9
               	subq	%r8, %r9
               	movq	-0x90(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %r9
               	jne	<addr>
               	xorl	%eax, %eax
               	subq	%r8, %rax
               	imulq	$-0x3, %rax, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x90(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rcx
               	movq	$-0x7, -0x88(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x4924924924924925, %r8 # imm = 0x4924924924924925
               	movq	%rsi, %rax
               	imulq	%r8
               	movq	%rdx, %rax
               	sarq	%rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %r8
               	movq	%rdi, %r9
               	subq	%r8, %r9
               	movq	-0x88(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %r9
               	jne	<addr>
               	xorl	%eax, %eax
               	subq	%r8, %rax
               	imulq	$-0x7, %rax, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x88(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
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
               	movq	$-0x3b9aca07, -0x80(%rbp) # imm = 0xC46535F9
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rcx
               	movabsq	$-0x768fa0ceed5d701b, %rdi # imm = 0x89705F3112A28FE5
               	movq	%rcx, %rax
               	imulq	%rdi
               	leaq	(%rdx,%rcx), %rax
               	movq	%rax, %rdi
               	sarq	$0x1d, %rdi
               	movq	%rdi, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdi,%r9), %rax
               	negq	%rax
               	addq	%r8, %rax
               	movq	-0x80(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	leaq	(%rdi,%r9), %rax
               	xorl	%edx, %edx
               	subq	%rax, %rdx
               	imulq	$-0x3b9aca07, %rdx, %rax # imm = 0xC46535F9
               	movq	%rcx, %rdi
               	subq	%rax, %rdi
               	movq	-0x80(%rbp), %r9
               	movq	%rcx, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rsi
               	cmpl	$0x14, %esi
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rcx
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, -0x78(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movq	%rsi, %rax
               	sarq	$0x3f, %rax
               	movq	%rax, %r8
               	shrq	%r8
               	leaq	(%rsi,%r8), %r9
               	movq	%r9, %rax
               	sarq	$0x3f, %rax
               	negq	%rax
               	addq	%rdi, %rax
               	movq	-0x78(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%r9, %rax
               	movq	%rax, %r9
               	subq	%r8, %r9
               	movq	-0x78(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
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
               	movq	$0x400, -0x68(%rbp)     # imm = 0x400
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movq	%rsi, %rax
               	sarq	$0x3f, %rax
               	movq	%rax, %rdi
               	shrq	$0x36, %rdi
               	leaq	(%rsi,%rdi), %r8
               	movq	%r8, %r9
               	sarq	$0xa, %r9
               	movq	-0x68(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %r9
               	jne	<addr>
               	movq	%r8, %rax
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
               	xorl	%edi, %edi
               	movq	%rdi, %rcx
               	movq	$-0x400, -0x60(%rbp)    # imm = 0xFC00
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movq	%rsi, %rax
               	sarq	$0x3f, %rax
               	movq	%rax, %r8
               	shrq	$0x36, %r8
               	leaq	(%rsi,%r8), %r9
               	movq	%r9, %rax
               	sarq	$0xa, %rax
               	negq	%rax
               	addq	%rdi, %rax
               	movq	-0x60(%rbp), %rdx
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
               	movq	%rax, %r9
               	subq	%r8, %r9
               	movq	-0x60(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
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
               	movq	$0x3, -0x58(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$-0x5555555555555555, %rdi # imm = 0xAAAAAAAAAAAAAAAB
               	movq	%rsi, %rax
               	mulq	%rdi
               	movq	%rdx, %rdi
               	shrq	%rdi
               	movq	-0x58(%rbp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	(%rdi,%rdi,2), %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	-0x58(%rbp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movq	$0x7, -0x50(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x2492492492492493, %rdi # imm = 0x2492492492492493
               	movq	%rsi, %rax
               	mulq	%rdi
               	movq	%rsi, %rax
               	subq	%rdx, %rax
               	shrq	%rax
               	addq	%rdx, %rax
               	movq	%rax, %rdi
               	shrq	$0x2, %rdi
               	movq	-0x50(%rbp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0x7, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	-0x50(%rbp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movq	$0xa, -0x48(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movq	%rsi, %rax
               	shrq	%rax
               	movabsq	$0x6666666666666667, %rdi # imm = 0x6666666666666667
               	mulq	%rdi
               	movq	%rdx, %rdi
               	shrq	%rdi
               	movq	-0x48(%rbp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0xa, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	-0x48(%rbp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movq	$0xe, -0x40(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movq	%rsi, %rax
               	shrq	%rax
               	movabsq	$0x4924924924924925, %rdi # imm = 0x4924924924924925
               	mulq	%rdi
               	movq	%rdx, %rdi
               	shrq	%rdi
               	movq	-0x40(%rbp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0xe, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	-0x40(%rbp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movq	$0x3b9aca07, -0x38(%rbp) # imm = 0x3B9ACA07
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$-0x768fa0ceed5d701b, %rdi # imm = 0x89705F3112A28FE5
               	movq	%rsi, %rax
               	mulq	%rdi
               	movq	%rdx, %rdi
               	shrq	$0x1d, %rdi
               	movq	-0x38(%rbp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0x3b9aca07, %rdi, %rax # imm = 0x3B9ACA07
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	-0x38(%rbp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
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
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	-0x30(%rbp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
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
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	-0x28(%rbp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
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
               	movq	%rsi, %rdi
               	andq	$0x3ff, %rdi            # imm = 0x3FF
               	movq	-0x18(%rbp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
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
               	leave
               	retq
               	movl	$0x5b, %eax
               	leave
               	retq
               	movl	$0x5a, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
