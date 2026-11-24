
x86_simd_values_under_pressure.x64:	file format elf64-x86-64

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
               	subq	$0x438, %rsp            # imm = 0x438
               	xorl	%eax, %eax
               	movl	$0x9e3779b9, %ecx       # imm = 0x9E3779B9
               	leaq	0x1b0(%rsp), %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %rsi
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	leaq	0x1(%rdi), %r8
               	movq	%r8, %r9
               	imulq	%rcx, %r9
               	movl	%r9d, (%rsi)
               	incq	%r8
               	imulq	%rcx, %r8
               	movl	%r8d, 0x4(%rsi)
               	leaq	0x1b0(%rsp), %rsi
               	addq	%rsi, %rdx
               	addq	$0x2, %rdi
               	incq	%rdi
               	imulq	%rcx, %rdi
               	movl	%edi, 0x8(%rdx)
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %rsi
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	addq	$0x3, %rdi
               	incq	%rdi
               	imulq	%rcx, %rdi
               	movl	%edi, 0xc(%rsi)
               	leaq	(%rsp), %rdi
               	addq	%rdi, %rdx
               	movups	(%rsi), %xmm0
               	movups	%xmm0, (%rdx)
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movups	(%rsp), %xmm14
               	movups	%xmm14, 0x170(%rsp)
               	movups	0x10(%rsp), %xmm14
               	movups	%xmm14, 0x180(%rsp)
               	movups	0x20(%rsp), %xmm14
               	movups	%xmm14, 0x190(%rsp)
               	movups	0x30(%rsp), %xmm14
               	movups	%xmm14, 0x1a0(%rsp)
               	movups	0x40(%rsp), %xmm13
               	movups	0x50(%rsp), %xmm14
               	movups	%xmm14, 0x150(%rsp)
               	movups	0x60(%rsp), %xmm14
               	movups	%xmm14, 0x160(%rsp)
               	movups	0x70(%rsp), %xmm12
               	movups	0x80(%rsp), %xmm11
               	movups	0x90(%rsp), %xmm10
               	movups	0xa0(%rsp), %xmm9
               	movups	0xb0(%rsp), %xmm8
               	movups	0xc0(%rsp), %xmm7
               	movups	0xd0(%rsp), %xmm6
               	movups	0xe0(%rsp), %xmm5
               	movups	0xf0(%rsp), %xmm1
               	movups	0x100(%rsp), %xmm4
               	movups	0x110(%rsp), %xmm3
               	movups	0x120(%rsp), %xmm2
               	movups	0x130(%rsp), %xmm0
               	movups	0x170(%rsp), %xmm14
               	vpaddd	%xmm0, %xmm14, %xmm14
               	movups	%xmm14, 0x170(%rsp)
               	movups	0x180(%rsp), %xmm14
               	movups	0x170(%rsp), %xmm15
               	vpxor	%xmm15, %xmm14, %xmm14
               	movups	%xmm14, 0x180(%rsp)
               	movups	0x190(%rsp), %xmm14
               	movups	0x180(%rsp), %xmm15
               	vpsubd	%xmm15, %xmm14, %xmm14
               	movups	%xmm14, 0x190(%rsp)
               	movups	0x1a0(%rsp), %xmm15
               	pslld	$0x7, %xmm15
               	movups	%xmm15, 0x1a0(%rsp)
               	movups	0x190(%rsp), %xmm15
               	psrld	$0x19, %xmm15
               	movups	%xmm15, 0x140(%rsp)
               	movups	0x1a0(%rsp), %xmm14
               	movups	0x140(%rsp), %xmm15
               	vpor	%xmm15, %xmm14, %xmm14
               	movups	%xmm14, 0x1a0(%rsp)
               	movups	0x1a0(%rsp), %xmm15
               	vpand	%xmm15, %xmm13, %xmm13
               	movups	0x150(%rsp), %xmm15
               	vpaddd	%xmm15, %xmm13, %xmm14
               	movups	%xmm14, 0x150(%rsp)
               	movl	$0x3, %ecx
               	vmovd	%ecx, %xmm14
               	movups	%xmm14, 0x140(%rsp)
               	xorl	%ecx, %ecx
               	movups	0x140(%rsp), %xmm14
               	vpinsrd	$0x1, %ecx, %xmm14, %xmm14
               	movups	%xmm14, 0x140(%rsp)
               	vmovq	%xmm14, %rcx
               	movl	$0x40, %edx
               	cmpq	$0x40, %rcx
               	cmovaq	%rdx, %rcx
               	movups	0x160(%rsp), %xmm15
               	movq	%rcx, %xmm14
               	pslld	%xmm14, %xmm15
               	movups	%xmm15, 0x160(%rsp)
               	pshufd	$0x1b, %xmm12, %xmm12   # xmm12 = xmm12[3,2,1,0]
               	vpmulld	%xmm12, %xmm11, %xmm11
               	pextrd	$0x2, %xmm11, %ecx
               	movslq	%ecx, %rcx
               	pinsrd	$0x1, %ecx, %xmm10
               	vpmaxud	%xmm10, %xmm9, %xmm9
               	vpminsd	%xmm9, %xmm8, %xmm8
               	vpunpckldq	%xmm8, %xmm7, %xmm7 # xmm7 = xmm7[0],xmm8[0],xmm7[1],xmm8[1]
               	vpaddd	%xmm7, %xmm6, %xmm6
               	vpxor	%xmm5, %xmm6, %xmm5
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	vpsubd	%xmm5, %xmm4, %xmm4
               	vpaddd	%xmm4, %xmm3, %xmm3
               	vpxor	%xmm3, %xmm2, %xmm2
               	vpaddd	%xmm2, %xmm0, %xmm0
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	0x2f0(%rsp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rdx
               	leaq	0x1b0(%rsp), %rsi
               	addq	%rcx, %rsi
               	movl	(%rsi), %esi
               	movl	%esi, (%rdx)
               	leaq	0x1b0(%rsp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	movl	0x4(%rdi), %edi
               	movl	%edi, 0x4(%rdx)
               	leaq	0x2f0(%rsp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rsi
               	movl	0x8(%rsi), %r8d
               	movl	%r8d, 0x8(%rdi)
               	addq	%rdx, %rcx
               	movl	0xc(%rsi), %edx
               	movl	%edx, 0xc(%rcx)
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	xorl	%r8d, %r8d
               	movl	0x2f0(%rsp), %eax
               	movl	0x420(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	%eax, 0x2f0(%rsp)
               	movl	0x2f4(%rsp), %eax
               	movl	0x424(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	%eax, 0x2f4(%rsp)
               	movl	0x2f8(%rsp), %eax
               	movl	0x428(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	%eax, 0x2f8(%rsp)
               	movl	0x2fc(%rsp), %eax
               	movl	0x42c(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	%eax, 0x2fc(%rsp)
               	movl	0x300(%rsp), %eax
               	movl	0x2f0(%rsp), %ecx
               	xorq	%rcx, %rax
               	movl	%eax, 0x300(%rsp)
               	movl	0x304(%rsp), %eax
               	movl	0x2f4(%rsp), %ecx
               	xorq	%rcx, %rax
               	movl	%eax, 0x304(%rsp)
               	movl	0x308(%rsp), %eax
               	movl	0x2f8(%rsp), %ecx
               	xorq	%rcx, %rax
               	movl	%eax, 0x308(%rsp)
               	movl	0x30c(%rsp), %eax
               	movl	0x2fc(%rsp), %ecx
               	xorq	%rcx, %rax
               	movl	%eax, 0x30c(%rsp)
               	movl	0x310(%rsp), %eax
               	movl	0x300(%rsp), %ecx
               	subq	%rcx, %rax
               	movl	%eax, 0x310(%rsp)
               	movl	0x314(%rsp), %eax
               	movl	0x304(%rsp), %ecx
               	subq	%rcx, %rax
               	movl	%eax, 0x314(%rsp)
               	movl	0x318(%rsp), %eax
               	movl	0x308(%rsp), %ecx
               	subq	%rcx, %rax
               	movl	%eax, 0x318(%rsp)
               	movl	0x31c(%rsp), %eax
               	movl	0x30c(%rsp), %ecx
               	subq	%rcx, %rax
               	movl	%eax, 0x31c(%rsp)
               	movl	0x320(%rsp), %eax
               	shlq	$0x7, %rax
               	movl	0x310(%rsp), %ecx
               	shrq	$0x19, %rcx
               	orq	%rcx, %rax
               	movl	%eax, 0x320(%rsp)
               	movl	0x324(%rsp), %eax
               	shlq	$0x7, %rax
               	movl	0x314(%rsp), %ecx
               	shrq	$0x19, %rcx
               	orq	%rcx, %rax
               	movl	%eax, 0x324(%rsp)
               	movl	0x328(%rsp), %eax
               	shlq	$0x7, %rax
               	movl	0x318(%rsp), %ecx
               	shrq	$0x19, %rcx
               	orq	%rcx, %rax
               	movl	%eax, 0x328(%rsp)
               	movl	0x32c(%rsp), %eax
               	shlq	$0x7, %rax
               	movl	0x31c(%rsp), %ecx
               	shrq	$0x19, %rcx
               	orq	%rcx, %rax
               	movl	%eax, 0x32c(%rsp)
               	movl	0x330(%rsp), %eax
               	movl	0x320(%rsp), %ecx
               	andq	%rcx, %rax
               	movl	%eax, 0x330(%rsp)
               	movl	0x334(%rsp), %eax
               	movl	0x324(%rsp), %ecx
               	andq	%rcx, %rax
               	movl	%eax, 0x334(%rsp)
               	movl	0x338(%rsp), %eax
               	movl	0x328(%rsp), %ecx
               	andq	%rcx, %rax
               	movl	%eax, 0x338(%rsp)
               	movl	0x33c(%rsp), %eax
               	movl	0x32c(%rsp), %ecx
               	andq	%rcx, %rax
               	movl	%eax, 0x33c(%rsp)
               	movl	0x330(%rsp), %eax
               	addl	%eax, 0x340(%rsp)
               	movl	0x334(%rsp), %eax
               	addl	%eax, 0x344(%rsp)
               	movl	0x338(%rsp), %eax
               	addl	%eax, 0x348(%rsp)
               	movl	0x33c(%rsp), %eax
               	addl	%eax, 0x34c(%rsp)
               	movl	0x350(%rsp), %eax
               	shlq	$0x3, %rax
               	movl	%eax, 0x350(%rsp)
               	movl	0x354(%rsp), %eax
               	shlq	$0x3, %rax
               	movl	%eax, 0x354(%rsp)
               	movl	0x358(%rsp), %eax
               	shlq	$0x3, %rax
               	movl	%eax, 0x358(%rsp)
               	movl	0x35c(%rsp), %eax
               	shlq	$0x3, %rax
               	movl	%eax, 0x35c(%rsp)
               	movl	0x36c(%rsp), %eax
               	movl	0x368(%rsp), %ecx
               	movl	0x364(%rsp), %edx
               	movl	0x360(%rsp), %esi
               	movl	%eax, 0x360(%rsp)
               	movl	%ecx, 0x364(%rsp)
               	movl	%edx, 0x368(%rsp)
               	movl	%esi, 0x36c(%rsp)
               	movl	0x370(%rsp), %edx
               	movl	%eax, %eax
               	imulq	%rdx, %rax
               	movl	%eax, 0x370(%rsp)
               	movl	0x374(%rsp), %eax
               	movl	%ecx, %ecx
               	imulq	%rcx, %rax
               	movl	%eax, 0x374(%rsp)
               	movl	0x378(%rsp), %eax
               	movl	0x368(%rsp), %ecx
               	imulq	%rcx, %rax
               	movl	%eax, 0x378(%rsp)
               	movl	%eax, %eax
               	movl	0x37c(%rsp), %ecx
               	movl	0x36c(%rsp), %edx
               	imulq	%rdx, %rcx
               	movl	%ecx, 0x37c(%rsp)
               	leaq	0x2f0(%rsp), %rcx
               	movl	%eax, 0x384(%rsp)
               	xorl	%eax, %eax
               	leaq	0xa0(%rcx), %rdx
               	jmp	<addr>
               	movl	%ecx, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	(%rdx,%rax,4), %esi
               	leaq	0x2f0(%rsp), %rcx
               	leaq	0x90(%rcx), %rdi
               	movl	(%rdi,%rax,4), %edi
               	cmpl	%edi, %esi
               	jbe	<addr>
               	addq	$0xa0, %rcx
               	movl	(%rcx,%rax,4), %ecx
               	jmp	<addr>
               	leaq	0x2f0(%rsp), %rcx
               	addq	$0x90, %rcx
               	movl	(%rcx,%rax,4), %ecx
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	%ecx, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	0x2f0(%rsp), %rdx
               	leaq	0xb0(%rdx), %rsi
               	movl	(%rsi,%rax,4), %ecx
               	addq	$0xa0, %rdx
               	movl	(%rdx,%rax,4), %edx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	leaq	0x2f0(%rsp), %rcx
               	addq	$0xa0, %rcx
               	movl	(%rcx,%rax,4), %ecx
               	jmp	<addr>
               	movl	0x3b0(%rsp), %eax
               	movl	0x3a0(%rsp), %ecx
               	movl	0x3b4(%rsp), %edx
               	movl	0x3a4(%rsp), %esi
               	movl	%eax, 0x3b0(%rsp)
               	movl	%ecx, 0x3b4(%rsp)
               	movl	%edx, 0x3b8(%rsp)
               	movl	%esi, 0x3bc(%rsp)
               	movl	0x3c0(%rsp), %edx
               	movl	%eax, %eax
               	addq	%rdx, %rax
               	movl	%eax, 0x3c0(%rsp)
               	movl	0x3c4(%rsp), %eax
               	movl	%ecx, %ecx
               	addq	%rcx, %rax
               	movl	%eax, 0x3c4(%rsp)
               	movl	0x3c8(%rsp), %eax
               	movl	0x3b8(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	%eax, 0x3c8(%rsp)
               	movl	0x3cc(%rsp), %eax
               	movl	0x3bc(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	%eax, 0x3cc(%rsp)
               	movl	0x3d0(%rsp), %eax
               	movl	0x3c0(%rsp), %ecx
               	xorq	%rcx, %rax
               	movl	%eax, 0x3d0(%rsp)
               	movl	0x3d4(%rsp), %eax
               	movl	0x3c4(%rsp), %ecx
               	xorq	%rcx, %rax
               	movl	%eax, 0x3d4(%rsp)
               	movl	0x3d8(%rsp), %eax
               	movl	0x3c8(%rsp), %ecx
               	xorq	%rcx, %rax
               	movl	%eax, 0x3d8(%rsp)
               	movl	0x3dc(%rsp), %eax
               	movl	0x3cc(%rsp), %ecx
               	xorq	%rcx, %rax
               	movl	%eax, 0x3dc(%rsp)
               	movq	$-0x1, 0x3e0(%rsp)
               	leaq	0x2f0(%rsp), %rdx
               	movq	$-0x1, 0x3e8(%rsp)
               	xorl	%eax, %eax
               	leaq	0x100(%rdx), %rcx
               	addq	$0xe0, %rdx
               	movl	(%rcx,%rax,4), %esi
               	movl	(%rdx,%rax,4), %edi
               	subq	%rdi, %rsi
               	movl	%esi, (%rcx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	0x2f0(%rsp), %rcx
               	leaq	0x110(%rcx), %rdx
               	movl	(%rdx,%rax,4), %esi
               	addq	$0x100, %rcx            # imm = 0x100
               	movl	(%rcx,%rax,4), %ecx
               	addq	%rsi, %rcx
               	movl	%ecx, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	0x2f0(%rsp), %rcx
               	leaq	0x120(%rcx), %rdx
               	movl	(%rdx,%rax,4), %esi
               	addq	$0x110, %rcx            # imm = 0x110
               	movl	(%rcx,%rax,4), %ecx
               	xorq	%rsi, %rcx
               	movl	%ecx, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	0x2f0(%rsp), %rcx
               	leaq	0x130(%rcx), %rdx
               	movl	(%rdx,%rax,4), %esi
               	addq	$0x120, %rcx            # imm = 0x120
               	movl	(%rcx,%rax,4), %ecx
               	addq	%rsi, %rcx
               	movl	%ecx, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	incq	%r8
               	cmpl	$0x4, %r8d
               	jl	<addr>
               	movups	0x170(%rsp), %xmm14
               	movups	%xmm14, (%rsp)
               	movups	0x180(%rsp), %xmm14
               	movups	%xmm14, 0x10(%rsp)
               	movups	0x190(%rsp), %xmm14
               	movups	%xmm14, 0x20(%rsp)
               	movups	0x1a0(%rsp), %xmm14
               	movups	%xmm14, 0x30(%rsp)
               	movups	%xmm13, 0x40(%rsp)
               	movups	0x150(%rsp), %xmm14
               	movups	%xmm14, 0x50(%rsp)
               	movups	0x160(%rsp), %xmm14
               	movups	%xmm14, 0x60(%rsp)
               	movups	%xmm12, 0x70(%rsp)
               	movups	%xmm11, 0x80(%rsp)
               	movups	%xmm10, 0x90(%rsp)
               	movups	%xmm9, 0xa0(%rsp)
               	movups	%xmm8, 0xb0(%rsp)
               	movups	%xmm7, 0xc0(%rsp)
               	movups	%xmm6, 0xd0(%rsp)
               	movups	%xmm5, 0xe0(%rsp)
               	movups	%xmm1, 0xf0(%rsp)
               	leaq	(%rsp), %r9
               	movups	%xmm4, 0x100(%rsp)
               	movups	%xmm3, 0x110(%rsp)
               	movups	%xmm2, 0x120(%rsp)
               	movups	%xmm0, 0x130(%rsp)
               	xorl	%r8d, %r8d
               	xorl	%eax, %eax
               	movq	%r8, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%r9,%rcx), %rdx
               	movups	(%rdx), %xmm0
               	movups	%xmm0, 0x2e0(%rsp)
               	movl	0x2e0(%rsp,%rax,4), %esi
               	leaq	0x2f0(%rsp), %rdi
               	addq	%rcx, %rdi
               	movl	(%rdi,%rax,4), %edi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	incq	%r8
               	cmpl	$0x14, %r8d
               	jl	<addr>
               	vpcmpeqd	%xmm0, %xmm0, %xmm0
               	vpcmpeqd	%xmm0, %xmm1, %xmm0
               	pmovmskb	%xmm0, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x1e, %eax
               	addq	$0x438, %rsp            # imm = 0x438
               	retq
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm0
               	sqrtss	%xmm0, %xmm0
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm2
               	jp	<addr>
               	jne	<addr>
               	vpermilps	$0x1, %xmm0, %xmm2 # xmm2 = xmm0[1,0,0,0]
               	movss	<rip>, %xmm3
               	ucomiss	%xmm3, %xmm2
               	jp	<addr>
               	jne	<addr>
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1f, %eax
               	addq	$0x438, %rsp            # imm = 0x438
               	retq
               	xorl	%eax, %eax
               	addq	$0x438, %rsp            # imm = 0x438
               	retq
               	leaq	0x1(%r8), %rax
               	addq	$0x438, %rsp            # imm = 0x438
               	retq
