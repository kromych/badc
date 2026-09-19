
strength_reduce_inlined_divmod.x64:	file format elf64-x86-64

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
               	movl	$0x80000000, %ecx       # imm = 0x80000000
               	movq	%rcx, 0x50(%rax)
               	movq	$0x7f, 0x58(%rax)
               	movq	$-0x80, 0x60(%rax)
               	movq	$0xff, 0x68(%rax)
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

<ints>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0xa, %r8d
               	movl	%r8d, -0xa8(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movslq	%ecx, %rcx
               	imulq	$0x66666667, %rcx, %r9  # imm = 0x66666667
               	movq	%r9, %rsi
               	sarq	$0x22, %rsi
               	movq	%rsi, %rbx
               	shrq	$0x3f, %rbx
               	leaq	(%rsi,%rbx), %rdi
               	movslq	-0xa8(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rdi
               	jne	<addr>
               	movq	%rdi, %rsi
               	imulq	%r8, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movslq	%edi, %rdi
               	movslq	-0xa8(%rbp), %rsi
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
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0x7, %r8d
               	movl	%r8d, -0xa0(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movslq	%ecx, %rcx
               	movl	$0x92492493, %r9d       # imm = 0x92492493
               	imulq	%rcx, %r9
               	movq	%r9, %rsi
               	sarq	$0x22, %rsi
               	movq	%rsi, %rbx
               	shrq	$0x3f, %rbx
               	leaq	(%rsi,%rbx), %rdi
               	movslq	-0xa0(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rdi
               	jne	<addr>
               	movq	%rdi, %rsi
               	imulq	%r8, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movslq	%edi, %rdi
               	movslq	-0xa0(%rbp), %rsi
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
               	movq	$-0x7, %r8
               	movl	%r8d, -0x98(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movslq	%ecx, %rcx
               	movl	$0x92492493, %r9d       # imm = 0x92492493
               	imulq	%rcx, %r9
               	movq	%r9, %rsi
               	sarq	$0x22, %rsi
               	movq	%rsi, %rbx
               	shrq	$0x3f, %rbx
               	leaq	(%rsi,%rbx), %r12
               	negq	%r12
               	addq	%rdi, %r12
               	movslq	-0x98(%rbp), %r13
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
               	xorl	%r9d, %r9d
               	subq	%rsi, %r9
               	movq	%r9, %rsi
               	imulq	%r8, %rsi
               	movq	%rcx, %r8
               	subq	%rsi, %r8
               	movslq	%r8d, %r8
               	movslq	-0x98(%rbp), %rsi
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
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0x1, -0x90(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movslq	%ecx, %rcx
               	movslq	-0x90(%rbp), %rsi
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
               	movq	%rcx, %rsi
               	shlq	$0x0, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movslq	%edi, %rdi
               	movslq	-0x90(%rbp), %rsi
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
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%edi, %edi
               	movq	%rdi, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$-0x1, %rsi
               	movl	%esi, -0x88(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rax
               	cmpl	$0x80000000, %eax       # imm = 0x80000000
               	je	<addr>
               	movq	%rdi, %r8
               	subq	%rax, %r8
               	movslq	-0x88(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	xorl	%r8d, %r8d
               	subq	%rax, %r8
               	imulq	%r8, %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movslq	%r8d, %r8
               	movslq	-0x88(%rbp), %rsi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %r8
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
               	movl	$0x2, -0x80(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	shrq	$0x3f, %rdi
               	leaq	(%rax,%rdi), %r8
               	movq	%r8, %rsi
               	sarq	%rsi
               	movslq	-0x80(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpq	%r9, %rsi
               	jne	<addr>
               	shlq	%rsi
               	movq	%rax, %rdi
               	subq	%rsi, %rdi
               	movslq	%edi, %rdi
               	movslq	-0x80(%rbp), %rsi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%edi, %edi
               	movq	%rdi, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$-0x2, %rsi
               	movl	%esi, -0x78(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rax,%r8), %r9
               	movq	%r9, %rbx
               	sarq	%rbx
               	movq	%rdi, %r12
               	subq	%rbx, %r12
               	movslq	-0x78(%rbp), %r13
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r13
               	movq	%rax, %r13
               	popq	%rdx
               	popq	%rax
               	cmpq	%r13, %r12
               	jne	<addr>
               	xorl	%r8d, %r8d
               	subq	%rbx, %r8
               	imulq	%r8, %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movslq	%r8d, %r8
               	movslq	-0x78(%rbp), %rsi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %r8
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
               	movl	$0x400, -0x70(%rbp)     # imm = 0x400
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	shrq	$0x36, %rdi
               	leaq	(%rax,%rdi), %r8
               	movq	%r8, %rsi
               	sarq	$0xa, %rsi
               	movslq	-0x70(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpq	%r9, %rsi
               	jne	<addr>
               	shlq	$0xa, %rsi
               	movq	%rax, %rdi
               	subq	%rsi, %rdi
               	movslq	%edi, %rdi
               	movslq	-0x70(%rbp), %rsi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
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
               	movl	$0x7fffffff, %r8d       # imm = 0x7FFFFFFF
               	movl	%r8d, -0x68(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movslq	%ecx, %rcx
               	imulq	$0x40000001, %rcx, %r9  # imm = 0x40000001
               	movq	%r9, %rsi
               	sarq	$0x3d, %rsi
               	movq	%rsi, %rbx
               	shrq	$0x3f, %rbx
               	leaq	(%rsi,%rbx), %rdi
               	movslq	-0x68(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rdi
               	jne	<addr>
               	movq	%rdi, %rsi
               	imulq	%r8, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movslq	%edi, %rdi
               	movslq	-0x68(%rbp), %rsi
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
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%edi, %edi
               	movq	%rdi, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$-0x80000000, %rsi      # imm = 0x80000000
               	movl	%esi, -0x60(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	shrq	$0x21, %r8
               	leaq	(%rax,%r8), %r9
               	movq	%r9, %rbx
               	sarq	$0x1f, %rbx
               	movq	%rdi, %r12
               	subq	%rbx, %r12
               	movslq	-0x60(%rbp), %r13
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r13
               	movq	%rax, %r13
               	popq	%rdx
               	popq	%rax
               	cmpq	%r13, %r12
               	jne	<addr>
               	xorl	%r8d, %r8d
               	subq	%rbx, %r8
               	imulq	%r8, %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movslq	%r8d, %r8
               	movslq	-0x60(%rbp), %rsi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%edi, %edi
               	movq	%rdi, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$-0x7fffffff, %r8       # imm = 0x80000001
               	movl	%r8d, -0x58(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movslq	%ecx, %rcx
               	imulq	$0x40000001, %rcx, %r9  # imm = 0x40000001
               	movq	%r9, %rsi
               	sarq	$0x3d, %rsi
               	movq	%rsi, %rbx
               	shrq	$0x3f, %rbx
               	leaq	(%rsi,%rbx), %r12
               	negq	%r12
               	addq	%rdi, %r12
               	movslq	-0x58(%rbp), %r13
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
               	xorl	%r9d, %r9d
               	subq	%rsi, %r9
               	movq	%r9, %rsi
               	imulq	%r8, %rsi
               	movq	%rcx, %r8
               	subq	%rsi, %r8
               	movslq	%r8d, %r8
               	movslq	-0x58(%rbp), %rsi
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
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0xa, %edi
               	movl	%edi, -0x50(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, %esi
               	movq	%rsi, %r8
               	shrq	%r8
               	imulq	$0x66666667, %r8, %r9   # imm = 0x66666667
               	movq	%r9, %rbx
               	shrq	$0x21, %rbx
               	movl	-0x50(%rbp), %r12d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpl	%r12d, %ebx
               	jne	<addr>
               	movq	%r9, %r8
               	shrq	$0x21, %r8
               	imulq	%r8, %rdi
               	subq	%rdi, %rsi
               	movl	%esi, %edi
               	movl	%ecx, %esi
               	movl	-0x50(%rbp), %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
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
               	movl	$0x7, %r8d
               	movl	%r8d, -0x48(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, %esi
               	imulq	$0x24924925, %rsi, %r9  # imm = 0x24924925
               	movq	%r9, %rdi
               	shrq	$0x20, %rdi
               	movq	%rsi, %rbx
               	subq	%rdi, %rbx
               	shrq	%rbx
               	addq	%rdi, %rbx
               	shrq	$0x2, %rbx
               	movl	-0x48(%rbp), %r12d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpl	%r12d, %ebx
               	jne	<addr>
               	movq	%rsi, %r9
               	subq	%rdi, %r9
               	shrq	%r9
               	addq	%r9, %rdi
               	shrq	$0x2, %rdi
               	imulq	%r8, %rdi
               	subq	%rdi, %rsi
               	movl	%esi, %edi
               	movl	%ecx, %esi
               	movl	-0x48(%rbp), %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
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
               	movl	$0x1, -0x40(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, %esi
               	movl	-0x40(%rbp), %edi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpl	%edi, %esi
               	jne	<addr>
               	movq	%rsi, %rdi
               	shlq	$0x0, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movl	%r8d, %edi
               	movl	-0x40(%rbp), %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
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
               	movl	$0x40, -0x38(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, %esi
               	movq	%rsi, %rdi
               	shrq	$0x6, %rdi
               	movl	-0x38(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	cmpl	%r8d, %edi
               	jne	<addr>
               	shlq	$0x6, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movl	%r8d, %edi
               	movl	-0x38(%rbp), %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
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
               	movl	$0x80000000, -0x30(%rbp) # imm = 0x80000000
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, %esi
               	movq	%rsi, %rdi
               	shrq	$0x1f, %rdi
               	movl	-0x30(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	cmpl	%r8d, %edi
               	jne	<addr>
               	shlq	$0x1f, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movl	%r8d, %edi
               	movl	-0x30(%rbp), %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
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
               	movl	$0x80000001, %r8d       # imm = 0x80000001
               	movl	%r8d, -0x28(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, %esi
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	movq	%rsi, %rdi
               	cmpq	%r11, %rsi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	-0x28(%rbp), %r9d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpl	%r9d, %edi
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movl	%r8d, %edi
               	movl	-0x28(%rbp), %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
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
               	movl	$0xfffffffe, %r8d       # imm = 0xFFFFFFFE
               	movl	%r8d, -0x20(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, %esi
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	movq	%rsi, %rdi
               	cmpq	%r11, %rsi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	-0x20(%rbp), %r9d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpl	%r9d, %edi
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movl	%r8d, %edi
               	movl	-0x20(%rbp), %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
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
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	movl	%r8d, -0x18(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, %esi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rsi, %rdi
               	cmpq	%r11, %rsi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	-0x18(%rbp), %r9d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpl	%r9d, %edi
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movl	%r8d, %edi
               	movl	-0x18(%rbp), %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
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
               	movl	$0xfffffffd, -0x10(%rbp) # imm = 0xFFFFFFFD
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, %esi
               	movl	$0xfffffffd, %r11d      # imm = 0xFFFFFFFD
               	movq	%rsi, %rdi
               	cmpq	%r11, %rsi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	-0x10(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	cmpl	%r8d, %edi
               	jne	<addr>
               	movl	$0xfffffffd, %r8d       # imm = 0xFFFFFFFD
               	imulq	%r8, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movl	%r8d, %edi
               	movl	-0x10(%rbp), %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
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
               	movl	$0xffffffff, -0x8(%rbp) # imm = 0xFFFFFFFF
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, %esi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rsi, %rdi
               	cmpq	%r11, %rsi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	-0x8(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	cmpl	%r8d, %edi
               	jne	<addr>
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	imulq	%r8, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movl	%r8d, %edi
               	movl	-0x8(%rbp), %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<wides>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0xa, %edi
               	movq	%rdi, -0xb0(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rsi
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$0x6666666666666667, %r8 # imm = 0x6666666666666667
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%r8
               	movq	%rdx, %r9
               	popq	%rdx
               	popq	%rax
               	movq	%r9, %rsi
               	sarq	$0x2, %rsi
               	movq	%rsi, %rbx
               	shrq	$0x3f, %rbx
               	leaq	(%rsi,%rbx), %r12
               	movq	-0xb0(%rbp), %r13
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
               	imulq	%rdi, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movq	-0xb0(%rbp), %rsi
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
               	movq	$-0x3e8, %r8            # imm = 0xFC18
               	movq	%r8, -0xa8(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rsi
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$0x20c49ba5e353f7cf, %r9 # imm = 0x20C49BA5E353F7CF
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%r9
               	movq	%rdx, %rbx
               	popq	%rdx
               	popq	%rax
               	movq	%rbx, %rsi
               	sarq	$0x7, %rsi
               	movq	%rsi, %r12
               	shrq	$0x3f, %r12
               	addq	%rsi, %r12
               	negq	%r12
               	addq	%rdi, %r12
               	movq	-0xa8(%rbp), %r13
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
               	movq	%rsi, %r9
               	shrq	$0x3f, %r9
               	addq	%r9, %rsi
               	xorl	%r9d, %r9d
               	subq	%rsi, %r9
               	movq	%r9, %rsi
               	imulq	%r8, %rsi
               	movq	%rcx, %r8
               	subq	%rsi, %r8
               	movq	-0xa8(%rbp), %rsi
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
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$0x1, -0xa0(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rsi
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	-0xa0(%rbp), %rsi
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
               	movq	%rcx, %rsi
               	shlq	$0x0, %rsi
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
               	movq	$-0x1, %rsi
               	movq	%rsi, -0x98(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%rcx, %r8
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rdi, %r8
               	subq	%rcx, %r8
               	movq	-0x98(%rbp), %r9
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
               	xorl	%r8d, %r8d
               	subq	%rcx, %r8
               	imulq	%r8, %rsi
               	movq	%rcx, %r8
               	subq	%rsi, %r8
               	movq	-0x98(%rbp), %rsi
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
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$0x1000, -0x90(%rbp)    # imm = 0x1000
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rsi
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rcx, %rsi
               	sarq	$0x3f, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x34, %rdi
               	leaq	(%rcx,%rdi), %r8
               	movq	%r8, %r9
               	sarq	$0xc, %r9
               	movq	-0x90(%rbp), %rbx
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
               	movq	%r9, %rsi
               	shlq	$0xc, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x90(%rbp), %rsi
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
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movabsq	$0x100000001, %rdi      # imm = 0x100000001
               	movq	%rdi, -0x88(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rsi
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$0x7fffffff80000001, %r8 # imm = 0x7FFFFFFF80000001
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%r8
               	movq	%rdx, %r9
               	popq	%rdx
               	popq	%rax
               	movq	%r9, %rsi
               	sarq	$0x1f, %rsi
               	movq	%rsi, %rbx
               	shrq	$0x3f, %rbx
               	leaq	(%rsi,%rbx), %r12
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
               	addq	%rbx, %rsi
               	imulq	%rdi, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x88(%rbp), %rsi
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
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movabsq	$0x7fffffffffffffff, %rdi # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rdi, -0x80(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rsi
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$0x4000000000000001, %r8 # imm = 0x4000000000000001
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%r8
               	movq	%rdx, %r9
               	popq	%rdx
               	popq	%rax
               	movq	%r9, %rsi
               	sarq	$0x3d, %rsi
               	movq	%rsi, %rbx
               	shrq	$0x3f, %rbx
               	leaq	(%rsi,%rbx), %r12
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
               	addq	%rbx, %rsi
               	imulq	%rdi, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x80(%rbp), %rsi
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
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%edi, %edi
               	movq	%rdi, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	movq	%rsi, -0x78(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rax, %r8
               	cmpq	%r11, %rax
               	je	<addr>
               	movq	%rax, %r8
               	sarq	$0x3f, %r8
               	movq	%r8, %r9
               	shrq	%r9
               	leaq	(%rax,%r9), %rbx
               	movq	%rbx, %r12
               	sarq	$0x3f, %r12
               	negq	%r12
               	addq	%rdi, %r12
               	movq	-0x78(%rbp), %r13
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r13
               	movq	%rax, %r13
               	popq	%rdx
               	popq	%rax
               	cmpq	%r13, %r12
               	jne	<addr>
               	movq	%rbx, %r8
               	sarq	$0x3f, %r8
               	xorl	%r9d, %r9d
               	subq	%r8, %r9
               	imulq	%r9, %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movq	-0x78(%rbp), %rsi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %r8
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
               	movl	$0xa, %esi
               	movq	%rsi, -0x70(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rdi
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rcx, %rdi
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
               	movq	-0x70(%rbp), %r12
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
               	imulq	%rbx, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x70(%rbp), %rsi
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
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0x7, %edi
               	movq	%rdi, -0x68(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rsi
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$0x2492492492492493, %r8 # imm = 0x2492492492492493
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	mulq	%r8
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, %r9
               	subq	%rsi, %r9
               	movq	%r9, %rbx
               	shrq	%rbx
               	leaq	(%rbx,%rsi), %r12
               	shrq	$0x2, %r12
               	movq	-0x68(%rbp), %r13
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
               	addq	%rbx, %rsi
               	shrq	$0x2, %rsi
               	imulq	%rdi, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x68(%rbp), %rsi
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
               	movq	%rcx, -0x60(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rsi
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rcx, %rsi
               	shrq	$0x20, %rsi
               	movq	-0x60(%rbp), %rdi
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
               	shlq	$0x20, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x60(%rbp), %rsi
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
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	movq	%rsi, -0x58(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rdi
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rcx, %rdi
               	shrq	$0x3f, %rdi
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
               	imulq	%rdi, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x58(%rbp), %rsi
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
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movabsq	$-0x7fffffffffffffff, %rsi # imm = 0x8000000000000001
               	movq	%rsi, -0x50(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rdi
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$-0x7fffffffffffffff, %r11 # imm = 0x8000000000000001
               	movq	%rcx, %rdi
               	cmpq	%r11, %rcx
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	-0x50(%rbp), %r8
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
               	imulq	%rdi, %rsi
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
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$-0x1, %rsi
               	movq	%rsi, -0x48(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rdi
               	cmpq	%r11, %rcx
               	je	<addr>
               	cmpq	$-0x1, %rcx
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	-0x48(%rbp), %r8
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
               	imulq	%rdi, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x48(%rbp), %rsi
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
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$-0x3, %rsi
               	movq	%rsi, -0x40(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rdi
               	cmpq	%r11, %rcx
               	je	<addr>
               	cmpq	$-0x3, %rcx
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	-0x40(%rbp), %r8
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
               	imulq	%rdi, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x40(%rbp), %rsi
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
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0xa, %edi
               	movq	%rdi, -0x38(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rsi
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$0x6666666666666667, %r8 # imm = 0x6666666666666667
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%r8
               	movq	%rdx, %r9
               	popq	%rdx
               	popq	%rax
               	movq	%r9, %rsi
               	sarq	$0x2, %rsi
               	movq	%rsi, %rbx
               	shrq	$0x3f, %rbx
               	leaq	(%rsi,%rbx), %r12
               	movq	-0x38(%rbp), %r13
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
               	imulq	%rdi, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x38(%rbp), %rsi
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
               	movq	$-0x7, %r8
               	movq	%r8, -0x30(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rsi
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$0x4924924924924925, %r9 # imm = 0x4924924924924925
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	imulq	%r9
               	movq	%rdx, %rbx
               	popq	%rdx
               	popq	%rax
               	movq	%rbx, %rsi
               	sarq	%rsi
               	movq	%rsi, %r12
               	shrq	$0x3f, %r12
               	addq	%rsi, %r12
               	negq	%r12
               	addq	%rdi, %r12
               	movq	-0x30(%rbp), %r13
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
               	movq	%rsi, %r9
               	shrq	$0x3f, %r9
               	addq	%r9, %rsi
               	xorl	%r9d, %r9d
               	subq	%rsi, %r9
               	movq	%r9, %rsi
               	imulq	%r8, %rsi
               	movq	%rcx, %r8
               	subq	%rsi, %r8
               	movq	-0x30(%rbp), %rsi
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
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$0x40000000, -0x28(%rbp) # imm = 0x40000000
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rsi
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rcx, %rsi
               	sarq	$0x3f, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x22, %rdi
               	leaq	(%rcx,%rdi), %r8
               	movq	%r8, %r9
               	sarq	$0x1e, %r9
               	movq	-0x28(%rbp), %rbx
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
               	movq	%r9, %rsi
               	shlq	$0x1e, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x28(%rbp), %rsi
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
               	movq	$-0x1, %rsi
               	movq	%rsi, -0x20(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%rcx, %r8
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rdi, %r8
               	subq	%rcx, %r8
               	movq	-0x20(%rbp), %r9
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
               	xorl	%r8d, %r8d
               	subq	%rcx, %r8
               	imulq	%r8, %rsi
               	movq	%rcx, %r8
               	subq	%rsi, %r8
               	movq	-0x20(%rbp), %rsi
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
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0xa, %esi
               	movq	%rsi, -0x18(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rdi
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rcx, %rdi
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
               	movq	-0x18(%rbp), %r12
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
               	imulq	%rbx, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x18(%rbp), %rsi
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
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0x80000001, %esi       # imm = 0x80000001
               	movq	%rsi, -0x10(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rdi
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$0x3fffffff80000001, %rdi # imm = 0x3FFFFFFF80000001
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	mulq	%rdi
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %r9
               	shrq	$0x1d, %r9
               	movq	-0x10(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r9
               	jne	<addr>
               	imulq	%r9, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x10(%rbp), %rsi
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
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$-0x3, %rsi
               	movq	%rsi, -0x8(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rdi
               	cmpq	%r11, %rcx
               	je	<addr>
               	cmpq	$-0x3, %rcx
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	-0x8(%rbp), %r8
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
               	imulq	%rdi, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x8(%rbp), %rsi
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
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<converted>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x98, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0x3, %r8d
               	movb	%r8b, -0x88(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movsbq	%cl, %rcx
               	imulq	$0x55555556, %rcx, %r9  # imm = 0x55555556
               	movq	%r9, %rsi
               	sarq	$0x20, %rsi
               	movq	%rsi, %rbx
               	shrq	$0x3f, %rbx
               	leaq	(%rsi,%rbx), %rdi
               	movsbq	-0x88(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpl	%r12d, %edi
               	jne	<addr>
               	movq	%rdi, %rsi
               	imulq	%r8, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movslq	%edi, %rdi
               	movsbq	-0x88(%rbp), %rsi
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
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%edi, %edi
               	movq	%rdi, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$-0x80, %rsi
               	movb	%sil, -0x80(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movsbq	%al, %rax
               	movq	%rax, %r8
               	shrq	$0x39, %r8
               	leaq	(%rax,%r8), %r9
               	movq	%r9, %rbx
               	sarq	$0x7, %rbx
               	movq	%rdi, %r12
               	subq	%rbx, %r12
               	movsbq	-0x80(%rbp), %r13
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r13
               	movq	%rax, %r13
               	popq	%rdx
               	popq	%rax
               	cmpl	%r13d, %r12d
               	jne	<addr>
               	xorl	%r8d, %r8d
               	subq	%rbx, %r8
               	imulq	%r8, %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movslq	%r8d, %r8
               	movsbq	-0x80(%rbp), %rsi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%edi, %edi
               	movq	%rdi, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	$-0x1, %rsi
               	movb	%sil, -0x78(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movsbq	%cl, %rcx
               	movq	%rdi, %r8
               	subq	%rcx, %r8
               	movsbq	-0x78(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	xorl	%r8d, %r8d
               	subq	%rcx, %r8
               	imulq	%r8, %rsi
               	movq	%rcx, %r8
               	subq	%rsi, %r8
               	movslq	%r8d, %r8
               	movsbq	-0x78(%rbp), %rsi
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
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x3, %edi
               	movb	%dil, -0x70(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	andq	$0xff, %rax
               	imulq	$0x55555556, %rax, %r8  # imm = 0x55555556
               	movq	%r8, %rsi
               	shrq	$0x20, %rsi
               	movzbq	-0x70(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpl	%r9d, %esi
               	jne	<addr>
               	imulq	%rdi, %rsi
               	movq	%rax, %rdi
               	subq	%rsi, %rdi
               	movslq	%edi, %rdi
               	movzbq	-0x70(%rbp), %rsi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
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
               	movl	$0xff, %edi
               	movb	%dil, -0x68(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	andq	$0xff, %rax
               	imulq	$0x1010102, %rax, %r8   # imm = 0x1010102
               	movq	%r8, %rsi
               	shrq	$0x20, %rsi
               	movzbq	-0x68(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpl	%r9d, %esi
               	jne	<addr>
               	imulq	%rdi, %rsi
               	movq	%rax, %rdi
               	subq	%rsi, %rdi
               	movslq	%edi, %rdi
               	movzbq	-0x68(%rbp), %rsi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %rdi
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
               	movl	$0xa, %r8d
               	movw	%r8w, -0x60(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movswq	%cx, %rcx
               	imulq	$0x66666667, %rcx, %r9  # imm = 0x66666667
               	movq	%r9, %rsi
               	sarq	$0x22, %rsi
               	movq	%rsi, %rbx
               	shrq	$0x3f, %rbx
               	leaq	(%rsi,%rbx), %rdi
               	movswq	-0x60(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpl	%r12d, %edi
               	jne	<addr>
               	movq	%rdi, %rsi
               	imulq	%r8, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movslq	%edi, %rdi
               	movswq	-0x60(%rbp), %rsi
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
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%edi, %edi
               	movq	%rdi, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$-0x8000, %rsi          # imm = 0x8000
               	movw	%si, -0x58(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movswq	%ax, %rax
               	movq	%rax, %r8
               	shrq	$0x31, %r8
               	leaq	(%rax,%r8), %r9
               	movq	%r9, %rbx
               	sarq	$0xf, %rbx
               	movq	%rdi, %r12
               	subq	%rbx, %r12
               	movswq	-0x58(%rbp), %r13
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r13
               	movq	%rax, %r13
               	popq	%rdx
               	popq	%rax
               	cmpl	%r13d, %r12d
               	jne	<addr>
               	xorl	%r8d, %r8d
               	subq	%rbx, %r8
               	imulq	%r8, %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movslq	%r8d, %r8
               	movswq	-0x58(%rbp), %rsi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %r8
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
               	movl	$0x3, %edi
               	movl	%edi, -0x50(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, %esi
               	movl	$0xaaaaaaab, %r8d       # imm = 0xAAAAAAAB
               	imulq	%rsi, %r8
               	movq	%r8, %r9
               	shrq	$0x21, %r9
               	movl	-0x50(%rbp), %ebx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpl	%ebx, %r9d
               	jne	<addr>
               	shrq	$0x21, %r8
               	imulq	%r8, %rdi
               	subq	%rdi, %rsi
               	movl	%esi, %edi
               	movl	-0x50(%rbp), %esi
               	movl	%ecx, %ecx
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
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movl	$0x80000000, -0x48(%rbp) # imm = 0x80000000
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, %esi
               	movq	%rsi, %rdi
               	shrq	$0x1f, %rdi
               	movl	-0x48(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	cmpl	%r8d, %edi
               	jne	<addr>
               	shlq	$0x1f, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movl	%r8d, %r8d
               	movl	-0x48(%rbp), %edi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
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
               	movl	$0xfffffffd, -0x40(%rbp) # imm = 0xFFFFFFFD
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, %esi
               	movl	$0xfffffffd, %r11d      # imm = 0xFFFFFFFD
               	movq	%rsi, %rdi
               	cmpq	%r11, %rsi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	-0x40(%rbp), %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	cmpl	%r8d, %edi
               	jne	<addr>
               	movl	$0xfffffffd, %r8d       # imm = 0xFFFFFFFD
               	imulq	%r8, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movl	%r8d, %r8d
               	movl	-0x40(%rbp), %edi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
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
               	movl	$0x3, %edi
               	movq	%rdi, -0x38(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movslq	%ecx, %rcx
               	imulq	$0x55555556, %rcx, %r8  # imm = 0x55555556
               	movq	%r8, %rsi
               	sarq	$0x20, %rsi
               	movq	%rsi, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rsi,%r9), %rbx
               	movq	-0x38(%rbp), %r12
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
               	movq	%rbx, %rsi
               	imulq	%rdi, %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movq	-0x38(%rbp), %rsi
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
               	movq	$-0x1, %rsi
               	movq	%rsi, -0x30(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movslq	%ecx, %rcx
               	movq	%rdi, %r8
               	subq	%rcx, %r8
               	movq	-0x30(%rbp), %r9
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
               	xorl	%r8d, %r8d
               	subq	%rcx, %r8
               	imulq	%r8, %rsi
               	movq	%rcx, %r8
               	subq	%rsi, %r8
               	movq	-0x30(%rbp), %rsi
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
               	movq	%rcx, -0x28(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movslq	%ecx, %rcx
               	movq	-0x28(%rbp), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	(%rcx), %rdi
               	movq	-0x28(%rbp), %rsi
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
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	xorl	%edi, %edi
               	movq	%rdi, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$-0x80000000, %rsi      # imm = 0x80000000
               	movq	%rsi, -0x20(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	shrq	$0x21, %r8
               	leaq	(%rax,%r8), %r9
               	movq	%r9, %rbx
               	sarq	$0x1f, %rbx
               	movq	%rdi, %r12
               	subq	%rbx, %r12
               	movq	-0x20(%rbp), %r13
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r13
               	movq	%rax, %r13
               	popq	%rdx
               	popq	%rax
               	cmpq	%r13, %r12
               	jne	<addr>
               	xorl	%r8d, %r8d
               	subq	%rbx, %r8
               	imulq	%r8, %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movq	-0x20(%rbp), %rsi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	%rax, %r8
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
               	movl	$0x7, %r8d
               	movq	%r8, -0x18(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, %esi
               	imulq	$0x24924925, %rsi, %r9  # imm = 0x24924925
               	movq	%r9, %rdi
               	shrq	$0x20, %rdi
               	movq	%rsi, %rbx
               	subq	%rdi, %rbx
               	shrq	%rbx
               	addq	%rdi, %rbx
               	shrq	$0x2, %rbx
               	movq	-0x18(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rbx
               	jne	<addr>
               	movq	%rsi, %r9
               	subq	%rdi, %r9
               	shrq	%r9
               	addq	%r9, %rdi
               	shrq	$0x2, %rdi
               	imulq	%r8, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movl	%ecx, %esi
               	movq	-0x18(%rbp), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %r8
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
               	movq	$-0x7, %r8
               	movq	%r8, -0x10(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, %esi
               	movabsq	$0x4924924924924925, %r9 # imm = 0x4924924924924925
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	imulq	%r9
               	movq	%rdx, %r9
               	popq	%rdx
               	popq	%rax
               	sarq	%r9
               	movq	%r9, %rbx
               	shrq	$0x3f, %rbx
               	addq	%rbx, %r9
               	negq	%r9
               	addq	%rdi, %r9
               	movq	-0x10(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r9
               	jne	<addr>
               	movabsq	$0x4924924924924925, %r9 # imm = 0x4924924924924925
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	imulq	%r9
               	movq	%rdx, %r9
               	popq	%rdx
               	popq	%rax
               	sarq	%r9
               	movq	%r9, %rbx
               	shrq	$0x3f, %rbx
               	addq	%rbx, %r9
               	xorl	%ebx, %ebx
               	negq	%r9
               	addq	%rbx, %r9
               	imulq	%r9, %r8
               	movq	%rsi, %r9
               	subq	%r8, %r9
               	movq	-0x10(%rbp), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %r9
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
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	movq	%rdi, -0x8(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
               	movl	%ecx, %esi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rsi, %r8
               	cmpq	%r11, %rsi
               	setae	%r8b
               	movzbq	%r8b, %r8
               	movq	-0x8(%rbp), %r9
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpq	%r9, %r8
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movq	-0x8(%rbp), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rcx, %r8
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rdx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<fixed>:
               	movslq	%edi, %rdi
               	movl	$0x92492493, %eax       # imm = 0x92492493
               	imulq	%rdi, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rax, %rcx
               	movl	%edi, %eax
               	movl	$0x3e8, %edx            # imm = 0x3E8
               	movq	%rax, %rsi
               	shrq	$0x3, %rsi
               	imulq	$0x10624dd3, %rsi, %rsi # imm = 0x10624DD3
               	shrq	$0x23, %rsi
               	imulq	%rsi, %rdx
               	subq	%rdx, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	callq	<addr>
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%ebx, %ebx
               	movl	%ebx, -0x18(%rbp)
               	movl	$0x7, -0x10(%rbp)
               	movl	$0x3e8, -0x8(%rbp)      # imm = 0x3E8
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%rbx, %r12
               	cmpl	$0x18, %r12d
               	jge	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax,%r12,8), %rdi
               	movslq	%edi, %r13
               	movl	$0x7, %esi
               	movl	$0x3e8, %edx            # imm = 0x3E8
               	callq	<addr>
               	movq	%rax, %rdx
               	movslq	-0x10(%rbp), %rax
               	movq	%rax, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r13, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movl	%r13d, %ecx
               	movl	-0x8(%rbp), %eax
               	movq	%rax, %r10
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	movslq	-0x18(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r13, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	imulq	%rcx, %rax
               	movq	%r13, %rdx
               	subq	%rax, %rdx
               	leaq	(%rcx,%rdx), %rax
               	addq	%rax, %rbx
               	incq	%r12
               	cmpl	$0x18, %r12d
               	jl	<addr>
               	movslq	%ebx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rbx
               	jmp	<addr>
