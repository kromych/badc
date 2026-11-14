
avx_floating_and_fma_follow_the_sdm.x64:	file format elf64-x86-64

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

<_mm_shuffle_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movslq	%edi, %rdi
               	movups	%xmm0, -0x20(%rbp)
               	movups	%xmm1, -0x10(%rbp)
               	movq	%rdi, %rdx
               	andq	$0x3, %rdx
               	movl	-0x20(%rbp,%rdx,4), %edx
               	vmovd	%edx, %xmm0
               	movq	%rdi, %rdx
               	sarq	$0x2, %rdx
               	andq	$0x3, %rdx
               	movl	-0x20(%rbp,%rdx,4), %eax
               	vpinsrd	$0x1, %eax, %xmm0, %xmm0
               	movq	%rdi, %rax
               	sarq	$0x4, %rax
               	andq	$0x3, %rax
               	movl	-0x10(%rbp,%rax,4), %eax
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	sarq	$0x6, %rdi
               	andq	$0x3, %rdi
               	movl	-0x10(%rbp,%rdi,4), %eax
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	leave
               	retq

<_mm256_permute_pd>:
               	vpextrq	$0x1, %xmm0, %rax
               	vmovq	%rax, %xmm1
               	vmovq	%xmm0, %rax
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrq	$0x1, %xmm2, %rax
               	vmovq	%rax, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vmovq	%xmm0, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	retq

<_mm256_shuffle_pd>:
               	vmovq	%xmm0, %rax
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm1, %rax
               	vpinsrq	$0x1, %rax, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rax
               	vmovq	%rax, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vmovq	%xmm1, %rax
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vinserti128	$0x1, %xmm0, %ymm2, %ymm0
               	retq

<rnd_f>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x61c8864680b583eb, %r11 # imm = 0x9E3779B97F4A7C15
               	imulq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x3c, %rcx
               	cmpl	$0x5, %ecx
               	jae	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movq	%rax, %rsi
               	shrq	$0x20, %rsi
               	movl	$0xc, %eax
               	movl	$0xb, %edx
               	testl	%edi, %edi
               	movq	%rdx, %r8
               	cmovneq	%rax, %r8
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movl	(%rcx,%rdx,4), %eax
               	movq	%rax, %rcx
               	andq	$0x7f800000, %rcx       # imm = 0x7F800000
               	cmpl	$0x7f800000, %ecx       # imm = 0x7F800000
               	jne	<addr>
               	testl	$0x7fffff, %eax         # imm = 0x7FFFFF
               	je	<addr>
               	orq	$0x400000, %rax         # imm = 0x400000
               	movl	$0x3f800000, %ecx       # imm = 0x3F800000
               	testl	%edi, %edi
               	cmoveq	%rcx, %rax
               	movl	%eax, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm0
               	leave
               	retq
               	shrq	$0x10, %rax
               	jmp	<addr>

<rnd_d>:
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x61c8864680b583eb, %rcx # imm = 0x9E3779B97F4A7C15
               	imulq	%rax, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x3c, %rdx
               	cmpl	$0x5, %edx
               	jae	<addr>
               	leaq	<rip>, %rsi # <addr>
               	shrq	$0x20, %rcx
               	movl	$0xb, %eax
               	movl	$0xa, %edx
               	testl	%edi, %edi
               	movq	%rdx, %r8
               	cmovneq	%rax, %r8
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movq	(%rsi,%rdx,8), %rax
               	movabsq	$0x7ff0000000000000, %rcx # imm = 0x7FF0000000000000
               	andq	%rax, %rcx
               	movabsq	$0x7ff0000000000000, %r11 # imm = 0x7FF0000000000000
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movabsq	$0xfffffffffffff, %rcx  # imm = 0xFFFFFFFFFFFFF
               	andq	%rax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movabsq	$0x8000000000000, %r11  # imm = 0x8000000000000
               	orq	%r11, %rax
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	testl	%edi, %edi
               	cmoveq	%rcx, %rax
               	movq	%rax, %xmm0
               	retq
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x61c8864680b583eb, %r11 # imm = 0x9E3779B97F4A7C15
               	imulq	%r11, %rax
               	jmp	<addr>

<fnv>:
               	xorl	%eax, %eax
               	movabsq	$0x100000001b3, %rcx    # imm = 0x100000001B3
               	cmpl	%edx, %eax
               	jge	<addr>
               	movzbq	(%rsi,%rax), %r8
               	xorq	%r8, %rdi
               	imulq	%rcx, %rdi
               	incq	%rax
               	cmpl	%edx, %eax
               	jl	<addr>
               	movq	%rdi, %rax
               	retq

<arith>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x210, %rsp            # imm = 0x210
               	subq	$0x140, %rsp            # imm = 0x140
               	andq	$-0x20, %rsp
               	vmovups	%ymm0, -0x1e0(%rbp)
               	vmovups	%ymm1, -0x200(%rbp)
               	vmovups	%ymm2, (%rsp)
               	vmovups	%ymm3, 0x20(%rsp)
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm0
               	vmovdqa	%xmm0, %xmm2
               	vmovups	-0x200(%rbp), %ymm1
               	vmovdqa	%xmm1, %xmm3
               	vaddps	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vaddps	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	-0x1e0(%rbp), %ymm0
               	vmovdqa	%xmm0, %xmm2
               	vmovups	-0x200(%rbp), %ymm1
               	vmovdqa	%xmm1, %xmm3
               	vsubps	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vsubps	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	-0x1e0(%rbp), %ymm0
               	vmovdqa	%xmm0, %xmm2
               	vmovups	-0x200(%rbp), %ymm1
               	vmovdqa	%xmm1, %xmm3
               	vmulps	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vmulps	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	-0x1e0(%rbp), %ymm0
               	vmovdqa	%xmm0, %xmm2
               	vmovups	-0x200(%rbp), %ymm1
               	vmovdqa	%xmm1, %xmm3
               	vdivps	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vdivps	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	-0x1e0(%rbp), %ymm0
               	vmovdqa	%xmm0, %xmm2
               	vmovups	-0x200(%rbp), %ymm1
               	vmovdqa	%xmm1, %xmm3
               	vminps	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vminps	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	-0x1e0(%rbp), %ymm0
               	vmovdqa	%xmm0, %xmm2
               	vmovups	-0x200(%rbp), %ymm1
               	vmovdqa	%xmm1, %xmm3
               	vmaxps	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vmaxps	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	-0x1e0(%rbp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	sqrtps	%xmm1, %xmm1
               	vextracti128	$0x1, %ymm0, %xmm0
               	sqrtps	%xmm0, %xmm0
               	vmovdqa	%xmm1, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	-0x1e0(%rbp), %ymm2
               	vmovdqa	%xmm2, %xmm0
               	vmovups	-0x200(%rbp), %ymm3
               	vmovdqa	%xmm3, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm4 # xmm4 = xmm0[0,0,0,0]
               	vpermilps	$0x0, %xmm1, %xmm5 # xmm5 = xmm1[0,0,0,0]
               	subss	%xmm5, %xmm4
               	vmovd	%xmm4, %r11d
               	vmovd	%r11d, %xmm4
               	vpermilps	$0x1, %xmm0, %xmm5 # xmm5 = xmm0[1,0,0,0]
               	vpermilps	$0x1, %xmm1, %xmm6 # xmm6 = xmm1[1,0,0,0]
               	addss	%xmm6, %xmm5
               	vmovd	%xmm5, %r11d
               	vpinsrd	$0x1, %r11d, %xmm4, %xmm4
               	vpermilps	$0x2, %xmm0, %xmm5 # xmm5 = xmm0[2,0,0,0]
               	vpermilps	$0x2, %xmm1, %xmm6 # xmm6 = xmm1[2,0,0,0]
               	subss	%xmm6, %xmm5
               	vmovd	%xmm5, %r11d
               	vpinsrd	$0x2, %r11d, %xmm4, %xmm4
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	vpermilps	$0x3, %xmm1, %xmm1 # xmm1 = xmm1[3,0,0,0]
               	addss	%xmm1, %xmm0
               	vmovd	%xmm0, %r11d
               	vpinsrd	$0x3, %r11d, %xmm4, %xmm4
               	vextracti128	$0x1, %ymm2, %xmm0
               	vextracti128	$0x1, %ymm3, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	vpermilps	$0x0, %xmm1, %xmm3 # xmm3 = xmm1[0,0,0,0]
               	subss	%xmm3, %xmm2
               	vmovd	%xmm2, %r11d
               	vmovd	%r11d, %xmm2
               	vpermilps	$0x1, %xmm0, %xmm3 # xmm3 = xmm0[1,0,0,0]
               	vpermilps	$0x1, %xmm1, %xmm5 # xmm5 = xmm1[1,0,0,0]
               	addss	%xmm5, %xmm3
               	vmovd	%xmm3, %r11d
               	vpinsrd	$0x1, %r11d, %xmm2, %xmm2
               	vpermilps	$0x2, %xmm0, %xmm3 # xmm3 = xmm0[2,0,0,0]
               	vpermilps	$0x2, %xmm1, %xmm5 # xmm5 = xmm1[2,0,0,0]
               	subss	%xmm5, %xmm3
               	vmovd	%xmm3, %r11d
               	vpinsrd	$0x2, %r11d, %xmm2, %xmm2
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	vpermilps	$0x3, %xmm1, %xmm1 # xmm1 = xmm1[3,0,0,0]
               	addss	%xmm1, %xmm0
               	vmovd	%xmm0, %r11d
               	movapd	%xmm2, %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovdqa	%xmm4, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	-0x1e0(%rbp), %ymm2
               	vmovdqa	%xmm2, %xmm0
               	vmovups	-0x200(%rbp), %ymm3
               	vmovdqa	%xmm3, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm4 # xmm4 = xmm0[0,0,0,0]
               	vpermilps	$0x1, %xmm0, %xmm5 # xmm5 = xmm0[1,0,0,0]
               	addss	%xmm5, %xmm4
               	vmovd	%xmm4, %r11d
               	vmovd	%r11d, %xmm4
               	vpermilps	$0x2, %xmm0, %xmm5 # xmm5 = xmm0[2,0,0,0]
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	vaddss	%xmm0, %xmm5, %xmm0
               	vmovd	%xmm0, %r11d
               	movapd	%xmm4, %xmm0
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	vpermilps	$0x0, %xmm1, %xmm4 # xmm4 = xmm1[0,0,0,0]
               	vpermilps	$0x1, %xmm1, %xmm5 # xmm5 = xmm1[1,0,0,0]
               	addss	%xmm5, %xmm4
               	vmovd	%xmm4, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	vpermilps	$0x2, %xmm1, %xmm4 # xmm4 = xmm1[2,0,0,0]
               	vpermilps	$0x3, %xmm1, %xmm1 # xmm1 = xmm1[3,0,0,0]
               	vaddss	%xmm1, %xmm4, %xmm1
               	vmovd	%xmm1, %r11d
               	movapd	%xmm0, %xmm4
               	vpinsrd	$0x3, %r11d, %xmm4, %xmm4
               	vextracti128	$0x1, %ymm2, %xmm0
               	vextracti128	$0x1, %ymm3, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	vpermilps	$0x1, %xmm0, %xmm3 # xmm3 = xmm0[1,0,0,0]
               	addss	%xmm3, %xmm2
               	vmovd	%xmm2, %r11d
               	vmovd	%r11d, %xmm2
               	vpermilps	$0x2, %xmm0, %xmm3 # xmm3 = xmm0[2,0,0,0]
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	vaddss	%xmm0, %xmm3, %xmm0
               	vmovd	%xmm0, %r11d
               	movapd	%xmm2, %xmm0
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	vpermilps	$0x0, %xmm1, %xmm2 # xmm2 = xmm1[0,0,0,0]
               	vpermilps	$0x1, %xmm1, %xmm3 # xmm3 = xmm1[1,0,0,0]
               	addss	%xmm3, %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	vpermilps	$0x2, %xmm1, %xmm2 # xmm2 = xmm1[2,0,0,0]
               	vpermilps	$0x3, %xmm1, %xmm1 # xmm1 = xmm1[3,0,0,0]
               	vaddss	%xmm1, %xmm2, %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovdqa	%xmm4, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	-0x1e0(%rbp), %ymm2
               	vmovdqa	%xmm2, %xmm0
               	vmovups	-0x200(%rbp), %ymm3
               	vmovdqa	%xmm3, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm4 # xmm4 = xmm0[0,0,0,0]
               	vpermilps	$0x1, %xmm0, %xmm5 # xmm5 = xmm0[1,0,0,0]
               	subss	%xmm5, %xmm4
               	vmovd	%xmm4, %r11d
               	vmovd	%r11d, %xmm4
               	vpermilps	$0x2, %xmm0, %xmm5 # xmm5 = xmm0[2,0,0,0]
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	subss	%xmm0, %xmm5
               	vmovd	%xmm5, %r11d
               	movapd	%xmm4, %xmm0
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	vpermilps	$0x0, %xmm1, %xmm4 # xmm4 = xmm1[0,0,0,0]
               	vpermilps	$0x1, %xmm1, %xmm5 # xmm5 = xmm1[1,0,0,0]
               	subss	%xmm5, %xmm4
               	vmovd	%xmm4, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	vpermilps	$0x2, %xmm1, %xmm4 # xmm4 = xmm1[2,0,0,0]
               	vpermilps	$0x3, %xmm1, %xmm1 # xmm1 = xmm1[3,0,0,0]
               	subss	%xmm1, %xmm4
               	vmovd	%xmm4, %r11d
               	movapd	%xmm0, %xmm4
               	vpinsrd	$0x3, %r11d, %xmm4, %xmm4
               	vextracti128	$0x1, %ymm2, %xmm0
               	vextracti128	$0x1, %ymm3, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	vpermilps	$0x1, %xmm0, %xmm3 # xmm3 = xmm0[1,0,0,0]
               	subss	%xmm3, %xmm2
               	vmovd	%xmm2, %r11d
               	vmovd	%r11d, %xmm2
               	vpermilps	$0x2, %xmm0, %xmm3 # xmm3 = xmm0[2,0,0,0]
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	subss	%xmm0, %xmm3
               	vmovd	%xmm3, %r11d
               	movapd	%xmm2, %xmm0
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	vpermilps	$0x0, %xmm1, %xmm2 # xmm2 = xmm1[0,0,0,0]
               	vpermilps	$0x1, %xmm1, %xmm3 # xmm3 = xmm1[1,0,0,0]
               	subss	%xmm3, %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	vpermilps	$0x2, %xmm1, %xmm2 # xmm2 = xmm1[2,0,0,0]
               	vpermilps	$0x3, %xmm1, %xmm1 # xmm1 = xmm1[3,0,0,0]
               	subss	%xmm1, %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovdqa	%xmm4, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	-0x1b8(%rbp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	vaddpd	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vaddpd	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	vsubpd	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vsubpd	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	vmulpd	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vmulpd	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	vdivpd	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vdivpd	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	vminpd	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vminpd	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	vmaxpd	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vmaxpd	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	sqrtpd	%xmm1, %xmm1
               	vextracti128	$0x1, %ymm0, %xmm0
               	sqrtpd	%xmm0, %xmm0
               	vmovdqa	%xmm1, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	vpermilpd	$0x0, %xmm2, %xmm4 # xmm4 = xmm2[0,0]
               	vpermilpd	$0x0, %xmm3, %xmm5 # xmm5 = xmm3[0,0]
               	subsd	%xmm5, %xmm4
               	vpermilpd	$0x1, %xmm2, %xmm2 # xmm2 = xmm2[1,0]
               	vpermilpd	$0x1, %xmm3, %xmm3 # xmm3 = xmm3[1,0]
               	addsd	%xmm3, %xmm2
               	vunpcklpd	%xmm2, %xmm4, %xmm2 # xmm2 = xmm4[0],xmm2[0]
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vpermilpd	$0x0, %xmm0, %xmm3 # xmm3 = xmm0[0,0]
               	vpermilpd	$0x0, %xmm1, %xmm4 # xmm4 = xmm1[0,0]
               	subsd	%xmm4, %xmm3
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	vpermilpd	$0x1, %xmm1, %xmm1 # xmm1 = xmm1[1,0]
               	addsd	%xmm1, %xmm0
               	vunpcklpd	%xmm0, %xmm3, %xmm0 # xmm0 = xmm3[0],xmm0[0]
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	vpermilpd	$0x0, %xmm2, %xmm4 # xmm4 = xmm2[0,0]
               	vpermilpd	$0x1, %xmm2, %xmm2 # xmm2 = xmm2[1,0]
               	vaddsd	%xmm2, %xmm4, %xmm2
               	vpermilpd	$0x0, %xmm3, %xmm4 # xmm4 = xmm3[0,0]
               	vpermilpd	$0x1, %xmm3, %xmm3 # xmm3 = xmm3[1,0]
               	vaddsd	%xmm3, %xmm4, %xmm3
               	vunpcklpd	%xmm3, %xmm2, %xmm2 # xmm2 = xmm2[0],xmm3[0]
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vpermilpd	$0x0, %xmm0, %xmm3 # xmm3 = xmm0[0,0]
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	vaddsd	%xmm0, %xmm3, %xmm0
               	vpermilpd	$0x0, %xmm1, %xmm3 # xmm3 = xmm1[0,0]
               	vpermilpd	$0x1, %xmm1, %xmm1 # xmm1 = xmm1[1,0]
               	vaddsd	%xmm1, %xmm3, %xmm1
               	vunpcklpd	%xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm1[0]
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	vpermilpd	$0x0, %xmm2, %xmm4 # xmm4 = xmm2[0,0]
               	vpermilpd	$0x1, %xmm2, %xmm2 # xmm2 = xmm2[1,0]
               	subsd	%xmm2, %xmm4
               	vmovq	%xmm4, %xmm2            # xmm2 = xmm4[0],zero
               	vpermilpd	$0x0, %xmm3, %xmm4 # xmm4 = xmm3[0,0]
               	vpermilpd	$0x1, %xmm3, %xmm3 # xmm3 = xmm3[1,0]
               	subsd	%xmm3, %xmm4
               	vunpcklpd	%xmm4, %xmm2, %xmm2 # xmm2 = xmm2[0],xmm4[0]
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vpermilpd	$0x0, %xmm0, %xmm3 # xmm3 = xmm0[0,0]
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	subsd	%xmm0, %xmm3
               	vmovq	%xmm3, %xmm0            # xmm0 = xmm3[0],zero
               	vpermilpd	$0x0, %xmm1, %xmm3 # xmm3 = xmm1[0,0]
               	vpermilpd	$0x1, %xmm1, %xmm1 # xmm1 = xmm1[1,0]
               	subsd	%xmm1, %xmm3
               	vunpcklpd	%xmm3, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm3[0]
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	-0x1b8(%rbp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmpeqps	%ymm15, %ymm14, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpeqpd	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmpeqss	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpeqsd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	-0x1b8(%rbp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmpltps	%ymm15, %ymm14, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpltpd	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmpltss	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpltsd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	-0x1b8(%rbp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmpleps	%ymm15, %ymm14, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmplepd	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmpless	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmplesd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	-0x1b8(%rbp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmpunordps	%ymm15, %ymm14, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpunordpd	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmpunordss	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpunordsd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	-0x1b8(%rbp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmpneqps	%ymm15, %ymm14, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpneqpd	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmpneqss	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpneqsd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	-0x1b8(%rbp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmpnltps	%ymm15, %ymm14, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpnltpd	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmpnltss	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpnltsd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	-0x1b8(%rbp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmpnleps	%ymm15, %ymm14, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpnlepd	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmpnless	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpnlesd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	-0x1b8(%rbp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmpordps	%ymm15, %ymm14, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpordpd	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmpordss	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpordsd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	-0x1b8(%rbp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmpeq_uqps	%ymm15, %ymm14, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpeq_uqpd	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmpeq_uqss	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpeq_uqsd	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmpngeps	%ymm15, %ymm14, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpngepd	%ymm1, %ymm0, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmpngess	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpngesd	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmpngtps	%ymm15, %ymm14, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpngtpd	%ymm1, %ymm0, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmpngtss	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpngtsd	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmpfalseps	%ymm15, %ymm14, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpfalsepd	%ymm1, %ymm0, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmpfalsess	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpfalsesd	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmpneq_oqps	%ymm15, %ymm14, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpneq_oqpd	%ymm1, %ymm0, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmpneq_oqss	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpneq_oqsd	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmpgeps	%ymm15, %ymm14, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpgepd	%ymm1, %ymm0, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmpgess	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpgesd	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmpgtps	%ymm15, %ymm14, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpgtpd	%ymm1, %ymm0, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmpgtss	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpgtsd	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmptrueps	%ymm15, %ymm14, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmptruepd	%ymm1, %ymm0, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmptruess	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmptruesd	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmpeq_osps	%ymm15, %ymm14, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpeq_ospd	%ymm1, %ymm0, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmpeq_osss	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpeq_ossd	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmplt_oqps	%ymm15, %ymm14, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmplt_oqpd	%ymm1, %ymm0, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmplt_oqss	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmplt_oqsd	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmple_oqps	%ymm15, %ymm14, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmple_oqpd	%ymm1, %ymm0, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmple_oqss	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmple_oqsd	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmpunord_sps	%ymm15, %ymm14, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpunord_spd	%ymm1, %ymm0, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmpunord_sss	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpunord_ssd	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmpneq_usps	%ymm15, %ymm14, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpneq_uspd	%ymm1, %ymm0, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmpneq_usss	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpneq_ussd	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmpnlt_uqps	%ymm15, %ymm14, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpnlt_uqpd	%ymm1, %ymm0, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmpnlt_uqss	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpnlt_uqsd	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmpnle_uqps	%ymm15, %ymm14, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpnle_uqpd	%ymm1, %ymm0, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmpnle_uqss	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpnle_uqsd	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmpord_sps	%ymm15, %ymm14, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpord_spd	%ymm1, %ymm0, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmpord_sss	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpord_ssd	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmpeq_usps	%ymm15, %ymm14, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpeq_uspd	%ymm1, %ymm0, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmpeq_usss	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpeq_ussd	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmpnge_uqps	%ymm15, %ymm14, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpnge_uqpd	%ymm1, %ymm0, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmpnge_uqss	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpnge_uqsd	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmpngt_uqps	%ymm15, %ymm14, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpngt_uqpd	%ymm1, %ymm0, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmpngt_uqss	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpngt_uqsd	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmpfalse_osps	%ymm15, %ymm14, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpfalse_ospd	%ymm1, %ymm0, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmpfalse_osss	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpfalse_ossd	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmpneq_osps	%ymm15, %ymm14, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpneq_ospd	%ymm1, %ymm0, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmpneq_osss	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpneq_ossd	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmpge_oqps	%ymm15, %ymm14, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpge_oqpd	%ymm1, %ymm0, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmpge_oqss	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpge_oqsd	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmpgt_oqps	%ymm15, %ymm14, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpgt_oqpd	%ymm1, %ymm0, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmpgt_oqss	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpgt_oqsd	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vcmptrue_usps	%ymm15, %ymm14, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmptrue_uspd	%ymm1, %ymm0, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	vmovdqu	-0x200(%rbp), %xmm1
               	vcmptrue_usss	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmptrue_ussd	%xmm1, %xmm0, %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1e0(%rbp), %ymm0
               	vextracti128	$0x1, %ymm0, %xmm1
               	cvtps2dq	%xmm1, %xmm1
               	cvtps2dq	%xmm0, %xmm0
               	vmovdqa	%xmm0, %xmm0
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	-0x1e0(%rbp), %ymm0
               	vextracti128	$0x1, %ymm0, %xmm1
               	cvttps2dq	%xmm1, %xmm1
               	cvttps2dq	%xmm0, %xmm0
               	vmovdqa	%xmm0, %xmm0
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	-0x200(%rbp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	cvtdq2ps	%xmm1, %xmm1
               	vextracti128	$0x1, %ymm0, %xmm0
               	cvtdq2ps	%xmm0, %xmm0
               	vmovdqa	%xmm1, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x60(%rsp), %rsi
               	vmovups	%ymm0, 0x60(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	cvtpd2ps	%xmm1, %xmm1
               	vextracti128	$0x1, %ymm0, %xmm0
               	cvtpd2ps	%xmm0, %xmm0
               	vmovd	%xmm1, %eax
               	movslq	%eax, %rax
               	vmovd	%eax, %xmm2
               	vpextrd	$0x1, %xmm1, %eax
               	movslq	%eax, %rax
               	movapd	%xmm2, %xmm1
               	vpinsrd	$0x1, %eax, %xmm1, %xmm1
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x2, %eax, %xmm1, %xmm1
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	leaq	0x100(%rsp), %rsi
               	movups	%xmm0, 0x100(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	cvtps2pd	%xmm0, %xmm1
               	vpextrd	$0x2, %xmm0, %eax
               	movslq	%eax, %rax
               	vmovd	%eax, %xmm2
               	vpextrd	$0x3, %xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x1, %eax, %xmm2, %xmm2
               	vpextrd	$0x2, %xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x2, %eax, %xmm2, %xmm2
               	vpextrd	$0x3, %xmm0, %eax
               	movslq	%eax, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	cvtps2pd	%xmm0, %xmm0
               	vmovdqa	%xmm1, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	cvtpd2dq	%xmm1, %xmm1
               	vextracti128	$0x1, %ymm0, %xmm0
               	cvtpd2dq	%xmm0, %xmm0
               	vpunpcklqdq	%xmm0, %xmm1, %xmm0 # xmm0 = xmm1[0],xmm0[0]
               	leaq	0x110(%rsp), %rsi
               	movups	%xmm0, 0x110(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	cvttpd2dq	%xmm1, %xmm1
               	vextracti128	$0x1, %ymm0, %xmm0
               	cvttpd2dq	%xmm0, %xmm0
               	vpunpcklqdq	%xmm0, %xmm1, %xmm0 # xmm0 = xmm1[0],xmm0[0]
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x20(%rsp), %ymm0
               	cvtdq2pd	%xmm0, %xmm1
               	pshufd	$0xe, %xmm0, %xmm0      # xmm0 = xmm0[2,3,0,0]
               	cvtdq2pd	%xmm0, %xmm0
               	vmovdqa	%xmm1, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	-0x1e0(%rbp), %ymm0
               	vmovdqa	%xmm0, %xmm2
               	vmovups	-0x200(%rbp), %ymm1
               	vmovdqa	%xmm1, %xmm3
               	vandps	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vandps	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm3
               	vmovdqa	%xmm1, %xmm4
               	vpcmpeqd	%xmm2, %xmm2, %xmm2
               	vpxor	%xmm2, %xmm3, %xmm3
               	vpand	%xmm4, %xmm3, %xmm3
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vpxor	%xmm2, %xmm0, %xmm0
               	vpand	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm3, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	-0x1e0(%rbp), %ymm0
               	vmovdqa	%xmm0, %xmm2
               	vmovups	-0x200(%rbp), %ymm1
               	vmovdqa	%xmm1, %xmm3
               	vorps	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vorps	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	vpxor	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vpxor	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	-0x1e0(%rbp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	vmovups	-0x200(%rbp), %ymm2
               	vmovdqa	%xmm2, %xmm3
               	vmovd	%xmm1, %eax
               	movslq	%eax, %rax
               	vmovd	%eax, %xmm4
               	vmovd	%xmm3, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x1, %eax, %xmm4, %xmm4
               	vpextrd	$0x1, %xmm1, %eax
               	movslq	%eax, %rax
               	movapd	%xmm4, %xmm1
               	vpinsrd	$0x2, %eax, %xmm1, %xmm1
               	vpextrd	$0x1, %xmm3, %eax
               	movslq	%eax, %rax
               	movapd	%xmm1, %xmm3
               	vpinsrd	$0x3, %eax, %xmm3, %xmm3
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm2, %xmm1
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vmovd	%eax, %xmm2
               	vmovd	%xmm1, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x1, %eax, %xmm2, %xmm2
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	vpextrd	$0x1, %xmm1, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	vmovdqa	%xmm3, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	vpextrq	$0x1, %xmm2, %rax
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm3, %rax
               	vpinsrq	$0x1, %rax, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vpextrq	$0x1, %xmm0, %rax
               	vmovq	%rax, %xmm0
               	vpextrq	$0x1, %xmm1, %rax
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x9c, %edi
               	vmovdqu	-0x1e0(%rbp), %xmm0
               	leaq	0x120(%rsp), %r9
               	movups	%xmm0, 0x120(%rsp)
               	vmovdqu	-0x200(%rbp), %xmm0
               	leaq	0x40(%rsp), %rax
               	movups	%xmm0, 0x40(%rsp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, -0x210(%rbp)
               	leaq	0x120(%rsp), %r9
               	vmovdqu	-0x1d0(%rbp), %xmm0
               	movups	%xmm0, 0x120(%rsp)
               	leaq	0x40(%rsp), %rax
               	vmovdqu	-0x1f0(%rbp), %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x9c, %edi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	vzeroupper
               	callq	<addr>
               	movups	-0x210(%rbp), %xmm15
               	vmovdqa	%xmm15, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x6, %edi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movq	%rax, %r10
               	vmovups	(%r10), %ymm1
               	callq	<addr>
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x1b, %edi
               	vmovups	-0x1e0(%rbp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	leaq	0x120(%rsp), %r9
               	movups	%xmm1, 0x120(%rsp)
               	leaq	0x40(%rsp), %rax
               	movups	%xmm0, 0x40(%rsp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, -0x210(%rbp)
               	leaq	0x120(%rsp), %r9
               	vmovups	-0x1e0(%rbp), %ymm1
               	vextracti128	$0x1, %ymm1, %xmm0
               	movups	%xmm0, 0x120(%rsp)
               	leaq	0x40(%rsp), %rax
               	vextracti128	$0x1, %ymm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movl	$0x1b, %edi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	vzeroupper
               	callq	<addr>
               	movups	-0x210(%rbp), %xmm15
               	vmovdqa	%xmm15, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	movl	$0x5, %edi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vperm2i128	$0x21, %ymm15, %ymm14, %ymm0 # ymm0 = ymm14[2,3],ymm15[0,1]
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vperm2i128	$0x30, %ymm1, %ymm0, %ymm0 # ymm0 = ymm0[0,1],ymm1[2,3]
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	-0x200(%rbp), %ymm15
               	vblendps	$0xa5, %ymm15, %ymm14, %ymm0 # ymm0 = ymm15[0],ymm14[1],ymm15[2],ymm14[3,4],ymm15[5],ymm14[6],ymm15[7]
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vblendpd	$0x9, %ymm1, %ymm0, %ymm0 # ymm0 = ymm1[0],ymm0[1,2],ymm1[3]
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	-0x1e0(%rbp), %ymm14
               	vblendvps	%ymm0, -0x200(%rbp), %ymm14, %ymm0
               	leaq	0xa0(%rsp), %rsi
               	vmovups	%ymm0, 0xa0(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	-0x1e0(%rbp), %ymm15
               	vblendvpd	%ymm15, %ymm1, %ymm0, %ymm0
               	leaq	0xc0(%rsp), %rsi
               	vmovups	%ymm0, 0xc0(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	-0x1e0(%rbp), %ymm1
               	vmovdqa	%xmm1, %xmm0
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setl	%al
               	movzbq	%al, %rax
               	vpextrd	$0x1, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	orq	%rcx, %rax
               	vpextrd	$0x2, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x2, %rcx
               	orq	%rcx, %rax
               	vpextrd	$0x3, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x3, %rcx
               	orq	%rcx, %rax
               	vextracti128	$0x1, %ymm1, %xmm0
               	vmovd	%xmm0, %ecx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	vpextrd	$0x1, %xmm0, %edx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	setl	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	vpextrd	$0x2, %xmm0, %edx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	setl	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	vpextrd	$0x3, %xmm0, %edx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	setl	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	shlq	$0x4, %rcx
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	vmovq	%xmm1, %rax
               	testq	%rax, %rax
               	setl	%al
               	movzbq	%al, %rax
               	vpextrq	$0x1, %xmm1, %rcx
               	testq	%rcx, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	orq	%rcx, %rax
               	vextracti128	$0x1, %ymm0, %xmm0
               	vmovq	%xmm0, %rcx
               	testq	%rcx, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	vpextrq	$0x1, %xmm0, %rdx
               	testq	%rdx, %rdx
               	setl	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	shlq	$0x2, %rcx
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	-0x1e0(%rbp), %ymm1
               	vmovdqa	%xmm1, %xmm0
               	vpermilps	$0x1, %xmm0, %xmm2 # xmm2 = xmm0[1,0,0,0]
               	vmovd	%xmm2, %r11d
               	vmovd	%r11d, %xmm2
               	vpermilps	$0x1, %xmm0, %xmm3 # xmm3 = xmm0[1,0,0,0]
               	vmovd	%xmm3, %r11d
               	vpinsrd	$0x1, %r11d, %xmm2, %xmm2
               	vpermilps	$0x3, %xmm0, %xmm3 # xmm3 = xmm0[3,0,0,0]
               	vmovd	%xmm3, %r11d
               	vpinsrd	$0x2, %r11d, %xmm2, %xmm2
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	vmovd	%xmm0, %r11d
               	vpinsrd	$0x3, %r11d, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm1, %xmm0
               	vpermilps	$0x1, %xmm0, %xmm1 # xmm1 = xmm0[1,0,0,0]
               	vmovd	%xmm1, %r11d
               	vmovd	%r11d, %xmm1
               	vpermilps	$0x1, %xmm0, %xmm3 # xmm3 = xmm0[1,0,0,0]
               	vmovd	%xmm3, %r11d
               	vpinsrd	$0x1, %r11d, %xmm1, %xmm1
               	vpermilps	$0x3, %xmm0, %xmm3 # xmm3 = xmm0[3,0,0,0]
               	vmovd	%xmm3, %r11d
               	vpinsrd	$0x2, %r11d, %xmm1, %xmm1
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0xe0(%rsp), %rsi
               	vmovups	%ymm0, 0xe0(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	-0x200(%rbp), %ymm1
               	vmovdqa	%xmm1, %xmm0
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	vmovd	%xmm2, %r11d
               	vmovd	%r11d, %xmm2
               	vpermilps	$0x0, %xmm0, %xmm3 # xmm3 = xmm0[0,0,0,0]
               	vmovd	%xmm3, %r11d
               	vpinsrd	$0x1, %r11d, %xmm2, %xmm2
               	vpermilps	$0x2, %xmm0, %xmm3 # xmm3 = xmm0[2,0,0,0]
               	vmovd	%xmm3, %r11d
               	vpinsrd	$0x2, %r11d, %xmm2, %xmm2
               	vpermilps	$0x2, %xmm0, %xmm0 # xmm0 = xmm0[2,0,0,0]
               	vmovd	%xmm0, %r11d
               	vpinsrd	$0x3, %r11d, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm1, %xmm0
               	vpermilps	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0,0,0]
               	vmovd	%xmm1, %r11d
               	vmovd	%r11d, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm3 # xmm3 = xmm0[0,0,0,0]
               	vmovd	%xmm3, %r11d
               	vpinsrd	$0x1, %r11d, %xmm1, %xmm1
               	vpermilps	$0x2, %xmm0, %xmm3 # xmm3 = xmm0[2,0,0,0]
               	vmovd	%xmm3, %r11d
               	vpinsrd	$0x2, %r11d, %xmm1, %xmm1
               	vpermilps	$0x2, %xmm0, %xmm0 # xmm0 = xmm0[2,0,0,0]
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	vpermilpd	$0x0, %xmm1, %xmm2 # xmm2 = xmm1[0,0]
               	vunpcklpd	%xmm1, %xmm2, %xmm1 # xmm1 = xmm2[0],xmm1[0]
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	vunpcklpd	%xmm0, %xmm2, %xmm0 # xmm0 = xmm2[0],xmm0[0]
               	vmovdqa	%xmm1, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovdqu	-0x1d0(%rbp), %xmm0
               	leaq	0x40(%rsp), %rsi
               	movups	%xmm0, 0x40(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x20(%rsp), %ymm0
               	vmovups	(%rsp), %ymm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x40(%rsp), %rsi
               	vmovups	%ymm0, 0x40(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	-0x1e0(%rbp), %ymm14
               	vpextrd	$0x3, %xmm14, %eax
               	movslq	%eax, %rax
               	movl	%eax, 0x40(%rsp)
               	movl	%eax, 0x44(%rsp)
               	movl	%eax, 0x48(%rsp)
               	movl	%eax, 0x4c(%rsp)
               	movl	%eax, 0x50(%rsp)
               	movl	%eax, 0x54(%rsp)
               	movl	%eax, 0x58(%rsp)
               	leaq	0x40(%rsp), %rsi
               	movl	%eax, 0x5c(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %rsi
               	vmovups	-0x1e0(%rbp), %ymm14
               	vmovups	%ymm14, 0x40(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	-0x200(%rbp), %ymm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	movss	%xmm0, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vzeroupper
               	leave
               	retq

<fused>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x130, %rsp            # imm = 0x130
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x20(%rbp)
               	vmovdqa	%xmm1, %xmm14
               	movups	%xmm14, -0x40(%rbp)
               	vmovdqa	%xmm2, %xmm6
               	vmovdqa	%xmm3, %xmm14
               	movups	%xmm14, -0x30(%rbp)
               	vmovdqa	%xmm4, %xmm14
               	movups	%xmm14, -0x50(%rbp)
               	vmovdqa	%xmm5, %xmm14
               	movups	%xmm14, -0x60(%rbp)
               	movl	$0x3d, %edi
               	vmovups	%ymm0, -0x80(%rbp)
               	vmovups	%ymm1, -0xa0(%rbp)
               	vmovups	%ymm2, -0xc0(%rbp)
               	vmovups	%ymm3, -0xe0(%rbp)
               	vmovups	%ymm4, -0x100(%rbp)
               	vmovups	%ymm5, -0x120(%rbp)
               	movups	%xmm6, -0x130(%rbp)
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x80(%rbp), %ymm0
               	vmovups	-0xa0(%rbp), %ymm1
               	vmovups	-0xc0(%rbp), %ymm2
               	vmovups	-0xe0(%rbp), %ymm3
               	vmovups	-0x100(%rbp), %ymm4
               	vmovups	-0x120(%rbp), %ymm5
               	movups	-0x130(%rbp), %xmm6
               	vmovaps	%ymm2, %ymm7
               	vfmadd231ps	%ymm1, %ymm0, %ymm7 # ymm7 = (ymm0 * ymm1) + ymm7
               	vmovups	%ymm7, (%rsp)
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
               	vmovaps	%ymm2, %ymm7
               	vfmsub231ps	%ymm1, %ymm0, %ymm7 # ymm7 = (ymm0 * ymm1) - ymm7
               	vmovups	%ymm7, (%rsp)
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
               	vmovaps	%ymm2, %ymm7
               	vfnmadd231ps	%ymm1, %ymm0, %ymm7 # ymm7 = -(ymm0 * ymm1) + ymm7
               	vmovups	%ymm7, (%rsp)
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
               	vmovaps	%ymm2, %ymm7
               	vfnmsub231ps	%ymm1, %ymm0, %ymm7 # ymm7 = -(ymm0 * ymm1) - ymm7
               	vmovups	%ymm7, (%rsp)
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
               	vmovaps	%ymm2, %ymm7
               	vfmaddsub231ps	%ymm1, %ymm0, %ymm7 # ymm7 = (ymm0 * ymm1) +/- ymm7
               	vmovups	%ymm7, (%rsp)
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
               	vmovaps	%ymm2, %ymm14
               	vfmsubadd231ps	%ymm1, %ymm0, %ymm14 # ymm14 = (ymm0 * ymm1) -/+ ymm14
               	vmovaps	%ymm14, %ymm0
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
               	vmovups	-0x20(%rbp), %ymm15
               	vmovaps	%ymm6, %ymm0
               	vfmadd231ps	-0x40(%rbp), %xmm15, %xmm0 # xmm0 = (xmm15 * mem) + xmm0
               	movups	%xmm0, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	-0x20(%rbp), %ymm15
               	vmovaps	%ymm6, %ymm0
               	vfnmsub231ps	-0x40(%rbp), %xmm15, %xmm0 # xmm0 = -(xmm15 * mem) - xmm0
               	movups	%xmm0, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	-0x20(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	movups	-0x40(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	vpermilps	$0x0, %xmm6, %xmm2 # xmm2 = xmm6[0,0,0,0]
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	vmovd	%xmm0, %r11d
               	movups	-0x20(%rbp), %xmm0
               	vpinsrd	$0x0, %r11d, %xmm0, %xmm0
               	movups	%xmm0, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	-0x20(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	movups	-0x40(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	vpermilps	$0x0, %xmm6, %xmm2 # xmm2 = xmm6[0,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	vmovd	%xmm0, %r11d
               	movups	-0x20(%rbp), %xmm0
               	vpinsrd	$0x0, %r11d, %xmm0, %xmm0
               	movups	%xmm0, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	vmovups	%ymm3, -0xe0(%rbp)
               	vmovups	%ymm4, -0x100(%rbp)
               	vmovups	%ymm5, -0x120(%rbp)
               	vzeroupper
               	callq	<addr>
               	vmovups	-0xe0(%rbp), %ymm3
               	vmovups	-0x100(%rbp), %ymm4
               	vmovups	-0x120(%rbp), %ymm5
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	-0x8(%rbp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	vmovups	%ymm3, -0xe0(%rbp)
               	vmovups	%ymm4, -0x100(%rbp)
               	vmovups	%ymm5, -0x120(%rbp)
               	vzeroupper
               	callq	<addr>
               	vmovups	-0xe0(%rbp), %ymm3
               	vmovups	-0x100(%rbp), %ymm4
               	vmovups	-0x120(%rbp), %ymm5
               	vmovaps	%ymm5, %ymm0
               	vfmadd231pd	%ymm4, %ymm3, %ymm0 # ymm0 = (ymm3 * ymm4) + ymm0
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
               	vmovaps	%ymm5, %ymm0
               	vfmsub231pd	%ymm4, %ymm3, %ymm0 # ymm0 = (ymm3 * ymm4) - ymm0
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
               	vmovaps	%ymm5, %ymm0
               	vfnmadd231pd	%ymm4, %ymm3, %ymm0 # ymm0 = -(ymm3 * ymm4) + ymm0
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
               	vmovaps	%ymm5, %ymm0
               	vfnmsub231pd	%ymm4, %ymm3, %ymm0 # ymm0 = -(ymm3 * ymm4) - ymm0
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
               	vmovaps	%ymm5, %ymm0
               	vfmaddsub231pd	%ymm4, %ymm3, %ymm0 # ymm0 = (ymm3 * ymm4) +/- ymm0
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
               	vmovaps	%ymm5, %ymm0
               	vfmsubadd231pd	%ymm4, %ymm3, %ymm0 # ymm0 = (ymm3 * ymm4) -/+ ymm0
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
               	vmovups	-0x30(%rbp), %ymm15
               	vmovups	-0x60(%rbp), %ymm0
               	vfmadd231pd	-0x50(%rbp), %xmm15, %xmm0 # xmm0 = (xmm15 * mem) + xmm0
               	movups	%xmm0, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	-0x30(%rbp), %ymm15
               	vmovups	-0x60(%rbp), %ymm0
               	vfnmadd231pd	-0x50(%rbp), %xmm15, %xmm0 # xmm0 = -(xmm15 * mem) + xmm0
               	movups	%xmm0, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	-0x30(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movups	-0x50(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	movups	-0x60(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm2 # xmm2 = xmm14[0,0]
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	vmovq	%xmm0, %r11
               	movups	-0x30(%rbp), %xmm0
               	vpinsrq	$0x0, %r11, %xmm0, %xmm0
               	movups	%xmm0, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	-0x30(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movups	-0x50(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	movups	-0x60(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm2 # xmm2 = xmm14[0,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	vmovq	%xmm0, %r11
               	movups	-0x30(%rbp), %xmm0
               	vpinsrq	$0x0, %r11, %xmm0, %xmm0
               	movups	%xmm0, (%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	-0x8(%rbp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx # <addr>
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
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
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx # <addr>
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
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
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	%xmm0, (%rsp)
               	movsd	%xmm0, 0x8(%rsp)
               	movsd	%xmm0, 0x10(%rsp)
               	movsd	%xmm0, 0x18(%rsp)
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
               	movups	-0x20(%rbp), %xmm15
               	vmovdqa	%xmm15, %xmm0
               	movups	-0x40(%rbp), %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
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
               	movups	-0x30(%rbp), %xmm15
               	vmovdqa	%xmm15, %xmm0
               	movups	-0x50(%rbp), %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
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
               	vzeroupper
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x140, %rsp            # imm = 0x140
               	andq	$-0x20, %rsp
               	movabsq	$-0x340d631b7bdddcdb, %rax # imm = 0xCBF29CE484222325
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	xorl	%r15d, %r15d
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%r15,4), %edi
               	vzeroupper
               	callq	<addr>
               	xorl	%ebx, %ebx
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm14
               	movups	%xmm14, -0x10(%rbp)
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm14
               	movups	%xmm14, -0x20(%rbp)
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x10(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x10(%rbp)
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x20(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x20(%rbp)
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x10(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x10(%rbp)
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x20(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x20(%rbp)
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x10(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovdqa	%xmm0, %xmm14
               	vmovups	%ymm14, -0x40(%rbp)
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x20(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovdqa	%xmm0, %xmm14
               	vmovups	%ymm14, -0x20(%rbp)
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm14
               	movups	%xmm14, -0x50(%rbp)
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm14
               	movups	%xmm14, -0x60(%rbp)
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x50(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x50(%rbp)
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x60(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x60(%rbp)
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x50(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x50(%rbp)
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x60(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x60(%rbp)
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x50(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovups	-0x40(%rbp), %ymm14
               	vinserti128	$0x1, %xmm0, %ymm14, %ymm14
               	vmovups	%ymm14, -0x40(%rbp)
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x60(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovups	-0x20(%rbp), %ymm14
               	vinserti128	$0x1, %xmm0, %ymm14, %ymm14
               	vmovups	%ymm14, -0x20(%rbp)
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	vmovq	%xmm0, %xmm14           # xmm14 = xmm0[0],zero
               	movups	%xmm14, -0x50(%rbp)
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	vmovq	%xmm0, %xmm14           # xmm14 = xmm0[0],zero
               	movups	%xmm14, -0x60(%rbp)
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x50(%rbp), %xmm1
               	vunpcklpd	%xmm0, %xmm1, %xmm0 # xmm0 = xmm1[0],xmm0[0]
               	vmovdqa	%xmm0, %xmm14
               	vmovups	%ymm14, -0x80(%rbp)
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x60(%rbp), %xmm1
               	vunpcklpd	%xmm0, %xmm1, %xmm0 # xmm0 = xmm1[0],xmm0[0]
               	vmovdqa	%xmm0, %xmm14
               	vmovups	%ymm14, -0x60(%rbp)
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	vmovq	%xmm0, %xmm14           # xmm14 = xmm0[0],zero
               	movups	%xmm14, -0x90(%rbp)
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	vmovq	%xmm0, %xmm14           # xmm14 = xmm0[0],zero
               	movups	%xmm14, -0xa0(%rbp)
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x90(%rbp), %xmm1
               	vunpcklpd	%xmm0, %xmm1, %xmm0 # xmm0 = xmm1[0],xmm0[0]
               	vmovups	-0x80(%rbp), %ymm14
               	vinserti128	$0x1, %xmm0, %ymm14, %ymm14
               	vmovups	%ymm14, -0x80(%rbp)
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0xa0(%rbp), %xmm1
               	vunpcklpd	%xmm0, %xmm1, %xmm0 # xmm0 = xmm1[0],xmm0[0]
               	vmovups	-0x60(%rbp), %ymm14
               	vinserti128	$0x1, %xmm0, %ymm14, %ymm0
               	leaq	(%rsp), %r9
               	vmovups	-0x40(%rbp), %ymm14
               	vmovups	%ymm14, (%rsp)
               	leaq	0x20(%rsp), %rax
               	vmovups	-0x20(%rbp), %ymm14
               	vmovups	%ymm14, 0x20(%rsp)
               	leaq	0x40(%rsp), %rcx
               	vmovups	-0x80(%rbp), %ymm14
               	vmovups	%ymm14, 0x40(%rsp)
               	leaq	0x60(%rsp), %rdx
               	vmovups	%ymm0, 0x60(%rsp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movq	%rax, %r10
               	vmovups	(%r10), %ymm1
               	movq	%rcx, %r10
               	vmovups	(%r10), %ymm2
               	movq	%rdx, %r10
               	vmovups	(%r10), %ymm3
               	callq	<addr>
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm14
               	movups	%xmm14, -0x10(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm14
               	movups	%xmm14, -0x20(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm14
               	movups	%xmm14, -0x30(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x10(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x10(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x20(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x20(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x30(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x30(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x10(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x10(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x20(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x20(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x30(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x30(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x10(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovdqa	%xmm0, %xmm14
               	vmovups	%ymm14, -0x50(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x20(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovdqa	%xmm0, %xmm14
               	vmovups	%ymm14, -0x20(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x30(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovdqa	%xmm0, %xmm14
               	vmovups	%ymm14, -0x70(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm14
               	movups	%xmm14, -0x30(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm14
               	movups	%xmm14, -0x80(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm14
               	movups	%xmm14, -0x90(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x30(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x30(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x80(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x80(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x90(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x90(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x30(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x30(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x80(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x80(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x90(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x90(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x30(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovups	-0x50(%rbp), %ymm14
               	vinserti128	$0x1, %xmm0, %ymm14, %ymm14
               	vmovups	%ymm14, -0x40(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x80(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovups	-0x20(%rbp), %ymm14
               	vinserti128	$0x1, %xmm0, %ymm14, %ymm14
               	vmovups	%ymm14, -0x20(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x90(%rbp), %xmm1
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovups	-0x70(%rbp), %ymm14
               	vinserti128	$0x1, %xmm0, %ymm14, %ymm14
               	vmovups	%ymm14, -0x60(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	vmovq	%xmm0, %xmm14           # xmm14 = xmm0[0],zero
               	movups	%xmm14, -0x70(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	vmovq	%xmm0, %xmm14           # xmm14 = xmm0[0],zero
               	movups	%xmm14, -0x80(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	vmovq	%xmm0, %xmm14           # xmm14 = xmm0[0],zero
               	movups	%xmm14, -0x90(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x70(%rbp), %xmm1
               	vunpcklpd	%xmm0, %xmm1, %xmm0 # xmm0 = xmm1[0],xmm0[0]
               	vmovdqa	%xmm0, %xmm14
               	vmovups	%ymm14, -0xb0(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x80(%rbp), %xmm1
               	vunpcklpd	%xmm0, %xmm1, %xmm0 # xmm0 = xmm1[0],xmm0[0]
               	vmovdqa	%xmm0, %xmm14
               	vmovups	%ymm14, -0x80(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x90(%rbp), %xmm1
               	vunpcklpd	%xmm0, %xmm1, %xmm0 # xmm0 = xmm1[0],xmm0[0]
               	vmovdqa	%xmm0, %xmm14
               	vmovups	%ymm14, -0xd0(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	vmovq	%xmm0, %xmm14           # xmm14 = xmm0[0],zero
               	movups	%xmm14, -0x90(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	vmovq	%xmm0, %xmm14           # xmm14 = xmm0[0],zero
               	movups	%xmm14, -0xe0(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	vmovq	%xmm0, %xmm14           # xmm14 = xmm0[0],zero
               	movups	%xmm14, -0xf0(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x90(%rbp), %xmm1
               	vunpcklpd	%xmm0, %xmm1, %xmm0 # xmm0 = xmm1[0],xmm0[0]
               	vmovups	-0xb0(%rbp), %ymm14
               	vinserti128	$0x1, %xmm0, %ymm14, %ymm14
               	vmovups	%ymm14, -0xa0(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0xe0(%rbp), %xmm1
               	vunpcklpd	%xmm0, %xmm1, %xmm0 # xmm0 = xmm1[0],xmm0[0]
               	vmovups	-0x80(%rbp), %ymm14
               	vinserti128	$0x1, %xmm0, %ymm14, %ymm14
               	vmovups	%ymm14, -0x80(%rbp)
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0xf0(%rbp), %xmm1
               	vunpcklpd	%xmm0, %xmm1, %xmm0 # xmm0 = xmm1[0],xmm0[0]
               	vmovups	-0xd0(%rbp), %ymm14
               	vinserti128	$0x1, %xmm0, %ymm14, %ymm0
               	leaq	0x80(%rsp), %r9
               	vmovups	-0x40(%rbp), %ymm14
               	vmovups	%ymm14, 0x80(%rsp)
               	leaq	0xa0(%rsp), %rax
               	vmovups	-0x20(%rbp), %ymm14
               	vmovups	%ymm14, 0xa0(%rsp)
               	leaq	0xc0(%rsp), %rcx
               	vmovups	-0x60(%rbp), %ymm14
               	vmovups	%ymm14, 0xc0(%rsp)
               	leaq	0xe0(%rsp), %rdx
               	vmovups	-0xa0(%rbp), %ymm14
               	vmovups	%ymm14, 0xe0(%rsp)
               	leaq	0x100(%rsp), %rsi
               	vmovups	-0x80(%rbp), %ymm14
               	vmovups	%ymm14, 0x100(%rsp)
               	vmovups	%ymm0, 0x120(%rsp)
               	leaq	0x120(%rsp), %rdi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movq	%rax, %r10
               	vmovups	(%r10), %ymm1
               	movq	%rcx, %r10
               	vmovups	(%r10), %ymm2
               	movq	%rdx, %r10
               	vmovups	(%r10), %ymm3
               	movq	%rsi, %r10
               	vmovups	(%r10), %ymm4
               	movq	%rdi, %r10
               	vmovups	(%r10), %ymm5
               	callq	<addr>
               	incq	%rbx
               	cmpl	$0x96, %ebx
               	jl	<addr>
               	incq	%r15
               	cmpl	$0x4, %r15d
               	jl	<addr>
               	xorl	%edi, %edi
               	vzeroupper
               	callq	<addr>
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$-0x2df3754bb839cc40, %r11 # imm = 0xD20C8AB447C633C0
               	cmpq	%r11, %rcx
               	je	<addr>
               	incq	%rax
               	leaq	-0x120(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x1, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x74ccbd3f6dc406f9, %r11 # imm = 0x74CCBD3F6DC406F9
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x1109575788509c5, %r11 # imm = 0x1109575788509C5
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x3, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x22e32b377fe2c5f9, %r11 # imm = 0x22E32B377FE2C5F9
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x4, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x643ff85c67bfe70e, %r11 # imm = 0x643FF85C67BFE70E
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x5, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x1399ba70a23f6f3f, %r11 # imm = 0x1399BA70A23F6F3F
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x6, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$-0x59fced26f1c647c3, %r11 # imm = 0xA60312D90E39B83D
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x7, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$-0x65ee5915fc0be271, %r11 # imm = 0x9A11A6EA03F41D8F
               	cmpq	%r11, %rcx
               	jne	<addr>
               	xorl	%eax, %eax
               	leaq	-0x120(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
