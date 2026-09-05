
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
               	subq	$0x720, %rsp            # imm = 0x720
               	movq	%rbx, (%rsp)
               	subq	$0x240, %rsp            # imm = 0x240
               	andq	$-0x20, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	0x90(%rsp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movq	%rcx, %rdx
               	leaq	0xa0(%rsp), %rdx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	0xb0(%rsp), %rdx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	(%rsp), %rdx
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
               	leaq	0x20(%rsp), %rdx
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
               	leaq	-0x4f8(%rbp), %rsi
               	movss	(%rax,%riz), %xmm0
               	movss	(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, (%rsi,%riz)
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rsi,%riz)
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rsi,%riz)
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rsi,%riz)
               	leaq	0xc0(%rsp), %rdx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rsi
               	leaq	-0xa0(%rbp), %rsi
               	leaq	(%rsi), %rdi
               	leaq	(%rax), %r8
               	movss	(%r8,%riz), %xmm0
               	leaq	(%rcx), %r8
               	movss	(%r8,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, (%rdi,%riz)
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rsi,%riz)
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rsi,%riz)
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rsi,%riz)
               	leaq	-0xa0(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	leaq	-0x720(%rbp), %rsp
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	0x80(%rsp), %rax
               	leaq	0x90(%rsp), %rcx
               	leaq	-0x508(%rbp), %rsi
               	movss	(%rax,%riz), %xmm0
               	movss	(%rcx,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, (%rsi,%riz)
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rsi,%riz)
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rsi,%riz)
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rsi,%riz)
               	leaq	0xd0(%rsp), %rdx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rsi
               	leaq	-0xd8(%rbp), %rsi
               	leaq	(%rsi), %rdi
               	leaq	(%rax), %r8
               	movss	(%r8,%riz), %xmm0
               	leaq	(%rcx), %r8
               	movss	(%r8,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, (%rdi,%riz)
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rsi,%riz)
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rsi,%riz)
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rsi,%riz)
               	leaq	-0xd8(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	leaq	-0x720(%rbp), %rsp
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	0x80(%rsp), %rax
               	leaq	0x90(%rsp), %rcx
               	leaq	-0x518(%rbp), %rsi
               	movss	(%rax,%riz), %xmm0
               	movss	(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, (%rsi,%riz)
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rsi,%riz)
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rsi,%riz)
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rsi,%riz)
               	leaq	0xe0(%rsp), %rdx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rsi
               	leaq	-0x110(%rbp), %rsi
               	leaq	(%rsi), %rdi
               	leaq	(%rax), %r8
               	movss	(%r8,%riz), %xmm0
               	leaq	(%rcx), %r8
               	movss	(%r8,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, (%rdi,%riz)
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rsi,%riz)
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rsi,%riz)
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rsi,%riz)
               	leaq	-0x110(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	leaq	-0x720(%rbp), %rsp
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	0x80(%rsp), %rax
               	leaq	0x90(%rsp), %rcx
               	leaq	-0x528(%rbp), %rsi
               	movss	(%rax,%riz), %xmm0
               	movss	(%rcx,%riz), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, (%rsi,%riz)
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rsi,%riz)
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rsi,%riz)
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rsi,%riz)
               	leaq	0xf0(%rsp), %rdx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rsi
               	leaq	-0x148(%rbp), %rsi
               	leaq	(%rsi), %rdi
               	leaq	(%rax), %r8
               	movss	(%r8,%riz), %xmm0
               	leaq	(%rcx), %r8
               	movss	(%r8,%riz), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, (%rdi,%riz)
               	movss	0x4(%rax,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rsi,%riz)
               	movss	0x8(%rax,%riz), %xmm0
               	movss	0x8(%rcx,%riz), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rsi,%riz)
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rsi,%riz)
               	leaq	-0x148(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	leaq	-0x720(%rbp), %rsp
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %rcx
               	leaq	-0x538(%rbp), %rdx
               	movsd	(%rax,%riz), %xmm0
               	movsd	(%rcx,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rdx,%riz)
               	movsd	0x8(%rax,%riz), %xmm0
               	movsd	0x8(%rcx,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rdx,%riz)
               	leaq	0x100(%rsp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	leaq	-0x180(%rbp), %rdx
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
               	movslq	%eax, %rcx
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	leaq	-0x720(%rbp), %rsp
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %rcx
               	leaq	-0x548(%rbp), %rdx
               	movsd	(%rax,%riz), %xmm0
               	movsd	(%rcx,%riz), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rdx,%riz)
               	movsd	0x8(%rax,%riz), %xmm0
               	movsd	0x8(%rcx,%riz), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rdx,%riz)
               	leaq	0x110(%rsp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	leaq	-0x1b8(%rbp), %rdx
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
               	movslq	%eax, %rcx
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	leaq	-0x720(%rbp), %rsp
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %rcx
               	leaq	-0x558(%rbp), %rdx
               	movsd	(%rax,%riz), %xmm0
               	movsd	(%rcx,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rdx,%riz)
               	movsd	0x8(%rax,%riz), %xmm0
               	movsd	0x8(%rcx,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rdx,%riz)
               	leaq	0x120(%rsp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	leaq	-0x1f0(%rbp), %rdx
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
               	movslq	%eax, %rcx
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	leaq	-0x720(%rbp), %rsp
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %rcx
               	leaq	-0x568(%rbp), %rdx
               	movsd	(%rax,%riz), %xmm0
               	movsd	(%rcx,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rdx,%riz)
               	movsd	0x8(%rax,%riz), %xmm0
               	movsd	0x8(%rcx,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rdx,%riz)
               	leaq	0x130(%rsp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	leaq	-0x228(%rbp), %rdx
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
               	movslq	%eax, %rcx
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x8, %eax
               	leaq	-0x720(%rbp), %rsp
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	-0x588(%rbp), %rdx
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
               	leaq	0x40(%rsp), %rsi
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
               	movq	%rsi, %rdx
               	leaq	-0x280(%rbp), %rdx
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
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	movss	0x10(%rax,%riz), %xmm0
               	movss	0x10(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x10(%rdx,%riz)
               	leaq	-0x280(%rbp), %rdx
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
               	leaq	0x40(%rsp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x9, %eax
               	leaq	-0x720(%rbp), %rsp
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	-0x5a8(%rbp), %rdx
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
               	leaq	0x60(%rsp), %rsi
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
               	movq	%rsi, %rdx
               	leaq	-0x2d8(%rbp), %rdx
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
               	movss	0xc(%rax,%riz), %xmm0
               	movss	0xc(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	movss	0x10(%rax,%riz), %xmm0
               	movss	0x10(%rcx,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x10(%rdx,%riz)
               	leaq	-0x2d8(%rbp), %rdx
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
               	leaq	0x60(%rsp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xa, %eax
               	leaq	-0x720(%rbp), %rsp
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	0x80(%rsp), %rax
               	movl	$0x40200000, %edx       # imm = 0x40200000
               	leaq	-0x5b8(%rbp), %rcx
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
               	leaq	0x140(%rsp), %rsi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rcx
               	leaq	-0x310(%rbp), %rcx
               	leaq	(%rcx), %rsi
               	leaq	(%rax), %rdi
               	movss	(%rdi,%riz), %xmm0
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, (%rsi,%riz)
               	movss	0x4(%rax,%riz), %xmm0
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x4(%rcx,%riz)
               	movss	0x8(%rax,%riz), %xmm0
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x8(%rcx,%riz)
               	leaq	-0x310(%rbp), %rdx
               	movss	0xc(%rax,%riz), %xmm0
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	leaq	0x140(%rsp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xb, %eax
               	leaq	-0x720(%rbp), %rsp
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	0x80(%rsp), %rax
               	movl	$0x3, %ecx
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rcx, %xmm0
               	leaq	-0x5c8(%rbp), %rcx
               	movss	(%rax,%riz), %xmm1
               	mulss	%xmm0, %xmm1
               	movss	%xmm1, (%rcx,%riz)
               	movss	0x4(%rax,%riz), %xmm1
               	mulss	%xmm0, %xmm1
               	movss	%xmm1, 0x4(%rcx,%riz)
               	movss	0x8(%rax,%riz), %xmm1
               	mulss	%xmm0, %xmm1
               	movss	%xmm1, 0x8(%rcx,%riz)
               	movss	0xc(%rax,%riz), %xmm1
               	movapd	%xmm0, %xmm15
               	movapd	%xmm1, %xmm0
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0xc(%rcx,%riz)
               	leaq	0x150(%rsp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x340(%rbp), %rcx
               	leaq	(%rcx), %rsi
               	leaq	(%rax), %rdx
               	movss	(%rdx,%riz), %xmm0
               	movl	$0x40400000, %edx       # imm = 0x40400000
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, (%rsi,%riz)
               	movss	0x4(%rax,%riz), %xmm0
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x4(%rcx,%riz)
               	movss	0x8(%rax,%riz), %xmm0
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x8(%rcx,%riz)
               	movss	0xc(%rax,%riz), %xmm0
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0xc(%rcx,%riz)
               	leaq	0x150(%rsp), %rdx
               	leaq	-0x340(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xc, %eax
               	leaq	-0x720(%rbp), %rsp
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	0xa0(%rsp), %rax
               	movabsq	$0x4010000000000000, %rcx # imm = 0x4010000000000000
               	leaq	-0x5d8(%rbp), %rdx
               	movsd	(%rax,%riz), %xmm0
               	movq	%rcx, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, (%rdx,%riz)
               	movsd	0x8(%rax,%riz), %xmm0
               	movq	%rcx, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, 0x8(%rdx,%riz)
               	leaq	0x160(%rsp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	leaq	-0x370(%rbp), %rdx
               	leaq	(%rdx), %rdi
               	leaq	(%rax), %r8
               	movsd	(%r8,%riz), %xmm0
               	movq	%rcx, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, (%rdi,%riz)
               	movsd	0x8(%rax,%riz), %xmm0
               	movq	%rcx, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, 0x8(%rdx,%riz)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xd, %eax
               	leaq	-0x720(%rbp), %rsp
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	0xa0(%rsp), %rax
               	movl	$0x3, %ecx
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rcx, %xmm0
               	leaq	-0x5e8(%rbp), %rcx
               	movsd	(%rax,%riz), %xmm1
               	addsd	%xmm0, %xmm1
               	movsd	%xmm1, (%rcx,%riz)
               	movsd	0x8(%rax,%riz), %xmm1
               	movapd	%xmm0, %xmm15
               	movapd	%xmm1, %xmm0
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, 0x8(%rcx,%riz)
               	leaq	0x170(%rsp), %rsi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rcx
               	leaq	-0x3a0(%rbp), %rdx
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
               	movslq	%eax, %rcx
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xe, %eax
               	leaq	-0x720(%rbp), %rsp
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	leaq	0x90(%rsp), %rax
               	leaq	-0x5f8(%rbp), %rdx
               	movss	(%rcx,%riz), %xmm0
               	movss	(%rax,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx,%riz)
               	movss	0x4(%rcx,%riz), %xmm0
               	movss	0x4(%rax,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx,%riz)
               	movss	0x8(%rcx,%riz), %xmm0
               	movss	0x8(%rax,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	movss	0xc(%rcx,%riz), %xmm0
               	movss	0xc(%rax,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	leaq	0x180(%rsp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	leaq	0x190(%rsp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x608(%rbp), %rcx
               	movss	(%rdx,%riz), %xmm0
               	movss	(%rax,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, (%rcx,%riz)
               	movss	0x4(%rdx,%riz), %xmm0
               	movss	0x4(%rax,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rcx,%riz)
               	movss	0x8(%rdx,%riz), %xmm0
               	movss	0x8(%rax,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rcx,%riz)
               	movss	0xc(%rdx,%riz), %xmm0
               	movss	0xc(%rax,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rcx,%riz)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xf, %eax
               	leaq	-0x720(%rbp), %rsp
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	leaq	0x90(%rsp), %rax
               	leaq	-0x618(%rbp), %rdx
               	movss	(%rcx,%riz), %xmm0
               	movss	(%rax,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx,%riz)
               	movss	0x4(%rcx,%riz), %xmm0
               	movss	0x4(%rax,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx,%riz)
               	movss	0x8(%rcx,%riz), %xmm0
               	movss	0x8(%rax,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	movss	0xc(%rcx,%riz), %xmm0
               	movss	0xc(%rax,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	leaq	0x1a0(%rsp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	leaq	0x1b0(%rsp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x628(%rbp), %rcx
               	movss	(%rdx,%riz), %xmm0
               	movss	(%rax,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, (%rcx,%riz)
               	movss	0x4(%rdx,%riz), %xmm0
               	movss	0x4(%rax,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rcx,%riz)
               	movss	0x8(%rdx,%riz), %xmm0
               	movss	0x8(%rax,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rcx,%riz)
               	movss	0xc(%rdx,%riz), %xmm0
               	movss	0xc(%rax,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rcx,%riz)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x10, %eax
               	leaq	-0x720(%rbp), %rsp
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	0xa0(%rsp), %rcx
               	leaq	0xb0(%rsp), %rax
               	leaq	-0x638(%rbp), %rdx
               	movsd	(%rcx,%riz), %xmm0
               	movsd	(%rax,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rdx,%riz)
               	movsd	0x8(%rcx,%riz), %xmm0
               	movsd	0x8(%rax,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rdx,%riz)
               	leaq	0x1c0(%rsp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	leaq	0x1d0(%rsp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x648(%rbp), %rcx
               	movsd	(%rdx,%riz), %xmm0
               	movsd	(%rax,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rcx,%riz)
               	movsd	0x8(%rdx,%riz), %xmm0
               	movsd	0x8(%rax,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rcx,%riz)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x11, %eax
               	leaq	-0x720(%rbp), %rsp
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	0x80(%rsp), %rax
               	leaq	0x1e0(%rsp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rcx
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	leaq	-0x658(%rbp), %rsi
               	movss	(%rdx,%riz), %xmm0
               	movq	%rcx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, (%rsi,%riz)
               	movss	0x4(%rdx,%riz), %xmm0
               	movq	%rcx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x4(%rsi,%riz)
               	movss	0x8(%rdx,%riz), %xmm0
               	movq	%rcx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x8(%rsi,%riz)
               	movss	0xc(%rdx,%riz), %xmm0
               	movq	%rcx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0xc(%rsi,%riz)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rsi
               	leaq	-0x668(%rbp), %rdi
               	movss	(%rax,%riz), %xmm0
               	movq	%rcx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, (%rdi,%riz)
               	movss	0x4(%rax,%riz), %xmm0
               	movq	%rcx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x4(%rdi,%riz)
               	movss	0x8(%rax,%riz), %xmm0
               	movq	%rcx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x8(%rdi,%riz)
               	movss	0xc(%rax,%riz), %xmm0
               	movq	%rcx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0xc(%rdi,%riz)
               	leaq	0x1f0(%rsp), %rsi
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdi), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x12, %eax
               	leaq	-0x720(%rbp), %rsp
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	0x80(%rsp), %rax
               	leaq	-0x678(%rbp), %rcx
               	movss	(%rax,%riz), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, (%rcx,%riz)
               	movss	0x4(%rax,%riz), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0x4(%rcx,%riz)
               	movss	0x8(%rax,%riz), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0x8(%rcx,%riz)
               	movss	0xc(%rax,%riz), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0xc(%rcx,%riz)
               	leaq	0x200(%rsp), %rsi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rcx
               	leaq	-0x450(%rbp), %rdx
               	leaq	(%rdx), %rcx
               	leaq	(%rax), %rdi
               	movss	(%rdi,%riz), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, (%rcx,%riz)
               	movss	0x4(%rax,%riz), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0x4(%rdx,%riz)
               	movss	0x8(%rax,%riz), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	movss	0xc(%rax,%riz), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0xc(%rdx,%riz)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x13, %eax
               	leaq	-0x720(%rbp), %rsp
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	0x200(%rsp), %rax
               	movzbq	0xf(%rax), %rax
               	xorq	$0x80, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	leaq	-0x720(%rbp), %rsp
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	0xa0(%rsp), %rax
               	leaq	-0x688(%rbp), %rcx
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	%xmm0, (%rcx,%riz)
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	%xmm0, 0x8(%rcx,%riz)
               	leaq	0x210(%rsp), %rsi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rcx
               	leaq	-0x488(%rbp), %rdx
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
               	movslq	%eax, %rcx
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x15, %eax
               	leaq	-0x720(%rbp), %rsp
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	0x80(%rsp), %rsi
               	leaq	0x90(%rsp), %r9
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
               	movl	$0x40000000, %edx       # imm = 0x40000000
               	leaq	-0x6b8(%rbp), %rax
               	movss	(%rsi,%riz), %xmm4
               	movapd	%xmm0, %xmm14
               	movq	%rdx, %xmm15
               	movapd	%xmm4, %xmm0
               	vfmsub231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) - xmm0
               	movss	%xmm0, (%rax,%riz)
               	movss	0x4(%rsi,%riz), %xmm0
               	movapd	%xmm1, %xmm14
               	movq	%rdx, %xmm15
               	vfmsub231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) - xmm0
               	movss	%xmm0, 0x4(%rax,%riz)
               	movss	0x8(%rsi,%riz), %xmm0
               	movapd	%xmm2, %xmm14
               	movq	%rdx, %xmm15
               	vfmsub231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) - xmm0
               	movss	%xmm0, 0x8(%rax,%riz)
               	movss	0xc(%rsi,%riz), %xmm0
               	movapd	%xmm3, %xmm14
               	movq	%rdx, %xmm15
               	vfmsub231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) - xmm0
               	movss	%xmm0, 0xc(%rax,%riz)
               	leaq	0x220(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x4b8(%rbp), %r8
               	movslq	%eax, %rdi
               	movq	%rdi, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%r8,%rcx), %rbx
               	leaq	(%rsi,%rcx), %r8
               	movss	(%r8,%riz), %xmm0
               	addq	%r9, %rcx
               	movss	(%rcx,%riz), %xmm1
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	addss	%xmm15, %xmm1
               	movapd	%xmm1, %xmm14
               	movq	%rdx, %xmm15
               	vfmsub231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) - xmm0
               	movss	%xmm0, (%rbx,%riz)
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x220(%rsp), %rdx
               	leaq	-0x4b8(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x16, %eax
               	leaq	-0x720(%rbp), %rsp
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	leaq	-0x720(%rbp), %rsp
               	movq	(%rsp), %rbx
               	leave
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
