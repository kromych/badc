
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
               	subq	$0x550, %rsp            # imm = 0x550
               	movq	%rbx, (%rsp)
               	leaq	-0x4a8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x4b8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x4c8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x4d8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x4f8(%rbp), %rax
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
               	leaq	-0x518(%rbp), %rax
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
               	leaq	-0x4a8(%rbp), %rcx
               	leaq	-0x4b8(%rbp), %rdx
               	leaq	-0x18(%rbp), %rax
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
               	leaq	-0x528(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x4a8(%rbp), %rax
               	leaq	-0x4b8(%rbp), %rcx
               	leaq	-0x538(%rbp), %rdx
               	addq	$0x0, %rdx
               	leaq	(%rax), %rsi
               	movss	(%rsi,%riz), %xmm0
               	leaq	(%rcx), %rsi
               	movss	(%rsi,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx,%riz)
               	leaq	-0x538(%rbp), %rdx
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx,%riz)
               	leaq	-0x538(%rbp), %rdx
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x538(%rbp), %rdx
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	leaq	-0x528(%rbp), %rdx
               	leaq	-0x538(%rbp), %rsi
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
               	movq	(%rsp), %rbx
               	addq	$0x550, %rsp            # imm = 0x550
               	popq	%rbp
               	retq
               	leaq	-0x4a8(%rbp), %rcx
               	leaq	-0x4b8(%rbp), %rdx
               	leaq	-0x28(%rbp), %rax
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
               	leaq	-0x488(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x4a8(%rbp), %rax
               	leaq	-0x4b8(%rbp), %rcx
               	leaq	-0x498(%rbp), %rdx
               	addq	$0x0, %rdx
               	leaq	(%rax), %rsi
               	movss	(%rsi,%riz), %xmm0
               	leaq	(%rcx), %rsi
               	movss	(%rsi,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx,%riz)
               	leaq	-0x498(%rbp), %rdx
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx,%riz)
               	leaq	-0x498(%rbp), %rdx
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x498(%rbp), %rdx
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	leaq	-0x488(%rbp), %rdx
               	leaq	-0x498(%rbp), %rsi
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
               	movq	(%rsp), %rbx
               	addq	$0x550, %rsp            # imm = 0x550
               	popq	%rbp
               	retq
               	leaq	-0x4a8(%rbp), %rcx
               	leaq	-0x4b8(%rbp), %rdx
               	leaq	-0x38(%rbp), %rax
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
               	leaq	-0x468(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x4a8(%rbp), %rax
               	leaq	-0x4b8(%rbp), %rcx
               	leaq	-0x478(%rbp), %rdx
               	addq	$0x0, %rdx
               	leaq	(%rax), %rsi
               	movss	(%rsi,%riz), %xmm0
               	leaq	(%rcx), %rsi
               	movss	(%rsi,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx,%riz)
               	leaq	-0x478(%rbp), %rdx
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx,%riz)
               	leaq	-0x478(%rbp), %rdx
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x478(%rbp), %rdx
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	leaq	-0x468(%rbp), %rdx
               	leaq	-0x478(%rbp), %rsi
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
               	movq	(%rsp), %rbx
               	addq	$0x550, %rsp            # imm = 0x550
               	popq	%rbp
               	retq
               	leaq	-0x4a8(%rbp), %rcx
               	leaq	-0x4b8(%rbp), %rdx
               	leaq	-0x48(%rbp), %rax
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
               	leaq	-0x448(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x4a8(%rbp), %rax
               	leaq	-0x4b8(%rbp), %rcx
               	leaq	-0x458(%rbp), %rdx
               	addq	$0x0, %rdx
               	leaq	(%rax), %rsi
               	movss	(%rsi,%riz), %xmm0
               	leaq	(%rcx), %rsi
               	movss	(%rsi,%riz), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx,%riz)
               	leaq	-0x458(%rbp), %rdx
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx,%riz)
               	leaq	-0x458(%rbp), %rdx
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x458(%rbp), %rdx
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	leaq	-0x448(%rbp), %rdx
               	leaq	-0x458(%rbp), %rsi
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
               	movq	(%rsp), %rbx
               	addq	$0x550, %rsp            # imm = 0x550
               	popq	%rbp
               	retq
               	leaq	-0x4c8(%rbp), %rcx
               	leaq	-0x4d8(%rbp), %rdx
               	leaq	-0x58(%rbp), %rax
               	movsd	(%rcx,%riz), %xmm0
               	movsd	(%rdx,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movsd	0x8(%rcx,%riz), %xmm0
               	movsd	0x8(%rdx,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rax,%riz)
               	leaq	-0x428(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x4c8(%rbp), %rax
               	leaq	-0x4d8(%rbp), %rcx
               	leaq	-0x438(%rbp), %rdx
               	addq	$0x0, %rdx
               	leaq	(%rax), %rsi
               	movsd	(%rsi,%riz), %xmm0
               	leaq	(%rcx), %rsi
               	movsd	(%rsi,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rdx,%riz)
               	leaq	-0x438(%rbp), %rdx
               	movsd	0x8(%rax,%riz), %xmm0
               	movsd	0x8(%rcx,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x428(%rbp), %rdx
               	leaq	-0x438(%rbp), %rsi
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
               	movq	(%rsp), %rbx
               	addq	$0x550, %rsp            # imm = 0x550
               	popq	%rbp
               	retq
               	leaq	-0x4c8(%rbp), %rcx
               	leaq	-0x4d8(%rbp), %rdx
               	leaq	-0x68(%rbp), %rax
               	movsd	(%rcx,%riz), %xmm0
               	movsd	(%rdx,%riz), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movsd	0x8(%rcx,%riz), %xmm0
               	movsd	0x8(%rdx,%riz), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rax,%riz)
               	leaq	-0x408(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x4c8(%rbp), %rax
               	leaq	-0x4d8(%rbp), %rcx
               	leaq	-0x418(%rbp), %rdx
               	addq	$0x0, %rdx
               	leaq	(%rax), %rsi
               	movsd	(%rsi,%riz), %xmm0
               	leaq	(%rcx), %rsi
               	movsd	(%rsi,%riz), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rdx,%riz)
               	leaq	-0x418(%rbp), %rdx
               	movsd	0x8(%rax,%riz), %xmm0
               	movsd	0x8(%rcx,%riz), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x408(%rbp), %rdx
               	leaq	-0x418(%rbp), %rsi
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
               	movq	(%rsp), %rbx
               	addq	$0x550, %rsp            # imm = 0x550
               	popq	%rbp
               	retq
               	leaq	-0x4c8(%rbp), %rcx
               	leaq	-0x4d8(%rbp), %rdx
               	leaq	-0x78(%rbp), %rax
               	movsd	(%rcx,%riz), %xmm0
               	movsd	(%rdx,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movsd	0x8(%rcx,%riz), %xmm0
               	movsd	0x8(%rdx,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rax,%riz)
               	leaq	-0x3e8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x4c8(%rbp), %rax
               	leaq	-0x4d8(%rbp), %rcx
               	leaq	-0x3f8(%rbp), %rdx
               	addq	$0x0, %rdx
               	leaq	(%rax), %rsi
               	movsd	(%rsi,%riz), %xmm0
               	leaq	(%rcx), %rsi
               	movsd	(%rsi,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rdx,%riz)
               	leaq	-0x3f8(%rbp), %rdx
               	movsd	0x8(%rax,%riz), %xmm0
               	movsd	0x8(%rcx,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x3e8(%rbp), %rdx
               	leaq	-0x3f8(%rbp), %rsi
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
               	movq	(%rsp), %rbx
               	addq	$0x550, %rsp            # imm = 0x550
               	popq	%rbp
               	retq
               	leaq	-0x4c8(%rbp), %rcx
               	leaq	-0x4d8(%rbp), %rdx
               	leaq	-0x88(%rbp), %rax
               	movsd	(%rcx,%riz), %xmm0
               	movsd	(%rdx,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movsd	0x8(%rcx,%riz), %xmm0
               	movsd	0x8(%rdx,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rax,%riz)
               	leaq	-0x3c8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x4c8(%rbp), %rax
               	leaq	-0x4d8(%rbp), %rcx
               	leaq	-0x3d8(%rbp), %rdx
               	addq	$0x0, %rdx
               	leaq	(%rax), %rsi
               	movsd	(%rsi,%riz), %xmm0
               	leaq	(%rcx), %rsi
               	movsd	(%rsi,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rdx,%riz)
               	leaq	-0x3d8(%rbp), %rdx
               	movsd	0x8(%rax,%riz), %xmm0
               	movsd	0x8(%rcx,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x3c8(%rbp), %rdx
               	leaq	-0x3d8(%rbp), %rsi
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
               	movq	(%rsp), %rbx
               	addq	$0x550, %rsp            # imm = 0x550
               	popq	%rbp
               	retq
               	leaq	-0x4f8(%rbp), %rcx
               	leaq	-0x518(%rbp), %rdx
               	leaq	-0xa8(%rbp), %rax
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
               	leaq	-0x398(%rbp), %rcx
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
               	leaq	-0x4f8(%rbp), %rax
               	leaq	-0x518(%rbp), %rcx
               	leaq	-0x3b8(%rbp), %rdx
               	addq	$0x0, %rdx
               	leaq	(%rax), %rsi
               	movss	(%rsi,%riz), %xmm0
               	leaq	(%rcx), %rsi
               	movss	(%rsi,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx,%riz)
               	leaq	-0x3b8(%rbp), %rdx
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx,%riz)
               	leaq	-0x3b8(%rbp), %rdx
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x3b8(%rbp), %rdx
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	leaq	-0x3b8(%rbp), %rdx
               	movss	0x10(%rax,%riz), %xmm0
               	movss	0x10(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x10(%rdx,%riz)
               	leaq	-0x3b8(%rbp), %rdx
               	movss	0x14(%rax,%riz), %xmm0
               	movss	0x14(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x14(%rdx,%riz)
               	leaq	-0x3b8(%rbp), %rdx
               	movss	0x18(%rax,%riz), %xmm0
               	movss	0x18(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x18(%rdx,%riz)
               	leaq	-0x3b8(%rbp), %rdx
               	movss	0x1c(%rax,%riz), %xmm0
               	movss	0x1c(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x1c(%rdx,%riz)
               	leaq	-0x398(%rbp), %rdx
               	leaq	-0x3b8(%rbp), %rsi
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
               	movq	(%rsp), %rbx
               	addq	$0x550, %rsp            # imm = 0x550
               	popq	%rbp
               	retq
               	leaq	-0x4f8(%rbp), %rcx
               	leaq	-0x518(%rbp), %rdx
               	leaq	-0xc8(%rbp), %rax
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
               	leaq	-0x358(%rbp), %rcx
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
               	leaq	-0x4f8(%rbp), %rax
               	leaq	-0x518(%rbp), %rcx
               	leaq	-0x378(%rbp), %rdx
               	addq	$0x0, %rdx
               	leaq	(%rax), %rsi
               	movss	(%rsi,%riz), %xmm0
               	leaq	(%rcx), %rsi
               	movss	(%rsi,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx,%riz)
               	leaq	-0x378(%rbp), %rdx
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx,%riz)
               	leaq	-0x378(%rbp), %rdx
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	leaq	-0x378(%rbp), %rdx
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	leaq	-0x378(%rbp), %rdx
               	movss	0x10(%rax,%riz), %xmm0
               	movss	0x10(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x10(%rdx,%riz)
               	leaq	-0x378(%rbp), %rdx
               	movss	0x14(%rax,%riz), %xmm0
               	movss	0x14(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x14(%rdx,%riz)
               	leaq	-0x378(%rbp), %rdx
               	movss	0x18(%rax,%riz), %xmm0
               	movss	0x18(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x18(%rdx,%riz)
               	leaq	-0x378(%rbp), %rdx
               	movss	0x1c(%rax,%riz), %xmm0
               	movss	0x1c(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x1c(%rdx,%riz)
               	leaq	-0x358(%rbp), %rdx
               	leaq	-0x378(%rbp), %rsi
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
               	movq	(%rsp), %rbx
               	addq	$0x550, %rsp            # imm = 0x550
               	popq	%rbp
               	retq
               	leaq	-0x4a8(%rbp), %rcx
               	movl	$0x40200000, %edx       # imm = 0x40200000
               	leaq	-0xd8(%rbp), %rax
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
               	leaq	-0x328(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x4a8(%rbp), %rax
               	leaq	-0x338(%rbp), %rcx
               	addq	$0x0, %rcx
               	leaq	(%rax), %rdx
               	movss	(%rdx,%riz), %xmm0
               	movl	$0x40200000, %edx       # imm = 0x40200000
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, (%rcx,%riz)
               	leaq	-0x338(%rbp), %rcx
               	movss	0x4(%rax,%riz), %xmm0
               	movl	$0x40200000, %edx       # imm = 0x40200000
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x4(%rcx,%riz)
               	leaq	-0x338(%rbp), %rcx
               	movss	0x8(%rax,%riz), %xmm0
               	movl	$0x40200000, %edx       # imm = 0x40200000
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x8(%rcx,%riz)
               	leaq	-0x338(%rbp), %rcx
               	movss	0xc(%rax,%riz), %xmm0
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0xc(%rcx,%riz)
               	leaq	-0x328(%rbp), %rdx
               	leaq	-0x338(%rbp), %rsi
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
               	movq	(%rsp), %rbx
               	addq	$0x550, %rsp            # imm = 0x550
               	popq	%rbp
               	retq
               	leaq	-0x4a8(%rbp), %rcx
               	movl	$0x3, %eax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	leaq	-0xe8(%rbp), %rax
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
               	leaq	-0x308(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x4a8(%rbp), %rax
               	leaq	-0x318(%rbp), %rcx
               	addq	$0x0, %rcx
               	leaq	(%rax), %rdx
               	movss	(%rdx,%riz), %xmm0
               	movl	$0x40400000, %edx       # imm = 0x40400000
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, (%rcx,%riz)
               	leaq	-0x318(%rbp), %rcx
               	movss	0x4(%rax,%riz), %xmm0
               	movl	$0x40400000, %edx       # imm = 0x40400000
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x4(%rcx,%riz)
               	leaq	-0x318(%rbp), %rcx
               	movss	0x8(%rax,%riz), %xmm0
               	movl	$0x40400000, %edx       # imm = 0x40400000
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x8(%rcx,%riz)
               	leaq	-0x318(%rbp), %rcx
               	movss	0xc(%rax,%riz), %xmm0
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0xc(%rcx,%riz)
               	leaq	-0x308(%rbp), %rdx
               	leaq	-0x318(%rbp), %rsi
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
               	addq	$0x550, %rsp            # imm = 0x550
               	popq	%rbp
               	retq
               	leaq	-0x4c8(%rbp), %rcx
               	movabsq	$0x4010000000000000, %rdx # imm = 0x4010000000000000
               	leaq	-0xf8(%rbp), %rax
               	movsd	(%rcx,%riz), %xmm0
               	movq	%rdx, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movsd	0x8(%rcx,%riz), %xmm0
               	movq	%rdx, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, 0x8(%rax,%riz)
               	leaq	-0x2e8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x4c8(%rbp), %rax
               	leaq	-0x2f8(%rbp), %rcx
               	addq	$0x0, %rcx
               	leaq	(%rax), %rdx
               	movsd	(%rdx,%riz), %xmm0
               	movabsq	$0x4010000000000000, %rdx # imm = 0x4010000000000000
               	movq	%rdx, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, (%rcx,%riz)
               	leaq	-0x2f8(%rbp), %rcx
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, 0x8(%rcx,%riz)
               	leaq	-0x2e8(%rbp), %rdx
               	leaq	-0x2f8(%rbp), %rsi
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
               	addq	$0x550, %rsp            # imm = 0x550
               	popq	%rbp
               	retq
               	leaq	-0x4c8(%rbp), %rcx
               	movl	$0x3, %eax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	leaq	-0x108(%rbp), %rax
               	movsd	(%rcx,%riz), %xmm1
               	addsd	%xmm0, %xmm1
               	movsd	%xmm1, (%rax,%riz)
               	movsd	0x8(%rcx,%riz), %xmm1
               	movapd	%xmm0, %xmm15
               	movapd	%xmm1, %xmm0
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, 0x8(%rax,%riz)
               	leaq	-0x2c8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x4c8(%rbp), %rax
               	leaq	-0x2d8(%rbp), %rcx
               	addq	$0x0, %rcx
               	leaq	(%rax), %rdx
               	movsd	(%rdx,%riz), %xmm0
               	movabsq	$0x4008000000000000, %rdx # imm = 0x4008000000000000
               	movq	%rdx, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, (%rcx,%riz)
               	leaq	-0x2d8(%rbp), %rcx
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, 0x8(%rcx,%riz)
               	leaq	-0x2c8(%rbp), %rdx
               	leaq	-0x2d8(%rbp), %rsi
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
               	movq	(%rsp), %rbx
               	addq	$0x550, %rsp            # imm = 0x550
               	popq	%rbp
               	retq
               	leaq	-0x4a8(%rbp), %rcx
               	leaq	-0x4b8(%rbp), %rdx
               	leaq	-0x118(%rbp), %rax
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
               	leaq	-0x228(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x4a8(%rbp), %rax
               	leaq	-0x238(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x238(%rbp), %rsi
               	leaq	-0x238(%rbp), %rcx
               	leaq	-0x4b8(%rbp), %rdx
               	leaq	-0x128(%rbp), %rax
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
               	leaq	-0x238(%rbp), %rdx
               	leaq	-0x228(%rbp), %rsi
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
               	addq	$0x550, %rsp            # imm = 0x550
               	popq	%rbp
               	retq
               	leaq	-0x4a8(%rbp), %rcx
               	leaq	-0x4b8(%rbp), %rdx
               	leaq	-0x138(%rbp), %rax
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
               	leaq	-0x248(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x4a8(%rbp), %rax
               	leaq	-0x258(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x258(%rbp), %rsi
               	leaq	-0x258(%rbp), %rcx
               	leaq	-0x4b8(%rbp), %rdx
               	leaq	-0x148(%rbp), %rax
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
               	leaq	-0x258(%rbp), %rdx
               	leaq	-0x248(%rbp), %rsi
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
               	addq	$0x550, %rsp            # imm = 0x550
               	popq	%rbp
               	retq
               	leaq	-0x4c8(%rbp), %rcx
               	leaq	-0x4d8(%rbp), %rdx
               	leaq	-0x158(%rbp), %rax
               	movsd	(%rcx,%riz), %xmm0
               	movsd	(%rdx,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movsd	0x8(%rcx,%riz), %xmm0
               	movsd	0x8(%rdx,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rax,%riz)
               	leaq	-0x268(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x4c8(%rbp), %rax
               	leaq	-0x278(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x278(%rbp), %rsi
               	leaq	-0x278(%rbp), %rcx
               	leaq	-0x4d8(%rbp), %rdx
               	leaq	-0x168(%rbp), %rax
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
               	leaq	-0x278(%rbp), %rdx
               	leaq	-0x268(%rbp), %rsi
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
               	addq	$0x550, %rsp            # imm = 0x550
               	popq	%rbp
               	retq
               	leaq	-0x4a8(%rbp), %rax
               	leaq	-0x288(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x288(%rbp), %rsi
               	leaq	-0x288(%rbp), %rdx
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	leaq	-0x178(%rbp), %rcx
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
               	leaq	-0x4a8(%rbp), %rdx
               	leaq	-0x188(%rbp), %rcx
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
               	leaq	-0x298(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x288(%rbp), %rdx
               	leaq	-0x298(%rbp), %rsi
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
               	addq	$0x550, %rsp            # imm = 0x550
               	popq	%rbp
               	retq
               	leaq	-0x4a8(%rbp), %rcx
               	leaq	-0x198(%rbp), %rax
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
               	leaq	-0x2a8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x4a8(%rbp), %rax
               	leaq	-0x2b8(%rbp), %rcx
               	addq	$0x0, %rcx
               	leaq	(%rax), %rdx
               	movss	(%rdx,%riz), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, (%rcx,%riz)
               	leaq	-0x2b8(%rbp), %rcx
               	movss	0x4(%rax,%riz), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0x4(%rcx,%riz)
               	leaq	-0x2b8(%rbp), %rcx
               	movss	0x8(%rax,%riz), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0x8(%rcx,%riz)
               	leaq	-0x2b8(%rbp), %rcx
               	movss	0xc(%rax,%riz), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0xc(%rcx,%riz)
               	leaq	-0x2a8(%rbp), %rdx
               	leaq	-0x2b8(%rbp), %rsi
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
               	addq	$0x550, %rsp            # imm = 0x550
               	popq	%rbp
               	retq
               	leaq	-0x2a8(%rbp), %rax
               	movzbq	0xf(%rax), %rax
               	xorq	$0x80, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	movq	(%rsp), %rbx
               	addq	$0x550, %rsp            # imm = 0x550
               	popq	%rbp
               	retq
               	leaq	-0x4c8(%rbp), %rcx
               	leaq	-0x1a8(%rbp), %rax
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
               	leaq	-0x208(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x4c8(%rbp), %rax
               	leaq	-0x218(%rbp), %rcx
               	addq	$0x0, %rcx
               	leaq	(%rax), %rdx
               	movsd	(%rdx,%riz), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	%xmm0, (%rcx,%riz)
               	leaq	-0x218(%rbp), %rcx
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	%xmm0, 0x8(%rcx,%riz)
               	leaq	-0x208(%rbp), %rdx
               	leaq	-0x218(%rbp), %rsi
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
               	movq	(%rsp), %rbx
               	addq	$0x550, %rsp            # imm = 0x550
               	popq	%rbp
               	retq
               	leaq	-0x4a8(%rbp), %rax
               	leaq	-0x4b8(%rbp), %rcx
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
               	leaq	-0x4a8(%rbp), %rdx
               	leaq	-0x1d8(%rbp), %rcx
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
               	leaq	-0x1e8(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x4a8(%rbp), %rdi
               	leaq	-0x4b8(%rbp), %r8
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1f8(%rbp), %rsi
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
               	leaq	-0x1e8(%rbp), %rdx
               	leaq	-0x1f8(%rbp), %rsi
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
               	addq	$0x550, %rsp            # imm = 0x550
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x550, %rsp            # imm = 0x550
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
