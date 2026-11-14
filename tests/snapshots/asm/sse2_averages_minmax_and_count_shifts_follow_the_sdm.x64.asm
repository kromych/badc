
sse2_averages_minmax_and_count_shifts_follow_the_sdm.x64:	file format elf64-x86-64

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

<check_products_and_averages>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%edx, %edx
               	movl	$0x1, %eax
               	shlq	$0x8, %rdx
               	movzbq	(%r12,%rax), %rsi
               	orq	%rsi, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rdi
               	imulq	%rdx, %rdi
               	shrq	$0x10, %rdi
               	xorl	%eax, %eax
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rdi, %r8
               	andq	$0xff, %r8
               	movb	%r8b, -0x40(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	(%rcx,%rdx), %rax
               	leaq	0x1(%rax), %rcx
               	shrq	%rcx
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x20(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0x2(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%edx, %edx
               	movl	$0x1, %eax
               	shlq	$0x8, %rdx
               	leaq	0x2(%rax), %rsi
               	movzbq	(%r12,%rsi), %rsi
               	orq	%rsi, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rdi
               	imulq	%rdx, %rdi
               	shrq	$0x10, %rdi
               	xorl	%eax, %eax
               	leaq	0x2(%rax), %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rdi, %r9
               	andq	$0xff, %r9
               	movb	%r9b, -0x40(%rbp,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	(%rcx,%rdx), %rax
               	leaq	0x1(%rax), %rcx
               	shrq	%rcx
               	xorl	%eax, %eax
               	leaq	0x2(%rax), %rdx
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, -0x20(%rbp,%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0x4(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%edx, %edx
               	movl	$0x1, %eax
               	shlq	$0x8, %rdx
               	leaq	0x4(%rax), %rsi
               	movzbq	(%r12,%rsi), %rsi
               	orq	%rsi, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rdi
               	imulq	%rdx, %rdi
               	shrq	$0x10, %rdi
               	xorl	%eax, %eax
               	leaq	0x4(%rax), %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rdi, %r9
               	andq	$0xff, %r9
               	movb	%r9b, -0x40(%rbp,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	(%rcx,%rdx), %rax
               	leaq	0x1(%rax), %rcx
               	shrq	%rcx
               	xorl	%eax, %eax
               	leaq	0x4(%rax), %rdx
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, -0x20(%rbp,%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0x6(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%edx, %edx
               	movl	$0x1, %eax
               	shlq	$0x8, %rdx
               	leaq	0x6(%rax), %rsi
               	movzbq	(%r12,%rsi), %rsi
               	orq	%rsi, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rdi
               	imulq	%rdx, %rdi
               	shrq	$0x10, %rdi
               	xorl	%eax, %eax
               	leaq	0x6(%rax), %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rdi, %r9
               	andq	$0xff, %r9
               	movb	%r9b, -0x40(%rbp,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	(%rcx,%rdx), %rax
               	leaq	0x1(%rax), %rcx
               	shrq	%rcx
               	xorl	%eax, %eax
               	leaq	0x6(%rax), %rdx
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, -0x20(%rbp,%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0x8(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%edx, %edx
               	movl	$0x1, %eax
               	shlq	$0x8, %rdx
               	leaq	0x8(%rax), %rsi
               	movzbq	(%r12,%rsi), %rsi
               	orq	%rsi, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rdi
               	imulq	%rdx, %rdi
               	shrq	$0x10, %rdi
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rdi, %r9
               	andq	$0xff, %r9
               	movb	%r9b, -0x40(%rbp,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	(%rcx,%rdx), %rax
               	leaq	0x1(%rax), %rcx
               	shrq	%rcx
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %rdx
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, -0x20(%rbp,%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0xa(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%edx, %edx
               	movl	$0x1, %eax
               	shlq	$0x8, %rdx
               	leaq	0xa(%rax), %rsi
               	movzbq	(%r12,%rsi), %rsi
               	orq	%rsi, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rdi
               	imulq	%rdx, %rdi
               	shrq	$0x10, %rdi
               	xorl	%eax, %eax
               	leaq	0xa(%rax), %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rdi, %r9
               	andq	$0xff, %r9
               	movb	%r9b, -0x40(%rbp,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	(%rcx,%rdx), %rax
               	leaq	0x1(%rax), %rcx
               	shrq	%rcx
               	xorl	%eax, %eax
               	leaq	0xa(%rax), %rdx
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, -0x20(%rbp,%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0xc(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%edx, %edx
               	movl	$0x1, %eax
               	shlq	$0x8, %rdx
               	leaq	0xc(%rax), %rsi
               	movzbq	(%r12,%rsi), %rsi
               	orq	%rsi, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rdi
               	imulq	%rdx, %rdi
               	shrq	$0x10, %rdi
               	xorl	%eax, %eax
               	leaq	0xc(%rax), %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rdi, %r9
               	andq	$0xff, %r9
               	movb	%r9b, -0x40(%rbp,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	(%rcx,%rdx), %rax
               	leaq	0x1(%rax), %rcx
               	shrq	%rcx
               	xorl	%eax, %eax
               	leaq	0xc(%rax), %rdx
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, -0x20(%rbp,%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0xe(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%edx, %edx
               	movl	$0x1, %eax
               	shlq	$0x8, %rdx
               	leaq	0xe(%rax), %rsi
               	movzbq	(%r12,%rsi), %rsi
               	orq	%rsi, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rdi
               	imulq	%rdx, %rdi
               	shrq	$0x10, %rdi
               	xorl	%eax, %eax
               	leaq	0xe(%rax), %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rdi, %r9
               	andq	$0xff, %r9
               	movb	%r9b, -0x40(%rbp,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	(%rcx,%rdx), %rax
               	leaq	0x1(%rax), %rcx
               	shrq	%rcx
               	xorl	%eax, %eax
               	leaq	0xe(%rax), %rdx
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, -0x20(%rbp,%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movzbq	(%rbx), %rax
               	movzbq	(%r12), %rcx
               	addq	%rcx, %rax
               	incq	%rax
               	sarq	%rax
               	movb	%al, -0x30(%rbp)
               	movzbq	0x1(%rbx), %rax
               	movzbq	0x1(%r12), %rcx
               	addq	%rcx, %rax
               	incq	%rax
               	sarq	%rax
               	movb	%al, -0x2f(%rbp)
               	movzbq	0x2(%rbx), %rax
               	movzbq	0x2(%r12), %rcx
               	addq	%rcx, %rax
               	incq	%rax
               	sarq	%rax
               	movb	%al, -0x2e(%rbp)
               	movzbq	0x3(%rbx), %rax
               	movzbq	0x3(%r12), %rcx
               	addq	%rcx, %rax
               	incq	%rax
               	sarq	%rax
               	movb	%al, -0x2d(%rbp)
               	movzbq	0x4(%rbx), %rax
               	movzbq	0x4(%r12), %rcx
               	addq	%rcx, %rax
               	incq	%rax
               	sarq	%rax
               	movb	%al, -0x2c(%rbp)
               	movzbq	0x5(%rbx), %rax
               	movzbq	0x5(%r12), %rcx
               	addq	%rcx, %rax
               	incq	%rax
               	sarq	%rax
               	movb	%al, -0x2b(%rbp)
               	movzbq	0x6(%rbx), %rax
               	movzbq	0x6(%r12), %rcx
               	addq	%rcx, %rax
               	incq	%rax
               	sarq	%rax
               	movb	%al, -0x2a(%rbp)
               	movzbq	0x7(%rbx), %rax
               	movzbq	0x7(%r12), %rcx
               	addq	%rcx, %rax
               	incq	%rax
               	sarq	%rax
               	movb	%al, -0x29(%rbp)
               	movzbq	0x8(%rbx), %rax
               	movzbq	0x8(%r12), %rcx
               	addq	%rcx, %rax
               	incq	%rax
               	sarq	%rax
               	movb	%al, -0x28(%rbp)
               	movzbq	0x9(%rbx), %rax
               	movzbq	0x9(%r12), %rcx
               	addq	%rcx, %rax
               	incq	%rax
               	sarq	%rax
               	movb	%al, -0x27(%rbp)
               	movzbq	0xa(%rbx), %rax
               	movzbq	0xa(%r12), %rcx
               	addq	%rcx, %rax
               	incq	%rax
               	sarq	%rax
               	movb	%al, -0x26(%rbp)
               	movzbq	0xb(%rbx), %rax
               	movzbq	0xb(%r12), %rcx
               	addq	%rcx, %rax
               	incq	%rax
               	sarq	%rax
               	movb	%al, -0x25(%rbp)
               	movzbq	0xc(%rbx), %rax
               	movzbq	0xc(%r12), %rcx
               	addq	%rcx, %rax
               	incq	%rax
               	sarq	%rax
               	movb	%al, -0x24(%rbp)
               	movzbq	0xd(%rbx), %rax
               	movzbq	0xd(%r12), %rcx
               	addq	%rcx, %rax
               	incq	%rax
               	sarq	%rax
               	movb	%al, -0x23(%rbp)
               	movzbq	0xe(%rbx), %rax
               	movzbq	0xe(%r12), %rcx
               	addq	%rcx, %rax
               	incq	%rax
               	sarq	%rax
               	movb	%al, -0x22(%rbp)
               	movzbq	0xf(%rbx), %rax
               	movzbq	0xf(%r12), %rcx
               	addq	%rcx, %rax
               	incq	%rax
               	sarq	%rax
               	movb	%al, -0x21(%rbp)
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vpmulhuw	%xmm1, %xmm0, %xmm0
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %r13d
               	xorl	%ecx, %ecx
               	testq	%rax, %rax
               	cmoveq	%rcx, %r13
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vpavgb	%xmm1, %xmm0, %xmm0
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vpavgw	%xmm1, %xmm0, %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	orq	$0x2, %r13
               	movq	%r13, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<check_count_shifts>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, 0xb0(%rsp)
               	xorl	%r10d, %r10d
               	movq	%r10, 0xb8(%rsp)
               	movq	0xb8(%rsp), %r11
               	movq	%r11, 0xc0(%rsp)
               	leaq	-0x28(%rbp), %rax
               	movq	0xb0(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rax)
               	leaq	<rip>, %rax # <addr>
               	movq	0xb8(%rsp), %r10
               	movq	(%rax,%r10,8), %rax
               	movups	(%rbx), %xmm0
               	movl	$0x40, %ecx
               	cmpq	$0x40, %rax
               	cmovbeq	%rax, %rcx
               	movapd	%xmm0, %xmm1
               	movq	%rcx, %xmm14
               	psllw	%xmm14, %xmm1
               	movups	%xmm1, -0xf0(%rbp)
               	movl	$0x40, %ecx
               	cmpq	$0x40, %rax
               	cmovbeq	%rax, %rcx
               	movapd	%xmm0, %xmm1
               	movq	%rcx, %xmm14
               	pslld	%xmm14, %xmm1
               	movups	%xmm1, -0xe0(%rbp)
               	movl	$0x40, %ecx
               	cmpq	$0x40, %rax
               	cmovbeq	%rax, %rcx
               	movapd	%xmm0, %xmm1
               	movq	%rcx, %xmm14
               	psllq	%xmm14, %xmm1
               	movups	%xmm1, -0xd0(%rbp)
               	movl	$0x40, %ecx
               	cmpq	$0x40, %rax
               	cmovbeq	%rax, %rcx
               	movapd	%xmm0, %xmm1
               	movq	%rcx, %xmm14
               	psrlw	%xmm14, %xmm1
               	movups	%xmm1, -0xc0(%rbp)
               	movl	$0x40, %ecx
               	cmpq	$0x40, %rax
               	cmovbeq	%rax, %rcx
               	movapd	%xmm0, %xmm1
               	movq	%rcx, %xmm14
               	psrld	%xmm14, %xmm1
               	movups	%xmm1, -0xb0(%rbp)
               	movl	$0x40, %ecx
               	cmpq	$0x40, %rax
               	cmovbeq	%rax, %rcx
               	movapd	%xmm0, %xmm1
               	movq	%rcx, %xmm14
               	psrlq	%xmm14, %xmm1
               	movups	%xmm1, -0xa0(%rbp)
               	movl	$0x40, %ecx
               	cmpq	$0x40, %rax
               	cmovbeq	%rax, %rcx
               	movapd	%xmm0, %xmm1
               	movq	%rcx, %xmm14
               	psraw	%xmm14, %xmm1
               	movups	%xmm1, -0x90(%rbp)
               	movl	$0x40, %ecx
               	cmpq	$0x40, %rax
               	cmovaq	%rcx, %rax
               	movq	%rax, %xmm14
               	psrad	%xmm14, %xmm0
               	movups	%xmm0, -0x80(%rbp)
               	xorl	%r10d, %r10d
               	movq	%r10, 0xc8(%rsp)
               	movq	%r10, %rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	<rip>, %rcx # <addr>
               	shlq	$0x3, %rax
               	addq	%rcx, %rax
               	movl	(%rax), %r8d
               	movl	0x4(%rax), %r10d
               	movq	%r10, 0xe8(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	0xb8(%rsp), %r10
               	movq	(%rax,%r10,8), %r14
               	leaq	-0x1(%r8), %rdi
               	movq	%r8, %rax
               	shlq	$0x3, %rax
               	leaq	-0x1(%rax), %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0xe0(%rsp)
               	movslq	%eax, %r15
               	leaq	-0x1(%r15), %rax
               	movslq	%eax, %r10
               	movq	%r10, 0xd8(%rsp)
               	movslq	%r14d, %r10
               	movq	%r10, 0xd0(%rsp)
               	xorl	%r13d, %r13d
               	movl	$0x10, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%eax, %r13d
               	jge	<addr>
               	movq	0xe8(%rsp), %r12
               	cmpl	$0x2, %r12d
               	sete	%r12b
               	movzbq	%r12b, %r12
               	xorl	%ecx, %ecx
               	movq	%r8, %rdx
               	imulq	%r13, %rdx
               	movq	%rdi, %rax
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
               	testq	%r12, %r12
               	je	<addr>
               	cmpl	$0x8, %r8d
               	jge	<addr>
               	movq	0xe0(%rsp), %r10
               	shrxq	%r10, %rcx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	shlxq	%r15, %rax, %rax
               	orq	%rax, %rcx
               	movq	0xe8(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	xorl	%eax, %eax
               	shlxq	%r14, %rcx, %rcx
               	cmpq	%r15, %r14
               	cmovaeq	%rax, %rcx
               	movq	%r8, %rdx
               	imulq	%r13, %rdx
               	xorl	%eax, %eax
               	cmpl	%r8d, %eax
               	jge	<addr>
               	leaq	(%rdx,%rax), %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %r12
               	shlq	$0x3, %r12
               	movslq	%r12d, %r12
               	shrxq	%r12, %rcx, %r12
               	andq	$0xff, %r12
               	movb	%r12b, -0x20(%rbp,%rsi)
               	incq	%rax
               	cmpl	%r8d, %eax
               	jl	<addr>
               	jmp	<addr>
               	movq	0xe8(%rsp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	shrxq	%r14, %rcx, %rcx
               	cmpq	%r15, %r14
               	cmovaeq	%rax, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movq	%r8, %rdx
               	imulq	%r13, %rdx
               	movq	%rdi, %rax
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
               	movq	0xe0(%rsp), %r10
               	shrxq	%r10, %rcx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	shlxq	%r15, %rax, %rax
               	orq	%rax, %rcx
               	cmpq	%r15, %r14
               	movq	0xd8(%rsp), %r10
               	movq	0xd0(%rsp), %r11
               	movq	%r11, %rax
               	cmovaeq	%r10, %rax
               	sarxq	%rax, %rcx, %rcx
               	jmp	<addr>
               	incq	%r13
               	movl	$0x10, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%eax, %r13d
               	jl	<addr>
               	leaq	-0xf0(%rbp), %rax
               	movq	0xc8(%rsp), %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rax
               	leaq	-0x20(%rbp), %rsi
               	movups	(%rax), %xmm0
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x8, %ecx
               	testq	%rax, %rax
               	movq	0xc0(%rsp), %r11
               	movq	%r11, %r10
               	cmovneq	%rcx, %r10
               	movq	%r10, 0xc0(%rsp)
               	addq	$0x1, 0xc8(%rsp)
               	movq	0xc8(%rsp), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	addq	$0x1, 0xb8(%rsp)
               	movq	0xb8(%rsp), %rax
               	cmpl	$0x12, %eax
               	jb	<addr>
               	movq	0xc0(%rsp), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<check_byte_shifts>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	xorl	%eax, %eax
               	movzbq	(%rbx,%rax), %rdx
               	movb	%dl, -0x20(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	pslldq	$0x0, %xmm0             # xmm0 = xmm0[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x10, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	movq	%rdx, %r12
               	cmovneq	%rcx, %r12
               	xorl	%eax, %eax
               	movzbq	(%rbx,%rax), %rdx
               	movb	%dl, -0x20(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	psrldq	$0x0, %xmm0             # xmm0 = xmm0[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x10, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r12
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movb	%dl, -0x20(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	cmpl	$0x1, %eax
               	jl	<addr>
               	leaq	-0x1(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movups	(%rbx), %xmm0
               	pslldq	$0x1, %xmm0             # xmm0 = zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x10, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r12
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movb	%sil, -0x20(%rbp,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	0x1(%rax), %rcx
               	cmpl	$0x10, %ecx
               	jge	<addr>
               	movzbq	(%rbx,%rcx), %rsi
               	jmp	<addr>
               	movq	%rdx, %rsi
               	jmp	<addr>
               	movups	(%rbx), %xmm0
               	psrldq	$0x1, %xmm0             # xmm0 = xmm0[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],zero
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x10, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r12
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movb	%dl, -0x20(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	cmpl	$0x9, %eax
               	jl	<addr>
               	leaq	-0x9(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movups	(%rbx), %xmm0
               	pslldq	$0x9, %xmm0             # xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6]
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x10, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r12
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movb	%dl, -0x20(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	0x9(%rax), %rdx
               	cmpl	$0x10, %edx
               	jge	<addr>
               	movzbq	(%rbx,%rdx), %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movups	(%rbx), %xmm0
               	psrldq	$0x9, %xmm0             # xmm0 = xmm0[9,10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x10, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r12
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movb	%dl, -0x20(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	cmpl	$0xf, %eax
               	jl	<addr>
               	movzbq	(%rbx), %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movups	(%rbx), %xmm0
               	pslldq	$0xf, %xmm0             # xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0]
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x10, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r12
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movb	%dl, -0x20(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	0xf(%rax), %rdx
               	cmpl	$0x10, %edx
               	jge	<addr>
               	movzbq	0xf(%rbx), %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movups	(%rbx), %xmm0
               	psrldq	$0xf, %xmm0             # xmm0 = xmm0[15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x10, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r12
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movb	%cl, -0x20(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	pslldq	$0x10, %xmm0            # xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x10, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r12
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movb	%cl, -0x20(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	psrldq	$0x10, %xmm0            # xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x10, %ecx
               	testq	%rax, %rax
               	cmoveq	%r12, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<check_stores>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	movq	%rsi, %rbx
               	xorl	%eax, %eax
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	leaq	<rip>, %rdi # <addr>
               	jmp	<addr>
               	movb	%cl, -0x68(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jge	<addr>
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %r8
               	shrq	$0xc, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, %r8
               	shlq	$0x19, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, %r8
               	shrq	$0x1b, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	imulq	%rsi, %rcx
               	movq	%rcx, %r8
               	shrq	$0x3c, %r8
               	cmpl	$0x4, %r8d
               	jae	<addr>
               	shrq	$0x3a, %rcx
               	andq	$0x3, %rcx
               	movzbq	(%rdi,%rcx), %rcx
               	jmp	<addr>
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	-0x68(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	(%r12), %xmm0
               	movups	(%rbx), %xmm1
               	leaq	0x3(%rax), %rcx
               	movups	%xmm0, -0x90(%rbp)
               	movups	%xmm1, -0x80(%rbp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	movsbq	-0x80(%rbp,%rax), %rdi
               	testb	$-0x80, %dil
               	je	<addr>
               	movsbq	-0x90(%rbp,%rax), %rdi
               	movb	%dil, (%rcx,%rax)
               	jmp	<addr>
               	leaq	-0x48(%rbp), %rax
               	leaq	-0x68(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	movzbq	(%rbx,%rax), %rcx
               	testb	$-0x80, %cl
               	je	<addr>
               	leaq	0x3(%rax), %rdx
               	movzbq	(%r12,%rax), %rsi
               	movb	%sil, -0x48(%rbp,%rdx)
               	jmp	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	-0x48(%rbp), %rsi
               	movl	$0x20, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	movq	%rdx, %r13
               	cmovneq	%rcx, %r13
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, %r10
               	clflush	(%r10)
               	leaq	<rip>, %rax # <addr>
               	addq	$0x3f, %rax
               	movq	%rax, %r10
               	clflush	(%r10)
               	leaq	<rip>, %rdi # <addr>
               	leaq	-0x48(%rbp), %rsi
               	movl	$0x20, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r13
               	movups	(%r12), %xmm0
               	movups	%xmm0, -0xa0(%rbp)
               	xorl	%ecx, %ecx
               	movl	%ecx, -0x28(%rbp)
               	movq	%rcx, -0x70(%rbp)
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x4(%rax), %rdx
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
               	movl	%ecx, -0x28(%rbp)
               	xorl	%ecx, %ecx
               	movl	$0x7, %eax
               	shlq	$0x8, %rcx
               	leaq	0x8(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, -0x70(%rbp)
               	movups	-0xa0(%rbp), %xmm0
               	leaq	-0x58(%rbp), %rdi
               	movups	%xmm0, -0x58(%rbp)
               	movl	$0x10, %edx
               	movq	%r12, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x28(%rbp), %esi
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x4(%rax), %rdx
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
               	movq	-0x70(%rbp), %rsi
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
               	movl	$0x20, %r13d
               	movq	%r13, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<check_moves>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	leaq	-0x30(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	(%r12), %r10
               	movq	%r10, (%rax)
               	xorl	%ebx, %ebx
               	movl	$0x7, %eax
               	shlq	$0x8, %rbx
               	leaq	0x8(%rax), %rcx
               	movzbq	(%r12,%rcx), %rcx
               	orq	%rcx, %rbx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	leaq	-0x20(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x8(%r12), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	xorps	%xmm14, %xmm14
               	cvtsi2ss	%rbx, %xmm14
               	movsd	%xmm14, 0x18(%rsp)
               	movups	(%r12), %xmm0
               	xorl	%eax, %eax
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	vmovq	%rbx, %xmm0
               	xorl	%eax, %eax
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movups	(%r12), %xmm0
               	vmovq	%xmm0, %rsi
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
               	movl	$0xc0200000, %eax       # imm = 0xC0200000
               	movq	%rax, %xmm15
               	vmovd	%xmm15, %r11d
               	vmovd	%r11d, %xmm0
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	vmovd	%xmm15, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movq	%rax, %xmm15
               	vmovd	%xmm15, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	movq	%rax, %xmm15
               	vmovd	%xmm15, %r11d
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	cvtss2si	%xmm0, %rcx
               	cmpq	$-0x2, %rcx
               	jne	<addr>
               	movl	$0xc0300000, %ecx       # imm = 0xC0300000
               	movq	%rcx, %xmm15
               	vmovd	%xmm15, %r11d
               	vmovd	%r11d, %xmm0
               	movq	%rax, %xmm15
               	vmovd	%xmm15, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movq	%rax, %xmm15
               	vmovd	%xmm15, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	movq	%rax, %xmm15
               	vmovd	%xmm15, %r11d
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	cvttss2si	%xmm0, %rax
               	cmpq	$-0x2, %rax
               	jne	<addr>
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rbx, %xmm0
               	movsd	0x18(%rsp), %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x40, %eax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r15d, %r15d
               	movq	%r15, %rbx
               	jmp	<addr>
               	movq	0x38(%rsp), %rbx
               	orq	%rax, %rbx
               	leaq	-0x70(%rbp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0x70(%rbp), %rdi
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0x70(%rbp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0x70(%rbp), %rdi
               	callq	<addr>
               	orq	%rax, %rbx
               	incq	%r15
               	cmpl	$0x12c, %r15d           # imm = 0x12C
               	jge	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%cl, -0x70(%rbp,%rax)
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
               	movb	%cl, -0x60(%rbp,%rax)
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
               	leaq	-0x70(%rbp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	callq	<addr>
               	movq	%rbx, %r10
               	orq	%rax, %r10
               	movq	%r10, 0x38(%rsp)
               	xorl	%r12d, %r12d
               	xorl	%ecx, %ecx
               	movq	%r12, %rdi
               	shlq	%rdi
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%rdi,%rax), %r8
               	movslq	%r8d, %r8
               	movzbq	-0x70(%rbp,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %r13
               	orq	$-0x10000, %r13         # imm = 0xFFFF0000
               	testb	$0x1, %al
               	cmoveq	%rcx, %r13
               	xorl	%ecx, %ecx
               	movq	%r12, %rdi
               	shlq	%rdi
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	(%rdi,%rax), %r8
               	movslq	%r8d, %r8
               	movzbq	-0x60(%rbp,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %r14
               	orq	$-0x10000, %r14         # imm = 0xFFFF0000
               	testb	$0x1, %al
               	cmoveq	%rcx, %r14
               	cmpq	%r14, %r13
               	movq	%r14, %r8
               	cmovlq	%r13, %r8
               	movq	%r12, %rcx
               	shlq	%rcx
               	xorl	%eax, %eax
               	leaq	(%rcx,%rax), %r9
               	movslq	%r9d, %r9
               	movq	%rax, %rbx
               	shlq	$0x3, %rbx
               	shrxq	%rbx, %r8, %rbx
               	andq	$0xff, %rbx
               	movb	%bl, -0x50(%rbp,%r9)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	cmpq	%r14, %r13
               	movq	%r14, %rdi
               	cmovgq	%r13, %rdi
               	movq	%r12, %r8
               	shlq	%r8
               	xorl	%eax, %eax
               	leaq	(%r8,%rax), %r9
               	movslq	%r9d, %r9
               	movq	%rax, %rbx
               	shlq	$0x3, %rbx
               	shrxq	%rbx, %rdi, %rbx
               	andq	$0xff, %rbx
               	movb	%bl, -0x40(%rbp,%r9)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%r12
               	cmpl	$0x8, %r12d
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x70(%rbp,%rax), %rcx
               	movzbq	-0x60(%rbp,%rax), %rdi
               	cmpl	%edi, %ecx
               	cmovgeq	%rdi, %rcx
               	movb	%cl, -0x30(%rbp,%rax)
               	movzbq	-0x70(%rbp,%rax), %rcx
               	movzbq	-0x60(%rbp,%rax), %rdi
               	cmpl	%edi, %ecx
               	cmovleq	%rdi, %rcx
               	movb	%cl, -0x20(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	-0x70(%rbp), %xmm14
               	movups	%xmm14, 0x50(%rsp)
               	movups	-0x60(%rbp), %xmm14
               	movups	%xmm14, 0x40(%rsp)
               	movups	0x50(%rsp), %xmm14
               	movups	0x40(%rsp), %xmm15
               	vpminsw	%xmm15, %xmm14, %xmm0
               	leaq	-0x50(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movups	0x50(%rsp), %xmm14
               	movups	0x40(%rsp), %xmm15
               	vpmaxsw	%xmm15, %xmm14, %xmm0
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movups	0x50(%rsp), %xmm14
               	movups	0x40(%rsp), %xmm15
               	vpminub	%xmm15, %xmm14, %xmm0
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movups	0x50(%rsp), %xmm14
               	movups	0x40(%rsp), %xmm15
               	vpmaxub	%xmm15, %xmm14, %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
