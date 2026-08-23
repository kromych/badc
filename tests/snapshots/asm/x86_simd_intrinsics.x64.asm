
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

<_mm_castpd_si128>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movsd	%xmm0, -0x10(%rbp,%riz)
               	movsd	%xmm1, -0x8(%rbp,%riz)
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<_mm_castsi128_pd>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	movsd	(%rcx,%riz), %xmm0
               	movsd	0x8(%rcx,%riz), %xmm1
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<_mm_loadu_si128>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	movdqu	(%rdi), %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<_mm_storeu_si128>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rsi, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdi)
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<_mm_add_epi32>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	paddd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<_mm_add_epi64>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	paddq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<_mm_sub_epi64>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	psubq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<_mm_and_si128>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pand	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<_mm_or_si128>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	por	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<_mm_xor_si128>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<_mm_unpacklo_epi64>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	punpcklqdq	%xmm14, %xmm15  # xmm15 = xmm15[0],xmm14[0]
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<_mm_shuffle_epi8>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pshufb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<_mm_cmpeq_epi64>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pcmpeqq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<_mm_aesenc_si128>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	aesenc	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<_mm_aesenclast_si128>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	aesenclast	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<_mm_aesdec_si128>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	aesdec	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<_mm_aesdeclast_si128>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	aesdeclast	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<_mm_aesimc_si128>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x20(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	aesimc	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<load>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<key_step>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%rdi, -0x80(%rbp)
               	movq	%rsi, -0x78(%rbp)
               	movq	%rdx, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x50(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rax)
               	leaq	-0xa0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x80(%rbp), %rbx
               	leaq	-0x40(%rbp), %rax
               	movdqu	(%rbx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rax)
               	leaq	-0x60(%rbp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	movq	%rbx, %rdi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x90(%rbp)
               	movq	%rdx, -0x88(%rbp)
               	leaq	-0x90(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	-0x60(%rbp), %rsi
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rsi), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x80(%rbp), %rbx
               	movq	%rbx, %rdi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x90(%rbp)
               	movq	%rdx, -0x88(%rbp)
               	leaq	-0x90(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	-0x60(%rbp), %rsi
               	leaq	-0x20(%rbp), %rax
               	movdqu	(%rsi), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x80(%rbp), %rbx
               	movq	%rbx, %rdi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x90(%rbp)
               	movq	%rdx, -0x88(%rbp)
               	leaq	-0x90(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	-0x80(%rbp), %rdi
               	leaq	-0xa0(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0xb0, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<aes128_known_answer>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1c0, %rsp            # imm = 0x1C0
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	-0x160(%rbp), %rbx
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, -0x170(%rbp)
               	movq	%rdx, -0x168(%rbp)
               	leaq	-0x170(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	-0x160(%rbp), %rdi
               	leaq	0x10(%rdi), %rbx
               	leaq	-0xb0(%rbp), %rsi
               	movdqu	(%rdi), %xmm14
               	aeskeygenassist	$0x1, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x170(%rbp)
               	movq	%rdx, -0x168(%rbp)
               	leaq	-0x170(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	-0x160(%rbp), %rax
               	leaq	0x20(%rax), %rbx
               	leaq	0x10(%rax), %rdi
               	leaq	-0xa0(%rbp), %rsi
               	movdqu	(%rdi), %xmm14
               	aeskeygenassist	$0x2, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x170(%rbp)
               	movq	%rdx, -0x168(%rbp)
               	leaq	-0x170(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	-0x160(%rbp), %rax
               	leaq	0x30(%rax), %rbx
               	leaq	0x20(%rax), %rdi
               	leaq	-0x90(%rbp), %rsi
               	movdqu	(%rdi), %xmm14
               	aeskeygenassist	$0x4, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x170(%rbp)
               	movq	%rdx, -0x168(%rbp)
               	leaq	-0x170(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	-0x160(%rbp), %rax
               	leaq	0x40(%rax), %rbx
               	leaq	0x30(%rax), %rdi
               	leaq	-0x80(%rbp), %rsi
               	movdqu	(%rdi), %xmm14
               	aeskeygenassist	$0x8, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x170(%rbp)
               	movq	%rdx, -0x168(%rbp)
               	leaq	-0x170(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	-0x160(%rbp), %rax
               	leaq	0x50(%rax), %rbx
               	leaq	0x40(%rax), %rdi
               	leaq	-0x70(%rbp), %rsi
               	movdqu	(%rdi), %xmm14
               	aeskeygenassist	$0x10, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x170(%rbp)
               	movq	%rdx, -0x168(%rbp)
               	leaq	-0x170(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	-0x160(%rbp), %rax
               	leaq	0x60(%rax), %rbx
               	leaq	0x50(%rax), %rdi
               	leaq	-0x60(%rbp), %rsi
               	movdqu	(%rdi), %xmm14
               	aeskeygenassist	$0x20, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x170(%rbp)
               	movq	%rdx, -0x168(%rbp)
               	leaq	-0x170(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	-0x160(%rbp), %rax
               	leaq	0x70(%rax), %rbx
               	leaq	0x60(%rax), %rdi
               	leaq	-0x50(%rbp), %rsi
               	movdqu	(%rdi), %xmm14
               	aeskeygenassist	$0x40, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x170(%rbp)
               	movq	%rdx, -0x168(%rbp)
               	leaq	-0x170(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	-0x160(%rbp), %rax
               	leaq	0x80(%rax), %rbx
               	leaq	0x70(%rax), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movdqu	(%rdi), %xmm14
               	aeskeygenassist	$0x80, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x170(%rbp)
               	movq	%rdx, -0x168(%rbp)
               	leaq	-0x170(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	-0x160(%rbp), %rax
               	leaq	0x90(%rax), %rbx
               	leaq	0x80(%rax), %rdi
               	leaq	-0x30(%rbp), %rsi
               	movdqu	(%rdi), %xmm14
               	aeskeygenassist	$0x1b, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x170(%rbp)
               	movq	%rdx, -0x168(%rbp)
               	leaq	-0x170(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	-0x160(%rbp), %rax
               	leaq	0xa0(%rax), %rbx
               	leaq	0x90(%rax), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movdqu	(%rdi), %xmm14
               	aeskeygenassist	$0x36, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x170(%rbp)
               	movq	%rdx, -0x168(%rbp)
               	leaq	-0x170(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	-0x1a0(%rbp), %rbx
               	leaq	<rip>, %r13
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%rax, -0x180(%rbp)
               	movq	%rdx, -0x178(%rbp)
               	leaq	-0x180(%rbp), %rdi
               	leaq	-0x160(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x170(%rbp)
               	movq	%rdx, -0x168(%rbp)
               	leaq	-0x170(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	movl	$0x1, %ebx
               	jmp	<addr>
               	leaq	-0x1a0(%rbp), %r12
               	leaq	-0x160(%rbp), %rax
               	movslq	%ebx, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rax,%rcx), %rsi
               	movq	%r12, %rdi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x170(%rbp)
               	movq	%rdx, -0x168(%rbp)
               	leaq	-0x170(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r12)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r12)
               	popq	%rcx
               	movq	%r12, %rax
               	movslq	%ebx, %rax
               	leaq	0x1(%rax), %rbx
               	cmpl	$0xa, %ebx
               	jl	<addr>
               	leaq	-0x1a0(%rbp), %rbx
               	leaq	-0x160(%rbp), %rax
               	leaq	0xa0(%rax), %rsi
               	movq	%rbx, %rdi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x170(%rbp)
               	movq	%rdx, -0x168(%rbp)
               	leaq	-0x170(%rbp), %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rbx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rbx)
               	popq	%rax
               	movq	%rbx, %rax
               	leaq	-0x1a0(%rbp), %rax
               	leaq	<rip>, %rbx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x10(%rbp), %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rdx
               	movslq	%eax, %rcx
               	addq	%rcx, %rdx
               	movzbq	(%rdx), %rdx
               	leaq	(%rbx,%rcx), %rsi
               	movzbq	(%rsi), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x1a0(%rbp), %rbx
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, -0x190(%rbp)
               	movq	%rdx, -0x188(%rbp)
               	leaq	-0x190(%rbp), %rdi
               	leaq	-0x160(%rbp), %rax
               	leaq	0xa0(%rax), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x180(%rbp)
               	movq	%rdx, -0x178(%rbp)
               	leaq	-0x180(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	movl	$0x9, %ebx
               	jmp	<addr>
               	leaq	-0x1a0(%rbp), %r12
               	leaq	-0x160(%rbp), %rax
               	movslq	%ebx, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rax,%rcx), %rdi
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x190(%rbp)
               	movq	%rdx, -0x188(%rbp)
               	leaq	-0x190(%rbp), %rsi
               	movq	%r12, %rdi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x180(%rbp)
               	movq	%rdx, -0x178(%rbp)
               	leaq	-0x180(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r12)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r12)
               	popq	%rcx
               	movq	%r12, %rax
               	movslq	%ebx, %rax
               	leaq	-0x1(%rax), %rbx
               	testl	%ebx, %ebx
               	jg	<addr>
               	leaq	-0x1a0(%rbp), %rbx
               	leaq	-0x160(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x180(%rbp)
               	movq	%rdx, -0x178(%rbp)
               	leaq	-0x180(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	-0x1a0(%rbp), %rax
               	leaq	-0x170(%rbp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x10(%rbp), %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rdx
               	movslq	%eax, %rcx
               	addq	%rcx, %rdx
               	movzbq	(%rdx), %rdx
               	leaq	(%r13,%rcx), %rsi
               	movzbq	(%rsi), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1c0, %rsp            # imm = 0x1C0
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	-0x158(%rbp), %rdx
               	movl	$0x1, %r12d
               	movl	$0x4, %esi
               	movl	$0x3, %edi
               	movl	$0x2, %r8d
               	leaq	-0x188(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x188(%rbp), %rax
               	movl	%r12d, (%rax)
               	movl	%r8d, 0x4(%rax)
               	leaq	-0x188(%rbp), %rax
               	movl	%edi, 0x8(%rax)
               	movl	%esi, 0xc(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rcx
               	leaq	-0x148(%rbp), %rdx
               	movl	$0x190, %esi            # imm = 0x190
               	movl	$0x12c, %edi            # imm = 0x12C
               	movl	$0xc8, %r8d
               	movl	$0x64, %r9d
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x188(%rbp), %rax
               	movl	%r9d, (%rax)
               	movl	%r8d, 0x4(%rax)
               	leaq	-0x188(%rbp), %rax
               	movl	%edi, 0x8(%rax)
               	movl	%esi, 0xc(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x168(%rbp), %rbx
               	leaq	-0x158(%rbp), %rdi
               	leaq	-0x148(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x188(%rbp)
               	movq	%rdx, -0x180(%rbp)
               	leaq	-0x188(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x168(%rbp), %rbx
               	movl	(%rbx), %eax
               	xorq	$0x65, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0x4(%rbx), %eax
               	xorq	$0xca, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movl	$0x1, %ecx
               	testq	%r12, %r12
               	jne	<addr>
               	movl	0x8(%rbx), %eax
               	xorq	$0x12f, %rax            # imm = 0x12F
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0xc(%rbx), %eax
               	xorq	$0x194, %rax            # imm = 0x194
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x158(%rbp), %rdi
               	leaq	-0x148(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x188(%rbp)
               	movq	%rdx, -0x180(%rbp)
               	leaq	-0x188(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x168(%rbp), %rbx
               	movl	(%rbx), %eax
               	cmpl	$0x65, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0xc(%rbx), %eax
               	cmpl	$0x194, %eax            # imm = 0x194
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x158(%rbp), %rdi
               	leaq	-0x148(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x188(%rbp)
               	movq	%rdx, -0x180(%rbp)
               	leaq	-0x188(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x168(%rbp), %r12
               	movl	0x4(%r12), %eax
               	cmpl	$0xca, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x158(%rbp), %rdi
               	leaq	-0x148(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x188(%rbp)
               	movq	%rdx, -0x180(%rbp)
               	leaq	-0x188(%rbp), %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x168(%rbp), %rax
               	movl	0x8(%rax), %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x158(%rbp), %rsi
               	xorq	%rcx, %rcx
               	movabsq	$-0x1, %rdx
               	movq	%rcx, (%rbx)
               	movq	%rcx, 0x8(%rbx)
               	leaq	-0x188(%rbp), %rax
               	movl	%edx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	%edx, 0x8(%rax)
               	leaq	-0x188(%rbp), %rax
               	movl	%ecx, 0xc(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rcx
               	leaq	-0x148(%rbp), %rdx
               	xorq	%rcx, %rcx
               	movl	$0x1, %esi
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x188(%rbp), %rax
               	movl	%esi, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x188(%rbp), %rax
               	movl	%ecx, 0xc(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x168(%rbp), %rbx
               	leaq	-0x158(%rbp), %rdi
               	leaq	-0x148(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x188(%rbp)
               	movq	%rdx, -0x180(%rbp)
               	leaq	-0x188(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x168(%rbp), %rbx
               	movl	(%rbx), %ecx
               	testl	%ecx, %ecx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0x4(%rbx), %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x158(%rbp), %rdi
               	leaq	-0x148(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x188(%rbp)
               	movq	%rdx, -0x180(%rbp)
               	leaq	-0x188(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x168(%rbp), %rbx
               	movl	(%rbx), %ecx
               	testl	%ecx, %ecx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0x4(%rbx), %eax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x158(%rbp), %rdi
               	leaq	-0x148(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x198(%rbp)
               	movq	%rdx, -0x190(%rbp)
               	leaq	-0x198(%rbp), %rdi
               	leaq	-0x148(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x188(%rbp)
               	movq	%rdx, -0x180(%rbp)
               	leaq	-0x188(%rbp), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x168(%rbp), %rcx
               	movl	(%rcx), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0x4(%rcx), %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x158(%rbp), %rcx
               	movl	$0x11223344, %edx       # imm = 0x11223344
               	movl	$0x55667788, %esi       # imm = 0x55667788
               	movabsq	$-0x66554434, %rdi      # imm = 0x99AABBCC
               	movabsq	$-0x22110100, %r8       # imm = 0xDDEEFF00
               	xorq	%rax, %rax
               	movq	%rax, (%r12)
               	movq	%rax, 0x8(%r12)
               	leaq	-0x188(%rbp), %rax
               	movl	%r8d, (%rax)
               	movl	%edi, 0x4(%rax)
               	movl	%esi, 0x8(%rax)
               	leaq	-0x188(%rbp), %rax
               	movl	%edx, 0xc(%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x168(%rbp), %rbx
               	leaq	-0x158(%rbp), %rax
               	leaq	-0x138(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	pslld	$0x4, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	movl	0xc(%rbx), %eax
               	cmpl	$0x12233440, %eax       # imm = 0x12233440
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x168(%rbp), %rbx
               	leaq	-0x158(%rbp), %rax
               	leaq	-0x128(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	psrld	$0x4, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	movl	0xc(%rbx), %eax
               	cmpl	$0x1122334, %eax        # imm = 0x1122334
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	movl	$0x8, %eax
               	leaq	-0x168(%rbp), %rbx
               	leaq	-0x158(%rbp), %rcx
               	leaq	-0x118(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movq	%rax, %xmm14
               	psrld	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	movl	0xc(%rbx), %eax
               	cmpl	$0x112233, %eax         # imm = 0x112233
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x168(%rbp), %rbx
               	leaq	-0x158(%rbp), %rax
               	leaq	-0x108(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	psrld	$0x20, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	movl	(%rbx), %ecx
               	testl	%ecx, %ecx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x168(%rbp), %rax
               	movl	0xc(%rax), %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x168(%rbp), %rbx
               	leaq	-0x158(%rbp), %rax
               	leaq	-0xf8(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	psllq	$0x8, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	movl	(%rbx), %eax
               	movl	$0xeeff0000, %r11d      # imm = 0xEEFF0000
               	cmpl	%r11d, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x168(%rbp), %rax
               	movl	0x4(%rax), %eax
               	movl	$0xaabbccdd, %r11d      # imm = 0xAABBCCDD
               	cmpl	%r11d, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x168(%rbp), %rbx
               	leaq	-0x158(%rbp), %rax
               	leaq	-0xe8(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	psrlq	$0x8, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	movl	(%rbx), %eax
               	movl	$0xccddeeff, %r11d      # imm = 0xCCDDEEFF
               	cmpl	%r11d, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x168(%rbp), %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x99aabb, %eax         # imm = 0x99AABB
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x168(%rbp), %rbx
               	leaq	-0x158(%rbp), %rax
               	leaq	-0xd8(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rsi)
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	movl	(%rbx), %ecx
               	testl	%ecx, %ecx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x168(%rbp), %rax
               	movl	0x4(%rax), %eax
               	movl	$0xddeeff00, %r11d      # imm = 0xDDEEFF00
               	cmpl	%r11d, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x158(%rbp), %rdx
               	movl	$0x1, %r12d
               	movl	$0xf, %esi
               	movl	$0xe, %edi
               	movl	$0xd, %r8d
               	movl	$0xc, %r9d
               	movl	$0xb, %ebx
               	movl	$0xa, %r13d
               	leaq	-0x188(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	xorq	%rax, %rax
               	leaq	-0x188(%rbp), %rcx
               	movb	%al, (%rcx)
               	movl	$0x1, %ecx
               	leaq	-0x188(%rbp), %rax
               	movb	%cl, 0x1(%rax)
               	movl	$0x2, %ecx
               	leaq	-0x188(%rbp), %rax
               	movb	%cl, 0x2(%rax)
               	movl	$0x3, %ecx
               	leaq	-0x188(%rbp), %rax
               	movb	%cl, 0x3(%rax)
               	movl	$0x4, %ecx
               	leaq	-0x188(%rbp), %rax
               	movb	%cl, 0x4(%rax)
               	movl	$0x5, %ecx
               	leaq	-0x188(%rbp), %rax
               	movb	%cl, 0x5(%rax)
               	movl	$0x6, %ecx
               	leaq	-0x188(%rbp), %rax
               	movb	%cl, 0x6(%rax)
               	movl	$0x7, %ecx
               	leaq	-0x188(%rbp), %rax
               	movb	%cl, 0x7(%rax)
               	movl	$0x8, %ecx
               	leaq	-0x188(%rbp), %rax
               	movb	%cl, 0x8(%rax)
               	movl	$0x9, %ecx
               	leaq	-0x188(%rbp), %rax
               	movb	%cl, 0x9(%rax)
               	leaq	-0x188(%rbp), %rax
               	movb	%r13b, 0xa(%rax)
               	leaq	-0x188(%rbp), %rax
               	movb	%bl, 0xb(%rax)
               	leaq	-0x188(%rbp), %rax
               	movb	%r9b, 0xc(%rax)
               	movb	%r8b, 0xd(%rax)
               	leaq	-0x188(%rbp), %rax
               	movb	%dil, 0xe(%rax)
               	movb	%sil, 0xf(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x178(%rbp), %rdi
               	leaq	-0x158(%rbp), %rax
               	leaq	-0xc8(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	psllw	$0x8, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x178(%rbp), %rbx
               	movzbq	(%rbx), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0x1(%rbx), %rax
               	testl	%eax, %eax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movl	$0x1, %eax
               	testq	%r12, %r12
               	jne	<addr>
               	movzbq	0x2(%rbx), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0x3(%rbx), %rax
               	xorq	$0x2, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x158(%rbp), %rax
               	leaq	-0xb8(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	psrlw	$0x8, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	movzbq	(%rbx), %rax
               	xorq	$0x1, %rax
               	movl	%eax, %ecx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x1(%rbx), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x178(%rbp), %rax
               	movzbq	0x2(%rax), %rax
               	xorq	$0x3, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x178(%rbp), %rbx
               	leaq	-0x158(%rbp), %rax
               	leaq	-0xa8(%rbp), %rsi
               	movdqu	(%rax), %xmm14
               	pshuflw	$0x1b, %xmm14, %xmm15   # xmm15 = xmm14[3,2,1,0,4,5,6,7]
               	movdqu	%xmm15, (%rsi)
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	movzbq	(%rbx), %rax
               	xorq	$0x6, %rax
               	movl	%eax, %ecx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x178(%rbp), %rcx
               	movzbq	0x1(%rcx), %rcx
               	xorq	$0x7, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x178(%rbp), %rcx
               	movzbq	0x6(%rcx), %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x178(%rbp), %rax
               	movzbq	0x7(%rax), %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x178(%rbp), %rax
               	movzbq	0x8(%rax), %rax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x178(%rbp), %rbx
               	leaq	-0x158(%rbp), %rax
               	leaq	-0x98(%rbp), %rsi
               	movdqu	(%rax), %xmm14
               	pshufhw	$0x1b, %xmm14, %xmm15   # xmm15 = xmm14[0,1,2,3,7,6,5,4]
               	movdqu	%xmm15, (%rsi)
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	movzbq	(%rbx), %rax
               	movl	$0x1, %ebx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x178(%rbp), %rax
               	movzbq	0x8(%rax), %rax
               	xorq	$0xe, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x178(%rbp), %rax
               	movzbq	0x9(%rax), %rax
               	xorq	$0xf, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x178(%rbp), %rax
               	movzbq	0xe(%rax), %rax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x178(%rbp), %rax
               	movzbq	0xf(%rax), %rax
               	xorq	$0x9, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x158(%rbp), %rdx
               	movl	$0x3, %esi
               	movl	$0x2, %edi
               	xorq	%r8, %r8
               	leaq	-0x188(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x188(%rbp), %rax
               	movl	%r8d, (%rax)
               	movl	%ebx, 0x4(%rax)
               	leaq	-0x188(%rbp), %rax
               	movl	%edi, 0x8(%rax)
               	movl	%esi, 0xc(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x168(%rbp), %rdi
               	leaq	-0x158(%rbp), %rax
               	leaq	-0x88(%rbp), %rsi
               	movdqu	(%rax), %xmm14
               	pshufd	$0x93, %xmm14, %xmm15   # xmm15 = xmm14[3,0,1,2]
               	movdqu	%xmm15, (%rsi)
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x168(%rbp), %rax
               	movl	(%rax), %ecx
               	xorq	$0x3, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	testl	%ecx, %ecx
               	setne	%bl
               	movzbq	%bl, %rbx
               	movl	$0x1, %r12d
               	testq	%rbx, %rbx
               	jne	<addr>
               	movl	0x8(%rax), %ecx
               	xorq	$0x1, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	xorq	$0x2, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x13, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x158(%rbp), %rdx
               	movl	$0xf, %esi
               	movl	$0xe, %edi
               	movl	$0xd, %r8d
               	movl	$0xc, %r9d
               	movl	$0xb, %ebx
               	movl	$0xa, %r13d
               	leaq	-0x188(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	xorq	%rax, %rax
               	leaq	-0x188(%rbp), %rcx
               	movb	%al, (%rcx)
               	movl	$0x1, %ecx
               	leaq	-0x188(%rbp), %rax
               	movb	%cl, 0x1(%rax)
               	movl	$0x2, %ecx
               	leaq	-0x188(%rbp), %rax
               	movb	%cl, 0x2(%rax)
               	movl	$0x3, %ecx
               	leaq	-0x188(%rbp), %rax
               	movb	%cl, 0x3(%rax)
               	movl	$0x4, %ecx
               	leaq	-0x188(%rbp), %rax
               	movb	%cl, 0x4(%rax)
               	movl	$0x5, %ecx
               	leaq	-0x188(%rbp), %rax
               	movb	%cl, 0x5(%rax)
               	movl	$0x6, %ecx
               	leaq	-0x188(%rbp), %rax
               	movb	%cl, 0x6(%rax)
               	movl	$0x7, %ecx
               	leaq	-0x188(%rbp), %rax
               	movb	%cl, 0x7(%rax)
               	movl	$0x8, %ecx
               	leaq	-0x188(%rbp), %rax
               	movb	%cl, 0x8(%rax)
               	movl	$0x9, %ecx
               	leaq	-0x188(%rbp), %rax
               	movb	%cl, 0x9(%rax)
               	leaq	-0x188(%rbp), %rax
               	movb	%r13b, 0xa(%rax)
               	leaq	-0x188(%rbp), %rax
               	movb	%bl, 0xb(%rax)
               	leaq	-0x188(%rbp), %rax
               	movb	%r9b, 0xc(%rax)
               	movb	%r8b, 0xd(%rax)
               	leaq	-0x188(%rbp), %rax
               	movb	%dil, 0xe(%rax)
               	movb	%sil, 0xf(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x148(%rbp), %rdx
               	movabsq	$-0x80, %rsi
               	movl	$0x1, %edi
               	movl	$0x2, %r8d
               	movl	$0x3, %r9d
               	movl	$0x4, %ebx
               	movl	$0x5, %r13d
               	leaq	-0x188(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movl	$0xf, %eax
               	leaq	-0x188(%rbp), %rcx
               	movb	%al, (%rcx)
               	movl	$0xe, %ecx
               	leaq	-0x188(%rbp), %rax
               	movb	%cl, 0x1(%rax)
               	movl	$0xd, %ecx
               	leaq	-0x188(%rbp), %rax
               	movb	%cl, 0x2(%rax)
               	movl	$0xc, %ecx
               	leaq	-0x188(%rbp), %rax
               	movb	%cl, 0x3(%rax)
               	movl	$0xb, %ecx
               	leaq	-0x188(%rbp), %rax
               	movb	%cl, 0x4(%rax)
               	movl	$0xa, %ecx
               	leaq	-0x188(%rbp), %rax
               	movb	%cl, 0x5(%rax)
               	movl	$0x9, %ecx
               	leaq	-0x188(%rbp), %rax
               	movb	%cl, 0x6(%rax)
               	movl	$0x8, %ecx
               	leaq	-0x188(%rbp), %rax
               	movb	%cl, 0x7(%rax)
               	movl	$0x7, %ecx
               	leaq	-0x188(%rbp), %rax
               	movb	%cl, 0x8(%rax)
               	movl	$0x6, %ecx
               	leaq	-0x188(%rbp), %rax
               	movb	%cl, 0x9(%rax)
               	leaq	-0x188(%rbp), %rax
               	movb	%r13b, 0xa(%rax)
               	leaq	-0x188(%rbp), %rax
               	movb	%bl, 0xb(%rax)
               	leaq	-0x188(%rbp), %rax
               	movb	%r9b, 0xc(%rax)
               	movb	%r8b, 0xd(%rax)
               	leaq	-0x188(%rbp), %rax
               	movb	%dil, 0xe(%rax)
               	movb	%sil, 0xf(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x178(%rbp), %rbx
               	leaq	-0x158(%rbp), %rdi
               	leaq	-0x148(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x188(%rbp)
               	movq	%rdx, -0x180(%rbp)
               	leaq	-0x188(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x178(%rbp), %rax
               	movzbq	(%rax), %rcx
               	xorq	$0xf, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xe(%rax), %rcx
               	xorq	$0x1, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%r12b
               	movzbq	%r12b, %r12
               	testq	%r12, %r12
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	testl	%eax, %eax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	testq	%r12, %r12
               	je	<addr>
               	movl	$0x14, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x158(%rbp), %rsi
               	movl	$0x1, %r12d
               	movl	$0x9, %ecx
               	leaq	-0x188(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x188(%rbp), %rax
               	movl	%r12d, (%rax)
               	movl	%r12d, 0x4(%rax)
               	leaq	-0x188(%rbp), %rax
               	movl	%ecx, 0x8(%rax)
               	movl	%ecx, 0xc(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rcx
               	leaq	-0x148(%rbp), %rdi
               	movl	$0x8, %ecx
               	movl	$0x2, %edx
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rax)
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x188(%rbp), %rax
               	movl	%edx, (%rax)
               	movl	%edx, 0x4(%rax)
               	leaq	-0x188(%rbp), %rax
               	movl	%ecx, 0x8(%rax)
               	movl	%ecx, 0xc(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	leaq	-0x168(%rbp), %rbx
               	leaq	-0x158(%rbp), %rdi
               	leaq	-0x148(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x188(%rbp)
               	movq	%rdx, -0x180(%rbp)
               	leaq	-0x188(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x168(%rbp), %rbx
               	movl	(%rbx), %eax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0x4(%rbx), %eax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movl	$0x1, %eax
               	testq	%r12, %r12
               	jne	<addr>
               	movl	0x8(%rbx), %eax
               	xorq	$0x2, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0xc(%rbx), %eax
               	xorq	$0x2, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x158(%rbp), %rdi
               	movq	%rdi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x188(%rbp)
               	movq	%rdx, -0x180(%rbp)
               	leaq	-0x188(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x168(%rbp), %rbx
               	movl	(%rbx), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0xc(%rbx), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x158(%rbp), %rdi
               	leaq	-0x148(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x188(%rbp)
               	movq	%rdx, -0x180(%rbp)
               	leaq	-0x188(%rbp), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x168(%rbp), %rax
               	movl	(%rax), %edx
               	testl	%edx, %edx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	testl	%eax, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x17, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x158(%rbp), %rcx
               	movl	$0x77778888, %edx       # imm = 0x77778888
               	movl	$0x55556666, %esi       # imm = 0x55556666
               	movl	$0x33334444, %edi       # imm = 0x33334444
               	movl	$0x11112222, %r8d       # imm = 0x11112222
               	xorq	%rax, %rax
               	movq	%rax, (%r12)
               	movq	%rax, 0x8(%r12)
               	leaq	-0x188(%rbp), %rax
               	movl	%r8d, (%rax)
               	movl	%edi, 0x4(%rax)
               	movl	%esi, 0x8(%rax)
               	leaq	-0x188(%rbp), %rbx
               	movl	%edx, 0xc(%rbx)
               	pushq	%rax
               	movq	(%rbx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rbx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movq	%rcx, %rax
               	leaq	-0x158(%rbp), %r12
               	leaq	-0x78(%rbp), %rax
               	movdqu	(%r12), %xmm14
               	pextrw	$0x0, %xmm14, %r11d
               	movl	%r11d, (%rax)
               	movslq	(%rax), %rax
               	cmpl	$0x2222, %eax           # imm = 0x2222
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x70(%rbp), %rax
               	movdqu	(%r12), %xmm14
               	pextrw	$0x7, %xmm14, %r11d
               	movl	%r11d, (%rax)
               	movslq	(%rax), %rax
               	cmpl	$0x7777, %eax           # imm = 0x7777
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rax
               	movdqu	(%r12), %xmm14
               	pextrd	$0x2, %xmm14, %r11d
               	movl	%r11d, (%rax)
               	movslq	(%rax), %rax
               	cmpl	$0x55556666, %eax       # imm = 0x55556666
               	je	<addr>
               	movl	$0x19, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x168(%rbp), %r13
               	movl	$0xa0b0c0d, %eax        # imm = 0xA0B0C0D
               	leaq	-0x60(%rbp), %rsi
               	movdqu	(%r12), %xmm15
               	pinsrd	$0x1, %eax, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	%r13, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	movl	0x4(%r13), %eax
               	cmpl	$0xa0b0c0d, %eax        # imm = 0xA0B0C0D
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x168(%rbp), %rax
               	movl	(%rax), %eax
               	cmpl	$0x11112222, %eax       # imm = 0x11112222
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movl	$0x3, %edx
               	movq	%rcx, (%rbx)
               	movq	%rcx, 0x8(%rbx)
               	leaq	-0x188(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r12)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r12)
               	popq	%rcx
               	movq	%r12, %rsi
               	leaq	-0x148(%rbp), %rsi
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x188(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x168(%rbp), %rbx
               	leaq	-0x158(%rbp), %rax
               	leaq	-0x50(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rax), %xmm14
               	pclmulqdq	$0x0, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	movl	(%rbx), %eax
               	xorq	$0x5, %rax
               	movl	%eax, %ecx
               	testl	%ecx, %ecx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x168(%rbp), %rax
               	movl	0x4(%rax), %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1b, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x168(%rbp), %rbx
               	leaq	-0x158(%rbp), %rax
               	leaq	-0x148(%rbp), %rcx
               	leaq	-0x40(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pclmulqdq	$0x10, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	movl	(%rbx), %eax
               	xorq	$0x5, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1c, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x158(%rbp), %rdx
               	movl	$0x1, %r12d
               	movl	$0x4, %esi
               	movl	$0x3, %edi
               	movl	$0x2, %r8d
               	leaq	-0x188(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x188(%rbp), %rax
               	movl	%r12d, (%rax)
               	movl	%r8d, 0x4(%rax)
               	leaq	-0x188(%rbp), %rax
               	movl	%edi, 0x8(%rax)
               	movl	%esi, 0xc(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rcx
               	leaq	-0x148(%rbp), %rdx
               	movl	$0x8, %esi
               	movl	$0x7, %edi
               	movl	$0x6, %r8d
               	movl	$0x5, %r9d
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x188(%rbp), %rax
               	movl	%r9d, (%rax)
               	movl	%r8d, 0x4(%rax)
               	leaq	-0x188(%rbp), %rax
               	movl	%edi, 0x8(%rax)
               	movl	%esi, 0xc(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x198(%rbp), %rbx
               	leaq	-0x158(%rbp), %rdi
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movsd	%xmm0, -0x30(%rbp,%riz)
               	movsd	%xmm1, -0x28(%rbp,%riz)
               	leaq	-0x30(%rbp), %r13
               	leaq	-0x148(%rbp), %rdi
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movsd	%xmm0, -0x20(%rbp,%riz)
               	movsd	%xmm1, -0x18(%rbp,%riz)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x10(%rbp), %rdi
               	movdqu	(%r13), %xmm15
               	movdqu	(%rax), %xmm14
               	shufpd	$0x1, %xmm14, %xmm15    # xmm15 = xmm15[1],xmm14[0]
               	movdqu	%xmm15, (%rdi)
               	movq	%rdi, %r10
               	movsd	(%r10,%riz), %xmm0
               	movsd	0x8(%r10,%riz), %xmm1
               	callq	<addr>
               	movq	%rax, -0x188(%rbp)
               	movq	%rdx, -0x180(%rbp)
               	leaq	-0x188(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	-0x168(%rbp), %rdi
               	leaq	-0x198(%rbp), %rsi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x168(%rbp), %rbx
               	movl	(%rbx), %eax
               	xorq	$0x3, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0x4(%rbx), %eax
               	xorq	$0x4, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movl	$0x1, %eax
               	testq	%r12, %r12
               	jne	<addr>
               	movl	0x8(%rbx), %eax
               	xorq	$0x5, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0xc(%rbx), %eax
               	xorq	$0x6, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1d, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x188(%rbp), %rsi
               	xorq	%rax, %rax
               	movq	%rax, (%rsi)
               	movq	%rax, 0x8(%rsi)
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	movl	(%rbx), %eax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0x4(%rbx), %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x168(%rbp), %rax
               	movl	0x8(%rax), %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x168(%rbp), %rax
               	movl	0xc(%rax), %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1e, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	leaq	-0x178(%rbp), %rax
               	leaq	(%rax), %rdx
               	movb	%cl, (%rdx)
               	movl	$0x8, %ecx
               	movb	%cl, 0x1(%rax)
               	movl	$0xf, %ecx
               	movb	%cl, 0x2(%rax)
               	movl	$0x16, %ecx
               	movb	%cl, 0x3(%rax)
               	movl	$0x1d, %ecx
               	movb	%cl, 0x4(%rax)
               	movl	$0x24, %ecx
               	movb	%cl, 0x5(%rax)
               	leaq	-0x178(%rbp), %rax
               	movl	$0x2b, %ecx
               	movb	%cl, 0x6(%rax)
               	movl	$0x32, %ecx
               	movb	%cl, 0x7(%rax)
               	movl	$0x39, %ecx
               	movb	%cl, 0x8(%rax)
               	movl	$0x40, %ecx
               	movb	%cl, 0x9(%rax)
               	movl	$0x47, %ecx
               	movb	%cl, 0xa(%rax)
               	movl	$0x4e, %ecx
               	movb	%cl, 0xb(%rax)
               	movl	$0x55, %ecx
               	movb	%cl, 0xc(%rax)
               	leaq	-0x178(%rbp), %rdi
               	movl	$0x5c, %eax
               	movb	%al, 0xd(%rdi)
               	movl	$0x63, %eax
               	movb	%al, 0xe(%rdi)
               	movl	$0x6a, %eax
               	movb	%al, 0xf(%rdi)
               	leaq	-0x158(%rbp), %rbx
               	callq	<addr>
               	movq	%rax, -0x188(%rbp)
               	movq	%rdx, -0x180(%rbp)
               	leaq	-0x188(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	xorq	%rbx, %rbx
               	leaq	-0x178(%rbp), %rdi
               	movq	%rbx, (%rdi)
               	movq	%rbx, 0x8(%rdi)
               	leaq	-0x158(%rbp), %rsi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	jmp	<addr>
               	leaq	-0x178(%rbp), %rcx
               	movslq	%ebx, %rax
               	addq	%rax, %rcx
               	movzbq	(%rcx), %rdx
               	imulq	$0x7, %rax, %rcx
               	incq	%rcx
               	andq	$0xff, %rcx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	leaq	0x1(%rax), %rbx
               	cmpl	$0x10, %ebx
               	jl	<addr>
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x20, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	movl	$0x1f, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%r12, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rbx, %rax
               	jmp	<addr>
               	movq	%rbx, %rax
               	jmp	<addr>
               	movq	%rbx, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	jmp	<addr>
