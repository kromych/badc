
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
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r8
               	movq	%rsi, %r9
               	xorl	%ebx, %ebx
               	leaq	<rip>, %rcx
               	movq	%rbx, %rax
               	cmpl	$0x100, %eax            # imm = 0x100
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
               	movzbq	(%rcx,%rax), %rsi
               	xorq	%rdi, %rsi
               	movq	%rdx, %rdi
               	shlq	%rdi
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	movq	%rbx, %rdx
               	jmp	<addr>
               	xorq	%rdi, %rdx
               	andq	$0xff, %rdx
               	movzbq	(%rcx,%rax), %rdi
               	xorq	%rdi, %rdx
               	movb	%sil, (%r8,%rax)
               	movb	%dl, (%r9,%rax)
               	incq	%rax
               	cmpl	$0x100, %eax            # imm = 0x100
               	jb	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

<avx2_syndrome>:
               	leaq	<rip>, %rdx
               	leaq	0x400(%rdx), %rdi
               	leaq	0x500(%rdx), %r8
               	xorl	%ecx, %ecx
               	vmovdqa	<rip>, %ymm0
               	vpxor	%ymm3, %ymm3, %ymm3
               	cmpl	$0x100, %ecx            # imm = 0x100
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
               	leaq	(%rdx,%rcx), %rax
               	prefetchnta	(%rax)
               	vpcmpgtb	%ymm4, %ymm3, %ymm5
               	vpaddb	%ymm4, %ymm4, %ymm4
               	vpand	%ymm0, %ymm5, %ymm5
               	vpxor	%ymm5, %ymm4, %ymm4
               	vpxor	%ymm6, %ymm2, %ymm2
               	vpxor	%ymm6, %ymm4, %ymm4
               	leaq	(%rdx,%rcx), %rax
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
               	cmpl	$0x100, %ecx            # imm = 0x100
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
               	subq	$0x38, %rsp
               	pushq	%rbx
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	%eax, -0x30(%rbp)
               	movl	%ebx, -0x28(%rbp)
               	movl	%ecx, -0x20(%rbp)
               	movl	%edx, -0x18(%rbp)
               	movl	-0x30(%rbp), %eax
               	cmpl	$0x7, %eax
               	jae	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	%eax, -0x30(%rbp)
               	movl	%ebx, -0x28(%rbp)
               	movl	%ecx, -0x20(%rbp)
               	movl	%edx, -0x18(%rbp)
               	movl	-0x20(%rbp), %eax
               	andq	$0x8000000, %rax        # imm = 0x8000000
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%ecx, %ecx
               	xgetbv
               	movl	%eax, -0x10(%rbp)
               	movl	%edx, -0x8(%rbp)
               	movl	-0x10(%rbp), %eax
               	andq	$0x6, %rax
               	xorq	$0x6, %rax
               	testl	%eax, %eax
               	je	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	%eax, -0x30(%rbp)
               	movl	%ebx, -0x28(%rbp)
               	movl	%ecx, -0x20(%rbp)
               	movl	%edx, -0x18(%rbp)
               	movl	-0x28(%rbp), %eax
               	andq	$0x20, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
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
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0xc3, %edx
               	movl	$0x3039, %eax           # imm = 0x3039
               	xorl	%esi, %esi
               	cmpl	$0x4, %esi
               	jge	<addr>
               	xorl	%ecx, %ecx
               	cmpl	$0x100, %ecx            # imm = 0x100
               	jae	<addr>
               	imulq	$0x41c64e6d, %rax, %rax # imm = 0x41C64E6D
               	addq	$0x3039, %rax           # imm = 0x3039
               	leaq	<rip>, %rdi
               	movq	%rsi, %r8
               	shlq	$0x8, %r8
               	addq	%r8, %rdi
               	movl	%eax, %r8d
               	shrq	$0x10, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi,%rcx)
               	incq	%rcx
               	cmpl	$0x100, %ecx            # imm = 0x100
               	jb	<addr>
               	incq	%rsi
               	cmpl	$0x4, %esi
               	jl	<addr>
               	xorl	%ecx, %ecx
               	cmpl	$0x100, %ecx            # imm = 0x100
               	jae	<addr>
               	imulq	$0x41c64e6d, %rax, %rax # imm = 0x41C64E6D
               	addq	$0x3039, %rax           # imm = 0x3039
               	leaq	<rip>, %rsi
               	movl	%eax, %edi
               	shrq	$0x10, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi,%rcx)
               	incq	%rcx
               	cmpl	$0x100, %ecx            # imm = 0x100
               	jb	<addr>
               	xorl	%eax, %eax
               	cmpl	$0x40, %eax
               	jae	<addr>
               	leaq	<rip>, %rcx
               	movb	$0x1d, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x40, %eax
               	jb	<addr>
               	leaq	<rip>, %rax
               	xorl	%esi, %esi
               	movb	%sil, (%rax)
               	leaq	<rip>, %rax
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
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rcx, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%sil, 0x1(%r9)
               	leaq	<rip>, %r9
               	movl	$0x2, %eax
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rcx, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%sil, 0x2(%r9)
               	leaq	<rip>, %r9
               	movl	$0x20, %eax
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rcx, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%sil, 0x2(%r9)
               	leaq	<rip>, %r9
               	movl	$0x3, %eax
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rcx, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%sil, 0x3(%r9)
               	leaq	<rip>, %r9
               	movl	$0x30, %eax
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rcx, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%sil, 0x3(%r9)
               	leaq	<rip>, %r9
               	movl	$0x4, %eax
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rcx, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%sil, 0x4(%r9)
               	leaq	<rip>, %r9
               	movl	$0x40, %eax
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rcx, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%sil, 0x4(%r9)
               	leaq	<rip>, %r9
               	movl	$0x5, %eax
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rcx, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%sil, 0x5(%r9)
               	leaq	<rip>, %r9
               	movl	$0x50, %eax
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rcx, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%sil, 0x5(%r9)
               	leaq	<rip>, %r9
               	movl	$0x6, %eax
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rcx, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%sil, 0x6(%r9)
               	leaq	<rip>, %r9
               	movl	$0x60, %eax
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rcx, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%sil, 0x6(%r9)
               	leaq	<rip>, %r9
               	movl	$0x7, %eax
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rcx, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%sil, 0x7(%r9)
               	leaq	<rip>, %r9
               	movl	$0x70, %eax
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rcx, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%sil, 0x7(%r9)
               	leaq	<rip>, %r9
               	movl	$0x8, %eax
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rcx, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%sil, 0x8(%r9)
               	leaq	<rip>, %r9
               	movl	$0x80, %eax
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rcx, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%sil, 0x8(%r9)
               	leaq	<rip>, %r9
               	movl	$0x9, %eax
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rcx, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%sil, 0x9(%r9)
               	leaq	<rip>, %r9
               	movl	$0x90, %eax
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rcx, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%sil, 0x9(%r9)
               	leaq	<rip>, %r9
               	movl	$0xa, %eax
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rcx, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%sil, 0xa(%r9)
               	leaq	<rip>, %r9
               	movl	$0xa0, %eax
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rcx, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%sil, 0xa(%r9)
               	leaq	<rip>, %r9
               	movl	$0xb, %eax
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rcx, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%sil, 0xb(%r9)
               	leaq	<rip>, %r9
               	movl	$0xb0, %eax
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rcx, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%sil, 0xb(%r9)
               	leaq	<rip>, %r9
               	movl	$0xc, %eax
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rcx, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%sil, 0xc(%r9)
               	leaq	<rip>, %r9
               	movl	$0xc0, %eax
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rcx, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%sil, 0xc(%r9)
               	leaq	<rip>, %r9
               	movl	$0xd, %eax
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rcx, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%sil, 0xd(%r9)
               	leaq	<rip>, %r9
               	movl	$0xd0, %eax
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rcx, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%sil, 0xd(%r9)
               	leaq	<rip>, %r9
               	movl	$0xe, %eax
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rcx, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%sil, 0xe(%r9)
               	leaq	<rip>, %r9
               	movl	$0xe0, %eax
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rcx, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%sil, 0xe(%r9)
               	leaq	<rip>, %r9
               	movl	$0xf, %eax
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	xorq	%rcx, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	andq	$0xff, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%sil, 0xf(%r9)
               	leaq	<rip>, %r8
               	movl	$0xf0, %eax
               	xorl	%esi, %esi
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
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	callq	<addr>
               	leaq	<rip>, %rax
               	leaq	0x400(%rax), %rcx
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	cmpl	$0x100, %eax            # imm = 0x100
               	jae	<addr>
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x100, %eax            # imm = 0x100
               	jb	<addr>
               	leaq	<rip>, %rax
               	leaq	0x500(%rax), %rcx
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	cmpl	$0x100, %eax            # imm = 0x100
               	jae	<addr>
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x100, %eax            # imm = 0x100
               	jb	<addr>
               	callq	<addr>
               	xorl	%r8d, %r8d
               	cmpl	$0x100, %r8d            # imm = 0x100
               	jae	<addr>
               	leaq	<rip>, %rax
               	movzbq	(%rax,%r8), %r9
               	leaq	<rip>, %rax
               	movzbq	(%rax,%r8), %rcx
               	movl	$0xc3, %eax
               	xorl	%esi, %esi
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
               	cmpl	$0x100, %r8d            # imm = 0x100
               	jb	<addr>
               	cmpl	$0x2, %ebx
               	jge	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	cmpl	$0x100, %eax            # imm = 0x100
               	jae	<addr>
               	leaq	<rip>, %rdx
               	leaq	0x400(%rdx), %rsi
               	addq	$0x500, %rdx            # imm = 0x500
               	leaq	<rip>, %rdi
               	movb	%cl, (%rdi,%rax)
               	movb	%cl, (%rdx,%rax)
               	movb	%cl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x100, %eax            # imm = 0x100
               	jb	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	leaq	0x400(%rax), %rcx
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	cmpl	$0x100, %eax            # imm = 0x100
               	jae	<addr>
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x100, %eax            # imm = 0x100
               	jb	<addr>
               	leaq	<rip>, %rax
               	leaq	0x500(%rax), %rcx
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	cmpl	$0x100, %eax            # imm = 0x100
               	jae	<addr>
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x100, %eax            # imm = 0x100
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
               	xorl	%r8d, %r8d
               	cmpl	$0x100, %r8d            # imm = 0x100
               	jae	<addr>
               	leaq	<rip>, %rax
               	movzbq	(%rax,%r8), %r9
               	leaq	<rip>, %rax
               	movzbq	(%rax,%r8), %rcx
               	movl	$0xc3, %eax
               	xorl	%esi, %esi
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
               	cmpl	$0x100, %r8d            # imm = 0x100
               	jb	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
