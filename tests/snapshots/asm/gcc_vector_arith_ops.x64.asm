
gcc_vector_arith_ops.x64:	file format elf64-x86-64

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

<same>:
               	movslq	%edx, %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdi,%rcx), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rsi,%rcx), %r9
               	movzbq	(%r9), %r9
               	cmpq	%r9, %r8
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	%rdx, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	retq
               	xorq	%rax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf60, %rsp            # imm = 0xF60
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	leaq	-0xed0(%rbp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0xec0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xeb0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xea0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xe90(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xe80(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xe70(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xe60(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xe50(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xe40(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xe30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xe20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xe10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xe00(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xdf0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xde0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xee0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0xed8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0xdd0(%rbp), %rax
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
               	leaq	-0xdb0(%rbp), %rax
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
               	leaq	-0xd80(%rbp), %rax
               	movl	$0x1, %edi
               	movb	%dil, (%rax)
               	movl	$0x3, %edi
               	movb	%dil, 0x1(%rax)
               	movl	$0x5, %edi
               	movb	%dil, 0x2(%rax)
               	movl	$0x7, %edi
               	movb	%dil, 0x3(%rax)
               	movl	$0x12c, %r8d            # imm = 0x12C
               	movb	%r8b, 0x4(%rax)
               	movl	$0x100, %edi            # imm = 0x100
               	movb	%dil, 0x5(%rax)
               	movb	%dil, 0x6(%rax)
               	movb	%r8b, 0x7(%rax)
               	movb	%dil, 0x8(%rax)
               	movl	$0x8, %edi
               	movb	%dil, 0x9(%rax)
               	movl	$0xd, %edi
               	movb	%dil, 0xa(%rax)
               	movl	$0x10, %edi
               	movb	%dil, 0xb(%rax)
               	movl	$0x13, %edi
               	movb	%dil, 0xc(%rax)
               	movl	$0x16, %edi
               	movb	%dil, 0xd(%rax)
               	movl	$0x1b, %edi
               	movb	%dil, 0xe(%rax)
               	movl	$0x1e, %ecx
               	movb	%cl, 0xf(%rax)
               	leaq	-0xd70(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xec0(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xd60(%rbp), %rdx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	leaq	(%rdi,%rcx), %r9
               	movzbq	(%r9), %r9
               	addq	%r9, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xd70(%rbp), %rdi
               	leaq	-0xd60(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rdx
               	leaq	-0xec0(%rbp), %rsi
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rdx), %rcx
               	movzbq	(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, (%rax)
               	movzbq	0x1(%rdx), %rcx
               	movzbq	0x1(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0x1(%rax)
               	movzbq	0x2(%rdx), %rcx
               	movzbq	0x2(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0x2(%rax)
               	movzbq	0x3(%rdx), %rcx
               	movzbq	0x3(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0x3(%rax)
               	movzbq	0x4(%rdx), %rcx
               	movzbq	0x4(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0x4(%rax)
               	movzbq	0x5(%rdx), %rcx
               	movzbq	0x5(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0x5(%rax)
               	movzbq	0x6(%rdx), %rcx
               	movzbq	0x6(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0x6(%rax)
               	movzbq	0x7(%rdx), %rcx
               	movzbq	0x7(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0x7(%rax)
               	movzbq	0x8(%rdx), %rcx
               	movzbq	0x8(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0x8(%rax)
               	movzbq	0x9(%rdx), %rcx
               	movzbq	0x9(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0x9(%rax)
               	movzbq	0xa(%rdx), %rcx
               	movzbq	0xa(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0xa(%rax)
               	movzbq	0xb(%rdx), %rcx
               	movzbq	0xb(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0xb(%rax)
               	movzbq	0xc(%rdx), %rcx
               	movzbq	0xc(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0xc(%rax)
               	movzbq	0xd(%rdx), %rcx
               	movzbq	0xd(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0xd(%rax)
               	movzbq	0xe(%rdx), %rcx
               	movzbq	0xe(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0xe(%rax)
               	movzbq	0xf(%rdx), %rcx
               	movzbq	0xf(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0xd50(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xd40(%rbp), %rdi
               	leaq	(%rdi,%rcx), %r8
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r9
               	movzbq	(%r9), %r9
               	subq	%r9, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xd50(%rbp), %rdi
               	leaq	-0xd40(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rdx
               	leaq	-0xec0(%rbp), %rsi
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rdx), %rcx
               	movzbq	(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, (%rax)
               	movzbq	0x1(%rdx), %rcx
               	movzbq	0x1(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0x1(%rax)
               	movzbq	0x2(%rdx), %rcx
               	movzbq	0x2(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0x2(%rax)
               	movzbq	0x3(%rdx), %rcx
               	movzbq	0x3(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0x3(%rax)
               	movzbq	0x4(%rdx), %rcx
               	movzbq	0x4(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0x4(%rax)
               	movzbq	0x5(%rdx), %rcx
               	movzbq	0x5(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0x5(%rax)
               	movzbq	0x6(%rdx), %rcx
               	movzbq	0x6(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0x6(%rax)
               	movzbq	0x7(%rdx), %rcx
               	movzbq	0x7(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0x7(%rax)
               	movzbq	0x8(%rdx), %rcx
               	movzbq	0x8(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0x8(%rax)
               	movzbq	0x9(%rdx), %rcx
               	movzbq	0x9(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0x9(%rax)
               	movzbq	0xa(%rdx), %rcx
               	movzbq	0xa(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0xa(%rax)
               	movzbq	0xb(%rdx), %rcx
               	movzbq	0xb(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0xb(%rax)
               	movzbq	0xc(%rdx), %rcx
               	movzbq	0xc(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0xc(%rax)
               	movzbq	0xd(%rdx), %rcx
               	movzbq	0xd(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0xd(%rax)
               	movzbq	0xe(%rdx), %rcx
               	movzbq	0xe(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0xe(%rax)
               	movzbq	0xf(%rdx), %rcx
               	movzbq	0xf(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0xd30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xd20(%rbp), %rdi
               	leaq	(%rdi,%rcx), %r8
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r9
               	movzbq	(%r9), %r9
               	imulq	%r9, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xd30(%rbp), %rdi
               	leaq	-0xd20(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rdx
               	leaq	-0xec0(%rbp), %rsi
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rdx), %rcx
               	movzbq	(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, (%rax)
               	movzbq	0x1(%rdx), %rcx
               	movzbq	0x1(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x1(%rax)
               	movzbq	0x2(%rdx), %rcx
               	movzbq	0x2(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x2(%rax)
               	movzbq	0x3(%rdx), %rcx
               	movzbq	0x3(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x3(%rax)
               	movzbq	0x4(%rdx), %rcx
               	movzbq	0x4(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x4(%rax)
               	movzbq	0x5(%rdx), %rcx
               	movzbq	0x5(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x5(%rax)
               	movzbq	0x6(%rdx), %rcx
               	movzbq	0x6(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x6(%rax)
               	movzbq	0x7(%rdx), %rcx
               	movzbq	0x7(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x7(%rax)
               	movzbq	0x8(%rdx), %rcx
               	movzbq	0x8(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x8(%rax)
               	movzbq	0x9(%rdx), %rcx
               	movzbq	0x9(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x9(%rax)
               	movzbq	0xa(%rdx), %rcx
               	movzbq	0xa(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xa(%rax)
               	movzbq	0xb(%rdx), %rcx
               	movzbq	0xb(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xb(%rax)
               	movzbq	0xc(%rdx), %rcx
               	movzbq	0xc(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xc(%rax)
               	movzbq	0xd(%rdx), %rcx
               	movzbq	0xd(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xd(%rax)
               	movzbq	0xe(%rdx), %rcx
               	movzbq	0xe(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xe(%rax)
               	movzbq	0xf(%rdx), %rcx
               	movzbq	0xf(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xf(%rax)
               	leaq	-0xd10(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xd00(%rbp), %rdi
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rsi,%rcx), %r9
               	movzbq	(%r9), %r9
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xd10(%rbp), %rdi
               	leaq	-0xd00(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rdx
               	leaq	-0xec0(%rbp), %rsi
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rdx), %rdi
               	movzbq	(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, (%rax)
               	movzbq	0x1(%rdx), %rdi
               	movzbq	0x1(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x1(%rax)
               	movzbq	0x2(%rdx), %rdi
               	movzbq	0x2(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x2(%rax)
               	movzbq	0x3(%rdx), %rdi
               	movzbq	0x3(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x3(%rax)
               	movzbq	0x4(%rdx), %rdi
               	movzbq	0x4(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x4(%rax)
               	movzbq	0x5(%rdx), %rdi
               	movzbq	0x5(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x5(%rax)
               	movzbq	0x6(%rdx), %rdi
               	movzbq	0x6(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x6(%rax)
               	movzbq	0x7(%rdx), %rdi
               	movzbq	0x7(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x7(%rax)
               	movzbq	0x8(%rdx), %rdi
               	movzbq	0x8(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x8(%rax)
               	movzbq	0x9(%rdx), %rdi
               	movzbq	0x9(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x9(%rax)
               	movzbq	0xa(%rdx), %rdi
               	movzbq	0xa(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xa(%rax)
               	movzbq	0xb(%rdx), %rdi
               	movzbq	0xb(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xb(%rax)
               	movzbq	0xc(%rdx), %rdi
               	movzbq	0xc(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xc(%rax)
               	movzbq	0xd(%rdx), %rdi
               	movzbq	0xd(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xd(%rax)
               	movzbq	0xe(%rdx), %rdi
               	movzbq	0xe(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xe(%rax)
               	movzbq	0xf(%rdx), %rdi
               	movzbq	0xf(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xf(%rax)
               	leaq	-0xcf0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xce0(%rbp), %rdi
               	leaq	(%rdi,%rcx), %r9
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %r8
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	andq	$0xff, %rdi
               	movb	%dil, (%r9)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xcf0(%rbp), %rdi
               	leaq	-0xce0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rdx
               	leaq	-0xec0(%rbp), %rsi
               	leaq	-0xd80(%rbp), %rax
               	movq	(%rdx), %rcx
               	movq	(%rsi), %rdi
               	andq	%rdi, %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	0x8(%rsi), %rdi
               	andq	%rdi, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xcd0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xcc0(%rbp), %rdi
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rsi,%rcx), %r9
               	movzbq	(%r9), %r9
               	andq	%r9, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xcd0(%rbp), %rdi
               	leaq	-0xcc0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rdx
               	leaq	-0xec0(%rbp), %rsi
               	leaq	-0xd80(%rbp), %rax
               	movq	(%rdx), %rcx
               	movq	(%rsi), %rdi
               	orq	%rdi, %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	0x8(%rsi), %rdi
               	orq	%rdi, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xcb0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xca0(%rbp), %rdi
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rsi,%rcx), %r9
               	movzbq	(%r9), %r9
               	orq	%r9, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xcb0(%rbp), %rdi
               	leaq	-0xca0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rdx
               	leaq	-0xec0(%rbp), %rsi
               	leaq	-0xd80(%rbp), %rax
               	movq	(%rdx), %rcx
               	movq	(%rsi), %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	0x8(%rsi), %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xc90(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xc80(%rbp), %rdi
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rsi,%rcx), %r9
               	movzbq	(%r9), %r9
               	xorq	%r9, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xc90(%rbp), %rdi
               	leaq	-0xc80(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xeb0(%rbp), %rdx
               	leaq	-0xea0(%rbp), %rsi
               	leaq	-0xd80(%rbp), %rax
               	movsbq	(%rdx), %rcx
               	movsbq	(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, (%rax)
               	movsbq	0x1(%rdx), %rcx
               	movsbq	0x1(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0x1(%rax)
               	movsbq	0x2(%rdx), %rcx
               	movsbq	0x2(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0x2(%rax)
               	movsbq	0x3(%rdx), %rcx
               	movsbq	0x3(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0x3(%rax)
               	movsbq	0x4(%rdx), %rcx
               	movsbq	0x4(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0x4(%rax)
               	movsbq	0x5(%rdx), %rcx
               	movsbq	0x5(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0x5(%rax)
               	movsbq	0x6(%rdx), %rcx
               	movsbq	0x6(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0x6(%rax)
               	movsbq	0x7(%rdx), %rcx
               	movsbq	0x7(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0x7(%rax)
               	movsbq	0x8(%rdx), %rcx
               	movsbq	0x8(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0x8(%rax)
               	movsbq	0x9(%rdx), %rcx
               	movsbq	0x9(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0x9(%rax)
               	movsbq	0xa(%rdx), %rcx
               	movsbq	0xa(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0xa(%rax)
               	movsbq	0xb(%rdx), %rcx
               	movsbq	0xb(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0xb(%rax)
               	movsbq	0xc(%rdx), %rcx
               	movsbq	0xc(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0xc(%rax)
               	movsbq	0xd(%rdx), %rcx
               	movsbq	0xd(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0xd(%rax)
               	movsbq	0xe(%rdx), %rcx
               	movsbq	0xe(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0xe(%rax)
               	movsbq	0xf(%rdx), %rcx
               	movsbq	0xf(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0xc70(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xc60(%rbp), %rdi
               	leaq	(%rdi,%rcx), %r9
               	leaq	(%rdx,%rcx), %rdi
               	movsbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movsbq	(%r8), %r8
               	addq	%r8, %rdi
               	movslq	%edi, %r8
               	movb	%r8b, (%r9)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xc70(%rbp), %rdi
               	leaq	-0xc60(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xeb0(%rbp), %rdx
               	leaq	-0xea0(%rbp), %rsi
               	leaq	-0xd80(%rbp), %rax
               	movsbq	(%rdx), %rcx
               	movsbq	(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, (%rax)
               	movsbq	0x1(%rdx), %rcx
               	movsbq	0x1(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0x1(%rax)
               	movsbq	0x2(%rdx), %rcx
               	movsbq	0x2(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0x2(%rax)
               	movsbq	0x3(%rdx), %rcx
               	movsbq	0x3(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0x3(%rax)
               	movsbq	0x4(%rdx), %rcx
               	movsbq	0x4(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0x4(%rax)
               	movsbq	0x5(%rdx), %rcx
               	movsbq	0x5(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0x5(%rax)
               	movsbq	0x6(%rdx), %rcx
               	movsbq	0x6(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0x6(%rax)
               	movsbq	0x7(%rdx), %rcx
               	movsbq	0x7(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0x7(%rax)
               	movsbq	0x8(%rdx), %rcx
               	movsbq	0x8(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0x8(%rax)
               	movsbq	0x9(%rdx), %rcx
               	movsbq	0x9(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0x9(%rax)
               	movsbq	0xa(%rdx), %rcx
               	movsbq	0xa(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0xa(%rax)
               	movsbq	0xb(%rdx), %rcx
               	movsbq	0xb(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0xb(%rax)
               	movsbq	0xc(%rdx), %rcx
               	movsbq	0xc(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0xc(%rax)
               	movsbq	0xd(%rdx), %rcx
               	movsbq	0xd(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0xd(%rax)
               	movsbq	0xe(%rdx), %rcx
               	movsbq	0xe(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0xe(%rax)
               	movsbq	0xf(%rdx), %rcx
               	movsbq	0xf(%rsi), %rdi
               	subq	%rdi, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0xc50(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xc40(%rbp), %rdi
               	leaq	(%rdi,%rcx), %r9
               	leaq	(%rdx,%rcx), %rdi
               	movsbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movsbq	(%r8), %r8
               	subq	%r8, %rdi
               	movslq	%edi, %r8
               	movb	%r8b, (%r9)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xc50(%rbp), %rdi
               	leaq	-0xc40(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xeb0(%rbp), %rdx
               	leaq	-0xea0(%rbp), %rsi
               	leaq	-0xd80(%rbp), %rax
               	movsbq	(%rdx), %rcx
               	movsbq	(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, (%rax)
               	movsbq	0x1(%rdx), %rcx
               	movsbq	0x1(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0x1(%rax)
               	movsbq	0x2(%rdx), %rcx
               	movsbq	0x2(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0x2(%rax)
               	movsbq	0x3(%rdx), %rcx
               	movsbq	0x3(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0x3(%rax)
               	movsbq	0x4(%rdx), %rcx
               	movsbq	0x4(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0x4(%rax)
               	movsbq	0x5(%rdx), %rcx
               	movsbq	0x5(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0x5(%rax)
               	movsbq	0x6(%rdx), %rcx
               	movsbq	0x6(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0x6(%rax)
               	movsbq	0x7(%rdx), %rcx
               	movsbq	0x7(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0x7(%rax)
               	movsbq	0x8(%rdx), %rcx
               	movsbq	0x8(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0x8(%rax)
               	movsbq	0x9(%rdx), %rcx
               	movsbq	0x9(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0x9(%rax)
               	movsbq	0xa(%rdx), %rcx
               	movsbq	0xa(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0xa(%rax)
               	movsbq	0xb(%rdx), %rcx
               	movsbq	0xb(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0xb(%rax)
               	movsbq	0xc(%rdx), %rcx
               	movsbq	0xc(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0xc(%rax)
               	movsbq	0xd(%rdx), %rcx
               	movsbq	0xd(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0xd(%rax)
               	movsbq	0xe(%rdx), %rcx
               	movsbq	0xe(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0xe(%rax)
               	movsbq	0xf(%rdx), %rcx
               	movsbq	0xf(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0xc30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xc20(%rbp), %rdi
               	leaq	(%rdi,%rcx), %r9
               	leaq	(%rdx,%rcx), %rdi
               	movsbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movsbq	(%r8), %r8
               	imulq	%r8, %rdi
               	movslq	%edi, %r8
               	movb	%r8b, (%r9)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xc30(%rbp), %rdi
               	leaq	-0xc20(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xeb0(%rbp), %rdx
               	leaq	-0xea0(%rbp), %rsi
               	leaq	-0xd80(%rbp), %rax
               	movsbq	(%rdx), %rcx
               	movsbq	(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, (%rax)
               	movsbq	0x1(%rdx), %rcx
               	movsbq	0x1(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x1(%rax)
               	movsbq	0x2(%rdx), %rcx
               	movsbq	0x2(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x2(%rax)
               	movsbq	0x3(%rdx), %rcx
               	movsbq	0x3(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x3(%rax)
               	movsbq	0x4(%rdx), %rcx
               	movsbq	0x4(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x4(%rax)
               	movsbq	0x5(%rdx), %rcx
               	movsbq	0x5(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x5(%rax)
               	movsbq	0x6(%rdx), %rcx
               	movsbq	0x6(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x6(%rax)
               	movsbq	0x7(%rdx), %rcx
               	movsbq	0x7(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x7(%rax)
               	movsbq	0x8(%rdx), %rcx
               	movsbq	0x8(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x8(%rax)
               	movsbq	0x9(%rdx), %rcx
               	movsbq	0x9(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x9(%rax)
               	movsbq	0xa(%rdx), %rcx
               	movsbq	0xa(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xa(%rax)
               	movsbq	0xb(%rdx), %rcx
               	movsbq	0xb(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xb(%rax)
               	movsbq	0xc(%rdx), %rcx
               	movsbq	0xc(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xc(%rax)
               	movsbq	0xd(%rdx), %rcx
               	movsbq	0xd(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xd(%rax)
               	movsbq	0xe(%rdx), %rcx
               	movsbq	0xe(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xe(%rax)
               	movsbq	0xf(%rdx), %rcx
               	movsbq	0xf(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xf(%rax)
               	leaq	-0xc10(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xc00(%rbp), %rdi
               	leaq	(%rdi,%rcx), %r8
               	leaq	(%rdx,%rcx), %rdi
               	movsbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r9
               	movsbq	(%r9), %r9
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xc10(%rbp), %rdi
               	leaq	-0xc00(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xeb0(%rbp), %rdx
               	leaq	-0xea0(%rbp), %rsi
               	leaq	-0xd80(%rbp), %rax
               	movsbq	(%rdx), %rdi
               	movsbq	(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, (%rax)
               	movsbq	0x1(%rdx), %rdi
               	movsbq	0x1(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x1(%rax)
               	movsbq	0x2(%rdx), %rdi
               	movsbq	0x2(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x2(%rax)
               	movsbq	0x3(%rdx), %rdi
               	movsbq	0x3(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x3(%rax)
               	movsbq	0x4(%rdx), %rdi
               	movsbq	0x4(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x4(%rax)
               	movsbq	0x5(%rdx), %rdi
               	movsbq	0x5(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x5(%rax)
               	movsbq	0x6(%rdx), %rdi
               	movsbq	0x6(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x6(%rax)
               	movsbq	0x7(%rdx), %rdi
               	movsbq	0x7(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x7(%rax)
               	movsbq	0x8(%rdx), %rdi
               	movsbq	0x8(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x8(%rax)
               	movsbq	0x9(%rdx), %rdi
               	movsbq	0x9(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x9(%rax)
               	movsbq	0xa(%rdx), %rdi
               	movsbq	0xa(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xa(%rax)
               	movsbq	0xb(%rdx), %rdi
               	movsbq	0xb(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xb(%rax)
               	movsbq	0xc(%rdx), %rdi
               	movsbq	0xc(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xc(%rax)
               	movsbq	0xd(%rdx), %rdi
               	movsbq	0xd(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xd(%rax)
               	movsbq	0xe(%rdx), %rdi
               	movsbq	0xe(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xe(%rax)
               	movsbq	0xf(%rdx), %rdi
               	movsbq	0xf(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xf(%rax)
               	leaq	-0xbf0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xbe0(%rbp), %rdi
               	leaq	(%rdi,%rcx), %r9
               	leaq	(%rdx,%rcx), %rdi
               	movsbq	(%rdi), %r8
               	leaq	(%rsi,%rcx), %rdi
               	movsbq	(%rdi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, (%r9)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xbf0(%rbp), %rdi
               	leaq	-0xbe0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xeb0(%rbp), %rsi
               	leaq	-0xea0(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movq	(%rsi), %rcx
               	movq	(%rdi), %rdx
               	andq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	0x8(%rdi), %rdx
               	andq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xbd0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xbc0(%rbp), %rdx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rsi,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	leaq	(%rdi,%rcx), %r9
               	movsbq	(%r9), %r9
               	andq	%r9, %rdx
               	movb	%dl, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xbd0(%rbp), %rdi
               	leaq	-0xbc0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe90(%rbp), %rsi
               	leaq	-0xe80(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movzwq	(%rsi), %rcx
               	movzwq	(%rdi), %rdx
               	addq	%rdx, %rcx
               	movw	%cx, (%rax)
               	movzwq	0x2(%rsi), %rcx
               	movzwq	0x2(%rdi), %rdx
               	addq	%rdx, %rcx
               	movw	%cx, 0x2(%rax)
               	movzwq	0x4(%rsi), %rcx
               	movzwq	0x4(%rdi), %rdx
               	addq	%rdx, %rcx
               	movw	%cx, 0x4(%rax)
               	movzwq	0x6(%rsi), %rcx
               	movzwq	0x6(%rdi), %rdx
               	addq	%rdx, %rcx
               	movw	%cx, 0x6(%rax)
               	movzwq	0x8(%rsi), %rcx
               	movzwq	0x8(%rdi), %rdx
               	addq	%rdx, %rcx
               	movw	%cx, 0x8(%rax)
               	movzwq	0xa(%rsi), %rcx
               	movzwq	0xa(%rdi), %rdx
               	addq	%rdx, %rcx
               	movw	%cx, 0xa(%rax)
               	movzwq	0xc(%rsi), %rcx
               	movzwq	0xc(%rdi), %rdx
               	addq	%rdx, %rcx
               	movw	%cx, 0xc(%rax)
               	movzwq	0xe(%rsi), %rcx
               	movzwq	0xe(%rdi), %rdx
               	addq	%rdx, %rcx
               	movw	%cx, 0xe(%rax)
               	leaq	-0xbb0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xba0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	%rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movzwq	(%r9), %r9
               	addq	%rdi, %rdx
               	movzwq	(%rdx), %rdx
               	addq	%r9, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0xbb0(%rbp), %rdi
               	leaq	-0xba0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe90(%rbp), %rsi
               	leaq	-0xe80(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movzwq	(%rsi), %rcx
               	movzwq	(%rdi), %rdx
               	subq	%rdx, %rcx
               	movw	%cx, (%rax)
               	movzwq	0x2(%rsi), %rcx
               	movzwq	0x2(%rdi), %rdx
               	subq	%rdx, %rcx
               	movw	%cx, 0x2(%rax)
               	movzwq	0x4(%rsi), %rcx
               	movzwq	0x4(%rdi), %rdx
               	subq	%rdx, %rcx
               	movw	%cx, 0x4(%rax)
               	movzwq	0x6(%rsi), %rcx
               	movzwq	0x6(%rdi), %rdx
               	subq	%rdx, %rcx
               	movw	%cx, 0x6(%rax)
               	movzwq	0x8(%rsi), %rcx
               	movzwq	0x8(%rdi), %rdx
               	subq	%rdx, %rcx
               	movw	%cx, 0x8(%rax)
               	movzwq	0xa(%rsi), %rcx
               	movzwq	0xa(%rdi), %rdx
               	subq	%rdx, %rcx
               	movw	%cx, 0xa(%rax)
               	movzwq	0xc(%rsi), %rcx
               	movzwq	0xc(%rdi), %rdx
               	subq	%rdx, %rcx
               	movw	%cx, 0xc(%rax)
               	movzwq	0xe(%rsi), %rcx
               	movzwq	0xe(%rdi), %rdx
               	subq	%rdx, %rcx
               	movw	%cx, 0xe(%rax)
               	leaq	-0xb90(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xb80(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	%rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movzwq	(%r9), %r9
               	addq	%rdi, %rdx
               	movzwq	(%rdx), %rdx
               	movq	%rdx, %r10
               	movq	%r9, %rdx
               	subq	%r10, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0xb90(%rbp), %rdi
               	leaq	-0xb80(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x10, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe90(%rbp), %rsi
               	leaq	-0xe80(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movzwq	(%rsi), %rcx
               	movzwq	(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movw	%cx, (%rax)
               	movzwq	0x2(%rsi), %rcx
               	movzwq	0x2(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movw	%cx, 0x2(%rax)
               	movzwq	0x4(%rsi), %rcx
               	movzwq	0x4(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movw	%cx, 0x4(%rax)
               	movzwq	0x6(%rsi), %rcx
               	movzwq	0x6(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movw	%cx, 0x6(%rax)
               	movzwq	0x8(%rsi), %rcx
               	movzwq	0x8(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movw	%cx, 0x8(%rax)
               	movzwq	0xa(%rsi), %rcx
               	movzwq	0xa(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movw	%cx, 0xa(%rax)
               	movzwq	0xc(%rsi), %rcx
               	movzwq	0xc(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movw	%cx, 0xc(%rax)
               	movzwq	0xe(%rsi), %rcx
               	movzwq	0xe(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movw	%cx, 0xe(%rax)
               	leaq	-0xb70(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xb60(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	%rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movzwq	(%r9), %r9
               	addq	%rdi, %rdx
               	movzwq	(%rdx), %rdx
               	imulq	%r9, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0xb70(%rbp), %rdi
               	leaq	-0xb60(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x11, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe90(%rbp), %rsi
               	leaq	-0xe80(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movzwq	(%rsi), %rcx
               	movzwq	(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, (%rax)
               	movzwq	0x2(%rsi), %rcx
               	movzwq	0x2(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x2(%rax)
               	movzwq	0x4(%rsi), %rcx
               	movzwq	0x4(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x4(%rax)
               	movzwq	0x6(%rsi), %rcx
               	movzwq	0x6(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x6(%rax)
               	movzwq	0x8(%rsi), %rcx
               	movzwq	0x8(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x8(%rax)
               	movzwq	0xa(%rsi), %rcx
               	movzwq	0xa(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xa(%rax)
               	movzwq	0xc(%rsi), %rcx
               	movzwq	0xc(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xc(%rax)
               	movzwq	0xe(%rsi), %rcx
               	movzwq	0xe(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xe(%rax)
               	leaq	-0xb50(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xb40(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	%rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movzwq	(%r9), %r9
               	addq	%rdi, %rdx
               	movzwq	(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%r9, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0xb50(%rbp), %rdi
               	leaq	-0xb40(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x12, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe90(%rbp), %rsi
               	leaq	-0xe80(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movzwq	(%rsi), %rdx
               	movzwq	(%rdi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, (%rax)
               	movzwq	0x2(%rsi), %rdx
               	movzwq	0x2(%rdi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x2(%rax)
               	movzwq	0x4(%rsi), %rdx
               	movzwq	0x4(%rdi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x4(%rax)
               	movzwq	0x6(%rsi), %rdx
               	movzwq	0x6(%rdi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x6(%rax)
               	movzwq	0x8(%rsi), %rdx
               	movzwq	0x8(%rdi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x8(%rax)
               	movzwq	0xa(%rsi), %rdx
               	movzwq	0xa(%rdi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xa(%rax)
               	movzwq	0xc(%rsi), %rdx
               	movzwq	0xc(%rdi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xc(%rax)
               	movzwq	0xe(%rsi), %rdx
               	movzwq	0xe(%rdi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xe(%rax)
               	leaq	-0xb30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xb20(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	%rdx
               	leaq	(%r8,%rdx), %r9
               	leaq	(%rsi,%rdx), %r8
               	movzwq	(%r8), %r8
               	addq	%rdi, %rdx
               	movzwq	(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%r8, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, (%r9)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0xb30(%rbp), %rdi
               	leaq	-0xb20(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x13, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe70(%rbp), %rsi
               	leaq	-0xe60(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movswq	(%rsi), %rcx
               	movswq	(%rdi), %rdx
               	addq	%rdx, %rcx
               	movw	%cx, (%rax)
               	movswq	0x2(%rsi), %rcx
               	movswq	0x2(%rdi), %rdx
               	addq	%rdx, %rcx
               	movw	%cx, 0x2(%rax)
               	movswq	0x4(%rsi), %rcx
               	movswq	0x4(%rdi), %rdx
               	addq	%rdx, %rcx
               	movw	%cx, 0x4(%rax)
               	movswq	0x6(%rsi), %rcx
               	movswq	0x6(%rdi), %rdx
               	addq	%rdx, %rcx
               	movw	%cx, 0x6(%rax)
               	movswq	0x8(%rsi), %rcx
               	movswq	0x8(%rdi), %rdx
               	addq	%rdx, %rcx
               	movw	%cx, 0x8(%rax)
               	movswq	0xa(%rsi), %rcx
               	movswq	0xa(%rdi), %rdx
               	addq	%rdx, %rcx
               	movw	%cx, 0xa(%rax)
               	movswq	0xc(%rsi), %rcx
               	movswq	0xc(%rdi), %rdx
               	addq	%rdx, %rcx
               	movw	%cx, 0xc(%rax)
               	movswq	0xe(%rsi), %rcx
               	movswq	0xe(%rdi), %rdx
               	addq	%rdx, %rcx
               	movw	%cx, 0xe(%rax)
               	leaq	-0xb10(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xb00(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	%rdx
               	leaq	(%r8,%rdx), %r9
               	leaq	(%rsi,%rdx), %r8
               	movswq	(%r8), %r8
               	addq	%rdi, %rdx
               	movswq	(%rdx), %rdx
               	addq	%r8, %rdx
               	movslq	%edx, %r8
               	movw	%r8w, (%r9)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0xb10(%rbp), %rdi
               	leaq	-0xb00(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x14, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe70(%rbp), %rsi
               	leaq	-0xe60(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movswq	(%rsi), %rcx
               	movswq	(%rdi), %rdx
               	subq	%rdx, %rcx
               	movw	%cx, (%rax)
               	movswq	0x2(%rsi), %rcx
               	movswq	0x2(%rdi), %rdx
               	subq	%rdx, %rcx
               	movw	%cx, 0x2(%rax)
               	movswq	0x4(%rsi), %rcx
               	movswq	0x4(%rdi), %rdx
               	subq	%rdx, %rcx
               	movw	%cx, 0x4(%rax)
               	movswq	0x6(%rsi), %rcx
               	movswq	0x6(%rdi), %rdx
               	subq	%rdx, %rcx
               	movw	%cx, 0x6(%rax)
               	movswq	0x8(%rsi), %rcx
               	movswq	0x8(%rdi), %rdx
               	subq	%rdx, %rcx
               	movw	%cx, 0x8(%rax)
               	movswq	0xa(%rsi), %rcx
               	movswq	0xa(%rdi), %rdx
               	subq	%rdx, %rcx
               	movw	%cx, 0xa(%rax)
               	movswq	0xc(%rsi), %rcx
               	movswq	0xc(%rdi), %rdx
               	subq	%rdx, %rcx
               	movw	%cx, 0xc(%rax)
               	movswq	0xe(%rsi), %rcx
               	movswq	0xe(%rdi), %rdx
               	subq	%rdx, %rcx
               	movw	%cx, 0xe(%rax)
               	leaq	-0xaf0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xae0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	%rdx
               	leaq	(%r8,%rdx), %r9
               	leaq	(%rsi,%rdx), %r8
               	movswq	(%r8), %r8
               	addq	%rdi, %rdx
               	movswq	(%rdx), %rdx
               	movq	%rdx, %r10
               	movq	%r8, %rdx
               	subq	%r10, %rdx
               	movslq	%edx, %r8
               	movw	%r8w, (%r9)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0xaf0(%rbp), %rdi
               	leaq	-0xae0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x15, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe70(%rbp), %rsi
               	leaq	-0xe60(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movswq	(%rsi), %rcx
               	movswq	(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movw	%cx, (%rax)
               	movswq	0x2(%rsi), %rcx
               	movswq	0x2(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movw	%cx, 0x2(%rax)
               	movswq	0x4(%rsi), %rcx
               	movswq	0x4(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movw	%cx, 0x4(%rax)
               	movswq	0x6(%rsi), %rcx
               	movswq	0x6(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movw	%cx, 0x6(%rax)
               	movswq	0x8(%rsi), %rcx
               	movswq	0x8(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movw	%cx, 0x8(%rax)
               	movswq	0xa(%rsi), %rcx
               	movswq	0xa(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movw	%cx, 0xa(%rax)
               	movswq	0xc(%rsi), %rcx
               	movswq	0xc(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movw	%cx, 0xc(%rax)
               	movswq	0xe(%rsi), %rcx
               	movswq	0xe(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movw	%cx, 0xe(%rax)
               	leaq	-0xad0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xac0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	%rdx
               	leaq	(%r8,%rdx), %r9
               	leaq	(%rsi,%rdx), %r8
               	movswq	(%r8), %r8
               	addq	%rdi, %rdx
               	movswq	(%rdx), %rdx
               	imulq	%r8, %rdx
               	movslq	%edx, %r8
               	movw	%r8w, (%r9)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0xad0(%rbp), %rdi
               	leaq	-0xac0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x16, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe70(%rbp), %rsi
               	leaq	-0xe60(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movswq	(%rsi), %rcx
               	movswq	(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, (%rax)
               	movswq	0x2(%rsi), %rcx
               	movswq	0x2(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x2(%rax)
               	movswq	0x4(%rsi), %rcx
               	movswq	0x4(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x4(%rax)
               	movswq	0x6(%rsi), %rcx
               	movswq	0x6(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x6(%rax)
               	movswq	0x8(%rsi), %rcx
               	movswq	0x8(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x8(%rax)
               	movswq	0xa(%rsi), %rcx
               	movswq	0xa(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xa(%rax)
               	movswq	0xc(%rsi), %rcx
               	movswq	0xc(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xc(%rax)
               	movswq	0xe(%rsi), %rcx
               	movswq	0xe(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xe(%rax)
               	leaq	-0xab0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xaa0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	%rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movswq	(%r9), %r9
               	addq	%rdi, %rdx
               	movswq	(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%r9, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movw	%dx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0xab0(%rbp), %rdi
               	leaq	-0xaa0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x17, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe70(%rbp), %rsi
               	leaq	-0xe60(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movswq	(%rsi), %rdx
               	movswq	(%rdi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, (%rax)
               	movswq	0x2(%rsi), %rdx
               	movswq	0x2(%rdi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x2(%rax)
               	movswq	0x4(%rsi), %rdx
               	movswq	0x4(%rdi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x4(%rax)
               	movswq	0x6(%rsi), %rdx
               	movswq	0x6(%rdi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x6(%rax)
               	movswq	0x8(%rsi), %rdx
               	movswq	0x8(%rdi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x8(%rax)
               	movswq	0xa(%rsi), %rdx
               	movswq	0xa(%rdi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xa(%rax)
               	movswq	0xc(%rsi), %rdx
               	movswq	0xc(%rdi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xc(%rax)
               	movswq	0xe(%rsi), %rdx
               	movswq	0xe(%rdi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xe(%rax)
               	leaq	-0xa90(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xa80(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	%rdx
               	leaq	(%r8,%rdx), %r9
               	leaq	(%rsi,%rdx), %r8
               	movswq	(%r8), %r8
               	addq	%rdi, %rdx
               	movswq	(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%r8, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	movw	%dx, (%r9)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0xa90(%rbp), %rdi
               	leaq	-0xa80(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x18, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe50(%rbp), %rsi
               	leaq	-0xe40(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movl	(%rsi), %ecx
               	movl	(%rdi), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	movl	0x4(%rsi), %ecx
               	movl	0x4(%rdi), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	0x8(%rsi), %ecx
               	movl	0x8(%rdi), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, 0x8(%rax)
               	movl	0xc(%rsi), %ecx
               	movl	0xc(%rdi), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0xa70(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xa60(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movl	(%r9), %r9d
               	addq	%rdi, %rdx
               	movl	(%rdx), %edx
               	addq	%r9, %rdx
               	movl	%edx, %edx
               	movl	%edx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0xa70(%rbp), %rdi
               	leaq	-0xa60(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x19, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe50(%rbp), %rsi
               	leaq	-0xe40(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movl	(%rsi), %ecx
               	movl	(%rdi), %edx
               	subq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	movl	0x4(%rsi), %ecx
               	movl	0x4(%rdi), %edx
               	subq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	0x8(%rsi), %ecx
               	movl	0x8(%rdi), %edx
               	subq	%rdx, %rcx
               	movl	%ecx, 0x8(%rax)
               	movl	0xc(%rsi), %ecx
               	movl	0xc(%rdi), %edx
               	subq	%rdx, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0xa50(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xa40(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movl	(%r9), %r9d
               	addq	%rdi, %rdx
               	movl	(%rdx), %edx
               	movq	%rdx, %r10
               	movq	%r9, %rdx
               	subq	%r10, %rdx
               	movl	%edx, %edx
               	movl	%edx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0xa50(%rbp), %rdi
               	leaq	-0xa40(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe50(%rbp), %rsi
               	leaq	-0xe40(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movl	(%rsi), %ecx
               	movl	(%rdi), %edx
               	imulq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	movl	0x4(%rsi), %ecx
               	movl	0x4(%rdi), %edx
               	imulq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	0x8(%rsi), %ecx
               	movl	0x8(%rdi), %edx
               	imulq	%rdx, %rcx
               	movl	%ecx, 0x8(%rax)
               	movl	0xc(%rsi), %ecx
               	movl	0xc(%rdi), %edx
               	imulq	%rdx, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0xa30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xa20(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movl	(%r9), %r9d
               	addq	%rdi, %rdx
               	movl	(%rdx), %edx
               	imulq	%r9, %rdx
               	movl	%edx, %edx
               	movl	%edx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0xa30(%rbp), %rdi
               	leaq	-0xa20(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1b, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe50(%rbp), %rsi
               	leaq	-0xe40(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movl	(%rsi), %ecx
               	movl	(%rdi), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, (%rax)
               	movl	0x4(%rsi), %ecx
               	movl	0x4(%rdi), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0x4(%rax)
               	movl	0x8(%rsi), %ecx
               	movl	0x8(%rdi), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0x8(%rax)
               	movl	0xc(%rsi), %ecx
               	movl	0xc(%rdi), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0xc(%rax)
               	leaq	-0xa10(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xa00(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movl	(%r9), %r9d
               	addq	%rdi, %rdx
               	movl	(%rdx), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%r9, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movl	%edx, %edx
               	movl	%edx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0xa10(%rbp), %rdi
               	leaq	-0xa00(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1c, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe50(%rbp), %rdi
               	leaq	-0xe40(%rbp), %r8
               	leaq	-0xd80(%rbp), %rax
               	movl	(%rdi), %edx
               	movl	(%r8), %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, (%rax)
               	movl	0x4(%rdi), %edx
               	movl	0x4(%r8), %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0x4(%rax)
               	movl	0x8(%rdi), %edx
               	movl	0x8(%r8), %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0x8(%rax)
               	movl	0xc(%rdi), %edx
               	movl	0xc(%r8), %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x9f0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x9e0(%rbp), %rsi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rsi,%rdx), %r9
               	leaq	(%rdi,%rdx), %rsi
               	movl	(%rsi), %esi
               	addq	%r8, %rdx
               	movl	(%rdx), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movl	%edx, %edx
               	movl	%edx, (%r9)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0x9f0(%rbp), %rdi
               	leaq	-0x9e0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1d, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe30(%rbp), %rsi
               	leaq	-0xe20(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movslq	(%rsi), %rcx
               	movslq	(%rdi), %rdx
               	addq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	movslq	0x4(%rsi), %rcx
               	movslq	0x4(%rdi), %rdx
               	addq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	movslq	0x8(%rsi), %rcx
               	movslq	0x8(%rdi), %rdx
               	addq	%rdx, %rcx
               	movl	%ecx, 0x8(%rax)
               	movslq	0xc(%rsi), %rcx
               	movslq	0xc(%rdi), %rdx
               	addq	%rdx, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x9d0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x9c0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movslq	(%r9), %r9
               	addq	%rdi, %rdx
               	movslq	(%rdx), %rdx
               	addq	%r9, %rdx
               	movl	%edx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0x9d0(%rbp), %rdi
               	leaq	-0x9c0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1e, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe30(%rbp), %rsi
               	leaq	-0xe20(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movslq	(%rsi), %rcx
               	movslq	(%rdi), %rdx
               	subq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	movslq	0x4(%rsi), %rcx
               	movslq	0x4(%rdi), %rdx
               	subq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	movslq	0x8(%rsi), %rcx
               	movslq	0x8(%rdi), %rdx
               	subq	%rdx, %rcx
               	movl	%ecx, 0x8(%rax)
               	movslq	0xc(%rsi), %rcx
               	movslq	0xc(%rdi), %rdx
               	subq	%rdx, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x9b0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x9a0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movslq	(%r9), %r9
               	addq	%rdi, %rdx
               	movslq	(%rdx), %rdx
               	movq	%rdx, %r10
               	movq	%r9, %rdx
               	subq	%r10, %rdx
               	movl	%edx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0x9b0(%rbp), %rdi
               	leaq	-0x9a0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1f, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe30(%rbp), %rsi
               	leaq	-0xe20(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movslq	(%rsi), %rcx
               	movslq	(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	movslq	0x4(%rsi), %rcx
               	movslq	0x4(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	movslq	0x8(%rsi), %rcx
               	movslq	0x8(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movl	%ecx, 0x8(%rax)
               	movslq	0xc(%rsi), %rcx
               	movslq	0xc(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x990(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x980(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movslq	(%r9), %r9
               	addq	%rdi, %rdx
               	movslq	(%rdx), %rdx
               	imulq	%r9, %rdx
               	movl	%edx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0x990(%rbp), %rdi
               	leaq	-0x980(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x20, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe30(%rbp), %rsi
               	leaq	-0xe20(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movslq	(%rsi), %rcx
               	movslq	(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, (%rax)
               	movslq	0x4(%rsi), %rcx
               	movslq	0x4(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0x4(%rax)
               	movslq	0x8(%rsi), %rcx
               	movslq	0x8(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0x8(%rax)
               	movslq	0xc(%rsi), %rcx
               	movslq	0xc(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x970(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x960(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movslq	(%r9), %r9
               	addq	%rdi, %rdx
               	movslq	(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%r9, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movl	%edx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0x970(%rbp), %rdi
               	leaq	-0x960(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x21, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe30(%rbp), %rdi
               	leaq	-0xe20(%rbp), %r8
               	leaq	-0xd80(%rbp), %rax
               	movslq	(%rdi), %rdx
               	movslq	(%r8), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, (%rax)
               	movslq	0x4(%rdi), %rdx
               	movslq	0x4(%r8), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0x4(%rax)
               	movslq	0x8(%rdi), %rdx
               	movslq	0x8(%r8), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0x8(%rax)
               	movslq	0xc(%rdi), %rdx
               	movslq	0xc(%r8), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x950(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x940(%rbp), %rsi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rsi,%rdx), %r9
               	leaq	(%rdi,%rdx), %rsi
               	movslq	(%rsi), %rsi
               	addq	%r8, %rdx
               	movslq	(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	movl	%edx, (%r9)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0x950(%rbp), %rdi
               	leaq	-0x940(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x22, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe10(%rbp), %rsi
               	leaq	-0xe00(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movq	(%rsi), %rcx
               	movq	(%rdi), %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	0x8(%rdi), %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x930(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x920(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	addq	%r9, %rdx
               	movq	%rdx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	leaq	-0x930(%rbp), %rdi
               	leaq	-0x920(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x23, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe10(%rbp), %rsi
               	leaq	-0xe00(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movq	(%rsi), %rcx
               	movq	(%rdi), %rdx
               	subq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	0x8(%rdi), %rdx
               	subq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x910(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x900(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	movq	%rdx, %r10
               	movq	%r9, %rdx
               	subq	%r10, %rdx
               	movq	%rdx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	leaq	-0x910(%rbp), %rdi
               	leaq	-0x900(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x24, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe10(%rbp), %rsi
               	leaq	-0xe00(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movq	(%rsi), %rcx
               	movq	(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	0x8(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x8f0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x8e0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	imulq	%r9, %rdx
               	movq	%rdx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	leaq	-0x8f0(%rbp), %rdi
               	leaq	-0x8e0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x25, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe10(%rbp), %rsi
               	leaq	-0xe00(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movq	(%rsi), %rcx
               	movq	(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	0x8(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x8d0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x8c0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%r9, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movq	%rdx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	leaq	-0x8d0(%rbp), %rdi
               	leaq	-0x8c0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x26, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe10(%rbp), %rdi
               	leaq	-0xe00(%rbp), %r8
               	leaq	-0xd80(%rbp), %rax
               	movq	(%rdi), %rdx
               	movq	(%r8), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, (%rax)
               	movq	0x8(%rdi), %rdx
               	movq	0x8(%r8), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x8b0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x8a0(%rbp), %rsi
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rsi,%rdx), %r9
               	leaq	(%rdi,%rdx), %rsi
               	movq	(%rsi), %rsi
               	addq	%r8, %rdx
               	movq	(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movq	%rdx, (%r9)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	leaq	-0x8b0(%rbp), %rdi
               	leaq	-0x8a0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x27, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xdf0(%rbp), %rsi
               	leaq	-0xde0(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movq	(%rsi), %rcx
               	movq	(%rdi), %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	0x8(%rdi), %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x890(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x880(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	addq	%r9, %rdx
               	movq	%rdx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	leaq	-0x890(%rbp), %rdi
               	leaq	-0x880(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x28, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xdf0(%rbp), %rsi
               	leaq	-0xde0(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movq	(%rsi), %rcx
               	movq	(%rdi), %rdx
               	subq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	0x8(%rdi), %rdx
               	subq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x870(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x860(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	movq	%rdx, %r10
               	movq	%r9, %rdx
               	subq	%r10, %rdx
               	movq	%rdx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	leaq	-0x870(%rbp), %rdi
               	leaq	-0x860(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x29, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xdf0(%rbp), %rsi
               	leaq	-0xde0(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movq	(%rsi), %rcx
               	movq	(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	0x8(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x850(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x840(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	imulq	%r9, %rdx
               	movq	%rdx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	leaq	-0x850(%rbp), %rdi
               	leaq	-0x840(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xdf0(%rbp), %rsi
               	leaq	-0xde0(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movq	(%rsi), %rcx
               	movq	(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	0x8(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x830(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x820(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%r9, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movq	%rdx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	leaq	-0x830(%rbp), %rdi
               	leaq	-0x820(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2b, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xdf0(%rbp), %rdi
               	leaq	-0xde0(%rbp), %r8
               	leaq	-0xd80(%rbp), %rax
               	movq	(%rdi), %rdx
               	movq	(%r8), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, (%rax)
               	movq	0x8(%rdi), %rdx
               	movq	0x8(%r8), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x810(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x800(%rbp), %rsi
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rsi,%rdx), %r9
               	leaq	(%rdi,%rdx), %rsi
               	movq	(%rsi), %rsi
               	addq	%r8, %rdx
               	movq	(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	movq	%rdx, (%r9)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	leaq	-0x810(%rbp), %rdi
               	leaq	-0x800(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2c, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xee0(%rbp), %rsi
               	leaq	-0xed8(%rbp), %rdi
               	leaq	-0xd78(%rbp), %rax
               	movzbq	(%rsi), %rcx
               	movzbq	(%rdi), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, (%rax)
               	movzbq	0x1(%rsi), %rcx
               	movzbq	0x1(%rdi), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, 0x1(%rax)
               	movzbq	0x2(%rsi), %rcx
               	movzbq	0x2(%rdi), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, 0x2(%rax)
               	movzbq	0x3(%rsi), %rcx
               	movzbq	0x3(%rdi), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, 0x3(%rax)
               	movzbq	0x4(%rsi), %rcx
               	movzbq	0x4(%rdi), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, 0x4(%rax)
               	movzbq	0x5(%rsi), %rcx
               	movzbq	0x5(%rdi), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, 0x5(%rax)
               	movzbq	0x6(%rsi), %rcx
               	movzbq	0x6(%rdi), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, 0x6(%rax)
               	movzbq	0x7(%rsi), %rcx
               	movzbq	0x7(%rdi), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, 0x7(%rax)
               	leaq	-0x7f0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x7e8(%rbp), %rdx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	leaq	(%rdi,%rcx), %r9
               	movzbq	(%r9), %r9
               	addq	%r9, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0x7f0(%rbp), %rdi
               	leaq	-0x7e8(%rbp), %rsi
               	movl	$0x8, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2d, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xee0(%rbp), %rsi
               	leaq	-0xed8(%rbp), %rdi
               	leaq	-0xd78(%rbp), %rax
               	movzbq	(%rsi), %rcx
               	movzbq	(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, (%rax)
               	movzbq	0x1(%rsi), %rcx
               	movzbq	0x1(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, 0x1(%rax)
               	movzbq	0x2(%rsi), %rcx
               	movzbq	0x2(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, 0x2(%rax)
               	movzbq	0x3(%rsi), %rcx
               	movzbq	0x3(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, 0x3(%rax)
               	movzbq	0x4(%rsi), %rcx
               	movzbq	0x4(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, 0x4(%rax)
               	movzbq	0x5(%rsi), %rcx
               	movzbq	0x5(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, 0x5(%rax)
               	movzbq	0x6(%rsi), %rcx
               	movzbq	0x6(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, 0x6(%rax)
               	movzbq	0x7(%rsi), %rcx
               	movzbq	0x7(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, 0x7(%rax)
               	leaq	-0x7e0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x7d8(%rbp), %rdx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	leaq	(%rdi,%rcx), %r9
               	movzbq	(%r9), %r9
               	imulq	%r9, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0x7e0(%rbp), %rdi
               	leaq	-0x7d8(%rbp), %rsi
               	movl	$0x8, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2e, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xdd0(%rbp), %rsi
               	leaq	-0xdb0(%rbp), %rdi
               	leaq	-0xd90(%rbp), %rax
               	movl	(%rsi), %ecx
               	movl	(%rdi), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	movl	0x4(%rsi), %ecx
               	movl	0x4(%rdi), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	0x8(%rsi), %ecx
               	movl	0x8(%rdi), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, 0x8(%rax)
               	movl	0xc(%rsi), %ecx
               	movl	0xc(%rdi), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, 0xc(%rax)
               	movl	0x10(%rsi), %ecx
               	movl	0x10(%rdi), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, 0x10(%rax)
               	movl	0x14(%rsi), %ecx
               	movl	0x14(%rdi), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, 0x14(%rax)
               	movl	0x18(%rsi), %ecx
               	movl	0x18(%rdi), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, 0x18(%rax)
               	movl	0x1c(%rsi), %ecx
               	movl	0x1c(%rdi), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, 0x1c(%rax)
               	leaq	-0x7d0(%rbp), %rcx
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
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x7b0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movl	(%r9), %r9d
               	addq	%rdi, %rdx
               	movl	(%rdx), %edx
               	addq	%r9, %rdx
               	movl	%edx, %edx
               	movl	%edx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0x7d0(%rbp), %rdi
               	leaq	-0x7b0(%rbp), %rsi
               	movl	$0x20, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2f, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xdd0(%rbp), %rsi
               	leaq	-0xdb0(%rbp), %rdi
               	leaq	-0xd90(%rbp), %rax
               	movl	(%rsi), %ecx
               	movl	(%rdi), %edx
               	subq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	movl	0x4(%rsi), %ecx
               	movl	0x4(%rdi), %edx
               	subq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	0x8(%rsi), %ecx
               	movl	0x8(%rdi), %edx
               	subq	%rdx, %rcx
               	movl	%ecx, 0x8(%rax)
               	movl	0xc(%rsi), %ecx
               	movl	0xc(%rdi), %edx
               	subq	%rdx, %rcx
               	movl	%ecx, 0xc(%rax)
               	movl	0x10(%rsi), %ecx
               	movl	0x10(%rdi), %edx
               	subq	%rdx, %rcx
               	movl	%ecx, 0x10(%rax)
               	movl	0x14(%rsi), %ecx
               	movl	0x14(%rdi), %edx
               	subq	%rdx, %rcx
               	movl	%ecx, 0x14(%rax)
               	movl	0x18(%rsi), %ecx
               	movl	0x18(%rdi), %edx
               	subq	%rdx, %rcx
               	movl	%ecx, 0x18(%rax)
               	movl	0x1c(%rsi), %ecx
               	movl	0x1c(%rdi), %edx
               	subq	%rdx, %rcx
               	movl	%ecx, 0x1c(%rax)
               	leaq	-0x790(%rbp), %rcx
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
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x770(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movl	(%r9), %r9d
               	addq	%rdi, %rdx
               	movl	(%rdx), %edx
               	movq	%rdx, %r10
               	movq	%r9, %rdx
               	subq	%r10, %rdx
               	movl	%edx, %edx
               	movl	%edx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0x790(%rbp), %rdi
               	leaq	-0x770(%rbp), %rsi
               	movl	$0x20, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x30, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xdc0(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	leaq	-0xda0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xed0(%rbp), %rdx
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rdx), %rsi
               	shlq	$0x0, %rsi
               	movb	%sil, (%rax)
               	movzbq	0x1(%rdx), %rsi
               	shlq	%rsi
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rdx), %rsi
               	shlq	$0x2, %rsi
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rdx), %rsi
               	shlq	$0x3, %rsi
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rdx), %rsi
               	shlq	$0x4, %rsi
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rdx), %rsi
               	shlq	$0x5, %rsi
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rdx), %rsi
               	shlq	$0x6, %rsi
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rdx), %rsi
               	shlq	$0x7, %rsi
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rdx), %rsi
               	shlq	$0x0, %rsi
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rdx), %rsi
               	shlq	%rsi
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rdx), %rsi
               	shlq	$0x2, %rsi
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rdx), %rsi
               	shlq	$0x3, %rsi
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rdx), %rsi
               	shlq	$0x4, %rsi
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rdx), %rsi
               	shlq	$0x5, %rsi
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rdx), %rsi
               	shlq	$0x6, %rsi
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rdx), %rsi
               	movq	%rsi, %rcx
               	shlq	$0x7, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0x750(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x740(%rbp), %rsi
               	leaq	(%rsi,%rcx), %r8
               	leaq	(%rdx,%rcx), %rsi
               	movzbq	(%rsi), %rsi
               	leaq	(%rdi,%rcx), %r9
               	movzbq	(%r9), %r9
               	pushq	%rcx
               	movq	%r9, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	andq	$0xff, %rsi
               	movb	%sil, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0x750(%rbp), %rdi
               	leaq	-0x740(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x31, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rdx
               	leaq	-0xdc0(%rbp), %rsi
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rdx), %rcx
               	movzbq	(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movb	%cl, (%rax)
               	movzbq	0x1(%rdx), %rcx
               	movzbq	0x1(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movb	%cl, 0x1(%rax)
               	movzbq	0x2(%rdx), %rcx
               	movzbq	0x2(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movb	%cl, 0x2(%rax)
               	movzbq	0x3(%rdx), %rcx
               	movzbq	0x3(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movb	%cl, 0x3(%rax)
               	movzbq	0x4(%rdx), %rcx
               	movzbq	0x4(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movb	%cl, 0x4(%rax)
               	movzbq	0x5(%rdx), %rcx
               	movzbq	0x5(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movb	%cl, 0x5(%rax)
               	movzbq	0x6(%rdx), %rcx
               	movzbq	0x6(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movb	%cl, 0x6(%rax)
               	movzbq	0x7(%rdx), %rcx
               	movzbq	0x7(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movb	%cl, 0x7(%rax)
               	movzbq	0x8(%rdx), %rcx
               	movzbq	0x8(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movb	%cl, 0x8(%rax)
               	movzbq	0x9(%rdx), %rcx
               	movzbq	0x9(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movb	%cl, 0x9(%rax)
               	movzbq	0xa(%rdx), %rcx
               	movzbq	0xa(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movb	%cl, 0xa(%rax)
               	movzbq	0xb(%rdx), %rcx
               	movzbq	0xb(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movb	%cl, 0xb(%rax)
               	movzbq	0xc(%rdx), %rcx
               	movzbq	0xc(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movb	%cl, 0xc(%rax)
               	movzbq	0xd(%rdx), %rcx
               	movzbq	0xd(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movb	%cl, 0xd(%rax)
               	movzbq	0xe(%rdx), %rcx
               	movzbq	0xe(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movb	%cl, 0xe(%rax)
               	movzbq	0xf(%rdx), %rcx
               	movzbq	0xf(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0x730(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x720(%rbp), %rdi
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rsi,%rcx), %r9
               	movzbq	(%r9), %r9
               	pushq	%rcx
               	movq	%r9, %rcx
               	shrq	%cl, %r8
               	popq	%rcx
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0x730(%rbp), %rdi
               	leaq	-0x720(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x32, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe70(%rbp), %rsi
               	leaq	-0xda0(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movswq	(%rsi), %rcx
               	movswq	(%rdi), %rdx
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	sarq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, (%rax)
               	movswq	0x2(%rsi), %rcx
               	movswq	0x2(%rdi), %rdx
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	sarq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0x2(%rax)
               	movswq	0x4(%rsi), %rcx
               	movswq	0x4(%rdi), %rdx
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	sarq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0x4(%rax)
               	movswq	0x6(%rsi), %rcx
               	movswq	0x6(%rdi), %rdx
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	sarq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0x6(%rax)
               	movswq	0x8(%rsi), %rcx
               	movswq	0x8(%rdi), %rdx
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	sarq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0x8(%rax)
               	movswq	0xa(%rsi), %rcx
               	movswq	0xa(%rdi), %rdx
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	sarq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0xa(%rax)
               	movswq	0xc(%rsi), %rcx
               	movswq	0xc(%rdi), %rdx
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	sarq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0xc(%rax)
               	movswq	0xe(%rsi), %rcx
               	movswq	0xe(%rdi), %rdx
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	sarq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0xe(%rax)
               	leaq	-0x710(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x700(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	%rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movswq	(%r9), %r9
               	addq	%rdi, %rdx
               	movswq	(%rdx), %rdx
               	movq	%rdx, %r10
               	movq	%r9, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	sarq	%cl, %rdx
               	popq	%rcx
               	movw	%dx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0x710(%rbp), %rdi
               	leaq	-0x700(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x33, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe70(%rbp), %rsi
               	leaq	-0xda0(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movswq	(%rsi), %rcx
               	movswq	(%rdi), %rdx
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, (%rax)
               	movswq	0x2(%rsi), %rcx
               	movswq	0x2(%rdi), %rdx
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0x2(%rax)
               	movswq	0x4(%rsi), %rcx
               	movswq	0x4(%rdi), %rdx
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0x4(%rax)
               	movswq	0x6(%rsi), %rcx
               	movswq	0x6(%rdi), %rdx
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0x6(%rax)
               	movswq	0x8(%rsi), %rcx
               	movswq	0x8(%rdi), %rdx
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0x8(%rax)
               	movswq	0xa(%rsi), %rcx
               	movswq	0xa(%rdi), %rdx
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0xa(%rax)
               	movswq	0xc(%rsi), %rcx
               	movswq	0xc(%rdi), %rdx
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0xc(%rax)
               	movswq	0xe(%rsi), %rcx
               	movswq	0xe(%rdi), %rdx
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0xe(%rax)
               	leaq	-0x6f0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x6e0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	%rdx
               	leaq	(%r8,%rdx), %r9
               	leaq	(%rsi,%rdx), %r8
               	movswq	(%r8), %r8
               	addq	%rdi, %rdx
               	movswq	(%rdx), %rdx
               	movq	%rdx, %r10
               	movq	%r8, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movslq	%edx, %r8
               	movw	%r8w, (%r9)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0x6f0(%rbp), %rdi
               	leaq	-0x6e0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x34, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe30(%rbp), %rsi
               	leaq	-0xd80(%rbp), %rax
               	movslq	(%rsi), %rcx
               	sarq	$0x3, %rcx
               	movl	%ecx, (%rax)
               	movslq	0x4(%rsi), %rcx
               	sarq	$0x3, %rcx
               	movl	%ecx, 0x4(%rax)
               	movslq	0x8(%rsi), %rcx
               	sarq	$0x3, %rcx
               	movl	%ecx, 0x8(%rax)
               	movslq	0xc(%rsi), %rcx
               	sarq	$0x3, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x6d0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x6c0(%rbp), %rdi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rdi
               	addq	%rsi, %rdx
               	movslq	(%rdx), %rdx
               	sarq	$0x3, %rdx
               	movl	%edx, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0x6d0(%rbp), %rdi
               	leaq	-0x6c0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x35, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe50(%rbp), %rsi
               	leaq	-0xd80(%rbp), %rax
               	movl	(%rsi), %ecx
               	shrq	$0x3, %rcx
               	movl	%ecx, (%rax)
               	movl	0x4(%rsi), %ecx
               	shrq	$0x3, %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	0x8(%rsi), %ecx
               	shrq	$0x3, %rcx
               	movl	%ecx, 0x8(%rax)
               	movl	0xc(%rsi), %ecx
               	shrq	$0x3, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x6b0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x6a0(%rbp), %rdi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rdi
               	addq	%rsi, %rdx
               	movl	(%rdx), %edx
               	shrq	$0x3, %rdx
               	movl	%edx, %edx
               	movl	%edx, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0x6b0(%rbp), %rdi
               	leaq	-0x6a0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x36, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xeb0(%rbp), %rcx
               	leaq	-0xd80(%rbp), %rax
               	movsbq	(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, (%rax)
               	movsbq	0x1(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x1(%rax)
               	movsbq	0x2(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x2(%rax)
               	movsbq	0x3(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x3(%rax)
               	movsbq	0x4(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x4(%rax)
               	movsbq	0x5(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x5(%rax)
               	movsbq	0x6(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x6(%rax)
               	movsbq	0x7(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x7(%rax)
               	movsbq	0x8(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x8(%rax)
               	movsbq	0x9(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x9(%rax)
               	movsbq	0xa(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0xa(%rax)
               	movsbq	0xb(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0xb(%rax)
               	movsbq	0xc(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0xc(%rax)
               	movsbq	0xd(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0xd(%rax)
               	movsbq	0xe(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0xe(%rax)
               	movsbq	0xf(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	-0x690(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x680(%rbp), %rsi
               	leaq	(%rsi,%rdx), %r8
               	leaq	(%rcx,%rdx), %rsi
               	movsbq	(%rsi), %rsi
               	shlq	$0x2, %rsi
               	movslq	%esi, %rdi
               	movb	%dil, (%r8)
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x10, %rdx
               	jl	<addr>
               	leaq	-0x690(%rbp), %rdi
               	leaq	-0x680(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x37, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rcx
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x3(%rax)
               	movzbq	0x4(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x5(%rax)
               	movzbq	0x6(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x6(%rax)
               	movzbq	0x7(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x7(%rax)
               	movzbq	0x8(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xb(%rax)
               	movzbq	0xc(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xc(%rax)
               	movzbq	0xd(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xd(%rax)
               	movzbq	0xe(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xe(%rax)
               	movzbq	0xf(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	-0x670(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x660(%rbp), %rsi
               	leaq	(%rsi,%rdx), %rdi
               	leaq	(%rcx,%rdx), %rsi
               	movzbq	(%rsi), %rsi
               	subq	$0x40, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdi)
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x10, %rdx
               	jl	<addr>
               	leaq	-0x670(%rbp), %rdi
               	leaq	-0x660(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x38, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rcx
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x3(%rax)
               	movzbq	0x4(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x5(%rax)
               	movzbq	0x6(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x6(%rax)
               	movzbq	0x7(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x7(%rax)
               	movzbq	0x8(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0xb(%rax)
               	movzbq	0xc(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0xc(%rax)
               	movzbq	0xd(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0xd(%rax)
               	movzbq	0xe(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0xe(%rax)
               	movzbq	0xf(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	-0x650(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x640(%rbp), %rsi
               	leaq	(%rsi,%rdx), %rdi
               	leaq	(%rcx,%rdx), %rsi
               	movzbq	(%rsi), %rsi
               	addq	$0x64, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdi)
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x10, %rdx
               	jl	<addr>
               	leaq	-0x650(%rbp), %rdi
               	leaq	-0x640(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x39, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rcx
               	movl	$0x7, %edx
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	-0x630(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x620(%rbp), %rsi
               	leaq	(%rsi,%rdx), %rdi
               	leaq	(%rcx,%rdx), %rsi
               	movzbq	(%rsi), %rsi
               	imulq	$0x7, %rsi, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdi)
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x10, %rdx
               	jl	<addr>
               	leaq	-0x630(%rbp), %rdi
               	leaq	-0x620(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rcx
               	movl	$0x7, %edx
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0xf(%rax)
               	leaq	-0x610(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	movl	$0x92492493, %edi       # imm = 0x92492493
               	jmp	<addr>
               	leaq	-0x600(%rbp), %rsi
               	leaq	(%rsi,%rdx), %r8
               	leaq	(%rcx,%rdx), %rsi
               	movzbq	(%rsi), %rsi
               	imulq	%rdi, %rsi
               	sarq	$0x22, %rsi
               	movq	%rsi, %r9
               	shrq	$0x3f, %r9
               	addq	%r9, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%r8)
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x10, %rdx
               	jl	<addr>
               	leaq	-0x610(%rbp), %rdi
               	leaq	-0x600(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3b, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rcx
               	movl	$0x7, %edx
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0xf(%rax)
               	leaq	-0x5f0(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	movl	$0x92492493, %r8d       # imm = 0x92492493
               	jmp	<addr>
               	leaq	-0x5e0(%rbp), %rsi
               	leaq	(%rsi,%rdx), %r9
               	leaq	(%rcx,%rdx), %rsi
               	movzbq	(%rsi), %rsi
               	movq	%rsi, %rdi
               	imulq	%r8, %rdi
               	sarq	$0x22, %rdi
               	movq	%rdi, %rbx
               	shrq	$0x3f, %rbx
               	addq	%rbx, %rdi
               	imulq	$0x7, %rdi, %rdi
               	subq	%rdi, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%r9)
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x10, %rdx
               	jl	<addr>
               	leaq	-0x5f0(%rbp), %rdi
               	leaq	-0x5e0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3c, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rcx
               	movl	$0xf, %edx
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rsi
               	andq	%rsi, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	-0x5d0(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x5c0(%rbp), %rsi
               	addq	%rdx, %rsi
               	leaq	(%rcx,%rdx), %rdi
               	movzbq	(%rdi), %rdi
               	andq	$0xf, %rdi
               	movb	%dil, (%rsi)
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x10, %rdx
               	jl	<addr>
               	leaq	-0x5d0(%rbp), %rdi
               	leaq	-0x5c0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3d, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rcx
               	movl	$0xf0, %edx
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rsi
               	orq	%rsi, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	-0x5b0(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x5a0(%rbp), %rsi
               	addq	%rdx, %rsi
               	leaq	(%rcx,%rdx), %rdi
               	movzbq	(%rdi), %rdi
               	orq	$0xf0, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi)
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x10, %rdx
               	jl	<addr>
               	leaq	-0x5b0(%rbp), %rdi
               	leaq	-0x5a0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3e, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rcx
               	movl	$0x55, %edx
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rsi
               	xorq	%rsi, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	-0x590(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x580(%rbp), %rsi
               	addq	%rdx, %rsi
               	leaq	(%rcx,%rdx), %rdi
               	movzbq	(%rdi), %rdi
               	xorq	$0x55, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi)
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x10, %rdx
               	jl	<addr>
               	leaq	-0x590(%rbp), %rdi
               	leaq	-0x580(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3f, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xeb0(%rbp), %rcx
               	leaq	-0xd80(%rbp), %rax
               	movsbq	(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, (%rax)
               	movsbq	0x1(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x1(%rax)
               	movsbq	0x2(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x2(%rax)
               	movsbq	0x3(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x3(%rax)
               	movsbq	0x4(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x4(%rax)
               	movsbq	0x5(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x5(%rax)
               	movsbq	0x6(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x6(%rax)
               	movsbq	0x7(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x7(%rax)
               	movsbq	0x8(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x8(%rax)
               	movsbq	0x9(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x9(%rax)
               	movsbq	0xa(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0xa(%rax)
               	movsbq	0xb(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0xb(%rax)
               	movsbq	0xc(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0xc(%rax)
               	movsbq	0xd(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0xd(%rax)
               	movsbq	0xe(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0xe(%rax)
               	movsbq	0xf(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	-0x570(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x560(%rbp), %rsi
               	leaq	(%rsi,%rdx), %r8
               	leaq	(%rcx,%rdx), %rsi
               	movsbq	(%rsi), %rsi
               	subq	$0x64, %rsi
               	movslq	%esi, %rdi
               	movb	%dil, (%r8)
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x10, %rdx
               	jl	<addr>
               	leaq	-0x570(%rbp), %rdi
               	leaq	-0x560(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x40, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xeb0(%rbp), %rcx
               	movl	$0x3, %edx
               	leaq	-0xd80(%rbp), %rax
               	movsbq	(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, (%rax)
               	movsbq	0x1(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x1(%rax)
               	movsbq	0x2(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x2(%rax)
               	movsbq	0x3(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x3(%rax)
               	movsbq	0x4(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x4(%rax)
               	movsbq	0x5(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x5(%rax)
               	movsbq	0x6(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x6(%rax)
               	movsbq	0x7(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x7(%rax)
               	movsbq	0x8(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x8(%rax)
               	movsbq	0x9(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x9(%rax)
               	movsbq	0xa(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xa(%rax)
               	movsbq	0xb(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xb(%rax)
               	movsbq	0xc(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xc(%rax)
               	movsbq	0xd(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xd(%rax)
               	movsbq	0xe(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xe(%rax)
               	movsbq	0xf(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0xf(%rax)
               	leaq	-0x550(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x540(%rbp), %rsi
               	leaq	(%rsi,%rdx), %rdi
               	leaq	(%rcx,%rdx), %rsi
               	movsbq	(%rsi), %rsi
               	imulq	$0x55555556, %rsi, %rsi # imm = 0x55555556
               	sarq	$0x20, %rsi
               	movq	%rsi, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rsi
               	movb	%sil, (%rdi)
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x10, %rdx
               	jl	<addr>
               	leaq	-0x550(%rbp), %rdi
               	leaq	-0x540(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x41, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xeb0(%rbp), %rcx
               	movl	$0x3, %edx
               	leaq	-0xd80(%rbp), %rax
               	movsbq	(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, (%rax)
               	movsbq	0x1(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x1(%rax)
               	movsbq	0x2(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x2(%rax)
               	movsbq	0x3(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x3(%rax)
               	movsbq	0x4(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x4(%rax)
               	movsbq	0x5(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x5(%rax)
               	movsbq	0x6(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x6(%rax)
               	movsbq	0x7(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x7(%rax)
               	movsbq	0x8(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x8(%rax)
               	movsbq	0x9(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x9(%rax)
               	movsbq	0xa(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xa(%rax)
               	movsbq	0xb(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xb(%rax)
               	movsbq	0xc(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xc(%rax)
               	movsbq	0xd(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xd(%rax)
               	movsbq	0xe(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xe(%rax)
               	movsbq	0xf(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	movb	%dl, 0xf(%rax)
               	leaq	-0x530(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x520(%rbp), %rsi
               	leaq	(%rsi,%rdx), %r8
               	leaq	(%rcx,%rdx), %rsi
               	movsbq	(%rsi), %rsi
               	imulq	$0x55555556, %rsi, %rdi # imm = 0x55555556
               	sarq	$0x20, %rdi
               	movq	%rdi, %r9
               	shrq	$0x3f, %r9
               	addq	%r9, %rdi
               	leaq	(%rdi,%rdi,2), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, (%r8)
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x10, %rdx
               	jl	<addr>
               	leaq	-0x530(%rbp), %rdi
               	leaq	-0x520(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x42, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe90(%rbp), %rsi
               	movl	$0x3e8, %ecx            # imm = 0x3E8
               	leaq	-0xd80(%rbp), %rax
               	movzwq	(%rsi), %rdx
               	imulq	%rcx, %rdx
               	movw	%dx, (%rax)
               	movzwq	0x2(%rsi), %rdx
               	imulq	%rcx, %rdx
               	movw	%dx, 0x2(%rax)
               	movzwq	0x4(%rsi), %rdx
               	imulq	%rcx, %rdx
               	movw	%dx, 0x4(%rax)
               	movzwq	0x6(%rsi), %rdx
               	imulq	%rcx, %rdx
               	movw	%dx, 0x6(%rax)
               	movzwq	0x8(%rsi), %rdx
               	imulq	%rcx, %rdx
               	movw	%dx, 0x8(%rax)
               	movzwq	0xa(%rsi), %rdx
               	imulq	%rcx, %rdx
               	movw	%dx, 0xa(%rax)
               	movzwq	0xc(%rsi), %rdx
               	imulq	%rcx, %rdx
               	movw	%dx, 0xc(%rax)
               	movzwq	0xe(%rsi), %rdx
               	imulq	%rdx, %rcx
               	movw	%cx, 0xe(%rax)
               	leaq	-0x510(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x500(%rbp), %rdi
               	movq	%rcx, %rdx
               	shlq	%rdx
               	addq	%rdx, %rdi
               	addq	%rsi, %rdx
               	movzwq	(%rdx), %rdx
               	imulq	$0x3e8, %rdx, %rdx      # imm = 0x3E8
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0x510(%rbp), %rdi
               	leaq	-0x500(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x43, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xdf0(%rbp), %rsi
               	movl	$0x7, %ecx
               	leaq	-0xd80(%rbp), %rax
               	movq	(%rsi), %rdx
               	imulq	%rcx, %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rsi), %rdx
               	imulq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x4f0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x4e0(%rbp), %rdi
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rdx
               	imulq	$0x7, %rdx, %rdx
               	movq	%rdx, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	leaq	-0x4f0(%rbp), %rdi
               	leaq	-0x4e0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x44, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	movl	$0x40, %edi
               	leaq	-0xed0(%rbp), %rcx
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x3(%rax)
               	movzbq	0x4(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x5(%rax)
               	movzbq	0x6(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x6(%rax)
               	movzbq	0x7(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x7(%rax)
               	movzbq	0x8(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xb(%rax)
               	movzbq	0xc(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xc(%rax)
               	movzbq	0xd(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xd(%rax)
               	movzbq	0xe(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xe(%rax)
               	movzbq	0xf(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	-0x4d0(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x4c0(%rbp), %rsi
               	leaq	(%rsi,%rdx), %r8
               	leaq	(%rcx,%rdx), %rsi
               	movzbq	(%rsi), %rsi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%r8)
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x10, %rdx
               	jl	<addr>
               	leaq	-0x4d0(%rbp), %rdi
               	leaq	-0x4c0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x45, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	movl	$0x64, %edi
               	leaq	-0xeb0(%rbp), %rcx
               	leaq	-0xd80(%rbp), %rax
               	movsbq	(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, (%rax)
               	movsbq	0x1(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x1(%rax)
               	movsbq	0x2(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x2(%rax)
               	movsbq	0x3(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x3(%rax)
               	movsbq	0x4(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x4(%rax)
               	movsbq	0x5(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x5(%rax)
               	movsbq	0x6(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x6(%rax)
               	movsbq	0x7(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x7(%rax)
               	movsbq	0x8(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x8(%rax)
               	movsbq	0x9(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x9(%rax)
               	movsbq	0xa(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xa(%rax)
               	movsbq	0xb(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xb(%rax)
               	movsbq	0xc(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xc(%rax)
               	movsbq	0xd(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xd(%rax)
               	movsbq	0xe(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xe(%rax)
               	movsbq	0xf(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	-0x4b0(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x4a0(%rbp), %rsi
               	leaq	(%rsi,%rdx), %r9
               	leaq	(%rcx,%rdx), %rsi
               	movsbq	(%rsi), %rsi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movslq	%esi, %r8
               	movb	%r8b, (%r9)
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x10, %rdx
               	jl	<addr>
               	leaq	-0x4b0(%rbp), %rdi
               	leaq	-0x4a0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x46, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	movl	$0xfa, %esi
               	leaq	-0xec0(%rbp), %rcx
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x3(%rax)
               	movzbq	0x4(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x5(%rax)
               	movzbq	0x6(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x6(%rax)
               	movzbq	0x7(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x7(%rax)
               	movzbq	0x8(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0xb(%rax)
               	movzbq	0xc(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0xc(%rax)
               	movzbq	0xd(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0xd(%rax)
               	movzbq	0xe(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0xe(%rax)
               	movzbq	0xf(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0xf(%rax)
               	leaq	-0x490(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x480(%rbp), %rdi
               	addq	%rdx, %rdi
               	leaq	(%rcx,%rdx), %r8
               	movzbq	(%r8), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi)
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x10, %rdx
               	jl	<addr>
               	leaq	-0x490(%rbp), %rdi
               	leaq	-0x480(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x47, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	movl	$0xfa, %eax
               	leaq	-0xec0(%rbp), %rdx
               	leaq	-0xd80(%rbp), %rcx
               	movzbq	(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, (%rcx)
               	movzbq	0x1(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x1(%rcx)
               	movzbq	0x2(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x2(%rcx)
               	movzbq	0x3(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x3(%rcx)
               	movzbq	0x4(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x4(%rcx)
               	movzbq	0x5(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x5(%rcx)
               	movzbq	0x6(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x6(%rcx)
               	movzbq	0x7(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x7(%rcx)
               	movzbq	0x8(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xb(%rcx)
               	movzbq	0xc(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xc(%rcx)
               	movzbq	0xd(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xd(%rcx)
               	movzbq	0xe(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xe(%rcx)
               	movzbq	0xf(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xf(%rcx)
               	leaq	-0x470(%rbp), %rsi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rcx
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x460(%rbp), %rdi
               	leaq	(%rdi,%rsi), %r8
               	leaq	(%rdx,%rsi), %rdi
               	movzbq	(%rdi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	andq	$0xff, %rdi
               	movb	%dil, (%r8)
               	leaq	0x1(%rsi), %rcx
               	movslq	%ecx, %rsi
               	cmpq	$0x10, %rsi
               	jl	<addr>
               	leaq	-0x470(%rbp), %rdi
               	leaq	-0x460(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x61, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	movl	$0xf, %edx
               	leaq	-0xec0(%rbp), %rcx
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rsi
               	andq	%rsi, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	-0x450(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x440(%rbp), %rsi
               	addq	%rdx, %rsi
               	leaq	(%rcx,%rdx), %rdi
               	movzbq	(%rdi), %rdi
               	andq	$0xf, %rdi
               	movb	%dil, (%rsi)
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x10, %rdx
               	jl	<addr>
               	leaq	-0x450(%rbp), %rdi
               	leaq	-0x440(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x62, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	leaq	-0xdc0(%rbp), %rcx
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x3(%rax)
               	movzbq	0x4(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x5(%rax)
               	movzbq	0x6(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x6(%rax)
               	movzbq	0x7(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x7(%rax)
               	movzbq	0x8(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xb(%rax)
               	movzbq	0xc(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xc(%rax)
               	movzbq	0xd(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xd(%rax)
               	movzbq	0xe(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xe(%rax)
               	movzbq	0xf(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xf(%rax)
               	leaq	-0x430(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x420(%rbp), %rsi
               	leaq	(%rsi,%rdx), %r8
               	leaq	(%rcx,%rdx), %rsi
               	movzbq	(%rsi), %rsi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	andq	$0xff, %rsi
               	movb	%sil, (%r8)
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x10, %rdx
               	jl	<addr>
               	leaq	-0x430(%rbp), %rdi
               	leaq	-0x420(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x63, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	movl	$0x80, %esi
               	leaq	-0xdc0(%rbp), %rcx
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x3(%rax)
               	movzbq	0x4(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x5(%rax)
               	movzbq	0x6(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x6(%rax)
               	movzbq	0x7(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x7(%rax)
               	movzbq	0x8(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xb(%rax)
               	movzbq	0xc(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xc(%rax)
               	movzbq	0xd(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xd(%rax)
               	movzbq	0xe(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xe(%rax)
               	movzbq	0xf(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xf(%rax)
               	leaq	-0x410(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x400(%rbp), %rdi
               	addq	%rdx, %rdi
               	leaq	(%rcx,%rdx), %r8
               	movzbq	(%r8), %r8
               	movq	%r8, %r10
               	movq	%rsi, %r8
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %r8
               	popq	%rcx
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi)
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x10, %rdx
               	jl	<addr>
               	leaq	-0x410(%rbp), %rdi
               	leaq	-0x400(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x64, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	movabsq	$-0x7, %rdi
               	leaq	-0xe20(%rbp), %rsi
               	leaq	-0xd80(%rbp), %rax
               	movslq	(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, (%rax)
               	movslq	0x4(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0x4(%rax)
               	movslq	0x8(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0x8(%rax)
               	movslq	0xc(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x3f0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x3e0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	addq	%rsi, %rdx
               	movslq	(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rdi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movl	%edx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0x3f0(%rbp), %rdi
               	leaq	-0x3e0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x65, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	movabsq	$-0x7, %rsi
               	leaq	-0xe20(%rbp), %rdi
               	leaq	-0xd80(%rbp), %rax
               	movslq	(%rdi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, (%rax)
               	movslq	0x4(%rdi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0x4(%rax)
               	movslq	0x8(%rdi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0x8(%rax)
               	movslq	0xc(%rdi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x3d0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x3c0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	addq	%rdi, %rdx
               	movslq	(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	movl	%edx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0x3d0(%rbp), %rdi
               	leaq	-0x3c0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x66, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rcx
               	movl	$0x3, %edx
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0xf(%rax)
               	leaq	-0x3b0(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x3a0(%rbp), %rsi
               	leaq	(%rsi,%rdx), %rdi
               	leaq	(%rcx,%rdx), %rsi
               	movzbq	(%rsi), %rsi
               	imulq	$0x55555556, %rsi, %rsi # imm = 0x55555556
               	sarq	$0x20, %rsi
               	movq	%rsi, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdi)
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x10, %rdx
               	jl	<addr>
               	leaq	-0x3b0(%rbp), %rdi
               	leaq	-0x3a0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x48, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe30(%rbp), %rsi
               	movl	$0x7, %ecx
               	leaq	-0xd80(%rbp), %rax
               	movslq	(%rsi), %rdx
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rdx
               	popq	%rax
               	movl	%edx, (%rax)
               	movslq	0x4(%rsi), %rdx
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rdx
               	popq	%rax
               	movl	%edx, 0x4(%rax)
               	movslq	0x8(%rsi), %rdx
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rdx
               	popq	%rax
               	movl	%edx, 0x8(%rax)
               	movslq	0xc(%rsi), %rdx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x390(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	movl	$0x92492493, %edi       # imm = 0x92492493
               	jmp	<addr>
               	leaq	-0x380(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	addq	%rsi, %rdx
               	movslq	(%rdx), %rdx
               	imulq	%rdi, %rdx
               	sarq	$0x22, %rdx
               	movq	%rdx, %r9
               	shrq	$0x3f, %r9
               	addq	%r9, %rdx
               	movl	%edx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0x390(%rbp), %rdi
               	leaq	-0x380(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x60, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rcx
               	leaq	-0xd80(%rbp), %rdx
               	movzbq	(%rcx), %rsi
               	xorq	%rax, %rax
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, (%rdx)
               	movzbq	0x1(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x1(%rdx)
               	movzbq	0x2(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x2(%rdx)
               	movzbq	0x3(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x3(%rdx)
               	movzbq	0x4(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x4(%rdx)
               	movzbq	0x5(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x5(%rdx)
               	movzbq	0x6(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x6(%rdx)
               	movzbq	0x7(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x7(%rdx)
               	movzbq	0x8(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x8(%rdx)
               	movzbq	0x9(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x9(%rdx)
               	movzbq	0xa(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xa(%rdx)
               	movzbq	0xb(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xb(%rdx)
               	movzbq	0xc(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xc(%rdx)
               	movzbq	0xd(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xd(%rdx)
               	movzbq	0xe(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xe(%rdx)
               	movzbq	0xf(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xf(%rdx)
               	leaq	-0x370(%rbp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	jmp	<addr>
               	leaq	-0x360(%rbp), %rsi
               	leaq	(%rsi,%rdx), %rdi
               	leaq	(%rcx,%rdx), %rsi
               	movzbq	(%rsi), %rsi
               	imulq	$-0x1, %rsi, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdi)
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x10, %rdx
               	jl	<addr>
               	leaq	-0x370(%rbp), %rdi
               	leaq	-0x360(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x49, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xeb0(%rbp), %rcx
               	leaq	-0xd80(%rbp), %rdx
               	movsbq	(%rcx), %rsi
               	xorq	%rax, %rax
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, (%rdx)
               	movsbq	0x1(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x1(%rdx)
               	movsbq	0x2(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x2(%rdx)
               	movsbq	0x3(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x3(%rdx)
               	movsbq	0x4(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x4(%rdx)
               	movsbq	0x5(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x5(%rdx)
               	movsbq	0x6(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x6(%rdx)
               	movsbq	0x7(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x7(%rdx)
               	movsbq	0x8(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x8(%rdx)
               	movsbq	0x9(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x9(%rdx)
               	movsbq	0xa(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xa(%rdx)
               	movsbq	0xb(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xb(%rdx)
               	movsbq	0xc(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xc(%rdx)
               	movsbq	0xd(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xd(%rdx)
               	movsbq	0xe(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xe(%rdx)
               	movsbq	0xf(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xf(%rdx)
               	leaq	-0x350(%rbp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	jmp	<addr>
               	leaq	-0x340(%rbp), %rsi
               	leaq	(%rsi,%rdx), %r8
               	leaq	(%rcx,%rdx), %rsi
               	movsbq	(%rsi), %rsi
               	imulq	$-0x1, %rsi, %rsi
               	movslq	%esi, %rdi
               	movb	%dil, (%r8)
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x10, %rdx
               	jl	<addr>
               	leaq	-0x350(%rbp), %rdi
               	leaq	-0x340(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe30(%rbp), %rsi
               	leaq	-0xd80(%rbp), %rcx
               	movslq	(%rsi), %rdx
               	xorq	%rax, %rax
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, (%rcx)
               	movslq	0x4(%rsi), %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0x4(%rcx)
               	movslq	0x8(%rsi), %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0x8(%rcx)
               	movslq	0xc(%rsi), %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0xc(%rcx)
               	leaq	-0x330(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	jmp	<addr>
               	leaq	-0x320(%rbp), %rdi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rdi
               	addq	%rsi, %rdx
               	movslq	(%rdx), %rdx
               	imulq	$-0x1, %rdx, %rdx
               	movl	%edx, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0x330(%rbp), %rdi
               	leaq	-0x320(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4b, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rcx
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x3(%rax)
               	movzbq	0x4(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x5(%rax)
               	movzbq	0x6(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x6(%rax)
               	movzbq	0x7(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x7(%rax)
               	movzbq	0x8(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0xb(%rax)
               	movzbq	0xc(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0xc(%rax)
               	movzbq	0xd(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0xd(%rax)
               	movzbq	0xe(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0xe(%rax)
               	movzbq	0xf(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	-0x310(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x300(%rbp), %rsi
               	addq	%rdx, %rsi
               	leaq	(%rcx,%rdx), %rdi
               	movzbq	(%rdi), %rdi
               	xorq	$-0x1, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi)
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x10, %rdx
               	jl	<addr>
               	leaq	-0x310(%rbp), %rdi
               	leaq	-0x300(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4c, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xdf0(%rbp), %rsi
               	leaq	-0xd80(%rbp), %rax
               	movq	(%rsi), %rcx
               	xorq	$-0x1, %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	xorq	$-0x1, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x2f0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x2e0(%rbp), %rdi
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rdx
               	xorq	$-0x1, %rdx
               	movq	%rdx, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	leaq	-0x2f0(%rbp), %rdi
               	leaq	-0x2e0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4d, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rdx
               	leaq	-0xec0(%rbp), %rcx
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rdx), %rsi
               	movzbq	(%rcx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, (%rax)
               	movzbq	0x1(%rdx), %rsi
               	movzbq	0x1(%rcx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rdx), %rsi
               	movzbq	0x2(%rcx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rdx), %rsi
               	movzbq	0x3(%rcx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rdx), %rsi
               	movzbq	0x4(%rcx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rdx), %rsi
               	movzbq	0x5(%rcx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rdx), %rsi
               	movzbq	0x6(%rcx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rdx), %rsi
               	movzbq	0x7(%rcx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rdx), %rsi
               	movzbq	0x8(%rcx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rdx), %rsi
               	movzbq	0x9(%rcx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rdx), %rsi
               	movzbq	0xa(%rcx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rdx), %rsi
               	movzbq	0xb(%rcx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rdx), %rsi
               	movzbq	0xc(%rcx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rdx), %rsi
               	movzbq	0xd(%rcx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rdx), %rsi
               	movzbq	0xe(%rcx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rdx), %rsi
               	movzbq	0xf(%rcx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0xf(%rax)
               	leaq	-0x2d0(%rbp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rdi
               	leaq	-0x2c0(%rbp), %rdi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rdx
               	movzbq	(%rdi), %rdx
               	movzbq	(%rcx), %r8
               	addq	%r8, %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rdi), %rdx
               	movzbq	0x1(%rcx), %r8
               	addq	%r8, %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rdi), %rdx
               	movzbq	0x2(%rcx), %r8
               	addq	%r8, %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rdi), %rdx
               	movzbq	0x3(%rcx), %r8
               	addq	%r8, %rdx
               	movb	%dl, 0x3(%rax)
               	movzbq	0x4(%rdi), %rdx
               	movzbq	0x4(%rcx), %r8
               	addq	%r8, %rdx
               	movb	%dl, 0x4(%rax)
               	movzbq	0x5(%rdi), %rdx
               	movzbq	0x5(%rcx), %r8
               	addq	%r8, %rdx
               	movb	%dl, 0x5(%rax)
               	movzbq	0x6(%rdi), %rdx
               	movzbq	0x6(%rcx), %r8
               	addq	%r8, %rdx
               	movb	%dl, 0x6(%rax)
               	movzbq	0x7(%rdi), %rdx
               	movzbq	0x7(%rcx), %r8
               	addq	%r8, %rdx
               	movb	%dl, 0x7(%rax)
               	movzbq	0x8(%rdi), %rdx
               	movzbq	0x8(%rcx), %r8
               	addq	%r8, %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rdi), %rdx
               	movzbq	0x9(%rcx), %r8
               	addq	%r8, %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rdi), %rdx
               	movzbq	0xa(%rcx), %r8
               	addq	%r8, %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rdi), %rdx
               	movzbq	0xb(%rcx), %r8
               	addq	%r8, %rdx
               	movb	%dl, 0xb(%rax)
               	movzbq	0xc(%rdi), %rdx
               	movzbq	0xc(%rcx), %r8
               	addq	%r8, %rdx
               	movb	%dl, 0xc(%rax)
               	movzbq	0xd(%rdi), %rdx
               	movzbq	0xd(%rcx), %r8
               	addq	%r8, %rdx
               	movb	%dl, 0xd(%rax)
               	movzbq	0xe(%rdi), %rdx
               	movzbq	0xe(%rcx), %r8
               	addq	%r8, %rdx
               	movb	%dl, 0xe(%rax)
               	movzbq	0xf(%rdi), %rdx
               	movzbq	0xf(%rcx), %rcx
               	addq	%rdx, %rcx
               	movb	%cl, 0xf(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4e, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rdx
               	leaq	-0xec0(%rbp), %rcx
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rdx), %rsi
               	movzbq	(%rcx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, (%rax)
               	movzbq	0x1(%rdx), %rsi
               	movzbq	0x1(%rcx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rdx), %rsi
               	movzbq	0x2(%rcx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rdx), %rsi
               	movzbq	0x3(%rcx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rdx), %rsi
               	movzbq	0x4(%rcx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rdx), %rsi
               	movzbq	0x5(%rcx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rdx), %rsi
               	movzbq	0x6(%rcx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rdx), %rsi
               	movzbq	0x7(%rcx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rdx), %rsi
               	movzbq	0x8(%rcx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rdx), %rsi
               	movzbq	0x9(%rcx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rdx), %rsi
               	movzbq	0xa(%rcx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rdx), %rsi
               	movzbq	0xb(%rcx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rdx), %rsi
               	movzbq	0xc(%rcx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rdx), %rsi
               	movzbq	0xd(%rcx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rdx), %rsi
               	movzbq	0xe(%rcx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rdx), %rsi
               	movzbq	0xf(%rcx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xf(%rax)
               	leaq	-0x2b0(%rbp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rdi
               	leaq	-0x2a0(%rbp), %rdi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rdx
               	movzbq	(%rdi), %rdx
               	movzbq	(%rcx), %r8
               	subq	%r8, %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rdi), %rdx
               	movzbq	0x1(%rcx), %r8
               	subq	%r8, %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rdi), %rdx
               	movzbq	0x2(%rcx), %r8
               	subq	%r8, %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rdi), %rdx
               	movzbq	0x3(%rcx), %r8
               	subq	%r8, %rdx
               	movb	%dl, 0x3(%rax)
               	movzbq	0x4(%rdi), %rdx
               	movzbq	0x4(%rcx), %r8
               	subq	%r8, %rdx
               	movb	%dl, 0x4(%rax)
               	movzbq	0x5(%rdi), %rdx
               	movzbq	0x5(%rcx), %r8
               	subq	%r8, %rdx
               	movb	%dl, 0x5(%rax)
               	movzbq	0x6(%rdi), %rdx
               	movzbq	0x6(%rcx), %r8
               	subq	%r8, %rdx
               	movb	%dl, 0x6(%rax)
               	movzbq	0x7(%rdi), %rdx
               	movzbq	0x7(%rcx), %r8
               	subq	%r8, %rdx
               	movb	%dl, 0x7(%rax)
               	movzbq	0x8(%rdi), %rdx
               	movzbq	0x8(%rcx), %r8
               	subq	%r8, %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rdi), %rdx
               	movzbq	0x9(%rcx), %r8
               	subq	%r8, %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rdi), %rdx
               	movzbq	0xa(%rcx), %r8
               	subq	%r8, %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rdi), %rdx
               	movzbq	0xb(%rcx), %r8
               	subq	%r8, %rdx
               	movb	%dl, 0xb(%rax)
               	movzbq	0xc(%rdi), %rdx
               	movzbq	0xc(%rcx), %r8
               	subq	%r8, %rdx
               	movb	%dl, 0xc(%rax)
               	movzbq	0xd(%rdi), %rdx
               	movzbq	0xd(%rcx), %r8
               	subq	%r8, %rdx
               	movb	%dl, 0xd(%rax)
               	movzbq	0xe(%rdi), %rdx
               	movzbq	0xe(%rcx), %r8
               	subq	%r8, %rdx
               	movb	%dl, 0xe(%rax)
               	movzbq	0xf(%rdi), %rdx
               	movzbq	0xf(%rcx), %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movb	%cl, 0xf(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4f, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rdx
               	leaq	-0xec0(%rbp), %rcx
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rdx), %rsi
               	movzbq	(%rcx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, (%rax)
               	movzbq	0x1(%rdx), %rsi
               	movzbq	0x1(%rcx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rdx), %rsi
               	movzbq	0x2(%rcx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rdx), %rsi
               	movzbq	0x3(%rcx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rdx), %rsi
               	movzbq	0x4(%rcx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rdx), %rsi
               	movzbq	0x5(%rcx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rdx), %rsi
               	movzbq	0x6(%rcx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rdx), %rsi
               	movzbq	0x7(%rcx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rdx), %rsi
               	movzbq	0x8(%rcx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rdx), %rsi
               	movzbq	0x9(%rcx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rdx), %rsi
               	movzbq	0xa(%rcx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rdx), %rsi
               	movzbq	0xb(%rcx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rdx), %rsi
               	movzbq	0xc(%rcx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rdx), %rsi
               	movzbq	0xd(%rcx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rdx), %rsi
               	movzbq	0xe(%rcx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rdx), %rsi
               	movzbq	0xf(%rcx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0xf(%rax)
               	leaq	-0x290(%rbp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rdi
               	leaq	-0x280(%rbp), %rdi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rdx
               	movzbq	(%rdi), %rdx
               	movzbq	(%rcx), %r8
               	imulq	%r8, %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rdi), %rdx
               	movzbq	0x1(%rcx), %r8
               	imulq	%r8, %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rdi), %rdx
               	movzbq	0x2(%rcx), %r8
               	imulq	%r8, %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rdi), %rdx
               	movzbq	0x3(%rcx), %r8
               	imulq	%r8, %rdx
               	movb	%dl, 0x3(%rax)
               	movzbq	0x4(%rdi), %rdx
               	movzbq	0x4(%rcx), %r8
               	imulq	%r8, %rdx
               	movb	%dl, 0x4(%rax)
               	movzbq	0x5(%rdi), %rdx
               	movzbq	0x5(%rcx), %r8
               	imulq	%r8, %rdx
               	movb	%dl, 0x5(%rax)
               	movzbq	0x6(%rdi), %rdx
               	movzbq	0x6(%rcx), %r8
               	imulq	%r8, %rdx
               	movb	%dl, 0x6(%rax)
               	movzbq	0x7(%rdi), %rdx
               	movzbq	0x7(%rcx), %r8
               	imulq	%r8, %rdx
               	movb	%dl, 0x7(%rax)
               	movzbq	0x8(%rdi), %rdx
               	movzbq	0x8(%rcx), %r8
               	imulq	%r8, %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rdi), %rdx
               	movzbq	0x9(%rcx), %r8
               	imulq	%r8, %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rdi), %rdx
               	movzbq	0xa(%rcx), %r8
               	imulq	%r8, %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rdi), %rdx
               	movzbq	0xb(%rcx), %r8
               	imulq	%r8, %rdx
               	movb	%dl, 0xb(%rax)
               	movzbq	0xc(%rdi), %rdx
               	movzbq	0xc(%rcx), %r8
               	imulq	%r8, %rdx
               	movb	%dl, 0xc(%rax)
               	movzbq	0xd(%rdi), %rdx
               	movzbq	0xd(%rcx), %r8
               	imulq	%r8, %rdx
               	movb	%dl, 0xd(%rax)
               	movzbq	0xe(%rdi), %rdx
               	movzbq	0xe(%rcx), %r8
               	imulq	%r8, %rdx
               	movb	%dl, 0xe(%rax)
               	movzbq	0xf(%rdi), %rdx
               	movzbq	0xf(%rcx), %rcx
               	imulq	%rdx, %rcx
               	movb	%cl, 0xf(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x50, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rdx
               	leaq	-0xec0(%rbp), %rcx
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rdx), %rsi
               	movzbq	(%rcx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, (%rax)
               	movzbq	0x1(%rdx), %rsi
               	movzbq	0x1(%rcx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rdx), %rsi
               	movzbq	0x2(%rcx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rdx), %rsi
               	movzbq	0x3(%rcx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rdx), %rsi
               	movzbq	0x4(%rcx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rdx), %rsi
               	movzbq	0x5(%rcx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rdx), %rsi
               	movzbq	0x6(%rcx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rdx), %rsi
               	movzbq	0x7(%rcx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rdx), %rsi
               	movzbq	0x8(%rcx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rdx), %rsi
               	movzbq	0x9(%rcx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rdx), %rsi
               	movzbq	0xa(%rcx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rdx), %rsi
               	movzbq	0xb(%rcx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rdx), %rsi
               	movzbq	0xc(%rcx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rdx), %rsi
               	movzbq	0xd(%rcx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rdx), %rsi
               	movzbq	0xe(%rcx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rdx), %rsi
               	movzbq	0xf(%rcx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xf(%rax)
               	leaq	-0x270(%rbp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rdi
               	leaq	-0x260(%rbp), %rdi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rdx
               	movzbq	(%rdi), %rdx
               	movzbq	(%rcx), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, (%rax)
               	movzbq	0x1(%rdi), %rdx
               	movzbq	0x1(%rcx), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rdi), %rdx
               	movzbq	0x2(%rcx), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rdi), %rdx
               	movzbq	0x3(%rcx), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x3(%rax)
               	movzbq	0x4(%rdi), %rdx
               	movzbq	0x4(%rcx), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x4(%rax)
               	movzbq	0x5(%rdi), %rdx
               	movzbq	0x5(%rcx), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x5(%rax)
               	movzbq	0x6(%rdi), %rdx
               	movzbq	0x6(%rcx), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x6(%rax)
               	movzbq	0x7(%rdi), %rdx
               	movzbq	0x7(%rcx), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x7(%rax)
               	movzbq	0x8(%rdi), %rdx
               	movzbq	0x8(%rcx), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rdi), %rdx
               	movzbq	0x9(%rcx), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rdi), %rdx
               	movzbq	0xa(%rcx), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rdi), %rdx
               	movzbq	0xb(%rcx), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0xb(%rax)
               	movzbq	0xc(%rdi), %rdx
               	movzbq	0xc(%rcx), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0xc(%rax)
               	movzbq	0xd(%rdi), %rdx
               	movzbq	0xd(%rcx), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0xd(%rax)
               	movzbq	0xe(%rdi), %rdx
               	movzbq	0xe(%rcx), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0xe(%rax)
               	movzbq	0xf(%rdi), %rdx
               	movzbq	0xf(%rcx), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xf(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x51, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rcx
               	leaq	-0xec0(%rbp), %rax
               	leaq	-0xd80(%rbp), %rdx
               	movzbq	(%rcx), %rdi
               	movzbq	(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, (%rdx)
               	movzbq	0x1(%rcx), %rdi
               	movzbq	0x1(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x1(%rdx)
               	movzbq	0x2(%rcx), %rdi
               	movzbq	0x2(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x2(%rdx)
               	movzbq	0x3(%rcx), %rdi
               	movzbq	0x3(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x3(%rdx)
               	movzbq	0x4(%rcx), %rdi
               	movzbq	0x4(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x4(%rdx)
               	movzbq	0x5(%rcx), %rdi
               	movzbq	0x5(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x5(%rdx)
               	movzbq	0x6(%rcx), %rdi
               	movzbq	0x6(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x6(%rdx)
               	movzbq	0x7(%rcx), %rdi
               	movzbq	0x7(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x7(%rdx)
               	movzbq	0x8(%rcx), %rdi
               	movzbq	0x8(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x8(%rdx)
               	movzbq	0x9(%rcx), %rdi
               	movzbq	0x9(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x9(%rdx)
               	movzbq	0xa(%rcx), %rdi
               	movzbq	0xa(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xa(%rdx)
               	movzbq	0xb(%rcx), %rdi
               	movzbq	0xb(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xb(%rdx)
               	movzbq	0xc(%rcx), %rdi
               	movzbq	0xc(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xc(%rdx)
               	movzbq	0xd(%rcx), %rdi
               	movzbq	0xd(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xd(%rdx)
               	movzbq	0xe(%rcx), %rdi
               	movzbq	0xe(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xe(%rdx)
               	movzbq	0xf(%rcx), %rdi
               	movzbq	0xf(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xf(%rdx)
               	leaq	-0x250(%rbp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	leaq	-0x240(%rbp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	leaq	-0xd80(%rbp), %rcx
               	movzbq	(%rdi), %rsi
               	movzbq	(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rdi), %rsi
               	movzbq	0x1(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rdi), %rsi
               	movzbq	0x2(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0x2(%rcx)
               	movzbq	0x3(%rdi), %rsi
               	movzbq	0x3(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0x3(%rcx)
               	movzbq	0x4(%rdi), %rsi
               	movzbq	0x4(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0x4(%rcx)
               	movzbq	0x5(%rdi), %rsi
               	movzbq	0x5(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0x5(%rcx)
               	movzbq	0x6(%rdi), %rsi
               	movzbq	0x6(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0x6(%rcx)
               	movzbq	0x7(%rdi), %rsi
               	movzbq	0x7(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0x7(%rcx)
               	movzbq	0x8(%rdi), %rsi
               	movzbq	0x8(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0x8(%rcx)
               	movzbq	0x9(%rdi), %rsi
               	movzbq	0x9(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0x9(%rcx)
               	movzbq	0xa(%rdi), %rsi
               	movzbq	0xa(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0xa(%rcx)
               	movzbq	0xb(%rdi), %rsi
               	movzbq	0xb(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0xb(%rcx)
               	movzbq	0xc(%rdi), %rsi
               	movzbq	0xc(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0xc(%rcx)
               	movzbq	0xd(%rdi), %rsi
               	movzbq	0xd(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0xd(%rcx)
               	movzbq	0xe(%rdi), %rsi
               	movzbq	0xe(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0xe(%rcx)
               	movzbq	0xf(%rdi), %rdx
               	movzbq	0xf(%rax), %rax
               	movq	%rax, %r10
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	movb	%al, 0xf(%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rax
               	leaq	-0x250(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x52, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rdx
               	leaq	-0xec0(%rbp), %rcx
               	leaq	-0xd80(%rbp), %rax
               	movq	(%rdx), %rsi
               	movq	(%rcx), %rdi
               	andq	%rdi, %rsi
               	movq	%rsi, (%rax)
               	movq	0x8(%rdx), %rsi
               	movq	0x8(%rcx), %rdi
               	andq	%rdi, %rsi
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x230(%rbp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rdi
               	leaq	-0x220(%rbp), %rdi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rdx
               	movq	(%rdi), %rdx
               	movq	(%rcx), %r8
               	andq	%r8, %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rdi), %rdx
               	movq	0x8(%rcx), %rcx
               	andq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x53, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rdx
               	leaq	-0xec0(%rbp), %rcx
               	leaq	-0xd80(%rbp), %rax
               	movq	(%rdx), %rsi
               	movq	(%rcx), %rdi
               	orq	%rdi, %rsi
               	movq	%rsi, (%rax)
               	movq	0x8(%rdx), %rsi
               	movq	0x8(%rcx), %rdi
               	orq	%rdi, %rsi
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x210(%rbp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rdi
               	leaq	-0x200(%rbp), %rdi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rdx
               	movq	(%rdi), %rdx
               	movq	(%rcx), %r8
               	orq	%r8, %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rdi), %rdx
               	movq	0x8(%rcx), %rcx
               	orq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x54, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rdx
               	leaq	-0xec0(%rbp), %rcx
               	leaq	-0xd80(%rbp), %rax
               	movq	(%rdx), %rsi
               	movq	(%rcx), %rdi
               	xorq	%rdi, %rsi
               	movq	%rsi, (%rax)
               	movq	0x8(%rdx), %rsi
               	movq	0x8(%rcx), %rdi
               	xorq	%rdi, %rsi
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x1f0(%rbp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rdi
               	leaq	-0x1e0(%rbp), %rdi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rdx
               	movq	(%rdi), %rdx
               	movq	(%rcx), %r8
               	xorq	%r8, %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rdi), %rdx
               	movq	0x8(%rcx), %rcx
               	xorq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x55, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rdx
               	leaq	-0xdc0(%rbp), %rcx
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rdx), %rsi
               	movzbq	(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, (%rax)
               	movzbq	0x1(%rdx), %rsi
               	movzbq	0x1(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rdx), %rsi
               	movzbq	0x2(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rdx), %rsi
               	movzbq	0x3(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rdx), %rsi
               	movzbq	0x4(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rdx), %rsi
               	movzbq	0x5(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rdx), %rsi
               	movzbq	0x6(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rdx), %rsi
               	movzbq	0x7(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rdx), %rsi
               	movzbq	0x8(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rdx), %rsi
               	movzbq	0x9(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rdx), %rsi
               	movzbq	0xa(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rdx), %rsi
               	movzbq	0xb(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rdx), %rsi
               	movzbq	0xc(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rdx), %rsi
               	movzbq	0xd(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rdx), %rsi
               	movzbq	0xe(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rdx), %rsi
               	movzbq	0xf(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xf(%rax)
               	leaq	-0x1d0(%rbp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rdi
               	leaq	-0x1c0(%rbp), %rdi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rdx
               	movzbq	(%rdi), %rdx
               	movzbq	(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rdi), %rdx
               	movzbq	0x1(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rdi), %rdx
               	movzbq	0x2(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rdi), %rdx
               	movzbq	0x3(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x3(%rax)
               	movzbq	0x4(%rdi), %rdx
               	movzbq	0x4(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x4(%rax)
               	movzbq	0x5(%rdi), %rdx
               	movzbq	0x5(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x5(%rax)
               	movzbq	0x6(%rdi), %rdx
               	movzbq	0x6(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x6(%rax)
               	movzbq	0x7(%rdi), %rdx
               	movzbq	0x7(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x7(%rax)
               	movzbq	0x8(%rdi), %rdx
               	movzbq	0x8(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rdi), %rdx
               	movzbq	0x9(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rdi), %rdx
               	movzbq	0xa(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rdi), %rdx
               	movzbq	0xb(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xb(%rax)
               	movzbq	0xc(%rdi), %rdx
               	movzbq	0xc(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xc(%rax)
               	movzbq	0xd(%rdi), %rdx
               	movzbq	0xd(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xd(%rax)
               	movzbq	0xe(%rdi), %rdx
               	movzbq	0xe(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xe(%rax)
               	movzbq	0xf(%rdi), %rdx
               	movzbq	0xf(%rcx), %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	movq	%rcx, %r11
               	movq	%r10, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	movb	%cl, 0xf(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x56, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rdx
               	leaq	-0xdc0(%rbp), %rcx
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rdx), %rsi
               	movzbq	(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, (%rax)
               	movzbq	0x1(%rdx), %rsi
               	movzbq	0x1(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rdx), %rsi
               	movzbq	0x2(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rdx), %rsi
               	movzbq	0x3(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rdx), %rsi
               	movzbq	0x4(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rdx), %rsi
               	movzbq	0x5(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rdx), %rsi
               	movzbq	0x6(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rdx), %rsi
               	movzbq	0x7(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rdx), %rsi
               	movzbq	0x8(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rdx), %rsi
               	movzbq	0x9(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rdx), %rsi
               	movzbq	0xa(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rdx), %rsi
               	movzbq	0xb(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rdx), %rsi
               	movzbq	0xc(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rdx), %rsi
               	movzbq	0xd(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rdx), %rsi
               	movzbq	0xe(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rdx), %rsi
               	movzbq	0xf(%rcx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xf(%rax)
               	leaq	-0x1b0(%rbp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rdi
               	leaq	-0x1a0(%rbp), %rdi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rdx
               	movzbq	(%rdi), %rdx
               	movzbq	(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rdi), %rdx
               	movzbq	0x1(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rdi), %rdx
               	movzbq	0x2(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rdi), %rdx
               	movzbq	0x3(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x3(%rax)
               	movzbq	0x4(%rdi), %rdx
               	movzbq	0x4(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x4(%rax)
               	movzbq	0x5(%rdi), %rdx
               	movzbq	0x5(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x5(%rax)
               	movzbq	0x6(%rdi), %rdx
               	movzbq	0x6(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x6(%rax)
               	movzbq	0x7(%rdi), %rdx
               	movzbq	0x7(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x7(%rax)
               	movzbq	0x8(%rdi), %rdx
               	movzbq	0x8(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rdi), %rdx
               	movzbq	0x9(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rdi), %rdx
               	movzbq	0xa(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rdi), %rdx
               	movzbq	0xb(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xb(%rax)
               	movzbq	0xc(%rdi), %rdx
               	movzbq	0xc(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xc(%rax)
               	movzbq	0xd(%rdi), %rdx
               	movzbq	0xd(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xd(%rax)
               	movzbq	0xe(%rdi), %rdx
               	movzbq	0xe(%rcx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xe(%rax)
               	movzbq	0xf(%rdi), %rdx
               	movzbq	0xf(%rcx), %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	movq	%rcx, %r11
               	movq	%r10, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movb	%cl, 0xf(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x57, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe70(%rbp), %rdx
               	leaq	-0xe60(%rbp), %rcx
               	leaq	-0xd80(%rbp), %rax
               	movswq	(%rdx), %rsi
               	movswq	(%rcx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, (%rax)
               	movswq	0x2(%rdx), %rsi
               	movswq	0x2(%rcx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0x2(%rax)
               	movswq	0x4(%rdx), %rsi
               	movswq	0x4(%rcx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0x4(%rax)
               	movswq	0x6(%rdx), %rsi
               	movswq	0x6(%rcx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0x6(%rax)
               	movswq	0x8(%rdx), %rsi
               	movswq	0x8(%rcx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0x8(%rax)
               	movswq	0xa(%rdx), %rsi
               	movswq	0xa(%rcx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0xa(%rax)
               	movswq	0xc(%rdx), %rsi
               	movswq	0xc(%rcx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0xc(%rax)
               	movswq	0xe(%rdx), %rsi
               	movswq	0xe(%rcx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0xe(%rax)
               	leaq	-0x190(%rbp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rdi
               	leaq	-0x180(%rbp), %rdi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rdx
               	movswq	(%rdi), %rdx
               	movswq	(%rcx), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movw	%dx, (%rax)
               	movswq	0x2(%rdi), %rdx
               	movswq	0x2(%rcx), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movw	%dx, 0x2(%rax)
               	movswq	0x4(%rdi), %rdx
               	movswq	0x4(%rcx), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movw	%dx, 0x4(%rax)
               	movswq	0x6(%rdi), %rdx
               	movswq	0x6(%rcx), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movw	%dx, 0x6(%rax)
               	movswq	0x8(%rdi), %rdx
               	movswq	0x8(%rcx), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movw	%dx, 0x8(%rax)
               	movswq	0xa(%rdi), %rdx
               	movswq	0xa(%rcx), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movw	%dx, 0xa(%rax)
               	movswq	0xc(%rdi), %rdx
               	movswq	0xc(%rcx), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movw	%dx, 0xc(%rax)
               	movswq	0xe(%rdi), %rdx
               	movswq	0xe(%rcx), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xe(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x58, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xdf0(%rbp), %rdx
               	leaq	-0xde0(%rbp), %rcx
               	leaq	-0xd80(%rbp), %rax
               	movq	(%rdx), %rsi
               	movq	(%rcx), %rdi
               	imulq	%rdi, %rsi
               	movq	%rsi, (%rax)
               	movq	0x8(%rdx), %rsi
               	movq	0x8(%rcx), %rdi
               	imulq	%rdi, %rsi
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x170(%rbp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rdi
               	leaq	-0x160(%rbp), %rdi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rdx
               	movq	(%rdi), %rdx
               	movq	(%rcx), %r8
               	imulq	%r8, %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rdi), %rdx
               	movq	0x8(%rcx), %rcx
               	imulq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x59, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rcx
               	leaq	-0x150(%rbp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rax
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x3(%rax)
               	movzbq	0x4(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4(%rax)
               	movzbq	0x5(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x5(%rax)
               	movzbq	0x6(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x6(%rax)
               	movzbq	0x7(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x7(%rax)
               	movzbq	0x8(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xb(%rax)
               	movzbq	0xc(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xc(%rax)
               	movzbq	0xd(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xd(%rax)
               	movzbq	0xe(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xe(%rax)
               	movzbq	0xf(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xf(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rdx
               	movzbq	(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x3(%rax)
               	movzbq	0x4(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x5(%rax)
               	movzbq	0x6(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x6(%rax)
               	movzbq	0x7(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x7(%rax)
               	movzbq	0x8(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xb(%rax)
               	movzbq	0xc(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xc(%rax)
               	movzbq	0xd(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xd(%rax)
               	movzbq	0xe(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xe(%rax)
               	movzbq	0xf(%rcx), %rcx
               	subq	$0x40, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0x140(%rbp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rcx
               	leaq	-0x130(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	-0xd80(%rbp), %rcx
               	movzbq	(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x2(%rcx)
               	movzbq	0x3(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x3(%rcx)
               	movzbq	0x4(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4(%rcx)
               	movzbq	0x5(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x5(%rcx)
               	movzbq	0x6(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x6(%rcx)
               	movzbq	0x7(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x7(%rcx)
               	movzbq	0x8(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x8(%rcx)
               	movzbq	0x9(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x9(%rcx)
               	movzbq	0xa(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xa(%rcx)
               	movzbq	0xb(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xb(%rcx)
               	movzbq	0xc(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xc(%rcx)
               	movzbq	0xd(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xd(%rcx)
               	movzbq	0xe(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xe(%rcx)
               	movzbq	0xf(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xf(%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rdx
               	movzbq	(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x2(%rcx)
               	movzbq	0x3(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x3(%rcx)
               	movzbq	0x4(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4(%rcx)
               	movzbq	0x5(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x5(%rcx)
               	movzbq	0x6(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x6(%rcx)
               	movzbq	0x7(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x7(%rcx)
               	movzbq	0x8(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x8(%rcx)
               	movzbq	0x9(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x9(%rcx)
               	movzbq	0xa(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xa(%rcx)
               	movzbq	0xb(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xb(%rcx)
               	movzbq	0xc(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xc(%rcx)
               	movzbq	0xd(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xd(%rcx)
               	movzbq	0xe(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xe(%rcx)
               	movzbq	0xf(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xf(%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	-0x130(%rbp), %rdx
               	leaq	-0xd80(%rbp), %rcx
               	movzbq	(%rdx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, (%rcx)
               	movzbq	0x1(%rdx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x1(%rcx)
               	movzbq	0x2(%rdx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x2(%rcx)
               	movzbq	0x3(%rdx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x3(%rcx)
               	movzbq	0x4(%rdx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x4(%rcx)
               	movzbq	0x5(%rdx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x5(%rcx)
               	movzbq	0x6(%rdx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x6(%rcx)
               	movzbq	0x7(%rdx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x7(%rcx)
               	movzbq	0x8(%rdx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0xb(%rcx)
               	movzbq	0xc(%rdx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0xc(%rcx)
               	movzbq	0xd(%rdx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0xd(%rcx)
               	movzbq	0xe(%rdx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0xe(%rcx)
               	movzbq	0xf(%rdx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xf(%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xed0(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x120(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	subq	$0xc0, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0x130(%rbp), %rdi
               	leaq	-0x120(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5b, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rax
               	leaq	-0xec0(%rbp), %rcx
               	movzbq	(%rax), %rsi
               	movzbq	(%rcx), %rdi
               	addq	%rdi, %rsi
               	movzbq	0x1(%rax), %rdi
               	movzbq	0x1(%rcx), %r8
               	addq	%r8, %rdi
               	movzbq	0x2(%rax), %r8
               	movzbq	0x2(%rcx), %r9
               	addq	%r9, %r8
               	movzbq	0x3(%rax), %r9
               	movzbq	0x3(%rcx), %rbx
               	addq	%rbx, %r9
               	movzbq	0x4(%rax), %rbx
               	movzbq	0x4(%rcx), %r12
               	addq	%r12, %rbx
               	movzbq	0x5(%rax), %r12
               	movzbq	0x5(%rcx), %r13
               	addq	%r13, %r12
               	movzbq	0x6(%rax), %r13
               	movzbq	0x6(%rcx), %r14
               	addq	%r14, %r13
               	movzbq	0x7(%rax), %r14
               	movzbq	0x7(%rcx), %r15
               	addq	%r15, %r14
               	movzbq	0x8(%rax), %r15
               	movzbq	0x8(%rcx), %r10
               	movq	%r10, 0x68(%rsp)
               	addq	0x68(%rsp), %r15
               	movzbq	0x9(%rax), %r10
               	movq	%r10, 0x68(%rsp)
               	movzbq	0x9(%rcx), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x68(%rsp), %r10
               	addq	0x60(%rsp), %r10
               	movq	%r10, 0x68(%rsp)
               	movzbq	0xa(%rax), %r10
               	movq	%r10, 0x60(%rsp)
               	movzbq	0xa(%rcx), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x60(%rsp), %r10
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	movzbq	0xb(%rax), %r10
               	movq	%r10, 0x58(%rsp)
               	movzbq	0xb(%rcx), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x58(%rsp), %r10
               	addq	0x50(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movzbq	0xc(%rax), %r10
               	movq	%r10, 0x50(%rsp)
               	movzbq	0xc(%rcx), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x50(%rsp), %r10
               	addq	0x48(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movzbq	0xd(%rax), %r10
               	movq	%r10, 0x48(%rsp)
               	movzbq	0xd(%rcx), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x48(%rsp), %r10
               	addq	0x40(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movzbq	0xe(%rax), %r10
               	movq	%r10, 0x40(%rsp)
               	movzbq	0xe(%rcx), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rsp), %r10
               	addq	0x38(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movzbq	0xf(%rax), %rax
               	movzbq	0xf(%rcx), %rcx
               	leaq	(%rax,%rcx), %r10
               	movq	%r10, 0x38(%rsp)
               	movl	$0x3, %eax
               	movq	%rsi, %rdx
               	andq	$0xff, %rdx
               	imulq	%rax, %rdx
               	movq	%rdi, %rsi
               	andq	$0xff, %rsi
               	imulq	%rax, %rsi
               	movq	%r8, %rdi
               	andq	$0xff, %rdi
               	imulq	%rax, %rdi
               	movq	%r9, %r8
               	andq	$0xff, %r8
               	imulq	%rax, %r8
               	movq	%rbx, %r9
               	andq	$0xff, %r9
               	imulq	%rax, %r9
               	movq	%r12, %rbx
               	andq	$0xff, %rbx
               	imulq	%rax, %rbx
               	movq	%r13, %r12
               	andq	$0xff, %r12
               	imulq	%rax, %r12
               	movq	%r14, %r13
               	andq	$0xff, %r13
               	imulq	%rax, %r13
               	movq	%r15, %r14
               	andq	$0xff, %r14
               	imulq	%rax, %r14
               	movq	0x68(%rsp), %r15
               	andq	$0xff, %r15
               	imulq	%rax, %r15
               	movq	0x60(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x68(%rsp), %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x58(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x60(%rsp), %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x50(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x48(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x40(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x38(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	leaq	-0xed0(%rbp), %rcx
               	leaq	-0xd80(%rbp), %rax
               	andq	$0xff, %rdx
               	movzbq	(%rcx), %r10
               	movq	%r10, 0x38(%rsp)
               	subq	0x38(%rsp), %rdx
               	movb	%dl, (%rax)
               	movq	%rsi, %rdx
               	andq	$0xff, %rdx
               	movzbq	0x1(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x1(%rax)
               	movq	%rdi, %rdx
               	andq	$0xff, %rdx
               	movzbq	0x2(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x2(%rax)
               	movq	%r8, %rdx
               	andq	$0xff, %rdx
               	movzbq	0x3(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x3(%rax)
               	movq	%r9, %rdx
               	andq	$0xff, %rdx
               	movzbq	0x4(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x4(%rax)
               	movq	%rbx, %rdx
               	andq	$0xff, %rdx
               	movzbq	0x5(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x5(%rax)
               	movq	%r12, %rdx
               	andq	$0xff, %rdx
               	movzbq	0x6(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x6(%rax)
               	movq	%r13, %rdx
               	andq	$0xff, %rdx
               	movzbq	0x7(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x7(%rax)
               	movq	%r14, %rdx
               	andq	$0xff, %rdx
               	movzbq	0x8(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x8(%rax)
               	movq	%r15, %rdx
               	andq	$0xff, %rdx
               	movzbq	0x9(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x9(%rax)
               	movq	0x68(%rsp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xa(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0xa(%rax)
               	movq	0x60(%rsp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xb(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0xb(%rax)
               	movq	0x58(%rsp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xc(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0xc(%rax)
               	movq	0x50(%rsp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xd(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0xd(%rax)
               	movq	0x48(%rsp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xe(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0xe(%rax)
               	movq	0x40(%rsp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xf(%rcx), %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0x110(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xed0(%rbp), %r8
               	leaq	-0xec0(%rbp), %r9
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x100(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rbx
               	leaq	(%r8,%rcx), %rsi
               	movzbq	(%rsi), %rdi
               	leaq	(%r9,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	addq	%rdi, %rdx
               	andq	$0xff, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	andq	$0xff, %rdx
               	subq	%rdi, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rbx)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0x110(%rbp), %rdi
               	leaq	-0x100(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5c, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xe30(%rbp), %rax
               	movl	$0x3, %ecx
               	movslq	(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movslq	0x4(%rax), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movslq	0x8(%rax), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movslq	0xc(%rax), %rax
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rcx
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	xorq	%rax, %rax
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movq	%r8, %r10
               	movq	%rax, %r8
               	subq	%r10, %r8
               	movq	%r9, %r10
               	movq	%rax, %r9
               	subq	%r10, %r9
               	leaq	-0xe20(%rbp), %rdx
               	leaq	-0xd80(%rbp), %rcx
               	movslq	(%rdx), %rbx
               	addq	%rbx, %rsi
               	movl	%esi, (%rcx)
               	movslq	0x4(%rdx), %rsi
               	addq	%rdi, %rsi
               	movl	%esi, 0x4(%rcx)
               	movslq	0x8(%rdx), %rsi
               	addq	%r8, %rsi
               	movl	%esi, 0x8(%rcx)
               	movslq	0xc(%rdx), %rdx
               	addq	%r9, %rdx
               	movl	%edx, 0xc(%rcx)
               	leaq	-0xf0(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0xe30(%rbp), %rdi
               	leaq	-0xe20(%rbp), %r8
               	jmp	<addr>
               	leaq	-0xe0(%rbp), %rsi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rsi,%rdx), %r9
               	leaq	(%rdi,%rdx), %rsi
               	movslq	(%rsi), %rsi
               	imulq	$0x55555556, %rsi, %rsi # imm = 0x55555556
               	sarq	$0x20, %rsi
               	movq	%rsi, %rbx
               	shrq	$0x3f, %rbx
               	addq	%rbx, %rsi
               	imulq	$-0x1, %rsi, %rsi
               	addq	%r8, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rsi, %rdx
               	movl	%edx, (%r9)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0xf0(%rbp), %rdi
               	leaq	-0xe0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5d, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rcx
               	leaq	-0xd80(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	-0xdc0(%rbp), %rcx
               	movzbq	(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0x2(%rcx)
               	movzbq	0x3(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0x3(%rcx)
               	movzbq	0x4(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0x4(%rcx)
               	movzbq	0x5(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0x5(%rcx)
               	movzbq	0x6(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0x6(%rcx)
               	movzbq	0x7(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0x7(%rcx)
               	movzbq	0x8(%rax), %rdx
               	shlq	%rdx
               	leaq	0x8(%rcx), %rsi
               	movb	%dl, (%rsi)
               	movzbq	0x9(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0x9(%rcx)
               	movzbq	0xa(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0xa(%rcx)
               	movzbq	0xb(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0xb(%rcx)
               	movzbq	0xc(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0xc(%rcx)
               	movzbq	0xd(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0xd(%rcx)
               	movzbq	0xe(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0xe(%rcx)
               	movzbq	0xf(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0xf(%rcx)
               	movsbq	(%rax), %rdi
               	sarq	$0x7, %rdi
               	movsbq	0x1(%rax), %r8
               	sarq	$0x7, %r8
               	movsbq	0x2(%rax), %r9
               	sarq	$0x7, %r9
               	movsbq	0x3(%rax), %rbx
               	sarq	$0x7, %rbx
               	movsbq	0x4(%rax), %r12
               	sarq	$0x7, %r12
               	movsbq	0x5(%rax), %r13
               	sarq	$0x7, %r13
               	movsbq	0x6(%rax), %r14
               	sarq	$0x7, %r14
               	movsbq	0x7(%rax), %r15
               	sarq	$0x7, %r15
               	movsbq	0x8(%rax), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x68(%rsp), %r10
               	sarq	$0x7, %r10
               	movq	%r10, 0x68(%rsp)
               	movsbq	0x9(%rax), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x60(%rsp), %r10
               	sarq	$0x7, %r10
               	movq	%r10, 0x60(%rsp)
               	movsbq	0xa(%rax), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	sarq	$0x7, %r10
               	movq	%r10, 0x58(%rsp)
               	movsbq	0xb(%rax), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	sarq	$0x7, %r10
               	movq	%r10, 0x50(%rsp)
               	movsbq	0xc(%rax), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	sarq	$0x7, %r10
               	movq	%r10, 0x48(%rsp)
               	movsbq	0xd(%rax), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	sarq	$0x7, %r10
               	movq	%r10, 0x40(%rsp)
               	movsbq	0xe(%rax), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	sarq	$0x7, %r10
               	movq	%r10, 0x38(%rsp)
               	movsbq	0xf(%rax), %rax
               	movq	%rax, %r10
               	sarq	$0x7, %r10
               	movq	%r10, 0x30(%rsp)
               	movl	$0x1b, %edx
               	leaq	-0xda0(%rbp), %rax
               	movsbq	%dil, %rdi
               	andq	%rdx, %rdi
               	movb	%dil, (%rax)
               	movsbq	%r8b, %rdi
               	andq	%rdx, %rdi
               	movb	%dil, 0x1(%rax)
               	movsbq	%r9b, %rdi
               	andq	%rdx, %rdi
               	movb	%dil, 0x2(%rax)
               	movsbq	%bl, %rdi
               	andq	%rdx, %rdi
               	movb	%dil, 0x3(%rax)
               	movsbq	%r12b, %rdi
               	andq	%rdx, %rdi
               	movb	%dil, 0x4(%rax)
               	movsbq	%r13b, %rdi
               	andq	%rdx, %rdi
               	movb	%dil, 0x5(%rax)
               	movsbq	%r14b, %rdi
               	andq	%rdx, %rdi
               	movb	%dil, 0x6(%rax)
               	movsbq	%r15b, %rdi
               	andq	%rdx, %rdi
               	movb	%dil, 0x7(%rax)
               	movq	0x68(%rsp), %rdi
               	movsbq	%dil, %rdi
               	movq	%rdi, %r8
               	andq	%rdx, %r8
               	leaq	0x8(%rax), %rdi
               	movb	%r8b, (%rdi)
               	movq	0x60(%rsp), %r8
               	movsbq	%r8b, %r8
               	andq	%rdx, %r8
               	movb	%r8b, 0x9(%rax)
               	movq	0x58(%rsp), %r8
               	movsbq	%r8b, %r8
               	andq	%rdx, %r8
               	movb	%r8b, 0xa(%rax)
               	movq	0x50(%rsp), %r8
               	movsbq	%r8b, %r8
               	andq	%rdx, %r8
               	movb	%r8b, 0xb(%rax)
               	movq	0x48(%rsp), %r8
               	movsbq	%r8b, %r8
               	andq	%rdx, %r8
               	movb	%r8b, 0xc(%rax)
               	movq	0x40(%rsp), %r8
               	movsbq	%r8b, %r8
               	andq	%rdx, %r8
               	movb	%r8b, 0xd(%rax)
               	movq	0x38(%rsp), %r8
               	movsbq	%r8b, %r8
               	andq	%rdx, %r8
               	movb	%r8b, 0xe(%rax)
               	movq	0x30(%rsp), %r8
               	movsbq	%r8b, %r8
               	andq	%r8, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	-0xd80(%rbp), %rdx
               	movq	(%rcx), %rcx
               	movq	(%rax), %rax
               	xorq	%rcx, %rax
               	movq	%rax, (%rdx)
               	movq	(%rsi), %rax
               	movq	(%rdi), %rcx
               	xorq	%rcx, %rax
               	movq	%rax, 0x8(%rdx)
               	leaq	-0xd0(%rbp), %rax
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0xed0(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdx
               	movsbq	%dl, %r8
               	sarq	$0x7, %r8
               	andq	$0x1b, %r8
               	leaq	-0xc0(%rbp), %r9
               	addq	%rcx, %r9
               	shlq	%rdx
               	andq	$0xff, %rdx
               	movq	%r8, %rdi
               	andq	$0xff, %rdi
               	xorq	%rdi, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%r9)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xd0(%rbp), %rdi
               	leaq	-0xc0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5e, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xed0(%rbp), %rdx
               	leaq	-0xeb0(%rbp), %rsi
               	leaq	-0xd80(%rbp), %rax
               	movzbq	(%rdx), %rcx
               	movzbq	(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, (%rax)
               	movzbq	0x1(%rdx), %rcx
               	movzbq	0x1(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0x1(%rax)
               	movzbq	0x2(%rdx), %rcx
               	movzbq	0x2(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0x2(%rax)
               	movzbq	0x3(%rdx), %rcx
               	movzbq	0x3(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0x3(%rax)
               	movzbq	0x4(%rdx), %rcx
               	movzbq	0x4(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0x4(%rax)
               	movzbq	0x5(%rdx), %rcx
               	movzbq	0x5(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0x5(%rax)
               	movzbq	0x6(%rdx), %rcx
               	movzbq	0x6(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0x6(%rax)
               	movzbq	0x7(%rdx), %rcx
               	movzbq	0x7(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0x7(%rax)
               	movzbq	0x8(%rdx), %rcx
               	movzbq	0x8(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0x8(%rax)
               	movzbq	0x9(%rdx), %rcx
               	movzbq	0x9(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0x9(%rax)
               	movzbq	0xa(%rdx), %rcx
               	movzbq	0xa(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0xa(%rax)
               	movzbq	0xb(%rdx), %rcx
               	movzbq	0xb(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0xb(%rax)
               	movzbq	0xc(%rdx), %rcx
               	movzbq	0xc(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0xc(%rax)
               	movzbq	0xd(%rdx), %rcx
               	movzbq	0xd(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0xd(%rax)
               	movzbq	0xe(%rdx), %rcx
               	movzbq	0xe(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0xe(%rax)
               	movzbq	0xf(%rdx), %rcx
               	movzbq	0xf(%rsi), %rdi
               	addq	%rdi, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0xb0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	leaq	(%rdi,%rcx), %r8
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r9
               	movzbq	(%r9), %r9
               	addq	%r9, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xb0(%rbp), %rdi
               	leaq	-0xa0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5f, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xdc0(%rbp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0xda0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xd80(%rbp), %rax
               	movl	$0x42, %edi
               	movb	%dil, (%rax)
               	xorq	%rdi, %rdi
               	movb	%dil, 0x1(%rax)
               	movl	$0x28, %r8d
               	movb	%r8b, 0x2(%rax)
               	movb	%dil, 0x3(%rax)
               	movl	$0x1d, %r8d
               	movb	%r8b, 0x4(%rax)
               	movb	%dil, 0x5(%rax)
               	movl	$0x16, %r8d
               	movb	%r8b, 0x6(%rax)
               	movb	%dil, 0x7(%rax)
               	movl	$0x1, %edi
               	movb	%dil, 0x8(%rax)
               	movl	$0x2, %edi
               	movb	%dil, 0x9(%rax)
               	movl	$0x3, %edi
               	movb	%dil, 0xa(%rax)
               	movl	$0x4, %edi
               	movb	%dil, 0xb(%rax)
               	movl	$0x5, %edi
               	movb	%dil, 0xc(%rax)
               	movl	$0x6, %edi
               	movb	%dil, 0xd(%rax)
               	movl	$0x7, %edi
               	movb	%dil, 0xe(%rax)
               	movl	$0x8, %ecx
               	movb	%cl, 0xf(%rax)
               	leaq	-0x90(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xda0(%rbp), %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rdi
               	addq	%rcx, %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rdx,%rcx), %r9
               	movzbq	(%r9), %r9
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0x90(%rbp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x67, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	leaq	-0xdc0(%rbp), %rdx
               	leaq	-0xda0(%rbp), %rsi
               	leaq	-0xd80(%rbp), %rax
               	movsbq	(%rdx), %rcx
               	movsbq	(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, (%rax)
               	movsbq	0x1(%rdx), %rcx
               	movsbq	0x1(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x1(%rax)
               	movsbq	0x2(%rdx), %rcx
               	movsbq	0x2(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x2(%rax)
               	movsbq	0x3(%rdx), %rcx
               	movsbq	0x3(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x3(%rax)
               	movsbq	0x4(%rdx), %rcx
               	movsbq	0x4(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x4(%rax)
               	movsbq	0x5(%rdx), %rcx
               	movsbq	0x5(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x5(%rax)
               	movsbq	0x6(%rdx), %rcx
               	movsbq	0x6(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x6(%rax)
               	movsbq	0x7(%rdx), %rcx
               	movsbq	0x7(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x7(%rax)
               	movsbq	0x8(%rdx), %rcx
               	movsbq	0x8(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x8(%rax)
               	movsbq	0x9(%rdx), %rcx
               	movsbq	0x9(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0x9(%rax)
               	movsbq	0xa(%rdx), %rcx
               	movsbq	0xa(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xa(%rax)
               	movsbq	0xb(%rdx), %rcx
               	movsbq	0xb(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xb(%rax)
               	movsbq	0xc(%rdx), %rcx
               	movsbq	0xc(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xc(%rax)
               	movsbq	0xd(%rdx), %rcx
               	movsbq	0xd(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xd(%rax)
               	movsbq	0xe(%rdx), %rcx
               	movsbq	0xe(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xe(%rax)
               	movsbq	0xf(%rdx), %rcx
               	movsbq	0xf(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xf(%rax)
               	leaq	-0x70(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x60(%rbp), %rdi
               	leaq	(%rdi,%rcx), %r8
               	leaq	(%rdx,%rcx), %rdi
               	movsbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r9
               	movsbq	(%r9), %r9
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0x70(%rbp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x68, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf60, %rsp            # imm = 0xF60
               	popq	%rbp
               	retq
