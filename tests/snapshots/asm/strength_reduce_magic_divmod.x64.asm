
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x3, -0x1a8(%rbp)
               	leaq	<rip>, %rcx
               	movslq	(%rcx,%rax,4), %rcx
               	imulq	$0x55555556, %rcx, %rsi # imm = 0x55555556
               	movq	%rsi, %rdx
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	leaq	(%rdx,%rdi), %r8
               	movslq	-0x1a8(%rbp), %r9
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
               	movslq	-0x1a8(%rbp), %rdx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x5, -0x1a0(%rbp)
               	leaq	<rip>, %rcx
               	movslq	(%rcx,%rax,4), %rcx
               	imulq	$0x66666667, %rcx, %rsi # imm = 0x66666667
               	movq	%rsi, %rdx
               	sarq	$0x21, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	leaq	(%rdx,%rdi), %r8
               	movslq	-0x1a0(%rbp), %r9
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
               	leaq	(%r8,%r8,4), %rdx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movslq	-0x1a0(%rbp), %rdx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x6, -0x198(%rbp)
               	leaq	<rip>, %rcx
               	movslq	(%rcx,%rax,4), %rcx
               	imulq	$0x2aaaaaab, %rcx, %rsi # imm = 0x2AAAAAAB
               	movq	%rsi, %rdx
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	leaq	(%rdx,%rdi), %r8
               	movslq	-0x198(%rbp), %r9
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
               	imulq	$0x6, %r8, %rdx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movslq	-0x198(%rbp), %rdx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x7, -0x190(%rbp)
               	leaq	<rip>, %rcx
               	movslq	(%rcx,%rax,4), %rcx
               	movl	$0x92492493, %esi       # imm = 0x92492493
               	imulq	%rcx, %rsi
               	movq	%rsi, %rdx
               	sarq	$0x22, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	leaq	(%rdx,%rdi), %r8
               	movslq	-0x190(%rbp), %r9
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
               	imulq	$0x7, %r8, %rdx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movslq	-0x190(%rbp), %rdx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0xa, -0x188(%rbp)
               	leaq	<rip>, %rcx
               	movslq	(%rcx,%rax,4), %rcx
               	imulq	$0x66666667, %rcx, %rsi # imm = 0x66666667
               	movq	%rsi, %rdx
               	sarq	$0x22, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	leaq	(%rdx,%rdi), %r8
               	movslq	-0x188(%rbp), %r9
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
               	imulq	$0xa, %r8, %rdx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movslq	-0x188(%rbp), %rdx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x64, -0x180(%rbp)
               	leaq	<rip>, %rcx
               	movslq	(%rcx,%rax,4), %rcx
               	imulq	$0x51eb851f, %rcx, %rsi # imm = 0x51EB851F
               	movq	%rsi, %rdx
               	sarq	$0x25, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	leaq	(%rdx,%rdi), %r8
               	movslq	-0x180(%rbp), %r9
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
               	imulq	$0x64, %r8, %rdx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movslq	-0x180(%rbp), %rdx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x3e8, -0x178(%rbp)    # imm = 0x3E8
               	leaq	<rip>, %rcx
               	movslq	(%rcx,%rax,4), %rcx
               	imulq	$0x10624dd3, %rcx, %rsi # imm = 0x10624DD3
               	movq	%rsi, %rdx
               	sarq	$0x26, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	leaq	(%rdx,%rdi), %r8
               	movslq	-0x178(%rbp), %r9
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
               	imulq	$0x3e8, %r8, %rdx       # imm = 0x3E8
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movslq	-0x178(%rbp), %rdx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0xffff, -0x170(%rbp)   # imm = 0xFFFF
               	leaq	<rip>, %rcx
               	movslq	(%rcx,%rax,4), %rcx
               	movl	$0x80008001, %esi       # imm = 0x80008001
               	imulq	%rcx, %rsi
               	movq	%rsi, %rdx
               	sarq	$0x2f, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	leaq	(%rdx,%rdi), %r8
               	movslq	-0x170(%rbp), %r9
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
               	imulq	$0xffff, %r8, %rdx      # imm = 0xFFFF
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movslq	-0x170(%rbp), %rdx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x10001, -0x168(%rbp)  # imm = 0x10001
               	leaq	<rip>, %rcx
               	movslq	(%rcx,%rax,4), %rcx
               	imulq	$0x7fff8001, %rcx, %rsi # imm = 0x7FFF8001
               	movq	%rsi, %rdx
               	sarq	$0x2f, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	leaq	(%rdx,%rdi), %r8
               	movslq	-0x168(%rbp), %r9
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
               	imulq	$0x10001, %r8, %rdx     # imm = 0x10001
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movslq	-0x168(%rbp), %rdx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x7fffffff, -0x160(%rbp) # imm = 0x7FFFFFFF
               	leaq	<rip>, %rcx
               	movslq	(%rcx,%rax,4), %rcx
               	imulq	$0x40000001, %rcx, %rsi # imm = 0x40000001
               	movq	%rsi, %rdx
               	sarq	$0x3d, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	leaq	(%rdx,%rdi), %r8
               	movslq	-0x160(%rbp), %r9
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
               	imulq	$0x7fffffff, %r8, %rdx  # imm = 0x7FFFFFFF
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movslq	-0x160(%rbp), %rdx
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
               	xorl	%esi, %esi
               	movq	%rsi, %rax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0xfffffffd, -0x158(%rbp) # imm = 0xFFFFFFFD
               	leaq	<rip>, %rcx
               	movslq	(%rcx,%rax,4), %rcx
               	imulq	$0x55555556, %rcx, %rdi # imm = 0x55555556
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
               	movq	%rcx, %rax
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rbx
               	jne	<addr>
               	xorl	%edx, %edx
               	subq	%r9, %rdx
               	imulq	$-0x3, %rdx, %rdx
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
               	movslq	-0x158(%rbp), %rdx
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
               	xorl	%esi, %esi
               	movq	%rsi, %rax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0xfffffff9, -0x150(%rbp) # imm = 0xFFFFFFF9
               	leaq	<rip>, %rcx
               	movslq	(%rcx,%rax,4), %rcx
               	movl	$0x92492493, %edi       # imm = 0x92492493
               	imulq	%rcx, %rdi
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
               	movq	%rcx, %rax
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rbx
               	jne	<addr>
               	xorl	%edx, %edx
               	subq	%r9, %rdx
               	imulq	$-0x7, %rdx, %rdx
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
               	movslq	-0x150(%rbp), %rdx
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
               	xorl	%esi, %esi
               	movq	%rsi, %rax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0xffffff9c, -0x148(%rbp) # imm = 0xFFFFFF9C
               	leaq	<rip>, %rcx
               	movslq	(%rcx,%rax,4), %rcx
               	imulq	$0x51eb851f, %rcx, %rdi # imm = 0x51EB851F
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
               	movq	%rcx, %rax
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rbx
               	jne	<addr>
               	xorl	%edx, %edx
               	subq	%r9, %rdx
               	imulq	$-0x64, %rdx, %rdx
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
               	movslq	-0x148(%rbp), %rdx
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
               	xorl	%esi, %esi
               	movq	%rsi, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x80000000, -0x140(%rbp) # imm = 0x80000000
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rax
               	movq	%rax, %rdx
               	shrq	$0x21, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movq	%rdi, %r8
               	sarq	$0x1f, %r8
               	movq	%rsi, %r9
               	subq	%r8, %r9
               	movslq	-0x140(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	cmpq	%r8, %r9
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x1, -0x138(%rbp)
               	leaq	<rip>, %rcx
               	movslq	(%rcx,%rax,4), %rcx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x8, -0x130(%rbp)
               	leaq	<rip>, %rcx
               	movslq	(%rcx,%rax,4), %rcx
               	movq	%rcx, %rdx
               	shrq	$0x3d, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	movq	%rsi, %rdi
               	sarq	$0x3, %rdi
               	movslq	-0x130(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
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
               	xorl	%esi, %esi
               	movq	%rsi, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0xfffffff8, -0x128(%rbp) # imm = 0xFFFFFFF8
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rax
               	movq	%rax, %rdx
               	shrq	$0x3d, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movq	%rdi, %r8
               	sarq	$0x3, %r8
               	movq	%rsi, %r9
               	subq	%r8, %r9
               	movslq	-0x128(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	cmpq	%r8, %r9
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x40000000, -0x120(%rbp) # imm = 0x40000000
               	leaq	<rip>, %rcx
               	movslq	(%rcx,%rax,4), %rcx
               	movq	%rcx, %rdx
               	shrq	$0x22, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	movq	%rsi, %rdi
               	sarq	$0x1e, %rdi
               	movslq	-0x120(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x3, -0x118(%rbp)
               	leaq	<rip>, %rcx
               	movl	(%rcx,%rax,4), %ecx
               	movl	$0xaaaaaaab, %edx       # imm = 0xAAAAAAAB
               	imulq	%rcx, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x21, %rsi
               	movl	-0x118(%rbp), %edi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpl	%edi, %esi
               	jne	<addr>
               	leaq	(%rsi,%rsi,2), %rdx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movl	-0x118(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
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
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x7, -0x110(%rbp)
               	leaq	<rip>, %rax
               	movl	(%rax,%rcx,4), %eax
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
               	xorl	%edx, %edx
               	divq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpl	%r12d, %ebx
               	jne	<addr>
               	imulq	$0x7, %rbx, %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movl	-0x110(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorl	%edx, %edx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0xa, -0x108(%rbp)
               	leaq	<rip>, %rcx
               	movl	(%rcx,%rax,4), %ecx
               	movq	%rcx, %rdx
               	shrq	%rdx
               	imulq	$0x66666667, %rdx, %rsi # imm = 0x66666667
               	movq	%rsi, %rdi
               	shrq	$0x21, %rdi
               	movl	-0x108(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	cmpl	%r8d, %edi
               	jne	<addr>
               	imulq	$0xa, %rdi, %rdx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movl	-0x108(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0xe, -0x100(%rbp)
               	leaq	<rip>, %rcx
               	movl	(%rcx,%rax,4), %ecx
               	movq	%rcx, %rdx
               	shrq	%rdx
               	movl	$0x92492493, %esi       # imm = 0x92492493
               	imulq	%rdx, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x22, %rdi
               	movl	-0x100(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	cmpl	%r8d, %edi
               	jne	<addr>
               	imulq	$0xe, %rdi, %rdx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movl	-0x100(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x64, -0xf8(%rbp)
               	leaq	<rip>, %rcx
               	movl	(%rcx,%rax,4), %ecx
               	movq	%rcx, %rdx
               	shrq	$0x2, %rdx
               	imulq	$0xa3d70a4, %rdx, %rsi  # imm = 0xA3D70A4
               	movq	%rsi, %rdi
               	shrq	$0x20, %rdi
               	movl	-0xf8(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	cmpl	%r8d, %edi
               	jne	<addr>
               	imulq	$0x64, %rdi, %rdx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movl	-0xf8(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x3e8, -0xf0(%rbp)     # imm = 0x3E8
               	leaq	<rip>, %rcx
               	movl	(%rcx,%rax,4), %ecx
               	movq	%rcx, %rdx
               	shrq	$0x3, %rdx
               	imulq	$0x10624dd3, %rdx, %rsi # imm = 0x10624DD3
               	movq	%rsi, %rdi
               	shrq	$0x23, %rdi
               	movl	-0xf0(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	cmpl	%r8d, %edi
               	jne	<addr>
               	imulq	$0x3e8, %rdi, %rdx      # imm = 0x3E8
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movl	-0xf0(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
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
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x7fffffff, -0xe8(%rbp) # imm = 0x7FFFFFFF
               	leaq	<rip>, %rax
               	movl	(%rax,%rcx,4), %eax
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
               	xorl	%edx, %edx
               	divq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpl	%r12d, %ebx
               	jne	<addr>
               	imulq	$0x7fffffff, %rbx, %rdx # imm = 0x7FFFFFFF
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movl	-0xe8(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorl	%edx, %edx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x80000001, -0xe0(%rbp) # imm = 0x80000001
               	leaq	<rip>, %rcx
               	movl	(%rcx,%rax,4), %ecx
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	movq	%rcx, %rdx
               	cmpl	%r11d, %ecx
               	setae	%dl
               	movzbq	%dl, %rdx
               	movl	-0xe0(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpl	%esi, %edx
               	jne	<addr>
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	imulq	%r11, %rdx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movl	-0xe0(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0xfffffffb, -0xd8(%rbp) # imm = 0xFFFFFFFB
               	leaq	<rip>, %rcx
               	movl	(%rcx,%rax,4), %ecx
               	movl	$0xfffffffb, %r11d      # imm = 0xFFFFFFFB
               	movq	%rcx, %rdx
               	cmpl	%r11d, %ecx
               	setae	%dl
               	movzbq	%dl, %rdx
               	movl	-0xd8(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpl	%esi, %edx
               	jne	<addr>
               	movl	$0xfffffffb, %r11d      # imm = 0xFFFFFFFB
               	imulq	%r11, %rdx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movl	-0xd8(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x1, -0xd0(%rbp)
               	leaq	<rip>, %rcx
               	movl	(%rcx,%rax,4), %ecx
               	movl	-0xd0(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movl	-0xd0(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movl	$0x10, -0xc8(%rbp)
               	leaq	<rip>, %rcx
               	movl	(%rcx,%rax,4), %ecx
               	movq	%rcx, %rdx
               	shrq	$0x4, %rdx
               	movl	-0xc8(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpl	%esi, %edx
               	jne	<addr>
               	movq	%rcx, %rsi
               	andq	$0xf, %rsi
               	movl	-0xc8(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movq	$0x3, -0xc0(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movq	$0x7, -0xb8(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movq	$0xa, -0xb0(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movq	$0x3e8, -0xa8(%rbp)     # imm = 0x3E8
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movq	$0x3b9aca07, -0xa0(%rbp) # imm = 0x3B9ACA07
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$-0x768fa0ceed5d701b, %rsi # imm = 0x89705F3112A28FE5
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%rsi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	leaq	(%rdi,%rcx), %r8
               	movq	%r8, %rdx
               	sarq	$0x1d, %rdx
               	movq	%rdx, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdx,%r9), %rbx
               	movq	-0xa0(%rbp), %r12
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
               	imulq	$0x3b9aca07, %rbx, %rdx # imm = 0x3B9ACA07
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movq	-0xa0(%rbp), %rdx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rcx, -0x98(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
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
               	xorl	%esi, %esi
               	movq	%rsi, %rax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movq	$-0x3, -0x90(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
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
               	xorl	%edx, %edx
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
               	xorl	%esi, %esi
               	movq	%rsi, %rax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movq	$-0x7, -0x88(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
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
               	xorl	%edx, %edx
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
               	xorl	%esi, %esi
               	movq	%rsi, %rax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movq	$-0x3b9aca07, -0x80(%rbp) # imm = 0xC46535F9
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$-0x768fa0ceed5d701b, %rdi # imm = 0x89705F3112A28FE5
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%rdi
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	leaq	(%r8,%rcx), %r9
               	movq	%r9, %rdx
               	sarq	$0x1d, %rdx
               	movq	%rdx, %rbx
               	shrq	$0x3f, %rbx
               	leaq	(%rdx,%rbx), %r12
               	negq	%r12
               	addq	%rsi, %r12
               	movq	-0x80(%rbp), %r13
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
               	addq	%rbx, %rdx
               	xorl	%edi, %edi
               	subq	%rdx, %rdi
               	imulq	$-0x3b9aca07, %rdi, %rdx # imm = 0xC46535F9
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
               	movq	-0x80(%rbp), %rdx
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
               	xorl	%esi, %esi
               	movq	%rsi, %rax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%rcx, -0x78(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movq	%rcx, %rdi
               	sarq	$0x3f, %rdi
               	movq	%rdi, %rdx
               	shrq	%rdx
               	leaq	(%rcx,%rdx), %r8
               	movq	%r8, %r9
               	sarq	$0x3f, %r9
               	negq	%r9
               	addq	%rsi, %r9
               	movq	-0x78(%rbp), %rbx
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
               	movabsq	$0x7fffffffffffffff, %rdi # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%r8, %rdi
               	subq	%rdx, %rdi
               	movq	-0x78(%rbp), %rdx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movq	$0x1, -0x70(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movq	$0x400, -0x68(%rbp)     # imm = 0x400
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
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
               	xorl	%esi, %esi
               	movq	%rsi, %rax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movq	$-0x400, -0x60(%rbp)    # imm = 0xFC00
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movq	%rcx, %rdi
               	sarq	$0x3f, %rdi
               	movq	%rdi, %rdx
               	shrq	$0x36, %rdx
               	leaq	(%rcx,%rdx), %r8
               	movq	%r8, %r9
               	sarq	$0xa, %r9
               	negq	%r9
               	addq	%rsi, %r9
               	movq	-0x60(%rbp), %rbx
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
               	movq	%r8, %rdi
               	andq	$0x3ff, %rdi            # imm = 0x3FF
               	subq	%rdx, %rdi
               	movq	-0x60(%rbp), %rdx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movq	$0x3, -0x58(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
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
               	xorl	%edx, %edx
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
               	xorl	%edx, %edx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movq	$0x7, -0x50(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x2492492492492493, %rsi # imm = 0x2492492492492493
               	pushq	%rax
               	movq	%rcx, %rax
               	mulq	%rsi
               	popq	%rax
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
               	movq	%rdi, %r8
               	shrq	%r8
               	leaq	(%r8,%rdx), %r9
               	movq	%r9, %rbx
               	shrq	$0x2, %rbx
               	movq	-0x50(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rbx
               	jne	<addr>
               	imulq	$0x7, %rbx, %rdx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movq	-0x50(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movq	$0xa, -0x48(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
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
               	xorl	%edx, %edx
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
               	xorl	%edx, %edx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movq	$0xe, -0x40(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
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
               	xorl	%edx, %edx
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
               	xorl	%edx, %edx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movq	$0x3b9aca07, -0x38(%rbp) # imm = 0x3B9ACA07
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
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
               	xorl	%edx, %edx
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
               	xorl	%edx, %edx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movabsq	$-0x7fffffffffffffff, %rcx # imm = 0x8000000000000001
               	movq	%rcx, -0x30(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$-0x7fffffffffffffff, %r11 # imm = 0x8000000000000001
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	setae	%dl
               	movzbq	%dl, %rdx
               	movq	-0x30(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
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
               	xorl	%edx, %edx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movq	$-0x5, -0x28(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	cmpq	$-0x5, %rcx
               	setae	%dl
               	movzbq	%dl, %rdx
               	movq	-0x28(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
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
               	xorl	%edx, %edx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movq	$0x1, -0x20(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movq	-0x20(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	xorl	%edx, %edx
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
               	xorl	%edx, %edx
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
               	xorl	%eax, %eax
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movq	$0x400, -0x18(%rbp)     # imm = 0x400
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movq	%rcx, %rdx
               	shrq	$0xa, %rdx
               	movq	-0x18(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
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
               	xorl	%edx, %edx
               	divq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x14, %eax
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
