
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
               	leaq	<rip>, %rax
               	movq	%rcx, 0xb0(%rax)
               	movabsq	$0x1069e6a57e06665d, %rcx # imm = 0x1069E6A57E06665D
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
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0xa, -0xe0(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movslq	%ecx, %rcx
               	imulq	$0x66666667, %rcx, %rdx # imm = 0x66666667
               	sarq	$0x22, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rdx
               	imulq	$0xa, %rdx, %rdi
               	movq	%rcx, %rsi
               	subq	%rdi, %rsi
               	movslq	-0xe0(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movslq	-0xe0(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpl	%r8d, %edx
               	jne	<addr>
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0x7, -0xd8(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movslq	%ecx, %rcx
               	movl	$0x92492493, %edx       # imm = 0x92492493
               	imulq	%rcx, %rdx
               	sarq	$0x22, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x7, %rdx, %rdi
               	movq	%rcx, %rsi
               	subq	%rdi, %rsi
               	movslq	-0xd8(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movslq	-0xd8(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpl	%r8d, %edx
               	jne	<addr>
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%r8d, %r8d
               	movq	%r8, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0xfffffff9, -0xd0(%rbp) # imm = 0xFFFFFFF9
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movslq	%ecx, %rcx
               	movl	$0x92492493, %edx       # imm = 0x92492493
               	imulq	%rcx, %rdx
               	sarq	$0x22, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rdx, %rsi
               	movq	%r8, %rdx
               	subq	%rsi, %rdx
               	imulq	$-0x7, %rdx, %rdi
               	movq	%rcx, %rsi
               	subq	%rdi, %rsi
               	movslq	-0xd0(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movslq	-0xd0(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpl	%r9d, %edx
               	jne	<addr>
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0x10, -0xc8(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x3c, %rsi
               	leaq	(%rcx,%rsi), %rdx
               	movq	%rdx, %rdi
               	sarq	$0x4, %rdi
               	andq	$0xf, %rdx
               	subq	%rsi, %rdx
               	movslq	-0xc8(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movslq	-0xc8(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpl	%r8d, %edi
               	jne	<addr>
               	cmpl	%ecx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0xfffffff0, -0xc0(%rbp) # imm = 0xFFFFFFF0
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x3c, %rsi
               	leaq	(%rcx,%rsi), %rdx
               	movq	%rdx, %r9
               	sarq	$0x4, %r9
               	movq	%rdi, %r8
               	subq	%r9, %r8
               	andq	$0xf, %rdx
               	subq	%rsi, %rdx
               	movslq	-0xc0(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movslq	-0xc0(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	cmpl	%ecx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0x1, -0xb8(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movslq	%ecx, %rcx
               	movslq	-0xb8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movslq	-0xb8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	cmpl	%esi, %ecx
               	jne	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%esi, %esi
               	movq	%rsi, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0xffffffff, -0xb0(%rbp) # imm = 0xFFFFFFFF
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movslq	%ecx, %rcx
               	cmpl	$0x80000000, %ecx       # imm = 0x80000000
               	je	<addr>
               	movq	%rsi, %rdi
               	subq	%rcx, %rdi
               	movslq	-0xb0(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movslq	-0xb0(%rbp), %rdx
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
               	testl	%ecx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0x7fffffff, -0xa8(%rbp) # imm = 0x7FFFFFFF
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movslq	%ecx, %rcx
               	imulq	$0x40000001, %rcx, %rdx # imm = 0x40000001
               	sarq	$0x3d, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x7fffffff, %rdx, %rdi # imm = 0x7FFFFFFF
               	movq	%rcx, %rsi
               	subq	%rdi, %rsi
               	movslq	-0xa8(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movslq	-0xa8(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpl	%r8d, %edx
               	jne	<addr>
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0x80000000, -0xa0(%rbp) # imm = 0x80000000
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x21, %rsi
               	leaq	(%rcx,%rsi), %rdx
               	movq	%rdx, %r9
               	sarq	$0x1f, %r9
               	movq	%rdi, %r8
               	subq	%r9, %r8
               	andq	$0x7fffffff, %rdx       # imm = 0x7FFFFFFF
               	subq	%rsi, %rdx
               	movslq	-0xa0(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movslq	-0xa0(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	cmpl	%ecx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0xa, -0x98(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, %edx
               	movq	%rdx, %rdi
               	shrq	%rdi
               	imulq	$0x66666667, %rdi, %r8  # imm = 0x66666667
               	movq	%r8, %rsi
               	shrq	$0x21, %rsi
               	imulq	$0xa, %rsi, %r8
               	movq	%rdx, %rdi
               	subq	%r8, %rdi
               	movl	-0x98(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movl	-0x98(%rbp), %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpl	%r8d, %esi
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
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0x7, -0x90(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, %edx
               	imulq	$0x24924925, %rdx, %rdi # imm = 0x24924925
               	movq	%rdi, %rsi
               	shrq	$0x20, %rsi
               	movq	%rdx, %r8
               	subq	%rsi, %r8
               	movq	%r8, %r9
               	shrq	%r9
               	leaq	(%r9,%rsi), %rbx
               	movq	%rbx, %r12
               	shrq	$0x2, %r12
               	movq	%rbx, %rsi
               	shrq	$0x2, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rdx
               	movl	%ecx, %esi
               	movl	-0x90(%rbp), %edi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movl	-0x90(%rbp), %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpl	%edi, %r12d
               	jne	<addr>
               	cmpl	%ecx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0x8, -0x88(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, %edx
               	movq	%rdx, %rdi
               	shrq	$0x3, %rdi
               	movq	%rcx, %rsi
               	andq	$0x7, %rsi
               	movl	-0x88(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movl	-0x88(%rbp), %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpl	%r8d, %edi
               	jne	<addr>
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0x1, -0x80(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, %edx
               	movl	-0x80(%rbp), %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movl	-0x80(%rbp), %esi
               	pushq	%rax
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	popq	%rax
               	cmpl	%edi, %ecx
               	jne	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0x80000001, -0x78(%rbp) # imm = 0x80000001
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	movq	%rcx, %rdi
               	cmpl	%r11d, %ecx
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	%ecx, %edx
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	movq	%rdx, %rsi
               	cmpq	%r11, %rdx
               	setae	%sil
               	movzbq	%sil, %rsi
               	movl	$0x80000001, %r8d       # imm = 0x80000001
               	imulq	%rsi, %r8
               	movq	%rdx, %rsi
               	subq	%r8, %rsi
               	movl	-0x78(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movl	-0x78(%rbp), %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpl	%r8d, %edi
               	jne	<addr>
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0xee6b2800, -0x70(%rbp) # imm = 0xEE6B2800
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	movq	%rcx, %rdi
               	cmpl	%r11d, %ecx
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	%ecx, %edx
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	movq	%rdx, %rsi
               	cmpq	%r11, %rdx
               	setae	%sil
               	movzbq	%sil, %rsi
               	movl	$0xee6b2800, %r8d       # imm = 0xEE6B2800
               	imulq	%rsi, %r8
               	movq	%rdx, %rsi
               	subq	%r8, %rsi
               	movl	-0x70(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movl	-0x70(%rbp), %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpl	%r8d, %edi
               	jne	<addr>
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0xffffffff, -0x68(%rbp) # imm = 0xFFFFFFFF
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rcx, %rdi
               	cmpl	%r11d, %ecx
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	%ecx, %edx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rdx, %rsi
               	cmpq	%r11, %rdx
               	setae	%sil
               	movzbq	%sil, %rsi
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	imulq	%rsi, %r8
               	movq	%rdx, %rsi
               	subq	%r8, %rsi
               	movl	-0x68(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movl	-0x68(%rbp), %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpl	%r8d, %edi
               	jne	<addr>
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$0xa, -0x60(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$0x6666666666666667, %rdx # imm = 0x6666666666666667
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	imulq	%r10
               	popq	%rax
               	sarq	$0x2, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rdx, %rsi
               	imulq	$0xa, %rsi, %rdx
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
               	movq	-0x60(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r8
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
               	xorl	%esi, %esi
               	movq	%rsi, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$-0x3e8, -0x58(%rbp)    # imm = 0xFC18
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$0x20c49ba5e353f7cf, %rdx # imm = 0x20C49BA5E353F7CF
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	imulq	%r10
               	popq	%rax
               	sarq	$0x7, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	movq	%rsi, %rdi
               	subq	%rdx, %rdi
               	imulq	$-0x3e8, %rdi, %rdx     # imm = 0xFC18
               	movq	%rcx, %r8
               	subq	%rdx, %r8
               	movq	-0x58(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	-0x58(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
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
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$0x1000, -0x50(%rbp)    # imm = 0x1000
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	shrq	$0x34, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	movq	%rsi, %rdi
               	sarq	$0xc, %rdi
               	andq	$0xfff, %rsi            # imm = 0xFFF
               	subq	%rdx, %rsi
               	movq	-0x50(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	-0x50(%rbp), %rdx
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
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%esi, %esi
               	movq	%rsi, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$-0x1, -0x48(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
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
               	xorl	%esi, %esi
               	movq	%rsi, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%rcx, -0x40(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	shrq	%rdx
               	leaq	(%rcx,%rdx), %rdi
               	movq	%rdi, %r8
               	sarq	$0x3f, %r8
               	movq	%rsi, %r9
               	subq	%r8, %r9
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%r11, %rdi
               	subq	%rdx, %rdi
               	movq	-0x40(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	-0x40(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%r8, %r9
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
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$0xa, -0x38(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rcx, %rdx
               	shrq	%rdx
               	movabsq	$0x6666666666666667, %rsi # imm = 0x6666666666666667
               	pushq	%rax
               	movq	%rdx, %rax
               	mulq	%rsi
               	popq	%rax
               	movq	%rdx, %rsi
               	shrq	%rsi
               	imulq	$0xa, %rsi, %rdx
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
               	movq	-0x38(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
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
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$0x7, -0x30(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$0x2492492492492493, %rdx # imm = 0x2492492492492493
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	mulq	%r10
               	popq	%rax
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	shrq	%rsi
               	addq	%rsi, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x2, %rsi
               	imulq	$0x7, %rsi, %rdx
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
               	movq	-0x30(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
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
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movabsq	$-0x7fffffffffffffff, %rcx # imm = 0x8000000000000001
               	movq	%rcx, -0x28(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
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
               	xorl	%edx, %edx
               	divq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
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
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$0x64, -0x20(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$-0x5c28f5c28f5c28f5, %rdx # imm = 0xA3D70A3D70A3D70B
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	imulq	%r10
               	popq	%rax
               	addq	%rcx, %rdx
               	sarq	$0x6, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rdx, %rsi
               	imulq	$0x64, %rsi, %rdx
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
               	movq	-0x20(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	-0x20(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
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
               	xorl	%esi, %esi
               	movq	%rsi, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$-0x3, -0x18(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$0x5555555555555556, %rdx # imm = 0x5555555555555556
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	imulq	%r10
               	popq	%rax
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	movq	%rsi, %rdi
               	subq	%rdx, %rdi
               	imulq	$-0x3, %rdi, %rdx
               	movq	%rcx, %r8
               	subq	%rdx, %r8
               	movq	-0x18(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	-0x18(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
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
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$0x64, -0x10(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rcx, %rdx
               	shrq	$0x2, %rdx
               	movabsq	$0x28f5c28f5c28f5c3, %rsi # imm = 0x28F5C28F5C28F5C3
               	pushq	%rax
               	movq	%rdx, %rax
               	mulq	%rsi
               	popq	%rax
               	movq	%rdx, %rsi
               	shrq	$0x2, %rsi
               	imulq	$0x64, %rsi, %rdx
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
               	movq	-0x10(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	-0x10(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
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
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$0x7, -0x8(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$0x2492492492492493, %rdx # imm = 0x2492492492492493
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	mulq	%r10
               	popq	%rax
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	shrq	%rsi
               	addq	%rsi, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x2, %rsi
               	imulq	$0x7, %rsi, %rdx
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
               	movq	-0x8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	-0x8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
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
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
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
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0x3, -0xa8(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movsbq	%cl, %rcx
               	imulq	$0x55555556, %rcx, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rdx
               	leaq	(%rdx,%rdx,2), %rdi
               	movq	%rcx, %rsi
               	subq	%rdi, %rsi
               	movslq	-0xa8(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movsbq	%dil, %r8
               	movslq	-0xa8(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movsbq	%cl, %rdi
               	cmpl	%r8d, %edx
               	jne	<addr>
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%r8d, %r8d
               	movq	%r8, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0xfffffffb, -0xa0(%rbp) # imm = 0xFFFFFFFB
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movsbq	%cl, %rcx
               	imulq	$0x66666667, %rcx, %rdx # imm = 0x66666667
               	sarq	$0x21, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rdx, %rsi
               	movq	%r8, %rdx
               	subq	%rsi, %rdx
               	imulq	$-0x5, %rdx, %rdi
               	movq	%rcx, %rsi
               	subq	%rdi, %rsi
               	movslq	-0xa0(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movsbq	%dil, %r9
               	movslq	-0xa0(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movsbq	%cl, %rdi
               	cmpl	%r9d, %edx
               	jne	<addr>
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%esi, %esi
               	movq	%rsi, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0xffffffff, -0x98(%rbp) # imm = 0xFFFFFFFF
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movsbq	%cl, %rcx
               	movq	%rsi, %rdx
               	subq	%rcx, %rdx
               	movsbq	%dl, %rdi
               	movslq	-0x98(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movsbq	%dl, %r8
               	movslq	-0x98(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movsbq	%cl, %rdx
               	cmpl	%r8d, %edi
               	jne	<addr>
               	testq	%rdx, %rdx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x3, -0x90(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	andq	$0xff, %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	leaq	(%rdx,%rdx,2), %rdi
               	movq	%rax, %rsi
               	subq	%rdi, %rsi
               	movslq	-0x90(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	%rdi, %r8
               	andq	$0xff, %r8
               	movslq	-0x90(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r8d, %edx
               	jne	<addr>
               	andq	$0xff, %rax
               	cmpl	%eax, %esi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x10, -0x88(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	andq	$0xff, %rax
               	movq	%rax, %rdi
               	shrq	$0x4, %rdi
               	movq	%rax, %rdx
               	andq	$0xf, %rdx
               	movslq	-0x88(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rsi, %r8
               	andq	$0xff, %r8
               	movslq	-0x88(%rbp), %rsi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r8d, %edi
               	jne	<addr>
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
               	xorl	%edi, %edi
               	movq	%rdi, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0xfffffff9, -0x80(%rbp) # imm = 0xFFFFFFF9
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	andq	$0xff, %rax
               	movl	$0x92492493, %edx       # imm = 0x92492493
               	imulq	%rax, %rdx
               	sarq	$0x22, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rdx, %rsi
               	movq	%rdi, %rdx
               	subq	%rsi, %rdx
               	movq	%rdx, %r8
               	andq	$0xff, %r8
               	imulq	$-0x7, %rdx, %rsi
               	movq	%rax, %rdx
               	subq	%rsi, %rdx
               	movslq	-0x80(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rsi, %r9
               	andq	$0xff, %r9
               	movslq	-0x80(%rbp), %rsi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %r8d
               	jne	<addr>
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
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0xa, -0x78(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movswq	%cx, %rcx
               	imulq	$0x66666667, %rcx, %rdx # imm = 0x66666667
               	sarq	$0x22, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rdx
               	imulq	$0xa, %rdx, %rdi
               	movq	%rcx, %rsi
               	subq	%rdi, %rsi
               	movslq	-0x78(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movswq	%di, %r8
               	movslq	-0x78(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movswq	%cx, %rdi
               	cmpl	%r8d, %edx
               	jne	<addr>
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%esi, %esi
               	movq	%rsi, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0xffffffff, -0x70(%rbp) # imm = 0xFFFFFFFF
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movswq	%cx, %rcx
               	movq	%rsi, %rdx
               	subq	%rcx, %rdx
               	movswq	%dx, %rdi
               	movslq	-0x70(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movswq	%dx, %r8
               	movslq	-0x70(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movswq	%cx, %rdx
               	cmpl	%r8d, %edi
               	jne	<addr>
               	testq	%rdx, %rdx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x3e8, -0x68(%rbp)     # imm = 0x3E8
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	imulq	$0x418938, %rax, %rdx   # imm = 0x418938
               	shrq	$0x20, %rdx
               	imulq	$0x3e8, %rdx, %rdi      # imm = 0x3E8
               	movq	%rax, %rsi
               	subq	%rdi, %rsi
               	movslq	-0x68(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	%rdi, %r8
               	andq	$0xffff, %r8            # imm = 0xFFFF
               	movslq	-0x68(%rbp), %rdi
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r8d, %edx
               	jne	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	%eax, %esi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x7, -0x60(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	imulq	$0x24924925, %rax, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	imulq	$0x7, %rdx, %rdi
               	movq	%rax, %rsi
               	subq	%rdi, %rsi
               	movl	-0x60(%rbp), %edi
               	pushq	%rax
               	pushq	%rdx
               	xorl	%edx, %edx
               	divq	%rdi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movl	-0x60(%rbp), %edi
               	pushq	%rdx
               	xorl	%edx, %edx
               	divq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r8d, %edx
               	jne	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	%eax, %esi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0x3, -0x58(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, %edx
               	movl	$0xaaaaaaab, %edi       # imm = 0xAAAAAAAB
               	imulq	%rdx, %rdi
               	movq	%rdi, %rsi
               	shrq	$0x21, %rsi
               	leaq	(%rsi,%rsi,2), %r8
               	movq	%rdx, %rdi
               	subq	%r8, %rdi
               	movl	-0x58(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movl	-0x58(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
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
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x80000000, -0x50(%rbp) # imm = 0x80000000
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movl	%eax, %edx
               	movq	%rdx, %r8
               	shrq	$0x1f, %r8
               	movq	%rax, %rsi
               	andq	$0x7fffffff, %rsi       # imm = 0x7FFFFFFF
               	movl	-0x50(%rbp), %edi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movl	-0x50(%rbp), %edi
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	cmpl	%eax, %esi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$0x3, -0x48(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movslq	%ecx, %rcx
               	imulq	$0x55555556, %rcx, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rdx
               	leaq	(%rdx,%rdx,2), %rdi
               	movq	%rcx, %rsi
               	subq	%rdi, %rsi
               	movq	-0x48(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	-0x48(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpl	%r8d, %edx
               	jne	<addr>
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movabsq	$0x100000000, %rcx      # imm = 0x100000000
               	movq	%rcx, -0x40(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movslq	%ecx, %rcx
               	movq	-0x40(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movq	-0x40(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	testl	%edx, %edx
               	jne	<addr>
               	cmpl	%esi, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$0x7, -0x38(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movslq	%ecx, %rcx
               	movabsq	$0x2492492492492493, %rdx # imm = 0x2492492492492493
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	mulq	%r10
               	popq	%rax
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	shrq	%rsi
               	addq	%rsi, %rdx
               	shrq	$0x2, %rdx
               	imulq	$0x7, %rdx, %rdi
               	movq	%rcx, %rsi
               	subq	%rdi, %rsi
               	movq	-0x38(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	-0x38(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpl	%r8d, %edx
               	jne	<addr>
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$0x7, -0x30(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, %edx
               	imulq	$0x24924925, %rdx, %rdi # imm = 0x24924925
               	movq	%rdi, %rsi
               	shrq	$0x20, %rsi
               	movq	%rdx, %r8
               	subq	%rsi, %r8
               	movq	%r8, %r9
               	shrq	%r9
               	leaq	(%r9,%rsi), %rbx
               	movq	%rbx, %r12
               	shrq	$0x2, %r12
               	movq	%rbx, %rsi
               	shrq	$0x2, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rdx
               	movl	%ecx, %esi
               	movq	-0x30(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	-0x30(%rbp), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpl	%edi, %r12d
               	jne	<addr>
               	cmpl	%ecx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%esi, %esi
               	movq	%rsi, %rax
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
               	movq	%r9, %rdx
               	sarq	%rdx
               	movq	%rdx, %rbx
               	shrq	$0x3f, %rbx
               	addq	%rdx, %rbx
               	negq	%rbx
               	addq	%rsi, %rbx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rdx
               	movq	%rsi, %r8
               	subq	%rdx, %r8
               	imulq	$-0x7, %r8, %r8
               	movq	%rdi, %rdx
               	subq	%r8, %rdx
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
               	cmpl	%r8d, %ebx
               	jne	<addr>
               	cmpl	%ecx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$0xa, -0x20(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, %edx
               	movq	%rdx, %rdi
               	shrq	%rdi
               	imulq	$0x66666667, %rdi, %r8  # imm = 0x66666667
               	movq	%r8, %rsi
               	shrq	$0x21, %rsi
               	imulq	$0xa, %rsi, %r8
               	movq	%rdx, %rdi
               	subq	%r8, %rdi
               	movq	-0x20(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	-0x20(%rbp), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpl	%r8d, %esi
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
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$0x9, -0x18(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movswq	%cx, %rcx
               	movabsq	$-0x1c71c71c71c71c71, %rdx # imm = 0xE38E38E38E38E38F
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	mulq	%r10
               	popq	%rax
               	shrq	$0x3, %rdx
               	movswq	%dx, %rdi
               	leaq	(%rdx,%rdx,8), %rsi
               	movq	%rcx, %rdx
               	subq	%rsi, %rdx
               	movq	-0x18(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movswq	%si, %r8
               	movq	-0x18(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movswq	%cx, %rsi
               	cmpl	%r8d, %edi
               	jne	<addr>
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%esi, %esi
               	movq	%rsi, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0xfffffff6, -0x10(%rbp) # imm = 0xFFFFFFF6
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$0x6666666666666667, %rdx # imm = 0x6666666666666667
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	imulq	%r10
               	popq	%rax
               	sarq	$0x2, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	movq	%rsi, %rdi
               	subq	%rdx, %rdi
               	imulq	$-0xa, %rdi, %rdx
               	movq	%rcx, %r8
               	subq	%rdx, %r8
               	movslq	-0x10(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movslq	-0x10(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
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
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0xa, -0x8(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rcx, %rdx
               	shrq	%rdx
               	movabsq	$0x6666666666666667, %rsi # imm = 0x6666666666666667
               	pushq	%rax
               	movq	%rdx, %rax
               	mulq	%rsi
               	popq	%rax
               	movq	%rdx, %rsi
               	shrq	%rsi
               	imulq	$0xa, %rsi, %rdx
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
               	movslq	-0x8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movslq	-0x8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
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
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<places>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x98, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdx
               	movl	%edx, -0x28(%rbp)
               	movq	(%rcx,%rax,8), %rdx
               	movl	%edx, -0x20(%rbp)
               	movl	$0xa, -0x18(%rbp)
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
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
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
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	leaq	-0x88(%rbp), %rcx
               	movslq	(%rcx,%rax,4), %rdi
               	imulq	$0x38e38e39, %rdi, %rdi # imm = 0x38E38E39
               	sarq	$0x21, %rdi
               	movq	%rdi, %r8
               	shrq	$0x3f, %r8
               	addq	%rdi, %r8
               	movq	%rsi, %rdi
               	subq	%r8, %rdi
               	movl	%edi, (%rcx,%rax,4)
               	cmpl	%edx, %edi
               	jne	<addr>
               	movslq	(%rcx,%rax,4), %rdi
               	cmpl	%edx, %edi
               	jne	<addr>
               	movslq	%edx, %rdi
               	movslq	-0x10(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rdi, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	movslq	(%rcx,%rax,4), %rdi
               	imulq	$0x38e38e39, %rdi, %r8  # imm = 0x38E38E39
               	sarq	$0x21, %r8
               	movq	%r8, %r9
               	shrq	$0x3f, %r9
               	addq	%r9, %r8
               	xorl	%r9d, %r9d
               	subq	%r8, %r9
               	imulq	$-0x9, %r9, %r8
               	subq	%r8, %rdi
               	movl	%edi, (%rcx,%rax,4)
               	movq	%rdi, %rcx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0x3, -0x8(%rbp)
               	leaq	-0x90(%rbp), %rdx
               	leaq	-0x30(%rbp), %rsi
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdi
               	movq	%rdi, %r8
               	andq	$0x7ff, %r8             # imm = 0x7FF
               	movl	(%rsi), %edi
               	andq	$-0x800, %rdi           # imm = 0xF800
               	orq	%r8, %rdi
               	movl	%edi, (%rsi)
               	shlq	$0x35, %r8
               	sarq	$0x35, %r8
               	movq	%r8, %r9
               	andq	$0x7ff, %r9             # imm = 0x7FF
               	movl	(%rdx), %r8d
               	andq	$-0x800, %r8            # imm = 0xF800
               	orq	%r9, %r8
               	movl	%r8d, (%rdx)
               	movq	(%rcx,%rax,8), %r9
               	andq	$0x1fff, %r9            # imm = 0x1FFF
               	movq	%rdi, %rbx
               	andq	$-0xfff801, %rbx        # imm = 0xFF0007FF
               	movq	%r9, %rdi
               	shlq	$0xb, %rdi
               	movq	%rbx, %r9
               	orq	%rdi, %r9
               	movl	%r9d, (%rsi)
               	movq	%r8, %rsi
               	andq	$-0xfff801, %rsi        # imm = 0xFF0007FF
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
               	movq	(%rdx), %rdi
               	andq	$0xffffff, %rdi         # imm = 0xFFFFFF
               	shlq	$0x18, %rcx
               	orq	%rcx, %rdi
               	movq	%rdi, (%rdx)
               	movl	(%rdx), %ecx
               	movq	%rcx, %rdi
               	andq	$0x7ff, %rdi            # imm = 0x7FF
               	shlq	$0x35, %rdi
               	sarq	$0x35, %rdi
               	imulq	$0x55555556, %rdi, %rdi # imm = 0x55555556
               	sarq	$0x20, %rdi
               	movq	%rdi, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rdi
               	andq	$0x7ff, %rdi            # imm = 0x7FF
               	andq	$-0x800, %rcx           # imm = 0xF800
               	orq	%rdi, %rcx
               	movl	%ecx, (%rdx)
               	leaq	-0x30(%rbp), %rdi
               	movl	(%rdi), %edx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	shlq	$0x35, %rdx
               	sarq	$0x35, %rdx
               	movslq	-0x8(%rbp), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movq	%rdx, %r8
               	andq	$0x7ff, %r8             # imm = 0x7FF
               	movl	(%rsi), %edx
               	andq	$-0x800, %rdx           # imm = 0xF800
               	orq	%r8, %rdx
               	movl	%edx, (%rsi)
               	leaq	-0x90(%rbp), %rsi
               	movl	%ecx, %r8d
               	sarq	$0xb, %r8
               	andq	$0x1fff, %r8            # imm = 0x1FFF
               	imulq	$0x55555556, %r8, %r8   # imm = 0x55555556
               	shrq	$0x20, %r8
               	andq	$-0xfff801, %rcx        # imm = 0xFF0007FF
               	shlq	$0xb, %r8
               	orq	%r8, %rcx
               	movl	%ecx, (%rsi)
               	movl	%edx, %ecx
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
               	andq	$-0xfff801, %rdx        # imm = 0xFF0007FF
               	shlq	$0xb, %rcx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rdi)
               	movq	(%rsi), %rcx
               	movq	%rcx, %rdx
               	sarq	$0x18, %rdx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdx
               	shlq	$0x18, %rdx
               	sarq	$0x18, %rdx
               	movabsq	$0x5555555555555556, %rdi # imm = 0x5555555555555556
               	pushq	%rax
               	movq	%rdx, %rax
               	imulq	%rdi
               	popq	%rax
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdx
               	movq	%rcx, %rdi
               	andq	$0xffffff, %rdi         # imm = 0xFFFFFF
               	movq	%rdx, %rcx
               	shlq	$0x18, %rcx
               	movq	%rdi, %rdx
               	orq	%rcx, %rdx
               	movq	%rdx, (%rsi)
               	leaq	-0x30(%rbp), %rcx
               	movq	(%rcx), %rsi
               	movq	%rsi, %rdi
               	sarq	$0x18, %rdi
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdi
               	shlq	$0x18, %rdi
               	sarq	$0x18, %rdi
               	movslq	-0x8(%rbp), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdi
               	movq	%rsi, %r8
               	andq	$0xffffff, %r8          # imm = 0xFFFFFF
               	movq	%rdi, %rsi
               	shlq	$0x18, %rsi
               	movq	%r8, %rdi
               	orq	%rsi, %rdi
               	movq	%rdi, (%rcx)
               	leaq	-0x90(%rbp), %rsi
               	movl	(%rsi), %r8d
               	andq	$0x7ff, %r8             # imm = 0x7FF
               	shlq	$0x35, %r8
               	sarq	$0x35, %r8
               	movl	(%rcx), %r9d
               	andq	$0x7ff, %r9             # imm = 0x7FF
               	shlq	$0x35, %r9
               	sarq	$0x35, %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	movl	(%rsi), %esi
               	sarq	$0xb, %rsi
               	andq	$0x1fff, %rsi           # imm = 0x1FFF
               	movl	(%rcx), %ecx
               	sarq	$0xb, %rcx
               	andq	$0x1fff, %rcx           # imm = 0x1FFF
               	cmpl	%ecx, %esi
               	jne	<addr>
               	movq	%rdx, %rcx
               	sarq	$0x18, %rcx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rcx
               	shlq	$0x18, %rcx
               	sarq	$0x18, %rcx
               	movq	%rdi, %rdx
               	sarq	$0x18, %rdx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdx
               	shlq	$0x18, %rdx
               	sarq	$0x18, %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	leaq	-0x90(%rbp), %rdx
               	leaq	-0x30(%rbp), %rsi
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdi
               	movq	%rdi, %r8
               	andq	$0x7ff, %r8             # imm = 0x7FF
               	movl	(%rsi), %edi
               	andq	$-0x800, %rdi           # imm = 0xF800
               	orq	%r8, %rdi
               	movl	%edi, (%rsi)
               	shlq	$0x35, %r8
               	sarq	$0x35, %r8
               	movq	%r8, %r9
               	andq	$0x7ff, %r9             # imm = 0x7FF
               	movl	(%rdx), %r8d
               	andq	$-0x800, %r8            # imm = 0xF800
               	orq	%r9, %r8
               	movl	%r8d, (%rdx)
               	movq	(%rcx,%rax,8), %r9
               	andq	$0x1fff, %r9            # imm = 0x1FFF
               	movq	%rdi, %rbx
               	andq	$-0xfff801, %rbx        # imm = 0xFF0007FF
               	movq	%r9, %rdi
               	shlq	$0xb, %rdi
               	movq	%rbx, %r9
               	orq	%rdi, %r9
               	movl	%r9d, (%rsi)
               	movq	%r8, %rsi
               	andq	$-0xfff801, %rsi        # imm = 0xFF0007FF
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
               	movq	(%rdx), %rdi
               	andq	$0xffffff, %rdi         # imm = 0xFFFFFF
               	shlq	$0x18, %rcx
               	orq	%rcx, %rdi
               	movq	%rdi, (%rdx)
               	movl	(%rdx), %ecx
               	movq	%rcx, %rdi
               	andq	$0x7ff, %rdi            # imm = 0x7FF
               	shlq	$0x35, %rdi
               	sarq	$0x35, %rdi
               	imulq	$0x55555556, %rdi, %r8  # imm = 0x55555556
               	sarq	$0x20, %r8
               	movq	%r8, %r9
               	shrq	$0x3f, %r9
               	addq	%r9, %r8
               	leaq	(%r8,%r8,2), %r8
               	subq	%r8, %rdi
               	andq	$0x7ff, %rdi            # imm = 0x7FF
               	andq	$-0x800, %rcx           # imm = 0xF800
               	orq	%rdi, %rcx
               	movl	%ecx, (%rdx)
               	leaq	-0x30(%rbp), %rdi
               	movl	(%rdi), %edx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	shlq	$0x35, %rdx
               	movq	%rdx, %r8
               	sarq	$0x35, %r8
               	movslq	-0x8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%r8, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	movq	%rdx, %r8
               	andq	$0x7ff, %r8             # imm = 0x7FF
               	movl	(%rsi), %edx
               	andq	$-0x800, %rdx           # imm = 0xF800
               	orq	%r8, %rdx
               	movl	%edx, (%rsi)
               	leaq	-0x90(%rbp), %rsi
               	movl	%ecx, %r8d
               	sarq	$0xb, %r8
               	andq	$0x1fff, %r8            # imm = 0x1FFF
               	imulq	$0x55555556, %r8, %r9   # imm = 0x55555556
               	shrq	$0x20, %r9
               	leaq	(%r9,%r9,2), %r9
               	subq	%r9, %r8
               	andq	$-0xfff801, %rcx        # imm = 0xFF0007FF
               	shlq	$0xb, %r8
               	orq	%r8, %rcx
               	movl	%ecx, (%rsi)
               	movl	%edx, %ecx
               	sarq	$0xb, %rcx
               	movq	%rcx, %r8
               	andq	$0x1fff, %r8            # imm = 0x1FFF
               	movslq	-0x8(%rbp), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	andq	$0x1fff, %rcx           # imm = 0x1FFF
               	andq	$-0xfff801, %rdx        # imm = 0xFF0007FF
               	shlq	$0xb, %rcx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rdi)
               	leaq	-0x90(%rbp), %rdi
               	movq	(%rdi), %rcx
               	sarq	$0x18, %rcx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rcx
               	shlq	$0x18, %rcx
               	sarq	$0x18, %rcx
               	movabsq	$0x5555555555555556, %rdx # imm = 0x5555555555555556
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	imulq	%r10
               	popq	%rax
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rcx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rcx
               	movq	(%rsi), %rdx
               	andq	$0xffffff, %rdx         # imm = 0xFFFFFF
               	shlq	$0x18, %rcx
               	movq	%rdx, %r8
               	orq	%rcx, %r8
               	movq	%r8, (%rsi)
               	leaq	-0x30(%rbp), %rcx
               	movq	(%rcx), %rsi
               	movq	%rsi, %rdx
               	sarq	$0x18, %rdx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdx
               	shlq	$0x18, %rdx
               	movq	%rdx, %r9
               	sarq	$0x18, %r9
               	movslq	-0x8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%r9, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdx
               	andq	$0xffffff, %rsi         # imm = 0xFFFFFF
               	shlq	$0x18, %rdx
               	orq	%rdx, %rsi
               	movq	%rsi, (%rcx)
               	movl	(%rdi), %edx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	shlq	$0x35, %rdx
               	sarq	$0x35, %rdx
               	movl	(%rcx), %ecx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	shlq	$0x35, %rcx
               	sarq	$0x35, %rcx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	leaq	-0x90(%rbp), %rcx
               	movl	(%rcx), %ecx
               	sarq	$0xb, %rcx
               	andq	$0x1fff, %rcx           # imm = 0x1FFF
               	leaq	-0x30(%rbp), %rdx
               	movl	(%rdx), %edx
               	sarq	$0xb, %rdx
               	andq	$0x1fff, %rdx           # imm = 0x1FFF
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movq	%r8, %rcx
               	sarq	$0x18, %rcx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rcx
               	shlq	$0x18, %rcx
               	sarq	$0x18, %rcx
               	movq	%rsi, %rdx
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
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
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
