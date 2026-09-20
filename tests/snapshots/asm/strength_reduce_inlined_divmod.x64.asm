
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
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0xa, %edi
               	movl	%edi, -0xa8(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	imulq	$0x66666667, %rsi, %rax # imm = 0x66666667
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %r8
               	movslq	-0xa8(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %rdi
               	movslq	-0xa8(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x7, %edi
               	movl	%edi, -0xa0(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movl	$0x92492493, %eax       # imm = 0x92492493
               	imulq	%rsi, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %r8
               	movslq	-0xa0(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %rdi
               	movslq	-0xa0(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
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
               	movq	$-0x7, %r8
               	movl	%r8d, -0x98(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movl	$0x92492493, %eax       # imm = 0x92492493
               	imulq	%rsi, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %r9
               	movq	%rdi, %rax
               	subq	%r9, %rax
               	movslq	-0x98(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	subq	%r9, %rax
               	imulq	%r8, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %r8
               	movslq	-0x98(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
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
               	movl	$0x1, -0x90(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movslq	-0x90(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rax, %rsi
               	jne	<addr>
               	movq	%rsi, %rax
               	subq	%rsi, %rax
               	movslq	%eax, %rdi
               	movslq	-0x90(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movl	$0xffffffff, -0x88(%rbp) # imm = 0xFFFFFFFF
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rax
               	movslq	%eax, %rcx
               	cmpl	$0x80000000, %ecx       # imm = 0x80000000
               	je	<addr>
               	movq	%rdi, %r8
               	subq	%rcx, %r8
               	movslq	-0x88(%rbp), %r9
               	movq	%rcx, %rax
               	cqto
               	idivq	%r9
               	cmpl	%eax, %r8d
               	jne	<addr>
               	leaq	(%rcx,%r8), %rax
               	movslq	%eax, %r8
               	movslq	-0x88(%rbp), %r9
               	movq	%rcx, %rax
               	cqto
               	idivq	%r9
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
               	movl	$0x2, -0x80(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movq	%rsi, %rax
               	shrq	$0x3f, %rax
               	addq	%rsi, %rax
               	movq	%rax, %rdi
               	sarq	%rdi
               	movslq	-0x80(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	movq	%rdi, %rax
               	shlq	%rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %rdi
               	movslq	-0x80(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	$-0x2, %r8
               	movl	%r8d, -0x78(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rax
               	movslq	%eax, %rcx
               	movq	%rcx, %rax
               	shrq	$0x3f, %rax
               	addq	%rcx, %rax
               	movq	%rax, %r9
               	sarq	%r9
               	movq	%rdi, %rax
               	subq	%r9, %rax
               	movslq	-0x78(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	subq	%r9, %rax
               	imulq	%r8, %rax
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %r8
               	movslq	-0x78(%rbp), %r9
               	movq	%rcx, %rax
               	cqto
               	idivq	%r9
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
               	movl	$0x400, -0x70(%rbp)     # imm = 0x400
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movq	%rsi, %rax
               	shrq	$0x36, %rax
               	addq	%rsi, %rax
               	movq	%rax, %rdi
               	sarq	$0xa, %rdi
               	movslq	-0x70(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	movq	%rdi, %rax
               	shlq	$0xa, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %rdi
               	movslq	-0x70(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x7fffffff, %edi       # imm = 0x7FFFFFFF
               	movl	%edi, -0x68(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	imulq	$0x40000001, %rsi, %rax # imm = 0x40000001
               	sarq	$0x3d, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %r8
               	movslq	-0x68(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %rdi
               	movslq	-0x68(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	$-0x80000000, %r8       # imm = 0x80000000
               	movl	%r8d, -0x60(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rax
               	movslq	%eax, %rcx
               	movq	%rcx, %rax
               	shrq	$0x21, %rax
               	addq	%rcx, %rax
               	movq	%rax, %r9
               	sarq	$0x1f, %r9
               	movq	%rdi, %rax
               	subq	%r9, %rax
               	movslq	-0x60(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	subq	%r9, %rax
               	imulq	%r8, %rax
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %r8
               	movslq	-0x60(%rbp), %r9
               	movq	%rcx, %rax
               	cqto
               	idivq	%r9
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
               	movq	%rdi, %rcx
               	movq	$-0x7fffffff, %r8       # imm = 0x80000001
               	movl	%r8d, -0x58(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	imulq	$0x40000001, %rsi, %rax # imm = 0x40000001
               	sarq	$0x3d, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %r9
               	movq	%rdi, %rax
               	subq	%r9, %rax
               	movslq	-0x58(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	subq	%r9, %rax
               	imulq	%r8, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %r8
               	movslq	-0x58(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
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
               	movl	$0xa, %edi
               	movl	%edi, -0x50(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %r8
               	movl	%r8d, %esi
               	movq	%rsi, %rax
               	shrq	%rax
               	imulq	$0x66666667, %rax, %rax # imm = 0x66666667
               	movq	%rax, %r9
               	shrq	$0x21, %r9
               	movl	-0x50(%rbp), %eax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpl	%eax, %r9d
               	jne	<addr>
               	movq	%r9, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movl	%edx, %esi
               	movl	%r8d, %edi
               	movl	-0x50(%rbp), %r8d
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x7, %r8d
               	movl	%r8d, -0x48(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %r9
               	movl	%r9d, %esi
               	imulq	$0x24924925, %rsi, %rax # imm = 0x24924925
               	movq	%rax, %rdi
               	shrq	$0x20, %rdi
               	movq	%rsi, %rax
               	subq	%rdi, %rax
               	movq	%rax, %rdx
               	shrq	%rdx
               	addq	%rdi, %rdx
               	shrq	$0x2, %rdx
               	movl	-0x48(%rbp), %ebx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpl	%ebx, %edx
               	jne	<addr>
               	shrq	%rax
               	addq	%rdi, %rax
               	shrq	$0x2, %rax
               	imulq	%r8, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movl	%edx, %esi
               	movl	%r9d, %edi
               	movl	-0x48(%rbp), %r8d
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x1, -0x40(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movl	%eax, %esi
               	movl	-0x40(%rbp), %edi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpl	%eax, %esi
               	jne	<addr>
               	movq	%rsi, %rax
               	subq	%rsi, %rax
               	movl	%eax, %edi
               	movl	-0x40(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x40, -0x38(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movl	%eax, %esi
               	movq	%rsi, %rdi
               	shrq	$0x6, %rdi
               	movl	-0x38(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpl	%eax, %edi
               	jne	<addr>
               	movq	%rdi, %rax
               	shlq	$0x6, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movl	%edx, %edi
               	movl	-0x38(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x80000000, -0x30(%rbp) # imm = 0x80000000
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movl	%eax, %esi
               	movq	%rsi, %rdi
               	shrq	$0x1f, %rdi
               	movl	-0x30(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpl	%eax, %edi
               	jne	<addr>
               	movq	%rdi, %rax
               	shlq	$0x1f, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movl	%edx, %edi
               	movl	-0x30(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x80000001, %edi       # imm = 0x80000001
               	movl	%edi, -0x28(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movl	%eax, %esi
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	movq	%rsi, %r8
               	cmpq	%r11, %rsi
               	setae	%r8b
               	movzbq	%r8b, %r8
               	movl	-0x28(%rbp), %r9d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movl	%edx, %edi
               	movl	-0x28(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0xfffffffe, %edi       # imm = 0xFFFFFFFE
               	movl	%edi, -0x20(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movl	%eax, %esi
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	movq	%rsi, %r8
               	cmpq	%r11, %rsi
               	setae	%r8b
               	movzbq	%r8b, %r8
               	movl	-0x20(%rbp), %r9d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movl	%edx, %edi
               	movl	-0x20(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	movl	%edi, -0x18(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movl	%eax, %esi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rsi, %r8
               	cmpq	%r11, %rsi
               	setae	%r8b
               	movzbq	%r8b, %r8
               	movl	-0x18(%rbp), %r9d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movl	%edx, %edi
               	movl	-0x18(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0xfffffffd, -0x10(%rbp) # imm = 0xFFFFFFFD
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movl	%eax, %esi
               	movl	$0xfffffffd, %r11d      # imm = 0xFFFFFFFD
               	movq	%rsi, %rdi
               	cmpq	%r11, %rsi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	-0x10(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpl	%eax, %edi
               	jne	<addr>
               	movl	$0xfffffffd, %eax       # imm = 0xFFFFFFFD
               	imulq	%rdi, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movl	%edx, %edi
               	movl	-0x10(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0xffffffff, -0x8(%rbp) # imm = 0xFFFFFFFF
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movl	%eax, %esi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rsi, %rdi
               	cmpq	%r11, %rsi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	-0x8(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpl	%eax, %edi
               	jne	<addr>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	imulq	%rdi, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movl	%edx, %edi
               	movl	-0x8(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
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
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	leave
               	retq

<wides>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0xa, %edi
               	movq	%rdi, -0xb0(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movabsq	$0x6666666666666667, %r8 # imm = 0x6666666666666667
               	movq	%rsi, %rax
               	imulq	%r8
               	movq	%rdx, %rax
               	sarq	$0x2, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %r8
               	movq	-0xb0(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	-0xb0(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
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
               	movq	$-0x3e8, %r9            # imm = 0xFC18
               	movq	%r9, -0xa8(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$0x20c49ba5e353f7cf, %rdi # imm = 0x20C49BA5E353F7CF
               	movq	%rcx, %rax
               	imulq	%rdi
               	movq	%rdx, %rdi
               	sarq	$0x7, %rdi
               	movq	%rdi, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdi,%rax), %rdx
               	negq	%rdx
               	addq	%r8, %rdx
               	movq	-0xa8(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %rdx
               	jne	<addr>
               	addq	%rdi, %rax
               	xorl	%edx, %edx
               	subq	%rax, %rdx
               	movq	%rdx, %rax
               	imulq	%r9, %rax
               	movq	%rcx, %rdi
               	subq	%rax, %rdi
               	movq	-0xa8(%rbp), %r9
               	movq	%rcx, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rsi
               	cmpl	$0x18, %esi
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%esi, %esi
               	movq	$0x1, -0xa0(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	-0xa0(%rbp), %rdi
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movq	%rcx, %rdi
               	subq	%rcx, %rdi
               	movq	-0xa0(%rbp), %r8
               	movq	%rcx, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
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
               	movq	$-0x1, -0x98(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rcx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rdi, %r8
               	subq	%rcx, %r8
               	movq	-0x98(%rbp), %r9
               	movq	%rcx, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rax, %r8
               	jne	<addr>
               	addq	%rcx, %r8
               	movq	-0x98(%rbp), %r9
               	movq	%rcx, %rax
               	cqto
               	idivq	%r9
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
               	movq	$0x1000, -0x90(%rbp)    # imm = 0x1000
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	shrq	$0x34, %rax
               	addq	%rcx, %rax
               	movq	%rax, %rdi
               	sarq	$0xc, %rdi
               	movq	-0x90(%rbp), %r8
               	movq	%rcx, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	movq	%rdi, %rax
               	shlq	$0xc, %rax
               	movq	%rcx, %rdi
               	subq	%rax, %rdi
               	movq	-0x90(%rbp), %r8
               	movq	%rcx, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rsi
               	cmpl	$0x18, %esi
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movabsq	$0x100000001, %rdi      # imm = 0x100000001
               	movq	%rdi, -0x88(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movabsq	$0x7fffffff80000001, %r8 # imm = 0x7FFFFFFF80000001
               	movq	%rsi, %rax
               	imulq	%r8
               	movq	%rdx, %rax
               	sarq	$0x1f, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %r8
               	movq	-0x88(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	-0x88(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movabsq	$0x7fffffffffffffff, %rdi # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rdi, -0x80(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movabsq	$0x4000000000000001, %r8 # imm = 0x4000000000000001
               	movq	%rsi, %rax
               	imulq	%r8
               	movq	%rdx, %rax
               	sarq	$0x3d, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %r8
               	movq	-0x80(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	-0x80(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movabsq	$-0x8000000000000000, %r8 # imm = 0x8000000000000000
               	movq	%r8, -0x78(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	shrq	%rax
               	addq	%rcx, %rax
               	movq	%rax, %r9
               	sarq	$0x3f, %r9
               	movq	%rdi, %rax
               	subq	%r9, %rax
               	movq	-0x78(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	subq	%r9, %rax
               	imulq	%r8, %rax
               	movq	%rcx, %r8
               	subq	%rax, %r8
               	movq	-0x78(%rbp), %r9
               	movq	%rcx, %rax
               	cqto
               	idivq	%r9
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
               	movl	$0xa, %edi
               	movq	%rdi, -0x70(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	shrq	%rax
               	movabsq	$0x6666666666666667, %r8 # imm = 0x6666666666666667
               	mulq	%r8
               	movq	%rdx, %r8
               	shrq	%r8
               	movq	-0x70(%rbp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	-0x70(%rbp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%esi, %esi
               	movl	$0x7, %edi
               	movq	%rdi, -0x68(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$0x2492492492492493, %r8 # imm = 0x2492492492492493
               	movq	%rcx, %rax
               	mulq	%r8
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	shrq	%rax
               	leaq	(%rax,%rdx), %r8
               	movq	%r8, %r9
               	shrq	$0x2, %r9
               	movq	-0x68(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpq	%rax, %r9
               	jne	<addr>
               	movq	%r8, %rax
               	shrq	$0x2, %rax
               	imulq	%rdi, %rax
               	movq	%rcx, %rdi
               	subq	%rax, %rdi
               	movq	-0x68(%rbp), %r8
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rsi
               	cmpl	$0x18, %esi
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
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
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	-0x60(%rbp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
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
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	-0x58(%rbp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
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
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	-0x50(%rbp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movq	$-0x1, -0x48(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	cmpq	$-0x1, %rsi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	-0x48(%rbp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	addq	%rsi, %rdi
               	movq	-0x48(%rbp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
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
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	-0x40(%rbp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0xa, %edi
               	movq	%rdi, -0x38(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movabsq	$0x6666666666666667, %r8 # imm = 0x6666666666666667
               	movq	%rsi, %rax
               	imulq	%r8
               	movq	%rdx, %rax
               	sarq	$0x2, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %r8
               	movq	-0x38(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	-0x38(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
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
               	movq	$-0x7, %r9
               	movq	%r9, -0x30(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$0x4924924924924925, %rdi # imm = 0x4924924924924925
               	movq	%rcx, %rax
               	imulq	%rdi
               	movq	%rdx, %rdi
               	sarq	%rdi
               	movq	%rdi, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdi,%rax), %rdx
               	negq	%rdx
               	addq	%r8, %rdx
               	movq	-0x30(%rbp), %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rbx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	%rbx, %rdx
               	jne	<addr>
               	addq	%rdi, %rax
               	xorl	%edx, %edx
               	subq	%rax, %rdx
               	movq	%rdx, %rax
               	imulq	%r9, %rax
               	movq	%rcx, %rdi
               	subq	%rax, %rdi
               	movq	-0x30(%rbp), %r9
               	movq	%rcx, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rsi
               	cmpl	$0x18, %esi
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%esi, %esi
               	movq	$0x40000000, -0x28(%rbp) # imm = 0x40000000
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	shrq	$0x22, %rax
               	addq	%rcx, %rax
               	movq	%rax, %rdi
               	sarq	$0x1e, %rdi
               	movq	-0x28(%rbp), %r8
               	movq	%rcx, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	movq	%rdi, %rax
               	shlq	$0x1e, %rax
               	movq	%rcx, %rdi
               	subq	%rax, %rdi
               	movq	-0x28(%rbp), %r8
               	movq	%rcx, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
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
               	movq	$-0x1, -0x20(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rcx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rdi, %r8
               	subq	%rcx, %r8
               	movq	-0x20(%rbp), %r9
               	movq	%rcx, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rax, %r8
               	jne	<addr>
               	addq	%rcx, %r8
               	movq	-0x20(%rbp), %r9
               	movq	%rcx, %rax
               	cqto
               	idivq	%r9
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
               	movl	$0xa, %edi
               	movq	%rdi, -0x18(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	shrq	%rax
               	movabsq	$0x6666666666666667, %r8 # imm = 0x6666666666666667
               	mulq	%r8
               	movq	%rdx, %r8
               	shrq	%r8
               	movq	-0x18(%rbp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	-0x18(%rbp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
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
               	movq	%rdx, %r8
               	shrq	$0x1d, %r8
               	movq	-0x10(%rbp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	-0x10(%rbp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
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
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	-0x8(%rbp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
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
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	leave
               	retq

<converted>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x98, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x3, %edi
               	movb	%dil, -0x88(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movsbq	%al, %rsi
               	imulq	$0x55555556, %rsi, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %r8
               	movsbq	-0x88(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %rdi
               	movsbq	-0x88(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	$-0x80, %r8
               	movb	%r8b, -0x80(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rax
               	movsbq	%al, %rcx
               	movq	%rcx, %rax
               	shrq	$0x39, %rax
               	addq	%rcx, %rax
               	movq	%rax, %r9
               	sarq	$0x7, %r9
               	movq	%rdi, %rax
               	subq	%r9, %rax
               	movsbq	-0x80(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpl	%edx, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	subq	%r9, %rax
               	imulq	%r8, %rax
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %r8
               	movsbq	-0x80(%rbp), %r9
               	movq	%rcx, %rax
               	cqto
               	idivq	%r9
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
               	movq	%rdi, %rcx
               	movb	$-0x1, -0x78(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movsbq	%al, %rsi
               	movq	%rdi, %r8
               	subq	%rsi, %r8
               	movsbq	-0x78(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpl	%eax, %r8d
               	jne	<addr>
               	addq	%rsi, %r8
               	movsbq	-0x78(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
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
               	movl	$0x3, %edi
               	movb	%dil, -0x70(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movq	%rax, %rsi
               	andq	$0xff, %rsi
               	imulq	$0x55555556, %rsi, %rax # imm = 0x55555556
               	movq	%rax, %r8
               	shrq	$0x20, %r8
               	movzbq	-0x70(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %rdi
               	movzbq	-0x70(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0xff, %edi
               	movb	%dil, -0x68(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movq	%rax, %rsi
               	andq	$0xff, %rsi
               	imulq	$0x1010102, %rsi, %rax  # imm = 0x1010102
               	movq	%rax, %r8
               	shrq	$0x20, %r8
               	movzbq	-0x68(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %rdi
               	movzbq	-0x68(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0xa, %edi
               	movw	%di, -0x60(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movswq	%ax, %rsi
               	imulq	$0x66666667, %rsi, %rax # imm = 0x66666667
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %r8
               	movswq	-0x60(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %rdi
               	movswq	-0x60(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	$-0x8000, %r8           # imm = 0x8000
               	movw	%r8w, -0x58(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rax
               	movswq	%ax, %rcx
               	movq	%rcx, %rax
               	shrq	$0x31, %rax
               	addq	%rcx, %rax
               	movq	%rax, %r9
               	sarq	$0xf, %r9
               	movq	%rdi, %rax
               	subq	%r9, %rax
               	movswq	-0x58(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpl	%edx, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	subq	%r9, %rax
               	imulq	%r8, %rax
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %r8
               	movswq	-0x58(%rbp), %r9
               	movq	%rcx, %rax
               	cqto
               	idivq	%r9
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
               	movl	$0x3, %edi
               	movl	%edi, -0x50(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %r8
               	movl	%r8d, %esi
               	movl	$0xaaaaaaab, %eax       # imm = 0xAAAAAAAB
               	imulq	%rsi, %rax
               	movq	%rax, %r9
               	shrq	$0x21, %r9
               	movl	-0x50(%rbp), %eax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpl	%eax, %r9d
               	jne	<addr>
               	movq	%r9, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movl	%edx, %esi
               	movl	-0x50(%rbp), %edi
               	movl	%r8d, %r8d
               	movq	%r8, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x80000000, -0x48(%rbp) # imm = 0x80000000
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movl	%eax, %esi
               	movq	%rsi, %rdi
               	shrq	$0x1f, %rdi
               	movl	-0x48(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpl	%eax, %edi
               	jne	<addr>
               	movq	%rdi, %rax
               	shlq	$0x1f, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movl	%edx, %edi
               	movl	-0x48(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0xfffffffd, -0x40(%rbp) # imm = 0xFFFFFFFD
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movl	%eax, %esi
               	movl	$0xfffffffd, %r11d      # imm = 0xFFFFFFFD
               	movq	%rsi, %rdi
               	cmpq	%r11, %rsi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	-0x40(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpl	%eax, %edi
               	jne	<addr>
               	movl	$0xfffffffd, %eax       # imm = 0xFFFFFFFD
               	imulq	%rdi, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movl	%edx, %edi
               	movl	-0x40(%rbp), %r8d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x3, %edi
               	movq	%rdi, -0x38(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	imulq	$0x55555556, %rsi, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %r8
               	movq	-0x38(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	-0x38(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
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
               	movq	$-0x1, -0x30(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movq	%rdi, %r8
               	subq	%rsi, %r8
               	movq	-0x30(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rax, %r8
               	jne	<addr>
               	addq	%rsi, %r8
               	movq	-0x30(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
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
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	$-0x80000000, %r8       # imm = 0x80000000
               	movq	%r8, -0x20(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rax
               	movslq	%eax, %rcx
               	movq	%rcx, %rax
               	shrq	$0x21, %rax
               	addq	%rcx, %rax
               	movq	%rax, %r9
               	sarq	$0x1f, %r9
               	movq	%rdi, %rax
               	subq	%r9, %rax
               	movq	-0x20(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	subq	%r9, %rax
               	imulq	%r8, %rax
               	movq	%rcx, %r8
               	subq	%rax, %r8
               	movq	-0x20(%rbp), %r9
               	movq	%rcx, %rax
               	cqto
               	idivq	%r9
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
               	movl	$0x7, %r8d
               	movq	%r8, -0x18(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %r9
               	movl	%r9d, %esi
               	imulq	$0x24924925, %rsi, %rax # imm = 0x24924925
               	movq	%rax, %rdi
               	shrq	$0x20, %rdi
               	movq	%rsi, %rax
               	subq	%rdi, %rax
               	movq	%rax, %rdx
               	shrq	%rdx
               	addq	%rdi, %rdx
               	shrq	$0x2, %rdx
               	movq	-0x18(%rbp), %rbx
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
               	shrq	%rax
               	addq	%rdi, %rax
               	shrq	$0x2, %rax
               	imulq	%r8, %rax
               	subq	%rax, %rsi
               	movl	%r9d, %edi
               	movq	-0x18(%rbp), %r8
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	$-0x7, %r8
               	movq	%r8, -0x10(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rax
               	movl	%eax, %ecx
               	movabsq	$0x4924924924924925, %r9 # imm = 0x4924924924924925
               	movq	%rcx, %rax
               	imulq	%r9
               	movq	%rdx, %rax
               	sarq	%rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	movq	%rdi, %r9
               	subq	%rax, %r9
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %r9
               	jne	<addr>
               	movabsq	$0x4924924924924925, %r9 # imm = 0x4924924924924925
               	movq	%rcx, %rax
               	imulq	%r9
               	movq	%rdx, %rax
               	sarq	%rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	xorl	%edx, %edx
               	subq	%rax, %rdx
               	movq	%rdx, %rax
               	imulq	%r8, %rax
               	movq	%rcx, %r8
               	subq	%rax, %r8
               	movq	-0x10(%rbp), %r9
               	movq	%rcx, %rax
               	cqto
               	idivq	%r9
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
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	movq	%rdi, -0x8(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movl	%eax, %esi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rsi, %r8
               	cmpq	%r11, %rsi
               	setae	%r8b
               	movzbq	%r8b, %r8
               	movq	-0x8(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	-0x8(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
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
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
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
               	retq

<others>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	movl	%ebx, -0x18(%rbp)
               	movl	$0x7, -0x10(%rbp)
               	movl	$0x3e8, -0x8(%rbp)      # imm = 0x3E8
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%rbx, %r12
               	leaq	<rip>, %rax
               	movq	(%rax,%r12,8), %rdi
               	movslq	%edi, %r13
               	movl	$0x7, %esi
               	movl	$0x3e8, %edx            # imm = 0x3E8
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	-0x10(%rbp), %rsi
               	movq	%r13, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %rsi
               	movl	%r13d, %edi
               	movl	-0x8(%rbp), %r8d
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	leaq	(%rsi,%rdx), %rax
               	cmpl	%eax, %ecx
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
               	movq	%rbx, %rax
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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	popq	%rbp
               	retq
