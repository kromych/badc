
gcc_vector_arith_float.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	leaq	0x20(%rsp), %rax
               	leaq	<rip>, %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	0x30(%rsp), %rcx
               	leaq	<rip>, %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm0
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm4
               	leaq	<rip>, %rcx
               	vmovups	(%rcx), %ymm2
               	leaq	<rip>, %rcx
               	vmovups	(%rcx), %ymm3
               	movups	0x20(%rsp), %xmm1
               	movups	(%rax), %xmm5
               	vaddps	%xmm5, %xmm1, %xmm5
               	movups	%xmm5, (%rsp)
               	vpermilps	$0x0, %xmm1, %xmm5 # xmm5 = xmm1[0,0,0,0]
               	movss	0x30(%rsp), %xmm6
               	addss	%xmm6, %xmm5
               	movss	%xmm5, -0x10(%rbp)
               	vpermilps	$0x1, %xmm1, %xmm5 # xmm5 = xmm1[1,0,0,0]
               	movss	0x34(%rsp), %xmm6
               	addss	%xmm6, %xmm5
               	movss	%xmm5, -0xc(%rbp)
               	vpermilps	$0x2, %xmm1, %xmm1 # xmm1 = xmm1[2,0,0,0]
               	movss	0x38(%rsp), %xmm5
               	addss	%xmm5, %xmm1
               	movss	%xmm1, -0x8(%rbp)
               	movss	0x2c(%rsp), %xmm1
               	movss	0x3c(%rsp), %xmm5
               	addss	%xmm5, %xmm1
               	movss	%xmm1, -0x4(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x20(%rsp), %xmm1
               	movups	0x30(%rsp), %xmm5
               	vsubps	%xmm5, %xmm1, %xmm6
               	movups	%xmm6, (%rsp)
               	vpermilps	$0x0, %xmm1, %xmm6 # xmm6 = xmm1[0,0,0,0]
               	vpermilps	$0x0, %xmm5, %xmm7 # xmm7 = xmm5[0,0,0,0]
               	subss	%xmm7, %xmm6
               	movss	%xmm6, -0x10(%rbp)
               	vpermilps	$0x1, %xmm1, %xmm6 # xmm6 = xmm1[1,0,0,0]
               	vpermilps	$0x1, %xmm5, %xmm7 # xmm7 = xmm5[1,0,0,0]
               	subss	%xmm7, %xmm6
               	movss	%xmm6, -0xc(%rbp)
               	vpermilps	$0x2, %xmm1, %xmm1 # xmm1 = xmm1[2,0,0,0]
               	vpermilps	$0x2, %xmm5, %xmm5 # xmm5 = xmm5[2,0,0,0]
               	subss	%xmm5, %xmm1
               	movss	%xmm1, -0x8(%rbp)
               	movss	0x2c(%rsp), %xmm1
               	movss	0x3c(%rsp), %xmm5
               	subss	%xmm5, %xmm1
               	movss	%xmm1, -0x4(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x20(%rsp), %xmm1
               	movups	0x30(%rsp), %xmm5
               	vmulps	%xmm5, %xmm1, %xmm6
               	movups	%xmm6, (%rsp)
               	vpermilps	$0x0, %xmm1, %xmm6 # xmm6 = xmm1[0,0,0,0]
               	vpermilps	$0x0, %xmm5, %xmm7 # xmm7 = xmm5[0,0,0,0]
               	mulss	%xmm7, %xmm6
               	movss	%xmm6, -0x10(%rbp)
               	vpermilps	$0x1, %xmm1, %xmm6 # xmm6 = xmm1[1,0,0,0]
               	vpermilps	$0x1, %xmm5, %xmm7 # xmm7 = xmm5[1,0,0,0]
               	mulss	%xmm7, %xmm6
               	movss	%xmm6, -0xc(%rbp)
               	vpermilps	$0x2, %xmm1, %xmm1 # xmm1 = xmm1[2,0,0,0]
               	vpermilps	$0x2, %xmm5, %xmm5 # xmm5 = xmm5[2,0,0,0]
               	mulss	%xmm5, %xmm1
               	movss	%xmm1, -0x8(%rbp)
               	movss	0x2c(%rsp), %xmm1
               	movss	0x3c(%rsp), %xmm5
               	mulss	%xmm5, %xmm1
               	movss	%xmm1, -0x4(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x20(%rsp), %xmm1
               	movups	0x30(%rsp), %xmm5
               	vdivps	%xmm5, %xmm1, %xmm6
               	movups	%xmm6, (%rsp)
               	vpermilps	$0x0, %xmm1, %xmm6 # xmm6 = xmm1[0,0,0,0]
               	vpermilps	$0x0, %xmm5, %xmm7 # xmm7 = xmm5[0,0,0,0]
               	divss	%xmm7, %xmm6
               	movss	%xmm6, -0x10(%rbp)
               	vpermilps	$0x1, %xmm1, %xmm6 # xmm6 = xmm1[1,0,0,0]
               	vpermilps	$0x1, %xmm5, %xmm7 # xmm7 = xmm5[1,0,0,0]
               	divss	%xmm7, %xmm6
               	movss	%xmm6, -0xc(%rbp)
               	vpermilps	$0x2, %xmm1, %xmm1 # xmm1 = xmm1[2,0,0,0]
               	vpermilps	$0x2, %xmm5, %xmm5 # xmm5 = xmm5[2,0,0,0]
               	divss	%xmm5, %xmm1
               	movss	%xmm1, -0x8(%rbp)
               	movss	0x2c(%rsp), %xmm1
               	movss	0x3c(%rsp), %xmm5
               	divss	%xmm5, %xmm1
               	movss	%xmm1, -0x4(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	vaddpd	%xmm4, %xmm0, %xmm1
               	movups	%xmm1, (%rsp)
               	vpermilpd	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0]
               	vpermilpd	$0x0, %xmm4, %xmm5 # xmm5 = xmm4[0,0]
               	addsd	%xmm5, %xmm1
               	movsd	%xmm1, -0x10(%rbp)
               	vpermilpd	$0x1, %xmm0, %xmm1 # xmm1 = xmm0[1,0]
               	vpermilpd	$0x1, %xmm4, %xmm5 # xmm5 = xmm4[1,0]
               	addsd	%xmm5, %xmm1
               	movsd	%xmm1, -0x8(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	vsubpd	%xmm4, %xmm0, %xmm1
               	movups	%xmm1, (%rsp)
               	vpermilpd	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0]
               	vpermilpd	$0x0, %xmm4, %xmm5 # xmm5 = xmm4[0,0]
               	subsd	%xmm5, %xmm1
               	movsd	%xmm1, -0x10(%rbp)
               	vpermilpd	$0x1, %xmm0, %xmm1 # xmm1 = xmm0[1,0]
               	vpermilpd	$0x1, %xmm4, %xmm5 # xmm5 = xmm4[1,0]
               	subsd	%xmm5, %xmm1
               	movsd	%xmm1, -0x8(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	vmulpd	%xmm4, %xmm0, %xmm1
               	movups	%xmm1, (%rsp)
               	vpermilpd	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0]
               	vpermilpd	$0x0, %xmm4, %xmm5 # xmm5 = xmm4[0,0]
               	mulsd	%xmm5, %xmm1
               	movsd	%xmm1, -0x10(%rbp)
               	vpermilpd	$0x1, %xmm0, %xmm1 # xmm1 = xmm0[1,0]
               	vpermilpd	$0x1, %xmm4, %xmm5 # xmm5 = xmm4[1,0]
               	mulsd	%xmm5, %xmm1
               	movsd	%xmm1, -0x8(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	vdivpd	%xmm4, %xmm0, %xmm1
               	movups	%xmm1, (%rsp)
               	vpermilpd	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0]
               	vpermilpd	$0x0, %xmm4, %xmm5 # xmm5 = xmm4[0,0]
               	divsd	%xmm5, %xmm1
               	movsd	%xmm1, -0x10(%rbp)
               	vpermilpd	$0x1, %xmm0, %xmm1 # xmm1 = xmm0[1,0]
               	vpermilpd	$0x1, %xmm4, %xmm5 # xmm5 = xmm4[1,0]
               	divsd	%xmm5, %xmm1
               	movsd	%xmm1, -0x8(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	vaddps	%ymm3, %ymm2, %ymm1
               	vmovups	%ymm1, (%rsp)
               	vpermilps	$0x0, %xmm2, %xmm1 # xmm1 = xmm2[0,0,0,0]
               	vpermilps	$0x0, %xmm3, %xmm5 # xmm5 = xmm3[0,0,0,0]
               	addss	%xmm5, %xmm1
               	movss	%xmm1, -0x20(%rbp)
               	vpermilps	$0x1, %xmm2, %xmm1 # xmm1 = xmm2[1,0,0,0]
               	vpermilps	$0x1, %xmm3, %xmm5 # xmm5 = xmm3[1,0,0,0]
               	addss	%xmm5, %xmm1
               	movss	%xmm1, -0x1c(%rbp)
               	vpermilps	$0x2, %xmm2, %xmm1 # xmm1 = xmm2[2,0,0,0]
               	vpermilps	$0x2, %xmm3, %xmm5 # xmm5 = xmm3[2,0,0,0]
               	addss	%xmm5, %xmm1
               	movss	%xmm1, -0x18(%rbp)
               	vpermilps	$0x3, %xmm2, %xmm1 # xmm1 = xmm2[3,0,0,0]
               	vpermilps	$0x3, %xmm3, %xmm5 # xmm5 = xmm3[3,0,0,0]
               	addss	%xmm5, %xmm1
               	movss	%xmm1, -0x14(%rbp)
               	vextracti128	$0x1, %ymm2, %xmm1
               	vextracti128	$0x1, %ymm3, %xmm5
               	addss	%xmm5, %xmm1
               	movss	%xmm1, -0x10(%rbp)
               	vextracti128	$0x1, %ymm2, %xmm1
               	vpermilps	$0x1, %xmm1, %xmm1 # xmm1 = xmm1[1,0,0,0]
               	vextracti128	$0x1, %ymm3, %xmm5
               	vpermilps	$0x1, %xmm5, %xmm5 # xmm5 = xmm5[1,0,0,0]
               	addss	%xmm5, %xmm1
               	movss	%xmm1, -0xc(%rbp)
               	vextracti128	$0x1, %ymm2, %xmm1
               	vpermilps	$0x2, %xmm1, %xmm1 # xmm1 = xmm1[2,0,0,0]
               	vextracti128	$0x1, %ymm3, %xmm5
               	vpermilps	$0x2, %xmm5, %xmm5 # xmm5 = xmm5[2,0,0,0]
               	addss	%xmm5, %xmm1
               	movss	%xmm1, -0x8(%rbp)
               	vextracti128	$0x1, %ymm2, %xmm1
               	vpermilps	$0x3, %xmm1, %xmm1 # xmm1 = xmm1[3,0,0,0]
               	vextracti128	$0x1, %ymm3, %xmm5
               	vpermilps	$0x3, %xmm5, %xmm5 # xmm5 = xmm5[3,0,0,0]
               	addss	%xmm5, %xmm1
               	movss	%xmm1, -0x4(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rsi
               	movzbq	-0x20(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	vmulps	%ymm3, %ymm2, %ymm1
               	vmovups	%ymm1, (%rsp)
               	vpermilps	$0x0, %xmm2, %xmm1 # xmm1 = xmm2[0,0,0,0]
               	vpermilps	$0x0, %xmm3, %xmm5 # xmm5 = xmm3[0,0,0,0]
               	mulss	%xmm5, %xmm1
               	movss	%xmm1, -0x20(%rbp)
               	vpermilps	$0x1, %xmm2, %xmm1 # xmm1 = xmm2[1,0,0,0]
               	vpermilps	$0x1, %xmm3, %xmm5 # xmm5 = xmm3[1,0,0,0]
               	mulss	%xmm5, %xmm1
               	movss	%xmm1, -0x1c(%rbp)
               	vpermilps	$0x2, %xmm2, %xmm1 # xmm1 = xmm2[2,0,0,0]
               	vpermilps	$0x2, %xmm3, %xmm5 # xmm5 = xmm3[2,0,0,0]
               	mulss	%xmm5, %xmm1
               	movss	%xmm1, -0x18(%rbp)
               	vpermilps	$0x3, %xmm2, %xmm1 # xmm1 = xmm2[3,0,0,0]
               	vpermilps	$0x3, %xmm3, %xmm5 # xmm5 = xmm3[3,0,0,0]
               	mulss	%xmm5, %xmm1
               	movss	%xmm1, -0x14(%rbp)
               	vextracti128	$0x1, %ymm2, %xmm1
               	vextracti128	$0x1, %ymm3, %xmm5
               	mulss	%xmm5, %xmm1
               	movss	%xmm1, -0x10(%rbp)
               	vextracti128	$0x1, %ymm2, %xmm1
               	vpermilps	$0x1, %xmm1, %xmm1 # xmm1 = xmm1[1,0,0,0]
               	vextracti128	$0x1, %ymm3, %xmm5
               	vpermilps	$0x1, %xmm5, %xmm5 # xmm5 = xmm5[1,0,0,0]
               	mulss	%xmm5, %xmm1
               	movss	%xmm1, -0xc(%rbp)
               	vextracti128	$0x1, %ymm2, %xmm1
               	vpermilps	$0x2, %xmm1, %xmm1 # xmm1 = xmm1[2,0,0,0]
               	vextracti128	$0x1, %ymm3, %xmm5
               	vpermilps	$0x2, %xmm5, %xmm5 # xmm5 = xmm5[2,0,0,0]
               	mulss	%xmm5, %xmm1
               	movss	%xmm1, -0x8(%rbp)
               	vextracti128	$0x1, %ymm2, %xmm1
               	vpermilps	$0x3, %xmm1, %xmm1 # xmm1 = xmm1[3,0,0,0]
               	vextracti128	$0x1, %ymm3, %xmm2
               	vpermilps	$0x3, %xmm2, %xmm2 # xmm2 = xmm2[3,0,0,0]
               	mulss	%xmm2, %xmm1
               	movss	%xmm1, -0x4(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rsi
               	movzbq	-0x20(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movss	0x20(%rsp), %xmm1
               	vmulss	<rip>, %xmm1, %xmm5
               	movss	0x24(%rsp), %xmm2
               	vmulss	<rip>, %xmm2, %xmm6
               	movss	0x28(%rsp), %xmm3
               	vmulss	<rip>, %xmm3, %xmm7
               	movss	0x2c(%rsp), %xmm8
               	vmulss	<rip>, %xmm8, %xmm8
               	movss	%xmm5, (%rsp)
               	movss	%xmm6, 0x4(%rsp)
               	movss	%xmm7, 0x8(%rsp)
               	movss	%xmm8, 0xc(%rsp)
               	vmulss	<rip>, %xmm1, %xmm1
               	movss	%xmm1, -0x10(%rbp)
               	vmulss	<rip>, %xmm2, %xmm1
               	movss	%xmm1, -0xc(%rbp)
               	vmulss	<rip>, %xmm3, %xmm1
               	movss	%xmm1, -0x8(%rbp)
               	movss	0x2c(%rsp), %xmm1
               	vmulss	<rip>, %xmm1, %xmm1
               	movss	%xmm1, -0x4(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movss	0x20(%rsp), %xmm1
               	vmulss	<rip>, %xmm1, %xmm5
               	movss	0x24(%rsp), %xmm2
               	vmulss	<rip>, %xmm2, %xmm6
               	movss	0x28(%rsp), %xmm3
               	vmulss	<rip>, %xmm3, %xmm7
               	movss	0x2c(%rsp), %xmm8
               	vmulss	<rip>, %xmm8, %xmm8
               	movss	%xmm5, (%rsp)
               	movss	%xmm6, 0x4(%rsp)
               	movss	%xmm7, 0x8(%rsp)
               	movss	%xmm8, 0xc(%rsp)
               	vmulss	<rip>, %xmm1, %xmm1
               	movss	%xmm1, -0x10(%rbp)
               	vmulss	<rip>, %xmm2, %xmm1
               	movss	%xmm1, -0xc(%rbp)
               	vmulss	<rip>, %xmm3, %xmm1
               	movss	%xmm1, -0x8(%rbp)
               	movss	0x2c(%rsp), %xmm1
               	vmulss	<rip>, %xmm1, %xmm1
               	movss	%xmm1, -0x4(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	vpermilpd	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0]
               	vdivsd	<rip>, %xmm1, %xmm2
               	vpermilpd	$0x1, %xmm0, %xmm1 # xmm1 = xmm0[1,0]
               	vdivsd	<rip>, %xmm1, %xmm3
               	movsd	%xmm2, (%rsp)
               	movsd	%xmm3, 0x8(%rsp)
               	vpermilpd	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0]
               	vdivsd	<rip>, %xmm1, %xmm2
               	movsd	%xmm2, -0x10(%rbp)
               	vpermilpd	$0x1, %xmm0, %xmm1 # xmm1 = xmm0[1,0]
               	vdivsd	<rip>, %xmm1, %xmm2
               	movsd	%xmm2, -0x8(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	vpermilpd	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0]
               	vaddsd	<rip>, %xmm1, %xmm1
               	vpermilpd	$0x1, %xmm0, %xmm2 # xmm2 = xmm0[1,0]
               	vaddsd	<rip>, %xmm2, %xmm2
               	movsd	%xmm1, (%rsp)
               	movsd	%xmm2, 0x8(%rsp)
               	vpermilpd	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0]
               	vaddsd	<rip>, %xmm1, %xmm1
               	movsd	%xmm1, -0x10(%rbp)
               	vpermilpd	$0x1, %xmm0, %xmm1 # xmm1 = xmm0[1,0]
               	vaddsd	<rip>, %xmm1, %xmm1
               	movsd	%xmm1, -0x8(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rax
               	movups	0x20(%rsp), %xmm1
               	movups	0x30(%rsp), %xmm2
               	vmulps	%xmm2, %xmm1, %xmm1
               	movups	%xmm1, 0x40(%rsp)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	movups	0x20(%rsp), %xmm1
               	movups	0x30(%rsp), %xmm2
               	vmulps	%xmm2, %xmm1, %xmm1
               	movups	%xmm1, (%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rsi
               	movzbq	0x40(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rax
               	movups	0x20(%rsp), %xmm1
               	movups	0x30(%rsp), %xmm2
               	vaddps	%xmm2, %xmm1, %xmm1
               	movups	%xmm1, 0x40(%rsp)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	movups	0x20(%rsp), %xmm1
               	movups	0x30(%rsp), %xmm2
               	vaddps	%xmm2, %xmm1, %xmm1
               	movups	%xmm1, (%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rsi
               	movzbq	0x40(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	vdivpd	%xmm4, %xmm0, %xmm1
               	movups	%xmm1, 0x40(%rsp)
               	movups	%xmm0, (%rsp)
               	vdivpd	%xmm4, %xmm0, %xmm1
               	movups	%xmm1, (%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rsi
               	movzbq	0x40(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	movss	0x20(%rsp), %xmm1
               	vmulss	<rip>, %xmm1, %xmm5
               	movss	0x24(%rsp), %xmm2
               	vmulss	<rip>, %xmm2, %xmm6
               	movss	0x28(%rsp), %xmm3
               	vmulss	<rip>, %xmm3, %xmm7
               	movss	0x2c(%rsp), %xmm4
               	vmulss	<rip>, %xmm4, %xmm8
               	movss	%xmm5, 0x40(%rsp)
               	movss	%xmm6, 0x44(%rsp)
               	movss	%xmm7, 0x48(%rsp)
               	movss	%xmm8, 0x4c(%rsp)
               	vmulss	<rip>, %xmm1, %xmm1
               	vmulss	<rip>, %xmm2, %xmm2
               	vmulss	<rip>, %xmm3, %xmm3
               	vmulss	<rip>, %xmm4, %xmm4
               	movss	%xmm1, (%rsp)
               	movss	%xmm2, 0x4(%rsp)
               	movss	%xmm3, 0x8(%rsp)
               	movss	%xmm4, 0xc(%rsp)
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movss	0x20(%rsp), %xmm1
               	movapd	%xmm1, %xmm4
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm4
               	movss	0x24(%rsp), %xmm2
               	movapd	%xmm2, %xmm5
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm5
               	movss	0x28(%rsp), %xmm3
               	movapd	%xmm3, %xmm6
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm6
               	movss	0x2c(%rsp), %xmm7
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm7
               	movss	%xmm4, (%rsp)
               	movss	%xmm5, 0x4(%rsp)
               	movss	%xmm6, 0x8(%rsp)
               	movss	%xmm7, 0xc(%rsp)
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movss	%xmm1, -0x10(%rbp)
               	movapd	%xmm2, %xmm1
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movss	%xmm1, -0xc(%rbp)
               	movapd	%xmm3, %xmm1
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movss	%xmm1, -0x8(%rbp)
               	movss	0x2c(%rsp), %xmm1
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movss	%xmm1, -0x4(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movzbq	0xf(%rsp), %rax
               	cmpl	$0x80, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	vzeroupper
               	leave
               	retq
               	vpermilpd	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	vpermilpd	$0x1, %xmm0, %xmm2 # xmm2 = xmm0[1,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	movsd	%xmm1, (%rsp)
               	movsd	%xmm2, 0x8(%rsp)
               	leaq	-0x10(%rbp), %rcx
               	vpermilpd	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movsd	%xmm1, -0x10(%rbp)
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rsi
               	leaq	0x30(%rsp), %rdi
               	movups	0x20(%rsp), %xmm0
               	movups	0x30(%rsp), %xmm1
               	vaddps	%xmm1, %xmm0, %xmm0
               	vpermilps	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0,0,0]
               	vmulss	<rip>, %xmm1, %xmm1
               	vmovd	%xmm1, %r11d
               	vmovd	%r11d, %xmm1
               	vpermilps	$0x1, %xmm0, %xmm2 # xmm2 = xmm0[1,0,0,0]
               	vmulss	<rip>, %xmm2, %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x1, %r11d, %xmm1, %xmm1
               	vpermilps	$0x2, %xmm0, %xmm2 # xmm2 = xmm0[2,0,0,0]
               	vmulss	<rip>, %xmm2, %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x2, %r11d, %xmm1, %xmm1
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	vmulss	<rip>, %xmm0, %xmm0
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	0x20(%rsp), %xmm1
               	vsubps	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, (%rsp)
               	xorl	%eax, %eax
               	movss	0x20(%rsp,%rax,4), %xmm0
               	vaddss	0x30(%rsp,%rax,4), %xmm0, %xmm1
               	vfmsub231ss	<rip>, %xmm1, %xmm0 # xmm0 = (xmm1 * mem) - xmm0
               	movss	%xmm0, -0x10(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x16, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x15, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x13, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x12, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x11, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x10, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0xf, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0xe, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0xd, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0xc, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0xb, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0xa, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x9, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x8, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x7, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x6, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x5, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x4, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x3, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x2, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x1, %eax
               	vzeroupper
               	leave
               	retq
