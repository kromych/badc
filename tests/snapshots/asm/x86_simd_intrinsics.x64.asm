
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
               	subq	$0x68, %rsp
               	pushq	%rbx
               	movl	$0x4, %eax
               	movl	$0x3, %ecx
               	movl	$0x2, %esi
               	movl	$0x1, %edi
               	xorl	%edx, %edx
               	vmovd	%edi, %xmm0
               	vpinsrd	$0x1, %esi, %xmm0, %xmm0
               	vpinsrd	$0x2, %ecx, %xmm0, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	movl	$0x190, %esi            # imm = 0x190
               	movl	$0x12c, %edi            # imm = 0x12C
               	movl	$0xc8, %r8d
               	movl	$0x64, %r9d
               	vmovd	%r9d, %xmm1
               	vpinsrd	$0x1, %r8d, %xmm1, %xmm1
               	vpinsrd	$0x2, %edi, %xmm1, %xmm1
               	vpinsrd	$0x3, %esi, %xmm1, %xmm1
               	movapd	%xmm0, %xmm2
               	paddd	%xmm1, %xmm2
               	vpextrd	$0x0, %xmm2, %edx
               	cmpl	$0x65, %edx
               	jne	<addr>
               	vpextrd	$0x1, %xmm2, %edx
               	cmpl	$0xca, %edx
               	jne	<addr>
               	vpextrd	$0x2, %xmm2, %edx
               	cmpl	$0x12f, %edx            # imm = 0x12F
               	jne	<addr>
               	vpextrd	$0x3, %xmm2, %edx
               	cmpl	$0x194, %edx            # imm = 0x194
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movapd	%xmm0, %xmm2
               	pxor	%xmm1, %xmm2
               	vpextrd	$0x0, %xmm2, %edx
               	cmpq	$0x65, %rdx
               	jne	<addr>
               	vpextrd	$0x3, %xmm2, %edx
               	cmpq	$0x194, %rdx            # imm = 0x194
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movapd	%xmm0, %xmm2
               	por	%xmm1, %xmm2
               	vpextrd	$0x1, %xmm2, %edx
               	cmpq	$0xca, %rdx
               	je	<addr>
               	movq	%rcx, %rax
               	popq	%rbx
               	leave
               	retq
               	pand	%xmm1, %xmm0
               	vpextrd	$0x2, %xmm0, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	$-0x1, %rcx
               	vmovd	%ecx, %xmm0
               	vpinsrd	$0x1, %eax, %xmm0, %xmm0
               	vpinsrd	$0x2, %ecx, %xmm0, %xmm0
               	movapd	%xmm0, %xmm1
               	vpinsrd	$0x3, %eax, %xmm1, %xmm1
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	vmovd	%edx, %xmm0
               	vpinsrd	$0x1, %ecx, %xmm0, %xmm0
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	movapd	%xmm1, %xmm2
               	paddd	%xmm0, %xmm2
               	vpextrd	$0x0, %xmm2, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	vpextrd	$0x1, %xmm2, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movapd	%xmm1, %xmm2
               	paddq	%xmm0, %xmm2
               	vpextrd	$0x0, %xmm2, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	vpextrd	$0x1, %xmm2, %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	paddq	%xmm0, %xmm1
               	movapd	%xmm1, %xmm15
               	psubq	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	vpextrd	$0x0, %xmm0, %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	jne	<addr>
               	vpextrd	$0x1, %xmm0, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x11223344, %eax       # imm = 0x11223344
               	movl	$0x55667788, %edx       # imm = 0x55667788
               	movq	$-0x66554434, %rsi      # imm = 0x99AABBCC
               	movq	$-0x22110100, %rdi      # imm = 0xDDEEFF00
               	vmovd	%edi, %xmm0
               	vpinsrd	$0x1, %esi, %xmm0, %xmm0
               	vpinsrd	$0x2, %edx, %xmm0, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	movapd	%xmm0, %xmm1
               	pslld	$0x4, %xmm1
               	vpextrd	$0x3, %xmm1, %eax
               	cmpq	$0x12233440, %rax       # imm = 0x12233440
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movapd	%xmm0, %xmm1
               	psrld	$0x4, %xmm1
               	vpextrd	$0x3, %xmm1, %eax
               	cmpq	$0x1122334, %rax        # imm = 0x1122334
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
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
               	popq	%rbx
               	leave
               	retq
               	movapd	%xmm0, %xmm1
               	psrld	$0x20, %xmm1
               	vpextrd	$0x0, %xmm1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	vpextrd	$0x3, %xmm1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	movapd	%xmm0, %xmm1
               	psllq	$0x8, %xmm1
               	vpextrd	$0x0, %xmm1, %eax
               	movl	$0xeeff0000, %r11d      # imm = 0xEEFF0000
               	cmpq	%r11, %rax
               	jne	<addr>
               	vpextrd	$0x1, %xmm1, %eax
               	movl	$0xaabbccdd, %r11d      # imm = 0xAABBCCDD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	leave
               	retq
               	movapd	%xmm0, %xmm1
               	psrlq	$0x8, %xmm1
               	vpextrd	$0x0, %xmm1, %eax
               	movl	$0xccddeeff, %r11d      # imm = 0xCCDDEEFF
               	cmpq	%r11, %rax
               	jne	<addr>
               	vpextrd	$0x1, %xmm1, %eax
               	cmpq	$0x99aabb, %rax         # imm = 0x99AABB
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	leave
               	retq
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpextrd	$0x0, %xmm0, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	vpextrd	$0x1, %xmm0, %eax
               	movl	$0xddeeff00, %r11d      # imm = 0xDDEEFF00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xf, %eax
               	movl	$0xe, %edx
               	movl	$0xd, %esi
               	movl	$0xc, %edi
               	movl	$0xb, %r8d
               	movl	$0xa, %r9d
               	xorl	%ebx, %ebx
               	movq	%rcx, %xmm0
               	vpinsrb	$0x0, %ebx, %xmm0, %xmm0
               	movl	$0x1, %ecx
               	vpinsrb	$0x1, %ecx, %xmm0, %xmm0
               	movl	$0x2, %ecx
               	vpinsrb	$0x2, %ecx, %xmm0, %xmm0
               	movl	$0x3, %ecx
               	vpinsrb	$0x3, %ecx, %xmm0, %xmm0
               	movl	$0x4, %ecx
               	vpinsrb	$0x4, %ecx, %xmm0, %xmm0
               	movl	$0x5, %ecx
               	vpinsrb	$0x5, %ecx, %xmm0, %xmm0
               	movl	$0x6, %ecx
               	vpinsrb	$0x6, %ecx, %xmm0, %xmm0
               	movl	$0x7, %ecx
               	vpinsrb	$0x7, %ecx, %xmm0, %xmm0
               	movl	$0x8, %ecx
               	vpinsrb	$0x8, %ecx, %xmm0, %xmm0
               	movl	$0x9, %ecx
               	vpinsrb	$0x9, %ecx, %xmm0, %xmm0
               	vpinsrb	$0xa, %r9d, %xmm0, %xmm0
               	vpinsrb	$0xb, %r8d, %xmm0, %xmm0
               	vpinsrb	$0xc, %edi, %xmm0, %xmm0
               	vpinsrb	$0xd, %esi, %xmm0, %xmm0
               	vpinsrb	$0xe, %edx, %xmm0, %xmm0
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	leaq	-0x38(%rbp), %rax
               	movapd	%xmm0, %xmm1
               	psllw	$0x8, %xmm1
               	movups	%xmm1, (%rax)
               	cmpb	$0x0, -0x38(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x37(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x36(%rbp)
               	jne	<addr>
               	movzbq	-0x35(%rbp), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	leave
               	retq
               	movapd	%xmm0, %xmm1
               	psrlw	$0x8, %xmm1
               	movups	%xmm1, (%rax)
               	movzbq	-0x38(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	cmpb	$0x0, -0x37(%rbp)
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movzbq	-0x36(%rbp), %rcx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	leave
               	retq
               	pshuflw	$0x1b, %xmm0, %xmm1     # xmm1 = xmm0[3,2,1,0,4,5,6,7]
               	movups	%xmm1, (%rax)
               	movzbq	-0x38(%rbp), %rcx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movzbq	-0x37(%rbp), %rcx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	cmpb	$0x0, -0x32(%rbp)
               	jne	<addr>
               	movzbq	-0x31(%rbp), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movzbq	-0x30(%rbp), %rcx
               	cmpl	$0x8, %ecx
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	leave
               	retq
               	pshufhw	$0x1b, %xmm0, %xmm0     # xmm0 = xmm0[0,1,2,3,7,6,5,4]
               	movups	%xmm0, (%rax)
               	cmpb	$0x0, -0x38(%rbp)
               	jne	<addr>
               	movzbq	-0x30(%rbp), %rax
               	cmpl	$0xe, %eax
               	jne	<addr>
               	movzbq	-0x2f(%rbp), %rax
               	cmpl	$0xf, %eax
               	jne	<addr>
               	movzbq	-0x2a(%rbp), %rax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movzbq	-0x29(%rbp), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %ecx
               	movl	$0x2, %edx
               	movl	$0x1, %esi
               	xorl	%eax, %eax
               	vmovd	%eax, %xmm0
               	vpinsrd	$0x1, %esi, %xmm0, %xmm0
               	vpinsrd	$0x2, %edx, %xmm0, %xmm0
               	vpinsrd	$0x3, %ecx, %xmm0, %xmm0
               	pshufd	$0x93, %xmm0, %xmm0     # xmm0 = xmm0[3,0,1,2]
               	vpextrd	$0x0, %xmm0, %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	vpextrd	$0x1, %xmm0, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	vpextrd	$0x2, %xmm0, %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %ecx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xf, %ecx
               	movl	$0xe, %edx
               	movl	$0xd, %esi
               	movl	$0xc, %edi
               	movl	$0xb, %r8d
               	movl	$0xa, %r9d
               	xorl	%ebx, %ebx
               	movq	%rax, %xmm0
               	vpinsrb	$0x0, %ebx, %xmm0, %xmm0
               	movl	$0x1, %eax
               	vpinsrb	$0x1, %eax, %xmm0, %xmm0
               	movl	$0x2, %ebx
               	vpinsrb	$0x2, %ebx, %xmm0, %xmm0
               	movl	$0x3, %ebx
               	vpinsrb	$0x3, %ebx, %xmm0, %xmm0
               	movl	$0x4, %ebx
               	vpinsrb	$0x4, %ebx, %xmm0, %xmm0
               	movl	$0x5, %ebx
               	vpinsrb	$0x5, %ebx, %xmm0, %xmm0
               	movl	$0x6, %ebx
               	vpinsrb	$0x6, %ebx, %xmm0, %xmm0
               	movl	$0x7, %ebx
               	vpinsrb	$0x7, %ebx, %xmm0, %xmm0
               	movl	$0x8, %ebx
               	vpinsrb	$0x8, %ebx, %xmm0, %xmm0
               	movl	$0x9, %ebx
               	vpinsrb	$0x9, %ebx, %xmm0, %xmm0
               	vpinsrb	$0xa, %r9d, %xmm0, %xmm0
               	vpinsrb	$0xb, %r8d, %xmm0, %xmm0
               	vpinsrb	$0xc, %edi, %xmm0, %xmm0
               	vpinsrb	$0xd, %esi, %xmm0, %xmm0
               	vpinsrb	$0xe, %edx, %xmm0, %xmm0
               	vpinsrb	$0xf, %ecx, %xmm0, %xmm0
               	movq	$-0x80, %rdx
               	movl	$0x2, %esi
               	movl	$0x3, %edi
               	movl	$0x4, %r8d
               	movl	$0x5, %r9d
               	xorl	%ecx, %ecx
               	movl	$0xf, %ebx
               	movq	%rcx, %xmm1
               	vpinsrb	$0x0, %ebx, %xmm1, %xmm1
               	movl	$0xe, %ecx
               	vpinsrb	$0x1, %ecx, %xmm1, %xmm1
               	movl	$0xd, %ecx
               	vpinsrb	$0x2, %ecx, %xmm1, %xmm1
               	movl	$0xc, %ecx
               	vpinsrb	$0x3, %ecx, %xmm1, %xmm1
               	movl	$0xb, %ecx
               	vpinsrb	$0x4, %ecx, %xmm1, %xmm1
               	movl	$0xa, %ecx
               	vpinsrb	$0x5, %ecx, %xmm1, %xmm1
               	movl	$0x9, %ecx
               	vpinsrb	$0x6, %ecx, %xmm1, %xmm1
               	movl	$0x8, %ebx
               	vpinsrb	$0x7, %ebx, %xmm1, %xmm1
               	movl	$0x7, %ebx
               	vpinsrb	$0x8, %ebx, %xmm1, %xmm1
               	movl	$0x6, %ebx
               	vpinsrb	$0x9, %ebx, %xmm1, %xmm1
               	vpinsrb	$0xa, %r9d, %xmm1, %xmm1
               	vpinsrb	$0xb, %r8d, %xmm1, %xmm1
               	vpinsrb	$0xc, %edi, %xmm1, %xmm1
               	vpinsrb	$0xd, %esi, %xmm1, %xmm1
               	vpinsrb	$0xe, %eax, %xmm1, %xmm1
               	vpinsrb	$0xf, %edx, %xmm1, %xmm1
               	leaq	-0x38(%rbp), %rax
               	pshufb	%xmm1, %xmm0
               	movups	%xmm0, (%rax)
               	movzbq	-0x38(%rbp), %rax
               	cmpl	$0xf, %eax
               	jne	<addr>
               	movzbq	-0x2a(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	cmpb	$0x0, -0x29(%rbp)
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x9, %esi
               	movl	$0x1, %edx
               	xorl	%eax, %eax
               	vmovd	%edx, %xmm0
               	vpinsrd	$0x1, %edx, %xmm0, %xmm0
               	vpinsrd	$0x2, %esi, %xmm0, %xmm0
               	vpinsrd	$0x3, %ecx, %xmm0, %xmm0
               	movl	$0x8, %ecx
               	movl	$0x2, %edx
               	vmovd	%edx, %xmm1
               	vpinsrd	$0x1, %edx, %xmm1, %xmm1
               	vpinsrd	$0x2, %ecx, %xmm1, %xmm1
               	movapd	%xmm1, %xmm2
               	vpinsrd	$0x3, %ecx, %xmm2, %xmm2
               	movapd	%xmm0, %xmm1
               	punpcklqdq	%xmm2, %xmm1    # xmm1 = xmm1[0],xmm2[0]
               	vpextrd	$0x0, %xmm1, %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	vpextrd	$0x1, %xmm1, %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	vpextrd	$0x2, %xmm1, %ecx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	vpextrd	$0x3, %xmm1, %ecx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	leave
               	retq
               	movapd	%xmm0, %xmm1
               	pcmpeqq	%xmm0, %xmm1
               	vpextrd	$0x0, %xmm1, %ecx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rcx
               	jne	<addr>
               	vpextrd	$0x3, %xmm1, %ecx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	leave
               	retq
               	pcmpeqq	%xmm2, %xmm0
               	vpextrd	$0x0, %xmm0, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x17, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x77778888, %ecx       # imm = 0x77778888
               	movl	$0x55556666, %edx       # imm = 0x55556666
               	movl	$0x33334444, %esi       # imm = 0x33334444
               	movl	$0x11112222, %edi       # imm = 0x11112222
               	vmovd	%edi, %xmm0
               	vpinsrd	$0x1, %esi, %xmm0, %xmm0
               	vpinsrd	$0x2, %edx, %xmm0, %xmm0
               	vpinsrd	$0x3, %ecx, %xmm0, %xmm0
               	pextrw	$0x0, %xmm0, %ecx
               	cmpl	$0x2222, %ecx           # imm = 0x2222
               	jne	<addr>
               	pextrw	$0x7, %xmm0, %ecx
               	cmpl	$0x7777, %ecx           # imm = 0x7777
               	je	<addr>
               	movl	$0x18, %eax
               	popq	%rbx
               	leave
               	retq
               	pextrd	$0x2, %xmm0, %ecx
               	cmpl	$0x55556666, %ecx       # imm = 0x55556666
               	je	<addr>
               	movl	$0x19, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xa0b0c0d, %ecx        # imm = 0xA0B0C0D
               	pinsrd	$0x1, %ecx, %xmm0
               	vpextrd	$0x1, %xmm0, %ecx
               	cmpq	$0xa0b0c0d, %rcx        # imm = 0xA0B0C0D
               	jne	<addr>
               	vpextrd	$0x0, %xmm0, %ecx
               	cmpq	$0x11112222, %rcx       # imm = 0x11112222
               	je	<addr>
               	movl	$0x1a, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	vmovq	%rdx, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vmovq	%rcx, %xmm1
               	movapd	%xmm1, %xmm2
               	vpinsrq	$0x1, %rdx, %xmm2, %xmm2
               	movapd	%xmm0, %xmm1
               	pclmulqdq	$0x0, %xmm0, %xmm1
               	vpextrd	$0x0, %xmm1, %eax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	vpextrd	$0x1, %xmm1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1b, %eax
               	popq	%rbx
               	leave
               	retq
               	pclmulqdq	$0x10, %xmm2, %xmm0
               	vpextrd	$0x0, %xmm0, %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x1c, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x4, %esi
               	movl	$0x2, %edi
               	movl	$0x1, %eax
               	vmovd	%eax, %xmm0
               	vpinsrd	$0x1, %edi, %xmm0, %xmm0
               	vpinsrd	$0x2, %edx, %xmm0, %xmm0
               	vpinsrd	$0x3, %esi, %xmm0, %xmm0
               	movl	$0x8, %ecx
               	movl	$0x7, %edx
               	movl	$0x6, %esi
               	movl	$0x5, %edi
               	xorl	%r8d, %r8d
               	vmovd	%edi, %xmm1
               	vpinsrd	$0x1, %esi, %xmm1, %xmm1
               	vpinsrd	$0x2, %edx, %xmm1, %xmm1
               	vpinsrd	$0x3, %ecx, %xmm1, %xmm1
               	shufpd	$0x1, %xmm1, %xmm0      # xmm0 = xmm0[1],xmm1[0]
               	vpextrd	$0x0, %xmm0, %edx
               	cmpl	$0x3, %edx
               	jne	<addr>
               	vpextrd	$0x1, %xmm0, %edx
               	cmpl	$0x4, %edx
               	jne	<addr>
               	vpextrd	$0x2, %xmm0, %edx
               	cmpl	$0x5, %edx
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %edx
               	cmpl	$0x6, %edx
               	je	<addr>
               	movl	$0x1d, %eax
               	popq	%rbx
               	leave
               	retq
               	movb	%al, -0x38(%rbp)
               	movb	%cl, -0x37(%rbp)
               	movb	$0xf, -0x36(%rbp)
               	movb	$0x16, -0x35(%rbp)
               	movb	$0x1d, -0x34(%rbp)
               	movb	$0x24, -0x33(%rbp)
               	movb	$0x2b, -0x32(%rbp)
               	movb	$0x32, -0x31(%rbp)
               	movb	$0x39, -0x30(%rbp)
               	movb	$0x40, -0x2f(%rbp)
               	movb	$0x47, -0x2e(%rbp)
               	movb	$0x4e, -0x2d(%rbp)
               	leaq	-0x38(%rbp), %rdi
               	movb	$0x55, -0x2c(%rbp)
               	movb	$0x5c, -0x2b(%rbp)
               	movb	$0x63, -0x2a(%rbp)
               	movb	$0x6a, -0x29(%rbp)
               	callq	<addr>
               	leaq	-0x38(%rbp), %rcx
               	movq	$0x0, -0x38(%rbp)
               	movq	$0x0, -0x30(%rbp)
               	movups	%xmm0, (%rcx)
               	movzbq	-0x38(%rbp), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1f, %eax
               	popq	%rbx
               	leave
               	retq
               	movzbq	-0x37(%rbp), %rax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movzbq	-0x36(%rbp), %rax
               	cmpl	$0xf, %eax
               	jne	<addr>
               	movzbq	-0x35(%rbp), %rax
               	cmpl	$0x16, %eax
               	jne	<addr>
               	movzbq	-0x34(%rbp), %rax
               	cmpl	$0x1d, %eax
               	jne	<addr>
               	movzbq	-0x33(%rbp), %rax
               	cmpl	$0x24, %eax
               	jne	<addr>
               	movzbq	-0x32(%rbp), %rax
               	cmpl	$0x2b, %eax
               	jne	<addr>
               	movzbq	-0x31(%rbp), %rax
               	cmpl	$0x32, %eax
               	jne	<addr>
               	movzbq	-0x30(%rbp), %rax
               	cmpl	$0x39, %eax
               	jne	<addr>
               	movzbq	-0x2f(%rbp), %rax
               	cmpl	$0x40, %eax
               	jne	<addr>
               	movzbq	-0x2e(%rbp), %rax
               	cmpl	$0x47, %eax
               	jne	<addr>
               	movzbq	-0x2d(%rbp), %rax
               	cmpl	$0x4e, %eax
               	jne	<addr>
               	movzbq	-0x2c(%rbp), %rax
               	cmpl	$0x55, %eax
               	jne	<addr>
               	movzbq	-0x2b(%rbp), %rax
               	cmpl	$0x5c, %eax
               	jne	<addr>
               	movzbq	-0x2a(%rbp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	-0x29(%rbp), %rax
               	cmpl	$0x6a, %eax
               	jne	<addr>
               	leaq	-0x50(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movw	$0x0, -0x50(%rbp)
               	movw	$0x1, -0x4e(%rbp)
               	movw	$0x2, -0x4c(%rbp)
               	movw	$0x3, -0x4a(%rbp)
               	leaq	-0x50(%rbp), %r9
               	movw	$0x4, -0x48(%rbp)
               	movw	$0x5, -0x46(%rbp)
               	movw	$0x6, -0x44(%rbp)
               	movw	$0x7, -0x42(%rbp)
               	leaq	<rip>, %rdi # <addr>
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x21, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x50(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movw	$0x7, -0x50(%rbp)
               	movw	$0x6, -0x4e(%rbp)
               	movw	$0x5, -0x4c(%rbp)
               	movw	$0x4, -0x4a(%rbp)
               	movw	$0x3, -0x48(%rbp)
               	movw	$0x2, -0x46(%rbp)
               	movw	$0x1, -0x44(%rbp)
               	movw	$0x0, -0x42(%rbp)
               	leaq	-0x50(%rbp), %r9
               	leaq	<rip>, %rdi # <addr>
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x22, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x50(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movb	$0x0, -0x50(%rbp)
               	movb	$0x1, -0x4f(%rbp)
               	movb	$0x2, -0x4e(%rbp)
               	movb	$0x3, -0x4d(%rbp)
               	movb	$0x4, -0x4c(%rbp)
               	movb	$0x5, -0x4b(%rbp)
               	movb	$0x6, -0x4a(%rbp)
               	movb	$0x7, -0x49(%rbp)
               	movb	$0x8, -0x48(%rbp)
               	movb	$0x9, -0x47(%rbp)
               	leaq	-0x50(%rbp), %r9
               	movb	$0xa, -0x46(%rbp)
               	movb	$0xb, -0x45(%rbp)
               	movb	$0xc, -0x44(%rbp)
               	movb	$0xd, -0x43(%rbp)
               	movb	$0xe, -0x42(%rbp)
               	movb	$0xf, -0x41(%rbp)
               	leaq	<rip>, %rdi # <addr>
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x23, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x50(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movb	$0xf, -0x50(%rbp)
               	movb	$0xe, -0x4f(%rbp)
               	movb	$0xd, -0x4e(%rbp)
               	movb	$0xc, -0x4d(%rbp)
               	movb	$0xb, -0x4c(%rbp)
               	movb	$0xa, -0x4b(%rbp)
               	movb	$0x9, -0x4a(%rbp)
               	movb	$0x8, -0x49(%rbp)
               	movb	$0x7, -0x48(%rbp)
               	movb	$0x6, -0x47(%rbp)
               	movb	$0x5, -0x46(%rbp)
               	movb	$0x4, -0x45(%rbp)
               	movb	$0x3, -0x44(%rbp)
               	movb	$0x2, -0x43(%rbp)
               	movb	$0x1, -0x42(%rbp)
               	movb	$0x0, -0x41(%rbp)
               	leaq	-0x50(%rbp), %r9
               	leaq	<rip>, %rdi # <addr>
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x24, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1234, %eax           # imm = 0x1234
               	xorl	%edx, %edx
               	movq	%rdx, %xmm0
               	vpinsrw	$0x0, %eax, %xmm0, %xmm0
               	vpinsrw	$0x1, %eax, %xmm0, %xmm0
               	vpinsrw	$0x2, %eax, %xmm0, %xmm0
               	vpinsrw	$0x3, %eax, %xmm0, %xmm0
               	vpinsrw	$0x4, %eax, %xmm0, %xmm0
               	vpinsrw	$0x5, %eax, %xmm0, %xmm0
               	vpinsrw	$0x6, %eax, %xmm0, %xmm0
               	vpinsrw	$0x7, %eax, %xmm0, %xmm0
               	vpextrd	$0x0, %xmm0, %eax
               	cmpq	$0x12341234, %rax       # imm = 0x12341234
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %eax
               	cmpq	$0x12341234, %rax       # imm = 0x12341234
               	je	<addr>
               	movl	$0x27, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x5a, %eax
               	movq	%rdx, %xmm0
               	vpinsrb	$0x0, %eax, %xmm0, %xmm0
               	vpinsrb	$0x1, %eax, %xmm0, %xmm0
               	vpinsrb	$0x2, %eax, %xmm0, %xmm0
               	vpinsrb	$0x3, %eax, %xmm0, %xmm0
               	vpinsrb	$0x4, %eax, %xmm0, %xmm0
               	vpinsrb	$0x5, %eax, %xmm0, %xmm0
               	vpinsrb	$0x6, %eax, %xmm0, %xmm0
               	vpinsrb	$0x7, %eax, %xmm0, %xmm0
               	vpinsrb	$0x8, %eax, %xmm0, %xmm0
               	vpinsrb	$0x9, %eax, %xmm0, %xmm0
               	vpinsrb	$0xa, %eax, %xmm0, %xmm0
               	vpinsrb	$0xb, %eax, %xmm0, %xmm0
               	vpinsrb	$0xc, %eax, %xmm0, %xmm0
               	vpinsrb	$0xd, %eax, %xmm0, %xmm0
               	vpinsrb	$0xe, %eax, %xmm0, %xmm0
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	vpextrd	$0x0, %xmm0, %eax
               	cmpq	$0x5a5a5a5a, %rax       # imm = 0x5A5A5A5A
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %eax
               	cmpq	$0x5a5a5a5a, %rax       # imm = 0x5A5A5A5A
               	je	<addr>
               	movl	$0x28, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$0x123456789abcdef, %rax # imm = 0x123456789ABCDEF
               	vmovq	%rax, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vpextrd	$0x0, %xmm0, %eax
               	movl	$0x89abcdef, %r11d      # imm = 0x89ABCDEF
               	cmpq	%r11, %rax
               	jne	<addr>
               	vpextrd	$0x1, %xmm0, %eax
               	cmpq	$0x1234567, %rax        # imm = 0x1234567
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %eax
               	cmpq	$0x1234567, %rax        # imm = 0x1234567
               	je	<addr>
               	movl	$0x29, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x1, %rcx
               	movq	%rdx, %xmm0
               	vpinsrb	$0x0, %ecx, %xmm0, %xmm0
               	vpinsrb	$0x1, %ecx, %xmm0, %xmm0
               	vpinsrb	$0x2, %ecx, %xmm0, %xmm0
               	vpinsrb	$0x3, %ecx, %xmm0, %xmm0
               	vpinsrb	$0x4, %ecx, %xmm0, %xmm0
               	vpinsrb	$0x5, %ecx, %xmm0, %xmm0
               	vpinsrb	$0x6, %ecx, %xmm0, %xmm0
               	vpinsrb	$0x7, %ecx, %xmm0, %xmm0
               	vpinsrb	$0x8, %ecx, %xmm0, %xmm0
               	vpinsrb	$0x9, %ecx, %xmm0, %xmm0
               	vpinsrb	$0xa, %ecx, %xmm0, %xmm0
               	vpinsrb	$0xb, %ecx, %xmm0, %xmm0
               	vpinsrb	$0xc, %ecx, %xmm0, %xmm0
               	vpinsrb	$0xd, %ecx, %xmm0, %xmm0
               	vpinsrb	$0xe, %ecx, %xmm0, %xmm0
               	movapd	%xmm0, %xmm1
               	vpinsrb	$0xf, %ecx, %xmm1, %xmm1
               	movl	$0x1, %eax
               	movq	%rdx, %xmm0
               	vpinsrb	$0x0, %eax, %xmm0, %xmm0
               	vpinsrb	$0x1, %eax, %xmm0, %xmm0
               	vpinsrb	$0x2, %eax, %xmm0, %xmm0
               	vpinsrb	$0x3, %eax, %xmm0, %xmm0
               	vpinsrb	$0x4, %eax, %xmm0, %xmm0
               	vpinsrb	$0x5, %eax, %xmm0, %xmm0
               	vpinsrb	$0x6, %eax, %xmm0, %xmm0
               	vpinsrb	$0x7, %eax, %xmm0, %xmm0
               	vpinsrb	$0x8, %eax, %xmm0, %xmm0
               	vpinsrb	$0x9, %eax, %xmm0, %xmm0
               	vpinsrb	$0xa, %eax, %xmm0, %xmm0
               	vpinsrb	$0xb, %eax, %xmm0, %xmm0
               	vpinsrb	$0xc, %eax, %xmm0, %xmm0
               	vpinsrb	$0xd, %eax, %xmm0, %xmm0
               	vpinsrb	$0xe, %eax, %xmm0, %xmm0
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	paddb	%xmm0, %xmm1
               	vpextrd	$0x0, %xmm1, %esi
               	testq	%rsi, %rsi
               	jne	<addr>
               	vpextrd	$0x3, %xmm1, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rdx, %xmm15
               	psubb	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	vpextrd	$0x0, %xmm0, %esi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x2b, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rdx, %xmm0
               	vpinsrw	$0x0, %ecx, %xmm0, %xmm0
               	vpinsrw	$0x1, %ecx, %xmm0, %xmm0
               	vpinsrw	$0x2, %ecx, %xmm0, %xmm0
               	vpinsrw	$0x3, %ecx, %xmm0, %xmm0
               	vpinsrw	$0x4, %ecx, %xmm0, %xmm0
               	vpinsrw	$0x5, %ecx, %xmm0, %xmm0
               	vpinsrw	$0x6, %ecx, %xmm0, %xmm0
               	vpinsrw	$0x7, %ecx, %xmm0, %xmm0
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm1
               	vpinsrw	$0x0, %eax, %xmm1, %xmm1
               	vpinsrw	$0x1, %eax, %xmm1, %xmm1
               	vpinsrw	$0x2, %eax, %xmm1, %xmm1
               	vpinsrw	$0x3, %eax, %xmm1, %xmm1
               	vpinsrw	$0x4, %eax, %xmm1, %xmm1
               	vpinsrw	$0x5, %eax, %xmm1, %xmm1
               	vpinsrw	$0x6, %eax, %xmm1, %xmm1
               	vpinsrw	$0x7, %eax, %xmm1, %xmm1
               	paddw	%xmm1, %xmm0
               	vpextrd	$0x0, %xmm0, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x2c, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rcx, %xmm0
               	vpinsrw	$0x0, %eax, %xmm0, %xmm0
               	vpinsrw	$0x1, %eax, %xmm0, %xmm0
               	vpinsrw	$0x2, %eax, %xmm0, %xmm0
               	vpinsrw	$0x3, %eax, %xmm0, %xmm0
               	vpinsrw	$0x4, %eax, %xmm0, %xmm0
               	vpinsrw	$0x5, %eax, %xmm0, %xmm0
               	vpinsrw	$0x6, %eax, %xmm0, %xmm0
               	vpinsrw	$0x7, %eax, %xmm0, %xmm0
               	movq	%rcx, %xmm15
               	psubw	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	vpextrd	$0x0, %xmm0, %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2d, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x5, %eax
               	vmovd	%eax, %xmm0
               	vpinsrd	$0x1, %eax, %xmm0, %xmm0
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	movl	$0x7, %eax
               	vmovd	%eax, %xmm1
               	vpinsrd	$0x1, %eax, %xmm1, %xmm1
               	vpinsrd	$0x2, %eax, %xmm1, %xmm1
               	vpinsrd	$0x3, %eax, %xmm1, %xmm1
               	psubd	%xmm1, %xmm0
               	vpextrd	$0x0, %xmm0, %eax
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2e, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1234, %eax           # imm = 0x1234
               	xorl	%esi, %esi
               	movq	%rsi, %xmm0
               	vpinsrw	$0x0, %eax, %xmm0, %xmm0
               	vpinsrw	$0x1, %eax, %xmm0, %xmm0
               	vpinsrw	$0x2, %eax, %xmm0, %xmm0
               	vpinsrw	$0x3, %eax, %xmm0, %xmm0
               	vpinsrw	$0x4, %eax, %xmm0, %xmm0
               	vpinsrw	$0x5, %eax, %xmm0, %xmm0
               	vpinsrw	$0x6, %eax, %xmm0, %xmm0
               	vpinsrw	$0x7, %eax, %xmm0, %xmm0
               	movl	$0x3, %ecx
               	movq	%rsi, %xmm1
               	vpinsrw	$0x0, %ecx, %xmm1, %xmm1
               	vpinsrw	$0x1, %ecx, %xmm1, %xmm1
               	vpinsrw	$0x2, %ecx, %xmm1, %xmm1
               	vpinsrw	$0x3, %ecx, %xmm1, %xmm1
               	vpinsrw	$0x4, %ecx, %xmm1, %xmm1
               	vpinsrw	$0x5, %ecx, %xmm1, %xmm1
               	vpinsrw	$0x6, %ecx, %xmm1, %xmm1
               	vpinsrw	$0x7, %ecx, %xmm1, %xmm1
               	pmullw	%xmm1, %xmm0
               	vpextrd	$0x0, %xmm0, %eax
               	cmpq	$0x369c369c, %rax       # imm = 0x369C369C
               	je	<addr>
               	movl	$0x2f, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x1000, %rax          # imm = 0xF000
               	movq	%rsi, %xmm0
               	vpinsrw	$0x0, %eax, %xmm0, %xmm0
               	vpinsrw	$0x1, %eax, %xmm0, %xmm0
               	vpinsrw	$0x2, %eax, %xmm0, %xmm0
               	vpinsrw	$0x3, %eax, %xmm0, %xmm0
               	vpinsrw	$0x4, %eax, %xmm0, %xmm0
               	vpinsrw	$0x5, %eax, %xmm0, %xmm0
               	vpinsrw	$0x6, %eax, %xmm0, %xmm0
               	vpinsrw	$0x7, %eax, %xmm0, %xmm0
               	movl	$0x10, %eax
               	movq	%rsi, %xmm1
               	vpinsrw	$0x0, %eax, %xmm1, %xmm1
               	vpinsrw	$0x1, %eax, %xmm1, %xmm1
               	vpinsrw	$0x2, %eax, %xmm1, %xmm1
               	vpinsrw	$0x3, %eax, %xmm1, %xmm1
               	vpinsrw	$0x4, %eax, %xmm1, %xmm1
               	vpinsrw	$0x5, %eax, %xmm1, %xmm1
               	vpinsrw	$0x6, %eax, %xmm1, %xmm1
               	vpinsrw	$0x7, %eax, %xmm1, %xmm1
               	pmulhw	%xmm1, %xmm0
               	vpextrd	$0x0, %xmm0, %edx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x30, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1000, %edx           # imm = 0x1000
               	movq	%rsi, %xmm0
               	vpinsrw	$0x0, %edx, %xmm0, %xmm0
               	vpinsrw	$0x1, %edx, %xmm0, %xmm0
               	vpinsrw	$0x2, %edx, %xmm0, %xmm0
               	vpinsrw	$0x3, %edx, %xmm0, %xmm0
               	vpinsrw	$0x4, %edx, %xmm0, %xmm0
               	vpinsrw	$0x5, %edx, %xmm0, %xmm0
               	vpinsrw	$0x6, %edx, %xmm0, %xmm0
               	vpinsrw	$0x7, %edx, %xmm0, %xmm0
               	movq	%rsi, %xmm1
               	vpinsrw	$0x0, %eax, %xmm1, %xmm1
               	vpinsrw	$0x1, %eax, %xmm1, %xmm1
               	vpinsrw	$0x2, %eax, %xmm1, %xmm1
               	vpinsrw	$0x3, %eax, %xmm1, %xmm1
               	vpinsrw	$0x4, %eax, %xmm1, %xmm1
               	vpinsrw	$0x5, %eax, %xmm1, %xmm1
               	vpinsrw	$0x6, %eax, %xmm1, %xmm1
               	vpinsrw	$0x7, %eax, %xmm1, %xmm1
               	pmulhw	%xmm1, %xmm0
               	vpextrd	$0x0, %xmm0, %eax
               	cmpq	$0x10001, %rax          # imm = 0x10001
               	je	<addr>
               	movl	$0x31, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	movl	$0x2, %esi
               	movl	$0x4, %edi
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	xorl	%edx, %edx
               	movq	%rdx, %xmm0
               	vpinsrw	$0x0, %eax, %xmm0, %xmm0
               	vpinsrw	$0x1, %esi, %xmm0, %xmm0
               	vpinsrw	$0x2, %ecx, %xmm0, %xmm0
               	vpinsrw	$0x3, %edi, %xmm0, %xmm0
               	vpinsrw	$0x4, %r8d, %xmm0, %xmm0
               	vpinsrw	$0x5, %r9d, %xmm0, %xmm0
               	movl	$0x7, %eax
               	vpinsrw	$0x6, %eax, %xmm0, %xmm0
               	movl	$0x8, %eax
               	vpinsrw	$0x7, %eax, %xmm0, %xmm0
               	movq	$-0x2, %rax
               	movq	%rdx, %xmm1
               	vpinsrw	$0x0, %eax, %xmm1, %xmm1
               	vpinsrw	$0x1, %eax, %xmm1, %xmm1
               	vpinsrw	$0x2, %eax, %xmm1, %xmm1
               	vpinsrw	$0x3, %eax, %xmm1, %xmm1
               	vpinsrw	$0x4, %eax, %xmm1, %xmm1
               	vpinsrw	$0x5, %eax, %xmm1, %xmm1
               	vpinsrw	$0x6, %eax, %xmm1, %xmm1
               	vpinsrw	$0x7, %eax, %xmm1, %xmm1
               	pmaddwd	%xmm1, %xmm0
               	vpextrd	$0x0, %xmm0, %eax
               	movl	$0xfffffffa, %r11d      # imm = 0xFFFFFFFA
               	cmpq	%r11, %rax
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %eax
               	movl	$0xffffffe2, %r11d      # imm = 0xFFFFFFE2
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x32, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdx
               	movl	$0x12c, %eax            # imm = 0x12C
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm0
               	vpinsrw	$0x0, %eax, %xmm0, %xmm0
               	vpinsrw	$0x1, %eax, %xmm0, %xmm0
               	vpinsrw	$0x2, %eax, %xmm0, %xmm0
               	vpinsrw	$0x3, %eax, %xmm0, %xmm0
               	vpinsrw	$0x4, %eax, %xmm0, %xmm0
               	vpinsrw	$0x5, %eax, %xmm0, %xmm0
               	vpinsrw	$0x6, %eax, %xmm0, %xmm0
               	vpinsrw	$0x7, %eax, %xmm0, %xmm0
               	movq	$-0x12c, %rax           # imm = 0xFED4
               	movq	%rcx, %xmm1
               	vpinsrw	$0x0, %eax, %xmm1, %xmm1
               	vpinsrw	$0x1, %eax, %xmm1, %xmm1
               	vpinsrw	$0x2, %eax, %xmm1, %xmm1
               	vpinsrw	$0x3, %eax, %xmm1, %xmm1
               	vpinsrw	$0x4, %eax, %xmm1, %xmm1
               	vpinsrw	$0x5, %eax, %xmm1, %xmm1
               	vpinsrw	$0x6, %eax, %xmm1, %xmm1
               	vpinsrw	$0x7, %eax, %xmm1, %xmm1
               	packsswb	%xmm1, %xmm0
               	movups	%xmm0, (%rdx)
               	movzbq	-0x38(%rbp), %rax
               	cmpl	$0x7f, %eax
               	jne	<addr>
               	movzbq	-0x31(%rbp), %rax
               	cmpl	$0x7f, %eax
               	jne	<addr>
               	movzbq	-0x30(%rbp), %rax
               	cmpl	$0x80, %eax
               	jne	<addr>
               	movzbq	-0x29(%rbp), %rax
               	cmpl	$0x80, %eax
               	je	<addr>
               	movl	$0x33, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdx
               	movl	$0x12c, %eax            # imm = 0x12C
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm0
               	vpinsrw	$0x0, %eax, %xmm0, %xmm0
               	vpinsrw	$0x1, %eax, %xmm0, %xmm0
               	vpinsrw	$0x2, %eax, %xmm0, %xmm0
               	vpinsrw	$0x3, %eax, %xmm0, %xmm0
               	vpinsrw	$0x4, %eax, %xmm0, %xmm0
               	vpinsrw	$0x5, %eax, %xmm0, %xmm0
               	vpinsrw	$0x6, %eax, %xmm0, %xmm0
               	vpinsrw	$0x7, %eax, %xmm0, %xmm0
               	movq	$-0x5, %rax
               	movq	%rcx, %xmm1
               	vpinsrw	$0x0, %eax, %xmm1, %xmm1
               	vpinsrw	$0x1, %eax, %xmm1, %xmm1
               	vpinsrw	$0x2, %eax, %xmm1, %xmm1
               	vpinsrw	$0x3, %eax, %xmm1, %xmm1
               	vpinsrw	$0x4, %eax, %xmm1, %xmm1
               	vpinsrw	$0x5, %eax, %xmm1, %xmm1
               	vpinsrw	$0x6, %eax, %xmm1, %xmm1
               	vpinsrw	$0x7, %eax, %xmm1, %xmm1
               	packuswb	%xmm1, %xmm0
               	movups	%xmm0, (%rdx)
               	movzbq	-0x38(%rbp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movzbq	-0x31(%rbp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	cmpb	$0x0, -0x30(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x29(%rbp)
               	je	<addr>
               	movl	$0x34, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdx
               	movl	$0x11170, %eax          # imm = 0x11170
               	xorl	%ecx, %ecx
               	vmovd	%eax, %xmm0
               	vpinsrd	$0x1, %eax, %xmm0, %xmm0
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	movq	$-0x11170, %rax         # imm = 0xFFFEEE90
               	vmovd	%eax, %xmm1
               	vpinsrd	$0x1, %eax, %xmm1, %xmm1
               	vpinsrd	$0x2, %eax, %xmm1, %xmm1
               	vpinsrd	$0x3, %eax, %xmm1, %xmm1
               	packssdw	%xmm1, %xmm0
               	movups	%xmm0, (%rdx)
               	movzbq	-0x38(%rbp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movzbq	-0x37(%rbp), %rax
               	cmpl	$0x7f, %eax
               	jne	<addr>
               	cmpb	$0x0, -0x30(%rbp)
               	jne	<addr>
               	movzbq	-0x2f(%rbp), %rax
               	cmpl	$0x80, %eax
               	je	<addr>
               	movl	$0x35, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	movl	$0x1, %ecx
               	movl	$0x2, %edx
               	movl	$0x3, %esi
               	movl	$0x4, %edi
               	movl	$0x5, %r8d
               	movq	%rax, %xmm0
               	vpinsrb	$0x0, %eax, %xmm0, %xmm0
               	vpinsrb	$0x1, %ecx, %xmm0, %xmm0
               	vpinsrb	$0x2, %edx, %xmm0, %xmm0
               	vpinsrb	$0x3, %esi, %xmm0, %xmm0
               	vpinsrb	$0x4, %edi, %xmm0, %xmm0
               	vpinsrb	$0x5, %r8d, %xmm0, %xmm0
               	movl	$0x6, %eax
               	vpinsrb	$0x6, %eax, %xmm0, %xmm0
               	movl	$0x7, %eax
               	vpinsrb	$0x7, %eax, %xmm0, %xmm0
               	movl	$0x8, %eax
               	vpinsrb	$0x8, %eax, %xmm0, %xmm0
               	movl	$0x9, %eax
               	vpinsrb	$0x9, %eax, %xmm0, %xmm0
               	movl	$0xa, %eax
               	vpinsrb	$0xa, %eax, %xmm0, %xmm0
               	movl	$0xb, %eax
               	vpinsrb	$0xb, %eax, %xmm0, %xmm0
               	movl	$0xc, %eax
               	vpinsrb	$0xc, %eax, %xmm0, %xmm0
               	movl	$0xd, %eax
               	vpinsrb	$0xd, %eax, %xmm0, %xmm0
               	movl	$0xe, %eax
               	vpinsrb	$0xe, %eax, %xmm0, %xmm0
               	movl	$0xf, %eax
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	leaq	-0x38(%rbp), %rax
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm14
               	movapd	%xmm0, %xmm1
               	punpcklbw	%xmm14, %xmm1   # xmm1 = xmm1[0],xmm14[0],xmm1[1],xmm14[1],xmm1[2],xmm14[2],xmm1[3],xmm14[3],xmm1[4],xmm14[4],xmm1[5],xmm14[5],xmm1[6],xmm14[6],xmm1[7],xmm14[7]
               	movups	%xmm1, (%rax)
               	cmpb	$0x0, -0x38(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x37(%rbp)
               	jne	<addr>
               	movzbq	-0x36(%rbp), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movzbq	-0x2a(%rbp), %rcx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	cmpb	$0x0, -0x29(%rbp)
               	je	<addr>
               	movl	$0x36, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm14
               	movapd	%xmm0, %xmm1
               	punpckhbw	%xmm14, %xmm1   # xmm1 = xmm1[8],xmm14[8],xmm1[9],xmm14[9],xmm1[10],xmm14[10],xmm1[11],xmm14[11],xmm1[12],xmm14[12],xmm1[13],xmm14[13],xmm1[14],xmm14[14],xmm1[15],xmm14[15]
               	movups	%xmm1, (%rax)
               	leaq	-0x38(%rbp), %rax
               	movzbq	-0x38(%rbp), %rdx
               	cmpl	$0x8, %edx
               	jne	<addr>
               	cmpb	$0x0, -0x37(%rbp)
               	jne	<addr>
               	movzbq	-0x2a(%rbp), %rdx
               	cmpl	$0xf, %edx
               	jne	<addr>
               	cmpb	$0x0, -0x29(%rbp)
               	je	<addr>
               	movl	$0x37, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rcx, %xmm14
               	movapd	%xmm0, %xmm1
               	punpcklwd	%xmm14, %xmm1   # xmm1 = xmm1[0],xmm14[0],xmm1[1],xmm14[1],xmm1[2],xmm14[2],xmm1[3],xmm14[3]
               	movups	%xmm1, (%rax)
               	cmpb	$0x0, -0x38(%rbp)
               	jne	<addr>
               	movzbq	-0x37(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rcx
               	cmpb	$0x0, -0x36(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x35(%rbp)
               	jne	<addr>
               	movzbq	-0x34(%rbp), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x38, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	punpckhwd	%xmm14, %xmm0   # xmm0 = xmm0[4],xmm14[4],xmm0[5],xmm14[5],xmm0[6],xmm14[6],xmm0[7],xmm14[7]
               	movups	%xmm0, (%rcx)
               	movzbq	-0x38(%rbp), %rcx
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	movzbq	-0x37(%rbp), %rcx
               	cmpl	$0x9, %ecx
               	jne	<addr>
               	cmpb	$0x0, -0x36(%rbp)
               	jne	<addr>
               	movzbq	-0x34(%rbp), %rcx
               	cmpl	$0xa, %ecx
               	je	<addr>
               	movl	$0x39, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %ecx
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %edi
               	vmovd	%ecx, %xmm0
               	vpinsrd	$0x1, %esi, %xmm0, %xmm0
               	vpinsrd	$0x2, %edx, %xmm0, %xmm0
               	movapd	%xmm0, %xmm1
               	vpinsrd	$0x3, %edi, %xmm1, %xmm1
               	movl	$0x5, %ecx
               	movl	$0x6, %esi
               	movl	$0x7, %edi
               	movl	$0x8, %r8d
               	vmovd	%ecx, %xmm0
               	vpinsrd	$0x1, %esi, %xmm0, %xmm0
               	vpinsrd	$0x2, %edi, %xmm0, %xmm0
               	movapd	%xmm0, %xmm2
               	vpinsrd	$0x3, %r8d, %xmm2, %xmm2
               	movapd	%xmm1, %xmm0
               	punpckldq	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1]
               	vpextrd	$0x0, %xmm0, %eax
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
               	popq	%rbx
               	leave
               	retq
               	movapd	%xmm1, %xmm0
               	punpckhdq	%xmm2, %xmm0    # xmm0 = xmm0[2],xmm2[2],xmm0[3],xmm2[3]
               	vpextrd	$0x0, %xmm0, %eax
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
               	popq	%rbx
               	leave
               	retq
               	movapd	%xmm1, %xmm0
               	punpckhqdq	%xmm2, %xmm0    # xmm0 = xmm0[1],xmm2[1]
               	vpextrd	$0x0, %xmm0, %eax
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
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x10, %rax
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm0
               	vpinsrw	$0x0, %eax, %xmm0, %xmm0
               	vpinsrw	$0x1, %eax, %xmm0, %xmm0
               	vpinsrw	$0x2, %eax, %xmm0, %xmm0
               	vpinsrw	$0x3, %eax, %xmm0, %xmm0
               	vpinsrw	$0x4, %eax, %xmm0, %xmm0
               	vpinsrw	$0x5, %eax, %xmm0, %xmm0
               	vpinsrw	$0x6, %eax, %xmm0, %xmm0
               	vpinsrw	$0x7, %eax, %xmm0, %xmm0
               	psraw	$0x2, %xmm0
               	vpextrd	$0x0, %xmm0, %esi
               	movl	$0xfffcfffc, %r11d      # imm = 0xFFFCFFFC
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x3d, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rcx, %xmm0
               	vpinsrw	$0x0, %eax, %xmm0, %xmm0
               	vpinsrw	$0x1, %eax, %xmm0, %xmm0
               	vpinsrw	$0x2, %eax, %xmm0, %xmm0
               	vpinsrw	$0x3, %eax, %xmm0, %xmm0
               	vpinsrw	$0x4, %eax, %xmm0, %xmm0
               	vpinsrw	$0x5, %eax, %xmm0, %xmm0
               	vpinsrw	$0x6, %eax, %xmm0, %xmm0
               	vpinsrw	$0x7, %eax, %xmm0, %xmm0
               	psraw	$0x20, %xmm0
               	vpextrd	$0x0, %xmm0, %esi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x3e, %eax
               	popq	%rbx
               	leave
               	retq
               	vmovd	%eax, %xmm0
               	vpinsrd	$0x1, %eax, %xmm0, %xmm0
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	psrad	$0x2, %xmm0
               	vpextrd	$0x0, %xmm0, %eax
               	movl	$0xfffffffc, %r11d      # imm = 0xFFFFFFFC
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3f, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x40, %rax
               	vmovd	%eax, %xmm0
               	vpinsrd	$0x1, %eax, %xmm0, %xmm0
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	movq	%rdx, %xmm14
               	psrad	%xmm14, %xmm0
               	vpextrd	$0x0, %xmm0, %eax
               	movl	$0xfffffff8, %r11d      # imm = 0xFFFFFFF8
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x40, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	movl	$0x1, %ecx
               	movl	$0x2, %edx
               	movl	$0x3, %esi
               	movl	$0x4, %edi
               	movl	$0x5, %r8d
               	movq	%rax, %xmm0
               	vpinsrb	$0x0, %eax, %xmm0, %xmm0
               	vpinsrb	$0x1, %ecx, %xmm0, %xmm0
               	vpinsrb	$0x2, %edx, %xmm0, %xmm0
               	vpinsrb	$0x3, %esi, %xmm0, %xmm0
               	vpinsrb	$0x4, %edi, %xmm0, %xmm0
               	vpinsrb	$0x5, %r8d, %xmm0, %xmm0
               	movl	$0x6, %eax
               	vpinsrb	$0x6, %eax, %xmm0, %xmm0
               	movl	$0x7, %eax
               	vpinsrb	$0x7, %eax, %xmm0, %xmm0
               	movl	$0x8, %eax
               	vpinsrb	$0x8, %eax, %xmm0, %xmm0
               	movl	$0x9, %eax
               	vpinsrb	$0x9, %eax, %xmm0, %xmm0
               	movl	$0xa, %eax
               	vpinsrb	$0xa, %eax, %xmm0, %xmm0
               	movl	$0xb, %eax
               	vpinsrb	$0xb, %eax, %xmm0, %xmm0
               	movl	$0xc, %eax
               	vpinsrb	$0xc, %eax, %xmm0, %xmm0
               	movl	$0xd, %eax
               	vpinsrb	$0xd, %eax, %xmm0, %xmm0
               	movl	$0xe, %eax
               	vpinsrb	$0xe, %eax, %xmm0, %xmm0
               	movl	$0xf, %eax
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	leaq	-0x38(%rbp), %rax
               	movapd	%xmm0, %xmm1
               	psrldq	$0x3, %xmm1             # xmm1 = xmm1[3,4,5,6,7,8,9,10,11,12,13,14,15],zero,zero,zero
               	movups	%xmm1, (%rax)
               	movzbq	-0x38(%rbp), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movzbq	-0x2c(%rbp), %rcx
               	cmpl	$0xf, %ecx
               	jne	<addr>
               	cmpb	$0x0, -0x2b(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x29(%rbp)
               	je	<addr>
               	movl	$0x41, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xbeef, %ecx           # imm = 0xBEEF
               	movapd	%xmm0, %xmm1
               	pinsrw	$0x2, %ecx, %xmm1
               	movups	%xmm1, (%rax)
               	movzbq	-0x34(%rbp), %rax
               	cmpl	$0xef, %eax
               	jne	<addr>
               	movzbq	-0x33(%rbp), %rax
               	cmpl	$0xbe, %eax
               	jne	<addr>
               	movzbq	-0x32(%rbp), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x42, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x80, %rax
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm1
               	vpinsrb	$0x0, %eax, %xmm1, %xmm1
               	vpinsrb	$0x1, %eax, %xmm1, %xmm1
               	vpinsrb	$0x2, %eax, %xmm1, %xmm1
               	vpinsrb	$0x3, %eax, %xmm1, %xmm1
               	vpinsrb	$0x4, %eax, %xmm1, %xmm1
               	vpinsrb	$0x5, %eax, %xmm1, %xmm1
               	vpinsrb	$0x6, %eax, %xmm1, %xmm1
               	vpinsrb	$0x7, %eax, %xmm1, %xmm1
               	vpinsrb	$0x8, %eax, %xmm1, %xmm1
               	vpinsrb	$0x9, %eax, %xmm1, %xmm1
               	vpinsrb	$0xa, %eax, %xmm1, %xmm1
               	vpinsrb	$0xb, %eax, %xmm1, %xmm1
               	vpinsrb	$0xc, %eax, %xmm1, %xmm1
               	vpinsrb	$0xd, %eax, %xmm1, %xmm1
               	vpinsrb	$0xe, %eax, %xmm1, %xmm1
               	vpinsrb	$0xf, %eax, %xmm1, %xmm1
               	pmovmskb	%xmm1, %edx
               	cmpl	$0xffff, %edx           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x43, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rcx, %xmm14
               	pmovmskb	%xmm14, %edx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x44, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edx, %edx
               	movq	%rdx, %xmm1
               	vpinsrb	$0x0, %eax, %xmm1, %xmm1
               	vpinsrb	$0x1, %ecx, %xmm1, %xmm1
               	vpinsrb	$0x2, %ecx, %xmm1, %xmm1
               	vpinsrb	$0x3, %ecx, %xmm1, %xmm1
               	vpinsrb	$0x4, %ecx, %xmm1, %xmm1
               	vpinsrb	$0x5, %edx, %xmm1, %xmm1
               	xorl	%eax, %eax
               	vpinsrb	$0x6, %eax, %xmm1, %xmm1
               	vpinsrb	$0x7, %eax, %xmm1, %xmm1
               	vpinsrb	$0x8, %eax, %xmm1, %xmm1
               	vpinsrb	$0x9, %eax, %xmm1, %xmm1
               	vpinsrb	$0xa, %eax, %xmm1, %xmm1
               	vpinsrb	$0xb, %eax, %xmm1, %xmm1
               	vpinsrb	$0xc, %eax, %xmm1, %xmm1
               	vpinsrb	$0xd, %eax, %xmm1, %xmm1
               	xorl	%edx, %edx
               	vpinsrb	$0xe, %edx, %xmm1, %xmm1
               	movq	$-0x80, %rax
               	vpinsrb	$0xf, %eax, %xmm1, %xmm1
               	pmovmskb	%xmm1, %eax
               	cmpl	$0x8001, %eax           # imm = 0x8001
               	je	<addr>
               	movl	$0x45, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xf, %eax
               	movq	%rdx, %xmm1
               	vpinsrb	$0x0, %eax, %xmm1, %xmm1
               	vpinsrb	$0x1, %eax, %xmm1, %xmm1
               	vpinsrb	$0x2, %eax, %xmm1, %xmm1
               	vpinsrb	$0x3, %eax, %xmm1, %xmm1
               	vpinsrb	$0x4, %eax, %xmm1, %xmm1
               	vpinsrb	$0x5, %eax, %xmm1, %xmm1
               	vpinsrb	$0x6, %eax, %xmm1, %xmm1
               	vpinsrb	$0x7, %eax, %xmm1, %xmm1
               	vpinsrb	$0x8, %eax, %xmm1, %xmm1
               	vpinsrb	$0x9, %eax, %xmm1, %xmm1
               	vpinsrb	$0xa, %eax, %xmm1, %xmm1
               	vpinsrb	$0xb, %eax, %xmm1, %xmm1
               	vpinsrb	$0xc, %eax, %xmm1, %xmm1
               	vpinsrb	$0xd, %eax, %xmm1, %xmm1
               	vpinsrb	$0xe, %eax, %xmm1, %xmm1
               	vpinsrb	$0xf, %eax, %xmm1, %xmm1
               	movl	$0x33, %eax
               	movq	%rdx, %xmm2
               	vpinsrb	$0x0, %eax, %xmm2, %xmm2
               	vpinsrb	$0x1, %eax, %xmm2, %xmm2
               	vpinsrb	$0x2, %eax, %xmm2, %xmm2
               	vpinsrb	$0x3, %eax, %xmm2, %xmm2
               	vpinsrb	$0x4, %eax, %xmm2, %xmm2
               	vpinsrb	$0x5, %eax, %xmm2, %xmm2
               	vpinsrb	$0x6, %eax, %xmm2, %xmm2
               	vpinsrb	$0x7, %eax, %xmm2, %xmm2
               	vpinsrb	$0x8, %eax, %xmm2, %xmm2
               	vpinsrb	$0x9, %eax, %xmm2, %xmm2
               	vpinsrb	$0xa, %eax, %xmm2, %xmm2
               	vpinsrb	$0xb, %eax, %xmm2, %xmm2
               	vpinsrb	$0xc, %eax, %xmm2, %xmm2
               	vpinsrb	$0xd, %eax, %xmm2, %xmm2
               	vpinsrb	$0xe, %eax, %xmm2, %xmm2
               	vpinsrb	$0xf, %eax, %xmm2, %xmm2
               	pandn	%xmm2, %xmm1
               	vpextrd	$0x0, %xmm1, %eax
               	cmpq	$0x30303030, %rax       # imm = 0x30303030
               	je	<addr>
               	movl	$0x46, %eax
               	popq	%rbx
               	leave
               	retq
               	movapd	%xmm0, %xmm1
               	pcmpeqb	%xmm0, %xmm1
               	vpextrd	$0x0, %xmm1, %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	jne	<addr>
               	vpextrd	$0x3, %xmm1, %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x47, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7, %eax
               	movq	%rdx, %xmm1
               	vpinsrw	$0x0, %eax, %xmm1, %xmm1
               	vpinsrw	$0x1, %eax, %xmm1, %xmm1
               	vpinsrw	$0x2, %eax, %xmm1, %xmm1
               	vpinsrw	$0x3, %eax, %xmm1, %xmm1
               	vpinsrw	$0x4, %eax, %xmm1, %xmm1
               	vpinsrw	$0x5, %eax, %xmm1, %xmm1
               	vpinsrw	$0x6, %eax, %xmm1, %xmm1
               	vpinsrw	$0x7, %eax, %xmm1, %xmm1
               	movl	$0x8, %ecx
               	movq	%rdx, %xmm2
               	vpinsrw	$0x0, %ecx, %xmm2, %xmm2
               	vpinsrw	$0x1, %ecx, %xmm2, %xmm2
               	vpinsrw	$0x2, %ecx, %xmm2, %xmm2
               	vpinsrw	$0x3, %ecx, %xmm2, %xmm2
               	vpinsrw	$0x4, %ecx, %xmm2, %xmm2
               	vpinsrw	$0x5, %ecx, %xmm2, %xmm2
               	vpinsrw	$0x6, %ecx, %xmm2, %xmm2
               	vpinsrw	$0x7, %ecx, %xmm2, %xmm2
               	pcmpeqw	%xmm2, %xmm1
               	vpextrd	$0x0, %xmm1, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x48, %eax
               	popq	%rbx
               	leave
               	retq
               	vmovd	%eax, %xmm1
               	vpinsrd	$0x1, %eax, %xmm1, %xmm1
               	vpinsrd	$0x2, %eax, %xmm1, %xmm1
               	vpinsrd	$0x3, %eax, %xmm1, %xmm1
               	vmovd	%eax, %xmm2
               	vpinsrd	$0x1, %eax, %xmm2, %xmm2
               	vpinsrd	$0x2, %eax, %xmm2, %xmm2
               	vpinsrd	$0x3, %eax, %xmm2, %xmm2
               	pcmpeqd	%xmm2, %xmm1
               	vpextrd	$0x0, %xmm1, %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x49, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x1, %rax
               	xorl	%edx, %edx
               	movq	%rdx, %xmm1
               	vpinsrw	$0x0, %eax, %xmm1, %xmm1
               	vpinsrw	$0x1, %eax, %xmm1, %xmm1
               	vpinsrw	$0x2, %eax, %xmm1, %xmm1
               	vpinsrw	$0x3, %eax, %xmm1, %xmm1
               	vpinsrw	$0x4, %eax, %xmm1, %xmm1
               	vpinsrw	$0x5, %eax, %xmm1, %xmm1
               	vpinsrw	$0x6, %eax, %xmm1, %xmm1
               	vpinsrw	$0x7, %eax, %xmm1, %xmm1
               	movq	$-0x2, %rcx
               	movq	%rdx, %xmm2
               	vpinsrw	$0x0, %ecx, %xmm2, %xmm2
               	vpinsrw	$0x1, %ecx, %xmm2, %xmm2
               	vpinsrw	$0x2, %ecx, %xmm2, %xmm2
               	vpinsrw	$0x3, %ecx, %xmm2, %xmm2
               	vpinsrw	$0x4, %ecx, %xmm2, %xmm2
               	vpinsrw	$0x5, %ecx, %xmm2, %xmm2
               	vpinsrw	$0x6, %ecx, %xmm2, %xmm2
               	vpinsrw	$0x7, %ecx, %xmm2, %xmm2
               	pcmpgtw	%xmm2, %xmm1
               	vpextrd	$0x0, %xmm1, %esi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x4a, %eax
               	popq	%rbx
               	leave
               	retq
               	vmovd	%ecx, %xmm1
               	vpinsrd	$0x1, %ecx, %xmm1, %xmm1
               	vpinsrd	$0x2, %ecx, %xmm1, %xmm1
               	vpinsrd	$0x3, %ecx, %xmm1, %xmm1
               	vmovd	%eax, %xmm2
               	vpinsrd	$0x1, %eax, %xmm2, %xmm2
               	vpinsrd	$0x2, %eax, %xmm2, %xmm2
               	vpinsrd	$0x3, %eax, %xmm2, %xmm2
               	movapd	%xmm2, %xmm15
               	pcmpgtd	%xmm1, %xmm15
               	movapd	%xmm15, %xmm1
               	vpextrd	$0x0, %xmm1, %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4b, %eax
               	popq	%rbx
               	leave
               	retq
               	movb	$0x1, -0x38(%rbp)
               	movb	$0x2, -0x37(%rbp)
               	movb	$0x3, -0x36(%rbp)
               	movb	$0x4, -0x35(%rbp)
               	movb	$0x5, -0x34(%rbp)
               	movb	$0x6, -0x33(%rbp)
               	movb	$0x7, -0x32(%rbp)
               	movb	$0x8, -0x31(%rbp)
               	movb	$0x9, -0x30(%rbp)
               	movb	$0xa, -0x2f(%rbp)
               	movb	$0xb, -0x2e(%rbp)
               	movb	$0xc, -0x2d(%rbp)
               	movb	$0xd, -0x2c(%rbp)
               	movb	$0xe, -0x2b(%rbp)
               	movb	$0xf, -0x2a(%rbp)
               	movb	$0x10, -0x29(%rbp)
               	xorl	%eax, %eax
               	movq	-0x38(%rbp), %rcx
               	vmovq	%rcx, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vpextrd	$0x0, %xmm1, %eax
               	cmpq	$0x4030201, %rax        # imm = 0x4030201
               	jne	<addr>
               	vpextrd	$0x1, %xmm1, %eax
               	cmpq	$0x8070605, %rax        # imm = 0x8070605
               	jne	<addr>
               	vpextrd	$0x2, %xmm1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	vpextrd	$0x3, %xmm1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4c, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$-0x1111111111111112, %rax # imm = 0xEEEEEEEEEEEEEEEE
               	movq	%rax, -0x38(%rbp)
               	movq	%rax, -0x30(%rbp)
               	leaq	-0x50(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x1, -0x50(%rbp)
               	movl	$0x2, -0x4c(%rbp)
               	movl	$0x3, -0x48(%rbp)
               	movl	$0x4, -0x44(%rbp)
               	movq	-0x50(%rbp), %rax
               	movq	%rax, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rcx
               	movzbq	-0x38(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movzbq	-0x34(%rbp), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movzbq	-0x30(%rbp), %rax
               	cmpl	$0xee, %eax
               	je	<addr>
               	movl	$0x4d, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movups	%xmm0, (%rax)
               	movups	(%rax), %xmm0
               	movups	%xmm0, (%rcx)
               	cmpb	$0x0, -0x38(%rbp)
               	je	<addr>
               	movl	$0x4e, %eax
               	popq	%rbx
               	leave
               	retq
               	movzbq	-0x37(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movzbq	-0x36(%rbp), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movzbq	-0x35(%rbp), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movzbq	-0x34(%rbp), %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movzbq	-0x33(%rbp), %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movzbq	-0x32(%rbp), %rax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movzbq	-0x31(%rbp), %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movzbq	-0x30(%rbp), %rax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movzbq	-0x2f(%rbp), %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movzbq	-0x2e(%rbp), %rax
               	cmpl	$0xa, %eax
               	jne	<addr>
               	movzbq	-0x2d(%rbp), %rax
               	cmpl	$0xb, %eax
               	jne	<addr>
               	movzbq	-0x2c(%rbp), %rax
               	cmpl	$0xc, %eax
               	jne	<addr>
               	movzbq	-0x2b(%rbp), %rax
               	cmpl	$0xd, %eax
               	jne	<addr>
               	movzbq	-0x2a(%rbp), %rax
               	cmpl	$0xe, %eax
               	jne	<addr>
               	movzbq	-0x29(%rbp), %rax
               	cmpl	$0xf, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	leaq	-0x18(%rbp), %rdx
               	leaq	0x1(%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	movups	-0x15(%rbp), %xmm0
               	leaq	-0x38(%rbp), %rcx
               	movups	%xmm0, (%rcx)
               	movzbq	-0x38(%rbp), %rcx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movzbq	-0x29(%rbp), %rcx
               	cmpl	$0x13, %ecx
               	je	<addr>
               	movl	$0x51, %eax
               	popq	%rbx
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
               	popq	%rbx
               	leave
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x53, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
