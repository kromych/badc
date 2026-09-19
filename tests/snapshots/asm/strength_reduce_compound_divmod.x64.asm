
strength_reduce_compound_divmod.x64:	file format elf64-x86-64

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
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %ecx
               	movq	%rcx, 0x8(%rax)
               	movabsq	$-0x1, %rcx
               	movq	%rcx, 0x10(%rax)
               	movl	$0x2, %ecx
               	movq	%rcx, 0x18(%rax)
               	movabsq	$-0x2, %rcx
               	movq	%rcx, 0x20(%rax)
               	movl	$0x7fffffff, %ecx       # imm = 0x7FFFFFFF
               	movq	%rcx, 0x28(%rax)
               	movabsq	$-0x80000000, %rcx      # imm = 0x80000000
               	movq	%rcx, 0x30(%rax)
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rcx, 0x38(%rax)
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%rcx, 0x40(%rax)
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movq	%rcx, 0x48(%rax)
               	movl	$0x7f, %ecx
               	movq	%rcx, 0x50(%rax)
               	movabsq	$-0x80, %rcx
               	movq	%rcx, 0x58(%rax)
               	movl	$0xff, %ecx
               	movq	%rcx, 0x60(%rax)
               	movl	$0x7fff, %ecx           # imm = 0x7FFF
               	movq	%rcx, 0x68(%rax)
               	movabsq	$-0x8000, %rcx          # imm = 0x8000
               	movq	%rcx, 0x70(%rax)
               	movl	$0xffff, %ecx           # imm = 0xFFFF
               	movq	%rcx, 0x78(%rax)
               	movabsq	$0x2ceaee21bf46bc00, %rcx # imm = 0x2CEAEE21BF46BC00
               	movq	%rcx, 0x80(%rax)
               	movabsq	$-0x557f8ab2e5e572b1, %rcx # imm = 0xAA80754D1A1A8D4F
               	movq	%rcx, 0x88(%rax)
               	movabsq	$-0x4c3b6fb592d876ce, %rcx # imm = 0xB3C4904A6D278932
               	movq	%rcx, 0x90(%rax)
               	movabsq	$-0x439630bd897b92e7, %rcx # imm = 0xBC69CF4276846D19
               	movq	%rcx, 0x98(%rax)
               	movabsq	$0x377b2fd56a5b15b4, %rcx # imm = 0x377B2FD56A5B15B4
               	movq	%rcx, 0xa0(%rax)
               	movabsq	$0x64d815deeaf29df3, %rcx # imm = 0x64D815DEEAF29DF3
               	movq	%rcx, 0xa8(%rax)
               	movabsq	$-0x991eff24d282dfa, %rcx # imm = 0xF66E100DB2D7D206
               	movq	%rcx, 0xb0(%rax)
               	movabsq	$0x1069e6a57e06665d, %rcx # imm = 0x1069E6A57E06665D
               	movq	%rcx, 0xb8(%rax)
               	retq

<plain>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0xa, %eax
               	movl	%eax, -0xe0(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	movslq	%eax, %rax
               	imulq	$0x66666667, %rax, %r8  # imm = 0x66666667
               	movq	%r8, %rdx
               	sarq	$0x22, %rdx
               	movq	%rdx, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdx,%r9), %rdi
               	imulq	$0xa, %rdi, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movslq	-0xe0(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r8
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movslq	-0xe0(%rbp), %r8
               	pushq	%rdx
               	cqto
               	idivq	%r8
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%eax, %edx
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x7, %eax
               	movl	%eax, -0xd8(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	movslq	%eax, %rax
               	movl	$0x92492493, %r8d       # imm = 0x92492493
               	imulq	%rax, %r8
               	movq	%r8, %rdx
               	sarq	$0x22, %rdx
               	movq	%rdx, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdx,%r9), %rdi
               	imulq	$0x7, %rdi, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movslq	-0xd8(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r8
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movslq	-0xd8(%rbp), %r8
               	pushq	%rdx
               	cqto
               	idivq	%r8
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%eax, %edx
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movabsq	$-0x7, %rax
               	movl	%eax, -0xd0(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	movslq	%eax, %rax
               	movl	$0x92492493, %edi       # imm = 0x92492493
               	imulq	%rax, %rdi
               	movq	%rdi, %rdx
               	sarq	$0x22, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %r9
               	xorq	%rbx, %rbx
               	movq	%rbx, %r12
               	subq	%r9, %r12
               	movq	%rbx, %rdx
               	subq	%r9, %rdx
               	imulq	$-0x7, %rdx, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movslq	-0xd0(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movslq	-0xd0(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r8d, %r12d
               	jne	<addr>
               	cmpl	%eax, %edx
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x10, %eax
               	movl	%eax, -0xc8(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	shrq	$0x3c, %rsi
               	leaq	(%rax,%rsi), %rdi
               	movq	%rdi, %r8
               	sarq	$0x4, %r8
               	andq	$0xf, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movslq	-0xc8(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movslq	-0xc8(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	cmpl	%eax, %esi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movabsq	$-0x10, %rax
               	movl	%eax, -0xc0(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	shrq	$0x3c, %rsi
               	leaq	(%rax,%rsi), %rdi
               	movq	%rdi, %r8
               	sarq	$0x4, %r8
               	xorq	%r9, %r9
               	movq	%r8, %r10
               	movq	%r9, %r8
               	subq	%r10, %r8
               	andq	$0xf, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movslq	-0xc0(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movslq	-0xc0(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	cmpl	%eax, %esi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %eax
               	movl	%eax, -0xb8(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	movslq	%eax, %rax
               	movslq	-0xb8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movslq	-0xb8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	cmpl	%edi, %eax
               	jne	<addr>
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	movl	%eax, -0xb0(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movslq	%eax, %rax
               	cmpl	$0x80000000, %eax       # imm = 0x80000000
               	je	<addr>
               	movq	%rdi, %r8
               	subq	%rax, %r8
               	movslq	-0xb0(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movslq	-0xb0(%rbp), %rsi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
               	movl	%eax, -0xa8(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	movslq	%eax, %rax
               	imulq	$0x40000001, %rax, %r8  # imm = 0x40000001
               	movq	%r8, %rdx
               	sarq	$0x3d, %rdx
               	movq	%rdx, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdx,%r9), %rdi
               	imulq	$0x7fffffff, %rdi, %rdx # imm = 0x7FFFFFFF
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movslq	-0xa8(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r8
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movslq	-0xa8(%rbp), %r8
               	pushq	%rdx
               	cqto
               	idivq	%r8
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%eax, %edx
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movabsq	$-0x80000000, %rax      # imm = 0x80000000
               	movl	%eax, -0xa0(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	shrq	$0x21, %rsi
               	leaq	(%rax,%rsi), %rdi
               	movq	%rdi, %r8
               	sarq	$0x1f, %r8
               	xorq	%r9, %r9
               	movq	%r8, %r10
               	movq	%r9, %r8
               	subq	%r10, %r8
               	andq	$0x7fffffff, %rdi       # imm = 0x7FFFFFFF
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movslq	-0xa0(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movslq	-0xa0(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	cmpl	%eax, %esi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0xa, %eax
               	movl	%eax, -0x98(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movl	%eax, %eax
               	movq	%rax, %r8
               	shrq	%r8
               	imulq	$0x66666667, %r8, %r9   # imm = 0x66666667
               	movq	%r9, %rdi
               	shrq	$0x21, %rdi
               	imulq	$0xa, %rdi, %r8
               	movq	%r8, %r10
               	movq	%rax, %r8
               	subq	%r10, %r8
               	movl	-0x98(%rbp), %r9d
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movl	%r9d, %r9d
               	movl	-0x98(%rbp), %esi
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %edi
               	jne	<addr>
               	movl	%r8d, %esi
               	movl	%eax, %eax
               	cmpl	%eax, %esi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x7, %eax
               	movl	%eax, -0x90(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	movl	%eax, %eax
               	imulq	$0x24924925, %rax, %r8  # imm = 0x24924925
               	movq	%r8, %rdx
               	shrq	$0x20, %rdx
               	movq	%rax, %r9
               	subq	%rdx, %r9
               	movq	%r9, %rbx
               	shrq	%rbx
               	leaq	(%rbx,%rdx), %r12
               	shrq	$0x2, %r12
               	movl	%r12d, %r12d
               	addq	%rbx, %rdx
               	shrq	$0x2, %rdx
               	imulq	$0x7, %rdx, %rdx
               	movq	%rax, %r8
               	subq	%rdx, %r8
               	movl	-0x90(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movl	%edx, %r9d
               	movl	-0x90(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %r12d
               	jne	<addr>
               	movl	%r8d, %edx
               	movl	%eax, %eax
               	cmpl	%eax, %edx
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x8, %eax
               	movl	%eax, -0x88(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movl	%eax, %eax
               	movq	%rax, %r8
               	shrq	$0x3, %r8
               	movq	%rax, %rdi
               	andq	$0x7, %rdi
               	movl	-0x88(%rbp), %r9d
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movl	%r9d, %r9d
               	movl	-0x88(%rbp), %esi
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	movl	%eax, %eax
               	cmpl	%eax, %edi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movl	%ecx, -0x80(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movl	%ecx, %ecx
               	movl	-0x80(%rbp), %edi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movl	%edi, %edi
               	movl	-0x80(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpl	%edi, %ecx
               	jne	<addr>
               	movl	%esi, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x80000001, %eax       # imm = 0x80000001
               	movl	%eax, -0x78(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movl	%eax, %eax
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	movq	%rax, %rdi
               	cmpl	%r11d, %eax
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	$0x80000001, %r8d       # imm = 0x80000001
               	imulq	%rdi, %r8
               	movq	%r8, %r10
               	movq	%rax, %r8
               	subq	%r10, %r8
               	movl	-0x78(%rbp), %r9d
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movl	%r9d, %r9d
               	movl	-0x78(%rbp), %esi
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %edi
               	jne	<addr>
               	movl	%r8d, %esi
               	movl	%eax, %eax
               	cmpl	%eax, %esi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0xee6b2800, %eax       # imm = 0xEE6B2800
               	movl	%eax, -0x70(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movl	%eax, %eax
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	movq	%rax, %rdi
               	cmpl	%r11d, %eax
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	$0xee6b2800, %r8d       # imm = 0xEE6B2800
               	imulq	%rdi, %r8
               	movq	%r8, %r10
               	movq	%rax, %r8
               	subq	%r10, %r8
               	movl	-0x70(%rbp), %r9d
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movl	%r9d, %r9d
               	movl	-0x70(%rbp), %esi
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %edi
               	jne	<addr>
               	movl	%r8d, %esi
               	movl	%eax, %eax
               	cmpl	%eax, %esi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	%eax, -0x68(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movl	%eax, %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rax, %rdi
               	cmpl	%r11d, %eax
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	imulq	%rdi, %r8
               	movq	%r8, %r10
               	movq	%rax, %r8
               	subq	%r10, %r8
               	movl	-0x68(%rbp), %r9d
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movl	%r9d, %r9d
               	movl	-0x68(%rbp), %esi
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %edi
               	jne	<addr>
               	movl	%r8d, %esi
               	movl	%eax, %eax
               	cmpl	%eax, %esi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0xa, %eax
               	movq	%rax, -0x60(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rax, %rdx
               	cmpq	%r11, %rax
               	je	<addr>
               	movabsq	$0x6666666666666667, %rdi # imm = 0x6666666666666667
               	pushq	%rax
               	pushq	%rdx
               	imulq	%rdi
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %rdx
               	sarq	$0x2, %rdx
               	movq	%rdx, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdx,%r9), %rbx
               	imulq	$0xa, %rbx, %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movq	-0x60(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	-0x60(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%r8, %rbx
               	jne	<addr>
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movabsq	$-0x3e8, %rax           # imm = 0xFC18
               	movq	%rax, -0x58(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rax, %rdx
               	cmpq	%r11, %rax
               	je	<addr>
               	movabsq	$0x20c49ba5e353f7cf, %rdi # imm = 0x20C49BA5E353F7CF
               	pushq	%rax
               	pushq	%rdx
               	imulq	%rdi
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %rdx
               	sarq	$0x7, %rdx
               	movq	%rdx, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdx,%r9), %rbx
               	xorq	%r12, %r12
               	movq	%r12, %r13
               	subq	%rbx, %r13
               	movq	%r12, %rdx
               	subq	%rbx, %rdx
               	imulq	$-0x3e8, %rdx, %rdx     # imm = 0xFC18
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movq	-0x58(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	-0x58(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%r8, %r13
               	jne	<addr>
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1000, %eax           # imm = 0x1000
               	movq	%rax, -0x50(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rax, %rsi
               	cmpq	%r11, %rax
               	je	<addr>
               	movq	%rax, %rdi
               	sarq	$0x3f, %rdi
               	movq	%rdi, %rsi
               	shrq	$0x34, %rsi
               	leaq	(%rax,%rsi), %r8
               	movq	%r8, %r9
               	sarq	$0xc, %r9
               	movq	%r8, %rdi
               	andq	$0xfff, %rdi            # imm = 0xFFF
               	subq	%rsi, %rdi
               	movq	-0x50(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	-0x50(%rbp), %rsi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%r8, %r9
               	jne	<addr>
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rdi, %rdi
               	movq	%rdi, %rax
               	jmp	<addr>
               	movabsq	$-0x1, %rcx
               	movq	%rcx, -0x48(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%rcx, %rsi
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rdi, %r8
               	subq	%rcx, %r8
               	movq	-0x48(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	-0x48(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%r9, %r8
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, -0x40(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rax, %rsi
               	cmpq	%r11, %rax
               	je	<addr>
               	movq	%rax, %rdi
               	sarq	$0x3f, %rdi
               	movq	%rdi, %rsi
               	shrq	%rsi
               	leaq	(%rax,%rsi), %r8
               	movq	%r8, %r9
               	sarq	$0x3f, %r9
               	xorq	%rbx, %rbx
               	movq	%r9, %r10
               	movq	%rbx, %r9
               	subq	%r10, %r9
               	movabsq	$0x7fffffffffffffff, %rdi # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%r8, %rdi
               	subq	%rsi, %rdi
               	movq	-0x40(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	-0x40(%rbp), %rsi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%r8, %r9
               	jne	<addr>
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0xa, %eax
               	movq	%rax, -0x38(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rax, %rsi
               	cmpq	%r11, %rax
               	je	<addr>
               	movq	%rax, %rsi
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
               	imulq	$0xa, %r9, %rsi
               	movq	%rax, %rdi
               	subq	%rsi, %rdi
               	movq	-0x38(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	-0x38(%rbp), %rsi
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%r8, %r9
               	jne	<addr>
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x7, %eax
               	movq	%rax, -0x30(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rax, %rdx
               	cmpq	%r11, %rax
               	je	<addr>
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
               	imulq	$0x7, %r12, %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movq	-0x30(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	-0x30(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%r8, %r12
               	jne	<addr>
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movabsq	$-0x7fffffffffffffff, %rax # imm = 0x8000000000000001
               	movq	%rax, -0x28(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rax, %rsi
               	cmpq	%r11, %rax
               	je	<addr>
               	movabsq	$-0x7fffffffffffffff, %r11 # imm = 0x8000000000000001
               	movq	%rax, %rdi
               	cmpq	%r11, %rax
               	setae	%dil
               	movzbq	%dil, %rdi
               	movabsq	$-0x7fffffffffffffff, %rsi # imm = 0x8000000000000001
               	imulq	%rdi, %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movq	-0x28(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	-0x28(%rbp), %rsi
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%r9, %rdi
               	jne	<addr>
               	cmpq	%rax, %r8
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x64, %eax
               	movq	%rax, -0x20(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rax, %rdx
               	cmpq	%r11, %rax
               	je	<addr>
               	movabsq	$-0x5c28f5c28f5c28f5, %rdi # imm = 0xA3D70A3D70A3D70B
               	pushq	%rax
               	pushq	%rdx
               	imulq	%rdi
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	leaq	(%r8,%rax), %r9
               	movq	%r9, %rdx
               	sarq	$0x6, %rdx
               	movq	%rdx, %rbx
               	shrq	$0x3f, %rbx
               	leaq	(%rdx,%rbx), %r12
               	imulq	$0x64, %r12, %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movq	-0x20(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	-0x20(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%r8, %r12
               	jne	<addr>
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movabsq	$-0x3, %rax
               	movq	%rax, -0x18(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rax, %rdx
               	cmpq	%r11, %rax
               	je	<addr>
               	movabsq	$0x5555555555555556, %rdi # imm = 0x5555555555555556
               	pushq	%rax
               	imulq	%rdi
               	popq	%rax
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %r9
               	xorq	%rbx, %rbx
               	movq	%rbx, %r12
               	subq	%r9, %r12
               	imulq	$-0x3, %r12, %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movq	-0x18(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	-0x18(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%r8, %r12
               	jne	<addr>
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x64, %eax
               	movq	%rax, -0x10(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rax, %rsi
               	cmpq	%r11, %rax
               	je	<addr>
               	movq	%rax, %rsi
               	shrq	$0x2, %rsi
               	movabsq	$0x28f5c28f5c28f5c3, %rdi # imm = 0x28F5C28F5C28F5C3
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	mulq	%rdi
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %r9
               	shrq	$0x2, %r9
               	imulq	$0x64, %r9, %rsi
               	movq	%rax, %rdi
               	subq	%rsi, %rdi
               	movq	-0x10(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	-0x10(%rbp), %rsi
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%r8, %r9
               	jne	<addr>
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x7, %eax
               	movq	%rax, -0x8(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rax, %rdx
               	cmpq	%r11, %rax
               	je	<addr>
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
               	imulq	$0x7, %r12, %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movq	-0x8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	-0x8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%r8, %r12
               	jne	<addr>
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	xorq	%rax, %rax
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

<converted>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x3, %eax
               	movl	%eax, -0xa8(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	movsbq	%al, %rax
               	imulq	$0x55555556, %rax, %rdi # imm = 0x55555556
               	movq	%rdi, %rdx
               	sarq	$0x20, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %r9
               	movsbq	%r9b, %rbx
               	leaq	(%r9,%r9,2), %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movsbq	%dil, %r8
               	movslq	-0xa8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movsbq	%dl, %r9
               	movslq	-0xa8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	movsbq	%al, %rdx
               	cmpl	%r9d, %ebx
               	jne	<addr>
               	cmpl	%edx, %r8d
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movabsq	$-0x5, %rax
               	movl	%eax, -0xa0(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	movsbq	%al, %rax
               	imulq	$0x66666667, %rax, %rdi # imm = 0x66666667
               	movq	%rdi, %rdx
               	sarq	$0x21, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %r9
               	xorq	%rbx, %rbx
               	movq	%rbx, %r12
               	subq	%r9, %r12
               	movsbq	%r12b, %r12
               	movq	%rbx, %rdx
               	subq	%r9, %rdx
               	imulq	$-0x5, %rdx, %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movsbq	%dil, %r8
               	movslq	-0xa0(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movsbq	%dl, %r9
               	movslq	-0xa0(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	movsbq	%al, %rdx
               	cmpl	%r9d, %r12d
               	jne	<addr>
               	cmpl	%edx, %r8d
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	movl	%eax, -0x98(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movsbq	%al, %rax
               	movq	%rdi, %rsi
               	subq	%rax, %rsi
               	movsbq	%sil, %r8
               	movslq	-0x98(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movsbq	%sil, %r9
               	movslq	-0x98(%rbp), %rsi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	movsbq	%al, %rsi
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x3, %eax
               	movl	%eax, -0x90(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	andq	$0xff, %rax
               	imulq	$0x55555556, %rax, %r8  # imm = 0x55555556
               	movq	%r8, %rdx
               	sarq	$0x20, %rdx
               	movq	%rdx, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdx,%r9), %rbx
               	movq	%rbx, %r12
               	andq	$0xff, %r12
               	leaq	(%rbx,%rbx,2), %rdx
               	movq	%rax, %r8
               	subq	%rdx, %r8
               	movslq	-0x90(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movq	%rdx, %r9
               	andq	$0xff, %r9
               	movslq	-0x90(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %r12d
               	jne	<addr>
               	movq	%r8, %rdx
               	andq	$0xff, %rdx
               	andq	$0xff, %rax
               	cmpl	%eax, %edx
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x10, %eax
               	movl	%eax, -0x88(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	andq	$0xff, %rax
               	leaq	(%rax), %rdi
               	movq	%rdi, %r8
               	sarq	$0x4, %r8
               	andq	$0xf, %rdi
               	subq	$0x0, %rdi
               	movslq	-0x88(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	andq	$0xff, %r9
               	movslq	-0x88(%rbp), %rsi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	andq	$0xff, %rax
               	cmpl	%eax, %edi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movabsq	$-0x7, %rax
               	movl	%eax, -0x80(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	andq	$0xff, %rax
               	movl	$0x92492493, %r8d       # imm = 0x92492493
               	imulq	%rax, %r8
               	movq	%r8, %rdx
               	sarq	$0x22, %rdx
               	movq	%rdx, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdx,%r9), %r12
               	xorq	%rbx, %rbx
               	movq	%r12, %r10
               	movq	%rbx, %r12
               	subq	%r10, %r12
               	andq	$0xff, %r12
               	addq	%r9, %rdx
               	movq	%rdx, %r10
               	movq	%rbx, %rdx
               	subq	%r10, %rdx
               	imulq	$-0x7, %rdx, %rdx
               	movq	%rax, %r8
               	subq	%rdx, %r8
               	movslq	-0x80(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movq	%rdx, %r9
               	andq	$0xff, %r9
               	movslq	-0x80(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %r12d
               	jne	<addr>
               	movq	%r8, %rdx
               	andq	$0xff, %rdx
               	andq	$0xff, %rax
               	cmpl	%eax, %edx
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0xa, %eax
               	movl	%eax, -0x78(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	movswq	%ax, %rax
               	imulq	$0x66666667, %rax, %rdi # imm = 0x66666667
               	movq	%rdi, %rdx
               	sarq	$0x22, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %r9
               	movswq	%r9w, %rbx
               	imulq	$0xa, %r9, %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movswq	%di, %r8
               	movslq	-0x78(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movswq	%dx, %r9
               	movslq	-0x78(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	movswq	%ax, %rdx
               	cmpl	%r9d, %ebx
               	jne	<addr>
               	cmpl	%edx, %r8d
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	movl	%eax, -0x70(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movswq	%ax, %rax
               	movq	%rdi, %rsi
               	subq	%rax, %rsi
               	movswq	%si, %r8
               	movslq	-0x70(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movswq	%si, %r9
               	movslq	-0x70(%rbp), %rsi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	movswq	%ax, %rsi
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x3e8, %eax            # imm = 0x3E8
               	movl	%eax, -0x68(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	imulq	$0x10624dd3, %rax, %r8  # imm = 0x10624DD3
               	movq	%r8, %rdx
               	sarq	$0x26, %rdx
               	movq	%rdx, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdx,%r9), %rbx
               	movq	%rbx, %r12
               	andq	$0xffff, %r12           # imm = 0xFFFF
               	imulq	$0x3e8, %rbx, %rdx      # imm = 0x3E8
               	movq	%rax, %r8
               	subq	%rdx, %r8
               	movslq	-0x68(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movq	%rdx, %r9
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	movslq	-0x68(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %r12d
               	jne	<addr>
               	movq	%r8, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	%eax, %edx
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x7, %eax
               	movl	%eax, -0x60(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	imulq	$0x24924925, %rax, %r8  # imm = 0x24924925
               	movq	%r8, %rdx
               	shrq	$0x20, %rdx
               	movq	%rax, %r9
               	subq	%rdx, %r9
               	movq	%r9, %rbx
               	shrq	%rbx
               	leaq	(%rbx,%rdx), %r12
               	shrq	$0x2, %r12
               	andq	$0xffff, %r12           # imm = 0xFFFF
               	addq	%rbx, %rdx
               	shrq	$0x2, %rdx
               	imulq	$0x7, %rdx, %rdx
               	movq	%rax, %r8
               	subq	%rdx, %r8
               	movl	-0x60(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movq	%rdx, %r9
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	movl	-0x60(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %r12d
               	jne	<addr>
               	movq	%r8, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	%eax, %edx
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x3, %ecx
               	movl	%ecx, -0x58(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rsi
               	movq	(%rcx,%rsi,8), %rcx
               	movl	%ecx, %edx
               	movl	$0xaaaaaaab, %r9d       # imm = 0xAAAAAAAB
               	imulq	%rdx, %r9
               	movq	%r9, %r8
               	shrq	$0x21, %r8
               	leaq	(%r8,%r8,2), %r9
               	movq	%r9, %r10
               	movq	%rdx, %r9
               	subq	%r10, %r9
               	movl	-0x58(%rbp), %ebx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	movl	-0x58(%rbp), %edx
               	movl	%ecx, %ecx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpl	%ebx, %r8d
               	jne	<addr>
               	cmpl	%ecx, %r9d
               	jne	<addr>
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	movl	%eax, -0x50(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	movl	%eax, %edx
               	movq	%rdx, %r9
               	shrq	$0x1f, %r9
               	movq	%rax, %r8
               	andq	$0x7fffffff, %r8        # imm = 0x7FFFFFFF
               	movl	-0x50(%rbp), %ebx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	movl	-0x50(%rbp), %edi
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%ebx, %r9d
               	jne	<addr>
               	cmpl	%eax, %r8d
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x3, %eax
               	movq	%rax, -0x48(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	movslq	%eax, %rax
               	movabsq	$0x5555555555555556, %r8 # imm = 0x5555555555555556
               	pushq	%rax
               	imulq	%r8
               	popq	%rax
               	movq	%rdx, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdx,%r9), %rdi
               	leaq	(%rdi,%rdi,2), %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movq	-0x48(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r8
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	-0x48(%rbp), %r8
               	pushq	%rdx
               	cqto
               	idivq	%r8
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%eax, %edx
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movabsq	$0x100000000, %rax      # imm = 0x100000000
               	movq	%rax, -0x40(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	sarq	$0x3f, %rdi
               	movq	%rdi, %rsi
               	shrq	$0x20, %rsi
               	leaq	(%rax,%rsi), %r8
               	movq	%r8, %r9
               	sarq	$0x20, %r9
               	movl	%r8d, %edi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movq	-0x40(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	-0x40(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r8d, %r9d
               	jne	<addr>
               	cmpl	%eax, %esi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x7, %eax
               	movq	%rax, -0x38(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	movslq	%eax, %rax
               	movabsq	$0x2492492492492493, %r8 # imm = 0x2492492492492493
               	pushq	%rax
               	mulq	%r8
               	popq	%rax
               	movq	%rax, %r9
               	subq	%rdx, %r9
               	movq	%r9, %rbx
               	shrq	%rbx
               	leaq	(%rbx,%rdx), %r12
               	movq	%r12, %rdi
               	shrq	$0x2, %rdi
               	imulq	$0x7, %rdi, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movq	-0x38(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	-0x38(%rbp), %r8
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%eax, %edx
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x7, %eax
               	movq	%rax, -0x30(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	movl	%eax, %eax
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
               	movl	%r12d, %r13d
               	imulq	$0x7, %r12, %rdx
               	movq	%rax, %r8
               	subq	%rdx, %r8
               	movq	-0x30(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movl	%edx, %r9d
               	movq	-0x30(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %r13d
               	jne	<addr>
               	movl	%r8d, %edx
               	movl	%eax, %eax
               	cmpl	%eax, %edx
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movabsq	$-0x7, %rax
               	movq	%rax, -0x28(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	movl	%eax, %eax
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
               	leaq	(%rdx,%rbx), %r13
               	xorq	%r12, %r12
               	movq	%r13, %r10
               	movq	%r12, %r13
               	subq	%r10, %r13
               	movl	%r13d, %r13d
               	addq	%rbx, %rdx
               	movq	%rdx, %r10
               	movq	%r12, %rdx
               	subq	%r10, %rdx
               	imulq	$-0x7, %rdx, %rdx
               	movq	%rax, %r8
               	subq	%rdx, %r8
               	movq	-0x28(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movl	%edx, %r9d
               	movq	-0x28(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %r13d
               	jne	<addr>
               	movl	%r8d, %edx
               	movl	%eax, %eax
               	cmpl	%eax, %edx
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0xa, %eax
               	movq	%rax, -0x20(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movl	%eax, %eax
               	movq	%rax, %rdi
               	shrq	%rdi
               	movabsq	$0x6666666666666667, %r8 # imm = 0x6666666666666667
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	mulq	%r8
               	movq	%rdx, %r9
               	popq	%rdx
               	popq	%rax
               	movq	%r9, %rbx
               	shrq	%rbx
               	movl	%ebx, %r12d
               	imulq	$0xa, %rbx, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movq	-0x20(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movl	%r8d, %r8d
               	movq	-0x20(%rbp), %rsi
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r8d, %r12d
               	jne	<addr>
               	movl	%edi, %esi
               	movl	%eax, %eax
               	cmpl	%eax, %esi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x9, %eax
               	movq	%rax, -0x18(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movswq	%ax, %rax
               	movabsq	$-0x1c71c71c71c71c71, %rsi # imm = 0xE38E38E38E38E38F
               	pushq	%rax
               	pushq	%rdx
               	mulq	%rsi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	%rdi, %r8
               	shrq	$0x3, %r8
               	movswq	%r8w, %r9
               	leaq	(%r8,%r8,8), %rsi
               	movq	%rax, %rdi
               	subq	%rsi, %rdi
               	movswq	%di, %r8
               	movq	-0x18(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movswq	%si, %rbx
               	movq	-0x18(%rbp), %rsi
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	movswq	%ax, %rsi
               	cmpl	%ebx, %r9d
               	jne	<addr>
               	cmpl	%esi, %r8d
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movabsq	$-0xa, %rax
               	movl	%eax, -0x10(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rax, %rdx
               	cmpq	%r11, %rax
               	je	<addr>
               	movabsq	$0x6666666666666667, %rdi # imm = 0x6666666666666667
               	pushq	%rax
               	pushq	%rdx
               	imulq	%rdi
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %rdx
               	sarq	$0x2, %rdx
               	movq	%rdx, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdx,%r9), %rbx
               	xorq	%r12, %r12
               	movq	%r12, %r13
               	subq	%rbx, %r13
               	movq	%r12, %rdx
               	subq	%rbx, %rdx
               	imulq	$-0xa, %rdx, %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movslq	-0x10(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movslq	-0x10(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%r8, %r13
               	jne	<addr>
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0xa, %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rax, %rsi
               	cmpq	%r11, %rax
               	je	<addr>
               	movq	%rax, %rsi
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
               	imulq	$0xa, %r9, %rsi
               	movq	%rax, %rdi
               	subq	%rsi, %rdi
               	movslq	-0x8(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movslq	-0x8(%rbp), %rsi
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%r8, %r9
               	jne	<addr>
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	xorq	%rax, %rax
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

<places>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	<rip>, %rbx
               	movslq	(%rbx), %rax
               	incq	%rax
               	movl	%eax, (%rbx)
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movslq	%eax, %rcx
               	movq	(%rdx,%rcx,8), %rsi
               	movl	%esi, -0x28(%rbp)
               	movq	(%rdx,%rcx,8), %rdx
               	movl	%edx, -0x20(%rbp)
               	movl	$0xa, %edx
               	movl	%edx, -0x18(%rbp)
               	movslq	-0x28(%rbp), %rdx
               	imulq	$0x66666667, %rdx, %rdx # imm = 0x66666667
               	sarq	$0x22, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rdx
               	movl	%edx, -0x28(%rbp)
               	movslq	-0x20(%rbp), %rdx
               	movslq	-0x18(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %rdx
               	popq	%rax
               	movl	%edx, -0x20(%rbp)
               	movslq	-0x28(%rbp), %rdx
               	movslq	-0x20(%rbp), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rsi
               	movl	%esi, -0x28(%rbp)
               	movq	(%rdx,%rcx,8), %rdx
               	movl	%edx, -0x20(%rbp)
               	movslq	-0x28(%rbp), %rdx
               	imulq	$0x66666667, %rdx, %rsi # imm = 0x66666667
               	sarq	$0x22, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	imulq	$0xa, %rsi, %rsi
               	subq	%rsi, %rdx
               	movl	%edx, -0x28(%rbp)
               	movslq	-0x20(%rbp), %rsi
               	movslq	-0x18(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	movl	%edx, -0x20(%rbp)
               	movslq	-0x28(%rbp), %rdx
               	movslq	-0x20(%rbp), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rbx), %rax
               	incq	%rax
               	movl	%eax, (%rbx)
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x88(%rbp), %rsi
               	movslq	%eax, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movl	%edx, (%rsi,%rcx,4)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movabsq	$-0x9, %rax
               	movl	%eax, -0x10(%rbp)
               	leaq	<rip>, %rdx
               	movslq	%ecx, %rax
               	movq	(%rdx,%rax,8), %rdx
               	movslq	%edx, %rdx
               	movslq	-0x10(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	leaq	-0x88(%rbp), %rdx
               	movslq	(%rdx,%rax,4), %rdi
               	imulq	$0x38e38e39, %rdi, %rdi # imm = 0x38E38E39
               	sarq	$0x21, %rdi
               	movq	%rdi, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rdi
               	xorq	%r8, %r8
               	movq	%rdi, %r10
               	movq	%r8, %rdi
               	subq	%r10, %rdi
               	movl	%edi, (%rdx,%rax,4)
               	movslq	(%rdx,%rax,4), %rdi
               	cmpl	%esi, %edi
               	jne	<addr>
               	movslq	(%rdx,%rax,4), %rdx
               	cmpl	%esi, %edx
               	jne	<addr>
               	movslq	%esi, %rsi
               	movslq	-0x10(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	leaq	-0x88(%rbp), %rdx
               	movslq	(%rdx,%rax,4), %rdi
               	imulq	$0x38e38e39, %rdi, %r8  # imm = 0x38E38E39
               	sarq	$0x21, %r8
               	movq	%r8, %r9
               	shrq	$0x3f, %r9
               	addq	%r9, %r8
               	xorq	%r9, %r9
               	movq	%r8, %r10
               	movq	%r9, %r8
               	subq	%r10, %r8
               	imulq	$-0x9, %r8, %r8
               	subq	%r8, %rdi
               	movl	%edi, (%rdx,%rax,4)
               	movslq	(%rdx,%rax,4), %rdx
               	cmpl	%esi, %edx
               	jne	<addr>
               	leaq	0x1(%rax), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rbx), %rax
               	incq	%rax
               	movl	%eax, (%rbx)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x3, %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x90(%rbp), %rdi
               	leaq	-0x30(%rbp), %r8
               	leaq	<rip>, %rdx
               	movslq	%ecx, %rax
               	movq	(%rdx,%rax,8), %rsi
               	andq	$0x7ff, %rsi            # imm = 0x7FF
               	movl	(%r8), %r9d
               	andq	$-0x800, %r9            # imm = 0xF800
               	orq	%rsi, %r9
               	movl	%r9d, (%r8)
               	shlq	$0x35, %rsi
               	sarq	$0x35, %rsi
               	andq	$0x7ff, %rsi            # imm = 0x7FF
               	movl	(%rdi), %r8d
               	andq	$-0x800, %r8            # imm = 0xF800
               	orq	%rsi, %r8
               	movl	%r8d, (%rdi)
               	leaq	-0x90(%rbp), %rdi
               	leaq	-0x30(%rbp), %r12
               	movq	(%rdx,%rax,8), %rsi
               	andq	$0x1fff, %rsi           # imm = 0x1FFF
               	movl	%r9d, %r9d
               	andq	$-0xfff801, %r9         # imm = 0xFF0007FF
               	shlq	$0xb, %rsi
               	orq	%rsi, %r9
               	movl	%r9d, (%r12)
               	movl	%r8d, %r8d
               	andq	$-0xfff801, %r8         # imm = 0xFF0007FF
               	orq	%r8, %rsi
               	movl	%esi, (%rdi)
               	leaq	-0x90(%rbp), %rsi
               	leaq	-0x30(%rbp), %rdi
               	movq	(%rdx,%rax,8), %rdx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdx
               	movq	(%rdi), %r8
               	andq	$0xffffff, %r8          # imm = 0xFFFFFF
               	shlq	$0x18, %rdx
               	orq	%rdx, %r8
               	movq	%r8, (%rdi)
               	sarq	$0x18, %rdx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdx
               	movq	(%rsi), %rdi
               	andq	$0xffffff, %rdi         # imm = 0xFFFFFF
               	shlq	$0x18, %rdx
               	orq	%rdx, %rdi
               	movq	%rdi, (%rsi)
               	leaq	-0x90(%rbp), %r8
               	movl	(%r8), %edx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	shlq	$0x35, %rdx
               	sarq	$0x35, %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	movq	%rdx, %rdi
               	andq	$0x7ff, %rdi            # imm = 0x7FF
               	movl	(%rsi), %edx
               	andq	$-0x800, %rdx           # imm = 0xF800
               	orq	%rdi, %rdx
               	movl	%edx, (%rsi)
               	leaq	-0x30(%rbp), %rsi
               	movl	(%rsi), %edi
               	movq	%rdi, %r9
               	andq	$0x7ff, %r9             # imm = 0x7FF
               	shlq	$0x35, %r9
               	sarq	$0x35, %r9
               	movslq	-0x8(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r12
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	andq	$0x7ff, %r9             # imm = 0x7FF
               	andq	$-0x800, %rdi           # imm = 0xF800
               	orq	%r9, %rdi
               	movl	%edi, (%rsi)
               	movl	%edx, %esi
               	movq	%rsi, %r9
               	sarq	$0xb, %r9
               	andq	$0x1fff, %r9            # imm = 0x1FFF
               	imulq	$0x55555556, %r9, %r9   # imm = 0x55555556
               	sarq	$0x20, %r9
               	movq	%r9, %r12
               	shrq	$0x3f, %r12
               	addq	%r12, %r9
               	andq	$0x1fff, %r9            # imm = 0x1FFF
               	movq	%rsi, %rdx
               	andq	$-0xfff801, %rdx        # imm = 0xFF0007FF
               	movq	%r9, %rsi
               	shlq	$0xb, %rsi
               	orq	%rsi, %rdx
               	movl	%edx, (%r8)
               	leaq	-0x30(%rbp), %rsi
               	movl	%edi, %edx
               	movq	%rdx, %r8
               	sarq	$0xb, %r8
               	andq	$0x1fff, %r8            # imm = 0x1FFF
               	movslq	-0x8(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	andq	$0x1fff, %r8            # imm = 0x1FFF
               	andq	$-0xfff801, %rdx        # imm = 0xFF0007FF
               	movq	%r8, %rdi
               	shlq	$0xb, %rdi
               	orq	%rdi, %rdx
               	movl	%edx, (%rsi)
               	leaq	-0x90(%rbp), %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, %rdi
               	sarq	$0x18, %rdi
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdi
               	shlq	$0x18, %rdi
               	sarq	$0x18, %rdi
               	movabsq	$0x5555555555555556, %r8 # imm = 0x5555555555555556
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	imulq	%r8
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	%rdi, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rdi
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdi
               	movq	%rsi, %r8
               	andq	$0xffffff, %r8          # imm = 0xFFFFFF
               	movq	%rdi, %rsi
               	shlq	$0x18, %rsi
               	movq	%r8, %rdi
               	orq	%rsi, %rdi
               	movq	%rdi, (%rdx)
               	leaq	-0x30(%rbp), %rsi
               	movq	(%rsi), %r8
               	movq	%r8, %r9
               	sarq	$0x18, %r9
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %r9
               	shlq	$0x18, %r9
               	sarq	$0x18, %r9
               	movslq	-0x8(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r12
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %r9
               	movq	%r8, %r12
               	andq	$0xffffff, %r12         # imm = 0xFFFFFF
               	movq	%r9, %r8
               	shlq	$0x18, %r8
               	movq	%r12, %r9
               	orq	%r8, %r9
               	movq	%r9, (%rsi)
               	movl	(%rdx), %edx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	shlq	$0x35, %rdx
               	movq	%rdx, %rsi
               	sarq	$0x35, %rsi
               	leaq	-0x30(%rbp), %rdx
               	movl	(%rdx), %r8d
               	andq	$0x7ff, %r8             # imm = 0x7FF
               	shlq	$0x35, %r8
               	sarq	$0x35, %r8
               	cmpq	%r8, %rsi
               	jne	<addr>
               	leaq	-0x90(%rbp), %rsi
               	movl	(%rsi), %esi
               	sarq	$0xb, %rsi
               	andq	$0x1fff, %rsi           # imm = 0x1FFF
               	movl	(%rdx), %edx
               	sarq	$0xb, %rdx
               	andq	$0x1fff, %rdx           # imm = 0x1FFF
               	cmpl	%edx, %esi
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rdi, %rdx
               	sarq	$0x18, %rdx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdx
               	shlq	$0x18, %rdx
               	sarq	$0x18, %rdx
               	movq	%r9, %rsi
               	sarq	$0x18, %rsi
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rsi
               	shlq	$0x18, %rsi
               	sarq	$0x18, %rsi
               	cmpq	%rsi, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x90(%rbp), %rdi
               	leaq	-0x30(%rbp), %r8
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rax,8), %rsi
               	andq	$0x7ff, %rsi            # imm = 0x7FF
               	movl	(%r8), %r9d
               	andq	$-0x800, %r9            # imm = 0xF800
               	orq	%rsi, %r9
               	movl	%r9d, (%r8)
               	shlq	$0x35, %rsi
               	sarq	$0x35, %rsi
               	andq	$0x7ff, %rsi            # imm = 0x7FF
               	movl	(%rdi), %r8d
               	andq	$-0x800, %r8            # imm = 0xF800
               	orq	%rsi, %r8
               	movl	%r8d, (%rdi)
               	leaq	-0x90(%rbp), %rdi
               	leaq	-0x30(%rbp), %r12
               	movq	(%rdx,%rax,8), %rsi
               	andq	$0x1fff, %rsi           # imm = 0x1FFF
               	movl	%r9d, %r9d
               	andq	$-0xfff801, %r9         # imm = 0xFF0007FF
               	shlq	$0xb, %rsi
               	orq	%rsi, %r9
               	movl	%r9d, (%r12)
               	movl	%r8d, %r8d
               	andq	$-0xfff801, %r8         # imm = 0xFF0007FF
               	orq	%r8, %rsi
               	movl	%esi, (%rdi)
               	leaq	-0x90(%rbp), %rsi
               	leaq	-0x30(%rbp), %rdi
               	movq	(%rdx,%rax,8), %rdx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdx
               	movq	(%rdi), %r8
               	andq	$0xffffff, %r8          # imm = 0xFFFFFF
               	shlq	$0x18, %rdx
               	orq	%rdx, %r8
               	movq	%r8, (%rdi)
               	sarq	$0x18, %rdx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdx
               	movq	(%rsi), %rdi
               	andq	$0xffffff, %rdi         # imm = 0xFFFFFF
               	shlq	$0x18, %rdx
               	orq	%rdx, %rdi
               	movq	%rdi, (%rsi)
               	leaq	-0x90(%rbp), %rdx
               	movl	(%rdx), %edx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	shlq	$0x35, %rdx
               	sarq	$0x35, %rdx
               	imulq	$0x55555556, %rdx, %rdi # imm = 0x55555556
               	sarq	$0x20, %rdi
               	movq	%rdi, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rdi
               	leaq	(%rdi,%rdi,2), %rdi
               	subq	%rdi, %rdx
               	movq	%rdx, %rdi
               	andq	$0x7ff, %rdi            # imm = 0x7FF
               	movl	(%rsi), %edx
               	andq	$-0x800, %rdx           # imm = 0xF800
               	orq	%rdi, %rdx
               	movl	%edx, (%rsi)
               	leaq	-0x30(%rbp), %rsi
               	movl	(%rsi), %r8d
               	movq	%r8, %rdi
               	andq	$0x7ff, %rdi            # imm = 0x7FF
               	shlq	$0x35, %rdi
               	movq	%rdi, %r9
               	sarq	$0x35, %r9
               	movslq	-0x8(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	%rdi, %r9
               	andq	$0x7ff, %r9             # imm = 0x7FF
               	movq	%r8, %rdi
               	andq	$-0x800, %rdi           # imm = 0xF800
               	orq	%r9, %rdi
               	movl	%edi, (%rsi)
               	leaq	-0x90(%rbp), %r12
               	movl	%edx, %esi
               	movq	%rsi, %r8
               	sarq	$0xb, %r8
               	andq	$0x1fff, %r8            # imm = 0x1FFF
               	imulq	$0x55555556, %r8, %r9   # imm = 0x55555556
               	sarq	$0x20, %r9
               	movq	%r9, %r13
               	shrq	$0x3f, %r13
               	addq	%r13, %r9
               	leaq	(%r9,%r9,2), %r9
               	subq	%r9, %r8
               	andq	$0x1fff, %r8            # imm = 0x1FFF
               	movq	%rsi, %rdx
               	andq	$-0xfff801, %rdx        # imm = 0xFF0007FF
               	movq	%r8, %rsi
               	shlq	$0xb, %rsi
               	orq	%rsi, %rdx
               	movl	%edx, (%r12)
               	leaq	-0x30(%rbp), %r9
               	movl	%edi, %esi
               	movq	%rsi, %rdx
               	sarq	$0xb, %rdx
               	movq	%rdx, %r8
               	andq	$0x1fff, %r8            # imm = 0x1FFF
               	movslq	-0x8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%r8, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	andq	$0x1fff, %rdx           # imm = 0x1FFF
               	andq	$-0xfff801, %rsi        # imm = 0xFF0007FF
               	shlq	$0xb, %rdx
               	orq	%rsi, %rdx
               	movl	%edx, (%r9)
               	leaq	-0x90(%rbp), %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, %rdi
               	sarq	$0x18, %rdi
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdi
               	shlq	$0x18, %rdi
               	sarq	$0x18, %rdi
               	movabsq	$0x5555555555555556, %r8 # imm = 0x5555555555555556
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	imulq	%r8
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %r9
               	shrq	$0x3f, %r9
               	addq	%r9, %r8
               	leaq	(%r8,%r8,2), %r8
               	subq	%r8, %rdi
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdi
               	movq	%rsi, %r8
               	andq	$0xffffff, %r8          # imm = 0xFFFFFF
               	movq	%rdi, %rsi
               	shlq	$0x18, %rsi
               	movq	%r8, %rdi
               	orq	%rsi, %rdi
               	movq	%rdi, (%rdx)
               	leaq	-0x30(%rbp), %rdx
               	movq	(%rdx), %r8
               	movq	%r8, %rsi
               	sarq	$0x18, %rsi
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rsi
               	shlq	$0x18, %rsi
               	movq	%rsi, %r9
               	sarq	$0x18, %r9
               	movslq	-0x8(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rsi
               	andq	$0xffffff, %r8          # imm = 0xFFFFFF
               	shlq	$0x18, %rsi
               	orq	%rsi, %r8
               	movq	%r8, (%rdx)
               	leaq	-0x90(%rbp), %rdx
               	movl	(%rdx), %esi
               	andq	$0x7ff, %rsi            # imm = 0x7FF
               	shlq	$0x35, %rsi
               	sarq	$0x35, %rsi
               	leaq	-0x30(%rbp), %r9
               	movl	(%r9), %r9d
               	andq	$0x7ff, %r9             # imm = 0x7FF
               	shlq	$0x35, %r9
               	sarq	$0x35, %r9
               	cmpq	%r9, %rsi
               	jne	<addr>
               	movl	(%rdx), %edx
               	sarq	$0xb, %rdx
               	andq	$0x1fff, %rdx           # imm = 0x1FFF
               	leaq	-0x30(%rbp), %rsi
               	movl	(%rsi), %esi
               	sarq	$0xb, %rsi
               	andq	$0x1fff, %rsi           # imm = 0x1FFF
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rdi, %rdx
               	sarq	$0x18, %rdx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdx
               	shlq	$0x18, %rdx
               	sarq	$0x18, %rdx
               	movq	%r8, %rsi
               	sarq	$0x18, %rsi
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rsi
               	shlq	$0x18, %rsi
               	sarq	$0x18, %rsi
               	cmpq	%rsi, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x1(%rax), %rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movslq	(%rbx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movslq	(%rbx), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movslq	(%rbx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movslq	(%rbx), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movslq	(%rbx), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movslq	(%rbx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movslq	(%rbx), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
