
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	movups	%xmm0, (%rax)
               	movzbq	-0x10(%rbp), %rax
               	movzbq	(%rdi), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movzbq	-0xf(%rbp), %rax
               	movzbq	0x1(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movzbq	-0xe(%rbp), %rax
               	movzbq	0x2(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movzbq	-0xd(%rbp), %rax
               	movzbq	0x3(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movzbq	-0xc(%rbp), %rax
               	movzbq	0x4(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movzbq	-0xb(%rbp), %rax
               	movzbq	0x5(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movzbq	-0xa(%rbp), %rax
               	movzbq	0x6(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movzbq	-0x9(%rbp), %rax
               	movzbq	0x7(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movzbq	-0x8(%rbp), %rax
               	movzbq	0x8(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movzbq	-0x7(%rbp), %rax
               	movzbq	0x9(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movzbq	-0x6(%rbp), %rax
               	movzbq	0xa(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movzbq	-0x5(%rbp), %rax
               	movzbq	0xb(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movzbq	-0x4(%rbp), %rax
               	movzbq	0xc(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movzbq	-0x3(%rbp), %rax
               	movzbq	0xd(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movzbq	-0x2(%rbp), %rax
               	movzbq	0xe(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movzbq	-0x1(%rbp), %rax
               	movzbq	0xf(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq

<load>:
               	movups	(%rdi), %xmm0
               	retq

<aes128_known_answer>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm0
               	movups	%xmm0, -0xc0(%rbp)
               	movups	-0xc0(%rbp), %xmm0
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
               	movups	-0xb0(%rbp), %xmm0
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
               	movups	-0xa0(%rbp), %xmm0
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
               	movups	-0x90(%rbp), %xmm0
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
               	movups	-0x80(%rbp), %xmm0
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
               	movups	-0x70(%rbp), %xmm0
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
               	movups	-0x60(%rbp), %xmm0
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
               	movups	-0x50(%rbp), %xmm0
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
               	movups	-0x40(%rbp), %xmm0
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
               	movups	-0x30(%rbp), %xmm0
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
               	subq	$0x80, %rsp
               	leaq	-0x70(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x1, -0x70(%rbp)
               	movl	$0x2, -0x6c(%rbp)
               	movl	$0x3, -0x68(%rbp)
               	movl	$0x4, -0x64(%rbp)
               	movups	-0x70(%rbp), %xmm0
               	leaq	-0x70(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x64, -0x70(%rbp)
               	movl	$0xc8, -0x6c(%rbp)
               	movl	$0x12c, -0x68(%rbp)     # imm = 0x12C
               	movl	$0x190, -0x64(%rbp)     # imm = 0x190
               	movups	-0x70(%rbp), %xmm1
               	leaq	-0x38(%rbp), %rax
               	movapd	%xmm0, %xmm2
               	paddd	%xmm1, %xmm2
               	movups	%xmm2, (%rax)
               	movl	-0x38(%rbp), %ecx
               	cmpl	$0x65, %ecx
               	jne	<addr>
               	movl	-0x34(%rbp), %ecx
               	cmpl	$0xca, %ecx
               	jne	<addr>
               	movl	-0x30(%rbp), %ecx
               	cmpl	$0x12f, %ecx            # imm = 0x12F
               	jne	<addr>
               	movl	-0x2c(%rbp), %ecx
               	cmpl	$0x194, %ecx            # imm = 0x194
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movapd	%xmm0, %xmm2
               	pxor	%xmm1, %xmm2
               	movups	%xmm2, (%rax)
               	movl	-0x38(%rbp), %eax
               	cmpl	$0x65, %eax
               	jne	<addr>
               	movl	-0x2c(%rbp), %eax
               	cmpl	$0x194, %eax            # imm = 0x194
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rax
               	movapd	%xmm0, %xmm2
               	por	%xmm1, %xmm2
               	movups	%xmm2, (%rax)
               	movl	-0x34(%rbp), %ecx
               	cmpl	$0xca, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	pand	%xmm1, %xmm0
               	movups	%xmm0, (%rax)
               	cmpl	$0x0, -0x30(%rbp)
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0xffffffff, -0x70(%rbp) # imm = 0xFFFFFFFF
               	movl	$0x0, -0x6c(%rbp)
               	movl	$0xffffffff, -0x68(%rbp) # imm = 0xFFFFFFFF
               	movl	$0x0, -0x64(%rbp)
               	movups	-0x70(%rbp), %xmm1
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x1, -0x70(%rbp)
               	movl	$0x0, -0x6c(%rbp)
               	movl	$0x0, -0x68(%rbp)
               	movl	$0x0, -0x64(%rbp)
               	movups	-0x70(%rbp), %xmm0
               	leaq	-0x38(%rbp), %rax
               	movapd	%xmm1, %xmm2
               	paddd	%xmm0, %xmm2
               	movups	%xmm2, (%rax)
               	cmpl	$0x0, -0x38(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x34(%rbp)
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movapd	%xmm1, %xmm2
               	paddq	%xmm0, %xmm2
               	movups	%xmm2, (%rax)
               	cmpl	$0x0, -0x38(%rbp)
               	jne	<addr>
               	movl	-0x34(%rbp), %ecx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	paddq	%xmm0, %xmm1
               	movapd	%xmm1, %xmm15
               	psubq	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	movups	%xmm0, (%rax)
               	movl	-0x38(%rbp), %eax
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	cmpl	$0x0, -0x34(%rbp)
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0xddeeff00, -0x70(%rbp) # imm = 0xDDEEFF00
               	movl	$0x99aabbcc, -0x6c(%rbp) # imm = 0x99AABBCC
               	movl	$0x55667788, -0x68(%rbp) # imm = 0x55667788
               	movl	$0x11223344, -0x64(%rbp) # imm = 0x11223344
               	movups	-0x70(%rbp), %xmm0
               	leaq	-0x38(%rbp), %rax
               	movapd	%xmm0, %xmm1
               	pslld	$0x4, %xmm1
               	movups	%xmm1, (%rax)
               	movl	-0x2c(%rbp), %ecx
               	cmpl	$0x12233440, %ecx       # imm = 0x12233440
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movapd	%xmm0, %xmm1
               	psrld	$0x4, %xmm1
               	movups	%xmm1, (%rax)
               	movl	-0x2c(%rbp), %ecx
               	cmpl	$0x1122334, %ecx        # imm = 0x1122334
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x8, %ecx
               	movapd	%xmm0, %xmm1
               	movq	%rcx, %xmm14
               	psrld	%xmm14, %xmm1
               	movups	%xmm1, (%rax)
               	movl	-0x2c(%rbp), %ecx
               	cmpl	$0x112233, %ecx         # imm = 0x112233
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movapd	%xmm0, %xmm1
               	psrld	$0x20, %xmm1
               	movups	%xmm1, (%rax)
               	cmpl	$0x0, -0x38(%rbp)
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	cmpl	$0x0, -0x2c(%rbp)
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movapd	%xmm0, %xmm1
               	psllq	$0x8, %xmm1
               	movups	%xmm1, (%rax)
               	movl	-0x38(%rbp), %ecx
               	cmpl	$0xeeff0000, %ecx       # imm = 0xEEFF0000
               	jne	<addr>
               	movl	-0x34(%rbp), %ecx
               	cmpl	$0xaabbccdd, %ecx       # imm = 0xAABBCCDD
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movapd	%xmm0, %xmm1
               	psrlq	$0x8, %xmm1
               	movups	%xmm1, (%rax)
               	movl	-0x38(%rbp), %ecx
               	cmpl	$0xccddeeff, %ecx       # imm = 0xCCDDEEFF
               	jne	<addr>
               	movl	-0x34(%rbp), %ecx
               	cmpl	$0x99aabb, %ecx         # imm = 0x99AABB
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	movups	%xmm0, (%rax)
               	cmpl	$0x0, -0x38(%rbp)
               	jne	<addr>
               	movl	-0x34(%rbp), %eax
               	cmpl	$0xddeeff00, %eax       # imm = 0xDDEEFF00
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movb	$0x0, -0x70(%rbp)
               	movb	$0x1, -0x6f(%rbp)
               	movb	$0x2, -0x6e(%rbp)
               	movb	$0x3, -0x6d(%rbp)
               	movb	$0x4, -0x6c(%rbp)
               	movb	$0x5, -0x6b(%rbp)
               	movb	$0x6, -0x6a(%rbp)
               	movb	$0x7, -0x69(%rbp)
               	movb	$0x8, -0x68(%rbp)
               	movb	$0x9, -0x67(%rbp)
               	movb	$0xa, -0x66(%rbp)
               	movb	$0xb, -0x65(%rbp)
               	movb	$0xc, -0x64(%rbp)
               	movb	$0xd, -0x63(%rbp)
               	movb	$0xe, -0x62(%rbp)
               	movb	$0xf, -0x61(%rbp)
               	movups	-0x70(%rbp), %xmm0
               	leaq	-0x48(%rbp), %rax
               	movapd	%xmm0, %xmm1
               	psllw	$0x8, %xmm1
               	movups	%xmm1, (%rax)
               	cmpb	$0x0, -0x48(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x47(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x46(%rbp)
               	jne	<addr>
               	movzbq	-0x45(%rbp), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movapd	%xmm0, %xmm1
               	psrlw	$0x8, %xmm1
               	movups	%xmm1, (%rax)
               	movzbq	-0x48(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	cmpb	$0x0, -0x47(%rbp)
               	jne	<addr>
               	leaq	-0x48(%rbp), %rax
               	movzbq	-0x46(%rbp), %rcx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	pshuflw	$0x1b, %xmm0, %xmm1     # xmm1 = xmm0[3,2,1,0,4,5,6,7]
               	movups	%xmm1, (%rax)
               	movzbq	-0x48(%rbp), %rcx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movzbq	-0x47(%rbp), %rcx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	cmpb	$0x0, -0x42(%rbp)
               	jne	<addr>
               	movzbq	-0x41(%rbp), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movzbq	-0x40(%rbp), %rcx
               	cmpl	$0x8, %ecx
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	pshufhw	$0x1b, %xmm0, %xmm0     # xmm0 = xmm0[0,1,2,3,7,6,5,4]
               	movups	%xmm0, (%rax)
               	cmpb	$0x0, -0x48(%rbp)
               	jne	<addr>
               	movzbq	-0x40(%rbp), %rax
               	cmpl	$0xe, %eax
               	jne	<addr>
               	movzbq	-0x3f(%rbp), %rax
               	cmpl	$0xf, %eax
               	jne	<addr>
               	movzbq	-0x3a(%rbp), %rax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movzbq	-0x39(%rbp), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x0, -0x70(%rbp)
               	movl	$0x1, -0x6c(%rbp)
               	movl	$0x2, -0x68(%rbp)
               	movl	$0x3, -0x64(%rbp)
               	movups	-0x70(%rbp), %xmm0
               	leaq	-0x38(%rbp), %rax
               	pshufd	$0x93, %xmm0, %xmm0     # xmm0 = xmm0[3,0,1,2]
               	movups	%xmm0, (%rax)
               	movl	-0x38(%rbp), %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	cmpl	$0x0, -0x34(%rbp)
               	jne	<addr>
               	movl	-0x30(%rbp), %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	-0x2c(%rbp), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movb	$0x0, -0x70(%rbp)
               	movb	$0x1, -0x6f(%rbp)
               	movb	$0x2, -0x6e(%rbp)
               	movb	$0x3, -0x6d(%rbp)
               	movb	$0x4, -0x6c(%rbp)
               	movb	$0x5, -0x6b(%rbp)
               	movb	$0x6, -0x6a(%rbp)
               	movb	$0x7, -0x69(%rbp)
               	movb	$0x8, -0x68(%rbp)
               	movb	$0x9, -0x67(%rbp)
               	movb	$0xa, -0x66(%rbp)
               	movb	$0xb, -0x65(%rbp)
               	movb	$0xc, -0x64(%rbp)
               	movb	$0xd, -0x63(%rbp)
               	movb	$0xe, -0x62(%rbp)
               	movb	$0xf, -0x61(%rbp)
               	movups	-0x70(%rbp), %xmm0
               	leaq	-0x70(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movb	$0xf, -0x70(%rbp)
               	movb	$0xe, -0x6f(%rbp)
               	movb	$0xd, -0x6e(%rbp)
               	movb	$0xc, -0x6d(%rbp)
               	movb	$0xb, -0x6c(%rbp)
               	movb	$0xa, -0x6b(%rbp)
               	movb	$0x9, -0x6a(%rbp)
               	movb	$0x8, -0x69(%rbp)
               	movb	$0x7, -0x68(%rbp)
               	movb	$0x6, -0x67(%rbp)
               	movb	$0x5, -0x66(%rbp)
               	movb	$0x4, -0x65(%rbp)
               	movb	$0x3, -0x64(%rbp)
               	movb	$0x2, -0x63(%rbp)
               	movb	$0x1, -0x62(%rbp)
               	movb	$-0x80, -0x61(%rbp)
               	movups	-0x70(%rbp), %xmm1
               	leaq	-0x48(%rbp), %rax
               	pshufb	%xmm1, %xmm0
               	movups	%xmm0, (%rax)
               	movzbq	-0x48(%rbp), %rax
               	cmpl	$0xf, %eax
               	jne	<addr>
               	movzbq	-0x3a(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	cmpb	$0x0, -0x39(%rbp)
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x1, -0x70(%rbp)
               	movl	$0x1, -0x6c(%rbp)
               	movl	$0x9, -0x68(%rbp)
               	movl	$0x9, -0x64(%rbp)
               	movups	-0x70(%rbp), %xmm0
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x2, -0x70(%rbp)
               	movl	$0x2, -0x6c(%rbp)
               	movl	$0x8, -0x68(%rbp)
               	movl	$0x8, -0x64(%rbp)
               	movups	-0x70(%rbp), %xmm1
               	leaq	-0x38(%rbp), %rax
               	movapd	%xmm0, %xmm2
               	punpcklqdq	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0]
               	movups	%xmm2, (%rax)
               	movl	-0x38(%rbp), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	-0x34(%rbp), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	-0x30(%rbp), %ecx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movl	-0x2c(%rbp), %ecx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movapd	%xmm0, %xmm2
               	pcmpeqq	%xmm0, %xmm2
               	movups	%xmm2, (%rax)
               	movl	-0x38(%rbp), %eax
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	movl	-0x2c(%rbp), %eax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rax
               	pcmpeqq	%xmm1, %xmm0
               	movups	%xmm0, (%rax)
               	cmpl	$0x0, -0x38(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x2c(%rbp)
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x11112222, -0x70(%rbp) # imm = 0x11112222
               	movl	$0x33334444, -0x6c(%rbp) # imm = 0x33334444
               	movl	$0x55556666, -0x68(%rbp) # imm = 0x55556666
               	movl	$0x77778888, -0x64(%rbp) # imm = 0x77778888
               	movups	-0x70(%rbp), %xmm0
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
               	leaq	-0x38(%rbp), %rax
               	movl	$0xa0b0c0d, %ecx        # imm = 0xA0B0C0D
               	pinsrd	$0x1, %ecx, %xmm0
               	movups	%xmm0, (%rax)
               	movl	-0x34(%rbp), %eax
               	cmpl	$0xa0b0c0d, %eax        # imm = 0xA0B0C0D
               	jne	<addr>
               	movl	-0x38(%rbp), %eax
               	cmpl	$0x11112222, %eax       # imm = 0x11112222
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	$0x3, -0x70(%rbp)
               	movq	$0x0, -0x68(%rbp)
               	movups	-0x70(%rbp), %xmm0
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	$0x0, -0x70(%rbp)
               	movq	$0x3, -0x68(%rbp)
               	movups	-0x70(%rbp), %xmm1
               	leaq	-0x38(%rbp), %rax
               	movapd	%xmm0, %xmm2
               	pclmulqdq	$0x0, %xmm0, %xmm2
               	movups	%xmm2, (%rax)
               	movl	-0x38(%rbp), %ecx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	cmpl	$0x0, -0x34(%rbp)
               	je	<addr>
               	movl	$0x1b, %eax
               	leave
               	retq
               	pclmulqdq	$0x10, %xmm1, %xmm0
               	movups	%xmm0, (%rax)
               	movl	-0x38(%rbp), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x1c, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x1, -0x70(%rbp)
               	movl	$0x2, -0x6c(%rbp)
               	movl	$0x3, -0x68(%rbp)
               	movl	$0x4, -0x64(%rbp)
               	movups	-0x70(%rbp), %xmm0
               	leaq	-0x70(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x5, -0x70(%rbp)
               	movl	$0x6, -0x6c(%rbp)
               	movl	$0x7, -0x68(%rbp)
               	movl	$0x8, -0x64(%rbp)
               	movups	-0x70(%rbp), %xmm1
               	shufpd	$0x1, %xmm1, %xmm0      # xmm0 = xmm0[1],xmm1[0]
               	leaq	-0x38(%rbp), %rax
               	movups	%xmm0, (%rax)
               	movl	-0x38(%rbp), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	-0x34(%rbp), %ecx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movl	-0x30(%rbp), %ecx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	-0x2c(%rbp), %ecx
               	cmpl	$0x6, %ecx
               	je	<addr>
               	movl	$0x1d, %eax
               	leave
               	retq
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm14
               	movups	%xmm14, (%rax)
               	movb	$0x1, -0x48(%rbp)
               	movb	$0x8, -0x47(%rbp)
               	movb	$0xf, -0x46(%rbp)
               	movb	$0x16, -0x45(%rbp)
               	movb	$0x1d, -0x44(%rbp)
               	movb	$0x24, -0x43(%rbp)
               	movb	$0x2b, -0x42(%rbp)
               	movb	$0x32, -0x41(%rbp)
               	movb	$0x39, -0x40(%rbp)
               	movb	$0x40, -0x3f(%rbp)
               	movb	$0x47, -0x3e(%rbp)
               	movb	$0x4e, -0x3d(%rbp)
               	movb	$0x55, -0x3c(%rbp)
               	movb	$0x5c, -0x3b(%rbp)
               	leaq	-0x48(%rbp), %rdi
               	movb	$0x63, -0x3a(%rbp)
               	movb	$0x6a, -0x39(%rbp)
               	callq	<addr>
               	leaq	-0x48(%rbp), %rcx
               	movq	$0x0, -0x48(%rbp)
               	movq	$0x0, -0x40(%rbp)
               	movups	%xmm0, (%rcx)
               	movzbq	-0x48(%rbp), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1f, %eax
               	leave
               	retq
               	movzbq	-0x47(%rbp), %rax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movzbq	-0x46(%rbp), %rax
               	cmpl	$0xf, %eax
               	jne	<addr>
               	movzbq	-0x45(%rbp), %rax
               	cmpl	$0x16, %eax
               	jne	<addr>
               	movzbq	-0x44(%rbp), %rax
               	cmpl	$0x1d, %eax
               	jne	<addr>
               	movzbq	-0x43(%rbp), %rax
               	cmpl	$0x24, %eax
               	jne	<addr>
               	movzbq	-0x42(%rbp), %rax
               	cmpl	$0x2b, %eax
               	jne	<addr>
               	movzbq	-0x41(%rbp), %rax
               	cmpl	$0x32, %eax
               	jne	<addr>
               	movzbq	-0x40(%rbp), %rax
               	cmpl	$0x39, %eax
               	jne	<addr>
               	movzbq	-0x3f(%rbp), %rax
               	cmpl	$0x40, %eax
               	jne	<addr>
               	movzbq	-0x3e(%rbp), %rax
               	cmpl	$0x47, %eax
               	jne	<addr>
               	movzbq	-0x3d(%rbp), %rax
               	cmpl	$0x4e, %eax
               	jne	<addr>
               	movzbq	-0x3c(%rbp), %rax
               	cmpl	$0x55, %eax
               	jne	<addr>
               	movzbq	-0x3b(%rbp), %rax
               	cmpl	$0x5c, %eax
               	jne	<addr>
               	movzbq	-0x3a(%rbp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	-0x39(%rbp), %rax
               	cmpl	$0x6a, %eax
               	jne	<addr>
               	leaq	-0x70(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movw	$0x0, -0x70(%rbp)
               	movw	$0x1, -0x6e(%rbp)
               	movw	$0x2, -0x6c(%rbp)
               	movw	$0x3, -0x6a(%rbp)
               	leaq	-0x70(%rbp), %r9
               	movw	$0x4, -0x68(%rbp)
               	movw	$0x5, -0x66(%rbp)
               	movw	$0x6, -0x64(%rbp)
               	movw	$0x7, -0x62(%rbp)
               	leaq	<rip>, %rdi # <addr>
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x21, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movw	$0x7, -0x70(%rbp)
               	movw	$0x6, -0x6e(%rbp)
               	movw	$0x5, -0x6c(%rbp)
               	movw	$0x4, -0x6a(%rbp)
               	movw	$0x3, -0x68(%rbp)
               	movw	$0x2, -0x66(%rbp)
               	movw	$0x1, -0x64(%rbp)
               	movw	$0x0, -0x62(%rbp)
               	leaq	-0x70(%rbp), %r9
               	leaq	<rip>, %rdi # <addr>
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x22, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movb	$0x0, -0x70(%rbp)
               	movb	$0x1, -0x6f(%rbp)
               	movb	$0x2, -0x6e(%rbp)
               	movb	$0x3, -0x6d(%rbp)
               	movb	$0x4, -0x6c(%rbp)
               	movb	$0x5, -0x6b(%rbp)
               	movb	$0x6, -0x6a(%rbp)
               	movb	$0x7, -0x69(%rbp)
               	movb	$0x8, -0x68(%rbp)
               	movb	$0x9, -0x67(%rbp)
               	leaq	-0x70(%rbp), %r9
               	movb	$0xa, -0x66(%rbp)
               	movb	$0xb, -0x65(%rbp)
               	movb	$0xc, -0x64(%rbp)
               	movb	$0xd, -0x63(%rbp)
               	movb	$0xe, -0x62(%rbp)
               	movb	$0xf, -0x61(%rbp)
               	leaq	<rip>, %rdi # <addr>
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x23, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movb	$0xf, -0x70(%rbp)
               	movb	$0xe, -0x6f(%rbp)
               	movb	$0xd, -0x6e(%rbp)
               	movb	$0xc, -0x6d(%rbp)
               	movb	$0xb, -0x6c(%rbp)
               	movb	$0xa, -0x6b(%rbp)
               	movb	$0x9, -0x6a(%rbp)
               	movb	$0x8, -0x69(%rbp)
               	movb	$0x7, -0x68(%rbp)
               	movb	$0x6, -0x67(%rbp)
               	movb	$0x5, -0x66(%rbp)
               	movb	$0x4, -0x65(%rbp)
               	movb	$0x3, -0x64(%rbp)
               	movb	$0x2, -0x63(%rbp)
               	movb	$0x1, -0x62(%rbp)
               	movb	$0x0, -0x61(%rbp)
               	leaq	-0x70(%rbp), %r9
               	leaq	<rip>, %rdi # <addr>
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x24, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x70(%rbp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movl	$0x1, -0x70(%rbp)
               	movl	$0x2, -0x6c(%rbp)
               	movl	$0x3, -0x68(%rbp)
               	movl	$0x4, -0x64(%rbp)
               	movups	-0x70(%rbp), %xmm0
               	movups	%xmm0, (%rax)
               	leaq	-0x38(%rbp), %rcx
               	movl	-0x38(%rbp), %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	-0x2c(%rbp), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x25, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x11223344, -0x70(%rbp) # imm = 0x11223344
               	movl	$0x11223344, -0x6c(%rbp) # imm = 0x11223344
               	movl	$0x11223344, -0x68(%rbp) # imm = 0x11223344
               	movl	$0x11223344, -0x64(%rbp) # imm = 0x11223344
               	movups	-0x70(%rbp), %xmm0
               	movups	%xmm0, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	-0x38(%rbp), %eax
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	jne	<addr>
               	movl	-0x2c(%rbp), %eax
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	je	<addr>
               	movl	$0x26, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movw	$0x1234, -0x70(%rbp)    # imm = 0x1234
               	movw	$0x1234, -0x6e(%rbp)    # imm = 0x1234
               	movw	$0x1234, -0x6c(%rbp)    # imm = 0x1234
               	movw	$0x1234, -0x6a(%rbp)    # imm = 0x1234
               	movw	$0x1234, -0x68(%rbp)    # imm = 0x1234
               	movw	$0x1234, -0x66(%rbp)    # imm = 0x1234
               	movw	$0x1234, -0x64(%rbp)    # imm = 0x1234
               	movw	$0x1234, -0x62(%rbp)    # imm = 0x1234
               	movups	-0x70(%rbp), %xmm0
               	movups	%xmm0, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	-0x38(%rbp), %eax
               	cmpl	$0x12341234, %eax       # imm = 0x12341234
               	jne	<addr>
               	movl	-0x2c(%rbp), %eax
               	cmpl	$0x12341234, %eax       # imm = 0x12341234
               	je	<addr>
               	movl	$0x27, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movb	$0x5a, -0x70(%rbp)
               	movb	$0x5a, -0x6f(%rbp)
               	movb	$0x5a, -0x6e(%rbp)
               	movb	$0x5a, -0x6d(%rbp)
               	movb	$0x5a, -0x6c(%rbp)
               	movb	$0x5a, -0x6b(%rbp)
               	movb	$0x5a, -0x6a(%rbp)
               	movb	$0x5a, -0x69(%rbp)
               	movb	$0x5a, -0x68(%rbp)
               	movb	$0x5a, -0x67(%rbp)
               	movb	$0x5a, -0x66(%rbp)
               	movb	$0x5a, -0x65(%rbp)
               	movb	$0x5a, -0x64(%rbp)
               	movb	$0x5a, -0x63(%rbp)
               	movb	$0x5a, -0x62(%rbp)
               	movb	$0x5a, -0x61(%rbp)
               	movups	-0x70(%rbp), %xmm0
               	movups	%xmm0, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	-0x38(%rbp), %eax
               	cmpl	$0x5a5a5a5a, %eax       # imm = 0x5A5A5A5A
               	jne	<addr>
               	movl	-0x2c(%rbp), %eax
               	cmpl	$0x5a5a5a5a, %eax       # imm = 0x5A5A5A5A
               	je	<addr>
               	movl	$0x28, %eax
               	leave
               	retq
               	movabsq	$0x123456789abcdef, %rax # imm = 0x123456789ABCDEF
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rax, -0x70(%rbp)
               	movq	%rax, -0x68(%rbp)
               	movups	-0x70(%rbp), %xmm0
               	movups	%xmm0, (%rcx)
               	movl	-0x38(%rbp), %eax
               	cmpl	$0x89abcdef, %eax       # imm = 0x89ABCDEF
               	jne	<addr>
               	movl	-0x34(%rbp), %eax
               	cmpl	$0x1234567, %eax        # imm = 0x1234567
               	jne	<addr>
               	movl	-0x2c(%rbp), %eax
               	cmpl	$0x1234567, %eax        # imm = 0x1234567
               	je	<addr>
               	movl	$0x29, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movb	$-0x1, -0x70(%rbp)
               	movb	$-0x1, -0x6f(%rbp)
               	movb	$-0x1, -0x6e(%rbp)
               	movb	$-0x1, -0x6d(%rbp)
               	movb	$-0x1, -0x6c(%rbp)
               	movb	$-0x1, -0x6b(%rbp)
               	movb	$-0x1, -0x6a(%rbp)
               	movb	$-0x1, -0x69(%rbp)
               	movb	$-0x1, -0x68(%rbp)
               	movb	$-0x1, -0x67(%rbp)
               	movb	$-0x1, -0x66(%rbp)
               	movb	$-0x1, -0x65(%rbp)
               	movb	$-0x1, -0x64(%rbp)
               	movb	$-0x1, -0x63(%rbp)
               	movb	$-0x1, -0x62(%rbp)
               	movb	$-0x1, -0x61(%rbp)
               	movups	-0x70(%rbp), %xmm1
               	leaq	-0x70(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movb	$0x1, -0x70(%rbp)
               	movb	$0x1, -0x6f(%rbp)
               	movb	$0x1, -0x6e(%rbp)
               	movb	$0x1, -0x6d(%rbp)
               	movb	$0x1, -0x6c(%rbp)
               	movb	$0x1, -0x6b(%rbp)
               	movb	$0x1, -0x6a(%rbp)
               	movb	$0x1, -0x69(%rbp)
               	movb	$0x1, -0x68(%rbp)
               	movb	$0x1, -0x67(%rbp)
               	movb	$0x1, -0x66(%rbp)
               	movb	$0x1, -0x65(%rbp)
               	movb	$0x1, -0x64(%rbp)
               	movb	$0x1, -0x63(%rbp)
               	movb	$0x1, -0x62(%rbp)
               	movb	$0x1, -0x61(%rbp)
               	movups	-0x70(%rbp), %xmm0
               	leaq	-0x38(%rbp), %rax
               	paddb	%xmm0, %xmm1
               	movups	%xmm1, (%rax)
               	cmpl	$0x0, -0x38(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x2c(%rbp)
               	je	<addr>
               	movl	$0x2a, %eax
               	leave
               	retq
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm15
               	psubb	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	movups	%xmm0, (%rax)
               	movl	-0x38(%rbp), %eax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x2b, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0xffff, -0x70(%rbp)    # imm = 0xFFFF
               	movw	$0xffff, -0x6e(%rbp)    # imm = 0xFFFF
               	movw	$0xffff, -0x6c(%rbp)    # imm = 0xFFFF
               	movw	$0xffff, -0x6a(%rbp)    # imm = 0xFFFF
               	movw	$0xffff, -0x68(%rbp)    # imm = 0xFFFF
               	movw	$0xffff, -0x66(%rbp)    # imm = 0xFFFF
               	movw	$0xffff, -0x64(%rbp)    # imm = 0xFFFF
               	movw	$0xffff, -0x62(%rbp)    # imm = 0xFFFF
               	movups	-0x70(%rbp), %xmm0
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movw	$0x1, -0x70(%rbp)
               	movw	$0x1, -0x6e(%rbp)
               	movw	$0x1, -0x6c(%rbp)
               	movw	$0x1, -0x6a(%rbp)
               	movw	$0x1, -0x68(%rbp)
               	movw	$0x1, -0x66(%rbp)
               	movw	$0x1, -0x64(%rbp)
               	movw	$0x1, -0x62(%rbp)
               	movups	-0x70(%rbp), %xmm1
               	paddw	%xmm1, %xmm0
               	movups	%xmm0, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	cmpl	$0x0, -0x38(%rbp)
               	je	<addr>
               	movl	$0x2c, %eax
               	leave
               	retq
               	xorl	%edx, %edx
               	leaq	-0x70(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movw	$0x1, -0x70(%rbp)
               	movw	$0x1, -0x6e(%rbp)
               	movw	$0x1, -0x6c(%rbp)
               	movw	$0x1, -0x6a(%rbp)
               	movw	$0x1, -0x68(%rbp)
               	movw	$0x1, -0x66(%rbp)
               	movw	$0x1, -0x64(%rbp)
               	movw	$0x1, -0x62(%rbp)
               	movups	-0x70(%rbp), %xmm0
               	movq	%rdx, %xmm15
               	psubw	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	movups	%xmm0, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	-0x38(%rbp), %eax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x2d, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x5, -0x60(%rbp)
               	movl	$0x5, -0x5c(%rbp)
               	movl	$0x5, -0x58(%rbp)
               	movl	$0x5, -0x54(%rbp)
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x7, -0x70(%rbp)
               	movl	$0x7, -0x6c(%rbp)
               	movl	$0x7, -0x68(%rbp)
               	movl	$0x7, -0x64(%rbp)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x70(%rbp), %xmm1
               	psubd	%xmm1, %xmm0
               	movups	%xmm0, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	-0x38(%rbp), %eax
               	cmpl	$-0x2, %eax
               	je	<addr>
               	movl	$0x2e, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movw	$0x1234, -0x60(%rbp)    # imm = 0x1234
               	movw	$0x1234, -0x5e(%rbp)    # imm = 0x1234
               	movw	$0x1234, -0x5c(%rbp)    # imm = 0x1234
               	movw	$0x1234, -0x5a(%rbp)    # imm = 0x1234
               	movw	$0x1234, -0x58(%rbp)    # imm = 0x1234
               	movw	$0x1234, -0x56(%rbp)    # imm = 0x1234
               	movw	$0x1234, -0x54(%rbp)    # imm = 0x1234
               	movw	$0x1234, -0x52(%rbp)    # imm = 0x1234
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movw	$0x3, -0x70(%rbp)
               	movw	$0x3, -0x6e(%rbp)
               	movw	$0x3, -0x6c(%rbp)
               	movw	$0x3, -0x6a(%rbp)
               	movw	$0x3, -0x68(%rbp)
               	movw	$0x3, -0x66(%rbp)
               	movw	$0x3, -0x64(%rbp)
               	movw	$0x3, -0x62(%rbp)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x70(%rbp), %xmm1
               	pmullw	%xmm1, %xmm0
               	movups	%xmm0, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	-0x38(%rbp), %eax
               	cmpl	$0x369c369c, %eax       # imm = 0x369C369C
               	je	<addr>
               	movl	$0x2f, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movw	$0xf000, -0x60(%rbp)    # imm = 0xF000
               	movw	$0xf000, -0x5e(%rbp)    # imm = 0xF000
               	movw	$0xf000, -0x5c(%rbp)    # imm = 0xF000
               	movw	$0xf000, -0x5a(%rbp)    # imm = 0xF000
               	movw	$0xf000, -0x58(%rbp)    # imm = 0xF000
               	movw	$0xf000, -0x56(%rbp)    # imm = 0xF000
               	movw	$0xf000, -0x54(%rbp)    # imm = 0xF000
               	movw	$0xf000, -0x52(%rbp)    # imm = 0xF000
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movw	$0x10, -0x70(%rbp)
               	movw	$0x10, -0x6e(%rbp)
               	movw	$0x10, -0x6c(%rbp)
               	movw	$0x10, -0x6a(%rbp)
               	movw	$0x10, -0x68(%rbp)
               	movw	$0x10, -0x66(%rbp)
               	movw	$0x10, -0x64(%rbp)
               	movw	$0x10, -0x62(%rbp)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x70(%rbp), %xmm1
               	pmulhw	%xmm1, %xmm0
               	movups	%xmm0, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	-0x38(%rbp), %eax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x30, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movw	$0x1000, -0x60(%rbp)    # imm = 0x1000
               	movw	$0x1000, -0x5e(%rbp)    # imm = 0x1000
               	movw	$0x1000, -0x5c(%rbp)    # imm = 0x1000
               	movw	$0x1000, -0x5a(%rbp)    # imm = 0x1000
               	movw	$0x1000, -0x58(%rbp)    # imm = 0x1000
               	movw	$0x1000, -0x56(%rbp)    # imm = 0x1000
               	movw	$0x1000, -0x54(%rbp)    # imm = 0x1000
               	movw	$0x1000, -0x52(%rbp)    # imm = 0x1000
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movw	$0x10, -0x70(%rbp)
               	movw	$0x10, -0x6e(%rbp)
               	movw	$0x10, -0x6c(%rbp)
               	movw	$0x10, -0x6a(%rbp)
               	movw	$0x10, -0x68(%rbp)
               	movw	$0x10, -0x66(%rbp)
               	movw	$0x10, -0x64(%rbp)
               	movw	$0x10, -0x62(%rbp)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x70(%rbp), %xmm1
               	pmulhw	%xmm1, %xmm0
               	movups	%xmm0, (%rcx)
               	movl	-0x38(%rbp), %eax
               	cmpl	$0x10001, %eax          # imm = 0x10001
               	je	<addr>
               	movl	$0x31, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movw	$0x1, -0x70(%rbp)
               	movw	$0x2, -0x6e(%rbp)
               	movw	$0x3, -0x6c(%rbp)
               	movw	$0x4, -0x6a(%rbp)
               	movw	$0x5, -0x68(%rbp)
               	movw	$0x6, -0x66(%rbp)
               	movw	$0x7, -0x64(%rbp)
               	movw	$0x8, -0x62(%rbp)
               	movups	-0x70(%rbp), %xmm0
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movw	$0xfffe, -0x70(%rbp)    # imm = 0xFFFE
               	movw	$0xfffe, -0x6e(%rbp)    # imm = 0xFFFE
               	movw	$0xfffe, -0x6c(%rbp)    # imm = 0xFFFE
               	movw	$0xfffe, -0x6a(%rbp)    # imm = 0xFFFE
               	movw	$0xfffe, -0x68(%rbp)    # imm = 0xFFFE
               	movw	$0xfffe, -0x66(%rbp)    # imm = 0xFFFE
               	movw	$0xfffe, -0x64(%rbp)    # imm = 0xFFFE
               	movw	$0xfffe, -0x62(%rbp)    # imm = 0xFFFE
               	movups	-0x70(%rbp), %xmm1
               	pmaddwd	%xmm1, %xmm0
               	movups	%xmm0, (%rcx)
               	movl	-0x38(%rbp), %eax
               	cmpl	$-0x6, %eax
               	jne	<addr>
               	movl	-0x2c(%rbp), %eax
               	cmpl	$-0x1e, %eax
               	je	<addr>
               	movl	$0x32, %eax
               	leave
               	retq
               	leaq	-0x48(%rbp), %rcx
               	leaq	-0x60(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movw	$0x12c, -0x60(%rbp)     # imm = 0x12C
               	movw	$0x12c, -0x5e(%rbp)     # imm = 0x12C
               	movw	$0x12c, -0x5c(%rbp)     # imm = 0x12C
               	movw	$0x12c, -0x5a(%rbp)     # imm = 0x12C
               	movw	$0x12c, -0x58(%rbp)     # imm = 0x12C
               	movw	$0x12c, -0x56(%rbp)     # imm = 0x12C
               	movw	$0x12c, -0x54(%rbp)     # imm = 0x12C
               	movw	$0x12c, -0x52(%rbp)     # imm = 0x12C
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movw	$0xfed4, -0x70(%rbp)    # imm = 0xFED4
               	movw	$0xfed4, -0x6e(%rbp)    # imm = 0xFED4
               	movw	$0xfed4, -0x6c(%rbp)    # imm = 0xFED4
               	movw	$0xfed4, -0x6a(%rbp)    # imm = 0xFED4
               	movw	$0xfed4, -0x68(%rbp)    # imm = 0xFED4
               	movw	$0xfed4, -0x66(%rbp)    # imm = 0xFED4
               	movw	$0xfed4, -0x64(%rbp)    # imm = 0xFED4
               	movw	$0xfed4, -0x62(%rbp)    # imm = 0xFED4
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x70(%rbp), %xmm1
               	packsswb	%xmm1, %xmm0
               	movups	%xmm0, (%rcx)
               	leaq	-0x48(%rbp), %rcx
               	movzbq	-0x48(%rbp), %rax
               	cmpl	$0x7f, %eax
               	jne	<addr>
               	movzbq	-0x41(%rbp), %rax
               	cmpl	$0x7f, %eax
               	jne	<addr>
               	movzbq	-0x40(%rbp), %rax
               	cmpl	$0x80, %eax
               	jne	<addr>
               	movzbq	-0x39(%rbp), %rax
               	cmpl	$0x80, %eax
               	je	<addr>
               	movl	$0x33, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movw	$0x12c, -0x60(%rbp)     # imm = 0x12C
               	movw	$0x12c, -0x5e(%rbp)     # imm = 0x12C
               	movw	$0x12c, -0x5c(%rbp)     # imm = 0x12C
               	movw	$0x12c, -0x5a(%rbp)     # imm = 0x12C
               	movw	$0x12c, -0x58(%rbp)     # imm = 0x12C
               	movw	$0x12c, -0x56(%rbp)     # imm = 0x12C
               	movw	$0x12c, -0x54(%rbp)     # imm = 0x12C
               	movw	$0x12c, -0x52(%rbp)     # imm = 0x12C
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movw	$0xfffb, -0x70(%rbp)    # imm = 0xFFFB
               	movw	$0xfffb, -0x6e(%rbp)    # imm = 0xFFFB
               	movw	$0xfffb, -0x6c(%rbp)    # imm = 0xFFFB
               	movw	$0xfffb, -0x6a(%rbp)    # imm = 0xFFFB
               	movw	$0xfffb, -0x68(%rbp)    # imm = 0xFFFB
               	movw	$0xfffb, -0x66(%rbp)    # imm = 0xFFFB
               	movw	$0xfffb, -0x64(%rbp)    # imm = 0xFFFB
               	movw	$0xfffb, -0x62(%rbp)    # imm = 0xFFFB
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x70(%rbp), %xmm1
               	packuswb	%xmm1, %xmm0
               	movups	%xmm0, (%rcx)
               	leaq	-0x48(%rbp), %rcx
               	movzbq	-0x48(%rbp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movzbq	-0x41(%rbp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	cmpb	$0x0, -0x40(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x39(%rbp)
               	je	<addr>
               	movl	$0x34, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x11170, -0x60(%rbp)   # imm = 0x11170
               	movl	$0x11170, -0x5c(%rbp)   # imm = 0x11170
               	movl	$0x11170, -0x58(%rbp)   # imm = 0x11170
               	movl	$0x11170, -0x54(%rbp)   # imm = 0x11170
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0xfffeee90, -0x70(%rbp) # imm = 0xFFFEEE90
               	movl	$0xfffeee90, -0x6c(%rbp) # imm = 0xFFFEEE90
               	movl	$0xfffeee90, -0x68(%rbp) # imm = 0xFFFEEE90
               	movl	$0xfffeee90, -0x64(%rbp) # imm = 0xFFFEEE90
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x70(%rbp), %xmm1
               	packssdw	%xmm1, %xmm0
               	movups	%xmm0, (%rcx)
               	movzbq	-0x48(%rbp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movzbq	-0x47(%rbp), %rax
               	cmpl	$0x7f, %eax
               	jne	<addr>
               	cmpb	$0x0, -0x40(%rbp)
               	jne	<addr>
               	movzbq	-0x3f(%rbp), %rax
               	cmpl	$0x80, %eax
               	je	<addr>
               	movl	$0x35, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movb	$0x0, -0x70(%rbp)
               	movb	$0x1, -0x6f(%rbp)
               	movb	$0x2, -0x6e(%rbp)
               	movb	$0x3, -0x6d(%rbp)
               	movb	$0x4, -0x6c(%rbp)
               	movb	$0x5, -0x6b(%rbp)
               	movb	$0x6, -0x6a(%rbp)
               	movb	$0x7, -0x69(%rbp)
               	movb	$0x8, -0x68(%rbp)
               	movb	$0x9, -0x67(%rbp)
               	movb	$0xa, -0x66(%rbp)
               	movb	$0xb, -0x65(%rbp)
               	movb	$0xc, -0x64(%rbp)
               	movb	$0xd, -0x63(%rbp)
               	movb	$0xe, -0x62(%rbp)
               	movb	$0xf, -0x61(%rbp)
               	movups	-0x70(%rbp), %xmm0
               	leaq	-0x48(%rbp), %rax
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm14
               	movapd	%xmm0, %xmm1
               	punpcklbw	%xmm14, %xmm1   # xmm1 = xmm1[0],xmm14[0],xmm1[1],xmm14[1],xmm1[2],xmm14[2],xmm1[3],xmm14[3],xmm1[4],xmm14[4],xmm1[5],xmm14[5],xmm1[6],xmm14[6],xmm1[7],xmm14[7]
               	movups	%xmm1, (%rax)
               	cmpb	$0x0, -0x48(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x47(%rbp)
               	jne	<addr>
               	movzbq	-0x46(%rbp), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movzbq	-0x3a(%rbp), %rcx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	cmpb	$0x0, -0x39(%rbp)
               	je	<addr>
               	movl	$0x36, %eax
               	leave
               	retq
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm14
               	movapd	%xmm0, %xmm1
               	punpckhbw	%xmm14, %xmm1   # xmm1 = xmm1[8],xmm14[8],xmm1[9],xmm14[9],xmm1[10],xmm14[10],xmm1[11],xmm14[11],xmm1[12],xmm14[12],xmm1[13],xmm14[13],xmm1[14],xmm14[14],xmm1[15],xmm14[15]
               	movups	%xmm1, (%rax)
               	leaq	-0x48(%rbp), %rax
               	movzbq	-0x48(%rbp), %rdx
               	cmpl	$0x8, %edx
               	jne	<addr>
               	cmpb	$0x0, -0x47(%rbp)
               	jne	<addr>
               	movzbq	-0x3a(%rbp), %rdx
               	cmpl	$0xf, %edx
               	jne	<addr>
               	cmpb	$0x0, -0x39(%rbp)
               	je	<addr>
               	movl	$0x37, %eax
               	leave
               	retq
               	movq	%rcx, %xmm14
               	movapd	%xmm0, %xmm1
               	punpcklwd	%xmm14, %xmm1   # xmm1 = xmm1[0],xmm14[0],xmm1[1],xmm14[1],xmm1[2],xmm14[2],xmm1[3],xmm14[3]
               	movups	%xmm1, (%rax)
               	cmpb	$0x0, -0x48(%rbp)
               	jne	<addr>
               	movzbq	-0x47(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x48(%rbp), %rax
               	cmpb	$0x0, -0x46(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x45(%rbp)
               	jne	<addr>
               	movzbq	-0x44(%rbp), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x38, %eax
               	leave
               	retq
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm14
               	punpckhwd	%xmm14, %xmm0   # xmm0 = xmm0[4],xmm14[4],xmm0[5],xmm14[5],xmm0[6],xmm14[6],xmm0[7],xmm14[7]
               	movups	%xmm0, (%rax)
               	movzbq	-0x48(%rbp), %rax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movzbq	-0x47(%rbp), %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	cmpb	$0x0, -0x46(%rbp)
               	jne	<addr>
               	movzbq	-0x44(%rbp), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x39, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x1, -0x70(%rbp)
               	movl	$0x2, -0x6c(%rbp)
               	movl	$0x3, -0x68(%rbp)
               	movl	$0x4, -0x64(%rbp)
               	movups	-0x70(%rbp), %xmm0
               	leaq	-0x70(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x5, -0x70(%rbp)
               	movl	$0x6, -0x6c(%rbp)
               	movl	$0x7, -0x68(%rbp)
               	movl	$0x8, -0x64(%rbp)
               	movups	-0x70(%rbp), %xmm1
               	leaq	-0x38(%rbp), %rax
               	movapd	%xmm0, %xmm2
               	punpckldq	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
               	movups	%xmm2, (%rax)
               	movl	-0x38(%rbp), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	-0x34(%rbp), %ecx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	-0x30(%rbp), %ecx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movl	-0x2c(%rbp), %ecx
               	cmpl	$0x6, %ecx
               	je	<addr>
               	movl	$0x3a, %eax
               	leave
               	retq
               	movapd	%xmm0, %xmm2
               	punpckhdq	%xmm1, %xmm2    # xmm2 = xmm2[2],xmm1[2],xmm2[3],xmm1[3]
               	movups	%xmm2, (%rax)
               	movl	-0x38(%rbp), %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movl	-0x34(%rbp), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rcx
               	movl	-0x30(%rbp), %eax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movl	-0x2c(%rbp), %eax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x3b, %eax
               	leave
               	retq
               	punpckhqdq	%xmm1, %xmm0    # xmm0 = xmm0[1],xmm1[1]
               	movups	%xmm0, (%rcx)
               	movl	-0x38(%rbp), %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movl	-0x34(%rbp), %eax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movl	-0x30(%rbp), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movl	-0x2c(%rbp), %eax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x3c, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movw	$0xfff0, -0x70(%rbp)    # imm = 0xFFF0
               	movw	$0xfff0, -0x6e(%rbp)    # imm = 0xFFF0
               	movw	$0xfff0, -0x6c(%rbp)    # imm = 0xFFF0
               	movw	$0xfff0, -0x6a(%rbp)    # imm = 0xFFF0
               	movw	$0xfff0, -0x68(%rbp)    # imm = 0xFFF0
               	movw	$0xfff0, -0x66(%rbp)    # imm = 0xFFF0
               	movw	$0xfff0, -0x64(%rbp)    # imm = 0xFFF0
               	movw	$0xfff0, -0x62(%rbp)    # imm = 0xFFF0
               	movups	-0x70(%rbp), %xmm0
               	psraw	$0x2, %xmm0
               	movups	%xmm0, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	-0x38(%rbp), %eax
               	cmpl	$0xfffcfffc, %eax       # imm = 0xFFFCFFFC
               	je	<addr>
               	movl	$0x3d, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movw	$0xfff0, -0x70(%rbp)    # imm = 0xFFF0
               	movw	$0xfff0, -0x6e(%rbp)    # imm = 0xFFF0
               	movw	$0xfff0, -0x6c(%rbp)    # imm = 0xFFF0
               	movw	$0xfff0, -0x6a(%rbp)    # imm = 0xFFF0
               	movw	$0xfff0, -0x68(%rbp)    # imm = 0xFFF0
               	movw	$0xfff0, -0x66(%rbp)    # imm = 0xFFF0
               	movw	$0xfff0, -0x64(%rbp)    # imm = 0xFFF0
               	movw	$0xfff0, -0x62(%rbp)    # imm = 0xFFF0
               	movups	-0x70(%rbp), %xmm0
               	psraw	$0x20, %xmm0
               	movups	%xmm0, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	-0x38(%rbp), %eax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x3e, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0xfffffff0, -0x70(%rbp) # imm = 0xFFFFFFF0
               	movl	$0xfffffff0, -0x6c(%rbp) # imm = 0xFFFFFFF0
               	movl	$0xfffffff0, -0x68(%rbp) # imm = 0xFFFFFFF0
               	movl	$0xfffffff0, -0x64(%rbp) # imm = 0xFFFFFFF0
               	movups	-0x70(%rbp), %xmm0
               	psrad	$0x2, %xmm0
               	movups	%xmm0, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	-0x38(%rbp), %eax
               	cmpl	$-0x4, %eax
               	je	<addr>
               	movl	$0x3f, %eax
               	leave
               	retq
               	movl	$0x3, %edx
               	leaq	-0x70(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movl	$0xffffffc0, -0x70(%rbp) # imm = 0xFFFFFFC0
               	movl	$0xffffffc0, -0x6c(%rbp) # imm = 0xFFFFFFC0
               	movl	$0xffffffc0, -0x68(%rbp) # imm = 0xFFFFFFC0
               	movl	$0xffffffc0, -0x64(%rbp) # imm = 0xFFFFFFC0
               	movups	-0x70(%rbp), %xmm0
               	movq	%rdx, %xmm14
               	psrad	%xmm14, %xmm0
               	movups	%xmm0, (%rcx)
               	movl	-0x38(%rbp), %eax
               	cmpl	$-0x8, %eax
               	je	<addr>
               	movl	$0x40, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movb	$0x0, -0x70(%rbp)
               	movb	$0x1, -0x6f(%rbp)
               	movb	$0x2, -0x6e(%rbp)
               	movb	$0x3, -0x6d(%rbp)
               	movb	$0x4, -0x6c(%rbp)
               	movb	$0x5, -0x6b(%rbp)
               	movb	$0x6, -0x6a(%rbp)
               	movb	$0x7, -0x69(%rbp)
               	movb	$0x8, -0x68(%rbp)
               	movb	$0x9, -0x67(%rbp)
               	movb	$0xa, -0x66(%rbp)
               	movb	$0xb, -0x65(%rbp)
               	movb	$0xc, -0x64(%rbp)
               	movb	$0xd, -0x63(%rbp)
               	movb	$0xe, -0x62(%rbp)
               	movb	$0xf, -0x61(%rbp)
               	movups	-0x70(%rbp), %xmm0
               	leaq	-0x48(%rbp), %rax
               	movapd	%xmm0, %xmm1
               	psrldq	$0x3, %xmm1             # xmm1 = xmm1[3,4,5,6,7,8,9,10,11,12,13,14,15],zero,zero,zero
               	movups	%xmm1, (%rax)
               	movzbq	-0x48(%rbp), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movzbq	-0x3c(%rbp), %rcx
               	cmpl	$0xf, %ecx
               	jne	<addr>
               	cmpb	$0x0, -0x3b(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x39(%rbp)
               	je	<addr>
               	movl	$0x41, %eax
               	leave
               	retq
               	movl	$0xbeef, %ecx           # imm = 0xBEEF
               	movapd	%xmm0, %xmm1
               	pinsrw	$0x2, %ecx, %xmm1
               	movups	%xmm1, (%rax)
               	movzbq	-0x44(%rbp), %rax
               	cmpl	$0xef, %eax
               	jne	<addr>
               	movzbq	-0x43(%rbp), %rax
               	cmpl	$0xbe, %eax
               	jne	<addr>
               	movzbq	-0x42(%rbp), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x42, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movb	$-0x80, -0x70(%rbp)
               	movb	$-0x80, -0x6f(%rbp)
               	movb	$-0x80, -0x6e(%rbp)
               	movb	$-0x80, -0x6d(%rbp)
               	movb	$-0x80, -0x6c(%rbp)
               	movb	$-0x80, -0x6b(%rbp)
               	movb	$-0x80, -0x6a(%rbp)
               	movb	$-0x80, -0x69(%rbp)
               	movb	$-0x80, -0x68(%rbp)
               	movb	$-0x80, -0x67(%rbp)
               	movb	$-0x80, -0x66(%rbp)
               	movb	$-0x80, -0x65(%rbp)
               	movb	$-0x80, -0x64(%rbp)
               	movb	$-0x80, -0x63(%rbp)
               	movb	$-0x80, -0x62(%rbp)
               	movb	$-0x80, -0x61(%rbp)
               	movups	-0x70(%rbp), %xmm1
               	pmovmskb	%xmm1, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x43, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	pmovmskb	%xmm14, %ecx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x44, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movb	$-0x80, -0x70(%rbp)
               	movb	%al, -0x6f(%rbp)
               	movb	%al, -0x6e(%rbp)
               	movb	%al, -0x6d(%rbp)
               	movb	%al, -0x6c(%rbp)
               	movb	%al, -0x6b(%rbp)
               	movb	$0x0, -0x6a(%rbp)
               	movb	$0x0, -0x69(%rbp)
               	movb	$0x0, -0x68(%rbp)
               	movb	$0x0, -0x67(%rbp)
               	movb	$0x0, -0x66(%rbp)
               	movb	$0x0, -0x65(%rbp)
               	movb	$0x0, -0x64(%rbp)
               	movb	$0x0, -0x63(%rbp)
               	movb	$0x0, -0x62(%rbp)
               	movb	$-0x80, -0x61(%rbp)
               	movups	-0x70(%rbp), %xmm1
               	pmovmskb	%xmm1, %eax
               	cmpl	$0x8001, %eax           # imm = 0x8001
               	je	<addr>
               	movl	$0x45, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x60(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movb	$0xf, -0x60(%rbp)
               	movb	$0xf, -0x5f(%rbp)
               	movb	$0xf, -0x5e(%rbp)
               	movb	$0xf, -0x5d(%rbp)
               	movb	$0xf, -0x5c(%rbp)
               	movb	$0xf, -0x5b(%rbp)
               	movb	$0xf, -0x5a(%rbp)
               	movb	$0xf, -0x59(%rbp)
               	movb	$0xf, -0x58(%rbp)
               	movb	$0xf, -0x57(%rbp)
               	movb	$0xf, -0x56(%rbp)
               	movb	$0xf, -0x55(%rbp)
               	movb	$0xf, -0x54(%rbp)
               	movb	$0xf, -0x53(%rbp)
               	movb	$0xf, -0x52(%rbp)
               	movb	$0xf, -0x51(%rbp)
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movb	$0x33, -0x70(%rbp)
               	movb	$0x33, -0x6f(%rbp)
               	movb	$0x33, -0x6e(%rbp)
               	movb	$0x33, -0x6d(%rbp)
               	movb	$0x33, -0x6c(%rbp)
               	movb	$0x33, -0x6b(%rbp)
               	movb	$0x33, -0x6a(%rbp)
               	movb	$0x33, -0x69(%rbp)
               	movb	$0x33, -0x68(%rbp)
               	movb	$0x33, -0x67(%rbp)
               	movb	$0x33, -0x66(%rbp)
               	movb	$0x33, -0x65(%rbp)
               	movb	$0x33, -0x64(%rbp)
               	movb	$0x33, -0x63(%rbp)
               	movb	$0x33, -0x62(%rbp)
               	movb	$0x33, -0x61(%rbp)
               	movups	-0x60(%rbp), %xmm1
               	movups	-0x70(%rbp), %xmm2
               	pandn	%xmm2, %xmm1
               	movups	%xmm1, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	-0x38(%rbp), %eax
               	cmpl	$0x30303030, %eax       # imm = 0x30303030
               	je	<addr>
               	movl	$0x46, %eax
               	leave
               	retq
               	movapd	%xmm0, %xmm1
               	pcmpeqb	%xmm0, %xmm1
               	movups	%xmm1, (%rcx)
               	movl	-0x38(%rbp), %eax
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	movl	-0x2c(%rbp), %eax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x47, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movw	$0x7, -0x60(%rbp)
               	movw	$0x7, -0x5e(%rbp)
               	movw	$0x7, -0x5c(%rbp)
               	movw	$0x7, -0x5a(%rbp)
               	movw	$0x7, -0x58(%rbp)
               	movw	$0x7, -0x56(%rbp)
               	movw	$0x7, -0x54(%rbp)
               	movw	$0x7, -0x52(%rbp)
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movw	$0x8, -0x70(%rbp)
               	movw	$0x8, -0x6e(%rbp)
               	movw	$0x8, -0x6c(%rbp)
               	movw	$0x8, -0x6a(%rbp)
               	movw	$0x8, -0x68(%rbp)
               	movw	$0x8, -0x66(%rbp)
               	movw	$0x8, -0x64(%rbp)
               	movw	$0x8, -0x62(%rbp)
               	movups	-0x60(%rbp), %xmm1
               	movups	-0x70(%rbp), %xmm2
               	pcmpeqw	%xmm2, %xmm1
               	movups	%xmm1, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	cmpl	$0x0, -0x38(%rbp)
               	je	<addr>
               	movl	$0x48, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x7, -0x60(%rbp)
               	movl	$0x7, -0x5c(%rbp)
               	movl	$0x7, -0x58(%rbp)
               	movl	$0x7, -0x54(%rbp)
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x7, -0x70(%rbp)
               	movl	$0x7, -0x6c(%rbp)
               	movl	$0x7, -0x68(%rbp)
               	movl	$0x7, -0x64(%rbp)
               	movups	-0x60(%rbp), %xmm1
               	movups	-0x70(%rbp), %xmm2
               	pcmpeqd	%xmm2, %xmm1
               	movups	%xmm1, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	-0x38(%rbp), %eax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x49, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movw	$0xffff, -0x60(%rbp)    # imm = 0xFFFF
               	movw	$0xffff, -0x5e(%rbp)    # imm = 0xFFFF
               	movw	$0xffff, -0x5c(%rbp)    # imm = 0xFFFF
               	movw	$0xffff, -0x5a(%rbp)    # imm = 0xFFFF
               	movw	$0xffff, -0x58(%rbp)    # imm = 0xFFFF
               	movw	$0xffff, -0x56(%rbp)    # imm = 0xFFFF
               	movw	$0xffff, -0x54(%rbp)    # imm = 0xFFFF
               	movw	$0xffff, -0x52(%rbp)    # imm = 0xFFFF
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movw	$0xfffe, -0x70(%rbp)    # imm = 0xFFFE
               	movw	$0xfffe, -0x6e(%rbp)    # imm = 0xFFFE
               	movw	$0xfffe, -0x6c(%rbp)    # imm = 0xFFFE
               	movw	$0xfffe, -0x6a(%rbp)    # imm = 0xFFFE
               	movw	$0xfffe, -0x68(%rbp)    # imm = 0xFFFE
               	movw	$0xfffe, -0x66(%rbp)    # imm = 0xFFFE
               	movw	$0xfffe, -0x64(%rbp)    # imm = 0xFFFE
               	movw	$0xfffe, -0x62(%rbp)    # imm = 0xFFFE
               	movups	-0x60(%rbp), %xmm1
               	movups	-0x70(%rbp), %xmm2
               	pcmpgtw	%xmm2, %xmm1
               	movups	%xmm1, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	-0x38(%rbp), %eax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x4a, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0xfffffffe, -0x60(%rbp) # imm = 0xFFFFFFFE
               	movl	$0xfffffffe, -0x5c(%rbp) # imm = 0xFFFFFFFE
               	movl	$0xfffffffe, -0x58(%rbp) # imm = 0xFFFFFFFE
               	movl	$0xfffffffe, -0x54(%rbp) # imm = 0xFFFFFFFE
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0xffffffff, -0x70(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0x6c(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0x68(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0x64(%rbp) # imm = 0xFFFFFFFF
               	movups	-0x70(%rbp), %xmm1
               	movups	-0x60(%rbp), %xmm2
               	pcmpgtd	%xmm2, %xmm1
               	movups	%xmm1, (%rcx)
               	movl	-0x38(%rbp), %eax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x4b, %eax
               	leave
               	retq
               	movb	$0x1, -0x48(%rbp)
               	movb	$0x2, -0x47(%rbp)
               	movb	$0x3, -0x46(%rbp)
               	movb	$0x4, -0x45(%rbp)
               	movb	$0x5, -0x44(%rbp)
               	movb	$0x6, -0x43(%rbp)
               	movb	$0x7, -0x42(%rbp)
               	movb	$0x8, -0x41(%rbp)
               	movb	$0x9, -0x40(%rbp)
               	movb	$0xa, -0x3f(%rbp)
               	movb	$0xb, -0x3e(%rbp)
               	movb	$0xc, -0x3d(%rbp)
               	movb	$0xd, -0x3c(%rbp)
               	movb	$0xe, -0x3b(%rbp)
               	movb	$0xf, -0x3a(%rbp)
               	movb	$0x10, -0x39(%rbp)
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x70(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	-0x48(%rbp), %rcx
               	movq	%rcx, -0x70(%rbp)
               	movq	$0x0, -0x68(%rbp)
               	movups	-0x70(%rbp), %xmm1
               	movups	%xmm1, (%rax)
               	movl	-0x38(%rbp), %eax
               	cmpl	$0x4030201, %eax        # imm = 0x4030201
               	jne	<addr>
               	movl	-0x34(%rbp), %eax
               	cmpl	$0x8070605, %eax        # imm = 0x8070605
               	jne	<addr>
               	cmpl	$0x0, -0x30(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x2c(%rbp)
               	je	<addr>
               	movl	$0x4c, %eax
               	leave
               	retq
               	movabsq	$-0x1111111111111112, %rax # imm = 0xEEEEEEEEEEEEEEEE
               	movq	%rax, -0x48(%rbp)
               	movq	%rax, -0x40(%rbp)
               	leaq	-0x70(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x1, -0x70(%rbp)
               	movl	$0x2, -0x6c(%rbp)
               	movl	$0x3, -0x68(%rbp)
               	movl	$0x4, -0x64(%rbp)
               	movq	-0x70(%rbp), %rax
               	movq	%rax, -0x48(%rbp)
               	leaq	-0x48(%rbp), %rcx
               	movzbq	-0x48(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movzbq	-0x44(%rbp), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movzbq	-0x40(%rbp), %rax
               	cmpl	$0xee, %eax
               	je	<addr>
               	movl	$0x4d, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movups	%xmm0, (%rax)
               	movups	(%rax), %xmm0
               	movups	%xmm0, (%rcx)
               	cmpb	$0x0, -0x48(%rbp)
               	je	<addr>
               	movl	$0x4e, %eax
               	leave
               	retq
               	movzbq	-0x47(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movzbq	-0x46(%rbp), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movzbq	-0x45(%rbp), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movzbq	-0x44(%rbp), %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movzbq	-0x43(%rbp), %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movzbq	-0x42(%rbp), %rax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movzbq	-0x41(%rbp), %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movzbq	-0x40(%rbp), %rax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movzbq	-0x3f(%rbp), %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movzbq	-0x3e(%rbp), %rax
               	cmpl	$0xa, %eax
               	jne	<addr>
               	movzbq	-0x3d(%rbp), %rax
               	cmpl	$0xb, %eax
               	jne	<addr>
               	movzbq	-0x3c(%rbp), %rax
               	cmpl	$0xc, %eax
               	jne	<addr>
               	movzbq	-0x3b(%rbp), %rax
               	cmpl	$0xd, %eax
               	jne	<addr>
               	movzbq	-0x3a(%rbp), %rax
               	cmpl	$0xe, %eax
               	jne	<addr>
               	movzbq	-0x39(%rbp), %rax
               	cmpl	$0xf, %eax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0xffffffff, -0x70(%rbp) # imm = 0xFFFFFFFF
               	xorl	%eax, %eax
               	movl	%eax, -0x6c(%rbp)
               	movl	%eax, -0x68(%rbp)
               	movl	%eax, -0x64(%rbp)
               	movups	-0x70(%rbp), %xmm0
               	movups	%xmm0, (%rcx)
               	movl	-0x38(%rbp), %ecx
               	cmpl	$-0x1, %ecx
               	jne	<addr>
               	cmpl	$0x0, -0x34(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x2c(%rbp)
               	je	<addr>
               	movl	$0x50, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rdx
               	leaq	0x1(%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	movups	-0x15(%rbp), %xmm0
               	leaq	-0x48(%rbp), %rcx
               	movups	%xmm0, (%rcx)
               	movzbq	-0x48(%rbp), %rcx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movzbq	-0x39(%rbp), %rcx
               	cmpl	$0x13, %ecx
               	je	<addr>
               	movl	$0x51, %eax
               	leave
               	retq
               	addq	$0x5, %rax
               	movq	$0x0, (%rax)
               	movq	$0x0, 0x8(%rax)
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
