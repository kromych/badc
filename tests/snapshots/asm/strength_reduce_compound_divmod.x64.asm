
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
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0xa, -0xe0(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	imulq	$0x66666667, %rsi, %rax # imm = 0x66666667
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	imulq	$0xa, %rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movslq	-0xe0(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	movslq	-0xe0(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x7, -0xd8(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movl	$0x92492493, %eax       # imm = 0x92492493
               	imulq	%rsi, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	imulq	$0x7, %rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movslq	-0xd8(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	movslq	-0xd8(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%edx, %r8d
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
               	movl	$0xfffffff9, -0xd0(%rbp) # imm = 0xFFFFFFF9
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movl	$0x92492493, %eax       # imm = 0x92492493
               	imulq	%rsi, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	movq	%rdi, %r8
               	subq	%rax, %r8
               	imulq	$-0x7, %r8, %rax
               	movq	%rsi, %r9
               	subq	%rax, %r9
               	movslq	-0xd0(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movslq	-0xd0(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	cmpl	%eax, %r8d
               	jne	<addr>
               	cmpl	%edx, %r9d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x10, -0xc8(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movq	%rsi, %rax
               	shrq	$0x3c, %rax
               	leaq	(%rsi,%rax), %rdx
               	movq	%rdx, %rdi
               	sarq	$0x4, %rdi
               	andq	$0xf, %rdx
               	movq	%rdx, %r8
               	subq	%rax, %r8
               	movslq	-0xc8(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	movslq	-0xc8(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%edx, %r8d
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
               	movl	$0xfffffff0, -0xc0(%rbp) # imm = 0xFFFFFFF0
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movq	%rsi, %rax
               	shrq	$0x3c, %rax
               	leaq	(%rsi,%rax), %rdx
               	movq	%rdx, %r8
               	sarq	$0x4, %r8
               	movq	%rdi, %r9
               	subq	%r8, %r9
               	andq	$0xf, %rdx
               	movq	%rdx, %r8
               	subq	%rax, %r8
               	movslq	-0xc0(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movslq	-0xc0(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	cmpl	%eax, %r9d
               	jne	<addr>
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x1, -0xb8(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movslq	-0xb8(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	movslq	-0xb8(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpl	%edi, %esi
               	jne	<addr>
               	testl	%edx, %edx
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
               	movl	$0xffffffff, -0xb0(%rbp) # imm = 0xFFFFFFFF
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	cmpl	$0x80000000, %esi       # imm = 0x80000000
               	je	<addr>
               	movq	%rdi, %r8
               	subq	%rsi, %r8
               	movslq	-0xb0(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	movslq	-0xb0(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x7fffffff, -0xa8(%rbp) # imm = 0x7FFFFFFF
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	imulq	$0x40000001, %rsi, %rax # imm = 0x40000001
               	sarq	$0x3d, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	imulq	$0x7fffffff, %rdi, %rax # imm = 0x7FFFFFFF
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movslq	-0xa8(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	movslq	-0xa8(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%edx, %r8d
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
               	movl	$0x80000000, -0xa0(%rbp) # imm = 0x80000000
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movq	%rsi, %rax
               	shrq	$0x21, %rax
               	leaq	(%rsi,%rax), %rdx
               	movq	%rdx, %r8
               	sarq	$0x1f, %r8
               	movq	%rdi, %r9
               	subq	%r8, %r9
               	andq	$0x7fffffff, %rdx       # imm = 0x7FFFFFFF
               	movq	%rdx, %r8
               	subq	%rax, %r8
               	movslq	-0xa0(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movslq	-0xa0(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	cmpl	%eax, %r9d
               	jne	<addr>
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0xa, -0x98(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movl	%eax, %esi
               	movq	%rsi, %rax
               	shrq	%rax
               	imulq	$0x66666667, %rax, %rax # imm = 0x66666667
               	movq	%rax, %rdi
               	shrq	$0x21, %rdi
               	imulq	$0xa, %rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movl	-0x98(%rbp), %r9d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	movl	-0x98(%rbp), %eax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x7, -0x90(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rdx
               	movl	%edx, %eax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	movq	%rax, %rdi
               	subq	%rsi, %rdi
               	shrq	%rdi
               	addq	%rdi, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x2, %rdi
               	shrq	$0x2, %rsi
               	imulq	$0x7, %rsi, %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movl	%edx, %esi
               	movl	-0x90(%rbp), %r9d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	movl	-0x90(%rbp), %eax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x8, -0x88(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movl	%eax, %esi
               	movq	%rsi, %rdi
               	shrq	$0x3, %rdi
               	movq	%rax, %r8
               	andq	$0x7, %r8
               	movl	-0x88(%rbp), %r9d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	movl	-0x88(%rbp), %eax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x1, -0x80(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movl	%esi, %edi
               	movl	-0x80(%rbp), %r8d
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %r8
               	movl	-0x80(%rbp), %r9d
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	cmpl	%r8d, %esi
               	jne	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x80000001, -0x78(%rbp) # imm = 0x80000001
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	movq	%rax, %rdi
               	cmpl	%r11d, %eax
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	%eax, %esi
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	setae	%al
               	movzbq	%al, %rax
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	imulq	%r11, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movl	-0x78(%rbp), %r9d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	movl	-0x78(%rbp), %eax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0xee6b2800, -0x70(%rbp) # imm = 0xEE6B2800
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	movq	%rax, %rdi
               	cmpl	%r11d, %eax
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	%eax, %esi
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	setae	%al
               	movzbq	%al, %rax
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	imulq	%r11, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movl	-0x70(%rbp), %r9d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	movl	-0x70(%rbp), %eax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0xffffffff, -0x68(%rbp) # imm = 0xFFFFFFFF
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rax, %rdi
               	cmpl	%r11d, %eax
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	%eax, %esi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	setae	%al
               	movzbq	%al, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	imulq	%r11, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movl	-0x68(%rbp), %r9d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	movl	-0x68(%rbp), %eax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movq	$0xa, -0x60(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movabsq	$0x6666666666666667, %rdi # imm = 0x6666666666666667
               	movq	%rsi, %rax
               	imulq	%rdi
               	movq	%rdx, %rax
               	sarq	$0x2, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	imulq	$0xa, %rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x60(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	movq	-0x60(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpq	%r9, %rdi
               	jne	<addr>
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
               	movq	%rdi, %rsi
               	movq	$-0x3e8, -0x58(%rbp)    # imm = 0xFC18
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$0x20c49ba5e353f7cf, %r8 # imm = 0x20C49BA5E353F7CF
               	movq	%rcx, %rax
               	imulq	%r8
               	movq	%rdx, %rax
               	sarq	$0x7, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	movq	%rdi, %r8
               	subq	%rax, %r8
               	imulq	$-0x3e8, %r8, %rax      # imm = 0xFC18
               	movq	%rcx, %r9
               	subq	%rax, %r9
               	movq	-0x58(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	-0x58(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	cmpq	%rax, %r8
               	jne	<addr>
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
               	movq	$0x1000, -0x50(%rbp)    # imm = 0x1000
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	sarq	$0x3f, %rax
               	shrq	$0x34, %rax
               	leaq	(%rsi,%rax), %rdx
               	movq	%rdx, %rdi
               	sarq	$0xc, %rdi
               	andq	$0xfff, %rdx            # imm = 0xFFF
               	movq	%rdx, %r8
               	subq	%rax, %r8
               	movq	-0x50(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	movq	-0x50(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpq	%r9, %rdi
               	jne	<addr>
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
               	movq	$-0x1, -0x48(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movq	%rdi, %r8
               	subq	%rsi, %r8
               	movq	-0x48(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	movq	-0x48(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpq	%r9, %r8
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
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, -0x40(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	shrq	%rax
               	leaq	(%rcx,%rax), %rdx
               	movq	%rdx, %r8
               	sarq	$0x3f, %r8
               	movq	%rdi, %r9
               	subq	%r8, %r9
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%r11, %rdx
               	movq	%rdx, %r8
               	subq	%rax, %r8
               	movq	-0x40(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	-0x40(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	cmpq	%rax, %r9
               	jne	<addr>
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
               	movq	$0xa, -0x38(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	shrq	%rax
               	movabsq	$0x6666666666666667, %rdi # imm = 0x6666666666666667
               	mulq	%rdi
               	movq	%rdx, %rdi
               	shrq	%rdi
               	imulq	$0xa, %rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x38(%rbp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	movq	-0x38(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpq	%r9, %rdi
               	jne	<addr>
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%esi, %esi
               	movq	$0x7, -0x30(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$0x2492492492492493, %rdi # imm = 0x2492492492492493
               	movq	%rcx, %rax
               	mulq	%rdi
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	shrq	%rax
               	addq	%rdx, %rax
               	movq	%rax, %rdi
               	shrq	$0x2, %rdi
               	imulq	$0x7, %rdi, %rax
               	movq	%rcx, %r8
               	subq	%rax, %r8
               	movq	-0x30(%rbp), %r9
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	movq	-0x30(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpq	%r9, %rdi
               	jne	<addr>
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
               	movabsq	$-0x7fffffffffffffff, %rax # imm = 0x8000000000000001
               	movq	%rax, -0x28(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movabsq	$-0x7fffffffffffffff, %r11 # imm = 0x8000000000000001
               	movq	%rsi, %rdi
               	cmpq	%r11, %rsi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movabsq	$-0x7fffffffffffffff, %rax # imm = 0x8000000000000001
               	imulq	%rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x28(%rbp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	movq	-0x28(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpq	%r9, %rdi
               	jne	<addr>
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%esi, %esi
               	movq	$0x64, -0x20(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$-0x5c28f5c28f5c28f5, %rdi # imm = 0xA3D70A3D70A3D70B
               	movq	%rcx, %rax
               	imulq	%rdi
               	leaq	(%rdx,%rcx), %rax
               	sarq	$0x6, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	imulq	$0x64, %rdi, %rax
               	movq	%rcx, %r8
               	subq	%rax, %r8
               	movq	-0x20(%rbp), %r9
               	movq	%rcx, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	movq	-0x20(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	cmpq	%r9, %rdi
               	jne	<addr>
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
               	movq	$-0x3, -0x18(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$0x5555555555555556, %r8 # imm = 0x5555555555555556
               	movq	%rcx, %rax
               	imulq	%r8
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	addq	%rdx, %rax
               	movq	%rdi, %r8
               	subq	%rax, %r8
               	imulq	$-0x3, %r8, %rax
               	movq	%rcx, %r9
               	subq	%rax, %r9
               	movq	-0x18(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	-0x18(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	cmpq	%rax, %r8
               	jne	<addr>
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
               	movq	$0x64, -0x10(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	shrq	$0x2, %rax
               	movabsq	$0x28f5c28f5c28f5c3, %rdi # imm = 0x28F5C28F5C28F5C3
               	mulq	%rdi
               	movq	%rdx, %rdi
               	shrq	$0x2, %rdi
               	imulq	$0x64, %rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x10(%rbp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpq	%r9, %rdi
               	jne	<addr>
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%esi, %esi
               	movq	$0x7, -0x8(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$0x2492492492492493, %rdi # imm = 0x2492492492492493
               	movq	%rcx, %rax
               	mulq	%rdi
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	shrq	%rax
               	addq	%rdx, %rax
               	movq	%rax, %rdi
               	shrq	$0x2, %rdi
               	imulq	$0x7, %rdi, %rax
               	movq	%rcx, %r8
               	subq	%rax, %r8
               	movq	-0x8(%rbp), %r9
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpq	%r9, %rdi
               	jne	<addr>
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rsi
               	cmpl	$0x18, %esi
               	jl	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq

<converted>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x3, -0xa8(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movsbq	%al, %rsi
               	imulq	$0x55555556, %rsi, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	leaq	(%rdi,%rdi,2), %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movslq	-0xa8(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	movsbq	%al, %r9
               	movslq	-0xa8(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movsbq	%dl, %rax
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%eax, %r8d
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
               	movl	$0xfffffffb, -0xa0(%rbp) # imm = 0xFFFFFFFB
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movsbq	%al, %rsi
               	imulq	$0x66666667, %rsi, %rax # imm = 0x66666667
               	sarq	$0x21, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	movq	%rdi, %r8
               	subq	%rax, %r8
               	imulq	$-0x5, %r8, %rax
               	movq	%rsi, %r9
               	subq	%rax, %r9
               	movslq	-0xa0(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movsbq	%al, %rax
               	movslq	-0xa0(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	movsbq	%dl, %rdx
               	cmpl	%eax, %r8d
               	jne	<addr>
               	cmpl	%edx, %r9d
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
               	movl	$0xffffffff, -0x98(%rbp) # imm = 0xFFFFFFFF
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movsbq	%al, %rsi
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	movsbq	%al, %r8
               	movslq	-0x98(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	movsbq	%al, %r9
               	movslq	-0x98(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movsbq	%dl, %rax
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x3, -0x90(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movq	%rax, %rsi
               	andq	$0xff, %rsi
               	imulq	$0x55555556, %rsi, %rax # imm = 0x55555556
               	movq	%rax, %rdi
               	shrq	$0x20, %rdi
               	leaq	(%rdi,%rdi,2), %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movslq	-0x90(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	andq	$0xff, %r9
               	movslq	-0x90(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpl	%r9d, %edi
               	jne	<addr>
               	movq	%rdx, %rax
               	andq	$0xff, %rax
               	cmpl	%eax, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x10, -0x88(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movq	%rax, %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x4, %rdi
               	movq	%rsi, %r8
               	andq	$0xf, %r8
               	movslq	-0x88(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	andq	$0xff, %r9
               	movslq	-0x88(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpl	%r9d, %edi
               	jne	<addr>
               	movq	%rdx, %rax
               	andq	$0xff, %rax
               	cmpl	%eax, %r8d
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
               	movl	$0xfffffff9, -0x80(%rbp) # imm = 0xFFFFFFF9
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movq	%rax, %rsi
               	andq	$0xff, %rsi
               	movl	$0x92492493, %eax       # imm = 0x92492493
               	imulq	%rsi, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rax, %rdx
               	movq	%rdi, %rax
               	subq	%rdx, %rax
               	movq	%rax, %r8
               	andq	$0xff, %r8
               	imulq	$-0x7, %rax, %rax
               	movq	%rsi, %r9
               	subq	%rax, %r9
               	movslq	-0x80(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	andq	$0xff, %rax
               	movslq	-0x80(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movq	%rdx, %rax
               	andq	$0xff, %rax
               	cmpl	%eax, %r9d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0xa, -0x78(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movswq	%ax, %rsi
               	imulq	$0x66666667, %rsi, %rax # imm = 0x66666667
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	imulq	$0xa, %rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movslq	-0x78(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	movswq	%ax, %r9
               	movslq	-0x78(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movswq	%dx, %rax
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%eax, %r8d
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
               	movl	$0xffffffff, -0x70(%rbp) # imm = 0xFFFFFFFF
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movswq	%ax, %rsi
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	movswq	%ax, %r8
               	movslq	-0x70(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	movswq	%ax, %r9
               	movslq	-0x70(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movswq	%dx, %rax
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x3e8, -0x68(%rbp)     # imm = 0x3E8
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movq	%rax, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	imulq	$0x418938, %rsi, %rax   # imm = 0x418938
               	movq	%rax, %rdi
               	shrq	$0x20, %rdi
               	imulq	$0x3e8, %rdi, %rax      # imm = 0x3E8
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movslq	-0x68(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	movslq	-0x68(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpl	%r9d, %edi
               	jne	<addr>
               	movq	%rdx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	%eax, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x7, -0x60(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movq	%rax, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	imulq	$0x24924925, %rsi, %rax # imm = 0x24924925
               	movq	%rax, %rdi
               	shrq	$0x20, %rdi
               	imulq	$0x7, %rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movl	-0x60(%rbp), %r9d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	movl	-0x60(%rbp), %eax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpl	%r9d, %edi
               	jne	<addr>
               	movq	%rdx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	%eax, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x3, -0x58(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movl	%eax, %esi
               	movl	$0xaaaaaaab, %eax       # imm = 0xAAAAAAAB
               	imulq	%rsi, %rax
               	movq	%rax, %rdi
               	shrq	$0x21, %rdi
               	leaq	(%rdi,%rdi,2), %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movl	-0x58(%rbp), %r9d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	movl	-0x58(%rbp), %eax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x80000000, -0x50(%rbp) # imm = 0x80000000
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movl	%eax, %esi
               	movq	%rsi, %rdi
               	shrq	$0x1f, %rdi
               	movq	%rax, %r8
               	andq	$0x7fffffff, %r8        # imm = 0x7FFFFFFF
               	movl	-0x50(%rbp), %r9d
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	movl	-0x50(%rbp), %eax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movq	$0x3, -0x48(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	imulq	$0x55555556, %rsi, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	leaq	(%rdi,%rdi,2), %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x48(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	movq	-0x48(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%edx, %r8d
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
               	movq	%rax, -0x40(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movq	-0x40(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	movq	-0x40(%rbp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	testl	%edi, %edi
               	jne	<addr>
               	cmpl	%edx, %esi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movq	$0x7, -0x38(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movabsq	$0x2492492492492493, %rdi # imm = 0x2492492492492493
               	movq	%rsi, %rax
               	mulq	%rdi
               	movq	%rsi, %rax
               	subq	%rdx, %rax
               	shrq	%rax
               	addq	%rdx, %rax
               	movq	%rax, %rdi
               	shrq	$0x2, %rdi
               	imulq	$0x7, %rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x38(%rbp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	movq	-0x38(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movq	$0x7, -0x30(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rdx
               	movl	%edx, %eax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	movq	%rax, %rdi
               	subq	%rsi, %rdi
               	shrq	%rdi
               	addq	%rdi, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x2, %rdi
               	shrq	$0x2, %rsi
               	imulq	$0x7, %rsi, %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movl	%edx, %esi
               	movq	-0x30(%rbp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	movq	-0x30(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%edx, %r8d
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
               	movq	$-0x7, -0x28(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %r8
               	movl	%r8d, %r9d
               	movabsq	$0x4924924924924925, %rsi # imm = 0x4924924924924925
               	movq	%r9, %rax
               	imulq	%rsi
               	movq	%rdx, %rsi
               	sarq	%rsi
               	movq	%rsi, %rax
               	shrq	$0x3f, %rax
               	addq	%rsi, %rax
               	negq	%rax
               	addq	%rdi, %rax
               	movq	%rsi, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rsi, %rdx
               	movq	%rdi, %rsi
               	subq	%rdx, %rsi
               	imulq	$-0x7, %rsi, %rdx
               	subq	%rdx, %r9
               	movl	%r8d, %esi
               	movq	-0x28(%rbp), %r8
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %r8
               	popq	%rax
               	movq	-0x28(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	cmpl	%r8d, %eax
               	jne	<addr>
               	cmpl	%edx, %r9d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movq	$0xa, -0x20(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movl	%eax, %esi
               	movq	%rsi, %rax
               	shrq	%rax
               	imulq	$0x66666667, %rax, %rax # imm = 0x66666667
               	movq	%rax, %rdi
               	shrq	$0x21, %rdi
               	imulq	$0xa, %rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x20(%rbp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	movq	-0x20(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movq	$0x9, -0x18(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movswq	%ax, %rsi
               	movabsq	$-0x1c71c71c71c71c71, %rdi # imm = 0xE38E38E38E38E38F
               	movq	%rsi, %rax
               	mulq	%rdi
               	movq	%rdx, %rax
               	shrq	$0x3, %rax
               	movswq	%ax, %rdi
               	leaq	(%rax,%rax,8), %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	-0x18(%rbp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movswq	%ax, %r9
               	movq	-0x18(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	movswq	%dx, %rax
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%eax, %r8d
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
               	movl	$0xfffffff6, -0x10(%rbp) # imm = 0xFFFFFFF6
               	leaq	<rip>, %rax
               	movq	(%rax,%rsi,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$0x6666666666666667, %r8 # imm = 0x6666666666666667
               	movq	%rcx, %rax
               	imulq	%r8
               	movq	%rdx, %rax
               	sarq	$0x2, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	movq	%rdi, %r8
               	subq	%rax, %r8
               	imulq	$-0xa, %r8, %rax
               	movq	%rcx, %r9
               	subq	%rax, %r9
               	movslq	-0x10(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movslq	-0x10(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	cmpq	%rax, %r8
               	jne	<addr>
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
               	movl	$0xa, -0x8(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	shrq	%rax
               	movabsq	$0x6666666666666667, %rdi # imm = 0x6666666666666667
               	mulq	%rdi
               	movq	%rdx, %rdi
               	shrq	%rdi
               	imulq	$0xa, %rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movslq	-0x8(%rbp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpq	%r9, %rdi
               	jne	<addr>
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
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
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rsi
               	movq	(%rsi,%rcx,8), %rax
               	movl	%eax, -0x28(%rbp)
               	movq	(%rsi,%rcx,8), %rax
               	movl	%eax, -0x20(%rbp)
               	movl	$0xa, -0x18(%rbp)
               	movslq	-0x28(%rbp), %rax
               	imulq	$0x66666667, %rax, %rax # imm = 0x66666667
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	movl	%eax, -0x28(%rbp)
               	movslq	-0x20(%rbp), %rax
               	movslq	-0x18(%rbp), %rdi
               	cqto
               	idivq	%rdi
               	movl	%eax, -0x20(%rbp)
               	movslq	-0x28(%rbp), %rax
               	movslq	-0x20(%rbp), %rdx
               	cmpl	%edx, %eax
               	jne	<addr>
               	movq	(%rsi,%rcx,8), %rax
               	movl	%eax, -0x28(%rbp)
               	movq	(%rsi,%rcx,8), %rax
               	movl	%eax, -0x20(%rbp)
               	movslq	-0x28(%rbp), %rax
               	imulq	$0x66666667, %rax, %rdx # imm = 0x66666667
               	sarq	$0x22, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rdx
               	imulq	$0xa, %rdx, %rdx
               	subq	%rdx, %rax
               	movl	%eax, -0x28(%rbp)
               	movslq	-0x20(%rbp), %rsi
               	movslq	-0x18(%rbp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movl	%edx, -0x20(%rbp)
               	movslq	-0x28(%rbp), %rax
               	movslq	-0x20(%rbp), %rdx
               	cmpl	%edx, %eax
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
               	leaq	-0x88(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rax,8), %rdx
               	movl	%edx, (%rcx,%rax,4)
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	xorl	%edi, %edi
               	movq	%rdi, %rcx
               	movl	$0xfffffff7, -0x10(%rbp) # imm = 0xFFFFFFF7
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rax
               	movslq	-0x10(%rbp), %rsi
               	cqto
               	idivq	%rsi
               	leaq	-0x88(%rbp), %rsi
               	movslq	(%rsi,%rcx,4), %rdx
               	imulq	$0x38e38e39, %rdx, %rdx # imm = 0x38E38E39
               	sarq	$0x21, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	addq	%rdx, %r8
               	movq	%rdi, %rdx
               	subq	%r8, %rdx
               	movl	%edx, (%rsi,%rcx,4)
               	cmpl	%eax, %edx
               	jne	<addr>
               	movslq	(%rsi,%rcx,4), %rdx
               	cmpl	%eax, %edx
               	jne	<addr>
               	movslq	%eax, %r8
               	movslq	-0x10(%rbp), %r9
               	movq	%r8, %rax
               	cqto
               	idivq	%r9
               	movq	%rdx, %r8
               	movslq	(%rsi,%rcx,4), %rax
               	imulq	$0x38e38e39, %rax, %rdx # imm = 0x38E38E39
               	sarq	$0x21, %rdx
               	movq	%rdx, %r9
               	shrq	$0x3f, %r9
               	addq	%r9, %rdx
               	xorl	%r9d, %r9d
               	subq	%rdx, %r9
               	imulq	$-0x9, %r9, %rdx
               	subq	%rdx, %rax
               	movl	%eax, (%rsi,%rcx,4)
               	cmpl	%r8d, %eax
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x3, -0x8(%rbp)
               	leaq	-0x90(%rbp), %rax
               	leaq	-0x30(%rbp), %rdx
               	leaq	<rip>, %rdi
               	movq	(%rdi,%rcx,8), %rsi
               	andq	$0x7ff, %rsi            # imm = 0x7FF
               	movl	(%rdx), %r8d
               	andq	$-0x800, %r8            # imm = 0xF800
               	orq	%rsi, %r8
               	movl	%r8d, (%rdx)
               	shlq	$0x35, %rsi
               	sarq	$0x35, %rsi
               	andq	$0x7ff, %rsi            # imm = 0x7FF
               	movl	(%rax), %r9d
               	andq	$-0x800, %r9            # imm = 0xF800
               	orq	%r9, %rsi
               	movl	%esi, (%rax)
               	movq	(%rdi,%rcx,8), %r9
               	andq	$0x1fff, %r9            # imm = 0x1FFF
               	movq	%r8, %rbx
               	andq	$-0xfff801, %rbx        # imm = 0xFF0007FF
               	movq	%r9, %r8
               	shlq	$0xb, %r8
               	movq	%rbx, %r9
               	orq	%r8, %r9
               	movl	%r9d, (%rdx)
               	movq	%rsi, %rdx
               	andq	$-0xfff801, %rdx        # imm = 0xFF0007FF
               	orq	%r8, %rdx
               	movl	%edx, (%rax)
               	leaq	-0x90(%rbp), %rax
               	leaq	-0x30(%rbp), %rsi
               	movq	(%rdi,%rcx,8), %rdx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdx
               	movq	(%rsi), %rdi
               	andq	$0xffffff, %rdi         # imm = 0xFFFFFF
               	shlq	$0x18, %rdx
               	orq	%rdx, %rdi
               	movq	%rdi, (%rsi)
               	sarq	$0x18, %rdx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdx
               	movq	(%rax), %rdi
               	andq	$0xffffff, %rdi         # imm = 0xFFFFFF
               	shlq	$0x18, %rdx
               	orq	%rdi, %rdx
               	movq	%rdx, (%rax)
               	movl	(%rax), %edx
               	movq	%rdx, %rdi
               	andq	$0x7ff, %rdi            # imm = 0x7FF
               	shlq	$0x35, %rdi
               	sarq	$0x35, %rdi
               	imulq	$0x55555556, %rdi, %rdi # imm = 0x55555556
               	sarq	$0x20, %rdi
               	movq	%rdi, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rdi
               	andq	$0x7ff, %rdi            # imm = 0x7FF
               	andq	$-0x800, %rdx           # imm = 0xF800
               	orq	%rdx, %rdi
               	movl	%edi, (%rax)
               	leaq	-0x30(%rbp), %r9
               	movl	(%r9), %eax
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	shlq	$0x35, %rax
               	sarq	$0x35, %rax
               	movslq	-0x8(%rbp), %r8
               	cqto
               	idivq	%r8
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	movl	(%rsi), %edx
               	andq	$-0x800, %rdx           # imm = 0xF800
               	movq	%rdx, %r8
               	orq	%rax, %r8
               	movl	%r8d, (%rsi)
               	leaq	-0x90(%rbp), %rsi
               	movl	%edi, %eax
               	sarq	$0xb, %rax
               	andq	$0x1fff, %rax           # imm = 0x1FFF
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	shrq	$0x20, %rax
               	movq	%rdi, %rdx
               	andq	$-0xfff801, %rdx        # imm = 0xFF0007FF
               	shlq	$0xb, %rax
               	orq	%rdx, %rax
               	movl	%eax, (%rsi)
               	movl	%r8d, %eax
               	sarq	$0xb, %rax
               	andq	$0x1fff, %rax           # imm = 0x1FFF
               	movslq	-0x8(%rbp), %rdi
               	cqto
               	idivq	%rdi
               	andq	$0x1fff, %rax           # imm = 0x1FFF
               	movq	%r8, %rdx
               	andq	$-0xfff801, %rdx        # imm = 0xFF0007FF
               	shlq	$0xb, %rax
               	orq	%rdx, %rax
               	movl	%eax, (%r9)
               	movq	(%rsi), %rdi
               	movq	%rdi, %rax
               	sarq	$0x18, %rax
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rax
               	shlq	$0x18, %rax
               	sarq	$0x18, %rax
               	movabsq	$0x5555555555555556, %r8 # imm = 0x5555555555555556
               	imulq	%r8
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	addq	%rdx, %rax
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rax
               	movq	%rdi, %rdx
               	andq	$0xffffff, %rdx         # imm = 0xFFFFFF
               	shlq	$0x18, %rax
               	movq	%rdx, %rdi
               	orq	%rax, %rdi
               	movq	%rdi, (%rsi)
               	leaq	-0x30(%rbp), %rsi
               	movq	(%rsi), %r8
               	movq	%r8, %rax
               	sarq	$0x18, %rax
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rax
               	shlq	$0x18, %rax
               	sarq	$0x18, %rax
               	movslq	-0x8(%rbp), %r9
               	cqto
               	idivq	%r9
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rax
               	movq	%r8, %rdx
               	andq	$0xffffff, %rdx         # imm = 0xFFFFFF
               	shlq	$0x18, %rax
               	orq	%rdx, %rax
               	movq	%rax, (%rsi)
               	leaq	-0x90(%rbp), %rdx
               	movl	(%rdx), %r8d
               	andq	$0x7ff, %r8             # imm = 0x7FF
               	shlq	$0x35, %r8
               	sarq	$0x35, %r8
               	movl	(%rsi), %r9d
               	andq	$0x7ff, %r9             # imm = 0x7FF
               	shlq	$0x35, %r9
               	sarq	$0x35, %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	movl	(%rdx), %edx
               	sarq	$0xb, %rdx
               	andq	$0x1fff, %rdx           # imm = 0x1FFF
               	movl	(%rsi), %esi
               	sarq	$0xb, %rsi
               	andq	$0x1fff, %rsi           # imm = 0x1FFF
               	cmpl	%esi, %edx
               	jne	<addr>
               	movq	%rdi, %rdx
               	sarq	$0x18, %rdx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdx
               	shlq	$0x18, %rdx
               	sarq	$0x18, %rdx
               	sarq	$0x18, %rax
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rax
               	shlq	$0x18, %rax
               	sarq	$0x18, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	leaq	-0x90(%rbp), %rax
               	leaq	-0x30(%rbp), %rdx
               	leaq	<rip>, %rdi
               	movq	(%rdi,%rcx,8), %rsi
               	andq	$0x7ff, %rsi            # imm = 0x7FF
               	movl	(%rdx), %r8d
               	andq	$-0x800, %r8            # imm = 0xF800
               	orq	%rsi, %r8
               	movl	%r8d, (%rdx)
               	shlq	$0x35, %rsi
               	sarq	$0x35, %rsi
               	andq	$0x7ff, %rsi            # imm = 0x7FF
               	movl	(%rax), %r9d
               	andq	$-0x800, %r9            # imm = 0xF800
               	orq	%r9, %rsi
               	movl	%esi, (%rax)
               	movq	(%rdi,%rcx,8), %r9
               	andq	$0x1fff, %r9            # imm = 0x1FFF
               	movq	%r8, %rbx
               	andq	$-0xfff801, %rbx        # imm = 0xFF0007FF
               	movq	%r9, %r8
               	shlq	$0xb, %r8
               	movq	%rbx, %r9
               	orq	%r8, %r9
               	movl	%r9d, (%rdx)
               	movq	%rsi, %rdx
               	andq	$-0xfff801, %rdx        # imm = 0xFF0007FF
               	orq	%r8, %rdx
               	movl	%edx, (%rax)
               	leaq	-0x90(%rbp), %rax
               	leaq	-0x30(%rbp), %rsi
               	movq	(%rdi,%rcx,8), %rdx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdx
               	movq	(%rsi), %rdi
               	andq	$0xffffff, %rdi         # imm = 0xFFFFFF
               	shlq	$0x18, %rdx
               	orq	%rdx, %rdi
               	movq	%rdi, (%rsi)
               	sarq	$0x18, %rdx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdx
               	movq	(%rax), %rdi
               	andq	$0xffffff, %rdi         # imm = 0xFFFFFF
               	shlq	$0x18, %rdx
               	orq	%rdi, %rdx
               	movq	%rdx, (%rax)
               	movl	(%rax), %edx
               	movq	%rdx, %rdi
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
               	andq	$-0x800, %rdx           # imm = 0xF800
               	orq	%rdx, %rdi
               	movl	%edi, (%rax)
               	leaq	-0x30(%rbp), %r9
               	movl	(%r9), %eax
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	shlq	$0x35, %rax
               	movq	%rax, %r8
               	sarq	$0x35, %r8
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %r10
               	movq	%r8, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	movl	(%rsi), %edx
               	andq	$-0x800, %rdx           # imm = 0xF800
               	movq	%rdx, %r8
               	orq	%rax, %r8
               	movl	%r8d, (%rsi)
               	leaq	-0x90(%rbp), %rsi
               	movl	%edi, %eax
               	sarq	$0xb, %rax
               	andq	$0x1fff, %rax           # imm = 0x1FFF
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movq	%rdi, %rdx
               	andq	$-0xfff801, %rdx        # imm = 0xFF0007FF
               	shlq	$0xb, %rax
               	orq	%rdx, %rax
               	movl	%eax, (%rsi)
               	movl	%r8d, %eax
               	sarq	$0xb, %rax
               	movq	%rax, %rdi
               	andq	$0x1fff, %rdi           # imm = 0x1FFF
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %r10
               	movq	%rdi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	andq	$0x1fff, %rax           # imm = 0x1FFF
               	movq	%r8, %rdx
               	andq	$-0xfff801, %rdx        # imm = 0xFF0007FF
               	shlq	$0xb, %rax
               	orq	%rdx, %rax
               	movl	%eax, (%r9)
               	leaq	-0x90(%rbp), %rdi
               	movq	(%rdi), %rax
               	sarq	$0x18, %rax
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rax
               	shlq	$0x18, %rax
               	movq	%rax, %r8
               	sarq	$0x18, %r8
               	movabsq	$0x5555555555555556, %r9 # imm = 0x5555555555555556
               	movq	%r8, %rax
               	imulq	%r9
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	addq	%rdx, %rax
               	leaq	(%rax,%rax,2), %rax
               	movq	%r8, %rdx
               	subq	%rax, %rdx
               	movabsq	$0xffffffffff, %rax     # imm = 0xFFFFFFFFFF
               	andq	%rdx, %rax
               	movq	(%rsi), %rdx
               	andq	$0xffffff, %rdx         # imm = 0xFFFFFF
               	shlq	$0x18, %rax
               	movq	%rdx, %r8
               	orq	%rax, %r8
               	movq	%r8, (%rsi)
               	leaq	-0x30(%rbp), %rsi
               	movq	(%rsi), %r9
               	movq	%r9, %rax
               	sarq	$0x18, %rax
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rax
               	shlq	$0x18, %rax
               	sarq	$0x18, %rax
               	movslq	-0x8(%rbp), %rdx
               	movq	%rdx, %r10
               	cqto
               	idivq	%r10
               	movabsq	$0xffffffffff, %rax     # imm = 0xFFFFFFFFFF
               	andq	%rdx, %rax
               	movq	%r9, %rdx
               	andq	$0xffffff, %rdx         # imm = 0xFFFFFF
               	shlq	$0x18, %rax
               	orq	%rdx, %rax
               	movq	%rax, (%rsi)
               	movl	(%rdi), %edx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	shlq	$0x35, %rdx
               	sarq	$0x35, %rdx
               	movl	(%rsi), %esi
               	andq	$0x7ff, %rsi            # imm = 0x7FF
               	shlq	$0x35, %rsi
               	sarq	$0x35, %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	leaq	-0x90(%rbp), %rdx
               	movl	(%rdx), %edx
               	sarq	$0xb, %rdx
               	andq	$0x1fff, %rdx           # imm = 0x1FFF
               	leaq	-0x30(%rbp), %rsi
               	movl	(%rsi), %esi
               	sarq	$0xb, %rsi
               	andq	$0x1fff, %rsi           # imm = 0x1FFF
               	cmpl	%esi, %edx
               	jne	<addr>
               	movq	%r8, %rdx
               	sarq	$0x18, %rdx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdx
               	shlq	$0x18, %rdx
               	sarq	$0x18, %rdx
               	sarq	$0x18, %rax
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rax
               	shlq	$0x18, %rax
               	sarq	$0x18, %rax
               	cmpq	%rax, %rdx
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
