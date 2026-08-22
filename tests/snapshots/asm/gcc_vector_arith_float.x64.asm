
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
               	subq	$0xe0, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0xc0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	-0xb0(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movq	%rcx, %rdx
               	leaq	-0xa0(%rbp), %rdx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	-0x90(%rbp), %rdx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	-0x80(%rbp), %rdx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	movq	0x10(%rsi), %rax
               	movq	%rax, 0x10(%rdx)
               	movq	0x18(%rsi), %rax
               	movq	%rax, 0x18(%rdx)
               	popq	%rax
               	leaq	-0x60(%rbp), %rdx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	movq	0x10(%rsi), %rax
               	movq	%rax, 0x10(%rdx)
               	movq	0x18(%rsi), %rax
               	movq	%rax, 0x18(%rdx)
               	popq	%rax
               	leaq	-0x10(%rbp), %rdx
               	movss	(%rax,%riz), %xmm0
               	movss	(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx,%riz)
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx,%riz)
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	leaq	-0x30(%rbp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdi
               	leaq	(%rdx), %rdi
               	leaq	(%rax), %r8
               	movss	(%r8,%riz), %xmm0
               	leaq	(%rcx), %r8
               	movss	(%r8,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, (%rdi,%riz)
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx,%riz)
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x10(%rbp), %rdx
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rdx,%rcx), %r8
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
               	movq	(%rsp), %rbx
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xc0(%rbp), %rax
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movss	(%rax,%riz), %xmm0
               	movss	(%rcx,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx,%riz)
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx,%riz)
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	leaq	-0x30(%rbp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdi
               	leaq	(%rdx), %rdi
               	leaq	(%rax), %r8
               	movss	(%r8,%riz), %xmm0
               	leaq	(%rcx), %r8
               	movss	(%r8,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, (%rdi,%riz)
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx,%riz)
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x10(%rbp), %rdx
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rdx,%rcx), %r8
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
               	movq	(%rsp), %rbx
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xc0(%rbp), %rax
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movss	(%rax,%riz), %xmm0
               	movss	(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx,%riz)
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx,%riz)
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	leaq	-0x30(%rbp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdi
               	leaq	(%rdx), %rdi
               	leaq	(%rax), %r8
               	movss	(%r8,%riz), %xmm0
               	leaq	(%rcx), %r8
               	movss	(%r8,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, (%rdi,%riz)
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx,%riz)
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x10(%rbp), %rdx
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rdx,%rcx), %r8
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
               	movq	(%rsp), %rbx
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xc0(%rbp), %rax
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movss	(%rax,%riz), %xmm0
               	movss	(%rcx,%riz), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx,%riz)
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx,%riz)
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	leaq	-0x30(%rbp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdi
               	leaq	(%rdx), %rdi
               	leaq	(%rax), %r8
               	movss	(%r8,%riz), %xmm0
               	leaq	(%rcx), %r8
               	movss	(%r8,%riz), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, (%rdi,%riz)
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx,%riz)
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x10(%rbp), %rdx
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rdx,%rcx), %r8
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
               	movq	(%rsp), %rbx
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa0(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movsd	(%rax,%riz), %xmm0
               	movsd	(%rcx,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rdx,%riz)
               	movsd	0x8(%rax,%riz), %xmm0
               	movsd	0x8(%rcx,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x30(%rbp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdi
               	leaq	(%rdx), %rdi
               	leaq	(%rax), %r8
               	movsd	(%r8,%riz), %xmm0
               	leaq	(%rcx), %r8
               	movsd	(%r8,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rdi,%riz)
               	movsd	0x8(%rax,%riz), %xmm0
               	movsd	0x8(%rcx,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rdx,%riz)
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rdx,%rcx), %r8
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
               	movq	(%rsp), %rbx
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa0(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movsd	(%rax,%riz), %xmm0
               	movsd	(%rcx,%riz), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rdx,%riz)
               	movsd	0x8(%rax,%riz), %xmm0
               	movsd	0x8(%rcx,%riz), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x30(%rbp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdi
               	leaq	(%rdx), %rdi
               	leaq	(%rax), %r8
               	movsd	(%r8,%riz), %xmm0
               	leaq	(%rcx), %r8
               	movsd	(%r8,%riz), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rdi,%riz)
               	movsd	0x8(%rax,%riz), %xmm0
               	movsd	0x8(%rcx,%riz), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rdx,%riz)
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rdx,%rcx), %r8
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
               	movq	(%rsp), %rbx
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa0(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movsd	(%rax,%riz), %xmm0
               	movsd	(%rcx,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rdx,%riz)
               	movsd	0x8(%rax,%riz), %xmm0
               	movsd	0x8(%rcx,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x30(%rbp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdi
               	leaq	(%rdx), %rdi
               	leaq	(%rax), %r8
               	movsd	(%r8,%riz), %xmm0
               	leaq	(%rcx), %r8
               	movsd	(%r8,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rdi,%riz)
               	movsd	0x8(%rax,%riz), %xmm0
               	movsd	0x8(%rcx,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rdx,%riz)
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rdx,%rcx), %r8
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
               	movq	(%rsp), %rbx
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa0(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movsd	(%rax,%riz), %xmm0
               	movsd	(%rcx,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rdx,%riz)
               	movsd	0x8(%rax,%riz), %xmm0
               	movsd	0x8(%rcx,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x30(%rbp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdi
               	leaq	(%rdx), %rdi
               	leaq	(%rax), %r8
               	movsd	(%r8,%riz), %xmm0
               	leaq	(%rcx), %r8
               	movsd	(%r8,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rdi,%riz)
               	movsd	0x8(%rax,%riz), %xmm0
               	movsd	0x8(%rcx,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rdx,%riz)
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rdx,%rcx), %r8
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
               	movq	(%rsp), %rbx
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	leaq	-0x60(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	movss	(%rax,%riz), %xmm0
               	movss	(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx,%riz)
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx,%riz)
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	movss	0x10(%rax,%riz), %xmm0
               	movss	0x10(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x10(%rdx,%riz)
               	movss	0x14(%rax,%riz), %xmm0
               	movss	0x14(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x14(%rdx,%riz)
               	movss	0x18(%rax,%riz), %xmm0
               	movss	0x18(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x18(%rdx,%riz)
               	movss	0x1c(%rax,%riz), %xmm0
               	movss	0x1c(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x1c(%rdx,%riz)
               	leaq	-0x40(%rbp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	movq	0x10(%rdx), %rax
               	movq	%rax, 0x10(%rsi)
               	movq	0x18(%rdx), %rax
               	movq	%rax, 0x18(%rsi)
               	popq	%rax
               	leaq	(%rdx), %rsi
               	leaq	(%rax), %rdi
               	movss	(%rdi,%riz), %xmm0
               	leaq	(%rcx), %rdi
               	movss	(%rdi,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, (%rsi,%riz)
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx,%riz)
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x20(%rbp), %rdx
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	movss	0x10(%rax,%riz), %xmm0
               	movss	0x10(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x10(%rdx,%riz)
               	movss	0x14(%rax,%riz), %xmm0
               	movss	0x14(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x14(%rdx,%riz)
               	movss	0x18(%rax,%riz), %xmm0
               	movss	0x18(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x18(%rdx,%riz)
               	movss	0x1c(%rax,%riz), %xmm0
               	movss	0x1c(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x1c(%rdx,%riz)
               	leaq	-0x40(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rdx,%rcx), %r8
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
               	movq	(%rsp), %rbx
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	leaq	-0x60(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	movss	(%rax,%riz), %xmm0
               	movss	(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx,%riz)
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx,%riz)
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	movss	0x10(%rax,%riz), %xmm0
               	movss	0x10(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x10(%rdx,%riz)
               	movss	0x14(%rax,%riz), %xmm0
               	movss	0x14(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x14(%rdx,%riz)
               	movss	0x18(%rax,%riz), %xmm0
               	movss	0x18(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x18(%rdx,%riz)
               	movss	0x1c(%rax,%riz), %xmm0
               	movss	0x1c(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x1c(%rdx,%riz)
               	leaq	-0x40(%rbp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	movq	0x10(%rdx), %rax
               	movq	%rax, 0x10(%rsi)
               	movq	0x18(%rdx), %rax
               	movq	%rax, 0x18(%rsi)
               	popq	%rax
               	leaq	(%rdx), %rsi
               	leaq	(%rax), %rdi
               	movss	(%rdi,%riz), %xmm0
               	leaq	(%rcx), %rdi
               	movss	(%rdi,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, (%rsi,%riz)
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx,%riz)
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x20(%rbp), %rdx
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	movss	0x10(%rax,%riz), %xmm0
               	movss	0x10(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x10(%rdx,%riz)
               	movss	0x14(%rax,%riz), %xmm0
               	movss	0x14(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x14(%rdx,%riz)
               	movss	0x18(%rax,%riz), %xmm0
               	movss	0x18(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x18(%rdx,%riz)
               	movss	0x1c(%rax,%riz), %xmm0
               	movss	0x1c(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x1c(%rdx,%riz)
               	leaq	-0x40(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rdx,%rcx), %r8
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
               	movq	(%rsp), %rbx
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xc0(%rbp), %rax
               	movl	$0x40200000, %edx       # imm = 0x40200000
               	leaq	-0x10(%rbp), %rcx
               	movss	(%rax,%riz), %xmm0
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, (%rcx,%riz)
               	movss	0x4(%rax,%riz), %xmm0
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x4(%rcx,%riz)
               	movss	0x8(%rax,%riz), %xmm0
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x8(%rcx,%riz)
               	movss	0xc(%rax,%riz), %xmm0
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0xc(%rcx,%riz)
               	leaq	-0x30(%rbp), %rsi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdi
               	leaq	(%rcx), %rdi
               	leaq	(%rax), %r8
               	movss	(%r8,%riz), %xmm0
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, (%rdi,%riz)
               	movss	0x4(%rax,%riz), %xmm0
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x4(%rcx,%riz)
               	leaq	-0x10(%rbp), %rdx
               	movss	0x8(%rax,%riz), %xmm0
               	movl	$0x40200000, %ecx       # imm = 0x40200000
               	movq	%rcx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	movss	0xc(%rax,%riz), %xmm0
               	movq	%rcx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rdx,%rcx), %r8
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
               	movq	(%rsp), %rbx
               	addq	$0xe0, %rsp
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
               	leaq	-0x30(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	leaq	(%rax), %rsi
               	leaq	(%rcx), %rdx
               	movss	(%rdx,%riz), %xmm0
               	movl	$0x40400000, %edx       # imm = 0x40400000
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, (%rsi,%riz)
               	movss	0x4(%rcx,%riz), %xmm0
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x4(%rax,%riz)
               	movss	0x8(%rcx,%riz), %xmm0
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x8(%rax,%riz)
               	movss	0xc(%rcx,%riz), %xmm0
               	movl	$0x40400000, %ecx       # imm = 0x40400000
               	movq	%rcx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0xc(%rax,%riz)
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
               	movq	(%rsp), %rbx
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa0(%rbp), %rcx
               	movabsq	$0x4010000000000000, %rsi # imm = 0x4010000000000000
               	leaq	-0x10(%rbp), %rax
               	movsd	(%rcx,%riz), %xmm0
               	movq	%rsi, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movsd	0x8(%rcx,%riz), %xmm0
               	movq	%rsi, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, 0x8(%rax,%riz)
               	leaq	-0x30(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rdi
               	leaq	(%rax), %rdi
               	leaq	(%rcx), %r8
               	movsd	(%r8,%riz), %xmm0
               	movq	%rsi, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, (%rdi,%riz)
               	movsd	0x8(%rcx,%riz), %xmm0
               	movq	%rsi, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, 0x8(%rax,%riz)
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
               	movq	(%rsp), %rbx
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa0(%rbp), %rax
               	movl	$0x3, %ecx
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rcx, %xmm0
               	leaq	-0x10(%rbp), %rdx
               	movsd	(%rax,%riz), %xmm1
               	addsd	%xmm0, %xmm1
               	movsd	%xmm1, (%rdx,%riz)
               	movsd	0x8(%rax,%riz), %xmm1
               	movapd	%xmm0, %xmm15
               	movapd	%xmm1, %xmm0
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x30(%rbp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rcx
               	leaq	(%rdx), %rdi
               	leaq	(%rax), %rcx
               	movsd	(%rcx,%riz), %xmm0
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, (%rdi,%riz)
               	movsd	0x8(%rax,%riz), %xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, 0x8(%rdx,%riz)
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rdx,%rcx), %r8
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
               	movq	(%rsp), %rbx
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xc0(%rbp), %rdi
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x10(%rbp), %rax
               	movss	(%rdi,%riz), %xmm0
               	movss	(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	movss	0x4(%rdi,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rax,%riz)
               	movss	0x8(%rdi,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rax,%riz)
               	movss	0xc(%rdi,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rax,%riz)
               	leaq	-0x50(%rbp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rdx
               	leaq	-0x30(%rbp), %rdx
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rdi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rdi
               	movss	(%rdx,%riz), %xmm0
               	movss	(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	movss	0x4(%rdx,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rax,%riz)
               	movss	0x8(%rdx,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rax,%riz)
               	movss	0xc(%rdx,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rax,%riz)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
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
               	movq	(%rsp), %rbx
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xc0(%rbp), %rdi
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x10(%rbp), %rax
               	movss	(%rdi,%riz), %xmm0
               	movss	(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	movss	0x4(%rdi,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rax,%riz)
               	movss	0x8(%rdi,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rax,%riz)
               	movss	0xc(%rdi,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rax,%riz)
               	leaq	-0x50(%rbp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rdx
               	leaq	-0x30(%rbp), %rdx
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rdi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rdi
               	movss	(%rdx,%riz), %xmm0
               	movss	(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	movss	0x4(%rdx,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rax,%riz)
               	movss	0x8(%rdx,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rax,%riz)
               	movss	0xc(%rdx,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rax,%riz)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
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
               	movq	(%rsp), %rbx
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x10(%rbp), %rax
               	movsd	(%rdi,%riz), %xmm0
               	movsd	(%rcx,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movsd	0x8(%rdi,%riz), %xmm0
               	movsd	0x8(%rcx,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rax,%riz)
               	leaq	-0x50(%rbp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rdx
               	leaq	-0x30(%rbp), %rdx
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rdi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rdi
               	movsd	(%rdx,%riz), %xmm0
               	movsd	(%rcx,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movsd	0x8(%rdx,%riz), %xmm0
               	movsd	0x8(%rcx,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rax,%riz)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
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
               	movq	(%rsp), %rbx
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xc0(%rbp), %rcx
               	leaq	-0x50(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rax
               	movl	$0x40000000, %esi       # imm = 0x40000000
               	leaq	-0x10(%rbp), %rax
               	movss	(%rdx,%riz), %xmm0
               	movq	%rsi, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	movss	0x4(%rdx,%riz), %xmm0
               	movq	%rsi, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x4(%rax,%riz)
               	movss	0x8(%rdx,%riz), %xmm0
               	movq	%rsi, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x8(%rax,%riz)
               	movss	0xc(%rdx,%riz), %xmm0
               	movq	%rsi, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0xc(%rax,%riz)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rdi
               	movss	(%rcx,%riz), %xmm0
               	movq	%rsi, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	movss	0x4(%rcx,%riz), %xmm0
               	movq	%rsi, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x4(%rax,%riz)
               	movss	0x8(%rcx,%riz), %xmm0
               	movq	%rsi, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x8(%rax,%riz)
               	movss	0xc(%rcx,%riz), %xmm0
               	movq	%rsi, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0xc(%rax,%riz)
               	leaq	-0x30(%rbp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
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
               	movq	(%rsp), %rbx
               	addq	$0xe0, %rsp
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
               	leaq	-0x30(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rsi
               	leaq	(%rax), %rsi
               	leaq	(%rcx), %rdi
               	movss	(%rdi,%riz), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, (%rsi,%riz)
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
               	movq	(%rsp), %rbx
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rsi
               	movzbq	0xf(%rsi), %rax
               	xorq	$0x80, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	movq	(%rsp), %rbx
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa0(%rbp), %rax
               	leaq	-0x10(%rbp), %rdx
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	%xmm0, (%rdx,%riz)
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	%xmm0, 0x8(%rdx,%riz)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rcx
               	leaq	(%rdx), %rcx
               	leaq	(%rax), %rdi
               	movsd	(%rdi,%riz), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	%xmm0, (%rcx,%riz)
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	%xmm0, 0x8(%rdx,%riz)
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rdx,%rcx), %r8
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
               	movq	(%rsp), %rbx
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xc0(%rbp), %rsi
               	leaq	-0xb0(%rbp), %r9
               	movss	(%rsi,%riz), %xmm0
               	movss	(%r9,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0x4(%rsi,%riz), %xmm1
               	movss	0x4(%r9,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rsi,%riz), %xmm2
               	movss	0x8(%r9,%riz), %xmm3
               	addss	%xmm3, %xmm2
               	movss	0xc(%rsi,%riz), %xmm3
               	movss	0xc(%r9,%riz), %xmm4
               	addss	%xmm4, %xmm3
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	leaq	-0x10(%rbp), %r8
               	movss	(%rsi,%riz), %xmm4
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm4, %xmm0
               	vfmsub231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) - xmm0
               	movss	%xmm0, (%r8,%riz)
               	movss	0x4(%rsi,%riz), %xmm0
               	movapd	%xmm1, %xmm14
               	movq	%rax, %xmm15
               	vfmsub231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) - xmm0
               	movss	%xmm0, 0x4(%r8,%riz)
               	movss	0x8(%rsi,%riz), %xmm0
               	movapd	%xmm2, %xmm14
               	movq	%rax, %xmm15
               	vfmsub231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) - xmm0
               	movss	%xmm0, 0x8(%r8,%riz)
               	movss	0xc(%rsi,%riz), %xmm0
               	movapd	%xmm3, %xmm14
               	movq	%rax, %xmm15
               	vfmsub231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) - xmm0
               	movss	%xmm0, 0xc(%r8,%riz)
               	leaq	-0x30(%rbp), %rax
               	pushq	%rcx
               	movq	(%r8), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%r8), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	xorq	%rax, %rax
               	jmp	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%r8,%rdx), %rbx
               	leaq	(%rsi,%rdx), %rdi
               	movss	(%rdi,%riz), %xmm0
               	addq	%r9, %rdx
               	movss	(%rdx,%riz), %xmm1
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	addss	%xmm15, %xmm1
               	movl	$0x40000000, %edx       # imm = 0x40000000
               	movapd	%xmm1, %xmm14
               	movq	%rdx, %xmm15
               	vfmsub231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) - xmm0
               	movss	%xmm0, (%rbx,%riz)
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
               	movq	(%rsp), %rbx
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0xe0, %rsp
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
