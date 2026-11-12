
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

<singles>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movups	%xmm0, 0x40(%rsp)
               	movups	%xmm1, 0x30(%rsp)
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vaddps	%xmm15, %xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vsubps	%xmm15, %xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vmulps	%xmm15, %xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vdivps	%xmm15, %xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vaddss	%xmm15, %xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vsubss	%xmm15, %xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vmulss	%xmm15, %xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vdivss	%xmm15, %xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	sqrtps	%xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x40(%rsp), %xmm0
               	sqrtss	%xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
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
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vminps	%xmm15, %xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vmaxps	%xmm15, %xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x30(%rsp), %xmm14
               	movups	0x40(%rsp), %xmm0
               	minss	%xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x30(%rsp), %xmm14
               	movups	0x40(%rsp), %xmm0
               	maxss	%xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
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
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vcmpeqps	%xmm15, %xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vcmpltps	%xmm15, %xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vcmpleps	%xmm15, %xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x30(%rsp), %xmm14
               	movups	0x40(%rsp), %xmm15
               	vcmpltps	%xmm15, %xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x30(%rsp), %xmm14
               	movups	0x40(%rsp), %xmm15
               	vcmpleps	%xmm15, %xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vcmpneqps	%xmm15, %xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vcmpnltps	%xmm15, %xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vcmpnleps	%xmm15, %xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x30(%rsp), %xmm14
               	movups	0x40(%rsp), %xmm15
               	vcmpnltps	%xmm15, %xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x30(%rsp), %xmm14
               	movups	0x40(%rsp), %xmm15
               	vcmpnleps	%xmm15, %xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vcmpordps	%xmm15, %xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vcmpunordps	%xmm15, %xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vcmpeqss	%xmm15, %xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vcmpltss	%xmm15, %xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm0
               	movups	0x30(%rsp), %xmm14
               	vcmpltss	%xmm0, %xmm14, %xmm1
               	vmovd	%xmm1, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm0
               	movups	0x30(%rsp), %xmm14
               	vcmpnless	%xmm0, %xmm14, %xmm1
               	vmovd	%xmm1, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vcmpunordss	%xmm15, %xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
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
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	movups	0x40(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	movups	0x30(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	comiss	%xmm0, %xmm1
               	jb	<addr>
               	movups	0x40(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	movups	0x30(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	comiss	%xmm1, %xmm0
               	setae	%cl
               	movzbq	%cl, %rcx
               	movl	%ecx, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	movups	0x30(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	comiss	%xmm0, %xmm1
               	seta	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	movups	0x30(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	comiss	%xmm0, %xmm1
               	setae	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	movups	0x30(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	comiss	%xmm1, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	movups	0x30(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	comiss	%xmm1, %xmm0
               	setae	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	xorl	%eax, %eax
               	movups	0x40(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	movups	0x30(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	comiss	%xmm0, %xmm1
               	jb	<addr>
               	movups	0x40(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	movups	0x30(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	comiss	%xmm1, %xmm0
               	setae	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	%ecx, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
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
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movups	0x40(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	movups	0x30(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	ucomiss	%xmm1, %xmm0
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	movups	0x30(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	ucomiss	%xmm0, %xmm1
               	seta	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	movups	0x30(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	ucomiss	%xmm0, %xmm1
               	setae	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	movups	0x30(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	ucomiss	%xmm1, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	movups	0x30(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	ucomiss	%xmm1, %xmm0
               	setae	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	movups	0x30(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	ucomiss	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
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
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movups	0x40(%rsp), %xmm14
               	cvtss2si	%xmm14, %eax
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	cvttss2si	%xmm14, %eax
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	cvtss2si	%xmm14, %rax
               	movq	%rax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	cvttss2si	%xmm14, %rax
               	movq	%rax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
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
               	movslq	%eax, %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	vmovd	%xmm0, %r11d
               	movups	0x40(%rsp), %xmm0
               	vpinsrd	$0x0, %r11d, %xmm0, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
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
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	vmovd	%xmm0, %r11d
               	movups	0x40(%rsp), %xmm0
               	vpinsrd	$0x0, %r11d, %xmm0, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	cvtps2dq	%xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	cvttps2dq	%xmm14, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	cvtdq2ps	%xmm14, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm14
               	cvtps2pd	%xmm14, %xmm0
               	leaq	-0x80(%rbp), %rdx
               	movups	%xmm0, -0x80(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
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
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	xorl	%eax, %eax
               	movups	0x40(%rsp), %xmm0
               	vpextrd	$0x2, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	vmovd	%ecx, %xmm1
               	vmovd	%xmm0, %ecx
               	movslq	%ecx, %rcx
               	vpinsrd	$0x1, %ecx, %xmm1, %xmm1
               	movups	0x30(%rsp), %xmm0
               	vpextrd	$0x3, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	vpinsrd	$0x2, %ecx, %xmm1, %xmm1
               	vpextrd	$0x1, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %ecx, %xmm0, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	xorl	%eax, %eax
               	movups	0x40(%rsp), %xmm0
               	vmovd	%xmm0, %ecx
               	movslq	%ecx, %rcx
               	vmovd	%ecx, %xmm2
               	movups	0x30(%rsp), %xmm1
               	vmovd	%xmm1, %ecx
               	movslq	%ecx, %rcx
               	vpinsrd	$0x1, %ecx, %xmm2, %xmm2
               	vpextrd	$0x1, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	movapd	%xmm2, %xmm0
               	vpinsrd	$0x2, %ecx, %xmm0, %xmm0
               	vpextrd	$0x1, %xmm1, %ecx
               	movslq	%ecx, %rcx
               	vpinsrd	$0x3, %ecx, %xmm0, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	xorl	%eax, %eax
               	movups	0x40(%rsp), %xmm0
               	vpextrd	$0x2, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	vmovd	%ecx, %xmm2
               	movups	0x30(%rsp), %xmm1
               	vpextrd	$0x2, %xmm1, %ecx
               	movslq	%ecx, %rcx
               	vpinsrd	$0x1, %ecx, %xmm2, %xmm2
               	vpextrd	$0x3, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	movapd	%xmm2, %xmm0
               	vpinsrd	$0x2, %ecx, %xmm0, %xmm0
               	vpextrd	$0x3, %xmm1, %ecx
               	movslq	%ecx, %rcx
               	vpinsrd	$0x3, %ecx, %xmm0, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	xorl	%eax, %eax
               	movups	0x30(%rsp), %xmm0
               	vpextrd	$0x2, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	vmovd	%ecx, %xmm1
               	vpextrd	$0x3, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	vpinsrd	$0x1, %ecx, %xmm1, %xmm1
               	movups	0x40(%rsp), %xmm0
               	vpextrd	$0x2, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	vpinsrd	$0x2, %ecx, %xmm1, %xmm1
               	vpextrd	$0x3, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %ecx, %xmm0, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	xorl	%eax, %eax
               	movups	0x40(%rsp), %xmm0
               	vmovd	%xmm0, %ecx
               	movslq	%ecx, %rcx
               	vmovd	%ecx, %xmm1
               	vpextrd	$0x1, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	vpinsrd	$0x1, %ecx, %xmm1, %xmm1
               	movups	0x30(%rsp), %xmm0
               	vmovd	%xmm0, %ecx
               	movslq	%ecx, %rcx
               	vpinsrd	$0x2, %ecx, %xmm1, %xmm1
               	vpextrd	$0x1, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %ecx, %xmm0, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x30(%rsp), %xmm14
               	vmovd	%xmm14, %eax
               	movslq	%eax, %rax
               	movups	0x40(%rsp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x40(%rsp), %xmm0
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setl	%al
               	movzbq	%al, %rax
               	vpextrd	$0x1, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	orq	%rcx, %rax
               	vpextrd	$0x2, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x2, %rcx
               	orq	%rcx, %rax
               	vpextrd	$0x3, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x3, %rcx
               	orq	%rcx, %rax
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	xorl	%eax, %eax
               	movups	0x40(%rsp), %xmm0
               	vpextrd	$0x3, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	vmovd	%ecx, %xmm1
               	vpextrd	$0x2, %xmm0, %edi
               	movslq	%edi, %rdi
               	vpinsrd	$0x1, %edi, %xmm1, %xmm1
               	vpextrd	$0x1, %xmm0, %r8d
               	movslq	%r8d, %r8
               	vpinsrd	$0x2, %r8d, %xmm1, %xmm1
               	vmovd	%xmm0, %r9d
               	movslq	%r9d, %r9
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %r9d, %xmm0, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	xorl	%eax, %eax
               	vmovd	%edi, %xmm0
               	vpinsrd	$0x1, %eax, %xmm0, %xmm0
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovd	%r8d, %xmm0
               	vpbroadcastd	%xmm0, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x30(%rsp), %xmm14
               	vmovd	%xmm14, %ecx
               	movslq	%ecx, %rcx
               	xorl	%eax, %eax
               	vmovd	%r9d, %xmm0
               	vpinsrd	$0x1, %r8d, %xmm0, %xmm0
               	vpinsrd	$0x2, %edi, %xmm0, %xmm0
               	vpinsrd	$0x3, %ecx, %xmm0, %xmm0
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	0x30(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	movss	%xmm0, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	xorq	%rsi, %rcx
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rcx
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
               	subq	$0xe0, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	movups	%xmm1, 0x50(%rsp)
               	movups	%xmm2, 0x40(%rsp)
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vaddpd	%xmm15, %xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vsubpd	%xmm15, %xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vmulpd	%xmm15, %xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vdivpd	%xmm15, %xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vaddsd	%xmm15, %xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vsubsd	%xmm15, %xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vmulsd	%xmm15, %xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vdivsd	%xmm15, %xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm14
               	sqrtpd	%xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x50(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm0
               	sqrtsd	%xmm14, %xmm0
               	vmovq	%xmm0, %rax
               	movups	0x60(%rsp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vminpd	%xmm15, %xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vmaxpd	%xmm15, %xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x50(%rsp), %xmm14
               	movups	0x60(%rsp), %xmm0
               	minsd	%xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x50(%rsp), %xmm14
               	movups	0x60(%rsp), %xmm0
               	maxsd	%xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vcmpeqpd	%xmm15, %xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vcmpltpd	%xmm15, %xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vcmplepd	%xmm15, %xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x50(%rsp), %xmm14
               	movups	0x60(%rsp), %xmm15
               	vcmpltpd	%xmm15, %xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x50(%rsp), %xmm14
               	movups	0x60(%rsp), %xmm15
               	vcmplepd	%xmm15, %xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vcmpneqpd	%xmm15, %xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vcmpnltpd	%xmm15, %xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vcmpnlepd	%xmm15, %xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x50(%rsp), %xmm14
               	movups	0x60(%rsp), %xmm15
               	vcmpnltpd	%xmm15, %xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x50(%rsp), %xmm14
               	movups	0x60(%rsp), %xmm15
               	vcmpnlepd	%xmm15, %xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vcmpordpd	%xmm15, %xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vcmpunordpd	%xmm15, %xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vcmpeqsd	%xmm15, %xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vcmplesd	%xmm15, %xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm0
               	movups	0x50(%rsp), %xmm14
               	vcmplesd	%xmm0, %xmm14, %xmm1
               	vmovq	%xmm1, %rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm0
               	movups	0x50(%rsp), %xmm14
               	vcmpnltsd	%xmm0, %xmm14, %xmm1
               	vmovq	%xmm1, %rax
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vcmpordsd	%xmm15, %xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	movups	0x50(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	comisd	%xmm0, %xmm1
               	jb	<addr>
               	movups	0x60(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	movups	0x50(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	comisd	%xmm1, %xmm0
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
               	movups	0x60(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	movups	0x50(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	comisd	%xmm0, %xmm1
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
               	movups	0x60(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	movups	0x50(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	comisd	%xmm1, %xmm0
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
               	movups	0x60(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	movups	0x50(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	comisd	%xmm0, %xmm1
               	jb	<addr>
               	movups	0x60(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	movups	0x50(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	comisd	%xmm1, %xmm0
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
               	movups	0x60(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	movups	0x50(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	ucomisd	%xmm1, %xmm0
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
               	movups	0x60(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	movups	0x50(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	ucomisd	%xmm0, %xmm1
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
               	movups	0x60(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	movups	0x50(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	ucomisd	%xmm1, %xmm0
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
               	movups	0x60(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	movups	0x50(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	ucomisd	%xmm1, %xmm0
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
               	movups	0x60(%rsp), %xmm14
               	cvtsd2si	%xmm14, %eax
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
               	movups	0x60(%rsp), %xmm14
               	cvttsd2si	%xmm14, %eax
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
               	movups	0x60(%rsp), %xmm14
               	cvtsd2si	%xmm14, %rax
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
               	movups	0x60(%rsp), %xmm14
               	cvttsd2si	%xmm14, %rax
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
               	movslq	%eax, %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	vmovq	%xmm0, %r11
               	movups	0x60(%rsp), %xmm0
               	vpinsrq	$0x0, %r11, %xmm0, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	vmovq	%xmm0, %r11
               	movups	0x60(%rsp), %xmm0
               	vpinsrq	$0x0, %r11, %xmm0, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm14
               	cvtpd2dq	%xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm14
               	cvttpd2dq	%xmm14, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x50(%rsp), %xmm14
               	cvtdq2pd	%xmm14, %xmm0
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
               	movups	0x60(%rsp), %xmm14
               	cvtpd2ps	%xmm14, %xmm0
               	leaq	-0xc0(%rbp), %rdx
               	movups	%xmm0, -0xc0(%rbp)
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
               	movups	0x60(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	cvtsd2ss	%xmm0, %xmm0
               	vmovd	%xmm0, %r11d
               	movups	0x40(%rsp), %xmm0
               	vpinsrd	$0x0, %r11d, %xmm0, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x40(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	vmovq	%xmm0, %r11
               	movups	0x60(%rsp), %xmm0
               	vpinsrq	$0x0, %r11, %xmm0, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm14
               	vmovq	%xmm14, %rcx
               	vmovq	%rcx, %xmm0
               	movups	0x50(%rsp), %xmm14
               	vmovq	%xmm14, %rax
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm14
               	vpextrq	$0x1, %xmm14, %rcx
               	vmovq	%rcx, %xmm0
               	movups	0x50(%rsp), %xmm14
               	vpextrq	$0x1, %xmm14, %rax
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x50(%rsp), %xmm14
               	vmovq	%xmm14, %rax
               	movups	0x60(%rsp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	testq	%rax, %rax
               	setl	%al
               	movzbq	%al, %rax
               	vpextrq	$0x1, %xmm0, %rcx
               	testq	%rcx, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
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
               	movups	0x60(%rsp), %xmm0
               	vpextrq	$0x1, %xmm0, %r8
               	vmovq	%r8, %xmm1
               	vmovq	%xmm0, %r9
               	movapd	%xmm1, %xmm0
               	vpinsrq	$0x1, %r9, %xmm0, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x50(%rsp), %xmm0
               	vpinsrq	$0x1, %r8, %xmm0, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x50(%rsp), %xmm0
               	vpinsrq	$0x0, %r9, %xmm0, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x50(%rsp), %xmm14
               	vpextrq	$0x1, %xmm14, %r8
               	vmovq	%r8, %xmm0
               	xorl	%eax, %eax
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovq	%r8, %xmm0
               	vpbroadcastq	%xmm0, %xmm0
               	leaq	-0xe0(%rbp), %rdx
               	movups	%xmm0, -0xe0(%rbp)
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
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vpmuludq	%xmm15, %xmm14, %xmm0
               	leaq	-0xb0(%rbp), %rdx
               	movups	%xmm0, -0xb0(%rbp)
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
               	subq	$0xb0, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movabsq	$-0x340d631b7bdddcdb, %rax # imm = 0xCBF29CE484222325
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
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
               	movl	%eax, -0x20(%rbp)
               	movq	%rax, %rcx
               	andq	$0x7f800000, %rcx       # imm = 0x7F800000
               	cmpl	$0x7f800000, %ecx       # imm = 0x7F800000
               	jne	<addr>
               	testl	$0x7fffff, %eax         # imm = 0x7FFFFF
               	je	<addr>
               	orq	$0x400000, %rax         # imm = 0x400000
               	movl	%eax, -0x20(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movss	-0x20(%rbp), %xmm0
               	vmovd	%xmm0, %r11d
               	movups	0x60(%rsp), %xmm0
               	vpinsrd	$0x0, %r11d, %xmm0, %xmm0
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
               	movl	%eax, -0x20(%rbp)
               	movq	%rax, %rsi
               	andq	$0x7f800000, %rsi       # imm = 0x7F800000
               	cmpl	$0x7f800000, %esi       # imm = 0x7F800000
               	jne	<addr>
               	testl	$0x7fffff, %eax         # imm = 0x7FFFFF
               	je	<addr>
               	orq	$0x400000, %rax         # imm = 0x400000
               	movl	%eax, -0x20(%rbp)
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movss	-0x20(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	movups	0x90(%rsp), %xmm1
               	vpinsrd	$0x0, %r11d, %xmm1, %xmm1
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
               	movq	%rax, %rdx
               	shrq	$0x3c, %rdx
               	cmpl	$0x5, %edx
               	jae	<addr>
               	leaq	<rip>, %rdx # <addr>
               	shrq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x2, %rsi
               	imulq	$0x55555556, %rsi, %rsi # imm = 0x55555556
               	shrq	$0x20, %rsi
               	imulq	$0xc, %rsi, %rsi
               	subq	%rsi, %rax
               	movl	(%rdx,%rax,4), %eax
               	movl	%eax, -0x20(%rbp)
               	movq	%rax, %rdx
               	andq	$0x7f800000, %rdx       # imm = 0x7F800000
               	cmpl	$0x7f800000, %edx       # imm = 0x7F800000
               	jne	<addr>
               	testl	$0x7fffff, %eax         # imm = 0x7FFFFF
               	je	<addr>
               	orq	$0x400000, %rax         # imm = 0x400000
               	movl	%eax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movss	-0x20(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
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
               	movq	%rax, %rsi
               	shrq	$0x2, %rsi
               	imulq	$0x55555556, %rsi, %rsi # imm = 0x55555556
               	shrq	$0x20, %rsi
               	imulq	$0xc, %rsi, %rsi
               	subq	%rsi, %rax
               	movl	(%rcx,%rax,4), %eax
               	movl	%eax, -0x20(%rbp)
               	movq	%rax, %rcx
               	andq	$0x7f800000, %rcx       # imm = 0x7F800000
               	cmpl	$0x7f800000, %ecx       # imm = 0x7F800000
               	jne	<addr>
               	testl	$0x7fffff, %eax         # imm = 0x7FFFFF
               	je	<addr>
               	orq	$0x400000, %rax         # imm = 0x400000
               	movl	%eax, -0x20(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movss	-0x20(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x1, %r11d, %xmm1, %xmm1
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
               	movq	%rax, %rdx
               	shrq	$0x3c, %rdx
               	cmpl	$0x5, %edx
               	jae	<addr>
               	leaq	<rip>, %rdx # <addr>
               	shrq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x2, %rsi
               	imulq	$0x55555556, %rsi, %rsi # imm = 0x55555556
               	shrq	$0x20, %rsi
               	imulq	$0xc, %rsi, %rsi
               	subq	%rsi, %rax
               	movl	(%rdx,%rax,4), %eax
               	movl	%eax, -0x20(%rbp)
               	movq	%rax, %rdx
               	andq	$0x7f800000, %rdx       # imm = 0x7F800000
               	cmpl	$0x7f800000, %edx       # imm = 0x7F800000
               	jne	<addr>
               	testl	$0x7fffff, %eax         # imm = 0x7FFFFF
               	je	<addr>
               	orq	$0x400000, %rax         # imm = 0x400000
               	movl	%eax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movss	-0x20(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
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
               	movl	%eax, -0x20(%rbp)
               	movq	%rax, %rsi
               	andq	$0x7f800000, %rsi       # imm = 0x7F800000
               	cmpl	$0x7f800000, %esi       # imm = 0x7F800000
               	jne	<addr>
               	testl	$0x7fffff, %eax         # imm = 0x7FFFFF
               	je	<addr>
               	orq	$0x400000, %rax         # imm = 0x400000
               	movl	%eax, -0x20(%rbp)
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movss	-0x20(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x2, %r11d, %xmm1, %xmm1
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
               	movl	%eax, -0x20(%rbp)
               	movq	%rax, %rcx
               	andq	$0x7f800000, %rcx       # imm = 0x7F800000
               	cmpl	$0x7f800000, %ecx       # imm = 0x7F800000
               	jne	<addr>
               	testl	$0x7fffff, %eax         # imm = 0x7FFFFF
               	je	<addr>
               	orq	$0x400000, %rax         # imm = 0x400000
               	movl	%eax, -0x20(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movss	-0x20(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	movapd	%xmm0, %xmm14
               	vpinsrd	$0x3, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x60(%rsp)
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
               	movl	%eax, -0x20(%rbp)
               	movq	%rax, %rsi
               	andq	$0x7f800000, %rsi       # imm = 0x7F800000
               	cmpl	$0x7f800000, %esi       # imm = 0x7F800000
               	jne	<addr>
               	testl	$0x7fffff, %eax         # imm = 0x7FFFFF
               	je	<addr>
               	orq	$0x400000, %rax         # imm = 0x400000
               	movl	%eax, -0x20(%rbp)
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movss	-0x20(%rbp), %xmm0
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm14
               	vpinsrd	$0x3, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x90(%rsp)
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
               	leaq	-0x8(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movsd	-0x10(%rbp), %xmm0
               	vmovq	%xmm0, %r11
               	movups	0x70(%rsp), %xmm0
               	vpinsrq	$0x0, %r11, %xmm0, %xmm0
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
               	movabsq	$-0x61c8864680b583eb, %rsi # imm = 0x9E3779B97F4A7C15
               	imulq	%rax, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3c, %rdi
               	cmpl	$0x5, %edi
               	jae	<addr>
               	leaq	<rip>, %rax # <addr>
               	shrq	$0x20, %rsi
               	movl	$0xba2e8ba3, %edi       # imm = 0xBA2E8BA3
               	imulq	%rsi, %rdi
               	shrq	$0x23, %rdi
               	imulq	$0xb, %rdi, %rdi
               	subq	%rdi, %rsi
               	movq	(%rax,%rsi,8), %rax
               	movq	%rax, -0x10(%rbp)
               	movabsq	$0x7ff0000000000000, %rsi # imm = 0x7FF0000000000000
               	andq	%rax, %rsi
               	movabsq	$0x7ff0000000000000, %r11 # imm = 0x7FF0000000000000
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movabsq	$0xfffffffffffff, %rsi  # imm = 0xFFFFFFFFFFFFF
               	andq	%rax, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movabsq	$0x8000000000000, %r11  # imm = 0x8000000000000
               	orq	%r11, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movsd	-0x10(%rbp), %xmm1
               	vmovq	%xmm1, %r11
               	movups	0x80(%rsp), %xmm1
               	vpinsrq	$0x0, %r11, %xmm1, %xmm1
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
               	movabsq	$-0x61c8864680b583eb, %rcx # imm = 0x9E3779B97F4A7C15
               	imulq	%rax, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x3c, %rdx
               	cmpl	$0x5, %edx
               	jae	<addr>
               	leaq	<rip>, %rax # <addr>
               	shrq	$0x20, %rcx
               	movl	$0xba2e8ba3, %edx       # imm = 0xBA2E8BA3
               	imulq	%rcx, %rdx
               	shrq	$0x23, %rdx
               	imulq	$0xb, %rdx, %rdx
               	subq	%rdx, %rcx
               	movq	(%rax,%rcx,8), %rax
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
               	leaq	-0x8(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movsd	-0x10(%rbp), %xmm2
               	vunpcklpd	%xmm2, %xmm0, %xmm14 # xmm14 = xmm0[0],xmm2[0]
               	movups	%xmm14, 0x70(%rsp)
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
               	movabsq	$-0x61c8864680b583eb, %rsi # imm = 0x9E3779B97F4A7C15
               	imulq	%rax, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3c, %rdi
               	cmpl	$0x5, %edi
               	jae	<addr>
               	leaq	<rip>, %rax # <addr>
               	shrq	$0x20, %rsi
               	movl	$0xba2e8ba3, %edi       # imm = 0xBA2E8BA3
               	imulq	%rsi, %rdi
               	shrq	$0x23, %rdi
               	imulq	$0xb, %rdi, %rdi
               	subq	%rdi, %rsi
               	movq	(%rax,%rsi,8), %rax
               	movq	%rax, -0x10(%rbp)
               	movabsq	$0x7ff0000000000000, %rsi # imm = 0x7FF0000000000000
               	andq	%rax, %rsi
               	movabsq	$0x7ff0000000000000, %r11 # imm = 0x7FF0000000000000
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movabsq	$0xfffffffffffff, %rsi  # imm = 0xFFFFFFFFFFFFF
               	andq	%rax, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movabsq	$0x8000000000000, %r11  # imm = 0x8000000000000
               	orq	%r11, %rax
               	movq	%rax, -0x10(%rbp)
               	jmp	<addr>
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
               	jmp	<addr>
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
               	jmp	<addr>
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
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movsd	-0x10(%rbp), %xmm0
               	vunpcklpd	%xmm0, %xmm1, %xmm14 # xmm14 = xmm1[0],xmm0[0]
               	movups	%xmm14, 0x80(%rsp)
               	leaq	-0xb0(%rbp), %r9
               	movups	0x60(%rsp), %xmm14
               	movups	%xmm14, -0xb0(%rbp)
               	leaq	-0xa0(%rbp), %rax
               	movups	0x90(%rsp), %xmm14
               	movups	%xmm14, -0xa0(%rbp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	-0x90(%rbp), %r9
               	movups	0x70(%rsp), %xmm14
               	movups	%xmm14, -0x90(%rbp)
               	leaq	-0x80(%rbp), %rax
               	movups	0x80(%rsp), %xmm14
               	movups	%xmm14, -0x80(%rbp)
               	leaq	-0x70(%rbp), %rcx
               	movups	0x90(%rsp), %xmm14
               	movups	%xmm14, -0x70(%rbp)
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
               	movabsq	$-0x61c8864680b583eb, %rsi # imm = 0x9E3779B97F4A7C15
               	xorl	%eax, %eax
               	movl	$0x3f800000, %edx       # imm = 0x3F800000
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rdi
               	shrq	$0xc, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rdi
               	shlq	$0x19, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rdi
               	shrq	$0x1b, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	imulq	%rsi, %rcx
               	shrq	$0x29, %rcx
               	xorps	%xmm0, %xmm0
               	movq	%rcx, %r10
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
               	movl	$0x49800000, %ecx       # imm = 0x49800000
               	movq	%rcx, %xmm15
               	divss	%xmm15, %xmm0
               	movq	%rdx, %xmm14
               	vaddss	%xmm0, %xmm14, %xmm0
               	vbroadcastss	%xmm0, %xmm1
               	movq	%rdx, %xmm15
               	vbroadcastss	%xmm15, %xmm2
               	vdivps	%xmm1, %xmm2, %xmm3
               	sqrtps	%xmm1, %xmm1
               	vdivps	%xmm1, %xmm2, %xmm1
               	vpermilps	$0x0, %xmm3, %xmm2 # xmm2 = xmm3[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	cvtss2sd	%xmm2, %xmm2
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm15
               	vfmsub213sd	%xmm15, %xmm0, %xmm2 # xmm2 = (xmm0 * xmm2) - xmm15
               	vpermilps	$0x0, %xmm1, %xmm3 # xmm3 = xmm1[0,0,0,0]
               	vmulss	%xmm1, %xmm3, %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rcx, %xmm15
               	vfmsub213sd	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) - xmm15
               	movabsq	$0x3f38000000000000, %rcx # imm = 0x3F38000000000000
               	movq	%rcx, %xmm15
               	comisd	%xmm15, %xmm2
               	ja	<addr>
               	movabsq	$-0x40c8000000000000, %rcx # imm = 0xBF38000000000000
               	movq	%rcx, %xmm15
               	comisd	%xmm2, %xmm15
               	ja	<addr>
               	movabsq	$0x3f48000000000000, %rcx # imm = 0x3F48000000000000
               	movq	%rcx, %xmm15
               	comisd	%xmm15, %xmm0
               	ja	<addr>
               	movabsq	$-0x40b8000000000000, %rcx # imm = 0xBF48000000000000
               	movq	%rcx, %xmm15
               	comisd	%xmm0, %xmm15
               	ja	<addr>
               	incq	%rax
               	cmpl	$0xc8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0xd, %eax
               	jmp	<addr>
