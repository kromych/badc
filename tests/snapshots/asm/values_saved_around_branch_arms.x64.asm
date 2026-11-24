
values_saved_around_branch_arms.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<mix>:
               	shrq	$0x3, %rsi
               	xorq	%rdi, %rsi
               	movabsq	$-0x61c8864680b583eb, %rax # imm = 0x9E3779B97F4A7C15
               	imulq	%rsi, %rax
               	retq

<direct>:
               	subq	$0xa8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	%rdi, 0xc0(%rsp)
               	movq	%rcx, 0xa8(%rsp)
               	movq	%rsi, 0xb8(%rsp)
               	xorl	%r9d, %r9d
               	movq	(%rdx), %r13
               	movq	0x8(%rdx), %r8
               	movq	0x10(%rdx), %r14
               	movq	0x18(%rdx), %rbp
               	movq	0x20(%rdx), %r12
               	movq	0x28(%rdx), %rbx
               	movq	0x30(%rdx), %rcx
               	movq	0x38(%rdx), %rax
               	movq	0x40(%rdx), %r15
               	movq	0x48(%rdx), %rsi
               	movq	0x50(%rdx), %rdx
               	movq	%r9, %rdi
               	jmp	<addr>
               	incq	%r9
               	nop
               	cmpq	0xb8(%rsp), %r9
               	jge	<addr>
               	movq	0xc0(%rsp), %r10
               	movzbq	(%r10,%r9), %r10
               	movq	%r10, 0xc8(%rsp)
               	andq	$0x7, %r10
               	movq	%r10, 0xc8(%rsp)
               	cmpl	$0x3, %r10d
               	jl	<addr>
               	nopl	(%rax)
               	movq	0xc8(%rsp), %r10
               	cmpl	$0x5, %r10d
               	jl	<addr>
               	nopw	%cs:(%rax,%rax)
               	nopl	(%rax)
               	movq	0xc8(%rsp), %r10
               	cmpl	$0x6, %r10d
               	jl	<addr>
               	nopw	%cs:(%rax,%rax)
               	nopl	(%rax)
               	movq	0xc8(%rsp), %r10
               	cmpl	$0x6, %r10d
               	je	<addr>
               	movq	%rbp, %r10
               	xorq	%rcx, %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r8
               	leaq	(%r13,%r15), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %rdi
               	jmp	<addr>
               	leaq	(%rdx,%rdx,2), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	%r9, %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %rsi
               	movq	%rsi, %r10
               	shlq	$0x2, %r10
               	movq	%r10, 0xc8(%rsp)
               	xorq	0xc8(%rsp), %rdx
               	jmp	<addr>
               	nopl	(%rax)
               	testb	$0x1, %r9b
               	je	<addr>
               	movq	%rax, 0x60(%rsp)
               	movq	%rbx, 0x58(%rsp)
               	movq	%r12, 0x50(%rsp)
               	movq	%r13, 0x48(%rsp)
               	movq	0xa8(%rsp), %rax
               	movq	(%rax), %r12
               	movq	0x10(%rax), %r13
               	movq	0x20(%rax), %rbx
               	movq	0x30(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	imulq	%r12, %rbx
               	movq	%r13, %r10
               	imulq	0xc8(%rsp), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %rbx
               	addq	%rbx, %r12
               	movq	%r12, 0x8(%rax)
               	movq	%rbx, %r12
               	xorq	%r13, %r12
               	movq	%r12, 0x18(%rax)
               	addq	%rbx, %rdi
               	movq	0x60(%rsp), %rax
               	movq	0x58(%rsp), %rbx
               	movq	0x50(%rsp), %r12
               	movq	0x48(%rsp), %r13
               	jmp	<addr>
               	movq	%rax, 0x60(%rsp)
               	movq	%rbx, 0x58(%rsp)
               	movq	%r12, 0x50(%rsp)
               	movq	%r13, 0x48(%rsp)
               	movq	0xa8(%rsp), %rax
               	movq	0x8(%rax), %rbx
               	movq	0x18(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0x28(%rax), %r12
               	movq	0x38(%rax), %r13
               	imulq	%r13, %rbx
               	movq	0xc8(%rsp), %r10
               	imulq	%r12, %r10
               	movq	%r10, 0xc8(%rsp)
               	subq	0xc8(%rsp), %rbx
               	negq	%r13
               	addq	%rbx, %r13
               	movq	%r13, (%rax)
               	xorq	%rbx, %r12
               	movq	%r12, 0x30(%rax)
               	subq	%rbx, %rdi
               	movq	0x60(%rsp), %rax
               	movq	0x58(%rsp), %rbx
               	movq	0x50(%rsp), %r12
               	movq	0x48(%rsp), %r13
               	jmp	<addr>
               	movq	0xc8(%rsp), %r10
               	cmpl	$0x4, %r10d
               	jl	<addr>
               	leaq	(%r15,%r9), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	%r9, 0x90(%rsp)
               	movq	%rdi, 0x88(%rsp)
               	movq	%rdx, 0x80(%rsp)
               	movq	%rsi, 0x78(%rsp)
               	movq	%rcx, 0x70(%rsp)
               	movq	%r8, 0x68(%rsp)
               	movq	%rax, %rdi
               	movq	0xc8(%rsp), %rsi
               	callq	<addr>
               	movq	0x90(%rsp), %r9
               	movq	0x88(%rsp), %rdi
               	movq	0x80(%rsp), %rdx
               	movq	0x78(%rsp), %rsi
               	movq	0x70(%rsp), %rcx
               	movq	0x68(%rsp), %r8
               	addq	%rax, %r15
               	jmp	<addr>
               	movq	%rax, 0x60(%rsp)
               	movq	%rbx, 0x58(%rsp)
               	movq	%r12, 0x50(%rsp)
               	movq	0xa8(%rsp), %rax
               	movq	0x8(%rax), %rbx
               	movq	0x30(%rax), %r12
               	addq	%r12, %rbx
               	movq	0x10(%rax), %r12
               	movq	0x28(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	xorq	0xc8(%rsp), %r12
               	movq	0x18(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0x20(%rax), %rax
               	movq	%rax, %r10
               	movq	0xc8(%rsp), %rax
               	subq	%r10, %rax
               	cmpq	$0x77, %rbx
               	je	<addr>
               	movq	%r13, 0x48(%rsp)
               	movq	%rbx, %r13
               	imulq	%r12, %r13
               	leaq	(%r13,%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xa8(%rsp), %r13
               	movq	0xc8(%rsp), %r11
               	movq	%r11, (%r13)
               	movq	%r12, %r10
               	imulq	%rax, %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	%rbx, %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	%r10, %r11
               	movq	%r11, 0x38(%r13)
               	addq	%r12, %rbx
               	addq	%rbx, %rax
               	xorq	%rax, %rdi
               	movq	0x60(%rsp), %rax
               	movq	0x58(%rsp), %rbx
               	movq	0x50(%rsp), %r12
               	movq	0x48(%rsp), %r13
               	jmp	<addr>
               	nopl	(%rax)
               	movq	0xc8(%rsp), %r10
               	cmpl	$0x1, %r10d
               	jl	<addr>
               	nopw	%cs:(%rax,%rax)
               	nopl	(%rax)
               	movq	0xc8(%rsp), %r10
               	cmpl	$0x2, %r10d
               	jl	<addr>
               	movq	%rax, 0x60(%rsp)
               	movq	%r12, %r10
               	subq	%rbx, %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	%rbx, %r10
               	subq	%r12, %r10
               	movq	%r10, 0xb0(%rsp)
               	cmpq	%rbx, %r12
               	movq	0xb0(%rsp), %r11
               	cmovbeq	%r11, %rbx
               	movq	0xc8(%rsp), %r10
               	cmovaq	%r10, %r12
               	leaq	(%r12,%rbx), %rax
               	xorq	%rax, %rcx
               	movq	0x60(%rsp), %rax
               	jmp	<addr>
               	movq	%rax, 0x60(%rsp)
               	movq	%rbx, 0x58(%rsp)
               	movq	%r12, 0x50(%rsp)
               	movq	%r13, 0x48(%rsp)
               	movq	%r14, 0x40(%rsp)
               	movq	%r15, 0x38(%rsp)
               	movq	%rbp, 0x30(%rsp)
               	movq	0xa8(%rsp), %rax
               	movq	(%rax), %rbx
               	movq	0x8(%rax), %r14
               	movq	0x10(%rax), %r15
               	movq	0x18(%rax), %rbp
               	movq	0x20(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0x28(%rax), %r12
               	movq	0x30(%rax), %r13
               	movq	0x38(%rax), %r10
               	movq	%r10, 0xa0(%rsp)
               	movq	%rbx, %r10
               	imulq	%r14, %r10
               	movq	%r10, 0xb0(%rsp)
               	movq	%r15, %r10
               	imulq	%rbp, %r10
               	movq	%r10, 0x98(%rsp)
               	movq	0xb0(%rsp), %r10
               	addq	0x98(%rsp), %r10
               	movq	%r10, 0xb0(%rsp)
               	movq	0xc8(%rsp), %r10
               	imulq	%r12, %r10
               	movq	%r10, 0x98(%rsp)
               	movq	0xb0(%rsp), %r10
               	addq	0x98(%rsp), %r10
               	movq	%r10, 0x98(%rsp)
               	movq	%r13, 0xb0(%rsp)
               	imulq	0xa0(%rsp), %r13
               	movq	%r13, %r10
               	movq	0x98(%rsp), %r13
               	addq	%r10, %r13
               	movq	%rbx, %r10
               	xorq	0xa0(%rsp), %r10
               	movq	%r10, 0xa0(%rsp)
               	xorq	0xb0(%rsp), %r14
               	movq	%r14, %r10
               	movq	0xa0(%rsp), %r14
               	addq	%r10, %r14
               	xorq	%r12, %r15
               	addq	%r15, %r14
               	movq	%rbp, %r15
               	xorq	0xc8(%rsp), %r15
               	addq	%r15, %r14
               	movq	%r9, %r15
               	andq	$0x7, %r15
               	movq	%r13, %rbp
               	xorq	%r14, %rbp
               	movq	%rbp, (%rax,%r15,8)
               	leaq	0x3(%r9), %r15
               	andq	$0x7, %r15
               	imulq	%r14, %rbx
               	addq	%r13, %rbx
               	addq	%r12, %rbx
               	movq	%rbx, (%rax,%r15,8)
               	movq	%r13, %rax
               	subq	%r14, %rax
               	addq	%rax, %rdi
               	movq	0x60(%rsp), %rax
               	movq	0x58(%rsp), %rbx
               	movq	0x50(%rsp), %r12
               	movq	0x48(%rsp), %r13
               	movq	0x40(%rsp), %r14
               	movq	0x38(%rsp), %r15
               	movq	0x30(%rsp), %rbp
               	jmp	<addr>
               	movq	%r8, %r10
               	xorq	%r9, %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r13
               	xorq	%r13, %r14
               	movq	%r14, %r10
               	shrq	%r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %rbp
               	jmp	<addr>
               	movq	0x60(%rsp), %rax
               	movq	0x58(%rsp), %rbx
               	movq	0x50(%rsp), %r12
               	addq	%r13, %rdi
               	leaq	(%r8,%r8,2), %r8
               	addq	%r8, %rdi
               	leaq	(%r14,%r14,4), %r8
               	addq	%r8, %rdi
               	imulq	$0x7, %rbp, %r8
               	addq	%r8, %rdi
               	leaq	(%r12,%r12,8), %r8
               	addq	%r8, %rdi
               	imulq	$0xb, %rbx, %r8
               	addq	%r8, %rdi
               	imulq	$0xd, %rcx, %rcx
               	addq	%rdi, %rcx
               	imulq	$0xf, %rax, %rax
               	addq	%rcx, %rax
               	imulq	$0x11, %r15, %rcx
               	addq	%rcx, %rax
               	imulq	$0x13, %rsi, %rcx
               	addq	%rcx, %rax
               	imulq	$0x15, %rdx, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0xa8, %rsp
               	retq
               	incq	%rdi
               	jmp	<addr>

<reference>:
               	subq	$0x70, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r14
               	movq	%rcx, %r13
               	movq	%rsi, %r15
               	xorl	%eax, %eax
               	leaq	0x38(%rsp), %rsi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rsi
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rsi)
               	incq	%rax
               	cmpl	$0xb, %eax
               	jl	<addr>
               	xorl	%r12d, %r12d
               	movq	%r12, %rbx
               	jmp	<addr>
               	incq	%r12
               	cmpq	%r15, %r12
               	jge	<addr>
               	movzbq	(%r14,%r12), %rax
               	andq	$0x7, %rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	nop
               	cmpl	$0x5, %eax
               	jl	<addr>
               	cmpl	$0x6, %eax
               	jl	<addr>
               	cmpl	$0x6, %eax
               	je	<addr>
               	movq	0x40(%rsp), %rax
               	movq	0x50(%rsp), %rcx
               	movq	0x68(%rsp), %rdx
               	xorq	%rdx, %rcx
               	addq	%rcx, %rax
               	movq	%rax, 0x40(%rsp)
               	movq	0x38(%rsp), %rax
               	movq	0x78(%rsp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	jmp	<addr>
               	movq	0x80(%rsp), %rax
               	movq	0x88(%rsp), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	%r12, %rcx
               	addq	%rcx, %rax
               	movq	%rax, 0x80(%rsp)
               	movq	0x88(%rsp), %rax
               	movq	0x80(%rsp), %rcx
               	shlq	$0x2, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, 0x88(%rsp)
               	jmp	<addr>
               	testb	$0x1, %r12b
               	je	<addr>
               	movq	(%r13), %rcx
               	movq	0x10(%r13), %rdx
               	movq	0x20(%r13), %rax
               	movq	0x30(%r13), %rsi
               	imulq	%rcx, %rax
               	imulq	%rdx, %rsi
               	addq	%rsi, %rax
               	addq	%rax, %rcx
               	movq	%rcx, 0x8(%r13)
               	xorq	%rax, %rdx
               	movq	%rdx, 0x18(%r13)
               	addq	%rax, %rbx
               	nop
               	jmp	<addr>
               	movq	0x8(%r13), %rax
               	movq	0x18(%r13), %rsi
               	movq	0x28(%r13), %rcx
               	movq	0x38(%r13), %rdx
               	imulq	%rdx, %rax
               	imulq	%rcx, %rsi
               	subq	%rsi, %rax
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movq	%rsi, (%r13)
               	xorq	%rax, %rcx
               	movq	%rcx, 0x30(%r13)
               	subq	%rax, %rbx
               	jmp	<addr>
               	nopl	(%rax)
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	0x70(%rsp), %rdi
               	movq	0x78(%rsp), %rax
               	leaq	(%rax,%r12), %rsi
               	callq	<addr>
               	movq	%rax, 0x70(%rsp)
               	movq	0x78(%rsp), %rax
               	movq	0x70(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	%rax, 0x78(%rsp)
               	jmp	<addr>
               	movq	0x8(%r13), %rax
               	movq	0x30(%r13), %rcx
               	addq	%rcx, %rax
               	movq	0x10(%r13), %rcx
               	movq	0x28(%r13), %rdx
               	xorq	%rdx, %rcx
               	movq	0x18(%r13), %rdx
               	movq	0x20(%r13), %rsi
               	subq	%rsi, %rdx
               	cmpq	$0x77, %rax
               	je	<addr>
               	movq	%rax, %rsi
               	imulq	%rcx, %rsi
               	addq	%rdx, %rsi
               	movq	%rsi, (%r13)
               	movq	%rcx, %rsi
               	imulq	%rdx, %rsi
               	addq	%rax, %rsi
               	movq	%rsi, 0x38(%r13)
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	xorq	%rax, %rbx
               	jmp	<addr>
               	cmpl	$0x1, %eax
               	jl	<addr>
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movq	0x58(%rsp), %rax
               	movq	0x60(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jbe	<addr>
               	movq	0x58(%rsp), %rax
               	movq	0x60(%rsp), %rcx
               	subq	%rcx, %rax
               	movq	%rax, 0x58(%rsp)
               	movq	0x68(%rsp), %rax
               	movq	0x58(%rsp), %rcx
               	movq	0x60(%rsp), %rdx
               	addq	%rdx, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, 0x68(%rsp)
               	jmp	<addr>
               	movq	0x60(%rsp), %rax
               	movq	0x58(%rsp), %rcx
               	subq	%rcx, %rax
               	movq	%rax, 0x60(%rsp)
               	jmp	<addr>
               	movq	(%r13), %rax
               	movq	0x8(%r13), %rcx
               	imulq	%rcx, %rax
               	movq	0x10(%r13), %rcx
               	movq	0x18(%r13), %rdx
               	imulq	%rdx, %rcx
               	addq	%rcx, %rax
               	movq	0x20(%r13), %rcx
               	movq	0x28(%r13), %rdx
               	imulq	%rdx, %rcx
               	addq	%rcx, %rax
               	movq	0x30(%r13), %rcx
               	movq	0x38(%r13), %rdx
               	imulq	%rdx, %rcx
               	addq	%rcx, %rax
               	movq	(%r13), %rcx
               	movq	0x38(%r13), %rdx
               	xorq	%rdx, %rcx
               	movq	0x8(%r13), %rdx
               	movq	0x30(%r13), %rsi
               	xorq	%rsi, %rdx
               	addq	%rdx, %rcx
               	movq	0x10(%r13), %rdx
               	movq	0x28(%r13), %rsi
               	xorq	%rsi, %rdx
               	addq	%rdx, %rcx
               	movq	0x18(%r13), %rdx
               	movq	0x20(%r13), %rsi
               	xorq	%rsi, %rdx
               	addq	%rdx, %rcx
               	movq	(%r13), %rdx
               	movq	0x28(%r13), %rsi
               	movq	%r12, %rdi
               	andq	$0x7, %rdi
               	shlq	$0x3, %rdi
               	addq	%r13, %rdi
               	movq	%rax, %r8
               	xorq	%rcx, %r8
               	movq	%r8, (%rdi)
               	leaq	0x3(%r12), %rdi
               	andq	$0x7, %rdi
               	shlq	$0x3, %rdi
               	addq	%r13, %rdi
               	imulq	%rcx, %rdx
               	addq	%rax, %rdx
               	addq	%rsi, %rdx
               	movq	%rdx, (%rdi)
               	subq	%rcx, %rax
               	addq	%rax, %rbx
               	nopl	(%rax,%rax)
               	jmp	<addr>
               	movq	0x38(%rsp), %rax
               	movq	0x40(%rsp), %rcx
               	xorq	%r12, %rcx
               	addq	%rcx, %rax
               	movq	%rax, 0x38(%rsp)
               	movq	0x48(%rsp), %rax
               	movq	0x38(%rsp), %rcx
               	xorq	%rcx, %rax
               	movq	%rax, 0x48(%rsp)
               	movq	0x50(%rsp), %rax
               	movq	0x48(%rsp), %rcx
               	shrq	%rcx
               	addq	%rcx, %rax
               	movq	%rax, 0x50(%rsp)
               	jmp	<addr>
               	xorl	%eax, %eax
               	leaq	0x38(%rsp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	movq	%rax, %rdx
               	shlq	%rdx
               	incq	%rdx
               	imulq	%rdx, %rcx
               	addq	%rcx, %rbx
               	incq	%rax
               	cmpl	$0xb, %eax
               	jl	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x70, %rsp
               	retq
               	incq	%rbx
               	jmp	<addr>

<main>:
               	subq	$0x1c0, %rsp            # imm = 0x1C0
               	pushq	%rbx
               	xorl	%eax, %eax
               	imulq	$0xd, %rax, %rdx
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	addq	%rsi, %rdx
               	andq	$0x7, %rdx
               	movb	%dl, 0xf8(%rsp,%rax)
               	incq	%rax
               	cmpl	$0xc8, %eax
               	jl	<addr>
               	movq	$0x1234567, 0xa0(%rsp)  # imm = 0x1234567
               	movq	$0x2568ace, 0xa8(%rsp)  # imm = 0x2568ACE
               	movq	$0x349d035, 0xb0(%rsp)  # imm = 0x349D035
               	movq	$0x4bd159c, 0xb8(%rsp)  # imm = 0x4BD159C
               	movq	$0x5f05b03, 0xc0(%rsp)  # imm = 0x5F05B03
               	movq	$0x683a06a, 0xc8(%rsp)  # imm = 0x683A06A
               	movq	$0x796e5d1, 0xd0(%rsp)  # imm = 0x796E5D1
               	movq	$0x96a2b38, 0xd8(%rsp)  # imm = 0x96A2B38
               	movq	$0xabd709f, 0xe0(%rsp)  # imm = 0xABD709F
               	movq	$0xbf0b606, 0xe8(%rsp)  # imm = 0xBF0B606
               	movq	$0xc23fb6d, 0xf0(%rsp)  # imm = 0xC23FB6D
               	movq	$0x30003, 0x60(%rsp)    # imm = 0x30003
               	movq	$0x30003, 0x20(%rsp)    # imm = 0x30003
               	movq	$0x40004, 0x68(%rsp)    # imm = 0x40004
               	movq	$0x40004, 0x28(%rsp)    # imm = 0x40004
               	movq	$0x50005, 0x70(%rsp)    # imm = 0x50005
               	movq	$0x50005, 0x30(%rsp)    # imm = 0x50005
               	movq	$0x60006, 0x78(%rsp)    # imm = 0x60006
               	movq	$0x60006, 0x38(%rsp)    # imm = 0x60006
               	movq	$0x70007, 0x80(%rsp)    # imm = 0x70007
               	movq	$0x70007, 0x40(%rsp)    # imm = 0x70007
               	movq	$0x80008, 0x88(%rsp)    # imm = 0x80008
               	movq	$0x80008, 0x48(%rsp)    # imm = 0x80008
               	movq	$0x90009, 0x90(%rsp)    # imm = 0x90009
               	movq	$0x90009, 0x50(%rsp)    # imm = 0x90009
               	movq	$0xa000a, 0x98(%rsp)    # imm = 0xA000A
               	movq	$0xa000a, 0x58(%rsp)    # imm = 0xA000A
               	leaq	0xf8(%rsp), %rdi
               	movl	$0xc8, %esi
               	leaq	0xa0(%rsp), %rdx
               	leaq	0x20(%rsp), %rcx
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0xf8(%rsp), %rdi
               	movl	$0xc8, %esi
               	leaq	0xa0(%rsp), %rdx
               	leaq	0x60(%rsp), %rcx
               	callq	<addr>
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	retq
               	movq	0x20(%rsp), %rax
               	movq	0x60(%rsp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	retq
               	movq	0x28(%rsp), %rax
               	movq	0x68(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	0x30(%rsp), %rax
               	movq	0x70(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	0x38(%rsp), %rax
               	movq	0x78(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	0x40(%rsp), %rax
               	movq	0x80(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	0x48(%rsp), %rax
               	movq	0x88(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	0x50(%rsp), %rax
               	movq	0x90(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	0x58(%rsp), %rax
               	movq	0x98(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	$0x0, 0x60(%rsp)
               	movq	$0x0, 0x20(%rsp)
               	movq	$0x0, 0x70(%rsp)
               	movq	$0x0, 0x30(%rsp)
               	movq	$0x0, 0x78(%rsp)
               	movq	$0x0, 0x38(%rsp)
               	movq	$0x0, 0x80(%rsp)
               	movq	$0x0, 0x40(%rsp)
               	movq	$0x0, 0x88(%rsp)
               	movq	$0x0, 0x48(%rsp)
               	movq	$0x0, 0x98(%rsp)
               	movq	$0x0, 0x58(%rsp)
               	movq	$0x70, 0x68(%rsp)
               	movq	$0x70, 0x28(%rsp)
               	leaq	0x20(%rsp), %rcx
               	movq	$0x7, 0x90(%rsp)
               	movq	$0x7, 0x50(%rsp)
               	leaq	0x18(%rsp), %rdi
               	leaq	<rip>, %rax
               	movl	(%rax), %r10d
               	movl	%r10d, (%rdi)
               	movl	$0x4, %esi
               	leaq	0xa0(%rsp), %rdx
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x18(%rsp), %rdi
               	movl	$0x4, %esi
               	leaq	0xa0(%rsp), %rdx
               	leaq	0x60(%rsp), %rcx
               	callq	<addr>
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	retq
               	leaq	0xf8(%rsp), %rdi
               	xorl	%esi, %esi
               	leaq	0xa0(%rsp), %rdx
               	leaq	0x20(%rsp), %rcx
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0xf8(%rsp), %rdi
               	xorl	%esi, %esi
               	leaq	0xa0(%rsp), %rdx
               	leaq	0x60(%rsp), %rcx
               	callq	<addr>
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	retq
