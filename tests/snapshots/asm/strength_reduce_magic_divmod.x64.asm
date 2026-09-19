
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
               	xorl	%eax, %eax
               	movq	%rax, (%rdx)
               	movl	$0x1, %ecx
               	movq	%rcx, 0x8(%rdx)
               	movq	$-0x1, %rcx
               	movq	%rcx, 0x10(%rdx)
               	movl	$0x2, %ecx
               	movq	%rcx, 0x18(%rdx)
               	movq	$-0x2, %rcx
               	movq	%rcx, 0x20(%rdx)
               	movl	$0x7fffffff, %ecx       # imm = 0x7FFFFFFF
               	movq	%rcx, 0x28(%rdx)
               	movq	$-0x80000000, %rcx      # imm = 0x80000000
               	movq	%rcx, 0x30(%rdx)
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rcx, 0x38(%rdx)
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%rcx, 0x40(%rdx)
               	movl	$0x3b9aca07, %ecx       # imm = 0x3B9ACA07
               	movq	%rcx, 0x48(%rdx)
               	movq	$-0x3b9aca07, %rcx      # imm = 0xC46535F9
               	movq	%rcx, 0x50(%rdx)
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movq	%rcx, 0x58(%rdx)
               	movabsq	$0x2ceaee21bf46bc00, %rsi # imm = 0x2CEAEE21BF46BC00
               	leaq	<rip>, %rcx
               	movq	%rsi, 0x60(%rcx)
               	movabsq	$-0x557f8ab2e5e572b1, %rsi # imm = 0xAA80754D1A1A8D4F
               	leaq	<rip>, %rcx
               	movq	%rsi, 0x68(%rcx)
               	movabsq	$-0x4c3b6fb592d876ce, %rsi # imm = 0xB3C4904A6D278932
               	leaq	<rip>, %rcx
               	movq	%rsi, 0x70(%rcx)
               	movabsq	$-0x439630bd897b92e7, %rsi # imm = 0xBC69CF4276846D19
               	leaq	<rip>, %rcx
               	movq	%rsi, 0x78(%rcx)
               	movabsq	$0x377b2fd56a5b15b4, %rsi # imm = 0x377B2FD56A5B15B4
               	leaq	<rip>, %rcx
               	movq	%rsi, 0x80(%rcx)
               	movabsq	$0x64d815deeaf29df3, %rsi # imm = 0x64D815DEEAF29DF3
               	leaq	<rip>, %rcx
               	movq	%rsi, 0x88(%rcx)
               	movabsq	$-0x991eff24d282dfa, %rsi # imm = 0xF66E100DB2D7D206
               	leaq	<rip>, %rcx
               	movq	%rsi, 0x90(%rcx)
               	movabsq	$0x1069e6a57e06665d, %rsi # imm = 0x1069E6A57E06665D
               	leaq	<rip>, %rcx
               	movq	%rsi, 0x98(%rcx)
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
               	subq	$0x1b8, %rsp            # imm = 0x1B8
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	callq	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edx, %edx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movl	$0x3, %ecx
               	movl	%ecx, -0x1a8(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movslq	(%rcx,%rsi,4), %rcx
               	imulq	$0x55555556, %rcx, %rdi # imm = 0x55555556
               	movq	%rdi, %rsi
               	sarq	$0x20, %rsi
               	movq	%rsi, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rsi,%r8), %r9
               	movslq	-0x1a8(%rbp), %rbx
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
               	leaq	(%r9,%r9,2), %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movslq	-0x1a8(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edx, %edx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movl	$0x5, %ecx
               	movl	%ecx, -0x1a0(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movslq	(%rcx,%rsi,4), %rcx
               	imulq	$0x66666667, %rcx, %rdi # imm = 0x66666667
               	movq	%rdi, %rsi
               	sarq	$0x21, %rsi
               	movq	%rsi, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rsi,%r8), %r9
               	movslq	-0x1a0(%rbp), %rbx
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
               	leaq	(%r9,%r9,4), %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movslq	-0x1a0(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edx, %edx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movl	$0x6, %ecx
               	movl	%ecx, -0x198(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movslq	(%rcx,%rsi,4), %rcx
               	imulq	$0x2aaaaaab, %rcx, %rdi # imm = 0x2AAAAAAB
               	movq	%rdi, %rsi
               	sarq	$0x20, %rsi
               	movq	%rsi, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rsi,%r8), %r9
               	movslq	-0x198(%rbp), %rbx
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
               	imulq	$0x6, %r9, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movslq	-0x198(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edx, %edx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movl	$0x7, %ecx
               	movl	%ecx, -0x190(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movslq	(%rcx,%rsi,4), %rcx
               	movl	$0x92492493, %edi       # imm = 0x92492493
               	imulq	%rcx, %rdi
               	movq	%rdi, %rsi
               	sarq	$0x22, %rsi
               	movq	%rsi, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rsi,%r8), %r9
               	movslq	-0x190(%rbp), %rbx
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
               	imulq	$0x7, %r9, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movslq	-0x190(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edx, %edx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movl	$0xa, %ecx
               	movl	%ecx, -0x188(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movslq	(%rcx,%rsi,4), %rcx
               	imulq	$0x66666667, %rcx, %rdi # imm = 0x66666667
               	movq	%rdi, %rsi
               	sarq	$0x22, %rsi
               	movq	%rsi, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rsi,%r8), %r9
               	movslq	-0x188(%rbp), %rbx
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
               	imulq	$0xa, %r9, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movslq	-0x188(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edx, %edx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movl	$0x64, %ecx
               	movl	%ecx, -0x180(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movslq	(%rcx,%rsi,4), %rcx
               	imulq	$0x51eb851f, %rcx, %rdi # imm = 0x51EB851F
               	movq	%rdi, %rsi
               	sarq	$0x25, %rsi
               	movq	%rsi, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rsi,%r8), %r9
               	movslq	-0x180(%rbp), %rbx
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
               	imulq	$0x64, %r9, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movslq	-0x180(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edx, %edx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movl	$0x3e8, %ecx            # imm = 0x3E8
               	movl	%ecx, -0x178(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movslq	(%rcx,%rsi,4), %rcx
               	imulq	$0x10624dd3, %rcx, %rdi # imm = 0x10624DD3
               	movq	%rdi, %rsi
               	sarq	$0x26, %rsi
               	movq	%rsi, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rsi,%r8), %r9
               	movslq	-0x178(%rbp), %rbx
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
               	imulq	$0x3e8, %r9, %rsi       # imm = 0x3E8
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movslq	-0x178(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edx, %edx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movl	$0xffff, %ecx           # imm = 0xFFFF
               	movl	%ecx, -0x170(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movslq	(%rcx,%rsi,4), %rcx
               	movl	$0x80008001, %edi       # imm = 0x80008001
               	imulq	%rcx, %rdi
               	movq	%rdi, %rsi
               	sarq	$0x2f, %rsi
               	movq	%rsi, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rsi,%r8), %r9
               	movslq	-0x170(%rbp), %rbx
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
               	imulq	$0xffff, %r9, %rsi      # imm = 0xFFFF
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movslq	-0x170(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edx, %edx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movl	$0x10001, %ecx          # imm = 0x10001
               	movl	%ecx, -0x168(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movslq	(%rcx,%rsi,4), %rcx
               	imulq	$0x7fff8001, %rcx, %rdi # imm = 0x7FFF8001
               	movq	%rdi, %rsi
               	sarq	$0x2f, %rsi
               	movq	%rsi, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rsi,%r8), %r9
               	movslq	-0x168(%rbp), %rbx
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
               	imulq	$0x10001, %r9, %rsi     # imm = 0x10001
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movslq	-0x168(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edx, %edx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movl	$0x7fffffff, %ecx       # imm = 0x7FFFFFFF
               	movl	%ecx, -0x160(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movslq	(%rcx,%rsi,4), %rcx
               	imulq	$0x40000001, %rcx, %rdi # imm = 0x40000001
               	movq	%rdi, %rsi
               	sarq	$0x3d, %rsi
               	movq	%rsi, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rsi,%r8), %r9
               	movslq	-0x160(%rbp), %rbx
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
               	imulq	$0x7fffffff, %r9, %rsi  # imm = 0x7FFFFFFF
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movslq	-0x160(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rdx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movq	$-0x3, %rcx
               	movl	%ecx, -0x158(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movslq	(%rcx,%rsi,4), %rcx
               	imulq	$0x55555556, %rcx, %r8  # imm = 0x55555556
               	movq	%r8, %rsi
               	sarq	$0x20, %rsi
               	movq	%rsi, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rsi,%r9), %rbx
               	movq	%rdi, %r12
               	subq	%rbx, %r12
               	movslq	-0x158(%rbp), %r13
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
               	xorl	%esi, %esi
               	subq	%rbx, %rsi
               	imulq	$-0x3, %rsi, %rsi
               	movq	%rcx, %r8
               	subq	%rsi, %r8
               	movslq	-0x158(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %r8
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rdx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movq	$-0x7, %rcx
               	movl	%ecx, -0x150(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movslq	(%rcx,%rsi,4), %rcx
               	movl	$0x92492493, %r8d       # imm = 0x92492493
               	imulq	%rcx, %r8
               	movq	%r8, %rsi
               	sarq	$0x22, %rsi
               	movq	%rsi, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rsi,%r9), %rbx
               	movq	%rdi, %r12
               	subq	%rbx, %r12
               	movslq	-0x150(%rbp), %r13
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
               	xorl	%esi, %esi
               	subq	%rbx, %rsi
               	imulq	$-0x7, %rsi, %rsi
               	movq	%rcx, %r8
               	subq	%rsi, %r8
               	movslq	-0x150(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %r8
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rdx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movq	$-0x64, %rcx
               	movl	%ecx, -0x148(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movslq	(%rcx,%rsi,4), %rcx
               	imulq	$0x51eb851f, %rcx, %r8  # imm = 0x51EB851F
               	movq	%r8, %rsi
               	sarq	$0x25, %rsi
               	movq	%rsi, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rsi,%r9), %rbx
               	movq	%rdi, %r12
               	subq	%rbx, %r12
               	movslq	-0x148(%rbp), %r13
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
               	xorl	%esi, %esi
               	subq	%rbx, %rsi
               	imulq	$-0x64, %rsi, %rsi
               	movq	%rcx, %r8
               	subq	%rsi, %r8
               	movslq	-0x148(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %r8
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rdx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movq	$-0x80000000, %rcx      # imm = 0x80000000
               	movl	%ecx, -0x140(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movslq	(%rcx,%rsi,4), %rcx
               	movq	%rcx, %rsi
               	shrq	$0x21, %rsi
               	leaq	(%rcx,%rsi), %r8
               	movq	%r8, %r9
               	sarq	$0x1f, %r9
               	movq	%r9, %r10
               	movq	%rdi, %r9
               	subq	%r10, %r9
               	movslq	-0x140(%rbp), %rbx
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
               	andq	$0x7fffffff, %r8        # imm = 0x7FFFFFFF
               	subq	%rsi, %r8
               	movslq	-0x140(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %r8
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x1, %edx
               	movl	%edx, -0x138(%rbp)
               	leaq	<rip>, %rdx
               	movslq	%ecx, %rsi
               	movslq	(%rdx,%rsi,4), %rdx
               	movslq	-0x138(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movslq	-0x138(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	popq	%rax
               	testq	%rdx, %rdx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edx, %edx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movl	$0x8, %ecx
               	movl	%ecx, -0x130(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movslq	(%rcx,%rsi,4), %rcx
               	movq	%rcx, %rsi
               	shrq	$0x3d, %rsi
               	leaq	(%rcx,%rsi), %rdi
               	movq	%rdi, %r8
               	sarq	$0x3, %r8
               	movslq	-0x130(%rbp), %r9
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
               	andq	$0x7, %rdi
               	subq	%rsi, %rdi
               	movslq	-0x130(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rdx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movq	$-0x8, %rcx
               	movl	%ecx, -0x128(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movslq	(%rcx,%rsi,4), %rcx
               	movq	%rcx, %rsi
               	shrq	$0x3d, %rsi
               	leaq	(%rcx,%rsi), %r8
               	movq	%r8, %r9
               	sarq	$0x3, %r9
               	movq	%r9, %r10
               	movq	%rdi, %r9
               	subq	%r10, %r9
               	movslq	-0x128(%rbp), %rbx
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
               	andq	$0x7, %r8
               	subq	%rsi, %r8
               	movslq	-0x128(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %r8
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edx, %edx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movl	%ecx, -0x120(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movslq	(%rcx,%rsi,4), %rcx
               	movq	%rcx, %rsi
               	shrq	$0x22, %rsi
               	leaq	(%rcx,%rsi), %rdi
               	movq	%rdi, %r8
               	sarq	$0x1e, %r8
               	movslq	-0x120(%rbp), %r9
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
               	andq	$0x3fffffff, %rdi       # imm = 0x3FFFFFFF
               	subq	%rsi, %rdi
               	movslq	-0x120(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edx, %edx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movl	$0x3, %ecx
               	movl	%ecx, -0x118(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movl	(%rcx,%rsi,4), %ecx
               	movl	$0xaaaaaaab, %esi       # imm = 0xAAAAAAAB
               	imulq	%rcx, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x21, %rdi
               	movl	-0x118(%rbp), %r8d
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
               	leaq	(%rdi,%rdi,2), %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movl	-0x118(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edx, %edx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movl	$0x7, %ecx
               	movl	%ecx, -0x110(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movl	(%rcx,%rsi,4), %ecx
               	imulq	$0x24924925, %rcx, %rdi # imm = 0x24924925
               	movq	%rdi, %rsi
               	shrq	$0x20, %rsi
               	movq	%rcx, %r8
               	subq	%rsi, %r8
               	movq	%r8, %r9
               	shrq	%r9
               	leaq	(%r9,%rsi), %rbx
               	movq	%rbx, %r12
               	shrq	$0x2, %r12
               	movl	-0x110(%rbp), %r13d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r13
               	movq	%rax, %r13
               	popq	%rdx
               	popq	%rax
               	cmpq	%r13, %r12
               	jne	<addr>
               	movq	%rbx, %rsi
               	shrq	$0x2, %rsi
               	imulq	$0x7, %rsi, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movl	-0x110(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edx, %edx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movl	$0xa, %ecx
               	movl	%ecx, -0x108(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movl	(%rcx,%rsi,4), %ecx
               	movq	%rcx, %rsi
               	shrq	%rsi
               	imulq	$0x66666667, %rsi, %rdi # imm = 0x66666667
               	movq	%rdi, %r8
               	shrq	$0x21, %r8
               	movl	-0x108(%rbp), %r9d
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
               	imulq	$0xa, %r8, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movl	-0x108(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edx, %edx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movl	$0xe, %ecx
               	movl	%ecx, -0x100(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movl	(%rcx,%rsi,4), %ecx
               	movq	%rcx, %rsi
               	shrq	%rsi
               	movl	$0x92492493, %edi       # imm = 0x92492493
               	imulq	%rsi, %rdi
               	movq	%rdi, %r8
               	shrq	$0x22, %r8
               	movl	-0x100(%rbp), %r9d
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
               	imulq	$0xe, %r8, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movl	-0x100(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edx, %edx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movl	$0x64, %ecx
               	movl	%ecx, -0xf8(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movl	(%rcx,%rsi,4), %ecx
               	movq	%rcx, %rsi
               	shrq	$0x2, %rsi
               	imulq	$0xa3d70a4, %rsi, %rdi  # imm = 0xA3D70A4
               	movq	%rdi, %r8
               	shrq	$0x20, %r8
               	movl	-0xf8(%rbp), %r9d
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
               	imulq	$0x64, %r8, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movl	-0xf8(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edx, %edx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movl	$0x3e8, %ecx            # imm = 0x3E8
               	movl	%ecx, -0xf0(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movl	(%rcx,%rsi,4), %ecx
               	movq	%rcx, %rsi
               	shrq	$0x3, %rsi
               	imulq	$0x10624dd3, %rsi, %rdi # imm = 0x10624DD3
               	movq	%rdi, %r8
               	shrq	$0x23, %r8
               	movl	-0xf0(%rbp), %r9d
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
               	imulq	$0x3e8, %r8, %rsi       # imm = 0x3E8
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movl	-0xf0(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edx, %edx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movl	$0x7fffffff, %ecx       # imm = 0x7FFFFFFF
               	movl	%ecx, -0xe8(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movl	(%rcx,%rsi,4), %ecx
               	leaq	(%rcx,%rcx,2), %rdi
               	movq	%rdi, %rsi
               	shrq	$0x20, %rsi
               	movq	%rcx, %r8
               	subq	%rsi, %r8
               	movq	%r8, %r9
               	shrq	%r9
               	leaq	(%r9,%rsi), %rbx
               	movq	%rbx, %r12
               	shrq	$0x1e, %r12
               	movl	-0xe8(%rbp), %r13d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r13
               	movq	%rax, %r13
               	popq	%rdx
               	popq	%rax
               	cmpq	%r13, %r12
               	jne	<addr>
               	movq	%rbx, %rsi
               	shrq	$0x1e, %rsi
               	imulq	$0x7fffffff, %rsi, %rsi # imm = 0x7FFFFFFF
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movl	-0xe8(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edx, %edx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movl	$0x80000001, %ecx       # imm = 0x80000001
               	movl	%ecx, -0xe0(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movl	(%rcx,%rsi,4), %ecx
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	movq	%rcx, %rsi
               	cmpl	%r11d, %ecx
               	setae	%sil
               	movzbq	%sil, %rsi
               	movl	-0xe0(%rbp), %edi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	imulq	%r11, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movl	-0xe0(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edx, %edx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movl	$0xfffffffb, %ecx       # imm = 0xFFFFFFFB
               	movl	%ecx, -0xd8(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movl	(%rcx,%rsi,4), %ecx
               	movl	$0xfffffffb, %r11d      # imm = 0xFFFFFFFB
               	movq	%rcx, %rsi
               	cmpl	%r11d, %ecx
               	setae	%sil
               	movzbq	%sil, %rsi
               	movl	-0xd8(%rbp), %edi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movl	$0xfffffffb, %r11d      # imm = 0xFFFFFFFB
               	imulq	%r11, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movl	-0xd8(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x1, %edx
               	movl	%edx, -0xd0(%rbp)
               	leaq	<rip>, %rdx
               	movslq	%ecx, %rsi
               	movl	(%rdx,%rsi,4), %edx
               	movl	-0xd0(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movl	-0xd0(%rbp), %esi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	popq	%rax
               	testq	%rdx, %rdx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x10, %edx
               	movl	%edx, -0xc8(%rbp)
               	leaq	<rip>, %rdx
               	movslq	%ecx, %rsi
               	movl	(%rdx,%rsi,4), %edx
               	movq	%rdx, %rsi
               	shrq	$0x4, %rsi
               	movl	-0xc8(%rbp), %edi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movq	%rdx, %rdi
               	andq	$0xf, %rdi
               	movl	-0xc8(%rbp), %esi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	popq	%rax
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x3, %edx
               	movq	%rdx, -0xc0(%rbp)
               	leaq	<rip>, %rdx
               	movslq	%ecx, %rsi
               	movq	(%rdx,%rsi,8), %rdx
               	movabsq	$0x5555555555555556, %rdi # imm = 0x5555555555555556
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	imulq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rsi, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rsi,%r8), %r9
               	movq	-0xc0(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r9
               	jne	<addr>
               	leaq	(%r9,%r9,2), %rsi
               	movq	%rdx, %rdi
               	subq	%rsi, %rdi
               	movq	-0xc0(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	popq	%rax
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x7, %edx
               	movq	%rdx, -0xb8(%rbp)
               	leaq	<rip>, %rdx
               	movslq	%ecx, %rsi
               	movq	(%rdx,%rsi,8), %rdx
               	movabsq	$0x4924924924924925, %rdi # imm = 0x4924924924924925
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	imulq	%rdi
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %rsi
               	sarq	%rsi
               	movq	%rsi, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rsi,%r9), %rbx
               	movq	-0xb8(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rbx
               	jne	<addr>
               	imulq	$0x7, %rbx, %rsi
               	movq	%rdx, %rdi
               	subq	%rsi, %rdi
               	movq	-0xb8(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	popq	%rax
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0xa, %edx
               	movq	%rdx, -0xb0(%rbp)
               	leaq	<rip>, %rdx
               	movslq	%ecx, %rsi
               	movq	(%rdx,%rsi,8), %rdx
               	movabsq	$0x6666666666666667, %rdi # imm = 0x6666666666666667
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	imulq	%rdi
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %rsi
               	sarq	$0x2, %rsi
               	movq	%rsi, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rsi,%r9), %rbx
               	movq	-0xb0(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rbx
               	jne	<addr>
               	imulq	$0xa, %rbx, %rsi
               	movq	%rdx, %rdi
               	subq	%rsi, %rdi
               	movq	-0xb0(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	popq	%rax
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x3e8, %edx            # imm = 0x3E8
               	movq	%rdx, -0xa8(%rbp)
               	leaq	<rip>, %rdx
               	movslq	%ecx, %rsi
               	movq	(%rdx,%rsi,8), %rdx
               	movabsq	$0x20c49ba5e353f7cf, %rdi # imm = 0x20C49BA5E353F7CF
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	imulq	%rdi
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %rsi
               	sarq	$0x7, %rsi
               	movq	%rsi, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rsi,%r9), %rbx
               	movq	-0xa8(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rbx
               	jne	<addr>
               	imulq	$0x3e8, %rbx, %rsi      # imm = 0x3E8
               	movq	%rdx, %rdi
               	subq	%rsi, %rdi
               	movq	-0xa8(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	popq	%rax
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edx, %edx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movl	$0x3b9aca07, %ecx       # imm = 0x3B9ACA07
               	movq	%rcx, -0xa0(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movq	(%rcx,%rsi,8), %rcx
               	movabsq	$-0x768fa0ceed5d701b, %rdi # imm = 0x89705F3112A28FE5
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%rdi
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	leaq	(%r8,%rcx), %r9
               	movq	%r9, %rsi
               	sarq	$0x1d, %rsi
               	movq	%rsi, %rbx
               	shrq	$0x3f, %rbx
               	leaq	(%rsi,%rbx), %r12
               	movq	-0xa0(%rbp), %r13
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
               	addq	%rbx, %rsi
               	imulq	$0x3b9aca07, %rsi, %rsi # imm = 0x3B9ACA07
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movq	-0xa0(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rdx, -0x98(%rbp)
               	leaq	<rip>, %rdx
               	movslq	%ecx, %rsi
               	movq	(%rdx,%rsi,8), %rdx
               	movabsq	$0x4000000000000001, %rdi # imm = 0x4000000000000001
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	imulq	%rdi
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %rsi
               	sarq	$0x3d, %rsi
               	movq	%rsi, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rsi,%r9), %rbx
               	movq	-0x98(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rbx
               	jne	<addr>
               	movabsq	$0x7fffffffffffffff, %rsi # imm = 0x7FFFFFFFFFFFFFFF
               	imulq	%rbx, %rsi
               	movq	%rdx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x98(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	popq	%rax
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movq	$-0x3, %rdx
               	movq	%rdx, -0x90(%rbp)
               	leaq	<rip>, %rdx
               	movslq	%ecx, %rsi
               	movq	(%rdx,%rsi,8), %rdx
               	movabsq	$0x5555555555555556, %r8 # imm = 0x5555555555555556
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	imulq	%r8
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rsi, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rsi,%r9), %rbx
               	movq	%rdi, %r12
               	subq	%rbx, %r12
               	movq	-0x90(%rbp), %r13
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%r13
               	movq	%rax, %r13
               	popq	%rdx
               	popq	%rax
               	cmpq	%r13, %r12
               	jne	<addr>
               	xorl	%esi, %esi
               	subq	%rbx, %rsi
               	imulq	$-0x3, %rsi, %rsi
               	movq	%rdx, %r8
               	subq	%rsi, %r8
               	movq	-0x90(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	popq	%rax
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rcx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movq	$-0x7, %rdx
               	movq	%rdx, -0x88(%rbp)
               	leaq	<rip>, %rdx
               	movslq	%ecx, %rsi
               	movq	(%rdx,%rsi,8), %rdx
               	movabsq	$0x4924924924924925, %r8 # imm = 0x4924924924924925
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	imulq	%r8
               	movq	%rdx, %r9
               	popq	%rdx
               	popq	%rax
               	movq	%r9, %rsi
               	sarq	%rsi
               	movq	%rsi, %rbx
               	shrq	$0x3f, %rbx
               	leaq	(%rsi,%rbx), %r12
               	movq	%r12, %r10
               	movq	%rdi, %r12
               	subq	%r10, %r12
               	movq	-0x88(%rbp), %r13
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%r13
               	movq	%rax, %r13
               	popq	%rdx
               	popq	%rax
               	cmpq	%r13, %r12
               	jne	<addr>
               	addq	%rbx, %rsi
               	xorl	%r8d, %r8d
               	movq	%rsi, %r10
               	movq	%r8, %rsi
               	subq	%r10, %rsi
               	imulq	$-0x7, %rsi, %rsi
               	movq	%rdx, %r8
               	subq	%rsi, %r8
               	movq	-0x88(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	popq	%rax
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rdx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movq	$-0x3b9aca07, %rcx      # imm = 0xC46535F9
               	movq	%rcx, -0x80(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movq	(%rcx,%rsi,8), %rcx
               	movabsq	$-0x768fa0ceed5d701b, %r8 # imm = 0x89705F3112A28FE5
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%r8
               	movq	%rdx, %r9
               	popq	%rdx
               	popq	%rax
               	leaq	(%r9,%rcx), %rbx
               	movq	%rbx, %rsi
               	sarq	$0x1d, %rsi
               	movq	%rsi, %r12
               	shrq	$0x3f, %r12
               	addq	%rsi, %r12
               	movq	%r12, %r10
               	movq	%rdi, %r12
               	subq	%r10, %r12
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
               	movq	%rsi, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rsi
               	xorl	%r8d, %r8d
               	movq	%rsi, %r10
               	movq	%r8, %rsi
               	subq	%r10, %rsi
               	imulq	$-0x3b9aca07, %rsi, %rsi # imm = 0xC46535F9
               	movq	%rcx, %r8
               	subq	%rsi, %r8
               	movq	-0x80(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %r8
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rdx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%rcx, -0x78(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movq	(%rcx,%rsi,8), %rcx
               	movq	%rcx, %r8
               	sarq	$0x3f, %r8
               	movq	%r8, %rsi
               	shrq	%rsi
               	leaq	(%rcx,%rsi), %r9
               	movq	%r9, %rbx
               	sarq	$0x3f, %rbx
               	movq	%rbx, %r10
               	movq	%rdi, %rbx
               	subq	%r10, %rbx
               	movq	-0x78(%rbp), %r12
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
               	movabsq	$0x7fffffffffffffff, %r8 # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%r9, %r8
               	subq	%rsi, %r8
               	movq	-0x78(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %r8
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x1, %edx
               	movq	%rdx, -0x70(%rbp)
               	leaq	<rip>, %rdx
               	movslq	%ecx, %rsi
               	movq	(%rdx,%rsi,8), %rdx
               	movq	-0x70(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movq	-0x70(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	popq	%rax
               	testq	%rdx, %rdx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x400, %edx            # imm = 0x400
               	movq	%rdx, -0x68(%rbp)
               	leaq	<rip>, %rdx
               	movslq	%ecx, %rsi
               	movq	(%rdx,%rsi,8), %rdx
               	movq	%rdx, %rdi
               	sarq	$0x3f, %rdi
               	movq	%rdi, %rsi
               	shrq	$0x36, %rsi
               	leaq	(%rdx,%rsi), %r8
               	movq	%r8, %r9
               	sarq	$0xa, %r9
               	movq	-0x68(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r9
               	jne	<addr>
               	movq	%r8, %rdi
               	andq	$0x3ff, %rdi            # imm = 0x3FF
               	subq	%rsi, %rdi
               	movq	-0x68(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	popq	%rax
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rdx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movq	$-0x400, %rcx           # imm = 0xFC00
               	movq	%rcx, -0x60(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movq	(%rcx,%rsi,8), %rcx
               	movq	%rcx, %r8
               	sarq	$0x3f, %r8
               	movq	%r8, %rsi
               	shrq	$0x36, %rsi
               	leaq	(%rcx,%rsi), %r9
               	movq	%r9, %rbx
               	sarq	$0xa, %rbx
               	movq	%rbx, %r10
               	movq	%rdi, %rbx
               	subq	%r10, %rbx
               	movq	-0x60(%rbp), %r12
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
               	movq	%r9, %r8
               	andq	$0x3ff, %r8             # imm = 0x3FF
               	subq	%rsi, %r8
               	movq	-0x60(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %r8
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x3, %edx
               	movq	%rdx, -0x58(%rbp)
               	leaq	<rip>, %rdx
               	movslq	%ecx, %rsi
               	movq	(%rdx,%rsi,8), %rdx
               	movabsq	$-0x5555555555555555, %rsi # imm = 0xAAAAAAAAAAAAAAAB
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	mulq	%rsi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	%rdi, %r8
               	shrq	%r8
               	movq	-0x58(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpq	%r9, %r8
               	jne	<addr>
               	leaq	(%r8,%r8,2), %rsi
               	movq	%rdx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x58(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	popq	%rax
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edx, %edx
               	cmpl	$0x14, %edx
               	jge	<addr>
               	movl	$0x7, %ecx
               	movq	%rcx, -0x50(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movq	(%rcx,%rsi,8), %rcx
               	movabsq	$0x2492492492492493, %rdi # imm = 0x2492492492492493
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	mulq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, %r8
               	subq	%rsi, %r8
               	movq	%r8, %r9
               	shrq	%r9
               	leaq	(%r9,%rsi), %rbx
               	movq	%rbx, %r12
               	shrq	$0x2, %r12
               	movq	-0x50(%rbp), %r13
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r13
               	movq	%rax, %r13
               	popq	%rdx
               	popq	%rax
               	cmpq	%r13, %r12
               	jne	<addr>
               	movq	%rbx, %rsi
               	shrq	$0x2, %rsi
               	imulq	$0x7, %rsi, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x50(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0xa, %edx
               	movq	%rdx, -0x48(%rbp)
               	leaq	<rip>, %rdx
               	movslq	%ecx, %rsi
               	movq	(%rdx,%rsi,8), %rdx
               	movq	%rdx, %rsi
               	shrq	%rsi
               	movabsq	$0x6666666666666667, %rdi # imm = 0x6666666666666667
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	mulq	%rdi
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %r9
               	shrq	%r9
               	movq	-0x48(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r9
               	jne	<addr>
               	imulq	$0xa, %r9, %rsi
               	movq	%rdx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x48(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	popq	%rax
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0xe, %edx
               	movq	%rdx, -0x40(%rbp)
               	leaq	<rip>, %rdx
               	movslq	%ecx, %rsi
               	movq	(%rdx,%rsi,8), %rdx
               	movq	%rdx, %rsi
               	shrq	%rsi
               	movabsq	$0x4924924924924925, %rdi # imm = 0x4924924924924925
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	mulq	%rdi
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %r9
               	shrq	%r9
               	movq	-0x40(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r9
               	jne	<addr>
               	imulq	$0xe, %r9, %rsi
               	movq	%rdx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x40(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	popq	%rax
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x3b9aca07, %edx       # imm = 0x3B9ACA07
               	movq	%rdx, -0x38(%rbp)
               	leaq	<rip>, %rdx
               	movslq	%ecx, %rsi
               	movq	(%rdx,%rsi,8), %rdx
               	movabsq	$-0x768fa0ceed5d701b, %rsi # imm = 0x89705F3112A28FE5
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	mulq	%rsi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	%rdi, %r8
               	shrq	$0x1d, %r8
               	movq	-0x38(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpq	%r9, %r8
               	jne	<addr>
               	imulq	$0x3b9aca07, %r8, %rsi  # imm = 0x3B9ACA07
               	movq	%rdx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x38(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	popq	%rax
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movabsq	$-0x7fffffffffffffff, %rdx # imm = 0x8000000000000001
               	movq	%rdx, -0x30(%rbp)
               	leaq	<rip>, %rdx
               	movslq	%ecx, %rsi
               	movq	(%rdx,%rsi,8), %rdx
               	movabsq	$-0x7fffffffffffffff, %r11 # imm = 0x8000000000000001
               	movq	%rdx, %rsi
               	cmpq	%r11, %rdx
               	setae	%sil
               	movzbq	%sil, %rsi
               	movq	-0x30(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movabsq	$-0x7fffffffffffffff, %r11 # imm = 0x8000000000000001
               	imulq	%r11, %rsi
               	movq	%rdx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x30(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	popq	%rax
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movq	$-0x5, %rdx
               	movq	%rdx, -0x28(%rbp)
               	leaq	<rip>, %rdx
               	movslq	%ecx, %rsi
               	movq	(%rdx,%rsi,8), %rdx
               	cmpq	$-0x5, %rdx
               	setae	%sil
               	movzbq	%sil, %rsi
               	movq	-0x28(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	imulq	$-0x5, %rsi, %rsi
               	movq	%rdx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x28(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	popq	%rax
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x1, %edx
               	movq	%rdx, -0x20(%rbp)
               	leaq	<rip>, %rdx
               	movslq	%ecx, %rsi
               	movq	(%rdx,%rsi,8), %rdx
               	movq	-0x20(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movq	-0x20(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	popq	%rax
               	testq	%rdx, %rdx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x14, %ecx
               	jge	<addr>
               	movl	$0x400, %edx            # imm = 0x400
               	movq	%rdx, -0x18(%rbp)
               	leaq	<rip>, %rdx
               	movslq	%ecx, %rsi
               	movq	(%rdx,%rsi,8), %rdx
               	movq	%rdx, %rsi
               	shrq	$0xa, %rsi
               	movq	-0x18(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movq	%rdx, %rdi
               	andq	$0x3ff, %rdi            # imm = 0x3FF
               	movq	-0x18(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	popq	%rax
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movq	$-0x3039, %rax          # imm = 0xCFC7
               	movl	%eax, -0x10(%rbp)
               	movabsq	$-0x11f71fb04cb, %rax   # imm = 0xFFFFFEE08E04FB35
               	movq	%rax, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
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
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
