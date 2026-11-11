
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
               	subq	$0x148, %rsp            # imm = 0x148
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
               	xorl	%eax, %eax
               	xorl	%edx, %edx
               	movl	$0x1, %ecx
               	shlq	$0x8, %rdx
               	movq	%rax, %r8
               	shlq	%r8
               	addq	%rcx, %r8
               	movslq	%r8d, %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rdx
               	decq	%rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	movq	%rdx, %rcx
               	shrq	$0xf, %rcx
               	movq	%rdx, %r8
               	orq	$-0x10000, %r8          # imm = 0xFFFF0000
               	testb	$0x1, %cl
               	movq	%rdx, %r9
               	cmovneq	%r8, %r9
               	xorl	%edx, %edx
               	movl	$0x1, %ecx
               	shlq	$0x8, %rdx
               	movq	%rax, %r8
               	shlq	%r8
               	addq	%rcx, %r8
               	movslq	%r8d, %r8
               	movzbq	(%rsi,%r8), %r8
               	orq	%r8, %rdx
               	decq	%rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	movq	%rdx, %rcx
               	shrq	$0xf, %rcx
               	movq	%rdx, %r8
               	orq	$-0x10000, %r8          # imm = 0xFFFF0000
               	testb	$0x1, %cl
               	movq	%rdx, %rcx
               	cmovneq	%r8, %rcx
               	imulq	%rcx, %r9
               	xorl	%edx, %edx
               	movl	$0x1, %ecx
               	shlq	$0x8, %rdx
               	movq	%rax, %r8
               	shlq	%r8
               	addq	%rcx, %r8
               	movslq	%r8d, %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rdx
               	decq	%rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	xorl	%r8d, %r8d
               	movl	$0x1, %ecx
               	shlq	$0x8, %r8
               	movq	%rax, %rbx
               	shlq	%rbx
               	addq	%rcx, %rbx
               	movslq	%ebx, %rbx
               	movzbq	(%rsi,%rbx), %rbx
               	orq	%rbx, %r8
               	decq	%rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	movq	%rdx, %r13
               	imulq	%r8, %r13
               	leaq	-0xe0(%rbp), %rbx
               	xorl	%edx, %edx
               	movl	$0x1, %ecx
               	shlq	$0x8, %rdx
               	movq	%rax, %r8
               	shlq	%r8
               	addq	%rcx, %r8
               	movslq	%r8d, %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rdx
               	decq	%rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	xorl	%r8d, %r8d
               	movl	$0x1, %ecx
               	shlq	$0x8, %r8
               	movq	%rax, %r12
               	shlq	%r12
               	addq	%rcx, %r12
               	movslq	%r12d, %r12
               	movzbq	(%rsi,%r12), %r12
               	orq	%r12, %r8
               	decq	%rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	(%rdx,%r8), %rcx
               	leaq	0x1(%rcx), %rdx
               	shrq	%rdx
               	xorl	%ecx, %ecx
               	movq	%rax, %r8
               	shlq	%r8
               	addq	%rcx, %r8
               	movslq	%r8d, %r8
               	movq	%rcx, %r12
               	shlq	$0x3, %r12
               	shrxq	%r12, %rdx, %r12
               	andq	$0xff, %r12
               	movb	%r12b, (%rbx,%r8)
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jl	<addr>
               	leaq	-0xc0(%rbp), %rdx
               	movq	%r9, %r8
               	sarq	$0x10, %r8
               	xorl	%ecx, %ecx
               	movq	%rax, %rbx
               	shlq	%rbx
               	addq	%rcx, %rbx
               	movslq	%ebx, %rbx
               	movq	%rcx, %r12
               	shlq	$0x3, %r12
               	shrxq	%r12, %r8, %r12
               	andq	$0xff, %r12
               	movb	%r12b, (%rdx,%rbx)
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jl	<addr>
               	leaq	-0xa0(%rbp), %rdx
               	movq	%r13, %r8
               	shrq	$0x10, %r8
               	xorl	%ecx, %ecx
               	movq	%rax, %rbx
               	shlq	%rbx
               	addq	%rcx, %rbx
               	movslq	%ebx, %rbx
               	movq	%rcx, %r12
               	shlq	$0x3, %r12
               	shrxq	%r12, %r8, %r12
               	andq	$0xff, %r12
               	movb	%r12b, (%rdx,%rbx)
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jl	<addr>
               	leaq	-0x80(%rbp), %rdx
               	movq	%r9, %rcx
               	sarq	$0xe, %rcx
               	leaq	0x1(%rcx), %r8
               	sarq	%r8
               	xorl	%ecx, %ecx
               	movq	%rax, %rbx
               	shlq	%rbx
               	addq	%rcx, %rbx
               	movslq	%ebx, %rbx
               	movq	%rcx, %r12
               	shlq	$0x3, %r12
               	shrxq	%r12, %r8, %r12
               	andq	$0xff, %r12
               	movb	%r12b, (%rdx,%rbx)
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jl	<addr>
               	leaq	-0x60(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movq	%rax, %r8
               	shlq	%r8
               	addq	%rcx, %r8
               	movslq	%r8d, %r8
               	movq	%rcx, %rbx
               	shlq	$0x3, %rbx
               	shrxq	%rbx, %r9, %rbx
               	andq	$0xff, %rbx
               	movb	%bl, (%rdx,%r8)
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jl	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
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
               	vzeroupper
               	leave
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>

<check_extremes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
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
               	leaq	(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	movups	%xmm14, 0x60(%rax)
               	movups	%xmm14, 0x70(%rax)
               	movups	%xmm14, 0x80(%rax)
               	movups	%xmm14, 0x90(%rax)
               	movups	%xmm14, 0xa0(%rax)
               	movups	%xmm14, 0xb0(%rax)
               	movups	%xmm14, 0xc0(%rax)
               	movups	%xmm14, 0xd0(%rax)
               	movups	%xmm14, 0xe0(%rax)
               	movups	%xmm14, 0xf0(%rax)
               	movups	%xmm14, 0x100(%rax)
               	movups	%xmm14, 0x110(%rax)
               	movups	%xmm14, 0x120(%rax)
               	movups	%xmm14, 0x130(%rax)
               	movups	%xmm14, 0x140(%rax)
               	movups	%xmm14, 0x150(%rax)
               	movups	%xmm14, 0x160(%rax)
               	movups	%xmm14, 0x170(%rax)
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
               	xorl	%r14d, %r14d
               	movl	$0x1, %ecx
               	movq	%r14, %rax
               	shrq	%rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	shlxq	%rax, %rcx, %rcx
               	cmpl	$0x6, %r14d
               	setl	%r13b
               	movzbq	%r13b, %r13
               	xorl	%r9d, %r9d
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r9d
               	jge	<addr>
               	xorl	%edx, %edx
               	leaq	-0x1(%rcx), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rdx
               	movq	%rcx, %rsi
               	imulq	%r9, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	testq	%r13, %r13
               	je	<addr>
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	decq	%rax
               	movslq	%eax, %rax
               	shrxq	%rax, %rdx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	movslq	%esi, %rsi
               	shlxq	%rsi, %rax, %rax
               	orq	%rax, %rdx
               	xorl	%r8d, %r8d
               	leaq	-0x1(%rcx), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %r8
               	movq	%rcx, %rsi
               	imulq	%r9, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movzbq	(%r12,%rsi), %rsi
               	orq	%rsi, %r8
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	testq	%r13, %r13
               	je	<addr>
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	decq	%rax
               	movslq	%eax, %rax
               	shrxq	%rax, %r8, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	movslq	%esi, %rsi
               	shlxq	%rsi, %rax, %rax
               	orq	%rax, %r8
               	cmpq	%r8, %rdx
               	setl	%al
               	movzbq	%al, %rax
               	cmpq	%r8, %rdx
               	setb	%sil
               	movzbq	%sil, %rsi
               	testq	%r13, %r13
               	cmoveq	%rsi, %rax
               	leaq	-0x40(%rbp), %rsi
               	testl	%eax, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testb	$0x1, %r14b
               	cmovneq	%rdi, %rax
               	testq	%rax, %rax
               	cmoveq	%r8, %rdx
               	xorl	%eax, %eax
               	cmpl	%ecx, %eax
               	jge	<addr>
               	movq	%rcx, %rdi
               	imulq	%r9, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	movslq	%r8d, %r8
               	shrxq	%r8, %rdx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rsi,%rdi)
               	incq	%rax
               	cmpl	%ecx, %eax
               	jl	<addr>
               	incq	%r9
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r9d
               	jl	<addr>
               	leaq	(%rsp), %rax
               	movq	%r14, %rcx
               	shlq	$0x5, %rcx
               	addq	%rax, %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x180(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%r14
               	cmpl	$0xc, %r14d
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x70(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x4, %eax
               	leaq	-0x70(%rbp), %rsp
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
               	subq	$0x68, %rsp
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
               	leaq	(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	vpabsb	%ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	vpabsw	%ymm0, %ymm2
               	vmovups	%ymm2, 0x20(%rsp)
               	vpabsd	%ymm0, %ymm2
               	vmovups	%ymm2, 0x40(%rsp)
               	leaq	0x60(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	vpsignb	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x60(%rsp)
               	vpsignw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x80(%rsp)
               	vpsignd	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0xa0(%rsp)
               	xorl	%r15d, %r15d
               	movl	$0x1, %eax
               	shlxq	%r15, %rax, %rcx
               	xorl	%r8d, %r8d
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r8d
               	jge	<addr>
               	xorl	%edx, %edx
               	leaq	-0x1(%rcx), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rdx
               	movq	%rcx, %rsi
               	imulq	%r8, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	leaq	-0x1(%rax), %rsi
               	movslq	%esi, %rsi
               	shrxq	%rsi, %rdx, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movq	$-0x1, %rsi
               	movslq	%eax, %rax
               	shlxq	%rax, %rsi, %rax
               	orq	%rax, %rdx
               	xorl	%r9d, %r9d
               	leaq	-0x1(%rcx), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %r9
               	movq	%rcx, %rsi
               	imulq	%r8, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movzbq	(%r12,%rsi), %rsi
               	orq	%rsi, %r9
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	leaq	-0x1(%rax), %rsi
               	movslq	%esi, %rsi
               	shrxq	%rsi, %r9, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movq	$-0x1, %rsi
               	movslq	%eax, %rax
               	shlxq	%rax, %rsi, %rax
               	orq	%rax, %r9
               	leaq	-0x60(%rbp), %rsi
               	movq	%rdx, %rax
               	negq	%rax
               	testq	%rdx, %rdx
               	movq	%rdx, %rdi
               	cmovlq	%rax, %rdi
               	xorl	%eax, %eax
               	cmpl	%ecx, %eax
               	jge	<addr>
               	movq	%rcx, %r13
               	imulq	%r8, %r13
               	addq	%rax, %r13
               	movslq	%r13d, %r13
               	movq	%rax, %r14
               	shlq	$0x3, %r14
               	movslq	%r14d, %r14
               	shrxq	%r14, %rdi, %r14
               	andq	$0xff, %r14
               	movb	%r14b, (%rsi,%r13)
               	incq	%rax
               	cmpl	%ecx, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rsi
               	testq	%r9, %r9
               	jge	<addr>
               	negq	%rdx
               	xorl	%eax, %eax
               	cmpl	%ecx, %eax
               	jge	<addr>
               	movq	%rcx, %rdi
               	imulq	%r8, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	movslq	%r9d, %r9
               	shrxq	%r9, %rdx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rsi,%rdi)
               	incq	%rax
               	cmpl	%ecx, %eax
               	jge	<addr>
               	jmp	<addr>
               	xorl	%eax, %eax
               	testq	%r9, %r9
               	cmoveq	%rax, %rdx
               	jmp	<addr>
               	incq	%r8
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r8d
               	jl	<addr>
               	leaq	(%rsp), %rax
               	movq	%r15, %rcx
               	shlq	$0x5, %rcx
               	addq	%rax, %rcx
               	leaq	-0x60(%rbp), %rsi
               	leaq	0xc0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x60(%rsp), %rax
               	movq	%r15, %rcx
               	shlq	$0x5, %rcx
               	addq	%rax, %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0xc0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%r15
               	cmpl	$0x3, %r15d
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
               	movl	$0x8, %eax
               	leaq	-0x90(%rbp), %rsp
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
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, 0x48(%rsp)
               	movq	%rcx, 0x38(%rsp)
               	movq	%rdx, %rbx
               	movq	%rsi, 0x40(%rsp)
               	movl	$0x8, %eax
               	cltd
               	idivl	%ebx
               	movq	%rax, %r14
               	xorl	%r15d, %r15d
               	xorl	%r13d, %r13d
               	movq	%r14, %rax
               	shlq	%rax
               	cmpl	%eax, %r13d
               	jge	<addr>
               	cmpl	%r14d, %r13d
               	movq	0x48(%rsp), %r10
               	movq	0x40(%rsp), %r11
               	movq	%r11, %rax
               	cmovlq	%r10, %rax
               	movq	%r15, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rax,%rcx), %r12
               	movl	%r13d, %eax
               	cltd
               	idivl	%r14d
               	movq	%rdx, %rcx
               	shlq	%rcx
               	xorl	%eax, %eax
               	leaq	-0x1(%rbx), %rdx
               	testl	%edx, %edx
               	jl	<addr>
               	shlq	$0x8, %rax
               	movq	%rbx, %rsi
               	imulq	%rcx, %rsi
               	addq	%rdx, %rsi
               	movslq	%esi, %rsi
               	movzbq	(%r12,%rsi), %rsi
               	orq	%rsi, %rax
               	decq	%rdx
               	testl	%edx, %edx
               	jge	<addr>
               	cmpl	$0x8, %ebx
               	jge	<addr>
               	movq	%rbx, %rdx
               	shlq	$0x3, %rdx
               	decq	%rdx
               	movslq	%edx, %rdx
               	shrxq	%rdx, %rax, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	movq	$-0x1, %rdx
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	movslq	%esi, %rsi
               	shlxq	%rsi, %rdx, %rdx
               	orq	%rdx, %rax
               	leaq	0x1(%rcx), %rsi
               	xorl	%ecx, %ecx
               	leaq	-0x1(%rbx), %rdx
               	testl	%edx, %edx
               	jl	<addr>
               	shlq	$0x8, %rcx
               	movq	%rbx, %rdi
               	imulq	%rsi, %rdi
               	addq	%rdx, %rdi
               	movslq	%edi, %rdi
               	movzbq	(%r12,%rdi), %rdi
               	orq	%rdi, %rcx
               	decq	%rdx
               	testl	%edx, %edx
               	jge	<addr>
               	cmpl	$0x8, %ebx
               	jge	<addr>
               	movq	%rbx, %rdx
               	shlq	$0x3, %rdx
               	decq	%rdx
               	movslq	%edx, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	movq	$-0x1, %rdx
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	movslq	%esi, %rsi
               	shlxq	%rsi, %rdx, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	addq	%rcx, %rax
               	movq	0x38(%rsp), %r10
               	testl	%r10d, %r10d
               	cmoveq	%rax, %rdx
               	movq	%r15, %rax
               	shlq	$0x4, %rax
               	leaq	(%r9,%rax), %rcx
               	testl	%r8d, %r8d
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	decq	%rsi
               	movslq	%esi, %rsi
               	shlxq	%rsi, %rax, %rax
               	negq	%rax
               	movl	$0x1, %esi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	decq	%rdi
               	movslq	%edi, %rdi
               	shlxq	%rdi, %rsi, %rsi
               	decq	%rsi
               	cmpq	%rax, %rdx
               	jge	<addr>
               	movq	%rax, %rdx
               	xorl	%eax, %eax
               	cmpl	%ebx, %eax
               	jge	<addr>
               	movq	%rbx, %rsi
               	imulq	%r13, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	shrxq	%rdi, %rdx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rcx,%rsi)
               	incq	%rax
               	cmpl	%ebx, %eax
               	jge	<addr>
               	jmp	<addr>
               	cmpq	%rsi, %rdx
               	cmovgq	%rsi, %rdx
               	jmp	<addr>
               	incq	%r13
               	movq	%r14, %rax
               	shlq	%rax
               	cmpl	%eax, %r13d
               	jl	<addr>
               	incq	%r15
               	cmpl	$0x2, %r15d
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
               	leaq	(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	movups	%xmm14, 0x60(%rax)
               	movups	%xmm14, 0x70(%rax)
               	movups	%xmm14, 0x80(%rax)
               	movups	%xmm14, 0x90(%rax)
               	movups	%xmm14, 0xa0(%rax)
               	movups	%xmm14, 0xb0(%rax)
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
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
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
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
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
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
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
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
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
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
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
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
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
               	subq	$0x48, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	vmovups	(%rbx), %ymm0
               	vmovups	(%r12), %ymm1
               	leaq	(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	movups	%xmm14, 0x60(%rax)
               	movups	%xmm14, 0x70(%rax)
               	vpcmpgtb	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	vpcmpgtw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x20(%rsp)
               	vpcmpgtd	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x40(%rsp)
               	vpcmpgtq	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x60(%rsp)
               	xorl	%r13d, %r13d
               	movl	$0x1, %eax
               	shlxq	%r13, %rax, %rcx
               	xorl	%r9d, %r9d
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r9d
               	jge	<addr>
               	leaq	-0x40(%rbp), %rsi
               	xorl	%edx, %edx
               	leaq	-0x1(%rcx), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rdx
               	movq	%rcx, %rdi
               	imulq	%r9, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movzbq	(%rbx,%rdi), %rdi
               	orq	%rdi, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	leaq	-0x1(%rax), %rdi
               	movslq	%edi, %rdi
               	shrxq	%rdi, %rdx, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	movq	$-0x1, %rdi
               	movslq	%eax, %rax
               	shlxq	%rax, %rdi, %rax
               	orq	%rax, %rdx
               	xorl	%r8d, %r8d
               	leaq	-0x1(%rcx), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %r8
               	movq	%rcx, %rdi
               	imulq	%r9, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movzbq	(%r12,%rdi), %rdi
               	orq	%rdi, %r8
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	decq	%rax
               	movslq	%eax, %rax
               	shrxq	%rax, %r8, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	%rcx, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	shlxq	%rdi, %rax, %rax
               	orq	%rax, %r8
               	movq	$-0x1, %rax
               	xorl	%edi, %edi
               	cmpq	%r8, %rdx
               	movq	%rdi, %rdx
               	cmovgq	%rax, %rdx
               	xorl	%eax, %eax
               	cmpl	%ecx, %eax
               	jge	<addr>
               	movq	%rcx, %rdi
               	imulq	%r9, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	movslq	%r8d, %r8
               	shrxq	%r8, %rdx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rsi,%rdi)
               	incq	%rax
               	cmpl	%ecx, %eax
               	jl	<addr>
               	incq	%r9
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r9d
               	jl	<addr>
               	leaq	(%rsp), %rax
               	movq	%r13, %rcx
               	shlq	$0x5, %rcx
               	addq	%rax, %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%r13
               	cmpl	$0x4, %r13d
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	vzeroupper
               	leave
               	retq
               	movl	$0x20, %eax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
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
               	movq	%rdi, -0x48(%rbp)
               	movq	%rsi, -0x50(%rbp)
               	movq	-0x48(%rbp), %r10
               	vmovups	(%r10), %ymm0
               	movq	-0x50(%rbp), %r10
               	vmovups	(%r10), %ymm1
               	leaq	(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	movups	%xmm14, 0x60(%rax)
               	movups	%xmm14, 0x70(%rax)
               	vpacksswb	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	vpackssdw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x20(%rsp)
               	vpackuswb	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x40(%rsp)
               	vpackusdw	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x60(%rsp)
               	xorl	%r10d, %r10d
               	movq	%r10, -0x58(%rbp)
               	movq	-0x58(%rbp), %rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0x4, %ecx
               	movl	$0x2, %edx
               	testb	$0x1, %al
               	movq	%rdx, %rbx
               	cmovneq	%rcx, %rbx
               	movq	-0x58(%rbp), %r15
               	cmpl	$0x2, %r15d
               	setl	%r15b
               	movzbq	%r15b, %r15
               	movl	$0x10, %eax
               	cltd
               	idivl	%ebx
               	movq	%rax, %r13
               	xorl	%r14d, %r14d
               	xorl	%r9d, %r9d
               	movq	%r13, %rax
               	shlq	%rax
               	cmpl	%eax, %r9d
               	jge	<addr>
               	cmpl	%r13d, %r9d
               	movq	-0x48(%rbp), %r10
               	movq	-0x50(%rbp), %r11
               	movq	%r11, %rax
               	cmovlq	%r10, %rax
               	movq	%r14, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rax,%rcx), %r12
               	movl	%r9d, %eax
               	cltd
               	idivl	%r13d
               	xorl	%r8d, %r8d
               	leaq	-0x1(%rbx), %rcx
               	testl	%ecx, %ecx
               	jl	<addr>
               	shlq	$0x8, %r8
               	movq	%rbx, %rax
               	imulq	%rdx, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movzbq	(%r12,%rax), %rax
               	orq	%rax, %r8
               	decq	%rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	decq	%rax
               	shrxq	%rax, %r8, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	shlxq	%rcx, %rax, %rax
               	orq	%rax, %r8
               	leaq	-0x40(%rbp), %rax
               	movq	%r14, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rax,%rcx), %rsi
               	movq	%rbx, %rdx
               	shrq	%rdx
               	testq	%r15, %r15
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	decq	%rcx
               	shlxq	%rcx, %rax, %rax
               	negq	%rax
               	testq	%r15, %r15
               	je	<addr>
               	movl	$0x1, %ecx
               	movq	%rdx, %rdi
               	shlq	$0x3, %rdi
               	decq	%rdi
               	shlxq	%rdi, %rcx, %rcx
               	decq	%rcx
               	cmpq	%rax, %r8
               	jge	<addr>
               	xorl	%ecx, %ecx
               	cmpl	%edx, %ecx
               	jge	<addr>
               	movq	%rdx, %r8
               	imulq	%r9, %r8
               	addq	%rcx, %r8
               	movslq	%r8d, %r8
               	movq	%rcx, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	shrxq	%rdi, %rax, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi,%r8)
               	incq	%rcx
               	cmpl	%edx, %ecx
               	jge	<addr>
               	jmp	<addr>
               	cmpq	%rcx, %r8
               	movq	%r8, %rax
               	cmovgq	%rcx, %rax
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rdx, %rdi
               	shlq	$0x3, %rdi
               	shlxq	%rdi, %rcx, %rcx
               	decq	%rcx
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%r9
               	movq	%r13, %rax
               	shlq	%rax
               	cmpl	%eax, %r9d
               	jl	<addr>
               	incq	%r14
               	cmpl	$0x2, %r14d
               	jl	<addr>
               	leaq	(%rsp), %rax
               	movq	-0x58(%rbp), %rcx
               	shlq	$0x5, %rcx
               	addq	%rax, %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x58(%rbp), %r10
               	incq	%r10
               	movq	%r10, -0x58(%rbp)
               	movq	-0x58(%rbp), %rax
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
               	subq	$0x68, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x48(%rbp)
               	movq	%rsi, -0x50(%rbp)
               	movq	-0x48(%rbp), %r10
               	vmovups	(%r10), %ymm0
               	movq	-0x50(%rbp), %r10
               	vmovups	(%r10), %ymm1
               	leaq	(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	movups	%xmm14, 0x60(%rax)
               	movups	%xmm14, 0x70(%rax)
               	vpunpcklbw	%ymm1, %ymm0, %ymm2 # ymm2 = ymm0[0],ymm1[0],ymm0[1],ymm1[1],ymm0[2],ymm1[2],ymm0[3],ymm1[3],ymm0[4],ymm1[4],ymm0[5],ymm1[5],ymm0[6],ymm1[6],ymm0[7],ymm1[7],ymm0[16],ymm1[16],ymm0[17],ymm1[17],ymm0[18],ymm1[18],ymm0[19],ymm1[19],ymm0[20],ymm1[20],ymm0[21],ymm1[21],ymm0[22],ymm1[22],ymm0[23],ymm1[23]
               	vmovups	%ymm2, (%rsp)
               	vpunpcklwd	%ymm1, %ymm0, %ymm2 # ymm2 = ymm0[0],ymm1[0],ymm0[1],ymm1[1],ymm0[2],ymm1[2],ymm0[3],ymm1[3],ymm0[8],ymm1[8],ymm0[9],ymm1[9],ymm0[10],ymm1[10],ymm0[11],ymm1[11]
               	vmovups	%ymm2, 0x20(%rsp)
               	vpunpckhbw	%ymm1, %ymm0, %ymm2 # ymm2 = ymm0[8],ymm1[8],ymm0[9],ymm1[9],ymm0[10],ymm1[10],ymm0[11],ymm1[11],ymm0[12],ymm1[12],ymm0[13],ymm1[13],ymm0[14],ymm1[14],ymm0[15],ymm1[15],ymm0[24],ymm1[24],ymm0[25],ymm1[25],ymm0[26],ymm1[26],ymm0[27],ymm1[27],ymm0[28],ymm1[28],ymm0[29],ymm1[29],ymm0[30],ymm1[30],ymm0[31],ymm1[31]
               	vmovups	%ymm2, 0x40(%rsp)
               	vpunpckhwd	%ymm1, %ymm0, %ymm0 # ymm0 = ymm0[4],ymm1[4],ymm0[5],ymm1[5],ymm0[6],ymm1[6],ymm0[7],ymm1[7],ymm0[12],ymm1[12],ymm0[13],ymm1[13],ymm0[14],ymm1[14],ymm0[15],ymm1[15]
               	vmovups	%ymm0, 0x60(%rsp)
               	xorl	%r10d, %r10d
               	movq	%r10, -0x58(%rbp)
               	movq	-0x58(%rbp), %rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0x2, %ecx
               	movl	$0x1, %edx
               	testb	$0x1, %al
               	cmoveq	%rdx, %rcx
               	movl	$0x10, %eax
               	cltd
               	idivl	%ecx
               	movq	%rax, %r15
               	movq	%r15, %rax
               	shrq	%rax
               	xorl	%edx, %edx
               	movq	-0x58(%rbp), %rsi
               	cmpl	$0x2, %esi
               	movq	%rdx, %r14
               	cmovgeq	%rax, %r14
               	xorl	%r13d, %r13d
               	xorl	%r12d, %r12d
               	movq	%r15, %rax
               	shrq	%rax
               	cmpl	%eax, %r12d
               	jge	<addr>
               	leaq	-0x40(%rbp), %rax
               	movq	%r13, %rdx
               	shlq	$0x4, %rdx
               	leaq	(%rax,%rdx), %r9
               	movq	%r12, %rax
               	shlq	%rax
               	movq	-0x48(%rbp), %rsi
               	addq	%rdx, %rsi
               	leaq	(%r14,%r12), %rdi
               	xorl	%r8d, %r8d
               	leaq	-0x1(%rcx), %rdx
               	testl	%edx, %edx
               	jl	<addr>
               	shlq	$0x8, %r8
               	movq	%rcx, %rbx
               	imulq	%rdi, %rbx
               	addq	%rdx, %rbx
               	movslq	%ebx, %rbx
               	movzbq	(%rsi,%rbx), %rbx
               	orq	%rbx, %r8
               	decq	%rdx
               	testl	%edx, %edx
               	jge	<addr>
               	xorl	%edx, %edx
               	cmpl	%ecx, %edx
               	jge	<addr>
               	movq	%rcx, %rsi
               	imulq	%rax, %rsi
               	addq	%rdx, %rsi
               	movslq	%esi, %rsi
               	movq	%rdx, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	shrxq	%rdi, %r8, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%r9,%rsi)
               	incq	%rdx
               	cmpl	%ecx, %edx
               	jl	<addr>
               	leaq	-0x40(%rbp), %rax
               	movq	%r13, %rdx
               	shlq	$0x4, %rdx
               	leaq	(%rax,%rdx), %r9
               	movq	%r12, %rax
               	shlq	%rax
               	incq	%rax
               	movq	-0x50(%rbp), %rsi
               	addq	%rdx, %rsi
               	leaq	(%r14,%r12), %rdi
               	xorl	%r8d, %r8d
               	leaq	-0x1(%rcx), %rdx
               	testl	%edx, %edx
               	jl	<addr>
               	shlq	$0x8, %r8
               	movq	%rcx, %rbx
               	imulq	%rdi, %rbx
               	addq	%rdx, %rbx
               	movslq	%ebx, %rbx
               	movzbq	(%rsi,%rbx), %rbx
               	orq	%rbx, %r8
               	decq	%rdx
               	testl	%edx, %edx
               	jge	<addr>
               	xorl	%edx, %edx
               	cmpl	%ecx, %edx
               	jge	<addr>
               	movq	%rcx, %rsi
               	imulq	%rax, %rsi
               	addq	%rdx, %rsi
               	movslq	%esi, %rsi
               	movq	%rdx, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	shrxq	%rdi, %r8, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%r9,%rsi)
               	incq	%rdx
               	cmpl	%ecx, %edx
               	jl	<addr>
               	incq	%r12
               	movq	%r15, %rax
               	shrq	%rax
               	cmpl	%eax, %r12d
               	jl	<addr>
               	incq	%r13
               	cmpl	$0x2, %r13d
               	jl	<addr>
               	leaq	(%rsp), %rax
               	movq	-0x58(%rbp), %rcx
               	shlq	$0x5, %rcx
               	addq	%rax, %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x58(%rbp), %r10
               	incq	%r10
               	movq	%r10, -0x58(%rbp)
               	movq	-0x58(%rbp), %rax
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
               	movl	$0x80, %eax
               	leaq	-0x90(%rbp), %rsp
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
               	subq	$0x98, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x120, %rsp            # imm = 0x120
               	andq	$-0x20, %rsp
               	xorl	%r15d, %r15d
               	movq	%r15, -0x88(%rbp)
               	leaq	-0x80(%rbp), %rdx
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
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
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %rdx
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
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
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	imulq	$0x33333334, %r15, %rax # imm = 0x33333334
               	shrq	$0x20, %rax
               	leaq	(%rax,%rax,4), %rax
               	movq	%r15, %rcx
               	subq	%rax, %rcx
               	testl	%ecx, %ecx
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
               	leaq	(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	movups	%xmm14, 0x60(%rax)
               	movups	%xmm14, 0x70(%rax)
               	movups	%xmm14, 0x80(%rax)
               	movups	%xmm14, 0x90(%rax)
               	movups	%xmm14, 0xa0(%rax)
               	movups	%xmm14, 0xb0(%rax)
               	movups	%xmm14, 0xc0(%rax)
               	movups	%xmm14, 0xd0(%rax)
               	movups	%xmm14, 0xe0(%rax)
               	movups	%xmm14, 0xf0(%rax)
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
               	xorl	%r14d, %r14d
               	movl	$0x2, %eax
               	movl	$0x1, %ecx
               	testb	$0x1, %r14b
               	cmovneq	%rax, %rcx
               	movq	%r14, %r13
               	andq	$0x2, %r13
               	xorl	%edi, %edi
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %edi
               	jge	<addr>
               	xorl	%edx, %edx
               	leaq	-0x1(%rcx), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rdx
               	movq	%rcx, %rsi
               	imulq	%rdi, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	testl	%r13d, %r13d
               	jne	<addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	decq	%rax
               	shrxq	%rax, %rdx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	shlxq	%rsi, %rax, %rax
               	orq	%rax, %rdx
               	xorl	%esi, %esi
               	leaq	-0x1(%rcx), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rsi
               	movq	%rcx, %r8
               	imulq	%rdi, %r8
               	addq	%rax, %r8
               	movslq	%r8d, %r8
               	movzbq	(%r12,%r8), %r8
               	orq	%r8, %rsi
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	testl	%r13d, %r13d
               	jne	<addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	decq	%rax
               	shrxq	%rax, %rsi, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	%rcx, %r8
               	shlq	$0x3, %r8
               	shlxq	%r8, %rax, %rax
               	orq	%rax, %rsi
               	leaq	-0x40(%rbp), %r8
               	movq	%rdx, %rax
               	subq	%rsi, %rax
               	addq	%rsi, %rdx
               	cmpl	$0x4, %r14d
               	movq	%rdx, %rsi
               	cmovgeq	%rax, %rsi
               	testl	%r13d, %r13d
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	decq	%rdx
               	shlxq	%rdx, %rax, %rax
               	movq	%rax, %rdx
               	negq	%rdx
               	testl	%r13d, %r13d
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rcx, %r9
               	shlq	$0x3, %r9
               	decq	%r9
               	shlxq	%r9, %rax, %rax
               	decq	%rax
               	cmpq	%rdx, %rsi
               	jge	<addr>
               	xorl	%eax, %eax
               	cmpl	%ecx, %eax
               	jge	<addr>
               	movq	%rcx, %rsi
               	imulq	%rdi, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	movslq	%r9d, %r9
               	shrxq	%r9, %rdx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%r8,%rsi)
               	incq	%rax
               	cmpl	%ecx, %eax
               	jge	<addr>
               	jmp	<addr>
               	cmpq	%rax, %rsi
               	movq	%rsi, %rdx
               	cmovgq	%rax, %rdx
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rcx, %r9
               	shlq	$0x3, %r9
               	shlxq	%r9, %rax, %rax
               	decq	%rax
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	incq	%rdi
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %edi
               	jl	<addr>
               	leaq	(%rsp), %rax
               	movq	%r14, %rcx
               	shlq	$0x5, %rcx
               	addq	%rcx, %rax
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x100(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	-0x20(%rbp), %rax
               	leaq	0x100(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%r14
               	cmpl	$0x8, %r14d
               	jl	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	-0x88(%rbp), %rbx
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
               	movq	%r10, -0x88(%rbp)
               	incq	%r15
               	cmpl	$0x12c, %r15d           # imm = 0x12C
               	jl	<addr>
               	movq	-0x88(%rbp), %rax
               	leaq	-0xc0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
