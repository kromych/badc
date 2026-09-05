
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movsd	%xmm0, -0x20(%rbp,%riz)
               	movsd	%xmm1, -0x18(%rbp,%riz)
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_castsi128_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	%rsi, -0x18(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, %rcx
               	movsd	(%rcx,%riz), %xmm0
               	movsd	0x8(%rcx,%riz), %xmm1
               	leave
               	retq

<_mm_load_si128>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	movdqu	(%rdi), %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
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
               	leave
               	retq

<_mm_store_si128>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdx, -0x18(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdi)
               	xorq	%rax, %rax
               	leave
               	retq

<_mm_storeu_si128>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdx, -0x18(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdi)
               	xorq	%rax, %rax
               	leave
               	retq

<_mm_add_epi8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	paddb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_add_epi16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	paddw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_add_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	paddd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_add_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	paddq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_sub_epi8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	psubb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_sub_epi16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	psubw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_sub_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	psubd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_sub_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	psubq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_mullo_epi16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pmullw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_mulhi_epi16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pmulhw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_madd_epi16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pmaddwd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_and_si128>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pand	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_andnot_si128>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pandn	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_or_si128>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	por	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_xor_si128>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_cmpeq_epi8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pcmpeqb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_cmpeq_epi16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pcmpeqw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_cmpeq_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pcmpeqd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_cmpgt_epi16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pcmpgtw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_cmplt_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x50(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pcmpgtd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_packs_epi16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	packsswb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_packs_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	packssdw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_packus_epi16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	packuswb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_unpacklo_epi8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	punpcklbw	%xmm14, %xmm15  # xmm15 = xmm15[0],xmm14[0],xmm15[1],xmm14[1],xmm15[2],xmm14[2],xmm15[3],xmm14[3],xmm15[4],xmm14[4],xmm15[5],xmm14[5],xmm15[6],xmm14[6],xmm15[7],xmm14[7]
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_unpacklo_epi16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	punpcklwd	%xmm14, %xmm15  # xmm15 = xmm15[0],xmm14[0],xmm15[1],xmm14[1],xmm15[2],xmm14[2],xmm15[3],xmm14[3]
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_unpacklo_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	punpckldq	%xmm14, %xmm15  # xmm15 = xmm15[0],xmm14[0],xmm15[1],xmm14[1]
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_unpacklo_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	punpcklqdq	%xmm14, %xmm15  # xmm15 = xmm15[0],xmm14[0]
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_unpackhi_epi8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	punpckhbw	%xmm14, %xmm15  # xmm15 = xmm15[8],xmm14[8],xmm15[9],xmm14[9],xmm15[10],xmm14[10],xmm15[11],xmm14[11],xmm15[12],xmm14[12],xmm15[13],xmm14[13],xmm15[14],xmm14[14],xmm15[15],xmm14[15]
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_unpackhi_epi16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	punpckhwd	%xmm14, %xmm15  # xmm15 = xmm15[4],xmm14[4],xmm15[5],xmm14[5],xmm15[6],xmm14[6],xmm15[7],xmm14[7]
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_unpackhi_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	punpckhdq	%xmm14, %xmm15  # xmm15 = xmm15[2],xmm14[2],xmm15[3],xmm14[3]
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_unpackhi_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	punpckhqdq	%xmm14, %xmm15  # xmm15 = xmm15[1],xmm14[1]
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_movemask_epi8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x28(%rbp)
               	leaq	-0x30(%rbp), %rcx
               	leaq	-0x18(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	pmovmskb	%xmm14, %r11d
               	movl	%r11d, (%rax)
               	movslq	(%rax), %rax
               	leave
               	retq

<_mm_shuffle_epi8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pshufb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_cmpeq_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pcmpeqq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_aesenc_si128>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	aesenc	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_aesenclast_si128>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	aesenclast	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_aesdec_si128>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	aesdec	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_aesdeclast_si128>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	aesdeclast	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<_mm_aesimc_si128>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x28(%rbp)
               	leaq	-0x30(%rbp), %rcx
               	leaq	-0x20(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	aesimc	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<same>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x28(%rbp)
               	movq	%rdx, %rbx
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x30(%rbp), %rsi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x10(%rbp), %rax
               	leaq	(%rax), %rcx
               	movzbq	(%rcx), %rcx
               	leaq	(%rbx), %rdx
               	movzbq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	je	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movzbq	0x1(%rax), %rcx
               	movzbq	0x1(%rbx), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x2(%rax), %rcx
               	movzbq	0x2(%rbx), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x3(%rax), %rcx
               	movzbq	0x3(%rbx), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x4(%rax), %rcx
               	movzbq	0x4(%rbx), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x5(%rax), %rax
               	movzbq	0x5(%rbx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movzbq	0x6(%rax), %rcx
               	movzbq	0x6(%rbx), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x7(%rax), %rcx
               	movzbq	0x7(%rbx), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x8(%rax), %rcx
               	movzbq	0x8(%rbx), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x9(%rax), %rcx
               	movzbq	0x9(%rbx), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0xa(%rax), %rcx
               	movzbq	0xa(%rbx), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0xb(%rax), %rax
               	movzbq	0xb(%rbx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movzbq	0xc(%rax), %rcx
               	movzbq	0xc(%rbx), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0xd(%rax), %rcx
               	movzbq	0xd(%rbx), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0xe(%rax), %rcx
               	movzbq	0xe(%rbx), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	movzbq	0xf(%rbx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
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
               	leave
               	retq

<key_step>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%rdi, -0xe0(%rbp)
               	movq	%rsi, -0xd8(%rbp)
               	movq	%rdx, -0xd0(%rbp)
               	movq	%rcx, -0xc8(%rbp)
               	leaq	-0xd0(%rbp), %rcx
               	leaq	-0x50(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rax)
               	leaq	-0xc0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xe0(%rbp), %rbx
               	leaq	-0x40(%rbp), %rax
               	movdqu	(%rbx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rax)
               	leaq	-0xb0(%rbp), %rsi
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
               	movq	%rax, -0xa0(%rbp)
               	movq	%rdx, -0x98(%rbp)
               	leaq	-0xa0(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	-0xb0(%rbp), %rsi
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
               	leaq	-0xe0(%rbp), %rbx
               	movq	%rbx, %rdi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xa0(%rbp)
               	movq	%rdx, -0x98(%rbp)
               	leaq	-0xa0(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	-0xb0(%rbp), %rsi
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
               	leaq	-0xe0(%rbp), %rbx
               	movq	%rbx, %rdi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xa0(%rbp)
               	movq	%rdx, -0x98(%rbp)
               	leaq	-0xa0(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	-0xe0(%rbp), %rdi
               	leaq	-0xc0(%rbp), %rsi
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
               	leave
               	retq

<aes128_known_answer>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x260, %rsp            # imm = 0x260
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	-0x240(%rbp), %rbx
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
               	leaq	-0x240(%rbp), %rdi
               	leaq	0x10(%rdi), %rbx
               	leaq	-0xa0(%rbp), %rsi
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
               	leaq	-0x240(%rbp), %rax
               	leaq	0x20(%rax), %rbx
               	leaq	0x10(%rax), %rdi
               	leaq	-0x90(%rbp), %rsi
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
               	leaq	-0x240(%rbp), %rax
               	leaq	0x30(%rax), %rbx
               	leaq	0x20(%rax), %rdi
               	leaq	-0x80(%rbp), %rsi
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
               	leaq	-0x240(%rbp), %rax
               	leaq	0x40(%rax), %rbx
               	leaq	0x30(%rax), %rdi
               	leaq	-0x70(%rbp), %rsi
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
               	leaq	-0x240(%rbp), %rax
               	leaq	0x50(%rax), %rbx
               	leaq	0x40(%rax), %rdi
               	leaq	-0x60(%rbp), %rsi
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
               	leaq	-0x240(%rbp), %rax
               	leaq	0x60(%rax), %rbx
               	leaq	0x50(%rax), %rdi
               	leaq	-0x50(%rbp), %rsi
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
               	leaq	-0x240(%rbp), %rax
               	leaq	0x70(%rax), %rbx
               	leaq	0x60(%rax), %rdi
               	leaq	-0x40(%rbp), %rsi
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
               	leaq	-0x240(%rbp), %rax
               	leaq	0x80(%rax), %rbx
               	leaq	0x70(%rax), %rdi
               	leaq	-0x30(%rbp), %rsi
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
               	leaq	-0x240(%rbp), %rax
               	leaq	0x90(%rax), %rbx
               	leaq	0x80(%rax), %rdi
               	leaq	-0x20(%rbp), %rsi
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
               	leaq	-0x240(%rbp), %rax
               	leaq	0xa0(%rax), %rbx
               	leaq	0x90(%rax), %rdi
               	leaq	-0x10(%rbp), %rsi
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
               	leaq	-0x190(%rbp), %rbx
               	leaq	<rip>, %r13
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%rax, -0x180(%rbp)
               	movq	%rdx, -0x178(%rbp)
               	leaq	-0x180(%rbp), %rdi
               	leaq	-0x240(%rbp), %rsi
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
               	leaq	-0x190(%rbp), %r12
               	leaq	-0x240(%rbp), %rax
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
               	leaq	-0x190(%rbp), %rbx
               	leaq	-0x240(%rbp), %rax
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
               	leaq	-0x170(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	-0x190(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x190(%rbp), %rbx
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, -0x180(%rbp)
               	movq	%rdx, -0x178(%rbp)
               	leaq	-0x180(%rbp), %rdi
               	leaq	-0x240(%rbp), %rax
               	leaq	0xa0(%rax), %rsi
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
               	movl	$0x9, %ebx
               	jmp	<addr>
               	leaq	-0x190(%rbp), %r12
               	leaq	-0x240(%rbp), %rax
               	movslq	%ebx, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rax,%rcx), %rdi
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x180(%rbp)
               	movq	%rdx, -0x178(%rbp)
               	leaq	-0x180(%rbp), %rsi
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
               	leaq	-0x1(%rax), %rbx
               	testl	%ebx, %ebx
               	jg	<addr>
               	leaq	-0x190(%rbp), %rbx
               	leaq	-0x240(%rbp), %rsi
               	movq	%rbx, %rdi
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
               	leaq	-0x190(%rbp), %rdi
               	movq	%r13, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x320, %rsp            # imm = 0x320
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	-0x300(%rbp), %rdx
               	movl	$0x1, %r12d
               	movl	$0x4, %esi
               	movl	$0x3, %edi
               	movl	$0x2, %r8d
               	leaq	-0x270(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x270(%rbp), %rax
               	movl	%r12d, (%rax)
               	movl	%r8d, 0x4(%rax)
               	leaq	-0x270(%rbp), %rax
               	movl	%edi, 0x8(%rax)
               	movl	%esi, 0xc(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rcx
               	leaq	-0x2f0(%rbp), %rdx
               	movl	$0x190, %esi            # imm = 0x190
               	movl	$0x12c, %edi            # imm = 0x12C
               	movl	$0xc8, %r8d
               	movl	$0x64, %r9d
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x270(%rbp), %rax
               	movl	%r9d, (%rax)
               	movl	%r8d, 0x4(%rax)
               	leaq	-0x270(%rbp), %rax
               	movl	%edi, 0x8(%rax)
               	movl	%esi, 0xc(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x250(%rbp), %rbx
               	leaq	-0x300(%rbp), %rdi
               	leaq	-0x2f0(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rbx
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
               	leave
               	retq
               	leaq	-0x300(%rbp), %rdi
               	leaq	-0x2f0(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rbx
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
               	leave
               	retq
               	leaq	-0x300(%rbp), %rdi
               	leaq	-0x2f0(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rbx
               	movl	0x4(%rbx), %eax
               	cmpl	$0xca, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x300(%rbp), %rdi
               	leaq	-0x2f0(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rax
               	movl	0x8(%rax), %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x300(%rbp), %rsi
               	xorq	%rcx, %rcx
               	movabsq	$-0x1, %rdx
               	leaq	-0x270(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x270(%rbp), %rax
               	movl	%edx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	%edx, 0x8(%rax)
               	leaq	-0x270(%rbp), %rax
               	movl	%ecx, 0xc(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rcx
               	leaq	-0x2f0(%rbp), %rdx
               	xorq	%rcx, %rcx
               	movl	$0x1, %esi
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x270(%rbp), %rax
               	movl	%esi, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x270(%rbp), %rax
               	movl	%ecx, 0xc(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x250(%rbp), %rbx
               	leaq	-0x300(%rbp), %rdi
               	leaq	-0x2f0(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rbx
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
               	leave
               	retq
               	leaq	-0x300(%rbp), %rdi
               	leaq	-0x2f0(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rbx
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
               	leave
               	retq
               	leaq	-0x300(%rbp), %rdi
               	leaq	-0x2f0(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x280(%rbp)
               	movq	%rdx, -0x278(%rbp)
               	leaq	-0x280(%rbp), %rdi
               	leaq	-0x2f0(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rcx
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
               	leave
               	retq
               	leaq	-0x300(%rbp), %rdx
               	movl	$0x11223344, %esi       # imm = 0x11223344
               	movl	$0x55667788, %edi       # imm = 0x55667788
               	movabsq	$-0x66554434, %r8       # imm = 0x99AABBCC
               	movabsq	$-0x22110100, %r9       # imm = 0xDDEEFF00
               	leaq	-0x270(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movl	%r9d, (%rax)
               	leaq	-0x270(%rbp), %rax
               	movl	%r8d, 0x4(%rax)
               	movl	%edi, 0x8(%rax)
               	movl	%esi, 0xc(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x250(%rbp), %rdi
               	leaq	-0x300(%rbp), %rax
               	leaq	-0x1e8(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	pslld	$0x4, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rdi
               	movl	0xc(%rdi), %eax
               	cmpl	$0x12233440, %eax       # imm = 0x12233440
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x300(%rbp), %rax
               	leaq	-0x1d8(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	psrld	$0x4, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rdi
               	movl	0xc(%rdi), %eax
               	cmpl	$0x1122334, %eax        # imm = 0x1122334
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x8, %eax
               	leaq	-0x300(%rbp), %rcx
               	leaq	-0x1c8(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movq	%rax, %xmm14
               	psrld	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rdi
               	movl	0xc(%rdi), %eax
               	cmpl	$0x112233, %eax         # imm = 0x112233
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x300(%rbp), %rax
               	leaq	-0x1b8(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	psrld	$0x20, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rax
               	movl	(%rax), %edx
               	testl	%edx, %edx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	0xc(%rax), %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x300(%rbp), %rcx
               	leaq	-0x1a8(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	psllq	$0x8, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	%rax, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	$0xeeff0000, %r11d      # imm = 0xEEFF0000
               	cmpl	%r11d, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	movl	$0xaabbccdd, %r11d      # imm = 0xAABBCCDD
               	cmpl	%r11d, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x300(%rbp), %rcx
               	leaq	-0x198(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	psrlq	$0x8, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	%rax, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	$0xccddeeff, %r11d      # imm = 0xCCDDEEFF
               	cmpl	%r11d, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x99aabb, %ecx         # imm = 0x99AABB
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x300(%rbp), %rcx
               	leaq	-0x188(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rsi)
               	movq	%rax, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rax
               	movl	(%rax), %edx
               	testl	%edx, %edx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	0x4(%rax), %eax
               	movl	$0xddeeff00, %r11d      # imm = 0xDDEEFF00
               	movq	%rax, %rcx
               	cmpl	%r11d, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x300(%rbp), %rdx
               	movl	$0x1, %ebx
               	movl	$0xf, %esi
               	movl	$0xe, %edi
               	movl	$0xd, %r8d
               	movl	$0xc, %r9d
               	movl	$0xb, %r12d
               	movl	$0xa, %r13d
               	leaq	-0x270(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	xorq	%rax, %rax
               	leaq	-0x270(%rbp), %rcx
               	movb	%al, (%rcx)
               	movl	$0x1, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x1(%rax)
               	movl	$0x2, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x2(%rax)
               	movl	$0x3, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x3(%rax)
               	movl	$0x4, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x4(%rax)
               	movl	$0x5, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x5(%rax)
               	movl	$0x6, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x6(%rax)
               	movl	$0x7, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x7(%rax)
               	movl	$0x8, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x8(%rax)
               	movl	$0x9, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x9(%rax)
               	leaq	-0x270(%rbp), %rax
               	movb	%r13b, 0xa(%rax)
               	leaq	-0x270(%rbp), %rax
               	movb	%r12b, 0xb(%rax)
               	leaq	-0x270(%rbp), %rax
               	movb	%r9b, 0xc(%rax)
               	movb	%r8b, 0xd(%rax)
               	leaq	-0x270(%rbp), %rax
               	movb	%dil, 0xe(%rax)
               	movb	%sil, 0xf(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x260(%rbp), %rdi
               	leaq	-0x300(%rbp), %rax
               	leaq	-0x178(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	psllw	$0x8, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x260(%rbp), %rax
               	movzbq	(%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x1(%rax), %rcx
               	testl	%ecx, %ecx
               	setne	%bl
               	movzbq	%bl, %rbx
               	movl	$0x1, %ecx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movzbq	0x2(%rax), %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x3(%rax), %rcx
               	xorq	$0x2, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x300(%rbp), %rcx
               	leaq	-0x168(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	psrlw	$0x8, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	%rax, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x260(%rbp), %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0x1, %rax
               	movl	%eax, %edx
               	movl	$0x1, %eax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x1(%rcx), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0x2(%rcx), %rax
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
               	leave
               	retq
               	leaq	-0x300(%rbp), %rax
               	leaq	-0x158(%rbp), %rsi
               	movdqu	(%rax), %xmm14
               	pshuflw	$0x1b, %xmm14, %xmm15   # xmm15 = xmm14[3,2,1,0,4,5,6,7]
               	movdqu	%xmm15, (%rsi)
               	movq	%rcx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x260(%rbp), %rax
               	movzbq	(%rax), %rcx
               	xorq	$0x6, %rcx
               	movl	%ecx, %edx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x1(%rax), %rdx
               	xorq	$0x7, %rdx
               	movl	%edx, %edx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x6(%rax), %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x7(%rax), %rcx
               	xorq	$0x1, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x8(%rax), %rax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x11, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x260(%rbp), %rdi
               	leaq	-0x300(%rbp), %rax
               	leaq	-0x148(%rbp), %rsi
               	movdqu	(%rax), %xmm14
               	pshufhw	$0x1b, %xmm14, %xmm15   # xmm15 = xmm14[0,1,2,3,7,6,5,4]
               	movdqu	%xmm15, (%rsi)
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x260(%rbp), %rax
               	movzbq	(%rax), %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x8(%rax), %rdx
               	xorq	$0xe, %rdx
               	movl	%edx, %edx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x9(%rax), %rdx
               	xorq	$0xf, %rdx
               	movl	%edx, %edx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0xe(%rax), %rcx
               	xorq	$0x8, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	xorq	$0x9, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x12, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x300(%rbp), %rdx
               	movl	$0x1, %r12d
               	movl	$0x3, %esi
               	movl	$0x2, %edi
               	xorq	%r8, %r8
               	leaq	-0x270(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x270(%rbp), %rax
               	movl	%r8d, (%rax)
               	movl	%r12d, 0x4(%rax)
               	leaq	-0x270(%rbp), %rax
               	movl	%edi, 0x8(%rax)
               	movl	%esi, 0xc(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x250(%rbp), %rdi
               	leaq	-0x300(%rbp), %rax
               	leaq	-0x138(%rbp), %rsi
               	movdqu	(%rax), %xmm14
               	pshufd	$0x93, %xmm14, %xmm15   # xmm15 = xmm14[3,0,1,2]
               	movdqu	%xmm15, (%rsi)
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rax
               	movl	(%rax), %ecx
               	xorq	$0x3, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	testl	%ecx, %ecx
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movl	$0x1, %ebx
               	testq	%r12, %r12
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
               	leave
               	retq
               	leaq	-0x300(%rbp), %rdx
               	movl	$0xf, %esi
               	movl	$0xe, %edi
               	movl	$0xd, %r8d
               	movl	$0xc, %r9d
               	movl	$0xb, %r12d
               	movl	$0xa, %r13d
               	leaq	-0x270(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	xorq	%rax, %rax
               	leaq	-0x270(%rbp), %rcx
               	movb	%al, (%rcx)
               	movl	$0x1, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x1(%rax)
               	movl	$0x2, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x2(%rax)
               	movl	$0x3, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x3(%rax)
               	movl	$0x4, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x4(%rax)
               	movl	$0x5, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x5(%rax)
               	movl	$0x6, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x6(%rax)
               	movl	$0x7, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x7(%rax)
               	movl	$0x8, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x8(%rax)
               	movl	$0x9, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x9(%rax)
               	leaq	-0x270(%rbp), %rax
               	movb	%r13b, 0xa(%rax)
               	leaq	-0x270(%rbp), %rax
               	movb	%r12b, 0xb(%rax)
               	leaq	-0x270(%rbp), %rax
               	movb	%r9b, 0xc(%rax)
               	movb	%r8b, 0xd(%rax)
               	leaq	-0x270(%rbp), %rax
               	movb	%dil, 0xe(%rax)
               	movb	%sil, 0xf(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x2f0(%rbp), %rdx
               	movabsq	$-0x80, %rsi
               	movl	$0x1, %edi
               	movl	$0x2, %r8d
               	movl	$0x3, %r9d
               	movl	$0x4, %r12d
               	movl	$0x5, %r13d
               	leaq	-0x270(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movl	$0xf, %eax
               	leaq	-0x270(%rbp), %rcx
               	movb	%al, (%rcx)
               	movl	$0xe, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x1(%rax)
               	movl	$0xd, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x2(%rax)
               	movl	$0xc, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x3(%rax)
               	movl	$0xb, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x4(%rax)
               	movl	$0xa, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x5(%rax)
               	movl	$0x9, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x6(%rax)
               	movl	$0x8, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x7(%rax)
               	movl	$0x7, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x8(%rax)
               	movl	$0x6, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x9(%rax)
               	leaq	-0x270(%rbp), %rax
               	movb	%r13b, 0xa(%rax)
               	leaq	-0x270(%rbp), %rax
               	movb	%r12b, 0xb(%rax)
               	leaq	-0x270(%rbp), %rax
               	movb	%r9b, 0xc(%rax)
               	movb	%r8b, 0xd(%rax)
               	leaq	-0x270(%rbp), %rax
               	movb	%dil, 0xe(%rax)
               	movb	%sil, 0xf(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x260(%rbp), %r12
               	leaq	-0x300(%rbp), %rdi
               	leaq	-0x2f0(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%r12, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x260(%rbp), %rax
               	movzbq	(%rax), %rcx
               	xorq	$0xf, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xe(%rax), %rcx
               	xorq	$0x1, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	testl	%eax, %eax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x14, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x300(%rbp), %rsi
               	movl	$0x1, %r12d
               	movl	$0x9, %ecx
               	leaq	-0x270(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x270(%rbp), %rax
               	movl	%r12d, (%rax)
               	movl	%r12d, 0x4(%rax)
               	leaq	-0x270(%rbp), %rax
               	movl	%ecx, 0x8(%rax)
               	movl	%ecx, 0xc(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rcx
               	leaq	-0x2f0(%rbp), %rdi
               	movl	$0x8, %ecx
               	movl	$0x2, %edx
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rax)
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x270(%rbp), %rax
               	movl	%edx, (%rax)
               	movl	%edx, 0x4(%rax)
               	leaq	-0x270(%rbp), %rax
               	movl	%ecx, 0x8(%rax)
               	movl	%ecx, 0xc(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	leaq	-0x250(%rbp), %rbx
               	leaq	-0x300(%rbp), %rdi
               	leaq	-0x2f0(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rbx
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
               	leave
               	retq
               	leaq	-0x300(%rbp), %rdi
               	movq	%rdi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rbx
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
               	leave
               	retq
               	leaq	-0x300(%rbp), %rdi
               	leaq	-0x2f0(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rax
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
               	leave
               	retq
               	leaq	-0x300(%rbp), %rdx
               	movl	$0x77778888, %esi       # imm = 0x77778888
               	movl	$0x55556666, %edi       # imm = 0x55556666
               	movl	$0x33334444, %r8d       # imm = 0x33334444
               	movl	$0x11112222, %r9d       # imm = 0x11112222
               	leaq	-0x270(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movl	%r9d, (%rax)
               	leaq	-0x270(%rbp), %rax
               	movl	%r8d, 0x4(%rax)
               	movl	%edi, 0x8(%rax)
               	movl	%esi, 0xc(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x300(%rbp), %rax
               	leaq	-0x128(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pextrw	$0x0, %xmm14, %r11d
               	movl	%r11d, (%rcx)
               	movslq	(%rcx), %rcx
               	cmpl	$0x2222, %ecx           # imm = 0x2222
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x120(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pextrw	$0x7, %xmm14, %r11d
               	movl	%r11d, (%rcx)
               	movslq	(%rcx), %rcx
               	cmpl	$0x7777, %ecx           # imm = 0x7777
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x18, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x118(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pextrd	$0x2, %xmm14, %r11d
               	movl	%r11d, (%rcx)
               	movslq	(%rcx), %rcx
               	cmpl	$0x55556666, %ecx       # imm = 0x55556666
               	je	<addr>
               	movl	$0x19, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x250(%rbp), %rdi
               	movl	$0xa0b0c0d, %ecx        # imm = 0xA0B0C0D
               	leaq	-0x110(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	pinsrd	$0x1, %ecx, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rcx
               	movl	0x4(%rcx), %eax
               	cmpl	$0xa0b0c0d, %eax        # imm = 0xA0B0C0D
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	(%rcx), %eax
               	cmpl	$0x11112222, %eax       # imm = 0x11112222
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x300(%rbp), %rsi
               	xorq	%rcx, %rcx
               	movl	$0x3, %edx
               	leaq	-0x270(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x270(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	leaq	-0x2f0(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	leaq	-0x250(%rbp), %rdi
               	leaq	-0x300(%rbp), %rax
               	leaq	-0x100(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rax), %xmm14
               	pclmulqdq	$0x0, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rax
               	movl	(%rax), %ecx
               	xorq	$0x5, %rcx
               	movl	%ecx, %edx
               	testl	%edx, %edx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1b, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x300(%rbp), %rcx
               	leaq	-0x2f0(%rbp), %rdx
               	leaq	-0xf0(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pclmulqdq	$0x10, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	%rax, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rax
               	movl	(%rax), %eax
               	xorq	$0x5, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1c, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x300(%rbp), %rdx
               	movl	$0x1, %ebx
               	movl	$0x4, %esi
               	movl	$0x3, %edi
               	movl	$0x2, %r8d
               	leaq	-0x270(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x270(%rbp), %rax
               	movl	%ebx, (%rax)
               	movl	%r8d, 0x4(%rax)
               	leaq	-0x270(%rbp), %rax
               	movl	%edi, 0x8(%rax)
               	movl	%esi, 0xc(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rcx
               	leaq	-0x2f0(%rbp), %rdx
               	movl	$0x8, %esi
               	movl	$0x7, %edi
               	movl	$0x6, %r8d
               	movl	$0x5, %r9d
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x270(%rbp), %rax
               	movl	%r9d, (%rax)
               	movl	%r8d, 0x4(%rax)
               	leaq	-0x270(%rbp), %rax
               	movl	%edi, 0x8(%rax)
               	movl	%esi, 0xc(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x2e0(%rbp), %r12
               	leaq	-0x300(%rbp), %rdi
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movsd	%xmm0, -0xe0(%rbp,%riz)
               	movsd	%xmm1, -0xd8(%rbp,%riz)
               	leaq	-0xe0(%rbp), %r13
               	leaq	-0x2f0(%rbp), %rdi
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movsd	%xmm0, -0xd0(%rbp,%riz)
               	movsd	%xmm1, -0xc8(%rbp,%riz)
               	leaq	-0xd0(%rbp), %rax
               	leaq	-0xc0(%rbp), %rdi
               	movdqu	(%r13), %xmm15
               	movdqu	(%rax), %xmm14
               	shufpd	$0x1, %xmm14, %xmm15    # xmm15 = xmm15[1],xmm14[0]
               	movdqu	%xmm15, (%rdi)
               	movq	%rdi, %r10
               	movsd	(%r10,%riz), %xmm0
               	movsd	0x8(%r10,%riz), %xmm1
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r12)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r12)
               	popq	%rcx
               	movq	%r12, %rax
               	leaq	-0x250(%rbp), %rdi
               	leaq	-0x2e0(%rbp), %rsi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rax
               	movl	(%rax), %ecx
               	xorq	$0x3, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	xorq	$0x4, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%bl
               	movzbq	%bl, %rbx
               	movl	$0x1, %ecx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movl	0x8(%rax), %ecx
               	xorq	$0x5, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0xc(%rax), %ecx
               	xorq	$0x6, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x270(%rbp), %rsi
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movq	%rax, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0x8(%rax), %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	testl	%eax, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1e, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x260(%rbp), %rax
               	leaq	(%rax), %rcx
               	movb	%dl, (%rcx)
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
               	leaq	-0x260(%rbp), %rax
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
               	leaq	-0x260(%rbp), %rdi
               	movl	$0x5c, %eax
               	movb	%al, 0xd(%rdi)
               	movl	$0x63, %eax
               	movb	%al, 0xe(%rdi)
               	movl	$0x6a, %eax
               	movb	%al, 0xf(%rdi)
               	leaq	-0x300(%rbp), %rbx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	xorq	%rbx, %rbx
               	leaq	-0x260(%rbp), %rdi
               	movq	%rbx, (%rdi)
               	movq	%rbx, 0x8(%rdi)
               	leaq	-0x300(%rbp), %rsi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	jmp	<addr>
               	leaq	-0x260(%rbp), %rcx
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
               	xorq	%rdx, %rdx
               	movl	$0x1, %esi
               	movl	$0x2, %edi
               	movl	$0x3, %r8d
               	movl	$0x4, %r9d
               	movl	$0x5, %ebx
               	leaq	-0x270(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x270(%rbp), %rax
               	movw	%dx, (%rax)
               	movw	%si, 0x2(%rax)
               	leaq	-0x270(%rbp), %rax
               	movw	%di, 0x4(%rax)
               	movw	%r8w, 0x6(%rax)
               	movw	%r9w, 0x8(%rax)
               	movw	%bx, 0xa(%rax)
               	movl	$0x6, %eax
               	leaq	-0x270(%rbp), %rdi
               	movw	%ax, 0xc(%rdi)
               	movl	$0x7, %eax
               	movw	%ax, 0xe(%rdi)
               	leaq	<rip>, %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x21, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	xorq	%rdx, %rdx
               	movl	$0x1, %esi
               	movl	$0x2, %edi
               	movl	$0x3, %r8d
               	movl	$0x4, %r9d
               	movl	$0x5, %ebx
               	leaq	-0x270(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movl	$0x7, %eax
               	leaq	-0x270(%rbp), %rcx
               	movw	%ax, (%rcx)
               	movl	$0x6, %ecx
               	leaq	-0x270(%rbp), %rax
               	movw	%cx, 0x2(%rax)
               	leaq	-0x270(%rbp), %rax
               	movw	%bx, 0x4(%rax)
               	movw	%r9w, 0x6(%rax)
               	leaq	-0x270(%rbp), %rax
               	movw	%r8w, 0x8(%rax)
               	movw	%di, 0xa(%rax)
               	movw	%si, 0xc(%rax)
               	movw	%dx, 0xe(%rax)
               	leaq	-0x270(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x22, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	xorq	%rdx, %rdx
               	movl	$0x1, %esi
               	movl	$0x2, %edi
               	movl	$0x3, %r8d
               	movl	$0x4, %r9d
               	movl	$0x5, %ebx
               	leaq	-0x270(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x270(%rbp), %rax
               	movb	%dl, (%rax)
               	movb	%sil, 0x1(%rax)
               	leaq	-0x270(%rbp), %rax
               	movb	%dil, 0x2(%rax)
               	movb	%r8b, 0x3(%rax)
               	movb	%r9b, 0x4(%rax)
               	movb	%bl, 0x5(%rax)
               	movl	$0x6, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x6(%rax)
               	movl	$0x7, %ecx
               	movb	%cl, 0x7(%rax)
               	movl	$0x8, %ecx
               	movb	%cl, 0x8(%rax)
               	movl	$0x9, %ecx
               	movb	%cl, 0x9(%rax)
               	movl	$0xa, %ecx
               	movb	%cl, 0xa(%rax)
               	movl	$0xb, %ecx
               	movb	%cl, 0xb(%rax)
               	movl	$0xc, %ecx
               	movb	%cl, 0xc(%rax)
               	movl	$0xd, %eax
               	leaq	-0x270(%rbp), %rdi
               	movb	%al, 0xd(%rdi)
               	movl	$0xe, %eax
               	movb	%al, 0xe(%rdi)
               	movl	$0xf, %eax
               	movb	%al, 0xf(%rdi)
               	leaq	<rip>, %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x23, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	xorq	%rdx, %rdx
               	movl	$0x1, %esi
               	movl	$0x2, %edi
               	movl	$0x3, %r8d
               	movl	$0x4, %r9d
               	movl	$0x5, %ebx
               	leaq	-0x270(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movl	$0xf, %eax
               	leaq	-0x270(%rbp), %rcx
               	movb	%al, (%rcx)
               	movl	$0xe, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x1(%rax)
               	movl	$0xd, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x2(%rax)
               	movl	$0xc, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x3(%rax)
               	movl	$0xb, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x4(%rax)
               	movl	$0xa, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x5(%rax)
               	movl	$0x9, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x6(%rax)
               	movl	$0x8, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x7(%rax)
               	movl	$0x7, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x8(%rax)
               	movl	$0x6, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x9(%rax)
               	leaq	-0x270(%rbp), %rax
               	movb	%bl, 0xa(%rax)
               	movb	%r9b, 0xb(%rax)
               	leaq	-0x270(%rbp), %rax
               	movb	%r8b, 0xc(%rax)
               	movb	%dil, 0xd(%rax)
               	movb	%sil, 0xe(%rax)
               	movb	%dl, 0xf(%rax)
               	leaq	-0x270(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x24, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x250(%rbp), %rdi
               	movl	$0x1, %edx
               	movl	$0x2, %r8d
               	movl	$0x3, %r9d
               	movl	$0x4, %ebx
               	leaq	-0x270(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movl	%edx, (%rax)
               	leaq	-0x270(%rbp), %rsi
               	movl	%r8d, 0x4(%rsi)
               	movl	%r9d, 0x8(%rsi)
               	movl	%ebx, 0xc(%rsi)
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rcx
               	movl	(%rcx), %eax
               	xorq	$0x1, %rax
               	movl	%eax, %edx
               	testl	%edx, %edx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	0xc(%rcx), %eax
               	xorq	$0x4, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x25, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x11223344, %edx       # imm = 0x11223344
               	leaq	-0x270(%rbp), %rax
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movl	%edx, (%rax)
               	movl	%edx, 0x4(%rax)
               	movl	%edx, 0x8(%rax)
               	movl	%edx, 0xc(%rax)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rcx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rdx
               	movl	(%rdx), %eax
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0xc(%rdx), %eax
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x26, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x1234, %ecx           # imm = 0x1234
               	leaq	-0x270(%rbp), %rax
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	leaq	-0x270(%rbp), %rsi
               	movw	%cx, 0x8(%rsi)
               	movw	%cx, 0xa(%rsi)
               	movw	%cx, 0xc(%rsi)
               	movw	%cx, 0xe(%rsi)
               	movq	%rdx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rdx
               	movl	(%rdx), %eax
               	cmpl	$0x12341234, %eax       # imm = 0x12341234
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0xc(%rdx), %eax
               	cmpl	$0x12341234, %eax       # imm = 0x12341234
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x27, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x5a, %eax
               	leaq	-0x270(%rbp), %rcx
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movb	%al, (%rcx)
               	movb	%al, 0x1(%rcx)
               	movb	%al, 0x2(%rcx)
               	movb	%al, 0x3(%rcx)
               	leaq	-0x270(%rbp), %rcx
               	movb	%al, 0x4(%rcx)
               	movb	%al, 0x5(%rcx)
               	movb	%al, 0x6(%rcx)
               	movb	%al, 0x7(%rcx)
               	movb	%al, 0x8(%rcx)
               	movb	%al, 0x9(%rcx)
               	leaq	-0x270(%rbp), %rcx
               	movb	%al, 0xa(%rcx)
               	movb	%al, 0xb(%rcx)
               	movb	%al, 0xc(%rcx)
               	movb	%al, 0xd(%rcx)
               	movb	%al, 0xe(%rcx)
               	movb	%al, 0xf(%rcx)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rdx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rax
               	movl	(%rax), %ecx
               	cmpl	$0x5a5a5a5a, %ecx       # imm = 0x5A5A5A5A
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0xc(%rax), %ecx
               	cmpl	$0x5a5a5a5a, %ecx       # imm = 0x5A5A5A5A
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x28, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movabsq	$0x123456789abcdef, %rcx # imm = 0x123456789ABCDEF
               	leaq	-0x270(%rbp), %rsi
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rsi)
               	movq	%rdx, 0x8(%rsi)
               	movq	%rcx, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movq	%rax, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rcx
               	movl	(%rcx), %eax
               	movl	$0x89abcdef, %r11d      # imm = 0x89ABCDEF
               	movq	%rax, %rdx
               	cmpl	%r11d, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	movl	0x4(%rcx), %eax
               	cmpl	$0x1234567, %eax        # imm = 0x1234567
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0xc(%rcx), %eax
               	cmpl	$0x1234567, %eax        # imm = 0x1234567
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x29, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x300(%rbp), %rsi
               	movabsq	$-0x1, %rax
               	leaq	-0x270(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	movb	%al, (%rcx)
               	movb	%al, 0x1(%rcx)
               	movb	%al, 0x2(%rcx)
               	movb	%al, 0x3(%rcx)
               	leaq	-0x270(%rbp), %rcx
               	movb	%al, 0x4(%rcx)
               	movb	%al, 0x5(%rcx)
               	movb	%al, 0x6(%rcx)
               	movb	%al, 0x7(%rcx)
               	movb	%al, 0x8(%rcx)
               	movb	%al, 0x9(%rcx)
               	leaq	-0x270(%rbp), %rcx
               	movb	%al, 0xa(%rcx)
               	movb	%al, 0xb(%rcx)
               	movb	%al, 0xc(%rcx)
               	movb	%al, 0xd(%rcx)
               	movb	%al, 0xe(%rcx)
               	movb	%al, 0xf(%rcx)
               	leaq	-0x270(%rbp), %rcx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rax
               	leaq	-0x2f0(%rbp), %rsi
               	movl	$0x1, %eax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	movb	%al, (%rcx)
               	movb	%al, 0x1(%rcx)
               	movb	%al, 0x2(%rcx)
               	movb	%al, 0x3(%rcx)
               	leaq	-0x270(%rbp), %rcx
               	movb	%al, 0x4(%rcx)
               	movb	%al, 0x5(%rcx)
               	movb	%al, 0x6(%rcx)
               	movb	%al, 0x7(%rcx)
               	movb	%al, 0x8(%rcx)
               	movb	%al, 0x9(%rcx)
               	leaq	-0x270(%rbp), %rcx
               	movb	%al, 0xa(%rcx)
               	movb	%al, 0xb(%rcx)
               	movb	%al, 0xc(%rcx)
               	movb	%al, 0xd(%rcx)
               	movb	%al, 0xe(%rcx)
               	movb	%al, 0xf(%rcx)
               	leaq	-0x270(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x250(%rbp), %rbx
               	leaq	-0x300(%rbp), %rdi
               	leaq	-0x2f0(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rbx
               	movl	(%rbx), %ecx
               	testl	%ecx, %ecx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0xc(%rbx), %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x280(%rbp), %rdi
               	xorq	%rax, %rax
               	movq	%rax, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	leaq	-0x2f0(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rax
               	movl	(%rax), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x2b, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x300(%rbp), %rsi
               	movabsq	$-0x1, %rcx
               	leaq	-0x270(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	leaq	-0x270(%rbp), %rax
               	movw	%cx, 0x8(%rax)
               	movw	%cx, 0xa(%rax)
               	movw	%cx, 0xc(%rax)
               	movw	%cx, 0xe(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x250(%rbp), %rbx
               	leaq	-0x300(%rbp), %rdi
               	movl	$0x1, %ecx
               	leaq	-0x280(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	leaq	-0x280(%rbp), %rax
               	movw	%cx, 0x6(%rax)
               	movw	%cx, 0x8(%rax)
               	movw	%cx, 0xa(%rax)
               	movw	%cx, 0xc(%rax)
               	movw	%cx, 0xe(%rax)
               	leaq	-0x280(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rbx
               	movl	(%rbx), %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2c, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x290(%rbp), %rdi
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rdi)
               	movq	%rdx, 0x8(%rdi)
               	movl	$0x1, %ecx
               	leaq	-0x280(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	leaq	-0x280(%rbp), %rax
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	movw	%cx, 0x8(%rax)
               	movw	%cx, 0xa(%rax)
               	movw	%cx, 0xc(%rax)
               	leaq	-0x280(%rbp), %rsi
               	movw	%cx, 0xe(%rsi)
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rbx
               	movl	(%rbx), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x2d, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x5, %ecx
               	leaq	-0x290(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movl	%ecx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	%ecx, 0x8(%rax)
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x290(%rbp), %rdi
               	movl	$0x7, %ecx
               	leaq	-0x280(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movl	%ecx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x280(%rbp), %rsi
               	movl	%ecx, 0xc(%rsi)
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rbx
               	movl	(%rbx), %eax
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x2e, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x1234, %ecx           # imm = 0x1234
               	leaq	-0x290(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	leaq	-0x290(%rbp), %rdi
               	movw	%cx, 0x8(%rdi)
               	movw	%cx, 0xa(%rdi)
               	movw	%cx, 0xc(%rdi)
               	movw	%cx, 0xe(%rdi)
               	movl	$0x3, %ecx
               	leaq	-0x280(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	leaq	-0x280(%rbp), %rax
               	movw	%cx, 0x6(%rax)
               	movw	%cx, 0x8(%rax)
               	movw	%cx, 0xa(%rax)
               	movw	%cx, 0xc(%rax)
               	movw	%cx, 0xe(%rax)
               	leaq	-0x280(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rbx
               	movl	(%rbx), %eax
               	cmpl	$0x369c369c, %eax       # imm = 0x369C369C
               	je	<addr>
               	movl	$0x2f, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movabsq	$-0x1000, %rcx          # imm = 0xF000
               	leaq	-0x290(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	leaq	-0x290(%rbp), %rdi
               	movw	%cx, 0x8(%rdi)
               	movw	%cx, 0xa(%rdi)
               	movw	%cx, 0xc(%rdi)
               	movw	%cx, 0xe(%rdi)
               	movl	$0x10, %ecx
               	leaq	-0x280(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	leaq	-0x280(%rbp), %rax
               	movw	%cx, 0x6(%rax)
               	movw	%cx, 0x8(%rax)
               	movw	%cx, 0xa(%rax)
               	movw	%cx, 0xc(%rax)
               	movw	%cx, 0xe(%rax)
               	leaq	-0x280(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rbx
               	movl	(%rbx), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x30, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x1000, %ecx           # imm = 0x1000
               	leaq	-0x290(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	leaq	-0x290(%rbp), %rdi
               	movw	%cx, 0x8(%rdi)
               	movw	%cx, 0xa(%rdi)
               	movw	%cx, 0xc(%rdi)
               	movw	%cx, 0xe(%rdi)
               	movl	$0x10, %ecx
               	leaq	-0x280(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	leaq	-0x280(%rbp), %rax
               	movw	%cx, 0x6(%rax)
               	movw	%cx, 0x8(%rax)
               	movw	%cx, 0xa(%rax)
               	movw	%cx, 0xc(%rax)
               	movw	%cx, 0xe(%rax)
               	leaq	-0x280(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rax
               	movl	(%rax), %eax
               	cmpl	$0x10001, %eax          # imm = 0x10001
               	je	<addr>
               	movl	$0x31, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x300(%rbp), %rdx
               	movl	$0x1, %esi
               	movl	$0x2, %edi
               	movl	$0x3, %r8d
               	movl	$0x4, %r9d
               	movl	$0x5, %ebx
               	movl	$0x6, %r12d
               	leaq	-0x270(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x270(%rbp), %rax
               	movw	%si, (%rax)
               	leaq	-0x270(%rbp), %rax
               	movw	%di, 0x2(%rax)
               	movw	%r8w, 0x4(%rax)
               	leaq	-0x270(%rbp), %rax
               	movw	%r9w, 0x6(%rax)
               	movw	%bx, 0x8(%rax)
               	movw	%r12w, 0xa(%rax)
               	movl	$0x7, %ecx
               	movw	%cx, 0xc(%rax)
               	movl	$0x8, %ecx
               	leaq	-0x270(%rbp), %rax
               	movw	%cx, 0xe(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x250(%rbp), %rbx
               	leaq	-0x300(%rbp), %rdi
               	movabsq	$-0x2, %rcx
               	leaq	-0x280(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	leaq	-0x280(%rbp), %rax
               	movw	%cx, 0x6(%rax)
               	movw	%cx, 0x8(%rax)
               	movw	%cx, 0xa(%rax)
               	movw	%cx, 0xc(%rax)
               	movw	%cx, 0xe(%rax)
               	leaq	-0x280(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rcx
               	movl	(%rcx), %eax
               	movl	$0xfffffffa, %r11d      # imm = 0xFFFFFFFA
               	cmpl	%r11d, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0xc(%rcx), %eax
               	movl	$0xffffffe2, %r11d      # imm = 0xFFFFFFE2
               	cmpl	%r11d, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x32, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x260(%rbp), %rbx
               	movl	$0x12c, %ecx            # imm = 0x12C
               	leaq	-0x290(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	leaq	-0x290(%rbp), %rdi
               	movw	%cx, 0x8(%rdi)
               	movw	%cx, 0xa(%rdi)
               	movw	%cx, 0xc(%rdi)
               	movw	%cx, 0xe(%rdi)
               	movabsq	$-0x12c, %rcx           # imm = 0xFED4
               	leaq	-0x280(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	leaq	-0x280(%rbp), %rax
               	movw	%cx, 0x6(%rax)
               	movw	%cx, 0x8(%rax)
               	movw	%cx, 0xa(%rax)
               	movw	%cx, 0xc(%rax)
               	movw	%cx, 0xe(%rax)
               	leaq	-0x280(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x260(%rbp), %rbx
               	movzbq	(%rbx), %rax
               	xorq	$0x7f, %rax
               	movl	%eax, %ecx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x7(%rbx), %rcx
               	xorq	$0x7f, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x8(%rbx), %rax
               	xorq	$0x80, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0xf(%rbx), %rax
               	xorq	$0x80, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x33, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x12c, %ecx            # imm = 0x12C
               	leaq	-0x290(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	leaq	-0x290(%rbp), %rdi
               	movw	%cx, 0x8(%rdi)
               	movw	%cx, 0xa(%rdi)
               	movw	%cx, 0xc(%rdi)
               	movw	%cx, 0xe(%rdi)
               	movabsq	$-0x5, %rcx
               	leaq	-0x280(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	leaq	-0x280(%rbp), %rax
               	movw	%cx, 0x6(%rax)
               	movw	%cx, 0x8(%rax)
               	movw	%cx, 0xa(%rax)
               	movw	%cx, 0xc(%rax)
               	movw	%cx, 0xe(%rax)
               	leaq	-0x280(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x260(%rbp), %rbx
               	movzbq	(%rbx), %rax
               	xorq	$0xff, %rax
               	movl	%eax, %ecx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x7(%rbx), %rcx
               	xorq	$0xff, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x8(%rbx), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0xf(%rbx), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x34, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x11170, %ecx          # imm = 0x11170
               	leaq	-0x290(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movl	%ecx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	%ecx, 0x8(%rax)
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x290(%rbp), %rdi
               	movabsq	$-0x11170, %rcx         # imm = 0xFFFEEE90
               	leaq	-0x280(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movl	%ecx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x280(%rbp), %rsi
               	movl	%ecx, 0xc(%rsi)
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x260(%rbp), %rax
               	movzbq	(%rax), %rcx
               	xorq	$0xff, %rcx
               	movl	%ecx, %ecx
               	movl	$0x1, %r12d
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x1(%rax), %rcx
               	xorq	$0x7f, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x8(%rax), %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x9(%rax), %rax
               	xorq	$0x80, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x35, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x300(%rbp), %rdx
               	xorq	%rsi, %rsi
               	movl	$0x2, %edi
               	movl	$0x3, %r8d
               	movl	$0x4, %r9d
               	movl	$0x5, %ebx
               	leaq	-0x270(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x270(%rbp), %rax
               	movb	%sil, (%rax)
               	leaq	-0x270(%rbp), %rax
               	movb	%r12b, 0x1(%rax)
               	leaq	-0x270(%rbp), %rax
               	movb	%dil, 0x2(%rax)
               	movb	%r8b, 0x3(%rax)
               	leaq	-0x270(%rbp), %rax
               	movb	%r9b, 0x4(%rax)
               	movb	%bl, 0x5(%rax)
               	movl	$0x6, %ecx
               	movb	%cl, 0x6(%rax)
               	movl	$0x7, %ecx
               	movb	%cl, 0x7(%rax)
               	movl	$0x8, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x8(%rax)
               	movl	$0x9, %ecx
               	movb	%cl, 0x9(%rax)
               	movl	$0xa, %ecx
               	movb	%cl, 0xa(%rax)
               	movl	$0xb, %ecx
               	movb	%cl, 0xb(%rax)
               	movl	$0xc, %ecx
               	movb	%cl, 0xc(%rax)
               	movl	$0xd, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0xd(%rax)
               	movl	$0xe, %ecx
               	movb	%cl, 0xe(%rax)
               	movl	$0xf, %ecx
               	movb	%cl, 0xf(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x260(%rbp), %rbx
               	leaq	-0x300(%rbp), %rdi
               	leaq	-0x280(%rbp), %rsi
               	xorq	%rax, %rax
               	movq	%rax, (%rsi)
               	movq	%rax, 0x8(%rsi)
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x260(%rbp), %rbx
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
               	movzbq	0x2(%rbx), %rcx
               	xorq	$0x1, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xe(%rbx), %rax
               	xorq	$0x7, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0xf(%rbx), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x36, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x300(%rbp), %rdi
               	leaq	-0x280(%rbp), %rsi
               	xorq	%rax, %rax
               	movq	%rax, (%rsi)
               	movq	%rax, 0x8(%rsi)
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x260(%rbp), %rbx
               	movzbq	(%rbx), %rax
               	xorq	$0x8, %rax
               	movl	%eax, %ecx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x1(%rbx), %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xe(%rbx), %rax
               	xorq	$0xf, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0xf(%rbx), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x37, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x300(%rbp), %rdi
               	leaq	-0x280(%rbp), %rsi
               	xorq	%rax, %rax
               	movq	%rax, (%rsi)
               	movq	%rax, 0x8(%rsi)
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x260(%rbp), %rax
               	movzbq	(%rax), %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x1(%rax), %rdx
               	xorq	$0x1, %rdx
               	movl	%edx, %edx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x2(%rax), %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x3(%rax), %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x4(%rax), %rax
               	xorq	$0x2, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x38, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x260(%rbp), %rbx
               	leaq	-0x300(%rbp), %rdi
               	leaq	-0x280(%rbp), %rsi
               	xorq	%rax, %rax
               	movq	%rax, (%rsi)
               	movq	%rax, 0x8(%rsi)
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x260(%rbp), %rax
               	movzbq	(%rax), %rcx
               	xorq	$0x8, %rcx
               	movl	%ecx, %ecx
               	movl	$0x1, %r12d
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x1(%rax), %rcx
               	xorq	$0x9, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x2(%rax), %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x4(%rax), %rax
               	xorq	$0xa, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x39, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x300(%rbp), %rdx
               	movl	$0x2, %esi
               	movl	$0x3, %edi
               	movl	$0x4, %r8d
               	leaq	-0x270(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x270(%rbp), %rax
               	movl	%r12d, (%rax)
               	movl	%esi, 0x4(%rax)
               	leaq	-0x270(%rbp), %rax
               	movl	%edi, 0x8(%rax)
               	movl	%r8d, 0xc(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rcx
               	leaq	-0x2f0(%rbp), %rdx
               	movl	$0x5, %esi
               	movl	$0x6, %edi
               	movl	$0x7, %r8d
               	movl	$0x8, %r9d
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x270(%rbp), %rax
               	movl	%esi, (%rax)
               	movl	%edi, 0x4(%rax)
               	leaq	-0x270(%rbp), %rax
               	movl	%r8d, 0x8(%rax)
               	movl	%r9d, 0xc(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x250(%rbp), %rbx
               	leaq	-0x300(%rbp), %rdi
               	leaq	-0x2f0(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rbx
               	movl	(%rbx), %eax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0x4(%rbx), %eax
               	xorq	$0x5, %rax
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
               	xorq	$0x6, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x300(%rbp), %rdi
               	leaq	-0x2f0(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rbx
               	movl	(%rbx), %eax
               	xorq	$0x3, %rax
               	movl	%eax, %ecx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0x4(%rbx), %ecx
               	xorq	$0x7, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0x8(%rbx), %eax
               	xorq	$0x4, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0xc(%rbx), %eax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3b, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x300(%rbp), %rdi
               	leaq	-0x2f0(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rcx
               	movl	(%rcx), %eax
               	xorq	$0x3, %rax
               	movl	%eax, %edx
               	movl	$0x1, %eax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	0x4(%rcx), %edx
               	xorq	$0x4, %rdx
               	movl	%edx, %edx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	0x8(%rcx), %eax
               	xorq	$0x7, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0xc(%rcx), %eax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3c, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movabsq	$-0x10, %rdx
               	leaq	-0xb0(%rbp), %rax
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movw	%dx, (%rax)
               	movw	%dx, 0x2(%rax)
               	movw	%dx, 0x4(%rax)
               	movw	%dx, 0x6(%rax)
               	leaq	-0xb0(%rbp), %rax
               	movw	%dx, 0x8(%rax)
               	movw	%dx, 0xa(%rax)
               	movw	%dx, 0xc(%rax)
               	movw	%dx, 0xe(%rax)
               	leaq	-0xa0(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	psraw	$0x2, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	%rcx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rdi
               	movl	(%rdi), %eax
               	movl	$0xfffcfffc, %r11d      # imm = 0xFFFCFFFC
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x3d, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movabsq	$-0x10, %rcx
               	leaq	-0x90(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	leaq	-0x90(%rbp), %rax
               	movw	%cx, 0x8(%rax)
               	movw	%cx, 0xa(%rax)
               	movw	%cx, 0xc(%rax)
               	movw	%cx, 0xe(%rax)
               	leaq	-0x80(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	psraw	$0x20, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rdi
               	movl	(%rdi), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x3e, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movabsq	$-0x10, %rcx
               	leaq	-0x70(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movl	%ecx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	%ecx, 0x8(%rax)
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x70(%rbp), %rax
               	leaq	-0x60(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	psrad	$0x2, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rdi
               	movl	(%rdi), %eax
               	movl	$0xfffffffc, %r11d      # imm = 0xFFFFFFFC
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x3f, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x3, %r8d
               	movabsq	$-0x40, %rcx
               	leaq	-0x50(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movl	%ecx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x50(%rbp), %rax
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x40(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	movq	%r8, %xmm14
               	psrad	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rax
               	movl	(%rax), %eax
               	movl	$0xfffffff8, %r11d      # imm = 0xFFFFFFF8
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x40, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x300(%rbp), %rdx
               	movl	$0x1, %ebx
               	xorq	%rsi, %rsi
               	movl	$0x2, %edi
               	movl	$0x3, %r8d
               	movl	$0x4, %r9d
               	movl	$0x5, %r12d
               	leaq	-0x270(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x270(%rbp), %rax
               	movb	%sil, (%rax)
               	leaq	-0x270(%rbp), %rax
               	movb	%bl, 0x1(%rax)
               	leaq	-0x270(%rbp), %rax
               	movb	%dil, 0x2(%rax)
               	movb	%r8b, 0x3(%rax)
               	leaq	-0x270(%rbp), %rax
               	movb	%r9b, 0x4(%rax)
               	movb	%r12b, 0x5(%rax)
               	movl	$0x6, %ecx
               	movb	%cl, 0x6(%rax)
               	movl	$0x7, %ecx
               	movb	%cl, 0x7(%rax)
               	movl	$0x8, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x8(%rax)
               	movl	$0x9, %ecx
               	movb	%cl, 0x9(%rax)
               	movl	$0xa, %ecx
               	movb	%cl, 0xa(%rax)
               	movl	$0xb, %ecx
               	movb	%cl, 0xb(%rax)
               	movl	$0xc, %ecx
               	movb	%cl, 0xc(%rax)
               	movl	$0xd, %ecx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0xd(%rax)
               	movl	$0xe, %ecx
               	movb	%cl, 0xe(%rax)
               	movl	$0xf, %ecx
               	movb	%cl, 0xf(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x260(%rbp), %rdi
               	leaq	-0x300(%rbp), %rax
               	leaq	-0x30(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	psrldq	$0x3, %xmm15            # xmm15 = xmm15[3,4,5,6,7,8,9,10,11,12,13,14,15],zero,zero,zero
               	movdqu	%xmm15, (%rsi)
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x260(%rbp), %rax
               	movzbq	(%rax), %rcx
               	xorq	$0x3, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xc(%rax), %rcx
               	xorq	$0xf, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%bl
               	movzbq	%bl, %rbx
               	movl	$0x1, %ecx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movzbq	0xd(%rax), %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xf(%rax), %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x41, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x300(%rbp), %rcx
               	movl	$0xbeef, %edx           # imm = 0xBEEF
               	leaq	-0x20(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	pinsrw	$0x2, %edx, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	%rax, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x260(%rbp), %rcx
               	movzbq	0x4(%rcx), %rax
               	xorq	$0xef, %rax
               	movl	%eax, %edx
               	movl	$0x1, %eax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x5(%rcx), %rax
               	xorq	$0xbe, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0x6(%rcx), %rax
               	xorq	$0x6, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x42, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movabsq	$-0x80, %rax
               	leaq	-0x270(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	movb	%al, (%rcx)
               	movb	%al, 0x1(%rcx)
               	movb	%al, 0x2(%rcx)
               	movb	%al, 0x3(%rcx)
               	movb	%al, 0x4(%rcx)
               	leaq	-0x270(%rbp), %rcx
               	movb	%al, 0x5(%rcx)
               	movb	%al, 0x6(%rcx)
               	movb	%al, 0x7(%rcx)
               	movb	%al, 0x8(%rcx)
               	movb	%al, 0x9(%rcx)
               	movb	%al, 0xa(%rcx)
               	movb	%al, 0xb(%rcx)
               	leaq	-0x270(%rbp), %rdi
               	movb	%al, 0xc(%rdi)
               	movb	%al, 0xd(%rdi)
               	movb	%al, 0xe(%rdi)
               	movb	%al, 0xf(%rdi)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	cmpq	$0xffff, %rax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x43, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x270(%rbp), %rdi
               	xorq	%rax, %rax
               	movq	%rax, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x44, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movabsq	$-0x80, %rsi
               	xorq	%rcx, %rcx
               	leaq	-0x270(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x270(%rbp), %rax
               	movb	%sil, (%rax)
               	movb	%cl, 0x1(%rax)
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x2(%rax)
               	movb	%cl, 0x3(%rax)
               	movb	%cl, 0x4(%rax)
               	movb	%cl, 0x5(%rax)
               	xorq	%rcx, %rcx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0x6(%rax)
               	movb	%cl, 0x7(%rax)
               	movb	%cl, 0x8(%rax)
               	movb	%cl, 0x9(%rax)
               	xorq	%rcx, %rcx
               	leaq	-0x270(%rbp), %rax
               	movb	%cl, 0xa(%rax)
               	movb	%cl, 0xb(%rax)
               	movb	%cl, 0xc(%rax)
               	movb	%cl, 0xd(%rax)
               	xorq	%rax, %rax
               	leaq	-0x270(%rbp), %rdi
               	movb	%al, 0xe(%rdi)
               	movabsq	$-0x80, %rax
               	movb	%al, 0xf(%rdi)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	cmpq	$0x8001, %rax           # imm = 0x8001
               	je	<addr>
               	movl	$0x45, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x250(%rbp), %rbx
               	movl	$0xf, %eax
               	leaq	-0x290(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	movb	%al, (%rcx)
               	movb	%al, 0x1(%rcx)
               	movb	%al, 0x2(%rcx)
               	movb	%al, 0x3(%rcx)
               	leaq	-0x290(%rbp), %rcx
               	movb	%al, 0x4(%rcx)
               	movb	%al, 0x5(%rcx)
               	movb	%al, 0x6(%rcx)
               	movb	%al, 0x7(%rcx)
               	movb	%al, 0x8(%rcx)
               	movb	%al, 0x9(%rcx)
               	leaq	-0x290(%rbp), %rcx
               	movb	%al, 0xa(%rcx)
               	movb	%al, 0xb(%rcx)
               	movb	%al, 0xc(%rcx)
               	movb	%al, 0xd(%rcx)
               	movb	%al, 0xe(%rcx)
               	movb	%al, 0xf(%rcx)
               	leaq	-0x290(%rbp), %rdi
               	movl	$0x33, %eax
               	leaq	-0x280(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	movb	%al, (%rcx)
               	movb	%al, 0x1(%rcx)
               	movb	%al, 0x2(%rcx)
               	leaq	-0x280(%rbp), %rcx
               	movb	%al, 0x3(%rcx)
               	movb	%al, 0x4(%rcx)
               	movb	%al, 0x5(%rcx)
               	movb	%al, 0x6(%rcx)
               	movb	%al, 0x7(%rcx)
               	leaq	-0x280(%rbp), %rcx
               	movb	%al, 0x8(%rcx)
               	movb	%al, 0x9(%rcx)
               	movb	%al, 0xa(%rcx)
               	movb	%al, 0xb(%rcx)
               	movb	%al, 0xc(%rcx)
               	leaq	-0x280(%rbp), %rsi
               	movb	%al, 0xd(%rsi)
               	movb	%al, 0xe(%rsi)
               	movb	%al, 0xf(%rsi)
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rbx
               	movl	(%rbx), %eax
               	cmpl	$0x30303030, %eax       # imm = 0x30303030
               	je	<addr>
               	movl	$0x46, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x300(%rbp), %rdi
               	movq	%rdi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rbx
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
               	movl	$0x47, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x7, %ecx
               	leaq	-0x290(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	leaq	-0x290(%rbp), %rdi
               	movw	%cx, 0x8(%rdi)
               	movw	%cx, 0xa(%rdi)
               	movw	%cx, 0xc(%rdi)
               	movw	%cx, 0xe(%rdi)
               	movl	$0x8, %ecx
               	leaq	-0x280(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	leaq	-0x280(%rbp), %rax
               	movw	%cx, 0x6(%rax)
               	movw	%cx, 0x8(%rax)
               	movw	%cx, 0xa(%rax)
               	movw	%cx, 0xc(%rax)
               	movw	%cx, 0xe(%rax)
               	leaq	-0x280(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rbx
               	movl	(%rbx), %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x48, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x7, %ecx
               	leaq	-0x290(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movl	%ecx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	%ecx, 0x8(%rax)
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x290(%rbp), %rdi
               	movl	$0x7, %ecx
               	leaq	-0x280(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movl	%ecx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x280(%rbp), %rsi
               	movl	%ecx, 0xc(%rsi)
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rbx
               	movl	(%rbx), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x49, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movabsq	$-0x1, %rcx
               	leaq	-0x290(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	leaq	-0x290(%rbp), %rdi
               	movw	%cx, 0x8(%rdi)
               	movw	%cx, 0xa(%rdi)
               	movw	%cx, 0xc(%rdi)
               	movw	%cx, 0xe(%rdi)
               	movabsq	$-0x2, %rcx
               	leaq	-0x280(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	leaq	-0x280(%rbp), %rax
               	movw	%cx, 0x6(%rax)
               	movw	%cx, 0x8(%rax)
               	movw	%cx, 0xa(%rax)
               	movw	%cx, 0xc(%rax)
               	movw	%cx, 0xe(%rax)
               	leaq	-0x280(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rbx
               	movl	(%rbx), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x4a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movabsq	$-0x2, %rcx
               	leaq	-0x290(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movl	%ecx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	%ecx, 0x8(%rax)
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x290(%rbp), %rdi
               	movabsq	$-0x1, %rcx
               	leaq	-0x280(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movl	%ecx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x280(%rbp), %rsi
               	movl	%ecx, 0xc(%rsi)
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rax
               	movl	(%rax), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x4b, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x260(%rbp), %rax
               	leaq	(%rax), %rcx
               	movl	$0x1, %edx
               	movb	%dl, (%rcx)
               	movl	$0x2, %ecx
               	movb	%cl, 0x1(%rax)
               	movl	$0x3, %ecx
               	movb	%cl, 0x2(%rax)
               	movl	$0x4, %ecx
               	movb	%cl, 0x3(%rax)
               	movl	$0x5, %ecx
               	movb	%cl, 0x4(%rax)
               	movl	$0x6, %ecx
               	movb	%cl, 0x5(%rax)
               	movl	$0x7, %ecx
               	movb	%cl, 0x6(%rax)
               	leaq	-0x260(%rbp), %rax
               	movl	$0x8, %ecx
               	movb	%cl, 0x7(%rax)
               	movl	$0x9, %ecx
               	movb	%cl, 0x8(%rax)
               	movl	$0xa, %ecx
               	movb	%cl, 0x9(%rax)
               	movl	$0xb, %ecx
               	movb	%cl, 0xa(%rax)
               	movl	$0xc, %ecx
               	movb	%cl, 0xb(%rax)
               	movl	$0xd, %ecx
               	movb	%cl, 0xc(%rax)
               	movl	$0xe, %ecx
               	movb	%cl, 0xd(%rax)
               	leaq	-0x260(%rbp), %rax
               	movl	$0xf, %ecx
               	movb	%cl, 0xe(%rax)
               	movl	$0x10, %ecx
               	movb	%cl, 0xf(%rax)
               	leaq	-0x250(%rbp), %rdi
               	leaq	-0x270(%rbp), %rsi
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movq	(%rax), %rax
               	movq	%rax, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rcx
               	movl	(%rcx), %eax
               	cmpl	$0x4030201, %eax        # imm = 0x4030201
               	movl	$0x1, %eax
               	jne	<addr>
               	movl	0x4(%rcx), %edx
               	cmpl	$0x8070605, %edx        # imm = 0x8070605
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	0x8(%rcx), %edx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	0xc(%rcx), %ecx
               	testl	%ecx, %ecx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x4c, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x260(%rbp), %rdx
               	movabsq	$-0x1111111111111112, %rcx # imm = 0xEEEEEEEEEEEEEEEE
               	movq	%rcx, (%rdx)
               	movq	%rcx, 0x8(%rdx)
               	movl	$0x2, %edi
               	movl	$0x3, %r8d
               	movl	$0x4, %r9d
               	leaq	-0x270(%rbp), %rcx
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	leaq	-0x270(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movl	%edi, 0x4(%rcx)
               	leaq	-0x270(%rbp), %rcx
               	movl	%r8d, 0x8(%rcx)
               	movl	%r9d, 0xc(%rcx)
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rdx)
               	leaq	-0x260(%rbp), %rcx
               	movzbq	(%rcx), %rdx
               	xorq	$0x1, %rdx
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x4(%rcx), %rax
               	xorq	$0x2, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0x8(%rcx), %rax
               	xorq	$0xee, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4d, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rbx
               	leaq	-0x300(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x260(%rbp), %r12
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, -0x270(%rbp)
               	movq	%rdx, -0x268(%rbp)
               	leaq	-0x270(%rbp), %rsi
               	movq	%r12, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x260(%rbp), %rax
               	leaq	(%rax), %rcx
               	movzbq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4e, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movzbq	0x1(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movzbq	0x2(%rax), %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movzbq	0x3(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movzbq	0x4(%rax), %rcx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movzbq	0x5(%rax), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movzbq	0x6(%rax), %rcx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movzbq	0x7(%rax), %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	leaq	-0x260(%rbp), %rax
               	movzbq	0x8(%rax), %rcx
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	movzbq	0x9(%rax), %rcx
               	cmpl	$0x9, %ecx
               	jne	<addr>
               	movzbq	0xa(%rax), %rcx
               	cmpl	$0xa, %ecx
               	jne	<addr>
               	movzbq	0xb(%rax), %rcx
               	cmpl	$0xb, %ecx
               	jne	<addr>
               	movzbq	0xc(%rax), %rcx
               	cmpl	$0xc, %ecx
               	jne	<addr>
               	movzbq	0xd(%rax), %rcx
               	cmpl	$0xd, %ecx
               	jne	<addr>
               	movzbq	0xe(%rax), %rcx
               	cmpl	$0xe, %ecx
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	cmpl	$0xf, %eax
               	jne	<addr>
               	leaq	-0x250(%rbp), %rdi
               	movabsq	$-0x1, %rdx
               	leaq	-0x270(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movl	%edx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	%ecx, 0x8(%rax)
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x270(%rbp), %rsi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rcx
               	movl	(%rcx), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rax, %rdx
               	cmpl	%r11d, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	movl	0x4(%rcx), %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0xc(%rcx), %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x50, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x200(%rbp), %rdx
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	0x1(%rcx), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	-0x2d0(%rbp), %rsi
               	leaq	-0x200(%rbp), %rax
               	addq	$0x3, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x260(%rbp), %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x260(%rbp), %rax
               	movzbq	(%rax), %rcx
               	xorq	$0x4, %rcx
               	movl	%ecx, %edx
               	testl	%edx, %edx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	xorq	$0x13, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x51, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x200(%rbp), %rax
               	leaq	0x5(%rax), %rsi
               	leaq	-0x270(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rcx
               	movzbq	0x4(%rax), %rcx
               	xorq	$0x5, %rcx
               	movl	%ecx, %edx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x5(%rax), %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x14(%rax), %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x15(%rax), %rax
               	xorq	$0x16, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x52, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x53, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%r12, %rcx
               	jmp	<addr>
               	movq	%r12, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%r12, %rcx
               	jmp	<addr>
               	movq	%r12, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
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
               	movl	$0x1f, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
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
               	movq	%rbx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
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
