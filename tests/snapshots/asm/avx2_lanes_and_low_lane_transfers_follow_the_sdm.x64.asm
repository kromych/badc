
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

<check_lanes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x78, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x2a0, %rsp            # imm = 0x2A0
               	andq	$-0x20, %rsp
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movq	(%rbx), %rax
               	movq	0x8(%rbx), %rcx
               	movq	0x10(%rbx), %rdx
               	movq	0x18(%rbx), %rsi
               	leaq	(%rsp), %rdi
               	movq	%rax, (%rsp)
               	movq	%rcx, 0x8(%rsp)
               	movq	%rdx, 0x10(%rsp)
               	movq	%rsi, 0x18(%rsp)
               	movq	(%r12), %rax
               	movq	0x8(%r12), %rcx
               	movq	0x10(%r12), %rdx
               	movq	0x18(%r12), %rsi
               	movq	%rax, 0x20(%rsp)
               	movq	%rcx, 0x28(%rsp)
               	movq	%rdx, 0x30(%rsp)
               	movq	%rsi, 0x38(%rsp)
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
               	leaq	0x20(%rsp), %rax
               	leaq	0x240(%rsp), %rcx
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdi), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x260(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movzbq	0x240(%rsp), %rax
               	movzbq	0x260(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1c0(%rsp)
               	movzbq	0x241(%rsp), %rax
               	movzbq	0x261(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1c1(%rsp)
               	movzbq	0x242(%rsp), %rax
               	movzbq	0x262(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1c2(%rsp)
               	movzbq	0x243(%rsp), %rax
               	movzbq	0x263(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1c3(%rsp)
               	movzbq	0x244(%rsp), %rax
               	movzbq	0x264(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1c4(%rsp)
               	movzbq	0x245(%rsp), %rax
               	movzbq	0x265(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1c5(%rsp)
               	movzbq	0x246(%rsp), %rax
               	movzbq	0x266(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1c6(%rsp)
               	movzbq	0x247(%rsp), %rax
               	movzbq	0x267(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1c7(%rsp)
               	movzbq	0x248(%rsp), %rax
               	movzbq	0x268(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1c8(%rsp)
               	movzbq	0x249(%rsp), %rax
               	movzbq	0x269(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1c9(%rsp)
               	movzbq	0x24a(%rsp), %rax
               	movzbq	0x26a(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1ca(%rsp)
               	movzbq	0x24b(%rsp), %rax
               	movzbq	0x26b(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1cb(%rsp)
               	movzbq	0x24c(%rsp), %rax
               	movzbq	0x26c(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1cc(%rsp)
               	movzbq	0x24d(%rsp), %rax
               	movzbq	0x26d(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1cd(%rsp)
               	movzbq	0x24e(%rsp), %rax
               	movzbq	0x26e(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1ce(%rsp)
               	movzbq	0x24f(%rsp), %rax
               	movzbq	0x26f(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1cf(%rsp)
               	movzbq	0x250(%rsp), %rax
               	movzbq	0x270(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1d0(%rsp)
               	movzbq	0x251(%rsp), %rax
               	movzbq	0x271(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1d1(%rsp)
               	movzbq	0x252(%rsp), %rax
               	movzbq	0x272(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1d2(%rsp)
               	movzbq	0x253(%rsp), %rax
               	movzbq	0x273(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1d3(%rsp)
               	movzbq	0x254(%rsp), %rax
               	movzbq	0x274(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1d4(%rsp)
               	movzbq	0x255(%rsp), %rax
               	movzbq	0x275(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1d5(%rsp)
               	movzbq	0x256(%rsp), %rax
               	movzbq	0x276(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1d6(%rsp)
               	movzbq	0x257(%rsp), %rax
               	movzbq	0x277(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1d7(%rsp)
               	movzbq	0x258(%rsp), %rax
               	movzbq	0x278(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1d8(%rsp)
               	movzbq	0x259(%rsp), %rax
               	movzbq	0x279(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1d9(%rsp)
               	movzbq	0x25a(%rsp), %rax
               	movzbq	0x27a(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1da(%rsp)
               	movzbq	0x25b(%rsp), %rax
               	movzbq	0x27b(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1db(%rsp)
               	movzbq	0x25c(%rsp), %rax
               	movzbq	0x27c(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1dc(%rsp)
               	movzbq	0x25d(%rsp), %rax
               	movzbq	0x27d(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1dd(%rsp)
               	movzbq	0x25e(%rsp), %rax
               	movzbq	0x27e(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1de(%rsp)
               	movzbq	0x25f(%rsp), %rax
               	movzbq	0x27f(%rsp), %rcx
               	addq	%rcx, %rax
               	movb	%al, 0x1df(%rsp)
               	movq	0x1c0(%rsp), %rax
               	movq	0x1c8(%rsp), %rcx
               	movq	0x1d0(%rsp), %rdx
               	movq	0x1d8(%rsp), %rsi
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rdx, 0x50(%rsp)
               	movq	%rsi, 0x58(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0x240(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x260(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movzwq	0x240(%rsp), %rax
               	movzwq	0x260(%rsp), %rcx
               	addq	%rcx, %rax
               	movw	%ax, 0x1c0(%rsp)
               	movzwq	0x242(%rsp), %rax
               	movzwq	0x262(%rsp), %rcx
               	addq	%rcx, %rax
               	movw	%ax, 0x1c2(%rsp)
               	movzwq	0x244(%rsp), %rax
               	movzwq	0x264(%rsp), %rcx
               	addq	%rcx, %rax
               	movw	%ax, 0x1c4(%rsp)
               	movzwq	0x246(%rsp), %rax
               	movzwq	0x266(%rsp), %rcx
               	addq	%rcx, %rax
               	movw	%ax, 0x1c6(%rsp)
               	movzwq	0x248(%rsp), %rax
               	movzwq	0x268(%rsp), %rcx
               	addq	%rcx, %rax
               	movw	%ax, 0x1c8(%rsp)
               	movzwq	0x24a(%rsp), %rax
               	movzwq	0x26a(%rsp), %rcx
               	addq	%rcx, %rax
               	movw	%ax, 0x1ca(%rsp)
               	movzwq	0x24c(%rsp), %rax
               	movzwq	0x26c(%rsp), %rcx
               	addq	%rcx, %rax
               	movw	%ax, 0x1cc(%rsp)
               	movzwq	0x24e(%rsp), %rax
               	movzwq	0x26e(%rsp), %rcx
               	addq	%rcx, %rax
               	movw	%ax, 0x1ce(%rsp)
               	movzwq	0x250(%rsp), %rax
               	movzwq	0x270(%rsp), %rcx
               	addq	%rcx, %rax
               	movw	%ax, 0x1d0(%rsp)
               	movzwq	0x252(%rsp), %rax
               	movzwq	0x272(%rsp), %rcx
               	addq	%rcx, %rax
               	movw	%ax, 0x1d2(%rsp)
               	movzwq	0x254(%rsp), %rax
               	movzwq	0x274(%rsp), %rcx
               	addq	%rcx, %rax
               	movw	%ax, 0x1d4(%rsp)
               	movzwq	0x256(%rsp), %rax
               	movzwq	0x276(%rsp), %rcx
               	addq	%rcx, %rax
               	movw	%ax, 0x1d6(%rsp)
               	movzwq	0x258(%rsp), %rax
               	movzwq	0x278(%rsp), %rcx
               	addq	%rcx, %rax
               	movw	%ax, 0x1d8(%rsp)
               	movzwq	0x25a(%rsp), %rax
               	movzwq	0x27a(%rsp), %rcx
               	addq	%rcx, %rax
               	movw	%ax, 0x1da(%rsp)
               	movzwq	0x25c(%rsp), %rax
               	movzwq	0x27c(%rsp), %rcx
               	addq	%rcx, %rax
               	movw	%ax, 0x1dc(%rsp)
               	movzwq	0x25e(%rsp), %rax
               	movzwq	0x27e(%rsp), %rcx
               	addq	%rcx, %rax
               	movw	%ax, 0x1de(%rsp)
               	movq	0x1c0(%rsp), %rcx
               	movq	0x1c8(%rsp), %rdx
               	movq	0x1d0(%rsp), %rsi
               	movq	0x1d8(%rsp), %rdi
               	leaq	0x40(%rsp), %rax
               	addq	$0x20, %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	movl	(%rsp), %eax
               	movl	0x4(%rsp), %ecx
               	movl	0x8(%rsp), %edx
               	movl	0xc(%rsp), %esi
               	movl	0x10(%rsp), %edi
               	movl	0x14(%rsp), %r8d
               	movl	0x18(%rsp), %r9d
               	movl	0x1c(%rsp), %r13d
               	movl	0x20(%rsp), %r14d
               	movl	0x24(%rsp), %r15d
               	movl	0x28(%rsp), %r10d
               	movq	%r10, -0x38(%rbp)
               	movl	0x2c(%rsp), %r10d
               	movq	%r10, -0x40(%rbp)
               	movl	0x30(%rsp), %r10d
               	movq	%r10, -0x48(%rbp)
               	movl	0x34(%rsp), %r10d
               	movq	%r10, -0x50(%rbp)
               	movl	0x38(%rsp), %r10d
               	movq	%r10, -0x58(%rbp)
               	movl	0x3c(%rsp), %r10d
               	movq	%r10, -0x60(%rbp)
               	addq	%r14, %rax
               	movl	%eax, 0x1c0(%rsp)
               	leaq	(%rcx,%r15), %rax
               	movl	%eax, 0x1c4(%rsp)
               	movq	%rdx, %rax
               	addq	-0x38(%rbp), %rax
               	movl	%eax, 0x1c8(%rsp)
               	movq	%rsi, %rax
               	addq	-0x40(%rbp), %rax
               	movl	%eax, 0x1cc(%rsp)
               	movq	%rdi, %rax
               	addq	-0x48(%rbp), %rax
               	movl	%eax, 0x1d0(%rsp)
               	movq	%r8, %rax
               	addq	-0x50(%rbp), %rax
               	movl	%eax, 0x1d4(%rsp)
               	movq	%r9, %rax
               	addq	-0x58(%rbp), %rax
               	movl	%eax, 0x1d8(%rsp)
               	movq	%r13, %rax
               	addq	-0x60(%rbp), %rax
               	movl	%eax, 0x1dc(%rsp)
               	movq	0x1c0(%rsp), %rcx
               	movq	0x1c8(%rsp), %rdx
               	movq	0x1d0(%rsp), %rsi
               	movq	0x1d8(%rsp), %rdi
               	leaq	0x40(%rsp), %rax
               	addq	$0x40, %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	movq	0x38(%rsp), %r13
               	addq	%rax, %rdi
               	addq	%rcx, %r8
               	addq	%r9, %rdx
               	addq	%r13, %rsi
               	leaq	0x40(%rsp), %rcx
               	leaq	0x60(%rcx), %rax
               	movq	%rdi, (%rax)
               	movq	%r8, 0x8(%rax)
               	movq	%rdx, 0x10(%rax)
               	movq	%rsi, 0x18(%rax)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rdx
               	leaq	0x240(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x260(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movzbq	0x240(%rsp), %rax
               	movzbq	0x260(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1c0(%rsp)
               	movzbq	0x241(%rsp), %rax
               	movzbq	0x261(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1c1(%rsp)
               	movzbq	0x242(%rsp), %rax
               	movzbq	0x262(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1c2(%rsp)
               	movzbq	0x243(%rsp), %rax
               	movzbq	0x263(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1c3(%rsp)
               	movzbq	0x244(%rsp), %rax
               	movzbq	0x264(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1c4(%rsp)
               	movzbq	0x245(%rsp), %rax
               	movzbq	0x265(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1c5(%rsp)
               	movzbq	0x246(%rsp), %rax
               	movzbq	0x266(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1c6(%rsp)
               	movzbq	0x247(%rsp), %rax
               	movzbq	0x267(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1c7(%rsp)
               	movzbq	0x248(%rsp), %rax
               	movzbq	0x268(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1c8(%rsp)
               	movzbq	0x249(%rsp), %rax
               	movzbq	0x269(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1c9(%rsp)
               	movzbq	0x24a(%rsp), %rax
               	movzbq	0x26a(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1ca(%rsp)
               	movzbq	0x24b(%rsp), %rax
               	movzbq	0x26b(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1cb(%rsp)
               	movzbq	0x24c(%rsp), %rax
               	movzbq	0x26c(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1cc(%rsp)
               	movzbq	0x24d(%rsp), %rax
               	movzbq	0x26d(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1cd(%rsp)
               	movzbq	0x24e(%rsp), %rax
               	movzbq	0x26e(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1ce(%rsp)
               	movzbq	0x24f(%rsp), %rax
               	movzbq	0x26f(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1cf(%rsp)
               	movzbq	0x250(%rsp), %rax
               	movzbq	0x270(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1d0(%rsp)
               	movzbq	0x251(%rsp), %rax
               	movzbq	0x271(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1d1(%rsp)
               	movzbq	0x252(%rsp), %rax
               	movzbq	0x272(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1d2(%rsp)
               	movzbq	0x253(%rsp), %rax
               	movzbq	0x273(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1d3(%rsp)
               	movzbq	0x254(%rsp), %rax
               	movzbq	0x274(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1d4(%rsp)
               	movzbq	0x255(%rsp), %rax
               	movzbq	0x275(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1d5(%rsp)
               	movzbq	0x256(%rsp), %rax
               	movzbq	0x276(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1d6(%rsp)
               	movzbq	0x257(%rsp), %rax
               	movzbq	0x277(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1d7(%rsp)
               	movzbq	0x258(%rsp), %rax
               	movzbq	0x278(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1d8(%rsp)
               	movzbq	0x259(%rsp), %rax
               	movzbq	0x279(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1d9(%rsp)
               	movzbq	0x25a(%rsp), %rax
               	movzbq	0x27a(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1da(%rsp)
               	movzbq	0x25b(%rsp), %rax
               	movzbq	0x27b(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1db(%rsp)
               	movzbq	0x25c(%rsp), %rax
               	movzbq	0x27c(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1dc(%rsp)
               	movzbq	0x25d(%rsp), %rax
               	movzbq	0x27d(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1dd(%rsp)
               	movzbq	0x25e(%rsp), %rax
               	movzbq	0x27e(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1de(%rsp)
               	movzbq	0x25f(%rsp), %rax
               	movzbq	0x27f(%rsp), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x1df(%rsp)
               	movq	0x1c0(%rsp), %rdx
               	movq	0x1c8(%rsp), %rsi
               	movq	0x1d0(%rsp), %rdi
               	movq	0x1d8(%rsp), %r8
               	leaq	0x80(%rcx), %rax
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	movq	%r8, 0x18(%rax)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0x240(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x260(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movzwq	0x240(%rsp), %rax
               	movzwq	0x260(%rsp), %rcx
               	subq	%rcx, %rax
               	movw	%ax, 0x1c0(%rsp)
               	movzwq	0x242(%rsp), %rax
               	movzwq	0x262(%rsp), %rcx
               	subq	%rcx, %rax
               	movw	%ax, 0x1c2(%rsp)
               	movzwq	0x244(%rsp), %rax
               	movzwq	0x264(%rsp), %rcx
               	subq	%rcx, %rax
               	movw	%ax, 0x1c4(%rsp)
               	movzwq	0x246(%rsp), %rax
               	movzwq	0x266(%rsp), %rcx
               	subq	%rcx, %rax
               	movw	%ax, 0x1c6(%rsp)
               	movzwq	0x248(%rsp), %rax
               	movzwq	0x268(%rsp), %rcx
               	subq	%rcx, %rax
               	movw	%ax, 0x1c8(%rsp)
               	movzwq	0x24a(%rsp), %rax
               	movzwq	0x26a(%rsp), %rcx
               	subq	%rcx, %rax
               	movw	%ax, 0x1ca(%rsp)
               	movzwq	0x24c(%rsp), %rax
               	movzwq	0x26c(%rsp), %rcx
               	subq	%rcx, %rax
               	movw	%ax, 0x1cc(%rsp)
               	movzwq	0x24e(%rsp), %rax
               	movzwq	0x26e(%rsp), %rcx
               	subq	%rcx, %rax
               	movw	%ax, 0x1ce(%rsp)
               	movzwq	0x250(%rsp), %rax
               	movzwq	0x270(%rsp), %rcx
               	subq	%rcx, %rax
               	movw	%ax, 0x1d0(%rsp)
               	movzwq	0x252(%rsp), %rax
               	movzwq	0x272(%rsp), %rcx
               	subq	%rcx, %rax
               	movw	%ax, 0x1d2(%rsp)
               	movzwq	0x254(%rsp), %rax
               	movzwq	0x274(%rsp), %rcx
               	subq	%rcx, %rax
               	movw	%ax, 0x1d4(%rsp)
               	movzwq	0x256(%rsp), %rax
               	movzwq	0x276(%rsp), %rcx
               	subq	%rcx, %rax
               	movw	%ax, 0x1d6(%rsp)
               	movzwq	0x258(%rsp), %rax
               	movzwq	0x278(%rsp), %rcx
               	subq	%rcx, %rax
               	movw	%ax, 0x1d8(%rsp)
               	movzwq	0x25a(%rsp), %rax
               	movzwq	0x27a(%rsp), %rcx
               	subq	%rcx, %rax
               	movw	%ax, 0x1da(%rsp)
               	movzwq	0x25c(%rsp), %rax
               	movzwq	0x27c(%rsp), %rcx
               	subq	%rcx, %rax
               	movw	%ax, 0x1dc(%rsp)
               	movzwq	0x25e(%rsp), %rax
               	movzwq	0x27e(%rsp), %rcx
               	subq	%rcx, %rax
               	movw	%ax, 0x1de(%rsp)
               	movq	0x1c0(%rsp), %rcx
               	movq	0x1c8(%rsp), %rdx
               	movq	0x1d0(%rsp), %rsi
               	movq	0x1d8(%rsp), %rdi
               	leaq	0x40(%rsp), %rax
               	addq	$0xa0, %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	movl	(%rsp), %eax
               	movl	0x4(%rsp), %ecx
               	movl	0x8(%rsp), %edx
               	movl	0xc(%rsp), %esi
               	movl	0x10(%rsp), %edi
               	movl	0x14(%rsp), %r8d
               	movl	0x18(%rsp), %r9d
               	movl	0x1c(%rsp), %r13d
               	movl	0x20(%rsp), %r14d
               	movl	0x24(%rsp), %r15d
               	movl	0x28(%rsp), %r10d
               	movq	%r10, -0x38(%rbp)
               	movl	0x2c(%rsp), %r10d
               	movq	%r10, -0x40(%rbp)
               	movl	0x30(%rsp), %r10d
               	movq	%r10, -0x48(%rbp)
               	movl	0x34(%rsp), %r10d
               	movq	%r10, -0x50(%rbp)
               	movl	0x38(%rsp), %r10d
               	movq	%r10, -0x58(%rbp)
               	movl	0x3c(%rsp), %r10d
               	movq	%r10, -0x60(%rbp)
               	subq	%r14, %rax
               	movl	%eax, 0x1c0(%rsp)
               	subq	%r15, %rcx
               	movl	%ecx, 0x1c4(%rsp)
               	subq	-0x38(%rbp), %rdx
               	movl	%edx, 0x1c8(%rsp)
               	subq	-0x40(%rbp), %rsi
               	movl	%esi, 0x1cc(%rsp)
               	subq	-0x48(%rbp), %rdi
               	movl	%edi, 0x1d0(%rsp)
               	subq	-0x50(%rbp), %r8
               	movl	%r8d, 0x1d4(%rsp)
               	subq	-0x58(%rbp), %r9
               	movl	%r9d, 0x1d8(%rsp)
               	subq	-0x60(%rbp), %r13
               	movl	%r13d, 0x1dc(%rsp)
               	movq	0x1c0(%rsp), %rcx
               	movq	0x1c8(%rsp), %rdx
               	movq	0x1d0(%rsp), %rsi
               	movq	0x1d8(%rsp), %rdi
               	leaq	0x40(%rsp), %rax
               	addq	$0xc0, %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	movq	0x38(%rsp), %r13
               	negq	%rdi
               	addq	%rax, %rdi
               	subq	%r8, %rcx
               	subq	%r9, %rdx
               	subq	%r13, %rsi
               	leaq	0x40(%rsp), %rax
               	addq	$0xe0, %rax
               	movq	%rdi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rdx, 0x10(%rax)
               	movq	%rsi, 0x18(%rax)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0x240(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x260(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movsbq	0x240(%rsp), %rax
               	movsbq	0x260(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1c0(%rsp)
               	movsbq	0x241(%rsp), %rax
               	movsbq	0x261(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1c1(%rsp)
               	movsbq	0x242(%rsp), %rax
               	movsbq	0x262(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1c2(%rsp)
               	movsbq	0x243(%rsp), %rax
               	movsbq	0x263(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1c3(%rsp)
               	movsbq	0x244(%rsp), %rax
               	movsbq	0x264(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1c4(%rsp)
               	movsbq	0x245(%rsp), %rax
               	movsbq	0x265(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1c5(%rsp)
               	movsbq	0x246(%rsp), %rax
               	movsbq	0x266(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1c6(%rsp)
               	movsbq	0x247(%rsp), %rax
               	movsbq	0x267(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1c7(%rsp)
               	movsbq	0x248(%rsp), %rax
               	movsbq	0x268(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1c8(%rsp)
               	movsbq	0x249(%rsp), %rax
               	movsbq	0x269(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1c9(%rsp)
               	movsbq	0x24a(%rsp), %rax
               	movsbq	0x26a(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1ca(%rsp)
               	movsbq	0x24b(%rsp), %rax
               	movsbq	0x26b(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1cb(%rsp)
               	movsbq	0x24c(%rsp), %rax
               	movsbq	0x26c(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1cc(%rsp)
               	movsbq	0x24d(%rsp), %rax
               	movsbq	0x26d(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1cd(%rsp)
               	movsbq	0x24e(%rsp), %rax
               	movsbq	0x26e(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1ce(%rsp)
               	movsbq	0x24f(%rsp), %rax
               	movsbq	0x26f(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1cf(%rsp)
               	movsbq	0x250(%rsp), %rax
               	movsbq	0x270(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1d0(%rsp)
               	movsbq	0x251(%rsp), %rax
               	movsbq	0x271(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1d1(%rsp)
               	movsbq	0x252(%rsp), %rax
               	movsbq	0x272(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1d2(%rsp)
               	movsbq	0x253(%rsp), %rax
               	movsbq	0x273(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1d3(%rsp)
               	movsbq	0x254(%rsp), %rax
               	movsbq	0x274(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1d4(%rsp)
               	movsbq	0x255(%rsp), %rax
               	movsbq	0x275(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1d5(%rsp)
               	movsbq	0x256(%rsp), %rax
               	movsbq	0x276(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1d6(%rsp)
               	movsbq	0x257(%rsp), %rax
               	movsbq	0x277(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1d7(%rsp)
               	movsbq	0x258(%rsp), %rax
               	movsbq	0x278(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1d8(%rsp)
               	movsbq	0x259(%rsp), %rax
               	movsbq	0x279(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1d9(%rsp)
               	movsbq	0x25a(%rsp), %rax
               	movsbq	0x27a(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1da(%rsp)
               	movsbq	0x25b(%rsp), %rax
               	movsbq	0x27b(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1db(%rsp)
               	movsbq	0x25c(%rsp), %rax
               	movsbq	0x27c(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1dc(%rsp)
               	movsbq	0x25d(%rsp), %rax
               	movsbq	0x27d(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1dd(%rsp)
               	movsbq	0x25e(%rsp), %rax
               	movsbq	0x27e(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1de(%rsp)
               	movsbq	0x25f(%rsp), %rax
               	movsbq	0x27f(%rsp), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x1df(%rsp)
               	movq	0x1c0(%rsp), %rcx
               	movq	0x1c8(%rsp), %rdx
               	movq	0x1d0(%rsp), %rsi
               	movq	0x1d8(%rsp), %rdi
               	leaq	0x40(%rsp), %rax
               	addq	$0x100, %rax            # imm = 0x100
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
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
               	movl	(%rsp), %eax
               	movl	0x4(%rsp), %ecx
               	movl	0x8(%rsp), %edx
               	movl	0xc(%rsp), %esi
               	movl	0x10(%rsp), %edi
               	movl	0x14(%rsp), %r8d
               	movl	0x18(%rsp), %r9d
               	movl	0x1c(%rsp), %r13d
               	movl	0x20(%rsp), %r14d
               	movl	0x24(%rsp), %r15d
               	movl	0x28(%rsp), %r10d
               	movq	%r10, -0x38(%rbp)
               	movl	0x2c(%rsp), %r10d
               	movq	%r10, -0x40(%rbp)
               	movl	0x30(%rsp), %r10d
               	movq	%r10, -0x48(%rbp)
               	movl	0x34(%rsp), %r10d
               	movq	%r10, -0x50(%rbp)
               	movl	0x38(%rsp), %r10d
               	movq	%r10, -0x58(%rbp)
               	movl	0x3c(%rsp), %r10d
               	movq	%r10, -0x60(%rbp)
               	cmpl	%r14d, %eax
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movl	%eax, 0x1c0(%rsp)
               	cmpl	%r15d, %ecx
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movl	%eax, 0x1c4(%rsp)
               	cmpl	-0x38(%rbp), %edx
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movl	%eax, 0x1c8(%rsp)
               	cmpl	-0x40(%rbp), %esi
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movl	%eax, 0x1cc(%rsp)
               	cmpl	-0x48(%rbp), %edi
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movl	%eax, 0x1d0(%rsp)
               	cmpl	-0x50(%rbp), %r8d
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movl	%eax, 0x1d4(%rsp)
               	cmpl	-0x58(%rbp), %r9d
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movl	%eax, 0x1d8(%rsp)
               	cmpl	-0x60(%rbp), %r13d
               	sete	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movl	%eax, 0x1dc(%rsp)
               	movq	0x1c0(%rsp), %rcx
               	movq	0x1c8(%rsp), %rdx
               	movq	0x1d0(%rsp), %rsi
               	movq	0x1d8(%rsp), %rdi
               	leaq	0x40(%rsp), %rax
               	addq	$0x140, %rax            # imm = 0x140
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	movq	0x38(%rsp), %r13
               	cmpq	%rdi, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, %rdi
               	negq	%rdi
               	cmpq	%r8, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, %rcx
               	negq	%rcx
               	cmpq	%r9, %rdx
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, %rdx
               	negq	%rdx
               	cmpq	%r13, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, %rsi
               	negq	%rsi
               	leaq	0x40(%rsp), %rax
               	addq	$0x160, %rax            # imm = 0x160
               	movq	%rdi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rdx, 0x10(%rax)
               	movq	%rsi, 0x18(%rax)
               	xorl	%r14d, %r14d
               	movl	$0x1, %eax
               	movq	%r14, %rcx
               	andq	$0x3, %rcx
               	shlxq	%rcx, %rax, %rcx
               	leaq	-0x28(%rbp), %rdx
               	leaq	0x40(%rsp), %rax
               	movq	%r14, %rsi
               	shlq	$0x5, %rsi
               	addq	%rax, %rsi
               	leaq	0x260(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%r8d, %r8d
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r8d
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	movq	%rcx, %rsi
               	imulq	%r8, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	shlxq	%rdi, %rsi, %rsi
               	orq	%rsi, %rdx
               	incq	%rax
               	cmpl	%ecx, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %r9
               	cmpl	%ecx, %eax
               	jge	<addr>
               	movq	%rcx, %rsi
               	imulq	%r8, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movzbq	(%r12,%rsi), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	shlxq	%rdi, %rsi, %rsi
               	orq	%rsi, %r9
               	incq	%rax
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpl	$0x4, %r14d
               	jge	<addr>
               	leaq	(%rdx,%r9), %r13
               	leaq	-0x28(%rbp), %rsi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	movq	%rcx, %rdi
               	imulq	%r8, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movzbq	(%rsi,%rdi), %rdi
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	movslq	%r9d, %r9
               	shlxq	%r9, %rdi, %rdi
               	orq	%rdi, %rdx
               	incq	%rax
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	movq	$-0x1, %rax
               	andq	%r13, %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	movslq	%esi, %rsi
               	shlxq	%rsi, %rax, %rax
               	decq	%rax
               	jmp	<addr>
               	cmpl	$0x8, %r14d
               	jge	<addr>
               	movq	%rdx, %r13
               	subq	%r9, %r13
               	jmp	<addr>
               	cmpq	%r9, %rdx
               	jne	<addr>
               	movq	$-0x1, %r13
               	jmp	<addr>
               	xorl	%r13d, %r13d
               	jmp	<addr>
               	incq	%r8
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r8d
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
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	movq	0x38(%rsp), %r13
               	andq	%rdi, %rax
               	andq	%r8, %rcx
               	andq	%r9, %rdx
               	andq	%r13, %rsi
               	movq	%rax, 0x1c0(%rsp)
               	movq	%rcx, 0x1c8(%rsp)
               	movq	%rdx, 0x1d0(%rsp)
               	movq	%rsi, 0x1d8(%rsp)
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	movq	0x38(%rsp), %r13
               	xorq	$-0x1, %rax
               	xorq	$-0x1, %rcx
               	xorq	$-0x1, %rdx
               	xorq	$-0x1, %rsi
               	andq	%rax, %rdi
               	andq	%r8, %rcx
               	andq	%r9, %rdx
               	andq	%r13, %rsi
               	leaq	0x1c0(%rsp), %rax
               	addq	$0x20, %rax
               	movq	%rdi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rdx, 0x10(%rax)
               	movq	%rsi, 0x18(%rax)
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	movq	0x38(%rsp), %r13
               	orq	%rax, %rdi
               	orq	%r8, %rcx
               	orq	%r9, %rdx
               	orq	%r13, %rsi
               	leaq	0x1c0(%rsp), %rax
               	addq	$0x40, %rax
               	movq	%rdi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rdx, 0x10(%rax)
               	movq	%rsi, 0x18(%rax)
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	movq	0x38(%rsp), %r13
               	xorq	%rax, %rdi
               	xorq	%r8, %rcx
               	xorq	%r9, %rdx
               	xorq	%r13, %rsi
               	leaq	0x1c0(%rsp), %rax
               	addq	$0x60, %rax
               	movq	%rdi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rdx, 0x10(%rax)
               	movq	%rsi, 0x18(%rax)
               	xorl	%edx, %edx
               	leaq	-0x28(%rbp), %rsi
               	leaq	0x1c0(%rsp), %rax
               	movq	%rdx, %rcx
               	shlq	$0x5, %rcx
               	addq	%rax, %rcx
               	leaq	0x260(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	xorl	%eax, %eax
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	(%rbx,%rax), %rcx
               	movzbq	(%r12,%rax), %rdi
               	andq	%rdi, %rcx
               	movzbq	(%rsi,%rax), %rdi
               	cmpl	%ecx, %edi
               	je	<addr>
               	jmp	<addr>
               	cmpl	$0x1, %edx
               	jne	<addr>
               	movzbq	(%rbx,%rax), %rcx
               	xorq	$-0x1, %rcx
               	andq	$0xff, %rcx
               	movzbq	(%r12,%rax), %rdi
               	andq	%rdi, %rcx
               	jmp	<addr>
               	cmpl	$0x2, %edx
               	jne	<addr>
               	movzbq	(%rbx,%rax), %rcx
               	movzbq	(%r12,%rax), %rdi
               	orq	%rdi, %rcx
               	jmp	<addr>
               	movzbq	(%rbx,%rax), %rcx
               	movzbq	(%r12,%rax), %rdi
               	xorq	%rdi, %rcx
               	movzbq	(%rsi,%rax), %rdi
               	cmpl	%ecx, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x4, %edx
               	jl	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movzbq	(%rbx,%rax), %rdx
               	shrq	$0x7, %rdx
               	shlxq	%rax, %rdx, %rdx
               	orq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rdx
               	movq	0x10(%rsp), %rsi
               	movq	0x18(%rsp), %rdi
               	leaq	0x260(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rax, 0x260(%rsp)
               	movq	%rdx, 0x268(%rsp)
               	leaq	0x280(%rsp), %rax
               	movups	0x260(%rsp), %xmm0
               	movups	%xmm0, 0x280(%rsp)
               	leaq	-0x8(%rbp), %rdx
               	movdqu	(%rax), %xmm14
               	pmovmskb	%xmm14, %r11d
               	movl	%r11d, (%rdx)
               	movl	-0x8(%rbp), %eax
               	leaq	0x260(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rsi, 0x260(%rsp)
               	movq	%rdi, 0x268(%rsp)
               	leaq	0x290(%rsp), %rdx
               	movups	0x260(%rsp), %xmm0
               	movups	%xmm0, 0x290(%rsp)
               	leaq	-0x8(%rbp), %rsi
               	movdqu	(%rdx), %xmm14
               	pmovmskb	%xmm14, %r11d
               	movl	%r11d, (%rsi)
               	movl	-0x8(%rbp), %edx
               	shlq	$0x10, %rdx
               	orq	%rdx, %rax
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x1, %ecx
               	xorl	%eax, %eax
               	movzbq	(%rbx,%rax), %rdx
               	movzbq	(%r12,%rax), %rsi
               	andq	%rsi, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rdx
               	movq	0x10(%rsp), %rsi
               	movq	0x18(%rsp), %rdi
               	movq	0x20(%rsp), %r8
               	movq	0x28(%rsp), %r9
               	movq	0x30(%rsp), %rbx
               	movq	0x38(%rsp), %r12
               	andq	%r8, %rax
               	andq	%r9, %rdx
               	andq	%rbx, %rsi
               	andq	%r12, %rdi
               	orq	%rdx, %rax
               	orq	%rsi, %rax
               	orq	%rdi, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	%ecx, %eax
               	setne	%al
               	movzbq	%al, %rax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<check_moves>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x120, %rsp            # imm = 0x120
               	andq	$-0x20, %rsp
               	movq	%rdi, %rbx
               	leaq	(%rsp), %rax
               	movdqu	(%rbx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	0x80(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x10(%rbx), %rax
               	leaq	(%rsp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	movq	(%rsp), %r13
               	movq	0x8(%rsp), %r14
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
               	movzbq	0x80(%rsp), %rax
               	movsbq	%al, %rax
               	andq	$0xff, %rax
               	movb	%al, 0xa0(%rsp)
               	movb	%al, 0xa1(%rsp)
               	movb	%al, 0xa2(%rsp)
               	movb	%al, 0xa3(%rsp)
               	movb	%al, 0xa4(%rsp)
               	movb	%al, 0xa5(%rsp)
               	movb	%al, 0xa6(%rsp)
               	movb	%al, 0xa7(%rsp)
               	movb	%al, 0xa8(%rsp)
               	movb	%al, 0xa9(%rsp)
               	movb	%al, 0xaa(%rsp)
               	movb	%al, 0xab(%rsp)
               	movb	%al, 0xac(%rsp)
               	movb	%al, 0xad(%rsp)
               	movb	%al, 0xae(%rsp)
               	movb	%al, 0xaf(%rsp)
               	movb	%al, 0xb0(%rsp)
               	movb	%al, 0xb1(%rsp)
               	movb	%al, 0xb2(%rsp)
               	movb	%al, 0xb3(%rsp)
               	movb	%al, 0xb4(%rsp)
               	movb	%al, 0xb5(%rsp)
               	movb	%al, 0xb6(%rsp)
               	movb	%al, 0xb7(%rsp)
               	movb	%al, 0xb8(%rsp)
               	movb	%al, 0xb9(%rsp)
               	movb	%al, 0xba(%rsp)
               	movb	%al, 0xbb(%rsp)
               	movb	%al, 0xbc(%rsp)
               	movb	%al, 0xbd(%rsp)
               	movb	%al, 0xbe(%rsp)
               	movb	%al, 0xbf(%rsp)
               	movq	0xa0(%rsp), %rax
               	movq	0xa8(%rsp), %rcx
               	movq	0xb0(%rsp), %rdx
               	movq	0xb8(%rsp), %rsi
               	movq	%rax, (%rsp)
               	movq	%rcx, 0x8(%rsp)
               	movq	%rdx, 0x10(%rsp)
               	movq	%rsi, 0x18(%rsp)
               	movzwq	0x80(%rsp), %rax
               	movw	%ax, 0xa0(%rsp)
               	movw	%ax, 0xa2(%rsp)
               	movw	%ax, 0xa4(%rsp)
               	movw	%ax, 0xa6(%rsp)
               	movw	%ax, 0xa8(%rsp)
               	movw	%ax, 0xaa(%rsp)
               	movw	%ax, 0xac(%rsp)
               	movw	%ax, 0xae(%rsp)
               	movw	%ax, 0xb0(%rsp)
               	movw	%ax, 0xb2(%rsp)
               	movw	%ax, 0xb4(%rsp)
               	movw	%ax, 0xb6(%rsp)
               	movw	%ax, 0xb8(%rsp)
               	movw	%ax, 0xba(%rsp)
               	movw	%ax, 0xbc(%rsp)
               	movw	%ax, 0xbe(%rsp)
               	movq	0xa0(%rsp), %rcx
               	movq	0xa8(%rsp), %rdx
               	movq	0xb0(%rsp), %rsi
               	movq	0xb8(%rsp), %rdi
               	leaq	(%rsp), %rax
               	addq	$0x20, %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	movl	0x80(%rsp), %eax
               	movl	%eax, 0xa0(%rsp)
               	movl	%eax, 0xa4(%rsp)
               	movl	%eax, 0xa8(%rsp)
               	movl	%eax, 0xac(%rsp)
               	movl	%eax, 0xb0(%rsp)
               	movl	%eax, 0xb4(%rsp)
               	movl	%eax, 0xb8(%rsp)
               	movl	%eax, 0xbc(%rsp)
               	movq	0xa0(%rsp), %rcx
               	movq	0xa8(%rsp), %rdx
               	movq	0xb0(%rsp), %rsi
               	movq	0xb8(%rsp), %rdi
               	leaq	(%rsp), %rax
               	addq	$0x40, %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	movq	0x80(%rsp), %rax
               	leaq	(%rsp), %rcx
               	addq	$0x60, %rcx
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	movq	%rax, 0x10(%rcx)
               	movq	%rax, 0x18(%rcx)
               	xorl	%r12d, %r12d
               	movl	$0x1, %eax
               	shlxq	%r12, %rax, %rcx
               	leaq	-0x50(%rbp), %rax
               	leaq	(%rsp), %rdx
               	movq	%r12, %rsi
               	shlq	$0x5, %rsi
               	addq	%rsi, %rdx
               	leaq	0xc0(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	xorl	%r8d, %r8d
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r8d
               	jge	<addr>
               	leaq	-0x50(%rbp), %rsi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	movq	%rcx, %rdi
               	imulq	%r8, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movzbq	(%rsi,%rdi), %rdi
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	movslq	%r9d, %r9
               	shlxq	%r9, %rdi, %rdi
               	orq	%rdi, %rdx
               	incq	%rax
               	cmpl	%ecx, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	cmpl	%ecx, %eax
               	jge	<addr>
               	imulq	$0x0, %rcx, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movzbq	(%rbx,%rdi), %rdi
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	movslq	%r9d, %r9
               	shlxq	%r9, %rdi, %rdi
               	orq	%rdi, %rsi
               	incq	%rax
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	incq	%r8
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r8d
               	jl	<addr>
               	incq	%r12
               	cmpl	$0x4, %r12d
               	jl	<addr>
               	movq	0x80(%rsp), %rax
               	movq	0x88(%rsp), %rcx
               	leaq	0x80(%rsp), %rdx
               	movq	%rax, 0x80(%rsp)
               	movq	%rcx, 0x88(%rsp)
               	movq	%r13, 0x90(%rsp)
               	movq	%r14, 0x98(%rsp)
               	leaq	-0x50(%rbp), %rdi
               	leaq	0xc0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	movq	%rbx, %rsi
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
               	popq	%r14
               	leave
               	retq
               	leaq	0xe0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	0x80(%rsp), %rax
               	movq	0x88(%rsp), %rcx
               	leaq	0x100(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rax, 0x100(%rsp)
               	movq	%rcx, 0x108(%rsp)
               	movups	0x100(%rsp), %xmm0
               	movups	%xmm0, 0xe0(%rsp)
               	movq	0x90(%rsp), %rax
               	movq	0x98(%rsp), %rcx
               	leaq	0x80(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rax, 0x80(%rsp)
               	movq	%rcx, 0x88(%rsp)
               	movups	0x80(%rsp), %xmm0
               	leaq	0xe0(%rsp), %rdi
               	movups	%xmm0, 0xf0(%rsp)
               	movl	$0x10, %edx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0xe0(%rsp), %rax
               	movl	$0x10, %edx
               	leaq	0x10(%rax), %rdi
               	leaq	0x10(%rbx), %rsi
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
               	popq	%r14
               	leave
               	retq
               	leaq	-0x50(%rbp), %rcx
               	xorl	%eax, %eax
               	leaq	0xc0(%rsp), %rdx
               	movq	%rax, 0xc0(%rsp)
               	movq	%rax, 0xc8(%rsp)
               	movq	%rax, 0xd0(%rsp)
               	movq	%rax, 0xd8(%rsp)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	-0x50(%rbp), %rcx
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	movl	$0xfffffffe, 0xa0(%rsp) # imm = 0xFFFFFFFE
               	movl	$0xfffffffe, 0xa4(%rsp) # imm = 0xFFFFFFFE
               	movl	$0xfffffffe, 0xa8(%rsp) # imm = 0xFFFFFFFE
               	movl	$0xfffffffe, 0xac(%rsp) # imm = 0xFFFFFFFE
               	movl	$0xfffffffe, 0xb0(%rsp) # imm = 0xFFFFFFFE
               	movl	$0xfffffffe, 0xb4(%rsp) # imm = 0xFFFFFFFE
               	movl	$0xfffffffe, 0xb8(%rsp) # imm = 0xFFFFFFFE
               	movl	$0xfffffffe, 0xbc(%rsp) # imm = 0xFFFFFFFE
               	movq	0xa0(%rsp), %rax
               	movq	0xa8(%rsp), %rdx
               	movq	0xb0(%rsp), %rsi
               	movq	0xb8(%rsp), %rdi
               	leaq	0xc0(%rsp), %r8
               	movq	%rax, 0xc0(%rsp)
               	movq	%rdx, 0xc8(%rsp)
               	movq	%rsi, 0xd0(%rsp)
               	movq	%rdi, 0xd8(%rsp)
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%r8), %xmm14
               	movups	%xmm14, 0x10(%rcx)
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
               	popq	%r14
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0x70(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0x70(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq

<find16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, %r12
               	movq	%rsi, %r13
               	movq	%r13, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	leaq	0x40(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	%eax, 0x40(%rsp)
               	movl	$0x0, 0x44(%rsp)
               	movl	$0x0, 0x48(%rsp)
               	movl	$0x0, 0x4c(%rsp)
               	movzwq	0x40(%rsp), %rax
               	movw	%ax, 0x40(%rsp)
               	movw	%ax, 0x42(%rsp)
               	movw	%ax, 0x44(%rsp)
               	movw	%ax, 0x46(%rsp)
               	movw	%ax, 0x48(%rsp)
               	movw	%ax, 0x4a(%rsp)
               	movw	%ax, 0x4c(%rsp)
               	movw	%ax, 0x4e(%rsp)
               	movw	%ax, 0x50(%rsp)
               	movw	%ax, 0x52(%rsp)
               	movw	%ax, 0x54(%rsp)
               	movw	%ax, 0x56(%rsp)
               	movw	%ax, 0x58(%rsp)
               	movw	%ax, 0x5a(%rsp)
               	movw	%ax, 0x5c(%rsp)
               	movw	%ax, 0x5e(%rsp)
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rcx
               	movq	0x50(%rsp), %rdx
               	movq	0x58(%rsp), %rsi
               	movq	%rax, (%rsp)
               	movq	%rcx, 0x8(%rsp)
               	movq	%rdx, 0x10(%rsp)
               	movq	%rsi, 0x18(%rsp)
               	xorl	%ebx, %ebx
               	movq	%rbx, %rax
               	shlq	%rax
               	addq	%r12, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	0x10(%rax), %rsi
               	movq	0x18(%rax), %rax
               	movq	%rcx, 0x20(%rsp)
               	movq	%rdx, 0x28(%rsp)
               	movq	%rsi, 0x30(%rsp)
               	movq	%rax, 0x38(%rsp)
               	leaq	0x40(%rsp), %rdi
               	leaq	0x20(%rsp), %r9
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
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rcx
               	movq	0x50(%rsp), %rdx
               	movq	0x58(%rsp), %rsi
               	leaq	0x80(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0x80(%rsp)
               	movq	%rcx, 0x88(%rsp)
               	leaq	0x60(%rsp), %rax
               	movups	0x80(%rsp), %xmm0
               	movups	%xmm0, 0x60(%rsp)
               	leaq	-0x8(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pmovmskb	%xmm14, %r11d
               	movl	%r11d, (%rcx)
               	movl	-0x8(%rbp), %eax
               	leaq	0x90(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%rdx, 0x90(%rsp)
               	movq	%rsi, 0x98(%rsp)
               	leaq	0x70(%rsp), %rcx
               	movups	0x90(%rsp), %xmm0
               	movups	%xmm0, 0x70(%rsp)
               	leaq	-0x8(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	pmovmskb	%xmm14, %r11d
               	movl	%r11d, (%rdx)
               	movl	-0x8(%rbp), %ecx
               	shlq	$0x10, %rcx
               	orq	%rcx, %rax
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
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	shlq	%rbx
               	leaq	(%r12,%rbx), %rax
               	leaq	-0x30(%rbp), %rsp
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
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x140, %rsp            # imm = 0x140
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r14d, %r14d
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
               	testb	$0x1, %r14b
               	je	<addr>
               	leaq	-0x70(%rbp), %rax
               	addq	$0x8, %rax
               	leaq	-0x90(%rbp), %rcx
               	addq	$0x8, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x90(%rbp), %rdi
               	leaq	-0x70(%rbp), %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x90(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x90(%rbp), %r13
               	leaq	-0x140(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	leaq	0x1(%r13), %rax
               	leaq	-0xd0(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x110(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	-0xd0(%rbp), %rax
               	movq	%rax, -0x110(%rbp)
               	movq	$0x0, -0x108(%rbp)
               	movups	-0x110(%rbp), %xmm0
               	movups	%xmm0, -0x140(%rbp)
               	leaq	0x3(%r13), %rcx
               	leaq	-0xc8(%rbp), %rdx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rdx)
               	leaq	-0x100(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	-0xc8(%rbp), %ecx
               	movl	%ecx, -0x100(%rbp)
               	movl	$0x0, -0xfc(%rbp)
               	movl	$0x0, -0xf8(%rbp)
               	movl	$0x0, -0xf4(%rbp)
               	movups	-0x100(%rbp), %xmm0
               	movups	%xmm0, -0x130(%rbp)
               	leaq	0x5(%r13), %rax
               	leaq	-0xc0(%rbp), %rcx
               	movzwq	(%rax), %r10
               	movw	%r10w, (%rcx)
               	leaq	-0xf0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movswq	-0xc0(%rbp), %rax
               	movw	%ax, -0xf0(%rbp)
               	movw	$0x0, -0xee(%rbp)
               	movw	$0x0, -0xec(%rbp)
               	movw	$0x0, -0xea(%rbp)
               	movw	$0x0, -0xe8(%rbp)
               	movw	$0x0, -0xe6(%rbp)
               	movw	$0x0, -0xe4(%rbp)
               	movw	$0x0, -0xe2(%rbp)
               	movups	-0xf0(%rbp), %xmm0
               	movups	%xmm0, -0x120(%rbp)
               	xorl	%r12d, %r12d
               	movl	$0x8, %eax
               	sarxq	%r12, %rax, %rbx
               	leaq	-0xa8(%rbp), %rcx
               	leaq	-0x140(%rbp), %rax
               	movq	%r12, %rdx
               	shlq	$0x4, %rdx
               	addq	%rax, %rdx
               	leaq	-0xe0(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0xa8(%rbp), %rdi
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
               	leaq	-0xa8(%rbp), %rax
               	movslq	%ebx, %rcx
               	cmpb	$0x0, (%rax,%rcx)
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x10, %ebx
               	jl	<addr>
               	incq	%r12
               	cmpl	$0x3, %r12d
               	jl	<addr>
               	leaq	-0xa8(%rbp), %rcx
               	movb	$-0x56, -0xa8(%rbp)
               	movb	$-0x56, -0xa7(%rbp)
               	movb	$-0x56, -0xa6(%rbp)
               	movb	$-0x56, -0xa5(%rbp)
               	movb	$-0x56, -0xa4(%rbp)
               	movb	$-0x56, -0xa3(%rbp)
               	movb	$-0x56, -0xa2(%rbp)
               	movb	$-0x56, -0xa1(%rbp)
               	movb	$-0x56, -0xa0(%rbp)
               	movb	$-0x56, -0x9f(%rbp)
               	movb	$-0x56, -0x9e(%rbp)
               	movb	$-0x56, -0x9d(%rbp)
               	movb	$-0x56, -0x9c(%rbp)
               	movb	$-0x56, -0x9b(%rbp)
               	movb	$-0x56, -0x9a(%rbp)
               	movb	$-0x56, -0x99(%rbp)
               	movb	$-0x56, -0x98(%rbp)
               	movb	$-0x56, -0x97(%rbp)
               	movb	$-0x56, -0x96(%rbp)
               	movb	$-0x56, -0x95(%rbp)
               	movb	$-0x56, -0x94(%rbp)
               	movb	$-0x56, -0x93(%rbp)
               	movb	$-0x56, -0x92(%rbp)
               	movb	$-0x56, -0x91(%rbp)
               	leaq	0x1(%rcx), %rax
               	movq	-0x140(%rbp), %rdx
               	movq	%rdx, -0xb8(%rbp)
               	leaq	-0xb8(%rbp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rax)
               	leaq	0xb(%rcx), %rax
               	movl	-0x130(%rbp), %edx
               	movl	%edx, -0xb0(%rbp)
               	leaq	-0xb0(%rbp), %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rax)
               	leaq	0x11(%rcx), %rax
               	movzwq	-0x120(%rbp), %rcx
               	movswq	%cx, %rcx
               	movw	%cx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movzwq	(%rcx), %r10
               	movw	%r10w, (%rax)
               	leaq	-0xa8(%rbp), %rax
               	leaq	0x1(%rax), %rdi
               	leaq	0x1(%r13), %rsi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa8(%rbp), %rax
               	movzbq	-0xa8(%rbp), %rcx
               	cmpl	$0xaa, %ecx
               	jne	<addr>
               	movzbq	-0x9f(%rbp), %rcx
               	cmpl	$0xaa, %ecx
               	jne	<addr>
               	leaq	0xb(%rax), %rdi
               	leaq	0x3(%r13), %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa8(%rbp), %rax
               	movzbq	-0x99(%rbp), %rcx
               	cmpl	$0xaa, %ecx
               	jne	<addr>
               	leaq	0x11(%rax), %rdi
               	leaq	0x5(%r13), %rsi
               	movl	$0x2, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	-0x95(%rbp), %rax
               	cmpl	$0xaa, %eax
               	jne	<addr>
               	incq	%r14
               	cmpl	$0xc8, %r14d
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
               	popq	%r12
               	popq	%r13
               	popq	%r14
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
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x21, %esi
               	movl	$0x28, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0xaa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0xa9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0xa8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
