
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
               	subq	$0x30, %rsp
               	movups	%xmm0, -0x30(%rbp)
               	movups	%xmm1, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x10(%rbp), %rax
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
               	movups	(%rcx), %xmm0
               	leave
               	retq

<vec8_sub>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movsd	%xmm0, -0x8(%rbp)
               	movsd	%xmm1, -0x10(%rbp)
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
               	movsd	(%rcx), %xmm0
               	leave
               	retq

<vecf_add>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movups	%xmm0, -0x30(%rbp)
               	movups	%xmm1, -0x20(%rbp)
               	leaq	-0x30(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x10(%rbp), %rax
               	movss	(%rcx), %xmm0
               	movss	(%rdx), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, (%rax)
               	movss	0x4(%rcx), %xmm0
               	movss	0x4(%rdx), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rax)
               	movss	0x8(%rcx), %xmm0
               	movss	0x8(%rdx), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rax)
               	movss	0xc(%rcx), %xmm0
               	movss	0xc(%rdx), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rax)
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<wrap_double>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movups	%xmm0, -0x30(%rbp)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	movzbq	(%rdx), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, (%rcx)
               	movzbq	0x1(%rdx), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, 0x1(%rcx)
               	movzbq	0x2(%rdx), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, 0x2(%rcx)
               	movzbq	0x3(%rdx), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, 0x3(%rcx)
               	movzbq	0x4(%rdx), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, 0x4(%rcx)
               	movzbq	0x5(%rdx), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, 0x5(%rcx)
               	movzbq	0x6(%rdx), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, 0x6(%rcx)
               	movzbq	0x7(%rdx), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, 0x7(%rcx)
               	movzbq	0x8(%rdx), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, 0xb(%rcx)
               	movzbq	0xc(%rdx), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, 0xc(%rcx)
               	movzbq	0xd(%rdx), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, 0xd(%rcx)
               	movzbq	0xe(%rdx), %rsi
               	addq	%rsi, %rsi
               	movb	%sil, 0xe(%rcx)
               	movzbq	0xf(%rdx), %rdx
               	addq	%rdx, %rdx
               	movb	%dl, 0xf(%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<nine>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movups	%xmm0, -0xe0(%rbp)
               	movups	%xmm1, -0xd0(%rbp)
               	movups	%xmm2, -0xc0(%rbp)
               	movups	%xmm3, -0xb0(%rbp)
               	movups	%xmm4, -0xa0(%rbp)
               	movups	%xmm5, -0x90(%rbp)
               	movups	%xmm6, -0x80(%rbp)
               	movups	%xmm7, -0x70(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x60(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x58(%rbp)
               	leaq	-0xe0(%rbp), %rax
               	leaq	-0xd0(%rbp), %rcx
               	movzbq	(%rax), %rdx
               	movzbq	(%rcx), %rsi
               	addq	%rsi, %rdx
               	movzbq	0x1(%rax), %rsi
               	movzbq	0x1(%rcx), %rdi
               	addq	%rdi, %rsi
               	movzbq	0x2(%rax), %rdi
               	movzbq	0x2(%rcx), %r8
               	addq	%r8, %rdi
               	movzbq	0x3(%rax), %r8
               	movzbq	0x3(%rcx), %r9
               	addq	%r9, %r8
               	movzbq	0x4(%rax), %r9
               	movzbq	0x4(%rcx), %rbx
               	addq	%rbx, %r9
               	movzbq	0x5(%rax), %rbx
               	movzbq	0x5(%rcx), %r12
               	addq	%r12, %rbx
               	movzbq	0x6(%rax), %r12
               	movzbq	0x6(%rcx), %r13
               	addq	%r13, %r12
               	movzbq	0x7(%rax), %r13
               	movzbq	0x7(%rcx), %r14
               	addq	%r14, %r13
               	movzbq	0x8(%rax), %r14
               	movzbq	0x8(%rcx), %r15
               	addq	%r15, %r14
               	movzbq	0x9(%rax), %r15
               	movzbq	0x9(%rcx), %r10
               	movq	%r10, 0x108(%rsp)
               	addq	0x108(%rsp), %r15
               	movzbq	0xa(%rax), %r10
               	movq	%r10, 0x108(%rsp)
               	movzbq	0xa(%rcx), %r10
               	movq	%r10, 0x100(%rsp)
               	movq	0x108(%rsp), %r10
               	addq	0x100(%rsp), %r10
               	movq	%r10, 0x108(%rsp)
               	movzbq	0xb(%rax), %r10
               	movq	%r10, 0x100(%rsp)
               	movzbq	0xb(%rcx), %r10
               	movq	%r10, 0xf8(%rsp)
               	movq	0x100(%rsp), %r10
               	addq	0xf8(%rsp), %r10
               	movq	%r10, 0x100(%rsp)
               	movzbq	0xc(%rax), %r10
               	movq	%r10, 0xf8(%rsp)
               	movzbq	0xc(%rcx), %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	0xf8(%rsp), %r10
               	addq	0xf0(%rsp), %r10
               	movq	%r10, 0xf8(%rsp)
               	movzbq	0xd(%rax), %r10
               	movq	%r10, 0xf0(%rsp)
               	movzbq	0xd(%rcx), %r10
               	movq	%r10, 0xe8(%rsp)
               	movq	0xf0(%rsp), %r10
               	addq	0xe8(%rsp), %r10
               	movq	%r10, 0xf0(%rsp)
               	movzbq	0xe(%rax), %r10
               	movq	%r10, 0xe8(%rsp)
               	movzbq	0xe(%rcx), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xe8(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0xe8(%rsp)
               	movzbq	0xf(%rax), %rax
               	movzbq	0xf(%rcx), %rcx
               	addq	%rax, %rcx
               	leaq	-0xc0(%rbp), %rax
               	andq	$0xff, %rdx
               	movzbq	(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %rdx
               	andq	$0xff, %rsi
               	movzbq	0x1(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %rsi
               	andq	$0xff, %rdi
               	movzbq	0x2(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %rdi
               	andq	$0xff, %r8
               	movzbq	0x3(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r8
               	andq	$0xff, %r9
               	movzbq	0x4(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r9
               	andq	$0xff, %rbx
               	movzbq	0x5(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %rbx
               	andq	$0xff, %r12
               	movzbq	0x6(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r12
               	andq	$0xff, %r13
               	movzbq	0x7(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r13
               	andq	$0xff, %r14
               	movzbq	0x8(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r14
               	andq	$0xff, %r15
               	movzbq	0x9(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r15
               	movq	0x108(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x108(%rsp)
               	movzbq	0xa(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0x108(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0x108(%rsp)
               	movq	0x100(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x100(%rsp)
               	movzbq	0xb(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0x100(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0x100(%rsp)
               	movq	0xf8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf8(%rsp)
               	movzbq	0xc(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xf8(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0xf8(%rsp)
               	movq	0xf0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf0(%rsp)
               	movzbq	0xd(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xf0(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	0xe8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe8(%rsp)
               	movzbq	0xe(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xe8(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0xe8(%rsp)
               	andq	$0xff, %rcx
               	movzbq	0xf(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0xb0(%rbp), %rax
               	andq	$0xff, %rdx
               	movzbq	(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %rdx
               	andq	$0xff, %rsi
               	movzbq	0x1(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %rsi
               	andq	$0xff, %rdi
               	movzbq	0x2(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %rdi
               	andq	$0xff, %r8
               	movzbq	0x3(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r8
               	andq	$0xff, %r9
               	movzbq	0x4(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r9
               	andq	$0xff, %rbx
               	movzbq	0x5(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %rbx
               	andq	$0xff, %r12
               	movzbq	0x6(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r12
               	andq	$0xff, %r13
               	movzbq	0x7(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r13
               	andq	$0xff, %r14
               	movzbq	0x8(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r14
               	andq	$0xff, %r15
               	movzbq	0x9(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r15
               	movq	0x108(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x108(%rsp)
               	movzbq	0xa(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0x108(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0x108(%rsp)
               	movq	0x100(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x100(%rsp)
               	movzbq	0xb(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0x100(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0x100(%rsp)
               	movq	0xf8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf8(%rsp)
               	movzbq	0xc(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xf8(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0xf8(%rsp)
               	movq	0xf0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf0(%rsp)
               	movzbq	0xd(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xf0(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	0xe8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe8(%rsp)
               	movzbq	0xe(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xe8(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0xe8(%rsp)
               	andq	$0xff, %rcx
               	movzbq	0xf(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0xa0(%rbp), %rax
               	andq	$0xff, %rdx
               	movzbq	(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %rdx
               	andq	$0xff, %rsi
               	movzbq	0x1(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %rsi
               	andq	$0xff, %rdi
               	movzbq	0x2(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %rdi
               	andq	$0xff, %r8
               	movzbq	0x3(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r8
               	andq	$0xff, %r9
               	movzbq	0x4(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r9
               	andq	$0xff, %rbx
               	movzbq	0x5(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %rbx
               	andq	$0xff, %r12
               	movzbq	0x6(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r12
               	andq	$0xff, %r13
               	movzbq	0x7(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r13
               	andq	$0xff, %r14
               	movzbq	0x8(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r14
               	andq	$0xff, %r15
               	movzbq	0x9(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r15
               	movq	0x108(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x108(%rsp)
               	movzbq	0xa(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0x108(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0x108(%rsp)
               	movq	0x100(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x100(%rsp)
               	movzbq	0xb(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0x100(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0x100(%rsp)
               	movq	0xf8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf8(%rsp)
               	movzbq	0xc(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xf8(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0xf8(%rsp)
               	movq	0xf0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf0(%rsp)
               	movzbq	0xd(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xf0(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	0xe8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe8(%rsp)
               	movzbq	0xe(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xe8(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0xe8(%rsp)
               	andq	$0xff, %rcx
               	movzbq	0xf(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x90(%rbp), %rax
               	andq	$0xff, %rdx
               	movzbq	(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %rdx
               	andq	$0xff, %rsi
               	movzbq	0x1(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %rsi
               	andq	$0xff, %rdi
               	movzbq	0x2(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %rdi
               	andq	$0xff, %r8
               	movzbq	0x3(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r8
               	andq	$0xff, %r9
               	movzbq	0x4(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r9
               	andq	$0xff, %rbx
               	movzbq	0x5(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %rbx
               	andq	$0xff, %r12
               	movzbq	0x6(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r12
               	andq	$0xff, %r13
               	movzbq	0x7(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r13
               	andq	$0xff, %r14
               	movzbq	0x8(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r14
               	andq	$0xff, %r15
               	movzbq	0x9(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r15
               	movq	0x108(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x108(%rsp)
               	movzbq	0xa(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0x108(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0x108(%rsp)
               	movq	0x100(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x100(%rsp)
               	movzbq	0xb(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0x100(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0x100(%rsp)
               	movq	0xf8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf8(%rsp)
               	movzbq	0xc(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xf8(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0xf8(%rsp)
               	movq	0xf0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf0(%rsp)
               	movzbq	0xd(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xf0(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	0xe8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe8(%rsp)
               	movzbq	0xe(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xe8(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0xe8(%rsp)
               	andq	$0xff, %rcx
               	movzbq	0xf(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x80(%rbp), %rax
               	andq	$0xff, %rdx
               	movzbq	(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %rdx
               	andq	$0xff, %rsi
               	movzbq	0x1(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %rsi
               	andq	$0xff, %rdi
               	movzbq	0x2(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %rdi
               	andq	$0xff, %r8
               	movzbq	0x3(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r8
               	andq	$0xff, %r9
               	movzbq	0x4(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r9
               	andq	$0xff, %rbx
               	movzbq	0x5(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %rbx
               	andq	$0xff, %r12
               	movzbq	0x6(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r12
               	andq	$0xff, %r13
               	movzbq	0x7(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r13
               	andq	$0xff, %r14
               	movzbq	0x8(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r14
               	andq	$0xff, %r15
               	movzbq	0x9(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r15
               	movq	0x108(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x108(%rsp)
               	movzbq	0xa(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0x108(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0x108(%rsp)
               	movq	0x100(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x100(%rsp)
               	movzbq	0xb(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0x100(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0x100(%rsp)
               	movq	0xf8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf8(%rsp)
               	movzbq	0xc(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xf8(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0xf8(%rsp)
               	movq	0xf0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf0(%rsp)
               	movzbq	0xd(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xf0(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	0xe8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe8(%rsp)
               	movzbq	0xe(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xe8(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0xe8(%rsp)
               	andq	$0xff, %rcx
               	movzbq	0xf(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x70(%rbp), %rax
               	andq	$0xff, %rdx
               	movzbq	(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %rdx
               	andq	$0xff, %rsi
               	movzbq	0x1(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %rsi
               	andq	$0xff, %rdi
               	movzbq	0x2(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %rdi
               	andq	$0xff, %r8
               	movzbq	0x3(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r8
               	andq	$0xff, %r9
               	movzbq	0x4(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r9
               	andq	$0xff, %rbx
               	movzbq	0x5(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %rbx
               	andq	$0xff, %r12
               	movzbq	0x6(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r12
               	andq	$0xff, %r13
               	movzbq	0x7(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r13
               	andq	$0xff, %r14
               	movzbq	0x8(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r14
               	andq	$0xff, %r15
               	movzbq	0x9(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	0xe0(%rsp), %r15
               	movq	0x108(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x108(%rsp)
               	movzbq	0xa(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0x108(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0x108(%rsp)
               	movq	0x100(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x100(%rsp)
               	movzbq	0xb(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0x100(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0x100(%rsp)
               	movq	0xf8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf8(%rsp)
               	movzbq	0xc(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xf8(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0xf8(%rsp)
               	movq	0xf0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf0(%rsp)
               	movzbq	0xd(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xf0(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	0xe8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe8(%rsp)
               	movzbq	0xe(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xe8(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0xe8(%rsp)
               	andq	$0xff, %rcx
               	movzbq	0xf(%rax), %rax
               	leaq	(%rcx,%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	leaq	-0x60(%rbp), %rcx
               	leaq	-0x50(%rbp), %rax
               	andq	$0xff, %rdx
               	movzbq	(%rcx), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rdx
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
               	movq	0x108(%rsp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xa(%rcx), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0xa(%rax)
               	movq	0x100(%rsp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xb(%rcx), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0xb(%rax)
               	movq	0xf8(%rsp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xc(%rcx), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0xc(%rax)
               	movq	0xf0(%rsp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xd(%rcx), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0xd(%rax)
               	movq	0xe8(%rsp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xe(%rcx), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0xe(%rax)
               	movq	0xe0(%rsp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xf(%rcx), %rcx
               	addq	%rdx, %rcx
               	movb	%cl, 0xf(%rax)
               	movq	%rax, %rcx
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	movups	(%rcx), %xmm0
               	leave
               	retq

<mixed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movups	%xmm0, -0x20(%rbp)
               	movups	%xmm2, -0x10(%rbp)
               	movzbq	-0x20(%rbp), %rax
               	movzbq	-0x10(%rbp), %rcx
               	subq	%rcx, %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movapd	%xmm1, %xmm14
               	movapd	%xmm3, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	leave
               	retq

<wide_sub>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rax
               	leaq	0x20(%rsp), %rdx
               	leaq	(%rsp), %rsi
               	leaq	0x40(%rsp), %rcx
               	movzbq	(%rdx), %rdi
               	movzbq	(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, (%rcx)
               	movzbq	0x1(%rdx), %rdi
               	movzbq	0x1(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x1(%rcx)
               	movzbq	0x2(%rdx), %rdi
               	movzbq	0x2(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x2(%rcx)
               	movzbq	0x3(%rdx), %rdi
               	movzbq	0x3(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x3(%rcx)
               	movzbq	0x4(%rdx), %rdi
               	movzbq	0x4(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x4(%rcx)
               	movzbq	0x5(%rdx), %rdi
               	movzbq	0x5(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x5(%rcx)
               	movzbq	0x6(%rdx), %rdi
               	movzbq	0x6(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x6(%rcx)
               	movzbq	0x7(%rdx), %rdi
               	movzbq	0x7(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x7(%rcx)
               	movzbq	0x8(%rdx), %rdi
               	movzbq	0x8(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rdi
               	movzbq	0x9(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rdi
               	movzbq	0xa(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rdi
               	movzbq	0xb(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0xb(%rcx)
               	movzbq	0xc(%rdx), %rdi
               	movzbq	0xc(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0xc(%rcx)
               	movzbq	0xd(%rdx), %rdi
               	movzbq	0xd(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0xd(%rcx)
               	movzbq	0xe(%rdx), %rdi
               	movzbq	0xe(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0xe(%rcx)
               	movzbq	0xf(%rdx), %rdi
               	movzbq	0xf(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0xf(%rcx)
               	movzbq	0x10(%rdx), %rdi
               	movzbq	0x10(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x10(%rcx)
               	movzbq	0x11(%rdx), %rdi
               	movzbq	0x11(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x11(%rcx)
               	movzbq	0x12(%rdx), %rdi
               	movzbq	0x12(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x12(%rcx)
               	movzbq	0x13(%rdx), %rdi
               	movzbq	0x13(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x13(%rcx)
               	movzbq	0x14(%rdx), %rdi
               	movzbq	0x14(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x14(%rcx)
               	movzbq	0x15(%rdx), %rdi
               	movzbq	0x15(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x15(%rcx)
               	movzbq	0x16(%rdx), %rdi
               	movzbq	0x16(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x16(%rcx)
               	movzbq	0x17(%rdx), %rdi
               	movzbq	0x17(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x17(%rcx)
               	movzbq	0x18(%rdx), %rdi
               	movzbq	0x18(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x18(%rcx)
               	movzbq	0x19(%rdx), %rdi
               	movzbq	0x19(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x19(%rcx)
               	movzbq	0x1a(%rdx), %rdi
               	movzbq	0x1a(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x1a(%rcx)
               	movzbq	0x1b(%rdx), %rdi
               	movzbq	0x1b(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x1b(%rcx)
               	movzbq	0x1c(%rdx), %rdi
               	movzbq	0x1c(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x1c(%rcx)
               	movzbq	0x1d(%rdx), %rdi
               	movzbq	0x1d(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x1d(%rcx)
               	movzbq	0x1e(%rdx), %rdi
               	movzbq	0x1e(%rsi), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x1e(%rcx)
               	movzbq	0x1f(%rdx), %rdx
               	movzbq	0x1f(%rsi), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x1f(%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq

<ramp>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rcx
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	movb	%al, (%rcx)
               	leaq	0x1(%rax), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x1(%rcx)
               	leaq	0x2(%rax), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x2(%rcx)
               	leaq	0x3(%rax), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x3(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	addq	$0x4, %rax
               	andq	$0xff, %rax
               	movb	%al, 0x4(%rcx)
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	leaq	0x5(%rax), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x5(%rcx)
               	leaq	0x6(%rax), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x6(%rcx)
               	leaq	0x7(%rax), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x7(%rcx)
               	leaq	0x8(%rax), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x8(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	addq	$0x9, %rax
               	andq	$0xff, %rax
               	movb	%al, 0x9(%rcx)
               	movq	%rdi, %rdx
               	andq	$0xff, %rdx
               	leaq	0xa(%rdx), %rax
               	andq	$0xff, %rax
               	movb	%al, 0xa(%rcx)
               	leaq	0xb(%rdx), %rax
               	andq	$0xff, %rax
               	movb	%al, 0xb(%rcx)
               	leaq	0xc(%rdx), %rax
               	andq	$0xff, %rax
               	movb	%al, 0xc(%rcx)
               	leaq	0xd(%rdx), %rax
               	andq	$0xff, %rax
               	movb	%al, 0xd(%rcx)
               	leaq	-0x10(%rbp), %rax
               	leaq	0xe(%rdx), %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0xe(%rax)
               	movq	%rdi, %rcx
               	andq	$0xff, %rcx
               	addq	$0xf, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0xf(%rax)
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movl	$0x1, %edi
               	callq	<addr>
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x20(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0x64, %edi
               	callq	<addr>
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x20(%rsp), %rax
               	leaq	(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	0x60(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x20(%rsp), %rcx
               	leaq	(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movzbq	(%rax), %rcx
               	xorq	$0x63, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	movzbq	0x1(%rax), %rcx
               	xorq	$0x63, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x2(%rax), %rcx
               	xorq	$0x63, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x3(%rax), %rcx
               	xorq	$0x63, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x4(%rax), %rcx
               	xorq	$0x63, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x5(%rax), %rax
               	xorq	$0x63, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	(%rsp), %rax
               	movzbq	0x6(%rax), %rcx
               	xorq	$0x63, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x7(%rax), %rcx
               	xorq	$0x63, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x8(%rax), %rcx
               	xorq	$0x63, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x9(%rax), %rcx
               	xorq	$0x63, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0xa(%rax), %rcx
               	xorq	$0x63, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0xb(%rax), %rcx
               	xorq	$0x63, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0xc(%rax), %rcx
               	xorq	$0x63, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0xd(%rax), %rax
               	xorq	$0x63, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	(%rsp), %rax
               	movzbq	0xe(%rax), %rcx
               	xorq	$0x63, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	xorq	$0x63, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movb	$0x27, (%rax)
               	movb	$0x27, 0x1(%rax)
               	movb	$0x27, 0x2(%rax)
               	movb	$0x27, 0x3(%rax)
               	movb	$0x27, 0x4(%rax)
               	movb	$0x27, 0x5(%rax)
               	movb	$0x27, 0x6(%rax)
               	movb	$0x27, 0x7(%rax)
               	movq	(%rax), %rcx
               	leaq	-0x8(%rbp), %rax
               	movq	%rcx, (%rax)
               	movzbq	(%rax), %rcx
               	xorq	$0x27, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	movzbq	0x1(%rax), %rcx
               	xorq	$0x27, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x2(%rax), %rcx
               	xorq	$0x27, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x3(%rax), %rcx
               	xorq	$0x27, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x4(%rax), %rcx
               	xorq	$0x27, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x5(%rax), %rax
               	xorq	$0x27, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movzbq	0x6(%rax), %rcx
               	xorq	$0x27, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x7(%rax), %rax
               	xorq	$0x27, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	(%rsp), %rcx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rdx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x60(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	(%rsp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rdx
               	movss	(%rax), %xmm0
               	movss	(%rcx), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx)
               	movss	0x4(%rax), %xmm0
               	movss	0x4(%rcx), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx)
               	movss	0x8(%rax), %xmm0
               	movss	0x8(%rcx), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx)
               	movss	0xc(%rax), %xmm0
               	movss	0xc(%rcx), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx)
               	movups	(%rdx), %xmm0
               	leaq	0x20(%rsp), %rax
               	movups	%xmm0, (%rax)
               	movss	(%rax), %xmm0
               	movl	$0x41300000, %ecx       # imm = 0x41300000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x4(%rax), %xmm0
               	movl	$0x41b00000, %ecx       # imm = 0x41B00000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x8(%rax), %xmm0
               	movl	$0x42040000, %ecx       # imm = 0x42040000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0xc(%rax), %xmm0
               	movl	$0x42300000, %eax       # imm = 0x42300000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x20(%rsp), %rax
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x20(%rsp), %rcx
               	leaq	(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movzbq	(%rax), %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	movzbq	0x1(%rax), %rcx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movzbq	0x2(%rax), %rcx
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	movzbq	0x3(%rax), %rcx
               	cmpl	$0xa, %ecx
               	jne	<addr>
               	movzbq	0x4(%rax), %rcx
               	cmpl	$0xc, %ecx
               	jne	<addr>
               	movzbq	0x5(%rax), %rax
               	cmpl	$0xe, %eax
               	jne	<addr>
               	leaq	(%rsp), %rax
               	movzbq	0x6(%rax), %rcx
               	cmpl	$0x10, %ecx
               	jne	<addr>
               	movzbq	0x7(%rax), %rcx
               	cmpl	$0x12, %ecx
               	jne	<addr>
               	movzbq	0x8(%rax), %rcx
               	cmpl	$0x14, %ecx
               	jne	<addr>
               	movzbq	0x9(%rax), %rcx
               	cmpl	$0x16, %ecx
               	jne	<addr>
               	movzbq	0xa(%rax), %rcx
               	cmpl	$0x18, %ecx
               	jne	<addr>
               	movzbq	0xb(%rax), %rcx
               	cmpl	$0x1a, %ecx
               	jne	<addr>
               	movzbq	0xc(%rax), %rcx
               	cmpl	$0x1c, %ecx
               	jne	<addr>
               	movzbq	0xd(%rax), %rax
               	cmpl	$0x1e, %eax
               	jne	<addr>
               	leaq	(%rsp), %rax
               	movzbq	0xe(%rax), %rcx
               	cmpl	$0x20, %ecx
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	cmpl	$0x22, %eax
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x20(%rsp), %rax
               	leaq	(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	(%rsp), %rax
               	leaq	(%rsp), %rcx
               	leaq	(%rsp), %rdx
               	subq	$0x10, %rsp
               	movq	%rdx, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	movq	%r9, %r10
               	movups	(%r10), %xmm2
               	movq	%r9, %r10
               	movups	(%r10), %xmm3
               	movq	%r9, %r10
               	movups	(%r10), %xmm4
               	movq	%r9, %r10
               	movups	(%r10), %xmm5
               	movq	%rax, %r10
               	movups	(%r10), %xmm6
               	movq	%rcx, %r10
               	movups	(%r10), %xmm7
               	callq	<addr>
               	addq	$0x10, %rsp
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x20(%rsp), %rax
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	leaq	0x1(%rax), %rsi
               	leaq	(%rsi,%rsi,8), %rsi
               	andq	$0xff, %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x32, %edi
               	callq	<addr>
               	movups	%xmm0, (%rsp)
               	movl	$0xa, %edi
               	callq	<addr>
               	movups	%xmm0, 0x20(%rsp)
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movzbq	(%rsp), %rcx
               	movzbq	0x20(%rsp), %rdx
               	subq	%rdx, %rcx
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rcx, %xmm0
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movabsq	$0x404a000000000000, %rax # imm = 0x404A000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	(%rsp), %rdx
               	leaq	0x1(%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	leaq	0x20(%rsp), %rdx
               	leaq	0x46(%rax), %rsi
               	movb	%sil, (%rdx,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x40(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	xorq	$0x45, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	movl	$0x7, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	movl	$0x5, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
