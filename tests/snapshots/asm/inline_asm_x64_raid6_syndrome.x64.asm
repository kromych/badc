
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
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%rdi, %r12
               	movq	%rsi, %r13
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rdi, %rax
               	jmp	<addr>
               	leaq	0x300(%rcx), %rdx
               	addq	%rax, %rdx
               	movzbq	(%rdx), %rdx
               	leaq	0x200(%rcx), %r8
               	leaq	(%r8,%rax), %r9
               	movzbq	(%r9), %rsi
               	xorq	%rdx, %rsi
               	movq	%rdx, %rbx
               	shlq	%rbx
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rbx, %rdx
               	movq	%rdx, %rbx
               	andq	$0xff, %rbx
               	movzbq	(%r9), %rdx
               	xorq	%rbx, %rdx
               	leaq	0x100(%rcx), %r8
               	leaq	(%r8,%rax), %r9
               	movzbq	(%r9), %rbx
               	xorq	%rbx, %rsi
               	movq	%rdx, %rbx
               	shlq	%rbx
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rbx, %rdx
               	movq	%rdx, %rbx
               	andq	$0xff, %rbx
               	movzbq	(%r9), %rdx
               	xorq	%rbx, %rdx
               	leaq	(%rcx), %r8
               	leaq	(%r8,%rax), %r9
               	movzbq	(%r9), %rbx
               	xorq	%rbx, %rsi
               	movq	%rdx, %rbx
               	shlq	%rbx
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rbx, %rdx
               	movq	%rdx, %rbx
               	andq	$0xff, %rbx
               	movzbq	(%r9), %rdx
               	xorq	%rbx, %rdx
               	leaq	(%r12,%rax), %r8
               	movb	%sil, (%r8)
               	leaq	(%r13,%rax), %rsi
               	movb	%dl, (%rsi)
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	movq	%rdi, %rdx
               	jmp	<addr>
               	incq	%rax
               	cmpq	$0x100, %rax            # imm = 0x100
               	jb	<addr>
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq

<avx2_syndrome>:
               	leaq	<rip>, %rdx
               	leaq	0x400(%rdx), %rdi
               	leaq	0x500(%rdx), %r8
               	xorq	%rcx, %rcx
               	vmovdqa	<rip>, %ymm0
               	vpxor	%ymm3, %ymm3, %ymm3
               	jmp	<addr>
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
               	testq	%rax, %rax
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
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	-0x10(%rbp), %eax
               	andq	$0xe0, %rax
               	xorq	$0xe0, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
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
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xc3, %r8d
               	movl	$0x3039, %eax           # imm = 0x3039
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	imulq	$0x41c64e6d, %rax, %rax # imm = 0x41C64E6D
               	movl	%eax, %eax
               	addq	$0x3039, %rax           # imm = 0x3039
               	movl	%eax, %eax
               	leaq	<rip>, %rsi
               	movslq	%edx, %rdi
               	shlq	$0x8, %rdi
               	addq	%rdi, %rsi
               	addq	%rcx, %rsi
               	movq	%rax, %rdi
               	shrq	$0x10, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi)
               	incq	%rcx
               	cmpq	$0x100, %rcx            # imm = 0x100
               	jb	<addr>
               	movslq	%edx, %rcx
               	leaq	0x1(%rcx), %rdx
               	cmpl	$0x4, %edx
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	imulq	$0x41c64e6d, %rax, %rax # imm = 0x41C64E6D
               	movl	%eax, %eax
               	addq	$0x3039, %rax           # imm = 0x3039
               	movl	%eax, %eax
               	leaq	<rip>, %rdx
               	addq	%rcx, %rdx
               	movq	%rax, %rsi
               	shrq	$0x10, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx)
               	incq	%rcx
               	cmpq	$0x100, %rcx            # imm = 0x100
               	jb	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	addq	%rax, %rcx
               	movl	$0x1d, %edx
               	movb	%dl, (%rcx)
               	incq	%rax
               	cmpq	$0x40, %rax
               	jb	<addr>
               	leaq	<rip>, %rax
               	leaq	(%rax), %rdi
               	xorq	%rdx, %rdx
               	movq	%r8, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, (%rdi)
               	leaq	<rip>, %rax
               	leaq	(%rax), %rdi
               	xorq	%rdx, %rdx
               	movq	%r8, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, (%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x1, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0x1(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x10, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0x1(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x2, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0x2(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x20, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0x2(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x3, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0x3(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x30, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0x3(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x4, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0x4(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x40, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0x4(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x5, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0x5(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x50, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0x5(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x6, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0x6(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x60, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0x6(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x7, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0x7(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x70, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0x7(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x8, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0x8(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x80, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0x8(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x9, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0x9(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x90, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0x9(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0xa, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0xa(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0xa0, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0xa(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0xb, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0xb(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0xb0, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0xb(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0xc, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0xc(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0xc0, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0xc(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0xd, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0xd(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0xd0, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0xd(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0xe, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0xe(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0xe0, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0xe(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0xf, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0xf(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0xf0, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%al, 0xf(%rdi)
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
               	jmp	<addr>
               	leaq	(%rcx,%rax), %rsi
               	movzbq	(%rsi), %rsi
               	leaq	(%rdx,%rax), %rdi
               	movzbq	(%rdi), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpq	$0x100, %rax            # imm = 0x100
               	jb	<addr>
               	leaq	<rip>, %rax
               	leaq	0x500(%rax), %rcx
               	leaq	<rip>, %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rcx,%rax), %rsi
               	movzbq	(%rsi), %rsi
               	leaq	(%rdx,%rax), %rdi
               	movzbq	(%rdi), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpq	$0x100, %rax            # imm = 0x100
               	jb	<addr>
               	callq	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	leaq	<rip>, %rax
               	addq	%rdi, %rax
               	movzbq	(%rax), %r8
               	leaq	<rip>, %rax
               	addq	%rdi, %rax
               	movzbq	(%rax), %rax
               	movl	$0xc3, %ecx
               	movq	%rax, -0x10(%rbp)
               	movq	%rcx, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpl	%eax, %r8d
               	jne	<addr>
               	incq	%rdi
               	cmpq	$0x100, %rdi            # imm = 0x100
               	jb	<addr>
               	cmpl	$0x2, %ebx
               	jge	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	leaq	0x400(%rdx), %rsi
               	addq	%rax, %rsi
               	addq	$0x500, %rdx            # imm = 0x500
               	addq	%rax, %rdx
               	leaq	<rip>, %rdi
               	addq	%rax, %rdi
               	movb	%cl, (%rdi)
               	movb	%cl, (%rdx)
               	movb	%cl, (%rsi)
               	incq	%rax
               	cmpq	$0x100, %rax            # imm = 0x100
               	jb	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	leaq	0x400(%rax), %rcx
               	leaq	<rip>, %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rcx,%rax), %rsi
               	movzbq	(%rsi), %rsi
               	leaq	(%rdx,%rax), %rdi
               	movzbq	(%rdi), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpq	$0x100, %rax            # imm = 0x100
               	jb	<addr>
               	leaq	<rip>, %rax
               	leaq	0x500(%rax), %rcx
               	leaq	<rip>, %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rcx,%rax), %rsi
               	movzbq	(%rsi), %rsi
               	leaq	(%rdx,%rax), %rdi
               	movzbq	(%rdi), %rdi
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
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	leaq	<rip>, %rax
               	addq	%rdi, %rax
               	movzbq	(%rax), %r8
               	leaq	<rip>, %rax
               	addq	%rdi, %rax
               	movzbq	(%rax), %rax
               	movl	$0xc3, %ecx
               	movq	%rax, -0x10(%rbp)
               	movq	%rcx, -0x8(%rbp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%cl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	shrq	%rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpl	%eax, %r8d
               	jne	<addr>
               	incq	%rdi
               	cmpq	$0x100, %rdi            # imm = 0x100
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
