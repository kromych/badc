
sse_floating_lanes_follow_the_sdm.x64:	file format elf64-x86-64

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

<rnd_d>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x61c8864680b583eb, %r11 # imm = 0x9E3779B97F4A7C15
               	imulq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x3c, %rcx
               	cmpl	$0x5, %ecx
               	jae	<addr>
               	leaq	<rip>, %rcx # <addr>
               	shrq	$0x20, %rax
               	movl	$0xba2e8ba3, %edx       # imm = 0xBA2E8BA3
               	imulq	%rax, %rdx
               	shrq	$0x23, %rdx
               	imulq	$0xb, %rdx, %rdx
               	subq	%rdx, %rax
               	movq	(%rcx,%rax,8), %rax
               	movq	%rax, -0x10(%rbp)
               	movabsq	$0x7ff0000000000000, %rcx # imm = 0x7FF0000000000000
               	andq	%rax, %rcx
               	movabsq	$0x7ff0000000000000, %r11 # imm = 0x7FF0000000000000
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movabsq	$0xfffffffffffff, %rcx  # imm = 0xFFFFFFFFFFFFF
               	andq	%rax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movabsq	$0x8000000000000, %r11  # imm = 0x8000000000000
               	orq	%r11, %rax
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	-0x8(%rbp), %xmm0
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x61c8864680b583eb, %r11 # imm = 0x9E3779B97F4A7C15
               	imulq	%r11, %rax
               	jmp	<addr>

<singles>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	movups	%xmm0, -0x100(%rbp)
               	movups	%xmm1, -0xf0(%rbp)
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	addps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	subps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	mulps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	divps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	addss	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	subss	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	mulss	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	divss	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	sqrtps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	movdqu	(%rcx), %xmm15
               	sqrtss	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x68(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x68(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	minps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	maxps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	minss	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	maxss	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x68(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x68(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	cmpeqps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	cmpltps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	cmpleps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rcx), %xmm14
               	cmpltps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rcx), %xmm14
               	cmpleps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	cmpneqps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	cmpnltps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	cmpnleps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rcx), %xmm14
               	cmpnltps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rcx), %xmm14
               	cmpnleps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	cmpordps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	cmpunordps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	cmpeqss	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	cmpltss	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xa0(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xe0(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x90(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	cmpltss	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0xd0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movl	-0x90(%rbp), %eax
               	movl	%eax, -0xd0(%rbp)
               	movups	-0xd0(%rbp), %xmm0
               	leaq	-0xd0(%rbp), %rdx
               	movups	%xmm0, -0xd0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xa0(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xe0(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	cmpnless	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0xd0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movl	-0x80(%rbp), %eax
               	movl	%eax, -0xd0(%rbp)
               	movups	-0xd0(%rbp), %xmm0
               	leaq	-0xd0(%rbp), %rdx
               	movups	%xmm0, -0xd0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	cmpunordss	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x68(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x68(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	movss	-0x100(%rbp), %xmm0
               	movss	-0xf0(%rbp), %xmm1
               	comiss	%xmm0, %xmm1
               	jb	<addr>
               	movss	-0x100(%rbp), %xmm0
               	movss	-0xf0(%rbp), %xmm1
               	comiss	%xmm1, %xmm0
               	setae	%cl
               	movzbq	%cl, %rcx
               	movl	%ecx, -0x68(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x68(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movss	-0x100(%rbp), %xmm0
               	movss	-0xf0(%rbp), %xmm1
               	comiss	%xmm0, %xmm1
               	seta	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x68(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x68(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movss	-0x100(%rbp), %xmm0
               	movss	-0xf0(%rbp), %xmm1
               	comiss	%xmm0, %xmm1
               	setae	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x68(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x68(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movss	-0x100(%rbp), %xmm0
               	movss	-0xf0(%rbp), %xmm1
               	comiss	%xmm1, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x68(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x68(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movss	-0x100(%rbp), %xmm0
               	movss	-0xf0(%rbp), %xmm1
               	comiss	%xmm1, %xmm0
               	setae	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x68(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x68(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	xorl	%eax, %eax
               	movss	-0x100(%rbp), %xmm0
               	movss	-0xf0(%rbp), %xmm1
               	comiss	%xmm0, %xmm1
               	jb	<addr>
               	movss	-0x100(%rbp), %xmm0
               	movss	-0xf0(%rbp), %xmm1
               	comiss	%xmm1, %xmm0
               	setae	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	%ecx, -0x68(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x68(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x68(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x68(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movss	-0x100(%rbp), %xmm0
               	movss	-0xf0(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	movl	%eax, -0x68(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x68(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movss	-0x100(%rbp), %xmm0
               	movss	-0xf0(%rbp), %xmm1
               	ucomiss	%xmm0, %xmm1
               	seta	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x68(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x68(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movss	-0x100(%rbp), %xmm0
               	movss	-0xf0(%rbp), %xmm1
               	ucomiss	%xmm0, %xmm1
               	setae	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x68(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x68(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movss	-0x100(%rbp), %xmm0
               	movss	-0xf0(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x68(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x68(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movss	-0x100(%rbp), %xmm0
               	movss	-0xf0(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setae	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x68(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x68(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movss	-0x100(%rbp), %xmm0
               	movss	-0xf0(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	movl	%eax, -0x68(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x68(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x68(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x68(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x100(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	cvtss2si	%xmm14, %r11d
               	movl	%r11d, (%rcx)
               	movl	-0x20(%rbp), %eax
               	movl	%eax, -0x68(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x68(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	cvttss2si	%xmm14, %r11d
               	movl	%r11d, (%rcx)
               	movl	-0x18(%rbp), %eax
               	movl	%eax, -0x68(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x68(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	cvtss2si	%xmm14, %r11
               	movq	%r11, (%rcx)
               	movq	-0x10(%rbp), %rax
               	movq	%rax, -0x68(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x68(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	cvttss2si	%xmm14, %r11
               	movq	%r11, (%rcx)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, -0x68(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x68(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rdx
               	shrq	$0xc, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdx
               	shlq	$0x19, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdx
               	shrq	$0x1b, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x61c8864680b583eb, %r11 # imm = 0x9E3779B97F4A7C15
               	imulq	%r11, %rax
               	movslq	%eax, %rax
               	leaq	-0xd0(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	%xmm0, -0xd0(%rbp)
               	movups	-0xd0(%rbp), %xmm0
               	leaq	-0xd0(%rbp), %rdx
               	movups	%xmm0, -0xd0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rdx
               	shrq	$0xc, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdx
               	shlq	$0x19, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdx
               	shrq	$0x1b, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x61c8864680b583eb, %r11 # imm = 0x9E3779B97F4A7C15
               	imulq	%r11, %rax
               	leaq	-0xd0(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	%xmm0, -0xd0(%rbp)
               	movups	-0xd0(%rbp), %xmm0
               	leaq	-0xd0(%rbp), %rdx
               	movups	%xmm0, -0xd0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	cvtps2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	cvttps2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0xe0(%rbp), %rcx
               	movups	-0x100(%rbp), %xmm0
               	movups	%xmm0, -0xe0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	cvtdq2ps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xc0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	cvtps2pd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xb0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x68(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x68(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	-0x100(%rbp), %eax
               	movl	-0xf8(%rbp), %ecx
               	movl	-0xec(%rbp), %edx
               	movl	-0xe4(%rbp), %esi
               	leaq	-0xd0(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	%ecx, -0xd0(%rbp)
               	movl	%eax, -0xcc(%rbp)
               	movl	%esi, -0xc8(%rbp)
               	movl	%edx, -0xc4(%rbp)
               	movups	-0xd0(%rbp), %xmm0
               	leaq	-0xd0(%rbp), %rdx
               	movups	%xmm0, -0xd0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	-0x100(%rbp), %eax
               	movl	-0xfc(%rbp), %ecx
               	movl	-0xf0(%rbp), %edx
               	movl	-0xec(%rbp), %esi
               	leaq	-0xd0(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	%eax, -0xd0(%rbp)
               	movl	%edx, -0xcc(%rbp)
               	movl	%ecx, -0xc8(%rbp)
               	movl	%esi, -0xc4(%rbp)
               	movups	-0xd0(%rbp), %xmm0
               	leaq	-0xd0(%rbp), %rdx
               	movups	%xmm0, -0xd0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	-0xf8(%rbp), %eax
               	movl	-0xf4(%rbp), %ecx
               	movl	-0xe8(%rbp), %edx
               	movl	-0xe4(%rbp), %esi
               	leaq	-0xd0(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	%eax, -0xd0(%rbp)
               	movl	%edx, -0xcc(%rbp)
               	movl	%ecx, -0xc8(%rbp)
               	movl	%esi, -0xc4(%rbp)
               	movups	-0xd0(%rbp), %xmm0
               	leaq	-0xd0(%rbp), %rdx
               	movups	%xmm0, -0xd0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	-0xf8(%rbp), %eax
               	movl	-0xf4(%rbp), %ecx
               	movl	-0xe8(%rbp), %edx
               	movl	-0xe4(%rbp), %esi
               	leaq	-0xd0(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	%edx, -0xd0(%rbp)
               	movl	%esi, -0xcc(%rbp)
               	movl	%eax, -0xc8(%rbp)
               	movl	%ecx, -0xc4(%rbp)
               	movups	-0xd0(%rbp), %xmm0
               	leaq	-0xd0(%rbp), %rdx
               	movups	%xmm0, -0xd0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	-0x100(%rbp), %eax
               	movl	-0xfc(%rbp), %ecx
               	movl	-0xf0(%rbp), %edx
               	movl	-0xec(%rbp), %esi
               	leaq	-0xd0(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	%eax, -0xd0(%rbp)
               	movl	%ecx, -0xcc(%rbp)
               	movl	%edx, -0xc8(%rbp)
               	movl	%esi, -0xc4(%rbp)
               	movups	-0xd0(%rbp), %xmm0
               	leaq	-0xd0(%rbp), %rdx
               	movups	%xmm0, -0xd0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	-0xfc(%rbp), %eax
               	movq	-0xf8(%rbp), %rcx
               	movl	-0xf0(%rbp), %esi
               	leaq	-0xd0(%rbp), %rdx
               	movl	%esi, -0xd0(%rbp)
               	movl	%eax, -0xcc(%rbp)
               	movq	%rcx, -0xc8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	-0x100(%rbp), %eax
               	movl	-0xfc(%rbp), %ecx
               	movl	-0xf8(%rbp), %edx
               	movl	-0xf4(%rbp), %esi
               	testl	%eax, %eax
               	setl	%al
               	movzbq	%al, %rax
               	testl	%ecx, %ecx
               	setl	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	orq	%rcx, %rax
               	testl	%edx, %edx
               	setl	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x2, %rcx
               	orq	%rcx, %rax
               	testl	%esi, %esi
               	setl	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x3, %rcx
               	orq	%rcx, %rax
               	movl	%eax, -0x68(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x68(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x70(%rbp), %rcx
               	movl	-0x100(%rbp), %eax
               	movl	-0xfc(%rbp), %edx
               	movl	-0xf8(%rbp), %esi
               	movl	-0xf4(%rbp), %edi
               	leaq	-0xe0(%rbp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movl	%edi, -0xe0(%rbp)
               	movl	%esi, -0xdc(%rbp)
               	leaq	-0xe0(%rbp), %rsi
               	movl	%edx, -0xd8(%rbp)
               	movl	%eax, -0xd4(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	-0x70(%rbp), %xmm0
               	leaq	-0xd0(%rbp), %rdx
               	movups	%xmm0, -0xd0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	-0x6c(%rbp), %ecx
               	xorl	%eax, %eax
               	leaq	-0xd0(%rbp), %rdx
               	movl	%ecx, -0xd0(%rbp)
               	movl	%eax, -0xcc(%rbp)
               	movl	%eax, -0xc8(%rbp)
               	movl	%eax, -0xc4(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	-0x68(%rbp), %eax
               	leaq	-0xd0(%rbp), %rdx
               	movl	%eax, -0xd0(%rbp)
               	movl	%eax, -0xcc(%rbp)
               	movl	%eax, -0xc8(%rbp)
               	movl	%eax, -0xc4(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	-0xf0(%rbp), %eax
               	movl	%eax, -0x70(%rbp)
               	movups	-0x70(%rbp), %xmm0
               	movups	%xmm0, -0xe0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	-0xd4(%rbp), %eax
               	movl	%eax, -0xd0(%rbp)
               	movl	-0xd8(%rbp), %eax
               	movl	%eax, -0xcc(%rbp)
               	movl	-0xdc(%rbp), %eax
               	movl	%eax, -0xc8(%rbp)
               	movl	-0xe0(%rbp), %eax
               	movl	%eax, -0xc4(%rbp)
               	movups	-0xd0(%rbp), %xmm0
               	leaq	-0xd0(%rbp), %rdx
               	movups	%xmm0, -0xd0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movss	-0xf0(%rbp), %xmm0
               	movss	%xmm0, -0x68(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x68(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<doubles>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x150, %rsp            # imm = 0x150
               	movups	%xmm0, -0x150(%rbp)
               	movups	%xmm1, -0x140(%rbp)
               	movups	%xmm2, -0x130(%rbp)
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	addpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	subpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	mulpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	divpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	addsd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	subsd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	mulsd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	divsd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	sqrtpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x120(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xc0(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	movdqu	(%rcx), %xmm15
               	sqrtsd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x110(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	-0xc0(%rbp), %rax
               	movq	%rax, -0x110(%rbp)
               	movups	-0x110(%rbp), %xmm0
               	leaq	-0x110(%rbp), %rdx
               	movups	%xmm0, -0x110(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x88(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x88(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	minpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	maxpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	minsd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	maxsd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x88(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x88(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	cmpeqpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	cmpltpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	cmplepd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rcx), %xmm14
               	cmpltpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rcx), %xmm14
               	cmplepd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	cmpneqpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	cmpnltpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	cmpnlepd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rcx), %xmm14
               	cmpnltpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rcx), %xmm14
               	cmpnlepd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	cmpordpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	cmpunordpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	cmpeqsd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	cmplesd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x120(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xb0(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	cmplesd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x110(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	-0xb0(%rbp), %rax
               	movq	%rax, -0x110(%rbp)
               	movups	-0x110(%rbp), %xmm0
               	leaq	-0x110(%rbp), %rdx
               	movups	%xmm0, -0x110(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x120(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xa0(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	cmpnltsd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x110(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	-0xa0(%rbp), %rax
               	movq	%rax, -0x110(%rbp)
               	movups	-0x110(%rbp), %xmm0
               	leaq	-0x110(%rbp), %rdx
               	movups	%xmm0, -0x110(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	cmpordsd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x88(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x88(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	movsd	-0x150(%rbp), %xmm0
               	movsd	-0x140(%rbp), %xmm1
               	comisd	%xmm0, %xmm1
               	jb	<addr>
               	movsd	-0x150(%rbp), %xmm0
               	movsd	-0x140(%rbp), %xmm1
               	comisd	%xmm1, %xmm0
               	setae	%cl
               	movzbq	%cl, %rcx
               	movl	%ecx, -0x88(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x88(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movsd	-0x150(%rbp), %xmm0
               	movsd	-0x140(%rbp), %xmm1
               	comisd	%xmm0, %xmm1
               	seta	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x88(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x88(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movsd	-0x150(%rbp), %xmm0
               	movsd	-0x140(%rbp), %xmm1
               	comisd	%xmm1, %xmm0
               	setae	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x88(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x88(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	xorl	%eax, %eax
               	movsd	-0x150(%rbp), %xmm0
               	movsd	-0x140(%rbp), %xmm1
               	comisd	%xmm0, %xmm1
               	jb	<addr>
               	movsd	-0x150(%rbp), %xmm0
               	movsd	-0x140(%rbp), %xmm1
               	comisd	%xmm1, %xmm0
               	setae	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	%ecx, -0x88(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x88(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x88(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x88(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	-0x150(%rbp), %xmm0
               	movsd	-0x140(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	movl	%eax, -0x88(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x88(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movsd	-0x150(%rbp), %xmm0
               	movsd	-0x140(%rbp), %xmm1
               	ucomisd	%xmm0, %xmm1
               	setae	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x88(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x88(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movsd	-0x150(%rbp), %xmm0
               	movsd	-0x140(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x88(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x88(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movsd	-0x150(%rbp), %xmm0
               	movsd	-0x140(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	movl	%eax, -0x88(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x88(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x88(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x88(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x150(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	cvtsd2si	%xmm14, %r11d
               	movl	%r11d, (%rcx)
               	movl	-0x20(%rbp), %eax
               	movl	%eax, -0x88(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x88(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	cvttsd2si	%xmm14, %r11d
               	movl	%r11d, (%rcx)
               	movl	-0x18(%rbp), %eax
               	movl	%eax, -0x88(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x88(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	cvtsd2si	%xmm14, %r11
               	movq	%r11, (%rcx)
               	movq	-0x10(%rbp), %rax
               	movq	%rax, -0x88(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x88(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	cvttsd2si	%xmm14, %r11
               	movq	%r11, (%rcx)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, -0x88(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x88(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rdx
               	shrq	$0xc, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdx
               	shlq	$0x19, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdx
               	shrq	$0x1b, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x61c8864680b583eb, %r11 # imm = 0x9E3779B97F4A7C15
               	imulq	%r11, %rax
               	movslq	%eax, %rax
               	leaq	-0x110(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movsd	%xmm0, -0x110(%rbp)
               	movups	-0x110(%rbp), %xmm0
               	leaq	-0x110(%rbp), %rdx
               	movups	%xmm0, -0x110(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rdx
               	shrq	$0xc, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdx
               	shlq	$0x19, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdx
               	shrq	$0x1b, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x61c8864680b583eb, %r11 # imm = 0x9E3779B97F4A7C15
               	imulq	%r11, %rax
               	leaq	-0x110(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movsd	%xmm0, -0x110(%rbp)
               	movups	-0x110(%rbp), %xmm0
               	leaq	-0x110(%rbp), %rdx
               	movups	%xmm0, -0x110(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	cvtpd2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	cvttpd2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x120(%rbp), %rcx
               	movups	-0x140(%rbp), %xmm0
               	movups	%xmm0, -0x120(%rbp)
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	cvtdq2pd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x100(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	cvtpd2ps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xf0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x130(%rbp), %rax
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x110(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movsd	-0x110(%rbp), %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, -0x120(%rbp)
               	movups	-0x120(%rbp), %xmm0
               	leaq	-0x110(%rbp), %rdx
               	movups	%xmm0, -0x110(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rax
               	leaq	-0x130(%rbp), %rcx
               	leaq	-0x120(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x110(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movss	-0x110(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movsd	%xmm0, -0x120(%rbp)
               	movups	-0x120(%rbp), %xmm0
               	leaq	-0x110(%rbp), %rdx
               	movups	%xmm0, -0x110(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x88(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x88(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	-0x150(%rbp), %rax
               	movq	-0x140(%rbp), %rcx
               	leaq	-0x110(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rax, -0x110(%rbp)
               	movq	%rcx, -0x108(%rbp)
               	movups	-0x110(%rbp), %xmm0
               	leaq	-0x110(%rbp), %rdx
               	movups	%xmm0, -0x110(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	-0x148(%rbp), %rax
               	movq	-0x138(%rbp), %rcx
               	leaq	-0x110(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rax, -0x110(%rbp)
               	movq	%rcx, -0x108(%rbp)
               	movups	-0x110(%rbp), %xmm0
               	leaq	-0x110(%rbp), %rdx
               	movups	%xmm0, -0x110(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	-0x148(%rbp), %rax
               	movq	-0x140(%rbp), %rcx
               	leaq	-0x110(%rbp), %rdx
               	movq	%rcx, -0x110(%rbp)
               	movq	%rax, -0x108(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	-0x150(%rbp), %rax
               	movq	-0x148(%rbp), %rcx
               	testq	%rax, %rax
               	setl	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	orq	%rcx, %rax
               	movl	%eax, -0x88(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x88(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x90(%rbp), %rdx
               	movq	-0x150(%rbp), %rcx
               	movq	-0x148(%rbp), %rsi
               	leaq	-0x120(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rsi, -0x120(%rbp)
               	movq	%rcx, -0x118(%rbp)
               	leaq	-0x110(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	-0x90(%rbp), %xmm0
               	leaq	-0x110(%rbp), %rdx
               	movups	%xmm0, -0x110(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x140(%rbp), %rcx
               	leaq	-0x120(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x110(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	-0x90(%rbp), %rax
               	movq	%rax, -0x108(%rbp)
               	movups	-0x110(%rbp), %xmm0
               	leaq	-0x110(%rbp), %rdx
               	movups	%xmm0, -0x110(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	-0x138(%rbp), %rax
               	movq	-0x88(%rbp), %rcx
               	leaq	-0x110(%rbp), %rdx
               	movq	%rcx, -0x110(%rbp)
               	movq	%rax, -0x108(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	-0x138(%rbp), %rcx
               	movq	%rcx, -0x90(%rbp)
               	xorl	%eax, %eax
               	leaq	-0x110(%rbp), %rdx
               	movq	%rcx, -0x110(%rbp)
               	movq	%rax, -0x108(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	-0x90(%rbp), %rax
               	leaq	-0x110(%rbp), %rdx
               	movq	%rax, -0x110(%rbp)
               	movq	%rax, -0x108(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0xd0(%rbp), %rcx
               	movups	-0x150(%rbp), %xmm0
               	movups	%xmm0, -0xd0(%rbp)
               	leaq	-0x120(%rbp), %rdx
               	movups	-0x140(%rbp), %xmm0
               	movups	%xmm0, -0x120(%rbp)
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pmuludq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movabsq	$-0x340d631b7bdddcdb, %rax # imm = 0xCBF29CE484222325
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x340d631b7bdddcdb, %rax # imm = 0xCBF29CE484222325
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x340d631b7bdddcdb, %rax # imm = 0xCBF29CE484222325
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	xorl	%r12d, %r12d
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%r12,4), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%ebx, %ebx
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x61c8864680b583eb, %r11 # imm = 0x9E3779B97F4A7C15
               	imulq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x3c, %rcx
               	cmpl	$0x5, %ecx
               	jae	<addr>
               	leaq	<rip>, %rcx # <addr>
               	shrq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x2, %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	imulq	$0xc, %rdx, %rdx
               	subq	%rdx, %rax
               	movl	(%rcx,%rax,4), %eax
               	movl	%eax, -0x50(%rbp)
               	movq	%rax, %rcx
               	andq	$0x7f800000, %rcx       # imm = 0x7F800000
               	cmpl	$0x7f800000, %ecx       # imm = 0x7F800000
               	jne	<addr>
               	testl	$0x7fffff, %eax         # imm = 0x7FFFFF
               	je	<addr>
               	orq	$0x400000, %rax         # imm = 0x400000
               	movl	%eax, -0x50(%rbp)
               	leaq	-0x48(%rbp), %rcx
               	leaq	-0x50(%rbp), %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movss	-0x48(%rbp), %xmm0
               	movss	%xmm0, -0x40(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rsi
               	shrq	$0x1b, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x61c8864680b583eb, %r11 # imm = 0x9E3779B97F4A7C15
               	imulq	%r11, %rax
               	movq	%rax, %rsi
               	shrq	$0x3c, %rsi
               	cmpl	$0x5, %esi
               	jae	<addr>
               	leaq	<rip>, %rsi # <addr>
               	shrq	$0x20, %rax
               	movq	%rax, %rdi
               	shrq	$0x2, %rdi
               	imulq	$0x55555556, %rdi, %rdi # imm = 0x55555556
               	shrq	$0x20, %rdi
               	imulq	$0xc, %rdi, %rdi
               	subq	%rdi, %rax
               	movl	(%rsi,%rax,4), %eax
               	movl	%eax, -0x50(%rbp)
               	movq	%rax, %rsi
               	andq	$0x7f800000, %rsi       # imm = 0x7F800000
               	cmpl	$0x7f800000, %esi       # imm = 0x7F800000
               	jne	<addr>
               	testl	$0x7fffff, %eax         # imm = 0x7FFFFF
               	je	<addr>
               	orq	$0x400000, %rax         # imm = 0x400000
               	movl	%eax, -0x50(%rbp)
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movss	-0x48(%rbp), %xmm0
               	movss	%xmm0, -0x30(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x61c8864680b583eb, %r11 # imm = 0x9E3779B97F4A7C15
               	imulq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x3c, %rcx
               	cmpl	$0x5, %ecx
               	jae	<addr>
               	leaq	<rip>, %rcx # <addr>
               	shrq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x2, %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	imulq	$0xc, %rdx, %rdx
               	subq	%rdx, %rax
               	movl	(%rcx,%rax,4), %eax
               	movl	%eax, -0x50(%rbp)
               	movq	%rax, %rcx
               	andq	$0x7f800000, %rcx       # imm = 0x7F800000
               	cmpl	$0x7f800000, %ecx       # imm = 0x7F800000
               	jne	<addr>
               	testl	$0x7fffff, %eax         # imm = 0x7FFFFF
               	je	<addr>
               	orq	$0x400000, %rax         # imm = 0x400000
               	movl	%eax, -0x50(%rbp)
               	leaq	-0x48(%rbp), %rcx
               	leaq	-0x50(%rbp), %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movss	-0x48(%rbp), %xmm0
               	movss	%xmm0, -0x3c(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rsi
               	shrq	$0x1b, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x61c8864680b583eb, %r11 # imm = 0x9E3779B97F4A7C15
               	imulq	%r11, %rax
               	movq	%rax, %rsi
               	shrq	$0x3c, %rsi
               	cmpl	$0x5, %esi
               	jae	<addr>
               	leaq	<rip>, %rsi # <addr>
               	shrq	$0x20, %rax
               	movq	%rax, %rdi
               	shrq	$0x2, %rdi
               	imulq	$0x55555556, %rdi, %rdi # imm = 0x55555556
               	shrq	$0x20, %rdi
               	imulq	$0xc, %rdi, %rdi
               	subq	%rdi, %rax
               	movl	(%rsi,%rax,4), %eax
               	movl	%eax, -0x50(%rbp)
               	movq	%rax, %rsi
               	andq	$0x7f800000, %rsi       # imm = 0x7F800000
               	cmpl	$0x7f800000, %esi       # imm = 0x7F800000
               	jne	<addr>
               	testl	$0x7fffff, %eax         # imm = 0x7FFFFF
               	je	<addr>
               	orq	$0x400000, %rax         # imm = 0x400000
               	movl	%eax, -0x50(%rbp)
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movss	-0x48(%rbp), %xmm0
               	movss	%xmm0, -0x2c(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x61c8864680b583eb, %r11 # imm = 0x9E3779B97F4A7C15
               	imulq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x3c, %rcx
               	cmpl	$0x5, %ecx
               	jae	<addr>
               	leaq	<rip>, %rcx # <addr>
               	shrq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x2, %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	imulq	$0xc, %rdx, %rdx
               	subq	%rdx, %rax
               	movl	(%rcx,%rax,4), %eax
               	movl	%eax, -0x50(%rbp)
               	movq	%rax, %rcx
               	andq	$0x7f800000, %rcx       # imm = 0x7F800000
               	cmpl	$0x7f800000, %ecx       # imm = 0x7F800000
               	jne	<addr>
               	testl	$0x7fffff, %eax         # imm = 0x7FFFFF
               	je	<addr>
               	orq	$0x400000, %rax         # imm = 0x400000
               	movl	%eax, -0x50(%rbp)
               	leaq	-0x48(%rbp), %rcx
               	leaq	-0x50(%rbp), %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movss	-0x48(%rbp), %xmm0
               	movss	%xmm0, -0x38(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rsi
               	shrq	$0x1b, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x61c8864680b583eb, %r11 # imm = 0x9E3779B97F4A7C15
               	imulq	%r11, %rax
               	movq	%rax, %rsi
               	shrq	$0x3c, %rsi
               	cmpl	$0x5, %esi
               	jae	<addr>
               	leaq	<rip>, %rsi # <addr>
               	shrq	$0x20, %rax
               	movq	%rax, %rdi
               	shrq	$0x2, %rdi
               	imulq	$0x55555556, %rdi, %rdi # imm = 0x55555556
               	shrq	$0x20, %rdi
               	imulq	$0xc, %rdi, %rdi
               	subq	%rdi, %rax
               	movl	(%rsi,%rax,4), %eax
               	movl	%eax, -0x50(%rbp)
               	movq	%rax, %rsi
               	andq	$0x7f800000, %rsi       # imm = 0x7F800000
               	cmpl	$0x7f800000, %esi       # imm = 0x7F800000
               	jne	<addr>
               	testl	$0x7fffff, %eax         # imm = 0x7FFFFF
               	je	<addr>
               	orq	$0x400000, %rax         # imm = 0x400000
               	movl	%eax, -0x50(%rbp)
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movss	-0x48(%rbp), %xmm0
               	movss	%xmm0, -0x28(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x61c8864680b583eb, %r11 # imm = 0x9E3779B97F4A7C15
               	imulq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x3c, %rcx
               	cmpl	$0x5, %ecx
               	jae	<addr>
               	leaq	<rip>, %rcx # <addr>
               	shrq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x2, %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	imulq	$0xc, %rdx, %rdx
               	subq	%rdx, %rax
               	movl	(%rcx,%rax,4), %eax
               	movl	%eax, -0x50(%rbp)
               	movq	%rax, %rcx
               	andq	$0x7f800000, %rcx       # imm = 0x7F800000
               	cmpl	$0x7f800000, %ecx       # imm = 0x7F800000
               	jne	<addr>
               	testl	$0x7fffff, %eax         # imm = 0x7FFFFF
               	je	<addr>
               	orq	$0x400000, %rax         # imm = 0x400000
               	movl	%eax, -0x50(%rbp)
               	leaq	-0x48(%rbp), %rcx
               	leaq	-0x50(%rbp), %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movss	-0x48(%rbp), %xmm0
               	movss	%xmm0, -0x34(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rsi
               	shrq	$0x1b, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x61c8864680b583eb, %r11 # imm = 0x9E3779B97F4A7C15
               	imulq	%r11, %rax
               	movq	%rax, %rsi
               	shrq	$0x3c, %rsi
               	cmpl	$0x5, %esi
               	jae	<addr>
               	leaq	<rip>, %rsi # <addr>
               	shrq	$0x20, %rax
               	movq	%rax, %rdi
               	shrq	$0x2, %rdi
               	imulq	$0x55555556, %rdi, %rdi # imm = 0x55555556
               	shrq	$0x20, %rdi
               	imulq	$0xc, %rdi, %rdi
               	subq	%rdi, %rax
               	movl	(%rsi,%rax,4), %eax
               	movl	%eax, -0x50(%rbp)
               	movq	%rax, %rsi
               	andq	$0x7f800000, %rsi       # imm = 0x7F800000
               	cmpl	$0x7f800000, %esi       # imm = 0x7F800000
               	jne	<addr>
               	testl	$0x7fffff, %eax         # imm = 0x7FFFFF
               	je	<addr>
               	orq	$0x400000, %rax         # imm = 0x400000
               	movl	%eax, -0x50(%rbp)
               	jmp	<addr>
               	shrq	$0x10, %rax
               	jmp	<addr>
               	shrq	$0x10, %rax
               	jmp	<addr>
               	shrq	$0x10, %rax
               	jmp	<addr>
               	shrq	$0x10, %rax
               	jmp	<addr>
               	shrq	$0x10, %rax
               	jmp	<addr>
               	shrq	$0x10, %rax
               	jmp	<addr>
               	shrq	$0x10, %rax
               	jmp	<addr>
               	shrq	$0x10, %rax
               	jmp	<addr>
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movss	-0x48(%rbp), %xmm0
               	movss	%xmm0, -0x24(%rbp)
               	callq	<addr>
               	movsd	%xmm0, -0x20(%rbp)
               	callq	<addr>
               	movsd	%xmm0, -0x10(%rbp)
               	callq	<addr>
               	movsd	%xmm0, -0x18(%rbp)
               	callq	<addr>
               	movsd	%xmm0, -0x8(%rbp)
               	leaq	-0xf0(%rbp), %r9
               	movups	-0x40(%rbp), %xmm0
               	movups	%xmm0, -0xf0(%rbp)
               	leaq	-0xe0(%rbp), %rax
               	movups	-0x30(%rbp), %xmm0
               	movups	%xmm0, -0xe0(%rbp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	-0xd0(%rbp), %r9
               	movups	-0x20(%rbp), %xmm0
               	movups	%xmm0, -0xd0(%rbp)
               	leaq	-0xc0(%rbp), %rax
               	movups	-0x10(%rbp), %xmm0
               	movups	%xmm0, -0xc0(%rbp)
               	leaq	-0xb0(%rbp), %rcx
               	movups	-0x30(%rbp), %xmm0
               	movups	%xmm0, -0xb0(%rbp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	callq	<addr>
               	incq	%rbx
               	cmpl	$0x12c, %ebx            # imm = 0x12C
               	jl	<addr>
               	incq	%r12
               	cmpl	$0x4, %r12d
               	jl	<addr>
               	xorl	%edi, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x1d353ecce4bb2c4c, %r11 # imm = 0x1D353ECCE4BB2C4C
               	cmpq	%r11, %rcx
               	je	<addr>
               	incq	%rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x1, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x5f321771cc41bdbe, %r11 # imm = 0x5F321771CC41BDBE
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x11856f6ffb76e2b5, %r11 # imm = 0x11856F6FFB76E2B5
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x3, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x522e63c0d8741325, %r11 # imm = 0x522E63C0D8741325
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x4, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$-0x6605217b7e29a463, %r11 # imm = 0x99FADE8481D65B9D
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x5, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$-0x476d81e9c79ae31c, %r11 # imm = 0xB8927E1638651CE4
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x6, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x2592e395939d25fb, %r11 # imm = 0x2592E395939D25FB
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x7, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x592dd2b653feaafd, %r11 # imm = 0x592DD2B653FEAAFD
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x8, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$-0x2c37e8b167510621, %r11 # imm = 0xD3C8174E98AEF9DF
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x9, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$-0x2aebe8f0aa8103b, %r11 # imm = 0xFD514170F557EFC5
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0xa, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x4d66a832b7bc62cb, %r11 # imm = 0x4D66A832B7BC62CB
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0xb, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0xa3dad741c2e2d3f, %r11 # imm = 0xA3DAD741C2E2D3F
               	cmpq	%r11, %rcx
               	jne	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movq	<rip>, %rdx # <addr>
               	movq	%rdx, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rdx
               	movq	%rdx, <rip> # <addr>
               	movq	%rdx, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rdx
               	movq	%rdx, <rip> # <addr>
               	movq	%rdx, %rsi
               	shrq	$0x1b, %rsi
               	xorq	%rsi, %rdx
               	movq	%rdx, <rip> # <addr>
               	movabsq	$-0x61c8864680b583eb, %r11 # imm = 0x9E3779B97F4A7C15
               	imulq	%r11, %rdx
               	shrq	$0x29, %rdx
               	xorps	%xmm0, %xmm0
               	movq	%rdx, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	movl	$0x49800000, %edx       # imm = 0x49800000
               	movq	%rdx, %xmm15
               	divss	%xmm15, %xmm0
               	movq	%rax, %xmm14
               	vaddss	%xmm0, %xmm14, %xmm0
               	movss	%xmm0, -0xb0(%rbp)
               	movss	%xmm0, -0xac(%rbp)
               	movss	%xmm0, -0xa8(%rbp)
               	movss	%xmm0, -0xa4(%rbp)
               	leaq	-0xa0(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rax, %xmm14
               	movss	%xmm14, -0xa0(%rbp)
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x9c(%rbp)
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x98(%rbp)
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x94(%rbp)
               	leaq	-0xa0(%rbp), %rax
               	leaq	-0xb0(%rbp), %rdx
               	leaq	-0x90(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	divps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	-0x90(%rbp), %xmm1
               	movups	%xmm1, -0x20(%rbp)
               	movss	%xmm0, -0xb0(%rbp)
               	movss	%xmm0, -0xac(%rbp)
               	movss	%xmm0, -0xa8(%rbp)
               	movss	%xmm0, -0xa4(%rbp)
               	leaq	-0x80(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x3f800000, -0x80(%rbp) # imm = 0x3F800000
               	movl	$0x3f800000, -0x7c(%rbp) # imm = 0x3F800000
               	movl	$0x3f800000, -0x78(%rbp) # imm = 0x3F800000
               	movl	$0x3f800000, -0x74(%rbp) # imm = 0x3F800000
               	leaq	-0x80(%rbp), %rdx
               	leaq	-0xb0(%rbp), %rsi
               	leaq	-0x70(%rbp), %rax
               	movdqu	(%rsi), %xmm14
               	sqrtps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x60(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rax), %xmm14
               	divps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	-0x60(%rbp), %xmm1
               	movups	%xmm1, -0x10(%rbp)
               	movss	-0x20(%rbp), %xmm1
               	cvtss2sd	%xmm0, %xmm0
               	cvtss2sd	%xmm1, %xmm1
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	vfmsub213sd	%xmm15, %xmm0, %xmm1 # xmm1 = (xmm0 * xmm1) - xmm15
               	movss	-0x10(%rbp), %xmm2
               	mulss	%xmm2, %xmm2
               	cvtss2sd	%xmm2, %xmm2
               	movq	%rax, %xmm15
               	vfmsub213sd	%xmm15, %xmm2, %xmm0 # xmm0 = (xmm2 * xmm0) - xmm15
               	movabsq	$0x3f38000000000000, %rax # imm = 0x3F38000000000000
               	movq	%rax, %xmm15
               	comisd	%xmm15, %xmm1
               	ja	<addr>
               	movabsq	$-0x40c8000000000000, %rax # imm = 0xBF38000000000000
               	movq	%rax, %xmm15
               	comisd	%xmm1, %xmm15
               	ja	<addr>
               	movabsq	$0x3f48000000000000, %rax # imm = 0x3F48000000000000
               	movq	%rax, %xmm15
               	comisd	%xmm15, %xmm0
               	ja	<addr>
               	movabsq	$-0x40b8000000000000, %rax # imm = 0xBF48000000000000
               	movq	%rax, %xmm15
               	comisd	%xmm0, %xmm15
               	ja	<addr>
               	incq	%rcx
               	cmpl	$0xc8, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0xd, %eax
               	jmp	<addr>
