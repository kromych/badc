
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
               	vmovdqa	%xmm1, %xmm1
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
               	vmovdqa	%xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rax
               	vmovq	%rax, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vmovq	%xmm1, %rax
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vinserti128	$0x1, %xmm0, %ymm2, %ymm0
               	retq

<_mm256_blend_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movl	$0xa5, %ecx
               	vmovups	%ymm0, (%rsp)
               	vmovups	%ymm1, 0x20(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	sarxq	%rax, %rcx, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	movl	0x20(%rsp,%rax,4), %edi
               	movl	%edi, (%rsp,%rax,4)
               	jmp	<addr>
               	vmovups	(%rsp), %ymm0
               	leave
               	retq

<_mm256_blend_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movl	$0x9, %ecx
               	vmovups	%ymm0, (%rsp)
               	vmovups	%ymm1, 0x20(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	sarxq	%rax, %rcx, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	movq	0x20(%rsp,%rax,8), %rdi
               	movq	%rdi, (%rsp,%rax,8)
               	jmp	<addr>
               	vmovups	(%rsp), %ymm0
               	leave
               	retq

<_mm256_blendv_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	vmovups	%ymm0, (%rsp)
               	vmovups	%ymm1, 0x20(%rsp)
               	vmovups	%ymm2, 0x40(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0x40(%rsp,%rax,4), %edi
               	testl	%edi, %edi
               	jge	<addr>
               	movl	0x20(%rsp,%rax,4), %edi
               	movl	%edi, (%rsp,%rax,4)
               	jmp	<addr>
               	vmovups	(%rsp), %ymm0
               	leave
               	retq

<_mm256_blendv_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	vmovups	%ymm0, (%rsp)
               	vmovups	%ymm1, 0x20(%rsp)
               	vmovups	%ymm2, 0x40(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x40(%rsp,%rax,8), %rdi
               	testq	%rdi, %rdi
               	jge	<addr>
               	movq	0x20(%rsp,%rax,8), %rdi
               	movq	%rdi, (%rsp,%rax,8)
               	jmp	<addr>
               	vmovups	(%rsp), %ymm0
               	leave
               	retq

<__badc_cmp_holds>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	ucomisd	%xmm1, %xmm0
               	setp	%al
               	movzbq	%al, %rax
               	ucomisd	%xmm0, %xmm1
               	seta	%cl
               	movzbq	%cl, %rcx
               	ucomisd	%xmm1, %xmm0
               	sete	%dl
               	movzbq	%dl, %rdx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rdx
               	movq	%rdi, %rsi
               	andq	$0x3, %rsi
               	movl	$0x1, %r8d
               	cmpl	$0x2, %esi
               	sete	%r9b
               	movzbq	%r9b, %r9
               	cmpl	$0x1, %esi
               	cmoveq	%r8, %r9
               	movq	%rdi, %rsi
               	sarq	$0x4, %rsi
               	andq	$0x1, %rsi
               	xorq	%r9, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	comisd	%xmm0, %xmm1
               	seta	%sil
               	movzbq	%sil, %rsi
               	movl	%esi, -0x8(%rbp)
               	movl	-0x8(%rbp), %esi
               	andq	$0xf, %rdi
               	cmpl	$0xf, %edi
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdi,8), %r10
               	jmpq	*%r10
               	movq	%rdx, %rax
               	leave
               	retq
               	movq	%rcx, %rax
               	leave
               	retq
               	movl	$0x1, %eax
               	testl	%ecx, %ecx
               	cmoveq	%rdx, %rax
               	leave
               	retq
               	leave
               	retq
               	testl	%edx, %edx
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq
               	testl	%ecx, %ecx
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq
               	movl	$0x1, %eax
               	testl	%ecx, %ecx
               	cmoveq	%rdx, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq
               	movl	$0x1, %ecx
               	testl	%edx, %edx
               	cmovneq	%rcx, %rax
               	leave
               	retq
               	movl	$0x1, %edx
               	testl	%ecx, %ecx
               	cmovneq	%rdx, %rax
               	leave
               	retq
               	movl	$0x1, %esi
               	movslq	%edx, %rdx
               	testl	%ecx, %ecx
               	cmovneq	%rsi, %rdx
               	testq	%rdx, %rdx
               	cmovneq	%rsi, %rax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	xorl	%ecx, %ecx
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%edx, %edx
               	cmovneq	%rcx, %rax
               	leave
               	retq
               	xorl	%edx, %edx
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%ecx, %ecx
               	cmovneq	%rdx, %rax
               	leave
               	retq
               	xorl	%esi, %esi
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%ecx, %ecx
               	cmovneq	%rsi, %rdx
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rdx, %rdx
               	cmoveq	%rsi, %rax
               	leave
               	retq
               	movq	%r8, %rax
               	leave
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
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x950, %rsp            # imm = 0x950
               	subq	$0xd60, %rsp            # imm = 0xD60
               	andq	$-0x20, %rsp
               	vmovups	%ymm0, (%rsp)
               	vmovups	%ymm1, 0x20(%rsp)
               	vmovups	%ymm2, 0x40(%rsp)
               	vmovups	%ymm3, 0x60(%rsp)
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	vaddps	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vaddps	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x80(%rsp,%rax), %rdi
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
               	vsubps	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vsubps	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x80(%rsp,%rax), %rdi
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
               	vmulps	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vmulps	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x80(%rsp,%rax), %rdi
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
               	vdivps	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vdivps	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x80(%rsp,%rax), %rdi
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
               	vminps	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vminps	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x80(%rsp,%rax), %rdi
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
               	vmaxps	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vmaxps	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x80(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	sqrtps	%xmm1, %xmm1
               	vextracti128	$0x1, %ymm0, %xmm0
               	sqrtps	%xmm0, %xmm0
               	vmovdqa	%xmm1, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x80(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm2
               	vmovups	0x20(%rsp), %ymm3
               	vmovdqa	%xmm2, %xmm0
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
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x80(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm2
               	vmovups	0x20(%rsp), %ymm3
               	vmovdqa	%xmm2, %xmm0
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
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x80(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm2
               	vmovups	0x20(%rsp), %ymm3
               	vmovdqa	%xmm2, %xmm0
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
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x80(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0x14b8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	-0x14b8(%rbp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	vaddpd	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vaddpd	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x80(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	vsubpd	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vsubpd	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x80(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	vmulpd	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vmulpd	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x80(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	vdivpd	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vdivpd	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x80(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	vminpd	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vminpd	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x80(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	vmaxpd	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vmaxpd	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x80(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	sqrtpd	%xmm1, %xmm1
               	vextracti128	$0x1, %ymm0, %xmm0
               	sqrtpd	%xmm0, %xmm0
               	vmovdqa	%xmm1, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x80(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
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
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x80(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
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
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x80(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
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
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x80(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0x14b8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	-0x14b8(%rbp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpeqps	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x80(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmpeqpd	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x80(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	xorl	%edi, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x14e0(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x14e0(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	movups	%xmm0, 0x920(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x920(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	xorl	%edi, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x14f0(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x14f0(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	movups	%xmm0, 0x930(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x930(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0x1420(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	-0x1420(%rbp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpltps	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0xa0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0xa0(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmpltpd	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0xc0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0xc0(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0x1, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x1500(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1500(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	movups	%xmm0, 0x940(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x940(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0x1, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x1510(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1510(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	movups	%xmm0, 0x950(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x950(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0x1388(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	-0x1388(%rbp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpleps	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0xe0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0xe0(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmplepd	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x100(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0x2, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x1520(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1520(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	movups	%xmm0, 0x960(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x960(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0x2, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x1530(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1530(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	movups	%xmm0, 0x970(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x970(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0x12f0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	-0x12f0(%rbp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpunordps	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x120(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x120(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmpunordpd	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x140(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x140(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0x3, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x1540(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1540(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	movups	%xmm0, 0x980(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x980(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0x3, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x1550(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1550(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	movups	%xmm0, 0x990(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x990(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0x1258(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	-0x1258(%rbp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpneqps	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x160(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x160(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmpneqpd	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x180(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x180(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0x4, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x1560(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1560(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	movups	%xmm0, 0x9a0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x9a0(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0x4, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x1570(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1570(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	movups	%xmm0, 0x9b0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x9b0(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0x11c0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	-0x11c0(%rbp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpnltps	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x1a0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x1a0(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmpnltpd	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x1c0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x1c0(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0x5, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x1580(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1580(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	movups	%xmm0, 0x9c0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x9c0(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0x5, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x1590(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1590(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	movups	%xmm0, 0x9d0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	0x9d0(%rsp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0x1128(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	-0x1128(%rbp,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpnleps	%ymm1, %ymm0, %ymm0
               	leaq	0x1e0(%rsp), %rsi
               	vmovups	%ymm0, 0x1e0(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmpnlepd	%ymm1, %ymm0, %ymm0
               	leaq	0x200(%rsp), %rsi
               	vmovups	%ymm0, 0x200(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0x6, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x15a0(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x15a0(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x9e0(%rsp), %rsi
               	movups	%xmm0, 0x9e0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0x6, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x15b0(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x15b0(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x9f0(%rsp), %rsi
               	movups	%xmm0, 0x9f0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0x1090(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1090(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpordps	%ymm1, %ymm0, %ymm0
               	leaq	0x220(%rsp), %rsi
               	vmovups	%ymm0, 0x220(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmpordpd	%ymm1, %ymm0, %ymm0
               	leaq	0x240(%rsp), %rsi
               	vmovups	%ymm0, 0x240(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0x7, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x15c0(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x15c0(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0xa00(%rsp), %rsi
               	movups	%xmm0, 0xa00(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0x7, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x15d0(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x15d0(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0xa10(%rsp), %rsi
               	movups	%xmm0, 0xa10(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0xff8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xff8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpeq_uqps	%ymm1, %ymm0, %ymm0
               	leaq	0x260(%rsp), %rsi
               	vmovups	%ymm0, 0x260(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmpeq_uqpd	%ymm1, %ymm0, %ymm0
               	leaq	0x280(%rsp), %rsi
               	vmovups	%ymm0, 0x280(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0x8, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x15e0(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x15e0(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0xa20(%rsp), %rsi
               	movups	%xmm0, 0xa20(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0x8, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x15f0(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x15f0(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0xa30(%rsp), %rsi
               	movups	%xmm0, 0xa30(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0xf60(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xf60(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpngeps	%ymm1, %ymm0, %ymm0
               	leaq	0x2a0(%rsp), %rsi
               	vmovups	%ymm0, 0x2a0(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmpngepd	%ymm1, %ymm0, %ymm0
               	leaq	0x2c0(%rsp), %rsi
               	vmovups	%ymm0, 0x2c0(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0x9, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x1600(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1600(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0xa40(%rsp), %rsi
               	movups	%xmm0, 0xa40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0x9, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x1610(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1610(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0xa50(%rsp), %rsi
               	movups	%xmm0, 0xa50(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0xec8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xec8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpngtps	%ymm1, %ymm0, %ymm0
               	leaq	0x2e0(%rsp), %rsi
               	vmovups	%ymm0, 0x2e0(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmpngtpd	%ymm1, %ymm0, %ymm0
               	leaq	0x300(%rsp), %rsi
               	vmovups	%ymm0, 0x300(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0xa, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x1620(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1620(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0xa60(%rsp), %rsi
               	movups	%xmm0, 0xa60(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0xa, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x1630(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1630(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0xa70(%rsp), %rsi
               	movups	%xmm0, 0xa70(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0xe30(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xe30(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpfalseps	%ymm1, %ymm0, %ymm0
               	leaq	0x320(%rsp), %rsi
               	vmovups	%ymm0, 0x320(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmpfalsepd	%ymm1, %ymm0, %ymm0
               	leaq	0x340(%rsp), %rsi
               	vmovups	%ymm0, 0x340(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0xb, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x1640(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1640(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0xa80(%rsp), %rsi
               	movups	%xmm0, 0xa80(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0xb, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x1650(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1650(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0xa90(%rsp), %rsi
               	movups	%xmm0, 0xa90(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0xd98(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xd98(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpneq_oqps	%ymm1, %ymm0, %ymm0
               	leaq	0x360(%rsp), %rsi
               	vmovups	%ymm0, 0x360(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmpneq_oqpd	%ymm1, %ymm0, %ymm0
               	leaq	0x380(%rsp), %rsi
               	vmovups	%ymm0, 0x380(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0xc, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x1660(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1660(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0xaa0(%rsp), %rsi
               	movups	%xmm0, 0xaa0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0xc, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x1670(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1670(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0xab0(%rsp), %rsi
               	movups	%xmm0, 0xab0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0xd00(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xd00(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpgeps	%ymm1, %ymm0, %ymm0
               	leaq	0x3a0(%rsp), %rsi
               	vmovups	%ymm0, 0x3a0(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmpgepd	%ymm1, %ymm0, %ymm0
               	leaq	0x3c0(%rsp), %rsi
               	vmovups	%ymm0, 0x3c0(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0xd, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x1680(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1680(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0xac0(%rsp), %rsi
               	movups	%xmm0, 0xac0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0xd, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x1690(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1690(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0xad0(%rsp), %rsi
               	movups	%xmm0, 0xad0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0xc68(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xc68(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpgtps	%ymm1, %ymm0, %ymm0
               	leaq	0x3e0(%rsp), %rsi
               	vmovups	%ymm0, 0x3e0(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmpgtpd	%ymm1, %ymm0, %ymm0
               	leaq	0x400(%rsp), %rsi
               	vmovups	%ymm0, 0x400(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0xe, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x16a0(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x16a0(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0xae0(%rsp), %rsi
               	movups	%xmm0, 0xae0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0xe, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x16b0(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x16b0(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0xaf0(%rsp), %rsi
               	movups	%xmm0, 0xaf0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0xbd0(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xbd0(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmptrueps	%ymm1, %ymm0, %ymm0
               	leaq	0x420(%rsp), %rsi
               	vmovups	%ymm0, 0x420(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmptruepd	%ymm1, %ymm0, %ymm0
               	leaq	0x440(%rsp), %rsi
               	vmovups	%ymm0, 0x440(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0xf, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x16c0(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x16c0(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0xb00(%rsp), %rsi
               	movups	%xmm0, 0xb00(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0xf, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x16d0(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x16d0(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0xb10(%rsp), %rsi
               	movups	%xmm0, 0xb10(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0xb38(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xb38(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpeq_osps	%ymm1, %ymm0, %ymm0
               	leaq	0x460(%rsp), %rsi
               	vmovups	%ymm0, 0x460(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmpeq_ospd	%ymm1, %ymm0, %ymm0
               	leaq	0x480(%rsp), %rsi
               	vmovups	%ymm0, 0x480(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0x10, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x16e0(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x16e0(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0xb20(%rsp), %rsi
               	movups	%xmm0, 0xb20(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0x10, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x16f0(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x16f0(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0xb30(%rsp), %rsi
               	movups	%xmm0, 0xb30(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0xaa0(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xaa0(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmplt_oqps	%ymm1, %ymm0, %ymm0
               	leaq	0x4a0(%rsp), %rsi
               	vmovups	%ymm0, 0x4a0(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmplt_oqpd	%ymm1, %ymm0, %ymm0
               	leaq	0x4c0(%rsp), %rsi
               	vmovups	%ymm0, 0x4c0(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0x11, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x1700(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1700(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0xb40(%rsp), %rsi
               	movups	%xmm0, 0xb40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0x11, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x1710(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1710(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0xb50(%rsp), %rsi
               	movups	%xmm0, 0xb50(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0xa08(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xa08(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmple_oqps	%ymm1, %ymm0, %ymm0
               	leaq	0x4e0(%rsp), %rsi
               	vmovups	%ymm0, 0x4e0(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmple_oqpd	%ymm1, %ymm0, %ymm0
               	leaq	0x500(%rsp), %rsi
               	vmovups	%ymm0, 0x500(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0x12, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x1720(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1720(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0xb60(%rsp), %rsi
               	movups	%xmm0, 0xb60(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0x12, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x1730(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1730(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0xb70(%rsp), %rsi
               	movups	%xmm0, 0xb70(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0x970(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x970(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpunord_sps	%ymm1, %ymm0, %ymm0
               	leaq	0x520(%rsp), %rsi
               	vmovups	%ymm0, 0x520(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmpunord_spd	%ymm1, %ymm0, %ymm0
               	leaq	0x540(%rsp), %rsi
               	vmovups	%ymm0, 0x540(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0x13, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x1740(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1740(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0xb80(%rsp), %rsi
               	movups	%xmm0, 0xb80(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0x13, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x1750(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1750(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0xb90(%rsp), %rsi
               	movups	%xmm0, 0xb90(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0x8d8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x8d8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpneq_usps	%ymm1, %ymm0, %ymm0
               	leaq	0x560(%rsp), %rsi
               	vmovups	%ymm0, 0x560(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmpneq_uspd	%ymm1, %ymm0, %ymm0
               	leaq	0x580(%rsp), %rsi
               	vmovups	%ymm0, 0x580(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0x14, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x1760(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1760(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0xba0(%rsp), %rsi
               	movups	%xmm0, 0xba0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0x14, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x1770(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1770(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0xbb0(%rsp), %rsi
               	movups	%xmm0, 0xbb0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0x840(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x840(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpnlt_uqps	%ymm1, %ymm0, %ymm0
               	leaq	0x5a0(%rsp), %rsi
               	vmovups	%ymm0, 0x5a0(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmpnlt_uqpd	%ymm1, %ymm0, %ymm0
               	leaq	0x5c0(%rsp), %rsi
               	vmovups	%ymm0, 0x5c0(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0x15, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x1780(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1780(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0xbc0(%rsp), %rsi
               	movups	%xmm0, 0xbc0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0x15, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x1790(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1790(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0xbd0(%rsp), %rsi
               	movups	%xmm0, 0xbd0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0x7a8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x7a8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpnle_uqps	%ymm1, %ymm0, %ymm0
               	leaq	0x5e0(%rsp), %rsi
               	vmovups	%ymm0, 0x5e0(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmpnle_uqpd	%ymm1, %ymm0, %ymm0
               	leaq	0x600(%rsp), %rsi
               	vmovups	%ymm0, 0x600(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0x16, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x17a0(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x17a0(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0xbe0(%rsp), %rsi
               	movups	%xmm0, 0xbe0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0x16, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x17b0(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x17b0(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0xbf0(%rsp), %rsi
               	movups	%xmm0, 0xbf0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0x710(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x710(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpord_sps	%ymm1, %ymm0, %ymm0
               	leaq	0x620(%rsp), %rsi
               	vmovups	%ymm0, 0x620(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmpord_spd	%ymm1, %ymm0, %ymm0
               	leaq	0x640(%rsp), %rsi
               	vmovups	%ymm0, 0x640(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0x17, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x17c0(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x17c0(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0xc00(%rsp), %rsi
               	movups	%xmm0, 0xc00(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0x17, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x17d0(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x17d0(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0xc10(%rsp), %rsi
               	movups	%xmm0, 0xc10(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0x678(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x678(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpeq_usps	%ymm1, %ymm0, %ymm0
               	leaq	0x660(%rsp), %rsi
               	vmovups	%ymm0, 0x660(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmpeq_uspd	%ymm1, %ymm0, %ymm0
               	leaq	0x680(%rsp), %rsi
               	vmovups	%ymm0, 0x680(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0x18, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x17e0(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x17e0(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0xc20(%rsp), %rsi
               	movups	%xmm0, 0xc20(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0x18, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x17f0(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x17f0(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0xc30(%rsp), %rsi
               	movups	%xmm0, 0xc30(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0x5e0(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x5e0(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpnge_uqps	%ymm1, %ymm0, %ymm0
               	leaq	0x6a0(%rsp), %rsi
               	vmovups	%ymm0, 0x6a0(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmpnge_uqpd	%ymm1, %ymm0, %ymm0
               	leaq	0x6c0(%rsp), %rsi
               	vmovups	%ymm0, 0x6c0(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0x19, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x1800(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1800(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0xc40(%rsp), %rsi
               	movups	%xmm0, 0xc40(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0x19, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x1810(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1810(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0xc50(%rsp), %rsi
               	movups	%xmm0, 0xc50(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0x548(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x548(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpngt_uqps	%ymm1, %ymm0, %ymm0
               	leaq	0x6e0(%rsp), %rsi
               	vmovups	%ymm0, 0x6e0(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmpngt_uqpd	%ymm1, %ymm0, %ymm0
               	leaq	0x700(%rsp), %rsi
               	vmovups	%ymm0, 0x700(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0x1a, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x1820(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1820(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0xc60(%rsp), %rsi
               	movups	%xmm0, 0xc60(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0x1a, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x1830(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1830(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0xc70(%rsp), %rsi
               	movups	%xmm0, 0xc70(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0x4b0(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x4b0(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpfalse_osps	%ymm1, %ymm0, %ymm0
               	leaq	0x720(%rsp), %rsi
               	vmovups	%ymm0, 0x720(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmpfalse_ospd	%ymm1, %ymm0, %ymm0
               	leaq	0x740(%rsp), %rsi
               	vmovups	%ymm0, 0x740(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0x1b, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x1840(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1840(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0xc80(%rsp), %rsi
               	movups	%xmm0, 0xc80(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0x1b, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x1850(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1850(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0xc90(%rsp), %rsi
               	movups	%xmm0, 0xc90(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0x418(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x418(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpneq_osps	%ymm1, %ymm0, %ymm0
               	leaq	0x760(%rsp), %rsi
               	vmovups	%ymm0, 0x760(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmpneq_ospd	%ymm1, %ymm0, %ymm0
               	leaq	0x780(%rsp), %rsi
               	vmovups	%ymm0, 0x780(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0x1c, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x1860(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1860(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0xca0(%rsp), %rsi
               	movups	%xmm0, 0xca0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0x1c, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x1870(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1870(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0xcb0(%rsp), %rsi
               	movups	%xmm0, 0xcb0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0x380(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x380(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpge_oqps	%ymm1, %ymm0, %ymm0
               	leaq	0x7a0(%rsp), %rsi
               	vmovups	%ymm0, 0x7a0(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmpge_oqpd	%ymm1, %ymm0, %ymm0
               	leaq	0x7c0(%rsp), %rsi
               	vmovups	%ymm0, 0x7c0(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0x1d, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x1880(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1880(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0xcc0(%rsp), %rsi
               	movups	%xmm0, 0xcc0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0x1d, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x1890(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x1890(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0xcd0(%rsp), %rsi
               	movups	%xmm0, 0xcd0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0x2e8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x2e8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmpgt_oqps	%ymm1, %ymm0, %ymm0
               	leaq	0x7e0(%rsp), %rsi
               	vmovups	%ymm0, 0x7e0(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmpgt_oqpd	%ymm1, %ymm0, %ymm0
               	leaq	0x800(%rsp), %rsi
               	vmovups	%ymm0, 0x800(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0x1e, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x18a0(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x18a0(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0xce0(%rsp), %rsi
               	movups	%xmm0, 0xce0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0x1e, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x18b0(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x18b0(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0xcf0(%rsp), %rsi
               	movups	%xmm0, 0xcf0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0x250(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x250(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vcmptrue_usps	%ymm1, %ymm0, %ymm0
               	leaq	0x820(%rsp), %rsi
               	vmovups	%ymm0, 0x820(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vcmptrue_uspd	%ymm1, %ymm0, %ymm0
               	leaq	0x840(%rsp), %rsi
               	vmovups	%ymm0, 0x840(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	movl	$0x1f, %edi
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm2, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movups	%xmm0, -0x18c0(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x18c0(%rbp), %xmm0
               	negq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0xd00(%rsp), %rsi
               	movups	%xmm0, 0xd00(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	movl	$0x1f, %edi
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movups	%xmm0, -0x18d0(%rbp)
               	movapd	%xmm2, %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	-0x18d0(%rbp), %xmm0
               	movslq	%eax, %rax
               	negq	%rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0xd10(%rsp), %rsi
               	movups	%xmm0, 0xd10(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vextracti128	$0x1, %ymm0, %xmm1
               	cvtps2dq	%xmm1, %xmm1
               	cvtps2dq	%xmm0, %xmm0
               	vmovdqa	%xmm0, %xmm0
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	leaq	0x860(%rsp), %rsi
               	vmovups	%ymm0, 0x860(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vextracti128	$0x1, %ymm0, %xmm1
               	cvttps2dq	%xmm1, %xmm1
               	cvttps2dq	%xmm0, %xmm0
               	vmovdqa	%xmm0, %xmm0
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x20(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	cvtdq2ps	%xmm1, %xmm1
               	vextracti128	$0x1, %ymm0, %xmm0
               	cvtdq2ps	%xmm0, %xmm0
               	vmovdqa	%xmm1, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x880(%rsp), %rsi
               	vmovups	%ymm0, 0x880(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
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
               	leaq	0xd20(%rsp), %rsi
               	movups	%xmm0, 0xd20(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
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
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	cvtpd2dq	%xmm1, %xmm1
               	vextracti128	$0x1, %ymm0, %xmm0
               	cvtpd2dq	%xmm0, %xmm0
               	vpunpcklqdq	%xmm0, %xmm1, %xmm0 # xmm0 = xmm1[0],xmm0[0]
               	leaq	0xd30(%rsp), %rsi
               	movups	%xmm0, 0xd30(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	cvttpd2dq	%xmm1, %xmm1
               	vextracti128	$0x1, %ymm0, %xmm0
               	cvttpd2dq	%xmm0, %xmm0
               	vpunpcklqdq	%xmm0, %xmm1, %xmm0 # xmm0 = xmm1[0],xmm0[0]
               	leaq	0x80(%rsp), %rsi
               	movups	%xmm0, 0x80(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x60(%rsp), %ymm0
               	cvtdq2pd	%xmm0, %xmm1
               	pshufd	$0xe, %xmm0, %xmm0      # xmm0 = xmm0[2,3,0,0]
               	cvtdq2pd	%xmm0, %xmm0
               	vmovdqa	%xmm1, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
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
               	movl	%eax, -0x14b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x14b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	vandps	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vandps	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x8a0(%rsp), %rsi
               	vmovups	%ymm0, 0x8a0(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
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
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	vorps	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vorps	%xmm1, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	vpxor	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vpxor	%xmm1, %xmm0, %xmm0
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
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	vmovd	%xmm2, %eax
               	movslq	%eax, %rax
               	vmovd	%eax, %xmm4
               	vmovd	%xmm3, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x1, %eax, %xmm4, %xmm4
               	vpextrd	$0x1, %xmm2, %eax
               	movslq	%eax, %rax
               	movapd	%xmm4, %xmm2
               	vpinsrd	$0x2, %eax, %xmm2, %xmm2
               	vpextrd	$0x1, %xmm3, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x3, %eax, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vmovd	%eax, %xmm3
               	vmovd	%xmm1, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x1, %eax, %xmm3, %xmm3
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	movapd	%xmm3, %xmm0
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	vpextrd	$0x1, %xmm1, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
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
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vmovups	0x20(%rsp), %ymm2
               	movl	$0x9c, %edi
               	vmovdqa	%xmm1, %xmm0
               	leaq	0xd40(%rsp), %r9
               	movups	%xmm0, 0xd40(%rsp)
               	vmovdqa	%xmm2, %xmm0
               	leaq	0x80(%rsp), %rax
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	%ymm1, -0x18f0(%rbp)
               	vmovups	%ymm2, -0x1910(%rbp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x18f0(%rbp), %ymm1
               	vmovups	-0x1910(%rbp), %ymm2
               	movups	%xmm0, -0x14d0(%rbp)
               	leaq	0xd40(%rsp), %r9
               	vextracti128	$0x1, %ymm1, %xmm0
               	movups	%xmm0, 0xd40(%rsp)
               	leaq	0x80(%rsp), %rax
               	vextracti128	$0x1, %ymm2, %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	movl	$0x9c, %edi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	vzeroupper
               	callq	<addr>
               	movups	-0x14d0(%rbp), %xmm15
               	vmovdqa	%xmm15, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x6, %edi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movq	%rax, %r10
               	vmovups	(%r10), %ymm1
               	callq	<addr>
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	movl	$0x1b, %edi
               	vmovdqa	%xmm1, %xmm0
               	leaq	0xd40(%rsp), %r9
               	movups	%xmm0, 0xd40(%rsp)
               	vmovdqa	%xmm1, %xmm0
               	leaq	0x80(%rsp), %rax
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	%ymm1, -0x1930(%rbp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1930(%rbp), %ymm1
               	movups	%xmm0, -0x14d0(%rbp)
               	leaq	0xd40(%rsp), %r9
               	vextracti128	$0x1, %ymm1, %xmm0
               	movups	%xmm0, 0xd40(%rsp)
               	leaq	0x80(%rsp), %rax
               	vextracti128	$0x1, %ymm1, %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	movl	$0x1b, %edi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	vzeroupper
               	callq	<addr>
               	movups	-0x14d0(%rbp), %xmm15
               	vmovdqa	%xmm15, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	movl	$0x5, %edi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vperm2i128	$0x21, %ymm1, %ymm0, %ymm0 # ymm0 = ymm0[2,3],ymm1[0,1]
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vperm2i128	$0x30, %ymm1, %ymm0, %ymm0 # ymm0 = ymm0[0,1],ymm1[2,3]
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0xa5, %edi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movq	%rax, %r10
               	vmovups	(%r10), %ymm1
               	callq	<addr>
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x9, %edi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movq	%rax, %r10
               	vmovups	(%r10), %ymm1
               	callq	<addr>
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movq	%rax, %r10
               	vmovups	(%r10), %ymm1
               	movq	%rcx, %r10
               	vmovups	(%r10), %ymm2
               	callq	<addr>
               	leaq	0x8c0(%rsp), %rsi
               	vmovups	%ymm0, 0x8c0(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	vmovups	(%rsp), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movq	%rax, %r10
               	vmovups	(%r10), %ymm1
               	movq	%rcx, %r10
               	vmovups	(%r10), %ymm2
               	callq	<addr>
               	leaq	0x8e0(%rsp), %rsi
               	vmovups	%ymm0, 0x8e0(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
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
               	movl	%eax, -0x14b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x14b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
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
               	movl	%eax, -0x14b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x14b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
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
               	leaq	0x900(%rsp), %rsi
               	vmovups	%ymm0, 0x900(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x20(%rsp), %ymm1
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
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	vpermilpd	$0x0, %xmm1, %xmm2 # xmm2 = xmm1[0,0]
               	vunpcklpd	%xmm1, %xmm2, %xmm1 # xmm1 = xmm2[0],xmm1[0]
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	vunpcklpd	%xmm0, %xmm2, %xmm0 # xmm0 = xmm2[0],xmm0[0]
               	vmovdqa	%xmm1, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vextracti128	$0x1, %ymm0, %xmm0
               	leaq	0x80(%rsp), %rsi
               	movups	%xmm0, 0x80(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x60(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vpextrd	$0x3, %xmm0, %eax
               	movslq	%eax, %rax
               	movl	%eax, 0x80(%rsp)
               	movl	%eax, 0x84(%rsp)
               	movl	%eax, 0x88(%rsp)
               	movl	%eax, 0x8c(%rsp)
               	movl	%eax, 0x90(%rsp)
               	movl	%eax, 0x94(%rsp)
               	movl	%eax, 0x98(%rsp)
               	leaq	0x80(%rsp), %rcx
               	movl	%eax, 0x9c(%rsp)
               	leaq	0x60(%rsp), %rsi
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vmovups	%ymm0, -0x1950(%rbp)
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x1950(%rbp), %ymm0
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movss	0x20(%rsp), %xmm0
               	movss	%xmm0, -0x14b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x14b8(%rbp), %rsi
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
               	subq	$0x150, %rsp            # imm = 0x150
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	vmovdqa	%xmm0, %xmm7
               	vmovdqa	%xmm1, %xmm8
               	vmovdqa	%xmm2, %xmm9
               	vmovdqa	%xmm3, %xmm12
               	vmovdqa	%xmm4, %xmm14
               	movups	%xmm14, -0x20(%rbp)
               	vmovdqa	%xmm5, %xmm14
               	movups	%xmm14, -0x30(%rbp)
               	movl	$0x3d, %edi
               	vmovups	%ymm0, -0x68(%rbp)
               	vmovups	%ymm1, -0x88(%rbp)
               	vmovups	%ymm2, -0xa8(%rbp)
               	vmovups	%ymm3, -0xc8(%rbp)
               	vmovups	%ymm4, -0xe8(%rbp)
               	vmovups	%ymm5, -0x108(%rbp)
               	movups	%xmm7, -0x118(%rbp)
               	movups	%xmm8, -0x128(%rbp)
               	movups	%xmm9, -0x138(%rbp)
               	movups	%xmm12, -0x148(%rbp)
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x68(%rbp), %ymm0
               	vmovups	-0x88(%rbp), %ymm1
               	vmovups	-0xa8(%rbp), %ymm2
               	vmovups	-0xc8(%rbp), %ymm3
               	vmovups	-0xe8(%rbp), %ymm4
               	vmovups	-0x108(%rbp), %ymm5
               	movups	-0x118(%rbp), %xmm7
               	movups	-0x128(%rbp), %xmm8
               	movups	-0x138(%rbp), %xmm9
               	movups	-0x148(%rbp), %xmm12
               	vpermilps	$0x0, %xmm0, %xmm6 # xmm6 = xmm0[0,0,0,0]
               	vpermilps	$0x0, %xmm1, %xmm10 # xmm10 = xmm1[0,0,0,0]
               	vpermilps	$0x0, %xmm2, %xmm11 # xmm11 = xmm2[0,0,0,0]
               	vfmadd213ss	%xmm11, %xmm10, %xmm6 # xmm6 = (xmm10 * xmm6) + xmm11
               	vmovd	%xmm6, %r11d
               	vmovd	%r11d, %xmm6
               	vpermilps	$0x1, %xmm0, %xmm10 # xmm10 = xmm0[1,0,0,0]
               	vpermilps	$0x1, %xmm1, %xmm11 # xmm11 = xmm1[1,0,0,0]
               	vpermilps	$0x1, %xmm2, %xmm14 # xmm14 = xmm2[1,0,0,0]
               	movsd	%xmm14, -0x38(%rbp)
               	vfmadd213ss	%xmm14, %xmm11, %xmm10 # xmm10 = (xmm11 * xmm10) + xmm14
               	vmovd	%xmm10, %r11d
               	vpinsrd	$0x1, %r11d, %xmm6, %xmm6
               	vpermilps	$0x2, %xmm0, %xmm10 # xmm10 = xmm0[2,0,0,0]
               	vpermilps	$0x2, %xmm1, %xmm11 # xmm11 = xmm1[2,0,0,0]
               	vpermilps	$0x2, %xmm2, %xmm14 # xmm14 = xmm2[2,0,0,0]
               	movsd	%xmm14, -0x38(%rbp)
               	vfmadd213ss	%xmm14, %xmm11, %xmm10 # xmm10 = (xmm11 * xmm10) + xmm14
               	vmovd	%xmm10, %r11d
               	vpinsrd	$0x2, %r11d, %xmm6, %xmm6
               	vpermilps	$0x3, %xmm0, %xmm10 # xmm10 = xmm0[3,0,0,0]
               	vpermilps	$0x3, %xmm1, %xmm11 # xmm11 = xmm1[3,0,0,0]
               	vpermilps	$0x3, %xmm2, %xmm14 # xmm14 = xmm2[3,0,0,0]
               	movsd	%xmm14, -0x38(%rbp)
               	vfmadd213ss	%xmm14, %xmm11, %xmm10 # xmm10 = (xmm11 * xmm10) + xmm14
               	vmovd	%xmm10, %r11d
               	vpinsrd	$0x3, %r11d, %xmm6, %xmm6
               	vmovdqa	%xmm6, %xmm6
               	vextracti128	$0x1, %ymm0, %xmm10
               	vextracti128	$0x1, %ymm1, %xmm11
               	vextracti128	$0x1, %ymm2, %xmm14
               	movups	%xmm14, -0x40(%rbp)
               	vpermilps	$0x0, %xmm14, %xmm14 # xmm14 = xmm14[0,0,0,0]
               	movsd	%xmm14, -0x38(%rbp)
               	vfmadd213ss	%xmm14, %xmm11, %xmm10 # xmm10 = (xmm11 * xmm10) + xmm14
               	vmovd	%xmm10, %r11d
               	vmovd	%r11d, %xmm10
               	vextracti128	$0x1, %ymm0, %xmm11
               	vpermilps	$0x1, %xmm11, %xmm11 # xmm11 = xmm11[1,0,0,0]
               	vextracti128	$0x1, %ymm1, %xmm14
               	movups	%xmm14, -0x40(%rbp)
               	vpermilps	$0x1, %xmm14, %xmm14 # xmm14 = xmm14[1,0,0,0]
               	movsd	%xmm14, -0x38(%rbp)
               	vextracti128	$0x1, %ymm2, %xmm14
               	movups	%xmm14, -0x48(%rbp)
               	vpermilps	$0x1, %xmm14, %xmm14 # xmm14 = xmm14[1,0,0,0]
               	movsd	%xmm14, -0x40(%rbp)
               	vfmadd132ss	-0x38(%rbp), %xmm14, %xmm11 # xmm11 = (xmm11 * mem) + xmm14
               	vmovd	%xmm11, %r11d
               	vpinsrd	$0x1, %r11d, %xmm10, %xmm10
               	vextracti128	$0x1, %ymm0, %xmm11
               	vpermilps	$0x2, %xmm11, %xmm11 # xmm11 = xmm11[2,0,0,0]
               	vextracti128	$0x1, %ymm1, %xmm14
               	movups	%xmm14, -0x40(%rbp)
               	vpermilps	$0x2, %xmm14, %xmm14 # xmm14 = xmm14[2,0,0,0]
               	movsd	%xmm14, -0x38(%rbp)
               	vextracti128	$0x1, %ymm2, %xmm14
               	movups	%xmm14, -0x48(%rbp)
               	vpermilps	$0x2, %xmm14, %xmm14 # xmm14 = xmm14[2,0,0,0]
               	movsd	%xmm14, -0x40(%rbp)
               	vfmadd132ss	-0x38(%rbp), %xmm14, %xmm11 # xmm11 = (xmm11 * mem) + xmm14
               	vmovd	%xmm11, %r11d
               	vpinsrd	$0x2, %r11d, %xmm10, %xmm10
               	vextracti128	$0x1, %ymm0, %xmm11
               	vpermilps	$0x3, %xmm11, %xmm11 # xmm11 = xmm11[3,0,0,0]
               	vextracti128	$0x1, %ymm1, %xmm14
               	movups	%xmm14, -0x40(%rbp)
               	vpermilps	$0x3, %xmm14, %xmm14 # xmm14 = xmm14[3,0,0,0]
               	movsd	%xmm14, -0x38(%rbp)
               	vextracti128	$0x1, %ymm2, %xmm14
               	movups	%xmm14, -0x48(%rbp)
               	vpermilps	$0x3, %xmm14, %xmm14 # xmm14 = xmm14[3,0,0,0]
               	movsd	%xmm14, -0x40(%rbp)
               	vfmadd132ss	-0x38(%rbp), %xmm14, %xmm11 # xmm11 = (xmm11 * mem) + xmm14
               	vmovd	%xmm11, %r11d
               	vpinsrd	$0x3, %r11d, %xmm10, %xmm10
               	vinserti128	$0x1, %xmm10, %ymm6, %ymm6
               	vmovups	%ymm6, (%rsp)
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
               	vpermilps	$0x0, %xmm0, %xmm6 # xmm6 = xmm0[0,0,0,0]
               	vpermilps	$0x0, %xmm1, %xmm10 # xmm10 = xmm1[0,0,0,0]
               	vpermilps	$0x0, %xmm2, %xmm11 # xmm11 = xmm2[0,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm11
               	vfmadd213ss	%xmm11, %xmm10, %xmm6 # xmm6 = (xmm10 * xmm6) + xmm11
               	vmovd	%xmm6, %r11d
               	vmovd	%r11d, %xmm6
               	vpermilps	$0x1, %xmm0, %xmm10 # xmm10 = xmm0[1,0,0,0]
               	vpermilps	$0x1, %xmm1, %xmm11 # xmm11 = xmm1[1,0,0,0]
               	vpermilps	$0x1, %xmm2, %xmm14 # xmm14 = xmm2[1,0,0,0]
               	movsd	%xmm14, -0x38(%rbp)
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm14
               	movsd	%xmm14, -0x38(%rbp)
               	vfmadd213ss	%xmm14, %xmm11, %xmm10 # xmm10 = (xmm11 * xmm10) + xmm14
               	vmovd	%xmm10, %r11d
               	vpinsrd	$0x1, %r11d, %xmm6, %xmm6
               	vpermilps	$0x2, %xmm0, %xmm10 # xmm10 = xmm0[2,0,0,0]
               	vpermilps	$0x2, %xmm1, %xmm11 # xmm11 = xmm1[2,0,0,0]
               	vpermilps	$0x2, %xmm2, %xmm14 # xmm14 = xmm2[2,0,0,0]
               	movsd	%xmm14, -0x38(%rbp)
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm14
               	movsd	%xmm14, -0x38(%rbp)
               	vfmadd213ss	%xmm14, %xmm11, %xmm10 # xmm10 = (xmm11 * xmm10) + xmm14
               	vmovd	%xmm10, %r11d
               	vpinsrd	$0x2, %r11d, %xmm6, %xmm6
               	vpermilps	$0x3, %xmm0, %xmm10 # xmm10 = xmm0[3,0,0,0]
               	vpermilps	$0x3, %xmm1, %xmm11 # xmm11 = xmm1[3,0,0,0]
               	vpermilps	$0x3, %xmm2, %xmm14 # xmm14 = xmm2[3,0,0,0]
               	movsd	%xmm14, -0x38(%rbp)
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm14
               	movsd	%xmm14, -0x38(%rbp)
               	vfmadd213ss	%xmm14, %xmm11, %xmm10 # xmm10 = (xmm11 * xmm10) + xmm14
               	vmovd	%xmm10, %r11d
               	vpinsrd	$0x3, %r11d, %xmm6, %xmm6
               	vmovdqa	%xmm6, %xmm6
               	vextracti128	$0x1, %ymm0, %xmm10
               	vextracti128	$0x1, %ymm1, %xmm11
               	vextracti128	$0x1, %ymm2, %xmm14
               	movups	%xmm14, -0x40(%rbp)
               	vpermilps	$0x0, %xmm14, %xmm14 # xmm14 = xmm14[0,0,0,0]
               	movsd	%xmm14, -0x38(%rbp)
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm14
               	movsd	%xmm14, -0x38(%rbp)
               	vfmadd213ss	%xmm14, %xmm11, %xmm10 # xmm10 = (xmm11 * xmm10) + xmm14
               	vmovd	%xmm10, %r11d
               	vmovd	%r11d, %xmm10
               	vextracti128	$0x1, %ymm0, %xmm11
               	vpermilps	$0x1, %xmm11, %xmm11 # xmm11 = xmm11[1,0,0,0]
               	vextracti128	$0x1, %ymm1, %xmm14
               	movups	%xmm14, -0x40(%rbp)
               	vpermilps	$0x1, %xmm14, %xmm14 # xmm14 = xmm14[1,0,0,0]
               	movsd	%xmm14, -0x38(%rbp)
               	vextracti128	$0x1, %ymm2, %xmm14
               	movups	%xmm14, -0x48(%rbp)
               	vpermilps	$0x1, %xmm14, %xmm14 # xmm14 = xmm14[1,0,0,0]
               	movsd	%xmm14, -0x40(%rbp)
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm14
               	movsd	%xmm14, -0x40(%rbp)
               	vfmadd132ss	-0x38(%rbp), %xmm14, %xmm11 # xmm11 = (xmm11 * mem) + xmm14
               	vmovd	%xmm11, %r11d
               	vpinsrd	$0x1, %r11d, %xmm10, %xmm10
               	vextracti128	$0x1, %ymm0, %xmm11
               	vpermilps	$0x2, %xmm11, %xmm11 # xmm11 = xmm11[2,0,0,0]
               	vextracti128	$0x1, %ymm1, %xmm14
               	movups	%xmm14, -0x40(%rbp)
               	vpermilps	$0x2, %xmm14, %xmm14 # xmm14 = xmm14[2,0,0,0]
               	movsd	%xmm14, -0x38(%rbp)
               	vextracti128	$0x1, %ymm2, %xmm14
               	movups	%xmm14, -0x48(%rbp)
               	vpermilps	$0x2, %xmm14, %xmm14 # xmm14 = xmm14[2,0,0,0]
               	movsd	%xmm14, -0x40(%rbp)
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm14
               	movsd	%xmm14, -0x40(%rbp)
               	vfmadd132ss	-0x38(%rbp), %xmm14, %xmm11 # xmm11 = (xmm11 * mem) + xmm14
               	vmovd	%xmm11, %r11d
               	vpinsrd	$0x2, %r11d, %xmm10, %xmm10
               	vextracti128	$0x1, %ymm0, %xmm11
               	vpermilps	$0x3, %xmm11, %xmm11 # xmm11 = xmm11[3,0,0,0]
               	vextracti128	$0x1, %ymm1, %xmm14
               	movups	%xmm14, -0x40(%rbp)
               	vpermilps	$0x3, %xmm14, %xmm14 # xmm14 = xmm14[3,0,0,0]
               	movsd	%xmm14, -0x38(%rbp)
               	vextracti128	$0x1, %ymm2, %xmm14
               	movups	%xmm14, -0x48(%rbp)
               	vpermilps	$0x3, %xmm14, %xmm14 # xmm14 = xmm14[3,0,0,0]
               	movsd	%xmm14, -0x40(%rbp)
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm14
               	movsd	%xmm14, -0x40(%rbp)
               	vfmadd132ss	-0x38(%rbp), %xmm14, %xmm11 # xmm11 = (xmm11 * mem) + xmm14
               	vmovd	%xmm11, %r11d
               	vpinsrd	$0x3, %r11d, %xmm10, %xmm10
               	vinserti128	$0x1, %xmm10, %ymm6, %ymm6
               	vmovups	%ymm6, (%rsp)
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
               	vpermilps	$0x0, %xmm0, %xmm6 # xmm6 = xmm0[0,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm6
               	vpermilps	$0x0, %xmm1, %xmm10 # xmm10 = xmm1[0,0,0,0]
               	vpermilps	$0x0, %xmm2, %xmm11 # xmm11 = xmm2[0,0,0,0]
               	vfmadd213ss	%xmm11, %xmm10, %xmm6 # xmm6 = (xmm10 * xmm6) + xmm11
               	vmovd	%xmm6, %r11d
               	vmovd	%r11d, %xmm6
               	vpermilps	$0x1, %xmm0, %xmm10 # xmm10 = xmm0[1,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm10
               	vpermilps	$0x1, %xmm1, %xmm11 # xmm11 = xmm1[1,0,0,0]
               	vpermilps	$0x1, %xmm2, %xmm14 # xmm14 = xmm2[1,0,0,0]
               	movsd	%xmm14, -0x38(%rbp)
               	vfmadd213ss	%xmm14, %xmm11, %xmm10 # xmm10 = (xmm11 * xmm10) + xmm14
               	vmovd	%xmm10, %r11d
               	vpinsrd	$0x1, %r11d, %xmm6, %xmm6
               	vpermilps	$0x2, %xmm0, %xmm10 # xmm10 = xmm0[2,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm10
               	vpermilps	$0x2, %xmm1, %xmm11 # xmm11 = xmm1[2,0,0,0]
               	vpermilps	$0x2, %xmm2, %xmm14 # xmm14 = xmm2[2,0,0,0]
               	movsd	%xmm14, -0x38(%rbp)
               	vfmadd213ss	%xmm14, %xmm11, %xmm10 # xmm10 = (xmm11 * xmm10) + xmm14
               	vmovd	%xmm10, %r11d
               	vpinsrd	$0x2, %r11d, %xmm6, %xmm6
               	vpermilps	$0x3, %xmm0, %xmm10 # xmm10 = xmm0[3,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm10
               	vpermilps	$0x3, %xmm1, %xmm11 # xmm11 = xmm1[3,0,0,0]
               	vpermilps	$0x3, %xmm2, %xmm14 # xmm14 = xmm2[3,0,0,0]
               	movsd	%xmm14, -0x38(%rbp)
               	vfmadd213ss	%xmm14, %xmm11, %xmm10 # xmm10 = (xmm11 * xmm10) + xmm14
               	vmovd	%xmm10, %r11d
               	vpinsrd	$0x3, %r11d, %xmm6, %xmm6
               	vmovdqa	%xmm6, %xmm6
               	vextracti128	$0x1, %ymm0, %xmm10
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm10
               	vextracti128	$0x1, %ymm1, %xmm11
               	vextracti128	$0x1, %ymm2, %xmm14
               	movups	%xmm14, -0x40(%rbp)
               	vpermilps	$0x0, %xmm14, %xmm14 # xmm14 = xmm14[0,0,0,0]
               	movsd	%xmm14, -0x38(%rbp)
               	vfmadd213ss	%xmm14, %xmm11, %xmm10 # xmm10 = (xmm11 * xmm10) + xmm14
               	vmovd	%xmm10, %r11d
               	vmovd	%r11d, %xmm10
               	vextracti128	$0x1, %ymm0, %xmm11
               	vpermilps	$0x1, %xmm11, %xmm11 # xmm11 = xmm11[1,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm11
               	vextracti128	$0x1, %ymm1, %xmm14
               	movups	%xmm14, -0x40(%rbp)
               	vpermilps	$0x1, %xmm14, %xmm14 # xmm14 = xmm14[1,0,0,0]
               	movsd	%xmm14, -0x38(%rbp)
               	vextracti128	$0x1, %ymm2, %xmm14
               	movups	%xmm14, -0x48(%rbp)
               	vpermilps	$0x1, %xmm14, %xmm14 # xmm14 = xmm14[1,0,0,0]
               	movsd	%xmm14, -0x40(%rbp)
               	vfmadd132ss	-0x38(%rbp), %xmm14, %xmm11 # xmm11 = (xmm11 * mem) + xmm14
               	vmovd	%xmm11, %r11d
               	vpinsrd	$0x1, %r11d, %xmm10, %xmm10
               	vextracti128	$0x1, %ymm0, %xmm11
               	vpermilps	$0x2, %xmm11, %xmm11 # xmm11 = xmm11[2,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm11
               	vextracti128	$0x1, %ymm1, %xmm14
               	movups	%xmm14, -0x40(%rbp)
               	vpermilps	$0x2, %xmm14, %xmm14 # xmm14 = xmm14[2,0,0,0]
               	movsd	%xmm14, -0x38(%rbp)
               	vextracti128	$0x1, %ymm2, %xmm14
               	movups	%xmm14, -0x48(%rbp)
               	vpermilps	$0x2, %xmm14, %xmm14 # xmm14 = xmm14[2,0,0,0]
               	movsd	%xmm14, -0x40(%rbp)
               	vfmadd132ss	-0x38(%rbp), %xmm14, %xmm11 # xmm11 = (xmm11 * mem) + xmm14
               	vmovd	%xmm11, %r11d
               	vpinsrd	$0x2, %r11d, %xmm10, %xmm10
               	vextracti128	$0x1, %ymm0, %xmm11
               	vpermilps	$0x3, %xmm11, %xmm11 # xmm11 = xmm11[3,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm11
               	vextracti128	$0x1, %ymm1, %xmm14
               	movups	%xmm14, -0x40(%rbp)
               	vpermilps	$0x3, %xmm14, %xmm14 # xmm14 = xmm14[3,0,0,0]
               	movsd	%xmm14, -0x38(%rbp)
               	vextracti128	$0x1, %ymm2, %xmm14
               	movups	%xmm14, -0x48(%rbp)
               	vpermilps	$0x3, %xmm14, %xmm14 # xmm14 = xmm14[3,0,0,0]
               	movsd	%xmm14, -0x40(%rbp)
               	vfmadd132ss	-0x38(%rbp), %xmm14, %xmm11 # xmm11 = (xmm11 * mem) + xmm14
               	vmovd	%xmm11, %r11d
               	vpinsrd	$0x3, %r11d, %xmm10, %xmm10
               	vinserti128	$0x1, %xmm10, %ymm6, %ymm6
               	vmovups	%ymm6, (%rsp)
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
               	vpermilps	$0x0, %xmm0, %xmm6 # xmm6 = xmm0[0,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm6
               	vpermilps	$0x0, %xmm1, %xmm10 # xmm10 = xmm1[0,0,0,0]
               	vpermilps	$0x0, %xmm2, %xmm11 # xmm11 = xmm2[0,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm11
               	vfmadd213ss	%xmm11, %xmm10, %xmm6 # xmm6 = (xmm10 * xmm6) + xmm11
               	vmovd	%xmm6, %r11d
               	vmovd	%r11d, %xmm6
               	vpermilps	$0x1, %xmm0, %xmm10 # xmm10 = xmm0[1,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm10
               	vpermilps	$0x1, %xmm1, %xmm11 # xmm11 = xmm1[1,0,0,0]
               	vpermilps	$0x1, %xmm2, %xmm14 # xmm14 = xmm2[1,0,0,0]
               	movsd	%xmm14, -0x38(%rbp)
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm14
               	movsd	%xmm14, -0x38(%rbp)
               	vfmadd213ss	%xmm14, %xmm11, %xmm10 # xmm10 = (xmm11 * xmm10) + xmm14
               	vmovd	%xmm10, %r11d
               	vpinsrd	$0x1, %r11d, %xmm6, %xmm6
               	vpermilps	$0x2, %xmm0, %xmm10 # xmm10 = xmm0[2,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm10
               	vpermilps	$0x2, %xmm1, %xmm11 # xmm11 = xmm1[2,0,0,0]
               	vpermilps	$0x2, %xmm2, %xmm14 # xmm14 = xmm2[2,0,0,0]
               	movsd	%xmm14, -0x38(%rbp)
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm14
               	movsd	%xmm14, -0x38(%rbp)
               	vfmadd213ss	%xmm14, %xmm11, %xmm10 # xmm10 = (xmm11 * xmm10) + xmm14
               	vmovd	%xmm10, %r11d
               	vpinsrd	$0x2, %r11d, %xmm6, %xmm6
               	vpermilps	$0x3, %xmm0, %xmm10 # xmm10 = xmm0[3,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm10
               	vpermilps	$0x3, %xmm1, %xmm11 # xmm11 = xmm1[3,0,0,0]
               	vpermilps	$0x3, %xmm2, %xmm14 # xmm14 = xmm2[3,0,0,0]
               	movsd	%xmm14, -0x38(%rbp)
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm14
               	movsd	%xmm14, -0x38(%rbp)
               	vfmadd213ss	%xmm14, %xmm11, %xmm10 # xmm10 = (xmm11 * xmm10) + xmm14
               	vmovd	%xmm10, %r11d
               	vpinsrd	$0x3, %r11d, %xmm6, %xmm6
               	vmovdqa	%xmm6, %xmm6
               	vextracti128	$0x1, %ymm0, %xmm10
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm10
               	vextracti128	$0x1, %ymm1, %xmm11
               	vextracti128	$0x1, %ymm2, %xmm14
               	movups	%xmm14, -0x40(%rbp)
               	vpermilps	$0x0, %xmm14, %xmm14 # xmm14 = xmm14[0,0,0,0]
               	movsd	%xmm14, -0x38(%rbp)
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm14
               	movsd	%xmm14, -0x38(%rbp)
               	vfmadd213ss	%xmm14, %xmm11, %xmm10 # xmm10 = (xmm11 * xmm10) + xmm14
               	vmovd	%xmm10, %r11d
               	vmovd	%r11d, %xmm10
               	vextracti128	$0x1, %ymm0, %xmm11
               	vpermilps	$0x1, %xmm11, %xmm11 # xmm11 = xmm11[1,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm11
               	vextracti128	$0x1, %ymm1, %xmm14
               	movups	%xmm14, -0x40(%rbp)
               	vpermilps	$0x1, %xmm14, %xmm14 # xmm14 = xmm14[1,0,0,0]
               	movsd	%xmm14, -0x38(%rbp)
               	vextracti128	$0x1, %ymm2, %xmm14
               	movups	%xmm14, -0x48(%rbp)
               	vpermilps	$0x1, %xmm14, %xmm14 # xmm14 = xmm14[1,0,0,0]
               	movsd	%xmm14, -0x40(%rbp)
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm14
               	movsd	%xmm14, -0x40(%rbp)
               	vfmadd132ss	-0x38(%rbp), %xmm14, %xmm11 # xmm11 = (xmm11 * mem) + xmm14
               	vmovd	%xmm11, %r11d
               	vpinsrd	$0x1, %r11d, %xmm10, %xmm10
               	vextracti128	$0x1, %ymm0, %xmm11
               	vpermilps	$0x2, %xmm11, %xmm11 # xmm11 = xmm11[2,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm11
               	vextracti128	$0x1, %ymm1, %xmm14
               	movups	%xmm14, -0x40(%rbp)
               	vpermilps	$0x2, %xmm14, %xmm14 # xmm14 = xmm14[2,0,0,0]
               	movsd	%xmm14, -0x38(%rbp)
               	vextracti128	$0x1, %ymm2, %xmm14
               	movups	%xmm14, -0x48(%rbp)
               	vpermilps	$0x2, %xmm14, %xmm14 # xmm14 = xmm14[2,0,0,0]
               	movsd	%xmm14, -0x40(%rbp)
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm14
               	movsd	%xmm14, -0x40(%rbp)
               	vfmadd132ss	-0x38(%rbp), %xmm14, %xmm11 # xmm11 = (xmm11 * mem) + xmm14
               	vmovd	%xmm11, %r11d
               	vpinsrd	$0x2, %r11d, %xmm10, %xmm10
               	vextracti128	$0x1, %ymm0, %xmm11
               	vpermilps	$0x3, %xmm11, %xmm11 # xmm11 = xmm11[3,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm11
               	vextracti128	$0x1, %ymm1, %xmm14
               	movups	%xmm14, -0x40(%rbp)
               	vpermilps	$0x3, %xmm14, %xmm14 # xmm14 = xmm14[3,0,0,0]
               	movsd	%xmm14, -0x38(%rbp)
               	vextracti128	$0x1, %ymm2, %xmm14
               	movups	%xmm14, -0x48(%rbp)
               	vpermilps	$0x3, %xmm14, %xmm14 # xmm14 = xmm14[3,0,0,0]
               	movsd	%xmm14, -0x40(%rbp)
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm14
               	movsd	%xmm14, -0x40(%rbp)
               	vfmadd132ss	-0x38(%rbp), %xmm14, %xmm11 # xmm11 = (xmm11 * mem) + xmm14
               	vmovd	%xmm11, %r11d
               	vpinsrd	$0x3, %r11d, %xmm10, %xmm10
               	vinserti128	$0x1, %xmm10, %ymm6, %ymm6
               	vmovups	%ymm6, (%rsp)
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
               	leaq	0x40(%rsp), %rdx
               	vmovups	%ymm0, 0x40(%rsp)
               	leaq	0x60(%rsp), %rsi
               	vmovups	%ymm1, 0x60(%rsp)
               	vmovups	%ymm2, 0x20(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	vfmadd231ss	%xmm11, %xmm10, %xmm6 # xmm6 = (xmm10 * xmm11) + xmm6
               	movss	%xmm6, (%rdi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	(%rsp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movss	(%r8), %xmm10
               	leaq	(%rsi,%rcx), %r8
               	movss	(%r8), %xmm11
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	cmpl	$0x1, %r8d
               	jne	<addr>
               	leaq	0x20(%rsp), %r8
               	addq	%r8, %rcx
               	movss	(%rcx), %xmm6
               	jmp	<addr>
               	leaq	0x20(%rsp), %r8
               	addq	%r8, %rcx
               	movss	(%rcx), %xmm6
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm6
               	jmp	<addr>
               	vmovups	(%rsp), %ymm6
               	vmovups	%ymm6, (%rsp)
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
               	leaq	0x40(%rsp), %rdx
               	vmovups	%ymm0, 0x40(%rsp)
               	leaq	0x60(%rsp), %rsi
               	vmovups	%ymm1, 0x60(%rsp)
               	vmovups	%ymm2, 0x20(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	vfmadd231ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm2) + xmm0
               	movss	%xmm0, (%rdi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	(%rsp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movss	(%r8), %xmm1
               	leaq	(%rsi,%rcx), %r8
               	movss	(%r8), %xmm2
               	testb	$0x1, %al
               	jne	<addr>
               	leaq	0x20(%rsp), %r8
               	addq	%r8, %rcx
               	movss	(%rcx), %xmm0
               	jmp	<addr>
               	leaq	0x20(%rsp), %r8
               	addq	%r8, %rcx
               	movss	(%rcx), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	jmp	<addr>
               	vmovups	(%rsp), %ymm0
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
               	vpermilps	$0x0, %xmm7, %xmm0 # xmm0 = xmm7[0,0,0,0]
               	vpermilps	$0x0, %xmm8, %xmm1 # xmm1 = xmm8[0,0,0,0]
               	vpermilps	$0x0, %xmm9, %xmm2 # xmm2 = xmm9[0,0,0,0]
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm0
               	vpermilps	$0x1, %xmm7, %xmm1 # xmm1 = xmm7[1,0,0,0]
               	vpermilps	$0x1, %xmm8, %xmm2 # xmm2 = xmm8[1,0,0,0]
               	vpermilps	$0x1, %xmm9, %xmm6 # xmm6 = xmm9[1,0,0,0]
               	vfmadd213ss	%xmm6, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + xmm6
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	vpermilps	$0x2, %xmm7, %xmm1 # xmm1 = xmm7[2,0,0,0]
               	vpermilps	$0x2, %xmm8, %xmm2 # xmm2 = xmm8[2,0,0,0]
               	vpermilps	$0x2, %xmm9, %xmm6 # xmm6 = xmm9[2,0,0,0]
               	vfmadd213ss	%xmm6, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + xmm6
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	vpermilps	$0x3, %xmm7, %xmm1 # xmm1 = xmm7[3,0,0,0]
               	vpermilps	$0x3, %xmm8, %xmm2 # xmm2 = xmm8[3,0,0,0]
               	vpermilps	$0x3, %xmm9, %xmm6 # xmm6 = xmm9[3,0,0,0]
               	vfmadd213ss	%xmm6, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + xmm6
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
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
               	vpermilps	$0x0, %xmm7, %xmm0 # xmm0 = xmm7[0,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	vpermilps	$0x0, %xmm8, %xmm1 # xmm1 = xmm8[0,0,0,0]
               	vpermilps	$0x0, %xmm9, %xmm2 # xmm2 = xmm9[0,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm0
               	vpermilps	$0x1, %xmm7, %xmm1 # xmm1 = xmm7[1,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	vpermilps	$0x1, %xmm8, %xmm2 # xmm2 = xmm8[1,0,0,0]
               	vpermilps	$0x1, %xmm9, %xmm6 # xmm6 = xmm9[1,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm6
               	vfmadd213ss	%xmm6, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + xmm6
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	vpermilps	$0x2, %xmm7, %xmm1 # xmm1 = xmm7[2,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	vpermilps	$0x2, %xmm8, %xmm2 # xmm2 = xmm8[2,0,0,0]
               	vpermilps	$0x2, %xmm9, %xmm6 # xmm6 = xmm9[2,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm6
               	vfmadd213ss	%xmm6, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + xmm6
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	vpermilps	$0x3, %xmm7, %xmm1 # xmm1 = xmm7[3,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	vpermilps	$0x3, %xmm8, %xmm2 # xmm2 = xmm8[3,0,0,0]
               	vpermilps	$0x3, %xmm9, %xmm6 # xmm6 = xmm9[3,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm6
               	vfmadd213ss	%xmm6, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + xmm6
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
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
               	vpermilps	$0x0, %xmm7, %xmm0 # xmm0 = xmm7[0,0,0,0]
               	vpermilps	$0x0, %xmm8, %xmm1 # xmm1 = xmm8[0,0,0,0]
               	vpermilps	$0x0, %xmm9, %xmm2 # xmm2 = xmm9[0,0,0,0]
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	vmovd	%xmm0, %r11d
               	movapd	%xmm7, %xmm0
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
               	vpermilps	$0x0, %xmm7, %xmm0 # xmm0 = xmm7[0,0,0,0]
               	vpermilps	$0x0, %xmm8, %xmm1 # xmm1 = xmm8[0,0,0,0]
               	vpermilps	$0x0, %xmm9, %xmm2 # xmm2 = xmm9[0,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	vmovd	%xmm0, %r11d
               	movapd	%xmm7, %xmm0
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
               	vmovups	%ymm3, -0xc8(%rbp)
               	vmovups	%ymm4, -0xe8(%rbp)
               	vmovups	%ymm5, -0x108(%rbp)
               	movups	%xmm7, -0x118(%rbp)
               	movups	%xmm8, -0x128(%rbp)
               	movups	%xmm12, -0x148(%rbp)
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	-0xc8(%rbp), %ymm3
               	vmovups	-0xe8(%rbp), %ymm4
               	vmovups	-0x108(%rbp), %ymm5
               	movups	-0x118(%rbp), %xmm7
               	movups	-0x128(%rbp), %xmm8
               	movups	-0x148(%rbp), %xmm12
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
               	vmovups	%ymm3, -0xc8(%rbp)
               	vmovups	%ymm4, -0xe8(%rbp)
               	vmovups	%ymm5, -0x108(%rbp)
               	movups	%xmm7, -0x118(%rbp)
               	movups	%xmm8, -0x128(%rbp)
               	movups	%xmm12, -0x148(%rbp)
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	-0xc8(%rbp), %ymm3
               	vmovups	-0xe8(%rbp), %ymm4
               	vmovups	-0x108(%rbp), %ymm5
               	movups	-0x118(%rbp), %xmm7
               	movups	-0x128(%rbp), %xmm8
               	movups	-0x148(%rbp), %xmm12
               	vpermilpd	$0x0, %xmm3, %xmm0 # xmm0 = xmm3[0,0]
               	vpermilpd	$0x0, %xmm4, %xmm1 # xmm1 = xmm4[0,0]
               	vpermilpd	$0x0, %xmm5, %xmm2 # xmm2 = xmm5[0,0]
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	vmovq	%xmm0, %xmm0            # xmm0 = xmm0[0],zero
               	vpermilpd	$0x1, %xmm3, %xmm1 # xmm1 = xmm3[1,0]
               	vpermilpd	$0x1, %xmm4, %xmm2 # xmm2 = xmm4[1,0]
               	vpermilpd	$0x1, %xmm5, %xmm6 # xmm6 = xmm5[1,0]
               	vfmadd213sd	%xmm6, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + xmm6
               	vunpcklpd	%xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm1[0]
               	vmovdqa	%xmm0, %xmm0
               	vextracti128	$0x1, %ymm3, %xmm1
               	vextracti128	$0x1, %ymm4, %xmm2
               	vextracti128	$0x1, %ymm5, %xmm6
               	vfmadd213sd	%xmm6, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + xmm6
               	vmovq	%xmm1, %xmm1            # xmm1 = xmm1[0],zero
               	vextracti128	$0x1, %ymm3, %xmm2
               	vpermilpd	$0x1, %xmm2, %xmm2 # xmm2 = xmm2[1,0]
               	vextracti128	$0x1, %ymm4, %xmm6
               	vpermilpd	$0x1, %xmm6, %xmm6 # xmm6 = xmm6[1,0]
               	vextracti128	$0x1, %ymm5, %xmm9
               	vpermilpd	$0x1, %xmm9, %xmm9 # xmm9 = xmm9[1,0]
               	vfmadd213sd	%xmm9, %xmm6, %xmm2 # xmm2 = (xmm6 * xmm2) + xmm9
               	vunpcklpd	%xmm2, %xmm1, %xmm1 # xmm1 = xmm1[0],xmm2[0]
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
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
               	vpermilpd	$0x0, %xmm3, %xmm0 # xmm0 = xmm3[0,0]
               	vpermilpd	$0x0, %xmm4, %xmm1 # xmm1 = xmm4[0,0]
               	vpermilpd	$0x0, %xmm5, %xmm2 # xmm2 = xmm5[0,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	vmovq	%xmm0, %xmm0            # xmm0 = xmm0[0],zero
               	vpermilpd	$0x1, %xmm3, %xmm1 # xmm1 = xmm3[1,0]
               	vpermilpd	$0x1, %xmm4, %xmm2 # xmm2 = xmm4[1,0]
               	vpermilpd	$0x1, %xmm5, %xmm6 # xmm6 = xmm5[1,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm6
               	vfmadd213sd	%xmm6, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + xmm6
               	vunpcklpd	%xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm1[0]
               	vmovdqa	%xmm0, %xmm0
               	vextracti128	$0x1, %ymm3, %xmm1
               	vextracti128	$0x1, %ymm4, %xmm2
               	vextracti128	$0x1, %ymm5, %xmm6
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm6
               	vfmadd213sd	%xmm6, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + xmm6
               	vmovq	%xmm1, %xmm1            # xmm1 = xmm1[0],zero
               	vextracti128	$0x1, %ymm3, %xmm2
               	vpermilpd	$0x1, %xmm2, %xmm2 # xmm2 = xmm2[1,0]
               	vextracti128	$0x1, %ymm4, %xmm6
               	vpermilpd	$0x1, %xmm6, %xmm6 # xmm6 = xmm6[1,0]
               	vextracti128	$0x1, %ymm5, %xmm9
               	vpermilpd	$0x1, %xmm9, %xmm9 # xmm9 = xmm9[1,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm9
               	vfmadd213sd	%xmm9, %xmm6, %xmm2 # xmm2 = (xmm6 * xmm2) + xmm9
               	vunpcklpd	%xmm2, %xmm1, %xmm1 # xmm1 = xmm1[0],xmm2[0]
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
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
               	vpermilpd	$0x0, %xmm3, %xmm0 # xmm0 = xmm3[0,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	vpermilpd	$0x0, %xmm4, %xmm1 # xmm1 = xmm4[0,0]
               	vpermilpd	$0x0, %xmm5, %xmm2 # xmm2 = xmm5[0,0]
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	vmovq	%xmm0, %xmm0            # xmm0 = xmm0[0],zero
               	vpermilpd	$0x1, %xmm3, %xmm1 # xmm1 = xmm3[1,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	vpermilpd	$0x1, %xmm4, %xmm2 # xmm2 = xmm4[1,0]
               	vpermilpd	$0x1, %xmm5, %xmm6 # xmm6 = xmm5[1,0]
               	vfmadd213sd	%xmm6, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + xmm6
               	vunpcklpd	%xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm1[0]
               	vmovdqa	%xmm0, %xmm0
               	vextracti128	$0x1, %ymm3, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	vextracti128	$0x1, %ymm4, %xmm2
               	vextracti128	$0x1, %ymm5, %xmm6
               	vfmadd213sd	%xmm6, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + xmm6
               	vmovq	%xmm1, %xmm1            # xmm1 = xmm1[0],zero
               	vextracti128	$0x1, %ymm3, %xmm2
               	vpermilpd	$0x1, %xmm2, %xmm2 # xmm2 = xmm2[1,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vextracti128	$0x1, %ymm4, %xmm6
               	vpermilpd	$0x1, %xmm6, %xmm6 # xmm6 = xmm6[1,0]
               	vextracti128	$0x1, %ymm5, %xmm9
               	vpermilpd	$0x1, %xmm9, %xmm9 # xmm9 = xmm9[1,0]
               	vfmadd213sd	%xmm9, %xmm6, %xmm2 # xmm2 = (xmm6 * xmm2) + xmm9
               	vunpcklpd	%xmm2, %xmm1, %xmm1 # xmm1 = xmm1[0],xmm2[0]
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
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
               	vpermilpd	$0x0, %xmm3, %xmm0 # xmm0 = xmm3[0,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	vpermilpd	$0x0, %xmm4, %xmm1 # xmm1 = xmm4[0,0]
               	vpermilpd	$0x0, %xmm5, %xmm2 # xmm2 = xmm5[0,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	vmovq	%xmm0, %xmm0            # xmm0 = xmm0[0],zero
               	vpermilpd	$0x1, %xmm3, %xmm1 # xmm1 = xmm3[1,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	vpermilpd	$0x1, %xmm4, %xmm2 # xmm2 = xmm4[1,0]
               	vpermilpd	$0x1, %xmm5, %xmm6 # xmm6 = xmm5[1,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm6
               	vfmadd213sd	%xmm6, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + xmm6
               	vunpcklpd	%xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm1[0]
               	vmovdqa	%xmm0, %xmm0
               	vextracti128	$0x1, %ymm3, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	vextracti128	$0x1, %ymm4, %xmm2
               	vextracti128	$0x1, %ymm5, %xmm6
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm6
               	vfmadd213sd	%xmm6, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + xmm6
               	vmovq	%xmm1, %xmm1            # xmm1 = xmm1[0],zero
               	vextracti128	$0x1, %ymm3, %xmm2
               	vpermilpd	$0x1, %xmm2, %xmm2 # xmm2 = xmm2[1,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vextracti128	$0x1, %ymm4, %xmm6
               	vpermilpd	$0x1, %xmm6, %xmm6 # xmm6 = xmm6[1,0]
               	vextracti128	$0x1, %ymm5, %xmm9
               	vpermilpd	$0x1, %xmm9, %xmm9 # xmm9 = xmm9[1,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm9
               	vfmadd213sd	%xmm9, %xmm6, %xmm2 # xmm2 = (xmm6 * xmm2) + xmm9
               	vunpcklpd	%xmm2, %xmm1, %xmm1 # xmm1 = xmm1[0],xmm2[0]
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
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
               	leaq	0x40(%rsp), %rdx
               	vmovups	%ymm3, 0x40(%rsp)
               	leaq	0x60(%rsp), %rsi
               	vmovups	%ymm4, 0x60(%rsp)
               	vmovups	%ymm5, 0x20(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	vfmadd231sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm2) + xmm0
               	movsd	%xmm0, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	(%rsp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movsd	(%r8), %xmm1
               	leaq	(%rsi,%rcx), %r8
               	movsd	(%r8), %xmm2
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	cmpl	$0x1, %r8d
               	jne	<addr>
               	leaq	0x20(%rsp), %r8
               	addq	%r8, %rcx
               	movsd	(%rcx), %xmm0
               	jmp	<addr>
               	leaq	0x20(%rsp), %r8
               	addq	%r8, %rcx
               	movsd	(%rcx), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	jmp	<addr>
               	vmovups	(%rsp), %ymm0
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
               	leaq	0x40(%rsp), %rdx
               	vmovups	%ymm3, 0x40(%rsp)
               	leaq	0x60(%rsp), %rsi
               	vmovups	%ymm4, 0x60(%rsp)
               	vmovups	%ymm5, 0x20(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	vfmadd231sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm2) + xmm0
               	movsd	%xmm0, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	(%rsp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movsd	(%r8), %xmm1
               	leaq	(%rsi,%rcx), %r8
               	movsd	(%r8), %xmm2
               	testb	$0x1, %al
               	jne	<addr>
               	leaq	0x20(%rsp), %r8
               	addq	%r8, %rcx
               	movsd	(%rcx), %xmm0
               	jmp	<addr>
               	leaq	0x20(%rsp), %r8
               	addq	%r8, %rcx
               	movsd	(%rcx), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	jmp	<addr>
               	vmovups	(%rsp), %ymm0
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
               	vpermilpd	$0x0, %xmm12, %xmm0 # xmm0 = xmm12[0,0]
               	movups	-0x20(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	movups	-0x30(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm2 # xmm2 = xmm14[0,0]
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	vpermilpd	$0x1, %xmm12, %xmm1 # xmm1 = xmm12[1,0]
               	movups	-0x20(%rbp), %xmm14
               	vpermilpd	$0x1, %xmm14, %xmm2 # xmm2 = xmm14[1,0]
               	movups	-0x30(%rbp), %xmm14
               	vpermilpd	$0x1, %xmm14, %xmm3 # xmm3 = xmm14[1,0]
               	vfmadd213sd	%xmm3, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + xmm3
               	vunpcklpd	%xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm1[0]
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
               	vpermilpd	$0x0, %xmm12, %xmm0 # xmm0 = xmm12[0,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movups	-0x20(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	movups	-0x30(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm2 # xmm2 = xmm14[0,0]
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	vpermilpd	$0x1, %xmm12, %xmm1 # xmm1 = xmm12[1,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movups	-0x20(%rbp), %xmm14
               	vpermilpd	$0x1, %xmm14, %xmm2 # xmm2 = xmm14[1,0]
               	movups	-0x30(%rbp), %xmm14
               	vpermilpd	$0x1, %xmm14, %xmm3 # xmm3 = xmm14[1,0]
               	vfmadd213sd	%xmm3, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + xmm3
               	vunpcklpd	%xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm1[0]
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
               	vpermilpd	$0x0, %xmm12, %xmm0 # xmm0 = xmm12[0,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movups	-0x20(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	movups	-0x30(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm2 # xmm2 = xmm14[0,0]
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	vmovq	%xmm0, %r11
               	movapd	%xmm12, %xmm0
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
               	vpermilpd	$0x0, %xmm12, %xmm0 # xmm0 = xmm12[0,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movups	-0x20(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	movups	-0x30(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm2 # xmm2 = xmm14[0,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	vmovq	%xmm0, %r11
               	movapd	%xmm12, %xmm0
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
               	movups	%xmm7, -0x118(%rbp)
               	movups	%xmm8, -0x128(%rbp)
               	movups	%xmm12, -0x148(%rbp)
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movups	-0x118(%rbp), %xmm7
               	movups	-0x128(%rbp), %xmm8
               	movups	-0x148(%rbp), %xmm12
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
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, (%rsp)
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0x8(%rsp)
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0x10(%rsp)
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0x18(%rsp)
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
               	vmovdqa	%xmm7, %xmm0
               	vinserti128	$0x1, %xmm8, %ymm0, %ymm0
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
               	vmovdqa	%xmm12, %xmm0
               	movups	-0x20(%rbp), %xmm15
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
               	xorl	%eax, %eax
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
               	xorl	%eax, %eax
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
