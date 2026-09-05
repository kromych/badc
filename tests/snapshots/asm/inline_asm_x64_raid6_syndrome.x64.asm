
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
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	xorq	%rax, %rax
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	leaq	0x300(%rcx), %rdx
               	addq	%rax, %rdx
               	movzbq	(%rdx), %rdx
               	movq	%rdx, %rsi
               	andq	$0xff, %rsi
               	leaq	0x200(%rcx), %rdi
               	leaq	(%rdi,%rax), %r8
               	movzbq	(%r8), %rdx
               	movq	%rsi, %r9
               	xorq	%rdx, %r9
               	movq	%rsi, %rdx
               	andq	$0xff, %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	movq	%rdx, %rsi
               	andq	$0xff, %rsi
               	movzbq	(%r8), %rdx
               	xorq	%rsi, %rdx
               	movq	%r9, %r8
               	andq	$0xff, %r8
               	leaq	0x100(%rcx), %rsi
               	leaq	(%rsi,%rax), %rdi
               	movzbq	(%rdi), %r9
               	xorq	%r9, %r8
               	andq	$0xff, %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %r9
               	shlq	%r9
               	movslq	%r9d, %r9
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%r9, %rdx
               	movq	%rdx, %r9
               	andq	$0xff, %r9
               	movzbq	(%rdi), %rdx
               	xorq	%r9, %rdx
               	andq	$0xff, %r8
               	leaq	(%rcx), %rsi
               	leaq	(%rsi,%rax), %rdi
               	movzbq	(%rdi), %r9
               	xorq	%r9, %r8
               	andq	$0xff, %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %r9
               	shlq	%r9
               	movslq	%r9d, %r9
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%r9, %rdx
               	movq	%rdx, %r9
               	andq	$0xff, %r9
               	movzbq	(%rdi), %rdx
               	xorq	%r9, %rdx
               	leaq	(%rbx,%rax), %rsi
               	movq	%r8, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi)
               	leaq	(%r12,%rax), %rsi
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi)
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	incq	%rax
               	cmpq	$0x100, %rax            # imm = 0x100
               	jb	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<avx2_syndrome>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %rcx
               	leaq	0x400(%rcx), %rsi
               	leaq	0x500(%rcx), %rdi
               	leaq	<rip>, %rdx
               	xorq	%rax, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa	<rip>, %ymm0
               	movq	-0x10(%rbp), %rax
               	vpxor	%ymm3, %ymm3, %ymm3
               	jmp	<addr>
               	leaq	0x300(%rcx), %rdx
               	leaq	(%rdx,%rax), %r8
               	movq	%rax, -0x10(%rbp)
               	movq	%r8, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	prefetchnta	(%rax)
               	movq	-0x10(%rbp), %rax
               	addq	%rax, %rdx
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa	(%rax), %ymm2
               	movq	-0x10(%rbp), %rax
               	vmovdqa	%ymm2, %ymm4
               	leaq	0x200(%rcx), %rdx
               	addq	%rax, %rdx
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa	(%rax), %ymm6
               	movq	-0x10(%rbp), %rax
               	leaq	0x100(%rcx), %rdx
               	addq	%rax, %rdx
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	prefetchnta	(%rax)
               	movq	-0x10(%rbp), %rax
               	vpcmpgtb	%ymm4, %ymm3, %ymm5
               	vpaddb	%ymm4, %ymm4, %ymm4
               	vpand	%ymm0, %ymm5, %ymm5
               	vpxor	%ymm5, %ymm4, %ymm4
               	vpxor	%ymm6, %ymm2, %ymm2
               	vpxor	%ymm6, %ymm4, %ymm4
               	leaq	0x100(%rcx), %rdx
               	addq	%rax, %rdx
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa	(%rax), %ymm6
               	movq	-0x10(%rbp), %rax
               	leaq	(%rcx), %rdx
               	addq	%rax, %rdx
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	prefetchnta	(%rax)
               	movq	-0x10(%rbp), %rax
               	vpcmpgtb	%ymm4, %ymm3, %ymm5
               	vpaddb	%ymm4, %ymm4, %ymm4
               	vpand	%ymm0, %ymm5, %ymm5
               	vpxor	%ymm5, %ymm4, %ymm4
               	vpxor	%ymm6, %ymm2, %ymm2
               	vpxor	%ymm6, %ymm4, %ymm4
               	leaq	(%rcx), %rdx
               	addq	%rax, %rdx
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa	(%rax), %ymm6
               	movq	-0x10(%rbp), %rax
               	vpcmpgtb	%ymm4, %ymm3, %ymm5
               	vpaddb	%ymm4, %ymm4, %ymm4
               	vpand	%ymm0, %ymm5, %ymm5
               	vpxor	%ymm5, %ymm4, %ymm4
               	vpxor	%ymm6, %ymm2, %ymm2
               	vpxor	%ymm6, %ymm4, %ymm4
               	leaq	(%rsi,%rax), %rdx
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovntdq	%ymm2, (%rax)
               	movq	-0x10(%rbp), %rax
               	leaq	(%rdi,%rax), %rdx
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovntdq	%ymm4, (%rax)
               	movq	-0x10(%rbp), %rax
               	addq	$0x20, %rax
               	cmpq	$0x100, %rax            # imm = 0x100
               	jb	<addr>
               	sfence
               	vzeroupper
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<avx2_table_mul>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vpbroadcastb	<rip>, %ymm7
               	movq	-0x10(%rbp), %rax
               	leaq	<rip>, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vbroadcasti128	<rip>, %ymm4 # ymm4 = mem[0,1,0,1]
               	movq	-0x10(%rbp), %rax
               	leaq	<rip>, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vbroadcasti128	<rip>, %ymm5 # ymm5 = mem[0,1,0,1]
               	movq	-0x10(%rbp), %rax
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa	<rip>, %ymm1
               	movq	-0x10(%rbp), %rax
               	vpsraw	$0x4, %ymm1, %ymm3
               	vpand	%ymm7, %ymm1, %ymm1
               	vpand	%ymm7, %ymm3, %ymm3
               	vpshufb	%ymm1, %ymm4, %ymm1
               	vpshufb	%ymm3, %ymm5, %ymm3
               	vpxor	%ymm1, %ymm3, %ymm3
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa	%ymm3, <rip>
               	movq	-0x10(%rbp), %rax
               	leaq	<rip>, %rax
               	addq	$0x20, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa	<rip>, %ymm1
               	movq	-0x10(%rbp), %rax
               	vpsraw	$0x4, %ymm1, %ymm3
               	vpand	%ymm7, %ymm1, %ymm1
               	vpand	%ymm7, %ymm3, %ymm3
               	vpshufb	%ymm1, %ymm4, %ymm1
               	vpshufb	%ymm3, %ymm5, %ymm3
               	vpxor	%ymm1, %ymm3, %ymm3
               	leaq	<rip>, %rax
               	addq	$0x20, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa	%ymm3, <rip>
               	movq	-0x10(%rbp), %rax
               	leaq	<rip>, %rax
               	addq	$0x40, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa	<rip>, %ymm1
               	movq	-0x10(%rbp), %rax
               	vpsraw	$0x4, %ymm1, %ymm3
               	vpand	%ymm7, %ymm1, %ymm1
               	vpand	%ymm7, %ymm3, %ymm3
               	vpshufb	%ymm1, %ymm4, %ymm1
               	vpshufb	%ymm3, %ymm5, %ymm3
               	vpxor	%ymm1, %ymm3, %ymm3
               	leaq	<rip>, %rax
               	addq	$0x40, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa	%ymm3, <rip>
               	movq	-0x10(%rbp), %rax
               	leaq	<rip>, %rax
               	addq	$0x60, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa	<rip>, %ymm1
               	movq	-0x10(%rbp), %rax
               	vpsraw	$0x4, %ymm1, %ymm3
               	vpand	%ymm7, %ymm1, %ymm1
               	vpand	%ymm7, %ymm3, %ymm3
               	vpshufb	%ymm1, %ymm4, %ymm1
               	vpshufb	%ymm3, %ymm5, %ymm3
               	vpxor	%ymm1, %ymm3, %ymm3
               	leaq	<rip>, %rax
               	addq	$0x60, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa	%ymm3, <rip>
               	movq	-0x10(%rbp), %rax
               	leaq	<rip>, %rax
               	addq	$0x80, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa	<rip>, %ymm1
               	movq	-0x10(%rbp), %rax
               	vpsraw	$0x4, %ymm1, %ymm3
               	vpand	%ymm7, %ymm1, %ymm1
               	vpand	%ymm7, %ymm3, %ymm3
               	vpshufb	%ymm1, %ymm4, %ymm1
               	vpshufb	%ymm3, %ymm5, %ymm3
               	vpxor	%ymm1, %ymm3, %ymm3
               	leaq	<rip>, %rax
               	addq	$0x80, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa	%ymm3, <rip>
               	movq	-0x10(%rbp), %rax
               	leaq	<rip>, %rax
               	addq	$0xa0, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa	<rip>, %ymm1
               	movq	-0x10(%rbp), %rax
               	vpsraw	$0x4, %ymm1, %ymm3
               	vpand	%ymm7, %ymm1, %ymm1
               	vpand	%ymm7, %ymm3, %ymm3
               	vpshufb	%ymm1, %ymm4, %ymm1
               	vpshufb	%ymm3, %ymm5, %ymm3
               	vpxor	%ymm1, %ymm3, %ymm3
               	leaq	<rip>, %rax
               	addq	$0xa0, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa	%ymm3, <rip>
               	movq	-0x10(%rbp), %rax
               	leaq	<rip>, %rax
               	addq	$0xc0, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa	<rip>, %ymm1
               	movq	-0x10(%rbp), %rax
               	vpsraw	$0x4, %ymm1, %ymm3
               	vpand	%ymm7, %ymm1, %ymm1
               	vpand	%ymm7, %ymm3, %ymm3
               	vpshufb	%ymm1, %ymm4, %ymm1
               	vpshufb	%ymm3, %ymm5, %ymm3
               	vpxor	%ymm1, %ymm3, %ymm3
               	leaq	<rip>, %rax
               	addq	$0xc0, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa	%ymm3, <rip>
               	movq	-0x10(%rbp), %rax
               	leaq	<rip>, %rax
               	addq	$0xe0, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa	<rip>, %ymm1
               	movq	-0x10(%rbp), %rax
               	vpsraw	$0x4, %ymm1, %ymm3
               	vpand	%ymm7, %ymm1, %ymm1
               	vpand	%ymm7, %ymm3, %ymm3
               	vpshufb	%ymm1, %ymm4, %ymm1
               	vpshufb	%ymm3, %ymm5, %ymm3
               	vpxor	%ymm1, %ymm3, %ymm3
               	leaq	<rip>, %rax
               	addq	$0xe0, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa	%ymm3, <rip>
               	movq	-0x10(%rbp), %rax
               	vzeroupper
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<avx512_syndrome>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %rax
               	leaq	0x400(%rax), %rcx
               	leaq	0x500(%rax), %rdx
               	leaq	<rip>, %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa64	<rip>, %zmm0
               	movq	-0x10(%rbp), %rax
               	vpxorq	%zmm1, %zmm1, %zmm1
               	leaq	0x300(%rax), %rsi
               	leaq	(%rsi), %rdi
               	movq	%rax, -0x10(%rbp)
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	prefetchnta	<rip>
               	movq	-0x10(%rbp), %rax
               	addq	$0x0, %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa64	<rip>, %zmm2
               	movq	-0x10(%rbp), %rax
               	vmovdqa64	%zmm2, %zmm4
               	leaq	0x200(%rax), %rsi
               	addq	$0x0, %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa64	<rip>, %zmm6
               	movq	-0x10(%rbp), %rax
               	leaq	0x100(%rax), %rsi
               	addq	$0x0, %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	prefetchnta	<rip>
               	movq	-0x10(%rbp), %rax
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	leaq	0x100(%rax), %rsi
               	addq	$0x0, %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa64	<rip>, %zmm6
               	movq	-0x10(%rbp), %rax
               	leaq	(%rax), %rsi
               	addq	$0x0, %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	prefetchnta	<rip>
               	movq	-0x10(%rbp), %rax
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	leaq	(%rax), %rsi
               	addq	$0x0, %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa64	<rip>, %zmm6
               	movq	-0x10(%rbp), %rax
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	leaq	(%rcx), %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovntdq	%zmm2, <rip>
               	movq	-0x10(%rbp), %rax
               	leaq	(%rdx), %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovntdq	%zmm4, <rip>
               	movq	-0x10(%rbp), %rax
               	leaq	0x300(%rax), %rsi
               	leaq	0x40(%rsi), %rdi
               	movq	%rax, -0x10(%rbp)
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	prefetchnta	<rip>
               	movq	-0x10(%rbp), %rax
               	addq	$0x40, %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa64	<rip>, %zmm2
               	movq	-0x10(%rbp), %rax
               	vmovdqa64	%zmm2, %zmm4
               	leaq	0x200(%rax), %rsi
               	addq	$0x40, %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa64	<rip>, %zmm6
               	movq	-0x10(%rbp), %rax
               	leaq	0x100(%rax), %rsi
               	addq	$0x40, %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	prefetchnta	<rip>
               	movq	-0x10(%rbp), %rax
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	leaq	0x100(%rax), %rsi
               	addq	$0x40, %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa64	<rip>, %zmm6
               	movq	-0x10(%rbp), %rax
               	leaq	(%rax), %rsi
               	addq	$0x40, %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	prefetchnta	<rip>
               	movq	-0x10(%rbp), %rax
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	leaq	(%rax), %rsi
               	addq	$0x40, %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa64	<rip>, %zmm6
               	movq	-0x10(%rbp), %rax
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	leaq	0x40(%rcx), %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovntdq	%zmm2, <rip>
               	movq	-0x10(%rbp), %rax
               	leaq	0x40(%rdx), %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovntdq	%zmm4, <rip>
               	movq	-0x10(%rbp), %rax
               	leaq	0x300(%rax), %rsi
               	leaq	0x80(%rsi), %rdi
               	movq	%rax, -0x10(%rbp)
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	prefetchnta	<rip>
               	movq	-0x10(%rbp), %rax
               	addq	$0x80, %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa64	<rip>, %zmm2
               	movq	-0x10(%rbp), %rax
               	vmovdqa64	%zmm2, %zmm4
               	leaq	0x200(%rax), %rsi
               	addq	$0x80, %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa64	<rip>, %zmm6
               	movq	-0x10(%rbp), %rax
               	leaq	0x100(%rax), %rsi
               	addq	$0x80, %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	prefetchnta	<rip>
               	movq	-0x10(%rbp), %rax
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	leaq	0x100(%rax), %rsi
               	addq	$0x80, %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa64	<rip>, %zmm6
               	movq	-0x10(%rbp), %rax
               	leaq	(%rax), %rsi
               	addq	$0x80, %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	prefetchnta	<rip>
               	movq	-0x10(%rbp), %rax
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	leaq	(%rax), %rsi
               	addq	$0x80, %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa64	<rip>, %zmm6
               	movq	-0x10(%rbp), %rax
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	leaq	0x80(%rcx), %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovntdq	%zmm2, <rip>
               	movq	-0x10(%rbp), %rax
               	leaq	0x80(%rdx), %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovntdq	%zmm4, <rip>
               	movq	-0x10(%rbp), %rax
               	leaq	0x300(%rax), %rsi
               	leaq	0xc0(%rsi), %rdi
               	movq	%rax, -0x10(%rbp)
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	prefetchnta	<rip>
               	movq	-0x10(%rbp), %rax
               	addq	$0xc0, %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa64	<rip>, %zmm2
               	movq	-0x10(%rbp), %rax
               	vmovdqa64	%zmm2, %zmm4
               	leaq	0x200(%rax), %rsi
               	addq	$0xc0, %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa64	<rip>, %zmm6
               	movq	-0x10(%rbp), %rax
               	leaq	0x100(%rax), %rsi
               	addq	$0xc0, %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	prefetchnta	<rip>
               	movq	-0x10(%rbp), %rax
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	leaq	0x100(%rax), %rsi
               	addq	$0xc0, %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa64	<rip>, %zmm6
               	movq	-0x10(%rbp), %rax
               	leaq	(%rax), %rsi
               	addq	$0xc0, %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	prefetchnta	<rip>
               	movq	-0x10(%rbp), %rax
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	addq	$0x0, %rax
               	addq	$0xc0, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovdqa64	<rip>, %zmm6
               	movq	-0x10(%rbp), %rax
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	leaq	0xc0(%rcx), %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovntdq	%zmm2, <rip>
               	movq	-0x10(%rbp), %rax
               	leaq	0xc0(%rdx), %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	vmovntdq	%zmm4, <rip>
               	movq	-0x10(%rbp), %rax
               	sfence
               	vzeroupper
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<vector_level>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	leaq	-0x30(%rbp), %rcx
               	leaq	-0x28(%rbp), %rdx
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x18(%rbp), %rdi
               	xorq	%rax, %rax
               	movq	%rax, -0x90(%rbp)
               	movq	%rcx, -0x88(%rbp)
               	movq	%rdx, -0x80(%rbp)
               	movq	%rbx, -0x78(%rbp)
               	movq	%rcx, -0x70(%rbp)
               	movq	%rdx, -0x68(%rbp)
               	movq	%rsi, -0x60(%rbp)
               	movq	%rdi, -0x58(%rbp)
               	movq	%rax, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rcx
               	cpuid
               	movq	-0x70(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x68(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x60(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x58(%rbp), %r10
               	movl	%edx, (%r10)
               	movq	-0x90(%rbp), %rax
               	movq	-0x88(%rbp), %rcx
               	movq	-0x80(%rbp), %rdx
               	movq	-0x78(%rbp), %rbx
               	movl	-0x30(%rbp), %eax
               	cmpl	$0x7, %eax
               	jae	<addr>
               	xorq	%rax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x18(%rbp), %rsi
               	movl	$0x1, %edi
               	xorq	%r8, %r8
               	movq	%rax, -0x90(%rbp)
               	movq	%rcx, -0x88(%rbp)
               	movq	%rdx, -0x80(%rbp)
               	movq	%rbx, -0x78(%rbp)
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rdx, -0x60(%rbp)
               	movq	%rsi, -0x58(%rbp)
               	movq	%rdi, -0x50(%rbp)
               	movq	%r8, -0x48(%rbp)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rcx
               	cpuid
               	movq	-0x70(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x68(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x60(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x58(%rbp), %r10
               	movl	%edx, (%r10)
               	movq	-0x90(%rbp), %rax
               	movq	-0x88(%rbp), %rcx
               	movq	-0x80(%rbp), %rdx
               	movq	-0x78(%rbp), %rbx
               	movl	-0x20(%rbp), %eax
               	andq	$0x8000000, %rax        # imm = 0x8000000
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movq	%rax, -0x90(%rbp)
               	movq	%rcx, -0x88(%rbp)
               	movq	%rdx, -0x80(%rbp)
               	movq	%rax, -0x78(%rbp)
               	movq	%rcx, -0x70(%rbp)
               	movq	%rdx, -0x68(%rbp)
               	movq	-0x68(%rbp), %rcx
               	xgetbv
               	movq	-0x78(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x70(%rbp), %r10
               	movl	%edx, (%r10)
               	movq	-0x90(%rbp), %rax
               	movq	-0x88(%rbp), %rcx
               	movq	-0x80(%rbp), %rdx
               	movl	-0x10(%rbp), %eax
               	andq	$0x6, %rax
               	xorq	$0x6, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x18(%rbp), %rsi
               	movl	$0x7, %edi
               	xorq	%r8, %r8
               	movq	%rax, -0x90(%rbp)
               	movq	%rcx, -0x88(%rbp)
               	movq	%rdx, -0x80(%rbp)
               	movq	%rbx, -0x78(%rbp)
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rdx, -0x60(%rbp)
               	movq	%rsi, -0x58(%rbp)
               	movq	%rdi, -0x50(%rbp)
               	movq	%r8, -0x48(%rbp)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rcx
               	cpuid
               	movq	-0x70(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x68(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x60(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x58(%rbp), %r10
               	movl	%edx, (%r10)
               	movq	-0x90(%rbp), %rax
               	movq	-0x88(%rbp), %rcx
               	movq	-0x80(%rbp), %rdx
               	movq	-0x78(%rbp), %rbx
               	movl	-0x28(%rbp), %eax
               	andq	$0x20, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
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
               	movl	%eax, %eax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xc3, %r8d
               	movl	$0x3039, %ecx           # imm = 0x3039
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%ecx, %ecx
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	movl	%ecx, %ecx
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %ecx
               	leaq	<rip>, %rsi
               	movslq	%edx, %rdi
               	shlq	$0x8, %rdi
               	addq	%rdi, %rsi
               	addq	%rax, %rsi
               	movl	%ecx, %edi
               	shrq	$0x10, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi)
               	incq	%rax
               	cmpq	$0x100, %rax            # imm = 0x100
               	jb	<addr>
               	movslq	%edx, %rax
               	leaq	0x1(%rax), %rdx
               	cmpl	$0x4, %edx
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%ecx, %ecx
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	movl	%ecx, %ecx
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %ecx
               	leaq	<rip>, %rdx
               	addq	%rax, %rdx
               	movl	%ecx, %esi
               	shrq	$0x10, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx)
               	incq	%rax
               	cmpq	$0x100, %rax            # imm = 0x100
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
               	xorq	%rcx, %rcx
               	movq	%r8, -0x10(%rbp)
               	movq	%rcx, -0x8(%rbp)
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, (%rdi)
               	leaq	<rip>, %rax
               	leaq	(%rax), %rdi
               	xorq	%rcx, %rcx
               	movq	%r8, -0x10(%rbp)
               	movq	%rcx, -0x8(%rbp)
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, (%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x1, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0x1(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x10, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0x1(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x2, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0x2(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x20, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0x2(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x3, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0x3(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x30, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0x3(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x4, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0x4(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x40, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0x4(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x5, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0x5(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x50, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0x5(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x6, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0x6(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x60, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0x6(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x7, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0x7(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x70, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0x7(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x8, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0x8(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x80, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0x8(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x9, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0x9(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x90, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0x9(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0xa, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0xa(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0xa0, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0xa(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0xb, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0xb(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0xb0, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0xb(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0xc, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0xc(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0xc0, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0xc(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0xd, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0xd(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0xd0, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0xd(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0xe, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0xe(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0xe0, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0xe(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0xf, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0xf(%rdi)
               	leaq	<rip>, %rdi
               	movl	$0xf0, %eax
               	movq	%r8, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
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
               	addq	$0x40, %rsp
               	popq	%rbp
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
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	cmpl	%eax, %r8d
               	jne	<addr>
               	incq	%rdi
               	cmpq	$0x100, %rdi            # imm = 0x100
               	jb	<addr>
               	cmpl	$0x2, %ebx
               	jge	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
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
               	leaq	<rip>, %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	vpbroadcastb	<rip>, %zmm7
               	movq	-0x30(%rbp), %rax
               	leaq	<rip>, %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	vbroadcasti64x2	<rip>, %zmm4 # zmm4 = mem[0,1,0,1,0,1,0,1]
               	movq	-0x30(%rbp), %rax
               	leaq	<rip>, %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	vbroadcasti64x2	<rip>, %zmm5 # zmm5 = mem[0,1,0,1,0,1,0,1]
               	movq	-0x30(%rbp), %rax
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	vmovdqa64	<rip>, %zmm1
               	movq	-0x30(%rbp), %rax
               	vpsraw	$0x4, %zmm1, %zmm3
               	vpandq	%zmm7, %zmm1, %zmm1
               	vpandq	%zmm7, %zmm3, %zmm3
               	vpshufb	%zmm1, %zmm4, %zmm1
               	vpshufb	%zmm3, %zmm5, %zmm3
               	vpxorq	%zmm1, %zmm3, %zmm3
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	vmovdqa64	%zmm3, <rip>
               	movq	-0x30(%rbp), %rax
               	leaq	<rip>, %rax
               	addq	$0x40, %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	vmovdqa64	<rip>, %zmm1
               	movq	-0x30(%rbp), %rax
               	vpsraw	$0x4, %zmm1, %zmm3
               	vpandq	%zmm7, %zmm1, %zmm1
               	vpandq	%zmm7, %zmm3, %zmm3
               	vpshufb	%zmm1, %zmm4, %zmm1
               	vpshufb	%zmm3, %zmm5, %zmm3
               	vpxorq	%zmm1, %zmm3, %zmm3
               	leaq	<rip>, %rax
               	addq	$0x40, %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	vmovdqa64	%zmm3, <rip>
               	movq	-0x30(%rbp), %rax
               	leaq	<rip>, %rax
               	addq	$0x80, %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	vmovdqa64	<rip>, %zmm1
               	movq	-0x30(%rbp), %rax
               	vpsraw	$0x4, %zmm1, %zmm3
               	vpandq	%zmm7, %zmm1, %zmm1
               	vpandq	%zmm7, %zmm3, %zmm3
               	vpshufb	%zmm1, %zmm4, %zmm1
               	vpshufb	%zmm3, %zmm5, %zmm3
               	vpxorq	%zmm1, %zmm3, %zmm3
               	leaq	<rip>, %rax
               	addq	$0x80, %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	vmovdqa64	%zmm3, <rip>
               	movq	-0x30(%rbp), %rax
               	leaq	<rip>, %rax
               	addq	$0xc0, %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	vmovdqa64	<rip>, %zmm1
               	movq	-0x30(%rbp), %rax
               	vpsraw	$0x4, %zmm1, %zmm3
               	vpandq	%zmm7, %zmm1, %zmm1
               	vpandq	%zmm7, %zmm3, %zmm3
               	vpshufb	%zmm1, %zmm4, %zmm1
               	vpshufb	%zmm3, %zmm5, %zmm3
               	vpxorq	%zmm1, %zmm3, %zmm3
               	leaq	<rip>, %rax
               	addq	$0xc0, %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	vmovdqa64	%zmm3, <rip>
               	movq	-0x30(%rbp), %rax
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
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	movzbq	-0x10(%rbp), %rdx
               	xorq	%rdx, %rax
               	movzbq	-0x10(%rbp), %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movb	%dl, -0x10(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shrq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	cmpl	%eax, %r8d
               	jne	<addr>
               	incq	%rdi
               	cmpq	$0x100, %rdi            # imm = 0x100
               	jb	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
