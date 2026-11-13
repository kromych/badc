
x86_simd_values_under_pressure.x64:	file format elf64-x86-64

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
               	subq	$0x440, %rsp            # imm = 0x440
               	xorl	%eax, %eax
               	movl	$0x9e3779b9, %ecx       # imm = 0x9E3779B9
               	leaq	-0x280(%rbp), %rsi
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
               	leaq	-0x280(%rbp), %rsi
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
               	leaq	-0x440(%rbp), %rdi
               	addq	%rdi, %rdx
               	movups	(%rsi), %xmm0
               	movups	%xmm0, (%rdx)
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movups	-0x440(%rbp), %xmm14
               	movups	%xmm14, 0x170(%rsp)
               	movups	-0x430(%rbp), %xmm14
               	movups	%xmm14, 0x180(%rsp)
               	movups	-0x420(%rbp), %xmm14
               	movups	%xmm14, 0x190(%rsp)
               	movups	-0x410(%rbp), %xmm14
               	movups	%xmm14, 0x1a0(%rsp)
               	movups	-0x400(%rbp), %xmm14
               	movups	%xmm14, 0x1b0(%rsp)
               	movups	-0x3f0(%rbp), %xmm14
               	movups	%xmm14, 0x150(%rsp)
               	movups	-0x3e0(%rbp), %xmm14
               	movups	%xmm14, 0x160(%rsp)
               	movups	-0x3d0(%rbp), %xmm12
               	movups	-0x3c0(%rbp), %xmm11
               	movups	-0x3b0(%rbp), %xmm10
               	movups	-0x3a0(%rbp), %xmm9
               	movups	-0x390(%rbp), %xmm8
               	movups	-0x380(%rbp), %xmm7
               	movups	-0x370(%rbp), %xmm6
               	movups	-0x360(%rbp), %xmm5
               	movups	-0x350(%rbp), %xmm1
               	movups	-0x340(%rbp), %xmm4
               	movups	-0x330(%rbp), %xmm3
               	movups	-0x320(%rbp), %xmm2
               	movups	-0x310(%rbp), %xmm0
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
               	movups	0x1b0(%rsp), %xmm14
               	movups	0x1a0(%rsp), %xmm15
               	vpand	%xmm15, %xmm14, %xmm14
               	movups	%xmm14, 0x1b0(%rsp)
               	movups	0x1b0(%rsp), %xmm14
               	movups	0x150(%rsp), %xmm15
               	vpaddd	%xmm15, %xmm14, %xmm14
               	movups	%xmm14, 0x150(%rsp)
               	movl	$0x3, %ecx
               	vmovd	%ecx, %xmm14
               	movups	%xmm14, 0x140(%rsp)
               	xorl	%ecx, %ecx
               	movups	0x140(%rsp), %xmm14
               	vpinsrd	$0x1, %ecx, %xmm14, %xmm14
               	movups	%xmm14, 0x140(%rsp)
               	movups	0x140(%rsp), %xmm14
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
               	leaq	-0x140(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rdx
               	leaq	-0x280(%rbp), %rsi
               	addq	%rcx, %rsi
               	movl	(%rsi), %esi
               	movl	%esi, (%rdx)
               	leaq	-0x280(%rbp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	movl	0x4(%rdi), %edi
               	movl	%edi, 0x4(%rdx)
               	leaq	-0x140(%rbp), %rdx
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
               	movl	-0x140(%rbp), %eax
               	movl	-0x10(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	%eax, -0x140(%rbp)
               	movl	-0x13c(%rbp), %eax
               	movl	-0xc(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	%eax, -0x13c(%rbp)
               	movl	-0x138(%rbp), %eax
               	movl	-0x8(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	%eax, -0x138(%rbp)
               	movl	-0x134(%rbp), %eax
               	movl	-0x4(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	%eax, -0x134(%rbp)
               	movl	-0x130(%rbp), %eax
               	movl	-0x140(%rbp), %ecx
               	xorq	%rcx, %rax
               	movl	%eax, -0x130(%rbp)
               	movl	-0x12c(%rbp), %eax
               	movl	-0x13c(%rbp), %ecx
               	xorq	%rcx, %rax
               	movl	%eax, -0x12c(%rbp)
               	movl	-0x128(%rbp), %eax
               	movl	-0x138(%rbp), %ecx
               	xorq	%rcx, %rax
               	movl	%eax, -0x128(%rbp)
               	movl	-0x124(%rbp), %eax
               	movl	-0x134(%rbp), %ecx
               	xorq	%rcx, %rax
               	movl	%eax, -0x124(%rbp)
               	movl	-0x120(%rbp), %eax
               	movl	-0x130(%rbp), %ecx
               	subq	%rcx, %rax
               	movl	%eax, -0x120(%rbp)
               	movl	-0x11c(%rbp), %eax
               	movl	-0x12c(%rbp), %ecx
               	subq	%rcx, %rax
               	movl	%eax, -0x11c(%rbp)
               	movl	-0x118(%rbp), %eax
               	movl	-0x128(%rbp), %ecx
               	subq	%rcx, %rax
               	movl	%eax, -0x118(%rbp)
               	movl	-0x114(%rbp), %eax
               	movl	-0x124(%rbp), %ecx
               	subq	%rcx, %rax
               	movl	%eax, -0x114(%rbp)
               	movl	-0x110(%rbp), %eax
               	shlq	$0x7, %rax
               	movl	-0x120(%rbp), %ecx
               	shrq	$0x19, %rcx
               	orq	%rcx, %rax
               	movl	%eax, -0x110(%rbp)
               	movl	-0x10c(%rbp), %eax
               	shlq	$0x7, %rax
               	movl	-0x11c(%rbp), %ecx
               	shrq	$0x19, %rcx
               	orq	%rcx, %rax
               	movl	%eax, -0x10c(%rbp)
               	movl	-0x108(%rbp), %eax
               	shlq	$0x7, %rax
               	movl	-0x118(%rbp), %ecx
               	shrq	$0x19, %rcx
               	orq	%rcx, %rax
               	movl	%eax, -0x108(%rbp)
               	movl	-0x104(%rbp), %eax
               	shlq	$0x7, %rax
               	movl	-0x114(%rbp), %ecx
               	shrq	$0x19, %rcx
               	orq	%rcx, %rax
               	movl	%eax, -0x104(%rbp)
               	movl	-0x100(%rbp), %eax
               	movl	-0x110(%rbp), %ecx
               	andq	%rcx, %rax
               	movl	%eax, -0x100(%rbp)
               	movl	-0xfc(%rbp), %eax
               	movl	-0x10c(%rbp), %ecx
               	andq	%rcx, %rax
               	movl	%eax, -0xfc(%rbp)
               	movl	-0xf8(%rbp), %eax
               	movl	-0x108(%rbp), %ecx
               	andq	%rcx, %rax
               	movl	%eax, -0xf8(%rbp)
               	movl	-0xf4(%rbp), %eax
               	movl	-0x104(%rbp), %ecx
               	andq	%rcx, %rax
               	movl	%eax, -0xf4(%rbp)
               	movl	-0x100(%rbp), %eax
               	movl	-0xf0(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	%eax, -0xf0(%rbp)
               	movl	-0xfc(%rbp), %eax
               	movl	-0xec(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	%eax, -0xec(%rbp)
               	movl	-0xf8(%rbp), %eax
               	movl	-0xe8(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	%eax, -0xe8(%rbp)
               	movl	-0xf4(%rbp), %eax
               	movl	-0xe4(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	%eax, -0xe4(%rbp)
               	movl	-0xe0(%rbp), %eax
               	shlq	$0x3, %rax
               	movl	%eax, -0xe0(%rbp)
               	movl	-0xdc(%rbp), %eax
               	shlq	$0x3, %rax
               	movl	%eax, -0xdc(%rbp)
               	movl	-0xd8(%rbp), %eax
               	shlq	$0x3, %rax
               	movl	%eax, -0xd8(%rbp)
               	movl	-0xd4(%rbp), %eax
               	shlq	$0x3, %rax
               	movl	%eax, -0xd4(%rbp)
               	movl	-0xc4(%rbp), %eax
               	movl	-0xc8(%rbp), %ecx
               	movl	-0xcc(%rbp), %edx
               	movl	-0xd0(%rbp), %esi
               	movl	%eax, -0xd0(%rbp)
               	movl	%ecx, -0xcc(%rbp)
               	movl	%edx, -0xc8(%rbp)
               	movl	%esi, -0xc4(%rbp)
               	movl	-0xc0(%rbp), %eax
               	movl	-0xd0(%rbp), %ecx
               	imulq	%rcx, %rax
               	movl	%eax, -0xc0(%rbp)
               	movl	-0xbc(%rbp), %eax
               	movl	-0xcc(%rbp), %ecx
               	imulq	%rcx, %rax
               	movl	%eax, -0xbc(%rbp)
               	movl	-0xb8(%rbp), %eax
               	movl	-0xc8(%rbp), %ecx
               	imulq	%rcx, %rax
               	movl	%eax, -0xb8(%rbp)
               	movl	-0xb8(%rbp), %eax
               	movl	-0xb4(%rbp), %ecx
               	movl	-0xc4(%rbp), %edx
               	imulq	%rdx, %rcx
               	movl	%ecx, -0xb4(%rbp)
               	leaq	-0x140(%rbp), %rcx
               	movl	%eax, -0xac(%rbp)
               	xorl	%eax, %eax
               	leaq	0xa0(%rcx), %rdx
               	movl	(%rdx,%rax,4), %esi
               	leaq	-0x140(%rbp), %rcx
               	leaq	0x90(%rcx), %rdi
               	movl	(%rdi,%rax,4), %edi
               	cmpl	%edi, %esi
               	jbe	<addr>
               	addq	$0xa0, %rcx
               	movl	(%rcx,%rax,4), %ecx
               	jmp	<addr>
               	leaq	-0x140(%rbp), %rcx
               	addq	$0x90, %rcx
               	movl	(%rcx,%rax,4), %ecx
               	movl	%ecx, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x140(%rbp), %rdx
               	leaq	0xb0(%rdx), %rcx
               	movl	(%rcx,%rax,4), %esi
               	addq	$0xa0, %rdx
               	movl	(%rdx,%rax,4), %edx
               	cmpl	%edx, %esi
               	jge	<addr>
               	movl	(%rcx,%rax,4), %edx
               	jmp	<addr>
               	leaq	-0x140(%rbp), %rdx
               	addq	$0xa0, %rdx
               	movl	(%rdx,%rax,4), %edx
               	movl	%edx, (%rcx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movl	-0x80(%rbp), %eax
               	movl	-0x90(%rbp), %ecx
               	movl	-0x7c(%rbp), %edx
               	movl	-0x8c(%rbp), %esi
               	movl	%eax, -0x80(%rbp)
               	movl	%ecx, -0x7c(%rbp)
               	movl	%edx, -0x78(%rbp)
               	movl	%esi, -0x74(%rbp)
               	movl	-0x70(%rbp), %eax
               	movl	-0x80(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	%eax, -0x70(%rbp)
               	movl	-0x6c(%rbp), %eax
               	movl	-0x7c(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	%eax, -0x6c(%rbp)
               	movl	-0x68(%rbp), %eax
               	movl	-0x78(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	%eax, -0x68(%rbp)
               	movl	-0x64(%rbp), %eax
               	movl	-0x74(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	%eax, -0x64(%rbp)
               	movl	-0x60(%rbp), %eax
               	movl	-0x70(%rbp), %ecx
               	xorq	%rcx, %rax
               	movl	%eax, -0x60(%rbp)
               	movl	-0x5c(%rbp), %eax
               	movl	-0x6c(%rbp), %ecx
               	xorq	%rcx, %rax
               	movl	%eax, -0x5c(%rbp)
               	movl	-0x58(%rbp), %eax
               	movl	-0x68(%rbp), %ecx
               	xorq	%rcx, %rax
               	movl	%eax, -0x58(%rbp)
               	movl	-0x54(%rbp), %eax
               	movl	-0x64(%rbp), %ecx
               	xorq	%rcx, %rax
               	movl	%eax, -0x54(%rbp)
               	movq	$-0x1, -0x50(%rbp)
               	leaq	-0x140(%rbp), %rdx
               	movq	$-0x1, -0x48(%rbp)
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
               	leaq	-0x140(%rbp), %rcx
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
               	leaq	-0x140(%rbp), %rcx
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
               	leaq	-0x140(%rbp), %rcx
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
               	movups	%xmm14, -0x440(%rbp)
               	movups	0x180(%rsp), %xmm14
               	movups	%xmm14, -0x430(%rbp)
               	movups	0x190(%rsp), %xmm14
               	movups	%xmm14, -0x420(%rbp)
               	movups	0x1a0(%rsp), %xmm14
               	movups	%xmm14, -0x410(%rbp)
               	movups	0x1b0(%rsp), %xmm14
               	movups	%xmm14, -0x400(%rbp)
               	movups	0x150(%rsp), %xmm14
               	movups	%xmm14, -0x3f0(%rbp)
               	movups	0x160(%rsp), %xmm14
               	movups	%xmm14, -0x3e0(%rbp)
               	movups	%xmm12, -0x3d0(%rbp)
               	movups	%xmm11, -0x3c0(%rbp)
               	movups	%xmm10, -0x3b0(%rbp)
               	movups	%xmm9, -0x3a0(%rbp)
               	movups	%xmm8, -0x390(%rbp)
               	movups	%xmm7, -0x380(%rbp)
               	movups	%xmm6, -0x370(%rbp)
               	movups	%xmm5, -0x360(%rbp)
               	movups	%xmm1, -0x350(%rbp)
               	leaq	-0x440(%rbp), %r9
               	movups	%xmm4, -0x340(%rbp)
               	movups	%xmm3, -0x330(%rbp)
               	movups	%xmm2, -0x320(%rbp)
               	movups	%xmm0, -0x310(%rbp)
               	xorl	%r8d, %r8d
               	xorl	%eax, %eax
               	movq	%r8, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%r9,%rcx), %rdx
               	movups	(%rdx), %xmm0
               	leaq	-0x150(%rbp), %rsi
               	movups	%xmm0, -0x150(%rbp)
               	movl	(%rsi,%rax,4), %esi
               	leaq	-0x140(%rbp), %rdi
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
               	leave
               	retq
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm0
               	sqrtss	%xmm0, %xmm0
               	vpermilps	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0,0,0]
               	movl	$0x40800000, %eax       # imm = 0x40800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	vpermilps	$0x1, %xmm0, %xmm1 # xmm1 = xmm0[1,0,0,0]
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1f, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	leaq	0x1(%r8), %rax
               	leave
               	retq
