
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
               	leaq	<rip>, %rcx
               	xorq	%rax, %rax
               	movq	%rax, (%rcx)
               	movl	$0x1, %eax
               	movq	%rax, 0x8(%rcx)
               	movabsq	$-0x1, %rax
               	movq	%rax, 0x10(%rcx)
               	movl	$0x2, %eax
               	movq	%rax, 0x18(%rcx)
               	movabsq	$-0x2, %rax
               	movq	%rax, 0x20(%rcx)
               	movl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
               	movq	%rax, 0x28(%rcx)
               	movabsq	$-0x80000000, %rax      # imm = 0x80000000
               	movq	%rax, 0x30(%rcx)
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rax, 0x38(%rcx)
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, 0x40(%rcx)
               	movl	$0x3b9aca07, %eax       # imm = 0x3B9ACA07
               	movq	%rax, 0x48(%rcx)
               	movabsq	$-0x3b9aca07, %rax      # imm = 0xC46535F9
               	movq	%rax, 0x50(%rcx)
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movq	%rax, 0x58(%rcx)
               	movabsq	$0x2ceaee21bf46bc00, %rax # imm = 0x2CEAEE21BF46BC00
               	movq	%rax, 0x60(%rcx)
               	movabsq	$-0x557f8ab2e5e572b1, %rax # imm = 0xAA80754D1A1A8D4F
               	movq	%rax, 0x68(%rcx)
               	movabsq	$-0x4c3b6fb592d876ce, %rax # imm = 0xB3C4904A6D278932
               	movq	%rax, 0x70(%rcx)
               	movabsq	$-0x439630bd897b92e7, %rax # imm = 0xBC69CF4276846D19
               	movq	%rax, 0x78(%rcx)
               	movabsq	$0x377b2fd56a5b15b4, %rax # imm = 0x377B2FD56A5B15B4
               	movq	%rax, 0x80(%rcx)
               	movabsq	$0x64d815deeaf29df3, %rax # imm = 0x64D815DEEAF29DF3
               	movq	%rax, 0x88(%rcx)
               	movabsq	$-0x991eff24d282dfa, %rax # imm = 0xF66E100DB2D7D206
               	movq	%rax, 0x90(%rcx)
               	movabsq	$0x1069e6a57e06665d, %rax # imm = 0x1069E6A57E06665D
               	movq	%rax, 0x98(%rcx)
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdi
               	addq	%rcx, %rsi
               	movq	(%rsi), %rsi
               	movq	%rsi, (%rdi)
               	leaq	<rip>, %rdi
               	movq	(%rcx,%rax,8), %rsi
               	movl	%esi, (%rdi,%rax,4)
               	leaq	<rip>, %rsi
               	movq	(%rcx,%rax,8), %rdi
               	movl	%edi, %edi
               	movl	%edi, (%rsi,%rax,4)
               	leaq	0x1(%rax), %rdx
               	movslq	%edx, %rax
               	cmpq	$0x14, %rax
               	jl	<addr>
               	xorq	%rax, %rax
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
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x3, %eax
               	movl	%eax, -0x1a8(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rdx,4), %rax
               	imulq	$0x55555556, %rax, %rsi # imm = 0x55555556
               	sarq	$0x20, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	movslq	-0x1a8(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	imulq	$0x55555556, %rax, %rsi # imm = 0x55555556
               	sarq	$0x20, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	leaq	(%rsi,%rsi,2), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movslq	-0x1a8(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x5, %eax
               	movl	%eax, -0x1a0(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rdx,4), %rax
               	imulq	$0x66666667, %rax, %rsi # imm = 0x66666667
               	sarq	$0x21, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	movslq	-0x1a0(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	imulq	$0x66666667, %rax, %rsi # imm = 0x66666667
               	sarq	$0x21, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	leaq	(%rsi,%rsi,4), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movslq	-0x1a0(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x6, %eax
               	movl	%eax, -0x198(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rdx,4), %rax
               	imulq	$0x2aaaaaab, %rax, %rsi # imm = 0x2AAAAAAB
               	sarq	$0x20, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	movslq	-0x198(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	imulq	$0x2aaaaaab, %rax, %rsi # imm = 0x2AAAAAAB
               	sarq	$0x20, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	imulq	$0x6, %rsi, %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movslq	-0x198(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x7, %eax
               	movl	%eax, -0x190(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rdx,4), %rax
               	movl	$0x92492493, %esi       # imm = 0x92492493
               	imulq	%rax, %rsi
               	sarq	$0x22, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	movslq	-0x190(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movl	$0x92492493, %esi       # imm = 0x92492493
               	imulq	%rax, %rsi
               	sarq	$0x22, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	imulq	$0x7, %rsi, %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movslq	-0x190(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0xa, %eax
               	movl	%eax, -0x188(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rdx,4), %rax
               	imulq	$0x66666667, %rax, %rsi # imm = 0x66666667
               	sarq	$0x22, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	movslq	-0x188(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	imulq	$0x66666667, %rax, %rsi # imm = 0x66666667
               	sarq	$0x22, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	imulq	$0xa, %rsi, %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movslq	-0x188(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x64, %eax
               	movl	%eax, -0x180(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rdx,4), %rax
               	imulq	$0x51eb851f, %rax, %rsi # imm = 0x51EB851F
               	sarq	$0x25, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	movslq	-0x180(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	imulq	$0x51eb851f, %rax, %rsi # imm = 0x51EB851F
               	sarq	$0x25, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	imulq	$0x64, %rsi, %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movslq	-0x180(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x3e8, %eax            # imm = 0x3E8
               	movl	%eax, -0x178(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rdx,4), %rax
               	imulq	$0x10624dd3, %rax, %rsi # imm = 0x10624DD3
               	sarq	$0x26, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	movslq	-0x178(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	imulq	$0x10624dd3, %rax, %rsi # imm = 0x10624DD3
               	sarq	$0x26, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	imulq	$0x3e8, %rsi, %rsi      # imm = 0x3E8
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movslq	-0x178(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0xffff, %eax           # imm = 0xFFFF
               	movl	%eax, -0x170(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rdx,4), %rax
               	movl	$0x80008001, %esi       # imm = 0x80008001
               	imulq	%rax, %rsi
               	sarq	$0x2f, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	movslq	-0x170(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movl	$0x80008001, %esi       # imm = 0x80008001
               	imulq	%rax, %rsi
               	sarq	$0x2f, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	imulq	$0xffff, %rsi, %rsi     # imm = 0xFFFF
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movslq	-0x170(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x10001, %eax          # imm = 0x10001
               	movl	%eax, -0x168(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rdx,4), %rax
               	imulq	$0x7fff8001, %rax, %rsi # imm = 0x7FFF8001
               	sarq	$0x2f, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	movslq	-0x168(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	imulq	$0x7fff8001, %rax, %rsi # imm = 0x7FFF8001
               	sarq	$0x2f, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	imulq	$0x10001, %rsi, %rsi    # imm = 0x10001
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movslq	-0x168(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
               	movl	%eax, -0x160(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rdx,4), %rax
               	imulq	$0x40000001, %rax, %rsi # imm = 0x40000001
               	sarq	$0x3d, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	movslq	-0x160(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	imulq	$0x40000001, %rax, %rsi # imm = 0x40000001
               	sarq	$0x3d, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	imulq	$0x7fffffff, %rsi, %rsi # imm = 0x7FFFFFFF
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movslq	-0x160(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movabsq	$-0x3, %rax
               	movl	%eax, -0x158(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rdx,4), %rax
               	imulq	$0x55555556, %rax, %rsi # imm = 0x55555556
               	sarq	$0x20, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	xorq	%rdi, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movslq	-0x158(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	imulq	$0x55555556, %rax, %rsi # imm = 0x55555556
               	sarq	$0x20, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	xorq	%rdi, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	imulq	$-0x3, %rsi, %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movslq	-0x158(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movabsq	$-0x7, %rax
               	movl	%eax, -0x150(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rdx,4), %rax
               	movl	$0x92492493, %esi       # imm = 0x92492493
               	imulq	%rax, %rsi
               	sarq	$0x22, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	xorq	%rdi, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movslq	-0x150(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movl	$0x92492493, %esi       # imm = 0x92492493
               	imulq	%rax, %rsi
               	sarq	$0x22, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	xorq	%rdi, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	imulq	$-0x7, %rsi, %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movslq	-0x150(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movabsq	$-0x64, %rax
               	movl	%eax, -0x148(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rdx,4), %rax
               	imulq	$0x51eb851f, %rax, %rsi # imm = 0x51EB851F
               	sarq	$0x25, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	xorq	%rdi, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movslq	-0x148(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	imulq	$0x51eb851f, %rax, %rsi # imm = 0x51EB851F
               	sarq	$0x25, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	xorq	%rdi, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	imulq	$-0x64, %rsi, %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movslq	-0x148(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movabsq	$-0x80000000, %rax      # imm = 0x80000000
               	movl	%eax, -0x140(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rdx,4), %rax
               	movq	%rax, %rsi
               	sarq	$0x3f, %rsi
               	shrq	$0x21, %rsi
               	addq	%rax, %rsi
               	sarq	$0x1f, %rsi
               	xorq	%rdi, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movslq	-0x140(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movq	%rax, %rsi
               	sarq	$0x3f, %rsi
               	shrq	$0x21, %rsi
               	leaq	(%rax,%rsi), %rdi
               	andq	$0x7fffffff, %rdi       # imm = 0x7FFFFFFF
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movslq	-0x140(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movl	%ecx, -0x138(%rbp)
               	leaq	<rip>, %rcx
               	movslq	(%rcx,%rdx,4), %rcx
               	movslq	-0x138(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rsi, %rcx
               	jne	<addr>
               	movslq	-0x138(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x8, %eax
               	movl	%eax, -0x130(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rdx,4), %rax
               	movq	%rax, %rsi
               	sarq	$0x3f, %rsi
               	shrq	$0x3d, %rsi
               	addq	%rax, %rsi
               	sarq	$0x3, %rsi
               	movslq	-0x130(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movq	%rax, %rsi
               	sarq	$0x3f, %rsi
               	shrq	$0x3d, %rsi
               	leaq	(%rax,%rsi), %rdi
               	andq	$0x7, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movslq	-0x130(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movabsq	$-0x8, %rax
               	movl	%eax, -0x128(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rdx,4), %rax
               	movq	%rax, %rsi
               	sarq	$0x3f, %rsi
               	shrq	$0x3d, %rsi
               	addq	%rax, %rsi
               	sarq	$0x3, %rsi
               	xorq	%rdi, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movslq	-0x128(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movq	%rax, %rsi
               	sarq	$0x3f, %rsi
               	shrq	$0x3d, %rsi
               	leaq	(%rax,%rsi), %rdi
               	andq	$0x7, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movslq	-0x128(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movl	%eax, -0x120(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax,%rdx,4), %rax
               	movq	%rax, %rsi
               	sarq	$0x3f, %rsi
               	shrq	$0x22, %rsi
               	addq	%rax, %rsi
               	sarq	$0x1e, %rsi
               	movslq	-0x120(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movq	%rax, %rsi
               	sarq	$0x3f, %rsi
               	shrq	$0x22, %rsi
               	leaq	(%rax,%rsi), %rdi
               	andq	$0x3fffffff, %rdi       # imm = 0x3FFFFFFF
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movslq	-0x120(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x3, %edx
               	movl	%edx, -0x118(%rbp)
               	leaq	<rip>, %rdx
               	movl	(%rdx,%rcx,4), %edx
               	movl	%edx, %esi
               	movl	$0xaaaaaaab, %edi       # imm = 0xAAAAAAAB
               	imulq	%rsi, %rdi
               	shrq	$0x21, %rdi
               	movl	-0x118(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rsi, %rdi
               	jne	<addr>
               	movl	%edx, %edx
               	movl	$0xaaaaaaab, %esi       # imm = 0xAAAAAAAB
               	imulq	%rdx, %rsi
               	shrq	$0x21, %rsi
               	leaq	(%rsi,%rsi,2), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movl	-0x118(%rbp), %edi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	popq	%rax
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x14, %rcx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x7, %edx
               	movl	%edx, -0x110(%rbp)
               	leaq	<rip>, %rdx
               	movl	(%rdx,%rcx,4), %esi
               	movl	%esi, %edx
               	imulq	$0x24924925, %rdx, %rdi # imm = 0x24924925
               	shrq	$0x20, %rdi
               	movq	%rdx, %r8
               	subq	%rdi, %r8
               	shrq	%r8
               	addq	%r8, %rdi
               	shrq	$0x2, %rdi
               	movl	-0x110(%rbp), %r8d
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	movl	%esi, %edx
               	imulq	$0x24924925, %rdx, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	movq	%rdx, %rdi
               	subq	%rsi, %rdi
               	shrq	%rdi
               	addq	%rdi, %rsi
               	shrq	$0x2, %rsi
               	imulq	$0x7, %rsi, %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movl	-0x110(%rbp), %edi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	popq	%rax
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x14, %rcx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0xa, %edx
               	movl	%edx, -0x108(%rbp)
               	leaq	<rip>, %rdx
               	movl	(%rdx,%rcx,4), %edx
               	movl	%edx, %esi
               	movq	%rsi, %rdi
               	shrq	%rdi
               	imulq	$0x66666667, %rdi, %rdi # imm = 0x66666667
               	shrq	$0x21, %rdi
               	movl	-0x108(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rsi, %rdi
               	jne	<addr>
               	movl	%edx, %edx
               	movq	%rdx, %rsi
               	shrq	%rsi
               	imulq	$0x66666667, %rsi, %rsi # imm = 0x66666667
               	shrq	$0x21, %rsi
               	imulq	$0xa, %rsi, %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movl	-0x108(%rbp), %edi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	popq	%rax
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x14, %rcx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0xe, %edx
               	movl	%edx, -0x100(%rbp)
               	leaq	<rip>, %rdx
               	movl	(%rdx,%rcx,4), %edx
               	movl	%edx, %esi
               	movq	%rsi, %rdi
               	shrq	%rdi
               	movl	$0x92492493, %r11d      # imm = 0x92492493
               	imulq	%r11, %rdi
               	shrq	$0x22, %rdi
               	movl	-0x100(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rsi, %rdi
               	jne	<addr>
               	movl	%edx, %edx
               	movq	%rdx, %rsi
               	shrq	%rsi
               	movl	$0x92492493, %r11d      # imm = 0x92492493
               	imulq	%r11, %rsi
               	shrq	$0x22, %rsi
               	imulq	$0xe, %rsi, %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movl	-0x100(%rbp), %edi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	popq	%rax
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x14, %rcx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x64, %edx
               	movl	%edx, -0xf8(%rbp)
               	leaq	<rip>, %rdx
               	movl	(%rdx,%rcx,4), %edx
               	movl	%edx, %esi
               	movq	%rsi, %rdi
               	shrq	$0x2, %rdi
               	imulq	$0xa3d70a4, %rdi, %rdi  # imm = 0xA3D70A4
               	shrq	$0x20, %rdi
               	movl	-0xf8(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rsi, %rdi
               	jne	<addr>
               	movl	%edx, %edx
               	movq	%rdx, %rsi
               	shrq	$0x2, %rsi
               	imulq	$0xa3d70a4, %rsi, %rsi  # imm = 0xA3D70A4
               	shrq	$0x20, %rsi
               	imulq	$0x64, %rsi, %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movl	-0xf8(%rbp), %edi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	popq	%rax
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x14, %rcx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x3e8, %edx            # imm = 0x3E8
               	movl	%edx, -0xf0(%rbp)
               	leaq	<rip>, %rdx
               	movl	(%rdx,%rcx,4), %edx
               	movl	%edx, %esi
               	movq	%rsi, %rdi
               	shrq	$0x3, %rdi
               	imulq	$0x10624dd3, %rdi, %rdi # imm = 0x10624DD3
               	shrq	$0x23, %rdi
               	movl	-0xf0(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rsi, %rdi
               	jne	<addr>
               	movl	%edx, %edx
               	movq	%rdx, %rsi
               	shrq	$0x3, %rsi
               	imulq	$0x10624dd3, %rsi, %rsi # imm = 0x10624DD3
               	shrq	$0x23, %rsi
               	imulq	$0x3e8, %rsi, %rsi      # imm = 0x3E8
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movl	-0xf0(%rbp), %edi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	popq	%rax
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x14, %rcx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x7fffffff, %edx       # imm = 0x7FFFFFFF
               	movl	%edx, -0xe8(%rbp)
               	leaq	<rip>, %rdx
               	movl	(%rdx,%rcx,4), %esi
               	movl	%esi, %edx
               	leaq	(%rdx,%rdx,2), %rdi
               	shrq	$0x20, %rdi
               	movq	%rdx, %r8
               	subq	%rdi, %r8
               	shrq	%r8
               	addq	%r8, %rdi
               	shrq	$0x1e, %rdi
               	movl	-0xe8(%rbp), %r8d
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	movl	%esi, %edx
               	leaq	(%rdx,%rdx,2), %rsi
               	shrq	$0x20, %rsi
               	movq	%rdx, %rdi
               	subq	%rsi, %rdi
               	shrq	%rdi
               	addq	%rdi, %rsi
               	shrq	$0x1e, %rsi
               	imulq	$0x7fffffff, %rsi, %rsi # imm = 0x7FFFFFFF
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movl	-0xe8(%rbp), %edi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	popq	%rax
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x14, %rcx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x80000001, %edx       # imm = 0x80000001
               	movl	%edx, -0xe0(%rbp)
               	leaq	<rip>, %rdx
               	movl	(%rdx,%rcx,4), %edx
               	movl	%edx, %esi
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	movq	%rsi, %rdi
               	cmpq	%r11, %rsi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	-0xe0(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rsi, %rdi
               	jne	<addr>
               	movl	%edx, %edx
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	movq	%rdx, %rsi
               	cmpq	%r11, %rdx
               	setae	%sil
               	movzbq	%sil, %rsi
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	imulq	%r11, %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movl	-0xe0(%rbp), %edi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	popq	%rax
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x14, %rcx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0xfffffffb, %edx       # imm = 0xFFFFFFFB
               	movl	%edx, -0xd8(%rbp)
               	leaq	<rip>, %rdx
               	movl	(%rdx,%rcx,4), %edx
               	movl	%edx, %esi
               	movl	$0xfffffffb, %r11d      # imm = 0xFFFFFFFB
               	movq	%rsi, %rdi
               	cmpq	%r11, %rsi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	-0xd8(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rsi, %rdi
               	jne	<addr>
               	movl	%edx, %edx
               	movl	$0xfffffffb, %r11d      # imm = 0xFFFFFFFB
               	movq	%rdx, %rsi
               	cmpq	%r11, %rdx
               	setae	%sil
               	movzbq	%sil, %rsi
               	movl	$0xfffffffb, %r11d      # imm = 0xFFFFFFFB
               	imulq	%r11, %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movl	-0xd8(%rbp), %edi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	popq	%rax
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x14, %rcx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x1, %edx
               	movl	%edx, -0xd0(%rbp)
               	leaq	<rip>, %rdx
               	movl	(%rdx,%rcx,4), %edx
               	movl	%edx, %esi
               	movl	-0xd0(%rbp), %edi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movl	%edx, %edx
               	movl	-0xd0(%rbp), %esi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	popq	%rax
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x14, %rcx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x10, %edx
               	movl	%edx, -0xc8(%rbp)
               	leaq	<rip>, %rdx
               	movl	(%rdx,%rcx,4), %edx
               	movl	%edx, %esi
               	movq	%rsi, %rdi
               	shrq	$0x4, %rdi
               	movl	-0xc8(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rsi, %rdi
               	jne	<addr>
               	movl	%edx, %edx
               	movq	%rdx, %rsi
               	andq	$0xf, %rsi
               	movl	-0xc8(%rbp), %edi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	popq	%rax
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x14, %rcx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x3, %ecx
               	movq	%rcx, -0xc0(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$0x5555555555555556, %rsi # imm = 0x5555555555555556
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	movq	-0xc0(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movabsq	$0x5555555555555556, %rsi # imm = 0x5555555555555556
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	leaq	(%rsi,%rsi,2), %rsi
               	movq	%rsi, %r10
               	movq	%rcx, %rsi
               	subq	%r10, %rsi
               	movq	-0xc0(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x7, %ecx
               	movq	%rcx, -0xb8(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$0x4924924924924925, %rsi # imm = 0x4924924924924925
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	sarq	%rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	movq	-0xb8(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movabsq	$0x4924924924924925, %rsi # imm = 0x4924924924924925
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	sarq	%rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	imulq	$0x7, %rsi, %rsi
               	movq	%rsi, %r10
               	movq	%rcx, %rsi
               	subq	%r10, %rsi
               	movq	-0xb8(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0xa, %ecx
               	movq	%rcx, -0xb0(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$0x6666666666666667, %rsi # imm = 0x6666666666666667
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	sarq	$0x2, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	movq	-0xb0(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movabsq	$0x6666666666666667, %rsi # imm = 0x6666666666666667
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	sarq	$0x2, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	imulq	$0xa, %rsi, %rsi
               	movq	%rsi, %r10
               	movq	%rcx, %rsi
               	subq	%r10, %rsi
               	movq	-0xb0(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x3e8, %ecx            # imm = 0x3E8
               	movq	%rcx, -0xa8(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$0x20c49ba5e353f7cf, %rsi # imm = 0x20C49BA5E353F7CF
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	sarq	$0x7, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	movq	-0xa8(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movabsq	$0x20c49ba5e353f7cf, %rsi # imm = 0x20C49BA5E353F7CF
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	sarq	$0x7, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	imulq	$0x3e8, %rsi, %rsi      # imm = 0x3E8
               	movq	%rsi, %r10
               	movq	%rcx, %rsi
               	subq	%r10, %rsi
               	movq	-0xa8(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x3b9aca07, %eax       # imm = 0x3B9ACA07
               	movq	%rax, -0xa0(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rdx,8), %rax
               	movabsq	$-0x768fa0ceed5d701b, %rsi # imm = 0x89705F3112A28FE5
               	pushq	%rax
               	pushq	%rdx
               	imulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	addq	%rax, %rsi
               	sarq	$0x1d, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	movq	-0xa0(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movabsq	$-0x768fa0ceed5d701b, %rsi # imm = 0x89705F3112A28FE5
               	pushq	%rax
               	pushq	%rdx
               	imulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	addq	%rax, %rsi
               	sarq	$0x1d, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	imulq	$0x3b9aca07, %rsi, %rsi # imm = 0x3B9ACA07
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movq	-0xa0(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rcx, -0x98(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$0x4000000000000001, %rsi # imm = 0x4000000000000001
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	sarq	$0x3d, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	movq	-0x98(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movabsq	$0x4000000000000001, %rsi # imm = 0x4000000000000001
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	sarq	$0x3d, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	imulq	%r11, %rsi
               	movq	%rsi, %r10
               	movq	%rcx, %rsi
               	subq	%r10, %rsi
               	movq	-0x98(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movabsq	$-0x3, %rcx
               	movq	%rcx, -0x90(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$0x5555555555555556, %rsi # imm = 0x5555555555555556
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	xorq	%rdi, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movq	-0x90(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movabsq	$0x5555555555555556, %rsi # imm = 0x5555555555555556
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	xorq	%rdi, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	imulq	$-0x3, %rsi, %rsi
               	movq	%rsi, %r10
               	movq	%rcx, %rsi
               	subq	%r10, %rsi
               	movq	-0x90(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movabsq	$-0x7, %rcx
               	movq	%rcx, -0x88(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$0x4924924924924925, %rsi # imm = 0x4924924924924925
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	sarq	%rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	xorq	%rdi, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movq	-0x88(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movabsq	$0x4924924924924925, %rsi # imm = 0x4924924924924925
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	sarq	%rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	xorq	%rdi, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	imulq	$-0x7, %rsi, %rsi
               	movq	%rsi, %r10
               	movq	%rcx, %rsi
               	subq	%r10, %rsi
               	movq	-0x88(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movabsq	$-0x3b9aca07, %rax      # imm = 0xC46535F9
               	movq	%rax, -0x80(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rdx,8), %rax
               	movabsq	$-0x768fa0ceed5d701b, %rsi # imm = 0x89705F3112A28FE5
               	pushq	%rax
               	pushq	%rdx
               	imulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	addq	%rax, %rsi
               	sarq	$0x1d, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	xorq	%rdi, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movq	-0x80(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movabsq	$-0x768fa0ceed5d701b, %rsi # imm = 0x89705F3112A28FE5
               	pushq	%rax
               	pushq	%rdx
               	imulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	addq	%rax, %rsi
               	sarq	$0x1d, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	xorq	%rdi, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	imulq	$-0x3b9aca07, %rsi, %rsi # imm = 0xC46535F9
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movq	-0x80(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, -0x78(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rdx,8), %rax
               	movq	%rax, %rsi
               	sarq	$0x3f, %rsi
               	shrq	%rsi
               	addq	%rax, %rsi
               	sarq	$0x3f, %rsi
               	xorq	%rdi, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movq	-0x78(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movq	%rax, %rsi
               	sarq	$0x3f, %rsi
               	shrq	%rsi
               	leaq	(%rax,%rsi), %rdi
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%r11, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movq	-0x78(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x1, %edx
               	movq	%rdx, -0x70(%rbp)
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
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
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x14, %rcx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x400, %eax            # imm = 0x400
               	movq	%rax, -0x68(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rdx,8), %rax
               	movq	%rax, %rsi
               	sarq	$0x3f, %rsi
               	shrq	$0x36, %rsi
               	addq	%rax, %rsi
               	sarq	$0xa, %rsi
               	movq	-0x68(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movq	%rax, %rsi
               	sarq	$0x3f, %rsi
               	shrq	$0x36, %rsi
               	leaq	(%rax,%rsi), %rdi
               	andq	$0x3ff, %rdi            # imm = 0x3FF
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movq	-0x68(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movabsq	$-0x400, %rax           # imm = 0xFC00
               	movq	%rax, -0x60(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rdx,8), %rax
               	movq	%rax, %rsi
               	sarq	$0x3f, %rsi
               	shrq	$0x36, %rsi
               	addq	%rax, %rsi
               	sarq	$0xa, %rsi
               	xorq	%rdi, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movq	-0x60(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movq	%rax, %rsi
               	sarq	$0x3f, %rsi
               	shrq	$0x36, %rsi
               	leaq	(%rax,%rsi), %rdi
               	andq	$0x3ff, %rdi            # imm = 0x3FF
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movq	-0x60(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x3, %ecx
               	movq	%rcx, -0x58(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$-0x5555555555555555, %rsi # imm = 0xAAAAAAAAAAAAAAAB
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	mulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	shrq	%rsi
               	movq	-0x58(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movabsq	$-0x5555555555555555, %rsi # imm = 0xAAAAAAAAAAAAAAAB
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	mulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	shrq	%rsi
               	leaq	(%rsi,%rsi,2), %rsi
               	movq	%rsi, %r10
               	movq	%rcx, %rsi
               	subq	%r10, %rsi
               	movq	-0x58(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x7, %eax
               	movq	%rax, -0x50(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rdx,8), %rax
               	movabsq	$0x2492492492492493, %rsi # imm = 0x2492492492492493
               	pushq	%rax
               	pushq	%rdx
               	mulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rax, %rdi
               	subq	%rsi, %rdi
               	shrq	%rdi
               	addq	%rdi, %rsi
               	shrq	$0x2, %rsi
               	movq	-0x50(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movabsq	$0x2492492492492493, %rsi # imm = 0x2492492492492493
               	pushq	%rax
               	pushq	%rdx
               	mulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rax, %rdi
               	subq	%rsi, %rdi
               	shrq	%rdi
               	addq	%rdi, %rsi
               	shrq	$0x2, %rsi
               	imulq	$0x7, %rsi, %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movq	-0x50(%rbp), %rdi
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0xa, %ecx
               	movq	%rcx, -0x48(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rdx,8), %rcx
               	movq	%rcx, %rsi
               	shrq	%rsi
               	movabsq	$0x6666666666666667, %rdi # imm = 0x6666666666666667
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	mulq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	shrq	%rsi
               	movq	-0x48(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movq	%rcx, %rsi
               	shrq	%rsi
               	movabsq	$0x6666666666666667, %rdi # imm = 0x6666666666666667
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	mulq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	shrq	%rsi
               	imulq	$0xa, %rsi, %rsi
               	movq	%rsi, %r10
               	movq	%rcx, %rsi
               	subq	%r10, %rsi
               	movq	-0x48(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0xe, %ecx
               	movq	%rcx, -0x40(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rdx,8), %rcx
               	movq	%rcx, %rsi
               	shrq	%rsi
               	movabsq	$0x4924924924924925, %rdi # imm = 0x4924924924924925
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	mulq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	shrq	%rsi
               	movq	-0x40(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movq	%rcx, %rsi
               	shrq	%rsi
               	movabsq	$0x4924924924924925, %rdi # imm = 0x4924924924924925
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	mulq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	shrq	%rsi
               	imulq	$0xe, %rsi, %rsi
               	movq	%rsi, %r10
               	movq	%rcx, %rsi
               	subq	%r10, %rsi
               	movq	-0x40(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x3b9aca07, %ecx       # imm = 0x3B9ACA07
               	movq	%rcx, -0x38(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$-0x768fa0ceed5d701b, %rsi # imm = 0x89705F3112A28FE5
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	mulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	shrq	$0x1d, %rsi
               	movq	-0x38(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movabsq	$-0x768fa0ceed5d701b, %rsi # imm = 0x89705F3112A28FE5
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	mulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	shrq	$0x1d, %rsi
               	imulq	$0x3b9aca07, %rsi, %rsi # imm = 0x3B9ACA07
               	movq	%rsi, %r10
               	movq	%rcx, %rsi
               	subq	%r10, %rsi
               	movq	-0x38(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movabsq	$-0x7fffffffffffffff, %rcx # imm = 0x8000000000000001
               	movq	%rcx, -0x30(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$-0x7fffffffffffffff, %r11 # imm = 0x8000000000000001
               	movq	%rcx, %rsi
               	cmpq	%r11, %rcx
               	setae	%sil
               	movzbq	%sil, %rsi
               	movq	-0x30(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movabsq	$-0x7fffffffffffffff, %r11 # imm = 0x8000000000000001
               	movq	%rcx, %rsi
               	cmpq	%r11, %rcx
               	setae	%sil
               	movzbq	%sil, %rsi
               	movabsq	$-0x7fffffffffffffff, %r11 # imm = 0x8000000000000001
               	imulq	%r11, %rsi
               	movq	%rsi, %r10
               	movq	%rcx, %rsi
               	subq	%r10, %rsi
               	movq	-0x30(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movabsq	$-0x5, %rcx
               	movq	%rcx, -0x28(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rdx,8), %rcx
               	cmpq	$-0x5, %rcx
               	setae	%sil
               	movzbq	%sil, %rsi
               	movq	-0x28(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	cmpq	$-0x5, %rcx
               	setae	%sil
               	movzbq	%sil, %rsi
               	imulq	$-0x5, %rsi, %rsi
               	movq	%rsi, %r10
               	movq	%rcx, %rsi
               	subq	%r10, %rsi
               	movq	-0x28(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x14, %rdx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x1, %edx
               	movq	%rdx, -0x20(%rbp)
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movq	-0x20(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movq	-0x20(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	popq	%rax
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x14, %rcx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x400, %edx            # imm = 0x400
               	movq	%rdx, -0x18(%rbp)
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movq	%rdx, %rsi
               	shrq	$0xa, %rsi
               	movq	-0x18(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movq	%rdx, %rsi
               	andq	$0x3ff, %rsi            # imm = 0x3FF
               	movq	-0x18(%rbp), %rdi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	popq	%rax
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x14, %rcx
               	jl	<addr>
               	movabsq	$-0x3039, %rax          # imm = 0xCFC7
               	movl	%eax, -0x10(%rbp)
               	movabsq	$-0x11f71fb04cb, %rax   # imm = 0xFFFFFEE08E04FB35
               	movq	%rax, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	cmpq	$0x3039, %rax           # imm = 0x3039
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	-0x10(%rbp), %rax
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5a, %eax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	movabsq	$0x11f71fb04cb, %r11    # imm = 0x11F71FB04CB
               	cmpq	%r11, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5b, %eax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
