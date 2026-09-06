
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
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rcx)
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
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movslq	%edx, %rax
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
               	cmpl	$0x14, %edx
               	jl	<addr>
               	xorq	%rax, %rax
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
               	jmp	<addr>
               	movl	$0x3, %eax
               	movl	%eax, -0x1a8(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movslq	(%rax,%rsi,4), %rax
               	imulq	$0x55555556, %rax, %rdi # imm = 0x55555556
               	movq	%rdi, %rdx
               	sarq	$0x20, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %r9
               	movslq	-0x1a8(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r9
               	jne	<addr>
               	leaq	(%r9,%r9,2), %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movslq	-0x1a8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x14, %ecx
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
               	movslq	%ecx, %rsi
               	movslq	(%rax,%rsi,4), %rax
               	imulq	$0x66666667, %rax, %rdi # imm = 0x66666667
               	movq	%rdi, %rdx
               	sarq	$0x21, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %r9
               	movslq	-0x1a0(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r9
               	jne	<addr>
               	leaq	(%r9,%r9,4), %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movslq	-0x1a0(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x14, %ecx
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
               	movslq	%ecx, %rsi
               	movslq	(%rax,%rsi,4), %rax
               	imulq	$0x2aaaaaab, %rax, %rdi # imm = 0x2AAAAAAB
               	movq	%rdi, %rdx
               	sarq	$0x20, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %r9
               	movslq	-0x198(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r9
               	jne	<addr>
               	imulq	$0x6, %r9, %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movslq	-0x198(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x14, %ecx
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
               	movslq	%ecx, %rsi
               	movslq	(%rax,%rsi,4), %rax
               	movl	$0x92492493, %edi       # imm = 0x92492493
               	imulq	%rax, %rdi
               	movq	%rdi, %rdx
               	sarq	$0x22, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %r9
               	movslq	-0x190(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r9
               	jne	<addr>
               	imulq	$0x7, %r9, %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movslq	-0x190(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x14, %ecx
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
               	movslq	%ecx, %rsi
               	movslq	(%rax,%rsi,4), %rax
               	imulq	$0x66666667, %rax, %rdi # imm = 0x66666667
               	movq	%rdi, %rdx
               	sarq	$0x22, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %r9
               	movslq	-0x188(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r9
               	jne	<addr>
               	imulq	$0xa, %r9, %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movslq	-0x188(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x14, %ecx
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
               	movslq	%ecx, %rsi
               	movslq	(%rax,%rsi,4), %rax
               	imulq	$0x51eb851f, %rax, %rdi # imm = 0x51EB851F
               	movq	%rdi, %rdx
               	sarq	$0x25, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %r9
               	movslq	-0x180(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r9
               	jne	<addr>
               	imulq	$0x64, %r9, %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movslq	-0x180(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x14, %ecx
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
               	movslq	%ecx, %rsi
               	movslq	(%rax,%rsi,4), %rax
               	imulq	$0x10624dd3, %rax, %rdi # imm = 0x10624DD3
               	movq	%rdi, %rdx
               	sarq	$0x26, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %r9
               	movslq	-0x178(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r9
               	jne	<addr>
               	imulq	$0x3e8, %r9, %rdx       # imm = 0x3E8
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movslq	-0x178(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x14, %ecx
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
               	movslq	%ecx, %rsi
               	movslq	(%rax,%rsi,4), %rax
               	movl	$0x80008001, %edi       # imm = 0x80008001
               	imulq	%rax, %rdi
               	movq	%rdi, %rdx
               	sarq	$0x2f, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %r9
               	movslq	-0x170(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r9
               	jne	<addr>
               	imulq	$0xffff, %r9, %rdx      # imm = 0xFFFF
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movslq	-0x170(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x14, %ecx
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
               	movslq	%ecx, %rsi
               	movslq	(%rax,%rsi,4), %rax
               	imulq	$0x7fff8001, %rax, %rdi # imm = 0x7FFF8001
               	movq	%rdi, %rdx
               	sarq	$0x2f, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %r9
               	movslq	-0x168(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r9
               	jne	<addr>
               	imulq	$0x10001, %r9, %rdx     # imm = 0x10001
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movslq	-0x168(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x14, %ecx
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
               	movslq	%ecx, %rsi
               	movslq	(%rax,%rsi,4), %rax
               	imulq	$0x40000001, %rax, %rdi # imm = 0x40000001
               	movq	%rdi, %rdx
               	sarq	$0x3d, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %r9
               	movslq	-0x160(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r9
               	jne	<addr>
               	imulq	$0x7fffffff, %r9, %rdx  # imm = 0x7FFFFFFF
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movslq	-0x160(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	jmp	<addr>
               	movabsq	$-0x3, %rax
               	movl	%eax, -0x158(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movslq	(%rax,%rsi,4), %rax
               	imulq	$0x55555556, %rax, %r8  # imm = 0x55555556
               	movq	%r8, %rdx
               	sarq	$0x20, %rdx
               	movq	%rdx, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdx,%r9), %rbx
               	movq	%rdi, %r12
               	subq	%rbx, %r12
               	movslq	-0x158(%rbp), %r13
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r13
               	movq	%rax, %r13
               	popq	%rdx
               	popq	%rax
               	cmpq	%r13, %r12
               	jne	<addr>
               	xorq	%rdx, %rdx
               	subq	%rbx, %rdx
               	imulq	$-0x3, %rdx, %rdx
               	movq	%rax, %r8
               	subq	%rdx, %r8
               	movslq	-0x158(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %r8
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	jmp	<addr>
               	movabsq	$-0x7, %rax
               	movl	%eax, -0x150(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movslq	(%rax,%rsi,4), %rax
               	movl	$0x92492493, %r8d       # imm = 0x92492493
               	imulq	%rax, %r8
               	movq	%r8, %rdx
               	sarq	$0x22, %rdx
               	movq	%rdx, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdx,%r9), %rbx
               	movq	%rdi, %r12
               	subq	%rbx, %r12
               	movslq	-0x150(%rbp), %r13
               	pushq	%rax
               	pushq	%rdx
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
               	movq	%rax, %r8
               	subq	%rdx, %r8
               	movslq	-0x150(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %r8
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	jmp	<addr>
               	movabsq	$-0x64, %rax
               	movl	%eax, -0x148(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movslq	(%rax,%rsi,4), %rax
               	imulq	$0x51eb851f, %rax, %r8  # imm = 0x51EB851F
               	movq	%r8, %rdx
               	sarq	$0x25, %rdx
               	movq	%rdx, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdx,%r9), %rbx
               	movq	%rdi, %r12
               	subq	%rbx, %r12
               	movslq	-0x148(%rbp), %r13
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r13
               	movq	%rax, %r13
               	popq	%rdx
               	popq	%rax
               	cmpq	%r13, %r12
               	jne	<addr>
               	xorq	%rdx, %rdx
               	subq	%rbx, %rdx
               	imulq	$-0x64, %rdx, %rdx
               	movq	%rax, %r8
               	subq	%rdx, %r8
               	movslq	-0x148(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %r8
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	jmp	<addr>
               	movabsq	$-0x80000000, %rax      # imm = 0x80000000
               	movl	%eax, -0x140(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movslq	(%rax,%rdx,4), %rax
               	movq	%rax, %r8
               	sarq	$0x3f, %r8
               	movq	%r8, %rsi
               	shrq	$0x21, %rsi
               	leaq	(%rax,%rsi), %r9
               	movq	%r9, %rbx
               	sarq	$0x1f, %rbx
               	movq	%rbx, %r10
               	movq	%rdi, %rbx
               	subq	%r10, %rbx
               	movslq	-0x140(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rbx
               	jne	<addr>
               	movq	%r9, %r8
               	andq	$0x7fffffff, %r8        # imm = 0x7FFFFFFF
               	subq	%rsi, %r8
               	movslq	-0x140(%rbp), %rsi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %r8
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x14, %ecx
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
               	movslq	%eax, %rdx
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
               	cmpl	$0x14, %eax
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
               	movslq	%ecx, %rdx
               	movslq	(%rax,%rdx,4), %rax
               	movq	%rax, %rdi
               	sarq	$0x3f, %rdi
               	movq	%rdi, %rsi
               	shrq	$0x3d, %rsi
               	leaq	(%rax,%rsi), %r8
               	movq	%r8, %r9
               	sarq	$0x3, %r9
               	movslq	-0x130(%rbp), %rbx
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
               	andq	$0x7, %rdi
               	subq	%rsi, %rdi
               	movslq	-0x130(%rbp), %rsi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	jmp	<addr>
               	movabsq	$-0x8, %rax
               	movl	%eax, -0x128(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movslq	(%rax,%rdx,4), %rax
               	movq	%rax, %r8
               	sarq	$0x3f, %r8
               	movq	%r8, %rsi
               	shrq	$0x3d, %rsi
               	leaq	(%rax,%rsi), %r9
               	movq	%r9, %rbx
               	sarq	$0x3, %rbx
               	movq	%rbx, %r10
               	movq	%rdi, %rbx
               	subq	%r10, %rbx
               	movslq	-0x128(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rbx
               	jne	<addr>
               	movq	%r9, %r8
               	andq	$0x7, %r8
               	subq	%rsi, %r8
               	movslq	-0x128(%rbp), %rsi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %r8
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x14, %ecx
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
               	movslq	%ecx, %rdx
               	movslq	(%rax,%rdx,4), %rax
               	movq	%rax, %rdi
               	sarq	$0x3f, %rdi
               	movq	%rdi, %rsi
               	shrq	$0x22, %rsi
               	leaq	(%rax,%rsi), %r8
               	movq	%r8, %r9
               	sarq	$0x1e, %r9
               	movslq	-0x120(%rbp), %rbx
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
               	andq	$0x3fffffff, %rdi       # imm = 0x3FFFFFFF
               	subq	%rsi, %rdi
               	movslq	-0x120(%rbp), %rsi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x3, %ecx
               	movl	%ecx, -0x118(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movl	(%rcx,%rdx,4), %esi
               	movl	%esi, %ecx
               	movl	$0xaaaaaaab, %edi       # imm = 0xAAAAAAAB
               	imulq	%rcx, %rdi
               	movq	%rdi, %r8
               	shrq	$0x21, %r8
               	movl	-0x118(%rbp), %r9d
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
               	leaq	(%r8,%r8,2), %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movl	-0x118(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x7, %eax
               	movl	%eax, -0x110(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movl	(%rax,%rsi,4), %edi
               	movl	%edi, %eax
               	imulq	$0x24924925, %rax, %r8  # imm = 0x24924925
               	movq	%r8, %rdx
               	shrq	$0x20, %rdx
               	movq	%rax, %r9
               	subq	%rdx, %r9
               	movq	%r9, %rbx
               	shrq	%rbx
               	addq	%rdx, %rbx
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
               	movq	%r9, %rdi
               	shrq	%rdi
               	addq	%rdi, %rdx
               	shrq	$0x2, %rdx
               	imulq	$0x7, %rdx, %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movl	-0x110(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0xa, %ecx
               	movl	%ecx, -0x108(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movl	(%rcx,%rdx,4), %esi
               	movl	%esi, %ecx
               	movq	%rcx, %rdi
               	shrq	%rdi
               	imulq	$0x66666667, %rdi, %r8  # imm = 0x66666667
               	movq	%r8, %r9
               	shrq	$0x21, %r9
               	movl	-0x108(%rbp), %ebx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r9
               	jne	<addr>
               	imulq	$0xa, %r9, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movl	-0x108(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0xe, %ecx
               	movl	%ecx, -0x100(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movl	(%rcx,%rdx,4), %esi
               	movl	%esi, %ecx
               	movq	%rcx, %rdi
               	shrq	%rdi
               	movl	$0x92492493, %r8d       # imm = 0x92492493
               	imulq	%rdi, %r8
               	movq	%r8, %r9
               	shrq	$0x22, %r9
               	movl	-0x100(%rbp), %ebx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r9
               	jne	<addr>
               	imulq	$0xe, %r9, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movl	-0x100(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x64, %ecx
               	movl	%ecx, -0xf8(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movl	(%rcx,%rdx,4), %esi
               	movl	%esi, %ecx
               	movq	%rcx, %rdi
               	shrq	$0x2, %rdi
               	imulq	$0xa3d70a4, %rdi, %r8   # imm = 0xA3D70A4
               	movq	%r8, %r9
               	shrq	$0x20, %r9
               	movl	-0xf8(%rbp), %ebx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r9
               	jne	<addr>
               	imulq	$0x64, %r9, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movl	-0xf8(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x3e8, %ecx            # imm = 0x3E8
               	movl	%ecx, -0xf0(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movl	(%rcx,%rdx,4), %esi
               	movl	%esi, %ecx
               	movq	%rcx, %rdi
               	shrq	$0x3, %rdi
               	imulq	$0x10624dd3, %rdi, %r8  # imm = 0x10624DD3
               	movq	%r8, %r9
               	shrq	$0x23, %r9
               	movl	-0xf0(%rbp), %ebx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r9
               	jne	<addr>
               	imulq	$0x3e8, %r9, %rsi       # imm = 0x3E8
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movl	-0xf0(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
               	movl	%eax, -0xe8(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movl	(%rax,%rsi,4), %edi
               	movl	%edi, %eax
               	leaq	(%rax,%rax,2), %r8
               	movq	%r8, %rdx
               	shrq	$0x20, %rdx
               	movq	%rax, %r9
               	subq	%rdx, %r9
               	movq	%r9, %rbx
               	shrq	%rbx
               	addq	%rdx, %rbx
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
               	movq	%r9, %rdi
               	shrq	%rdi
               	addq	%rdi, %rdx
               	shrq	$0x1e, %rdx
               	imulq	$0x7fffffff, %rdx, %rdx # imm = 0x7FFFFFFF
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movl	-0xe8(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x80000001, %ecx       # imm = 0x80000001
               	movl	%ecx, -0xe0(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movl	(%rcx,%rdx,4), %esi
               	movl	%esi, %ecx
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	movq	%rcx, %rdi
               	cmpl	%r11d, %ecx
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	-0xe0(%rbp), %r8d
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
               	movl	$0x80000001, %esi       # imm = 0x80000001
               	imulq	%rdi, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movl	-0xe0(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0xfffffffb, %ecx       # imm = 0xFFFFFFFB
               	movl	%ecx, -0xd8(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movl	(%rcx,%rdx,4), %esi
               	movl	%esi, %ecx
               	movl	$0xfffffffb, %r11d      # imm = 0xFFFFFFFB
               	movq	%rcx, %rdi
               	cmpl	%r11d, %ecx
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	-0xd8(%rbp), %r8d
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
               	movl	$0xfffffffb, %esi       # imm = 0xFFFFFFFB
               	imulq	%rdi, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movl	-0xd8(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movl	%ecx, -0xd0(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movl	(%rcx,%rdx,4), %esi
               	movl	%esi, %ecx
               	movl	-0xd0(%rbp), %edi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rcx
               	jne	<addr>
               	movl	-0xd0(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x10, %ecx
               	movl	%ecx, -0xc8(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movl	(%rcx,%rdx,4), %esi
               	movl	%esi, %ecx
               	movq	%rcx, %rdi
               	shrq	$0x4, %rdi
               	movl	-0xc8(%rbp), %r8d
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
               	movq	%rcx, %rdi
               	andq	$0xf, %rdi
               	movl	-0xc8(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x14, %eax
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
               	movslq	%eax, %rsi
               	movq	(%rcx,%rsi,8), %rcx
               	movabsq	$0x5555555555555556, %rdi # imm = 0x5555555555555556
               	pushq	%rax
               	movq	%rcx, %rax
               	imulq	%rdi
               	popq	%rax
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %r9
               	movq	-0xc0(%rbp), %rbx
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
               	leaq	(%r9,%r9,2), %rdx
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
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
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x14, %eax
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
               	movslq	%eax, %rsi
               	movq	(%rcx,%rsi,8), %rcx
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
               	movq	-0xb8(%rbp), %r12
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
               	imulq	$0x7, %rbx, %rdx
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
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
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x14, %eax
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
               	movslq	%eax, %rsi
               	movq	(%rcx,%rsi,8), %rcx
               	movabsq	$0x6666666666666667, %rdi # imm = 0x6666666666666667
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%rdi
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %rdx
               	sarq	$0x2, %rdx
               	movq	%rdx, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdx,%r9), %rbx
               	movq	-0xb0(%rbp), %r12
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
               	imulq	$0xa, %rbx, %rdx
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
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
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x14, %eax
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
               	movslq	%eax, %rsi
               	movq	(%rcx,%rsi,8), %rcx
               	movabsq	$0x20c49ba5e353f7cf, %rdi # imm = 0x20C49BA5E353F7CF
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%rdi
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %rdx
               	sarq	$0x7, %rdx
               	movq	%rdx, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdx,%r9), %rbx
               	movq	-0xa8(%rbp), %r12
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
               	imulq	$0x3e8, %rbx, %rdx      # imm = 0x3E8
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
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
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x14, %eax
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
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
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
               	movq	-0xa0(%rbp), %r13
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
               	imulq	$0x3b9aca07, %rdx, %rdx # imm = 0x3B9ACA07
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movq	-0xa0(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x14, %ecx
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
               	movslq	%eax, %rsi
               	movq	(%rcx,%rsi,8), %rcx
               	movabsq	$0x4000000000000001, %rdi # imm = 0x4000000000000001
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%rdi
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %rdx
               	sarq	$0x3d, %rdx
               	movq	%rdx, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdx,%r9), %rbx
               	movq	-0x98(%rbp), %r12
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
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	imulq	%rbx, %rdx
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
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
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	jmp	<addr>
               	movabsq	$-0x3, %rax
               	movq	%rax, -0x90(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	movabsq	$0x5555555555555556, %r8 # imm = 0x5555555555555556
               	pushq	%rax
               	imulq	%r8
               	popq	%rax
               	movq	%rdx, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdx,%r9), %rbx
               	movq	%rdi, %r12
               	subq	%rbx, %r12
               	movq	-0x90(%rbp), %r13
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r13
               	movq	%rax, %r13
               	popq	%rdx
               	popq	%rax
               	cmpq	%r13, %r12
               	jne	<addr>
               	xorq	%rdx, %rdx
               	subq	%rbx, %rdx
               	imulq	$-0x3, %rdx, %rdx
               	movq	%rax, %r8
               	subq	%rdx, %r8
               	movq	-0x90(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %r8
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	jmp	<addr>
               	movabsq	$-0x7, %rax
               	movq	%rax, -0x88(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	movabsq	$0x4924924924924925, %r8 # imm = 0x4924924924924925
               	pushq	%rax
               	pushq	%rdx
               	imulq	%r8
               	movq	%rdx, %r9
               	popq	%rdx
               	popq	%rax
               	movq	%r9, %rdx
               	sarq	%rdx
               	movq	%rdx, %rbx
               	shrq	$0x3f, %rbx
               	leaq	(%rdx,%rbx), %r12
               	movq	%r12, %r10
               	movq	%rdi, %r12
               	subq	%r10, %r12
               	movq	-0x88(%rbp), %r13
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
               	xorq	%r8, %r8
               	movq	%rdx, %r10
               	movq	%r8, %rdx
               	subq	%r10, %rdx
               	imulq	$-0x7, %rdx, %rdx
               	movq	%rax, %r8
               	subq	%rdx, %r8
               	movq	-0x88(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %r8
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	jmp	<addr>
               	movabsq	$-0x3b9aca07, %rax      # imm = 0xC46535F9
               	movq	%rax, -0x80(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	movabsq	$-0x768fa0ceed5d701b, %r8 # imm = 0x89705F3112A28FE5
               	pushq	%rax
               	pushq	%rdx
               	imulq	%r8
               	movq	%rdx, %r9
               	popq	%rdx
               	popq	%rax
               	leaq	(%r9,%rax), %rbx
               	movq	%rbx, %rdx
               	sarq	$0x1d, %rdx
               	movq	%rdx, %r12
               	shrq	$0x3f, %r12
               	addq	%rdx, %r12
               	movq	%r12, %r10
               	movq	%rdi, %r12
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
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rdx
               	xorq	%r8, %r8
               	movq	%rdx, %r10
               	movq	%r8, %rdx
               	subq	%r10, %rdx
               	imulq	$-0x3b9aca07, %rdx, %rdx # imm = 0xC46535F9
               	movq	%rax, %r8
               	subq	%rdx, %r8
               	movq	-0x80(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %r8
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	jmp	<addr>
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, -0x78(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movq	%rax, %r8
               	sarq	$0x3f, %r8
               	movq	%r8, %rsi
               	shrq	%rsi
               	leaq	(%rax,%rsi), %r9
               	movq	%r9, %rbx
               	sarq	$0x3f, %rbx
               	movq	%rbx, %r10
               	movq	%rdi, %rbx
               	subq	%r10, %rbx
               	movq	-0x78(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
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
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %r8
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, -0x70(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movq	-0x70(%rbp), %rsi
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
               	movq	-0x70(%rbp), %rsi
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
               	cmpl	$0x14, %eax
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
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movq	%rax, %rdi
               	sarq	$0x3f, %rdi
               	movq	%rdi, %rsi
               	shrq	$0x36, %rsi
               	leaq	(%rax,%rsi), %r8
               	movq	%r8, %r9
               	sarq	$0xa, %r9
               	movq	-0x68(%rbp), %rbx
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
               	subq	%rsi, %rdi
               	movq	-0x68(%rbp), %rsi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	jmp	<addr>
               	movabsq	$-0x400, %rax           # imm = 0xFC00
               	movq	%rax, -0x60(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movq	%rax, %r8
               	sarq	$0x3f, %r8
               	movq	%r8, %rsi
               	shrq	$0x36, %rsi
               	leaq	(%rax,%rsi), %r9
               	movq	%r9, %rbx
               	sarq	$0xa, %rbx
               	movq	%rbx, %r10
               	movq	%rdi, %rbx
               	subq	%r10, %rbx
               	movq	-0x60(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
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
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %r8
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x14, %ecx
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
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$-0x5555555555555555, %rsi # imm = 0xAAAAAAAAAAAAAAAB
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	mulq	%rsi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	%rdi, %r8
               	shrq	%r8
               	movq	-0x58(%rbp), %r9
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
               	leaq	(%r8,%r8,2), %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x58(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x14, %eax
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
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	movabsq	$0x2492492492492493, %rdi # imm = 0x2492492492492493
               	pushq	%rax
               	mulq	%rdi
               	popq	%rax
               	movq	%rax, %r8
               	subq	%rdx, %r8
               	movq	%r8, %r9
               	shrq	%r9
               	leaq	(%r9,%rdx), %rbx
               	movq	%rbx, %r12
               	shrq	$0x2, %r12
               	movq	-0x50(%rbp), %r13
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r13
               	movq	%rax, %r13
               	popq	%rdx
               	popq	%rax
               	cmpq	%r13, %r12
               	jne	<addr>
               	movq	%rbx, %rdx
               	shrq	$0x2, %rdx
               	imulq	$0x7, %rdx, %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movq	-0x50(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x14, %ecx
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
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movq	%rcx, %rsi
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
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r9
               	jne	<addr>
               	imulq	$0xa, %r9, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x48(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x14, %eax
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
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movq	%rcx, %rsi
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
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r9
               	jne	<addr>
               	imulq	$0xe, %r9, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x40(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x14, %eax
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
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$-0x768fa0ceed5d701b, %rsi # imm = 0x89705F3112A28FE5
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	mulq	%rsi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	%rdi, %r8
               	shrq	$0x1d, %r8
               	movq	-0x38(%rbp), %r9
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
               	imulq	$0x3b9aca07, %r8, %rsi  # imm = 0x3B9ACA07
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x38(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x14, %eax
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
               	movslq	%eax, %rdx
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
               	imulq	%r11, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x30(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x14, %eax
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
               	movslq	%eax, %rdx
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
               	imulq	$-0x5, %rsi, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x28(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, -0x20(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movq	-0x20(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rsi, %rcx
               	jne	<addr>
               	movq	-0x20(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x400, %ecx            # imm = 0x400
               	movq	%rcx, -0x18(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movq	%rcx, %rsi
               	shrq	$0xa, %rsi
               	movq	-0x18(%rbp), %rdi
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
               	movq	%rcx, %rdi
               	andq	$0x3ff, %rdi            # imm = 0x3FF
               	movq	-0x18(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
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
