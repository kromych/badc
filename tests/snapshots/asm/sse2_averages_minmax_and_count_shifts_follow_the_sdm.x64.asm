
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
               	subq	$0xe8, %rsp
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
               	leaq	-0x40(%rbp), %rsi
               	movq	%rcx, %rdi
               	imulq	%rdx, %rdi
               	shrq	$0x10, %rdi
               	xorl	%eax, %eax
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rdi, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rsi
               	leaq	(%rcx,%rdx), %rax
               	leaq	0x1(%rax), %rcx
               	shrq	%rcx
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi,%rax)
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
               	leaq	-0x40(%rbp), %rsi
               	movq	%rcx, %rdi
               	imulq	%rdx, %rdi
               	shrq	$0x10, %rdi
               	xorl	%eax, %eax
               	leaq	0x2(%rax), %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rdi, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rsi,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rsi
               	leaq	(%rcx,%rdx), %rax
               	leaq	0x1(%rax), %rcx
               	shrq	%rcx
               	xorl	%eax, %eax
               	leaq	0x2(%rax), %rdx
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi,%rdx)
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
               	leaq	-0x40(%rbp), %rsi
               	movq	%rcx, %rdi
               	imulq	%rdx, %rdi
               	shrq	$0x10, %rdi
               	xorl	%eax, %eax
               	leaq	0x4(%rax), %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rdi, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rsi,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rsi
               	leaq	(%rcx,%rdx), %rax
               	leaq	0x1(%rax), %rcx
               	shrq	%rcx
               	xorl	%eax, %eax
               	leaq	0x4(%rax), %rdx
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi,%rdx)
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
               	leaq	-0x40(%rbp), %rsi
               	movq	%rcx, %rdi
               	imulq	%rdx, %rdi
               	shrq	$0x10, %rdi
               	xorl	%eax, %eax
               	leaq	0x6(%rax), %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rdi, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rsi,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rsi
               	leaq	(%rcx,%rdx), %rax
               	leaq	0x1(%rax), %rcx
               	shrq	%rcx
               	xorl	%eax, %eax
               	leaq	0x6(%rax), %rdx
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi,%rdx)
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
               	leaq	-0x40(%rbp), %rsi
               	movq	%rcx, %rdi
               	imulq	%rdx, %rdi
               	shrq	$0x10, %rdi
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rdi, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rsi,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rsi
               	leaq	(%rcx,%rdx), %rax
               	leaq	0x1(%rax), %rcx
               	shrq	%rcx
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %rdx
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi,%rdx)
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
               	leaq	-0x40(%rbp), %rsi
               	movq	%rcx, %rdi
               	imulq	%rdx, %rdi
               	shrq	$0x10, %rdi
               	xorl	%eax, %eax
               	leaq	0xa(%rax), %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rdi, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rsi,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rsi
               	leaq	(%rcx,%rdx), %rax
               	leaq	0x1(%rax), %rcx
               	shrq	%rcx
               	xorl	%eax, %eax
               	leaq	0xa(%rax), %rdx
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi,%rdx)
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
               	leaq	-0x40(%rbp), %rsi
               	movq	%rcx, %rdi
               	imulq	%rdx, %rdi
               	shrq	$0x10, %rdi
               	xorl	%eax, %eax
               	leaq	0xc(%rax), %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rdi, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rsi,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rsi
               	leaq	(%rcx,%rdx), %rax
               	leaq	0x1(%rax), %rcx
               	shrq	%rcx
               	xorl	%eax, %eax
               	leaq	0xc(%rax), %rdx
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi,%rdx)
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
               	leaq	-0x40(%rbp), %rsi
               	movq	%rcx, %rdi
               	imulq	%rdx, %rdi
               	shrq	$0x10, %rdi
               	xorl	%eax, %eax
               	leaq	0xe(%rax), %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rdi, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rsi,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rsi
               	leaq	(%rcx,%rdx), %rax
               	leaq	0x1(%rax), %rcx
               	shrq	%rcx
               	xorl	%eax, %eax
               	leaq	0xe(%rax), %rdx
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi,%rdx)
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
               	leaq	-0xe0(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xd0(%rbp), %rcx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xc0(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pmulhuw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x50(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %r13d
               	leaq	-0xb0(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xa0(%rbp), %rcx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x90(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pavgb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0x50(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x80(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x70(%rbp), %rcx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x60(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pavgw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x50(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
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
               	xorl	%r13d, %r13d
               	jmp	<addr>

<check_count_shifts>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1a8, %rsp            # imm = 0x1A8
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, 0x190(%rsp)
               	xorl	%r10d, %r10d
               	movq	%r10, 0x198(%rsp)
               	movq	0x198(%rsp), %r15
               	leaq	-0x28(%rbp), %rax
               	movq	0x190(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rax)
               	leaq	<rip>, %rax # <addr>
               	movq	0x198(%rsp), %r10
               	movq	(%rax,%r10,8), %rax
               	leaq	-0x110(%rbp), %rcx
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x1a0(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x190(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movups	%xmm14, 0x20(%rcx)
               	movups	%xmm14, 0x30(%rcx)
               	movups	%xmm14, 0x40(%rcx)
               	movups	%xmm14, 0x50(%rcx)
               	movups	%xmm14, 0x60(%rcx)
               	movups	%xmm14, 0x70(%rcx)
               	leaq	-0x100(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %edx
               	leaq	-0xf0(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movq	%rdx, %xmm14
               	psllw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	-0xf0(%rbp), %xmm0
               	movups	%xmm0, -0x190(%rbp)
               	leaq	-0x1a0(%rbp), %rdx
               	leaq	-0xe0(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %edx
               	leaq	-0xd0(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movq	%rdx, %xmm14
               	pslld	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	-0xd0(%rbp), %xmm0
               	movups	%xmm0, -0x180(%rbp)
               	leaq	-0x1a0(%rbp), %rdx
               	leaq	-0x100(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %edx
               	leaq	-0xc0(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movq	%rdx, %xmm14
               	psllq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	-0xc0(%rbp), %xmm0
               	movups	%xmm0, -0x170(%rbp)
               	leaq	-0x1a0(%rbp), %rdx
               	leaq	-0xe0(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %edx
               	leaq	-0xb0(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movq	%rdx, %xmm14
               	psrlw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	-0xb0(%rbp), %xmm0
               	movups	%xmm0, -0x160(%rbp)
               	leaq	-0x1a0(%rbp), %rdx
               	leaq	-0x100(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %edx
               	leaq	-0xa0(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movq	%rdx, %xmm14
               	psrld	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	-0xa0(%rbp), %xmm0
               	movups	%xmm0, -0x150(%rbp)
               	leaq	-0x1a0(%rbp), %rdx
               	leaq	-0xe0(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %edx
               	leaq	-0x90(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movq	%rdx, %xmm14
               	psrlq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	-0x90(%rbp), %xmm0
               	movups	%xmm0, -0x140(%rbp)
               	leaq	-0x1a0(%rbp), %rdx
               	leaq	-0x100(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %edx
               	leaq	-0x80(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movq	%rdx, %xmm14
               	psraw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	-0x80(%rbp), %xmm0
               	movups	%xmm0, -0x130(%rbp)
               	leaq	-0x1a0(%rbp), %rdx
               	leaq	-0xe0(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x40, %eax
               	leaq	-0x70(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movq	%rax, %xmm14
               	psrad	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	-0x70(%rbp), %xmm0
               	movups	%xmm0, -0x120(%rbp)
               	xorl	%r14d, %r14d
               	leaq	<rip>, %rax # <addr>
               	movq	%r14, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %r13d
               	leaq	<rip>, %rax # <addr>
               	movq	0x198(%rsp), %r10
               	movq	(%rax,%r10,8), %r12
               	leaq	-0x20(%rbp), %rdi
               	xorl	%r8d, %r8d
               	movl	$0x10, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r8d
               	jge	<addr>
               	cmpl	$0x2, %r13d
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%edx, %edx
               	leaq	-0x1(%rcx), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rdx
               	movq	%rcx, %r9
               	imulq	%r8, %r9
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	movzbq	(%rbx,%r9), %r9
               	orq	%r9, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	testq	%rsi, %rsi
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
               	movq	%rcx, %r9
               	shlq	$0x3, %r9
               	movslq	%r9d, %r9
               	shlxq	%r9, %rax, %rax
               	orq	%rax, %rdx
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	movslq	%eax, %rsi
               	testl	%r13d, %r13d
               	jne	<addr>
               	cmpq	%rsi, %r12
               	jb	<addr>
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	cmpl	%ecx, %eax
               	jge	<addr>
               	movq	%rcx, %r9
               	imulq	%r8, %r9
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	movslq	%esi, %rsi
               	shrxq	%rsi, %rdx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdi,%r9)
               	incq	%rax
               	cmpl	%ecx, %eax
               	jge	<addr>
               	jmp	<addr>
               	shlxq	%r12, %rdx, %rdx
               	jmp	<addr>
               	cmpl	$0x1, %r13d
               	jne	<addr>
               	cmpq	%rsi, %r12
               	jb	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	shrxq	%r12, %rdx, %rdx
               	jmp	<addr>
               	xorl	%edx, %edx
               	leaq	-0x1(%rcx), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rdx
               	movq	%rcx, %r9
               	imulq	%r8, %r9
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	movzbq	(%rbx,%r9), %r9
               	orq	%r9, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
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
               	movq	%rcx, %r9
               	shlq	$0x3, %r9
               	movslq	%r9d, %r9
               	shlxq	%r9, %rax, %rax
               	orq	%rax, %rdx
               	cmpq	%rsi, %r12
               	jb	<addr>
               	leaq	-0x1(%rsi), %rax
               	movslq	%eax, %rax
               	sarxq	%rax, %rdx, %rdx
               	jmp	<addr>
               	movslq	%r12d, %rax
               	jmp	<addr>
               	incq	%r8
               	movl	$0x10, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r8d
               	jl	<addr>
               	leaq	-0x190(%rbp), %rax
               	movq	%r14, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rax
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x60(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x60(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %r15d
               	incq	%r14
               	cmpl	$0x8, %r14d
               	jge	<addr>
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	0x198(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0x198(%rsp)
               	movq	0x198(%rsp), %rax
               	cmpl	$0x12, %eax
               	jb	<addr>
               	movq	%r15, %rax
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
               	subq	$0x170, %rsp            # imm = 0x170
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rcx
               	movzbq	(%rbx,%rax), %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x170(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x160(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x0, %xmm15            # xmm15 = xmm15[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x30(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %r12d
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rcx
               	movzbq	(%rbx,%rax), %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x150(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x140(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	psrldq	$0x0, %xmm15            # xmm15 = xmm15[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x30(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %r12d
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	-0x20(%rbp), %rsi
               	cmpl	$0x1, %eax
               	jl	<addr>
               	leaq	-0x1(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	movb	%dl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x130(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x120(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x1, %xmm15            # xmm15 = zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x30(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %r12d
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	leaq	-0x20(%rbp), %rdi
               	leaq	0x1(%rax), %rcx
               	cmpl	$0x10, %ecx
               	jge	<addr>
               	movzbq	(%rbx,%rcx), %rsi
               	jmp	<addr>
               	movq	%rdx, %rsi
               	movb	%sil, (%rdi,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x110(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x100(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	psrldq	$0x1, %xmm15            # xmm15 = xmm15[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],zero
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x30(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %r12d
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	-0x20(%rbp), %rsi
               	cmpl	$0x9, %eax
               	jl	<addr>
               	leaq	-0x9(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	movb	%dl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xf0(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xe0(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x9, %xmm15            # xmm15 = zero,zero,zero,zero,zero,zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6]
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x30(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %r12d
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	-0x20(%rbp), %rsi
               	leaq	0x9(%rax), %rdx
               	cmpl	$0x10, %edx
               	jge	<addr>
               	movzbq	(%rbx,%rdx), %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	movb	%dl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xd0(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xc0(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	psrldq	$0x9, %xmm15            # xmm15 = xmm15[9,10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x30(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %r12d
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	-0x20(%rbp), %rsi
               	cmpl	$0xf, %eax
               	jl	<addr>
               	movzbq	(%rbx), %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	movb	%dl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xb0(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xa0(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0xf, %xmm15            # xmm15 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,xmm15[0]
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x30(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %r12d
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	-0x20(%rbp), %rsi
               	leaq	0xf(%rax), %rdx
               	cmpl	$0x10, %edx
               	jge	<addr>
               	movzbq	0xf(%rbx), %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	movb	%dl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x90(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	psrldq	$0xf, %xmm15            # xmm15 = xmm15[15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x30(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %r12d
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	-0x20(%rbp), %rdx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x70(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x60(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x10, %xmm15           # xmm15 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x30(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %r12d
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	-0x20(%rbp), %rdx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	psrldq	$0x10, %xmm15           # xmm15 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x30(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %r12d
               	movq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%r12d, %r12d
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2b8, %rsp            # imm = 0x2B8
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r14d, %r14d
               	movq	%r14, %rbx
               	leaq	-0xd8(%rbp), %rdx
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
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xc8(%rbp), %rdx
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
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xd8(%rbp), %rdi
               	leaq	-0xc8(%rbp), %rsi
               	callq	<addr>
               	movq	%rbx, %r15
               	orq	%rax, %r15
               	leaq	-0xd8(%rbp), %rdi
               	leaq	-0xc8(%rbp), %r8
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movzbq	(%rdi,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	testb	$0x1, %al
               	je	<addr>
               	orq	$-0x10000, %rcx         # imm = 0xFFFF0000
               	xorl	%esi, %esi
               	movl	$0x1, %eax
               	shlq	$0x8, %rsi
               	movq	%rdx, %r9
               	shlq	%r9
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	movzbq	(%r8,%r9), %r9
               	orq	%r9, %rsi
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rsi, %rax
               	shrq	$0xf, %rax
               	testb	$0x1, %al
               	je	<addr>
               	orq	$-0x10000, %rsi         # imm = 0xFFFF0000
               	leaq	-0xb8(%rbp), %rbx
               	cmpq	%rsi, %rcx
               	jge	<addr>
               	movq	%rcx, %r9
               	xorl	%eax, %eax
               	movq	%rdx, %r12
               	shlq	%r12
               	addq	%rax, %r12
               	movslq	%r12d, %r12
               	movq	%rax, %r13
               	shlq	$0x3, %r13
               	shrxq	%r13, %r9, %r13
               	andq	$0xff, %r13
               	movb	%r13b, (%rbx,%r12)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0xa8(%rbp), %r9
               	cmpq	%rsi, %rcx
               	jle	<addr>
               	xorl	%eax, %eax
               	movq	%rdx, %rsi
               	shlq	%rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %rbx
               	shlq	$0x3, %rbx
               	shrxq	%rbx, %rcx, %rbx
               	andq	$0xff, %rbx
               	movb	%bl, (%r9,%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	jmp	<addr>
               	movq	%rsi, %rcx
               	jmp	<addr>
               	movq	%rsi, %r9
               	jmp	<addr>
               	incq	%rdx
               	cmpl	$0x8, %edx
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x98(%rbp), %rdx
               	movzbq	(%rdi,%rax), %rcx
               	movzbq	(%r8,%rax), %rsi
               	cmpl	%esi, %ecx
               	jge	<addr>
               	movzbq	(%rdi,%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	leaq	-0x88(%rbp), %rdx
               	movzbq	(%rdi,%rax), %rcx
               	movzbq	(%r8,%rax), %rsi
               	cmpl	%esi, %ecx
               	jle	<addr>
               	movzbq	(%rdi,%rax), %rcx
               	jmp	<addr>
               	movzbq	(%r8,%rax), %rcx
               	jmp	<addr>
               	movzbq	(%r8,%rax), %rcx
               	jmp	<addr>
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x290(%rbp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x2b0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x280(%rbp), %rax
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x2a0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x270(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pminsw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xb8(%rbp), %rsi
               	leaq	-0x230(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x48(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x2b0(%rbp), %rcx
               	leaq	-0x2a0(%rbp), %rdx
               	leaq	-0x260(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pmaxsw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xa8(%rbp), %rsi
               	leaq	-0x230(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x48(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x2b0(%rbp), %rcx
               	leaq	-0x2a0(%rbp), %rdx
               	leaq	-0x250(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pminub	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x98(%rbp), %rsi
               	leaq	-0x230(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x48(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x2b0(%rbp), %rcx
               	leaq	-0x2a0(%rbp), %rdx
               	leaq	-0x240(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pmaxub	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x88(%rbp), %rsi
               	leaq	-0x230(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x48(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	movq	%r15, %rbx
               	orq	%rax, %rbx
               	leaq	-0xd8(%rbp), %rdi
               	leaq	-0xc8(%rbp), %rsi
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0xd8(%rbp), %rdi
               	callq	<addr>
               	movq	%rbx, %r15
               	orq	%rax, %r15
               	leaq	-0xd8(%rbp), %r13
               	leaq	-0xc8(%rbp), %rbx
               	xorl	%r12d, %r12d
               	leaq	-0x78(%rbp), %rdx
               	movq	%r12, %rax
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
               	leaq	<rip>, %rax # <addr>
               	leaq	-0x78(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x200(%rbp), %rax
               	movups	(%r13), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x1f0(%rbp), %rdx
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x3, %rcx
               	leaq	-0x1d0(%rbp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0x1c0(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x1d0(%rbp), %rax
               	leaq	-0x1b0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x1c0(%rbp), %rax
               	leaq	-0x1a0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	leaq	-0x1a0(%rbp), %rdx
               	movsbq	(%rdx,%rax), %rdx
               	testb	$-0x80, %dl
               	je	<addr>
               	leaq	-0x1b0(%rbp), %rdx
               	movsbq	(%rdx,%rax), %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x58(%rbp), %rax
               	leaq	-0x78(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	xorl	%eax, %eax
               	movzbq	(%rbx,%rax), %rcx
               	testb	$-0x80, %cl
               	je	<addr>
               	leaq	-0x58(%rbp), %rcx
               	leaq	0x3(%rax), %rdx
               	movzbq	(%r13,%rax), %rsi
               	movb	%sil, (%rcx,%rdx)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	-0x58(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x20, %r12d
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, %r10
               	clflush	(%r10)
               	leaq	<rip>, %rax # <addr>
               	addq	$0x3f, %rax
               	movq	%rax, %r10
               	clflush	(%r10)
               	leaq	<rip>, %rdi # <addr>
               	leaq	-0x58(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x20, %r12d
               	leaq	-0x220(%rbp), %rax
               	leaq	0x10(%rax), %rcx
               	leaq	-0x1e0(%rbp), %rax
               	movups	(%r13), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x190(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x190(%rbp), %rax
               	leaq	-0x2a0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x2a0(%rbp), %rax
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	xorl	%ecx, %ecx
               	movl	%ecx, -0x38(%rbp)
               	movq	%rcx, -0xe0(%rbp)
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
               	testb	$0x1, %al
               	je	<addr>
               	movabsq	$-0x100000000, %r11     # imm = 0xFFFFFFFF00000000
               	orq	%r11, %rcx
               	movl	%ecx, -0x38(%rbp)
               	xorl	%ecx, %ecx
               	movl	$0x7, %eax
               	shlq	$0x8, %rcx
               	leaq	0x8(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, -0xe0(%rbp)
               	leaq	-0x220(%rbp), %rax
               	leaq	0x10(%rax), %rcx
               	leaq	-0x180(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x88(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x88(%rbp), %rdi
               	movl	$0x10, %edx
               	movq	%r13, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x38(%rbp), %esi
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
               	testb	$0x1, %al
               	je	<addr>
               	movabsq	$-0x100000000, %r11     # imm = 0xFFFFFFFF00000000
               	orq	%r11, %rcx
               	cmpl	%ecx, %esi
               	jne	<addr>
               	movq	-0xe0(%rbp), %rsi
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
               	movl	$0x20, %r12d
               	movq	%r15, %r13
               	orq	%r12, %r13
               	leaq	-0xd8(%rbp), %r12
               	leaq	-0x98(%rbp), %rax
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
               	leaq	-0x88(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x8(%r12), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	xorps	%xmm14, %xmm14
               	cvtsi2ss	%rbx, %xmm14
               	movsd	%xmm14, 0x1f8(%rsp)
               	leaq	-0x170(%rbp), %rax
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rax)
               	movq	-0x170(%rbp), %rax
               	leaq	-0x120(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%rax, -0x120(%rbp)
               	movq	$0x0, -0x118(%rbp)
               	movups	-0x120(%rbp), %xmm0
               	leaq	-0x98(%rbp), %rsi
               	leaq	-0x110(%rbp), %rax
               	movups	%xmm0, -0x110(%rbp)
               	leaq	-0x48(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x48(%rbp), %rdi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x88(%rbp), %rsi
               	leaq	-0x110(%rbp), %rcx
               	movq	%rbx, -0x110(%rbp)
               	movq	$0x0, -0x108(%rbp)
               	leaq	-0x48(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x48(%rbp), %rdi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x160(%rbp), %rax
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rax)
               	movq	-0x160(%rbp), %rsi
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
               	leaq	-0x150(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0xc0200000, -0x150(%rbp) # imm = 0xC0200000
               	movl	$0x0, -0x14c(%rbp)
               	movl	$0x0, -0x148(%rbp)
               	leaq	-0x150(%rbp), %rcx
               	movl	$0x0, -0x144(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	cvtss2si	%xmm14, %r11
               	movq	%r11, (%rdx)
               	movq	-0x10(%rbp), %rcx
               	cmpq	$-0x2, %rcx
               	jne	<addr>
               	leaq	-0x140(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0xc0300000, -0x140(%rbp) # imm = 0xC0300000
               	movl	$0x0, -0x13c(%rbp)
               	leaq	-0x140(%rbp), %rcx
               	movl	$0x0, -0x138(%rbp)
               	movl	$0x0, -0x134(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	cvttss2si	%xmm14, %r11
               	movq	%r11, (%rax)
               	movq	-0x8(%rbp), %rax
               	cmpq	$-0x2, %rax
               	jne	<addr>
               	movq	$0x0, -0x100(%rbp)
               	movq	$0x0, -0xf8(%rbp)
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rbx, %xmm0
               	movss	%xmm0, -0x100(%rbp)
               	movups	-0x100(%rbp), %xmm0
               	movups	%xmm0, -0x130(%rbp)
               	movss	-0x130(%rbp), %xmm0
               	movsd	0x1f8(%rsp), %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x40, %eax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movq	%r13, %rbx
               	orq	%rax, %rbx
               	incq	%r14
               	cmpl	$0x12c, %r14d           # imm = 0x12C
               	jl	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
