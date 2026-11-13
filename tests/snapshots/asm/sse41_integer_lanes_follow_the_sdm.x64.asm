
sse41_integer_lanes_follow_the_sdm.x64:	file format elf64-x86-64

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

<check_products_packs>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	pushq	%r12
               	pushq	%rbx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rdi,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	movzbq	(%rsi,%rax), %r9
               	orq	%r9, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	imulq	%rdx, %rcx
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x50(%rbp,%rax)
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
               	leaq	0x4(%rax), %rdx
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, -0x50(%rbp,%rdx)
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
               	leaq	0x8(%rax), %rdx
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, -0x50(%rbp,%rdx)
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
               	leaq	0xc(%rax), %rdx
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, -0x50(%rbp,%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%r8d, %r8d
               	movq	%r8, %r9
               	shlq	%r9
               	xorl	%ecx, %ecx
               	shlq	$0x2, %r9
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	(%r9,%rax), %rbx
               	movslq	%ebx, %rbx
               	movzbq	(%rdi,%rbx), %rbx
               	orq	%rbx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	movabsq	$-0x100000000, %r9      # imm = 0xFFFFFFFF00000000
               	orq	%rcx, %r9
               	testb	$0x1, %al
               	movq	%rcx, %r12
               	cmovneq	%r9, %r12
               	movq	%r8, %r9
               	shlq	%r9
               	xorl	%ecx, %ecx
               	shlq	$0x2, %r9
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	(%r9,%rax), %rbx
               	movslq	%ebx, %rbx
               	movzbq	(%rsi,%rbx), %rbx
               	orq	%rbx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	movabsq	$-0x100000000, %r9      # imm = 0xFFFFFFFF00000000
               	orq	%rcx, %r9
               	testb	$0x1, %al
               	cmovneq	%r9, %rcx
               	imulq	%r12, %rcx
               	movq	%r8, %r9
               	shlq	$0x3, %r9
               	xorl	%eax, %eax
               	leaq	(%r9,%rax), %rbx
               	movslq	%ebx, %rbx
               	movq	%rax, %r12
               	shlq	$0x3, %r12
               	shrxq	%r12, %rcx, %r12
               	andq	$0xff, %r12
               	movb	%r12b, -0x40(%rbp,%rbx)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movq	%r8, %rdx
               	shlq	$0x3, %rdx
               	movl	$0x7, %eax
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
               	shlq	$0x3, %rbx
               	movl	$0x7, %eax
               	shlq	$0x8, %rdx
               	leaq	(%rbx,%rax), %r12
               	movslq	%r12d, %r12
               	movzbq	(%rsi,%r12), %r12
               	orq	%r12, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	$-0x1, %rax
               	xorl	%ebx, %ebx
               	cmpq	%rdx, %rcx
               	movq	%rbx, %rdx
               	cmovgq	%rax, %rdx
               	movq	%r8, %rcx
               	shlq	$0x3, %rcx
               	xorl	%eax, %eax
               	leaq	(%rcx,%rax), %rbx
               	movslq	%ebx, %rbx
               	movq	%rax, %r12
               	shlq	$0x3, %r12
               	shrxq	%r12, %rdx, %r12
               	andq	$0xff, %r12
               	movb	%r12b, -0x20(%rbp,%rbx)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	incq	%r8
               	cmpl	$0x2, %r8d
               	jl	<addr>
               	xorl	%r12d, %r12d
               	cmpl	$0x4, %r12d
               	movq	%rsi, %rdx
               	cmovlq	%rdi, %rdx
               	movq	%r12, %r8
               	andq	$0x3, %r8
               	xorl	%ecx, %ecx
               	shlq	$0x2, %r8
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	(%r8,%rax), %r9
               	movslq	%r9d, %r9
               	movzbq	(%rdx,%r9), %r9
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
               	xorl	%ecx, %ecx
               	movq	%r12, %rdx
               	shlq	%rdx
               	xorl	%eax, %eax
               	leaq	(%rdx,%rax), %r9
               	movslq	%r9d, %r9
               	movq	%rax, %rbx
               	shlq	$0x3, %rbx
               	shrxq	%rbx, %rcx, %rbx
               	andq	$0xff, %rbx
               	movb	%bl, -0x30(%rbp,%r9)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	jmp	<addr>
               	movl	$0xffff, %eax           # imm = 0xFFFF
               	cmpq	$0xffff, %rcx           # imm = 0xFFFF
               	cmovgq	%rax, %rcx
               	jmp	<addr>
               	incq	%r12
               	cmpl	$0x8, %r12d
               	jl	<addr>
               	movups	(%rdi), %xmm14
               	movups	%xmm14, 0x20(%rsp)
               	movups	(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rsp)
               	movups	0x20(%rsp), %xmm14
               	movups	0x10(%rsp), %xmm15
               	vpmulld	%xmm15, %xmm14, %xmm0
               	leaq	-0x50(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movups	0x20(%rsp), %xmm14
               	movups	0x10(%rsp), %xmm15
               	vpmuldq	%xmm15, %xmm14, %xmm0
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movups	0x20(%rsp), %xmm14
               	movups	0x10(%rsp), %xmm15
               	vpackusdw	%xmm15, %xmm14, %xmm0
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movups	0x20(%rsp), %xmm14
               	movups	0x10(%rsp), %xmm15
               	vpcmpgtq	%xmm15, %xmm14, %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>

<check_extensions>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x108, %rsp            # imm = 0x108
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movups	(%rbx), %xmm0
               	pmovsxbw	%xmm0, %xmm1
               	movups	%xmm1, -0x100(%rbp)
               	pmovsxbd	%xmm0, %xmm1
               	movups	%xmm1, -0xf0(%rbp)
               	pmovsxbq	%xmm0, %xmm1
               	movups	%xmm1, -0xe0(%rbp)
               	pmovsxwd	%xmm0, %xmm1
               	movups	%xmm1, -0xd0(%rbp)
               	pmovsxwq	%xmm0, %xmm1
               	movups	%xmm1, -0xc0(%rbp)
               	pmovsxdq	%xmm0, %xmm1
               	movups	%xmm1, -0xb0(%rbp)
               	pmovzxbw	%xmm0, %xmm1            # xmm1 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero,xmm0[4],zero,xmm0[5],zero,xmm0[6],zero,xmm0[7],zero
               	movups	%xmm1, -0xa0(%rbp)
               	pmovzxbd	%xmm0, %xmm1            # xmm1 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero,xmm0[2],zero,zero,zero,xmm0[3],zero,zero,zero
               	movups	%xmm1, -0x90(%rbp)
               	pmovzxbq	%xmm0, %xmm1            # xmm1 = xmm0[0],zero,zero,zero,zero,zero,zero,zero,xmm0[1],zero,zero,zero,zero,zero,zero,zero
               	movups	%xmm1, -0x80(%rbp)
               	pmovzxwd	%xmm0, %xmm1            # xmm1 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero
               	movups	%xmm1, -0x70(%rbp)
               	pmovzxwq	%xmm0, %xmm1            # xmm1 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero
               	movups	%xmm1, -0x60(%rbp)
               	pmovzxdq	%xmm0, %xmm0            # xmm0 = xmm0[0],zero,xmm0[1],zero
               	movups	%xmm0, -0x50(%rbp)
               	xorl	%r10d, %r10d
               	movq	%r10, 0xf8(%rsp)
               	movq	0xf8(%rsp), %rax
               	cmpl	$0xc, %eax
               	jge	<addr>
               	leaq	<rip>, %rcx # <addr>
               	imulq	$0x2aaaaaab, %rax, %rdx # imm = 0x2AAAAAAB
               	shrq	$0x20, %rdx
               	imulq	$0x6, %rdx, %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rcx
               	xorl	%r13d, %r13d
               	movl	(%rcx), %r14d
               	movl	0x4(%rcx), %esi
               	cmpl	$0x6, %eax
               	setl	%r15b
               	movzbq	%r15b, %r15
               	leaq	-0x1(%r14), %rdi
               	movq	%r14, %rax
               	shlq	$0x3, %rax
               	leaq	-0x1(%rax), %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x108(%rsp)
               	movslq	%eax, %r10
               	movq	%r10, 0x100(%rsp)
               	movl	$0x10, %eax
               	cltd
               	idivl	%esi
               	cmpl	%eax, %r13d
               	jge	<addr>
               	xorl	%ecx, %ecx
               	movq	%r14, %r8
               	imulq	%r13, %r8
               	movq	%rdi, %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rcx
               	leaq	(%r8,%rax), %r9
               	movslq	%r9d, %r9
               	movzbq	(%rbx,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	testq	%r15, %r15
               	je	<addr>
               	cmpl	$0x8, %r14d
               	jge	<addr>
               	movq	0x108(%rsp), %r10
               	shrxq	%r10, %rcx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	0x100(%rsp), %r10
               	shlxq	%r10, %rax, %rax
               	orq	%rax, %rcx
               	movq	%rsi, %r8
               	imulq	%r13, %r8
               	xorl	%eax, %eax
               	cmpl	%esi, %eax
               	jge	<addr>
               	leaq	(%r8,%rax), %r9
               	movslq	%r9d, %r9
               	movq	%rax, %r12
               	shlq	$0x3, %r12
               	movslq	%r12d, %r12
               	shrxq	%r12, %rcx, %r12
               	andq	$0xff, %r12
               	movb	%r12b, -0x20(%rbp,%r9)
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	incq	%r13
               	movl	$0x10, %eax
               	cltd
               	idivl	%esi
               	cmpl	%eax, %r13d
               	jl	<addr>
               	leaq	-0x100(%rbp), %rax
               	movq	0xf8(%rsp), %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rax
               	leaq	-0x20(%rbp), %rsi
               	movups	(%rax), %xmm0
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	addq	$0x1, 0xf8(%rsp)
               	movq	0xf8(%rsp), %rax
               	cmpl	$0xc, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<check_blends>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rdx, %r13
               	movq	%rsi, %r12
               	xorl	%edi, %edi
               	xorl	%eax, %eax
               	sarxq	%rdi, %rax, %rax
               	testb	$0x1, %al
               	movq	%rbx, %r9
               	cmovneq	%r12, %r9
               	xorl	%ecx, %ecx
               	movq	%rdi, %rdx
               	shlq	%rdx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %rsi
               	movslq	%esi, %rsi
               	movzbq	(%r9,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rdi, %r9
               	shlq	%r9
               	xorl	%eax, %eax
               	leaq	(%r9,%rax), %rdx
               	movslq	%edx, %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, -0x20(%rbp,%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rdi
               	cmpl	$0x8, %edi
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vpblendw	$0x0, %xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0,1,2,3,4,5,6,7]
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x8, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	movq	%rdx, %r14
               	cmovneq	%rcx, %r14
               	xorl	%edi, %edi
               	movl	$0xff, %eax
               	sarxq	%rdi, %rax, %rax
               	testb	$0x1, %al
               	movq	%rbx, %r9
               	cmovneq	%r12, %r9
               	xorl	%ecx, %ecx
               	movq	%rdi, %rdx
               	shlq	%rdx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %rsi
               	movslq	%esi, %rsi
               	movzbq	(%r9,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rdi, %r9
               	shlq	%r9
               	xorl	%eax, %eax
               	leaq	(%r9,%rax), %rdx
               	movslq	%edx, %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, -0x20(%rbp,%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rdi
               	cmpl	$0x8, %edi
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vpblendw	$0xff, %xmm1, %xmm0, %xmm0 # xmm0 = xmm1[0,1,2,3,4,5,6,7]
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x8, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r14
               	xorl	%edi, %edi
               	movl	$0xa5, %eax
               	sarxq	%rdi, %rax, %rax
               	testb	$0x1, %al
               	movq	%rbx, %r9
               	cmovneq	%r12, %r9
               	xorl	%ecx, %ecx
               	movq	%rdi, %rdx
               	shlq	%rdx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %rsi
               	movslq	%esi, %rsi
               	movzbq	(%r9,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rdi, %r9
               	shlq	%r9
               	xorl	%eax, %eax
               	leaq	(%r9,%rax), %rdx
               	movslq	%edx, %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, -0x20(%rbp,%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rdi
               	cmpl	$0x8, %edi
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vpblendw	$0xa5, %xmm1, %xmm0, %xmm0 # xmm0 = xmm1[0],xmm0[1],xmm1[2],xmm0[3,4],xmm1[5],xmm0[6],xmm1[7]
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x8, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r14
               	xorl	%edi, %edi
               	movl	$0x3c, %eax
               	sarxq	%rdi, %rax, %rax
               	testb	$0x1, %al
               	movq	%rbx, %r9
               	cmovneq	%r12, %r9
               	xorl	%ecx, %ecx
               	movq	%rdi, %rdx
               	shlq	%rdx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %rsi
               	movslq	%esi, %rsi
               	movzbq	(%r9,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rdi, %r9
               	shlq	%r9
               	xorl	%eax, %eax
               	leaq	(%r9,%rax), %rdx
               	movslq	%edx, %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, -0x20(%rbp,%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rdi
               	cmpl	$0x8, %edi
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vpblendw	$0x3c, %xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0,1],xmm1[2,3,4,5],xmm0[6,7]
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x8, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r14
               	xorl	%edi, %edi
               	movl	$0x81, %eax
               	sarxq	%rdi, %rax, %rax
               	testb	$0x1, %al
               	movq	%rbx, %r9
               	cmovneq	%r12, %r9
               	xorl	%ecx, %ecx
               	movq	%rdi, %rdx
               	shlq	%rdx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %rsi
               	movslq	%esi, %rsi
               	movzbq	(%r9,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rdi, %r9
               	shlq	%r9
               	xorl	%eax, %eax
               	leaq	(%r9,%rax), %rdx
               	movslq	%edx, %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, -0x20(%rbp,%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rdi
               	cmpl	$0x8, %edi
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vpblendw	$0x81, %xmm1, %xmm0, %xmm0 # xmm0 = xmm1[0],xmm0[1,2,3,4,5,6],xmm1[7]
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x8, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r14
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%cl, -0x20(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	movzbq	(%r13,%rax), %rcx
               	testb	$-0x80, %cl
               	je	<addr>
               	movzbq	(%r12,%rax), %rcx
               	jmp	<addr>
               	movzbq	(%rbx,%rax), %rcx
               	jmp	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	movups	(%r13), %xmm2
               	movups	%xmm0, -0x50(%rbp)
               	movups	%xmm1, -0x40(%rbp)
               	movups	%xmm2, -0x30(%rbp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	movsbq	-0x30(%rbp,%rax), %rdi
               	testb	$-0x80, %dil
               	je	<addr>
               	movsbq	-0x40(%rbp,%rax), %rdi
               	movb	%dil, -0x50(%rbp,%rax)
               	jmp	<addr>
               	movups	-0x50(%rbp), %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
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
               	leave
               	retq

<check_elements>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
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
               	xorl	%r12d, %r12d
               	movl	$0x7, %eax
               	shlq	$0x8, %r12
               	leaq	0x8(%rax), %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	orq	%rcx, %r12
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%r14d, %r14d
               	movups	(%rbx), %xmm0
               	pextrb	$0x0, %xmm0, %eax
               	movzbq	(%rbx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movups	(%rbx), %xmm0
               	pextrb	$0x9, %xmm0, %eax
               	movzbq	0x9(%rbx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	pextrb	$0xf, %xmm0, %eax
               	movzbq	0xf(%rbx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x10, %r14d
               	movups	(%rbx), %xmm0
               	pextrd	$0x3, %xmm0, %esi
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0xc(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
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
               	movups	(%rbx), %xmm0
               	pextrq	$0x0, %xmm0, %rsi
               	xorl	%ecx, %ecx
               	movl	$0x7, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	movups	(%rbx), %xmm0
               	pextrq	$0x1, %xmm0, %rsi
               	xorl	%ecx, %ecx
               	movl	$0x7, %eax
               	shlq	$0x8, %rcx
               	leaq	0x8(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	cmpq	%rcx, %rsi
               	je	<addr>
               	movl	$0x10, %r14d
               	leaq	-0x20(%rbp), %rsi
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%r13, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x15(%rbp)
               	movups	(%rbx), %xmm0
               	pinsrb	$0xb, %r13d, %xmm0
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x10, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r14
               	leaq	-0x20(%rbp), %rcx
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %r13, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, -0x20(%rbp,%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	pinsrd	$0x2, %r13d, %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x10, %ecx
               	testq	%rax, %rax
               	movq	%r14, %r13
               	cmovneq	%rcx, %r13
               	leaq	-0x20(%rbp), %rcx
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %r12, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, -0x20(%rbp,%rdx)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	pinsrq	$0x1, %r12, %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
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
               	leave
               	retq

<check_ptest>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	movzbq	(%r12), %rax
               	movzbq	(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x28(%rbp)
               	movzbq	0x1(%r12), %rax
               	movzbq	0x1(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x27(%rbp)
               	movzbq	0x2(%r12), %rax
               	movzbq	0x2(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x26(%rbp)
               	movzbq	0x3(%r12), %rax
               	movzbq	0x3(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x25(%rbp)
               	movzbq	0x4(%r12), %rax
               	movzbq	0x4(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x24(%rbp)
               	movzbq	0x5(%r12), %rax
               	movzbq	0x5(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x23(%rbp)
               	movzbq	0x6(%r12), %rax
               	movzbq	0x6(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x22(%rbp)
               	movzbq	0x7(%r12), %rax
               	movzbq	0x7(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x21(%rbp)
               	movzbq	0x8(%r12), %rax
               	movzbq	0x8(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x20(%rbp)
               	movzbq	0x9(%r12), %rax
               	movzbq	0x9(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x1f(%rbp)
               	movzbq	0xa(%r12), %rax
               	movzbq	0xa(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x1e(%rbp)
               	movzbq	0xb(%r12), %rax
               	movzbq	0xb(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x1d(%rbp)
               	movzbq	0xc(%r12), %rax
               	movzbq	0xc(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x1c(%rbp)
               	movzbq	0xd(%r12), %rax
               	movzbq	0xd(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x1b(%rbp)
               	movzbq	0xe(%r12), %rax
               	movzbq	0xe(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x1a(%rbp)
               	movzbq	0xf(%r12), %rax
               	movzbq	0xf(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x19(%rbp)
               	xorl	%eax, %eax
               	movq	%r12, -0x18(%rbp)
               	movq	%rsi, -0x10(%rbp)
               	leaq	-0x28(%rbp), %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rbx
               	xorl	%esi, %esi
               	jmp	<addr>
               	incq	%rsi
               	cmpl	$0x3, %esi
               	jge	<addr>
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	movq	%rdx, %r8
               	movq	-0x18(%rbp,%rax,8), %r9
               	movzbq	(%r9,%rcx), %r9
               	movq	-0x18(%rbp,%rsi,8), %rdi
               	movzbq	(%rdi,%rcx), %rdi
               	andq	%rdi, %r9
               	testl	%r9d, %r9d
               	sete	%r9b
               	movzbq	%r9b, %r9
               	andq	%r9, %r8
               	movq	-0x18(%rbp,%rax,8), %r9
               	movzbq	(%r9,%rcx), %r9
               	xorq	$-0x1, %r9
               	movq	-0x18(%rbp,%rsi,8), %rdi
               	movzbq	(%rdi,%rcx), %rdi
               	andq	%rdi, %r9
               	testl	%r9d, %r9d
               	sete	%r9b
               	movzbq	%r9b, %r9
               	andq	%r9, %rdx
               	incq	%rcx
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	movq	-0x18(%rbp,%rax,8), %r9
               	movups	(%r9), %xmm0
               	movq	-0x18(%rbp,%rsi,8), %rcx
               	movups	(%rcx), %xmm1
               	vpand	%xmm1, %xmm0, %xmm2
               	vmovq	%xmm2, %rcx
               	vpextrq	$0x1, %xmm2, %r9
               	orq	%r9, %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpl	%r8d, %ecx
               	jne	<addr>
               	vpcmpeqd	%xmm2, %xmm2, %xmm2
               	vpxor	%xmm2, %xmm0, %xmm3
               	vpand	%xmm1, %xmm3, %xmm3
               	vmovq	%xmm3, %rcx
               	vpextrq	$0x1, %xmm3, %r9
               	orq	%r9, %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	vpand	%xmm1, %xmm0, %xmm3
               	vmovq	%xmm3, %rcx
               	vpextrq	$0x1, %xmm3, %r9
               	orq	%rcx, %r9
               	xorl	%ecx, %ecx
               	testq	%r9, %r9
               	je	<addr>
               	vpxor	%xmm2, %xmm0, %xmm3
               	vpand	%xmm1, %xmm3, %xmm3
               	vmovq	%xmm3, %rcx
               	vpextrq	$0x1, %xmm3, %r9
               	orq	%r9, %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%r9d, %r9d
               	testl	%edx, %edx
               	sete	%dil
               	movzbq	%dil, %rdi
               	testl	%r8d, %r8d
               	cmoveq	%rdi, %r9
               	cmpl	%r9d, %ecx
               	jne	<addr>
               	vpand	%xmm1, %xmm0, %xmm3
               	vmovq	%xmm3, %rcx
               	vpextrq	$0x1, %xmm3, %r9
               	orq	%r9, %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpl	%r8d, %ecx
               	jne	<addr>
               	vpand	%xmm1, %xmm0, %xmm3
               	vmovq	%xmm3, %rcx
               	vpextrq	$0x1, %xmm3, %r9
               	orq	%rcx, %r9
               	xorl	%ecx, %ecx
               	testq	%r9, %r9
               	je	<addr>
               	vpxor	%xmm2, %xmm0, %xmm0
               	vpand	%xmm1, %xmm0, %xmm0
               	vmovq	%xmm0, %rcx
               	vpextrq	$0x1, %xmm0, %r9
               	orq	%r9, %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%r9d, %r9d
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%r8d, %r8d
               	cmovneq	%r9, %rdx
               	cmpl	%edx, %ecx
               	je	<addr>
               	movl	$0x20, %ebx
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movzbq	(%r12), %rax
               	cmpl	$0xff, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movzbq	0x1(%r12), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0x2(%r12), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0x3(%r12), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0x4(%r12), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0x5(%r12), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0x6(%r12), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0x7(%r12), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0x8(%r12), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0x9(%r12), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0xa(%r12), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0xb(%r12), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0xc(%r12), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0xd(%r12), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0xe(%r12), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0xf(%r12), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movups	(%r12), %xmm0
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
               	vpcmpeqd	%xmm0, %xmm0, %xmm2
               	vpxor	%xmm1, %xmm0, %xmm0
               	vpand	%xmm2, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	vpextrq	$0x1, %xmm0, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x20, %ebx
               	movq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<check_minpos>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%rbx
               	leaq	-0x20(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%ebx, %ebx
               	movl	$0x1, %r9d
               	xorl	%ecx, %ecx
               	movq	%r9, %rdx
               	shlq	%rdx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %rsi
               	movslq	%esi, %rsi
               	movzbq	(%rdi,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%edx, %edx
               	movq	%rbx, %rsi
               	shlq	%rsi
               	movl	$0x1, %eax
               	shlq	$0x8, %rdx
               	leaq	(%rsi,%rax), %r8
               	movslq	%r8d, %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	cmpq	%rdx, %rcx
               	cmovbq	%r9, %rbx
               	incq	%r9
               	cmpl	$0x8, %r9d
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movq	%rbx, %rsi
               	shlq	%rsi
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%rsi,%rax), %r8
               	movslq	%r8d, %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, -0x20(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	0x2(%rax), %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rbx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, -0x20(%rbp,%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	(%rdi), %xmm0
               	movups	%xmm0, -0x30(%rbp)
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	movswq	-0x30(%rbp,%rax,2), %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movswq	-0x30(%rbp,%rcx,2), %rdi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	cmpl	%edi, %esi
               	cmovlq	%rax, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movswq	-0x30(%rbp,%rcx,2), %rax
               	vpinsrw	$0x0, %eax, %xmm0, %xmm0
               	vpinsrw	$0x1, %ecx, %xmm0, %xmm0
               	xorl	%eax, %eax
               	vpinsrw	$0x2, %eax, %xmm0, %xmm0
               	vpinsrw	$0x3, %eax, %xmm0, %xmm0
               	vpinsrw	$0x4, %eax, %xmm0, %xmm0
               	vpinsrw	$0x5, %eax, %xmm0, %xmm0
               	vpinsrw	$0x6, %eax, %xmm0, %xmm0
               	vpinsrw	$0x7, %eax, %xmm0, %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	xorl	%ecx, %ecx
               	movl	$0x40, %edx
               	testq	%rax, %rax
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	leave
               	retq

<check_mpsadbw>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
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
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movslq	%edx, %rdx
               	movq	%rsi, %rdi
               	shlq	%rdi
               	xorl	%eax, %eax
               	leaq	(%rdi,%rax), %r8
               	movslq	%r8d, %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rdx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, -0x20(%rbp,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rsi
               	cmpl	$0x8, %esi
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	movups	%xmm0, -0x50(%rbp)
               	movups	%xmm1, -0x40(%rbp)
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	leaq	(%rsi,%rax), %rdi
               	movsbq	-0x50(%rbp,%rdi), %rcx
               	andq	$0xff, %rcx
               	movsbq	-0x40(%rbp,%rax), %rdi
               	andq	$0xff, %rdi
               	subq	%rdi, %rcx
               	movq	%rcx, %rdi
               	negq	%rdi
               	testl	%ecx, %ecx
               	cmovlq	%rdi, %rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movw	%dx, -0x30(%rbp,%rsi,2)
               	incq	%rsi
               	cmpl	$0x8, %esi
               	jl	<addr>
               	movups	-0x30(%rbp), %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
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
               	movq	%rsi, %rdi
               	shlq	%rdi
               	xorl	%eax, %eax
               	leaq	(%rdi,%rax), %r8
               	movslq	%r8d, %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rdx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, -0x20(%rbp,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rsi
               	cmpl	$0x8, %esi
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	movups	%xmm0, -0x50(%rbp)
               	movups	%xmm1, -0x40(%rbp)
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	leaq	(%rsi,%rax), %rdi
               	movsbq	-0x50(%rbp,%rdi), %rcx
               	andq	$0xff, %rcx
               	leaq	0x4(%rax), %r8
               	movsbq	-0x40(%rbp,%r8), %rdi
               	andq	$0xff, %rdi
               	subq	%rdi, %rcx
               	movq	%rcx, %rdi
               	negq	%rdi
               	testl	%ecx, %ecx
               	cmovlq	%rdi, %rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movw	%dx, -0x30(%rbp,%rsi,2)
               	incq	%rsi
               	cmpl	$0x8, %esi
               	jl	<addr>
               	movups	-0x30(%rbp), %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
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
               	movq	%rsi, %rdi
               	shlq	%rdi
               	xorl	%eax, %eax
               	leaq	(%rdi,%rax), %r8
               	movslq	%r8d, %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rdx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, -0x20(%rbp,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rsi
               	cmpl	$0x8, %esi
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	movups	%xmm0, -0x50(%rbp)
               	movups	%xmm1, -0x40(%rbp)
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	leaq	(%rsi,%rax), %rdi
               	movsbq	-0x50(%rbp,%rdi), %rcx
               	andq	$0xff, %rcx
               	leaq	0x8(%rax), %r8
               	movsbq	-0x40(%rbp,%r8), %rdi
               	andq	$0xff, %rdi
               	subq	%rdi, %rcx
               	movq	%rcx, %rdi
               	negq	%rdi
               	testl	%ecx, %ecx
               	cmovlq	%rdi, %rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movw	%dx, -0x30(%rbp,%rsi,2)
               	incq	%rsi
               	cmpl	$0x8, %esi
               	jl	<addr>
               	movups	-0x30(%rbp), %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
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
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movslq	%edx, %rdx
               	movq	%rsi, %rdi
               	shlq	%rdi
               	xorl	%eax, %eax
               	leaq	(%rdi,%rax), %r8
               	movslq	%r8d, %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rdx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, -0x20(%rbp,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rsi
               	cmpl	$0x8, %esi
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	movups	%xmm0, -0x50(%rbp)
               	movups	%xmm1, -0x40(%rbp)
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	leaq	(%rsi,%rax), %rdi
               	movsbq	-0x50(%rbp,%rdi), %rcx
               	andq	$0xff, %rcx
               	leaq	0xc(%rax), %r8
               	movsbq	-0x40(%rbp,%r8), %rdi
               	andq	$0xff, %rdi
               	subq	%rdi, %rcx
               	movq	%rcx, %rdi
               	negq	%rdi
               	testl	%ecx, %ecx
               	cmovlq	%rdi, %rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movw	%dx, -0x30(%rbp,%rsi,2)
               	incq	%rsi
               	cmpl	$0x8, %esi
               	jl	<addr>
               	movups	-0x30(%rbp), %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
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
               	movq	%r9, %rsi
               	shlq	%rsi
               	xorl	%eax, %eax
               	leaq	(%rsi,%rax), %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rdx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, -0x20(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%r9
               	cmpl	$0x8, %r9d
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	movups	%xmm0, -0x50(%rbp)
               	movups	%xmm1, -0x40(%rbp)
               	xorl	%r9d, %r9d
               	leaq	0x4(%r9), %rsi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	leaq	(%rsi,%rax), %rdi
               	movsbq	-0x50(%rbp,%rdi), %rcx
               	andq	$0xff, %rcx
               	movsbq	-0x40(%rbp,%rax), %rdi
               	andq	$0xff, %rdi
               	subq	%rdi, %rcx
               	movq	%rcx, %rdi
               	negq	%rdi
               	testl	%ecx, %ecx
               	cmovlq	%rdi, %rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movw	%dx, -0x30(%rbp,%r9,2)
               	incq	%r9
               	cmpl	$0x8, %r9d
               	jl	<addr>
               	movups	-0x30(%rbp), %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
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
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movslq	%edx, %rdx
               	movq	%r9, %rsi
               	shlq	%rsi
               	xorl	%eax, %eax
               	leaq	(%rsi,%rax), %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rdx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, -0x20(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%r9
               	cmpl	$0x8, %r9d
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	movups	%xmm0, -0x50(%rbp)
               	movups	%xmm1, -0x40(%rbp)
               	xorl	%r9d, %r9d
               	leaq	0x4(%r9), %rsi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	leaq	(%rsi,%rax), %rdi
               	movsbq	-0x50(%rbp,%rdi), %rcx
               	andq	$0xff, %rcx
               	leaq	0x4(%rax), %r8
               	movsbq	-0x40(%rbp,%r8), %rdi
               	andq	$0xff, %rdi
               	subq	%rdi, %rcx
               	movq	%rcx, %rdi
               	negq	%rdi
               	testl	%ecx, %ecx
               	cmovlq	%rdi, %rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movw	%dx, -0x30(%rbp,%r9,2)
               	incq	%r9
               	cmpl	$0x8, %r9d
               	jl	<addr>
               	movups	-0x30(%rbp), %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
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
               	movq	%r9, %rsi
               	shlq	%rsi
               	xorl	%eax, %eax
               	leaq	(%rsi,%rax), %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rdx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, -0x20(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%r9
               	cmpl	$0x8, %r9d
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	movups	%xmm0, -0x50(%rbp)
               	movups	%xmm1, -0x40(%rbp)
               	xorl	%r9d, %r9d
               	leaq	0x4(%r9), %rsi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	leaq	(%rsi,%rax), %rdi
               	movsbq	-0x50(%rbp,%rdi), %rcx
               	andq	$0xff, %rcx
               	leaq	0x8(%rax), %r8
               	movsbq	-0x40(%rbp,%r8), %rdi
               	andq	$0xff, %rdi
               	subq	%rdi, %rcx
               	movq	%rcx, %rdi
               	negq	%rdi
               	testl	%ecx, %ecx
               	cmovlq	%rdi, %rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movw	%dx, -0x30(%rbp,%r9,2)
               	incq	%r9
               	cmpl	$0x8, %r9d
               	jl	<addr>
               	movups	-0x30(%rbp), %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
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
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movslq	%edx, %rdx
               	movq	%r9, %rsi
               	shlq	%rsi
               	xorl	%eax, %eax
               	leaq	(%rsi,%rax), %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rdx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, -0x20(%rbp,%rdi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%r9
               	cmpl	$0x8, %r9d
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	movups	%xmm0, -0x50(%rbp)
               	movups	%xmm1, -0x40(%rbp)
               	xorl	%r9d, %r9d
               	leaq	0x4(%r9), %rsi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	leaq	(%rsi,%rax), %rdi
               	movsbq	-0x50(%rbp,%rdi), %rcx
               	andq	$0xff, %rcx
               	leaq	0xc(%rax), %r8
               	movsbq	-0x40(%rbp,%r8), %rdi
               	andq	$0xff, %rdi
               	subq	%rdi, %rcx
               	movq	%rcx, %rdi
               	negq	%rdi
               	testl	%ecx, %ecx
               	cmovlq	%rdi, %rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movw	%dx, -0x30(%rbp,%r9,2)
               	incq	%r9
               	cmpl	$0x8, %r9d
               	jl	<addr>
               	movups	-0x30(%rbp), %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
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
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x80, %ecx
               	testq	%rax, %rax
               	cmoveq	%r12, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x108, %rsp            # imm = 0x108
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r10d, %r10d
               	movq	%r10, 0xb8(%rsp)
               	movq	0xb8(%rsp), %r11
               	movq	%r11, 0xb0(%rsp)
               	jmp	<addr>
               	movq	0xb0(%rsp), %rbx
               	orq	%rax, %rbx
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0x50(%rbp), %rdi
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x30(%rbp), %rdx
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0x50(%rbp), %rdi
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	callq	<addr>
               	movq	%rbx, %r10
               	orq	%rax, %r10
               	movq	%r10, 0xb0(%rsp)
               	addq	$0x1, 0xb8(%rsp)
               	movq	0xb8(%rsp), %rax
               	cmpl	$0x12c, %eax            # imm = 0x12C
               	jge	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%cl, -0x50(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
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
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%cl, -0x40(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
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
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%cl, -0x30(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
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
               	movq	0xb8(%rsp), %rax
               	imulq	$0x24924925, %rax, %rcx # imm = 0x24924925
               	shrq	$0x20, %rcx
               	imulq	$0x7, %rcx, %rcx
               	subq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	leaq	-0x50(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x50(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	vpminsb	%xmm1, %xmm0, %xmm2
               	movups	%xmm2, -0x100(%rbp)
               	vpmaxsb	%xmm1, %xmm0, %xmm2
               	movups	%xmm2, -0xf0(%rbp)
               	vpminuw	%xmm1, %xmm0, %xmm2
               	movups	%xmm2, -0xe0(%rbp)
               	vpmaxuw	%xmm1, %xmm0, %xmm2
               	movups	%xmm2, -0xd0(%rbp)
               	vpminsd	%xmm1, %xmm0, %xmm2
               	movups	%xmm2, -0xc0(%rbp)
               	vpmaxsd	%xmm1, %xmm0, %xmm2
               	movups	%xmm2, -0xb0(%rbp)
               	vpminud	%xmm1, %xmm0, %xmm2
               	movups	%xmm2, -0xa0(%rbp)
               	vpmaxud	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, -0x90(%rbp)
               	xorl	%r10d, %r10d
               	movq	%r10, 0xc0(%rsp)
               	movq	0xc0(%rsp), %rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movq	%rax, %rdx
               	shrq	%rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	xorl	%r14d, %r14d
               	movl	(%rcx), %edi
               	movslq	0x4(%rcx), %r15
               	leaq	-0x1(%rdi), %rsi
               	movq	%rdi, %rcx
               	shlq	$0x3, %rcx
               	leaq	-0x1(%rcx), %rdx
               	movslq	%edx, %r10
               	movq	%r10, 0xd8(%rsp)
               	movslq	%ecx, %r10
               	movq	%r10, 0xd0(%rsp)
               	movq	%rax, %r10
               	andq	$0x1, %r10
               	movq	%r10, 0xc8(%rsp)
               	movl	$0x10, %eax
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
               	movzbq	-0x50(%rbp,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	testq	%r15, %r15
               	je	<addr>
               	cmpl	$0x8, %edi
               	jge	<addr>
               	movq	0xd8(%rsp), %r10
               	shrxq	%r10, %rcx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	0xd0(%rsp), %r10
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
               	movzbq	-0x40(%rbp,%r9), %r9
               	orq	%r9, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	testq	%r15, %r15
               	je	<addr>
               	cmpl	$0x8, %edi
               	jge	<addr>
               	movq	0xd8(%rsp), %r10
               	shrxq	%r10, %rdx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	0xd0(%rsp), %r10
               	shlxq	%r10, %rax, %rax
               	orq	%rax, %rdx
               	cmpq	%rdx, %rcx
               	setl	%al
               	movzbq	%al, %rax
               	cmpq	%rdx, %rcx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	testq	%r15, %r15
               	cmoveq	%r8, %rax
               	movq	0xc8(%rsp), %r10
               	testq	%r10, %r10
               	je	<addr>
               	xorl	%r8d, %r8d
               	cmpq	%rdx, %rcx
               	setne	%r9b
               	movzbq	%r9b, %r9
               	testl	%eax, %eax
               	movq	%r9, %rax
               	cmovneq	%r8, %rax
               	testq	%rax, %rax
               	cmoveq	%rdx, %rcx
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
               	movb	%r13b, -0x20(%rbp,%r9)
               	incq	%rax
               	cmpl	%edi, %eax
               	jl	<addr>
               	incq	%r14
               	movl	$0x10, %eax
               	cltd
               	idivl	%edi
               	cmpl	%eax, %r14d
               	jl	<addr>
               	leaq	-0x100(%rbp), %rax
               	movq	0xc0(%rsp), %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rax
               	leaq	-0x20(%rbp), %rsi
               	movups	(%rax), %xmm0
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	addq	$0x1, 0xc0(%rsp)
               	movq	0xc0(%rsp), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movq	0xb0(%rsp), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
