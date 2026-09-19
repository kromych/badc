
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
               	subq	$0xf0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0xa, %eax
               	movl	%eax, -0xe0(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movslq	%eax, %rax
               	imulq	$0x66666667, %rax, %rdi # imm = 0x66666667
               	movq	%rdi, %rdx
               	sarq	$0x22, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %rsi
               	imulq	$0xa, %rsi, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movslq	-0xe0(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movslq	-0xe0(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r8d, %esi
               	jne	<addr>
               	cmpl	%eax, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x7, %eax
               	movl	%eax, -0xd8(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movslq	%eax, %rax
               	movl	$0x92492493, %edi       # imm = 0x92492493
               	imulq	%rax, %rdi
               	movq	%rdi, %rdx
               	sarq	$0x22, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %rsi
               	imulq	$0x7, %rsi, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movslq	-0xd8(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movslq	-0xd8(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r8d, %esi
               	jne	<addr>
               	cmpl	%eax, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movabsq	$-0x7, %rax
               	movl	%eax, -0xd0(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movslq	%eax, %rax
               	movl	$0x92492493, %edi       # imm = 0x92492493
               	imulq	%rax, %rdi
               	movq	%rdi, %rdx
               	sarq	$0x22, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %r9
               	movq	%rsi, %rbx
               	subq	%r9, %rbx
               	movq	%rsi, %rdx
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
               	cmpl	%r8d, %ebx
               	jne	<addr>
               	cmpl	%eax, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x10, %eax
               	movl	%eax, -0xc8(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rdx
               	shrq	$0x3c, %rdx
               	leaq	(%rax,%rdx), %rsi
               	movq	%rsi, %rdi
               	sarq	$0x4, %rdi
               	andq	$0xf, %rsi
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movslq	-0xc8(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movslq	-0xc8(%rbp), %rsi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r8d, %edi
               	jne	<addr>
               	cmpl	%eax, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movabsq	$-0x10, %rax
               	movl	%eax, -0xc0(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rdx
               	shrq	$0x3c, %rdx
               	leaq	(%rax,%rdx), %rsi
               	movq	%rsi, %r8
               	sarq	$0x4, %r8
               	movq	%r8, %r10
               	movq	%rdi, %r8
               	subq	%r10, %r8
               	andq	$0xf, %rsi
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movslq	-0xc0(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movslq	-0xc0(%rbp), %rsi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	cmpl	%eax, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x1, %eax
               	movl	%eax, -0xb8(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movslq	%eax, %rax
               	movslq	-0xb8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movslq	-0xb8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	cmpl	%esi, %eax
               	jne	<addr>
               	testq	%rdx, %rdx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movabsq	$-0x1, %rax
               	movl	%eax, -0xb0(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movslq	%eax, %rax
               	cmpl	$0x80000000, %eax       # imm = 0x80000000
               	je	<addr>
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movslq	-0xb0(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movslq	-0xb0(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r8d, %edi
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
               	movl	%eax, -0xa8(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movslq	%eax, %rax
               	imulq	$0x40000001, %rax, %rdi # imm = 0x40000001
               	movq	%rdi, %rdx
               	sarq	$0x3d, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %rsi
               	imulq	$0x7fffffff, %rsi, %rdx # imm = 0x7FFFFFFF
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movslq	-0xa8(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movslq	-0xa8(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r8d, %esi
               	jne	<addr>
               	cmpl	%eax, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movabsq	$-0x80000000, %rax      # imm = 0x80000000
               	movl	%eax, -0xa0(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rdx
               	shrq	$0x21, %rdx
               	leaq	(%rax,%rdx), %rsi
               	movq	%rsi, %r8
               	sarq	$0x1f, %r8
               	movq	%r8, %r10
               	movq	%rdi, %r8
               	subq	%r10, %r8
               	andq	$0x7fffffff, %rsi       # imm = 0x7FFFFFFF
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movslq	-0xa0(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movslq	-0xa0(%rbp), %rsi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	cmpl	%eax, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0xa, %eax
               	movl	%eax, -0x98(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movl	%eax, %eax
               	movq	%rax, %rdi
               	shrq	%rdi
               	imulq	$0x66666667, %rdi, %r8  # imm = 0x66666667
               	movq	%r8, %rsi
               	shrq	$0x21, %rsi
               	imulq	$0xa, %rsi, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movl	-0x98(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movl	%r8d, %r8d
               	movl	-0x98(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r8d, %esi
               	jne	<addr>
               	movl	%edi, %edx
               	movl	%eax, %eax
               	cmpl	%eax, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x7, %eax
               	movl	%eax, -0x90(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movl	%eax, %eax
               	imulq	$0x24924925, %rax, %rdi # imm = 0x24924925
               	movq	%rdi, %rdx
               	shrq	$0x20, %rdx
               	movq	%rax, %r8
               	subq	%rdx, %r8
               	movq	%r8, %r9
               	shrq	%r9
               	leaq	(%r9,%rdx), %rbx
               	movq	%rbx, %r12
               	shrq	$0x2, %r12
               	movl	%r12d, %r12d
               	movq	%rbx, %rdx
               	shrq	$0x2, %rdx
               	imulq	$0x7, %rdx, %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movl	-0x90(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movl	%edx, %r8d
               	movl	-0x90(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r8d, %r12d
               	jne	<addr>
               	movl	%edi, %edx
               	movl	%eax, %eax
               	cmpl	%eax, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0x8, %ecx
               	movl	%ecx, -0x88(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movl	%ecx, %ecx
               	movq	%rcx, %rdi
               	shrq	$0x3, %rdi
               	movq	%rcx, %rsi
               	andq	$0x7, %rsi
               	movl	-0x88(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movl	%r8d, %r8d
               	movl	-0x88(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpl	%r8d, %edi
               	jne	<addr>
               	movl	%ecx, %ecx
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0x1, %ecx
               	movl	%ecx, -0x80(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movl	%ecx, %ecx
               	movl	-0x80(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movl	%esi, %esi
               	movl	-0x80(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	cmpl	%esi, %ecx
               	jne	<addr>
               	movl	%edx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x80000001, %eax       # imm = 0x80000001
               	movl	%eax, -0x78(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movl	%eax, %eax
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	movq	%rax, %rsi
               	cmpl	%r11d, %eax
               	setae	%sil
               	movzbq	%sil, %rsi
               	movl	$0x80000001, %edi       # imm = 0x80000001
               	imulq	%rsi, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movl	-0x78(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movl	%r8d, %r8d
               	movl	-0x78(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r8d, %esi
               	jne	<addr>
               	movl	%edi, %edx
               	movl	%eax, %eax
               	cmpl	%eax, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0xee6b2800, %eax       # imm = 0xEE6B2800
               	movl	%eax, -0x70(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movl	%eax, %eax
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	movq	%rax, %rsi
               	cmpl	%r11d, %eax
               	setae	%sil
               	movzbq	%sil, %rsi
               	movl	$0xee6b2800, %edi       # imm = 0xEE6B2800
               	imulq	%rsi, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movl	-0x70(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movl	%r8d, %r8d
               	movl	-0x70(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r8d, %esi
               	jne	<addr>
               	movl	%edi, %edx
               	movl	%eax, %eax
               	cmpl	%eax, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	%eax, -0x68(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movl	%eax, %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rax, %rsi
               	cmpl	%r11d, %eax
               	setae	%sil
               	movzbq	%sil, %rsi
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	imulq	%rsi, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movl	-0x68(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movl	%r8d, %r8d
               	movl	-0x68(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r8d, %esi
               	jne	<addr>
               	movl	%edi, %edx
               	movl	%eax, %eax
               	cmpl	%eax, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0xa, %ecx
               	movq	%rcx, -0x60(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	je	<addr>
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
               	imulq	$0xa, %r9, %rdx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movq	-0x60(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
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
               	cmpq	%rdi, %r9
               	jne	<addr>
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movabsq	$-0x3e8, %rax           # imm = 0xFC18
               	movq	%rax, -0x58(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
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
               	movq	%rsi, %r12
               	subq	%rbx, %r12
               	movq	%rsi, %rdx
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
               	cmpq	%r8, %r12
               	jne	<addr>
               	cmpq	%rax, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x1000, %eax           # imm = 0x1000
               	movq	%rax, -0x50(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rax, %rdx
               	cmpq	%r11, %rax
               	je	<addr>
               	movq	%rax, %rsi
               	sarq	$0x3f, %rsi
               	movq	%rsi, %rdx
               	shrq	$0x34, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movq	%rdi, %r8
               	sarq	$0xc, %r8
               	movq	%rdi, %rsi
               	andq	$0xfff, %rsi            # imm = 0xFFF
               	subq	%rdx, %rsi
               	movq	-0x50(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	-0x50(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rdi, %r8
               	jne	<addr>
               	cmpq	%rax, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movabsq	$-0x1, %rcx
               	movq	%rcx, -0x48(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rsi, %rdi
               	subq	%rcx, %rdi
               	movq	-0x48(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	-0x48(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%r8, %rdi
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, -0x40(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rax, %rdx
               	cmpq	%r11, %rax
               	je	<addr>
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
               	movabsq	$0x7fffffffffffffff, %rdi # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%r8, %rdi
               	subq	%rdx, %rdi
               	movq	-0x40(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	-0x40(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%r8, %r9
               	jne	<addr>
               	cmpq	%rax, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0xa, %ecx
               	movq	%rcx, -0x38(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	je	<addr>
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
               	imulq	$0xa, %r8, %rdx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movq	-0x38(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
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
               	cmpq	%rdi, %r8
               	jne	<addr>
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x7, %eax
               	movq	%rax, -0x30(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rax, %rdx
               	cmpq	%r11, %rax
               	je	<addr>
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
               	imulq	$0x7, %rbx, %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movq	-0x30(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	-0x30(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rdi, %rbx
               	jne	<addr>
               	cmpq	%rax, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movabsq	$-0x7fffffffffffffff, %rcx # imm = 0x8000000000000001
               	movq	%rcx, -0x28(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$-0x7fffffffffffffff, %r11 # imm = 0x8000000000000001
               	movq	%rcx, %rsi
               	cmpq	%r11, %rcx
               	setae	%sil
               	movzbq	%sil, %rsi
               	movabsq	$-0x7fffffffffffffff, %rdx # imm = 0x8000000000000001
               	imulq	%rsi, %rdx
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
               	movq	-0x28(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
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
               	cmpq	%r8, %rsi
               	jne	<addr>
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x64, %eax
               	movq	%rax, -0x20(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rax, %rdx
               	cmpq	%r11, %rax
               	je	<addr>
               	movabsq	$-0x5c28f5c28f5c28f5, %rsi # imm = 0xA3D70A3D70A3D70B
               	pushq	%rax
               	pushq	%rdx
               	imulq	%rsi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	leaq	(%rdi,%rax), %r8
               	movq	%r8, %rdx
               	sarq	$0x6, %rdx
               	movq	%rdx, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdx,%r9), %rbx
               	imulq	$0x64, %rbx, %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movq	-0x20(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	-0x20(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rdi, %rbx
               	jne	<addr>
               	cmpq	%rax, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movabsq	$-0x3, %rax
               	movq	%rax, -0x18(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
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
               	movq	%rsi, %rbx
               	subq	%r9, %rbx
               	imulq	$-0x3, %rbx, %rdx
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
               	cmpq	%r8, %rbx
               	jne	<addr>
               	cmpq	%rax, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0x64, %ecx
               	movq	%rcx, -0x10(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rcx, %rdx
               	shrq	$0x2, %rdx
               	movabsq	$0x28f5c28f5c28f5c3, %rsi # imm = 0x28F5C28F5C28F5C3
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	mulq	%rsi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	%rdi, %r8
               	shrq	$0x2, %r8
               	imulq	$0x64, %r8, %rdx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movq	-0x10(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	-0x10(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %r8
               	jne	<addr>
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x7, %eax
               	movq	%rax, -0x8(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rax, %rdx
               	cmpq	%r11, %rax
               	je	<addr>
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
               	imulq	$0x7, %rbx, %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movq	-0x8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	-0x8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rdi, %rbx
               	jne	<addr>
               	cmpq	%rax, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq

<converted>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x3, %eax
               	movl	%eax, -0xa8(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movsbq	%al, %rax
               	imulq	$0x55555556, %rax, %rsi # imm = 0x55555556
               	movq	%rsi, %rdx
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	leaq	(%rdx,%rdi), %r8
               	movsbq	%r8b, %r9
               	leaq	(%r8,%r8,2), %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movsbq	%sil, %rdi
               	movslq	-0xa8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movsbq	%dl, %r8
               	movslq	-0xa8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	movsbq	%al, %rdx
               	cmpl	%r8d, %r9d
               	jne	<addr>
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movabsq	$-0x5, %rax
               	movl	%eax, -0xa0(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movsbq	%al, %rax
               	imulq	$0x66666667, %rax, %rsi # imm = 0x66666667
               	movq	%rsi, %rdx
               	sarq	$0x21, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	leaq	(%rdx,%rdi), %r8
               	xorq	%r9, %r9
               	movq	%r9, %rbx
               	subq	%r8, %rbx
               	movsbq	%bl, %r12
               	imulq	$-0x5, %rbx, %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movsbq	%sil, %rdi
               	movslq	-0xa0(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movsbq	%dl, %r8
               	movslq	-0xa0(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	movsbq	%al, %rdx
               	cmpl	%r8d, %r12d
               	jne	<addr>
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movabsq	$-0x1, %rax
               	movl	%eax, -0x98(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movsbq	%al, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movsbq	%dl, %rdi
               	movslq	-0x98(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movsbq	%dl, %r8
               	movslq	-0x98(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	movsbq	%al, %rdx
               	cmpl	%r8d, %edi
               	jne	<addr>
               	testq	%rdx, %rdx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x3, %eax
               	movl	%eax, -0x90(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	andq	$0xff, %rax
               	imulq	$0x55555556, %rax, %rdi # imm = 0x55555556
               	movq	%rdi, %rdx
               	sarq	$0x20, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %r9
               	movq	%r9, %rbx
               	andq	$0xff, %rbx
               	leaq	(%r9,%r9,2), %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movslq	-0x90(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movq	%rdx, %r8
               	andq	$0xff, %r8
               	movslq	-0x90(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r8d, %ebx
               	jne	<addr>
               	movq	%rdi, %rdx
               	andq	$0xff, %rdx
               	andq	$0xff, %rax
               	cmpl	%eax, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0x10, %ecx
               	movl	%ecx, -0x88(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	andq	$0xff, %rcx
               	leaq	(%rcx), %rsi
               	movq	%rsi, %rdi
               	sarq	$0x4, %rdi
               	andq	$0xf, %rsi
               	subq	$0x0, %rsi
               	movslq	-0x88(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	andq	$0xff, %r8
               	movslq	-0x88(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpl	%r8d, %edi
               	jne	<addr>
               	andq	$0xff, %rcx
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movabsq	$-0x7, %rax
               	movl	%eax, -0x80(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	andq	$0xff, %rax
               	movl	$0x92492493, %r8d       # imm = 0x92492493
               	imulq	%rax, %r8
               	movq	%r8, %rdx
               	sarq	$0x22, %rdx
               	movq	%rdx, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdx,%r9), %rbx
               	movq	%rbx, %r10
               	movq	%rsi, %rbx
               	subq	%r10, %rbx
               	andq	$0xff, %rbx
               	addq	%r9, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
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
               	cmpl	%r9d, %ebx
               	jne	<addr>
               	movq	%r8, %rdx
               	andq	$0xff, %rdx
               	andq	$0xff, %rax
               	cmpl	%eax, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0xa, %eax
               	movl	%eax, -0x78(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movswq	%ax, %rax
               	imulq	$0x66666667, %rax, %rsi # imm = 0x66666667
               	movq	%rsi, %rdx
               	sarq	$0x22, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	leaq	(%rdx,%rdi), %r8
               	movswq	%r8w, %r9
               	imulq	$0xa, %r8, %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movswq	%si, %rdi
               	movslq	-0x78(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movswq	%dx, %r8
               	movslq	-0x78(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	movswq	%ax, %rdx
               	cmpl	%r8d, %r9d
               	jne	<addr>
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movabsq	$-0x1, %rax
               	movl	%eax, -0x70(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movswq	%ax, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movswq	%dx, %rdi
               	movslq	-0x70(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movswq	%dx, %r8
               	movslq	-0x70(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	movswq	%ax, %rdx
               	cmpl	%r8d, %edi
               	jne	<addr>
               	testq	%rdx, %rdx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x3e8, %eax            # imm = 0x3E8
               	movl	%eax, -0x68(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	imulq	$0x10624dd3, %rax, %rdi # imm = 0x10624DD3
               	movq	%rdi, %rdx
               	sarq	$0x26, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %r9
               	movq	%r9, %rbx
               	andq	$0xffff, %rbx           # imm = 0xFFFF
               	imulq	$0x3e8, %r9, %rdx       # imm = 0x3E8
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movslq	-0x68(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movq	%rdx, %r8
               	andq	$0xffff, %r8            # imm = 0xFFFF
               	movslq	-0x68(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r8d, %ebx
               	jne	<addr>
               	movq	%rdi, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	%eax, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x7, %eax
               	movl	%eax, -0x60(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	imulq	$0x24924925, %rax, %rdi # imm = 0x24924925
               	movq	%rdi, %rdx
               	shrq	$0x20, %rdx
               	movq	%rax, %r8
               	subq	%rdx, %r8
               	movq	%r8, %r9
               	shrq	%r9
               	leaq	(%r9,%rdx), %rbx
               	movq	%rbx, %r12
               	shrq	$0x2, %r12
               	andq	$0xffff, %r12           # imm = 0xFFFF
               	movq	%rbx, %rdx
               	shrq	$0x2, %rdx
               	imulq	$0x7, %rdx, %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movl	-0x60(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movq	%rdx, %r8
               	andq	$0xffff, %r8            # imm = 0xFFFF
               	movl	-0x60(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r8d, %r12d
               	jne	<addr>
               	movq	%rdi, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	%eax, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0x3, %ecx
               	movl	%ecx, -0x58(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movl	%ecx, %edx
               	movl	$0xaaaaaaab, %r8d       # imm = 0xAAAAAAAB
               	imulq	%rdx, %r8
               	movq	%r8, %rdi
               	shrq	$0x21, %rdi
               	leaq	(%rdi,%rdi,2), %r8
               	movq	%r8, %r10
               	movq	%rdx, %r8
               	subq	%r10, %r8
               	movl	-0x58(%rbp), %r9d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movl	-0x58(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0x80000000, %ecx       # imm = 0x80000000
               	movl	%ecx, -0x50(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movl	%ecx, %edx
               	movq	%rdx, %r8
               	shrq	$0x1f, %r8
               	movq	%rcx, %rdi
               	andq	$0x7fffffff, %rdi       # imm = 0x7FFFFFFF
               	movl	-0x50(%rbp), %r9d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movl	-0x50(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	cmpl	%ecx, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x3, %eax
               	movq	%rax, -0x48(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movslq	%eax, %rax
               	movabsq	$0x5555555555555556, %rdi # imm = 0x5555555555555556
               	pushq	%rax
               	imulq	%rdi
               	popq	%rax
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdx,%r8), %rsi
               	leaq	(%rsi,%rsi,2), %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movq	-0x48(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	-0x48(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r8d, %esi
               	jne	<addr>
               	cmpl	%eax, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movabsq	$0x100000000, %rax      # imm = 0x100000000
               	movq	%rax, -0x40(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	sarq	$0x3f, %rsi
               	movq	%rsi, %rdx
               	shrq	$0x20, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movq	%rdi, %r8
               	sarq	$0x20, %r8
               	movl	%edi, %esi
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movq	-0x40(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	-0x40(%rbp), %rsi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%edi, %r8d
               	jne	<addr>
               	cmpl	%eax, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x7, %eax
               	movq	%rax, -0x38(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movslq	%eax, %rax
               	movabsq	$0x2492492492492493, %rdi # imm = 0x2492492492492493
               	pushq	%rax
               	mulq	%rdi
               	popq	%rax
               	movq	%rax, %r8
               	subq	%rdx, %r8
               	movq	%r8, %r9
               	shrq	%r9
               	leaq	(%r9,%rdx), %rbx
               	movq	%rbx, %rsi
               	shrq	$0x2, %rsi
               	imulq	$0x7, %rsi, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movq	-0x38(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	-0x38(%rbp), %rdi
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r8d, %esi
               	jne	<addr>
               	cmpl	%eax, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x7, %eax
               	movq	%rax, -0x30(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movl	%eax, %eax
               	movabsq	$0x4924924924924925, %rdi # imm = 0x4924924924924925
               	pushq	%rax
               	pushq	%rdx
               	imulq	%rdi
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %rdx
               	sarq	%rdx
               	movq	%rdx, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdx,%r9), %rbx
               	movl	%ebx, %r12d
               	imulq	$0x7, %rbx, %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movq	-0x30(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movl	%edx, %r8d
               	movq	-0x30(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r8d, %r12d
               	jne	<addr>
               	movl	%edi, %edx
               	movl	%eax, %eax
               	cmpl	%eax, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movabsq	$-0x7, %rax
               	movq	%rax, -0x28(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
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
               	movq	%r12, %r10
               	movq	%rsi, %r12
               	subq	%r10, %r12
               	movl	%r12d, %r12d
               	addq	%rbx, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
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
               	cmpl	%r9d, %r12d
               	jne	<addr>
               	movl	%r8d, %edx
               	movl	%eax, %eax
               	cmpl	%eax, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0xa, %eax
               	movq	%rax, -0x20(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movl	%eax, %eax
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
               	movl	%r9d, %ebx
               	imulq	$0xa, %r9, %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movq	-0x20(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movl	%edi, %edi
               	movq	-0x20(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%edi, %ebx
               	jne	<addr>
               	movl	%esi, %edx
               	movl	%eax, %eax
               	cmpl	%eax, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x9, %eax
               	movq	%rax, -0x18(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
               	movswq	%ax, %rax
               	movabsq	$-0x1c71c71c71c71c71, %rdx # imm = 0xE38E38E38E38E38F
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	mulq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rsi, %rdi
               	shrq	$0x3, %rdi
               	movswq	%di, %r8
               	leaq	(%rdi,%rdi,8), %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movswq	%si, %rdi
               	movq	-0x18(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movswq	%dx, %r9
               	movq	-0x18(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	movswq	%ax, %rdx
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movabsq	$-0xa, %rax
               	movl	%eax, -0x10(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	(%rax,%rdx,8), %rax
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
               	movq	%rsi, %r12
               	subq	%rbx, %r12
               	movq	%rsi, %rdx
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
               	cmpq	%r8, %r12
               	jne	<addr>
               	cmpq	%rax, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0xa, %ecx
               	movl	%ecx, -0x8(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	je	<addr>
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
               	imulq	$0xa, %r8, %rdx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movslq	-0x8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movslq	-0x8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %r8
               	jne	<addr>
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq

<places>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	<rip>, %rbx
               	movslq	(%rbx), %rax
               	incq	%rax
               	movl	%eax, (%rbx)
               	xorq	%rax, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
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
               	movq	(%rdx,%rcx,8), %rcx
               	movl	%ecx, -0x20(%rbp)
               	movslq	-0x28(%rbp), %rcx
               	imulq	$0x66666667, %rcx, %rdx # imm = 0x66666667
               	sarq	$0x22, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rdx
               	imulq	$0xa, %rdx, %rdx
               	subq	%rdx, %rcx
               	movl	%ecx, -0x28(%rbp)
               	movslq	-0x20(%rbp), %rdx
               	movslq	-0x18(%rbp), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, -0x20(%rbp)
               	movslq	-0x28(%rbp), %rcx
               	movslq	-0x20(%rbp), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rbx), %rax
               	incq	%rax
               	movl	%eax, (%rbx)
               	xorq	%rax, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	movslq	%eax, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movl	%edx, (%rsi,%rcx,4)
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movabsq	$-0x9, %rcx
               	movl	%ecx, -0x10(%rbp)
               	leaq	<rip>, %rdx
               	movslq	%eax, %rcx
               	movq	(%rdx,%rcx,8), %rdx
               	movslq	%edx, %rdx
               	movslq	-0x10(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %rdx
               	popq	%rax
               	leaq	-0x88(%rbp), %rsi
               	movslq	(%rsi,%rcx,4), %rdi
               	imulq	$0x38e38e39, %rdi, %rdi # imm = 0x38E38E39
               	sarq	$0x21, %rdi
               	movq	%rdi, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rdi
               	xorq	%r8, %r8
               	movq	%rdi, %r10
               	movq	%r8, %rdi
               	subq	%r10, %rdi
               	movl	%edi, (%rsi,%rcx,4)
               	cmpl	%edx, %edi
               	jne	<addr>
               	movslq	(%rsi,%rcx,4), %rsi
               	cmpl	%edx, %esi
               	jne	<addr>
               	movslq	%edx, %rsi
               	movslq	-0x10(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	leaq	-0x88(%rbp), %rsi
               	movslq	(%rsi,%rcx,4), %rdi
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
               	movl	%edi, (%rsi,%rcx,4)
               	movq	%rdi, %rcx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rbx), %rax
               	incq	%rax
               	movl	%eax, (%rbx)
               	xorq	%rax, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0x3, %ecx
               	movl	%ecx, -0x8(%rbp)
               	leaq	-0x90(%rbp), %rdi
               	leaq	-0x30(%rbp), %r8
               	leaq	<rip>, %rdx
               	movslq	%eax, %rcx
               	movq	(%rdx,%rcx,8), %rsi
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
               	movq	(%rdx,%rcx,8), %rsi
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
               	movq	(%rdx,%rcx,8), %rdx
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
               	movq	(%rdx,%rcx,8), %rsi
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
               	movq	(%rdx,%rcx,8), %rsi
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
               	movq	(%rdx,%rcx,8), %rcx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rcx
               	movq	(%rdi), %rdx
               	andq	$0xffffff, %rdx         # imm = 0xFFFFFF
               	shlq	$0x18, %rcx
               	orq	%rcx, %rdx
               	movq	%rdx, (%rdi)
               	sarq	$0x18, %rcx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rcx
               	movq	(%rsi), %rdx
               	andq	$0xffffff, %rdx         # imm = 0xFFFFFF
               	shlq	$0x18, %rcx
               	orq	%rcx, %rdx
               	movq	%rdx, (%rsi)
               	leaq	-0x90(%rbp), %rdi
               	movl	(%rdi), %ecx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	shlq	$0x35, %rcx
               	sarq	$0x35, %rcx
               	imulq	$0x55555556, %rcx, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rcx
               	movq	%rcx, %rdx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	movl	(%rsi), %ecx
               	andq	$-0x800, %rcx           # imm = 0xF800
               	orq	%rdx, %rcx
               	movl	%ecx, (%rsi)
               	leaq	-0x30(%rbp), %rdx
               	movl	(%rdx), %r8d
               	movq	%r8, %rsi
               	andq	$0x7ff, %rsi            # imm = 0x7FF
               	shlq	$0x35, %rsi
               	movq	%rsi, %r9
               	sarq	$0x35, %r9
               	movslq	-0x8(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rsi, %r9
               	andq	$0x7ff, %r9             # imm = 0x7FF
               	movq	%r8, %rsi
               	andq	$-0x800, %rsi           # imm = 0xF800
               	orq	%r9, %rsi
               	movl	%esi, (%rdx)
               	movl	%ecx, %edx
               	movq	%rdx, %r8
               	sarq	$0xb, %r8
               	andq	$0x1fff, %r8            # imm = 0x1FFF
               	imulq	$0x55555556, %r8, %r9   # imm = 0x55555556
               	sarq	$0x20, %r9
               	movq	%r9, %r12
               	shrq	$0x3f, %r12
               	addq	%r12, %r9
               	leaq	(%r9,%r9,2), %r9
               	subq	%r9, %r8
               	andq	$0x1fff, %r8            # imm = 0x1FFF
               	movq	%rdx, %rcx
               	andq	$-0xfff801, %rcx        # imm = 0xFF0007FF
               	movq	%r8, %rdx
               	shlq	$0xb, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rdi)
               	leaq	-0x30(%rbp), %r8
               	movl	%esi, %edx
               	movq	%rdx, %rcx
               	sarq	$0xb, %rcx
               	movq	%rcx, %rdi
               	andq	$0x1fff, %rdi           # imm = 0x1FFF
               	movslq	-0x8(%rbp), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	andq	$0x1fff, %rcx           # imm = 0x1FFF
               	andq	$-0xfff801, %rdx        # imm = 0xFF0007FF
               	shlq	$0xb, %rcx
               	orq	%rdx, %rcx
               	movl	%ecx, (%r8)
               	leaq	-0x90(%rbp), %rcx
               	movq	(%rcx), %rdx
               	movq	%rdx, %rsi
               	sarq	$0x18, %rsi
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rsi
               	shlq	$0x18, %rsi
               	sarq	$0x18, %rsi
               	movabsq	$0x5555555555555556, %rdi # imm = 0x5555555555555556
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	imulq	%rdi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	%rdi, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rdi
               	leaq	(%rdi,%rdi,2), %rdi
               	subq	%rdi, %rsi
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rsi
               	movq	%rdx, %rdi
               	andq	$0xffffff, %rdi         # imm = 0xFFFFFF
               	movq	%rsi, %rdx
               	shlq	$0x18, %rdx
               	orq	%rdx, %rdi
               	movq	%rdi, (%rcx)
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
               	movl	(%rcx), %ecx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	shlq	$0x35, %rcx
               	movq	%rcx, %rdx
               	sarq	$0x35, %rdx
               	leaq	-0x30(%rbp), %rcx
               	movl	(%rcx), %esi
               	andq	$0x7ff, %rsi            # imm = 0x7FF
               	shlq	$0x35, %rsi
               	sarq	$0x35, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	-0x90(%rbp), %rdx
               	movl	(%rdx), %edx
               	sarq	$0xb, %rdx
               	andq	$0x1fff, %rdx           # imm = 0x1FFF
               	movl	(%rcx), %ecx
               	sarq	$0xb, %rcx
               	andq	$0x1fff, %rcx           # imm = 0x1FFF
               	cmpl	%ecx, %edx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	%rdi, %rcx
               	sarq	$0x18, %rcx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rcx
               	shlq	$0x18, %rcx
               	sarq	$0x18, %rcx
               	movq	%r8, %rdx
               	sarq	$0x18, %rdx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdx
               	shlq	$0x18, %rdx
               	sarq	$0x18, %rdx
               	cmpq	%rdx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movslq	(%rbx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movslq	(%rbx), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movslq	(%rbx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movslq	(%rbx), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movslq	(%rbx), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movslq	(%rbx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movslq	(%rbx), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
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
