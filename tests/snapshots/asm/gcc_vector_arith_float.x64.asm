
gcc_vector_arith_float.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	leaq	0x20(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x30(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm0
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm3
               	leaq	<rip>, %rax
               	vmovups	(%rax), %ymm1
               	leaq	<rip>, %rax
               	vmovups	(%rax), %ymm2
               	movups	0x20(%rsp), %xmm4
               	movups	0x30(%rsp), %xmm5
               	addps	%xmm5, %xmm4
               	leaq	(%rsp), %rcx
               	movups	%xmm4, (%rsp)
               	leaq	-0x10(%rbp), %rdx
               	movss	0x20(%rsp), %xmm4
               	movss	0x30(%rsp), %xmm5
               	addss	%xmm5, %xmm4
               	movss	%xmm4, -0x10(%rbp)
               	movss	0x24(%rsp), %xmm4
               	movss	0x34(%rsp), %xmm5
               	addss	%xmm5, %xmm4
               	movss	%xmm4, -0xc(%rbp)
               	movss	0x28(%rsp), %xmm4
               	movss	0x38(%rsp), %xmm5
               	addss	%xmm5, %xmm4
               	movss	%xmm4, -0x8(%rbp)
               	movss	0x2c(%rsp), %xmm4
               	movss	0x3c(%rsp), %xmm5
               	addss	%xmm5, %xmm4
               	movss	%xmm4, -0x4(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x20(%rsp), %xmm4
               	movups	0x30(%rsp), %xmm5
               	subps	%xmm5, %xmm4
               	leaq	(%rsp), %rcx
               	movups	%xmm4, (%rsp)
               	leaq	-0x10(%rbp), %rdx
               	movss	0x20(%rsp), %xmm4
               	movss	0x30(%rsp), %xmm5
               	subss	%xmm5, %xmm4
               	movss	%xmm4, -0x10(%rbp)
               	movss	0x24(%rsp), %xmm4
               	movss	0x34(%rsp), %xmm5
               	subss	%xmm5, %xmm4
               	movss	%xmm4, -0xc(%rbp)
               	movss	0x28(%rsp), %xmm4
               	movss	0x38(%rsp), %xmm5
               	subss	%xmm5, %xmm4
               	movss	%xmm4, -0x8(%rbp)
               	movss	0x2c(%rsp), %xmm4
               	movss	0x3c(%rsp), %xmm5
               	subss	%xmm5, %xmm4
               	movss	%xmm4, -0x4(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x20(%rsp), %xmm4
               	movups	0x30(%rsp), %xmm5
               	mulps	%xmm5, %xmm4
               	leaq	(%rsp), %rcx
               	movups	%xmm4, (%rsp)
               	leaq	-0x10(%rbp), %rdx
               	movss	0x20(%rsp), %xmm4
               	movss	0x30(%rsp), %xmm5
               	mulss	%xmm5, %xmm4
               	movss	%xmm4, -0x10(%rbp)
               	movss	0x24(%rsp), %xmm4
               	movss	0x34(%rsp), %xmm5
               	mulss	%xmm5, %xmm4
               	movss	%xmm4, -0xc(%rbp)
               	movss	0x28(%rsp), %xmm4
               	movss	0x38(%rsp), %xmm5
               	mulss	%xmm5, %xmm4
               	movss	%xmm4, -0x8(%rbp)
               	movss	0x2c(%rsp), %xmm4
               	movss	0x3c(%rsp), %xmm5
               	mulss	%xmm5, %xmm4
               	movss	%xmm4, -0x4(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x20(%rsp), %xmm4
               	movups	0x30(%rsp), %xmm5
               	divps	%xmm5, %xmm4
               	leaq	(%rsp), %rcx
               	movups	%xmm4, (%rsp)
               	leaq	-0x10(%rbp), %rdx
               	movss	0x20(%rsp), %xmm4
               	movss	0x30(%rsp), %xmm5
               	divss	%xmm5, %xmm4
               	movss	%xmm4, -0x10(%rbp)
               	movss	0x24(%rsp), %xmm4
               	movss	0x34(%rsp), %xmm5
               	divss	%xmm5, %xmm4
               	movss	%xmm4, -0xc(%rbp)
               	movss	0x28(%rsp), %xmm4
               	movss	0x38(%rsp), %xmm5
               	divss	%xmm5, %xmm4
               	movss	%xmm4, -0x8(%rbp)
               	movss	0x2c(%rsp), %xmm4
               	movss	0x3c(%rsp), %xmm5
               	divss	%xmm5, %xmm4
               	movss	%xmm4, -0x4(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movapd	%xmm0, %xmm4
               	addpd	%xmm3, %xmm4
               	leaq	(%rsp), %rcx
               	movups	%xmm4, (%rsp)
               	leaq	-0x10(%rbp), %rdx
               	vpermilpd	$0x0, %xmm0, %xmm4 # xmm4 = xmm0[0,0]
               	vpermilpd	$0x0, %xmm3, %xmm5 # xmm5 = xmm3[0,0]
               	addsd	%xmm5, %xmm4
               	movsd	%xmm4, -0x10(%rbp)
               	vpermilpd	$0x1, %xmm0, %xmm4 # xmm4 = xmm0[1,0]
               	vpermilpd	$0x1, %xmm3, %xmm5 # xmm5 = xmm3[1,0]
               	addsd	%xmm5, %xmm4
               	movsd	%xmm4, -0x8(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movapd	%xmm0, %xmm4
               	subpd	%xmm3, %xmm4
               	leaq	(%rsp), %rcx
               	movups	%xmm4, (%rsp)
               	leaq	-0x10(%rbp), %rdx
               	vpermilpd	$0x0, %xmm0, %xmm4 # xmm4 = xmm0[0,0]
               	vpermilpd	$0x0, %xmm3, %xmm5 # xmm5 = xmm3[0,0]
               	subsd	%xmm5, %xmm4
               	movsd	%xmm4, -0x10(%rbp)
               	vpermilpd	$0x1, %xmm0, %xmm4 # xmm4 = xmm0[1,0]
               	vpermilpd	$0x1, %xmm3, %xmm5 # xmm5 = xmm3[1,0]
               	subsd	%xmm5, %xmm4
               	movsd	%xmm4, -0x8(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movapd	%xmm0, %xmm4
               	mulpd	%xmm3, %xmm4
               	leaq	(%rsp), %rcx
               	movups	%xmm4, (%rsp)
               	leaq	-0x10(%rbp), %rdx
               	vpermilpd	$0x0, %xmm0, %xmm4 # xmm4 = xmm0[0,0]
               	vpermilpd	$0x0, %xmm3, %xmm5 # xmm5 = xmm3[0,0]
               	mulsd	%xmm5, %xmm4
               	movsd	%xmm4, -0x10(%rbp)
               	vpermilpd	$0x1, %xmm0, %xmm4 # xmm4 = xmm0[1,0]
               	vpermilpd	$0x1, %xmm3, %xmm5 # xmm5 = xmm3[1,0]
               	mulsd	%xmm5, %xmm4
               	movsd	%xmm4, -0x8(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movapd	%xmm0, %xmm4
               	divpd	%xmm3, %xmm4
               	leaq	(%rsp), %rcx
               	movups	%xmm4, (%rsp)
               	leaq	-0x10(%rbp), %rdx
               	vpermilpd	$0x0, %xmm0, %xmm4 # xmm4 = xmm0[0,0]
               	vpermilpd	$0x0, %xmm3, %xmm5 # xmm5 = xmm3[0,0]
               	divsd	%xmm5, %xmm4
               	movsd	%xmm4, -0x10(%rbp)
               	vpermilpd	$0x1, %xmm0, %xmm4 # xmm4 = xmm0[1,0]
               	vpermilpd	$0x1, %xmm3, %xmm5 # xmm5 = xmm3[1,0]
               	divsd	%xmm5, %xmm4
               	movsd	%xmm4, -0x8(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	vaddps	%ymm2, %ymm1, %ymm4
               	vmovups	%ymm4, (%rsp)
               	vpermilps	$0x0, %xmm1, %xmm4 # xmm4 = xmm1[0,0,0,0]
               	vpermilps	$0x0, %xmm2, %xmm5 # xmm5 = xmm2[0,0,0,0]
               	addss	%xmm5, %xmm4
               	movss	%xmm4, -0x20(%rbp)
               	vpermilps	$0x1, %xmm1, %xmm4 # xmm4 = xmm1[1,0,0,0]
               	vpermilps	$0x1, %xmm2, %xmm5 # xmm5 = xmm2[1,0,0,0]
               	addss	%xmm5, %xmm4
               	movss	%xmm4, -0x1c(%rbp)
               	vpermilps	$0x2, %xmm1, %xmm4 # xmm4 = xmm1[2,0,0,0]
               	vpermilps	$0x2, %xmm2, %xmm5 # xmm5 = xmm2[2,0,0,0]
               	addss	%xmm5, %xmm4
               	movss	%xmm4, -0x18(%rbp)
               	vpermilps	$0x3, %xmm1, %xmm4 # xmm4 = xmm1[3,0,0,0]
               	vpermilps	$0x3, %xmm2, %xmm5 # xmm5 = xmm2[3,0,0,0]
               	addss	%xmm5, %xmm4
               	movss	%xmm4, -0x14(%rbp)
               	vextracti128	$0x1, %ymm1, %xmm4
               	vpermilps	$0x0, %xmm4, %xmm4 # xmm4 = xmm4[0,0,0,0]
               	vextracti128	$0x1, %ymm2, %xmm5
               	vpermilps	$0x0, %xmm5, %xmm5 # xmm5 = xmm5[0,0,0,0]
               	addss	%xmm5, %xmm4
               	movss	%xmm4, -0x10(%rbp)
               	vextracti128	$0x1, %ymm1, %xmm4
               	vpermilps	$0x1, %xmm4, %xmm4 # xmm4 = xmm4[1,0,0,0]
               	vextracti128	$0x1, %ymm2, %xmm5
               	vpermilps	$0x1, %xmm5, %xmm5 # xmm5 = xmm5[1,0,0,0]
               	addss	%xmm5, %xmm4
               	movss	%xmm4, -0xc(%rbp)
               	vextracti128	$0x1, %ymm1, %xmm4
               	vpermilps	$0x2, %xmm4, %xmm4 # xmm4 = xmm4[2,0,0,0]
               	vextracti128	$0x1, %ymm2, %xmm5
               	vpermilps	$0x2, %xmm5, %xmm5 # xmm5 = xmm5[2,0,0,0]
               	addss	%xmm5, %xmm4
               	movss	%xmm4, -0x8(%rbp)
               	vextracti128	$0x1, %ymm1, %xmm4
               	vpermilps	$0x3, %xmm4, %xmm4 # xmm4 = xmm4[3,0,0,0]
               	vextracti128	$0x1, %ymm2, %xmm5
               	vpermilps	$0x3, %xmm5, %xmm5 # xmm5 = xmm5[3,0,0,0]
               	addss	%xmm5, %xmm4
               	movss	%xmm4, -0x4(%rbp)
               	leaq	(%rsp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	vmulps	%ymm2, %ymm1, %ymm4
               	vmovups	%ymm4, (%rsp)
               	vpermilps	$0x0, %xmm1, %xmm4 # xmm4 = xmm1[0,0,0,0]
               	vpermilps	$0x0, %xmm2, %xmm5 # xmm5 = xmm2[0,0,0,0]
               	mulss	%xmm5, %xmm4
               	movss	%xmm4, -0x20(%rbp)
               	vpermilps	$0x1, %xmm1, %xmm4 # xmm4 = xmm1[1,0,0,0]
               	vpermilps	$0x1, %xmm2, %xmm5 # xmm5 = xmm2[1,0,0,0]
               	mulss	%xmm5, %xmm4
               	movss	%xmm4, -0x1c(%rbp)
               	vpermilps	$0x2, %xmm1, %xmm4 # xmm4 = xmm1[2,0,0,0]
               	vpermilps	$0x2, %xmm2, %xmm5 # xmm5 = xmm2[2,0,0,0]
               	mulss	%xmm5, %xmm4
               	movss	%xmm4, -0x18(%rbp)
               	vpermilps	$0x3, %xmm1, %xmm4 # xmm4 = xmm1[3,0,0,0]
               	vpermilps	$0x3, %xmm2, %xmm5 # xmm5 = xmm2[3,0,0,0]
               	mulss	%xmm5, %xmm4
               	movss	%xmm4, -0x14(%rbp)
               	vextracti128	$0x1, %ymm1, %xmm4
               	vpermilps	$0x0, %xmm4, %xmm4 # xmm4 = xmm4[0,0,0,0]
               	vextracti128	$0x1, %ymm2, %xmm5
               	vpermilps	$0x0, %xmm5, %xmm5 # xmm5 = xmm5[0,0,0,0]
               	mulss	%xmm5, %xmm4
               	movss	%xmm4, -0x10(%rbp)
               	vextracti128	$0x1, %ymm1, %xmm4
               	vpermilps	$0x1, %xmm4, %xmm4 # xmm4 = xmm4[1,0,0,0]
               	vextracti128	$0x1, %ymm2, %xmm5
               	vpermilps	$0x1, %xmm5, %xmm5 # xmm5 = xmm5[1,0,0,0]
               	mulss	%xmm5, %xmm4
               	movss	%xmm4, -0xc(%rbp)
               	vextracti128	$0x1, %ymm1, %xmm4
               	vpermilps	$0x2, %xmm4, %xmm4 # xmm4 = xmm4[2,0,0,0]
               	vextracti128	$0x1, %ymm2, %xmm5
               	vpermilps	$0x2, %xmm5, %xmm5 # xmm5 = xmm5[2,0,0,0]
               	mulss	%xmm5, %xmm4
               	movss	%xmm4, -0x8(%rbp)
               	vextracti128	$0x1, %ymm1, %xmm1
               	vpermilps	$0x3, %xmm1, %xmm1 # xmm1 = xmm1[3,0,0,0]
               	vextracti128	$0x1, %ymm2, %xmm2
               	vpermilps	$0x3, %xmm2, %xmm2 # xmm2 = xmm2[3,0,0,0]
               	mulss	%xmm2, %xmm1
               	movss	%xmm1, -0x4(%rbp)
               	leaq	(%rsp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movss	0x20(%rsp), %xmm1
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm1
               	movss	0x24(%rsp), %xmm2
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm2
               	movss	0x28(%rsp), %xmm4
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm4
               	movss	0x2c(%rsp), %xmm5
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm5
               	movss	%xmm1, (%rsp)
               	movss	%xmm2, 0x4(%rsp)
               	movss	%xmm4, 0x8(%rsp)
               	movss	%xmm5, 0xc(%rsp)
               	movss	0x20(%rsp), %xmm1
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm1
               	movss	%xmm1, -0x10(%rbp)
               	movss	0x24(%rsp), %xmm1
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm1
               	movss	%xmm1, -0xc(%rbp)
               	movss	0x28(%rsp), %xmm1
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm1
               	movss	%xmm1, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	movss	0x2c(%rsp), %xmm1
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm1
               	movss	%xmm1, -0x4(%rbp)
               	leaq	(%rsp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movss	0x20(%rsp), %xmm1
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm1
               	movss	0x24(%rsp), %xmm2
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm2
               	movss	0x28(%rsp), %xmm4
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm4
               	movss	0x2c(%rsp), %xmm5
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm5
               	movss	%xmm1, (%rsp)
               	movss	%xmm2, 0x4(%rsp)
               	movss	%xmm4, 0x8(%rsp)
               	movss	%xmm5, 0xc(%rsp)
               	movss	0x20(%rsp), %xmm1
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm1
               	movss	%xmm1, -0x10(%rbp)
               	movss	0x24(%rsp), %xmm1
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm1
               	movss	%xmm1, -0xc(%rbp)
               	movss	0x28(%rsp), %xmm1
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm1
               	movss	%xmm1, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	movss	0x2c(%rsp), %xmm1
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm1
               	movss	%xmm1, -0x4(%rbp)
               	leaq	(%rsp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	vpermilpd	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0]
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm1
               	vpermilpd	$0x1, %xmm0, %xmm2 # xmm2 = xmm0[1,0]
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm2
               	leaq	(%rsp), %rcx
               	movsd	%xmm1, (%rsp)
               	movsd	%xmm2, 0x8(%rsp)
               	leaq	-0x10(%rbp), %rdx
               	vpermilpd	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0]
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm1
               	movsd	%xmm1, -0x10(%rbp)
               	vpermilpd	$0x1, %xmm0, %xmm1 # xmm1 = xmm0[1,0]
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm1
               	movsd	%xmm1, -0x8(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	vpermilpd	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0]
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm1
               	vpermilpd	$0x1, %xmm0, %xmm2 # xmm2 = xmm0[1,0]
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm2
               	leaq	(%rsp), %rcx
               	movsd	%xmm1, (%rsp)
               	movsd	%xmm2, 0x8(%rsp)
               	leaq	-0x10(%rbp), %rdx
               	vpermilpd	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0]
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm1
               	movsd	%xmm1, -0x10(%rbp)
               	vpermilpd	$0x1, %xmm0, %xmm1 # xmm1 = xmm0[1,0]
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm1
               	movsd	%xmm1, -0x8(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rax
               	movups	0x20(%rsp), %xmm1
               	movups	0x30(%rsp), %xmm2
               	mulps	%xmm2, %xmm1
               	leaq	0x40(%rsp), %rdx
               	movups	%xmm1, 0x40(%rsp)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	(%rsp), %xmm1
               	movups	0x30(%rsp), %xmm2
               	mulps	%xmm2, %xmm1
               	movups	%xmm1, (%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rax
               	movups	0x20(%rsp), %xmm1
               	movups	0x30(%rsp), %xmm2
               	addps	%xmm2, %xmm1
               	leaq	0x40(%rsp), %rdx
               	movups	%xmm1, 0x40(%rsp)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	(%rsp), %xmm1
               	movups	0x30(%rsp), %xmm2
               	addps	%xmm2, %xmm1
               	movups	%xmm1, (%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movapd	%xmm0, %xmm1
               	divpd	%xmm3, %xmm1
               	leaq	0x40(%rsp), %rcx
               	movups	%xmm1, 0x40(%rsp)
               	leaq	(%rsp), %rdx
               	movups	%xmm0, (%rsp)
               	movups	(%rsp), %xmm1
               	divpd	%xmm3, %xmm1
               	movups	%xmm1, (%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movss	0x40(%rsp), %xmm1
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm1
               	movss	0x44(%rsp), %xmm2
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm2
               	movss	0x48(%rsp), %xmm3
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm3
               	movss	0x4c(%rsp), %xmm4
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm4
               	movss	%xmm1, 0x40(%rsp)
               	movss	%xmm2, 0x44(%rsp)
               	movss	%xmm3, 0x48(%rsp)
               	movss	%xmm4, 0x4c(%rsp)
               	movss	0x20(%rsp), %xmm1
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm1
               	movss	0x24(%rsp), %xmm2
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm2
               	movss	0x28(%rsp), %xmm3
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm3
               	movss	0x2c(%rsp), %xmm4
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm4
               	leaq	(%rsp), %rdx
               	movss	%xmm1, (%rsp)
               	movss	%xmm2, 0x4(%rsp)
               	movss	%xmm3, 0x8(%rsp)
               	movss	%xmm4, 0xc(%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movss	0x20(%rsp), %xmm1
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movss	0x24(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	movss	0x28(%rsp), %xmm3
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm3
               	movss	0x2c(%rsp), %xmm4
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm4
               	leaq	(%rsp), %rcx
               	movss	%xmm1, (%rsp)
               	movss	%xmm2, 0x4(%rsp)
               	movss	%xmm3, 0x8(%rsp)
               	movss	%xmm4, 0xc(%rsp)
               	leaq	-0x10(%rbp), %rdx
               	movss	0x20(%rsp), %xmm1
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movss	%xmm1, -0x10(%rbp)
               	movss	0x24(%rsp), %xmm1
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movss	%xmm1, -0xc(%rbp)
               	movss	0x28(%rsp), %xmm1
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
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
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
               	leaq	(%rsp), %rcx
               	movsd	%xmm1, (%rsp)
               	movsd	%xmm2, 0x8(%rsp)
               	leaq	-0x10(%rbp), %rdx
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
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %r8
               	leaq	0x30(%rsp), %r9
               	movups	0x20(%rsp), %xmm0
               	movups	0x30(%rsp), %xmm1
               	addps	%xmm1, %xmm0
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	vpermilps	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0,0,0]
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm1
               	xorl	%ecx, %ecx
               	vmovd	%xmm1, %r11d
               	vmovd	%r11d, %xmm1
               	vpermilps	$0x1, %xmm0, %xmm2 # xmm2 = xmm0[1,0,0,0]
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x1, %r11d, %xmm1, %xmm1
               	vpermilps	$0x2, %xmm0, %xmm2 # xmm2 = xmm0[2,0,0,0]
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x2, %r11d, %xmm1, %xmm1
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	0x20(%rsp), %xmm1
               	subps	%xmm1, %xmm0
               	movups	%xmm0, (%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdi
               	movss	(%rdi), %xmm0
               	addq	%r9, %rcx
               	movss	(%rcx), %xmm1
               	vaddss	%xmm1, %xmm0, %xmm1
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movq	%rcx, %xmm15
               	vfmsub231ss	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm15) - xmm0
               	movss	%xmm0, (%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
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
