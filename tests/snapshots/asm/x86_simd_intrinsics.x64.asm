
x86_simd_intrinsics.x64:	file format elf64-x86-64

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

<aes128_known_answer>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm0
               	movups	%xmm0, -0xc0(%rbp)
               	aeskeygenassist	$0x1, %xmm0, %xmm1
               	pshufd	$0xff, %xmm1, %xmm2     # xmm2 = xmm1[3,3,3,3]
               	movapd	%xmm0, %xmm1
               	pslldq	$0x4, %xmm1             # xmm1 = zero,zero,zero,zero,xmm1[0,1,2,3,4,5,6,7,8,9,10,11]
               	movapd	%xmm0, %xmm3
               	pxor	%xmm1, %xmm3
               	movapd	%xmm1, %xmm0
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	movapd	%xmm3, %xmm1
               	pxor	%xmm0, %xmm1
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	pxor	%xmm1, %xmm0
               	pxor	%xmm2, %xmm0
               	movups	%xmm0, -0xb0(%rbp)
               	aeskeygenassist	$0x2, %xmm0, %xmm1
               	pshufd	$0xff, %xmm1, %xmm2     # xmm2 = xmm1[3,3,3,3]
               	movapd	%xmm0, %xmm1
               	pslldq	$0x4, %xmm1             # xmm1 = zero,zero,zero,zero,xmm1[0,1,2,3,4,5,6,7,8,9,10,11]
               	movapd	%xmm0, %xmm3
               	pxor	%xmm1, %xmm3
               	movapd	%xmm1, %xmm0
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	movapd	%xmm3, %xmm1
               	pxor	%xmm0, %xmm1
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	pxor	%xmm1, %xmm0
               	pxor	%xmm2, %xmm0
               	movups	%xmm0, -0xa0(%rbp)
               	aeskeygenassist	$0x4, %xmm0, %xmm1
               	pshufd	$0xff, %xmm1, %xmm2     # xmm2 = xmm1[3,3,3,3]
               	movapd	%xmm0, %xmm1
               	pslldq	$0x4, %xmm1             # xmm1 = zero,zero,zero,zero,xmm1[0,1,2,3,4,5,6,7,8,9,10,11]
               	movapd	%xmm0, %xmm3
               	pxor	%xmm1, %xmm3
               	movapd	%xmm1, %xmm0
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	movapd	%xmm3, %xmm1
               	pxor	%xmm0, %xmm1
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	pxor	%xmm1, %xmm0
               	pxor	%xmm2, %xmm0
               	movups	%xmm0, -0x90(%rbp)
               	aeskeygenassist	$0x8, %xmm0, %xmm1
               	pshufd	$0xff, %xmm1, %xmm2     # xmm2 = xmm1[3,3,3,3]
               	movapd	%xmm0, %xmm1
               	pslldq	$0x4, %xmm1             # xmm1 = zero,zero,zero,zero,xmm1[0,1,2,3,4,5,6,7,8,9,10,11]
               	movapd	%xmm0, %xmm3
               	pxor	%xmm1, %xmm3
               	movapd	%xmm1, %xmm0
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	movapd	%xmm3, %xmm1
               	pxor	%xmm0, %xmm1
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	pxor	%xmm1, %xmm0
               	pxor	%xmm2, %xmm0
               	movups	%xmm0, -0x80(%rbp)
               	aeskeygenassist	$0x10, %xmm0, %xmm1
               	pshufd	$0xff, %xmm1, %xmm2     # xmm2 = xmm1[3,3,3,3]
               	movapd	%xmm0, %xmm1
               	pslldq	$0x4, %xmm1             # xmm1 = zero,zero,zero,zero,xmm1[0,1,2,3,4,5,6,7,8,9,10,11]
               	movapd	%xmm0, %xmm3
               	pxor	%xmm1, %xmm3
               	movapd	%xmm1, %xmm0
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	movapd	%xmm3, %xmm1
               	pxor	%xmm0, %xmm1
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	pxor	%xmm1, %xmm0
               	pxor	%xmm2, %xmm0
               	movups	%xmm0, -0x70(%rbp)
               	aeskeygenassist	$0x20, %xmm0, %xmm1
               	pshufd	$0xff, %xmm1, %xmm2     # xmm2 = xmm1[3,3,3,3]
               	movapd	%xmm0, %xmm1
               	pslldq	$0x4, %xmm1             # xmm1 = zero,zero,zero,zero,xmm1[0,1,2,3,4,5,6,7,8,9,10,11]
               	movapd	%xmm0, %xmm3
               	pxor	%xmm1, %xmm3
               	movapd	%xmm1, %xmm0
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	movapd	%xmm3, %xmm1
               	pxor	%xmm0, %xmm1
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	pxor	%xmm1, %xmm0
               	pxor	%xmm2, %xmm0
               	movups	%xmm0, -0x60(%rbp)
               	aeskeygenassist	$0x40, %xmm0, %xmm1
               	pshufd	$0xff, %xmm1, %xmm2     # xmm2 = xmm1[3,3,3,3]
               	movapd	%xmm0, %xmm1
               	pslldq	$0x4, %xmm1             # xmm1 = zero,zero,zero,zero,xmm1[0,1,2,3,4,5,6,7,8,9,10,11]
               	movapd	%xmm0, %xmm3
               	pxor	%xmm1, %xmm3
               	movapd	%xmm1, %xmm0
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	movapd	%xmm3, %xmm1
               	pxor	%xmm0, %xmm1
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	pxor	%xmm1, %xmm0
               	pxor	%xmm2, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	aeskeygenassist	$0x80, %xmm0, %xmm1
               	pshufd	$0xff, %xmm1, %xmm2     # xmm2 = xmm1[3,3,3,3]
               	movapd	%xmm0, %xmm1
               	pslldq	$0x4, %xmm1             # xmm1 = zero,zero,zero,zero,xmm1[0,1,2,3,4,5,6,7,8,9,10,11]
               	movapd	%xmm0, %xmm3
               	pxor	%xmm1, %xmm3
               	movapd	%xmm1, %xmm0
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	movapd	%xmm3, %xmm1
               	pxor	%xmm0, %xmm1
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	pxor	%xmm1, %xmm0
               	pxor	%xmm2, %xmm0
               	movups	%xmm0, -0x40(%rbp)
               	aeskeygenassist	$0x1b, %xmm0, %xmm1
               	pshufd	$0xff, %xmm1, %xmm2     # xmm2 = xmm1[3,3,3,3]
               	movapd	%xmm0, %xmm1
               	pslldq	$0x4, %xmm1             # xmm1 = zero,zero,zero,zero,xmm1[0,1,2,3,4,5,6,7,8,9,10,11]
               	movapd	%xmm0, %xmm3
               	pxor	%xmm1, %xmm3
               	movapd	%xmm1, %xmm0
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	movapd	%xmm3, %xmm1
               	pxor	%xmm0, %xmm1
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	pxor	%xmm1, %xmm0
               	pxor	%xmm2, %xmm0
               	movups	%xmm0, -0x30(%rbp)
               	aeskeygenassist	$0x36, %xmm0, %xmm1
               	pshufd	$0xff, %xmm1, %xmm2     # xmm2 = xmm1[3,3,3,3]
               	movapd	%xmm0, %xmm1
               	pslldq	$0x4, %xmm1             # xmm1 = zero,zero,zero,zero,xmm1[0,1,2,3,4,5,6,7,8,9,10,11]
               	movapd	%xmm0, %xmm3
               	pxor	%xmm1, %xmm3
               	movapd	%xmm1, %xmm0
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	movapd	%xmm3, %xmm1
               	pxor	%xmm0, %xmm1
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	pxor	%xmm1, %xmm0
               	pxor	%xmm2, %xmm0
               	movups	%xmm0, -0x20(%rbp)
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm0
               	movups	-0xc0(%rbp), %xmm1
               	pxor	%xmm1, %xmm0
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x1, %eax
               	leaq	-0xc0(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %rcx
               	movups	-0x10(%rbp), %xmm0
               	movups	(%rcx), %xmm1
               	aesenc	%xmm1, %xmm0
               	movups	%xmm0, -0x10(%rbp)
               	incq	%rax
               	cmpl	$0xa, %eax
               	jl	<addr>
               	leaq	-0x10(%rbp), %r9
               	movups	-0x10(%rbp), %xmm0
               	movups	-0x20(%rbp), %xmm1
               	aesenclast	%xmm1, %xmm0
               	movups	%xmm0, -0x10(%rbp)
               	leaq	<rip>, %rdi # <addr>
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm0
               	leaq	-0xc0(%rbp), %rcx
               	movups	-0x20(%rbp), %xmm1
               	pxor	%xmm1, %xmm0
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x9, %eax
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rcx, %rdx
               	movups	(%rdx), %xmm0
               	aesimc	%xmm0, %xmm0
               	movups	-0x10(%rbp), %xmm1
               	movapd	%xmm1, %xmm15
               	aesdec	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	movups	%xmm0, -0x10(%rbp)
               	decq	%rax
               	testl	%eax, %eax
               	jg	<addr>
               	leaq	-0x10(%rbp), %r9
               	movups	-0x10(%rbp), %xmm0
               	movups	-0xc0(%rbp), %xmm1
               	aesdeclast	%xmm1, %xmm0
               	movups	%xmm0, -0x10(%rbp)
               	leaq	<rip>, %rdi # <addr>
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm0
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm1
               	movapd	%xmm0, %xmm2
               	paddd	%xmm1, %xmm2
               	vmovd	%xmm2, %eax
               	cmpl	$0x65, %eax
               	jne	<addr>
               	vpextrd	$0x1, %xmm2, %eax
               	cmpl	$0xca, %eax
               	jne	<addr>
               	vpextrd	$0x2, %xmm2, %eax
               	cmpl	$0x12f, %eax            # imm = 0x12F
               	jne	<addr>
               	vpextrd	$0x3, %xmm2, %eax
               	cmpl	$0x194, %eax            # imm = 0x194
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movapd	%xmm0, %xmm2
               	pxor	%xmm1, %xmm2
               	vmovd	%xmm2, %eax
               	cmpq	$0x65, %rax
               	jne	<addr>
               	vpextrd	$0x3, %xmm2, %eax
               	cmpq	$0x194, %rax            # imm = 0x194
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movapd	%xmm0, %xmm2
               	por	%xmm1, %xmm2
               	vpextrd	$0x1, %xmm2, %eax
               	cmpq	$0xca, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	pand	%xmm1, %xmm0
               	vpextrd	$0x2, %xmm0, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm1
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm0
               	movapd	%xmm1, %xmm2
               	paddd	%xmm0, %xmm2
               	vmovd	%xmm2, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	vpextrd	$0x1, %xmm2, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movapd	%xmm1, %xmm2
               	paddq	%xmm0, %xmm2
               	vmovd	%xmm2, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	vpextrd	$0x1, %xmm2, %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	paddq	%xmm0, %xmm1
               	movapd	%xmm1, %xmm15
               	psubq	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	vmovd	%xmm0, %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	jne	<addr>
               	vpextrd	$0x1, %xmm0, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm0
               	movapd	%xmm0, %xmm1
               	pslld	$0x4, %xmm1
               	vpextrd	$0x3, %xmm1, %eax
               	cmpq	$0x12233440, %rax       # imm = 0x12233440
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movapd	%xmm0, %xmm1
               	psrld	$0x4, %xmm1
               	vpextrd	$0x3, %xmm1, %eax
               	cmpq	$0x1122334, %rax        # imm = 0x1122334
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x8, %eax
               	movapd	%xmm0, %xmm1
               	movq	%rax, %xmm14
               	psrld	%xmm14, %xmm1
               	vpextrd	$0x3, %xmm1, %eax
               	cmpq	$0x112233, %rax         # imm = 0x112233
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movapd	%xmm0, %xmm1
               	psrld	$0x20, %xmm1
               	vmovd	%xmm1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	vpextrd	$0x3, %xmm1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movapd	%xmm0, %xmm1
               	psllq	$0x8, %xmm1
               	vmovd	%xmm1, %eax
               	movl	$0xeeff0000, %r11d      # imm = 0xEEFF0000
               	cmpq	%r11, %rax
               	jne	<addr>
               	vpextrd	$0x1, %xmm1, %eax
               	movl	$0xaabbccdd, %r11d      # imm = 0xAABBCCDD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movapd	%xmm0, %xmm1
               	psrlq	$0x8, %xmm1
               	vmovd	%xmm1, %eax
               	movl	$0xccddeeff, %r11d      # imm = 0xCCDDEEFF
               	cmpq	%r11, %rax
               	jne	<addr>
               	vpextrd	$0x1, %xmm1, %eax
               	cmpq	$0x99aabb, %rax         # imm = 0x99AABB
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	vmovd	%xmm0, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	vpextrd	$0x1, %xmm0, %eax
               	movl	$0xddeeff00, %r11d      # imm = 0xDDEEFF00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm1
               	movapd	%xmm1, %xmm0
               	psllw	$0x8, %xmm0
               	vpextrb	$0x0, %xmm0, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	vpextrb	$0x1, %xmm0, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	vpextrb	$0x2, %xmm0, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	vpextrb	$0x3, %xmm0, %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movapd	%xmm1, %xmm0
               	psrlw	$0x8, %xmm0
               	vpextrb	$0x0, %xmm0, %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	vpextrb	$0x1, %xmm0, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	vpextrb	$0x2, %xmm0, %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	pshuflw	$0x1b, %xmm1, %xmm0     # xmm0 = xmm1[3,2,1,0,4,5,6,7]
               	vpextrb	$0x0, %xmm0, %eax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	vpextrb	$0x1, %xmm0, %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	vpextrb	$0x6, %xmm0, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	vpextrb	$0x7, %xmm0, %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	vpextrb	$0x8, %xmm0, %eax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	pshufhw	$0x1b, %xmm1, %xmm0     # xmm0 = xmm1[0,1,2,3,7,6,5,4]
               	vpextrb	$0x0, %xmm0, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	vpextrb	$0x8, %xmm0, %eax
               	cmpl	$0xe, %eax
               	jne	<addr>
               	vpextrb	$0x9, %xmm0, %eax
               	cmpl	$0xf, %eax
               	jne	<addr>
               	vpextrb	$0xe, %xmm0, %eax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	vpextrb	$0xf, %xmm0, %eax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm0
               	pshufd	$0x93, %xmm0, %xmm0     # xmm0 = xmm0[3,0,1,2]
               	vmovd	%xmm0, %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	vpextrd	$0x1, %xmm0, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	vpextrd	$0x2, %xmm0, %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm0
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm1
               	pshufb	%xmm1, %xmm0
               	vpextrb	$0x0, %xmm0, %eax
               	cmpl	$0xf, %eax
               	jne	<addr>
               	vpextrb	$0xe, %xmm0, %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	vpextrb	$0xf, %xmm0, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm0
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm2
               	movapd	%xmm0, %xmm1
               	punpcklqdq	%xmm2, %xmm1    # xmm1 = xmm1[0],xmm2[0]
               	vmovd	%xmm1, %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	vpextrd	$0x1, %xmm1, %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	vpextrd	$0x2, %xmm1, %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	vpextrd	$0x3, %xmm1, %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movapd	%xmm0, %xmm1
               	pcmpeqq	%xmm0, %xmm1
               	vmovd	%xmm1, %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	jne	<addr>
               	vpextrd	$0x3, %xmm1, %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	pcmpeqq	%xmm2, %xmm0
               	vmovd	%xmm0, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm0
               	pextrw	$0x0, %xmm0, %eax
               	cmpl	$0x2222, %eax           # imm = 0x2222
               	jne	<addr>
               	pextrw	$0x7, %xmm0, %eax
               	cmpl	$0x7777, %eax           # imm = 0x7777
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	pextrd	$0x2, %xmm0, %eax
               	cmpl	$0x55556666, %eax       # imm = 0x55556666
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	movl	$0xa0b0c0d, %eax        # imm = 0xA0B0C0D
               	pinsrd	$0x1, %eax, %xmm0
               	vpextrd	$0x1, %xmm0, %eax
               	cmpq	$0xa0b0c0d, %rax        # imm = 0xA0B0C0D
               	jne	<addr>
               	vmovd	%xmm0, %eax
               	cmpq	$0x11112222, %rax       # imm = 0x11112222
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm0
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm2
               	movapd	%xmm0, %xmm1
               	pclmulqdq	$0x0, %xmm0, %xmm1
               	vmovd	%xmm1, %eax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	vpextrd	$0x1, %xmm1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1b, %eax
               	leave
               	retq
               	pclmulqdq	$0x10, %xmm2, %xmm0
               	vmovd	%xmm0, %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x1c, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm0
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm1
               	shufpd	$0x1, %xmm1, %xmm0      # xmm0 = xmm0[1],xmm1[0]
               	vmovd	%xmm0, %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	vpextrd	$0x1, %xmm0, %eax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	vpextrd	$0x2, %xmm0, %eax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %eax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x1d, %eax
               	leave
               	retq
               	leaq	-0x90(%rbp), %r9
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	<rip>, %rdi # <addr>
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x21, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %r9
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	<rip>, %rdi # <addr>
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x22, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %r9
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	<rip>, %rdi # <addr>
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x23, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %r9
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	<rip>, %rdi # <addr>
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x24, %eax
               	leave
               	retq
               	movl	$0x1234, %r11d          # imm = 0x1234
               	vmovd	%r11d, %xmm0
               	vpbroadcastw	%xmm0, %xmm0
               	vmovd	%xmm0, %eax
               	cmpq	$0x12341234, %rax       # imm = 0x12341234
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %eax
               	cmpq	$0x12341234, %rax       # imm = 0x12341234
               	je	<addr>
               	movl	$0x27, %eax
               	leave
               	retq
               	movl	$0x5a, %r11d
               	vmovd	%r11d, %xmm1
               	vpbroadcastb	%xmm1, %xmm1
               	vmovd	%xmm1, %eax
               	cmpq	$0x5a5a5a5a, %rax       # imm = 0x5A5A5A5A
               	jne	<addr>
               	vpextrd	$0x3, %xmm1, %eax
               	cmpq	$0x5a5a5a5a, %rax       # imm = 0x5A5A5A5A
               	je	<addr>
               	movl	$0x28, %eax
               	leave
               	retq
               	vpcmpeqd	%xmm2, %xmm2, %xmm2
               	movl	$0x1, %r11d
               	vmovd	%r11d, %xmm1
               	vpbroadcastb	%xmm1, %xmm1
               	paddb	%xmm1, %xmm2
               	vmovd	%xmm2, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	vpextrd	$0x3, %xmm2, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2a, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	psubb	%xmm1, %xmm15
               	movapd	%xmm15, %xmm1
               	vmovd	%xmm1, %ecx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x2b, %eax
               	leave
               	retq
               	vpcmpeqd	%xmm2, %xmm2, %xmm2
               	movl	$0x1, %r11d
               	vmovd	%r11d, %xmm1
               	vpbroadcastw	%xmm1, %xmm1
               	paddw	%xmm1, %xmm2
               	vmovd	%xmm2, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2c, %eax
               	leave
               	retq
               	movq	%rax, %xmm15
               	psubw	%xmm1, %xmm15
               	movapd	%xmm15, %xmm1
               	vmovd	%xmm1, %ecx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x2d, %eax
               	leave
               	retq
               	movl	$0x5, %r11d
               	vmovd	%r11d, %xmm1
               	vpbroadcastd	%xmm1, %xmm1
               	movl	$0x7, %r11d
               	vmovd	%r11d, %xmm2
               	vpbroadcastd	%xmm2, %xmm2
               	psubd	%xmm2, %xmm1
               	vmovd	%xmm1, %ecx
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x2e, %eax
               	leave
               	retq
               	movl	$0x3, %r11d
               	vmovd	%r11d, %xmm1
               	vpbroadcastw	%xmm1, %xmm1
               	pmullw	%xmm1, %xmm0
               	vmovd	%xmm0, %ecx
               	cmpq	$0x369c369c, %rcx       # imm = 0x369C369C
               	je	<addr>
               	movl	$0x2f, %eax
               	leave
               	retq
               	movl	$0xf000, %r11d          # imm = 0xF000
               	vmovd	%r11d, %xmm1
               	vpbroadcastw	%xmm1, %xmm1
               	movl	$0x10, %r11d
               	vmovd	%r11d, %xmm0
               	vpbroadcastw	%xmm0, %xmm0
               	pmulhw	%xmm0, %xmm1
               	vmovd	%xmm1, %ecx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x30, %eax
               	leave
               	retq
               	movl	$0x1000, %r11d          # imm = 0x1000
               	vmovd	%r11d, %xmm1
               	vpbroadcastw	%xmm1, %xmm1
               	pmulhw	%xmm1, %xmm0
               	vmovd	%xmm0, %ecx
               	cmpq	$0x10001, %rcx          # imm = 0x10001
               	je	<addr>
               	movl	$0x31, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movups	(%rcx), %xmm0
               	movl	$0xfffe, %r11d          # imm = 0xFFFE
               	vmovd	%r11d, %xmm1
               	vpbroadcastw	%xmm1, %xmm1
               	pmaddwd	%xmm1, %xmm0
               	vmovd	%xmm0, %ecx
               	movl	$0xfffffffa, %r11d      # imm = 0xFFFFFFFA
               	cmpq	%r11, %rcx
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %ecx
               	movl	$0xffffffe2, %r11d      # imm = 0xFFFFFFE2
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x32, %eax
               	leave
               	retq
               	movl	$0x12c, %r11d           # imm = 0x12C
               	vmovd	%r11d, %xmm1
               	vpbroadcastw	%xmm1, %xmm1
               	movl	$0xfed4, %r11d          # imm = 0xFED4
               	vmovd	%r11d, %xmm0
               	vpbroadcastw	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	packsswb	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	vpextrb	$0x0, %xmm0, %ecx
               	cmpl	$0x7f, %ecx
               	jne	<addr>
               	vpextrb	$0x7, %xmm0, %ecx
               	cmpl	$0x7f, %ecx
               	jne	<addr>
               	vpextrb	$0x8, %xmm0, %ecx
               	cmpl	$0x80, %ecx
               	jne	<addr>
               	vpextrb	$0xf, %xmm0, %ecx
               	cmpl	$0x80, %ecx
               	je	<addr>
               	movl	$0x33, %eax
               	leave
               	retq
               	movl	$0xfffb, %r11d          # imm = 0xFFFB
               	vmovd	%r11d, %xmm0
               	vpbroadcastw	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	packuswb	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	vpextrb	$0x0, %xmm0, %ecx
               	cmpl	$0xff, %ecx
               	jne	<addr>
               	vpextrb	$0x7, %xmm0, %ecx
               	cmpl	$0xff, %ecx
               	jne	<addr>
               	vpextrb	$0x8, %xmm0, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	vpextrb	$0xf, %xmm0, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x34, %eax
               	leave
               	retq
               	movl	$0x11170, %r11d         # imm = 0x11170
               	vmovd	%r11d, %xmm0
               	vpbroadcastd	%xmm0, %xmm0
               	movl	$0xfffeee90, %r11d      # imm = 0xFFFEEE90
               	vmovd	%r11d, %xmm1
               	vpbroadcastd	%xmm1, %xmm1
               	packssdw	%xmm1, %xmm0
               	vpextrb	$0x0, %xmm0, %ecx
               	cmpl	$0xff, %ecx
               	jne	<addr>
               	vpextrb	$0x1, %xmm0, %ecx
               	cmpl	$0x7f, %ecx
               	jne	<addr>
               	vpextrb	$0x8, %xmm0, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	vpextrb	$0x9, %xmm0, %ecx
               	cmpl	$0x80, %ecx
               	je	<addr>
               	movl	$0x35, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movups	(%rcx), %xmm1
               	movq	%rax, %xmm14
               	movapd	%xmm1, %xmm0
               	punpcklbw	%xmm14, %xmm0   # xmm0 = xmm0[0],xmm14[0],xmm0[1],xmm14[1],xmm0[2],xmm14[2],xmm0[3],xmm14[3],xmm0[4],xmm14[4],xmm0[5],xmm14[5],xmm0[6],xmm14[6],xmm0[7],xmm14[7]
               	vpextrb	$0x0, %xmm0, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	vpextrb	$0x1, %xmm0, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	vpextrb	$0x2, %xmm0, %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	vpextrb	$0xe, %xmm0, %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	vpextrb	$0xf, %xmm0, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x36, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movapd	%xmm1, %xmm0
               	punpckhbw	%xmm14, %xmm0   # xmm0 = xmm0[8],xmm14[8],xmm0[9],xmm14[9],xmm0[10],xmm14[10],xmm0[11],xmm14[11],xmm0[12],xmm14[12],xmm0[13],xmm14[13],xmm0[14],xmm14[14],xmm0[15],xmm14[15]
               	vpextrb	$0x0, %xmm0, %ecx
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	vpextrb	$0x1, %xmm0, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	vpextrb	$0xe, %xmm0, %ecx
               	cmpl	$0xf, %ecx
               	jne	<addr>
               	vpextrb	$0xf, %xmm0, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x37, %eax
               	leave
               	retq
               	movq	%rax, %xmm14
               	movapd	%xmm1, %xmm0
               	punpcklwd	%xmm14, %xmm0   # xmm0 = xmm0[0],xmm14[0],xmm0[1],xmm14[1],xmm0[2],xmm14[2],xmm0[3],xmm14[3]
               	vpextrb	$0x0, %xmm0, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	vpextrb	$0x1, %xmm0, %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	vpextrb	$0x2, %xmm0, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	vpextrb	$0x3, %xmm0, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	vpextrb	$0x4, %xmm0, %ecx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x38, %eax
               	leave
               	retq
               	movq	%rax, %xmm14
               	movapd	%xmm1, %xmm0
               	punpckhwd	%xmm14, %xmm0   # xmm0 = xmm0[4],xmm14[4],xmm0[5],xmm14[5],xmm0[6],xmm14[6],xmm0[7],xmm14[7]
               	vpextrb	$0x0, %xmm0, %eax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	vpextrb	$0x1, %xmm0, %eax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	vpextrb	$0x2, %xmm0, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	vpextrb	$0x4, %xmm0, %eax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x39, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm1
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm2
               	movapd	%xmm1, %xmm0
               	punpckldq	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1]
               	vmovd	%xmm0, %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	vpextrd	$0x1, %xmm0, %eax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	vpextrd	$0x2, %xmm0, %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %eax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x3a, %eax
               	leave
               	retq
               	movapd	%xmm1, %xmm0
               	punpckhdq	%xmm2, %xmm0    # xmm0 = xmm0[2],xmm2[2],xmm0[3],xmm2[3]
               	vmovd	%xmm0, %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	vpextrd	$0x1, %xmm0, %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	vpextrd	$0x2, %xmm0, %eax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %eax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x3b, %eax
               	leave
               	retq
               	movapd	%xmm1, %xmm0
               	punpckhqdq	%xmm2, %xmm0    # xmm0 = xmm0[1],xmm2[1]
               	vmovd	%xmm0, %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	vpextrd	$0x1, %xmm0, %eax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	vpextrd	$0x2, %xmm0, %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %eax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x3c, %eax
               	leave
               	retq
               	movl	$0xfff0, %r11d          # imm = 0xFFF0
               	vmovd	%r11d, %xmm0
               	vpbroadcastw	%xmm0, %xmm0
               	movapd	%xmm0, %xmm1
               	psraw	$0x2, %xmm1
               	vmovd	%xmm1, %eax
               	movl	$0xfffcfffc, %r11d      # imm = 0xFFFCFFFC
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3d, %eax
               	leave
               	retq
               	psraw	$0x20, %xmm0
               	vmovd	%xmm0, %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3e, %eax
               	leave
               	retq
               	movl	$0xfffffff0, %r11d      # imm = 0xFFFFFFF0
               	vmovd	%r11d, %xmm0
               	vpbroadcastd	%xmm0, %xmm0
               	psrad	$0x2, %xmm0
               	vmovd	%xmm0, %eax
               	movl	$0xfffffffc, %r11d      # imm = 0xFFFFFFFC
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3f, %eax
               	leave
               	retq
               	movl	$0x3, %eax
               	movl	$0xffffffc0, %r11d      # imm = 0xFFFFFFC0
               	vmovd	%r11d, %xmm0
               	vpbroadcastd	%xmm0, %xmm0
               	movq	%rax, %xmm14
               	psrad	%xmm14, %xmm0
               	vmovd	%xmm0, %ecx
               	movl	$0xfffffff8, %r11d      # imm = 0xFFFFFFF8
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x40, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movups	(%rcx), %xmm0
               	movapd	%xmm0, %xmm1
               	psrldq	$0x3, %xmm1             # xmm1 = xmm1[3,4,5,6,7,8,9,10,11,12,13,14,15],zero,zero,zero
               	vpextrb	$0x0, %xmm1, %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	vpextrb	$0xc, %xmm1, %ecx
               	cmpl	$0xf, %ecx
               	jne	<addr>
               	vpextrb	$0xd, %xmm1, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	vpextrb	$0xf, %xmm1, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x41, %eax
               	leave
               	retq
               	movl	$0xbeef, %ecx           # imm = 0xBEEF
               	movapd	%xmm0, %xmm1
               	pinsrw	$0x2, %ecx, %xmm1
               	vpextrb	$0x4, %xmm1, %ecx
               	cmpl	$0xef, %ecx
               	jne	<addr>
               	vpextrb	$0x5, %xmm1, %ecx
               	cmpl	$0xbe, %ecx
               	jne	<addr>
               	vpextrb	$0x6, %xmm1, %ecx
               	cmpl	$0x6, %ecx
               	je	<addr>
               	movl	$0x42, %eax
               	leave
               	retq
               	movl	$0x80, %r11d
               	vmovd	%r11d, %xmm2
               	vpbroadcastb	%xmm2, %xmm2
               	pmovmskb	%xmm2, %ecx
               	cmpl	$0xffff, %ecx           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x43, %eax
               	leave
               	retq
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm14
               	pmovmskb	%xmm14, %edx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x44, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movups	(%rdx), %xmm2
               	pmovmskb	%xmm2, %edx
               	cmpl	$0x8001, %edx           # imm = 0x8001
               	je	<addr>
               	movl	$0x45, %eax
               	leave
               	retq
               	movl	$0xf, %r11d
               	vmovd	%r11d, %xmm2
               	vpbroadcastb	%xmm2, %xmm2
               	movl	$0x33, %r11d
               	vmovd	%r11d, %xmm3
               	vpbroadcastb	%xmm3, %xmm3
               	pandn	%xmm3, %xmm2
               	vmovd	%xmm2, %edx
               	cmpq	$0x30303030, %rdx       # imm = 0x30303030
               	je	<addr>
               	movl	$0x46, %eax
               	leave
               	retq
               	movapd	%xmm0, %xmm2
               	pcmpeqb	%xmm0, %xmm2
               	vmovd	%xmm2, %edx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rdx
               	jne	<addr>
               	vpextrd	$0x3, %xmm2, %edx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x47, %eax
               	leave
               	retq
               	movl	$0x7, %r11d
               	vmovd	%r11d, %xmm2
               	vpbroadcastw	%xmm2, %xmm2
               	movl	$0x8, %r11d
               	vmovd	%r11d, %xmm3
               	vpbroadcastw	%xmm3, %xmm3
               	pcmpeqw	%xmm3, %xmm2
               	vmovd	%xmm2, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x48, %eax
               	leave
               	retq
               	movl	$0x7, %r11d
               	vmovd	%r11d, %xmm2
               	vpbroadcastd	%xmm2, %xmm2
               	movapd	%xmm2, %xmm15
               	pcmpeqd	%xmm2, %xmm15
               	movapd	%xmm15, %xmm2
               	vmovd	%xmm2, %edx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x49, %eax
               	leave
               	retq
               	vpcmpeqd	%xmm2, %xmm2, %xmm2
               	movl	$0xfffe, %r11d          # imm = 0xFFFE
               	vmovd	%r11d, %xmm3
               	vpbroadcastw	%xmm3, %xmm3
               	pcmpgtw	%xmm3, %xmm2
               	vmovd	%xmm2, %edx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x4a, %eax
               	leave
               	retq
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	vmovd	%r11d, %xmm2
               	vpbroadcastd	%xmm2, %xmm2
               	vpcmpeqd	%xmm3, %xmm3, %xmm3
               	movapd	%xmm3, %xmm15
               	pcmpgtd	%xmm2, %xmm15
               	movapd	%xmm15, %xmm2
               	vmovd	%xmm2, %edx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x4b, %eax
               	leave
               	retq
               	movl	$0x1, %edx
               	vpinsrb	$0x0, %edx, %xmm1, %xmm1
               	movl	$0x2, %edx
               	vpinsrb	$0x1, %edx, %xmm1, %xmm1
               	vpinsrb	$0x2, %eax, %xmm1, %xmm1
               	movl	$0x4, %eax
               	vpinsrb	$0x3, %eax, %xmm1, %xmm1
               	movl	$0x5, %eax
               	vpinsrb	$0x4, %eax, %xmm1, %xmm1
               	movl	$0x6, %eax
               	vpinsrb	$0x5, %eax, %xmm1, %xmm1
               	movl	$0x7, %eax
               	vpinsrb	$0x6, %eax, %xmm1, %xmm1
               	movl	$0x8, %eax
               	vpinsrb	$0x7, %eax, %xmm1, %xmm1
               	xorl	%eax, %eax
               	vmovq	%xmm1, %rdx
               	vmovq	%rdx, %xmm1
               	movapd	%xmm1, %xmm2
               	vpinsrq	$0x1, %rcx, %xmm2, %xmm2
               	vmovd	%xmm1, %eax
               	cmpq	$0x4030201, %rax        # imm = 0x4030201
               	jne	<addr>
               	vpextrd	$0x1, %xmm1, %eax
               	cmpq	$0x8070605, %rax        # imm = 0x8070605
               	jne	<addr>
               	vpextrd	$0x2, %xmm2, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	vpextrd	$0x3, %xmm2, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4c, %eax
               	leave
               	retq
               	movabsq	$-0x1111111111111112, %r11 # imm = 0xEEEEEEEEEEEEEEEE
               	vmovq	%r11, %xmm1
               	vpbroadcastq	%xmm1, %xmm1
               	movabsq	$0x200000001, %rax      # imm = 0x200000001
               	vpinsrq	$0x0, %rax, %xmm1, %xmm1
               	vpextrb	$0x0, %xmm1, %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	vpextrb	$0x4, %xmm1, %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movups	%xmm0, (%rax)
               	vpextrb	$0x0, %xmm0, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4e, %eax
               	leave
               	retq
               	vpextrb	$0x1, %xmm0, %eax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	vpextrb	$0x2, %xmm0, %eax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	vpextrb	$0x3, %xmm0, %eax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	vpextrb	$0x4, %xmm0, %eax
               	cmpq	$0x4, %rax
               	jne	<addr>
               	vpextrb	$0x5, %xmm0, %eax
               	cmpq	$0x5, %rax
               	jne	<addr>
               	vpextrb	$0x6, %xmm0, %eax
               	cmpq	$0x6, %rax
               	jne	<addr>
               	vpextrb	$0x7, %xmm0, %eax
               	cmpq	$0x7, %rax
               	jne	<addr>
               	vpextrb	$0x8, %xmm0, %eax
               	cmpq	$0x8, %rax
               	jne	<addr>
               	vpextrb	$0x9, %xmm0, %eax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	vpextrb	$0xa, %xmm0, %eax
               	cmpq	$0xa, %rax
               	jne	<addr>
               	vpextrb	$0xb, %xmm0, %eax
               	cmpq	$0xb, %rax
               	jne	<addr>
               	vpextrb	$0xc, %xmm0, %eax
               	cmpq	$0xc, %rax
               	jne	<addr>
               	vpextrb	$0xd, %xmm0, %eax
               	cmpq	$0xd, %rax
               	jne	<addr>
               	vpextrb	$0xe, %xmm0, %eax
               	cmpq	$0xe, %rax
               	jne	<addr>
               	vpextrb	$0xf, %xmm0, %eax
               	cmpq	$0xf, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	leaq	-0x18(%rbp), %rdx
               	leaq	0x1(%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	movups	-0x15(%rbp), %xmm0
               	vpextrb	$0x0, %xmm0, %eax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	vpextrb	$0xf, %xmm0, %eax
               	cmpl	$0x13, %eax
               	je	<addr>
               	movl	$0x51, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, -0x13(%rbp)
               	movzbq	-0x14(%rbp), %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movzbq	-0x3(%rbp), %rax
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0x52, %eax
               	leave
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x53, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x4d, %eax
               	leave
               	retq
