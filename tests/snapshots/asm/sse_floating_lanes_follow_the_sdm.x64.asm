
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
               	subq	$0xb0, %rsp
               	movups	%xmm0, -0xb0(%rbp)
               	movups	%xmm1, -0xa0(%rbp)
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movups	-0xb0(%rbp), %xmm0
               	movups	-0xa0(%rbp), %xmm1
               	addps	%xmm1, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xb0(%rbp), %xmm0
               	movups	-0xa0(%rbp), %xmm1
               	subps	%xmm1, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xb0(%rbp), %xmm0
               	movups	-0xa0(%rbp), %xmm1
               	mulps	%xmm1, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xb0(%rbp), %xmm0
               	movups	-0xa0(%rbp), %xmm1
               	divps	%xmm1, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xb0(%rbp), %xmm0
               	movups	-0xa0(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xb0(%rbp), %xmm0
               	movups	-0xa0(%rbp), %xmm1
               	subss	%xmm1, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xb0(%rbp), %xmm0
               	movups	-0xa0(%rbp), %xmm1
               	mulss	%xmm1, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xb0(%rbp), %xmm0
               	movups	-0xa0(%rbp), %xmm1
               	divss	%xmm1, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xb0(%rbp), %xmm0
               	sqrtps	%xmm0, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xb0(%rbp), %xmm0
               	sqrtss	%xmm0, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
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
               	movups	-0xb0(%rbp), %xmm0
               	movups	-0xa0(%rbp), %xmm1
               	minps	%xmm1, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xb0(%rbp), %xmm0
               	movups	-0xa0(%rbp), %xmm1
               	maxps	%xmm1, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xb0(%rbp), %xmm0
               	movups	-0xa0(%rbp), %xmm1
               	minss	%xmm1, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xb0(%rbp), %xmm0
               	movups	-0xa0(%rbp), %xmm1
               	maxss	%xmm1, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
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
               	movups	-0xb0(%rbp), %xmm0
               	movups	-0xa0(%rbp), %xmm1
               	cmpeqps	%xmm1, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xb0(%rbp), %xmm0
               	movups	-0xa0(%rbp), %xmm1
               	cmpltps	%xmm1, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xb0(%rbp), %xmm0
               	movups	-0xa0(%rbp), %xmm1
               	cmpleps	%xmm1, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xa0(%rbp), %xmm0
               	movups	-0xb0(%rbp), %xmm1
               	cmpltps	%xmm1, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xa0(%rbp), %xmm0
               	movups	-0xb0(%rbp), %xmm1
               	cmpleps	%xmm1, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xb0(%rbp), %xmm0
               	movups	-0xa0(%rbp), %xmm1
               	cmpneqps	%xmm1, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xb0(%rbp), %xmm0
               	movups	-0xa0(%rbp), %xmm1
               	cmpnltps	%xmm1, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xb0(%rbp), %xmm0
               	movups	-0xa0(%rbp), %xmm1
               	cmpnleps	%xmm1, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xa0(%rbp), %xmm0
               	movups	-0xb0(%rbp), %xmm1
               	cmpnltps	%xmm1, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xa0(%rbp), %xmm0
               	movups	-0xb0(%rbp), %xmm1
               	cmpnleps	%xmm1, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xb0(%rbp), %xmm0
               	movups	-0xa0(%rbp), %xmm1
               	cmpordps	%xmm1, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xb0(%rbp), %xmm0
               	movups	-0xa0(%rbp), %xmm1
               	cmpunordps	%xmm1, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xb0(%rbp), %xmm0
               	movups	-0xa0(%rbp), %xmm1
               	cmpeqss	%xmm1, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xb0(%rbp), %xmm0
               	movups	-0xa0(%rbp), %xmm1
               	cmpltss	%xmm1, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xb0(%rbp), %xmm0
               	movups	-0xa0(%rbp), %xmm1
               	cmpltss	%xmm0, %xmm1
               	movups	%xmm1, -0x60(%rbp)
               	movups	%xmm0, -0x90(%rbp)
               	movl	-0x60(%rbp), %eax
               	movl	%eax, -0x90(%rbp)
               	movups	-0x90(%rbp), %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xb0(%rbp), %xmm0
               	movups	-0xa0(%rbp), %xmm1
               	cmpnless	%xmm0, %xmm1
               	movups	%xmm1, -0x60(%rbp)
               	movups	%xmm0, -0x90(%rbp)
               	movl	-0x60(%rbp), %eax
               	movl	%eax, -0x90(%rbp)
               	movups	-0x90(%rbp), %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xb0(%rbp), %xmm0
               	movups	-0xa0(%rbp), %xmm1
               	cmpunordss	%xmm1, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
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
               	movss	-0xb0(%rbp), %xmm0
               	movss	-0xa0(%rbp), %xmm1
               	comiss	%xmm0, %xmm1
               	jb	<addr>
               	movss	-0xb0(%rbp), %xmm0
               	movss	-0xa0(%rbp), %xmm1
               	comiss	%xmm1, %xmm0
               	setae	%cl
               	movzbq	%cl, %rcx
               	movl	%ecx, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movss	-0xb0(%rbp), %xmm0
               	movss	-0xa0(%rbp), %xmm1
               	comiss	%xmm0, %xmm1
               	seta	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movss	-0xb0(%rbp), %xmm0
               	movss	-0xa0(%rbp), %xmm1
               	comiss	%xmm0, %xmm1
               	setae	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movss	-0xb0(%rbp), %xmm0
               	movss	-0xa0(%rbp), %xmm1
               	comiss	%xmm1, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movss	-0xb0(%rbp), %xmm0
               	movss	-0xa0(%rbp), %xmm1
               	comiss	%xmm1, %xmm0
               	setae	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
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
               	movss	-0xb0(%rbp), %xmm0
               	movss	-0xa0(%rbp), %xmm1
               	comiss	%xmm0, %xmm1
               	jb	<addr>
               	movss	-0xb0(%rbp), %xmm0
               	movss	-0xa0(%rbp), %xmm1
               	comiss	%xmm1, %xmm0
               	setae	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	%ecx, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
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
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
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
               	movss	-0xb0(%rbp), %xmm0
               	movss	-0xa0(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movss	-0xb0(%rbp), %xmm0
               	movss	-0xa0(%rbp), %xmm1
               	ucomiss	%xmm0, %xmm1
               	seta	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movss	-0xb0(%rbp), %xmm0
               	movss	-0xa0(%rbp), %xmm1
               	ucomiss	%xmm0, %xmm1
               	setae	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movss	-0xb0(%rbp), %xmm0
               	movss	-0xa0(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movss	-0xb0(%rbp), %xmm0
               	movss	-0xa0(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setae	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movss	-0xb0(%rbp), %xmm0
               	movss	-0xa0(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
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
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
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
               	movups	-0xb0(%rbp), %xmm0
               	cvtss2si	%xmm0, %eax
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	-0xb0(%rbp), %xmm0
               	cvttss2si	%xmm0, %eax
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	-0xb0(%rbp), %xmm0
               	cvtss2si	%xmm0, %rax
               	movq	%rax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	-0xb0(%rbp), %xmm0
               	cvttss2si	%xmm0, %rax
               	movq	%rax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0xb0(%rbp), %rcx
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
               	leaq	-0x90(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	%xmm0, -0x90(%rbp)
               	movups	-0x90(%rbp), %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	leaq	-0xb0(%rbp), %rcx
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
               	leaq	-0x90(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	%xmm0, -0x90(%rbp)
               	movups	-0x90(%rbp), %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xb0(%rbp), %xmm0
               	cvtps2dq	%xmm0, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xb0(%rbp), %xmm0
               	cvttps2dq	%xmm0, %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movups	-0xb0(%rbp), %xmm0
               	cvtdq2ps	%xmm0, %xmm0
               	leaq	-0x80(%rbp), %rdx
               	movups	%xmm0, -0x80(%rbp)
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
               	movups	-0xb0(%rbp), %xmm0
               	cvtps2pd	%xmm0, %xmm0
               	leaq	-0x70(%rbp), %rdx
               	movups	%xmm0, -0x70(%rbp)
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
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	-0xb0(%rbp), %eax
               	movl	-0xa8(%rbp), %ecx
               	movl	-0x9c(%rbp), %edx
               	movl	-0x94(%rbp), %esi
               	leaq	-0x90(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	%ecx, -0x90(%rbp)
               	movl	%eax, -0x8c(%rbp)
               	movl	%esi, -0x88(%rbp)
               	movl	%edx, -0x84(%rbp)
               	movups	-0x90(%rbp), %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movl	-0xb0(%rbp), %eax
               	movl	-0xac(%rbp), %ecx
               	movl	-0xa0(%rbp), %edx
               	movl	-0x9c(%rbp), %esi
               	leaq	-0x90(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	%eax, -0x90(%rbp)
               	movl	%edx, -0x8c(%rbp)
               	movl	%ecx, -0x88(%rbp)
               	movl	%esi, -0x84(%rbp)
               	movups	-0x90(%rbp), %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movl	-0xa8(%rbp), %eax
               	movl	-0xa4(%rbp), %ecx
               	movl	-0x98(%rbp), %edx
               	movl	-0x94(%rbp), %esi
               	leaq	-0x90(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	%eax, -0x90(%rbp)
               	movl	%edx, -0x8c(%rbp)
               	movl	%ecx, -0x88(%rbp)
               	movl	%esi, -0x84(%rbp)
               	movups	-0x90(%rbp), %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movl	-0xa8(%rbp), %eax
               	movl	-0xa4(%rbp), %ecx
               	movl	-0x98(%rbp), %edx
               	movl	-0x94(%rbp), %esi
               	leaq	-0x90(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	%edx, -0x90(%rbp)
               	movl	%esi, -0x8c(%rbp)
               	movl	%eax, -0x88(%rbp)
               	movl	%ecx, -0x84(%rbp)
               	movups	-0x90(%rbp), %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movl	-0xb0(%rbp), %eax
               	movl	-0xac(%rbp), %ecx
               	movl	-0xa0(%rbp), %edx
               	movl	-0x9c(%rbp), %esi
               	leaq	-0x90(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	%eax, -0x90(%rbp)
               	movl	%ecx, -0x8c(%rbp)
               	movl	%edx, -0x88(%rbp)
               	movl	%esi, -0x84(%rbp)
               	movups	-0x90(%rbp), %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movl	-0xac(%rbp), %eax
               	movq	-0xa8(%rbp), %rcx
               	movl	-0xa0(%rbp), %esi
               	leaq	-0x90(%rbp), %rdx
               	movl	%esi, -0x90(%rbp)
               	movl	%eax, -0x8c(%rbp)
               	movq	%rcx, -0x88(%rbp)
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
               	movl	-0xb0(%rbp), %eax
               	movl	-0xac(%rbp), %ecx
               	movl	-0xa8(%rbp), %edx
               	movl	-0xa4(%rbp), %esi
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
               	movl	%eax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x50(%rbp), %rcx
               	movl	-0xb0(%rbp), %eax
               	movl	-0xac(%rbp), %edx
               	movl	-0xa8(%rbp), %esi
               	movl	-0xa4(%rbp), %edi
               	leaq	-0x60(%rbp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movl	%edi, -0x60(%rbp)
               	movl	%esi, -0x5c(%rbp)
               	leaq	-0x60(%rbp), %rsi
               	movl	%edx, -0x58(%rbp)
               	movl	%eax, -0x54(%rbp)
               	leaq	-0x90(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	-0x50(%rbp), %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movl	-0x4c(%rbp), %ecx
               	xorl	%eax, %eax
               	leaq	-0x90(%rbp), %rdx
               	movl	%ecx, -0x90(%rbp)
               	movl	%eax, -0x8c(%rbp)
               	movl	%eax, -0x88(%rbp)
               	movl	%eax, -0x84(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	-0x48(%rbp), %eax
               	leaq	-0x90(%rbp), %rdx
               	movl	%eax, -0x90(%rbp)
               	movl	%eax, -0x8c(%rbp)
               	movl	%eax, -0x88(%rbp)
               	movl	%eax, -0x84(%rbp)
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
               	movl	-0xa0(%rbp), %eax
               	movl	%eax, -0x50(%rbp)
               	movups	-0x50(%rbp), %xmm0
               	movups	%xmm0, -0x60(%rbp)
               	leaq	-0x90(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	-0x54(%rbp), %eax
               	movl	%eax, -0x90(%rbp)
               	movl	-0x58(%rbp), %eax
               	movl	%eax, -0x8c(%rbp)
               	movl	-0x5c(%rbp), %eax
               	movl	%eax, -0x88(%rbp)
               	movl	-0x60(%rbp), %eax
               	movl	%eax, -0x84(%rbp)
               	movups	-0x90(%rbp), %xmm0
               	leaq	-0x90(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp)
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
               	movss	-0xa0(%rbp), %xmm0
               	movss	%xmm0, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
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
               	subq	$0x100, %rsp            # imm = 0x100
               	movups	%xmm2, 0x80(%rsp)
               	movups	%xmm0, -0x100(%rbp)
               	movups	%xmm1, -0xf0(%rbp)
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movups	-0x100(%rbp), %xmm0
               	movups	-0xf0(%rbp), %xmm1
               	addpd	%xmm1, %xmm0
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
               	movups	-0x100(%rbp), %xmm0
               	movups	-0xf0(%rbp), %xmm1
               	subpd	%xmm1, %xmm0
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
               	movups	-0x100(%rbp), %xmm0
               	movups	-0xf0(%rbp), %xmm1
               	mulpd	%xmm1, %xmm0
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
               	movups	-0x100(%rbp), %xmm0
               	movups	-0xf0(%rbp), %xmm1
               	divpd	%xmm1, %xmm0
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
               	movups	-0x100(%rbp), %xmm0
               	movups	-0xf0(%rbp), %xmm1
               	addsd	%xmm1, %xmm0
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
               	movups	-0x100(%rbp), %xmm0
               	movups	-0xf0(%rbp), %xmm1
               	subsd	%xmm1, %xmm0
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
               	movups	-0x100(%rbp), %xmm0
               	movups	-0xf0(%rbp), %xmm1
               	mulsd	%xmm1, %xmm0
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
               	movups	-0x100(%rbp), %xmm0
               	movups	-0xf0(%rbp), %xmm1
               	divsd	%xmm1, %xmm0
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
               	movups	-0x100(%rbp), %xmm0
               	sqrtpd	%xmm0, %xmm0
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
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xa0(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0xf0(%rbp), %xmm0
               	sqrtsd	%xmm0, %xmm0
               	movups	%xmm0, -0x90(%rbp)
               	leaq	-0xe0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	-0x90(%rbp), %rax
               	movq	%rax, -0xe0(%rbp)
               	movups	-0xe0(%rbp), %xmm0
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
               	movups	-0x100(%rbp), %xmm0
               	movups	-0xf0(%rbp), %xmm1
               	minpd	%xmm1, %xmm0
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
               	movups	-0x100(%rbp), %xmm0
               	movups	-0xf0(%rbp), %xmm1
               	maxpd	%xmm1, %xmm0
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
               	movups	-0x100(%rbp), %xmm0
               	movups	-0xf0(%rbp), %xmm1
               	minsd	%xmm1, %xmm0
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
               	movups	-0x100(%rbp), %xmm0
               	movups	-0xf0(%rbp), %xmm1
               	maxsd	%xmm1, %xmm0
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
               	movups	-0x100(%rbp), %xmm0
               	movups	-0xf0(%rbp), %xmm1
               	cmpeqpd	%xmm1, %xmm0
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
               	movups	-0x100(%rbp), %xmm0
               	movups	-0xf0(%rbp), %xmm1
               	cmpltpd	%xmm1, %xmm0
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
               	movups	-0x100(%rbp), %xmm0
               	movups	-0xf0(%rbp), %xmm1
               	cmplepd	%xmm1, %xmm0
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
               	movups	-0xf0(%rbp), %xmm0
               	movups	-0x100(%rbp), %xmm1
               	cmpltpd	%xmm1, %xmm0
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
               	movups	-0xf0(%rbp), %xmm0
               	movups	-0x100(%rbp), %xmm1
               	cmplepd	%xmm1, %xmm0
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
               	movups	-0x100(%rbp), %xmm0
               	movups	-0xf0(%rbp), %xmm1
               	cmpneqpd	%xmm1, %xmm0
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
               	movups	-0x100(%rbp), %xmm0
               	movups	-0xf0(%rbp), %xmm1
               	cmpnltpd	%xmm1, %xmm0
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
               	movups	-0x100(%rbp), %xmm0
               	movups	-0xf0(%rbp), %xmm1
               	cmpnlepd	%xmm1, %xmm0
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
               	movups	-0xf0(%rbp), %xmm0
               	movups	-0x100(%rbp), %xmm1
               	cmpnltpd	%xmm1, %xmm0
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
               	movups	-0xf0(%rbp), %xmm0
               	movups	-0x100(%rbp), %xmm1
               	cmpnlepd	%xmm1, %xmm0
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
               	movups	-0x100(%rbp), %xmm0
               	movups	-0xf0(%rbp), %xmm1
               	cmpordpd	%xmm1, %xmm0
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
               	movups	-0x100(%rbp), %xmm0
               	movups	-0xf0(%rbp), %xmm1
               	cmpunordpd	%xmm1, %xmm0
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
               	movups	-0x100(%rbp), %xmm0
               	movups	-0xf0(%rbp), %xmm1
               	cmpeqsd	%xmm1, %xmm0
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
               	movups	-0x100(%rbp), %xmm0
               	movups	-0xf0(%rbp), %xmm1
               	cmplesd	%xmm1, %xmm0
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
               	movups	-0x100(%rbp), %xmm0
               	movups	-0xf0(%rbp), %xmm1
               	cmplesd	%xmm0, %xmm1
               	movups	%xmm1, -0x90(%rbp)
               	movups	%xmm0, -0xe0(%rbp)
               	movq	-0x90(%rbp), %rax
               	movq	%rax, -0xe0(%rbp)
               	movups	-0xe0(%rbp), %xmm0
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
               	movups	-0x100(%rbp), %xmm0
               	movups	-0xf0(%rbp), %xmm1
               	cmpnltsd	%xmm0, %xmm1
               	movups	%xmm1, -0x90(%rbp)
               	movups	%xmm0, -0xe0(%rbp)
               	movq	-0x90(%rbp), %rax
               	movq	%rax, -0xe0(%rbp)
               	movups	-0xe0(%rbp), %xmm0
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
               	movups	-0x100(%rbp), %xmm0
               	movups	-0xf0(%rbp), %xmm1
               	cmpordsd	%xmm1, %xmm0
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
               	movsd	-0x100(%rbp), %xmm0
               	movsd	-0xf0(%rbp), %xmm1
               	comisd	%xmm0, %xmm1
               	jb	<addr>
               	movsd	-0x100(%rbp), %xmm0
               	movsd	-0xf0(%rbp), %xmm1
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
               	movsd	-0x100(%rbp), %xmm0
               	movsd	-0xf0(%rbp), %xmm1
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
               	movsd	-0x100(%rbp), %xmm0
               	movsd	-0xf0(%rbp), %xmm1
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
               	movsd	-0x100(%rbp), %xmm0
               	movsd	-0xf0(%rbp), %xmm1
               	comisd	%xmm0, %xmm1
               	jb	<addr>
               	movsd	-0x100(%rbp), %xmm0
               	movsd	-0xf0(%rbp), %xmm1
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
               	movsd	-0x100(%rbp), %xmm0
               	movsd	-0xf0(%rbp), %xmm1
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
               	movsd	-0x100(%rbp), %xmm0
               	movsd	-0xf0(%rbp), %xmm1
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
               	movsd	-0x100(%rbp), %xmm0
               	movsd	-0xf0(%rbp), %xmm1
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
               	movsd	-0x100(%rbp), %xmm0
               	movsd	-0xf0(%rbp), %xmm1
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
               	movups	-0x100(%rbp), %xmm0
               	cvtsd2si	%xmm0, %eax
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
               	movups	-0x100(%rbp), %xmm0
               	cvttsd2si	%xmm0, %eax
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
               	movups	-0x100(%rbp), %xmm0
               	cvtsd2si	%xmm0, %rax
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
               	movups	-0x100(%rbp), %xmm0
               	cvttsd2si	%xmm0, %rax
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
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movsd	%xmm0, -0xe0(%rbp)
               	movups	-0xe0(%rbp), %xmm0
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
               	leaq	-0xe0(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movsd	%xmm0, -0xe0(%rbp)
               	movups	-0xe0(%rbp), %xmm0
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
               	movups	-0x100(%rbp), %xmm0
               	cvtpd2dq	%xmm0, %xmm0
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
               	movups	-0x100(%rbp), %xmm0
               	cvttpd2dq	%xmm0, %xmm0
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
               	movups	-0xf0(%rbp), %xmm0
               	cvtdq2pd	%xmm0, %xmm0
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
               	movups	-0x100(%rbp), %xmm0
               	cvtpd2ps	%xmm0, %xmm0
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
               	leaq	-0x100(%rbp), %rax
               	movups	0x80(%rsp), %xmm14
               	movups	%xmm14, -0x90(%rbp)
               	leaq	-0xe0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	-0xe0(%rbp), %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, -0x90(%rbp)
               	movups	-0x90(%rbp), %xmm0
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
               	leaq	-0x100(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x80(%rsp), %xmm14
               	movups	%xmm14, -0xe0(%rbp)
               	movss	-0xe0(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movsd	%xmm0, -0x90(%rbp)
               	movups	-0x90(%rbp), %xmm0
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
               	movq	-0x100(%rbp), %rax
               	movq	-0xf0(%rbp), %rcx
               	leaq	-0xe0(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rax, -0xe0(%rbp)
               	movq	%rcx, -0xd8(%rbp)
               	movups	-0xe0(%rbp), %xmm0
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
               	movq	-0xf8(%rbp), %rax
               	movq	-0xe8(%rbp), %rcx
               	leaq	-0xe0(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rax, -0xe0(%rbp)
               	movq	%rcx, -0xd8(%rbp)
               	movups	-0xe0(%rbp), %xmm0
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
               	movq	-0xf8(%rbp), %rax
               	movq	-0xf0(%rbp), %rcx
               	leaq	-0xe0(%rbp), %rdx
               	movq	%rcx, -0xe0(%rbp)
               	movq	%rax, -0xd8(%rbp)
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
               	movq	-0x100(%rbp), %rax
               	movq	-0xf8(%rbp), %rcx
               	testq	%rax, %rax
               	setl	%al
               	movzbq	%al, %rax
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
               	leaq	-0x70(%rbp), %rdx
               	movq	-0x100(%rbp), %rcx
               	movq	-0xf8(%rbp), %rsi
               	leaq	-0x90(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rsi, -0x90(%rbp)
               	movq	%rcx, -0x88(%rbp)
               	leaq	-0xe0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	-0x70(%rbp), %xmm0
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
               	leaq	-0xf0(%rbp), %rcx
               	leaq	-0x90(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xe0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	-0x70(%rbp), %rax
               	movq	%rax, -0xd8(%rbp)
               	movups	-0xe0(%rbp), %xmm0
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
               	movq	-0xe8(%rbp), %rax
               	movq	-0x68(%rbp), %rcx
               	leaq	-0xe0(%rbp), %rdx
               	movq	%rcx, -0xe0(%rbp)
               	movq	%rax, -0xd8(%rbp)
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
               	movq	-0xe8(%rbp), %rcx
               	movq	%rcx, -0x70(%rbp)
               	xorl	%eax, %eax
               	leaq	-0xe0(%rbp), %rdx
               	movq	%rcx, -0xe0(%rbp)
               	movq	%rax, -0xd8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	-0x70(%rbp), %rax
               	leaq	-0xe0(%rbp), %rdx
               	movq	%rax, -0xe0(%rbp)
               	movq	%rax, -0xd8(%rbp)
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
               	movups	-0x100(%rbp), %xmm0
               	movups	-0xf0(%rbp), %xmm1
               	pmuludq	%xmm1, %xmm0
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
               	subq	$0xa0, %rsp
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
               	leaq	-0xa0(%rbp), %r9
               	movups	-0x40(%rbp), %xmm0
               	movups	%xmm0, -0xa0(%rbp)
               	leaq	-0x90(%rbp), %rax
               	movups	-0x30(%rbp), %xmm0
               	movups	%xmm0, -0x90(%rbp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	-0x80(%rbp), %r9
               	movups	-0x20(%rbp), %xmm0
               	movups	%xmm0, -0x80(%rbp)
               	leaq	-0x70(%rbp), %rax
               	movups	-0x10(%rbp), %xmm0
               	movups	%xmm0, -0x70(%rbp)
               	leaq	-0x60(%rbp), %rcx
               	movups	-0x30(%rbp), %xmm0
               	movups	%xmm0, -0x60(%rbp)
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
               	xorl	%eax, %eax
               	movl	$0x3f800000, %edx       # imm = 0x3F800000
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
               	movabsq	$-0x61c8864680b583eb, %r11 # imm = 0x9E3779B97F4A7C15
               	imulq	%r11, %rcx
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
               	leaq	-0x90(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movss	%xmm0, -0x90(%rbp)
               	movss	%xmm0, -0x8c(%rbp)
               	movss	%xmm0, -0x88(%rbp)
               	movss	%xmm0, -0x84(%rbp)
               	movups	-0x90(%rbp), %xmm1
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x3f800000, -0x70(%rbp) # imm = 0x3F800000
               	movl	$0x3f800000, -0x6c(%rbp) # imm = 0x3F800000
               	movl	$0x3f800000, -0x68(%rbp) # imm = 0x3F800000
               	movl	$0x3f800000, -0x64(%rbp) # imm = 0x3F800000
               	movups	-0x70(%rbp), %xmm2
               	movapd	%xmm2, %xmm15
               	divps	%xmm1, %xmm15
               	movapd	%xmm15, %xmm1
               	movups	%xmm1, -0x20(%rbp)
               	leaq	-0x80(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movss	%xmm0, -0x80(%rbp)
               	movss	%xmm0, -0x7c(%rbp)
               	movss	%xmm0, -0x78(%rbp)
               	movss	%xmm0, -0x74(%rbp)
               	movups	-0x80(%rbp), %xmm1
               	leaq	-0x60(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x3f800000, -0x60(%rbp) # imm = 0x3F800000
               	movl	$0x3f800000, -0x5c(%rbp) # imm = 0x3F800000
               	movl	$0x3f800000, -0x58(%rbp) # imm = 0x3F800000
               	movl	$0x3f800000, -0x54(%rbp) # imm = 0x3F800000
               	sqrtps	%xmm1, %xmm1
               	movups	-0x60(%rbp), %xmm2
               	movapd	%xmm2, %xmm15
               	divps	%xmm1, %xmm15
               	movapd	%xmm15, %xmm1
               	movups	%xmm1, -0x10(%rbp)
               	movss	-0x20(%rbp), %xmm1
               	cvtss2sd	%xmm0, %xmm0
               	cvtss2sd	%xmm1, %xmm1
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm15
               	vfmsub213sd	%xmm15, %xmm0, %xmm1 # xmm1 = (xmm0 * xmm1) - xmm15
               	movss	-0x10(%rbp), %xmm2
               	mulss	%xmm2, %xmm2
               	cvtss2sd	%xmm2, %xmm2
               	movq	%rcx, %xmm15
               	vfmsub213sd	%xmm15, %xmm2, %xmm0 # xmm0 = (xmm2 * xmm0) - xmm15
               	movabsq	$0x3f38000000000000, %rcx # imm = 0x3F38000000000000
               	movq	%rcx, %xmm15
               	comisd	%xmm15, %xmm1
               	ja	<addr>
               	movabsq	$-0x40c8000000000000, %rcx # imm = 0xBF38000000000000
               	movq	%rcx, %xmm15
               	comisd	%xmm1, %xmm15
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
