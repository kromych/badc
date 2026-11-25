
sse41_integer_lanes_follow_the_sdm.x64:	file format elf64-x86-64

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

<check_products_packs>:
               	subq	$0x78, %rsp
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rdi,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	nopw	(%rax,%rax)
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	movzbq	(%rsi,%rax), %r9
               	orq	%r9, %rdx
               	decq	%rax
               	nopw	(%rax,%rax)
               	testl	%eax, %eax
               	jge	<addr>
               	imulq	%rdx, %rcx
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x20(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x4(%rax), %rdx
               	movzbq	(%rdi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	leaq	0x4(%rax), %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	imulq	%rdx, %rcx
               	xorl	%eax, %eax
               	leaq	0x4(%rax), %r9
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x20(%rsp,%r9)
               	incq	%rax
               	cmpl	$0x4, %eax
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
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	leaq	0x8(%rax), %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	imulq	%rdx, %rcx
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %r9
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x20(%rsp,%r9)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0xc(%rax), %rdx
               	movzbq	(%rdi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	leaq	0xc(%rax), %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	imulq	%rdx, %rcx
               	xorl	%eax, %eax
               	leaq	0xc(%rax), %r9
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x20(%rsp,%r9)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%r9d, %r9d
               	movq	%r9, %rdx
               	shlq	%rdx
               	xorl	%ecx, %ecx
               	shlq	$0x2, %rdx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %r8
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
               	cmoveq	%rcx, %r8
               	movq	%r9, %rdx
               	shlq	%rdx
               	xorl	%ecx, %ecx
               	shlq	$0x2, %rdx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %r11
               	movzbq	(%rsi,%r11), %r11
               	orq	%r11, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	movabsq	$-0x100000000, %rdx     # imm = 0xFFFFFFFF00000000
               	orq	%rcx, %rdx
               	testb	$0x1, %al
               	cmovneq	%rdx, %rcx
               	imulq	%rcx, %r8
               	movq	%r9, %rdx
               	shlq	$0x3, %rdx
               	xorl	%eax, %eax
               	leaq	(%rdx,%rax), %r11
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %r8, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x30(%rsp,%r11)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movq	%r9, %rdx
               	shlq	$0x3, %rdx
               	movl	$0x7, %eax
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %r10
               	movzbq	(%rdi,%r10), %r10
               	orq	%r10, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%edx, %edx
               	movq	%r9, %r10
               	shlq	$0x3, %r10
               	movl	$0x7, %eax
               	shlq	$0x8, %rdx
               	leaq	(%r10,%rax), %r11
               	movzbq	(%rsi,%r11), %r11
               	orq	%r11, %rdx
               	decq	%rax
               	nopl	(%rax)
               	testl	%eax, %eax
               	jge	<addr>
               	movq	$-0x1, %r10
               	xorl	%eax, %eax
               	cmpq	%rdx, %rcx
               	cmovleq	%rax, %r10
               	movq	%r9, %rdx
               	shlq	$0x3, %rdx
               	xorl	%eax, %eax
               	leaq	(%rdx,%rax), %r11
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %r10, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x50(%rsp,%r11)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x8, %eax
               	jl	<addr>
               	incq	%r9
               	cmpl	$0x2, %r9d
               	jl	<addr>
               	xorl	%r11d, %r11d
               	cmpl	$0x4, %r11d
               	movq	%rsi, %r8
               	cmovlq	%rdi, %r8
               	movq	%r11, %rdx
               	andq	$0x3, %rdx
               	xorl	%ecx, %ecx
               	shlq	$0x2, %rdx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %r9
               	movzbq	(%r8,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	movabsq	$-0x100000000, %rdx     # imm = 0xFFFFFFFF00000000
               	orq	%rcx, %rdx
               	testb	$0x1, %al
               	cmovneq	%rdx, %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	xorl	%edx, %edx
               	movq	%r11, %r8
               	shlq	%r8
               	xorl	%eax, %eax
               	leaq	(%r8,%rax), %r10
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x40(%rsp,%r10)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	jmp	<addr>
               	movl	$0xffff, %edx           # imm = 0xFFFF
               	cmpq	$0xffff, %rcx           # imm = 0xFFFF
               	cmovleq	%rcx, %rdx
               	jmp	<addr>
               	incq	%r11
               	cmpl	$0x8, %r11d
               	jl	<addr>
               	movups	(%rdi), %xmm0
               	movups	(%rsi), %xmm1
               	vpmulld	%xmm1, %xmm0, %xmm2
               	leaq	0x20(%rsp), %rsi
               	leaq	0x60(%rsp), %rdi
               	movups	%xmm2, 0x60(%rsp)
               	movl	$0x10, %edx
               	movups	%xmm0, 0x10(%rsp)
               	movups	%xmm1, (%rsp)
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movups	0x10(%rsp), %xmm14
               	movups	(%rsp), %xmm15
               	vpmuldq	%xmm15, %xmm14, %xmm0
               	leaq	0x30(%rsp), %rsi
               	leaq	0x60(%rsp), %rdi
               	movups	%xmm0, 0x60(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movups	0x10(%rsp), %xmm14
               	movups	(%rsp), %xmm15
               	vpackusdw	%xmm15, %xmm14, %xmm0
               	leaq	0x40(%rsp), %rsi
               	leaq	0x60(%rsp), %rdi
               	movups	%xmm0, 0x60(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movups	0x10(%rsp), %xmm14
               	movups	(%rsp), %xmm15
               	vpcmpgtq	%xmm15, %xmm14, %xmm0
               	leaq	0x50(%rsp), %rsi
               	leaq	0x60(%rsp), %rdi
               	movups	%xmm0, 0x60(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	addq	$0x78, %rsp
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>

<check_extensions>:
               	subq	$0xe8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movups	(%rbx), %xmm0
               	pmovsxbw	%xmm0, %xmm1
               	movups	%xmm1, 0x30(%rsp)
               	pmovsxbd	%xmm0, %xmm1
               	movups	%xmm1, 0x40(%rsp)
               	pmovsxbq	%xmm0, %xmm1
               	movups	%xmm1, 0x50(%rsp)
               	pmovsxwd	%xmm0, %xmm1
               	movups	%xmm1, 0x60(%rsp)
               	pmovsxwq	%xmm0, %xmm1
               	movups	%xmm1, 0x70(%rsp)
               	pmovsxdq	%xmm0, %xmm1
               	movups	%xmm1, 0x80(%rsp)
               	pmovzxbw	%xmm0, %xmm1            # xmm1 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero,xmm0[4],zero,xmm0[5],zero,xmm0[6],zero,xmm0[7],zero
               	movups	%xmm1, 0x90(%rsp)
               	pmovzxbd	%xmm0, %xmm1            # xmm1 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero,xmm0[2],zero,zero,zero,xmm0[3],zero,zero,zero
               	movups	%xmm1, 0xa0(%rsp)
               	pmovzxbq	%xmm0, %xmm1            # xmm1 = xmm0[0],zero,zero,zero,zero,zero,zero,zero,xmm0[1],zero,zero,zero,zero,zero,zero,zero
               	movups	%xmm1, 0xb0(%rsp)
               	pmovzxwd	%xmm0, %xmm1            # xmm1 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero
               	movups	%xmm1, 0xc0(%rsp)
               	pmovzxwq	%xmm0, %xmm1            # xmm1 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero
               	movups	%xmm1, 0xd0(%rsp)
               	pmovzxdq	%xmm0, %xmm0            # xmm0 = xmm0[0],zero,xmm0[1],zero
               	movups	%xmm0, 0xe0(%rsp)
               	xorl	%r14d, %r14d
               	leaq	<rip>, %rcx # <addr>
               	imulq	$0x2aaaaaab, %r14, %rax # imm = 0x2AAAAAAB
               	shrq	$0x20, %rax
               	imulq	$0x6, %rax, %rdx
               	movq	%r14, %rax
               	subq	%rdx, %rax
               	shlq	$0x3, %rax
               	addq	%rcx, %rax
               	xorl	%r11d, %r11d
               	movl	(%rax), %r12d
               	movl	0x4(%rax), %esi
               	cmpl	$0x6, %r14d
               	setl	%r13b
               	movzbq	%r13b, %r13
               	leaq	-0x1(%r12), %rdi
               	movq	%r12, %rax
               	shlq	$0x3, %rax
               	leaq	-0x1(%rax), %rcx
               	movslq	%ecx, %r15
               	movslq	%eax, %rbp
               	movl	$0x10, %eax
               	cltd
               	idivl	%esi
               	cmpl	%eax, %r11d
               	jge	<addr>
               	xorl	%ecx, %ecx
               	movq	%r12, %rdx
               	imulq	%r11, %rdx
               	movq	%rdi, %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %r9
               	movslq	%r9d, %r9
               	movzbq	(%rbx,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	testq	%r13, %r13
               	je	<addr>
               	nopl	(%rax,%rax)
               	cmpl	$0x8, %r12d
               	jge	<addr>
               	shrxq	%r15, %rcx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	shlxq	%rbp, %rax, %rax
               	orq	%rax, %rcx
               	movq	%rsi, %r9
               	imulq	%r11, %r9
               	xorl	%eax, %eax
               	cmpl	%esi, %eax
               	jge	<addr>
               	leaq	(%r9,%rax), %rdx
               	movslq	%edx, %r10
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	movslq	%edx, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0xf0(%rsp,%r10)
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	incq	%r11
               	movl	$0x10, %eax
               	cltd
               	idivl	%esi
               	cmpl	%eax, %r11d
               	jl	<addr>
               	leaq	0x30(%rsp), %rax
               	movq	%r14, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rax
               	leaq	0xf0(%rsp), %rsi
               	movups	(%rax), %xmm0
               	leaq	0x100(%rsp), %rdi
               	movups	%xmm0, 0x100(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%r14
               	cmpl	$0xc, %r14d
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0xe8, %rsp
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0xe8, %rsp
               	retq

<check_blends>:
               	subq	$0x28, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rdx, %r13
               	movq	%rsi, %r12
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	sarxq	%rdx, %rcx, %rax
               	testb	$0x1, %al
               	movq	%rbx, %r8
               	cmovneq	%r12, %r8
               	movq	%rdx, %r10
               	shlq	%r10
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%r10,%rax), %r11
               	movzbq	(%r8,%r11), %r11
               	orq	%r11, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rdx, %r10
               	shlq	%r10
               	xorl	%eax, %eax
               	leaq	(%r10,%rax), %r11
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, 0x20(%rsp,%r11)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rdx
               	nopw	(%rax,%rax)
               	cmpl	$0x8, %edx
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vpblendw	$0x0, %xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0,1,2,3,4,5,6,7]
               	leaq	0x20(%rsp), %rsi
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x8, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	movq	%rdx, %r14
               	cmovneq	%rcx, %r14
               	xorl	%edx, %edx
               	movl	$0xff, %eax
               	sarxq	%rdx, %rax, %rax
               	testb	$0x1, %al
               	movq	%rbx, %r8
               	cmovneq	%r12, %r8
               	xorl	%ecx, %ecx
               	movq	%rdx, %r10
               	shlq	%r10
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%r10,%rax), %r11
               	movzbq	(%r8,%r11), %r11
               	orq	%r11, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rdx, %r10
               	shlq	%r10
               	xorl	%eax, %eax
               	leaq	(%r10,%rax), %r11
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, 0x20(%rsp,%r11)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x8, %edx
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vpblendw	$0xff, %xmm1, %xmm0, %xmm0 # xmm0 = xmm1[0,1,2,3,4,5,6,7]
               	leaq	0x20(%rsp), %rsi
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x8, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r14
               	xorl	%edx, %edx
               	movl	$0xa5, %eax
               	sarxq	%rdx, %rax, %rax
               	testb	$0x1, %al
               	movq	%rbx, %r8
               	cmovneq	%r12, %r8
               	xorl	%ecx, %ecx
               	movq	%rdx, %r10
               	shlq	%r10
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%r10,%rax), %r11
               	movzbq	(%r8,%r11), %r11
               	orq	%r11, %rcx
               	decq	%rax
               	nopl	(%rax)
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rdx, %r10
               	shlq	%r10
               	xorl	%eax, %eax
               	leaq	(%r10,%rax), %r11
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, 0x20(%rsp,%r11)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x8, %edx
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vpblendw	$0xa5, %xmm1, %xmm0, %xmm0 # xmm0 = xmm1[0],xmm0[1],xmm1[2],xmm0[3,4],xmm1[5],xmm0[6],xmm1[7]
               	leaq	0x20(%rsp), %rsi
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x8, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r14
               	xorl	%edx, %edx
               	movl	$0x3c, %eax
               	sarxq	%rdx, %rax, %rax
               	testb	$0x1, %al
               	movq	%rbx, %r8
               	cmovneq	%r12, %r8
               	xorl	%ecx, %ecx
               	movq	%rdx, %r10
               	shlq	%r10
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%r10,%rax), %r11
               	movzbq	(%r8,%r11), %r11
               	orq	%r11, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rdx, %r10
               	shlq	%r10
               	xorl	%eax, %eax
               	leaq	(%r10,%rax), %r11
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, 0x20(%rsp,%r11)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rdx
               	nopw	(%rax,%rax)
               	cmpl	$0x8, %edx
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vpblendw	$0x3c, %xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0,1],xmm1[2,3,4,5],xmm0[6,7]
               	leaq	0x20(%rsp), %rsi
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x8, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r14
               	xorl	%edx, %edx
               	movl	$0x81, %eax
               	sarxq	%rdx, %rax, %rax
               	testb	$0x1, %al
               	movq	%rbx, %r8
               	cmovneq	%r12, %r8
               	xorl	%ecx, %ecx
               	movq	%rdx, %r10
               	shlq	%r10
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%r10,%rax), %r11
               	movzbq	(%r8,%r11), %r11
               	orq	%r11, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rdx, %r10
               	shlq	%r10
               	xorl	%eax, %eax
               	leaq	(%r10,%rax), %r11
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, 0x20(%rsp,%r11)
               	incq	%rax
               	nop
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x8, %edx
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vpblendw	$0x81, %xmm1, %xmm0, %xmm0 # xmm0 = xmm1[0],xmm0[1,2,3,4,5,6],xmm1[7]
               	leaq	0x20(%rsp), %rsi
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x8, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r14
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%cl, 0x20(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	movzbq	(%r13,%rax), %rcx
               	nopl	(%rax)
               	testb	$-0x80, %cl
               	je	<addr>
               	movzbq	(%r12,%rax), %rcx
               	jmp	<addr>
               	movzbq	(%rbx,%rax), %rcx
               	jmp	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	movups	(%r13), %xmm2
               	vpblendvb	%xmm2, %xmm1, %xmm0, %xmm0
               	leaq	0x20(%rsp), %rsi
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x8, %ecx
               	testq	%rax, %rax
               	cmoveq	%r14, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	addq	$0x28, %rsp
               	retq

<check_elements>:
               	subq	$0x28, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rsi,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	movabsq	$-0x100000000, %rdx     # imm = 0xFFFFFFFF00000000
               	orq	%rcx, %rdx
               	testb	$0x1, %al
               	cmovneq	%rdx, %rcx
               	movslq	%ecx, %r13
               	xorl	%ebx, %ebx
               	movl	$0x7, %eax
               	shlq	$0x8, %rbx
               	leaq	0x8(%rax), %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	orq	%rcx, %rbx
               	decq	%rax
               	nop
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%r14d, %r14d
               	movups	(%r12), %xmm0
               	pextrb	$0x0, %xmm0, %eax
               	movzbq	(%r12), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movups	(%r12), %xmm0
               	pextrb	$0x9, %xmm0, %eax
               	movzbq	0x9(%r12), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	pextrb	$0xf, %xmm0, %eax
               	movzbq	0xf(%r12), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x10, %r14d
               	movups	(%r12), %xmm0
               	pextrd	$0x3, %xmm0, %esi
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0xc(%rax), %rdx
               	movzbq	(%r12,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	movabsq	$-0x100000000, %rdx     # imm = 0xFFFFFFFF00000000
               	orq	%rcx, %rdx
               	testb	$0x1, %al
               	cmovneq	%rdx, %rcx
               	cmpl	%ecx, %esi
               	jne	<addr>
               	movups	(%r12), %xmm0
               	pextrq	$0x0, %xmm0, %rsi
               	xorl	%ecx, %ecx
               	movl	$0x7, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%r12,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	movups	(%r12), %xmm0
               	pextrq	$0x1, %xmm0, %rsi
               	xorl	%ecx, %ecx
               	movl	$0x7, %eax
               	shlq	$0x8, %rcx
               	leaq	0x8(%rax), %rdx
               	movzbq	(%r12,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	cmpq	%rcx, %rsi
               	je	<addr>
               	movl	$0x10, %r14d
               	leaq	0x20(%rsp), %rsi
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%r13, %rax
               	andq	$0xff, %rax
               	movb	%al, 0x2b(%rsp)
               	movups	(%r12), %xmm0
               	pinsrb	$0xb, %r13d, %xmm0
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x10, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r14
               	leaq	0x20(%rsp), %rdx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %rsi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %r13, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x20(%rsp,%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	(%r12), %xmm0
               	pinsrd	$0x2, %r13d, %xmm0
               	leaq	0x20(%rsp), %rsi
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x10, %ecx
               	testq	%rax, %rax
               	movq	%r14, %r13
               	cmovneq	%rcx, %r13
               	leaq	0x20(%rsp), %rdx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %rsi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rbx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x20(%rsp,%rsi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movups	(%r12), %xmm0
               	pinsrq	$0x1, %rbx, %xmm0
               	leaq	0x20(%rsp), %rsi
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x10, %ecx
               	testq	%rax, %rax
               	cmoveq	%r13, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	addq	$0x28, %rsp
               	retq

<check_ptest>:
               	subq	$0x48, %rsp
               	movzbq	(%rdi), %rax
               	movzbq	(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, 0x18(%rsp)
               	movzbq	0x1(%rdi), %rax
               	movzbq	0x1(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, 0x19(%rsp)
               	movzbq	0x2(%rdi), %rax
               	movzbq	0x2(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, 0x1a(%rsp)
               	movzbq	0x3(%rdi), %rax
               	movzbq	0x3(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, 0x1b(%rsp)
               	movzbq	0x4(%rdi), %rax
               	movzbq	0x4(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, 0x1c(%rsp)
               	movzbq	0x5(%rdi), %rax
               	movzbq	0x5(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, 0x1d(%rsp)
               	movzbq	0x6(%rdi), %rax
               	movzbq	0x6(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, 0x1e(%rsp)
               	movzbq	0x7(%rdi), %rax
               	movzbq	0x7(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, 0x1f(%rsp)
               	movzbq	0x8(%rdi), %rax
               	movzbq	0x8(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, 0x20(%rsp)
               	movzbq	0x9(%rdi), %rax
               	movzbq	0x9(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, 0x21(%rsp)
               	movzbq	0xa(%rdi), %rax
               	movzbq	0xa(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, 0x22(%rsp)
               	movzbq	0xb(%rdi), %rax
               	movzbq	0xb(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, 0x23(%rsp)
               	leaq	0x18(%rsp), %rcx
               	movzbq	0xc(%rdi), %rax
               	movzbq	0xc(%rsi), %rdx
               	andq	%rdx, %rax
               	andq	$0x11, %rax
               	movb	%al, 0x24(%rsp)
               	movzbq	0xd(%rdi), %rax
               	movzbq	0xd(%rsi), %rdx
               	andq	%rdx, %rax
               	andq	$0x11, %rax
               	movb	%al, 0x25(%rsp)
               	movzbq	0xe(%rdi), %rax
               	movzbq	0xe(%rsi), %rdx
               	andq	%rdx, %rax
               	andq	$0x11, %rax
               	movb	%al, 0x26(%rsp)
               	movzbq	0xf(%rdi), %rax
               	movzbq	0xf(%rsi), %rdx
               	andq	%rdx, %rax
               	andq	$0x11, %rax
               	movb	%al, 0x27(%rsp)
               	xorl	%eax, %eax
               	movq	%rdi, 0x28(%rsp)
               	movq	%rsi, 0x30(%rsp)
               	movq	%rcx, 0x38(%rsp)
               	movq	%rax, %r11
               	xorl	%r8d, %r8d
               	nop
               	jmp	<addr>
               	incq	%r8
               	cmpl	$0x3, %r8d
               	jge	<addr>
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	movq	%rdx, %r9
               	movq	0x28(%rsp,%rax,8), %r10
               	movzbq	(%r10,%rcx), %r10
               	movq	0x28(%rsp,%r8,8), %rsi
               	movzbq	(%rsi,%rcx), %rsi
               	andq	%rsi, %r10
               	testl	%r10d, %r10d
               	sete	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %r9
               	movq	0x28(%rsp,%rax,8), %rsi
               	movzbq	(%rsi,%rcx), %rsi
               	xorq	$-0x1, %rsi
               	movq	0x28(%rsp,%r8,8), %r10
               	movzbq	(%r10,%rcx), %r10
               	andq	%r10, %rsi
               	testl	%esi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rdx
               	incq	%rcx
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	movq	0x28(%rsp,%rax,8), %rsi
               	movups	(%rsi), %xmm0
               	movq	0x28(%rsp,%r8,8), %rcx
               	movups	(%rcx), %xmm1
               	vpand	%xmm1, %xmm0, %xmm2
               	vmovq	%xmm2, %rcx
               	vpextrq	$0x1, %xmm2, %rsi
               	orq	%rsi, %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	nopl	(%rax,%rax)
               	cmpl	%r9d, %ecx
               	jne	<addr>
               	movq	%r11, (%rsp)
               	vpcmpeqd	%xmm3, %xmm3, %xmm3
               	vpxor	%xmm3, %xmm0, %xmm2
               	vpand	%xmm1, %xmm2, %xmm2
               	vmovq	%xmm2, %rcx
               	vpextrq	$0x1, %xmm2, %rsi
               	orq	%rsi, %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpl	%edx, %ecx
               	movq	(%rsp), %r11
               	jne	<addr>
               	vpand	%xmm1, %xmm0, %xmm2
               	vmovq	%xmm2, %rcx
               	vpextrq	$0x1, %xmm2, %rsi
               	orq	%rsi, %rcx
               	xorl	%esi, %esi
               	testq	%rcx, %rcx
               	je	<addr>
               	vpxor	%xmm3, %xmm0, %xmm2
               	vpand	%xmm1, %xmm2, %xmm2
               	vmovq	%xmm2, %rcx
               	vpextrq	$0x1, %xmm2, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%edx, %edx
               	sete	%r10b
               	movzbq	%r10b, %r10
               	testl	%r9d, %r9d
               	cmovneq	%rsi, %r10
               	nopw	(%rax,%rax)
               	cmpl	%r10d, %ecx
               	jne	<addr>
               	vpand	%xmm1, %xmm0, %xmm2
               	vmovq	%xmm2, %rcx
               	vpextrq	$0x1, %xmm2, %rsi
               	orq	%rsi, %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpl	%r9d, %ecx
               	jne	<addr>
               	vpand	%xmm1, %xmm0, %xmm2
               	vmovq	%xmm2, %rcx
               	vpextrq	$0x1, %xmm2, %rsi
               	orq	%rsi, %rcx
               	xorl	%esi, %esi
               	nop
               	testq	%rcx, %rcx
               	je	<addr>
               	vpxor	%xmm3, %xmm0, %xmm0
               	vpand	%xmm1, %xmm0, %xmm0
               	vmovq	%xmm0, %rcx
               	vpextrq	$0x1, %xmm0, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%r9d, %r9d
               	cmovneq	%rsi, %rdx
               	cmpl	%edx, %ecx
               	je	<addr>
               	movl	$0x20, %r11d
               	jmp	<addr>
               	movq	%rsi, %rcx
               	jmp	<addr>
               	movq	%rsi, %rcx
               	nopl	(%rax)
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movzbq	(%rdi), %rax
               	cmpl	$0xff, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movzbq	0x1(%rdi), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0x2(%rdi), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0x3(%rdi), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0x4(%rdi), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0x5(%rdi), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0x6(%rdi), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0x7(%rdi), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0x8(%rdi), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0x9(%rdi), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0xa(%rdi), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0xb(%rdi), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0xc(%rdi), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0xd(%rdi), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0xe(%rdi), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0xf(%rdi), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movups	(%rdi), %xmm0
               	vpcmpeqd	%xmm0, %xmm0, %xmm2
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	vpxor	%xmm1, %xmm0, %xmm0
               	vpand	%xmm2, %xmm0, %xmm0
               	vmovq	%xmm0, %rcx
               	vpextrq	$0x1, %xmm0, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpl	%eax, %ecx
               	jne	<addr>
               	vpcmpeqd	%xmm0, %xmm0, %xmm0
               	vpxor	%xmm1, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	vpextrq	$0x1, %xmm0, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x20, %r11d
               	movq	%r11, %rax
               	addq	$0x48, %rsp
               	retq

<check_minpos>:
               	subq	$0x28, %rsp
               	leaq	(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%r10d, %r10d
               	movl	$0x1, %r9d
               	xorl	%ecx, %ecx
               	movq	%r9, %rdx
               	shlq	%rdx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %rsi
               	movzbq	(%rdi,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	nopl	(%rax)
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%edx, %edx
               	movq	%r10, %rsi
               	shlq	%rsi
               	movl	$0x1, %eax
               	shlq	$0x8, %rdx
               	leaq	(%rsi,%rax), %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	cmpq	%rdx, %rcx
               	cmovbq	%r9, %r10
               	incq	%r9
               	cmpl	$0x8, %r9d
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movq	%r10, %rdx
               	shlq	%rdx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	nopl	(%rax,%rax)
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rsp,%rax)
               	incq	%rax
               	nop
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	0x2(%rax), %rsi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %r10, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rsp,%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	(%rdi), %xmm0
               	phminposuw	%xmm0, %xmm0
               	leaq	(%rsp), %rsi
               	leaq	0x10(%rsp), %rdi
               	movups	%xmm0, 0x10(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	xorl	%ecx, %ecx
               	movl	$0x40, %edx
               	testq	%rax, %rax
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	addq	$0x28, %rsp
               	retq

<check_mpsadbw>:
               	subq	$0x30, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	leaq	(%rsi,%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	movzbq	(%r12,%rax), %rdi
               	subq	%rdi, %rcx
               	movq	%rcx, %rdi
               	negq	%rdi
               	testl	%ecx, %ecx
               	cmovlq	%rdi, %rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movslq	%edx, %rdx
               	movq	%rsi, %r8
               	shlq	%r8
               	xorl	%eax, %eax
               	leaq	(%r8,%rax), %r9
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x20(%rsp,%r9)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rsi
               	nopw	(%rax,%rax)
               	cmpl	$0x8, %esi
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vmpsadbw	$0x0, %xmm1, %xmm0, %xmm0
               	leaq	0x20(%rsp), %rsi
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x80, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	movq	%rdx, %r13
               	cmovneq	%rcx, %r13
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	leaq	(%rsi,%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	leaq	0x4(%rax), %rdi
               	movzbq	(%r12,%rdi), %rdi
               	subq	%rdi, %rcx
               	movq	%rcx, %rdi
               	negq	%rdi
               	testl	%ecx, %ecx
               	cmovlq	%rdi, %rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movslq	%edx, %rdx
               	movq	%rsi, %r8
               	shlq	%r8
               	xorl	%eax, %eax
               	leaq	(%r8,%rax), %r9
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x20(%rsp,%r9)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rsi
               	cmpl	$0x8, %esi
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vmpsadbw	$0x1, %xmm1, %xmm0, %xmm0
               	leaq	0x20(%rsp), %rsi
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x80, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r13
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	leaq	(%rsi,%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	leaq	0x8(%rax), %rdi
               	movzbq	(%r12,%rdi), %rdi
               	subq	%rdi, %rcx
               	movq	%rcx, %rdi
               	negq	%rdi
               	testl	%ecx, %ecx
               	cmovlq	%rdi, %rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movslq	%edx, %rdx
               	movq	%rsi, %r8
               	shlq	%r8
               	xorl	%eax, %eax
               	leaq	(%r8,%rax), %r9
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x20(%rsp,%r9)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rsi
               	cmpl	$0x8, %esi
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vmpsadbw	$0x2, %xmm1, %xmm0, %xmm0
               	leaq	0x20(%rsp), %rsi
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x80, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r13
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	leaq	(%rsi,%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	leaq	0xc(%rax), %rdi
               	movzbq	(%r12,%rdi), %rdi
               	subq	%rdi, %rcx
               	movq	%rcx, %rdi
               	negq	%rdi
               	testl	%ecx, %ecx
               	cmovlq	%rdi, %rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movslq	%edx, %rdx
               	movq	%rsi, %r8
               	shlq	%r8
               	xorl	%eax, %eax
               	leaq	(%r8,%rax), %r9
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x20(%rsp,%r9)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rsi
               	nopw	(%rax,%rax)
               	cmpl	$0x8, %esi
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vmpsadbw	$0x3, %xmm1, %xmm0, %xmm0
               	leaq	0x20(%rsp), %rsi
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x80, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r13
               	xorl	%r9d, %r9d
               	xorl	%eax, %eax
               	leaq	0x4(%r9), %rsi
               	movq	%rax, %rdx
               	leaq	(%rsi,%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	movzbq	(%r12,%rax), %rdi
               	subq	%rdi, %rcx
               	movq	%rcx, %rdi
               	negq	%rdi
               	testl	%ecx, %ecx
               	cmovlq	%rdi, %rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movslq	%edx, %rdx
               	movq	%r9, %rdi
               	shlq	%rdi
               	xorl	%eax, %eax
               	leaq	(%rdi,%rax), %r8
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x20(%rsp,%r8)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%r9
               	cmpl	$0x8, %r9d
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vmpsadbw	$0x4, %xmm1, %xmm0, %xmm0
               	leaq	0x20(%rsp), %rsi
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x80, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r13
               	xorl	%r9d, %r9d
               	xorl	%eax, %eax
               	leaq	0x4(%r9), %rsi
               	movq	%rax, %rdx
               	leaq	(%rsi,%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	leaq	0x4(%rax), %rdi
               	movzbq	(%r12,%rdi), %rdi
               	subq	%rdi, %rcx
               	movq	%rcx, %rdi
               	negq	%rdi
               	testl	%ecx, %ecx
               	cmovlq	%rdi, %rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movslq	%edx, %rdx
               	movq	%r9, %rdi
               	shlq	%rdi
               	xorl	%eax, %eax
               	leaq	(%rdi,%rax), %r8
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x20(%rsp,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%r9
               	nopw	(%rax,%rax)
               	cmpl	$0x8, %r9d
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vmpsadbw	$0x5, %xmm1, %xmm0, %xmm0
               	leaq	0x20(%rsp), %rsi
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x80, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r13
               	xorl	%r9d, %r9d
               	xorl	%eax, %eax
               	leaq	0x4(%r9), %rsi
               	movq	%rax, %rdx
               	leaq	(%rsi,%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	leaq	0x8(%rax), %rdi
               	movzbq	(%r12,%rdi), %rdi
               	subq	%rdi, %rcx
               	movq	%rcx, %rdi
               	negq	%rdi
               	testl	%ecx, %ecx
               	cmovlq	%rdi, %rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movslq	%edx, %rdx
               	movq	%r9, %rdi
               	shlq	%rdi
               	xorl	%eax, %eax
               	leaq	(%rdi,%rax), %r8
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x20(%rsp,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%r9
               	cmpl	$0x8, %r9d
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vmpsadbw	$0x6, %xmm1, %xmm0, %xmm0
               	leaq	0x20(%rsp), %rsi
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x80, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r13
               	xorl	%r9d, %r9d
               	xorl	%eax, %eax
               	leaq	0x4(%r9), %rsi
               	movq	%rax, %rdx
               	leaq	(%rsi,%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	leaq	0xc(%rax), %rdi
               	movzbq	(%r12,%rdi), %rdi
               	subq	%rdi, %rcx
               	movq	%rcx, %rdi
               	negq	%rdi
               	testl	%ecx, %ecx
               	cmovlq	%rdi, %rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movslq	%edx, %rdx
               	movq	%r9, %rdi
               	shlq	%rdi
               	xorl	%eax, %eax
               	leaq	(%rdi,%rax), %r8
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x20(%rsp,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%r9
               	nopw	(%rax,%rax)
               	cmpl	$0x8, %r9d
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vmpsadbw	$0x7, %xmm1, %xmm0, %xmm0
               	leaq	0x20(%rsp), %rsi
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x80, %ecx
               	testq	%rax, %rax
               	movq	%r13, %r12
               	cmovneq	%rcx, %r12
               	leaq	<rip>, %rax # <addr>
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	(%rax), %xmm0
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	movq	%rbx, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x80, %ecx
               	testq	%rax, %rax
               	cmoveq	%r12, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x30, %rsp
               	retq

<main>:
               	subq	$0xf8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	xorl	%r10d, %r10d
               	movq	%r10, 0xb8(%rsp)
               	movq	0xb8(%rsp), %r11
               	movq	%r11, 0xc0(%rsp)
               	jmp	<addr>
               	movq	0xc0(%rsp), %r10
               	orq	%rax, %r10
               	movq	%r10, 0xc0(%rsp)
               	leaq	0xd0(%rsp), %rdi
               	leaq	0xe0(%rsp), %rsi
               	callq	<addr>
               	movq	0xc0(%rsp), %r10
               	orq	%rax, %r10
               	movq	%r10, 0xc0(%rsp)
               	leaq	0xd0(%rsp), %rdi
               	callq	<addr>
               	movq	0xc0(%rsp), %r10
               	orq	%rax, %r10
               	movq	%r10, 0xc0(%rsp)
               	leaq	0xd0(%rsp), %rdi
               	leaq	0xe0(%rsp), %rsi
               	leaq	0xf0(%rsp), %rdx
               	callq	<addr>
               	movq	0xc0(%rsp), %r10
               	orq	%rax, %r10
               	movq	%r10, 0xc0(%rsp)
               	leaq	0xd0(%rsp), %rdi
               	leaq	0xe0(%rsp), %rsi
               	callq	<addr>
               	movq	0xc0(%rsp), %r10
               	orq	%rax, %r10
               	movq	%r10, 0xc0(%rsp)
               	leaq	0xd0(%rsp), %rdi
               	leaq	0xe0(%rsp), %rsi
               	callq	<addr>
               	movq	0xc0(%rsp), %r10
               	orq	%rax, %r10
               	movq	%r10, 0xc0(%rsp)
               	leaq	0xd0(%rsp), %rdi
               	callq	<addr>
               	movq	0xc0(%rsp), %r10
               	orq	%rax, %r10
               	movq	%r10, 0xc0(%rsp)
               	leaq	0xd0(%rsp), %rdi
               	leaq	0xe0(%rsp), %rsi
               	callq	<addr>
               	movq	0xc0(%rsp), %r10
               	orq	%rax, %r10
               	movq	%r10, 0xc0(%rsp)
               	addq	$0x1, 0xb8(%rsp)
               	nopl	(%rax)
               	movq	0xb8(%rsp), %rax
               	cmpl	$0x12c, %eax            # imm = 0x12C
               	jge	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	movb	%al, 0xd0(%rsp,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
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
               	movb	%al, 0xe0(%rsp,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
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
               	nop
               	jmp	<addr>
               	movb	%al, 0xf0(%rsp,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
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
               	nop
               	jmp	<addr>
               	movq	0xb8(%rsp), %rax
               	imulq	$0x24924925, %rax, %rcx # imm = 0x24924925
               	shrq	$0x20, %rcx
               	imulq	$0x7, %rcx, %rcx
               	subq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	0xe0(%rsp), %rax
               	leaq	0xd0(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0xd0(%rsp), %xmm0
               	movups	0xe0(%rsp), %xmm1
               	vpminsb	%xmm1, %xmm0, %xmm2
               	movups	%xmm2, 0x30(%rsp)
               	vpmaxsb	%xmm1, %xmm0, %xmm2
               	movups	%xmm2, 0x40(%rsp)
               	vpminuw	%xmm1, %xmm0, %xmm2
               	movups	%xmm2, 0x50(%rsp)
               	vpmaxuw	%xmm1, %xmm0, %xmm2
               	movups	%xmm2, 0x60(%rsp)
               	vpminsd	%xmm1, %xmm0, %xmm2
               	movups	%xmm2, 0x70(%rsp)
               	vpmaxsd	%xmm1, %xmm0, %xmm2
               	movups	%xmm2, 0x80(%rsp)
               	vpminud	%xmm1, %xmm0, %xmm2
               	movups	%xmm2, 0x90(%rsp)
               	vpmaxud	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0xa0(%rsp)
               	xorl	%r15d, %r15d
               	leaq	<rip>, %rcx # <addr>
               	movq	%r15, %rax
               	shrq	%rax
               	shlq	$0x3, %rax
               	addq	%rcx, %rax
               	xorl	%r11d, %r11d
               	movslq	(%rax), %rdi
               	movslq	0x4(%rax), %r13
               	leaq	-0x1(%rdi), %rsi
               	movq	%rdi, %rax
               	shlq	$0x3, %rax
               	leaq	-0x1(%rax), %rcx
               	movslq	%ecx, %rbp
               	movq	%rax, 0xc8(%rsp)
               	movq	%r15, %r14
               	andq	$0x1, %r14
               	movl	$0x10, %eax
               	cltd
               	idivl	%edi
               	cmpl	%eax, %r11d
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rdi, %rdx
               	imulq	%r11, %rdx
               	movq	%rsi, %rcx
               	testl	%ecx, %ecx
               	jl	<addr>
               	shlq	$0x8, %rax
               	leaq	(%rdx,%rcx), %r8
               	movslq	%r8d, %r8
               	movzbq	0xd0(%rsp,%r8), %r8
               	orq	%r8, %rax
               	decq	%rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	testq	%r13, %r13
               	je	<addr>
               	cmpl	$0x8, %edi
               	jge	<addr>
               	shrxq	%rbp, %rax, %rcx
               	nopw	(%rax,%rax)
               	testb	$0x1, %cl
               	je	<addr>
               	movq	$-0x1, %rcx
               	movq	0xc8(%rsp), %rdx
               	movslq	%edx, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	orq	%rcx, %rax
               	xorl	%ecx, %ecx
               	movq	%rdi, %r8
               	imulq	%r11, %r8
               	movq	%rsi, %rdx
               	testl	%edx, %edx
               	jl	<addr>
               	shlq	$0x8, %rcx
               	leaq	(%r8,%rdx), %r9
               	movslq	%r9d, %r9
               	movzbq	0xe0(%rsp,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rdx
               	testl	%edx, %edx
               	jge	<addr>
               	testq	%r13, %r13
               	je	<addr>
               	cmpl	$0x8, %edi
               	jge	<addr>
               	shrxq	%rbp, %rcx, %rdx
               	nopl	(%rax)
               	testb	$0x1, %dl
               	je	<addr>
               	movq	$-0x1, %rdx
               	movq	0xc8(%rsp), %r8
               	movslq	%r8d, %r8
               	shlxq	%r8, %rdx, %rdx
               	orq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	setl	%r8b
               	movzbq	%r8b, %r8
               	cmpq	%rcx, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	testq	%r13, %r13
               	cmoveq	%rdx, %r8
               	nopl	(%rax)
               	testq	%r14, %r14
               	je	<addr>
               	xorl	%edx, %edx
               	cmpq	%rcx, %rax
               	setne	%r9b
               	movzbq	%r9b, %r9
               	testl	%r8d, %r8d
               	movq	%r9, %r8
               	cmovneq	%rdx, %r8
               	testq	%r8, %r8
               	movq	%rcx, %r8
               	cmovneq	%rax, %r8
               	movq	%rdi, %r9
               	imulq	%r11, %r9
               	xorl	%eax, %eax
               	cmpl	%edi, %eax
               	jge	<addr>
               	leaq	(%r9,%rax), %rcx
               	movslq	%ecx, %r10
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	shrxq	%rcx, %r8, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x100(%rsp,%r10)
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	%edi, %eax
               	jl	<addr>
               	incq	%r11
               	movl	$0x10, %eax
               	cltd
               	idivl	%edi
               	cmpl	%eax, %r11d
               	jl	<addr>
               	leaq	0x30(%rsp), %rax
               	movq	%r15, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rax
               	leaq	0x100(%rsp), %rsi
               	movups	(%rax), %xmm0
               	leaq	0x110(%rsp), %rdi
               	movups	%xmm0, 0x110(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%r15
               	nopw	(%rax,%rax)
               	cmpl	$0x8, %r15d
               	jl	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movq	0xc0(%rsp), %rax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0xf8, %rsp
               	retq
