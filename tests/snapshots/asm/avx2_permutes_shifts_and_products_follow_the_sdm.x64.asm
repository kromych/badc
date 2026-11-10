
avx2_permutes_shifts_and_products_follow_the_sdm.x64:	file format elf64-x86-64

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

<_mm256_setr_epi8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x60(%rbp)
               	movsbq	%sil, %rsi
               	movsbq	%r9b, %r9
               	movsbq	%r8b, %r8
               	movsbq	%cl, %rcx
               	movsbq	%dl, %rdx
               	movq	-0x60(%rbp), %rax
               	leaq	(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movb	%sil, (%rsp)
               	movb	%dl, 0x1(%rsp)
               	movb	%cl, 0x2(%rsp)
               	movb	%r8b, 0x3(%rsp)
               	movb	%r9b, 0x4(%rsp)
               	movsbq	0x10(%rbp), %rcx
               	movb	%cl, 0x5(%rsp)
               	movsbq	0x18(%rbp), %rcx
               	movb	%cl, 0x6(%rsp)
               	movsbq	0x20(%rbp), %rcx
               	movb	%cl, 0x7(%rsp)
               	movsbq	0x28(%rbp), %rcx
               	movb	%cl, 0x8(%rsp)
               	movsbq	0x30(%rbp), %rcx
               	movb	%cl, 0x9(%rsp)
               	movsbq	0x38(%rbp), %rcx
               	movb	%cl, 0xa(%rsp)
               	movsbq	0x40(%rbp), %rcx
               	movb	%cl, 0xb(%rsp)
               	movsbq	0x48(%rbp), %rcx
               	movb	%cl, 0xc(%rsp)
               	movsbq	0x50(%rbp), %rcx
               	movb	%cl, 0xd(%rsp)
               	movsbq	0x58(%rbp), %rcx
               	movb	%cl, 0xe(%rsp)
               	movsbq	0x60(%rbp), %rcx
               	movb	%cl, 0xf(%rsp)
               	movsbq	0x68(%rbp), %rcx
               	movb	%cl, 0x10(%rsp)
               	movsbq	0x70(%rbp), %rcx
               	movb	%cl, 0x11(%rsp)
               	movsbq	0x78(%rbp), %rcx
               	movb	%cl, 0x12(%rsp)
               	movsbq	0x80(%rbp), %rcx
               	movb	%cl, 0x13(%rsp)
               	movsbq	0x88(%rbp), %rcx
               	movb	%cl, 0x14(%rsp)
               	movsbq	0x90(%rbp), %rcx
               	movb	%cl, 0x15(%rsp)
               	movsbq	0x98(%rbp), %rcx
               	movb	%cl, 0x16(%rsp)
               	movsbq	0xa0(%rbp), %rcx
               	movb	%cl, 0x17(%rsp)
               	movsbq	0xa8(%rbp), %rcx
               	movb	%cl, 0x18(%rsp)
               	movsbq	0xb0(%rbp), %rcx
               	movb	%cl, 0x19(%rsp)
               	movsbq	0xb8(%rbp), %rcx
               	movb	%cl, 0x1a(%rsp)
               	movsbq	0xc0(%rbp), %rcx
               	movb	%cl, 0x1b(%rsp)
               	movsbq	0xc8(%rbp), %rcx
               	leaq	(%rsp), %rdx
               	movb	%cl, 0x1c(%rsp)
               	movsbq	0xd0(%rbp), %rcx
               	movb	%cl, 0x1d(%rsp)
               	movsbq	0xd8(%rbp), %rcx
               	movb	%cl, 0x1e(%rsp)
               	movsbq	0xe0(%rbp), %rcx
               	movb	%cl, 0x1f(%rsp)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<round_of>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	leaq	-0x60(%rbp), %rdx
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %r8
               	shrq	$0xc, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %r8
               	shlq	$0x19, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %r8
               	shrq	$0x1b, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	imulq	%rsi, %rcx
               	movq	%rcx, %r8
               	shrq	$0x3c, %r8
               	cmpl	$0x4, %r8d
               	jae	<addr>
               	shrq	$0x3a, %rcx
               	andq	$0x3, %rcx
               	movzbq	(%rdi,%rcx), %rcx
               	jmp	<addr>
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdx
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %r8
               	shrq	$0xc, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %r8
               	shlq	$0x19, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %r8
               	shrq	$0x1b, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	imulq	%rsi, %rcx
               	movq	%rcx, %r8
               	shrq	$0x3c, %r8
               	cmpl	$0x4, %r8d
               	jae	<addr>
               	shrq	$0x3a, %rcx
               	andq	$0x3, %rcx
               	movzbq	(%rdi,%rcx), %rcx
               	jmp	<addr>
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	-0x80(%rbp), %rdx
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %r8
               	shrq	$0xc, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %r8
               	shlq	$0x19, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %r8
               	shrq	$0x1b, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	imulq	%rsi, %rcx
               	movq	%rcx, %r8
               	shrq	$0x3c, %r8
               	cmpl	$0x4, %r8d
               	jae	<addr>
               	shrq	$0x3a, %rcx
               	andq	$0x3, %rcx
               	movzbq	(%rdi,%rcx), %rcx
               	jmp	<addr>
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x70(%rbp), %rdx
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %r8
               	shrq	$0xc, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %r8
               	shlq	$0x19, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %r8
               	shrq	$0x1b, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	imulq	%rsi, %rcx
               	movq	%rcx, %r8
               	shrq	$0x3c, %r8
               	cmpl	$0x4, %r8d
               	jae	<addr>
               	shrq	$0x3a, %rcx
               	andq	$0x3, %rcx
               	movzbq	(%rdi,%rcx), %rcx
               	jmp	<addr>
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %rax
               	vmovups	(%rax), %ymm0
               	vmovups	%ymm0, (%rsp)
               	leaq	-0x40(%rbp), %rax
               	vmovups	(%rax), %ymm0
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x80(%rbp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x60(%rsp), %rcx
               	leaq	-0x70(%rbp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x78(%rbp), %rcx
               	movl	(%rax), %r10d
               	movl	%r10d, (%rcx)
               	leaq	-0x68(%rbp), %rcx
               	addq	$0x8, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rcx
               	leaq	0x20(%rsp), %rdx
               	movq	%rax, 0x20(%rsp)
               	movq	%rcx, 0x28(%rsp)
               	movq	%rax, 0x30(%rsp)
               	movq	%rcx, 0x38(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rcx
               	movq	0x60(%rsp), %rsi
               	movq	0x68(%rsp), %rdi
               	leaq	0x20(%rsp), %rdx
               	movq	%rsi, 0x20(%rsp)
               	movq	%rdi, 0x28(%rsp)
               	movq	%rax, 0x30(%rsp)
               	movq	%rcx, 0x38(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	0x40(%rsp), %rcx
               	movq	0x48(%rsp), %rsi
               	xorl	%eax, %eax
               	leaq	0x20(%rsp), %rdx
               	movq	%rcx, 0x20(%rsp)
               	movq	%rsi, 0x28(%rsp)
               	movq	%rax, 0x30(%rsp)
               	movq	%rax, 0x38(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpcmpgtd	%ymm0, %ymm1, %ymm1
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpcmpgtq	%ymm0, %ymm1, %ymm1
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movzbq	(%rsp), %rax
               	movq	%rax, -0x28(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x28(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movzbq	0x11(%rsp), %rax
               	movq	%rax, -0x28(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x28(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movzbq	0x1f(%rsp), %rax
               	movq	%rax, -0x28(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x28(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movslq	0x8(%rsp), %rax
               	movq	%rax, -0x28(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x28(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movslq	0x1c(%rsp), %rax
               	movq	%rax, -0x28(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x28(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	0x8(%rsp), %rax
               	movq	%rax, -0x28(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x28(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	0x18(%rsp), %rax
               	movq	%rax, -0x28(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x28(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %rcx
               	movl	-0x78(%rbp), %edx
               	leaq	0x60(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movb	%dl, 0x25(%rsp)
               	movq	0x20(%rsp), %rax
               	movq	0x28(%rsp), %rcx
               	movq	0x30(%rsp), %rsi
               	movq	0x38(%rsp), %rdi
               	leaq	0x40(%rsp), %rdx
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rsi, 0x50(%rsp)
               	movq	%rdi, 0x58(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %rcx
               	movl	-0x78(%rbp), %edx
               	leaq	0x60(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movb	%dl, 0x3e(%rsp)
               	movq	0x20(%rsp), %rax
               	movq	0x28(%rsp), %rcx
               	movq	0x30(%rsp), %rsi
               	movq	0x38(%rsp), %rdi
               	leaq	0x20(%rsp), %rdx
               	movq	%rax, 0x20(%rsp)
               	movq	%rcx, 0x28(%rsp)
               	movq	%rsi, 0x30(%rsp)
               	movq	%rdi, 0x38(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %rcx
               	movl	-0x78(%rbp), %edx
               	leaq	0x60(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movl	%edx, 0x38(%rsp)
               	movq	0x20(%rsp), %rax
               	movq	0x28(%rsp), %rcx
               	movq	0x30(%rsp), %rsi
               	movq	0x38(%rsp), %rdi
               	leaq	0x20(%rsp), %rdx
               	movq	%rax, 0x20(%rsp)
               	movq	%rcx, 0x28(%rsp)
               	movq	%rsi, 0x30(%rsp)
               	movq	%rdi, 0x38(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	-0x68(%rbp), %rax
               	movq	(%rsp), %rcx
               	movq	0x8(%rsp), %rsi
               	movq	0x18(%rsp), %rdi
               	leaq	0x20(%rsp), %rdx
               	movq	%rcx, 0x20(%rsp)
               	movq	%rsi, 0x28(%rsp)
               	movq	%rax, 0x30(%rsp)
               	movq	%rdi, 0x38(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpmaddwd	%ymm0, %ymm1, %ymm1
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpmaddubsw	%ymm0, %ymm1, %ymm1
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpmuludq	%ymm0, %ymm1, %ymm1
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	(%rsp), %eax
               	movl	0x4(%rsp), %ecx
               	movl	0x8(%rsp), %edx
               	movl	0xc(%rsp), %esi
               	movl	0x10(%rsp), %edi
               	movl	0x14(%rsp), %r8d
               	movl	0x18(%rsp), %r9d
               	movl	0x1c(%rsp), %ebx
               	vmovups	%ymm0, 0x60(%rsp)
               	movl	0x60(%rsp), %r12d
               	imulq	%r12, %rax
               	movl	%eax, 0x20(%rsp)
               	movl	0x64(%rsp), %eax
               	imulq	%rcx, %rax
               	movl	%eax, 0x24(%rsp)
               	movl	0x68(%rsp), %eax
               	imulq	%rdx, %rax
               	movl	%eax, 0x28(%rsp)
               	movl	0x6c(%rsp), %eax
               	imulq	%rsi, %rax
               	movl	%eax, 0x2c(%rsp)
               	movl	0x70(%rsp), %eax
               	imulq	%rdi, %rax
               	movl	%eax, 0x30(%rsp)
               	movl	0x74(%rsp), %eax
               	imulq	%r8, %rax
               	movl	%eax, 0x34(%rsp)
               	movl	0x78(%rsp), %eax
               	imulq	%r9, %rax
               	movl	%eax, 0x38(%rsp)
               	movl	0x7c(%rsp), %eax
               	imulq	%rbx, %rax
               	movl	%eax, 0x3c(%rsp)
               	movq	0x20(%rsp), %rax
               	movq	0x28(%rsp), %rcx
               	movq	0x30(%rsp), %rsi
               	movq	0x38(%rsp), %rdi
               	leaq	0x20(%rsp), %rdx
               	movq	%rax, 0x20(%rsp)
               	movq	%rcx, 0x28(%rsp)
               	movq	%rsi, 0x30(%rsp)
               	movq	%rdi, 0x38(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vperm2i128	$0x0, %ymm0, %ymm1, %ymm1 # ymm1 = ymm1[0,1,0,1]
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vperm2i128	$0x31, %ymm0, %ymm1, %ymm1 # ymm1 = ymm1[2,3],ymm0[2,3]
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vperm2i128	$0x12, %ymm0, %ymm1, %ymm1 # ymm1 = ymm0[0,1],ymm1[2,3]
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vperm2i128	$0x83, %ymm0, %ymm1, %ymm1 # ymm1 = ymm0[2,3],zero,zero
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vperm2i128	$0x28, %ymm0, %ymm1, %ymm1 # ymm1 = zero,zero,ymm0[0,1]
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpermq	$0x1b, %ymm1, %ymm1     # ymm1 = ymm1[3,2,1,0]
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpermq	$0xd8, %ymm1, %ymm1     # ymm1 = ymm1[0,2,1,3]
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpermd	%ymm1, %ymm0, %ymm1
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpsadbw	%ymm0, %ymm1, %ymm1
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpshufb	%ymm0, %ymm1, %ymm1
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpslld	$0x0, %ymm1, %ymm1
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpslld	$0x7, %ymm1, %ymm1
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpslld	$0x1f, %ymm1, %ymm1
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpslld	$0x20, %ymm1, %ymm1
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpsllq	$0xd, %ymm1, %ymm1
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpsllq	$0x3f, %ymm1, %ymm1
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpsllq	$0x40, %ymm1, %ymm1
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpsrld	$0x5, %ymm1, %ymm1
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpsrld	$0x20, %ymm1, %ymm1
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpsrlq	$0x21, %ymm1, %ymm1
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpsrlq	$0x40, %ymm1, %ymm1
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpslldq	$0x0, %ymm1, %ymm1      # ymm1 = ymm1[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpslldq	$0x3, %ymm1, %ymm1      # ymm1 = zero,zero,zero,ymm1[0,1,2,3,4,5,6,7,8,9,10,11,12],zero,zero,zero,ymm1[16,17,18,19,20,21,22,23,24,25,26,27,28]
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpslldq	$0xf, %ymm1, %ymm1      # ymm1 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,ymm1[0],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,ymm1[16]
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpslldq	$0x10, %ymm1, %ymm1     # ymm1 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpsrldq	$0x1, %ymm1, %ymm1      # ymm1 = ymm1[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],zero,ymm1[17,18,19,20,21,22,23,24,25,26,27,28,29,30,31],zero
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpsrldq	$0x9, %ymm1, %ymm1      # ymm1 = ymm1[9,10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero,ymm1[25,26,27,28,29,30,31],zero,zero,zero,zero,zero,zero,zero,zero,zero
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpsrldq	$0x10, %ymm1, %ymm1     # ymm1 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpsubusw	%ymm0, %ymm1, %ymm1
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpunpckldq	%ymm0, %ymm1, %ymm1 # ymm1 = ymm1[0],ymm0[0],ymm1[1],ymm0[1],ymm1[4],ymm0[4],ymm1[5],ymm0[5]
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpunpckhdq	%ymm0, %ymm1, %ymm1 # ymm1 = ymm1[2],ymm0[2],ymm1[3],ymm0[3],ymm1[6],ymm0[6],ymm1[7],ymm0[7]
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpunpcklqdq	%ymm0, %ymm1, %ymm1 # ymm1 = ymm1[0],ymm0[0],ymm1[2],ymm0[2]
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm1, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vpunpckhqdq	%ymm0, %ymm1, %ymm0 # ymm0 = ymm1[1],ymm0[1],ymm1[3],ymm0[3]
               	leaq	0x20(%rsp), %rdx
               	vmovups	%ymm0, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x20(%rsp), %rax
               	movl	-0x78(%rbp), %ecx
               	movzbq	-0x5d(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movl	%edx, 0x20(%rsp)
               	movl	$0x6, 0x24(%rsp)
               	movl	$0x80000000, 0x28(%rsp) # imm = 0x80000000
               	movl	$0x7fffffff, 0x2c(%rsp) # imm = 0x7FFFFFFF
               	movl	$0x3, 0x30(%rsp)
               	movl	$0xfffffffe, 0x34(%rsp) # imm = 0xFFFFFFFE
               	movl	$0x1, 0x38(%rsp)
               	movl	%ecx, 0x3c(%rsp)
               	leaq	0x60(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x20(%rsp), %rax
               	movl	-0x78(%rbp), %ecx
               	movzbq	-0x5d(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movl	%ecx, 0x20(%rsp)
               	movl	$0x1, 0x24(%rsp)
               	movl	$0xfffffffe, 0x28(%rsp) # imm = 0xFFFFFFFE
               	movl	$0x3, 0x2c(%rsp)
               	movl	$0x7fffffff, 0x30(%rsp) # imm = 0x7FFFFFFF
               	movl	$0x80000000, 0x34(%rsp) # imm = 0x80000000
               	movl	$0x6, 0x38(%rsp)
               	movl	%edx, 0x3c(%rsp)
               	leaq	0x60(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	-0x68(%rbp), %rax
               	movslq	-0x78(%rbp), %rcx
               	leaq	0x20(%rsp), %rdx
               	movq	%rcx, 0x20(%rsp)
               	movq	$0x2, 0x28(%rsp)
               	movq	$-0x1, 0x30(%rsp)
               	movq	%rax, 0x38(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x20(%rsp), %rdi
               	movzbq	-0x60(%rbp), %rax
               	movsbq	%al, %rax
               	movq	$-0x80, %rsi
               	movl	$0x1e, %edx
               	movl	$0x1d, %ecx
               	movl	$0x1c, %r8d
               	movl	$0x1b, %r9d
               	subq	$0xe0, %rsp
               	movq	$0x1a, (%rsp)
               	movq	$0x19, 0x8(%rsp)
               	movq	$0x18, 0x10(%rsp)
               	movq	$0x17, 0x18(%rsp)
               	movq	$0x16, 0x20(%rsp)
               	movq	$0x15, 0x28(%rsp)
               	movq	$0x14, 0x30(%rsp)
               	movq	$0x13, 0x38(%rsp)
               	movq	$0x12, 0x40(%rsp)
               	movq	$0x11, 0x48(%rsp)
               	movq	$0x10, 0x50(%rsp)
               	movq	$0xf, 0x58(%rsp)
               	movq	$0xe, 0x60(%rsp)
               	movq	$0xd, 0x68(%rsp)
               	movq	$0xc, 0x70(%rsp)
               	movq	$0xb, 0x78(%rsp)
               	movq	$0xa, 0x80(%rsp)
               	movq	$0x9, 0x88(%rsp)
               	movq	$0x8, 0x90(%rsp)
               	movq	$0x7, 0x98(%rsp)
               	movq	$0x6, 0xa0(%rsp)
               	movq	$0x5, 0xa8(%rsp)
               	movq	$0x4, 0xb0(%rsp)
               	movq	$0x3, 0xb8(%rsp)
               	movq	$0x2, 0xc0(%rsp)
               	movq	$0x1, 0xc8(%rsp)
               	movq	%rax, 0xd0(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0xe0, %rsp
               	leaq	0x20(%rsp), %rax
               	leaq	0x60(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x20(%rsp), %rdi
               	movzbq	-0x60(%rbp), %rsi
               	movl	$0x1, %edx
               	movl	$0x2, %ecx
               	movl	$0x3, %r8d
               	movl	$0x4, %r9d
               	subq	$0xe0, %rsp
               	movq	$0x5, (%rsp)
               	movq	$0x6, 0x8(%rsp)
               	movq	$0x7, 0x10(%rsp)
               	movq	$0x8, 0x18(%rsp)
               	movq	$0x9, 0x20(%rsp)
               	movq	$0xa, 0x28(%rsp)
               	movq	$0xb, 0x30(%rsp)
               	movq	$0xc, 0x38(%rsp)
               	movq	$0xd, 0x40(%rsp)
               	movq	$0xe, 0x48(%rsp)
               	movq	$0xf, 0x50(%rsp)
               	movq	$0x10, 0x58(%rsp)
               	movq	$0x11, 0x60(%rsp)
               	movq	$0x12, 0x68(%rsp)
               	movq	$0x13, 0x70(%rsp)
               	movq	$0x14, 0x78(%rsp)
               	movq	$0x15, 0x80(%rsp)
               	movq	$0x16, 0x88(%rsp)
               	movq	$0x17, 0x90(%rsp)
               	movq	$0x18, 0x98(%rsp)
               	movq	$0x19, 0xa0(%rsp)
               	movq	$0x1a, 0xa8(%rsp)
               	movq	$0x1b, 0xb0(%rsp)
               	movq	$0x1c, 0xb8(%rsp)
               	movq	$0x1d, 0xc0(%rsp)
               	movq	$0x1e, 0xc8(%rsp)
               	movq	$-0x80, 0xd0(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0xe0, %rsp
               	leaq	0x20(%rsp), %rax
               	leaq	0x60(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	vzeroupper
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x340d631b7bdddcdb, %rdx # imm = 0xCBF29CE484222325
               	movq	%rdx, (%rcx,%rax,8)
               	incq	%rax
               	cmpl	$0x15, %eax
               	jl	<addr>
               	xorl	%ebx, %ebx
               	callq	<addr>
               	incq	%rbx
               	cmpl	$0x190, %ebx            # imm = 0x190
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rsi,%rcx), %rdi
               	movq	(%rdi), %rdi
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x15, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	incq	%rax
               	popq	%rbx
               	leave
               	retq
