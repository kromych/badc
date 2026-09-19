
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

<ints>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0xa, %r9d
               	movl	%r9d, -0xa8(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	imulq	$0x66666667, %rsi, %rax # imm = 0x66666667
               	movq	%rax, %rdi
               	sarq	$0x22, %rdi
               	movq	%rdi, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rdi,%rdx), %r8
               	movslq	-0xa8(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r8
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%r9, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %r8
               	movslq	-0xa8(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
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
               	movl	$0x7, %r9d
               	movl	%r9d, -0xa0(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movl	$0x92492493, %eax       # imm = 0x92492493
               	imulq	%rsi, %rax
               	movq	%rax, %rdi
               	sarq	$0x22, %rdi
               	movq	%rdi, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rdi,%rdx), %r8
               	movslq	-0xa0(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r8
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%r9, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %r8
               	movslq	-0xa0(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%r8d, %r8d
               	movq	%r8, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$-0x7, %r9
               	movl	%r9d, -0x98(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movl	$0x92492493, %eax       # imm = 0x92492493
               	imulq	%rsi, %rax
               	movq	%rax, %rdi
               	sarq	$0x22, %rdi
               	movq	%rdi, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rdi,%rdx), %rbx
               	movq	%r8, %r12
               	subq	%rbx, %r12
               	movslq	-0x98(%rbp), %r13
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r13
               	movq	%rax, %r13
               	popq	%rdx
               	popq	%rax
               	cmpq	%r13, %r12
               	jne	<addr>
               	xorl	%eax, %eax
               	subq	%rbx, %rax
               	imulq	%r9, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %r9
               	movslq	-0x98(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r9
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%esi, %esi
               	cmpl	$0x18, %esi
               	jge	<addr>
               	movl	$0x1, -0x90(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rax
               	movslq	%eax, %rcx
               	movslq	-0x90(%rbp), %rdi
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movq	%rcx, %rax
               	subq	%rcx, %rax
               	movslq	%eax, %r8
               	movslq	-0x90(%rbp), %rdi
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rsi
               	cmpl	$0x18, %esi
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	cmpl	$0x18, %esi
               	jge	<addr>
               	movq	$-0x1, %r9
               	movl	%r9d, -0x88(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rax
               	movslq	%eax, %rcx
               	cmpl	$0x80000000, %ecx       # imm = 0x80000000
               	je	<addr>
               	movq	%rdi, %r8
               	subq	%rcx, %r8
               	movslq	-0x88(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%r9, %rax
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %r9
               	movslq	-0x88(%rbp), %r8
               	movq	%rcx, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %r9
               	jne	<addr>
               	incq	%rsi
               	cmpl	$0x18, %esi
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%esi, %esi
               	cmpl	$0x18, %esi
               	jge	<addr>
               	movl	$0x2, -0x80(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rax
               	movslq	%eax, %rcx
               	movq	%rcx, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rcx,%r8), %r9
               	movq	%r9, %rdi
               	sarq	%rdi
               	movslq	-0x80(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %rdi
               	jne	<addr>
               	movq	%rdi, %rax
               	shlq	%rax
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %r8
               	movslq	-0x80(%rbp), %rdi
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rsi
               	cmpl	$0x18, %esi
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%r8d, %r8d
               	movq	%r8, %rsi
               	cmpl	$0x18, %esi
               	jge	<addr>
               	movq	$-0x2, %rdi
               	movl	%edi, -0x78(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rax
               	movslq	%eax, %rcx
               	movq	%rcx, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rcx,%r9), %rax
               	movq	%rax, %rdx
               	sarq	%rdx
               	movq	%r8, %rbx
               	subq	%rdx, %rbx
               	movslq	-0x78(%rbp), %r12
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
               	xorl	%eax, %eax
               	subq	%rdx, %rax
               	imulq	%rdi, %rax
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %r9
               	movslq	-0x78(%rbp), %rdi
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r9
               	jne	<addr>
               	incq	%rsi
               	cmpl	$0x18, %esi
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%esi, %esi
               	cmpl	$0x18, %esi
               	jge	<addr>
               	movl	$0x400, -0x70(%rbp)     # imm = 0x400
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rax
               	movslq	%eax, %rcx
               	movq	%rcx, %r8
               	shrq	$0x36, %r8
               	leaq	(%rcx,%r8), %r9
               	movq	%r9, %rdi
               	sarq	$0xa, %rdi
               	movslq	-0x70(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %rdi
               	jne	<addr>
               	movq	%rdi, %rax
               	shlq	$0xa, %rax
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %r8
               	movslq	-0x70(%rbp), %rdi
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rsi
               	cmpl	$0x18, %esi
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x7fffffff, %r9d       # imm = 0x7FFFFFFF
               	movl	%r9d, -0x68(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	imulq	$0x40000001, %rsi, %rax # imm = 0x40000001
               	movq	%rax, %rdi
               	sarq	$0x3d, %rdi
               	movq	%rdi, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rdi,%rdx), %r8
               	movslq	-0x68(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %r8
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%r9, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %r8
               	movslq	-0x68(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%r8d, %r8d
               	movq	%r8, %rsi
               	cmpl	$0x18, %esi
               	jge	<addr>
               	movq	$-0x80000000, %rdi      # imm = 0x80000000
               	movl	%edi, -0x60(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rax
               	movslq	%eax, %rcx
               	movq	%rcx, %r9
               	shrq	$0x21, %r9
               	leaq	(%rcx,%r9), %rax
               	movq	%rax, %rdx
               	sarq	$0x1f, %rdx
               	movq	%r8, %rbx
               	subq	%rdx, %rbx
               	movslq	-0x60(%rbp), %r12
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
               	xorl	%eax, %eax
               	subq	%rdx, %rax
               	imulq	%rdi, %rax
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %r9
               	movslq	-0x60(%rbp), %rdi
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r9
               	jne	<addr>
               	incq	%rsi
               	cmpl	$0x18, %esi
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%r8d, %r8d
               	movq	%r8, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$-0x7fffffff, %r9       # imm = 0x80000001
               	movl	%r9d, -0x58(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	imulq	$0x40000001, %rsi, %rax # imm = 0x40000001
               	movq	%rax, %rdi
               	sarq	$0x3d, %rdi
               	movq	%rdi, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rdi,%rdx), %rbx
               	movq	%r8, %r12
               	subq	%rbx, %r12
               	movslq	-0x58(%rbp), %r13
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r13
               	movq	%rax, %r13
               	popq	%rdx
               	popq	%rax
               	cmpq	%r13, %r12
               	jne	<addr>
               	xorl	%eax, %eax
               	subq	%rbx, %rax
               	imulq	%r9, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %r9
               	movslq	-0x58(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r9
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
               	movl	$0xa, %r9d
               	movl	%r9d, -0x50(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movl	%esi, %edi
               	movq	%rdi, %rax
               	shrq	%rax
               	imulq	$0x66666667, %rax, %rdx # imm = 0x66666667
               	movq	%rdx, %r8
               	shrq	$0x21, %r8
               	movl	-0x50(%rbp), %ebx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpl	%ebx, %r8d
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%r9, %rax
               	movq	%rdi, %rdx
               	subq	%rax, %rdx
               	movl	%edx, %r8d
               	movl	%esi, %edi
               	movl	-0x50(%rbp), %esi
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	cmpq	%rdx, %r8
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
               	movl	$0x7, %r9d
               	movl	%r9d, -0x48(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movl	%esi, %edi
               	imulq	$0x24924925, %rdi, %rax # imm = 0x24924925
               	movq	%rax, %r8
               	shrq	$0x20, %r8
               	movq	%rdi, %rdx
               	subq	%r8, %rdx
               	movq	%rdx, %rbx
               	shrq	%rbx
               	addq	%r8, %rbx
               	shrq	$0x2, %rbx
               	movl	-0x48(%rbp), %r12d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpl	%r12d, %ebx
               	jne	<addr>
               	movq	%rdx, %rax
               	shrq	%rax
               	addq	%r8, %rax
               	shrq	$0x2, %rax
               	imulq	%r9, %rax
               	movq	%rdi, %rdx
               	subq	%rax, %rdx
               	movl	%edx, %r8d
               	movl	%esi, %edi
               	movl	-0x48(%rbp), %esi
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	cmpq	%rdx, %r8
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
               	movl	$0x1, -0x40(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movl	%esi, %edi
               	movl	-0x40(%rbp), %r8d
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpl	%eax, %edi
               	jne	<addr>
               	movq	%rdi, %rax
               	subq	%rdi, %rax
               	movl	%eax, %r8d
               	movl	-0x40(%rbp), %esi
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	cmpq	%rdx, %r8
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
               	movl	$0x40, -0x38(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movl	%esi, %edi
               	movq	%rdi, %r8
               	shrq	$0x6, %r8
               	movl	-0x38(%rbp), %r9d
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movq	%r8, %rax
               	shlq	$0x6, %rax
               	movq	%rdi, %rdx
               	subq	%rax, %rdx
               	movl	%edx, %r8d
               	movl	-0x38(%rbp), %esi
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	cmpq	%rdx, %r8
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
               	movl	$0x80000000, -0x30(%rbp) # imm = 0x80000000
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movl	%esi, %edi
               	movq	%rdi, %r8
               	shrq	$0x1f, %r8
               	movl	-0x30(%rbp), %r9d
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movq	%r8, %rax
               	shlq	$0x1f, %rax
               	movq	%rdi, %rdx
               	subq	%rax, %rdx
               	movl	%edx, %r8d
               	movl	-0x30(%rbp), %esi
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	cmpq	%rdx, %r8
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
               	movl	$0x80000001, %r9d       # imm = 0x80000001
               	movl	%r9d, -0x28(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movl	%esi, %edi
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	movq	%rdi, %r8
               	cmpq	%r11, %rdi
               	setae	%r8b
               	movzbq	%r8b, %r8
               	movl	-0x28(%rbp), %eax
               	movq	%rax, %r10
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%r9, %rax
               	movq	%rdi, %rdx
               	subq	%rax, %rdx
               	movl	%edx, %r8d
               	movl	-0x28(%rbp), %esi
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	cmpq	%rdx, %r8
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
               	movl	$0xfffffffe, %r9d       # imm = 0xFFFFFFFE
               	movl	%r9d, -0x20(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movl	%esi, %edi
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	movq	%rdi, %r8
               	cmpq	%r11, %rdi
               	setae	%r8b
               	movzbq	%r8b, %r8
               	movl	-0x20(%rbp), %eax
               	movq	%rax, %r10
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%r9, %rax
               	movq	%rdi, %rdx
               	subq	%rax, %rdx
               	movl	%edx, %r8d
               	movl	-0x20(%rbp), %esi
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	cmpq	%rdx, %r8
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
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	movl	%r9d, -0x18(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movl	%esi, %edi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rdi, %r8
               	cmpq	%r11, %rdi
               	setae	%r8b
               	movzbq	%r8b, %r8
               	movl	-0x18(%rbp), %eax
               	movq	%rax, %r10
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%r9, %rax
               	movq	%rdi, %rdx
               	subq	%rax, %rdx
               	movl	%edx, %r8d
               	movl	-0x18(%rbp), %esi
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	cmpq	%rdx, %r8
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
               	movl	$0xfffffffd, -0x10(%rbp) # imm = 0xFFFFFFFD
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movl	%esi, %edi
               	movl	$0xfffffffd, %r11d      # imm = 0xFFFFFFFD
               	movq	%rdi, %r8
               	cmpq	%r11, %rdi
               	setae	%r8b
               	movzbq	%r8b, %r8
               	movl	-0x10(%rbp), %r9d
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movl	$0xfffffffd, %eax       # imm = 0xFFFFFFFD
               	imulq	%r8, %rax
               	movq	%rdi, %rdx
               	subq	%rax, %rdx
               	movl	%edx, %r8d
               	movl	-0x10(%rbp), %esi
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	cmpq	%rdx, %r8
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
               	movl	$0xffffffff, -0x8(%rbp) # imm = 0xFFFFFFFF
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movl	%esi, %edi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rdi, %r8
               	cmpq	%r11, %rdi
               	setae	%r8b
               	movzbq	%r8b, %r8
               	movl	-0x8(%rbp), %r9d
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	imulq	%r8, %rax
               	movq	%rdi, %rdx
               	subq	%rax, %rdx
               	movl	%edx, %r8d
               	movl	-0x8(%rbp), %esi
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
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

<wides>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0xa, %r8d
               	movq	%r8, -0xb0(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movabsq	$0x6666666666666667, %r9 # imm = 0x6666666666666667
               	movq	%rsi, %rax
               	imulq	%r9
               	movq	%rdx, %rdi
               	sarq	$0x2, %rdi
               	movq	%rdi, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdi,%rax), %rbx
               	movq	-0xb0(%rbp), %r12
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
               	movq	%rbx, %rax
               	imulq	%r8, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0xb0(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%r8d, %r8d
               	movq	%r8, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$-0x3e8, %r9            # imm = 0xFC18
               	movq	%r9, -0xa8(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movabsq	$0x20c49ba5e353f7cf, %rax # imm = 0x20C49BA5E353F7CF
               	movq	%rax, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	imulq	%r10
               	popq	%rax
               	movq	%rdx, %rdi
               	sarq	$0x7, %rdi
               	movq	%rdi, %rbx
               	shrq	$0x3f, %rbx
               	leaq	(%rdi,%rbx), %r12
               	negq	%r12
               	addq	%r8, %r12
               	movq	-0xa8(%rbp), %r13
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r13
               	movq	%rax, %r13
               	popq	%rdx
               	popq	%rax
               	cmpq	%r13, %r12
               	jne	<addr>
               	leaq	(%rdi,%rbx), %rax
               	xorl	%edx, %edx
               	subq	%rax, %rdx
               	movq	%rdx, %rax
               	imulq	%r9, %rax
               	movq	%rsi, %r9
               	subq	%rax, %r9
               	movq	-0xa8(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r9
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
               	movq	$0x1, -0xa0(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movq	-0xa0(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rax, %rsi
               	jne	<addr>
               	movq	%rsi, %r8
               	subq	%rsi, %r8
               	movq	-0xa0(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
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
               	movq	$-0x1, %r8
               	movq	%r8, -0x98(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movq	%rdi, %r9
               	subq	%rsi, %r9
               	movq	-0x98(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %r9
               	jne	<addr>
               	movq	%r9, %rax
               	imulq	%r8, %rax
               	movq	%rsi, %r9
               	subq	%rax, %r9
               	movq	-0x98(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %r9
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
               	movq	$0x1000, -0x90(%rbp)    # imm = 0x1000
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movq	%rsi, %rdi
               	sarq	$0x3f, %rdi
               	movq	%rdi, %r8
               	shrq	$0x34, %r8
               	leaq	(%rsi,%r8), %r9
               	movq	%r9, %rax
               	sarq	$0xc, %rax
               	movq	-0x90(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	shlq	$0xc, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x90(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
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
               	movabsq	$0x100000001, %r8       # imm = 0x100000001
               	movq	%r8, -0x88(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movabsq	$0x7fffffff80000001, %r9 # imm = 0x7FFFFFFF80000001
               	movq	%rsi, %rax
               	imulq	%r9
               	movq	%rdx, %rdi
               	sarq	$0x1f, %rdi
               	movq	%rdi, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdi,%rax), %rbx
               	movq	-0x88(%rbp), %r12
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
               	movq	%rbx, %rax
               	imulq	%r8, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x88(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
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
               	movabsq	$0x7fffffffffffffff, %r8 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%r8, -0x80(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movabsq	$0x4000000000000001, %r9 # imm = 0x4000000000000001
               	movq	%rsi, %rax
               	imulq	%r9
               	movq	%rdx, %rdi
               	sarq	$0x3d, %rdi
               	movq	%rdi, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdi,%rax), %rbx
               	movq	-0x80(%rbp), %r12
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
               	movq	%rbx, %rax
               	imulq	%r8, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x80(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%r8d, %r8d
               	movq	%r8, %rsi
               	cmpl	$0x18, %esi
               	jge	<addr>
               	movabsq	$-0x8000000000000000, %rdi # imm = 0x8000000000000000
               	movq	%rdi, -0x78(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rcx, %r9
               	sarq	$0x3f, %r9
               	movq	%r9, %rax
               	shrq	%rax
               	leaq	(%rcx,%rax), %rdx
               	movq	%rdx, %rbx
               	sarq	$0x3f, %rbx
               	movq	%r8, %r12
               	subq	%rbx, %r12
               	movq	-0x78(%rbp), %r13
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
               	xorl	%eax, %eax
               	subq	%rbx, %rax
               	imulq	%rdi, %rax
               	movq	%rcx, %r9
               	subq	%rax, %r9
               	movq	-0x78(%rbp), %rdi
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r9
               	jne	<addr>
               	incq	%rsi
               	cmpl	$0x18, %esi
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0xa, %edi
               	movq	%rdi, -0x70(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movq	%rsi, %r8
               	shrq	%r8
               	movabsq	$0x6666666666666667, %r9 # imm = 0x6666666666666667
               	movq	%r8, %rax
               	mulq	%r9
               	movq	%rdx, %rax
               	shrq	%rax
               	movq	-0x70(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %rax
               	jne	<addr>
               	imulq	%rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x70(%rbp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
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
               	movl	$0x7, %r8d
               	movq	%r8, -0x68(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movabsq	$0x2492492492492493, %r9 # imm = 0x2492492492492493
               	movq	%rsi, %rax
               	mulq	%r9
               	movq	%rdx, %rdi
               	movq	%rsi, %rax
               	subq	%rdi, %rax
               	movq	%rax, %rdx
               	shrq	%rdx
               	leaq	(%rdx,%rdi), %rbx
               	movq	%rbx, %r12
               	shrq	$0x2, %r12
               	movq	-0x68(%rbp), %r13
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r13
               	movq	%rax, %r13
               	popq	%rdx
               	popq	%rax
               	cmpq	%r13, %r12
               	jne	<addr>
               	movq	%rbx, %rax
               	shrq	$0x2, %rax
               	imulq	%r8, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x68(%rbp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
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
               	movabsq	$0x100000000, %rax      # imm = 0x100000000
               	movq	%rax, -0x60(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movq	%rsi, %rdi
               	shrq	$0x20, %rdi
               	movq	-0x60(%rbp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	movq	%rdi, %rax
               	shlq	$0x20, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x60(%rbp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
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
               	movabsq	$-0x8000000000000000, %rdi # imm = 0x8000000000000000
               	movq	%rdi, -0x58(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movq	%rsi, %r8
               	shrq	$0x3f, %r8
               	movq	-0x58(%rbp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x58(%rbp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
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
               	movabsq	$-0x7fffffffffffffff, %rdi # imm = 0x8000000000000001
               	movq	%rdi, -0x50(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movabsq	$-0x7fffffffffffffff, %r11 # imm = 0x8000000000000001
               	movq	%rsi, %r8
               	cmpq	%r11, %rsi
               	setae	%r8b
               	movzbq	%r8b, %r8
               	movq	-0x50(%rbp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x50(%rbp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
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
               	movq	$-0x1, %rdi
               	movq	%rdi, -0x48(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	cmpq	$-0x1, %rsi
               	setae	%r8b
               	movzbq	%r8b, %r8
               	movq	-0x48(%rbp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x48(%rbp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
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
               	movq	$-0x3, %rdi
               	movq	%rdi, -0x40(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	cmpq	$-0x3, %rsi
               	setae	%r8b
               	movzbq	%r8b, %r8
               	movq	-0x40(%rbp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x40(%rbp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
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
               	movl	$0xa, %r8d
               	movq	%r8, -0x38(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movabsq	$0x6666666666666667, %r9 # imm = 0x6666666666666667
               	movq	%rsi, %rax
               	imulq	%r9
               	movq	%rdx, %rdi
               	sarq	$0x2, %rdi
               	movq	%rdi, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdi,%rax), %rbx
               	movq	-0x38(%rbp), %r12
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
               	movq	%rbx, %rax
               	imulq	%r8, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x38(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%r8d, %r8d
               	movq	%r8, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$-0x7, %r9
               	movq	%r9, -0x30(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movabsq	$0x4924924924924925, %rax # imm = 0x4924924924924925
               	movq	%rax, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	imulq	%r10
               	popq	%rax
               	movq	%rdx, %rdi
               	sarq	%rdi
               	movq	%rdi, %rbx
               	shrq	$0x3f, %rbx
               	leaq	(%rdi,%rbx), %r12
               	negq	%r12
               	addq	%r8, %r12
               	movq	-0x30(%rbp), %r13
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r13
               	movq	%rax, %r13
               	popq	%rdx
               	popq	%rax
               	cmpq	%r13, %r12
               	jne	<addr>
               	leaq	(%rdi,%rbx), %rax
               	xorl	%edx, %edx
               	subq	%rax, %rdx
               	movq	%rdx, %rax
               	imulq	%r9, %rax
               	movq	%rsi, %r9
               	subq	%rax, %r9
               	movq	-0x30(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r9
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
               	movq	$0x40000000, -0x28(%rbp) # imm = 0x40000000
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movq	%rsi, %rdi
               	sarq	$0x3f, %rdi
               	movq	%rdi, %r8
               	shrq	$0x22, %r8
               	leaq	(%rsi,%r8), %r9
               	movq	%r9, %rax
               	sarq	$0x1e, %rax
               	movq	-0x28(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	shlq	$0x1e, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x28(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
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
               	movq	$-0x1, %r8
               	movq	%r8, -0x20(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movq	%rdi, %r9
               	subq	%rsi, %r9
               	movq	-0x20(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %r9
               	jne	<addr>
               	movq	%r9, %rax
               	imulq	%r8, %rax
               	movq	%rsi, %r9
               	subq	%rax, %r9
               	movq	-0x20(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %r9
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
               	movl	$0xa, %edi
               	movq	%rdi, -0x18(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movq	%rsi, %r8
               	shrq	%r8
               	movabsq	$0x6666666666666667, %r9 # imm = 0x6666666666666667
               	movq	%r8, %rax
               	mulq	%r9
               	movq	%rdx, %rax
               	shrq	%rax
               	movq	-0x18(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %rax
               	jne	<addr>
               	imulq	%rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x18(%rbp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
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
               	movl	$0x80000001, %edi       # imm = 0x80000001
               	movq	%rdi, -0x10(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movabsq	$0x3fffffff80000001, %r8 # imm = 0x3FFFFFFF80000001
               	movq	%rsi, %rax
               	mulq	%r8
               	movq	%rdx, %r9
               	movq	%r9, %rax
               	shrq	$0x1d, %rax
               	movq	-0x10(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	imulq	%rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x10(%rbp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
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
               	movq	$-0x3, %rdi
               	movq	%rdi, -0x8(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	cmpq	$-0x3, %rsi
               	setae	%r8b
               	movzbq	%r8b, %r8
               	movq	-0x8(%rbp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x8(%rbp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
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

<converted>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x3, %r9d
               	movb	%r9b, -0x88(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movsbq	%al, %rsi
               	imulq	$0x55555556, %rsi, %rax # imm = 0x55555556
               	movq	%rax, %rdi
               	sarq	$0x20, %rdi
               	movq	%rdi, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rdi,%rdx), %r8
               	movsbq	-0x88(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpl	%ebx, %r8d
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%r9, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %r8
               	movsbq	-0x88(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%r8d, %r8d
               	movq	%r8, %rsi
               	cmpl	$0x18, %esi
               	jge	<addr>
               	movq	$-0x80, %rdi
               	movb	%dil, -0x80(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rax
               	movsbq	%al, %rcx
               	movq	%rcx, %r9
               	shrq	$0x39, %r9
               	leaq	(%rcx,%r9), %rax
               	movq	%rax, %rdx
               	sarq	$0x7, %rdx
               	movq	%r8, %rbx
               	subq	%rdx, %rbx
               	movsbq	-0x80(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpl	%r12d, %ebx
               	jne	<addr>
               	xorl	%eax, %eax
               	subq	%rdx, %rax
               	imulq	%rdi, %rax
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %r9
               	movsbq	-0x80(%rbp), %rdi
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r9
               	jne	<addr>
               	incq	%rsi
               	cmpl	$0x18, %esi
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$-0x1, %r9
               	movb	%r9b, -0x78(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movsbq	%al, %rsi
               	movq	%rdi, %r8
               	subq	%rsi, %r8
               	movsbq	-0x78(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%r9, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %r9
               	movsbq	-0x78(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %r9
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%esi, %esi
               	cmpl	$0x18, %esi
               	jge	<addr>
               	movl	$0x3, %r8d
               	movb	%r8b, -0x70(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	imulq	$0x55555556, %rcx, %r9  # imm = 0x55555556
               	movq	%r9, %rdi
               	shrq	$0x20, %rdi
               	movzbq	-0x70(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	cmpl	%eax, %edi
               	jne	<addr>
               	movq	%rdi, %rax
               	imulq	%r8, %rax
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %r8
               	movzbq	-0x70(%rbp), %rdi
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rsi
               	cmpl	$0x18, %esi
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%esi, %esi
               	cmpl	$0x18, %esi
               	jge	<addr>
               	movl	$0xff, %r8d
               	movb	%r8b, -0x68(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	imulq	$0x1010102, %rcx, %r9   # imm = 0x1010102
               	movq	%r9, %rdi
               	shrq	$0x20, %rdi
               	movzbq	-0x68(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	cmpl	%eax, %edi
               	jne	<addr>
               	movq	%rdi, %rax
               	imulq	%r8, %rax
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %r8
               	movzbq	-0x68(%rbp), %rdi
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rsi
               	cmpl	$0x18, %esi
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0xa, %r9d
               	movw	%r9w, -0x60(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movswq	%ax, %rsi
               	imulq	$0x66666667, %rsi, %rax # imm = 0x66666667
               	movq	%rax, %rdi
               	sarq	$0x22, %rdi
               	movq	%rdi, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rdi,%rdx), %r8
               	movswq	-0x60(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpl	%ebx, %r8d
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%r9, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %r8
               	movswq	-0x60(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%r8d, %r8d
               	movq	%r8, %rsi
               	cmpl	$0x18, %esi
               	jge	<addr>
               	movq	$-0x8000, %rdi          # imm = 0x8000
               	movw	%di, -0x58(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rax
               	movswq	%ax, %rcx
               	movq	%rcx, %r9
               	shrq	$0x31, %r9
               	leaq	(%rcx,%r9), %rax
               	movq	%rax, %rdx
               	sarq	$0xf, %rdx
               	movq	%r8, %rbx
               	subq	%rdx, %rbx
               	movswq	-0x58(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpl	%r12d, %ebx
               	jne	<addr>
               	xorl	%eax, %eax
               	subq	%rdx, %rax
               	imulq	%rdi, %rax
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %r9
               	movswq	-0x58(%rbp), %rdi
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r9
               	jne	<addr>
               	incq	%rsi
               	cmpl	$0x18, %esi
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x3, %r9d
               	movl	%r9d, -0x50(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movl	%esi, %edi
               	movl	$0xaaaaaaab, %eax       # imm = 0xAAAAAAAB
               	imulq	%rdi, %rax
               	movq	%rax, %r8
               	shrq	$0x21, %r8
               	movl	-0x50(%rbp), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpl	%edx, %r8d
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%r9, %rax
               	movq	%rdi, %rdx
               	subq	%rax, %rdx
               	movl	%edx, %r8d
               	movl	-0x50(%rbp), %edi
               	movl	%esi, %esi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
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
               	movl	$0x80000000, -0x48(%rbp) # imm = 0x80000000
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movl	%esi, %edi
               	movq	%rdi, %r8
               	shrq	$0x1f, %r8
               	movl	-0x48(%rbp), %r9d
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movq	%r8, %rax
               	shlq	$0x1f, %rax
               	movq	%rdi, %rdx
               	subq	%rax, %rdx
               	movl	%edx, %r9d
               	movl	-0x48(%rbp), %r8d
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %r9
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
               	movl	$0xfffffffd, -0x40(%rbp) # imm = 0xFFFFFFFD
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movl	%esi, %edi
               	movl	$0xfffffffd, %r11d      # imm = 0xFFFFFFFD
               	movq	%rdi, %r8
               	cmpq	%r11, %rdi
               	setae	%r8b
               	movzbq	%r8b, %r8
               	movl	-0x40(%rbp), %r9d
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movl	$0xfffffffd, %eax       # imm = 0xFFFFFFFD
               	imulq	%r8, %rax
               	movq	%rdi, %rdx
               	subq	%rax, %rdx
               	movl	%edx, %r9d
               	movl	-0x40(%rbp), %r8d
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %r9
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
               	movl	$0x3, %r8d
               	movq	%r8, -0x38(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	imulq	$0x55555556, %rsi, %r9  # imm = 0x55555556
               	movq	%r9, %rdi
               	sarq	$0x20, %rdi
               	movq	%rdi, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdi,%rax), %rdx
               	movq	-0x38(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %rdx
               	jne	<addr>
               	movq	%rdx, %rax
               	imulq	%r8, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x38(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
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
               	movq	$-0x1, %r8
               	movq	%r8, -0x30(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movq	%rdi, %r9
               	subq	%rsi, %r9
               	movq	-0x30(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %r9
               	jne	<addr>
               	movq	%r9, %rax
               	imulq	%r8, %rax
               	movq	%rsi, %r9
               	subq	%rax, %r9
               	movq	-0x30(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %r9
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
               	movabsq	$0x100000000, %rax      # imm = 0x100000000
               	movq	%rax, -0x28(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movq	-0x28(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x28(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%r8d, %r8d
               	movq	%r8, %rsi
               	cmpl	$0x18, %esi
               	jge	<addr>
               	movq	$-0x80000000, %rdi      # imm = 0x80000000
               	movq	%rdi, -0x20(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rax
               	movslq	%eax, %rcx
               	movq	%rcx, %r9
               	shrq	$0x21, %r9
               	leaq	(%rcx,%r9), %rax
               	movq	%rax, %rdx
               	sarq	$0x1f, %rdx
               	movq	%r8, %rbx
               	subq	%rdx, %rbx
               	movq	-0x20(%rbp), %r12
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
               	xorl	%eax, %eax
               	subq	%rdx, %rax
               	imulq	%rdi, %rax
               	movq	%rcx, %r9
               	subq	%rax, %r9
               	movq	-0x20(%rbp), %rdi
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r9
               	jne	<addr>
               	incq	%rsi
               	cmpl	$0x18, %esi
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x7, %r9d
               	movq	%r9, -0x18(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movl	%esi, %edi
               	imulq	$0x24924925, %rdi, %rax # imm = 0x24924925
               	movq	%rax, %r8
               	shrq	$0x20, %r8
               	movq	%rdi, %rdx
               	subq	%r8, %rdx
               	movq	%rdx, %rbx
               	shrq	%rbx
               	addq	%r8, %rbx
               	shrq	$0x2, %rbx
               	movq	-0x18(%rbp), %r12
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	%r12, %rbx
               	jne	<addr>
               	movq	%rdx, %rax
               	shrq	%rax
               	addq	%r8, %rax
               	shrq	$0x2, %rax
               	imulq	%r9, %rax
               	movq	%rdi, %r8
               	subq	%rax, %r8
               	movl	%esi, %edi
               	movq	-0x18(%rbp), %rsi
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%r8d, %r8d
               	movq	%r8, %rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$-0x7, %r9
               	movq	%r9, -0x10(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movl	%esi, %edi
               	movabsq	$0x4924924924924925, %rax # imm = 0x4924924924924925
               	movq	%rax, %r10
               	movq	%rdi, %rax
               	imulq	%r10
               	movq	%rdx, %rax
               	sarq	%rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	negq	%rax
               	addq	%r8, %rax
               	movq	-0x10(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rdi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movabsq	$0x4924924924924925, %rax # imm = 0x4924924924924925
               	movq	%rax, %r10
               	movq	%rdi, %rax
               	imulq	%r10
               	movq	%rdx, %rax
               	sarq	%rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	xorl	%edx, %edx
               	subq	%rax, %rdx
               	movq	%rdx, %rax
               	imulq	%r9, %rax
               	movq	%rdi, %r9
               	subq	%rax, %r9
               	movq	-0x10(%rbp), %rsi
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	cmpq	%rdx, %r9
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
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	movq	%r8, -0x8(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movl	%esi, %edi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rdi, %r9
               	cmpq	%r11, %rdi
               	setae	%r9b
               	movzbq	%r9b, %r9
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rdi, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %r9
               	jne	<addr>
               	movq	%r9, %rax
               	imulq	%r8, %rax
               	movq	%rdi, %r8
               	subq	%rax, %r8
               	movq	-0x8(%rbp), %rsi
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
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
               	movq	%rax, %rdi
               	movslq	-0x10(%rbp), %rcx
               	movq	%r13, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %r8
               	movl	%r13d, %esi
               	movl	-0x8(%rbp), %ecx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	leaq	(%r8,%rdx), %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rdi
               	jne	<addr>
               	movslq	-0x18(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%ecx, %ecx
               	movq	%r13, %rax
               	cqto
               	idivq	%rcx
               	imulq	%rax, %rcx
               	movq	%r13, %rdx
               	subq	%rcx, %rdx
               	addq	%rdx, %rax
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
