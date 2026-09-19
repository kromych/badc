
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
               	leaq	<rip>, %rdx
               	xorq	%rax, %rax
               	movq	%rax, (%rdx)
               	movl	$0x1, %ecx
               	movq	%rcx, 0x8(%rdx)
               	movabsq	$-0x1, %rcx
               	movq	%rcx, 0x10(%rdx)
               	movl	$0x2, %ecx
               	movq	%rcx, 0x18(%rdx)
               	movabsq	$-0x2, %rcx
               	movq	%rcx, 0x20(%rdx)
               	movl	$0x7fffffff, %ecx       # imm = 0x7FFFFFFF
               	movq	%rcx, 0x28(%rdx)
               	movabsq	$-0x80000000, %rcx      # imm = 0x80000000
               	movq	%rcx, 0x30(%rdx)
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rcx, 0x38(%rdx)
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%rcx, 0x40(%rdx)
               	movl	$0x3b9aca07, %ecx       # imm = 0x3B9ACA07
               	movq	%rcx, 0x48(%rdx)
               	movabsq	$-0x3b9aca07, %rcx      # imm = 0xC46535F9
               	movq	%rcx, 0x50(%rdx)
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movq	%rcx, 0x58(%rdx)
               	movabsq	$0x2ceaee21bf46bc00, %rcx # imm = 0x2CEAEE21BF46BC00
               	movq	%rcx, 0x60(%rdx)
               	movabsq	$-0x557f8ab2e5e572b1, %rcx # imm = 0xAA80754D1A1A8D4F
               	movq	%rcx, 0x68(%rdx)
               	movabsq	$-0x4c3b6fb592d876ce, %rcx # imm = 0xB3C4904A6D278932
               	movq	%rcx, 0x70(%rdx)
               	movabsq	$-0x439630bd897b92e7, %rcx # imm = 0xBC69CF4276846D19
               	movq	%rcx, 0x78(%rdx)
               	movabsq	$0x377b2fd56a5b15b4, %rcx # imm = 0x377B2FD56A5B15B4
               	movq	%rcx, 0x80(%rdx)
               	movabsq	$0x64d815deeaf29df3, %rcx # imm = 0x64D815DEEAF29DF3
               	movq	%rcx, 0x88(%rdx)
               	movabsq	$-0x991eff24d282dfa, %rcx # imm = 0xF66E100DB2D7D206
               	movq	%rcx, 0x90(%rdx)
               	movabsq	$0x1069e6a57e06665d, %rcx # imm = 0x1069E6A57E06665D
               	movq	%rcx, 0x98(%rdx)
               	cmpl	$0x14, %eax
               	jge	<addr>
               	leaq	<rip>, %rdi
               	movslq	%eax, %rcx
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdi
               	addq	%rdx, %rsi
               	movq	(%rsi), %rsi
               	movq	%rsi, (%rdi)
               	leaq	<rip>, %rdi
               	movq	(%rdx,%rcx,8), %rsi
               	movl	%esi, (%rdi,%rcx,4)
               	leaq	<rip>, %rsi
               	movq	(%rdx,%rcx,8), %rdi
               	movl	%edi, %edi
               	movl	%edi, (%rsi,%rcx,4)
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1d0, %rsp            # imm = 0x1D0
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x3, %eax
               	movl	%eax, -0x1a8(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movslq	(%rax,%rdx,4), %rax
               	imulq	$0x55555556, %rax, %rsi # imm = 0x55555556
               	movq	%rsi, %rdx
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	leaq	(%rdx,%rdi), %r8
               	movslq	-0x1a8(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpq	%r9, %r8
               	jne	<addr>
               	leaq	(%r8,%r8,2), %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movslq	-0x1a8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x5, %eax
               	movl	%eax, -0x1a0(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movslq	(%rax,%rdx,4), %rax
               	imulq	$0x66666667, %rax, %rsi # imm = 0x66666667
               	movq	%rsi, %rdx
               	sarq	$0x21, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	leaq	(%rdx,%rdi), %r8
               	movslq	-0x1a0(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpq	%r9, %r8
               	jne	<addr>
               	leaq	(%r8,%r8,4), %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movslq	-0x1a0(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x6, %eax
               	movl	%eax, -0x198(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movslq	(%rax,%rdx,4), %rax
               	imulq	$0x2aaaaaab, %rax, %rsi # imm = 0x2AAAAAAB
               	movq	%rsi, %rdx
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	leaq	(%rdx,%rdi), %r8
               	movslq	-0x198(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpq	%r9, %r8
               	jne	<addr>
               	imulq	$0x6, %r8, %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movslq	-0x198(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x7, %eax
               	movl	%eax, -0x190(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movslq	(%rax,%rdx,4), %rax
               	movl	$0x92492493, %esi       # imm = 0x92492493
               	imulq	%rax, %rsi
               	movq	%rsi, %rdx
               	sarq	$0x22, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	leaq	(%rdx,%rdi), %r8
               	movslq	-0x190(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpq	%r9, %r8
               	jne	<addr>
               	imulq	$0x7, %r8, %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movslq	-0x190(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0xa, %eax
               	movl	%eax, -0x188(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movslq	(%rax,%rdx,4), %rax
               	imulq	$0x66666667, %rax, %rsi # imm = 0x66666667
               	movq	%rsi, %rdx
               	sarq	$0x22, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	leaq	(%rdx,%rdi), %r8
               	movslq	-0x188(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpq	%r9, %r8
               	jne	<addr>
               	imulq	$0xa, %r8, %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movslq	-0x188(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x64, %eax
               	movl	%eax, -0x180(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movslq	(%rax,%rdx,4), %rax
               	imulq	$0x51eb851f, %rax, %rsi # imm = 0x51EB851F
               	movq	%rsi, %rdx
               	sarq	$0x25, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	leaq	(%rdx,%rdi), %r8
               	movslq	-0x180(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpq	%r9, %r8
               	jne	<addr>
               	imulq	$0x64, %r8, %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movslq	-0x180(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x3e8, %eax            # imm = 0x3E8
               	movl	%eax, -0x178(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movslq	(%rax,%rdx,4), %rax
               	imulq	$0x10624dd3, %rax, %rsi # imm = 0x10624DD3
               	movq	%rsi, %rdx
               	sarq	$0x26, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	leaq	(%rdx,%rdi), %r8
               	movslq	-0x178(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpq	%r9, %r8
               	jne	<addr>
               	imulq	$0x3e8, %r8, %rdx       # imm = 0x3E8
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movslq	-0x178(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0xffff, %eax           # imm = 0xFFFF
               	movl	%eax, -0x170(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movslq	(%rax,%rdx,4), %rax
               	movl	$0x80008001, %esi       # imm = 0x80008001
               	imulq	%rax, %rsi
               	movq	%rsi, %rdx
               	sarq	$0x2f, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	leaq	(%rdx,%rdi), %r8
               	movslq	-0x170(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpq	%r9, %r8
               	jne	<addr>
               	imulq	$0xffff, %r8, %rdx      # imm = 0xFFFF
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movslq	-0x170(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x10001, %eax          # imm = 0x10001
               	movl	%eax, -0x168(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movslq	(%rax,%rdx,4), %rax
               	imulq	$0x7fff8001, %rax, %rsi # imm = 0x7FFF8001
               	movq	%rsi, %rdx
               	sarq	$0x2f, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	leaq	(%rdx,%rdi), %r8
               	movslq	-0x168(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpq	%r9, %r8
               	jne	<addr>
               	imulq	$0x10001, %r8, %rdx     # imm = 0x10001
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movslq	-0x168(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
               	movl	%eax, -0x160(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movslq	(%rax,%rdx,4), %rax
               	imulq	$0x40000001, %rax, %rsi # imm = 0x40000001
               	movq	%rsi, %rdx
               	sarq	$0x3d, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	leaq	(%rdx,%rdi), %r8
               	movslq	-0x160(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpq	%r9, %r8
               	jne	<addr>
               	imulq	$0x7fffffff, %r8, %rdx  # imm = 0x7FFFFFFF
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movslq	-0x160(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movabsq	$-0x3, %rax
               	movl	%eax, -0x158(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movslq	(%rax,%rdx,4), %rax
               	imulq	$0x55555556, %rax, %rdi # imm = 0x55555556
               	movq	%rdi, %rdx
               	sarq	$0x20, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %r9
               	movq	%rsi, %rbx
               	subq	%r9, %rbx
               	movslq	-0x158(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rbx
               	jne	<addr>
               	xorq	%rdx, %rdx
               	subq	%r9, %rdx
               	imulq	$-0x3, %rdx, %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movslq	-0x158(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movabsq	$-0x7, %rax
               	movl	%eax, -0x150(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movslq	(%rax,%rdx,4), %rax
               	movl	$0x92492493, %edi       # imm = 0x92492493
               	imulq	%rax, %rdi
               	movq	%rdi, %rdx
               	sarq	$0x22, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %r9
               	movq	%rsi, %rbx
               	subq	%r9, %rbx
               	movslq	-0x150(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rbx
               	jne	<addr>
               	xorq	%rdx, %rdx
               	subq	%r9, %rdx
               	imulq	$-0x7, %rdx, %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movslq	-0x150(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movabsq	$-0x64, %rax
               	movl	%eax, -0x148(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movslq	(%rax,%rdx,4), %rax
               	imulq	$0x51eb851f, %rax, %rdi # imm = 0x51EB851F
               	movq	%rdi, %rdx
               	sarq	$0x25, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %r9
               	movq	%rsi, %rbx
               	subq	%r9, %rbx
               	movslq	-0x148(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rbx
               	jne	<addr>
               	xorq	%rdx, %rdx
               	subq	%r9, %rdx
               	imulq	$-0x64, %rdx, %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movslq	-0x148(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movabsq	$-0x80000000, %rax      # imm = 0x80000000
               	movl	%eax, -0x140(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movslq	(%rax,%rdx,4), %rax
               	movq	%rax, %rdx
               	shrq	$0x21, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movq	%rdi, %r8
               	sarq	$0x1f, %r8
               	movq	%r8, %r10
               	movq	%rsi, %r8
               	subq	%r10, %r8
               	movslq	-0x140(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpq	%r9, %r8
               	jne	<addr>
               	andq	$0x7fffffff, %rdi       # imm = 0x7FFFFFFF
               	subq	%rdx, %rdi
               	movslq	-0x140(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x1, %ecx
               	movl	%ecx, -0x138(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movslq	(%rcx,%rdx,4), %rcx
               	movslq	-0x138(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movslq	-0x138(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x8, %eax
               	movl	%eax, -0x130(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movslq	(%rax,%rdx,4), %rax
               	movq	%rax, %rdx
               	shrq	$0x3d, %rdx
               	leaq	(%rax,%rdx), %rsi
               	movq	%rsi, %rdi
               	sarq	$0x3, %rdi
               	movslq	-0x130(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	cmpq	%r8, %rdi
               	jne	<addr>
               	andq	$0x7, %rsi
               	subq	%rdx, %rsi
               	movslq	-0x130(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movabsq	$-0x8, %rax
               	movl	%eax, -0x128(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movslq	(%rax,%rdx,4), %rax
               	movq	%rax, %rdx
               	shrq	$0x3d, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movq	%rdi, %r8
               	sarq	$0x3, %r8
               	movq	%r8, %r10
               	movq	%rsi, %r8
               	subq	%r10, %r8
               	movslq	-0x128(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpq	%r9, %r8
               	jne	<addr>
               	andq	$0x7, %rdi
               	subq	%rdx, %rdi
               	movslq	-0x128(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movl	%eax, -0x120(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movslq	(%rax,%rdx,4), %rax
               	movq	%rax, %rdx
               	shrq	$0x22, %rdx
               	leaq	(%rax,%rdx), %rsi
               	movq	%rsi, %rdi
               	sarq	$0x1e, %rdi
               	movslq	-0x120(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	cmpq	%r8, %rdi
               	jne	<addr>
               	andq	$0x3fffffff, %rsi       # imm = 0x3FFFFFFF
               	subq	%rdx, %rsi
               	movslq	-0x120(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x3, %eax
               	movl	%eax, -0x118(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movl	(%rax,%rdx,4), %eax
               	movl	$0xaaaaaaab, %edx       # imm = 0xAAAAAAAB
               	imulq	%rax, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x21, %rsi
               	movl	-0x118(%rbp), %edi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	leaq	(%rsi,%rsi,2), %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movl	-0x118(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x7, %eax
               	movl	%eax, -0x110(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movl	(%rax,%rdx,4), %eax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	movq	%rsi, %rdx
               	shrq	$0x20, %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movq	%rdi, %r8
               	shrq	%r8
               	leaq	(%r8,%rdx), %r9
               	movq	%r9, %rbx
               	shrq	$0x2, %rbx
               	movl	-0x110(%rbp), %r12d
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rbx
               	jne	<addr>
               	imulq	$0x7, %rbx, %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movl	-0x110(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0xa, %eax
               	movl	%eax, -0x108(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movl	(%rax,%rdx,4), %eax
               	movq	%rax, %rdx
               	shrq	%rdx
               	imulq	$0x66666667, %rdx, %rsi # imm = 0x66666667
               	movq	%rsi, %rdi
               	shrq	$0x21, %rdi
               	movl	-0x108(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	cmpq	%r8, %rdi
               	jne	<addr>
               	imulq	$0xa, %rdi, %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movl	-0x108(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0xe, %eax
               	movl	%eax, -0x100(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movl	(%rax,%rdx,4), %eax
               	movq	%rax, %rdx
               	shrq	%rdx
               	movl	$0x92492493, %esi       # imm = 0x92492493
               	imulq	%rdx, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x22, %rdi
               	movl	-0x100(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	cmpq	%r8, %rdi
               	jne	<addr>
               	imulq	$0xe, %rdi, %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movl	-0x100(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x64, %eax
               	movl	%eax, -0xf8(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movl	(%rax,%rdx,4), %eax
               	movq	%rax, %rdx
               	shrq	$0x2, %rdx
               	imulq	$0xa3d70a4, %rdx, %rsi  # imm = 0xA3D70A4
               	movq	%rsi, %rdi
               	shrq	$0x20, %rdi
               	movl	-0xf8(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	cmpq	%r8, %rdi
               	jne	<addr>
               	imulq	$0x64, %rdi, %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movl	-0xf8(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x3e8, %eax            # imm = 0x3E8
               	movl	%eax, -0xf0(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movl	(%rax,%rdx,4), %eax
               	movq	%rax, %rdx
               	shrq	$0x3, %rdx
               	imulq	$0x10624dd3, %rdx, %rsi # imm = 0x10624DD3
               	movq	%rsi, %rdi
               	shrq	$0x23, %rdi
               	movl	-0xf0(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	cmpq	%r8, %rdi
               	jne	<addr>
               	imulq	$0x3e8, %rdi, %rdx      # imm = 0x3E8
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movl	-0xf0(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
               	movl	%eax, -0xe8(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movl	(%rax,%rdx,4), %eax
               	leaq	(%rax,%rax,2), %rsi
               	movq	%rsi, %rdx
               	shrq	$0x20, %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movq	%rdi, %r8
               	shrq	%r8
               	leaq	(%r8,%rdx), %r9
               	movq	%r9, %rbx
               	shrq	$0x1e, %rbx
               	movl	-0xe8(%rbp), %r12d
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rbx
               	jne	<addr>
               	imulq	$0x7fffffff, %rbx, %rdx # imm = 0x7FFFFFFF
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movl	-0xe8(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x80000001, %eax       # imm = 0x80000001
               	movl	%eax, -0xe0(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movl	(%rax,%rdx,4), %eax
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	movq	%rax, %rdx
               	cmpl	%r11d, %eax
               	setae	%dl
               	movzbq	%dl, %rdx
               	movl	-0xe0(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	imulq	%r11, %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movl	-0xe0(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
               	movl	%eax, -0xd8(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movl	(%rax,%rdx,4), %eax
               	movl	$0xfffffffb, %r11d      # imm = 0xFFFFFFFB
               	movq	%rax, %rdx
               	cmpl	%r11d, %eax
               	setae	%dl
               	movzbq	%dl, %rdx
               	movl	-0xd8(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movl	$0xfffffffb, %r11d      # imm = 0xFFFFFFFB
               	imulq	%r11, %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movl	-0xd8(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x1, %ecx
               	movl	%ecx, -0xd0(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movl	(%rcx,%rdx,4), %ecx
               	movl	-0xd0(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movl	-0xd0(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x10, %ecx
               	movl	%ecx, -0xc8(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movl	(%rcx,%rdx,4), %ecx
               	movq	%rcx, %rdx
               	shrq	$0x4, %rdx
               	movl	-0xc8(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movq	%rcx, %rsi
               	andq	$0xf, %rsi
               	movl	-0xc8(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x3, %ecx
               	movq	%rcx, -0xc0(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$0x5555555555555556, %rsi # imm = 0x5555555555555556
               	pushq	%rax
               	movq	%rcx, %rax
               	imulq	%rsi
               	popq	%rax
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	leaq	(%rdx,%rdi), %r8
               	movq	-0xc0(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpq	%r9, %r8
               	jne	<addr>
               	leaq	(%r8,%r8,2), %rdx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movq	-0xc0(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x7, %ecx
               	movq	%rcx, -0xb8(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$0x4924924924924925, %rsi # imm = 0x4924924924924925
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%rsi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	%rdi, %rdx
               	sarq	%rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %r9
               	movq	-0xb8(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r9
               	jne	<addr>
               	imulq	$0x7, %r9, %rdx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movq	-0xb8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0xa, %ecx
               	movq	%rcx, -0xb0(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$0x6666666666666667, %rsi # imm = 0x6666666666666667
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%rsi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	%rdi, %rdx
               	sarq	$0x2, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %r9
               	movq	-0xb0(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r9
               	jne	<addr>
               	imulq	$0xa, %r9, %rdx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movq	-0xb0(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x3e8, %ecx            # imm = 0x3E8
               	movq	%rcx, -0xa8(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$0x20c49ba5e353f7cf, %rsi # imm = 0x20C49BA5E353F7CF
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%rsi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	%rdi, %rdx
               	sarq	$0x7, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %r9
               	movq	-0xa8(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r9
               	jne	<addr>
               	imulq	$0x3e8, %r9, %rdx       # imm = 0x3E8
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movq	-0xa8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x3b9aca07, %eax       # imm = 0x3B9ACA07
               	movq	%rax, -0xa0(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movabsq	$-0x768fa0ceed5d701b, %rsi # imm = 0x89705F3112A28FE5
               	pushq	%rax
               	pushq	%rdx
               	imulq	%rsi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	leaq	(%rdi,%rax), %r8
               	movq	%r8, %rdx
               	sarq	$0x1d, %rdx
               	movq	%rdx, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdx,%r9), %rbx
               	movq	-0xa0(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rbx
               	jne	<addr>
               	imulq	$0x3b9aca07, %rbx, %rdx # imm = 0x3B9ACA07
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movq	-0xa0(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rcx, -0x98(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$0x4000000000000001, %rsi # imm = 0x4000000000000001
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%rsi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	%rdi, %rdx
               	sarq	$0x3d, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %r9
               	movq	-0x98(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r9
               	jne	<addr>
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	imulq	%r9, %rdx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movq	-0x98(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, %rax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movabsq	$-0x3, %rcx
               	movq	%rcx, -0x90(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$0x5555555555555556, %rdi # imm = 0x5555555555555556
               	pushq	%rax
               	movq	%rcx, %rax
               	imulq	%rdi
               	popq	%rax
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %r9
               	movq	%rsi, %rbx
               	subq	%r9, %rbx
               	movq	-0x90(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rbx
               	jne	<addr>
               	xorq	%rdx, %rdx
               	subq	%r9, %rdx
               	imulq	$-0x3, %rdx, %rdx
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
               	movq	-0x90(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, %rax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movabsq	$-0x7, %rcx
               	movq	%rcx, -0x88(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$0x4924924924924925, %rdi # imm = 0x4924924924924925
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%rdi
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %rdx
               	sarq	%rdx
               	movq	%rdx, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdx,%r9), %rbx
               	movq	%rsi, %r12
               	subq	%rbx, %r12
               	movq	-0x88(%rbp), %r13
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r13
               	movq	%rax, %r13
               	popq	%rdx
               	popq	%rax
               	cmpq	%r13, %r12
               	jne	<addr>
               	xorq	%rdx, %rdx
               	subq	%rbx, %rdx
               	imulq	$-0x7, %rdx, %rdx
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
               	movq	-0x88(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movabsq	$-0x3b9aca07, %rax      # imm = 0xC46535F9
               	movq	%rax, -0x80(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movabsq	$-0x768fa0ceed5d701b, %rdi # imm = 0x89705F3112A28FE5
               	pushq	%rax
               	pushq	%rdx
               	imulq	%rdi
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	leaq	(%r8,%rax), %r9
               	movq	%r9, %rdx
               	sarq	$0x1d, %rdx
               	movq	%rdx, %rbx
               	shrq	$0x3f, %rbx
               	leaq	(%rdx,%rbx), %r12
               	movq	%r12, %r10
               	movq	%rsi, %r12
               	subq	%r10, %r12
               	movq	-0x80(%rbp), %r13
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r13
               	movq	%rax, %r13
               	popq	%rdx
               	popq	%rax
               	cmpq	%r13, %r12
               	jne	<addr>
               	addq	%rbx, %rdx
               	xorq	%rdi, %rdi
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	imulq	$-0x3b9aca07, %rdx, %rdx # imm = 0xC46535F9
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movq	-0x80(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, -0x78(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movq	%rax, %rdi
               	sarq	$0x3f, %rdi
               	movq	%rdi, %rdx
               	shrq	%rdx
               	leaq	(%rax,%rdx), %r8
               	movq	%r8, %r9
               	sarq	$0x3f, %r9
               	movq	%r9, %r10
               	movq	%rsi, %r9
               	subq	%r10, %r9
               	movq	-0x78(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r9
               	jne	<addr>
               	movabsq	$0x7fffffffffffffff, %rdi # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%r8, %rdi
               	subq	%rdx, %rdi
               	movq	-0x78(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, -0x70(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movq	-0x70(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	-0x70(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x400, %ecx            # imm = 0x400
               	movq	%rcx, -0x68(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movq	%rcx, %rsi
               	sarq	$0x3f, %rsi
               	movq	%rsi, %rdx
               	shrq	$0x36, %rdx
               	leaq	(%rcx,%rdx), %rdi
               	movq	%rdi, %r8
               	sarq	$0xa, %r8
               	movq	-0x68(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpq	%r9, %r8
               	jne	<addr>
               	movq	%rdi, %rsi
               	andq	$0x3ff, %rsi            # imm = 0x3FF
               	subq	%rdx, %rsi
               	movq	-0x68(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movabsq	$-0x400, %rax           # imm = 0xFC00
               	movq	%rax, -0x60(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movq	%rax, %rdi
               	sarq	$0x3f, %rdi
               	movq	%rdi, %rdx
               	shrq	$0x36, %rdx
               	leaq	(%rax,%rdx), %r8
               	movq	%r8, %r9
               	sarq	$0xa, %r9
               	movq	%r9, %r10
               	movq	%rsi, %r9
               	subq	%r10, %r9
               	movq	-0x60(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r9
               	jne	<addr>
               	movq	%r8, %rdi
               	andq	$0x3ff, %rdi            # imm = 0x3FF
               	subq	%rdx, %rdi
               	movq	-0x60(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x3, %ecx
               	movq	%rcx, -0x58(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$-0x5555555555555555, %rdx # imm = 0xAAAAAAAAAAAAAAAB
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	mulq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rsi, %rdi
               	shrq	%rdi
               	movq	-0x58(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	(%rdi,%rdi,2), %rdx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movq	-0x58(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x7, %eax
               	movq	%rax, -0x50(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movabsq	$0x2492492492492493, %rsi # imm = 0x2492492492492493
               	pushq	%rax
               	mulq	%rsi
               	popq	%rax
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movq	%rdi, %r8
               	shrq	%r8
               	leaq	(%r8,%rdx), %r9
               	movq	%r9, %rbx
               	shrq	$0x2, %rbx
               	movq	-0x50(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rbx
               	jne	<addr>
               	imulq	$0x7, %rbx, %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movq	-0x50(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0xa, %ecx
               	movq	%rcx, -0x48(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movq	%rcx, %rdx
               	shrq	%rdx
               	movabsq	$0x6666666666666667, %rsi # imm = 0x6666666666666667
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	mulq	%rsi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	%rdi, %r8
               	shrq	%r8
               	movq	-0x48(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpq	%r9, %r8
               	jne	<addr>
               	imulq	$0xa, %r8, %rdx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movq	-0x48(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0xe, %ecx
               	movq	%rcx, -0x40(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movq	%rcx, %rdx
               	shrq	%rdx
               	movabsq	$0x4924924924924925, %rsi # imm = 0x4924924924924925
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	mulq	%rsi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	%rdi, %r8
               	shrq	%r8
               	movq	-0x40(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpq	%r9, %r8
               	jne	<addr>
               	imulq	$0xe, %r8, %rdx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movq	-0x40(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x3b9aca07, %ecx       # imm = 0x3B9ACA07
               	movq	%rcx, -0x38(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$-0x768fa0ceed5d701b, %rdx # imm = 0x89705F3112A28FE5
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	mulq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rsi, %rdi
               	shrq	$0x1d, %rdi
               	movq	-0x38(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	cmpq	%r8, %rdi
               	jne	<addr>
               	imulq	$0x3b9aca07, %rdi, %rdx # imm = 0x3B9ACA07
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movq	-0x38(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movabsq	$-0x7fffffffffffffff, %rcx # imm = 0x8000000000000001
               	movq	%rcx, -0x30(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$-0x7fffffffffffffff, %r11 # imm = 0x8000000000000001
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	setae	%dl
               	movzbq	%dl, %rdx
               	movq	-0x30(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movabsq	$-0x7fffffffffffffff, %r11 # imm = 0x8000000000000001
               	imulq	%r11, %rdx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movq	-0x30(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movabsq	$-0x5, %rcx
               	movq	%rcx, -0x28(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	cmpq	$-0x5, %rcx
               	setae	%dl
               	movzbq	%dl, %rdx
               	movq	-0x28(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	imulq	$-0x5, %rdx, %rdx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movq	-0x28(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, -0x20(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movq	-0x20(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	-0x20(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x400, %ecx            # imm = 0x400
               	movq	%rcx, -0x18(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movq	%rcx, %rdx
               	shrq	$0xa, %rdx
               	movq	-0x18(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movq	%rcx, %rsi
               	andq	$0x3ff, %rsi            # imm = 0x3FF
               	movq	-0x18(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	movabsq	$-0x3039, %rax          # imm = 0xCFC7
               	movl	%eax, -0x10(%rbp)
               	movabsq	$-0x11f71fb04cb, %rax   # imm = 0xFFFFFEE08E04FB35
               	movq	%rax, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rcx
               	xorq	%rax, %rax
               	movq	%rcx, %r10
               	movq	%rax, %rcx
               	subq	%r10, %rcx
               	cmpq	$0x3039, %rcx           # imm = 0x3039
               	jne	<addr>
               	movslq	-0x10(%rbp), %rcx
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %r10
               	movq	%rax, %rcx
               	subq	%r10, %rcx
               	movabsq	$0x11f71fb04cb, %r11    # imm = 0x11F71FB04CB
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movq	-0x8(%rbp), %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x5b, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x5a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
