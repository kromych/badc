
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

<round_of>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%cl, -0x40(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jge	<addr>
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %r8
               	shrq	$0xc, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, %r8
               	shlq	$0x19, %r8
               	xorq	%r8, %rcx
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
               	jmp	<addr>
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%cl, -0x20(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jge	<addr>
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %r8
               	shrq	$0xc, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, %r8
               	shlq	$0x19, %r8
               	xorq	%r8, %rcx
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
               	jmp	<addr>
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%cl, -0x60(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %r8
               	shrq	$0xc, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, %r8
               	shlq	$0x19, %r8
               	xorq	%r8, %rcx
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
               	jmp	<addr>
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%cl, -0x50(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %r8
               	shrq	$0xc, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, %r8
               	shlq	$0x19, %r8
               	xorq	%r8, %rcx
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
               	jmp	<addr>
               	vmovups	-0x40(%rbp), %ymm0
               	leaq	-0x20(%rbp), %rax
               	vmovups	-0x20(%rbp), %ymm1
               	movups	-0x60(%rbp), %xmm2
               	movups	-0x50(%rbp), %xmm3
               	leaq	-0x58(%rbp), %rcx
               	movl	(%rax), %r10d
               	movl	%r10d, (%rcx)
               	leaq	-0x48(%rbp), %rcx
               	addq	$0x8, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	vmovdqa	%xmm2, %xmm4
               	vinserti128	$0x1, %xmm2, %ymm4, %ymm4
               	vmovups	%ymm4, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovdqa	%xmm3, %xmm3
               	vinserti128	$0x1, %xmm2, %ymm3, %ymm3
               	vmovups	%ymm3, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovdqa	%xmm2, %xmm2
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpcmpgtd	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpcmpgtq	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpextrb	$0x0, %xmm0, %eax
               	movslq	%eax, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	-0x8(%rbp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x1, %xmm2, %eax
               	movslq	%eax, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	-0x8(%rbp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xf, %xmm2, %eax
               	movslq	%eax, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	-0x8(%rbp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpextrd	$0x2, %xmm0, %eax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	-0x8(%rbp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrd	$0x3, %xmm2, %eax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	-0x8(%rbp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	-0x8(%rbp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrq	$0x1, %xmm2, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	-0x8(%rbp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	-0x58(%rbp), %eax
               	movsbq	%al, %rax
               	vmovdqa	%xmm0, %xmm2
               	vpinsrb	$0x5, %eax, %xmm2, %xmm2
               	vinserti128	$0x0, %xmm2, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	-0x58(%rbp), %eax
               	movsbq	%al, %rax
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpinsrb	$0xe, %eax, %xmm2, %xmm2
               	vinserti128	$0x1, %xmm2, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	-0x58(%rbp), %eax
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpinsrd	$0x2, %eax, %xmm2, %xmm2
               	vinserti128	$0x1, %xmm2, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	-0x48(%rbp), %rax
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpinsrq	$0x0, %rax, %xmm2, %xmm2
               	vinserti128	$0x1, %xmm2, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpmaddwd	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpmaddubsw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpmuludq	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovd	%xmm0, %eax
               	vmovd	%xmm1, %ecx
               	imulq	%rcx, %rax
               	vmovd	%eax, %xmm2
               	vpextrd	$0x1, %xmm0, %eax
               	vpextrd	$0x1, %xmm1, %edx
               	imulq	%rdx, %rax
               	vpinsrd	$0x1, %eax, %xmm2, %xmm2
               	vpextrd	$0x2, %xmm0, %eax
               	vpextrd	$0x2, %xmm1, %edx
               	imulq	%rdx, %rax
               	vpinsrd	$0x2, %eax, %xmm2, %xmm2
               	vpextrd	$0x3, %xmm0, %eax
               	vpextrd	$0x3, %xmm1, %edx
               	imulq	%rdx, %rax
               	vpinsrd	$0x3, %eax, %xmm2, %xmm2
               	vmovdqa	%xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm3
               	vmovd	%xmm3, %eax
               	vextracti128	$0x1, %ymm1, %xmm3
               	vmovd	%xmm3, %ecx
               	imulq	%rcx, %rax
               	vmovd	%eax, %xmm3
               	vextracti128	$0x1, %ymm0, %xmm4
               	vpextrd	$0x1, %xmm4, %eax
               	vextracti128	$0x1, %ymm1, %xmm4
               	vpextrd	$0x1, %xmm4, %ecx
               	imulq	%rcx, %rax
               	vpinsrd	$0x1, %eax, %xmm3, %xmm3
               	vextracti128	$0x1, %ymm0, %xmm4
               	vpextrd	$0x2, %xmm4, %eax
               	vextracti128	$0x1, %ymm1, %xmm4
               	vpextrd	$0x2, %xmm4, %ecx
               	imulq	%rcx, %rax
               	vpinsrd	$0x2, %eax, %xmm3, %xmm3
               	vextracti128	$0x1, %ymm0, %xmm4
               	vpextrd	$0x3, %xmm4, %eax
               	vextracti128	$0x1, %ymm1, %xmm4
               	vpextrd	$0x3, %xmm4, %ecx
               	imulq	%rcx, %rax
               	vpinsrd	$0x3, %eax, %xmm3, %xmm3
               	vinserti128	$0x1, %xmm3, %ymm2, %ymm2
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vperm2i128	$0x0, %ymm1, %ymm0, %ymm2 # ymm2 = ymm0[0,1,0,1]
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vperm2i128	$0x31, %ymm1, %ymm0, %ymm2 # ymm2 = ymm0[2,3],ymm1[2,3]
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vperm2i128	$0x12, %ymm1, %ymm0, %ymm2 # ymm2 = ymm1[0,1],ymm0[2,3]
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vperm2i128	$0x83, %ymm1, %ymm0, %ymm2 # ymm2 = ymm1[2,3],zero,zero
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vperm2i128	$0x28, %ymm1, %ymm0, %ymm2 # ymm2 = zero,zero,ymm1[0,1]
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpermq	$0x1b, %ymm0, %ymm2     # ymm2 = ymm0[3,2,1,0]
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpermq	$0xd8, %ymm0, %ymm2     # ymm2 = ymm0[0,2,1,3]
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpermd	%ymm0, %ymm1, %ymm2
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpsadbw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpshufb	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpslld	$0x0, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpslld	$0x7, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpslld	$0x1f, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpslld	$0x20, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpsllq	$0xd, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpsllq	$0x3f, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpsllq	$0x40, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpsrld	$0x5, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpsrld	$0x20, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpsrlq	$0x21, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpsrlq	$0x40, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpslldq	$0x0, %ymm0, %ymm2      # ymm2 = ymm0[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpslldq	$0x3, %ymm0, %ymm2      # ymm2 = zero,zero,zero,ymm0[0,1,2,3,4,5,6,7,8,9,10,11,12],zero,zero,zero,ymm0[16,17,18,19,20,21,22,23,24,25,26,27,28]
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpslldq	$0xf, %ymm0, %ymm2      # ymm2 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,ymm0[0],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,ymm0[16]
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpslldq	$0x10, %ymm0, %ymm2     # ymm2 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpsrldq	$0x1, %ymm0, %ymm2      # ymm2 = ymm0[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],zero,ymm0[17,18,19,20,21,22,23,24,25,26,27,28,29,30,31],zero
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpsrldq	$0x9, %ymm0, %ymm2      # ymm2 = ymm0[9,10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero,ymm0[25,26,27,28,29,30,31],zero,zero,zero,zero,zero,zero,zero,zero,zero
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpsrldq	$0x10, %ymm0, %ymm2     # ymm2 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpsubusw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpunpckldq	%ymm1, %ymm0, %ymm2 # ymm2 = ymm0[0],ymm1[0],ymm0[1],ymm1[1],ymm0[4],ymm1[4],ymm0[5],ymm1[5]
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpunpckhdq	%ymm1, %ymm0, %ymm2 # ymm2 = ymm0[2],ymm1[2],ymm0[3],ymm1[3],ymm0[6],ymm1[6],ymm0[7],ymm1[7]
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpunpcklqdq	%ymm1, %ymm0, %ymm2 # ymm2 = ymm0[0],ymm1[0],ymm0[2],ymm1[2]
               	vmovups	%ymm2, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vpunpckhqdq	%ymm1, %ymm0, %ymm0 # ymm0 = ymm0[1],ymm1[1],ymm0[3],ymm1[3]
               	vmovups	%ymm0, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movzbq	-0x3d(%rbp), %rax
               	movl	%eax, (%rsp)
               	movl	$0x6, 0x4(%rsp)
               	movabsq	$0x7fffffff80000000, %rax # imm = 0x7FFFFFFF80000000
               	movq	%rax, 0x8(%rsp)
               	movabsq	$-0x1fffffffd, %rax     # imm = 0xFFFFFFFE00000003
               	movq	%rax, 0x10(%rsp)
               	leaq	(%rsp), %rcx
               	movl	$0x1, 0x18(%rsp)
               	movl	-0x58(%rbp), %eax
               	movl	%eax, 0x1c(%rsp)
               	leaq	0x20(%rsp), %rdx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	-0x58(%rbp), %eax
               	movl	%eax, (%rsp)
               	movl	$0x1, 0x4(%rsp)
               	movabsq	$0x3fffffffe, %rax      # imm = 0x3FFFFFFFE
               	movq	%rax, 0x8(%rsp)
               	movabsq	$-0x7fffffff80000001, %rax # imm = 0x800000007FFFFFFF
               	movq	%rax, 0x10(%rsp)
               	movl	$0x6, 0x18(%rsp)
               	movzbq	-0x3d(%rbp), %rax
               	leaq	(%rsp), %rcx
               	movl	%eax, 0x1c(%rsp)
               	leaq	0x20(%rsp), %rdx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movslq	-0x58(%rbp), %rax
               	leaq	(%rsp), %rcx
               	movq	%rax, (%rsp)
               	movq	$0x2, 0x8(%rsp)
               	movq	$-0x1, 0x10(%rsp)
               	movq	-0x48(%rbp), %rax
               	movq	%rax, 0x18(%rsp)
               	leaq	0x20(%rsp), %rdx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movabsq	$0x18191a1b1c1d1e80, %rax # imm = 0x18191A1B1C1D1E80
               	movq	%rax, (%rsp)
               	movabsq	$0x1011121314151617, %rax # imm = 0x1011121314151617
               	movq	%rax, 0x8(%rsp)
               	movabsq	$0x8090a0b0c0d0e0f, %rax # imm = 0x8090A0B0C0D0E0F
               	movq	%rax, 0x10(%rsp)
               	movl	$0x4050607, 0x18(%rsp)  # imm = 0x4050607
               	leaq	(%rsp), %rax
               	movw	$0x203, 0x1c(%rsp)      # imm = 0x203
               	movb	$0x1, 0x1e(%rsp)
               	movzbq	-0x40(%rbp), %rcx
               	movb	%cl, 0x1f(%rsp)
               	leaq	0x20(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movzbq	-0x40(%rbp), %rax
               	movb	%al, (%rsp)
               	movb	$0x1, 0x1(%rsp)
               	movw	$0x302, 0x2(%rsp)       # imm = 0x302
               	movl	$0x7060504, 0x4(%rsp)   # imm = 0x7060504
               	movabsq	$0xf0e0d0c0b0a0908, %rax # imm = 0xF0E0D0C0B0A0908
               	movq	%rax, 0x8(%rsp)
               	movabsq	$0x1716151413121110, %rax # imm = 0x1716151413121110
               	movq	%rax, 0x10(%rsp)
               	leaq	(%rsp), %rax
               	movabsq	$-0x7fe1e2e3e4e5e6e8, %rcx # imm = 0x801E1D1C1B1A1918
               	movq	%rcx, 0x18(%rsp)
               	leaq	0x20(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
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
