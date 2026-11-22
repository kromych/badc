
x86_simd_intrinsics.x64:	file format elf64-x86-64

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
               	vpxor	%xmm1, %xmm0, %xmm3
               	movapd	%xmm1, %xmm0
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm0, %xmm3, %xmm1
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm0, %xmm1, %xmm0
               	vpxor	%xmm2, %xmm0, %xmm0
               	movups	%xmm0, -0xb0(%rbp)
               	aeskeygenassist	$0x2, %xmm0, %xmm1
               	pshufd	$0xff, %xmm1, %xmm2     # xmm2 = xmm1[3,3,3,3]
               	movapd	%xmm0, %xmm1
               	pslldq	$0x4, %xmm1             # xmm1 = zero,zero,zero,zero,xmm1[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm1, %xmm0, %xmm3
               	movapd	%xmm1, %xmm0
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm0, %xmm3, %xmm1
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm0, %xmm1, %xmm0
               	vpxor	%xmm2, %xmm0, %xmm0
               	movups	%xmm0, -0xa0(%rbp)
               	aeskeygenassist	$0x4, %xmm0, %xmm1
               	pshufd	$0xff, %xmm1, %xmm2     # xmm2 = xmm1[3,3,3,3]
               	movapd	%xmm0, %xmm1
               	pslldq	$0x4, %xmm1             # xmm1 = zero,zero,zero,zero,xmm1[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm1, %xmm0, %xmm3
               	movapd	%xmm1, %xmm0
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm0, %xmm3, %xmm1
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm0, %xmm1, %xmm0
               	vpxor	%xmm2, %xmm0, %xmm0
               	movups	%xmm0, -0x90(%rbp)
               	aeskeygenassist	$0x8, %xmm0, %xmm1
               	pshufd	$0xff, %xmm1, %xmm2     # xmm2 = xmm1[3,3,3,3]
               	movapd	%xmm0, %xmm1
               	pslldq	$0x4, %xmm1             # xmm1 = zero,zero,zero,zero,xmm1[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm1, %xmm0, %xmm3
               	movapd	%xmm1, %xmm0
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm0, %xmm3, %xmm1
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm0, %xmm1, %xmm0
               	vpxor	%xmm2, %xmm0, %xmm0
               	movups	%xmm0, -0x80(%rbp)
               	aeskeygenassist	$0x10, %xmm0, %xmm1
               	pshufd	$0xff, %xmm1, %xmm2     # xmm2 = xmm1[3,3,3,3]
               	movapd	%xmm0, %xmm1
               	pslldq	$0x4, %xmm1             # xmm1 = zero,zero,zero,zero,xmm1[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm1, %xmm0, %xmm3
               	movapd	%xmm1, %xmm0
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm0, %xmm3, %xmm1
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm0, %xmm1, %xmm0
               	vpxor	%xmm2, %xmm0, %xmm0
               	movups	%xmm0, -0x70(%rbp)
               	aeskeygenassist	$0x20, %xmm0, %xmm1
               	pshufd	$0xff, %xmm1, %xmm2     # xmm2 = xmm1[3,3,3,3]
               	movapd	%xmm0, %xmm1
               	pslldq	$0x4, %xmm1             # xmm1 = zero,zero,zero,zero,xmm1[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm1, %xmm0, %xmm3
               	movapd	%xmm1, %xmm0
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm0, %xmm3, %xmm1
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm0, %xmm1, %xmm0
               	vpxor	%xmm2, %xmm0, %xmm0
               	movups	%xmm0, -0x60(%rbp)
               	aeskeygenassist	$0x40, %xmm0, %xmm1
               	pshufd	$0xff, %xmm1, %xmm2     # xmm2 = xmm1[3,3,3,3]
               	movapd	%xmm0, %xmm1
               	pslldq	$0x4, %xmm1             # xmm1 = zero,zero,zero,zero,xmm1[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm1, %xmm0, %xmm3
               	movapd	%xmm1, %xmm0
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm0, %xmm3, %xmm1
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm0, %xmm1, %xmm0
               	vpxor	%xmm2, %xmm0, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	aeskeygenassist	$0x80, %xmm0, %xmm1
               	pshufd	$0xff, %xmm1, %xmm2     # xmm2 = xmm1[3,3,3,3]
               	movapd	%xmm0, %xmm1
               	pslldq	$0x4, %xmm1             # xmm1 = zero,zero,zero,zero,xmm1[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm1, %xmm0, %xmm3
               	movapd	%xmm1, %xmm0
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm0, %xmm3, %xmm1
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm0, %xmm1, %xmm0
               	vpxor	%xmm2, %xmm0, %xmm0
               	movups	%xmm0, -0x40(%rbp)
               	aeskeygenassist	$0x1b, %xmm0, %xmm1
               	pshufd	$0xff, %xmm1, %xmm2     # xmm2 = xmm1[3,3,3,3]
               	movapd	%xmm0, %xmm1
               	pslldq	$0x4, %xmm1             # xmm1 = zero,zero,zero,zero,xmm1[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm1, %xmm0, %xmm3
               	movapd	%xmm1, %xmm0
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm0, %xmm3, %xmm1
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm0, %xmm1, %xmm0
               	vpxor	%xmm2, %xmm0, %xmm0
               	movups	%xmm0, -0x30(%rbp)
               	aeskeygenassist	$0x36, %xmm0, %xmm1
               	pshufd	$0xff, %xmm1, %xmm2     # xmm2 = xmm1[3,3,3,3]
               	movapd	%xmm0, %xmm1
               	pslldq	$0x4, %xmm1             # xmm1 = zero,zero,zero,zero,xmm1[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm1, %xmm0, %xmm3
               	movapd	%xmm1, %xmm0
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm0, %xmm3, %xmm1
               	pslldq	$0x4, %xmm0             # xmm0 = zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11]
               	vpxor	%xmm0, %xmm1, %xmm0
               	vpxor	%xmm2, %xmm0, %xmm0
               	movups	%xmm0, -0x20(%rbp)
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm0
               	movups	-0xc0(%rbp), %xmm1
               	vpxor	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x1, %eax
               	leaq	-0xc0(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %rcx
               	movups	-0x10(%rbp), %xmm0
               	movups	(%rcx), %xmm1
               	vaesenc	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, -0x10(%rbp)
               	incq	%rax
               	cmpl	$0xa, %eax
               	jl	<addr>
               	leaq	-0x10(%rbp), %r9
               	movups	-0x10(%rbp), %xmm0
               	movups	-0x20(%rbp), %xmm1
               	vaesenclast	%xmm1, %xmm0, %xmm0
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
               	vpxor	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x9, %eax
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rcx, %rdx
               	movups	(%rdx), %xmm0
               	aesimc	%xmm0, %xmm0
               	movups	-0x10(%rbp), %xmm1
               	vaesdec	%xmm0, %xmm1, %xmm0
               	movups	%xmm0, -0x10(%rbp)
               	decq	%rax
               	testl	%eax, %eax
               	jg	<addr>
               	leaq	-0x10(%rbp), %r9
               	movups	-0x10(%rbp), %xmm0
               	movups	-0xc0(%rbp), %xmm1
               	vaesdeclast	%xmm1, %xmm0, %xmm0
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
               	movl	$0x8, %eax
               	movq	%rax, %xmm14
               	psrld	%xmm14, %xmm0
               	vpextrd	$0x3, %xmm0, %eax
               	cmpq	$0x112233, %rax         # imm = 0x112233
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm0
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
               	vmovd	%r11d, %xmm0
               	vpbroadcastb	%xmm0, %xmm0
               	vmovd	%xmm0, %eax
               	cmpq	$0x5a5a5a5a, %rax       # imm = 0x5A5A5A5A
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %eax
               	cmpq	$0x5a5a5a5a, %rax       # imm = 0x5A5A5A5A
               	je	<addr>
               	movl	$0x28, %eax
               	leave
               	retq
               	movl	$0x3, %eax
               	movl	$0xffffffc0, %r11d      # imm = 0xFFFFFFC0
               	vmovd	%r11d, %xmm0
               	vpbroadcastd	%xmm0, %xmm0
               	movq	%rax, %xmm14
               	psrad	%xmm14, %xmm0
               	vmovd	%xmm0, %eax
               	movl	$0xfffffff8, %r11d      # imm = 0xFFFFFFF8
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x40, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm0
               	movl	$0xbeef, %eax           # imm = 0xBEEF
               	movapd	%xmm0, %xmm1
               	pinsrw	$0x2, %eax, %xmm1
               	vpextrb	$0x4, %xmm1, %eax
               	cmpl	$0xef, %eax
               	jne	<addr>
               	vpextrb	$0x5, %xmm1, %eax
               	cmpl	$0xbe, %eax
               	jne	<addr>
               	vpextrb	$0x6, %xmm1, %eax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x42, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm1
               	vpinsrb	$0x0, %eax, %xmm1, %xmm1
               	movl	$0x2, %eax
               	vpinsrb	$0x1, %eax, %xmm1, %xmm1
               	movl	$0x3, %eax
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
               	vmovq	%xmm1, %rax
               	vmovq	%rax, %xmm1
               	xorl	%eax, %eax
               	movapd	%xmm1, %xmm2
               	vpinsrq	$0x1, %rax, %xmm2, %xmm2
               	vmovd	%xmm1, %ecx
               	cmpq	$0x4030201, %rcx        # imm = 0x4030201
               	jne	<addr>
               	vpextrd	$0x1, %xmm1, %ecx
               	cmpq	$0x8070605, %rcx        # imm = 0x8070605
               	jne	<addr>
               	vpextrd	$0x2, %xmm2, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	vpextrd	$0x3, %xmm2, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4c, %eax
               	leave
               	retq
               	movabsq	$-0x1111111111111112, %r11 # imm = 0xEEEEEEEEEEEEEEEE
               	vmovq	%r11, %xmm1
               	vpbroadcastq	%xmm1, %xmm1
               	movabsq	$0x200000001, %rcx      # imm = 0x200000001
               	vpinsrq	$0x0, %rcx, %xmm1, %xmm1
               	vpextrb	$0x0, %xmm1, %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	vpextrb	$0x4, %xmm1, %ecx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movups	%xmm0, (%rcx)
               	vpextrb	$0x0, %xmm0, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4e, %eax
               	leave
               	retq
               	vpextrb	$0x1, %xmm0, %ecx
               	cmpq	$0x1, %rcx
               	jne	<addr>
               	vpextrb	$0x2, %xmm0, %ecx
               	cmpq	$0x2, %rcx
               	jne	<addr>
               	vpextrb	$0x3, %xmm0, %ecx
               	cmpq	$0x3, %rcx
               	jne	<addr>
               	vpextrb	$0x4, %xmm0, %ecx
               	cmpq	$0x4, %rcx
               	jne	<addr>
               	vpextrb	$0x5, %xmm0, %ecx
               	cmpq	$0x5, %rcx
               	jne	<addr>
               	vpextrb	$0x6, %xmm0, %ecx
               	cmpq	$0x6, %rcx
               	jne	<addr>
               	vpextrb	$0x7, %xmm0, %ecx
               	cmpq	$0x7, %rcx
               	jne	<addr>
               	vpextrb	$0x8, %xmm0, %ecx
               	cmpq	$0x8, %rcx
               	jne	<addr>
               	vpextrb	$0x9, %xmm0, %ecx
               	cmpq	$0x9, %rcx
               	jne	<addr>
               	vpextrb	$0xa, %xmm0, %ecx
               	cmpq	$0xa, %rcx
               	jne	<addr>
               	vpextrb	$0xb, %xmm0, %ecx
               	cmpq	$0xb, %rcx
               	jne	<addr>
               	vpextrb	$0xc, %xmm0, %ecx
               	cmpq	$0xc, %rcx
               	jne	<addr>
               	vpextrb	$0xd, %xmm0, %ecx
               	cmpq	$0xd, %rcx
               	jne	<addr>
               	vpextrb	$0xe, %xmm0, %ecx
               	cmpq	$0xe, %rcx
               	jne	<addr>
               	vpextrb	$0xf, %xmm0, %ecx
               	cmpq	$0xf, %rcx
               	jne	<addr>
               	leaq	0x1(%rax), %rcx
               	movb	%cl, -0x18(%rbp,%rax)
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
