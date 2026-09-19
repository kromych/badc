
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
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movq	%rcx, 0x48(%rax)
               	movq	$0x7f, 0x50(%rax)
               	movq	$-0x80, 0x58(%rax)
               	movq	$0xff, 0x60(%rax)
               	movq	$0x7fff, 0x68(%rax)     # imm = 0x7FFF
               	movq	$-0x8000, 0x70(%rax)    # imm = 0x8000
               	movq	$0xffff, 0x78(%rax)     # imm = 0xFFFF
               	movabsq	$0x2ceaee21bf46bc00, %rcx # imm = 0x2CEAEE21BF46BC00
               	leaq	<rip>, %rax
               	movq	%rcx, 0x80(%rax)
               	movabsq	$-0x557f8ab2e5e572b1, %rcx # imm = 0xAA80754D1A1A8D4F
               	leaq	<rip>, %rax
               	movq	%rcx, 0x88(%rax)
               	movabsq	$-0x4c3b6fb592d876ce, %rcx # imm = 0xB3C4904A6D278932
               	leaq	<rip>, %rax
               	movq	%rcx, 0x90(%rax)
               	movabsq	$-0x439630bd897b92e7, %rcx # imm = 0xBC69CF4276846D19
               	leaq	<rip>, %rax
               	movq	%rcx, 0x98(%rax)
               	movabsq	$0x377b2fd56a5b15b4, %rcx # imm = 0x377B2FD56A5B15B4
               	leaq	<rip>, %rax
               	movq	%rcx, 0xa0(%rax)
               	movabsq	$0x64d815deeaf29df3, %rcx # imm = 0x64D815DEEAF29DF3
               	leaq	<rip>, %rax
               	movq	%rcx, 0xa8(%rax)
               	movabsq	$-0x991eff24d282dfa, %rcx # imm = 0xF66E100DB2D7D206
               	leaq	<rip>, %rax
               	movq	%rcx, 0xb0(%rax)
               	movabsq	$0x1069e6a57e06665d, %rcx # imm = 0x1069E6A57E06665D
               	leaq	<rip>, %rax
               	movq	%rcx, 0xb8(%rax)
               	retq

<plain>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0xa, -0xe0(%rbp)
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movslq	%edx, %rdx
               	imulq	$0x66666667, %rdx, %rsi # imm = 0x66666667
               	sarq	$0x22, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	imulq	$0xa, %rsi, %rdi
               	movq	%rdi, %r10
               	movq	%rdx, %rdi
               	subq	%r10, %rdi
               	movslq	-0xe0(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movslq	-0xe0(%rbp), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%r8
               	popq	%rax
               	cmpl	%r9d, %esi
               	jne	<addr>
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x7, -0xd8(%rbp)
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movslq	%edx, %rdx
               	movl	$0x92492493, %esi       # imm = 0x92492493
               	imulq	%rdx, %rsi
               	sarq	$0x22, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	imulq	$0x7, %rsi, %rdi
               	movq	%rdi, %r10
               	movq	%rdx, %rdi
               	subq	%r10, %rdi
               	movslq	-0xd8(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movslq	-0xd8(%rbp), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%r8
               	popq	%rax
               	cmpl	%r9d, %esi
               	jne	<addr>
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0xfffffff9, -0xd0(%rbp) # imm = 0xFFFFFFF9
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movslq	%edx, %rdx
               	movl	$0x92492493, %esi       # imm = 0x92492493
               	imulq	%rdx, %rsi
               	sarq	$0x22, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	xorl	%edi, %edi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	imulq	$-0x7, %rsi, %rdi
               	movq	%rdi, %r10
               	movq	%rdx, %rdi
               	subq	%r10, %rdi
               	movslq	-0xd0(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movslq	-0xd0(%rbp), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%r8
               	popq	%rax
               	cmpl	%r9d, %esi
               	jne	<addr>
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x10, -0xc8(%rbp)
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x3c, %rsi
               	leaq	(%rdx,%rsi), %rdi
               	movq	%rdi, %r8
               	sarq	$0x4, %r8
               	andq	$0xf, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movslq	-0xc8(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movslq	-0xc8(%rbp), %rdi
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rdi
               	popq	%rax
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	cmpl	%edx, %esi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0xfffffff0, -0xc0(%rbp) # imm = 0xFFFFFFF0
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x3c, %rsi
               	leaq	(%rdx,%rsi), %rdi
               	movq	%rdi, %r8
               	sarq	$0x4, %r8
               	xorl	%r9d, %r9d
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
               	movq	%rdx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movslq	-0xc0(%rbp), %rdi
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rdi
               	popq	%rax
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	cmpl	%edx, %esi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x1, -0xb8(%rbp)
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movslq	%edx, %rdx
               	movslq	-0xb8(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movslq	-0xb8(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpl	%edi, %edx
               	jne	<addr>
               	testl	%esi, %esi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0xffffffff, -0xb0(%rbp) # imm = 0xFFFFFFFF
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movslq	%edx, %rdx
               	cmpl	$0x80000000, %edx       # imm = 0x80000000
               	je	<addr>
               	movq	%rdi, %r8
               	subq	%rdx, %r8
               	movslq	-0xb0(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movslq	-0xb0(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	popq	%rax
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x7fffffff, -0xa8(%rbp) # imm = 0x7FFFFFFF
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movslq	%edx, %rdx
               	imulq	$0x40000001, %rdx, %rsi # imm = 0x40000001
               	sarq	$0x3d, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	imulq	$0x7fffffff, %rsi, %rdi # imm = 0x7FFFFFFF
               	movq	%rdi, %r10
               	movq	%rdx, %rdi
               	subq	%r10, %rdi
               	movslq	-0xa8(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movslq	-0xa8(%rbp), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%r8
               	popq	%rax
               	cmpl	%r9d, %esi
               	jne	<addr>
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x80000000, -0xa0(%rbp) # imm = 0x80000000
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x21, %rsi
               	leaq	(%rdx,%rsi), %rdi
               	movq	%rdi, %r8
               	sarq	$0x1f, %r8
               	xorl	%r9d, %r9d
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
               	movq	%rdx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movslq	-0xa0(%rbp), %rdi
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rdi
               	popq	%rax
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	cmpl	%edx, %esi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0xa, -0x98(%rbp)
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movl	%edx, %esi
               	movq	%rsi, %r8
               	shrq	%r8
               	imulq	$0x66666667, %r8, %r9   # imm = 0x66666667
               	movq	%r9, %rdi
               	shrq	$0x21, %rdi
               	imulq	$0xa, %rdi, %r8
               	movq	%r8, %r10
               	movq	%rsi, %r8
               	subq	%r10, %r8
               	movl	-0x98(%rbp), %r9d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movl	%edx, %r9d
               	movl	-0x98(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%r9, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	popq	%rax
               	cmpl	%esi, %edi
               	jne	<addr>
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x7, -0x90(%rbp)
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movl	%edx, %esi
               	imulq	$0x24924925, %rsi, %r8  # imm = 0x24924925
               	movq	%r8, %rdi
               	shrq	$0x20, %rdi
               	movq	%rsi, %r9
               	subq	%rdi, %r9
               	movq	%r9, %rbx
               	shrq	%rbx
               	leaq	(%rbx,%rdi), %r12
               	shrq	$0x2, %r12
               	addq	%rbx, %rdi
               	shrq	$0x2, %rdi
               	imulq	$0x7, %rdi, %rdi
               	subq	%rdi, %rsi
               	movl	%edx, %edi
               	movl	-0x90(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movl	-0x90(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	popq	%rax
               	cmpl	%r8d, %r12d
               	jne	<addr>
               	cmpl	%edx, %esi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x8, -0x88(%rbp)
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movl	%edx, %esi
               	movq	%rsi, %r8
               	shrq	$0x3, %r8
               	movq	%rdx, %rdi
               	andq	$0x7, %rdi
               	movl	-0x88(%rbp), %r9d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movl	-0x88(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	popq	%rax
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x1, -0x80(%rbp)
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movl	%edx, %esi
               	movl	-0x80(%rbp), %edi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movl	-0x80(%rbp), %edi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpl	%r8d, %edx
               	jne	<addr>
               	testl	%esi, %esi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x80000001, -0x78(%rbp) # imm = 0x80000001
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	movq	%rdx, %r8
               	cmpl	%r11d, %edx
               	setae	%r8b
               	movzbq	%r8b, %r8
               	movl	%edx, %esi
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	movq	%rsi, %rdi
               	cmpq	%r11, %rsi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	imulq	%r11, %rdi
               	movq	%rdi, %r10
               	movq	%rsi, %rdi
               	subq	%r10, %rdi
               	movl	-0x78(%rbp), %r9d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movl	-0x78(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	popq	%rax
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0xee6b2800, -0x70(%rbp) # imm = 0xEE6B2800
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	movq	%rdx, %r8
               	cmpl	%r11d, %edx
               	setae	%r8b
               	movzbq	%r8b, %r8
               	movl	%edx, %esi
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	movq	%rsi, %rdi
               	cmpq	%r11, %rsi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	imulq	%r11, %rdi
               	movq	%rdi, %r10
               	movq	%rsi, %rdi
               	subq	%r10, %rdi
               	movl	-0x70(%rbp), %r9d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movl	-0x70(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	popq	%rax
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0xffffffff, -0x68(%rbp) # imm = 0xFFFFFFFF
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rdx, %r8
               	cmpl	%r11d, %edx
               	setae	%r8b
               	movzbq	%r8b, %r8
               	movl	%edx, %esi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rsi, %rdi
               	cmpq	%r11, %rsi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	imulq	%r11, %rdi
               	movq	%rdi, %r10
               	movq	%rsi, %rdi
               	subq	%r10, %rdi
               	movl	-0x68(%rbp), %r9d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movl	-0x68(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	popq	%rax
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$0xa, -0x60(%rbp)
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rdx, %rsi
               	cmpq	%r11, %rdx
               	je	<addr>
               	movabsq	$0x6666666666666667, %rsi # imm = 0x6666666666666667
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	imulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	sarq	$0x2, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rsi, %rdi
               	imulq	$0xa, %rdi, %rsi
               	movq	%rdx, %r8
               	subq	%rsi, %r8
               	movq	-0x60(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	-0x60(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	popq	%rax
               	cmpq	%r9, %rdi
               	jne	<addr>
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$-0x3e8, -0x58(%rbp)    # imm = 0xFC18
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rdx, %rsi
               	cmpq	%r11, %rdx
               	je	<addr>
               	movabsq	$0x20c49ba5e353f7cf, %rsi # imm = 0x20C49BA5E353F7CF
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	imulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	sarq	$0x7, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	xorl	%edi, %edi
               	subq	%rsi, %rdi
               	imulq	$-0x3e8, %rdi, %rsi     # imm = 0xFC18
               	movq	%rdx, %r8
               	subq	%rsi, %r8
               	movq	-0x58(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	-0x58(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	popq	%rax
               	cmpq	%r9, %rdi
               	jne	<addr>
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$0x1000, -0x50(%rbp)    # imm = 0x1000
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rdx, %rsi
               	cmpq	%r11, %rdx
               	je	<addr>
               	movq	%rdx, %rsi
               	sarq	$0x3f, %rsi
               	shrq	$0x34, %rsi
               	leaq	(%rdx,%rsi), %rdi
               	movq	%rdi, %r8
               	sarq	$0xc, %r8
               	andq	$0xfff, %rdi            # imm = 0xFFF
               	subq	%rsi, %rdi
               	movq	-0x50(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	-0x50(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	popq	%rax
               	cmpq	%r9, %r8
               	jne	<addr>
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$-0x1, -0x48(%rbp)
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%rdx, %rsi
               	cmpq	%r11, %rdx
               	je	<addr>
               	movq	%rdi, %r8
               	subq	%rdx, %r8
               	movq	-0x48(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	-0x48(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	popq	%rax
               	cmpq	%r9, %r8
               	jne	<addr>
               	testq	%rdx, %rdx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movabsq	$-0x8000000000000000, %rdx # imm = 0x8000000000000000
               	movq	%rdx, -0x40(%rbp)
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rdx, %rsi
               	cmpq	%r11, %rdx
               	je	<addr>
               	movq	%rdx, %rsi
               	sarq	$0x3f, %rsi
               	shrq	%rsi
               	leaq	(%rdx,%rsi), %rdi
               	movq	%rdi, %r8
               	sarq	$0x3f, %r8
               	xorl	%r9d, %r9d
               	movq	%r8, %r10
               	movq	%r9, %r8
               	subq	%r10, %r8
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%r11, %rdi
               	subq	%rsi, %rdi
               	movq	-0x40(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	-0x40(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	popq	%rax
               	cmpq	%r9, %r8
               	jne	<addr>
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$0xa, -0x38(%rbp)
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rdx, %rsi
               	cmpq	%r11, %rdx
               	je	<addr>
               	movq	%rdx, %rsi
               	shrq	%rsi
               	movabsq	$0x6666666666666667, %rdi # imm = 0x6666666666666667
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	mulq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rsi, %rdi
               	shrq	%rdi
               	imulq	$0xa, %rdi, %rsi
               	movq	%rdx, %r8
               	subq	%rsi, %r8
               	movq	-0x38(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	-0x38(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	popq	%rax
               	cmpq	%r9, %rdi
               	jne	<addr>
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$0x7, -0x30(%rbp)
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rdx, %rsi
               	cmpq	%r11, %rdx
               	je	<addr>
               	movabsq	$0x2492492492492493, %rsi # imm = 0x2492492492492493
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	mulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rdx, %rdi
               	subq	%rsi, %rdi
               	shrq	%rdi
               	addq	%rdi, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x2, %rdi
               	imulq	$0x7, %rdi, %rsi
               	movq	%rdx, %r8
               	subq	%rsi, %r8
               	movq	-0x30(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	-0x30(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	popq	%rax
               	cmpq	%r9, %rdi
               	jne	<addr>
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movabsq	$-0x7fffffffffffffff, %rdx # imm = 0x8000000000000001
               	movq	%rdx, -0x28(%rbp)
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rdx, %rsi
               	cmpq	%r11, %rdx
               	je	<addr>
               	movabsq	$-0x7fffffffffffffff, %r11 # imm = 0x8000000000000001
               	movq	%rdx, %rdi
               	cmpq	%r11, %rdx
               	setae	%dil
               	movzbq	%dil, %rdi
               	movabsq	$-0x7fffffffffffffff, %rsi # imm = 0x8000000000000001
               	imulq	%rdi, %rsi
               	movq	%rdx, %r8
               	subq	%rsi, %r8
               	movq	-0x28(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	-0x28(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	popq	%rax
               	cmpq	%r9, %rdi
               	jne	<addr>
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$0x64, -0x20(%rbp)
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rdx, %rsi
               	cmpq	%r11, %rdx
               	je	<addr>
               	movabsq	$-0x5c28f5c28f5c28f5, %rsi # imm = 0xA3D70A3D70A3D70B
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	imulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	addq	%rdx, %rsi
               	sarq	$0x6, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rsi, %rdi
               	imulq	$0x64, %rdi, %rsi
               	movq	%rdx, %r8
               	subq	%rsi, %r8
               	movq	-0x20(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	-0x20(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	popq	%rax
               	cmpq	%r9, %rdi
               	jne	<addr>
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$-0x3, -0x18(%rbp)
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rdx, %rsi
               	cmpq	%r11, %rdx
               	je	<addr>
               	movabsq	$0x5555555555555556, %rsi # imm = 0x5555555555555556
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	imulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	xorl	%edi, %edi
               	subq	%rsi, %rdi
               	imulq	$-0x3, %rdi, %rsi
               	movq	%rdx, %r8
               	subq	%rsi, %r8
               	movq	-0x18(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	-0x18(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	popq	%rax
               	cmpq	%r9, %rdi
               	jne	<addr>
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$0x64, -0x10(%rbp)
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rdx, %rsi
               	cmpq	%r11, %rdx
               	je	<addr>
               	movq	%rdx, %rsi
               	shrq	$0x2, %rsi
               	movabsq	$0x28f5c28f5c28f5c3, %rdi # imm = 0x28F5C28F5C28F5C3
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	mulq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rsi, %rdi
               	shrq	$0x2, %rdi
               	imulq	$0x64, %rdi, %rsi
               	movq	%rdx, %r8
               	subq	%rsi, %r8
               	movq	-0x10(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	-0x10(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	popq	%rax
               	cmpq	%r9, %rdi
               	jne	<addr>
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$0x7, -0x8(%rbp)
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rdx, %rsi
               	cmpq	%r11, %rdx
               	je	<addr>
               	movabsq	$0x2492492492492493, %rsi # imm = 0x2492492492492493
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	mulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rdx, %rdi
               	subq	%rsi, %rdi
               	shrq	%rdi
               	addq	%rdi, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x2, %rdi
               	imulq	$0x7, %rdi, %rsi
               	movq	%rdx, %r8
               	subq	%rsi, %r8
               	movq	-0x8(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	-0x8(%rbp), %rsi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	popq	%rax
               	cmpq	%r9, %rdi
               	jne	<addr>
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<converted>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0x3, -0xa8(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movsbq	%cl, %rcx
               	imulq	$0x55555556, %rcx, %rsi # imm = 0x55555556
               	sarq	$0x20, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	leaq	(%rsi,%rsi,2), %rdi
               	movq	%rdi, %r10
               	movq	%rcx, %rdi
               	subq	%r10, %rdi
               	movslq	-0xa8(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movsbq	%r8b, %r9
               	movslq	-0xa8(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r8
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movsbq	%cl, %r8
               	cmpl	%r9d, %esi
               	jne	<addr>
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0xfffffffb, -0xa0(%rbp) # imm = 0xFFFFFFFB
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movsbq	%cl, %rcx
               	imulq	$0x66666667, %rcx, %rsi # imm = 0x66666667
               	sarq	$0x21, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	xorl	%edi, %edi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	imulq	$-0x5, %rsi, %rdi
               	movq	%rdi, %r10
               	movq	%rcx, %rdi
               	subq	%r10, %rdi
               	movslq	-0xa0(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movsbq	%r8b, %r9
               	movslq	-0xa0(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r8
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movsbq	%cl, %r8
               	cmpl	%r9d, %esi
               	jne	<addr>
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%edi, %edi
               	movq	%rdi, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0xffffffff, -0x98(%rbp) # imm = 0xFFFFFFFF
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movsbq	%cl, %rcx
               	movq	%rdi, %rsi
               	subq	%rcx, %rsi
               	movsbq	%sil, %r8
               	movslq	-0x98(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movsbq	%sil, %r9
               	movslq	-0x98(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movsbq	%cl, %rsi
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	testq	%rsi, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x3, -0x90(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	andq	$0xff, %rax
               	imulq	$0x55555556, %rax, %rsi # imm = 0x55555556
               	shrq	$0x20, %rsi
               	leaq	(%rsi,%rsi,2), %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movslq	-0x90(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %r9
               	andq	$0xff, %r9
               	movslq	-0x90(%rbp), %r8
               	pushq	%rdx
               	cqto
               	idivq	%r8
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %esi
               	jne	<addr>
               	andq	$0xff, %rax
               	cmpl	%eax, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x10, -0x88(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	andq	$0xff, %rax
               	movq	%rax, %r8
               	shrq	$0x4, %r8
               	movq	%rax, %rsi
               	andq	$0xf, %rsi
               	movslq	-0x88(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	%rdi, %r9
               	andq	$0xff, %r9
               	movslq	-0x88(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	andq	$0xff, %rax
               	cmpl	%eax, %esi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0xfffffff9, -0x80(%rbp) # imm = 0xFFFFFFF9
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	andq	$0xff, %rax
               	movl	$0x92492493, %esi       # imm = 0x92492493
               	imulq	%rax, %rsi
               	sarq	$0x22, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	xorl	%edi, %edi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movq	%rsi, %r8
               	andq	$0xff, %r8
               	imulq	$-0x7, %rsi, %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movslq	-0x80(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	%rdi, %r9
               	andq	$0xff, %r9
               	movslq	-0x80(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	andq	$0xff, %rax
               	cmpl	%eax, %esi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0xa, -0x78(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movswq	%cx, %rcx
               	imulq	$0x66666667, %rcx, %rsi # imm = 0x66666667
               	sarq	$0x22, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	imulq	$0xa, %rsi, %rdi
               	movq	%rdi, %r10
               	movq	%rcx, %rdi
               	subq	%r10, %rdi
               	movslq	-0x78(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movswq	%r8w, %r9
               	movslq	-0x78(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r8
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movswq	%cx, %r8
               	cmpl	%r9d, %esi
               	jne	<addr>
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%edi, %edi
               	movq	%rdi, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0xffffffff, -0x70(%rbp) # imm = 0xFFFFFFFF
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movswq	%cx, %rcx
               	movq	%rdi, %rsi
               	subq	%rcx, %rsi
               	movswq	%si, %r8
               	movslq	-0x70(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movswq	%si, %r9
               	movslq	-0x70(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movswq	%cx, %rsi
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	testq	%rsi, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x3e8, -0x68(%rbp)     # imm = 0x3E8
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	imulq	$0x418938, %rax, %rsi   # imm = 0x418938
               	shrq	$0x20, %rsi
               	imulq	$0x3e8, %rsi, %rdi      # imm = 0x3E8
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movslq	-0x68(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %r9
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	movslq	-0x68(%rbp), %r8
               	pushq	%rdx
               	cqto
               	idivq	%r8
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %esi
               	jne	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	%eax, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x7, -0x60(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movl	-0x60(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movl	-0x60(%rbp), %r8d
               	pushq	%rdx
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %esi
               	jne	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	%eax, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0x3, -0x58(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, %esi
               	movl	$0xaaaaaaab, %r8d       # imm = 0xAAAAAAAB
               	imulq	%rsi, %r8
               	movq	%r8, %rdi
               	shrq	$0x21, %rdi
               	leaq	(%rdi,%rdi,2), %r8
               	movq	%r8, %r10
               	movq	%rsi, %r8
               	subq	%r10, %r8
               	movl	-0x58(%rbp), %r9d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	movl	-0x58(%rbp), %r9d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpl	%ebx, %edi
               	jne	<addr>
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x80000000, -0x50(%rbp) # imm = 0x80000000
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movl	%eax, %esi
               	movq	%rsi, %r9
               	shrq	$0x1f, %r9
               	movq	%rax, %rdi
               	andq	$0x7fffffff, %rdi       # imm = 0x7FFFFFFF
               	movl	-0x50(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	movl	-0x50(%rbp), %r8d
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%ebx, %r9d
               	jne	<addr>
               	cmpl	%eax, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$0x3, -0x48(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movslq	%ecx, %rcx
               	imulq	$0x55555556, %rcx, %rsi # imm = 0x55555556
               	sarq	$0x20, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	leaq	(%rsi,%rsi,2), %rdi
               	movq	%rdi, %r10
               	movq	%rcx, %rdi
               	subq	%r10, %rdi
               	movq	-0x48(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	-0x48(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r8
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpl	%r9d, %esi
               	jne	<addr>
               	cmpl	%ecx, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movabsq	$0x100000000, %rcx      # imm = 0x100000000
               	movq	%rcx, -0x40(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movslq	%ecx, %rcx
               	movq	-0x40(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	-0x40(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	testl	%esi, %esi
               	jne	<addr>
               	cmpl	%edi, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$0x7, -0x38(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movslq	%ecx, %rcx
               	movabsq	$0x2492492492492493, %rsi # imm = 0x2492492492492493
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	mulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	shrq	%rdi
               	addq	%rdi, %rsi
               	shrq	$0x2, %rsi
               	imulq	$0x7, %rsi, %rdi
               	movq	%rdi, %r10
               	movq	%rcx, %rdi
               	subq	%r10, %rdi
               	movq	-0x38(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	-0x38(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpl	%r9d, %esi
               	jne	<addr>
               	cmpl	%ecx, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$0x7, -0x30(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, %esi
               	imulq	$0x24924925, %rsi, %r8  # imm = 0x24924925
               	movq	%r8, %rdi
               	shrq	$0x20, %rdi
               	movq	%rsi, %r9
               	subq	%rdi, %r9
               	movq	%r9, %rbx
               	shrq	%rbx
               	leaq	(%rbx,%rdi), %r12
               	shrq	$0x2, %r12
               	addq	%rbx, %rdi
               	shrq	$0x2, %rdi
               	imulq	$0x7, %rdi, %rdi
               	subq	%rdi, %rsi
               	movl	%ecx, %edi
               	movq	-0x30(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	-0x30(%rbp), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpl	%r8d, %r12d
               	jne	<addr>
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$-0x7, -0x28(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, %edi
               	movabsq	$0x4924924924924925, %r8 # imm = 0x4924924924924925
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	imulq	%r8
               	movq	%rdx, %r9
               	popq	%rdx
               	popq	%rax
               	movq	%r9, %rsi
               	sarq	%rsi
               	movq	%rsi, %rbx
               	shrq	$0x3f, %rbx
               	leaq	(%rsi,%rbx), %r12
               	xorl	%ebx, %ebx
               	movq	%r12, %r10
               	movq	%rbx, %r12
               	subq	%r10, %r12
               	movq	%rsi, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rsi
               	movq	%rsi, %r10
               	movq	%rbx, %rsi
               	subq	%r10, %rsi
               	imulq	$-0x7, %rsi, %rsi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movl	%ecx, %edi
               	movq	-0x28(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	-0x28(%rbp), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpl	%r8d, %r12d
               	jne	<addr>
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$0xa, -0x20(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, %esi
               	movq	%rsi, %r8
               	shrq	%r8
               	imulq	$0x66666667, %r8, %r9   # imm = 0x66666667
               	movq	%r9, %rdi
               	shrq	$0x21, %rdi
               	imulq	$0xa, %rdi, %r8
               	movq	%r8, %r10
               	movq	%rsi, %r8
               	subq	%r10, %r8
               	movq	-0x20(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, %r9d
               	movq	-0x20(%rbp), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpl	%esi, %edi
               	jne	<addr>
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$0x9, -0x18(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movswq	%cx, %rcx
               	movabsq	$-0x1c71c71c71c71c71, %rsi # imm = 0xE38E38E38E38E38F
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	mulq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	shrq	$0x3, %rsi
               	movswq	%si, %r8
               	leaq	(%rsi,%rsi,8), %rsi
               	movq	%rsi, %r10
               	movq	%rcx, %rsi
               	subq	%r10, %rsi
               	movq	-0x18(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movswq	%di, %r9
               	movq	-0x18(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movswq	%cx, %rdi
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0xfffffff6, -0x10(%rbp) # imm = 0xFFFFFFF6
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rsi
               	cmpq	%r11, %rcx
               	je	<addr>
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
               	xorl	%edi, %edi
               	subq	%rsi, %rdi
               	imulq	$-0xa, %rdi, %rsi
               	movq	%rcx, %r8
               	subq	%rsi, %r8
               	movslq	-0x10(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movslq	-0x10(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%r9, %rdi
               	jne	<addr>
               	cmpq	%rcx, %r8
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0xa, -0x8(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rsi
               	cmpq	%r11, %rcx
               	je	<addr>
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
               	movq	%rsi, %rdi
               	shrq	%rdi
               	imulq	$0xa, %rdi, %rsi
               	movq	%rcx, %r8
               	subq	%rsi, %r8
               	movslq	-0x8(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movslq	-0x8(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%r9, %rdi
               	jne	<addr>
               	cmpq	%rcx, %r8
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<places>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rbx
               	movslq	(%rbx), %rax
               	incq	%rax
               	movl	%eax, (%rbx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdx
               	movl	%edx, -0x28(%rbp)
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, -0x20(%rbp)
               	movl	$0xa, -0x18(%rbp)
               	movslq	-0x28(%rbp), %rcx
               	imulq	$0x66666667, %rcx, %rcx # imm = 0x66666667
               	sarq	$0x22, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rcx
               	movl	%ecx, -0x28(%rbp)
               	movslq	-0x20(%rbp), %rcx
               	movslq	-0x18(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, -0x20(%rbp)
               	movslq	-0x28(%rbp), %rcx
               	movslq	-0x20(%rbp), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdx
               	movl	%edx, -0x28(%rbp)
               	movq	(%rcx,%rax,8), %rcx
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
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	xorl	%esi, %esi
               	movq	%rsi, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0xfffffff7, -0x10(%rbp) # imm = 0xFFFFFFF7
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movslq	%ecx, %rcx
               	movslq	-0x10(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	leaq	-0x88(%rbp), %rdx
               	movslq	(%rdx,%rax,4), %rdi
               	imulq	$0x38e38e39, %rdi, %rdi # imm = 0x38E38E39
               	sarq	$0x21, %rdi
               	movq	%rdi, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rdi
               	movq	%rdi, %r10
               	movq	%rsi, %rdi
               	subq	%r10, %rdi
               	movl	%edi, (%rdx,%rax,4)
               	cmpl	%ecx, %edi
               	jne	<addr>
               	movslq	(%rdx,%rax,4), %rdx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	movslq	%ecx, %rdx
               	movslq	-0x10(%rbp), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	leaq	-0x88(%rbp), %rdx
               	movslq	(%rdx,%rax,4), %rdi
               	imulq	$0x38e38e39, %rdi, %r8  # imm = 0x38E38E39
               	sarq	$0x21, %r8
               	movq	%r8, %r9
               	shrq	$0x3f, %r9
               	addq	%r9, %r8
               	xorl	%r9d, %r9d
               	movq	%r8, %r10
               	movq	%r9, %r8
               	subq	%r10, %r8
               	imulq	$-0x9, %r8, %r8
               	subq	%r8, %rdi
               	movl	%edi, (%rdx,%rax,4)
               	movq	%rdi, %rdx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rbx), %rax
               	incq	%rax
               	movl	%eax, (%rbx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0x3, -0x8(%rbp)
               	leaq	-0x90(%rbp), %rdx
               	leaq	-0x30(%rbp), %rdi
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rsi
               	movq	%rsi, %r8
               	andq	$0x7ff, %r8             # imm = 0x7FF
               	movl	(%rdi), %esi
               	andq	$-0x800, %rsi           # imm = 0xF800
               	orq	%r8, %rsi
               	movl	%esi, (%rdi)
               	movq	%r8, %rdi
               	shlq	$0x35, %rdi
               	sarq	$0x35, %rdi
               	movq	%rdi, %r8
               	andq	$0x7ff, %r8             # imm = 0x7FF
               	movl	(%rdx), %edi
               	andq	$-0x800, %rdi           # imm = 0xF800
               	orq	%r8, %rdi
               	movl	%edi, (%rdx)
               	leaq	-0x30(%rbp), %r9
               	movq	(%rcx,%rax,8), %r8
               	andq	$0x1fff, %r8            # imm = 0x1FFF
               	movq	%rsi, %r12
               	andq	$-0xfff801, %r12        # imm = 0xFF0007FF
               	movq	%r8, %rsi
               	shlq	$0xb, %rsi
               	movq	%r12, %r8
               	orq	%rsi, %r8
               	movl	%r8d, (%r9)
               	andq	$-0xfff801, %rdi        # imm = 0xFF0007FF
               	orq	%rdi, %rsi
               	movl	%esi, (%rdx)
               	leaq	-0x90(%rbp), %rdx
               	leaq	-0x30(%rbp), %rsi
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rcx
               	movq	(%rsi), %rdi
               	andq	$0xffffff, %rdi         # imm = 0xFFFFFF
               	shlq	$0x18, %rcx
               	orq	%rcx, %rdi
               	movq	%rdi, (%rsi)
               	sarq	$0x18, %rcx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rcx
               	movq	(%rdx), %rsi
               	andq	$0xffffff, %rsi         # imm = 0xFFFFFF
               	shlq	$0x18, %rcx
               	orq	%rcx, %rsi
               	movq	%rsi, (%rdx)
               	movl	(%rdx), %ecx
               	movq	%rcx, %rsi
               	andq	$0x7ff, %rsi            # imm = 0x7FF
               	shlq	$0x35, %rsi
               	sarq	$0x35, %rsi
               	imulq	$0x55555556, %rsi, %rsi # imm = 0x55555556
               	sarq	$0x20, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	andq	$0x7ff, %rsi            # imm = 0x7FF
               	andq	$-0x800, %rcx           # imm = 0xF800
               	orq	%rsi, %rcx
               	movl	%ecx, (%rdx)
               	leaq	-0x30(%rbp), %rdx
               	movl	(%rdx), %esi
               	movq	%rsi, %rdi
               	andq	$0x7ff, %rdi            # imm = 0x7FF
               	shlq	$0x35, %rdi
               	sarq	$0x35, %rdi
               	movslq	-0x8(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	andq	$0x7ff, %rdi            # imm = 0x7FF
               	andq	$-0x800, %rsi           # imm = 0xF800
               	orq	%rdi, %rsi
               	movl	%esi, (%rdx)
               	leaq	-0x90(%rbp), %rdi
               	movl	%ecx, %r8d
               	sarq	$0xb, %r8
               	andq	$0x1fff, %r8            # imm = 0x1FFF
               	imulq	$0x55555556, %r8, %r8   # imm = 0x55555556
               	shrq	$0x20, %r8
               	andq	$-0xfff801, %rcx        # imm = 0xFF0007FF
               	shlq	$0xb, %r8
               	orq	%r8, %rcx
               	movl	%ecx, (%rdi)
               	movl	%esi, %ecx
               	sarq	$0xb, %rcx
               	andq	$0x1fff, %rcx           # imm = 0x1FFF
               	movslq	-0x8(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	andq	$0x1fff, %rcx           # imm = 0x1FFF
               	andq	$-0xfff801, %rsi        # imm = 0xFF0007FF
               	shlq	$0xb, %rcx
               	orq	%rsi, %rcx
               	movl	%ecx, (%rdx)
               	leaq	-0x90(%rbp), %rdx
               	movq	(%rdx), %rcx
               	sarq	$0x18, %rcx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rcx
               	shlq	$0x18, %rcx
               	sarq	$0x18, %rcx
               	movabsq	$0x5555555555555556, %rsi # imm = 0x5555555555555556
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rcx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rcx
               	movq	(%rdi), %rsi
               	andq	$0xffffff, %rsi         # imm = 0xFFFFFF
               	shlq	$0x18, %rcx
               	movq	%rsi, %r8
               	orq	%rcx, %r8
               	movq	%r8, (%rdi)
               	leaq	-0x30(%rbp), %rcx
               	movq	(%rcx), %rsi
               	movq	%rsi, %rdi
               	sarq	$0x18, %rdi
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdi
               	shlq	$0x18, %rdi
               	sarq	$0x18, %rdi
               	movslq	-0x8(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdi
               	movq	%rsi, %r9
               	andq	$0xffffff, %r9          # imm = 0xFFFFFF
               	movq	%rdi, %rsi
               	shlq	$0x18, %rsi
               	movq	%r9, %rdi
               	orq	%rsi, %rdi
               	movq	%rdi, (%rcx)
               	movl	(%rdx), %edx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	shlq	$0x35, %rdx
               	sarq	$0x35, %rdx
               	movl	(%rcx), %ecx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	shlq	$0x35, %rcx
               	sarq	$0x35, %rcx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	leaq	-0x90(%rbp), %rdx
               	movl	(%rdx), %ecx
               	sarq	$0xb, %rcx
               	andq	$0x1fff, %rcx           # imm = 0x1FFF
               	leaq	-0x30(%rbp), %rsi
               	movl	(%rsi), %r9d
               	sarq	$0xb, %r9
               	andq	$0x1fff, %r9            # imm = 0x1FFF
               	cmpl	%r9d, %ecx
               	jne	<addr>
               	movq	%r8, %rcx
               	sarq	$0x18, %rcx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rcx
               	shlq	$0x18, %rcx
               	sarq	$0x18, %rcx
               	sarq	$0x18, %rdi
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdi
               	shlq	$0x18, %rdi
               	sarq	$0x18, %rdi
               	cmpq	%rdi, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdi
               	movq	%rdi, %r8
               	andq	$0x7ff, %r8             # imm = 0x7FF
               	movl	(%rsi), %edi
               	andq	$-0x800, %rdi           # imm = 0xF800
               	orq	%r8, %rdi
               	movl	%edi, (%rsi)
               	movq	%r8, %rsi
               	shlq	$0x35, %rsi
               	sarq	$0x35, %rsi
               	movq	%rsi, %r8
               	andq	$0x7ff, %r8             # imm = 0x7FF
               	movl	(%rdx), %esi
               	andq	$-0x800, %rsi           # imm = 0xF800
               	orq	%r8, %rsi
               	movl	%esi, (%rdx)
               	leaq	-0x90(%rbp), %r8
               	leaq	-0x30(%rbp), %r9
               	movq	(%rcx,%rax,8), %rdx
               	andq	$0x1fff, %rdx           # imm = 0x1FFF
               	andq	$-0xfff801, %rdi        # imm = 0xFF0007FF
               	shlq	$0xb, %rdx
               	orq	%rdx, %rdi
               	movl	%edi, (%r9)
               	andq	$-0xfff801, %rsi        # imm = 0xFF0007FF
               	orq	%rsi, %rdx
               	movl	%edx, (%r8)
               	leaq	-0x90(%rbp), %rdx
               	leaq	-0x30(%rbp), %rsi
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rcx
               	movq	(%rsi), %rdi
               	andq	$0xffffff, %rdi         # imm = 0xFFFFFF
               	shlq	$0x18, %rcx
               	orq	%rcx, %rdi
               	movq	%rdi, (%rsi)
               	sarq	$0x18, %rcx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rcx
               	movq	(%rdx), %rsi
               	andq	$0xffffff, %rsi         # imm = 0xFFFFFF
               	shlq	$0x18, %rcx
               	orq	%rcx, %rsi
               	movq	%rsi, (%rdx)
               	movl	(%rdx), %ecx
               	movq	%rcx, %rsi
               	andq	$0x7ff, %rsi            # imm = 0x7FF
               	shlq	$0x35, %rsi
               	sarq	$0x35, %rsi
               	imulq	$0x55555556, %rsi, %rdi # imm = 0x55555556
               	sarq	$0x20, %rdi
               	movq	%rdi, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rdi
               	leaq	(%rdi,%rdi,2), %rdi
               	subq	%rdi, %rsi
               	andq	$0x7ff, %rsi            # imm = 0x7FF
               	andq	$-0x800, %rcx           # imm = 0xF800
               	orq	%rsi, %rcx
               	movl	%ecx, (%rdx)
               	leaq	-0x30(%rbp), %rdx
               	movl	(%rdx), %edi
               	movq	%rdi, %rsi
               	andq	$0x7ff, %rsi            # imm = 0x7FF
               	shlq	$0x35, %rsi
               	movq	%rsi, %r8
               	sarq	$0x35, %r8
               	movslq	-0x8(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rsi, %r8
               	andq	$0x7ff, %r8             # imm = 0x7FF
               	movq	%rdi, %rsi
               	andq	$-0x800, %rsi           # imm = 0xF800
               	orq	%r8, %rsi
               	movl	%esi, (%rdx)
               	leaq	-0x90(%rbp), %r8
               	movl	%ecx, %edi
               	sarq	$0xb, %rdi
               	andq	$0x1fff, %rdi           # imm = 0x1FFF
               	imulq	$0x55555556, %rdi, %r9  # imm = 0x55555556
               	shrq	$0x20, %r9
               	leaq	(%r9,%r9,2), %r9
               	subq	%r9, %rdi
               	andq	$-0xfff801, %rcx        # imm = 0xFF0007FF
               	shlq	$0xb, %rdi
               	orq	%rdi, %rcx
               	movl	%ecx, (%r8)
               	movl	%esi, %ecx
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
               	andq	$-0xfff801, %rsi        # imm = 0xFF0007FF
               	shlq	$0xb, %rcx
               	orq	%rsi, %rcx
               	movl	%ecx, (%rdx)
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
               	cmpl	%esi, %edx
               	jne	<addr>
               	leaq	-0x90(%rbp), %rdx
               	movl	(%rdx), %edx
               	sarq	$0xb, %rdx
               	andq	$0x1fff, %rdx           # imm = 0x1FFF
               	movl	(%rcx), %ecx
               	sarq	$0xb, %rcx
               	andq	$0x1fff, %rcx           # imm = 0x1FFF
               	cmpl	%ecx, %edx
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
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rbx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rbx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rbx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%rbx), %rax
               	popq	%rbx
               	popq	%r12
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
