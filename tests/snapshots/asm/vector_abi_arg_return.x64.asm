
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
               	leaq	-0x10(%rbp), %rax
               	movzbq	-0x20(%rbp), %rcx
               	movzbq	-0x30(%rbp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x1f(%rbp), %rcx
               	movzbq	-0x2f(%rbp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, -0xf(%rbp)
               	movzbq	-0x1e(%rbp), %rcx
               	movzbq	-0x2e(%rbp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, -0xe(%rbp)
               	movzbq	-0x1d(%rbp), %rcx
               	movzbq	-0x2d(%rbp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, -0xd(%rbp)
               	movzbq	-0x1c(%rbp), %rcx
               	movzbq	-0x2c(%rbp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, -0xc(%rbp)
               	movzbq	-0x1b(%rbp), %rcx
               	movzbq	-0x2b(%rbp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, -0xb(%rbp)
               	movzbq	-0x1a(%rbp), %rcx
               	movzbq	-0x2a(%rbp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, -0xa(%rbp)
               	movzbq	-0x19(%rbp), %rcx
               	movzbq	-0x29(%rbp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, -0x9(%rbp)
               	movzbq	-0x18(%rbp), %rcx
               	movzbq	-0x28(%rbp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x17(%rbp), %rcx
               	movzbq	-0x27(%rbp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, -0x7(%rbp)
               	movzbq	-0x16(%rbp), %rcx
               	movzbq	-0x26(%rbp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, -0x6(%rbp)
               	movzbq	-0x15(%rbp), %rcx
               	movzbq	-0x25(%rbp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, -0x5(%rbp)
               	movzbq	-0x14(%rbp), %rcx
               	movzbq	-0x24(%rbp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, -0x4(%rbp)
               	movzbq	-0x13(%rbp), %rcx
               	movzbq	-0x23(%rbp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, -0x3(%rbp)
               	movzbq	-0x12(%rbp), %rcx
               	movzbq	-0x22(%rbp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, -0x2(%rbp)
               	movzbq	-0x11(%rbp), %rcx
               	movzbq	-0x21(%rbp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, -0x1(%rbp)
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
               	leaq	-0x18(%rbp), %rax
               	movzbq	-0x10(%rbp), %rcx
               	movzbq	-0x8(%rbp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, -0x18(%rbp)
               	movzbq	-0xf(%rbp), %rcx
               	movzbq	-0x7(%rbp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, -0x17(%rbp)
               	movzbq	-0xe(%rbp), %rcx
               	movzbq	-0x6(%rbp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, -0x16(%rbp)
               	movzbq	-0xd(%rbp), %rcx
               	movzbq	-0x5(%rbp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, -0x15(%rbp)
               	movzbq	-0xc(%rbp), %rcx
               	movzbq	-0x4(%rbp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, -0x14(%rbp)
               	movzbq	-0xb(%rbp), %rcx
               	movzbq	-0x3(%rbp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, -0x13(%rbp)
               	movzbq	-0xa(%rbp), %rcx
               	movzbq	-0x2(%rbp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, -0x12(%rbp)
               	movzbq	-0x9(%rbp), %rcx
               	movzbq	-0x1(%rbp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, -0x11(%rbp)
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
               	leaq	-0x10(%rbp), %rax
               	movss	-0x30(%rbp), %xmm0
               	movss	-0x20(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movss	-0x2c(%rbp), %xmm0
               	movss	-0x1c(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0xc(%rbp)
               	movss	-0x28(%rbp), %xmm0
               	movss	-0x18(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movss	-0x24(%rbp), %xmm0
               	movss	-0x14(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x4(%rbp)
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
               	leaq	-0x10(%rbp), %rdx
               	movzbq	-0x30(%rbp), %rcx
               	addq	%rcx, %rcx
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x2f(%rbp), %rcx
               	addq	%rcx, %rcx
               	movb	%cl, -0xf(%rbp)
               	movzbq	-0x2e(%rbp), %rcx
               	addq	%rcx, %rcx
               	movb	%cl, -0xe(%rbp)
               	movzbq	-0x2d(%rbp), %rcx
               	addq	%rcx, %rcx
               	movb	%cl, -0xd(%rbp)
               	movzbq	-0x2c(%rbp), %rcx
               	addq	%rcx, %rcx
               	movb	%cl, -0xc(%rbp)
               	movzbq	-0x2b(%rbp), %rcx
               	addq	%rcx, %rcx
               	movb	%cl, -0xb(%rbp)
               	movzbq	-0x2a(%rbp), %rcx
               	addq	%rcx, %rcx
               	movb	%cl, -0xa(%rbp)
               	movzbq	-0x29(%rbp), %rcx
               	addq	%rcx, %rcx
               	movb	%cl, -0x9(%rbp)
               	movzbq	-0x28(%rbp), %rcx
               	addq	%rcx, %rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x27(%rbp), %rcx
               	addq	%rcx, %rcx
               	movb	%cl, -0x7(%rbp)
               	movzbq	-0x26(%rbp), %rcx
               	addq	%rcx, %rcx
               	movb	%cl, -0x6(%rbp)
               	movzbq	-0x25(%rbp), %rcx
               	addq	%rcx, %rcx
               	movb	%cl, -0x5(%rbp)
               	movzbq	-0x24(%rbp), %rcx
               	addq	%rcx, %rcx
               	movb	%cl, -0x4(%rbp)
               	movzbq	-0x23(%rbp), %rcx
               	addq	%rcx, %rcx
               	movb	%cl, -0x3(%rbp)
               	movzbq	-0x22(%rbp), %rcx
               	addq	%rcx, %rcx
               	movb	%cl, -0x2(%rbp)
               	movzbq	-0x21(%rbp), %rcx
               	addq	%rcx, %rcx
               	movb	%cl, -0x1(%rbp)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<nine>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movups	%xmm0, -0xd0(%rbp)
               	movups	%xmm1, -0xc0(%rbp)
               	movups	%xmm2, -0xb0(%rbp)
               	movups	%xmm3, -0xa0(%rbp)
               	movups	%xmm4, -0x90(%rbp)
               	movups	%xmm5, -0x80(%rbp)
               	movups	%xmm6, -0x70(%rbp)
               	movups	%xmm7, -0x60(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x50(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x48(%rbp)
               	movzbq	-0xd0(%rbp), %rax
               	movzbq	-0xc0(%rbp), %rcx
               	addq	%rcx, %rax
               	movzbq	-0xcf(%rbp), %rcx
               	movzbq	-0xbf(%rbp), %rdx
               	addq	%rdx, %rcx
               	movzbq	-0xce(%rbp), %rdx
               	movzbq	-0xbe(%rbp), %rsi
               	addq	%rsi, %rdx
               	movzbq	-0xcd(%rbp), %rsi
               	movzbq	-0xbd(%rbp), %rdi
               	addq	%rdi, %rsi
               	movzbq	-0xcc(%rbp), %rdi
               	movzbq	-0xbc(%rbp), %r8
               	addq	%r8, %rdi
               	movzbq	-0xcb(%rbp), %r8
               	movzbq	-0xbb(%rbp), %r9
               	addq	%r9, %r8
               	movzbq	-0xca(%rbp), %r9
               	movzbq	-0xba(%rbp), %rbx
               	addq	%rbx, %r9
               	movzbq	-0xc9(%rbp), %rbx
               	movzbq	-0xb9(%rbp), %r12
               	addq	%r12, %rbx
               	movzbq	-0xc8(%rbp), %r12
               	movzbq	-0xb8(%rbp), %r13
               	addq	%r13, %r12
               	movzbq	-0xc7(%rbp), %r13
               	movzbq	-0xb7(%rbp), %r14
               	addq	%r14, %r13
               	movzbq	-0xc6(%rbp), %r14
               	movzbq	-0xb6(%rbp), %r15
               	addq	%r15, %r14
               	movzbq	-0xc5(%rbp), %r15
               	movzbq	-0xb5(%rbp), %r10
               	movq	%r10, 0xf8(%rsp)
               	addq	0xf8(%rsp), %r15
               	movzbq	-0xc4(%rbp), %r10
               	movq	%r10, 0xf8(%rsp)
               	movzbq	-0xb4(%rbp), %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	0xf8(%rsp), %r10
               	addq	0xf0(%rsp), %r10
               	movq	%r10, 0xf8(%rsp)
               	movzbq	-0xc3(%rbp), %r10
               	movq	%r10, 0xf0(%rsp)
               	movzbq	-0xb3(%rbp), %r10
               	movq	%r10, 0xe8(%rsp)
               	movq	0xf0(%rsp), %r10
               	addq	0xe8(%rsp), %r10
               	movq	%r10, 0xf0(%rsp)
               	movzbq	-0xc2(%rbp), %r10
               	movq	%r10, 0xe8(%rsp)
               	movzbq	-0xb2(%rbp), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xe8(%rsp), %r10
               	addq	0xe0(%rsp), %r10
               	movq	%r10, 0xe8(%rsp)
               	movzbq	-0xc1(%rbp), %r10
               	movq	%r10, 0xe0(%rsp)
               	movzbq	-0xb1(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xe0(%rsp), %r10
               	addq	0xd8(%rsp), %r10
               	movq	%r10, 0xe0(%rsp)
               	andq	$0xff, %rax
               	movzbq	-0xb0(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rax
               	andq	$0xff, %rcx
               	movzbq	-0xaf(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rcx
               	andq	$0xff, %rdx
               	movzbq	-0xae(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rdx
               	andq	$0xff, %rsi
               	movzbq	-0xad(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rsi
               	andq	$0xff, %rdi
               	movzbq	-0xac(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rdi
               	andq	$0xff, %r8
               	movzbq	-0xab(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r8
               	andq	$0xff, %r9
               	movzbq	-0xaa(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r9
               	andq	$0xff, %rbx
               	movzbq	-0xa9(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rbx
               	andq	$0xff, %r12
               	movzbq	-0xa8(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r12
               	andq	$0xff, %r13
               	movzbq	-0xa7(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r13
               	andq	$0xff, %r14
               	movzbq	-0xa6(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r14
               	andq	$0xff, %r15
               	movzbq	-0xa5(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r15
               	movq	0xf8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf8(%rsp)
               	movzbq	-0xa4(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xf8(%rsp), %r10
               	addq	0xd8(%rsp), %r10
               	movq	%r10, 0xf8(%rsp)
               	movq	0xf0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf0(%rsp)
               	movzbq	-0xa3(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xf0(%rsp), %r10
               	addq	0xd8(%rsp), %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	0xe8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe8(%rsp)
               	movzbq	-0xa2(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xe8(%rsp), %r10
               	addq	0xd8(%rsp), %r10
               	movq	%r10, 0xe8(%rsp)
               	movq	0xe0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe0(%rsp)
               	movzbq	-0xa1(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xe0(%rsp), %r10
               	addq	0xd8(%rsp), %r10
               	movq	%r10, 0xe0(%rsp)
               	andq	$0xff, %rax
               	movzbq	-0xa0(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rax
               	andq	$0xff, %rcx
               	movzbq	-0x9f(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rcx
               	andq	$0xff, %rdx
               	movzbq	-0x9e(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rdx
               	andq	$0xff, %rsi
               	movzbq	-0x9d(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rsi
               	andq	$0xff, %rdi
               	movzbq	-0x9c(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rdi
               	andq	$0xff, %r8
               	movzbq	-0x9b(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r8
               	andq	$0xff, %r9
               	movzbq	-0x9a(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r9
               	andq	$0xff, %rbx
               	movzbq	-0x99(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rbx
               	andq	$0xff, %r12
               	movzbq	-0x98(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r12
               	andq	$0xff, %r13
               	movzbq	-0x97(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r13
               	andq	$0xff, %r14
               	movzbq	-0x96(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r14
               	andq	$0xff, %r15
               	movzbq	-0x95(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r15
               	movq	0xf8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf8(%rsp)
               	movzbq	-0x94(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xf8(%rsp), %r10
               	addq	0xd8(%rsp), %r10
               	movq	%r10, 0xf8(%rsp)
               	movq	0xf0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf0(%rsp)
               	movzbq	-0x93(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xf0(%rsp), %r10
               	addq	0xd8(%rsp), %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	0xe8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe8(%rsp)
               	movzbq	-0x92(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xe8(%rsp), %r10
               	addq	0xd8(%rsp), %r10
               	movq	%r10, 0xe8(%rsp)
               	movq	0xe0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe0(%rsp)
               	movzbq	-0x91(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xe0(%rsp), %r10
               	addq	0xd8(%rsp), %r10
               	movq	%r10, 0xe0(%rsp)
               	andq	$0xff, %rax
               	movzbq	-0x90(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rax
               	andq	$0xff, %rcx
               	movzbq	-0x8f(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rcx
               	andq	$0xff, %rdx
               	movzbq	-0x8e(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rdx
               	andq	$0xff, %rsi
               	movzbq	-0x8d(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rsi
               	andq	$0xff, %rdi
               	movzbq	-0x8c(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rdi
               	andq	$0xff, %r8
               	movzbq	-0x8b(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r8
               	andq	$0xff, %r9
               	movzbq	-0x8a(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r9
               	andq	$0xff, %rbx
               	movzbq	-0x89(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rbx
               	andq	$0xff, %r12
               	movzbq	-0x88(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r12
               	andq	$0xff, %r13
               	movzbq	-0x87(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r13
               	andq	$0xff, %r14
               	movzbq	-0x86(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r14
               	andq	$0xff, %r15
               	movzbq	-0x85(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r15
               	movq	0xf8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf8(%rsp)
               	movzbq	-0x84(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xf8(%rsp), %r10
               	addq	0xd8(%rsp), %r10
               	movq	%r10, 0xf8(%rsp)
               	movq	0xf0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf0(%rsp)
               	movzbq	-0x83(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xf0(%rsp), %r10
               	addq	0xd8(%rsp), %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	0xe8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe8(%rsp)
               	movzbq	-0x82(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xe8(%rsp), %r10
               	addq	0xd8(%rsp), %r10
               	movq	%r10, 0xe8(%rsp)
               	movq	0xe0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe0(%rsp)
               	movzbq	-0x81(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xe0(%rsp), %r10
               	addq	0xd8(%rsp), %r10
               	movq	%r10, 0xe0(%rsp)
               	andq	$0xff, %rax
               	movzbq	-0x80(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rax
               	andq	$0xff, %rcx
               	movzbq	-0x7f(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rcx
               	andq	$0xff, %rdx
               	movzbq	-0x7e(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rdx
               	andq	$0xff, %rsi
               	movzbq	-0x7d(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rsi
               	andq	$0xff, %rdi
               	movzbq	-0x7c(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rdi
               	andq	$0xff, %r8
               	movzbq	-0x7b(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r8
               	andq	$0xff, %r9
               	movzbq	-0x7a(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r9
               	andq	$0xff, %rbx
               	movzbq	-0x79(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rbx
               	andq	$0xff, %r12
               	movzbq	-0x78(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r12
               	andq	$0xff, %r13
               	movzbq	-0x77(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r13
               	andq	$0xff, %r14
               	movzbq	-0x76(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r14
               	andq	$0xff, %r15
               	movzbq	-0x75(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r15
               	movq	0xf8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf8(%rsp)
               	movzbq	-0x74(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xf8(%rsp), %r10
               	addq	0xd8(%rsp), %r10
               	movq	%r10, 0xf8(%rsp)
               	movq	0xf0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf0(%rsp)
               	movzbq	-0x73(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xf0(%rsp), %r10
               	addq	0xd8(%rsp), %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	0xe8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe8(%rsp)
               	movzbq	-0x72(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xe8(%rsp), %r10
               	addq	0xd8(%rsp), %r10
               	movq	%r10, 0xe8(%rsp)
               	movq	0xe0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe0(%rsp)
               	movzbq	-0x71(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xe0(%rsp), %r10
               	addq	0xd8(%rsp), %r10
               	movq	%r10, 0xe0(%rsp)
               	andq	$0xff, %rax
               	movzbq	-0x70(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rax
               	andq	$0xff, %rcx
               	movzbq	-0x6f(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rcx
               	andq	$0xff, %rdx
               	movzbq	-0x6e(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rdx
               	andq	$0xff, %rsi
               	movzbq	-0x6d(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rsi
               	andq	$0xff, %rdi
               	movzbq	-0x6c(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rdi
               	andq	$0xff, %r8
               	movzbq	-0x6b(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r8
               	andq	$0xff, %r9
               	movzbq	-0x6a(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r9
               	andq	$0xff, %rbx
               	movzbq	-0x69(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rbx
               	andq	$0xff, %r12
               	movzbq	-0x68(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r12
               	andq	$0xff, %r13
               	movzbq	-0x67(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r13
               	andq	$0xff, %r14
               	movzbq	-0x66(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r14
               	andq	$0xff, %r15
               	movzbq	-0x65(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r15
               	movq	0xf8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf8(%rsp)
               	movzbq	-0x64(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xf8(%rsp), %r10
               	addq	0xd8(%rsp), %r10
               	movq	%r10, 0xf8(%rsp)
               	movq	0xf0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf0(%rsp)
               	movzbq	-0x63(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xf0(%rsp), %r10
               	addq	0xd8(%rsp), %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	0xe8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe8(%rsp)
               	movzbq	-0x62(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xe8(%rsp), %r10
               	addq	0xd8(%rsp), %r10
               	movq	%r10, 0xe8(%rsp)
               	movq	0xe0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe0(%rsp)
               	movzbq	-0x61(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xe0(%rsp), %r10
               	addq	0xd8(%rsp), %r10
               	movq	%r10, 0xe0(%rsp)
               	andq	$0xff, %rax
               	movzbq	-0x60(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rax
               	andq	$0xff, %rcx
               	movzbq	-0x5f(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rcx
               	andq	$0xff, %rdx
               	movzbq	-0x5e(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rdx
               	andq	$0xff, %rsi
               	movzbq	-0x5d(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rsi
               	andq	$0xff, %rdi
               	movzbq	-0x5c(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rdi
               	andq	$0xff, %r8
               	movzbq	-0x5b(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r8
               	andq	$0xff, %r9
               	movzbq	-0x5a(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r9
               	andq	$0xff, %rbx
               	movzbq	-0x59(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %rbx
               	andq	$0xff, %r12
               	movzbq	-0x58(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r12
               	andq	$0xff, %r13
               	movzbq	-0x57(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r13
               	andq	$0xff, %r14
               	movzbq	-0x56(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r14
               	andq	$0xff, %r15
               	movzbq	-0x55(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	addq	0xd8(%rsp), %r15
               	movq	0xf8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf8(%rsp)
               	movzbq	-0x54(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xf8(%rsp), %r10
               	addq	0xd8(%rsp), %r10
               	movq	%r10, 0xf8(%rsp)
               	movq	0xf0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xf0(%rsp)
               	movzbq	-0x53(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xf0(%rsp), %r10
               	addq	0xd8(%rsp), %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	0xe8(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe8(%rsp)
               	movzbq	-0x52(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xe8(%rsp), %r10
               	addq	0xd8(%rsp), %r10
               	movq	%r10, 0xe8(%rsp)
               	movq	0xe0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xe0(%rsp)
               	movzbq	-0x51(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xe0(%rsp), %r10
               	addq	0xd8(%rsp), %r10
               	movq	%r10, 0xe0(%rsp)
               	leaq	-0x40(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	andq	$0xff, %rax
               	movzbq	-0x50(%rbp), %r10
               	movq	%r10, 0xd0(%rsp)
               	addq	0xd0(%rsp), %rax
               	movb	%al, -0x40(%rbp)
               	movq	%rcx, %rax
               	andq	$0xff, %rax
               	movzbq	-0x4f(%rbp), %rcx
               	addq	%rcx, %rax
               	movb	%al, -0x3f(%rbp)
               	movq	%rdx, %rax
               	andq	$0xff, %rax
               	movzbq	-0x4e(%rbp), %rcx
               	addq	%rcx, %rax
               	movb	%al, -0x3e(%rbp)
               	movq	%rsi, %rax
               	andq	$0xff, %rax
               	movzbq	-0x4d(%rbp), %rcx
               	addq	%rcx, %rax
               	movb	%al, -0x3d(%rbp)
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	movzbq	-0x4c(%rbp), %rcx
               	addq	%rcx, %rax
               	movb	%al, -0x3c(%rbp)
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	movzbq	-0x4b(%rbp), %rcx
               	addq	%rcx, %rax
               	movb	%al, -0x3b(%rbp)
               	movq	%r9, %rax
               	andq	$0xff, %rax
               	movzbq	-0x4a(%rbp), %rcx
               	addq	%rcx, %rax
               	movb	%al, -0x3a(%rbp)
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	movzbq	-0x49(%rbp), %rcx
               	addq	%rcx, %rax
               	movb	%al, -0x39(%rbp)
               	movq	%r12, %rax
               	andq	$0xff, %rax
               	movzbq	-0x48(%rbp), %rcx
               	addq	%rcx, %rax
               	movb	%al, -0x38(%rbp)
               	movq	%r13, %rax
               	andq	$0xff, %rax
               	movzbq	-0x47(%rbp), %rcx
               	addq	%rcx, %rax
               	movb	%al, -0x37(%rbp)
               	movq	%r14, %rax
               	andq	$0xff, %rax
               	movzbq	-0x46(%rbp), %rcx
               	addq	%rcx, %rax
               	movb	%al, -0x36(%rbp)
               	movq	%r15, %rax
               	andq	$0xff, %rax
               	movzbq	-0x45(%rbp), %rcx
               	addq	%rcx, %rax
               	movb	%al, -0x35(%rbp)
               	movq	0xf8(%rsp), %rax
               	andq	$0xff, %rax
               	movzbq	-0x44(%rbp), %rcx
               	addq	%rcx, %rax
               	movb	%al, -0x34(%rbp)
               	movq	0xf0(%rsp), %rax
               	andq	$0xff, %rax
               	movzbq	-0x43(%rbp), %rcx
               	addq	%rcx, %rax
               	movb	%al, -0x33(%rbp)
               	movq	0xe8(%rsp), %rax
               	andq	$0xff, %rax
               	movzbq	-0x42(%rbp), %rcx
               	addq	%rcx, %rax
               	movb	%al, -0x32(%rbp)
               	movq	0xe0(%rsp), %rax
               	andq	$0xff, %rax
               	movzbq	-0x41(%rbp), %rcx
               	addq	%rcx, %rax
               	movb	%al, -0x31(%rbp)
               	movq	0xd8(%rsp), %rcx
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
               	vfmadd231sd	%xmm3, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm3) + xmm0
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
               	leaq	0x40(%rsp), %rcx
               	movzbq	0x20(%rsp), %rdx
               	movzbq	(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x21(%rsp), %rdx
               	movzbq	0x1(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x22(%rsp), %rdx
               	movzbq	0x2(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x23(%rsp), %rdx
               	movzbq	0x3(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x24(%rsp), %rdx
               	movzbq	0x4(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x25(%rsp), %rdx
               	movzbq	0x5(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x26(%rsp), %rdx
               	movzbq	0x6(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x27(%rsp), %rdx
               	movzbq	0x7(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x28(%rsp), %rdx
               	movzbq	0x8(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x29(%rsp), %rdx
               	movzbq	0x9(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x49(%rsp)
               	movzbq	0x2a(%rsp), %rdx
               	movzbq	0xa(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0x2b(%rsp), %rdx
               	movzbq	0xb(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0x2c(%rsp), %rdx
               	movzbq	0xc(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0x2d(%rsp), %rdx
               	movzbq	0xd(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0x2e(%rsp), %rdx
               	movzbq	0xe(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0x2f(%rsp), %rdx
               	movzbq	0xf(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x4f(%rsp)
               	movzbq	0x30(%rsp), %rdx
               	movzbq	0x10(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x50(%rsp)
               	movzbq	0x31(%rsp), %rdx
               	movzbq	0x11(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x51(%rsp)
               	movzbq	0x32(%rsp), %rdx
               	movzbq	0x12(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x52(%rsp)
               	movzbq	0x33(%rsp), %rdx
               	movzbq	0x13(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x53(%rsp)
               	movzbq	0x34(%rsp), %rdx
               	movzbq	0x14(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x54(%rsp)
               	movzbq	0x35(%rsp), %rdx
               	movzbq	0x15(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x55(%rsp)
               	movzbq	0x36(%rsp), %rdx
               	movzbq	0x16(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x56(%rsp)
               	movzbq	0x37(%rsp), %rdx
               	movzbq	0x17(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x57(%rsp)
               	movzbq	0x38(%rsp), %rdx
               	movzbq	0x18(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x58(%rsp)
               	movzbq	0x39(%rsp), %rdx
               	movzbq	0x19(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x59(%rsp)
               	movzbq	0x3a(%rsp), %rdx
               	movzbq	0x1a(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x5a(%rsp)
               	movzbq	0x3b(%rsp), %rdx
               	movzbq	0x1b(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x5b(%rsp)
               	movzbq	0x3c(%rsp), %rdx
               	movzbq	0x1c(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x5c(%rsp)
               	movzbq	0x3d(%rsp), %rdx
               	movzbq	0x1d(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x5d(%rsp)
               	movzbq	0x3e(%rsp), %rdx
               	movzbq	0x1e(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x5e(%rsp)
               	movzbq	0x3f(%rsp), %rdx
               	movzbq	0x1f(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x5f(%rsp)
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
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x10(%rbp)
               	leaq	0x1(%rax), %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0xf(%rbp)
               	leaq	0x2(%rax), %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0xe(%rbp)
               	leaq	0x3(%rax), %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0xd(%rbp)
               	addq	$0x4, %rax
               	andq	$0xff, %rax
               	movb	%al, -0xc(%rbp)
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	leaq	0x5(%rax), %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0xb(%rbp)
               	leaq	0x6(%rax), %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0xa(%rbp)
               	leaq	0x7(%rax), %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x9(%rbp)
               	leaq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x8(%rbp)
               	addq	$0x9, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x7(%rbp)
               	movq	%rdi, %rcx
               	andq	$0xff, %rcx
               	leaq	0xa(%rcx), %rax
               	andq	$0xff, %rax
               	movb	%al, -0x6(%rbp)
               	leaq	0xb(%rcx), %rax
               	andq	$0xff, %rax
               	movb	%al, -0x5(%rbp)
               	leaq	0xc(%rcx), %rax
               	andq	$0xff, %rax
               	movb	%al, -0x4(%rbp)
               	leaq	0xd(%rcx), %rax
               	andq	$0xff, %rax
               	movb	%al, -0x3(%rbp)
               	leaq	-0x10(%rbp), %rax
               	addq	$0xe, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x2(%rbp)
               	movq	%rdi, %rcx
               	andq	$0xff, %rcx
               	addq	$0xf, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x1(%rbp)
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
               	leaq	0x20(%rsp), %rax
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movzbq	(%rsp), %rax
               	xorq	$0x63, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	movzbq	0x1(%rsp), %rax
               	xorq	$0x63, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	0x2(%rsp), %rax
               	xorq	$0x63, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	0x3(%rsp), %rax
               	xorq	$0x63, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	0x4(%rsp), %rax
               	xorq	$0x63, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	0x5(%rsp), %rax
               	xorq	$0x63, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	0x6(%rsp), %rax
               	xorq	$0x63, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	0x7(%rsp), %rax
               	xorq	$0x63, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	0x8(%rsp), %rax
               	xorq	$0x63, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	0x9(%rsp), %rax
               	xorq	$0x63, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	0xa(%rsp), %rax
               	xorq	$0x63, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	0xb(%rsp), %rax
               	xorq	$0x63, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	0xc(%rsp), %rax
               	xorq	$0x63, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	0xd(%rsp), %rax
               	xorq	$0x63, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	0xe(%rsp), %rax
               	xorq	$0x63, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	0xf(%rsp), %rax
               	xorq	$0x63, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movb	$0x27, -0x8(%rbp)
               	movb	$0x27, -0x7(%rbp)
               	movb	$0x27, -0x6(%rbp)
               	movb	$0x27, -0x5(%rbp)
               	movb	$0x27, -0x4(%rbp)
               	movb	$0x27, -0x3(%rbp)
               	movb	$0x27, -0x2(%rbp)
               	movb	$0x27, -0x1(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rax
               	xorq	$0x27, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	movzbq	-0x7(%rbp), %rax
               	xorq	$0x27, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	-0x6(%rbp), %rax
               	xorq	$0x27, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	-0x5(%rbp), %rax
               	xorq	$0x27, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	-0x4(%rbp), %rax
               	xorq	$0x27, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	-0x3(%rbp), %rax
               	xorq	$0x27, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	-0x2(%rbp), %rax
               	xorq	$0x27, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	-0x1(%rbp), %rax
               	xorq	$0x27, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x20(%rsp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x60(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movss	0x60(%rsp), %xmm0
               	movss	(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x20(%rsp)
               	movss	0x64(%rsp), %xmm0
               	movss	0x4(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x24(%rsp)
               	movss	0x68(%rsp), %xmm0
               	movss	0x8(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x28(%rsp)
               	movss	0x6c(%rsp), %xmm0
               	movss	0xc(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x2c(%rsp)
               	movups	0x20(%rsp), %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	movss	0x20(%rsp), %xmm0
               	movl	$0x41300000, %eax       # imm = 0x41300000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x24(%rsp), %xmm0
               	movl	$0x41b00000, %eax       # imm = 0x41B00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x28(%rsp), %xmm0
               	movl	$0x42040000, %eax       # imm = 0x42040000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x2c(%rsp), %xmm0
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
               	leaq	0x20(%rsp), %rax
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movzbq	(%rsp), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	movzbq	0x1(%rsp), %rax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movzbq	0x2(%rsp), %rax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movzbq	0x3(%rsp), %rax
               	cmpl	$0xa, %eax
               	jne	<addr>
               	movzbq	0x4(%rsp), %rax
               	cmpl	$0xc, %eax
               	jne	<addr>
               	movzbq	0x5(%rsp), %rax
               	cmpl	$0xe, %eax
               	jne	<addr>
               	movzbq	0x6(%rsp), %rax
               	cmpl	$0x10, %eax
               	jne	<addr>
               	movzbq	0x7(%rsp), %rax
               	cmpl	$0x12, %eax
               	jne	<addr>
               	movzbq	0x8(%rsp), %rax
               	cmpl	$0x14, %eax
               	jne	<addr>
               	movzbq	0x9(%rsp), %rax
               	cmpl	$0x16, %eax
               	jne	<addr>
               	movzbq	0xa(%rsp), %rax
               	cmpl	$0x18, %eax
               	jne	<addr>
               	movzbq	0xb(%rsp), %rax
               	cmpl	$0x1a, %eax
               	jne	<addr>
               	movzbq	0xc(%rsp), %rax
               	cmpl	$0x1c, %eax
               	jne	<addr>
               	movzbq	0xd(%rsp), %rax
               	cmpl	$0x1e, %eax
               	jne	<addr>
               	movzbq	0xe(%rsp), %rax
               	cmpl	$0x20, %eax
               	jne	<addr>
               	movzbq	0xf(%rsp), %rax
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
