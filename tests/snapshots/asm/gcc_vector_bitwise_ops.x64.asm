
gcc_vector_bitwise_ops.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	leaq	-0x70(%rbp), %rcx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x60(%rbp), %rdx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	movzbq	-0x70(%rbp,%rax), %rdi
               	movzbq	-0x60(%rbp,%rax), %r8
               	xorq	%r8, %rdi
               	movb	%dil, -0x30(%rbp,%rax)
               	movzbq	-0x70(%rbp,%rax), %rdi
               	movzbq	-0x60(%rbp,%rax), %r8
               	andq	%r8, %rdi
               	movb	%dil, -0x20(%rbp,%rax)
               	movzbq	-0x70(%rbp,%rax), %rdi
               	movzbq	-0x60(%rbp,%rax), %r8
               	orq	%r8, %rdi
               	movb	%dil, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	-0x70(%rbp), %xmm0
               	movups	-0x60(%rbp), %xmm1
               	vpxor	%xmm1, %xmm0, %xmm0
               	leaq	-0x50(%rbp), %r9
               	movups	%xmm0, -0x50(%rbp)
               	leaq	-0x30(%rbp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movups	-0x70(%rbp), %xmm0
               	movups	-0x60(%rbp), %xmm1
               	vpand	%xmm1, %xmm0, %xmm0
               	leaq	-0x50(%rbp), %r9
               	movups	%xmm0, -0x50(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movups	-0x70(%rbp), %xmm0
               	movups	-0x60(%rbp), %xmm1
               	vpor	%xmm1, %xmm0, %xmm0
               	leaq	-0x50(%rbp), %r9
               	movups	%xmm0, -0x50(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movups	-0x70(%rbp), %xmm1
               	movups	-0x60(%rbp), %xmm0
               	vpxor	%xmm0, %xmm1, %xmm1
               	vpxor	%xmm0, %xmm1, %xmm0
               	leaq	-0x50(%rbp), %r9
               	movups	%xmm0, -0x50(%rbp)
               	leaq	-0x70(%rbp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %rax
               	leaq	-0x50(%rbp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	-0x70(%rbp), %xmm0
               	movups	-0x60(%rbp), %xmm1
               	vpxor	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	leaq	-0x30(%rbp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %r9
               	leaq	-0x70(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	-0x70(%rbp), %xmm0
               	movups	-0x60(%rbp), %xmm1
               	vpand	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %r9
               	leaq	-0x70(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	-0x70(%rbp), %xmm0
               	movups	-0x60(%rbp), %xmm1
               	vpor	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movups	-0x70(%rbp), %xmm0
               	movups	-0x60(%rbp), %xmm1
               	vpxor	%xmm1, %xmm0, %xmm0
               	leaq	-0x50(%rbp), %r9
               	movups	%xmm0, -0x50(%rbp)
               	leaq	-0x30(%rbp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movw	$0x801, -0x40(%rbp)     # imm = 0x801
               	movw	$0xc7c8, -0x60(%rbp)    # imm = 0xC7C8
               	movw	$0x160f, -0x3e(%rbp)    # imm = 0x160F
               	movw	$0xc5c6, -0x5e(%rbp)    # imm = 0xC5C6
               	movw	$0x241d, -0x3c(%rbp)    # imm = 0x241D
               	movw	$0xc3c4, -0x5c(%rbp)    # imm = 0xC3C4
               	movw	$0x322b, -0x3a(%rbp)    # imm = 0x322B
               	movw	$0xc1c2, -0x5a(%rbp)    # imm = 0xC1C2
               	movw	$0x4039, -0x38(%rbp)    # imm = 0x4039
               	movw	$0xbfc0, -0x58(%rbp)    # imm = 0xBFC0
               	movw	$0x4e47, -0x36(%rbp)    # imm = 0x4E47
               	movw	$0xbdbe, -0x56(%rbp)    # imm = 0xBDBE
               	movw	$0x5c55, -0x34(%rbp)    # imm = 0x5C55
               	movw	$0xbbbc, -0x54(%rbp)    # imm = 0xBBBC
               	movw	$0x6a63, -0x32(%rbp)    # imm = 0x6A63
               	movw	$0xb9ba, -0x52(%rbp)    # imm = 0xB9BA
               	movups	-0x40(%rbp), %xmm0
               	movups	-0x60(%rbp), %xmm1
               	vpxor	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rdi
               	movzbq	-0x40(%rbp,%rax), %r8
               	movzbq	-0x60(%rbp,%rax), %r9
               	xorq	%r9, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0xa, %eax
               	leave
               	retq
