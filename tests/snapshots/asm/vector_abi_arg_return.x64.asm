
vector_abi_arg_return.x64:	file format elf64-x86-64

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

<vec_sub>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movups	%xmm0, -0x50(%rbp,%riz)
               	movups	%xmm1, -0x40(%rbp,%riz)
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x50(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	movzbq	(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	movzbq	0x1(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	movzbq	0x2(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	movzbq	0x3(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	movzbq	0x4(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	movzbq	0x5(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	movzbq	0x6(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	movzbq	0x7(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	movzbq	0x8(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	movzbq	0x9(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	movzbq	0xa(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	movzbq	0xb(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	movzbq	0xc(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	movzbq	0xd(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	movzbq	0xe(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rcx
               	movzbq	0xf(%rdx), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, 0xf(%rax)
               	movq	%rax, %rcx
               	movups	(%rcx,%riz), %xmm0
               	leave
               	retq

<vec8_sub>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movsd	%xmm0, -0x8(%rbp,%riz)
               	movsd	%xmm1, -0x10(%rbp,%riz)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x8(%rbp), %rdx
               	leaq	-0x18(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	movzbq	(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	movzbq	0x1(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	movzbq	0x2(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	movzbq	0x3(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	movzbq	0x4(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	movzbq	0x5(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	movzbq	0x6(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rcx
               	movzbq	0x7(%rdx), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, 0x7(%rax)
               	movq	%rax, %rcx
               	movsd	(%rcx,%riz), %xmm0
               	leave
               	retq

<vecf_add>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movups	%xmm0, -0x50(%rbp,%riz)
               	movups	%xmm1, -0x40(%rbp,%riz)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
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
               	movq	%rax, %rcx
               	movups	(%rcx,%riz), %xmm0
               	leave
               	retq

<wrap_double>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movups	%xmm0, -0x50(%rbp,%riz)
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x50(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	movzbq	(%rax), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, (%rcx)
               	movzbq	0x1(%rax), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, 0x1(%rcx)
               	movzbq	0x2(%rax), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, 0x2(%rcx)
               	movzbq	0x3(%rax), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, 0x3(%rcx)
               	movzbq	0x4(%rax), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, 0x4(%rcx)
               	movzbq	0x5(%rax), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, 0x5(%rcx)
               	movzbq	0x6(%rax), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, 0x6(%rcx)
               	movzbq	0x7(%rax), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, 0x7(%rcx)
               	movzbq	0x8(%rax), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, 0x8(%rcx)
               	movzbq	0x9(%rax), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, 0x9(%rcx)
               	movzbq	0xa(%rax), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, 0xa(%rcx)
               	movzbq	0xb(%rax), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, 0xb(%rcx)
               	movzbq	0xc(%rax), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, 0xc(%rcx)
               	movzbq	0xd(%rax), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, 0xd(%rcx)
               	movzbq	0xe(%rax), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, 0xe(%rcx)
               	movzbq	0xf(%rax), %rsi
               	leaq	(%rsi,%rsi), %rax
               	movb	%al, 0xf(%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rax
               	movq	%rdx, %rcx
               	movups	(%rcx,%riz), %xmm0
               	leave
               	retq

<nine>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x210, %rsp            # imm = 0x210
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movups	%xmm0, -0x1e0(%rbp,%riz)
               	movups	%xmm1, -0x1d0(%rbp,%riz)
               	movups	%xmm2, -0x1c0(%rbp,%riz)
               	movups	%xmm3, -0x1b0(%rbp,%riz)
               	movups	%xmm4, -0x1a0(%rbp,%riz)
               	movups	%xmm5, -0x190(%rbp,%riz)
               	movups	%xmm6, -0x180(%rbp,%riz)
               	movups	%xmm7, -0x170(%rbp,%riz)
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x160(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x158(%rbp)
               	leaq	-0x1e0(%rbp), %rax
               	leaq	-0x1d0(%rbp), %rcx
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
               	movq	%r10, 0xf8(%rsp)
               	addq	0xf8(%rsp), %r15
               	movzbq	0x9(%rax), %r10
               	movq	%r10, 0xf8(%rsp)
               	movzbq	0x9(%rcx), %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	0xf8(%rsp), %r10
               	addq	0xf0(%rsp), %r10
               	movq	%r10, 0xf8(%rsp)
               	movzbq	0xa(%rax), %r10
               	movq	%r10, 0xf0(%rsp)
               	movzbq	0xa(%rcx), %r10
               	movq	%r10, 0xe8(%rsp)
               	movq	0xf0(%rsp), %r10
               	addq	0xe8(%rsp), %r10
               	movq	%r10, 0xf0(%rsp)
               	movzbq	0xb(%rax), %r10
               	movq	%r10, 0xe8(%rsp)
               	movzbq	0xb(%rcx), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xe8(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0xe8(%rsp)
               	movzbq	0xc(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movzbq	0xc(%rcx), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xe0(%rsp), %r10
               	addq	0xd8(%rsp), %r10
               	movq	%r10, 0xe0(%rsp)
               	movzbq	0xd(%rax), %r10
               	movq	%r10, 0xd8(%rsp)
               	movzbq	0xd(%rcx), %r10
               	movq	%r10, 0xd0(%rsp)
               	movq	0xd8(%rsp), %r10
               	addq	0xd0(%rsp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movzbq	0xe(%rax), %r10
               	movq	%r10, 0xd0(%rsp)
               	movzbq	0xe(%rcx), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xd0(%rsp), %r10
               	addq	0xc8(%rsp), %r10
               	movq	%r10, 0xd0(%rsp)
               	movzbq	0xf(%rax), %rax
               	movzbq	0xf(%rcx), %rcx
               	leaq	(%rax,%rcx), %r10
               	movq	%r10, 0xc8(%rsp)
               	leaq	-0x1c0(%rbp), %rax
               	movq	%rsi, %rdx
               	andq	$0xff, %rdx
               	movzbq	(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	%rdi, %rsi
               	andq	$0xff, %rsi
               	movzbq	0x1(%rax), %rdi
               	addq	%rdi, %rsi
               	movq	%r8, %rdi
               	andq	$0xff, %rdi
               	movzbq	0x2(%rax), %r8
               	addq	%r8, %rdi
               	movq	%r9, %r8
               	andq	$0xff, %r8
               	movzbq	0x3(%rax), %r9
               	addq	%r9, %r8
               	movq	%rbx, %r9
               	andq	$0xff, %r9
               	movzbq	0x4(%rax), %rbx
               	addq	%rbx, %r9
               	movq	%r12, %rbx
               	andq	$0xff, %rbx
               	movzbq	0x5(%rax), %r12
               	addq	%r12, %rbx
               	movq	%r13, %r12
               	andq	$0xff, %r12
               	movzbq	0x6(%rax), %r13
               	addq	%r13, %r12
               	movq	%r14, %r13
               	andq	$0xff, %r13
               	movzbq	0x7(%rax), %r14
               	addq	%r14, %r13
               	movq	%r15, %r14
               	andq	$0xff, %r14
               	movzbq	0x8(%rax), %r15
               	addq	%r15, %r14
               	movq	0xf8(%rsp), %r15
               	andq	$0xff, %r15
               	movzbq	0x9(%rax), %r10
               	movq	%r10, 0xf8(%rsp)
               	addq	0xf8(%rsp), %r15
               	movq	0xf0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf8(%rsp)
               	movzbq	0xa(%rax), %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	0xf8(%rsp), %r10
               	addq	0xf0(%rsp), %r10
               	movq	%r10, 0xf8(%rsp)
               	movq	0xe8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf0(%rsp)
               	movzbq	0xb(%rax), %r10
               	movq	%r10, 0xe8(%rsp)
               	movq	0xf0(%rsp), %r10
               	addq	0xe8(%rsp), %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	0xe0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe8(%rsp)
               	movzbq	0xc(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xe8(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0xe8(%rsp)
               	movq	0xd8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe0(%rsp)
               	movzbq	0xd(%rax), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xe0(%rsp), %r10
               	addq	0xd8(%rsp), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xd0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xd8(%rsp)
               	movzbq	0xe(%rax), %r10
               	movq	%r10, 0xd0(%rsp)
               	movq	0xd8(%rsp), %r10
               	addq	0xd0(%rsp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xc8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xd0(%rsp)
               	movzbq	0xf(%rax), %rax
               	movq	0xd0(%rsp), %r10
               	addq	%rax, %r10
               	movq	%r10, 0xd0(%rsp)
               	leaq	-0x1b0(%rbp), %rax
               	andq	$0xff, %rdx
               	movzbq	(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %rdx
               	andq	$0xff, %rsi
               	movzbq	0x1(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %rsi
               	andq	$0xff, %rdi
               	movzbq	0x2(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %rdi
               	andq	$0xff, %r8
               	movzbq	0x3(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r8
               	andq	$0xff, %r9
               	movzbq	0x4(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r9
               	andq	$0xff, %rbx
               	movzbq	0x5(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %rbx
               	andq	$0xff, %r12
               	movzbq	0x6(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r12
               	andq	$0xff, %r13
               	movzbq	0x7(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r13
               	andq	$0xff, %r14
               	movzbq	0x8(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r14
               	andq	$0xff, %r15
               	movzbq	0x9(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r15
               	movq	0xf8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf8(%rsp)
               	movzbq	0xa(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xf8(%rsp), %r10
               	addq	0xc8(%rsp), %r10
               	movq	%r10, 0xf8(%rsp)
               	movq	0xf0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf0(%rsp)
               	movzbq	0xb(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xf0(%rsp), %r10
               	addq	0xc8(%rsp), %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	0xe8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe8(%rsp)
               	movzbq	0xc(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xe8(%rsp), %r10
               	addq	0xc8(%rsp), %r10
               	movq	%r10, 0xe8(%rsp)
               	movq	0xe0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe0(%rsp)
               	movzbq	0xd(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xe0(%rsp), %r10
               	addq	0xc8(%rsp), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xd8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xd8(%rsp)
               	movzbq	0xe(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xd8(%rsp), %r10
               	addq	0xc8(%rsp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xd0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xd0(%rsp)
               	movzbq	0xf(%rax), %rax
               	movq	0xd0(%rsp), %r10
               	addq	%rax, %r10
               	movq	%r10, 0xd0(%rsp)
               	leaq	-0x1a0(%rbp), %rax
               	andq	$0xff, %rdx
               	movzbq	(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %rdx
               	andq	$0xff, %rsi
               	movzbq	0x1(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %rsi
               	andq	$0xff, %rdi
               	movzbq	0x2(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %rdi
               	andq	$0xff, %r8
               	movzbq	0x3(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r8
               	andq	$0xff, %r9
               	movzbq	0x4(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r9
               	andq	$0xff, %rbx
               	movzbq	0x5(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %rbx
               	andq	$0xff, %r12
               	movzbq	0x6(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r12
               	andq	$0xff, %r13
               	movzbq	0x7(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r13
               	andq	$0xff, %r14
               	movzbq	0x8(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r14
               	andq	$0xff, %r15
               	movzbq	0x9(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r15
               	movq	0xf8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf8(%rsp)
               	movzbq	0xa(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xf8(%rsp), %r10
               	addq	0xc8(%rsp), %r10
               	movq	%r10, 0xf8(%rsp)
               	movq	0xf0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf0(%rsp)
               	movzbq	0xb(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xf0(%rsp), %r10
               	addq	0xc8(%rsp), %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	0xe8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe8(%rsp)
               	movzbq	0xc(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xe8(%rsp), %r10
               	addq	0xc8(%rsp), %r10
               	movq	%r10, 0xe8(%rsp)
               	movq	0xe0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe0(%rsp)
               	movzbq	0xd(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xe0(%rsp), %r10
               	addq	0xc8(%rsp), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xd8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xd8(%rsp)
               	movzbq	0xe(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xd8(%rsp), %r10
               	addq	0xc8(%rsp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xd0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xd0(%rsp)
               	movzbq	0xf(%rax), %rax
               	movq	0xd0(%rsp), %r10
               	addq	%rax, %r10
               	movq	%r10, 0xd0(%rsp)
               	leaq	-0x190(%rbp), %rax
               	andq	$0xff, %rdx
               	movzbq	(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %rdx
               	andq	$0xff, %rsi
               	movzbq	0x1(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %rsi
               	andq	$0xff, %rdi
               	movzbq	0x2(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %rdi
               	andq	$0xff, %r8
               	movzbq	0x3(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r8
               	andq	$0xff, %r9
               	movzbq	0x4(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r9
               	andq	$0xff, %rbx
               	movzbq	0x5(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %rbx
               	andq	$0xff, %r12
               	movzbq	0x6(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r12
               	andq	$0xff, %r13
               	movzbq	0x7(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r13
               	andq	$0xff, %r14
               	movzbq	0x8(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r14
               	andq	$0xff, %r15
               	movzbq	0x9(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r15
               	movq	0xf8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf8(%rsp)
               	movzbq	0xa(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xf8(%rsp), %r10
               	addq	0xc8(%rsp), %r10
               	movq	%r10, 0xf8(%rsp)
               	movq	0xf0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf0(%rsp)
               	movzbq	0xb(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xf0(%rsp), %r10
               	addq	0xc8(%rsp), %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	0xe8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe8(%rsp)
               	movzbq	0xc(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xe8(%rsp), %r10
               	addq	0xc8(%rsp), %r10
               	movq	%r10, 0xe8(%rsp)
               	movq	0xe0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe0(%rsp)
               	movzbq	0xd(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xe0(%rsp), %r10
               	addq	0xc8(%rsp), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xd8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xd8(%rsp)
               	movzbq	0xe(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xd8(%rsp), %r10
               	addq	0xc8(%rsp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xd0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xd0(%rsp)
               	movzbq	0xf(%rax), %rax
               	movq	0xd0(%rsp), %r10
               	addq	%rax, %r10
               	movq	%r10, 0xd0(%rsp)
               	leaq	-0x180(%rbp), %rax
               	andq	$0xff, %rdx
               	movzbq	(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %rdx
               	andq	$0xff, %rsi
               	movzbq	0x1(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %rsi
               	andq	$0xff, %rdi
               	movzbq	0x2(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %rdi
               	andq	$0xff, %r8
               	movzbq	0x3(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r8
               	andq	$0xff, %r9
               	movzbq	0x4(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r9
               	andq	$0xff, %rbx
               	movzbq	0x5(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %rbx
               	andq	$0xff, %r12
               	movzbq	0x6(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r12
               	andq	$0xff, %r13
               	movzbq	0x7(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r13
               	andq	$0xff, %r14
               	movzbq	0x8(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r14
               	andq	$0xff, %r15
               	movzbq	0x9(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r15
               	movq	0xf8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf8(%rsp)
               	movzbq	0xa(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xf8(%rsp), %r10
               	addq	0xc8(%rsp), %r10
               	movq	%r10, 0xf8(%rsp)
               	movq	0xf0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf0(%rsp)
               	movzbq	0xb(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xf0(%rsp), %r10
               	addq	0xc8(%rsp), %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	0xe8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe8(%rsp)
               	movzbq	0xc(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xe8(%rsp), %r10
               	addq	0xc8(%rsp), %r10
               	movq	%r10, 0xe8(%rsp)
               	movq	0xe0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe0(%rsp)
               	movzbq	0xd(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xe0(%rsp), %r10
               	addq	0xc8(%rsp), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xd8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xd8(%rsp)
               	movzbq	0xe(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xd8(%rsp), %r10
               	addq	0xc8(%rsp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xd0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xd0(%rsp)
               	movzbq	0xf(%rax), %rax
               	movq	0xd0(%rsp), %r10
               	addq	%rax, %r10
               	movq	%r10, 0xd0(%rsp)
               	leaq	-0x170(%rbp), %rax
               	andq	$0xff, %rdx
               	movzbq	(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %rdx
               	andq	$0xff, %rsi
               	movzbq	0x1(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %rsi
               	andq	$0xff, %rdi
               	movzbq	0x2(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %rdi
               	andq	$0xff, %r8
               	movzbq	0x3(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r8
               	andq	$0xff, %r9
               	movzbq	0x4(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r9
               	andq	$0xff, %rbx
               	movzbq	0x5(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %rbx
               	andq	$0xff, %r12
               	movzbq	0x6(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r12
               	andq	$0xff, %r13
               	movzbq	0x7(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r13
               	andq	$0xff, %r14
               	movzbq	0x8(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r14
               	andq	$0xff, %r15
               	movzbq	0x9(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %r15
               	movq	0xf8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf8(%rsp)
               	movzbq	0xa(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xf8(%rsp), %r10
               	addq	0xc8(%rsp), %r10
               	movq	%r10, 0xf8(%rsp)
               	movq	0xf0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf0(%rsp)
               	movzbq	0xb(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xf0(%rsp), %r10
               	addq	0xc8(%rsp), %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	0xe8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe8(%rsp)
               	movzbq	0xc(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xe8(%rsp), %r10
               	addq	0xc8(%rsp), %r10
               	movq	%r10, 0xe8(%rsp)
               	movq	0xe0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe0(%rsp)
               	movzbq	0xd(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xe0(%rsp), %r10
               	addq	0xc8(%rsp), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xd8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xd8(%rsp)
               	movzbq	0xe(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xd8(%rsp), %r10
               	addq	0xc8(%rsp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xd0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xd0(%rsp)
               	movzbq	0xf(%rax), %rax
               	movq	0xd0(%rsp), %r10
               	addq	%rax, %r10
               	movq	%r10, 0xd0(%rsp)
               	leaq	-0x160(%rbp), %rcx
               	leaq	-0x110(%rbp), %rax
               	andq	$0xff, %rdx
               	movzbq	(%rcx), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	0xc8(%rsp), %rdx
               	movb	%dl, (%rax)
               	movq	%rsi, %rdx
               	andq	$0xff, %rdx
               	movzbq	0x1(%rcx), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x1(%rax)
               	movq	%rdi, %rdx
               	andq	$0xff, %rdx
               	movzbq	0x2(%rcx), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x2(%rax)
               	movq	%r8, %rdx
               	andq	$0xff, %rdx
               	movzbq	0x3(%rcx), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x3(%rax)
               	movq	%r9, %rdx
               	andq	$0xff, %rdx
               	movzbq	0x4(%rcx), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x4(%rax)
               	movq	%rbx, %rdx
               	andq	$0xff, %rdx
               	movzbq	0x5(%rcx), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x5(%rax)
               	movq	%r12, %rdx
               	andq	$0xff, %rdx
               	movzbq	0x6(%rcx), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x6(%rax)
               	movq	%r13, %rdx
               	andq	$0xff, %rdx
               	movzbq	0x7(%rcx), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x7(%rax)
               	movq	%r14, %rdx
               	andq	$0xff, %rdx
               	movzbq	0x8(%rcx), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x8(%rax)
               	movq	%r15, %rdx
               	andq	$0xff, %rdx
               	movzbq	0x9(%rcx), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x9(%rax)
               	movq	0xf8(%rsp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xa(%rcx), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0xa(%rax)
               	movq	0xf0(%rsp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xb(%rcx), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0xb(%rax)
               	movq	0xe8(%rsp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xc(%rcx), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0xc(%rax)
               	movq	0xe0(%rsp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xd(%rcx), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0xd(%rax)
               	movq	0xd8(%rsp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xe(%rcx), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0xe(%rax)
               	movq	0xd0(%rsp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xf(%rcx), %rcx
               	addq	%rdx, %rcx
               	movb	%cl, 0xf(%rax)
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	movups	(%rcx,%riz), %xmm0
               	leave
               	retq

<mixed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movups	%xmm0, -0x40(%rbp,%riz)
               	movups	%xmm2, -0x30(%rbp,%riz)
               	movapd	%xmm1, %xmm0
               	movapd	%xmm3, %xmm1
               	leaq	-0x40(%rbp), %rax
               	movzbq	(%rax), %rax
               	leaq	-0x30(%rbp), %rcx
               	movzbq	(%rcx), %rcx
               	subq	%rcx, %rax
               	movslq	%eax, %rax
               	xorps	%xmm2, %xmm2
               	cvtsi2sd	%rax, %xmm2
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	leave
               	retq

<wide_sub>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x90(%rbp)
               	movq	%rsi, -0x80(%rbp)
               	movq	%rdx, -0x70(%rbp)
               	leaq	(%rsp), %rax
               	movq	-0x80(%rbp), %rcx
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
               	movq	%rax, %rcx
               	leaq	0x20(%rsp), %rcx
               	movq	-0x70(%rbp), %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	movq	0x10(%rdx), %rax
               	movq	%rax, 0x10(%rcx)
               	movq	0x18(%rdx), %rax
               	movq	%rax, 0x18(%rcx)
               	popq	%rax
               	movq	%rcx, %rdx
               	movq	-0x90(%rbp), %rsi
               	leaq	-0x60(%rbp), %rdx
               	movzbq	(%rcx), %rdi
               	movzbq	(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, (%rdx)
               	movzbq	0x1(%rcx), %rdi
               	movzbq	0x1(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x1(%rdx)
               	movzbq	0x2(%rcx), %rdi
               	movzbq	0x2(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x2(%rdx)
               	movzbq	0x3(%rcx), %rdi
               	movzbq	0x3(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x3(%rdx)
               	movzbq	0x4(%rcx), %rdi
               	movzbq	0x4(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x4(%rdx)
               	movzbq	0x5(%rcx), %rdi
               	movzbq	0x5(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x5(%rdx)
               	movzbq	0x6(%rcx), %rdi
               	movzbq	0x6(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x6(%rdx)
               	movzbq	0x7(%rcx), %rdi
               	movzbq	0x7(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x7(%rdx)
               	movzbq	0x8(%rcx), %rdi
               	movzbq	0x8(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x8(%rdx)
               	movzbq	0x9(%rcx), %rdi
               	movzbq	0x9(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x9(%rdx)
               	movzbq	0xa(%rcx), %rdi
               	movzbq	0xa(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0xa(%rdx)
               	movzbq	0xb(%rcx), %rdi
               	movzbq	0xb(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0xb(%rdx)
               	movzbq	0xc(%rcx), %rdi
               	movzbq	0xc(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0xc(%rdx)
               	movzbq	0xd(%rcx), %rdi
               	movzbq	0xd(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0xd(%rdx)
               	movzbq	0xe(%rcx), %rdi
               	movzbq	0xe(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0xe(%rdx)
               	movzbq	0xf(%rcx), %rdi
               	movzbq	0xf(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0xf(%rdx)
               	movzbq	0x10(%rcx), %rdi
               	movzbq	0x10(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x10(%rdx)
               	movzbq	0x11(%rcx), %rdi
               	movzbq	0x11(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x11(%rdx)
               	movzbq	0x12(%rcx), %rdi
               	movzbq	0x12(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x12(%rdx)
               	movzbq	0x13(%rcx), %rdi
               	movzbq	0x13(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x13(%rdx)
               	movzbq	0x14(%rcx), %rdi
               	movzbq	0x14(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x14(%rdx)
               	movzbq	0x15(%rcx), %rdi
               	movzbq	0x15(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x15(%rdx)
               	movzbq	0x16(%rcx), %rdi
               	movzbq	0x16(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x16(%rdx)
               	movzbq	0x17(%rcx), %rdi
               	movzbq	0x17(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x17(%rdx)
               	movzbq	0x18(%rcx), %rdi
               	movzbq	0x18(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x18(%rdx)
               	movzbq	0x19(%rcx), %rdi
               	movzbq	0x19(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x19(%rdx)
               	movzbq	0x1a(%rcx), %rdi
               	movzbq	0x1a(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x1a(%rdx)
               	movzbq	0x1b(%rcx), %rdi
               	movzbq	0x1b(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x1b(%rdx)
               	movzbq	0x1c(%rcx), %rdi
               	movzbq	0x1c(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x1c(%rdx)
               	movzbq	0x1d(%rcx), %rdi
               	movzbq	0x1d(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x1d(%rdx)
               	movzbq	0x1e(%rcx), %rdi
               	movzbq	0x1e(%rax), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x1e(%rdx)
               	movzbq	0x1f(%rcx), %rcx
               	movzbq	0x1f(%rax), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	movb	%al, 0x1f(%rdx)
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
               	movq	%rsi, %rax
               	leaq	-0x90(%rbp), %rsp
               	movq	%rsi, %rax
               	leave
               	retq

<ramp>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rax
               	leaq	(%rax), %rsi
               	movq	%rdi, %rcx
               	andq	$0xff, %rcx
               	leaq	(%rcx), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi)
               	leaq	0x1(%rcx), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x1(%rax)
               	leaq	0x2(%rcx), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x2(%rax)
               	leaq	0x3(%rcx), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x3(%rax)
               	leaq	-0x20(%rbp), %rax
               	addq	$0x4, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x4(%rax)
               	movq	%rdi, %rcx
               	andq	$0xff, %rcx
               	leaq	0x5(%rcx), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x5(%rax)
               	leaq	0x6(%rcx), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x6(%rax)
               	leaq	0x7(%rcx), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x7(%rax)
               	leaq	0x8(%rcx), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x8(%rax)
               	leaq	-0x20(%rbp), %rax
               	addq	$0x9, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x9(%rax)
               	movq	%rdi, %rcx
               	andq	$0xff, %rcx
               	leaq	0xa(%rcx), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0xa(%rax)
               	leaq	0xb(%rcx), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0xb(%rax)
               	leaq	0xc(%rcx), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0xc(%rax)
               	leaq	0xd(%rcx), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0xd(%rax)
               	leaq	-0x20(%rbp), %rax
               	addq	$0xe, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0xe(%rax)
               	movq	%rdi, %rcx
               	andq	$0xff, %rcx
               	addq	$0xf, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0xf(%rax)
               	movq	%rax, %rcx
               	movups	(%rcx,%riz), %xmm0
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x330, %rsp            # imm = 0x330
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	subq	$0x120, %rsp            # imm = 0x120
               	andq	$-0x20, %rsp
               	movl	$0x1, %edi
               	callq	<addr>
               	movups	%xmm0, -0x1e8(%rbp,%riz)
               	leaq	-0x1e8(%rbp), %rax
               	leaq	0x60(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movl	$0x64, %edi
               	callq	<addr>
               	movups	%xmm0, -0x1f8(%rbp,%riz)
               	leaq	-0x1f8(%rbp), %rax
               	leaq	0x70(%rsp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	0x60(%rsp), %rdi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %r10
               	movups	(%r10,%riz), %xmm1
               	callq	<addr>
               	movups	%xmm0, -0x208(%rbp,%riz)
               	leaq	-0x208(%rbp), %rcx
               	leaq	0x80(%rsp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	(%rax), %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x63, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0x330(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movzbq	0x1(%rax), %rcx
               	xorq	$0x63, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x2(%rax), %rcx
               	xorq	$0x63, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x3(%rax), %rcx
               	xorq	$0x63, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x4(%rax), %rcx
               	xorq	$0x63, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x5(%rax), %rax
               	xorq	$0x63, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x80(%rsp), %rax
               	movzbq	0x6(%rax), %rcx
               	xorq	$0x63, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x7(%rax), %rcx
               	xorq	$0x63, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x8(%rax), %rcx
               	xorq	$0x63, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x9(%rax), %rcx
               	xorq	$0x63, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xa(%rax), %rcx
               	xorq	$0x63, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xb(%rax), %rcx
               	xorq	$0x63, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xc(%rax), %rcx
               	xorq	$0x63, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xd(%rax), %rax
               	xorq	$0x63, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x80(%rsp), %rax
               	movzbq	0xe(%rax), %rcx
               	xorq	$0x63, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	xorq	$0x63, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x70(%rbp), %rax
               	leaq	(%rax), %rcx
               	movl	$0x1, %edx
               	movb	%dl, (%rcx)
               	leaq	-0x78(%rbp), %rcx
               	leaq	(%rcx), %rdx
               	movl	$0x28, %esi
               	movb	%sil, (%rdx)
               	movl	$0x2, %edx
               	movb	%dl, 0x1(%rax)
               	movl	$0x29, %edx
               	movb	%dl, 0x1(%rcx)
               	movl	$0x3, %edx
               	movb	%dl, 0x2(%rax)
               	movl	$0x2a, %edx
               	movb	%dl, 0x2(%rcx)
               	movl	$0x4, %edx
               	movb	%dl, 0x3(%rax)
               	movl	$0x2b, %eax
               	movb	%al, 0x3(%rcx)
               	leaq	-0x70(%rbp), %rax
               	movl	$0x5, %ecx
               	movb	%cl, 0x4(%rax)
               	leaq	-0x78(%rbp), %rcx
               	movl	$0x2c, %edx
               	movb	%dl, 0x4(%rcx)
               	movl	$0x6, %edx
               	movb	%dl, 0x5(%rax)
               	movl	$0x2d, %edx
               	movb	%dl, 0x5(%rcx)
               	movl	$0x7, %edx
               	movb	%dl, 0x6(%rax)
               	movl	$0x2e, %edx
               	movb	%dl, 0x6(%rcx)
               	movl	$0x8, %edx
               	movb	%dl, 0x7(%rax)
               	movl	$0x2f, %eax
               	movb	%al, 0x7(%rcx)
               	leaq	-0x70(%rbp), %rdi
               	leaq	-0x78(%rbp), %rsi
               	movq	%rdi, %r10
               	movsd	(%r10,%riz), %xmm0
               	movq	%rsi, %r10
               	movsd	(%r10,%riz), %xmm1
               	callq	<addr>
               	movsd	%xmm0, -0x210(%rbp,%riz)
               	leaq	-0x210(%rbp), %rax
               	movzbq	(%rax), %rcx
               	movzbq	0x1(%rax), %rdx
               	movzbq	0x2(%rax), %rsi
               	movzbq	0x3(%rax), %rdi
               	movzbq	0x4(%rax), %r8
               	movzbq	0x5(%rax), %r9
               	movzbq	0x6(%rax), %rbx
               	movzbq	0x7(%rax), %r12
               	movq	%rcx, %rax
               	andq	$0xff, %rax
               	xorq	$0x27, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leaq	-0x330(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movq	%rdx, %rax
               	andq	$0xff, %rax
               	xorq	$0x27, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rsi, %rax
               	andq	$0xff, %rax
               	xorq	$0x27, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	xorq	$0x27, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	xorq	$0x27, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%r9, %rax
               	andq	$0xff, %rax
               	xorq	$0x27, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	xorq	$0x27, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%r12, %rax
               	andq	$0xff, %rax
               	xorq	$0x27, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x90(%rsp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	leaq	0xa0(%rsp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %r10
               	movups	(%r10,%riz), %xmm1
               	callq	<addr>
               	movups	%xmm0, -0x220(%rbp,%riz)
               	leaq	-0x220(%rbp), %rcx
               	leaq	0xb0(%rsp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	movss	(%rax,%riz), %xmm0
               	movl	$0x41300000, %ecx       # imm = 0x41300000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x4(%rax,%riz), %xmm0
               	movl	$0x41b00000, %ecx       # imm = 0x41B00000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movss	0x8(%rax,%riz), %xmm0
               	movl	$0x42040000, %ecx       # imm = 0x42040000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movss	0xc(%rax,%riz), %xmm0
               	movl	$0x42300000, %eax       # imm = 0x42300000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leaq	-0x330(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	0xc0(%rsp), %rbx
               	movl	$0x2, %edi
               	callq	<addr>
               	movups	%xmm0, -0x248(%rbp,%riz)
               	leaq	-0x248(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	0xc0(%rsp), %rdi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	movups	%xmm0, -0x258(%rbp,%riz)
               	leaq	-0x258(%rbp), %rax
               	leaq	0xd0(%rsp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdi
               	leaq	0x2(%rcx), %rdx
               	shlq	%rdx
               	andq	$0xff, %rdx
               	cmpl	%edx, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	movups	%xmm0, -0x268(%rbp,%riz)
               	leaq	-0x268(%rbp), %rax
               	leaq	0xe0(%rsp), %rdi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	leaq	0xe0(%rsp), %rax
               	leaq	0xe0(%rsp), %rcx
               	leaq	0xe0(%rsp), %rdx
               	subq	$0x10, %rsp
               	movq	%rdx, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm1
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm2
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm3
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm4
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm5
               	movq	%rax, %r10
               	movups	(%r10,%riz), %xmm6
               	movq	%rcx, %r10
               	movups	(%r10,%riz), %xmm7
               	callq	<addr>
               	addq	$0x10, %rsp
               	movups	%xmm0, -0x278(%rbp,%riz)
               	leaq	-0x278(%rbp), %rax
               	leaq	0xf0(%rsp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdi
               	leaq	0x1(%rcx), %rdx
               	leaq	(%rdx,%rdx,8), %rdx
               	andq	$0xff, %rdx
               	cmpl	%edx, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x32, %edi
               	callq	<addr>
               	movups	%xmm0, -0x288(%rbp,%riz)
               	leaq	-0x288(%rbp), %r12
               	movabsq	$0x4008000000000000, %rbx # imm = 0x4008000000000000
               	movl	$0xa, %edi
               	callq	<addr>
               	movups	%xmm0, -0x298(%rbp,%riz)
               	leaq	-0x298(%rbp), %rcx
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movzbq	(%r12), %rdx
               	movzbq	(%rcx), %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movslq	%ecx, %rcx
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rcx, %xmm0
               	movq	%rbx, %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movabsq	$0x404a000000000000, %rax # imm = 0x404A000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	leaq	-0x330(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rsp), %rdx
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	0x1(%rcx), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi)
               	leaq	0x20(%rsp), %rdx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	0x46(%rcx), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	-0x2b8(%rbp), %rdi
               	leaq	(%rsp), %rsi
               	leaq	0x20(%rsp), %rdx
               	callq	<addr>
               	leaq	-0x2b8(%rbp), %rax
               	leaq	0x40(%rsp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rsi)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	xorq	$0x45, %rdx
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	leaq	-0x330(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x7, %eax
               	leaq	-0x330(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x5, %eax
               	leaq	-0x330(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x4, %eax
               	leaq	-0x330(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
