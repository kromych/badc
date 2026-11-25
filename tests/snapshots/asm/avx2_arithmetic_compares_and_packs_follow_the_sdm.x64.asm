
avx2_arithmetic_compares_and_packs_follow_the_sdm.x64:	file format elf64-x86-64

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

<check_products>:
               	subq	$0x148, %rsp            # imm = 0x148
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%eax, %eax
               	movzbq	(%rdi,%rax), %rcx
               	movzbq	(%rsi,%rax), %r8
               	addq	%r8, %rcx
               	incq	%rcx
               	sarq	%rcx
               	movb	%cl, 0x60(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	xorl	%r9d, %r9d
               	xorl	%ecx, %ecx
               	movq	%r9, %rdx
               	shlq	%rdx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %rbx
               	orq	$-0x10000, %rbx         # imm = 0xFFFF0000
               	testb	$0x1, %al
               	cmoveq	%rcx, %rbx
               	xorl	%ecx, %ecx
               	movq	%r9, %rdx
               	shlq	%rdx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %r8
               	movzbq	(%rsi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %rdx
               	orq	$-0x10000, %rdx         # imm = 0xFFFF0000
               	testb	$0x1, %al
               	cmovneq	%rdx, %rcx
               	imulq	%rcx, %rbx
               	xorl	%ecx, %ecx
               	movq	%r9, %rdx
               	shlq	%rdx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%edx, %edx
               	movq	%r9, %r8
               	shlq	%r8
               	movl	$0x1, %eax
               	shlq	$0x8, %rdx
               	leaq	(%r8,%rax), %r12
               	movzbq	(%rsi,%r12), %r12
               	orq	%r12, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	imulq	%rdx, %rcx
               	xorl	%edx, %edx
               	movq	%r9, %r8
               	shlq	%r8
               	movl	$0x1, %eax
               	shlq	$0x8, %rdx
               	leaq	(%r8,%rax), %r13
               	movzbq	(%rdi,%r13), %r13
               	orq	%r13, %rdx
               	decq	%rax
               	nopl	(%rax,%rax)
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%r8d, %r8d
               	movq	%r9, %r13
               	shlq	%r13
               	movl	$0x1, %eax
               	shlq	$0x8, %r8
               	leaq	(%r13,%rax), %r14
               	movzbq	(%rsi,%r14), %r14
               	orq	%r14, %r8
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	leaq	(%rdx,%r8), %rax
               	leaq	0x1(%rax), %r8
               	shrq	%r8
               	movq	%r9, %r13
               	shlq	%r13
               	xorl	%eax, %eax
               	leaq	(%r13,%rax), %r14
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %r8, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x80(%rsp,%r14)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movq	%rbx, %r12
               	sarq	$0x10, %r12
               	movq	%r9, %r13
               	shlq	%r13
               	xorl	%eax, %eax
               	leaq	(%r13,%rax), %r14
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %r12, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0xa0(%rsp,%r14)
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movq	%rcx, %r8
               	shrq	$0x10, %r8
               	movq	%r9, %r12
               	shlq	%r12
               	xorl	%eax, %eax
               	leaq	(%r12,%rax), %r13
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %r8, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0xc0(%rsp,%r13)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movq	%rbx, %rax
               	sarq	$0xe, %rax
               	leaq	0x1(%rax), %rdx
               	sarq	%rdx
               	movq	%r9, %r12
               	shlq	%r12
               	xorl	%eax, %eax
               	leaq	(%r12,%rax), %r13
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0xe0(%rsp,%r13)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movq	%r9, %r8
               	shlq	%r8
               	xorl	%eax, %eax
               	leaq	(%r8,%rax), %r12
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rbx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x100(%rsp,%r12)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%r9
               	cmpl	$0x10, %r9d
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rdi,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	movabsq	$-0x100000000, %rdx     # imm = 0xFFFFFFFF00000000
               	orq	%rcx, %rdx
               	testb	$0x1, %al
               	cmoveq	%rcx, %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rsi,%rax), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	nop
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	movabsq	$-0x100000000, %r9      # imm = 0xFFFFFFFF00000000
               	orq	%rcx, %r9
               	testb	$0x1, %al
               	cmovneq	%r9, %rcx
               	imulq	%rcx, %rdx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x120(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x8(%rax), %rdx
               	movzbq	(%rdi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	movabsq	$-0x100000000, %rdx     # imm = 0xFFFFFFFF00000000
               	orq	%rcx, %rdx
               	testb	$0x1, %al
               	cmoveq	%rcx, %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x8(%rax), %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	nopl	(%rax,%rax)
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	movabsq	$-0x100000000, %r9      # imm = 0xFFFFFFFF00000000
               	orq	%rcx, %r9
               	testb	$0x1, %al
               	cmovneq	%r9, %rcx
               	imulq	%rcx, %rdx
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %r9
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x120(%rsp,%r9)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x10(%rax), %rdx
               	movzbq	(%rdi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	movabsq	$-0x100000000, %rdx     # imm = 0xFFFFFFFF00000000
               	orq	%rcx, %rdx
               	testb	$0x1, %al
               	cmoveq	%rcx, %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x10(%rax), %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	nopl	(%rax)
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	movabsq	$-0x100000000, %r9      # imm = 0xFFFFFFFF00000000
               	orq	%rcx, %r9
               	testb	$0x1, %al
               	cmovneq	%r9, %rcx
               	imulq	%rcx, %rdx
               	xorl	%eax, %eax
               	leaq	0x10(%rax), %r9
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x120(%rsp,%r9)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x18(%rax), %rdx
               	movzbq	(%rdi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	movabsq	$-0x100000000, %rdx     # imm = 0xFFFFFFFF00000000
               	orq	%rcx, %rdx
               	testb	$0x1, %al
               	cmoveq	%rcx, %rdx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x18(%rax), %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	nopl	(%rax)
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	movabsq	$-0x100000000, %r9      # imm = 0xFFFFFFFF00000000
               	orq	%rcx, %r9
               	testb	$0x1, %al
               	cmovneq	%r9, %rcx
               	imulq	%rcx, %rdx
               	xorl	%eax, %eax
               	leaq	0x18(%rax), %r9
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x120(%rsp,%r9)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	vmovups	(%rdi), %ymm0
               	vmovups	(%rsi), %ymm1
               	vpavgb	%ymm1, %ymm0, %ymm2
               	leaq	0x60(%rsp), %rsi
               	leaq	0x140(%rsp), %rdi
               	vmovups	%ymm2, 0x140(%rsp)
               	movl	$0x20, %edx
               	vmovaps	%ymm0, %ymm14
               	vmovups	%ymm14, 0x40(%rsp)
               	vmovaps	%ymm1, %ymm14
               	vmovups	%ymm14, 0x20(%rsp)
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	vmovups	0x40(%rsp), %ymm14
               	vmovups	0x20(%rsp), %ymm15
               	vpavgw	%ymm15, %ymm14, %ymm0
               	leaq	0x80(%rsp), %rsi
               	leaq	0x140(%rsp), %rdi
               	vmovups	%ymm0, 0x140(%rsp)
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	vmovups	0x40(%rsp), %ymm14
               	vmovups	0x20(%rsp), %ymm15
               	vpmulhw	%ymm15, %ymm14, %ymm0
               	leaq	0xa0(%rsp), %rsi
               	leaq	0x140(%rsp), %rdi
               	vmovups	%ymm0, 0x140(%rsp)
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	vmovups	0x40(%rsp), %ymm14
               	vmovups	0x20(%rsp), %ymm15
               	vpmulhuw	%ymm15, %ymm14, %ymm0
               	leaq	0xc0(%rsp), %rsi
               	leaq	0x140(%rsp), %rdi
               	vmovups	%ymm0, 0x140(%rsp)
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	vmovups	0x40(%rsp), %ymm14
               	vmovups	0x20(%rsp), %ymm15
               	vpmulhrsw	%ymm15, %ymm14, %ymm0
               	leaq	0xe0(%rsp), %rsi
               	leaq	0x140(%rsp), %rdi
               	vmovups	%ymm0, 0x140(%rsp)
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	vmovups	0x40(%rsp), %ymm14
               	vmovups	0x20(%rsp), %ymm15
               	vpmullw	%ymm15, %ymm14, %ymm0
               	leaq	0x100(%rsp), %rsi
               	leaq	0x140(%rsp), %rdi
               	vmovups	%ymm0, 0x140(%rsp)
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	vmovups	0x40(%rsp), %ymm14
               	vmovups	0x20(%rsp), %ymm15
               	vpmuldq	%ymm15, %ymm14, %ymm0
               	leaq	0x120(%rsp), %rsi
               	leaq	0x140(%rsp), %rdi
               	vmovups	%ymm0, 0x140(%rsp)
               	movl	$0x20, %edx
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
               	addq	$0x148, %rsp            # imm = 0x148
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
               	movq	%r10, -0x48(%rbp)
               	movq	%r10, %rax
               	cmpl	$0xc, %eax
               	jge	<addr>
               	movl	$0x1, %esi
               	movq	%rax, %rcx
               	shrq	%rcx
               	imulq	$0x55555556, %rcx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rcx
               	shlxq	%rcx, %rsi, %r9
               	cmpl	$0x6, %eax
               	setl	%r15b
               	movzbq	%r15b, %r15
               	xorl	%r14d, %r14d
               	leaq	-0x1(%r9), %r8
               	movq	%r9, %rax
               	shlq	$0x3, %rax
               	leaq	-0x1(%rax), %rcx
               	movslq	%ecx, %r10
               	movq	%r10, -0x50(%rbp)
               	movq	%rax, -0x58(%rbp)
               	movl	$0x20, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%eax, %r14d
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%r9, %rdx
               	imulq	%r14, %rdx
               	movq	%r8, %rcx
               	nop
               	testl	%ecx, %ecx
               	jl	<addr>
               	shlq	$0x8, %rax
               	leaq	(%rdx,%rcx), %rsi
               	movslq	%esi, %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rax
               	decq	%rcx
               	nopw	(%rax,%rax)
               	testl	%ecx, %ecx
               	jge	<addr>
               	testq	%r15, %r15
               	je	<addr>
               	cmpl	$0x8, %r9d
               	jge	<addr>
               	movq	-0x50(%rbp), %r10
               	shrxq	%r10, %rax, %rcx
               	nopl	(%rax,%rax)
               	testb	$0x1, %cl
               	je	<addr>
               	movq	$-0x1, %rcx
               	movq	-0x58(%rbp), %rdx
               	movslq	%edx, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	orq	%rcx, %rax
               	xorl	%ecx, %ecx
               	movq	%r9, %rsi
               	imulq	%r14, %rsi
               	movq	%r8, %rdx
               	testl	%edx, %edx
               	jl	<addr>
               	shlq	$0x8, %rcx
               	leaq	(%rsi,%rdx), %rdi
               	movslq	%edi, %rdi
               	movzbq	(%r12,%rdi), %rdi
               	orq	%rdi, %rcx
               	decq	%rdx
               	testl	%edx, %edx
               	jge	<addr>
               	testq	%r15, %r15
               	je	<addr>
               	cmpl	$0x8, %r9d
               	jge	<addr>
               	movq	-0x50(%rbp), %r10
               	shrxq	%r10, %rcx, %rdx
               	nopl	(%rax)
               	testb	$0x1, %dl
               	je	<addr>
               	movq	$-0x1, %rdx
               	movq	-0x58(%rbp), %rsi
               	movslq	%esi, %rsi
               	shlxq	%rsi, %rdx, %rdx
               	orq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	setl	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rcx, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	testq	%r15, %r15
               	cmoveq	%rdx, %rsi
               	testl	%esi, %esi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	-0x48(%rbp), %r13
               	testb	$0x1, %r13b
               	cmoveq	%rsi, %rdi
               	testq	%rdi, %rdi
               	movq	%rcx, %rsi
               	cmovneq	%rax, %rsi
               	movq	%r9, %rdi
               	imulq	%r14, %rdi
               	xorl	%eax, %eax
               	cmpl	%r9d, %eax
               	jge	<addr>
               	leaq	(%rdi,%rax), %rcx
               	movslq	%ecx, %r13
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	shrxq	%rcx, %rsi, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x40(%rbp,%r13)
               	incq	%rax
               	cmpl	%r9d, %eax
               	jl	<addr>
               	incq	%r14
               	movl	$0x20, %eax
               	cltd
               	idivl	%r9d
               	nopl	(%rax)
               	cmpl	%eax, %r14d
               	jl	<addr>
               	leaq	(%rsp), %rax
               	movq	-0x48(%rbp), %rcx
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
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	addq	$0x1, -0x48(%rbp)
               	movq	-0x48(%rbp), %rax
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
               	subq	$0x78, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x100, %rsp            # imm = 0x100
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
               	movq	%r10, -0x70(%rbp)
               	movq	%r10, %rax
               	cmpl	$0x3, %eax
               	jge	<addr>
               	movl	$0x1, %ecx
               	shlxq	%rax, %rcx, %r8
               	xorl	%r10d, %r10d
               	movq	%r10, -0x68(%rbp)
               	leaq	-0x1(%r8), %r9
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
               	nopl	(%rax,%rax)
               	testl	%eax, %eax
               	jge	<addr>
               	cmpl	$0x8, %r8d
               	jge	<addr>
               	movq	%r8, %rdx
               	shlq	$0x3, %rdx
               	leaq	-0x1(%rdx), %rax
               	movslq	%eax, %rax
               	shrxq	%rax, %rcx, %rax
               	nopl	(%rax)
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movslq	%edx, %rdx
               	shlxq	%rdx, %rax, %rax
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
               	nopl	(%rax)
               	testl	%eax, %eax
               	jge	<addr>
               	cmpl	$0x8, %r8d
               	jge	<addr>
               	movq	%r8, %rsi
               	shlq	$0x3, %rsi
               	leaq	-0x1(%rsi), %rax
               	movslq	%eax, %rax
               	shrxq	%rax, %rdx, %rax
               	nopl	(%rax)
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movslq	%esi, %rsi
               	shlxq	%rsi, %rax, %rax
               	orq	%rax, %rdx
               	movq	%rcx, %r14
               	negq	%r14
               	testq	%rcx, %rcx
               	cmovgeq	%rcx, %r14
               	movq	%r8, %rdi
               	imulq	-0x68(%rbp), %rdi
               	xorl	%eax, %eax
               	cmpl	%r8d, %eax
               	jge	<addr>
               	leaq	(%rdi,%rax), %rsi
               	movslq	%esi, %r15
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	movslq	%esi, %rsi
               	shrxq	%rsi, %r14, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, -0x60(%rbp,%r15)
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	%r8d, %eax
               	jl	<addr>
               	testq	%rdx, %rdx
               	jge	<addr>
               	movq	%rcx, %rdx
               	negq	%rdx
               	movq	%r8, %rdi
               	imulq	-0x68(%rbp), %rdi
               	xorl	%eax, %eax
               	nopw	(%rax,%rax)
               	cmpl	%r8d, %eax
               	jge	<addr>
               	leaq	(%rdi,%rax), %rcx
               	movslq	%ecx, %r13
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x40(%rbp,%r13)
               	incq	%rax
               	cmpl	%r8d, %eax
               	jl	<addr>
               	jmp	<addr>
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	movq	%rax, %rdx
               	cmovneq	%rcx, %rdx
               	nopl	(%rax)
               	jmp	<addr>
               	addq	$0x1, -0x68(%rbp)
               	movl	$0x20, %eax
               	cltd
               	idivl	%r8d
               	nopw	%cs:(%rax,%rax)
               	nopl	(%rax,%rax)
               	movq	%rax, %r10
               	movq	-0x68(%rbp), %rax
               	cmpl	%r10d, %eax
               	jl	<addr>
               	leaq	(%rsp), %rax
               	movq	-0x70(%rbp), %rcx
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
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x60(%rsp), %rax
               	movq	-0x70(%rbp), %rcx
               	shlq	$0x5, %rcx
               	addq	%rax, %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0xe0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	-0x20(%rbp), %rdi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdi)
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	nopl	(%rax,%rax)
               	testq	%rax, %rax
               	jne	<addr>
               	addq	$0x1, -0x70(%rbp)
               	movq	-0x70(%rbp), %rax
               	cmpl	$0x3, %eax
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
               	movl	$0x8, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq

<model_horizontal>:
               	subq	$0x48, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	%rdi, 0x68(%rsp)
               	movq	%r9, 0x38(%rsp)
               	movq	%r8, 0x50(%rsp)
               	movq	%rcx, 0x58(%rsp)
               	movslq	%edx, %r13
               	movq	%rsi, 0x60(%rsp)
               	movl	$0x8, %eax
               	cltd
               	idivl	%r13d
               	movq	%rax, %rbp
               	xorl	%r10d, %r10d
               	movq	%r10, 0x48(%rsp)
               	leaq	-0x1(%r13), %rbx
               	movq	%r13, %rax
               	shlq	$0x3, %rax
               	leaq	-0x1(%rax), %rcx
               	movslq	%ecx, %r8
               	movq	%rax, 0x40(%rsp)
               	xorl	%r15d, %r15d
               	movq	0x48(%rsp), %r9
               	shlq	$0x4, %r9
               	movq	0x38(%rsp), %r14
               	addq	%r9, %r14
               	movq	%rbp, %rax
               	shlq	%rax
               	cmpl	%eax, %r15d
               	jge	<addr>
               	cmpl	%ebp, %r15d
               	movq	0x68(%rsp), %r10
               	movq	0x60(%rsp), %r11
               	movq	%r11, %rax
               	cmovlq	%r10, %rax
               	leaq	(%rax,%r9), %r12
               	movl	%r15d, %eax
               	cltd
               	idivl	%ebp
               	movq	%rdx, %rdi
               	shlq	%rdi
               	xorl	%eax, %eax
               	movq	%r13, %rdx
               	imulq	%rdi, %rdx
               	movq	%rbx, %rcx
               	testl	%ecx, %ecx
               	jl	<addr>
               	shlq	$0x8, %rax
               	leaq	(%rdx,%rcx), %rsi
               	movslq	%esi, %rsi
               	movzbq	(%r12,%rsi), %rsi
               	orq	%rsi, %rax
               	decq	%rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	cmpl	$0x8, %r13d
               	jge	<addr>
               	shrxq	%r8, %rax, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	movq	$-0x1, %rcx
               	movq	0x40(%rsp), %rdx
               	movslq	%edx, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	orq	%rcx, %rax
               	leaq	0x1(%rdi), %rsi
               	xorl	%ecx, %ecx
               	imulq	%r13, %rsi
               	movq	%rbx, %rdx
               	nopw	(%rax,%rax)
               	testl	%edx, %edx
               	jl	<addr>
               	shlq	$0x8, %rcx
               	leaq	(%rsi,%rdx), %rdi
               	movslq	%edi, %rdi
               	movzbq	(%r12,%rdi), %rdi
               	orq	%rdi, %rcx
               	decq	%rdx
               	nopw	(%rax,%rax)
               	testl	%edx, %edx
               	jge	<addr>
               	cmpl	$0x8, %r13d
               	jge	<addr>
               	shrxq	%r8, %rcx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	movq	$-0x1, %rdx
               	movq	0x40(%rsp), %rsi
               	movslq	%esi, %rsi
               	shlxq	%rsi, %rdx, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	addq	%rcx, %rax
               	movq	0x58(%rsp), %r10
               	testl	%r10d, %r10d
               	cmoveq	%rax, %rdx
               	movq	0x50(%rsp), %r10
               	testl	%r10d, %r10d
               	je	<addr>
               	movl	$0x1, %eax
               	shlxq	%r8, %rax, %rax
               	negq	%rax
               	movl	$0x1, %ecx
               	shlxq	%r8, %rcx, %rcx
               	decq	%rcx
               	cmpq	%rax, %rdx
               	jge	<addr>
               	movq	%rax, %rdx
               	movq	%r13, %rsi
               	imulq	%r15, %rsi
               	xorl	%eax, %eax
               	cmpl	%r13d, %eax
               	jge	<addr>
               	leaq	(%rsi,%rax), %rcx
               	movslq	%ecx, %rdi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%r14,%rdi)
               	incq	%rax
               	nop
               	cmpl	%r13d, %eax
               	jl	<addr>
               	jmp	<addr>
               	cmpq	%rcx, %rdx
               	cmovgq	%rcx, %rdx
               	jmp	<addr>
               	incq	%r15
               	movq	%rbp, %rax
               	shlq	%rax
               	nopl	(%rax)
               	cmpl	%eax, %r15d
               	jl	<addr>
               	addq	$0x1, 0x48(%rsp)
               	movq	0x48(%rsp), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x48, %rsp
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
               	movq	%r10, -0x48(%rbp)
               	movq	%r10, %rax
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
               	movq	%rax, -0x50(%rbp)
               	movl	$0x20, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%eax, %r14d
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%r9, %rdx
               	imulq	%r14, %rdx
               	movq	%r8, %rcx
               	testl	%ecx, %ecx
               	jl	<addr>
               	shlq	$0x8, %rax
               	leaq	(%rdx,%rcx), %rdi
               	movslq	%edi, %rdi
               	movzbq	(%rbx,%rdi), %rdi
               	orq	%rdi, %rax
               	decq	%rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	cmpl	$0x8, %r9d
               	jge	<addr>
               	shrxq	%r15, %rax, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movq	$-0x1, %rcx
               	movq	-0x50(%rbp), %rdx
               	movslq	%edx, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	orq	%rcx, %rax
               	xorl	%ecx, %ecx
               	movq	%r9, %rdi
               	imulq	%r14, %rdi
               	movq	%r8, %rdx
               	nopl	(%rax,%rax)
               	testl	%edx, %edx
               	jl	<addr>
               	shlq	$0x8, %rcx
               	leaq	(%rdi,%rdx), %r13
               	movslq	%r13d, %r13
               	movzbq	(%r12,%r13), %r13
               	orq	%r13, %rcx
               	decq	%rdx
               	nopw	(%rax,%rax)
               	testl	%edx, %edx
               	jge	<addr>
               	cmpl	$0x8, %r9d
               	jge	<addr>
               	shrxq	%r15, %rcx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	movq	$-0x1, %rdx
               	movq	-0x50(%rbp), %rdi
               	movslq	%edi, %rdi
               	shlxq	%rdi, %rdx, %rdx
               	orq	%rdx, %rcx
               	movq	$-0x1, %rdi
               	xorl	%edx, %edx
               	cmpq	%rcx, %rax
               	cmovleq	%rdx, %rdi
               	movq	%r9, %rdx
               	imulq	%r14, %rdx
               	xorl	%eax, %eax
               	cmpl	%r9d, %eax
               	jge	<addr>
               	leaq	(%rdx,%rax), %rcx
               	movslq	%ecx, %r13
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	shrxq	%rcx, %rdi, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x40(%rbp,%r13)
               	incq	%rax
               	cmpl	%r9d, %eax
               	jl	<addr>
               	incq	%r14
               	movl	$0x20, %eax
               	cltd
               	idivl	%r9d
               	nop
               	cmpl	%eax, %r14d
               	jl	<addr>
               	leaq	(%rsp), %rax
               	movq	-0x48(%rbp), %rcx
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
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	addq	$0x1, -0x48(%rbp)
               	movq	-0x48(%rbp), %rax
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
               	subq	$0x68, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	vmovups	(%rdi), %ymm0
               	vmovups	(%rsi), %ymm1
               	vpacksswb	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	vpackssdw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x20(%rsp)
               	vpackuswb	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x40(%rsp)
               	vpackusdw	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x60(%rsp)
               	xorl	%r10d, %r10d
               	movq	%r10, -0x60(%rbp)
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x58(%rbp)
               	movq	-0x60(%rbp), %rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0x4, %r14d
               	movl	$0x2, %ecx
               	testb	$0x1, %al
               	cmoveq	%rcx, %r14
               	movq	-0x60(%rbp), %r10
               	cmpl	$0x2, %r10d
               	setl	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x48(%rbp)
               	movl	$0x10, %eax
               	cltd
               	idivl	%r14d
               	movq	%rax, %r13
               	xorl	%r15d, %r15d
               	leaq	-0x1(%r14), %r8
               	movq	%r14, %rdi
               	shrq	%rdi
               	xorl	%r12d, %r12d
               	movq	%r13, %rax
               	shlq	%rax
               	cmpl	%eax, %r12d
               	jge	<addr>
               	cmpl	%r13d, %r12d
               	movq	-0x50(%rbp), %r10
               	movq	-0x58(%rbp), %r11
               	movq	%r11, %rax
               	cmovlq	%r10, %rax
               	movq	%r15, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rax,%rcx), %r9
               	movl	%r12d, %eax
               	cltd
               	idivl	%r13d
               	xorl	%ecx, %ecx
               	imulq	%r14, %rdx
               	movq	%r8, %rsi
               	testl	%esi, %esi
               	jl	<addr>
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rsi), %rax
               	movslq	%eax, %rax
               	movzbq	(%r9,%rax), %rax
               	orq	%rax, %rcx
               	decq	%rsi
               	nop
               	testl	%esi, %esi
               	jge	<addr>
               	movq	%r14, %rax
               	shlq	$0x3, %rax
               	decq	%rax
               	shrxq	%rax, %rcx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	%r14, %rdx
               	shlq	$0x3, %rdx
               	shlxq	%rdx, %rax, %rax
               	orq	%rax, %rcx
               	leaq	-0x40(%rbp), %rax
               	movq	%r15, %rdx
               	shlq	$0x4, %rdx
               	leaq	(%rax,%rdx), %r9
               	movq	-0x48(%rbp), %r10
               	testq	%r10, %r10
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rdi, %rdx
               	shlq	$0x3, %rdx
               	decq	%rdx
               	shlxq	%rdx, %rax, %rax
               	movq	%rax, %rsi
               	negq	%rsi
               	movq	-0x48(%rbp), %r10
               	testq	%r10, %r10
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rdi, %rdx
               	shlq	$0x3, %rdx
               	decq	%rdx
               	shlxq	%rdx, %rax, %rax
               	leaq	-0x1(%rax), %rdx
               	cmpq	%rsi, %rcx
               	jge	<addr>
               	movq	%rdi, %rax
               	imulq	%r12, %rax
               	xorl	%ecx, %ecx
               	cmpl	%edi, %ecx
               	jge	<addr>
               	leaq	(%rax,%rcx), %rdx
               	movslq	%edx, %rbx
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	movslq	%edx, %rdx
               	shrxq	%rdx, %rsi, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%r9,%rbx)
               	incq	%rcx
               	nop
               	cmpl	%edi, %ecx
               	jl	<addr>
               	jmp	<addr>
               	cmpq	%rdx, %rcx
               	movq	%rcx, %rsi
               	cmovgq	%rdx, %rsi
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rdi, %rdx
               	shlq	$0x3, %rdx
               	shlxq	%rdx, %rax, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	xorl	%esi, %esi
               	jmp	<addr>
               	incq	%r12
               	movq	%r13, %rax
               	shlq	%rax
               	nopl	(%rax)
               	cmpl	%eax, %r12d
               	jl	<addr>
               	incq	%r15
               	cmpl	$0x2, %r15d
               	jl	<addr>
               	leaq	(%rsp), %rax
               	movq	-0x60(%rbp), %rcx
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
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	addq	$0x1, -0x60(%rbp)
               	movq	-0x60(%rbp), %rax
               	cmpl	$0x4, %eax
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
               	movl	$0x40, %eax
               	leaq	-0x90(%rbp), %rsp
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
               	vmovups	(%rdi), %ymm0
               	vmovups	(%rsi), %ymm1
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
               	movq	%rdi, -0x60(%rbp)
               	movq	%rsi, -0x68(%rbp)
               	movq	-0x70(%rbp), %rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0x2, %esi
               	movl	$0x1, %ecx
               	testb	$0x1, %al
               	cmoveq	%rcx, %rsi
               	movl	$0x10, %eax
               	cltd
               	idivl	%esi
               	movq	%rax, %rcx
               	shrq	%rcx
               	xorl	%edx, %edx
               	movq	-0x70(%rbp), %rdi
               	cmpl	$0x2, %edi
               	movq	%rax, -0x50(%rbp)
               	movq	%rdx, %r10
               	cmovgeq	%rcx, %r10
               	movq	%r10, -0x48(%rbp)
               	xorl	%r10d, %r10d
               	movq	%r10, -0x58(%rbp)
               	leaq	-0x1(%rsi), %rdx
               	xorl	%r14d, %r14d
               	movq	-0x58(%rbp), %r15
               	shlq	$0x4, %r15
               	movq	-0x60(%rbp), %r9
               	addq	%r15, %r9
               	movq	-0x68(%rbp), %rbx
               	addq	%r15, %rbx
               	movq	-0x50(%rbp), %rax
               	shrq	%rax
               	cmpl	%eax, %r14d
               	jge	<addr>
               	leaq	-0x40(%rbp), %rax
               	leaq	(%rax,%r15), %r12
               	movq	%r14, %r8
               	shlq	%r8
               	movq	-0x48(%rbp), %rdi
               	addq	%r14, %rdi
               	xorl	%ecx, %ecx
               	imulq	%rsi, %rdi
               	movq	%rdx, %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rcx
               	leaq	(%rdi,%rax), %r13
               	movslq	%r13d, %r13
               	movzbq	(%r9,%r13), %r13
               	orq	%r13, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	imulq	%rsi, %r8
               	xorl	%eax, %eax
               	cmpl	%esi, %eax
               	jge	<addr>
               	leaq	(%r8,%rax), %rdi
               	movslq	%edi, %r13
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%r12,%r13)
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	%esi, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rax
               	leaq	(%rax,%r15), %r12
               	movq	%r14, %rax
               	shlq	%rax
               	leaq	0x1(%rax), %r8
               	movq	-0x48(%rbp), %rdi
               	addq	%r14, %rdi
               	xorl	%ecx, %ecx
               	imulq	%rsi, %rdi
               	movq	%rdx, %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rcx
               	leaq	(%rdi,%rax), %r13
               	movslq	%r13d, %r13
               	movzbq	(%rbx,%r13), %r13
               	orq	%r13, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	imulq	%rsi, %r8
               	xorl	%eax, %eax
               	cmpl	%esi, %eax
               	jge	<addr>
               	leaq	(%r8,%rax), %rdi
               	movslq	%edi, %r13
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%r12,%r13)
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	incq	%r14
               	movq	-0x50(%rbp), %rax
               	shrq	%rax
               	cmpl	%eax, %r14d
               	jl	<addr>
               	addq	$0x1, -0x58(%rbp)
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
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	nopw	(%rax,%rax)
               	testq	%rax, %rax
               	jne	<addr>
               	addq	$0x1, -0x70(%rbp)
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
               	subq	$0xa8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x120, %rsp            # imm = 0x120
               	andq	$-0x20, %rsp
               	xorl	%r10d, %r10d
               	movq	%r10, -0x98(%rbp)
               	movq	-0x98(%rbp), %r11
               	movq	%r11, -0x90(%rbp)
               	jmp	<addr>
               	movq	-0x90(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x90(%rbp)
               	leaq	-0x80(%rbp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	vzeroupper
               	callq	<addr>
               	movq	-0x90(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x90(%rbp)
               	leaq	-0x80(%rbp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	vzeroupper
               	callq	<addr>
               	movq	-0x90(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x90(%rbp)
               	leaq	-0x80(%rbp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	vzeroupper
               	callq	<addr>
               	movq	-0x90(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x90(%rbp)
               	leaq	-0x80(%rbp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	vzeroupper
               	callq	<addr>
               	movq	-0x90(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x90(%rbp)
               	leaq	-0x80(%rbp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	vzeroupper
               	callq	<addr>
               	movq	-0x90(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x90(%rbp)
               	leaq	-0x80(%rbp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	vzeroupper
               	callq	<addr>
               	movq	-0x90(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x90(%rbp)
               	leaq	-0x80(%rbp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	vzeroupper
               	callq	<addr>
               	movq	-0x90(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x90(%rbp)
               	addq	$0x1, -0x98(%rbp)
               	nopl	(%rax)
               	movq	-0x98(%rbp), %rax
               	cmpl	$0x12c, %eax            # imm = 0x12C
               	jge	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	movb	%al, -0x80(%rbp,%rcx)
               	incq	%rcx
               	nopl	(%rax)
               	cmpl	$0x20, %ecx
               	jge	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, %rsi
               	shrq	$0x1b, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movq	%rax, %rsi
               	shrq	$0x3c, %rsi
               	cmpl	$0x4, %esi
               	jae	<addr>
               	leaq	<rip>, %rsi # <addr>
               	shrq	$0x3a, %rax
               	andq	$0x3, %rax
               	movzbq	(%rsi,%rax), %rax
               	jmp	<addr>
               	shrq	$0x18, %rax
               	andq	$0xff, %rax
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	movb	%al, -0x60(%rbp,%rcx)
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jge	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, %rsi
               	shrq	$0x1b, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movq	%rax, %rsi
               	shrq	$0x3c, %rsi
               	cmpl	$0x4, %esi
               	jae	<addr>
               	leaq	<rip>, %rsi # <addr>
               	shrq	$0x3a, %rax
               	andq	$0x3, %rax
               	movzbq	(%rsi,%rax), %rax
               	jmp	<addr>
               	shrq	$0x18, %rax
               	andq	$0xff, %rax
               	jmp	<addr>
               	movq	-0x98(%rbp), %rax
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
               	movq	%r10, -0x88(%rbp)
               	movq	%r10, %rax
               	nop
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	$0x2, %edi
               	movl	$0x1, %ecx
               	testb	$0x1, %al
               	cmoveq	%rcx, %rdi
               	movq	-0x88(%rbp), %r15
               	andq	$0x2, %r15
               	leaq	-0x1(%rdi), %rsi
               	xorl	%r14d, %r14d
               	movl	$0x20, %eax
               	cltd
               	idivl	%edi
               	cmpl	%eax, %r14d
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rdi, %rdx
               	imulq	%r14, %rdx
               	movq	%rsi, %rcx
               	testl	%ecx, %ecx
               	jl	<addr>
               	shlq	$0x8, %rax
               	leaq	(%rdx,%rcx), %r8
               	movslq	%r8d, %r8
               	movzbq	-0x80(%rbp,%r8), %r8
               	orq	%r8, %rax
               	decq	%rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	testl	%r15d, %r15d
               	jne	<addr>
               	movq	%rdi, %rcx
               	shlq	$0x3, %rcx
               	decq	%rcx
               	shrxq	%rcx, %rax, %rcx
               	nopl	(%rax,%rax)
               	testb	$0x1, %cl
               	je	<addr>
               	movq	$-0x1, %rcx
               	movq	%rdi, %rdx
               	shlq	$0x3, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	orq	%rcx, %rax
               	xorl	%ecx, %ecx
               	movq	%rdi, %r8
               	imulq	%r14, %r8
               	movq	%rsi, %rdx
               	testl	%edx, %edx
               	jl	<addr>
               	shlq	$0x8, %rcx
               	leaq	(%r8,%rdx), %r9
               	movslq	%r9d, %r9
               	movzbq	-0x60(%rbp,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rdx
               	testl	%edx, %edx
               	jge	<addr>
               	testl	%r15d, %r15d
               	jne	<addr>
               	movq	%rdi, %rdx
               	shlq	$0x3, %rdx
               	decq	%rdx
               	shrxq	%rdx, %rcx, %rdx
               	nopw	(%rax,%rax)
               	testb	$0x1, %dl
               	je	<addr>
               	movq	$-0x1, %rdx
               	movq	%rdi, %r8
               	shlq	$0x3, %r8
               	shlxq	%r8, %rdx, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	addq	%rax, %rcx
               	movq	-0x88(%rbp), %rax
               	cmpl	$0x4, %eax
               	cmovgeq	%rdx, %rcx
               	testl	%r15d, %r15d
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rdi, %rdx
               	shlq	$0x3, %rdx
               	decq	%rdx
               	shlxq	%rdx, %rax, %rax
               	movq	%rax, %rdx
               	negq	%rdx
               	testl	%r15d, %r15d
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rdi, %r9
               	shlq	$0x3, %r9
               	decq	%r9
               	shlxq	%r9, %rax, %rax
               	decq	%rax
               	cmpq	%rdx, %rcx
               	jge	<addr>
               	movq	%rdi, %r9
               	imulq	%r14, %r9
               	xorl	%eax, %eax
               	cmpl	%edi, %eax
               	jge	<addr>
               	leaq	(%r9,%rax), %rcx
               	movslq	%ecx, %r13
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x40(%rbp,%r13)
               	incq	%rax
               	cmpl	%edi, %eax
               	jl	<addr>
               	jmp	<addr>
               	cmpq	%rax, %rcx
               	movq	%rcx, %rdx
               	cmovgq	%rax, %rdx
               	nopl	(%rax)
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rdi, %r9
               	shlq	$0x3, %r9
               	shlxq	%r9, %rax, %rax
               	decq	%rax
               	jmp	<addr>
               	xorl	%edx, %edx
               	nopl	(%rax)
               	jmp	<addr>
               	incq	%r14
               	movl	$0x20, %eax
               	cltd
               	idivl	%edi
               	cmpl	%eax, %r14d
               	jl	<addr>
               	leaq	(%rsp), %rax
               	movq	-0x88(%rbp), %rcx
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
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	addq	$0x1, -0x88(%rbp)
               	movq	-0x88(%rbp), %rax
               	nopl	(%rax,%rax)
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movq	-0x90(%rbp), %rax
               	leaq	-0xd0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
