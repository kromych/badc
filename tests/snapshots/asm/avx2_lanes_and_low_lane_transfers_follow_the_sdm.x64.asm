
avx2_lanes_and_low_lane_transfers_follow_the_sdm.x64:	file format elf64-x86-64

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

<_mm256_loadu_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	leaq	(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movq	-0x20(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_storeu_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leave
               	retq

<_mm256_setzero_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_set1_epi8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movsbq	%sil, %rsi
               	leaq	(%rsp), %rcx
               	andq	$0xff, %rsi
               	movb	%sil, (%rsp)
               	movb	%sil, 0x1(%rsp)
               	movb	%sil, 0x2(%rsp)
               	movb	%sil, 0x3(%rsp)
               	movb	%sil, 0x4(%rsp)
               	movb	%sil, 0x5(%rsp)
               	movb	%sil, 0x6(%rsp)
               	movb	%sil, 0x7(%rsp)
               	movb	%sil, 0x8(%rsp)
               	movb	%sil, 0x9(%rsp)
               	movb	%sil, 0xa(%rsp)
               	movb	%sil, 0xb(%rsp)
               	movb	%sil, 0xc(%rsp)
               	movb	%sil, 0xd(%rsp)
               	movb	%sil, 0xe(%rsp)
               	movb	%sil, 0xf(%rsp)
               	movb	%sil, 0x10(%rsp)
               	movb	%sil, 0x11(%rsp)
               	movb	%sil, 0x12(%rsp)
               	movb	%sil, 0x13(%rsp)
               	movb	%sil, 0x14(%rsp)
               	movb	%sil, 0x15(%rsp)
               	movb	%sil, 0x16(%rsp)
               	movb	%sil, 0x17(%rsp)
               	movb	%sil, 0x18(%rsp)
               	movb	%sil, 0x19(%rsp)
               	movb	%sil, 0x1a(%rsp)
               	movb	%sil, 0x1b(%rsp)
               	movb	%sil, 0x1c(%rsp)
               	movb	%sil, 0x1d(%rsp)
               	movb	%sil, 0x1e(%rsp)
               	movb	%sil, 0x1f(%rsp)
               	movq	-0x20(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_set1_epi16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movswq	%si, %rsi
               	movw	%si, (%rsp)
               	movw	%si, 0x2(%rsp)
               	movw	%si, 0x4(%rsp)
               	movw	%si, 0x6(%rsp)
               	movw	%si, 0x8(%rsp)
               	movw	%si, 0xa(%rsp)
               	movw	%si, 0xc(%rsp)
               	movw	%si, 0xe(%rsp)
               	movw	%si, 0x10(%rsp)
               	movw	%si, 0x12(%rsp)
               	movw	%si, 0x14(%rsp)
               	movw	%si, 0x16(%rsp)
               	movw	%si, 0x18(%rsp)
               	movw	%si, 0x1a(%rsp)
               	leaq	(%rsp), %rcx
               	movw	%si, 0x1c(%rsp)
               	movw	%si, 0x1e(%rsp)
               	movq	-0x20(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_set1_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movl	%esi, (%rsp)
               	movl	%esi, 0x4(%rsp)
               	movl	%esi, 0x8(%rsp)
               	movl	%esi, 0xc(%rsp)
               	movl	%esi, 0x10(%rsp)
               	movl	%esi, 0x14(%rsp)
               	movl	%esi, 0x18(%rsp)
               	leaq	(%rsp), %rcx
               	movl	%esi, 0x1c(%rsp)
               	movq	-0x20(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_set1_epi64x>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	-0x20(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	%rsi, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rsi, 0x18(%rax)
               	leave
               	retq

<_mm256_broadcastb_epi8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movups	%xmm0, 0x20(%rsp)
               	movq	-0x20(%rbp), %rbx
               	leaq	(%rsp), %rdi
               	movsbq	0x20(%rsp), %rsi
               	callq	<addr>
               	leaq	(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_broadcastw_epi16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movups	%xmm0, 0x20(%rsp)
               	movq	-0x20(%rbp), %rbx
               	leaq	(%rsp), %rdi
               	movswq	0x20(%rsp), %rsi
               	callq	<addr>
               	leaq	(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_broadcastd_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movups	%xmm0, 0x20(%rsp)
               	movq	-0x20(%rbp), %rbx
               	leaq	(%rsp), %rdi
               	movl	0x20(%rsp), %esi
               	callq	<addr>
               	leaq	(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_broadcastq_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movups	%xmm0, 0x20(%rsp)
               	movq	-0x20(%rbp), %rbx
               	leaq	(%rsp), %rdi
               	movq	0x20(%rsp), %rsi
               	callq	<addr>
               	leaq	(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_castsi128_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movups	%xmm0, 0x20(%rsp)
               	movq	-0x20(%rbp), %rax
               	leaq	(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movq	0x20(%rsp), %rdx
               	movq	%rdx, (%rsp)
               	movq	0x28(%rsp), %rdx
               	movq	%rdx, 0x8(%rsp)
               	movq	$0x0, 0x10(%rsp)
               	leaq	(%rsp), %rdx
               	movq	$0x0, 0x18(%rsp)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_extracti128_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	testb	$0x1, %dil
               	je	<addr>
               	leaq	0x20(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rsp), %rcx
               	movq	%rcx, 0x20(%rsp)
               	movq	0x18(%rsp), %rcx
               	movq	%rcx, 0x28(%rsp)
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq
               	leaq	0x30(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	(%rsp), %rcx
               	movq	%rcx, 0x30(%rsp)
               	movq	0x8(%rsp), %rcx
               	movq	%rcx, 0x38(%rsp)
               	jmp	<addr>

<_mm256_inserti128_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movups	%xmm0, 0x20(%rsp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %rcx
               	movq	0x20(%rsp), %rax
               	movq	%rax, 0x10(%rsp)
               	movq	0x28(%rsp), %rax
               	movq	%rax, 0x18(%rsp)
               	movq	-0x30(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_and_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x40, %rsp
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
               	movq	(%rsp), %rcx
               	movq	0x20(%rsp), %rdx
               	andq	%rdx, %rcx
               	movq	0x8(%rsp), %rdx
               	movq	0x28(%rsp), %rsi
               	andq	%rsi, %rdx
               	movq	0x10(%rsp), %rsi
               	movq	0x30(%rsp), %rdi
               	andq	%rdi, %rsi
               	movq	0x18(%rsp), %rdi
               	movq	0x38(%rsp), %r8
               	andq	%r8, %rdi
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	leave
               	retq

<_mm256_andnot_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x40, %rsp
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
               	movq	(%rsp), %rcx
               	xorq	$-0x1, %rcx
               	movq	0x8(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movq	0x10(%rsp), %rsi
               	xorq	$-0x1, %rsi
               	movq	0x18(%rsp), %rdi
               	xorq	$-0x1, %rdi
               	movq	0x20(%rsp), %r8
               	andq	%r8, %rcx
               	movq	0x28(%rsp), %r8
               	andq	%r8, %rdx
               	movq	0x30(%rsp), %r8
               	andq	%r8, %rsi
               	movq	0x38(%rsp), %r8
               	andq	%r8, %rdi
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	leave
               	retq

<_mm256_or_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x40, %rsp
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
               	movq	(%rsp), %rcx
               	movq	0x20(%rsp), %rdx
               	orq	%rdx, %rcx
               	movq	0x8(%rsp), %rdx
               	movq	0x28(%rsp), %rsi
               	orq	%rsi, %rdx
               	movq	0x10(%rsp), %rsi
               	movq	0x30(%rsp), %rdi
               	orq	%rdi, %rsi
               	movq	0x18(%rsp), %rdi
               	movq	0x38(%rsp), %r8
               	orq	%r8, %rdi
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	leave
               	retq

<_mm256_xor_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x40, %rsp
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
               	movq	(%rsp), %rcx
               	movq	0x20(%rsp), %rdx
               	xorq	%rdx, %rcx
               	movq	0x8(%rsp), %rdx
               	movq	0x28(%rsp), %rsi
               	xorq	%rsi, %rdx
               	movq	0x10(%rsp), %rsi
               	movq	0x30(%rsp), %rdi
               	xorq	%rdi, %rsi
               	movq	0x18(%rsp), %rdi
               	movq	0x38(%rsp), %r8
               	xorq	%r8, %rdi
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	leave
               	retq

<_mm256_testz_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
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
               	movq	(%rsp), %rax
               	movq	0x20(%rsp), %rcx
               	andq	%rcx, %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x28(%rsp), %rdx
               	andq	%rdx, %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x30(%rsp), %rsi
               	andq	%rsi, %rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x38(%rsp), %rdi
               	andq	%rdi, %rsi
               	orq	%rcx, %rax
               	orq	%rdx, %rax
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq

<_mm256_add_epi8>:
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
               	movzbq	(%rsp), %rdx
               	movzbq	0x20(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x1(%rsp), %rdx
               	movzbq	0x21(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x2(%rsp), %rdx
               	movzbq	0x22(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x3(%rsp), %rdx
               	movzbq	0x23(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x4(%rsp), %rdx
               	movzbq	0x24(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x5(%rsp), %rdx
               	movzbq	0x25(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x6(%rsp), %rdx
               	movzbq	0x26(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x7(%rsp), %rdx
               	movzbq	0x27(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x8(%rsp), %rdx
               	movzbq	0x28(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x9(%rsp), %rdx
               	movzbq	0x29(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x49(%rsp)
               	movzbq	0xa(%rsp), %rdx
               	movzbq	0x2a(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0xb(%rsp), %rdx
               	movzbq	0x2b(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0xc(%rsp), %rdx
               	movzbq	0x2c(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0xd(%rsp), %rdx
               	movzbq	0x2d(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0xe(%rsp), %rdx
               	movzbq	0x2e(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0xf(%rsp), %rdx
               	movzbq	0x2f(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x4f(%rsp)
               	movzbq	0x10(%rsp), %rdx
               	movzbq	0x30(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x50(%rsp)
               	movzbq	0x11(%rsp), %rdx
               	movzbq	0x31(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x51(%rsp)
               	movzbq	0x12(%rsp), %rdx
               	movzbq	0x32(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x52(%rsp)
               	movzbq	0x13(%rsp), %rdx
               	movzbq	0x33(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x53(%rsp)
               	movzbq	0x14(%rsp), %rdx
               	movzbq	0x34(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x54(%rsp)
               	movzbq	0x15(%rsp), %rdx
               	movzbq	0x35(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x55(%rsp)
               	movzbq	0x16(%rsp), %rdx
               	movzbq	0x36(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x56(%rsp)
               	movzbq	0x17(%rsp), %rdx
               	movzbq	0x37(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x57(%rsp)
               	movzbq	0x18(%rsp), %rdx
               	movzbq	0x38(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x58(%rsp)
               	movzbq	0x19(%rsp), %rdx
               	movzbq	0x39(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x59(%rsp)
               	movzbq	0x1a(%rsp), %rdx
               	movzbq	0x3a(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x5a(%rsp)
               	movzbq	0x1b(%rsp), %rdx
               	movzbq	0x3b(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x5b(%rsp)
               	movzbq	0x1c(%rsp), %rdx
               	movzbq	0x3c(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x5c(%rsp)
               	movzbq	0x1d(%rsp), %rdx
               	movzbq	0x3d(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x5d(%rsp)
               	movzbq	0x1e(%rsp), %rdx
               	movzbq	0x3e(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x5e(%rsp)
               	movzbq	0x1f(%rsp), %rdx
               	movzbq	0x3f(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x5f(%rsp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_add_epi16>:
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
               	movzwq	(%rsp), %rdx
               	movzwq	0x20(%rsp), %rsi
               	addq	%rsi, %rdx
               	movw	%dx, 0x40(%rsp)
               	movzwq	0x2(%rsp), %rdx
               	movzwq	0x22(%rsp), %rsi
               	addq	%rsi, %rdx
               	movw	%dx, 0x42(%rsp)
               	movzwq	0x4(%rsp), %rdx
               	movzwq	0x24(%rsp), %rsi
               	addq	%rsi, %rdx
               	movw	%dx, 0x44(%rsp)
               	movzwq	0x6(%rsp), %rdx
               	movzwq	0x26(%rsp), %rsi
               	addq	%rsi, %rdx
               	movw	%dx, 0x46(%rsp)
               	movzwq	0x8(%rsp), %rdx
               	movzwq	0x28(%rsp), %rsi
               	addq	%rsi, %rdx
               	movw	%dx, 0x48(%rsp)
               	movzwq	0xa(%rsp), %rdx
               	movzwq	0x2a(%rsp), %rsi
               	addq	%rsi, %rdx
               	movw	%dx, 0x4a(%rsp)
               	movzwq	0xc(%rsp), %rdx
               	movzwq	0x2c(%rsp), %rsi
               	addq	%rsi, %rdx
               	movw	%dx, 0x4c(%rsp)
               	movzwq	0xe(%rsp), %rdx
               	movzwq	0x2e(%rsp), %rsi
               	addq	%rsi, %rdx
               	movw	%dx, 0x4e(%rsp)
               	movzwq	0x10(%rsp), %rdx
               	movzwq	0x30(%rsp), %rsi
               	addq	%rsi, %rdx
               	movw	%dx, 0x50(%rsp)
               	movzwq	0x12(%rsp), %rdx
               	movzwq	0x32(%rsp), %rsi
               	addq	%rsi, %rdx
               	movw	%dx, 0x52(%rsp)
               	movzwq	0x14(%rsp), %rdx
               	movzwq	0x34(%rsp), %rsi
               	addq	%rsi, %rdx
               	movw	%dx, 0x54(%rsp)
               	movzwq	0x16(%rsp), %rdx
               	movzwq	0x36(%rsp), %rsi
               	addq	%rsi, %rdx
               	movw	%dx, 0x56(%rsp)
               	movzwq	0x18(%rsp), %rdx
               	movzwq	0x38(%rsp), %rsi
               	addq	%rsi, %rdx
               	movw	%dx, 0x58(%rsp)
               	movzwq	0x1a(%rsp), %rdx
               	movzwq	0x3a(%rsp), %rsi
               	addq	%rsi, %rdx
               	movw	%dx, 0x5a(%rsp)
               	movzwq	0x1c(%rsp), %rdx
               	movzwq	0x3c(%rsp), %rsi
               	addq	%rsi, %rdx
               	movw	%dx, 0x5c(%rsp)
               	movzwq	0x1e(%rsp), %rdx
               	movzwq	0x3e(%rsp), %rsi
               	addq	%rsi, %rdx
               	movw	%dx, 0x5e(%rsp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_add_epi32>:
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
               	movl	(%rsp), %edx
               	movl	0x20(%rsp), %esi
               	addq	%rsi, %rdx
               	movl	%edx, 0x40(%rsp)
               	movl	0x4(%rsp), %edx
               	movl	0x24(%rsp), %esi
               	addq	%rsi, %rdx
               	movl	%edx, 0x44(%rsp)
               	movl	0x8(%rsp), %edx
               	movl	0x28(%rsp), %esi
               	addq	%rsi, %rdx
               	movl	%edx, 0x48(%rsp)
               	movl	0xc(%rsp), %edx
               	movl	0x2c(%rsp), %esi
               	addq	%rsi, %rdx
               	movl	%edx, 0x4c(%rsp)
               	movl	0x10(%rsp), %edx
               	movl	0x30(%rsp), %esi
               	addq	%rsi, %rdx
               	movl	%edx, 0x50(%rsp)
               	movl	0x14(%rsp), %edx
               	movl	0x34(%rsp), %esi
               	addq	%rsi, %rdx
               	movl	%edx, 0x54(%rsp)
               	movl	0x18(%rsp), %edx
               	movl	0x38(%rsp), %esi
               	addq	%rsi, %rdx
               	movl	%edx, 0x58(%rsp)
               	movl	0x1c(%rsp), %edx
               	movl	0x3c(%rsp), %esi
               	addq	%rsi, %rdx
               	movl	%edx, 0x5c(%rsp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_add_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x40, %rsp
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
               	movq	(%rsp), %rcx
               	movq	0x20(%rsp), %rdx
               	addq	%rdx, %rcx
               	movq	0x8(%rsp), %rdx
               	movq	0x28(%rsp), %rsi
               	addq	%rsi, %rdx
               	movq	0x10(%rsp), %rsi
               	movq	0x30(%rsp), %rdi
               	addq	%rdi, %rsi
               	movq	0x18(%rsp), %rdi
               	movq	0x38(%rsp), %r8
               	addq	%r8, %rdi
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	leave
               	retq

<_mm256_sub_epi8>:
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
               	movzbq	(%rsp), %rdx
               	movzbq	0x20(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x1(%rsp), %rdx
               	movzbq	0x21(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x2(%rsp), %rdx
               	movzbq	0x22(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x3(%rsp), %rdx
               	movzbq	0x23(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x4(%rsp), %rdx
               	movzbq	0x24(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x5(%rsp), %rdx
               	movzbq	0x25(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x6(%rsp), %rdx
               	movzbq	0x26(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x7(%rsp), %rdx
               	movzbq	0x27(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x8(%rsp), %rdx
               	movzbq	0x28(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x9(%rsp), %rdx
               	movzbq	0x29(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x49(%rsp)
               	movzbq	0xa(%rsp), %rdx
               	movzbq	0x2a(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0xb(%rsp), %rdx
               	movzbq	0x2b(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0xc(%rsp), %rdx
               	movzbq	0x2c(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0xd(%rsp), %rdx
               	movzbq	0x2d(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0xe(%rsp), %rdx
               	movzbq	0x2e(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0xf(%rsp), %rdx
               	movzbq	0x2f(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x4f(%rsp)
               	movzbq	0x10(%rsp), %rdx
               	movzbq	0x30(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x50(%rsp)
               	movzbq	0x11(%rsp), %rdx
               	movzbq	0x31(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x51(%rsp)
               	movzbq	0x12(%rsp), %rdx
               	movzbq	0x32(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x52(%rsp)
               	movzbq	0x13(%rsp), %rdx
               	movzbq	0x33(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x53(%rsp)
               	movzbq	0x14(%rsp), %rdx
               	movzbq	0x34(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x54(%rsp)
               	movzbq	0x15(%rsp), %rdx
               	movzbq	0x35(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x55(%rsp)
               	movzbq	0x16(%rsp), %rdx
               	movzbq	0x36(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x56(%rsp)
               	movzbq	0x17(%rsp), %rdx
               	movzbq	0x37(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x57(%rsp)
               	movzbq	0x18(%rsp), %rdx
               	movzbq	0x38(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x58(%rsp)
               	movzbq	0x19(%rsp), %rdx
               	movzbq	0x39(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x59(%rsp)
               	movzbq	0x1a(%rsp), %rdx
               	movzbq	0x3a(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x5a(%rsp)
               	movzbq	0x1b(%rsp), %rdx
               	movzbq	0x3b(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x5b(%rsp)
               	movzbq	0x1c(%rsp), %rdx
               	movzbq	0x3c(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x5c(%rsp)
               	movzbq	0x1d(%rsp), %rdx
               	movzbq	0x3d(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x5d(%rsp)
               	movzbq	0x1e(%rsp), %rdx
               	movzbq	0x3e(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x5e(%rsp)
               	movzbq	0x1f(%rsp), %rdx
               	movzbq	0x3f(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x5f(%rsp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_sub_epi16>:
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
               	movzwq	(%rsp), %rdx
               	movzwq	0x20(%rsp), %rsi
               	subq	%rsi, %rdx
               	movw	%dx, 0x40(%rsp)
               	movzwq	0x2(%rsp), %rdx
               	movzwq	0x22(%rsp), %rsi
               	subq	%rsi, %rdx
               	movw	%dx, 0x42(%rsp)
               	movzwq	0x4(%rsp), %rdx
               	movzwq	0x24(%rsp), %rsi
               	subq	%rsi, %rdx
               	movw	%dx, 0x44(%rsp)
               	movzwq	0x6(%rsp), %rdx
               	movzwq	0x26(%rsp), %rsi
               	subq	%rsi, %rdx
               	movw	%dx, 0x46(%rsp)
               	movzwq	0x8(%rsp), %rdx
               	movzwq	0x28(%rsp), %rsi
               	subq	%rsi, %rdx
               	movw	%dx, 0x48(%rsp)
               	movzwq	0xa(%rsp), %rdx
               	movzwq	0x2a(%rsp), %rsi
               	subq	%rsi, %rdx
               	movw	%dx, 0x4a(%rsp)
               	movzwq	0xc(%rsp), %rdx
               	movzwq	0x2c(%rsp), %rsi
               	subq	%rsi, %rdx
               	movw	%dx, 0x4c(%rsp)
               	movzwq	0xe(%rsp), %rdx
               	movzwq	0x2e(%rsp), %rsi
               	subq	%rsi, %rdx
               	movw	%dx, 0x4e(%rsp)
               	movzwq	0x10(%rsp), %rdx
               	movzwq	0x30(%rsp), %rsi
               	subq	%rsi, %rdx
               	movw	%dx, 0x50(%rsp)
               	movzwq	0x12(%rsp), %rdx
               	movzwq	0x32(%rsp), %rsi
               	subq	%rsi, %rdx
               	movw	%dx, 0x52(%rsp)
               	movzwq	0x14(%rsp), %rdx
               	movzwq	0x34(%rsp), %rsi
               	subq	%rsi, %rdx
               	movw	%dx, 0x54(%rsp)
               	movzwq	0x16(%rsp), %rdx
               	movzwq	0x36(%rsp), %rsi
               	subq	%rsi, %rdx
               	movw	%dx, 0x56(%rsp)
               	movzwq	0x18(%rsp), %rdx
               	movzwq	0x38(%rsp), %rsi
               	subq	%rsi, %rdx
               	movw	%dx, 0x58(%rsp)
               	movzwq	0x1a(%rsp), %rdx
               	movzwq	0x3a(%rsp), %rsi
               	subq	%rsi, %rdx
               	movw	%dx, 0x5a(%rsp)
               	movzwq	0x1c(%rsp), %rdx
               	movzwq	0x3c(%rsp), %rsi
               	subq	%rsi, %rdx
               	movw	%dx, 0x5c(%rsp)
               	movzwq	0x1e(%rsp), %rdx
               	movzwq	0x3e(%rsp), %rsi
               	subq	%rsi, %rdx
               	movw	%dx, 0x5e(%rsp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_sub_epi32>:
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
               	movl	(%rsp), %edx
               	movl	0x20(%rsp), %esi
               	subq	%rsi, %rdx
               	movl	%edx, 0x40(%rsp)
               	movl	0x4(%rsp), %edx
               	movl	0x24(%rsp), %esi
               	subq	%rsi, %rdx
               	movl	%edx, 0x44(%rsp)
               	movl	0x8(%rsp), %edx
               	movl	0x28(%rsp), %esi
               	subq	%rsi, %rdx
               	movl	%edx, 0x48(%rsp)
               	movl	0xc(%rsp), %edx
               	movl	0x2c(%rsp), %esi
               	subq	%rsi, %rdx
               	movl	%edx, 0x4c(%rsp)
               	movl	0x10(%rsp), %edx
               	movl	0x30(%rsp), %esi
               	subq	%rsi, %rdx
               	movl	%edx, 0x50(%rsp)
               	movl	0x14(%rsp), %edx
               	movl	0x34(%rsp), %esi
               	subq	%rsi, %rdx
               	movl	%edx, 0x54(%rsp)
               	movl	0x18(%rsp), %edx
               	movl	0x38(%rsp), %esi
               	subq	%rsi, %rdx
               	movl	%edx, 0x58(%rsp)
               	movl	0x1c(%rsp), %edx
               	movl	0x3c(%rsp), %esi
               	subq	%rsi, %rdx
               	movl	%edx, 0x5c(%rsp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_sub_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x40, %rsp
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
               	movq	(%rsp), %rcx
               	movq	0x20(%rsp), %rdx
               	subq	%rdx, %rcx
               	movq	0x8(%rsp), %rdx
               	movq	0x28(%rsp), %rsi
               	subq	%rsi, %rdx
               	movq	0x10(%rsp), %rsi
               	movq	0x30(%rsp), %rdi
               	subq	%rdi, %rsi
               	movq	0x18(%rsp), %rdi
               	movq	0x38(%rsp), %r8
               	subq	%r8, %rdi
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	leave
               	retq

<_mm256_cmpeq_epi8>:
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
               	movsbq	(%rsp), %rdx
               	movsbq	0x20(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x40(%rsp)
               	movsbq	0x1(%rsp), %rdx
               	movsbq	0x21(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x41(%rsp)
               	movsbq	0x2(%rsp), %rdx
               	movsbq	0x22(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x42(%rsp)
               	movsbq	0x3(%rsp), %rdx
               	movsbq	0x23(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x43(%rsp)
               	movsbq	0x4(%rsp), %rdx
               	movsbq	0x24(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x44(%rsp)
               	movsbq	0x5(%rsp), %rdx
               	movsbq	0x25(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x45(%rsp)
               	movsbq	0x6(%rsp), %rdx
               	movsbq	0x26(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x46(%rsp)
               	movsbq	0x7(%rsp), %rdx
               	movsbq	0x27(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x47(%rsp)
               	movsbq	0x8(%rsp), %rdx
               	movsbq	0x28(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x48(%rsp)
               	movsbq	0x9(%rsp), %rdx
               	movsbq	0x29(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x49(%rsp)
               	movsbq	0xa(%rsp), %rdx
               	movsbq	0x2a(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x4a(%rsp)
               	movsbq	0xb(%rsp), %rdx
               	movsbq	0x2b(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x4b(%rsp)
               	movsbq	0xc(%rsp), %rdx
               	movsbq	0x2c(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x4c(%rsp)
               	movsbq	0xd(%rsp), %rdx
               	movsbq	0x2d(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x4d(%rsp)
               	movsbq	0xe(%rsp), %rdx
               	movsbq	0x2e(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x4e(%rsp)
               	movsbq	0xf(%rsp), %rdx
               	movsbq	0x2f(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x4f(%rsp)
               	movsbq	0x10(%rsp), %rdx
               	movsbq	0x30(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x50(%rsp)
               	movsbq	0x11(%rsp), %rdx
               	movsbq	0x31(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x51(%rsp)
               	movsbq	0x12(%rsp), %rdx
               	movsbq	0x32(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x52(%rsp)
               	movsbq	0x13(%rsp), %rdx
               	movsbq	0x33(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x53(%rsp)
               	movsbq	0x14(%rsp), %rdx
               	movsbq	0x34(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x54(%rsp)
               	movsbq	0x15(%rsp), %rdx
               	movsbq	0x35(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x55(%rsp)
               	movsbq	0x16(%rsp), %rdx
               	movsbq	0x36(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x56(%rsp)
               	movsbq	0x17(%rsp), %rdx
               	movsbq	0x37(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x57(%rsp)
               	movsbq	0x18(%rsp), %rdx
               	movsbq	0x38(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x58(%rsp)
               	movsbq	0x19(%rsp), %rdx
               	movsbq	0x39(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x59(%rsp)
               	movsbq	0x1a(%rsp), %rdx
               	movsbq	0x3a(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x5a(%rsp)
               	movsbq	0x1b(%rsp), %rdx
               	movsbq	0x3b(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x5b(%rsp)
               	movsbq	0x1c(%rsp), %rdx
               	movsbq	0x3c(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x5c(%rsp)
               	movsbq	0x1d(%rsp), %rdx
               	movsbq	0x3d(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x5d(%rsp)
               	movsbq	0x1e(%rsp), %rdx
               	movsbq	0x3e(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x5e(%rsp)
               	movsbq	0x1f(%rsp), %rdx
               	movsbq	0x3f(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x5f(%rsp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_cmpeq_epi16>:
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
               	movswq	(%rsp), %rdx
               	movswq	0x20(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x40(%rsp)
               	movswq	0x2(%rsp), %rdx
               	movswq	0x22(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x42(%rsp)
               	movswq	0x4(%rsp), %rdx
               	movswq	0x24(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x44(%rsp)
               	movswq	0x6(%rsp), %rdx
               	movswq	0x26(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x46(%rsp)
               	movswq	0x8(%rsp), %rdx
               	movswq	0x28(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x48(%rsp)
               	movswq	0xa(%rsp), %rdx
               	movswq	0x2a(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x4a(%rsp)
               	movswq	0xc(%rsp), %rdx
               	movswq	0x2c(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x4c(%rsp)
               	movswq	0xe(%rsp), %rdx
               	movswq	0x2e(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x4e(%rsp)
               	movswq	0x10(%rsp), %rdx
               	movswq	0x30(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x50(%rsp)
               	movswq	0x12(%rsp), %rdx
               	movswq	0x32(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x52(%rsp)
               	movswq	0x14(%rsp), %rdx
               	movswq	0x34(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x54(%rsp)
               	movswq	0x16(%rsp), %rdx
               	movswq	0x36(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x56(%rsp)
               	movswq	0x18(%rsp), %rdx
               	movswq	0x38(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x58(%rsp)
               	movswq	0x1a(%rsp), %rdx
               	movswq	0x3a(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x5a(%rsp)
               	movswq	0x1c(%rsp), %rdx
               	movswq	0x3c(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x5c(%rsp)
               	movswq	0x1e(%rsp), %rdx
               	movswq	0x3e(%rsp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x5e(%rsp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_cmpeq_epi32>:
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
               	movl	(%rsp), %edx
               	movl	0x20(%rsp), %esi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x40(%rsp)
               	movl	0x4(%rsp), %edx
               	movl	0x24(%rsp), %esi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x44(%rsp)
               	movl	0x8(%rsp), %edx
               	movl	0x28(%rsp), %esi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x48(%rsp)
               	movl	0xc(%rsp), %edx
               	movl	0x2c(%rsp), %esi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x4c(%rsp)
               	movl	0x10(%rsp), %edx
               	movl	0x30(%rsp), %esi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x50(%rsp)
               	movl	0x14(%rsp), %edx
               	movl	0x34(%rsp), %esi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x54(%rsp)
               	movl	0x18(%rsp), %edx
               	movl	0x38(%rsp), %esi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x58(%rsp)
               	movl	0x1c(%rsp), %edx
               	movl	0x3c(%rsp), %esi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x5c(%rsp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_cmpeq_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x40, %rsp
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
               	movq	(%rsp), %rcx
               	movq	0x20(%rsp), %rdx
               	cmpq	%rdx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	movq	0x8(%rsp), %rdx
               	movq	0x28(%rsp), %rsi
               	cmpq	%rsi, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movq	0x10(%rsp), %rsi
               	movq	0x30(%rsp), %rdi
               	cmpq	%rdi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movq	0x18(%rsp), %rdi
               	movq	0x38(%rsp), %r8
               	cmpq	%r8, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	leave
               	retq

<_mm256_movemask_epi8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movsbq	(%rdx,%rax), %rsi
               	testl	%esi, %esi
               	setl	%sil
               	movzbq	%sil, %rsi
               	shlxq	%rax, %rsi, %rsi
               	orq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	leave
               	retq

<check_lanes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x260, %rsp            # imm = 0x260
               	andq	$-0x20, %rsp
               	movq	%rdi, %r12
               	movq	%rsi, %r13
               	leaq	0x40(%rsp), %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x40(%rsp), %rdi
               	movq	%r13, %rsi
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	leaq	0x20(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0x40(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	movups	%xmm14, 0x60(%rax)
               	movups	%xmm14, 0x70(%rax)
               	movups	%xmm14, 0x80(%rax)
               	movups	%xmm14, 0x90(%rax)
               	movups	%xmm14, 0xa0(%rax)
               	movups	%xmm14, 0xb0(%rax)
               	movups	%xmm14, 0xc0(%rax)
               	movups	%xmm14, 0xd0(%rax)
               	movups	%xmm14, 0xe0(%rax)
               	movups	%xmm14, 0xf0(%rax)
               	movups	%xmm14, 0x100(%rax)
               	movups	%xmm14, 0x110(%rax)
               	movups	%xmm14, 0x120(%rax)
               	movups	%xmm14, 0x130(%rax)
               	movups	%xmm14, 0x140(%rax)
               	movups	%xmm14, 0x150(%rax)
               	movups	%xmm14, 0x160(%rax)
               	movups	%xmm14, 0x170(%rax)
               	leaq	0x1c0(%rsp), %rdi
               	leaq	(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%r9, %r10
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
               	leaq	0x1c0(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x1c0(%rsp), %rdi
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
               	leaq	0x1c0(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	addq	$0x20, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x1c0(%rsp), %rdi
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
               	leaq	0x1c0(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	addq	$0x40, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x1c0(%rsp), %rdi
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
               	leaq	0x1c0(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	addq	$0x60, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x1c0(%rsp), %rdi
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
               	leaq	0x1c0(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	addq	$0x80, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x1c0(%rsp), %rdi
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
               	leaq	0x1c0(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	addq	$0xa0, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x1c0(%rsp), %rdi
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
               	leaq	0x1c0(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	addq	$0xc0, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x1c0(%rsp), %rdi
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
               	leaq	0x1c0(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	addq	$0xe0, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x1c0(%rsp), %rdi
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
               	leaq	0x1c0(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	addq	$0x100, %rcx            # imm = 0x100
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x1c0(%rsp), %rdi
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
               	leaq	0x1c0(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	addq	$0x120, %rcx            # imm = 0x120
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x1c0(%rsp), %rdi
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
               	leaq	0x1c0(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	addq	$0x140, %rcx            # imm = 0x140
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x1c0(%rsp), %rdi
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
               	leaq	0x1c0(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	addq	$0x160, %rcx            # imm = 0x160
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	xorl	%r14d, %r14d
               	movl	$0x1, %eax
               	movq	%r14, %rcx
               	andq	$0x3, %rcx
               	shlxq	%rcx, %rax, %rbx
               	leaq	-0x20(%rbp), %rdi
               	leaq	0x40(%rsp), %rax
               	movq	%r14, %rcx
               	shlq	$0x5, %rcx
               	leaq	(%rax,%rcx), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	xorl	%ecx, %ecx
               	movl	$0x20, %eax
               	cltd
               	idivl	%ebx
               	cmpl	%eax, %ecx
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpl	%ebx, %eax
               	jge	<addr>
               	movq	%rbx, %rsi
               	imulq	%rcx, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movzbq	(%r12,%rsi), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	shlxq	%rdi, %rsi, %rsi
               	orq	%rsi, %rdx
               	incq	%rax
               	cmpl	%ebx, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %r8
               	cmpl	%ebx, %eax
               	jge	<addr>
               	movq	%rbx, %rsi
               	imulq	%rcx, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movzbq	(%r13,%rsi), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	shlxq	%rdi, %rsi, %rsi
               	orq	%rsi, %r8
               	incq	%rax
               	cmpl	%ebx, %eax
               	jl	<addr>
               	cmpl	$0x4, %r14d
               	jge	<addr>
               	leaq	(%rdx,%r8), %r9
               	leaq	-0x20(%rbp), %rsi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpl	%ebx, %eax
               	jge	<addr>
               	movq	%rbx, %rdi
               	imulq	%rcx, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movzbq	(%rsi,%rdi), %rdi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	movslq	%r8d, %r8
               	shlxq	%r8, %rdi, %rdi
               	orq	%rdi, %rdx
               	incq	%rax
               	cmpl	%ebx, %eax
               	jl	<addr>
               	cmpl	$0x8, %ebx
               	jne	<addr>
               	movq	$-0x1, %rax
               	andq	%r9, %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	movslq	%esi, %rsi
               	shlxq	%rsi, %rax, %rax
               	decq	%rax
               	jmp	<addr>
               	cmpl	$0x8, %r14d
               	jge	<addr>
               	movq	%rdx, %r9
               	subq	%r8, %r9
               	jmp	<addr>
               	cmpq	%r8, %rdx
               	jne	<addr>
               	movq	$-0x1, %r9
               	jmp	<addr>
               	xorl	%r9d, %r9d
               	jmp	<addr>
               	incq	%rcx
               	movl	$0x20, %eax
               	cltd
               	idivl	%ebx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	incq	%r14
               	cmpl	$0xc, %r14d
               	jl	<addr>
               	leaq	0x1c0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	movups	%xmm14, 0x60(%rax)
               	movups	%xmm14, 0x70(%rax)
               	leaq	0x240(%rsp), %rdi
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
               	leaq	0x240(%rsp), %rax
               	leaq	0x1c0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x240(%rsp), %rdi
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
               	leaq	0x240(%rsp), %rax
               	leaq	0x1c0(%rsp), %rcx
               	addq	$0x20, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x240(%rsp), %rdi
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
               	leaq	0x240(%rsp), %rax
               	leaq	0x1c0(%rsp), %rcx
               	addq	$0x40, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x240(%rsp), %rdi
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
               	leaq	0x240(%rsp), %rax
               	leaq	0x1c0(%rsp), %rcx
               	addq	$0x60, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	xorl	%ebx, %ebx
               	leaq	-0x20(%rbp), %rdi
               	leaq	0x1c0(%rsp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x5, %rcx
               	leaq	(%rax,%rcx), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	xorl	%eax, %eax
               	testl	%ebx, %ebx
               	jne	<addr>
               	movzbq	(%r12,%rax), %rcx
               	movzbq	(%r13,%rax), %rdx
               	andq	%rdx, %rcx
               	leaq	-0x20(%rbp), %rdx
               	movzbq	(%rdx,%rax), %rdx
               	cmpl	%ecx, %edx
               	je	<addr>
               	jmp	<addr>
               	cmpl	$0x1, %ebx
               	jne	<addr>
               	movzbq	(%r12,%rax), %rcx
               	xorq	$-0x1, %rcx
               	andq	$0xff, %rcx
               	movzbq	(%r13,%rax), %rdx
               	andq	%rdx, %rcx
               	jmp	<addr>
               	cmpl	$0x2, %ebx
               	jne	<addr>
               	movzbq	(%r12,%rax), %rcx
               	movzbq	(%r13,%rax), %rdx
               	orq	%rdx, %rcx
               	jmp	<addr>
               	movzbq	(%r12,%rax), %rcx
               	movzbq	(%r13,%rax), %rdx
               	xorq	%rdx, %rcx
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rbx
               	movzbq	(%r12,%rax), %rcx
               	shrq	$0x7, %rcx
               	shlxq	%rax, %rcx, %rcx
               	orq	%rcx, %rbx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpl	%ebx, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x1, %ebx
               	xorl	%eax, %eax
               	movzbq	(%r12,%rax), %rcx
               	movzbq	(%r13,%rax), %rdx
               	andq	%rdx, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rbx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
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
               	cmpl	%ebx, %eax
               	setne	%al
               	movzbq	%al, %rax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq

<check_moves>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x120, %rsp            # imm = 0x120
               	andq	$-0x20, %rsp
               	movq	%rdi, %r12
               	leaq	0x100(%rsp), %rax
               	movdqu	(%r12), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	0xc0(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	0x10(%r12), %rcx
               	leaq	0x110(%rsp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	0xd0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	movups	%xmm14, 0x60(%rax)
               	movups	%xmm14, 0x70(%rax)
               	leaq	0x80(%rsp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	0x80(%rsp), %rax
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x80(%rsp), %rdi
               	leaq	0xc0(%rsp), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	0x80(%rsp), %rax
               	leaq	(%rsp), %rcx
               	addq	$0x20, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x80(%rsp), %rdi
               	leaq	0xc0(%rsp), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	0x80(%rsp), %rax
               	leaq	(%rsp), %rcx
               	addq	$0x40, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x80(%rsp), %rdi
               	leaq	0xc0(%rsp), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	0x80(%rsp), %rax
               	leaq	(%rsp), %rcx
               	addq	$0x60, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	xorl	%r13d, %r13d
               	movl	$0x1, %eax
               	shlxq	%r13, %rax, %rbx
               	leaq	-0x50(%rbp), %rdi
               	leaq	(%rsp), %rax
               	movq	%r13, %rcx
               	shlq	$0x5, %rcx
               	leaq	(%rax,%rcx), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	xorl	%esi, %esi
               	movl	$0x20, %eax
               	cltd
               	idivl	%ebx
               	cmpl	%eax, %esi
               	jge	<addr>
               	leaq	-0x50(%rbp), %rdx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%ebx, %eax
               	jge	<addr>
               	movq	%rbx, %rdi
               	imulq	%rsi, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movzbq	(%rdx,%rdi), %rdi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	movslq	%r8d, %r8
               	shlxq	%r8, %rdi, %rdi
               	orq	%rdi, %rcx
               	incq	%rax
               	cmpl	%ebx, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpl	%ebx, %eax
               	jge	<addr>
               	imulq	$0x0, %rbx, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movzbq	(%r12,%rdi), %rdi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	movslq	%r8d, %r8
               	shlxq	%r8, %rdi, %rdi
               	orq	%rdi, %rdx
               	incq	%rax
               	cmpl	%ebx, %eax
               	jl	<addr>
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	incq	%rsi
               	movl	$0x20, %eax
               	cltd
               	idivl	%ebx
               	cmpl	%eax, %esi
               	jl	<addr>
               	incq	%r13
               	cmpl	$0x4, %r13d
               	jl	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0xc0(%rsp), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	0x80(%rsp), %r9
               	leaq	0xd0(%rsp), %rax
               	movl	$0x1, %esi
               	leaq	0xa0(%rsp), %rdi
               	subq	$0x20, %rsp
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
               	movups	(%r10), %xmm0
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0xa0(%rsp), %rax
               	leaq	0x80(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	-0x50(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	-0x50(%rbp), %rdi
               	movl	$0x20, %edx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0x70(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0xe0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x80(%rsp), %r9
               	xorl	%edi, %edi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	leaq	0xe0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x80(%rsp), %r9
               	movl	$0x1, %edi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	leaq	0xe0(%rsp), %rdi
               	leaq	0x10(%rdi), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0x10, %edx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0xe0(%rsp), %rax
               	movl	$0x10, %edx
               	leaq	0x10(%rax), %rdi
               	leaq	0x10(%r12), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0x70(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0x80(%rsp), %rdi
               	callq	<addr>
               	leaq	0x80(%rsp), %r9
               	leaq	-0x50(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	xorl	%eax, %eax
               	leaq	-0x50(%rbp), %rcx
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %rdi
               	movq	$-0x2, %rsi
               	callq	<addr>
               	leaq	0x80(%rsp), %r9
               	leaq	-0x50(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	-0x50(%rbp), %rdx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	leaq	0x1c(%rax), %rsi
               	movzbq	(%rdx,%rsi), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shlxq	%rdi, %rsi, %rsi
               	orq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	cmpq	%r11, %rcx
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x50(%rbp), %rdx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movzbq	(%rdx,%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shlxq	%rdi, %rsi, %rsi
               	orq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	leaq	-0x70(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0x70(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0x70(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<check_low_lane>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r13
               	leaq	-0x60(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	leaq	0x1(%r13), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x30(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	$0x0, -0x28(%rbp)
               	movups	-0x30(%rbp), %xmm0
               	movups	%xmm0, -0x60(%rbp)
               	leaq	0x3(%r13), %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	leaq	-0x30(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	-0x8(%rbp), %ecx
               	movl	%ecx, -0x30(%rbp)
               	movl	$0x0, -0x2c(%rbp)
               	movl	$0x0, -0x28(%rbp)
               	movl	$0x0, -0x24(%rbp)
               	movups	-0x30(%rbp), %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	leaq	0x5(%r13), %rax
               	leaq	-0x8(%rbp), %rcx
               	movzwq	(%rax), %r10
               	movw	%r10w, (%rcx)
               	leaq	-0x30(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movswq	-0x8(%rbp), %rax
               	movw	%ax, -0x30(%rbp)
               	xorl	%r12d, %r12d
               	movw	%r12w, -0x2e(%rbp)
               	movw	%r12w, -0x2c(%rbp)
               	movw	%r12w, -0x2a(%rbp)
               	movw	%r12w, -0x28(%rbp)
               	movw	%r12w, -0x26(%rbp)
               	movw	%r12w, -0x24(%rbp)
               	movw	%r12w, -0x22(%rbp)
               	movups	-0x30(%rbp), %xmm0
               	movups	%xmm0, -0x40(%rbp)
               	movl	$0x8, %eax
               	sarxq	%r12, %rax, %rbx
               	leaq	-0x18(%rbp), %rdi
               	leaq	-0x60(%rbp), %rax
               	movq	%r12, %rcx
               	shlq	$0x4, %rcx
               	addq	%rax, %rcx
               	leaq	-0x30(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdi)
               	leaq	0x1(%r13), %rax
               	movq	%r12, %rcx
               	shlq	%rcx
               	leaq	(%rax,%rcx), %rsi
               	movslq	%ebx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x10, %ebx
               	jge	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	%ebx, %rcx
               	cmpb	$0x0, (%rax,%rcx)
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x10, %ebx
               	jl	<addr>
               	incq	%r12
               	cmpl	$0x3, %r12d
               	jl	<addr>
               	leaq	-0x18(%rbp), %rdi
               	movl	$0xaa, %esi
               	movl	$0x18, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x18(%rbp), %rax
               	leaq	0x1(%rax), %rdx
               	movq	-0x60(%rbp), %rcx
               	movq	%rcx, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	leaq	0xb(%rax), %rdx
               	movl	-0x50(%rbp), %esi
               	movl	%esi, -0x20(%rbp)
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rdx)
               	addq	$0x11, %rax
               	movzwq	-0x40(%rbp), %rcx
               	movswq	%cx, %rcx
               	movw	%cx, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	movzwq	(%rcx), %r10
               	movw	%r10w, (%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	0x1(%rax), %rdi
               	leaq	0x1(%r13), %rsi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	-0x18(%rbp), %rax
               	cmpl	$0xaa, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	-0xf(%rbp), %rax
               	cmpl	$0xaa, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	leaq	0xb(%rax), %rdi
               	leaq	0x3(%r13), %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	-0x9(%rbp), %rcx
               	cmpl	$0xaa, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	leaq	0x11(%rax), %rdi
               	leaq	0x5(%r13), %rsi
               	movl	$0x2, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	-0x5(%rbp), %rax
               	cmpl	$0xaa, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<find16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, %r12
               	movq	%rsi, %r13
               	leaq	0x40(%rsp), %rdi
               	movq	%r13, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	leaq	0x60(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	%eax, 0x60(%rsp)
               	movl	$0x0, 0x64(%rsp)
               	movl	$0x0, 0x68(%rsp)
               	leaq	0x60(%rsp), %r9
               	movl	$0x0, 0x6c(%rsp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	xorl	%ebx, %ebx
               	leaq	0x60(%rsp), %rdi
               	movq	%rbx, %rax
               	shlq	%rax
               	leaq	(%r12,%rax), %rsi
               	callq	<addr>
               	leaq	0x60(%rsp), %rax
               	leaq	0x20(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0x40(%rsp), %rdi
               	leaq	(%rsp), %rax
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
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	jne	<addr>
               	addq	$0x10, %rbx
               	leaq	0x10(%rbx), %rax
               	cmpl	$0x28, %eax
               	jbe	<addr>
               	cmpl	$0x28, %ebx
               	jae	<addr>
               	movzwq	(%r12,%rbx,2), %rax
               	movq	%r13, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	cmpl	%ecx, %eax
               	je	<addr>
               	incq	%rbx
               	cmpl	$0x28, %ebx
               	jb	<addr>
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	shlq	%rbx
               	leaq	(%r12,%rbx), %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rbx, %rcx
               	shlq	%rcx
               	addq	%r12, %rcx
               	movl	$0x20, %r11d
               	bsfl	%eax, %eax
               	cmovel	%r11d, %eax
               	sarq	%rax
               	shlq	%rax
               	addq	%rcx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x98, %rsp
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	leaq	-0x90(%rbp), %rdx
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rsi
               	shrq	$0x1b, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x3c, %rsi
               	cmpl	$0x4, %esi
               	jae	<addr>
               	leaq	<rip>, %rsi # <addr>
               	shrq	$0x3a, %rcx
               	andq	$0x3, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	jmp	<addr>
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	-0x70(%rbp), %rdx
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rsi
               	shrq	$0x1b, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x3c, %rsi
               	cmpl	$0x4, %esi
               	jae	<addr>
               	leaq	<rip>, %rsi # <addr>
               	shrq	$0x3a, %rcx
               	andq	$0x3, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	jmp	<addr>
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	testb	$0x1, %bl
               	je	<addr>
               	leaq	-0x70(%rbp), %rax
               	leaq	0x8(%rax), %rdi
               	leaq	-0x90(%rbp), %rax
               	leaq	0x8(%rax), %rsi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x90(%rbp), %rdi
               	leaq	-0x70(%rbp), %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x90(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x90(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0xc8, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x50(%rbp), %rcx
               	leaq	0x100(%rax), %rdx
               	movw	%dx, (%rcx,%rax,2)
               	incq	%rax
               	cmpl	$0x28, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rdi
               	movl	$0x115, %esi            # imm = 0x115
               	movl	$0x28, %edx
               	callq	<addr>
               	leaq	-0x50(%rbp), %rdi
               	leaq	0x2a(%rdi), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xaf, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x127, %esi            # imm = 0x127
               	movl	$0x28, %edx
               	callq	<addr>
               	leaq	-0x50(%rbp), %rdi
               	leaq	0x4e(%rdi), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xb0, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x21, %esi
               	movl	$0x28, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb1, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xaa, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xa9, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xa8, %eax
               	popq	%rbx
               	leave
               	retq
