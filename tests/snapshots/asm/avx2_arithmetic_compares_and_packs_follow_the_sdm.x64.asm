
avx2_arithmetic_compares_and_packs_follow_the_sdm.x64:	file format elf64-x86-64

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

<check_products>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x140, %rsp            # imm = 0x140
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%eax, %eax
               	leaq	-0x100(%rbp), %rcx
               	movzbq	(%rdi,%rax), %rdx
               	movzbq	(%rsi,%rax), %r8
               	addq	%r8, %rdx
               	incq	%rdx
               	sarq	%rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	xorl	%r8d, %r8d
               	xorl	%ecx, %ecx
               	movq	%r8, %rdx
               	shlq	%rdx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %r9
               	movslq	%r9d, %r9
               	movzbq	(%rdi,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %rdx
               	orq	$-0x10000, %rdx         # imm = 0xFFFF0000
               	testb	$0x1, %al
               	movq	%rcx, %rbx
               	cmovneq	%rdx, %rbx
               	xorl	%ecx, %ecx
               	movq	%r8, %rdx
               	shlq	%rdx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %r9
               	movslq	%r9d, %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %rdx
               	orq	$-0x10000, %rdx         # imm = 0xFFFF0000
               	testb	$0x1, %al
               	cmovneq	%rdx, %rcx
               	movq	%rbx, %r9
               	imulq	%rcx, %r9
               	xorl	%ecx, %ecx
               	movq	%r8, %rdx
               	shlq	%rdx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %rbx
               	movslq	%ebx, %rbx
               	movzbq	(%rdi,%rbx), %rbx
               	orq	%rbx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%edx, %edx
               	movq	%r8, %rbx
               	shlq	%rbx
               	movl	$0x1, %eax
               	shlq	$0x8, %rdx
               	leaq	(%rbx,%rax), %r12
               	movslq	%r12d, %r12
               	movzbq	(%rsi,%r12), %r12
               	orq	%r12, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %r14
               	imulq	%rdx, %r14
               	leaq	-0xe0(%rbp), %rbx
               	xorl	%ecx, %ecx
               	movq	%r8, %rdx
               	shlq	%rdx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %r12
               	movslq	%r12d, %r12
               	movzbq	(%rdi,%r12), %r12
               	orq	%r12, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%edx, %edx
               	movq	%r8, %r12
               	shlq	%r12
               	movl	$0x1, %eax
               	shlq	$0x8, %rdx
               	leaq	(%r12,%rax), %r13
               	movslq	%r13d, %r13
               	movzbq	(%rsi,%r13), %r13
               	orq	%r13, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	leaq	(%rcx,%rdx), %rax
               	leaq	0x1(%rax), %rcx
               	shrq	%rcx
               	movq	%r8, %rdx
               	shlq	%rdx
               	xorl	%eax, %eax
               	leaq	(%rdx,%rax), %r12
               	movslq	%r12d, %r12
               	movq	%rax, %r13
               	shlq	$0x3, %r13
               	shrxq	%r13, %rcx, %r13
               	andq	$0xff, %r13
               	movb	%r13b, (%rbx,%r12)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0xc0(%rbp), %rcx
               	movq	%r9, %rdx
               	sarq	$0x10, %rdx
               	movq	%r8, %rbx
               	shlq	%rbx
               	xorl	%eax, %eax
               	leaq	(%rbx,%rax), %r12
               	movslq	%r12d, %r12
               	movq	%rax, %r13
               	shlq	$0x3, %r13
               	shrxq	%r13, %rdx, %r13
               	andq	$0xff, %r13
               	movb	%r13b, (%rcx,%r12)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0xa0(%rbp), %rcx
               	movq	%r14, %rdx
               	shrq	$0x10, %rdx
               	movq	%r8, %rbx
               	shlq	%rbx
               	xorl	%eax, %eax
               	leaq	(%rbx,%rax), %r12
               	movslq	%r12d, %r12
               	movq	%rax, %r13
               	shlq	$0x3, %r13
               	shrxq	%r13, %rdx, %r13
               	andq	$0xff, %r13
               	movb	%r13b, (%rcx,%r12)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x80(%rbp), %rcx
               	movq	%r9, %rax
               	sarq	$0xe, %rax
               	leaq	0x1(%rax), %rdx
               	sarq	%rdx
               	movq	%r8, %rbx
               	shlq	%rbx
               	xorl	%eax, %eax
               	leaq	(%rbx,%rax), %r12
               	movslq	%r12d, %r12
               	movq	%rax, %r13
               	shlq	$0x3, %r13
               	shrxq	%r13, %rdx, %r13
               	andq	$0xff, %r13
               	movb	%r13b, (%rcx,%r12)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %rcx
               	movq	%r8, %rdx
               	shlq	%rdx
               	xorl	%eax, %eax
               	leaq	(%rdx,%rax), %rbx
               	movslq	%ebx, %rbx
               	movq	%rax, %r12
               	shlq	$0x3, %r12
               	shrxq	%r12, %r9, %r12
               	andq	$0xff, %r12
               	movb	%r12b, (%rcx,%rbx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%r8
               	cmpl	$0x10, %r8d
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rdi,%rax), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	movabsq	$-0x100000000, %r8      # imm = 0xFFFFFFFF00000000
               	orq	%rcx, %r8
               	testb	$0x1, %al
               	movq	%rcx, %r9
               	cmovneq	%r8, %r9
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rsi,%rax), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	movabsq	$-0x100000000, %r8      # imm = 0xFFFFFFFF00000000
               	orq	%rcx, %r8
               	testb	$0x1, %al
               	cmovneq	%r8, %rcx
               	imulq	%r9, %rcx
               	xorl	%eax, %eax
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x8(%rax), %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	movabsq	$-0x100000000, %r8      # imm = 0xFFFFFFFF00000000
               	orq	%rcx, %r8
               	testb	$0x1, %al
               	movq	%rcx, %r9
               	cmovneq	%r8, %r9
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x8(%rax), %r8
               	movzbq	(%rsi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	movabsq	$-0x100000000, %r8      # imm = 0xFFFFFFFF00000000
               	orq	%rcx, %r8
               	testb	$0x1, %al
               	cmovneq	%r8, %rcx
               	imulq	%r9, %rcx
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rdx,%r8)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x10(%rax), %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	movabsq	$-0x100000000, %r8      # imm = 0xFFFFFFFF00000000
               	orq	%rcx, %r8
               	testb	$0x1, %al
               	movq	%rcx, %r9
               	cmovneq	%r8, %r9
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x10(%rax), %r8
               	movzbq	(%rsi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	movabsq	$-0x100000000, %r8      # imm = 0xFFFFFFFF00000000
               	orq	%rcx, %r8
               	testb	$0x1, %al
               	cmovneq	%r8, %rcx
               	imulq	%r9, %rcx
               	xorl	%eax, %eax
               	leaq	0x10(%rax), %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rdx,%r8)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x18(%rax), %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	movabsq	$-0x100000000, %r8      # imm = 0xFFFFFFFF00000000
               	orq	%rcx, %r8
               	testb	$0x1, %al
               	movq	%rcx, %r9
               	cmovneq	%r8, %r9
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x18(%rax), %r8
               	movzbq	(%rsi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	movabsq	$-0x100000000, %r8      # imm = 0xFFFFFFFF00000000
               	orq	%rcx, %r8
               	testb	$0x1, %al
               	cmovneq	%r8, %rcx
               	imulq	%r9, %rcx
               	xorl	%eax, %eax
               	leaq	0x18(%rax), %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rdx,%r8)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	vmovups	(%rdi), %ymm14
               	vmovups	%ymm14, 0x40(%rsp)
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, 0x20(%rsp)
               	vmovups	0x40(%rsp), %ymm14
               	vmovups	0x20(%rsp), %ymm15
               	vpavgb	%ymm15, %ymm14, %ymm0
               	leaq	-0x100(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	vmovups	0x40(%rsp), %ymm14
               	vmovups	0x20(%rsp), %ymm15
               	vpavgw	%ymm15, %ymm14, %ymm0
               	leaq	-0xe0(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	vmovups	0x40(%rsp), %ymm14
               	vmovups	0x20(%rsp), %ymm15
               	vpmulhw	%ymm15, %ymm14, %ymm0
               	leaq	-0xc0(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	vmovups	0x40(%rsp), %ymm14
               	vmovups	0x20(%rsp), %ymm15
               	vpmulhuw	%ymm15, %ymm14, %ymm0
               	leaq	-0xa0(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	vmovups	0x40(%rsp), %ymm14
               	vmovups	0x20(%rsp), %ymm15
               	vpmulhrsw	%ymm15, %ymm14, %ymm0
               	leaq	-0x80(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	vmovups	0x40(%rsp), %ymm14
               	vmovups	0x20(%rsp), %ymm15
               	vpmullw	%ymm15, %ymm14, %ymm0
               	leaq	-0x60(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	vmovups	0x40(%rsp), %ymm14
               	vmovups	0x20(%rsp), %ymm15
               	vpmuldq	%ymm15, %ymm14, %ymm0
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	vmovups	%ymm0, -0x20(%rbp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	vzeroupper
               	leave
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>

<check_extremes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x1a0, %rsp            # imm = 0x1A0
               	andq	$-0x20, %rsp
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	vmovups	(%rbx), %ymm0
               	vmovups	(%r12), %ymm1
               	vpminsb	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	vpmaxsb	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x20(%rsp)
               	vpminsw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x40(%rsp)
               	vpmaxsw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x60(%rsp)
               	vpminsd	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x80(%rsp)
               	vpmaxsd	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0xa0(%rsp)
               	vpminub	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0xc0(%rsp)
               	vpmaxub	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0xe0(%rsp)
               	vpminuw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x100(%rsp)
               	vpmaxuw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x120(%rsp)
               	vpminud	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x140(%rsp)
               	vpmaxud	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x160(%rsp)
               	xorl	%r10d, %r10d
               	movq	%r10, -0x60(%rbp)
               	movq	-0x60(%rbp), %rax
               	cmpl	$0xc, %eax
               	jge	<addr>
               	movl	$0x1, %edx
               	movq	%rax, %rcx
               	shrq	%rcx
               	imulq	$0x55555556, %rcx, %rsi # imm = 0x55555556
               	shrq	$0x20, %rsi
               	leaq	(%rsi,%rsi,2), %rsi
               	subq	%rsi, %rcx
               	shlxq	%rcx, %rdx, %r9
               	cmpl	$0x6, %eax
               	setl	%r15b
               	movzbq	%r15b, %r15
               	xorl	%r14d, %r14d
               	leaq	-0x1(%r9), %r8
               	movq	%r9, %rcx
               	shlq	$0x3, %rcx
               	leaq	-0x1(%rcx), %rdx
               	movslq	%edx, %r10
               	movq	%r10, -0x48(%rbp)
               	movslq	%ecx, %r10
               	movq	%r10, -0x50(%rbp)
               	movq	%rax, %r10
               	andq	$0x1, %r10
               	movq	%r10, -0x58(%rbp)
               	movl	$0x20, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%eax, %r14d
               	jge	<addr>
               	xorl	%ecx, %ecx
               	movq	%r9, %rdx
               	imulq	%r14, %rdx
               	movq	%r8, %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %rsi
               	movslq	%esi, %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	testq	%r15, %r15
               	je	<addr>
               	cmpl	$0x8, %r9d
               	jge	<addr>
               	movq	-0x48(%rbp), %r10
               	shrxq	%r10, %rcx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	-0x50(%rbp), %r10
               	shlxq	%r10, %rax, %rax
               	orq	%rax, %rcx
               	xorl	%edx, %edx
               	movq	%r9, %rsi
               	imulq	%r14, %rsi
               	movq	%r8, %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rdx
               	leaq	(%rsi,%rax), %rdi
               	movslq	%edi, %rdi
               	movzbq	(%r12,%rdi), %rdi
               	orq	%rdi, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	testq	%r15, %r15
               	je	<addr>
               	cmpl	$0x8, %r9d
               	jge	<addr>
               	movq	-0x48(%rbp), %r10
               	shrxq	%r10, %rdx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	-0x50(%rbp), %r10
               	shlxq	%r10, %rax, %rax
               	orq	%rax, %rdx
               	cmpq	%rdx, %rcx
               	setl	%al
               	movzbq	%al, %rax
               	cmpq	%rdx, %rcx
               	setb	%sil
               	movzbq	%sil, %rsi
               	testq	%r15, %r15
               	cmoveq	%rsi, %rax
               	leaq	-0x40(%rbp), %rsi
               	testl	%eax, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	-0x58(%rbp), %r10
               	testq	%r10, %r10
               	cmoveq	%rax, %rdi
               	testq	%rdi, %rdi
               	cmoveq	%rdx, %rcx
               	movq	%r9, %rdx
               	imulq	%r14, %rdx
               	xorl	%eax, %eax
               	cmpl	%r9d, %eax
               	jge	<addr>
               	leaq	(%rdx,%rax), %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r13
               	shlq	$0x3, %r13
               	movslq	%r13d, %r13
               	shrxq	%r13, %rcx, %r13
               	andq	$0xff, %r13
               	movb	%r13b, (%rsi,%rdi)
               	incq	%rax
               	cmpl	%r9d, %eax
               	jl	<addr>
               	incq	%r14
               	movl	$0x20, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%eax, %r14d
               	jl	<addr>
               	leaq	(%rsp), %rax
               	movq	-0x60(%rbp), %rcx
               	shlq	$0x5, %rcx
               	addq	%rax, %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x180(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	-0x20(%rbp), %rdi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x60(%rbp), %r10
               	incq	%r10
               	movq	%r10, -0x60(%rbp)
               	movq	-0x60(%rbp), %rax
               	cmpl	$0xc, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x4, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq

<check_abs_sign>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x88, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0xe0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	vmovups	(%rbx), %ymm0
               	vmovups	(%r12), %ymm1
               	vpabsb	%ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	vpabsw	%ymm0, %ymm2
               	vmovups	%ymm2, 0x20(%rsp)
               	vpabsd	%ymm0, %ymm2
               	vmovups	%ymm2, 0x40(%rsp)
               	vpsignb	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x60(%rsp)
               	vpsignw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x80(%rsp)
               	vpsignd	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0xa0(%rsp)
               	xorl	%r10d, %r10d
               	movq	%r10, -0x80(%rbp)
               	movq	-0x80(%rbp), %rax
               	cmpl	$0x3, %eax
               	jge	<addr>
               	movl	$0x1, %ecx
               	shlxq	%rax, %rcx, %r8
               	xorl	%r10d, %r10d
               	movq	%r10, -0x68(%rbp)
               	leaq	-0x1(%r8), %r9
               	movq	%r8, %rax
               	shlq	$0x3, %rax
               	leaq	-0x1(%rax), %rcx
               	movslq	%ecx, %r10
               	movq	%r10, -0x70(%rbp)
               	movslq	%eax, %r10
               	movq	%r10, -0x78(%rbp)
               	movl	$0x20, %eax
               	cltd
               	idivl	%r8d
               	movq	%rax, %r10
               	movq	-0x68(%rbp), %rax
               	cmpl	%r10d, %eax
               	jge	<addr>
               	xorl	%ecx, %ecx
               	movq	%r8, %rdx
               	imulq	-0x68(%rbp), %rdx
               	movq	%r9, %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %rsi
               	movslq	%esi, %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	cmpl	$0x8, %r8d
               	jge	<addr>
               	movq	-0x70(%rbp), %r10
               	shrxq	%r10, %rcx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	-0x78(%rbp), %r10
               	shlxq	%r10, %rax, %rax
               	orq	%rax, %rcx
               	xorl	%edx, %edx
               	movq	%r8, %rsi
               	imulq	-0x68(%rbp), %rsi
               	movq	%r9, %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rdx
               	leaq	(%rsi,%rax), %rdi
               	movslq	%edi, %rdi
               	movzbq	(%r12,%rdi), %rdi
               	orq	%rdi, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	cmpl	$0x8, %r8d
               	jge	<addr>
               	movq	-0x70(%rbp), %r10
               	shrxq	%r10, %rdx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	-0x78(%rbp), %r10
               	shlxq	%r10, %rax, %rax
               	orq	%rax, %rdx
               	leaq	-0x60(%rbp), %rdi
               	movq	%rcx, %r13
               	negq	%r13
               	testq	%rcx, %rcx
               	cmovgeq	%rcx, %r13
               	movq	%r8, %rsi
               	imulq	-0x68(%rbp), %rsi
               	xorl	%eax, %eax
               	cmpl	%r8d, %eax
               	jge	<addr>
               	leaq	(%rsi,%rax), %r14
               	movslq	%r14d, %r14
               	movq	%rax, %r15
               	shlq	$0x3, %r15
               	movslq	%r15d, %r15
               	shrxq	%r15, %r13, %r15
               	andq	$0xff, %r15
               	movb	%r15b, (%rdi,%r14)
               	incq	%rax
               	cmpl	%r8d, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rsi
               	testq	%rdx, %rdx
               	jge	<addr>
               	negq	%rcx
               	movq	%r8, %rdx
               	imulq	-0x68(%rbp), %rdx
               	xorl	%eax, %eax
               	cmpl	%r8d, %eax
               	jge	<addr>
               	leaq	(%rdx,%rax), %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r13
               	shlq	$0x3, %r13
               	movslq	%r13d, %r13
               	shrxq	%r13, %rcx, %r13
               	andq	$0xff, %r13
               	movb	%r13b, (%rsi,%rdi)
               	incq	%rax
               	cmpl	%r8d, %eax
               	jl	<addr>
               	jmp	<addr>
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	cmoveq	%rax, %rcx
               	jmp	<addr>
               	movq	-0x68(%rbp), %r10
               	incq	%r10
               	movq	%r10, -0x68(%rbp)
               	movl	$0x20, %eax
               	cltd
               	idivl	%r8d
               	movq	%rax, %r10
               	movq	-0x68(%rbp), %rax
               	cmpl	%r10d, %eax
               	jl	<addr>
               	leaq	(%rsp), %rax
               	movq	-0x80(%rbp), %rcx
               	shlq	$0x5, %rcx
               	addq	%rax, %rcx
               	leaq	-0x60(%rbp), %rsi
               	leaq	0xc0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	-0x20(%rbp), %rdi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x60(%rsp), %rax
               	movq	-0x80(%rbp), %rcx
               	shlq	$0x5, %rcx
               	addq	%rax, %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0xc0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	-0x20(%rbp), %rdi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x80(%rbp), %r10
               	incq	%r10
               	movq	%r10, -0x80(%rbp)
               	movq	-0x80(%rbp), %rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x8, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq

<model_horizontal>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, 0x68(%rsp)
               	movq	%r9, 0x38(%rsp)
               	movq	%r8, 0x50(%rsp)
               	movq	%rcx, 0x58(%rsp)
               	movq	%rdx, %r13
               	movq	%rsi, 0x60(%rsp)
               	movl	$0x8, %eax
               	cltd
               	idivl	%r13d
               	movq	%rax, %r9
               	xorl	%r10d, %r10d
               	movq	%r10, 0x40(%rsp)
               	leaq	-0x1(%r13), %rbx
               	movq	%r13, %rax
               	shlq	$0x3, %rax
               	leaq	-0x1(%rax), %rcx
               	movslq	%ecx, %r8
               	movslq	%eax, %r10
               	movq	%r10, 0x78(%rsp)
               	movq	%r9, %r10
               	shlq	%r10
               	movq	%r10, 0x48(%rsp)
               	xorl	%r15d, %r15d
               	movq	0x40(%rsp), %r10
               	shlq	$0x4, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x38(%rsp), %r14
               	addq	0x70(%rsp), %r14
               	cmpl	0x48(%rsp), %r15d
               	jge	<addr>
               	cmpl	%r9d, %r15d
               	movq	0x68(%rsp), %r10
               	movq	0x60(%rsp), %r11
               	movq	%r11, %rax
               	cmovlq	%r10, %rax
               	movq	%rax, %r12
               	addq	0x70(%rsp), %r12
               	movl	%r15d, %eax
               	cltd
               	idivl	%r9d
               	movq	%rdx, %rdi
               	shlq	%rdi
               	xorl	%ecx, %ecx
               	movq	%r13, %rdx
               	imulq	%rdi, %rdx
               	movq	%rbx, %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %rsi
               	movslq	%esi, %rsi
               	movzbq	(%r12,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	cmpl	$0x8, %r13d
               	jge	<addr>
               	shrxq	%r8, %rcx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	0x78(%rsp), %r10
               	shlxq	%r10, %rax, %rax
               	orq	%rax, %rcx
               	leaq	0x1(%rdi), %rsi
               	xorl	%edx, %edx
               	imulq	%r13, %rsi
               	movq	%rbx, %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rdx
               	leaq	(%rsi,%rax), %rdi
               	movslq	%edi, %rdi
               	movzbq	(%r12,%rdi), %rdi
               	orq	%rdi, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	cmpl	$0x8, %r13d
               	jge	<addr>
               	shrxq	%r8, %rdx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	0x78(%rsp), %r10
               	shlxq	%r10, %rax, %rax
               	orq	%rax, %rdx
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	addq	%rdx, %rcx
               	movq	0x58(%rsp), %r10
               	testl	%r10d, %r10d
               	cmovneq	%rax, %rcx
               	movq	0x50(%rsp), %r10
               	testl	%r10d, %r10d
               	je	<addr>
               	movl	$0x1, %eax
               	shlxq	%r8, %rax, %rax
               	negq	%rax
               	movl	$0x1, %edx
               	shlxq	%r8, %rdx, %rdx
               	decq	%rdx
               	cmpq	%rax, %rcx
               	jge	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rdx
               	imulq	%r15, %rdx
               	xorl	%eax, %eax
               	cmpl	%r13d, %eax
               	jge	<addr>
               	leaq	(%rdx,%rax), %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%r14,%rsi)
               	incq	%rax
               	cmpl	%r13d, %eax
               	jl	<addr>
               	jmp	<addr>
               	cmpq	%rdx, %rcx
               	cmovgq	%rdx, %rcx
               	jmp	<addr>
               	incq	%r15
               	cmpl	0x48(%rsp), %r15d
               	jl	<addr>
               	movq	0x40(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<check_horizontal>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0xe0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	vmovups	(%rbx), %ymm0
               	vmovups	(%r12), %ymm1
               	vphaddw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	vphaddd	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x20(%rsp)
               	vphsubw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x40(%rsp)
               	vphsubd	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x60(%rsp)
               	vphaddsw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x80(%rsp)
               	vphsubsw	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0xa0(%rsp)
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	leaq	-0x40(%rbp), %r9
               	movq	%rbx, %rdi
               	movq	%rcx, %r8
               	movq	%r12, %rsi
               	vzeroupper
               	callq	<addr>
               	leaq	(%rsp), %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0xc0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	-0x20(%rbp), %rdi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	vzeroupper
               	leave
               	retq
               	movl	$0x4, %edx
               	xorl	%ecx, %ecx
               	leaq	-0x40(%rbp), %r9
               	movq	%rbx, %rdi
               	movq	%rcx, %r8
               	movq	%r12, %rsi
               	vzeroupper
               	callq	<addr>
               	leaq	(%rsp), %rax
               	leaq	0x20(%rax), %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0xc0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	-0x20(%rbp), %rdi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %edx
               	movl	$0x1, %ecx
               	xorl	%r8d, %r8d
               	leaq	-0x40(%rbp), %r9
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	vzeroupper
               	callq	<addr>
               	leaq	(%rsp), %rax
               	leaq	0x40(%rax), %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0xc0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	-0x20(%rbp), %rdi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %edx
               	movl	$0x1, %ecx
               	xorl	%r8d, %r8d
               	leaq	-0x40(%rbp), %r9
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	vzeroupper
               	callq	<addr>
               	leaq	(%rsp), %rax
               	leaq	0x60(%rax), %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0xc0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	-0x20(%rbp), %rdi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	movl	$0x1, %r8d
               	leaq	-0x40(%rbp), %r9
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	vzeroupper
               	callq	<addr>
               	leaq	(%rsp), %rax
               	leaq	0x80(%rax), %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0xc0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	-0x20(%rbp), %rdi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %edx
               	movl	$0x1, %ecx
               	leaq	-0x40(%rbp), %r9
               	movq	%rbx, %rdi
               	movq	%rcx, %r8
               	movq	%r12, %rsi
               	vzeroupper
               	callq	<addr>
               	leaq	(%rsp), %rax
               	leaq	0xa0(%rax), %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0xc0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	-0x20(%rbp), %rdi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	vzeroupper
               	leave
               	retq

<check_compares>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	vmovups	(%rbx), %ymm0
               	vmovups	(%r12), %ymm1
               	vpcmpgtb	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	vpcmpgtw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x20(%rsp)
               	vpcmpgtd	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x40(%rsp)
               	vpcmpgtq	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x60(%rsp)
               	xorl	%r10d, %r10d
               	movq	%r10, -0x50(%rbp)
               	movq	-0x50(%rbp), %rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0x1, %ecx
               	shlxq	%rax, %rcx, %r9
               	xorl	%r14d, %r14d
               	leaq	-0x1(%r9), %r8
               	movq	%r9, %rax
               	shlq	$0x3, %rax
               	leaq	-0x1(%rax), %rcx
               	movslq	%ecx, %r15
               	movslq	%eax, %r10
               	movq	%r10, -0x48(%rbp)
               	movl	$0x20, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%eax, %r14d
               	jge	<addr>
               	leaq	-0x40(%rbp), %rsi
               	xorl	%ecx, %ecx
               	movq	%r9, %rdx
               	imulq	%r14, %rdx
               	movq	%r8, %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %rdi
               	movslq	%edi, %rdi
               	movzbq	(%rbx,%rdi), %rdi
               	orq	%rdi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	cmpl	$0x8, %r9d
               	jge	<addr>
               	shrxq	%r15, %rcx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	-0x48(%rbp), %r10
               	shlxq	%r10, %rax, %rax
               	orq	%rax, %rcx
               	xorl	%edx, %edx
               	movq	%r9, %rdi
               	imulq	%r14, %rdi
               	movq	%r8, %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rdx
               	leaq	(%rdi,%rax), %r13
               	movslq	%r13d, %r13
               	movzbq	(%r12,%r13), %r13
               	orq	%r13, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	cmpl	$0x8, %r9d
               	jge	<addr>
               	shrxq	%r15, %rdx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	-0x48(%rbp), %r10
               	shlxq	%r10, %rax, %rax
               	orq	%rax, %rdx
               	movq	$-0x1, %rax
               	xorl	%edi, %edi
               	cmpq	%rdx, %rcx
               	movq	%rdi, %rdx
               	cmovgq	%rax, %rdx
               	movq	%r9, %rcx
               	imulq	%r14, %rcx
               	xorl	%eax, %eax
               	cmpl	%r9d, %eax
               	jge	<addr>
               	leaq	(%rcx,%rax), %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r13
               	shlq	$0x3, %r13
               	movslq	%r13d, %r13
               	shrxq	%r13, %rdx, %r13
               	andq	$0xff, %r13
               	movb	%r13b, (%rsi,%rdi)
               	incq	%rax
               	cmpl	%r9d, %eax
               	jl	<addr>
               	incq	%r14
               	movl	$0x20, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%eax, %r14d
               	jl	<addr>
               	leaq	(%rsp), %rax
               	movq	-0x50(%rbp), %rcx
               	shlq	$0x5, %rcx
               	addq	%rax, %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x80(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	-0x20(%rbp), %rdi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x50(%rbp), %r10
               	incq	%r10
               	movq	%r10, -0x50(%rbp)
               	movq	-0x50(%rbp), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x80(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x20, %eax
               	leaq	-0x80(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq

<check_packs>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x70(%rbp)
               	movq	%rsi, -0x78(%rbp)
               	movq	-0x70(%rbp), %r10
               	vmovups	(%r10), %ymm0
               	movq	-0x78(%rbp), %r10
               	vmovups	(%r10), %ymm1
               	vpacksswb	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	vpackssdw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x20(%rsp)
               	vpackuswb	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x40(%rsp)
               	vpackusdw	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x60(%rsp)
               	xorl	%r10d, %r10d
               	movq	%r10, -0x98(%rbp)
               	movq	-0x98(%rbp), %rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0x4, %ecx
               	movl	$0x2, %edx
               	testb	$0x1, %al
               	movq	%rdx, %r10
               	cmovneq	%rcx, %r10
               	movq	%r10, -0x58(%rbp)
               	movq	-0x98(%rbp), %r15
               	cmpl	$0x2, %r15d
               	setl	%r15b
               	movzbq	%r15b, %r15
               	movl	$0x10, %eax
               	movq	-0x58(%rbp), %r9
               	cltd
               	idivl	%r9d
               	movq	%rax, %r14
               	xorl	%r10d, %r10d
               	movq	%r10, -0x90(%rbp)
               	leaq	-0x1(%r9), %rbx
               	movq	%r9, %r10
               	shlq	$0x3, %r10
               	movq	%r10, -0x60(%rbp)
               	movq	-0x60(%rbp), %r10
               	decq	%r10
               	movq	%r10, -0x80(%rbp)
               	shrq	%r9
               	movq	%r9, %r10
               	shlq	$0x3, %r10
               	movq	%r10, -0x68(%rbp)
               	movq	-0x68(%rbp), %r10
               	decq	%r10
               	movq	%r10, -0x48(%rbp)
               	movq	%r14, %r10
               	shlq	%r10
               	movq	%r10, -0x88(%rbp)
               	xorl	%r13d, %r13d
               	movq	-0x90(%rbp), %r10
               	shlq	$0x4, %r10
               	movq	%r10, -0x50(%rbp)
               	cmpl	-0x88(%rbp), %r13d
               	jge	<addr>
               	cmpl	%r14d, %r13d
               	movq	-0x70(%rbp), %r10
               	movq	-0x78(%rbp), %r11
               	movq	%r11, %rax
               	cmovlq	%r10, %rax
               	movq	%rax, %r12
               	addq	-0x50(%rbp), %r12
               	movl	%r13d, %eax
               	cltd
               	idivl	%r14d
               	xorl	%r8d, %r8d
               	movq	%rdx, %r10
               	movq	-0x58(%rbp), %rdx
               	imulq	%r10, %rdx
               	movq	%rbx, %rcx
               	testl	%ecx, %ecx
               	jl	<addr>
               	shlq	$0x8, %r8
               	leaq	(%rdx,%rcx), %rax
               	movslq	%eax, %rax
               	movzbq	(%r12,%rax), %rax
               	orq	%rax, %r8
               	decq	%rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	movq	-0x80(%rbp), %r10
               	shrxq	%r10, %r8, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	-0x60(%rbp), %r10
               	shlxq	%r10, %rax, %rax
               	orq	%rax, %r8
               	leaq	-0x40(%rbp), %rax
               	addq	-0x50(%rbp), %rax
               	testq	%r15, %r15
               	je	<addr>
               	movl	$0x1, %ecx
               	movq	-0x48(%rbp), %r10
               	shlxq	%r10, %rcx, %rcx
               	movq	%rcx, %rdx
               	negq	%rdx
               	testq	%r15, %r15
               	je	<addr>
               	movl	$0x1, %ecx
               	movq	-0x48(%rbp), %r10
               	shlxq	%r10, %rcx, %rcx
               	decq	%rcx
               	cmpq	%rdx, %r8
               	jge	<addr>
               	movq	%r9, %r8
               	imulq	%r13, %r8
               	xorl	%ecx, %ecx
               	cmpl	%r9d, %ecx
               	jge	<addr>
               	leaq	(%r8,%rcx), %rsi
               	movslq	%esi, %rsi
               	movq	%rcx, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	shrxq	%rdi, %rdx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rax,%rsi)
               	incq	%rcx
               	cmpl	%r9d, %ecx
               	jl	<addr>
               	jmp	<addr>
               	cmpq	%rcx, %r8
               	movq	%r8, %rdx
               	cmovgq	%rcx, %rdx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	-0x68(%rbp), %r10
               	shlxq	%r10, %rcx, %rcx
               	decq	%rcx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	incq	%r13
               	cmpl	-0x88(%rbp), %r13d
               	jl	<addr>
               	movq	-0x90(%rbp), %r10
               	incq	%r10
               	movq	%r10, -0x90(%rbp)
               	movq	-0x90(%rbp), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	(%rsp), %rax
               	movq	-0x98(%rbp), %rcx
               	shlq	$0x5, %rcx
               	addq	%rax, %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x80(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	-0x20(%rbp), %rdi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x98(%rbp), %r10
               	incq	%r10
               	movq	%r10, -0x98(%rbp)
               	movq	-0x98(%rbp), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0xd0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x40, %eax
               	leaq	-0xd0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq

<check_unpacks>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x78, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x60(%rbp)
               	movq	%rsi, -0x68(%rbp)
               	movq	-0x60(%rbp), %r10
               	vmovups	(%r10), %ymm0
               	movq	-0x68(%rbp), %r10
               	vmovups	(%r10), %ymm1
               	vpunpcklbw	%ymm1, %ymm0, %ymm2 # ymm2 = ymm0[0],ymm1[0],ymm0[1],ymm1[1],ymm0[2],ymm1[2],ymm0[3],ymm1[3],ymm0[4],ymm1[4],ymm0[5],ymm1[5],ymm0[6],ymm1[6],ymm0[7],ymm1[7],ymm0[16],ymm1[16],ymm0[17],ymm1[17],ymm0[18],ymm1[18],ymm0[19],ymm1[19],ymm0[20],ymm1[20],ymm0[21],ymm1[21],ymm0[22],ymm1[22],ymm0[23],ymm1[23]
               	vmovups	%ymm2, (%rsp)
               	vpunpcklwd	%ymm1, %ymm0, %ymm2 # ymm2 = ymm0[0],ymm1[0],ymm0[1],ymm1[1],ymm0[2],ymm1[2],ymm0[3],ymm1[3],ymm0[8],ymm1[8],ymm0[9],ymm1[9],ymm0[10],ymm1[10],ymm0[11],ymm1[11]
               	vmovups	%ymm2, 0x20(%rsp)
               	vpunpckhbw	%ymm1, %ymm0, %ymm2 # ymm2 = ymm0[8],ymm1[8],ymm0[9],ymm1[9],ymm0[10],ymm1[10],ymm0[11],ymm1[11],ymm0[12],ymm1[12],ymm0[13],ymm1[13],ymm0[14],ymm1[14],ymm0[15],ymm1[15],ymm0[24],ymm1[24],ymm0[25],ymm1[25],ymm0[26],ymm1[26],ymm0[27],ymm1[27],ymm0[28],ymm1[28],ymm0[29],ymm1[29],ymm0[30],ymm1[30],ymm0[31],ymm1[31]
               	vmovups	%ymm2, 0x40(%rsp)
               	vpunpckhwd	%ymm1, %ymm0, %ymm0 # ymm0 = ymm0[4],ymm1[4],ymm0[5],ymm1[5],ymm0[6],ymm1[6],ymm0[7],ymm1[7],ymm0[12],ymm1[12],ymm0[13],ymm1[13],ymm0[14],ymm1[14],ymm0[15],ymm1[15]
               	vmovups	%ymm0, 0x60(%rsp)
               	xorl	%r10d, %r10d
               	movq	%r10, -0x70(%rbp)
               	movq	-0x70(%rbp), %rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0x2, %r8d
               	movl	$0x1, %ecx
               	testb	$0x1, %al
               	cmoveq	%rcx, %r8
               	movl	$0x10, %eax
               	cltd
               	idivl	%r8d
               	movq	%rax, %rcx
               	shrq	%rcx
               	xorl	%edx, %edx
               	movq	-0x70(%rbp), %rsi
               	cmpl	$0x2, %esi
               	movq	%rdx, %r10
               	cmovgeq	%rcx, %r10
               	movq	%r10, -0x48(%rbp)
               	xorl	%r10d, %r10d
               	movq	%r10, -0x58(%rbp)
               	leaq	-0x1(%r8), %rdx
               	movq	%rax, %r10
               	shrq	%r10
               	movq	%r10, -0x50(%rbp)
               	xorl	%r14d, %r14d
               	movq	-0x58(%rbp), %r15
               	shlq	$0x4, %r15
               	movq	-0x60(%rbp), %r9
               	addq	%r15, %r9
               	movq	-0x68(%rbp), %rsi
               	addq	%r15, %rsi
               	cmpl	-0x50(%rbp), %r14d
               	jge	<addr>
               	leaq	-0x40(%rbp), %rax
               	leaq	(%rax,%r15), %rdi
               	movq	%r14, %r13
               	shlq	%r13
               	movq	-0x48(%rbp), %rbx
               	addq	%r14, %rbx
               	xorl	%ecx, %ecx
               	imulq	%r8, %rbx
               	movq	%rdx, %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rcx
               	leaq	(%rbx,%rax), %r12
               	movslq	%r12d, %r12
               	movzbq	(%r9,%r12), %r12
               	orq	%r12, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%r8, %rbx
               	imulq	%r13, %rbx
               	xorl	%eax, %eax
               	cmpl	%r8d, %eax
               	jge	<addr>
               	leaq	(%rbx,%rax), %r12
               	movslq	%r12d, %r12
               	movq	%rax, %r13
               	shlq	$0x3, %r13
               	movslq	%r13d, %r13
               	shrxq	%r13, %rcx, %r13
               	andq	$0xff, %r13
               	movb	%r13b, (%rdi,%r12)
               	incq	%rax
               	cmpl	%r8d, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rax
               	leaq	(%rax,%r15), %rdi
               	movq	%r14, %rax
               	shlq	%rax
               	leaq	0x1(%rax), %r13
               	movq	-0x48(%rbp), %rbx
               	addq	%r14, %rbx
               	xorl	%ecx, %ecx
               	imulq	%r8, %rbx
               	movq	%rdx, %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rcx
               	leaq	(%rbx,%rax), %r12
               	movslq	%r12d, %r12
               	movzbq	(%rsi,%r12), %r12
               	orq	%r12, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%r8, %rbx
               	imulq	%r13, %rbx
               	xorl	%eax, %eax
               	cmpl	%r8d, %eax
               	jge	<addr>
               	leaq	(%rbx,%rax), %r12
               	movslq	%r12d, %r12
               	movq	%rax, %r13
               	shlq	$0x3, %r13
               	movslq	%r13d, %r13
               	shrxq	%r13, %rcx, %r13
               	andq	$0xff, %r13
               	movb	%r13b, (%rdi,%r12)
               	incq	%rax
               	cmpl	%r8d, %eax
               	jl	<addr>
               	incq	%r14
               	cmpl	-0x50(%rbp), %r14d
               	jl	<addr>
               	movq	-0x58(%rbp), %r10
               	incq	%r10
               	movq	%r10, -0x58(%rbp)
               	movq	-0x58(%rbp), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	(%rsp), %rax
               	movq	-0x70(%rbp), %rcx
               	shlq	$0x5, %rcx
               	addq	%rax, %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x80(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	-0x20(%rbp), %rdi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x70(%rbp), %r10
               	incq	%r10
               	movq	%r10, -0x70(%rbp)
               	movq	-0x70(%rbp), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x80, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x120, %rsp            # imm = 0x120
               	andq	$-0x20, %rsp
               	xorl	%r10d, %r10d
               	movq	%r10, -0xa0(%rbp)
               	movq	-0xa0(%rbp), %r11
               	movq	%r11, -0xa8(%rbp)
               	jmp	<addr>
               	movq	-0xa8(%rbp), %rbx
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	vzeroupper
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	vzeroupper
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	vzeroupper
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	vzeroupper
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	vzeroupper
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	vzeroupper
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	vzeroupper
               	callq	<addr>
               	movq	%rbx, %r10
               	orq	%rax, %r10
               	movq	%r10, -0xa8(%rbp)
               	movq	-0xa0(%rbp), %r10
               	incq	%r10
               	movq	%r10, -0xa0(%rbp)
               	movq	-0xa0(%rbp), %rax
               	cmpl	$0x12c, %eax            # imm = 0x12C
               	jge	<addr>
               	leaq	-0x80(%rbp), %rdx
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jge	<addr>
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x1b, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x3c, %rsi
               	cmpl	$0x4, %esi
               	jae	<addr>
               	leaq	<rip>, %rsi # <addr>
               	shrq	$0x3a, %rcx
               	andq	$0x3, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	jmp	<addr>
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	leaq	-0x60(%rbp), %rdx
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jge	<addr>
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x1b, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x3c, %rsi
               	cmpl	$0x4, %esi
               	jae	<addr>
               	leaq	<rip>, %rsi # <addr>
               	shrq	$0x3a, %rcx
               	andq	$0x3, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	jmp	<addr>
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	-0xa0(%rbp), %rax
               	imulq	$0x33333334, %rax, %rcx # imm = 0x33333334
               	shrq	$0x20, %rcx
               	leaq	(%rcx,%rcx,4), %rcx
               	subq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x60(%rbp), %rax
               	addq	$0x8, %rax
               	leaq	-0x80(%rbp), %rcx
               	addq	$0x8, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x80(%rbp), %rbx
               	leaq	-0x60(%rbp), %r12
               	vmovups	-0x80(%rbp), %ymm0
               	vmovups	-0x60(%rbp), %ymm1
               	vpaddsb	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	vpaddsw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x20(%rsp)
               	vpaddusb	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x40(%rsp)
               	vpaddusw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x60(%rsp)
               	vpsubsb	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x80(%rsp)
               	vpsubsw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0xa0(%rsp)
               	vpsubusb	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0xc0(%rsp)
               	vpsubusw	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0xe0(%rsp)
               	xorl	%r10d, %r10d
               	movq	%r10, -0x98(%rbp)
               	movq	-0x98(%rbp), %rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	$0x2, %edi
               	movl	$0x1, %ecx
               	testb	$0x1, %al
               	cmoveq	%rcx, %rdi
               	movq	-0x98(%rbp), %r15
               	andq	$0x2, %r15
               	leaq	-0x1(%rdi), %rsi
               	movq	%rdi, %r10
               	shlq	$0x3, %r10
               	movq	%r10, -0x90(%rbp)
               	movq	-0x90(%rbp), %r10
               	decq	%r10
               	movq	%r10, -0x88(%rbp)
               	xorl	%r14d, %r14d
               	movl	$0x20, %eax
               	cltd
               	idivl	%edi
               	cmpl	%eax, %r14d
               	jge	<addr>
               	xorl	%ecx, %ecx
               	movq	%rdi, %rdx
               	imulq	%r14, %rdx
               	movq	%rsi, %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %r8
               	movslq	%r8d, %r8
               	movzbq	(%rbx,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	testl	%r15d, %r15d
               	jne	<addr>
               	movq	-0x88(%rbp), %r10
               	shrxq	%r10, %rcx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	-0x90(%rbp), %r10
               	shlxq	%r10, %rax, %rax
               	orq	%rax, %rcx
               	xorl	%edx, %edx
               	movq	%rdi, %r8
               	imulq	%r14, %r8
               	movq	%rsi, %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rdx
               	leaq	(%r8,%rax), %r9
               	movslq	%r9d, %r9
               	movzbq	(%r12,%r9), %r9
               	orq	%r9, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	testl	%r15d, %r15d
               	jne	<addr>
               	movq	-0x88(%rbp), %r10
               	shrxq	%r10, %rdx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	-0x90(%rbp), %r10
               	shlxq	%r10, %rax, %rax
               	orq	%rax, %rdx
               	leaq	-0x40(%rbp), %r8
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	addq	%rcx, %rdx
               	movq	-0x98(%rbp), %rcx
               	cmpl	$0x4, %ecx
               	cmovgeq	%rax, %rdx
               	testl	%r15d, %r15d
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	-0x88(%rbp), %r10
               	shlxq	%r10, %rax, %rax
               	movq	%rax, %rcx
               	negq	%rcx
               	testl	%r15d, %r15d
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	-0x88(%rbp), %r10
               	shlxq	%r10, %rax, %rax
               	decq	%rax
               	cmpq	%rcx, %rdx
               	jge	<addr>
               	movq	%rdi, %rdx
               	imulq	%r14, %rdx
               	xorl	%eax, %eax
               	cmpl	%edi, %eax
               	jge	<addr>
               	leaq	(%rdx,%rax), %r9
               	movslq	%r9d, %r9
               	movq	%rax, %r13
               	shlq	$0x3, %r13
               	movslq	%r13d, %r13
               	shrxq	%r13, %rcx, %r13
               	andq	$0xff, %r13
               	movb	%r13b, (%r8,%r9)
               	incq	%rax
               	cmpl	%edi, %eax
               	jl	<addr>
               	jmp	<addr>
               	cmpq	%rax, %rdx
               	movq	%rdx, %rcx
               	cmovgq	%rax, %rcx
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	-0x90(%rbp), %r10
               	shlxq	%r10, %rax, %rax
               	decq	%rax
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	incq	%r14
               	movl	$0x20, %eax
               	cltd
               	idivl	%edi
               	cmpl	%eax, %r14d
               	jl	<addr>
               	leaq	(%rsp), %rax
               	movq	-0x98(%rbp), %rcx
               	shlq	$0x5, %rcx
               	addq	%rcx, %rax
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x100(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	-0x20(%rbp), %rax
               	leaq	0x100(%rsp), %rcx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x98(%rbp), %r10
               	incq	%r10
               	movq	%r10, -0x98(%rbp)
               	movq	-0x98(%rbp), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movq	-0xa8(%rbp), %rax
               	leaq	-0xe0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
