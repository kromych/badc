
gcc_vector_bitwise_ops.x64:	file format elf64-x86-64

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

<same16>:
               	vpextrb	$0x0, %xmm0, %eax
               	movzbq	(%rdi), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	xorl	%eax, %eax
               	retq
               	vpextrb	$0x1, %xmm0, %eax
               	movzbq	0x1(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x2, %xmm0, %eax
               	movzbq	0x2(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x3, %xmm0, %eax
               	movzbq	0x3(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x4, %xmm0, %eax
               	movzbq	0x4(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x5, %xmm0, %eax
               	movzbq	0x5(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x6, %xmm0, %eax
               	movzbq	0x6(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x7, %xmm0, %eax
               	movzbq	0x7(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x8, %xmm0, %eax
               	movzbq	0x8(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x9, %xmm0, %eax
               	movzbq	0x9(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0xa, %xmm0, %eax
               	movzbq	0xa(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0xb, %xmm0, %eax
               	movzbq	0xb(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0xc, %xmm0, %eax
               	movzbq	0xc(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0xd, %xmm0, %eax
               	movzbq	0xd(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0xe, %xmm0, %eax
               	movzbq	0xe(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0xf, %xmm0, %eax
               	movzbq	0xf(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	retq

<main>:
               	subq	$0x78, %rsp
               	leaq	(%rsp), %rcx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x10(%rsp), %rdx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	movzbq	0x10(%rsp,%rax), %r8
               	xorq	%r8, %rdi
               	movb	%dil, 0x40(%rsp,%rax)
               	movzbq	(%rsp,%rax), %rdi
               	movzbq	0x10(%rsp,%rax), %r8
               	andq	%r8, %rdi
               	movb	%dil, 0x50(%rsp,%rax)
               	movzbq	(%rsp,%rax), %rdi
               	movzbq	0x10(%rsp,%rax), %r8
               	orq	%r8, %rdi
               	movb	%dil, 0x60(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	(%rsp), %xmm0
               	movups	0x10(%rsp), %xmm1
               	vpxor	%xmm1, %xmm0, %xmm0
               	leaq	0x20(%rsp), %r9
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x40(%rsp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x78, %rsp
               	retq
               	movups	(%rsp), %xmm0
               	movups	0x10(%rsp), %xmm1
               	vpand	%xmm1, %xmm0, %xmm0
               	leaq	0x20(%rsp), %r9
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x50(%rsp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0x78, %rsp
               	retq
               	movups	(%rsp), %xmm0
               	movups	0x10(%rsp), %xmm1
               	vpor	%xmm1, %xmm0, %xmm0
               	leaq	0x20(%rsp), %r9
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x60(%rsp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	addq	$0x78, %rsp
               	retq
               	movups	(%rsp), %xmm1
               	movups	0x10(%rsp), %xmm0
               	vpxor	%xmm0, %xmm1, %xmm1
               	vpxor	%xmm0, %xmm1, %xmm0
               	leaq	0x20(%rsp), %r9
               	movups	%xmm0, 0x20(%rsp)
               	leaq	(%rsp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0x78, %rsp
               	retq
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	(%rsp), %xmm0
               	movups	0x10(%rsp), %xmm1
               	vpxor	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x40(%rsp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0x78, %rsp
               	retq
               	leaq	0x20(%rsp), %r9
               	leaq	(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	(%rsp), %xmm0
               	movups	0x10(%rsp), %xmm1
               	vpand	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x50(%rsp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x6, %eax
               	addq	$0x78, %rsp
               	retq
               	leaq	0x20(%rsp), %r9
               	leaq	(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	(%rsp), %xmm0
               	movups	0x10(%rsp), %xmm1
               	vpor	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x60(%rsp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7, %eax
               	addq	$0x78, %rsp
               	retq
               	movups	(%rsp), %xmm0
               	movups	0x10(%rsp), %xmm1
               	vpxor	%xmm1, %xmm0, %xmm0
               	leaq	0x20(%rsp), %r9
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x40(%rsp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x8, %eax
               	addq	$0x78, %rsp
               	retq
               	movw	$0x801, 0x30(%rsp)      # imm = 0x801
               	movw	$0xc7c8, 0x10(%rsp)     # imm = 0xC7C8
               	movw	$0x160f, 0x32(%rsp)     # imm = 0x160F
               	movw	$0xc5c6, 0x12(%rsp)     # imm = 0xC5C6
               	movw	$0x241d, 0x34(%rsp)     # imm = 0x241D
               	movw	$0xc3c4, 0x14(%rsp)     # imm = 0xC3C4
               	movw	$0x322b, 0x36(%rsp)     # imm = 0x322B
               	movw	$0xc1c2, 0x16(%rsp)     # imm = 0xC1C2
               	movw	$0x4039, 0x38(%rsp)     # imm = 0x4039
               	movw	$0xbfc0, 0x18(%rsp)     # imm = 0xBFC0
               	movw	$0x4e47, 0x3a(%rsp)     # imm = 0x4E47
               	movw	$0xbdbe, 0x1a(%rsp)     # imm = 0xBDBE
               	movw	$0x5c55, 0x3c(%rsp)     # imm = 0x5C55
               	movw	$0xbbbc, 0x1c(%rsp)     # imm = 0xBBBC
               	movw	$0x6a63, 0x3e(%rsp)     # imm = 0x6A63
               	movw	$0xb9ba, 0x1e(%rsp)     # imm = 0xB9BA
               	movups	0x30(%rsp), %xmm0
               	movups	0x10(%rsp), %xmm1
               	vpxor	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rdi
               	movzbq	0x30(%rsp,%rax), %r8
               	movzbq	0x10(%rsp,%rax), %r9
               	xorq	%r9, %r8
               	nop
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	addq	$0x78, %rsp
               	retq
               	movl	$0xa, %eax
               	addq	$0x78, %rsp
               	retq
