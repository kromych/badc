
gcc_vector_arith_float.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	leaq	-0xc0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xb0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xa0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x90(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x80(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	popq	%rdx
               	leaq	-0x60(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	popq	%rdx
               	leaq	-0xc0(%rbp), %rcx
               	leaq	-0xb0(%rbp), %rdx
               	leaq	-0x10(%rbp), %rax
               	movss	(%rcx,%riz), %xmm0
               	movss	(%rdx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	movss	0x4(%rcx,%riz), %xmm0
               	movss	0x4(%rdx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rax,%riz)
               	movss	0x8(%rcx,%riz), %xmm0
               	movss	0x8(%rdx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rax,%riz)
               	movss	0xc(%rcx,%riz), %xmm0
               	movss	0xc(%rdx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rax,%riz)
               	leaq	-0x30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xc0(%rbp), %rax
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	addq	$0x0, %rdx
               	leaq	(%rax), %rsi
               	movss	(%rsi,%riz), %xmm0
               	leaq	(%rcx), %rsi
               	movss	(%rsi,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx,%riz)
               	leaq	-0x10(%rbp), %rdx
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx,%riz)
               	leaq	-0x10(%rbp), %rdx
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x10(%rbp), %rdx
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x10(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xc0(%rbp), %rcx
               	leaq	-0xb0(%rbp), %rdx
               	leaq	-0x10(%rbp), %rax
               	movss	(%rcx,%riz), %xmm0
               	movss	(%rdx,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	movss	0x4(%rcx,%riz), %xmm0
               	movss	0x4(%rdx,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rax,%riz)
               	movss	0x8(%rcx,%riz), %xmm0
               	movss	0x8(%rdx,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rax,%riz)
               	movss	0xc(%rcx,%riz), %xmm0
               	movss	0xc(%rdx,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rax,%riz)
               	leaq	-0x30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xc0(%rbp), %rax
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	addq	$0x0, %rdx
               	leaq	(%rax), %rsi
               	movss	(%rsi,%riz), %xmm0
               	leaq	(%rcx), %rsi
               	movss	(%rsi,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx,%riz)
               	leaq	-0x10(%rbp), %rdx
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx,%riz)
               	leaq	-0x10(%rbp), %rdx
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x10(%rbp), %rdx
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x10(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xc0(%rbp), %rcx
               	leaq	-0xb0(%rbp), %rdx
               	leaq	-0x10(%rbp), %rax
               	movss	(%rcx,%riz), %xmm0
               	movss	(%rdx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	movss	0x4(%rcx,%riz), %xmm0
               	movss	0x4(%rdx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rax,%riz)
               	movss	0x8(%rcx,%riz), %xmm0
               	movss	0x8(%rdx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rax,%riz)
               	movss	0xc(%rcx,%riz), %xmm0
               	movss	0xc(%rdx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rax,%riz)
               	leaq	-0x30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xc0(%rbp), %rax
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	addq	$0x0, %rdx
               	leaq	(%rax), %rsi
               	movss	(%rsi,%riz), %xmm0
               	leaq	(%rcx), %rsi
               	movss	(%rsi,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx,%riz)
               	leaq	-0x10(%rbp), %rdx
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx,%riz)
               	leaq	-0x10(%rbp), %rdx
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x10(%rbp), %rdx
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x10(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xc0(%rbp), %rcx
               	leaq	-0xb0(%rbp), %rdx
               	leaq	-0x10(%rbp), %rax
               	movss	(%rcx,%riz), %xmm0
               	movss	(%rdx,%riz), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	movss	0x4(%rcx,%riz), %xmm0
               	movss	0x4(%rdx,%riz), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rax,%riz)
               	movss	0x8(%rcx,%riz), %xmm0
               	movss	0x8(%rdx,%riz), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rax,%riz)
               	movss	0xc(%rcx,%riz), %xmm0
               	movss	0xc(%rdx,%riz), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rax,%riz)
               	leaq	-0x30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xc0(%rbp), %rax
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	addq	$0x0, %rdx
               	leaq	(%rax), %rsi
               	movss	(%rsi,%riz), %xmm0
               	leaq	(%rcx), %rsi
               	movss	(%rsi,%riz), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx,%riz)
               	leaq	-0x10(%rbp), %rdx
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx,%riz)
               	leaq	-0x10(%rbp), %rdx
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x10(%rbp), %rdx
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x10(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa0(%rbp), %rcx
               	leaq	-0x90(%rbp), %rdx
               	leaq	-0x10(%rbp), %rax
               	movsd	(%rcx,%riz), %xmm0
               	movsd	(%rdx,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movsd	0x8(%rcx,%riz), %xmm0
               	movsd	0x8(%rdx,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rax,%riz)
               	leaq	-0x30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xa0(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	addq	$0x0, %rdx
               	leaq	(%rax), %rsi
               	movsd	(%rsi,%riz), %xmm0
               	leaq	(%rcx), %rsi
               	movsd	(%rsi,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rdx,%riz)
               	leaq	-0x10(%rbp), %rdx
               	movsd	0x8(%rax,%riz), %xmm0
               	movsd	0x8(%rcx,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x10(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa0(%rbp), %rcx
               	leaq	-0x90(%rbp), %rdx
               	leaq	-0x10(%rbp), %rax
               	movsd	(%rcx,%riz), %xmm0
               	movsd	(%rdx,%riz), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movsd	0x8(%rcx,%riz), %xmm0
               	movsd	0x8(%rdx,%riz), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rax,%riz)
               	leaq	-0x30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xa0(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	addq	$0x0, %rdx
               	leaq	(%rax), %rsi
               	movsd	(%rsi,%riz), %xmm0
               	leaq	(%rcx), %rsi
               	movsd	(%rsi,%riz), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rdx,%riz)
               	leaq	-0x10(%rbp), %rdx
               	movsd	0x8(%rax,%riz), %xmm0
               	movsd	0x8(%rcx,%riz), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x10(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa0(%rbp), %rcx
               	leaq	-0x90(%rbp), %rdx
               	leaq	-0x10(%rbp), %rax
               	movsd	(%rcx,%riz), %xmm0
               	movsd	(%rdx,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movsd	0x8(%rcx,%riz), %xmm0
               	movsd	0x8(%rdx,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rax,%riz)
               	leaq	-0x30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xa0(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	addq	$0x0, %rdx
               	leaq	(%rax), %rsi
               	movsd	(%rsi,%riz), %xmm0
               	leaq	(%rcx), %rsi
               	movsd	(%rsi,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rdx,%riz)
               	leaq	-0x10(%rbp), %rdx
               	movsd	0x8(%rax,%riz), %xmm0
               	movsd	0x8(%rcx,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x10(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa0(%rbp), %rcx
               	leaq	-0x90(%rbp), %rdx
               	leaq	-0x10(%rbp), %rax
               	movsd	(%rcx,%riz), %xmm0
               	movsd	(%rdx,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movsd	0x8(%rcx,%riz), %xmm0
               	movsd	0x8(%rdx,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rax,%riz)
               	leaq	-0x30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xa0(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	addq	$0x0, %rdx
               	leaq	(%rax), %rsi
               	movsd	(%rsi,%riz), %xmm0
               	leaq	(%rcx), %rsi
               	movsd	(%rsi,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rdx,%riz)
               	leaq	-0x10(%rbp), %rdx
               	movsd	0x8(%rax,%riz), %xmm0
               	movsd	0x8(%rcx,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x10(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x8, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rcx
               	leaq	-0x60(%rbp), %rdx
               	leaq	-0x20(%rbp), %rax
               	movss	(%rcx,%riz), %xmm0
               	movss	(%rdx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	movss	0x4(%rcx,%riz), %xmm0
               	movss	0x4(%rdx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rax,%riz)
               	movss	0x8(%rcx,%riz), %xmm0
               	movss	0x8(%rdx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rax,%riz)
               	movss	0xc(%rcx,%riz), %xmm0
               	movss	0xc(%rdx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rax,%riz)
               	movss	0x10(%rcx,%riz), %xmm0
               	movss	0x10(%rdx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x10(%rax,%riz)
               	movss	0x14(%rcx,%riz), %xmm0
               	movss	0x14(%rdx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x14(%rax,%riz)
               	movss	0x18(%rcx,%riz), %xmm0
               	movss	0x18(%rdx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x18(%rax,%riz)
               	movss	0x1c(%rcx,%riz), %xmm0
               	movss	0x1c(%rdx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x1c(%rax,%riz)
               	leaq	-0x40(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	movq	0x18(%rax), %rdx
               	movq	%rdx, 0x18(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x80(%rbp), %rax
               	leaq	-0x60(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	addq	$0x0, %rdx
               	leaq	(%rax), %rsi
               	movss	(%rsi,%riz), %xmm0
               	leaq	(%rcx), %rsi
               	movss	(%rsi,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx,%riz)
               	leaq	-0x20(%rbp), %rdx
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx,%riz)
               	leaq	-0x20(%rbp), %rdx
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x20(%rbp), %rdx
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	leaq	-0x20(%rbp), %rdx
               	movss	0x10(%rax,%riz), %xmm0
               	movss	0x10(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x10(%rdx,%riz)
               	leaq	-0x20(%rbp), %rdx
               	movss	0x14(%rax,%riz), %xmm0
               	movss	0x14(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x14(%rdx,%riz)
               	leaq	-0x20(%rbp), %rdx
               	movss	0x18(%rax,%riz), %xmm0
               	movss	0x18(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x18(%rdx,%riz)
               	leaq	-0x20(%rbp), %rdx
               	movss	0x1c(%rax,%riz), %xmm0
               	movss	0x1c(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x1c(%rdx,%riz)
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x20(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x20, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x9, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rcx
               	leaq	-0x60(%rbp), %rdx
               	leaq	-0x20(%rbp), %rax
               	movss	(%rcx,%riz), %xmm0
               	movss	(%rdx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	movss	0x4(%rcx,%riz), %xmm0
               	movss	0x4(%rdx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rax,%riz)
               	movss	0x8(%rcx,%riz), %xmm0
               	movss	0x8(%rdx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rax,%riz)
               	movss	0xc(%rcx,%riz), %xmm0
               	movss	0xc(%rdx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rax,%riz)
               	movss	0x10(%rcx,%riz), %xmm0
               	movss	0x10(%rdx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x10(%rax,%riz)
               	movss	0x14(%rcx,%riz), %xmm0
               	movss	0x14(%rdx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x14(%rax,%riz)
               	movss	0x18(%rcx,%riz), %xmm0
               	movss	0x18(%rdx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x18(%rax,%riz)
               	movss	0x1c(%rcx,%riz), %xmm0
               	movss	0x1c(%rdx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x1c(%rax,%riz)
               	leaq	-0x40(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	movq	0x18(%rax), %rdx
               	movq	%rdx, 0x18(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x80(%rbp), %rax
               	leaq	-0x60(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	addq	$0x0, %rdx
               	leaq	(%rax), %rsi
               	movss	(%rsi,%riz), %xmm0
               	leaq	(%rcx), %rsi
               	movss	(%rsi,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx,%riz)
               	leaq	-0x20(%rbp), %rdx
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx,%riz)
               	leaq	-0x20(%rbp), %rdx
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x20(%rbp), %rdx
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	leaq	-0x20(%rbp), %rdx
               	movss	0x10(%rax,%riz), %xmm0
               	movss	0x10(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x10(%rdx,%riz)
               	leaq	-0x20(%rbp), %rdx
               	movss	0x14(%rax,%riz), %xmm0
               	movss	0x14(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x14(%rdx,%riz)
               	leaq	-0x20(%rbp), %rdx
               	movss	0x18(%rax,%riz), %xmm0
               	movss	0x18(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x18(%rdx,%riz)
               	leaq	-0x20(%rbp), %rdx
               	movss	0x1c(%rax,%riz), %xmm0
               	movss	0x1c(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x1c(%rdx,%riz)
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x20(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x20, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xa, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xc0(%rbp), %rcx
               	movl	$0x40200000, %edx       # imm = 0x40200000
               	leaq	-0x10(%rbp), %rax
               	movss	(%rcx,%riz), %xmm0
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	movss	0x4(%rcx,%riz), %xmm0
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x4(%rax,%riz)
               	movss	0x8(%rcx,%riz), %xmm0
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x8(%rax,%riz)
               	movss	0xc(%rcx,%riz), %xmm0
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0xc(%rax,%riz)
               	leaq	-0x30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xc0(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	addq	$0x0, %rcx
               	leaq	(%rax), %rdx
               	movss	(%rdx,%riz), %xmm0
               	movl	$0x40200000, %edx       # imm = 0x40200000
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, (%rcx,%riz)
               	leaq	-0x10(%rbp), %rcx
               	movss	0x4(%rax,%riz), %xmm0
               	movl	$0x40200000, %edx       # imm = 0x40200000
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x4(%rcx,%riz)
               	leaq	-0x10(%rbp), %rcx
               	movss	0x8(%rax,%riz), %xmm0
               	movl	$0x40200000, %edx       # imm = 0x40200000
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x8(%rcx,%riz)
               	leaq	-0x10(%rbp), %rcx
               	movss	0xc(%rax,%riz), %xmm0
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0xc(%rcx,%riz)
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x10(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xb, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xc0(%rbp), %rcx
               	movl	$0x3, %eax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	leaq	-0x10(%rbp), %rax
               	movss	(%rcx,%riz), %xmm1
               	mulss	%xmm0, %xmm1
               	movss	%xmm1, (%rax,%riz)
               	movss	0x4(%rcx,%riz), %xmm1
               	mulss	%xmm0, %xmm1
               	movss	%xmm1, 0x4(%rax,%riz)
               	movss	0x8(%rcx,%riz), %xmm1
               	mulss	%xmm0, %xmm1
               	movss	%xmm1, 0x8(%rax,%riz)
               	movss	0xc(%rcx,%riz), %xmm1
               	movapd	%xmm0, %xmm15
               	movapd	%xmm1, %xmm0
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0xc(%rax,%riz)
               	leaq	-0x30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xc0(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	addq	$0x0, %rcx
               	leaq	(%rax), %rdx
               	movss	(%rdx,%riz), %xmm0
               	movl	$0x40400000, %edx       # imm = 0x40400000
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, (%rcx,%riz)
               	leaq	-0x10(%rbp), %rcx
               	movss	0x4(%rax,%riz), %xmm0
               	movl	$0x40400000, %edx       # imm = 0x40400000
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x4(%rcx,%riz)
               	leaq	-0x10(%rbp), %rcx
               	movss	0x8(%rax,%riz), %xmm0
               	movl	$0x40400000, %edx       # imm = 0x40400000
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x8(%rcx,%riz)
               	leaq	-0x10(%rbp), %rcx
               	movss	0xc(%rax,%riz), %xmm0
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0xc(%rcx,%riz)
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x10(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xc, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa0(%rbp), %rcx
               	movabsq	$0x4010000000000000, %rdx # imm = 0x4010000000000000
               	leaq	-0x10(%rbp), %rax
               	movsd	(%rcx,%riz), %xmm0
               	movq	%rdx, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movsd	0x8(%rcx,%riz), %xmm0
               	movq	%rdx, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, 0x8(%rax,%riz)
               	leaq	-0x30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xa0(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	addq	$0x0, %rcx
               	leaq	(%rax), %rdx
               	movsd	(%rdx,%riz), %xmm0
               	movabsq	$0x4010000000000000, %rdx # imm = 0x4010000000000000
               	movq	%rdx, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, (%rcx,%riz)
               	leaq	-0x10(%rbp), %rcx
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, 0x8(%rcx,%riz)
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x10(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xd, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa0(%rbp), %rcx
               	movl	$0x3, %eax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	leaq	-0x10(%rbp), %rax
               	movsd	(%rcx,%riz), %xmm1
               	addsd	%xmm0, %xmm1
               	movsd	%xmm1, (%rax,%riz)
               	movsd	0x8(%rcx,%riz), %xmm1
               	movapd	%xmm0, %xmm15
               	movapd	%xmm1, %xmm0
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, 0x8(%rax,%riz)
               	leaq	-0x30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xa0(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	addq	$0x0, %rcx
               	leaq	(%rax), %rdx
               	movsd	(%rdx,%riz), %xmm0
               	movabsq	$0x4008000000000000, %rdx # imm = 0x4008000000000000
               	movq	%rdx, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, (%rcx,%riz)
               	leaq	-0x10(%rbp), %rcx
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, 0x8(%rcx,%riz)
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x10(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xe, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xc0(%rbp), %rcx
               	leaq	-0xb0(%rbp), %rdx
               	leaq	-0x10(%rbp), %rax
               	movss	(%rcx,%riz), %xmm0
               	movss	(%rdx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	movss	0x4(%rcx,%riz), %xmm0
               	movss	0x4(%rdx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rax,%riz)
               	movss	0x8(%rcx,%riz), %xmm0
               	movss	0x8(%rdx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rax,%riz)
               	movss	0xc(%rcx,%riz), %xmm0
               	movss	0xc(%rdx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rax,%riz)
               	leaq	-0x50(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xc0(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0x30(%rbp), %rcx
               	leaq	-0xb0(%rbp), %rdx
               	leaq	-0x10(%rbp), %rax
               	movss	(%rcx,%riz), %xmm0
               	movss	(%rdx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	movss	0x4(%rcx,%riz), %xmm0
               	movss	0x4(%rdx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rax,%riz)
               	movss	0x8(%rcx,%riz), %xmm0
               	movss	0x8(%rdx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rax,%riz)
               	movss	0xc(%rcx,%riz), %xmm0
               	movss	0xc(%rdx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rax,%riz)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x50(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xf, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xc0(%rbp), %rcx
               	leaq	-0xb0(%rbp), %rdx
               	leaq	-0x10(%rbp), %rax
               	movss	(%rcx,%riz), %xmm0
               	movss	(%rdx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	movss	0x4(%rcx,%riz), %xmm0
               	movss	0x4(%rdx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rax,%riz)
               	movss	0x8(%rcx,%riz), %xmm0
               	movss	0x8(%rdx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rax,%riz)
               	movss	0xc(%rcx,%riz), %xmm0
               	movss	0xc(%rdx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rax,%riz)
               	leaq	-0x50(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xc0(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0x30(%rbp), %rcx
               	leaq	-0xb0(%rbp), %rdx
               	leaq	-0x10(%rbp), %rax
               	movss	(%rcx,%riz), %xmm0
               	movss	(%rdx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	movss	0x4(%rcx,%riz), %xmm0
               	movss	0x4(%rdx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rax,%riz)
               	movss	0x8(%rcx,%riz), %xmm0
               	movss	0x8(%rdx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rax,%riz)
               	movss	0xc(%rcx,%riz), %xmm0
               	movss	0xc(%rdx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rax,%riz)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x50(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x10, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa0(%rbp), %rcx
               	leaq	-0x90(%rbp), %rdx
               	leaq	-0x10(%rbp), %rax
               	movsd	(%rcx,%riz), %xmm0
               	movsd	(%rdx,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movsd	0x8(%rcx,%riz), %xmm0
               	movsd	0x8(%rdx,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rax,%riz)
               	leaq	-0x50(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xa0(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0x30(%rbp), %rcx
               	leaq	-0x90(%rbp), %rdx
               	leaq	-0x10(%rbp), %rax
               	movsd	(%rcx,%riz), %xmm0
               	movsd	(%rdx,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movsd	0x8(%rcx,%riz), %xmm0
               	movsd	0x8(%rdx,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rax,%riz)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x50(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x11, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xc0(%rbp), %rax
               	leaq	-0x50(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x50(%rbp), %rsi
               	leaq	-0x50(%rbp), %rdx
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	leaq	-0x10(%rbp), %rcx
               	movss	(%rdx,%riz), %xmm0
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, (%rcx,%riz)
               	movss	0x4(%rdx,%riz), %xmm0
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x4(%rcx,%riz)
               	movss	0x8(%rdx,%riz), %xmm0
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x8(%rcx,%riz)
               	movss	0xc(%rdx,%riz), %xmm0
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0xc(%rcx,%riz)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rcx
               	leaq	-0xc0(%rbp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	movss	(%rdx,%riz), %xmm0
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, (%rcx,%riz)
               	movss	0x4(%rdx,%riz), %xmm0
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x4(%rcx,%riz)
               	movss	0x8(%rdx,%riz), %xmm0
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x8(%rcx,%riz)
               	movss	0xc(%rdx,%riz), %xmm0
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0xc(%rcx,%riz)
               	leaq	-0x30(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x50(%rbp), %rdx
               	leaq	-0x30(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x12, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xc0(%rbp), %rcx
               	leaq	-0x10(%rbp), %rax
               	movss	(%rcx,%riz), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	movss	0x4(%rcx,%riz), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0x4(%rax,%riz)
               	movss	0x8(%rcx,%riz), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0x8(%rax,%riz)
               	movss	0xc(%rcx,%riz), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0xc(%rax,%riz)
               	leaq	-0x30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xc0(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	addq	$0x0, %rcx
               	leaq	(%rax), %rdx
               	movss	(%rdx,%riz), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, (%rcx,%riz)
               	leaq	-0x10(%rbp), %rcx
               	movss	0x4(%rax,%riz), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0x4(%rcx,%riz)
               	leaq	-0x10(%rbp), %rcx
               	movss	0x8(%rax,%riz), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0x8(%rcx,%riz)
               	leaq	-0x10(%rbp), %rcx
               	movss	0xc(%rax,%riz), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0xc(%rcx,%riz)
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x10(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x13, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movzbq	0xf(%rax), %rax
               	xorq	$0x80, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa0(%rbp), %rcx
               	leaq	-0x10(%rbp), %rax
               	movsd	(%rcx,%riz), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movsd	0x8(%rcx,%riz), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	%xmm0, 0x8(%rax,%riz)
               	leaq	-0x30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xa0(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	addq	$0x0, %rcx
               	leaq	(%rax), %rdx
               	movsd	(%rdx,%riz), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	%xmm0, (%rcx,%riz)
               	leaq	-0x10(%rbp), %rcx
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	%xmm0, 0x8(%rcx,%riz)
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x10(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x15, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xc0(%rbp), %rax
               	leaq	-0xb0(%rbp), %rcx
               	movss	(%rax,%riz), %xmm0
               	movss	(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0x4(%rax,%riz), %xmm1
               	movss	0x4(%rcx,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	movss	0x8(%rcx,%riz), %xmm3
               	addss	%xmm3, %xmm2
               	movss	0xc(%rax,%riz), %xmm3
               	movss	0xc(%rcx,%riz), %xmm4
               	addss	%xmm4, %xmm3
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	leaq	-0xc0(%rbp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	movss	(%rdx,%riz), %xmm4
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm4, %xmm0
               	vfmsub231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) - xmm0
               	movss	%xmm0, (%rcx,%riz)
               	movss	0x4(%rdx,%riz), %xmm0
               	movapd	%xmm1, %xmm14
               	movq	%rax, %xmm15
               	vfmsub231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) - xmm0
               	movss	%xmm0, 0x4(%rcx,%riz)
               	movss	0x8(%rdx,%riz), %xmm0
               	movapd	%xmm2, %xmm14
               	movq	%rax, %xmm15
               	vfmsub231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) - xmm0
               	movss	%xmm0, 0x8(%rcx,%riz)
               	movss	0xc(%rdx,%riz), %xmm0
               	movapd	%xmm3, %xmm14
               	movq	%rax, %xmm15
               	vfmsub231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) - xmm0
               	movss	%xmm0, 0xc(%rcx,%riz)
               	leaq	-0x30(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xc0(%rbp), %rdi
               	leaq	-0xb0(%rbp), %r8
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rsi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rsi,%rdx), %r9
               	leaq	(%rdi,%rdx), %rsi
               	movss	(%rsi,%riz), %xmm0
               	addq	%r8, %rdx
               	movss	(%rdx,%riz), %xmm1
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	addss	%xmm15, %xmm1
               	movl	$0x40000000, %edx       # imm = 0x40000000
               	movapd	%xmm1, %xmm14
               	movq	%rdx, %xmm15
               	vfmsub231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) - xmm0
               	movss	%xmm0, (%r9,%riz)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x10(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x16, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
