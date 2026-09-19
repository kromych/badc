
inline_asm_x64_raid6_syndrome.x64:	file format elf64-x86-64

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

<ref_syndrome>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %r8
               	movq	%rsi, %r9
               	xorq	%rbx, %rbx
               	leaq	<rip>, %rcx
               	movq	%rbx, %rax
               	cmpq	$0x100, %rax            # imm = 0x100
               	jae	<addr>
               	leaq	0x300(%rcx), %rdx
               	movzbq	(%rdx,%rax), %rdx
               	leaq	0x200(%rcx), %rsi
               	movzbq	(%rsi,%rax), %rdi
               	xorq	%rdx, %rdi
               	movq	%rdx, %r12
               	shlq	%r12
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%r12, %rdx
               	andq	$0xff, %rdx
               	movzbq	(%rsi,%rax), %rsi
               	xorq	%rsi, %rdx
               	leaq	0x100(%rcx), %rsi
               	movzbq	(%rsi,%rax), %r12
               	xorq	%r12, %rdi
               	movq	%rdx, %r12
               	shlq	%r12
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%r12, %rdx
               	andq	$0xff, %rdx
               	movzbq	(%rsi,%rax), %rsi
               	xorq	%rsi, %rdx
               	leaq	(%rcx), %rsi
               	movzbq	(%rsi,%rax), %r12
               	xorq	%r12, %rdi
               	movq	%rdx, %r12
               	shlq	%r12
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	movq	%rbx, %rdx
               	jmp	<addr>
               	xorq	%r12, %rdx
               	andq	$0xff, %rdx
               	movzbq	(%rsi,%rax), %rsi
               	xorq	%rsi, %rdx
               	movb	%dil, (%r8,%rax)
               	movb	%dl, (%r9,%rax)
               	incq	%rax
               	cmpq	$0x100, %rax            # imm = 0x100
               	jb	<addr>
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq

<avx2_syndrome>:
               	leaq	<rip>, %rdx
               	leaq	0x400(%rdx), %rdi
               	leaq	0x500(%rdx), %r8
               	xorq	%rcx, %rcx
               	vmovdqa	<rip>, %ymm0
               	vpxor	%ymm3, %ymm3, %ymm3
               	cmpq	$0x100, %rcx            # imm = 0x100
               	jae	<addr>
               	leaq	0x300(%rdx), %rsi
               	leaq	(%rsi,%rcx), %rax
               	prefetchnta	(%rax)
               	leaq	(%rsi,%rcx), %rax
               	vmovdqa	(%rax), %ymm2
               	vmovdqa	%ymm2, %ymm4
               	leaq	0x200(%rdx), %rax
               	addq	%rcx, %rax
               	vmovdqa	(%rax), %ymm6
               	leaq	0x100(%rdx), %rax
               	addq	%rcx, %rax
               	prefetchnta	(%rax)
               	vpcmpgtb	%ymm4, %ymm3, %ymm5
               	vpaddb	%ymm4, %ymm4, %ymm4
               	vpand	%ymm0, %ymm5, %ymm5
               	vpxor	%ymm5, %ymm4, %ymm4
               	vpxor	%ymm6, %ymm2, %ymm2
               	vpxor	%ymm6, %ymm4, %ymm4
               	leaq	0x100(%rdx), %rax
               	addq	%rcx, %rax
               	vmovdqa	(%rax), %ymm6
               	leaq	(%rdx), %rax
               	addq	%rcx, %rax
               	prefetchnta	(%rax)
               	vpcmpgtb	%ymm4, %ymm3, %ymm5
               	vpaddb	%ymm4, %ymm4, %ymm4
               	vpand	%ymm0, %ymm5, %ymm5
               	vpxor	%ymm5, %ymm4, %ymm4
               	vpxor	%ymm6, %ymm2, %ymm2
               	vpxor	%ymm6, %ymm4, %ymm4
               	leaq	(%rdx), %rax
               	addq	%rcx, %rax
               	vmovdqa	(%rax), %ymm6
               	vpcmpgtb	%ymm4, %ymm3, %ymm5
               	vpaddb	%ymm4, %ymm4, %ymm4
               	vpand	%ymm0, %ymm5, %ymm5
               	vpxor	%ymm5, %ymm4, %ymm4
               	vpxor	%ymm6, %ymm2, %ymm2
               	vpxor	%ymm6, %ymm4, %ymm4
               	leaq	(%rdi,%rcx), %rax
               	vmovntdq	%ymm2, (%rax)
               	leaq	(%r8,%rcx), %rax
               	vmovntdq	%ymm4, (%rax)
               	addq	$0x20, %rcx
               	cmpq	$0x100, %rcx            # imm = 0x100
               	jb	<addr>
               	sfence
               	vzeroupper
               	retq

<avx2_table_mul>:
               	vpbroadcastb	<rip>, %ymm7
               	vbroadcasti128	<rip>, %ymm4 # ymm4 = mem[0,1,0,1]
               	vbroadcasti128	<rip>, %ymm5 # ymm5 = mem[0,1,0,1]
               	vmovdqa	<rip>, %ymm1
               	vpsraw	$0x4, %ymm1, %ymm3
               	vpand	%ymm7, %ymm1, %ymm1
               	vpand	%ymm7, %ymm3, %ymm3
               	vpshufb	%ymm1, %ymm4, %ymm1
               	vpshufb	%ymm3, %ymm5, %ymm3
               	vpxor	%ymm1, %ymm3, %ymm3
               	vmovdqa	%ymm3, <rip>
               	vmovdqa	<rip>, %ymm1
               	vpsraw	$0x4, %ymm1, %ymm3
               	vpand	%ymm7, %ymm1, %ymm1
               	vpand	%ymm7, %ymm3, %ymm3
               	vpshufb	%ymm1, %ymm4, %ymm1
               	vpshufb	%ymm3, %ymm5, %ymm3
               	vpxor	%ymm1, %ymm3, %ymm3
               	vmovdqa	%ymm3, <rip>
               	vmovdqa	<rip>, %ymm1
               	vpsraw	$0x4, %ymm1, %ymm3
               	vpand	%ymm7, %ymm1, %ymm1
               	vpand	%ymm7, %ymm3, %ymm3
               	vpshufb	%ymm1, %ymm4, %ymm1
               	vpshufb	%ymm3, %ymm5, %ymm3
               	vpxor	%ymm1, %ymm3, %ymm3
               	vmovdqa	%ymm3, <rip>
               	vmovdqa	<rip>, %ymm1
               	vpsraw	$0x4, %ymm1, %ymm3
               	vpand	%ymm7, %ymm1, %ymm1
               	vpand	%ymm7, %ymm3, %ymm3
               	vpshufb	%ymm1, %ymm4, %ymm1
               	vpshufb	%ymm3, %ymm5, %ymm3
               	vpxor	%ymm1, %ymm3, %ymm3
               	vmovdqa	%ymm3, <rip>
               	vmovdqa	<rip>, %ymm1
               	vpsraw	$0x4, %ymm1, %ymm3
               	vpand	%ymm7, %ymm1, %ymm1
               	vpand	%ymm7, %ymm3, %ymm3
               	vpshufb	%ymm1, %ymm4, %ymm1
               	vpshufb	%ymm3, %ymm5, %ymm3
               	vpxor	%ymm1, %ymm3, %ymm3
               	vmovdqa	%ymm3, <rip>
               	vmovdqa	<rip>, %ymm1
               	vpsraw	$0x4, %ymm1, %ymm3
               	vpand	%ymm7, %ymm1, %ymm1
               	vpand	%ymm7, %ymm3, %ymm3
               	vpshufb	%ymm1, %ymm4, %ymm1
               	vpshufb	%ymm3, %ymm5, %ymm3
               	vpxor	%ymm1, %ymm3, %ymm3
               	vmovdqa	%ymm3, <rip>
               	vmovdqa	<rip>, %ymm1
               	vpsraw	$0x4, %ymm1, %ymm3
               	vpand	%ymm7, %ymm1, %ymm1
               	vpand	%ymm7, %ymm3, %ymm3
               	vpshufb	%ymm1, %ymm4, %ymm1
               	vpshufb	%ymm3, %ymm5, %ymm3
               	vpxor	%ymm1, %ymm3, %ymm3
               	vmovdqa	%ymm3, <rip>
               	vmovdqa	<rip>, %ymm1
               	vpsraw	$0x4, %ymm1, %ymm3
               	vpand	%ymm7, %ymm1, %ymm1
               	vpand	%ymm7, %ymm3, %ymm3
               	vpshufb	%ymm1, %ymm4, %ymm1
               	vpshufb	%ymm3, %ymm5, %ymm3
               	vpxor	%ymm1, %ymm3, %ymm3
               	vmovdqa	%ymm3, <rip>
               	vzeroupper
               	retq

<avx512_syndrome>:
               	vmovdqa64	<rip>, %zmm0
               	vpxorq	%zmm1, %zmm1, %zmm1
               	prefetchnta	<rip>
               	vmovdqa64	<rip>, %zmm2
               	vmovdqa64	%zmm2, %zmm4
               	vmovdqa64	<rip>, %zmm6
               	prefetchnta	<rip>
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	vmovdqa64	<rip>, %zmm6
               	prefetchnta	<rip>
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	vmovdqa64	<rip>, %zmm6
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	vmovntdq	%zmm2, <rip>
               	vmovntdq	%zmm4, <rip>
               	prefetchnta	<rip>
               	vmovdqa64	<rip>, %zmm2
               	vmovdqa64	%zmm2, %zmm4
               	vmovdqa64	<rip>, %zmm6
               	prefetchnta	<rip>
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	vmovdqa64	<rip>, %zmm6
               	prefetchnta	<rip>
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	vmovdqa64	<rip>, %zmm6
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	vmovntdq	%zmm2, <rip>
               	vmovntdq	%zmm4, <rip>
               	prefetchnta	<rip>
               	vmovdqa64	<rip>, %zmm2
               	vmovdqa64	%zmm2, %zmm4
               	vmovdqa64	<rip>, %zmm6
               	prefetchnta	<rip>
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	vmovdqa64	<rip>, %zmm6
               	prefetchnta	<rip>
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	vmovdqa64	<rip>, %zmm6
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	vmovntdq	%zmm2, <rip>
               	vmovntdq	%zmm4, <rip>
               	prefetchnta	<rip>
               	vmovdqa64	<rip>, %zmm2
               	vmovdqa64	%zmm2, %zmm4
               	vmovdqa64	<rip>, %zmm6
               	prefetchnta	<rip>
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	vmovdqa64	<rip>, %zmm6
               	prefetchnta	<rip>
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	vmovdqa64	<rip>, %zmm6
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	vmovntdq	%zmm2, <rip>
               	vmovntdq	%zmm4, <rip>
               	sfence
               	vzeroupper
               	retq

<vector_level>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rax, %rax
               	xorq	%rcx, %rcx
               	cpuid
               	movl	%eax, -0x30(%rbp)
               	movl	%ebx, -0x28(%rbp)
               	movl	%ecx, -0x20(%rbp)
               	movl	%edx, -0x18(%rbp)
               	movl	-0x30(%rbp), %eax
               	cmpl	$0x7, %eax
               	jae	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	xorq	%rcx, %rcx
               	cpuid
               	movl	%eax, -0x30(%rbp)
               	movl	%ebx, -0x28(%rbp)
               	movl	%ecx, -0x20(%rbp)
               	movl	%edx, -0x18(%rbp)
               	movl	-0x20(%rbp), %eax
               	andq	$0x8000000, %rax        # imm = 0x8000000
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rcx, %rcx
               	xgetbv
               	movl	%eax, -0x10(%rbp)
               	movl	%edx, -0x8(%rbp)
               	movl	-0x10(%rbp), %eax
               	andq	$0x6, %rax
               	xorq	$0x6, %rax
               	testl	%eax, %eax
               	je	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x7, %eax
               	xorq	%rcx, %rcx
               	cpuid
               	movl	%eax, -0x30(%rbp)
               	movl	%ebx, -0x28(%rbp)
               	movl	%ecx, -0x20(%rbp)
               	movl	%edx, -0x18(%rbp)
               	movl	-0x28(%rbp), %eax
               	andq	$0x20, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	-0x28(%rbp), %eax
               	andq	$0x10000, %rax          # imm = 0x10000
               	testq	%rax, %rax
               	je	<addr>
               	movl	-0x28(%rbp), %eax
               	andq	$0x40000000, %rax       # imm = 0x40000000
               	testq	%rax, %rax
               	je	<addr>
               	movl	-0x10(%rbp), %eax
               	andq	$0xe0, %rax
               	xorq	$0xe0, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xc3, %edx
               	movl	$0x3039, %eax           # imm = 0x3039
               	xorq	%rdi, %rdi
               	cmpl	$0x4, %edi
               	jge	<addr>
               	xorq	%rcx, %rcx
               	cmpq	$0x100, %rcx            # imm = 0x100
               	jae	<addr>
               	imulq	$0x41c64e6d, %rax, %rax # imm = 0x41C64E6D
               	movl	%eax, %eax
               	addq	$0x3039, %rax           # imm = 0x3039
               	movl	%eax, %eax
               	leaq	<rip>, %rsi
               	movslq	%edi, %r8
               	shlq	$0x8, %r8
               	addq	%r8, %rsi
               	movq	%rax, %r8
               	shrq	$0x10, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rsi,%rcx)
               	incq	%rcx
               	cmpq	$0x100, %rcx            # imm = 0x100
               	jb	<addr>
               	incq	%rdi
               	cmpl	$0x4, %edi
               	jl	<addr>
               	xorq	%rcx, %rcx
               	cmpq	$0x100, %rcx            # imm = 0x100
               	jae	<addr>
               	imulq	$0x41c64e6d, %rax, %rax # imm = 0x41C64E6D
               	movl	%eax, %eax
               	addq	$0x3039, %rax           # imm = 0x3039
               	movl	%eax, %eax
               	leaq	<rip>, %rsi
               	movq	%rax, %rdi
               	shrq	$0x10, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi,%rcx)
               	incq	%rcx
               	cmpq	$0x100, %rcx            # imm = 0x100
               	jb	<addr>
               	xorq	%rax, %rax
               	cmpq	$0x40, %rax
               	jae	<addr>
               	leaq	<rip>, %rcx
               	movl	$0x1d, %esi
               	movb	%sil, (%rcx,%rax)
               	incq	%rax
               	cmpq	$0x40, %rax
               	jb	<addr>
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	xorq	%rsi, %rsi
               	movb	%sil, (%rax)
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movb	%sil, (%rax)
               	leaq	<rip>, %r8
               	movl	$0x1, %edi
               	movq	%rsi, %rcx
               	movq	%rdx, %rax
               	testq	%rdi, %rdi
               	je	<addr>
               	xorq	%rax, %rcx
               	movq	%rax, %rdi
               	shlq	%rdi
               	andq	$0x80, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1d, %eax
               	jmp	<addr>
               	movq	%rsi, %rax
               	xorq	%rdi, %rax
               	andq	$0xff, %rax
               	movq	%rsi, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movb	%cl, 0x1(%r8)
               	leaq	<rip>, %r9
               	movl	$0x10, %eax
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rsi, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0x1(%r9)
               	leaq	<rip>, %r9
               	movl	$0x2, %eax
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rsi, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0x2(%r9)
               	leaq	<rip>, %r9
               	movl	$0x20, %eax
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rsi, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0x2(%r9)
               	leaq	<rip>, %r9
               	movl	$0x3, %eax
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rsi, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0x3(%r9)
               	leaq	<rip>, %r9
               	movl	$0x30, %eax
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rsi, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0x3(%r9)
               	leaq	<rip>, %r9
               	movl	$0x4, %eax
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rsi, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0x4(%r9)
               	leaq	<rip>, %r9
               	movl	$0x40, %eax
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rsi, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0x4(%r9)
               	leaq	<rip>, %r9
               	movl	$0x5, %eax
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rsi, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0x5(%r9)
               	leaq	<rip>, %r9
               	movl	$0x50, %eax
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rsi, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0x5(%r9)
               	leaq	<rip>, %r9
               	movl	$0x6, %eax
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rsi, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0x6(%r9)
               	leaq	<rip>, %r9
               	movl	$0x60, %eax
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rsi, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0x6(%r9)
               	leaq	<rip>, %r9
               	movl	$0x7, %eax
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rsi, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0x7(%r9)
               	leaq	<rip>, %r9
               	movl	$0x70, %eax
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rsi, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0x7(%r9)
               	leaq	<rip>, %r9
               	movl	$0x8, %eax
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rsi, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0x8(%r9)
               	leaq	<rip>, %r9
               	movl	$0x80, %eax
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rsi, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0x8(%r9)
               	leaq	<rip>, %r9
               	movl	$0x9, %eax
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rsi, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0x9(%r9)
               	leaq	<rip>, %r9
               	movl	$0x90, %eax
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rsi, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0x9(%r9)
               	leaq	<rip>, %r9
               	movl	$0xa, %eax
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rsi, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0xa(%r9)
               	leaq	<rip>, %r9
               	movl	$0xa0, %eax
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rsi, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0xa(%r9)
               	leaq	<rip>, %r9
               	movl	$0xb, %eax
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rsi, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0xb(%r9)
               	leaq	<rip>, %r9
               	movl	$0xb0, %eax
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rsi, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0xb(%r9)
               	leaq	<rip>, %r9
               	movl	$0xc, %eax
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rsi, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0xc(%r9)
               	leaq	<rip>, %r9
               	movl	$0xc0, %eax
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rsi, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0xc(%r9)
               	leaq	<rip>, %r9
               	movl	$0xd, %eax
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rsi, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0xd(%r9)
               	leaq	<rip>, %r9
               	movl	$0xd0, %eax
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rsi, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0xd(%r9)
               	leaq	<rip>, %r9
               	movl	$0xe, %eax
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rsi, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0xe(%r9)
               	leaq	<rip>, %r9
               	movl	$0xe0, %eax
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rsi, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0xe(%r9)
               	leaq	<rip>, %r9
               	movl	$0xf, %eax
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rsi, %rcx
               	movq	%rsi, %r8
               	shlq	%r8
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0xf(%r9)
               	leaq	<rip>, %r8
               	movl	$0xf0, %eax
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %rdi
               	andq	$0x1, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorq	%rdx, %rcx
               	movq	%rdx, %rdi
               	shlq	%rdi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	jmp	<addr>
               	movq	%rsi, %rdx
               	xorq	%rdi, %rdx
               	andq	$0xff, %rdx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, 0xf(%r8)
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	callq	<addr>
               	movq	%rax, %rbx
               	cmpl	$0x1, %ebx
               	jge	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	callq	<addr>
               	leaq	<rip>, %rax
               	leaq	0x400(%rax), %rcx
               	leaq	<rip>, %rdx
               	xorq	%rax, %rax
               	cmpq	$0x100, %rax            # imm = 0x100
               	jae	<addr>
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpq	$0x100, %rax            # imm = 0x100
               	jb	<addr>
               	leaq	<rip>, %rax
               	leaq	0x500(%rax), %rcx
               	leaq	<rip>, %rdx
               	xorq	%rax, %rax
               	cmpq	$0x100, %rax            # imm = 0x100
               	jae	<addr>
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpq	$0x100, %rax            # imm = 0x100
               	jb	<addr>
               	callq	<addr>
               	xorq	%r8, %r8
               	cmpq	$0x100, %r8             # imm = 0x100
               	jae	<addr>
               	leaq	<rip>, %rax
               	movzbq	(%rax,%r8), %r9
               	leaq	<rip>, %rax
               	movzbq	(%rax,%r8), %rcx
               	movl	$0xc3, %eax
               	xorq	%rsi, %rsi
               	movq	%rsi, %rdx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %rdi
               	andq	$0x1, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorq	%rcx, %rdx
               	movq	%rcx, %rdi
               	shlq	%rdi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rsi, %rcx
               	xorq	%rdi, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	%edx, %r9d
               	jne	<addr>
               	incq	%r8
               	cmpq	$0x100, %r8             # imm = 0x100
               	jb	<addr>
               	cmpl	$0x2, %ebx
               	jge	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	cmpq	$0x100, %rax            # imm = 0x100
               	jae	<addr>
               	leaq	<rip>, %rdx
               	leaq	0x400(%rdx), %rsi
               	addq	$0x500, %rdx            # imm = 0x500
               	leaq	<rip>, %rdi
               	movb	%cl, (%rdi,%rax)
               	movb	%cl, (%rdx,%rax)
               	movb	%cl, (%rsi,%rax)
               	incq	%rax
               	cmpq	$0x100, %rax            # imm = 0x100
               	jb	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	leaq	0x400(%rax), %rcx
               	leaq	<rip>, %rdx
               	xorq	%rax, %rax
               	cmpq	$0x100, %rax            # imm = 0x100
               	jae	<addr>
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpq	$0x100, %rax            # imm = 0x100
               	jb	<addr>
               	leaq	<rip>, %rax
               	leaq	0x500(%rax), %rcx
               	leaq	<rip>, %rdx
               	xorq	%rax, %rax
               	cmpq	$0x100, %rax            # imm = 0x100
               	jae	<addr>
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpq	$0x100, %rax            # imm = 0x100
               	jb	<addr>
               	vpbroadcastb	<rip>, %zmm7
               	vbroadcasti64x2	<rip>, %zmm4 # zmm4 = mem[0,1,0,1,0,1,0,1]
               	vbroadcasti64x2	<rip>, %zmm5 # zmm5 = mem[0,1,0,1,0,1,0,1]
               	vmovdqa64	<rip>, %zmm1
               	vpsraw	$0x4, %zmm1, %zmm3
               	vpandq	%zmm7, %zmm1, %zmm1
               	vpandq	%zmm7, %zmm3, %zmm3
               	vpshufb	%zmm1, %zmm4, %zmm1
               	vpshufb	%zmm3, %zmm5, %zmm3
               	vpxorq	%zmm1, %zmm3, %zmm3
               	vmovdqa64	%zmm3, <rip>
               	vmovdqa64	<rip>, %zmm1
               	vpsraw	$0x4, %zmm1, %zmm3
               	vpandq	%zmm7, %zmm1, %zmm1
               	vpandq	%zmm7, %zmm3, %zmm3
               	vpshufb	%zmm1, %zmm4, %zmm1
               	vpshufb	%zmm3, %zmm5, %zmm3
               	vpxorq	%zmm1, %zmm3, %zmm3
               	vmovdqa64	%zmm3, <rip>
               	vmovdqa64	<rip>, %zmm1
               	vpsraw	$0x4, %zmm1, %zmm3
               	vpandq	%zmm7, %zmm1, %zmm1
               	vpandq	%zmm7, %zmm3, %zmm3
               	vpshufb	%zmm1, %zmm4, %zmm1
               	vpshufb	%zmm3, %zmm5, %zmm3
               	vpxorq	%zmm1, %zmm3, %zmm3
               	vmovdqa64	%zmm3, <rip>
               	vmovdqa64	<rip>, %zmm1
               	vpsraw	$0x4, %zmm1, %zmm3
               	vpandq	%zmm7, %zmm1, %zmm1
               	vpandq	%zmm7, %zmm3, %zmm3
               	vpshufb	%zmm1, %zmm4, %zmm1
               	vpshufb	%zmm3, %zmm5, %zmm3
               	vpxorq	%zmm1, %zmm3, %zmm3
               	vmovdqa64	%zmm3, <rip>
               	vzeroupper
               	xorq	%r8, %r8
               	cmpq	$0x100, %r8             # imm = 0x100
               	jae	<addr>
               	leaq	<rip>, %rax
               	movzbq	(%rax,%r8), %r9
               	leaq	<rip>, %rax
               	movzbq	(%rax,%r8), %rcx
               	movl	$0xc3, %eax
               	xorq	%rsi, %rsi
               	movq	%rsi, %rdx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %rdi
               	andq	$0x1, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorq	%rcx, %rdx
               	movq	%rcx, %rdi
               	shlq	%rdi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rsi, %rcx
               	xorq	%rdi, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	%edx, %r9d
               	jne	<addr>
               	incq	%r8
               	cmpq	$0x100, %r8             # imm = 0x100
               	jb	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
