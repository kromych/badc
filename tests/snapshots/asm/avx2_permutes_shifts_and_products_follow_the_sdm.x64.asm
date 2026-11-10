
avx2_permutes_shifts_and_products_follow_the_sdm.x64:	file format elf64-x86-64

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

<_mm256_setr_epi8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x60(%rbp)
               	movsbq	%sil, %rsi
               	movsbq	%r9b, %r9
               	movsbq	%r8b, %r8
               	movsbq	%cl, %rcx
               	movsbq	%dl, %rdx
               	movq	-0x60(%rbp), %rax
               	leaq	(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movb	%sil, (%rsp)
               	movb	%dl, 0x1(%rsp)
               	movb	%cl, 0x2(%rsp)
               	movb	%r8b, 0x3(%rsp)
               	movb	%r9b, 0x4(%rsp)
               	movsbq	0x10(%rbp), %rcx
               	movb	%cl, 0x5(%rsp)
               	movsbq	0x18(%rbp), %rcx
               	movb	%cl, 0x6(%rsp)
               	movsbq	0x20(%rbp), %rcx
               	movb	%cl, 0x7(%rsp)
               	movsbq	0x28(%rbp), %rcx
               	movb	%cl, 0x8(%rsp)
               	movsbq	0x30(%rbp), %rcx
               	movb	%cl, 0x9(%rsp)
               	movsbq	0x38(%rbp), %rcx
               	movb	%cl, 0xa(%rsp)
               	movsbq	0x40(%rbp), %rcx
               	movb	%cl, 0xb(%rsp)
               	movsbq	0x48(%rbp), %rcx
               	movb	%cl, 0xc(%rsp)
               	movsbq	0x50(%rbp), %rcx
               	movb	%cl, 0xd(%rsp)
               	movsbq	0x58(%rbp), %rcx
               	movb	%cl, 0xe(%rsp)
               	movsbq	0x60(%rbp), %rcx
               	movb	%cl, 0xf(%rsp)
               	movsbq	0x68(%rbp), %rcx
               	movb	%cl, 0x10(%rsp)
               	movsbq	0x70(%rbp), %rcx
               	movb	%cl, 0x11(%rsp)
               	movsbq	0x78(%rbp), %rcx
               	movb	%cl, 0x12(%rsp)
               	movsbq	0x80(%rbp), %rcx
               	movb	%cl, 0x13(%rsp)
               	movsbq	0x88(%rbp), %rcx
               	movb	%cl, 0x14(%rsp)
               	movsbq	0x90(%rbp), %rcx
               	movb	%cl, 0x15(%rsp)
               	movsbq	0x98(%rbp), %rcx
               	movb	%cl, 0x16(%rsp)
               	movsbq	0xa0(%rbp), %rcx
               	movb	%cl, 0x17(%rsp)
               	movsbq	0xa8(%rbp), %rcx
               	movb	%cl, 0x18(%rsp)
               	movsbq	0xb0(%rbp), %rcx
               	movb	%cl, 0x19(%rsp)
               	movsbq	0xb8(%rbp), %rcx
               	movb	%cl, 0x1a(%rsp)
               	movsbq	0xc0(%rbp), %rcx
               	movb	%cl, 0x1b(%rsp)
               	movsbq	0xc8(%rbp), %rcx
               	leaq	(%rsp), %rdx
               	movb	%cl, 0x1c(%rsp)
               	movsbq	0xd0(%rbp), %rcx
               	movb	%cl, 0x1d(%rsp)
               	movsbq	0xd8(%rbp), %rcx
               	movb	%cl, 0x1e(%rsp)
               	movsbq	0xe0(%rbp), %rcx
               	movb	%cl, 0x1f(%rsp)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<fnv>:
               	xorl	%eax, %eax
               	movabsq	$0x100000001b3, %rcx    # imm = 0x100000001B3
               	movzbq	(%rsi,%rax), %rdx
               	xorq	%rdi, %rdx
               	movq	%rdx, %rdi
               	imulq	%rcx, %rdi
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rdi, %rax
               	retq

<round_of>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x100, %rsp            # imm = 0x100
               	andq	$-0x20, %rsp
               	leaq	-0x60(%rbp), %rdx
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %r8
               	shrq	$0xc, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %r8
               	shlq	$0x19, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
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
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdx
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %r8
               	shrq	$0xc, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %r8
               	shlq	$0x19, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
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
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	-0x80(%rbp), %rdx
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %r8
               	shrq	$0xc, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %r8
               	shlq	$0x19, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
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
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x70(%rbp), %rdx
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %r8
               	shrq	$0xc, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %r8
               	shlq	$0x19, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
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
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	-0x60(%rbp), %rax
               	movq	-0x58(%rbp), %rcx
               	movq	-0x50(%rbp), %rdx
               	movq	-0x48(%rbp), %rsi
               	movq	%rax, (%rsp)
               	movq	%rcx, 0x8(%rsp)
               	movq	%rdx, 0x10(%rsp)
               	movq	%rsi, 0x18(%rsp)
               	leaq	-0x40(%rbp), %rax
               	movq	-0x40(%rbp), %rcx
               	movq	-0x38(%rbp), %rdx
               	movq	-0x30(%rbp), %rsi
               	movq	-0x28(%rbp), %rdi
               	movq	%rcx, 0x20(%rsp)
               	movq	%rdx, 0x28(%rsp)
               	movq	%rsi, 0x30(%rsp)
               	movq	%rdi, 0x38(%rsp)
               	leaq	0x60(%rsp), %rcx
               	leaq	-0x80(%rbp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x80(%rsp), %rcx
               	leaq	-0x70(%rbp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x78(%rbp), %rcx
               	movl	(%rax), %r10d
               	movl	%r10d, (%rcx)
               	leaq	-0x68(%rbp), %rcx
               	addq	$0x8, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movq	0x60(%rsp), %rax
               	movq	0x68(%rsp), %rcx
               	leaq	0x40(%rsp), %rdx
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rax, 0x50(%rsp)
               	movq	%rcx, 0x58(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	0x60(%rsp), %rax
               	movq	0x68(%rsp), %rcx
               	movq	0x80(%rsp), %rsi
               	movq	0x88(%rsp), %rdi
               	leaq	0x40(%rsp), %rdx
               	movq	%rsi, 0x40(%rsp)
               	movq	%rdi, 0x48(%rsp)
               	movq	%rax, 0x50(%rsp)
               	movq	%rcx, 0x58(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	0x60(%rsp), %rcx
               	movq	0x68(%rsp), %rsi
               	xorl	%eax, %eax
               	leaq	0x40(%rsp), %rdx
               	movq	%rcx, 0x40(%rsp)
               	movq	%rsi, 0x48(%rsp)
               	movq	%rax, 0x50(%rsp)
               	movq	%rax, 0x58(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	(%rsp), %eax
               	movl	0x4(%rsp), %ecx
               	movl	0x8(%rsp), %edx
               	movl	0xc(%rsp), %esi
               	movl	0x10(%rsp), %edi
               	movl	0x14(%rsp), %r8d
               	movl	0x18(%rsp), %r9d
               	movl	0x1c(%rsp), %ebx
               	movl	0x20(%rsp), %r12d
               	movl	0x24(%rsp), %r13d
               	movl	0x28(%rsp), %r14d
               	movl	0x2c(%rsp), %r15d
               	movl	0x30(%rsp), %r10d
               	movq	%r10, -0x88(%rbp)
               	movl	0x34(%rsp), %r10d
               	movq	%r10, -0x90(%rbp)
               	movl	0x38(%rsp), %r10d
               	movq	%r10, -0x98(%rbp)
               	movl	0x3c(%rsp), %r10d
               	movq	%r10, -0xa0(%rbp)
               	cmpl	%r12d, %eax
               	setg	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movl	%eax, 0x40(%rsp)
               	cmpl	%r13d, %ecx
               	setg	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movl	%eax, 0x44(%rsp)
               	cmpl	%r14d, %edx
               	setg	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movl	%eax, 0x48(%rsp)
               	cmpl	%r15d, %esi
               	setg	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movl	%eax, 0x4c(%rsp)
               	cmpl	-0x88(%rbp), %edi
               	setg	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movl	%eax, 0x50(%rsp)
               	cmpl	-0x90(%rbp), %r8d
               	setg	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movl	%eax, 0x54(%rsp)
               	cmpl	-0x98(%rbp), %r9d
               	setg	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movl	%eax, 0x58(%rsp)
               	cmpl	-0xa0(%rbp), %ebx
               	setg	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movl	%eax, 0x5c(%rsp)
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rcx
               	movq	0x50(%rsp), %rsi
               	movq	0x58(%rsp), %rdi
               	leaq	0x40(%rsp), %rdx
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rsi, 0x50(%rsp)
               	movq	%rdi, 0x58(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	movq	0x38(%rsp), %rbx
               	cmpq	%rdi, %rax
               	setg	%al
               	movzbq	%al, %rax
               	negq	%rax
               	cmpq	%r8, %rcx
               	setg	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	cmpq	%r9, %rdx
               	setg	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %rdi
               	negq	%rdi
               	cmpq	%rbx, %rsi
               	setg	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %rsi
               	negq	%rsi
               	leaq	0x40(%rsp), %rdx
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rdi, 0x50(%rsp)
               	movq	%rsi, 0x58(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movzbq	(%rsp), %rax
               	movq	%rax, -0x28(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x28(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movzbq	0x11(%rsp), %rax
               	movq	%rax, -0x28(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x28(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movzbq	0x1f(%rsp), %rax
               	movq	%rax, -0x28(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x28(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movslq	0x8(%rsp), %rax
               	movq	%rax, -0x28(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x28(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movslq	0x1c(%rsp), %rax
               	movq	%rax, -0x28(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x28(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	0x8(%rsp), %rax
               	movq	%rax, -0x28(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x28(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	0x18(%rsp), %rax
               	movq	%rax, -0x28(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x28(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %rcx
               	movl	-0x78(%rbp), %edx
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movb	%dl, 0x45(%rsp)
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rcx
               	movq	0x50(%rsp), %rsi
               	movq	0x58(%rsp), %rdi
               	leaq	0x60(%rsp), %rdx
               	movq	%rax, 0x60(%rsp)
               	movq	%rcx, 0x68(%rsp)
               	movq	%rsi, 0x70(%rsp)
               	movq	%rdi, 0x78(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %rcx
               	movl	-0x78(%rbp), %edx
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movb	%dl, 0x5e(%rsp)
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rcx
               	movq	0x50(%rsp), %rsi
               	movq	0x58(%rsp), %rdi
               	leaq	0x40(%rsp), %rdx
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rsi, 0x50(%rsp)
               	movq	%rdi, 0x58(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %rcx
               	movl	-0x78(%rbp), %edx
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movl	%edx, 0x58(%rsp)
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rcx
               	movq	0x50(%rsp), %rsi
               	movq	0x58(%rsp), %rdi
               	leaq	0x40(%rsp), %rdx
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rsi, 0x50(%rsp)
               	movq	%rdi, 0x58(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	-0x68(%rbp), %rax
               	movq	(%rsp), %rcx
               	movq	0x8(%rsp), %rsi
               	movq	0x18(%rsp), %rdi
               	leaq	0x40(%rsp), %rdx
               	movq	%rcx, 0x40(%rsp)
               	movq	%rsi, 0x48(%rsp)
               	movq	%rax, 0x50(%rsp)
               	movq	%rdi, 0x58(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	movq	0x38(%rsp), %rbx
               	leaq	0xc0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	leaq	0xc0(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdi, 0xc0(%rsp)
               	movq	%r8, 0xc8(%rsp)
               	movups	0xc0(%rsp), %xmm1
               	pmaddwd	%xmm1, %xmm0
               	leaq	0xd0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xd0(%rsp)
               	movq	%rsi, 0xd8(%rsp)
               	movups	0xd0(%rsp), %xmm1
               	leaq	0xd0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r9, 0xd0(%rsp)
               	movq	%rbx, 0xd8(%rsp)
               	movups	0xd0(%rsp), %xmm2
               	pmaddwd	%xmm2, %xmm1
               	movups	%xmm0, 0xe0(%rsp)
               	movups	%xmm1, 0xf0(%rsp)
               	movq	0xe0(%rsp), %rax
               	movq	0xe8(%rsp), %rcx
               	movq	0xf0(%rsp), %rsi
               	movq	0xf8(%rsp), %rdi
               	leaq	0x40(%rsp), %rdx
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rsi, 0x50(%rsp)
               	movq	%rdi, 0x58(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	movq	0x38(%rsp), %rbx
               	leaq	0xc0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	leaq	0xc0(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdi, 0xc0(%rsp)
               	movq	%r8, 0xc8(%rsp)
               	movups	0xc0(%rsp), %xmm1
               	pmaddubsw	%xmm1, %xmm0
               	leaq	0xd0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xd0(%rsp)
               	movq	%rsi, 0xd8(%rsp)
               	movups	0xd0(%rsp), %xmm1
               	leaq	0xd0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r9, 0xd0(%rsp)
               	movq	%rbx, 0xd8(%rsp)
               	movups	0xd0(%rsp), %xmm2
               	pmaddubsw	%xmm2, %xmm1
               	movups	%xmm0, 0xe0(%rsp)
               	movups	%xmm1, 0xf0(%rsp)
               	movq	0xe0(%rsp), %rax
               	movq	0xe8(%rsp), %rcx
               	movq	0xf0(%rsp), %rsi
               	movq	0xf8(%rsp), %rdi
               	leaq	0x40(%rsp), %rdx
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rsi, 0x50(%rsp)
               	movq	%rdi, 0x58(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	movq	0x38(%rsp), %rbx
               	movl	%eax, %eax
               	movl	%ecx, %ecx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edi, %edi
               	movl	%r8d, %r8d
               	movl	%r9d, %r9d
               	movl	%ebx, %ebx
               	imulq	%rdi, %rax
               	imulq	%r8, %rcx
               	imulq	%rdx, %r9
               	imulq	%rbx, %rsi
               	leaq	0x40(%rsp), %rdx
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%r9, 0x50(%rsp)
               	movq	%rsi, 0x58(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	(%rsp), %eax
               	movl	0x4(%rsp), %ecx
               	movl	0x8(%rsp), %edx
               	movl	0xc(%rsp), %esi
               	movl	0x10(%rsp), %edi
               	movl	0x14(%rsp), %r8d
               	movl	0x18(%rsp), %r9d
               	movl	0x1c(%rsp), %ebx
               	movl	0x20(%rsp), %r12d
               	movl	0x24(%rsp), %r13d
               	movl	0x28(%rsp), %r14d
               	movl	0x2c(%rsp), %r15d
               	movl	0x30(%rsp), %r10d
               	movq	%r10, -0x88(%rbp)
               	movl	0x34(%rsp), %r10d
               	movq	%r10, -0x90(%rbp)
               	movl	0x38(%rsp), %r10d
               	movq	%r10, -0x98(%rbp)
               	movl	0x3c(%rsp), %r10d
               	movq	%r10, -0xa0(%rbp)
               	imulq	%r12, %rax
               	movl	%eax, 0x40(%rsp)
               	imulq	%r13, %rcx
               	movl	%ecx, 0x44(%rsp)
               	imulq	%r14, %rdx
               	movl	%edx, 0x48(%rsp)
               	imulq	%r15, %rsi
               	movl	%esi, 0x4c(%rsp)
               	imulq	-0x88(%rbp), %rdi
               	movl	%edi, 0x50(%rsp)
               	imulq	-0x90(%rbp), %r8
               	movl	%r8d, 0x54(%rsp)
               	imulq	-0x98(%rbp), %r9
               	movl	%r9d, 0x58(%rsp)
               	imulq	-0xa0(%rbp), %rbx
               	movl	%ebx, 0x5c(%rsp)
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rcx
               	movq	0x50(%rsp), %rsi
               	movq	0x58(%rsp), %rdi
               	leaq	0x40(%rsp), %rdx
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rsi, 0x50(%rsp)
               	movq	%rdi, 0x58(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0xa0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x60(%rsp), %r9
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	xorl	%esi, %esi
               	movq	%rsi, %rax
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	sarxq	%rcx, %rsi, %rcx
               	testb	$0x2, %cl
               	je	<addr>
               	movq	%r9, %rdx
               	leaq	0x40(%rsp), %rdi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x80(%rsp), %rbx
               	movq	%rax, %r8
               	shlq	%r8
               	testb	$0x8, %cl
               	je	<addr>
               	xorl	%edx, %edx
               	movq	%rdx, (%rbx,%r8,8)
               	leaq	0x80(%rsp), %rdx
               	leaq	0x1(%r8), %rdi
               	testb	$0x8, %cl
               	je	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	leaq	0x40(%rsp), %r8
               	andq	$0x1, %rcx
               	shlq	%rcx
               	incq	%rcx
               	movq	(%r8,%rcx,8), %rcx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	andq	$0x1, %rdx
               	shlq	%rdx
               	movq	(%rdi,%rdx,8), %rdx
               	jmp	<addr>
               	leaq	0xa0(%rsp), %rdx
               	jmp	<addr>
               	movq	%rcx, (%rdx,%rdi,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movq	0x80(%rsp), %rax
               	movq	0x88(%rsp), %rcx
               	movq	0x90(%rsp), %rsi
               	movq	0x98(%rsp), %rdi
               	leaq	0x60(%rsp), %rdx
               	movq	%rax, 0x60(%rsp)
               	movq	%rcx, 0x68(%rsp)
               	movq	%rsi, 0x70(%rsp)
               	movq	%rdi, 0x78(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0xa0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x60(%rsp), %r8
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	movl	$0x31, %r9d
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	sarxq	%rcx, %r9, %rcx
               	testb	$0x2, %cl
               	je	<addr>
               	movq	%r8, %rdx
               	leaq	0x40(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x80(%rsp), %rbx
               	movq	%rax, %rdi
               	shlq	%rdi
               	testb	$0x8, %cl
               	je	<addr>
               	xorl	%edx, %edx
               	movq	%rdx, (%rbx,%rdi,8)
               	leaq	0x80(%rsp), %rdx
               	leaq	0x1(%rdi), %rsi
               	testb	$0x8, %cl
               	je	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	leaq	0x40(%rsp), %rdi
               	andq	$0x1, %rcx
               	shlq	%rcx
               	incq	%rcx
               	movq	(%rdi,%rcx,8), %rcx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	andq	$0x1, %rdx
               	shlq	%rdx
               	movq	(%rsi,%rdx,8), %rdx
               	jmp	<addr>
               	leaq	0xa0(%rsp), %rdx
               	jmp	<addr>
               	movq	%rcx, (%rdx,%rsi,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movq	0x80(%rsp), %rax
               	movq	0x88(%rsp), %rcx
               	movq	0x90(%rsp), %rsi
               	movq	0x98(%rsp), %rdi
               	leaq	0x60(%rsp), %rdx
               	movq	%rax, 0x60(%rsp)
               	movq	%rcx, 0x68(%rsp)
               	movq	%rsi, 0x70(%rsp)
               	movq	%rdi, 0x78(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0xa0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x60(%rsp), %r8
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	movl	$0x12, %r9d
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	sarxq	%rcx, %r9, %rcx
               	testb	$0x2, %cl
               	je	<addr>
               	movq	%r8, %rdx
               	leaq	0x40(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x80(%rsp), %rbx
               	movq	%rax, %rdi
               	shlq	%rdi
               	testb	$0x8, %cl
               	je	<addr>
               	xorl	%edx, %edx
               	movq	%rdx, (%rbx,%rdi,8)
               	leaq	0x80(%rsp), %rdx
               	leaq	0x1(%rdi), %rsi
               	testb	$0x8, %cl
               	je	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	leaq	0x40(%rsp), %rdi
               	andq	$0x1, %rcx
               	shlq	%rcx
               	incq	%rcx
               	movq	(%rdi,%rcx,8), %rcx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	andq	$0x1, %rdx
               	shlq	%rdx
               	movq	(%rsi,%rdx,8), %rdx
               	jmp	<addr>
               	leaq	0xa0(%rsp), %rdx
               	jmp	<addr>
               	movq	%rcx, (%rdx,%rsi,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movq	0x80(%rsp), %rax
               	movq	0x88(%rsp), %rcx
               	movq	0x90(%rsp), %rsi
               	movq	0x98(%rsp), %rdi
               	leaq	0x60(%rsp), %rdx
               	movq	%rax, 0x60(%rsp)
               	movq	%rcx, 0x68(%rsp)
               	movq	%rsi, 0x70(%rsp)
               	movq	%rdi, 0x78(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0xa0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x60(%rsp), %r8
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	movl	$0x83, %r9d
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	sarxq	%rcx, %r9, %rcx
               	testb	$0x2, %cl
               	je	<addr>
               	movq	%r8, %rdx
               	leaq	0x40(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x80(%rsp), %rbx
               	movq	%rax, %rdi
               	shlq	%rdi
               	testb	$0x8, %cl
               	je	<addr>
               	xorl	%edx, %edx
               	movq	%rdx, (%rbx,%rdi,8)
               	leaq	0x80(%rsp), %rdx
               	leaq	0x1(%rdi), %rsi
               	testb	$0x8, %cl
               	je	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	leaq	0x40(%rsp), %rdi
               	andq	$0x1, %rcx
               	shlq	%rcx
               	incq	%rcx
               	movq	(%rdi,%rcx,8), %rcx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	andq	$0x1, %rdx
               	shlq	%rdx
               	movq	(%rsi,%rdx,8), %rdx
               	jmp	<addr>
               	leaq	0xa0(%rsp), %rdx
               	jmp	<addr>
               	movq	%rcx, (%rdx,%rsi,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movq	0x80(%rsp), %rax
               	movq	0x88(%rsp), %rcx
               	movq	0x90(%rsp), %rsi
               	movq	0x98(%rsp), %rdi
               	leaq	0x60(%rsp), %rdx
               	movq	%rax, 0x60(%rsp)
               	movq	%rcx, 0x68(%rsp)
               	movq	%rsi, 0x70(%rsp)
               	movq	%rdi, 0x78(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0xa0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x60(%rsp), %r8
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	movl	$0x28, %r9d
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	sarxq	%rcx, %r9, %rcx
               	testb	$0x2, %cl
               	je	<addr>
               	movq	%r8, %rdx
               	leaq	0x40(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x80(%rsp), %rbx
               	movq	%rax, %rdi
               	shlq	%rdi
               	testb	$0x8, %cl
               	je	<addr>
               	xorl	%edx, %edx
               	movq	%rdx, (%rbx,%rdi,8)
               	leaq	0x80(%rsp), %rdx
               	leaq	0x1(%rdi), %rsi
               	testb	$0x8, %cl
               	je	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	leaq	0x40(%rsp), %rdi
               	andq	$0x1, %rcx
               	shlq	%rcx
               	incq	%rcx
               	movq	(%rdi,%rcx,8), %rcx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	andq	$0x1, %rdx
               	shlq	%rdx
               	movq	(%rsi,%rdx,8), %rdx
               	jmp	<addr>
               	leaq	0xa0(%rsp), %rdx
               	jmp	<addr>
               	movq	%rcx, (%rdx,%rsi,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movq	0x80(%rsp), %rax
               	movq	0x88(%rsp), %rcx
               	movq	0x90(%rsp), %rsi
               	movq	0x98(%rsp), %rdi
               	leaq	0x40(%rsp), %rdx
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rsi, 0x50(%rsp)
               	movq	%rdi, 0x58(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rsi
               	movq	0x18(%rsp), %rdi
               	leaq	0x40(%rsp), %rdx
               	movq	%rdi, 0x40(%rsp)
               	movq	%rsi, 0x48(%rsp)
               	movq	%rcx, 0x50(%rsp)
               	movq	%rax, 0x58(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rsi
               	movq	0x18(%rsp), %rdi
               	leaq	0x40(%rsp), %rdx
               	movq	%rax, 0x40(%rsp)
               	movq	%rsi, 0x48(%rsp)
               	movq	%rcx, 0x50(%rsp)
               	movq	%rdi, 0x58(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movl	0x20(%rsp), %eax
               	movl	0x24(%rsp), %ecx
               	movl	0x28(%rsp), %edx
               	movl	0x2c(%rsp), %esi
               	movl	0x30(%rsp), %edi
               	movl	0x34(%rsp), %r8d
               	movl	0x38(%rsp), %r9d
               	movl	0x3c(%rsp), %ebx
               	leaq	0x40(%rsp), %r12
               	leaq	0x80(%rsp), %r13
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%r13)
               	movups	0x10(%r12), %xmm14
               	movups	%xmm14, 0x10(%r13)
               	leaq	0x80(%rsp), %r12
               	andq	$0x7, %rax
               	movl	(%r12,%rax,4), %eax
               	movl	%eax, 0x40(%rsp)
               	leaq	0x80(%rsp), %rax
               	andq	$0x7, %rcx
               	movl	(%rax,%rcx,4), %eax
               	movl	%eax, 0x44(%rsp)
               	leaq	0x80(%rsp), %rax
               	andq	$0x7, %rdx
               	movl	(%rax,%rdx,4), %eax
               	movl	%eax, 0x48(%rsp)
               	leaq	0x80(%rsp), %rax
               	andq	$0x7, %rsi
               	movl	(%rax,%rsi,4), %eax
               	movl	%eax, 0x4c(%rsp)
               	leaq	0x80(%rsp), %rax
               	andq	$0x7, %rdi
               	movl	(%rax,%rdi,4), %ecx
               	movl	%ecx, 0x50(%rsp)
               	andq	$0x7, %r8
               	movl	(%rax,%r8,4), %ecx
               	movl	%ecx, 0x54(%rsp)
               	andq	$0x7, %r9
               	movl	(%rax,%r9,4), %eax
               	movl	%eax, 0x58(%rsp)
               	leaq	0x80(%rsp), %rax
               	andq	$0x7, %rbx
               	movl	(%rax,%rbx,4), %eax
               	movl	%eax, 0x5c(%rsp)
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rcx
               	movq	0x50(%rsp), %rsi
               	movq	0x58(%rsp), %rdi
               	leaq	0x40(%rsp), %rdx
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rsi, 0x50(%rsp)
               	movq	%rdi, 0x58(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	movq	0x38(%rsp), %rbx
               	leaq	0xc0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	leaq	0xc0(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdi, 0xc0(%rsp)
               	movq	%r8, 0xc8(%rsp)
               	movups	0xc0(%rsp), %xmm1
               	psadbw	%xmm1, %xmm0
               	leaq	0xd0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xd0(%rsp)
               	movq	%rsi, 0xd8(%rsp)
               	movups	0xd0(%rsp), %xmm1
               	leaq	0xd0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r9, 0xd0(%rsp)
               	movq	%rbx, 0xd8(%rsp)
               	movups	0xd0(%rsp), %xmm2
               	psadbw	%xmm2, %xmm1
               	movups	%xmm0, 0xe0(%rsp)
               	movups	%xmm1, 0xf0(%rsp)
               	movq	0xe0(%rsp), %rax
               	movq	0xe8(%rsp), %rcx
               	movq	0xf0(%rsp), %rsi
               	movq	0xf8(%rsp), %rdi
               	leaq	0x40(%rsp), %rdx
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rsi, 0x50(%rsp)
               	movq	%rdi, 0x58(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	movq	0x38(%rsp), %rbx
               	leaq	0xc0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	leaq	0xc0(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdi, 0xc0(%rsp)
               	movq	%r8, 0xc8(%rsp)
               	movups	0xc0(%rsp), %xmm1
               	pshufb	%xmm1, %xmm0
               	leaq	0xd0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xd0(%rsp)
               	movq	%rsi, 0xd8(%rsp)
               	movups	0xd0(%rsp), %xmm1
               	leaq	0xd0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r9, 0xd0(%rsp)
               	movq	%rbx, 0xd8(%rsp)
               	movups	0xd0(%rsp), %xmm2
               	pshufb	%xmm2, %xmm1
               	movups	%xmm0, 0xe0(%rsp)
               	movups	%xmm1, 0xf0(%rsp)
               	movq	0xe0(%rsp), %rax
               	movq	0xe8(%rsp), %rcx
               	movq	0xf0(%rsp), %rsi
               	movq	0xf8(%rsp), %rdi
               	leaq	0x40(%rsp), %rdx
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rsi, 0x50(%rsp)
               	movq	%rdi, 0x58(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	(%rsp), %eax
               	movl	0x4(%rsp), %ecx
               	movl	0x8(%rsp), %edx
               	movl	0xc(%rsp), %esi
               	movl	0x10(%rsp), %edi
               	movl	0x14(%rsp), %r8d
               	movl	0x18(%rsp), %r9d
               	movl	0x1c(%rsp), %ebx
               	movl	%eax, 0x40(%rsp)
               	movl	%ecx, 0x44(%rsp)
               	movl	%edx, 0x48(%rsp)
               	movl	%esi, 0x4c(%rsp)
               	movl	%edi, 0x50(%rsp)
               	movl	%r8d, 0x54(%rsp)
               	movl	%r9d, 0x58(%rsp)
               	movl	%ebx, 0x5c(%rsp)
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rcx
               	movq	0x50(%rsp), %rsi
               	movq	0x58(%rsp), %rdi
               	leaq	0x80(%rsp), %rdx
               	movq	%rax, 0x80(%rsp)
               	movq	%rcx, 0x88(%rsp)
               	movq	%rsi, 0x90(%rsp)
               	movq	%rdi, 0x98(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	(%rsp), %eax
               	movl	0x4(%rsp), %ecx
               	movl	0x8(%rsp), %edx
               	movl	0xc(%rsp), %esi
               	movl	0x10(%rsp), %edi
               	movl	0x14(%rsp), %r8d
               	movl	0x18(%rsp), %r9d
               	movl	0x1c(%rsp), %ebx
               	shlq	$0x7, %rax
               	movl	%eax, 0x40(%rsp)
               	shlq	$0x7, %rcx
               	movl	%ecx, 0x44(%rsp)
               	shlq	$0x7, %rdx
               	movl	%edx, 0x48(%rsp)
               	shlq	$0x7, %rsi
               	movl	%esi, 0x4c(%rsp)
               	shlq	$0x7, %rdi
               	movl	%edi, 0x50(%rsp)
               	shlq	$0x7, %r8
               	movl	%r8d, 0x54(%rsp)
               	shlq	$0x7, %r9
               	movl	%r9d, 0x58(%rsp)
               	shlq	$0x7, %rbx
               	movl	%ebx, 0x5c(%rsp)
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rcx
               	movq	0x50(%rsp), %rsi
               	movq	0x58(%rsp), %rdi
               	leaq	0x80(%rsp), %rdx
               	movq	%rax, 0x80(%rsp)
               	movq	%rcx, 0x88(%rsp)
               	movq	%rsi, 0x90(%rsp)
               	movq	%rdi, 0x98(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	(%rsp), %eax
               	movl	0x4(%rsp), %ecx
               	movl	0x8(%rsp), %edx
               	movl	0xc(%rsp), %esi
               	movl	0x10(%rsp), %edi
               	movl	0x14(%rsp), %r8d
               	movl	0x18(%rsp), %r9d
               	movl	0x1c(%rsp), %ebx
               	shlq	$0x1f, %rax
               	movl	%eax, 0x40(%rsp)
               	shlq	$0x1f, %rcx
               	movl	%ecx, 0x44(%rsp)
               	shlq	$0x1f, %rdx
               	movl	%edx, 0x48(%rsp)
               	shlq	$0x1f, %rsi
               	movl	%esi, 0x4c(%rsp)
               	shlq	$0x1f, %rdi
               	movl	%edi, 0x50(%rsp)
               	shlq	$0x1f, %r8
               	movl	%r8d, 0x54(%rsp)
               	shlq	$0x1f, %r9
               	movl	%r9d, 0x58(%rsp)
               	shlq	$0x1f, %rbx
               	movl	%ebx, 0x5c(%rsp)
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rcx
               	movq	0x50(%rsp), %rsi
               	movq	0x58(%rsp), %rdi
               	leaq	0x40(%rsp), %rdx
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rsi, 0x50(%rsp)
               	movq	%rdi, 0x58(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x40(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x40(%rsp), %rsi
               	movq	$0x0, 0x40(%rsp)
               	movq	$0x0, 0x48(%rsp)
               	movq	$0x0, 0x50(%rsp)
               	movq	$0x0, 0x58(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	shlq	$0xd, %rax
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, %rax
               	shlq	$0xd, %rax
               	movq	%rax, 0x48(%rsp)
               	movq	%rdx, %rcx
               	shlq	$0xd, %rcx
               	movq	%rcx, 0x50(%rsp)
               	movq	%rsi, %rdx
               	shlq	$0xd, %rdx
               	movq	%rdx, 0x58(%rsp)
               	movq	0x40(%rsp), %rdi
               	leaq	0x80(%rsp), %rsi
               	movq	%rdi, 0x80(%rsp)
               	movq	%rax, 0x88(%rsp)
               	movq	%rcx, 0x90(%rsp)
               	movq	%rdx, 0x98(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	shlq	$0x3f, %rax
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, %rax
               	shlq	$0x3f, %rax
               	movq	%rax, 0x48(%rsp)
               	movq	%rdx, %rcx
               	shlq	$0x3f, %rcx
               	movq	%rcx, 0x50(%rsp)
               	movq	%rsi, %rdx
               	shlq	$0x3f, %rdx
               	movq	%rdx, 0x58(%rsp)
               	movq	0x40(%rsp), %rdi
               	leaq	0x40(%rsp), %rsi
               	movq	%rdi, 0x40(%rsp)
               	movq	%rax, 0x48(%rsp)
               	movq	%rcx, 0x50(%rsp)
               	movq	%rdx, 0x58(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x40(%rsp), %rsi
               	movq	$0x0, 0x40(%rsp)
               	movq	$0x0, 0x48(%rsp)
               	movq	$0x0, 0x50(%rsp)
               	movq	$0x0, 0x58(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	(%rsp), %eax
               	movl	0x4(%rsp), %ecx
               	movl	0x8(%rsp), %edx
               	movl	0xc(%rsp), %esi
               	movl	0x10(%rsp), %edi
               	movl	0x14(%rsp), %r8d
               	movl	0x18(%rsp), %r9d
               	movl	0x1c(%rsp), %ebx
               	shrq	$0x5, %rax
               	movl	%eax, 0x40(%rsp)
               	shrq	$0x5, %rcx
               	movl	%ecx, 0x44(%rsp)
               	shrq	$0x5, %rdx
               	movl	%edx, 0x48(%rsp)
               	shrq	$0x5, %rsi
               	movl	%esi, 0x4c(%rsp)
               	shrq	$0x5, %rdi
               	movl	%edi, 0x50(%rsp)
               	shrq	$0x5, %r8
               	movl	%r8d, 0x54(%rsp)
               	shrq	$0x5, %r9
               	movl	%r9d, 0x58(%rsp)
               	shrq	$0x5, %rbx
               	movl	%ebx, 0x5c(%rsp)
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rcx
               	movq	0x50(%rsp), %rdx
               	movq	0x58(%rsp), %rdi
               	leaq	0x40(%rsp), %rsi
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rdx, 0x50(%rsp)
               	movq	%rdi, 0x58(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x40(%rsp), %rsi
               	movq	$0x0, 0x40(%rsp)
               	movq	$0x0, 0x48(%rsp)
               	movq	$0x0, 0x50(%rsp)
               	movq	$0x0, 0x58(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	shrq	$0x21, %rax
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, %rax
               	shrq	$0x21, %rax
               	movq	%rax, 0x48(%rsp)
               	movq	%rdx, %rcx
               	shrq	$0x21, %rcx
               	movq	%rcx, 0x50(%rsp)
               	movq	%rsi, %rdx
               	shrq	$0x21, %rdx
               	movq	%rdx, 0x58(%rsp)
               	movq	0x40(%rsp), %rdi
               	leaq	0x40(%rsp), %rsi
               	movq	%rdi, 0x40(%rsp)
               	movq	%rax, 0x48(%rsp)
               	movq	%rcx, 0x50(%rsp)
               	movq	%rdx, 0x58(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x40(%rsp), %rsi
               	movq	$0x0, 0x40(%rsp)
               	movq	$0x0, 0x48(%rsp)
               	movq	$0x0, 0x50(%rsp)
               	movq	$0x0, 0x58(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0xc0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	movups	0xc0(%rsp), %xmm0
               	pslldq	$0x0, %xmm0             # xmm0 = xmm0[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	leaq	0xd0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xd0(%rsp)
               	movq	%rsi, 0xd8(%rsp)
               	movups	0xd0(%rsp), %xmm1
               	pslldq	$0x0, %xmm1             # xmm1 = xmm1[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	movups	%xmm0, 0xe0(%rsp)
               	movups	%xmm1, 0xf0(%rsp)
               	movq	0xe0(%rsp), %rax
               	movq	0xe8(%rsp), %rcx
               	movq	0xf0(%rsp), %rdx
               	movq	0xf8(%rsp), %rdi
               	leaq	0x40(%rsp), %rsi
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rdx, 0x50(%rsp)
               	movq	%rdi, 0x58(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0xc0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	movups	0xc0(%rsp), %xmm0
               	pslldq	$0x3, %xmm0             # xmm0 = zero,zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11,12]
               	leaq	0xd0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xd0(%rsp)
               	movq	%rsi, 0xd8(%rsp)
               	movups	0xd0(%rsp), %xmm1
               	pslldq	$0x3, %xmm1             # xmm1 = zero,zero,zero,xmm1[0,1,2,3,4,5,6,7,8,9,10,11,12]
               	movups	%xmm0, 0xe0(%rsp)
               	movups	%xmm1, 0xf0(%rsp)
               	movq	0xe0(%rsp), %rax
               	movq	0xe8(%rsp), %rcx
               	movq	0xf0(%rsp), %rdx
               	movq	0xf8(%rsp), %rdi
               	leaq	0x40(%rsp), %rsi
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rdx, 0x50(%rsp)
               	movq	%rdi, 0x58(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0xc0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	movups	0xc0(%rsp), %xmm0
               	pslldq	$0xf, %xmm0             # xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0]
               	leaq	0xd0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xd0(%rsp)
               	movq	%rsi, 0xd8(%rsp)
               	movups	0xd0(%rsp), %xmm1
               	pslldq	$0xf, %xmm1             # xmm1 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,xmm1[0]
               	movups	%xmm0, 0xe0(%rsp)
               	movups	%xmm1, 0xf0(%rsp)
               	movq	0xe0(%rsp), %rax
               	movq	0xe8(%rsp), %rcx
               	movq	0xf0(%rsp), %rdx
               	movq	0xf8(%rsp), %rdi
               	leaq	0x40(%rsp), %rsi
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rdx, 0x50(%rsp)
               	movq	%rdi, 0x58(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0xc0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	movups	0xc0(%rsp), %xmm0
               	pslldq	$0x10, %xmm0            # xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
               	leaq	0xd0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xd0(%rsp)
               	movq	%rsi, 0xd8(%rsp)
               	movups	0xd0(%rsp), %xmm1
               	pslldq	$0x10, %xmm1            # xmm1 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
               	movups	%xmm0, 0xe0(%rsp)
               	movups	%xmm1, 0xf0(%rsp)
               	movq	0xe0(%rsp), %rax
               	movq	0xe8(%rsp), %rcx
               	movq	0xf0(%rsp), %rdx
               	movq	0xf8(%rsp), %rdi
               	leaq	0x40(%rsp), %rsi
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rdx, 0x50(%rsp)
               	movq	%rdi, 0x58(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0xc0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	movups	0xc0(%rsp), %xmm0
               	psrldq	$0x1, %xmm0             # xmm0 = xmm0[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],zero
               	leaq	0xd0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xd0(%rsp)
               	movq	%rsi, 0xd8(%rsp)
               	movups	0xd0(%rsp), %xmm1
               	psrldq	$0x1, %xmm1             # xmm1 = xmm1[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],zero
               	movups	%xmm0, 0xe0(%rsp)
               	movups	%xmm1, 0xf0(%rsp)
               	movq	0xe0(%rsp), %rax
               	movq	0xe8(%rsp), %rcx
               	movq	0xf0(%rsp), %rdx
               	movq	0xf8(%rsp), %rdi
               	leaq	0x40(%rsp), %rsi
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rdx, 0x50(%rsp)
               	movq	%rdi, 0x58(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0xc0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	movups	0xc0(%rsp), %xmm0
               	psrldq	$0x9, %xmm0             # xmm0 = xmm0[9,10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero
               	leaq	0xd0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xd0(%rsp)
               	movq	%rsi, 0xd8(%rsp)
               	movups	0xd0(%rsp), %xmm1
               	psrldq	$0x9, %xmm1             # xmm1 = xmm1[9,10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero
               	movups	%xmm0, 0xe0(%rsp)
               	movups	%xmm1, 0xf0(%rsp)
               	movq	0xe0(%rsp), %rax
               	movq	0xe8(%rsp), %rcx
               	movq	0xf0(%rsp), %rdx
               	movq	0xf8(%rsp), %rdi
               	leaq	0x40(%rsp), %rsi
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rdx, 0x50(%rsp)
               	movq	%rdi, 0x58(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0xc0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	movups	0xc0(%rsp), %xmm0
               	psrldq	$0x10, %xmm0            # xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
               	leaq	0xd0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xd0(%rsp)
               	movq	%rsi, 0xd8(%rsp)
               	movups	0xd0(%rsp), %xmm1
               	psrldq	$0x10, %xmm1            # xmm1 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
               	movups	%xmm0, 0xe0(%rsp)
               	movups	%xmm1, 0xf0(%rsp)
               	movq	0xe0(%rsp), %rax
               	movq	0xe8(%rsp), %rcx
               	movq	0xf0(%rsp), %rdx
               	movq	0xf8(%rsp), %rdi
               	leaq	0x40(%rsp), %rsi
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rdx, 0x50(%rsp)
               	movq	%rdi, 0x58(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	movq	0x38(%rsp), %rbx
               	leaq	0x40(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	leaq	0x40(%rsp), %rax
               	movups	0x40(%rsp), %xmm0
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdi, 0x40(%rsp)
               	movq	%r8, 0x48(%rsp)
               	movups	0x40(%rsp), %xmm1
               	psubusw	%xmm1, %xmm0
               	leaq	0x40(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0x40(%rsp)
               	movq	%rsi, 0x48(%rsp)
               	movups	0x40(%rsp), %xmm1
               	leaq	0x40(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r9, 0x40(%rsp)
               	movq	%rbx, 0x48(%rsp)
               	movups	0x40(%rsp), %xmm2
               	psubusw	%xmm2, %xmm1
               	movups	%xmm0, 0x80(%rsp)
               	movups	%xmm1, 0x40(%rsp)
               	movq	0x80(%rsp), %rax
               	movq	0x88(%rsp), %rcx
               	movq	0x40(%rsp), %rdx
               	movq	0x48(%rsp), %rdi
               	leaq	0x40(%rsp), %rsi
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rdx, 0x50(%rsp)
               	movq	%rdi, 0x58(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	(%rsp), %eax
               	movl	0x4(%rsp), %ecx
               	movl	0x10(%rsp), %edx
               	movl	0x14(%rsp), %esi
               	movl	0x20(%rsp), %edi
               	movl	0x24(%rsp), %r8d
               	movl	0x30(%rsp), %r9d
               	movl	0x34(%rsp), %ebx
               	leaq	0x40(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movups	%xmm14, 0x10(%r12)
               	movl	%eax, 0x40(%rsp)
               	movl	%edi, 0x44(%rsp)
               	movl	%ecx, 0x48(%rsp)
               	movl	%r8d, 0x4c(%rsp)
               	movl	%edx, 0x50(%rsp)
               	movl	%r9d, 0x54(%rsp)
               	movl	%esi, 0x58(%rsp)
               	movl	%ebx, 0x5c(%rsp)
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rcx
               	movq	0x50(%rsp), %rdx
               	movq	0x58(%rsp), %rdi
               	leaq	0x40(%rsp), %rsi
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rdx, 0x50(%rsp)
               	movq	%rdi, 0x58(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	0x8(%rsp), %eax
               	movl	0xc(%rsp), %ecx
               	movl	0x18(%rsp), %edx
               	movl	0x1c(%rsp), %esi
               	movl	0x28(%rsp), %edi
               	movl	0x2c(%rsp), %r8d
               	movl	0x38(%rsp), %r9d
               	movl	0x3c(%rsp), %ebx
               	leaq	0x40(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movups	%xmm14, 0x10(%r12)
               	movl	%eax, 0x40(%rsp)
               	movl	%edi, 0x44(%rsp)
               	movl	%ecx, 0x48(%rsp)
               	movl	%r8d, 0x4c(%rsp)
               	movl	%edx, 0x50(%rsp)
               	movl	%r9d, 0x54(%rsp)
               	movl	%esi, 0x58(%rsp)
               	movl	%ebx, 0x5c(%rsp)
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rcx
               	movq	0x50(%rsp), %rdx
               	movq	0x58(%rsp), %rdi
               	leaq	0x40(%rsp), %rsi
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rdx, 0x50(%rsp)
               	movq	%rdi, 0x58(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movq	(%rsp), %rax
               	movq	0x10(%rsp), %rcx
               	movq	0x20(%rsp), %rdx
               	movq	0x30(%rsp), %rdi
               	leaq	0x40(%rsp), %rsi
               	movq	%rax, 0x40(%rsp)
               	movq	%rdx, 0x48(%rsp)
               	movq	%rcx, 0x50(%rsp)
               	movq	%rdi, 0x58(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movq	0x8(%rsp), %rax
               	movq	0x18(%rsp), %rcx
               	movq	0x28(%rsp), %rdx
               	movq	0x38(%rsp), %rdi
               	leaq	0x40(%rsp), %rsi
               	movq	%rax, 0x40(%rsp)
               	movq	%rdx, 0x48(%rsp)
               	movq	%rcx, 0x50(%rsp)
               	movq	%rdi, 0x58(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %rax
               	movl	-0x78(%rbp), %ecx
               	movzbq	-0x5d(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movl	%edx, 0x40(%rsp)
               	movl	$0x6, 0x44(%rsp)
               	movl	$0x80000000, 0x48(%rsp) # imm = 0x80000000
               	movl	$0x7fffffff, 0x4c(%rsp) # imm = 0x7FFFFFFF
               	movl	$0x3, 0x50(%rsp)
               	movl	$0xfffffffe, 0x54(%rsp) # imm = 0xFFFFFFFE
               	movl	$0x1, 0x58(%rsp)
               	movl	%ecx, 0x5c(%rsp)
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %rax
               	movl	-0x78(%rbp), %ecx
               	movzbq	-0x5d(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movl	%ecx, 0x40(%rsp)
               	movl	$0x1, 0x44(%rsp)
               	movl	$0xfffffffe, 0x48(%rsp) # imm = 0xFFFFFFFE
               	movl	$0x3, 0x4c(%rsp)
               	movl	$0x7fffffff, 0x50(%rsp) # imm = 0x7FFFFFFF
               	movl	$0x80000000, 0x54(%rsp) # imm = 0x80000000
               	movl	$0x6, 0x58(%rsp)
               	movl	%edx, 0x5c(%rsp)
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movq	-0x68(%rbp), %rax
               	movslq	-0x78(%rbp), %rcx
               	leaq	0x40(%rsp), %rsi
               	movq	%rcx, 0x40(%rsp)
               	movq	$0x2, 0x48(%rsp)
               	movq	$-0x1, 0x50(%rsp)
               	movq	%rax, 0x58(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %rdi
               	movzbq	-0x60(%rbp), %rax
               	movsbq	%al, %rax
               	movq	$-0x80, %rsi
               	movl	$0x1e, %edx
               	movl	$0x1d, %ecx
               	movl	$0x1c, %r8d
               	movl	$0x1b, %r9d
               	subq	$0xe0, %rsp
               	movq	$0x1a, (%rsp)
               	movq	$0x19, 0x8(%rsp)
               	movq	$0x18, 0x10(%rsp)
               	movq	$0x17, 0x18(%rsp)
               	movq	$0x16, 0x20(%rsp)
               	movq	$0x15, 0x28(%rsp)
               	movq	$0x14, 0x30(%rsp)
               	movq	$0x13, 0x38(%rsp)
               	movq	$0x12, 0x40(%rsp)
               	movq	$0x11, 0x48(%rsp)
               	movq	$0x10, 0x50(%rsp)
               	movq	$0xf, 0x58(%rsp)
               	movq	$0xe, 0x60(%rsp)
               	movq	$0xd, 0x68(%rsp)
               	movq	$0xc, 0x70(%rsp)
               	movq	$0xb, 0x78(%rsp)
               	movq	$0xa, 0x80(%rsp)
               	movq	$0x9, 0x88(%rsp)
               	movq	$0x8, 0x90(%rsp)
               	movq	$0x7, 0x98(%rsp)
               	movq	$0x6, 0xa0(%rsp)
               	movq	$0x5, 0xa8(%rsp)
               	movq	$0x4, 0xb0(%rsp)
               	movq	$0x3, 0xb8(%rsp)
               	movq	$0x2, 0xc0(%rsp)
               	movq	$0x1, 0xc8(%rsp)
               	movq	%rax, 0xd0(%rsp)
               	callq	<addr>
               	addq	$0xe0, %rsp
               	leaq	0x40(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %rdi
               	movzbq	-0x60(%rbp), %rsi
               	movl	$0x1, %edx
               	movl	$0x2, %ecx
               	movl	$0x3, %r8d
               	movl	$0x4, %r9d
               	subq	$0xe0, %rsp
               	movq	$0x5, (%rsp)
               	movq	$0x6, 0x8(%rsp)
               	movq	$0x7, 0x10(%rsp)
               	movq	$0x8, 0x18(%rsp)
               	movq	$0x9, 0x20(%rsp)
               	movq	$0xa, 0x28(%rsp)
               	movq	$0xb, 0x30(%rsp)
               	movq	$0xc, 0x38(%rsp)
               	movq	$0xd, 0x40(%rsp)
               	movq	$0xe, 0x48(%rsp)
               	movq	$0xf, 0x50(%rsp)
               	movq	$0x10, 0x58(%rsp)
               	movq	$0x11, 0x60(%rsp)
               	movq	$0x12, 0x68(%rsp)
               	movq	$0x13, 0x70(%rsp)
               	movq	$0x14, 0x78(%rsp)
               	movq	$0x15, 0x80(%rsp)
               	movq	$0x16, 0x88(%rsp)
               	movq	$0x17, 0x90(%rsp)
               	movq	$0x18, 0x98(%rsp)
               	movq	$0x19, 0xa0(%rsp)
               	movq	$0x1a, 0xa8(%rsp)
               	movq	$0x1b, 0xb0(%rsp)
               	movq	$0x1c, 0xb8(%rsp)
               	movq	$0x1d, 0xc0(%rsp)
               	movq	$0x1e, 0xc8(%rsp)
               	movq	$-0x80, 0xd0(%rsp)
               	callq	<addr>
               	addq	$0xe0, %rsp
               	leaq	0x40(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	-0xe0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x340d631b7bdddcdb, %rdx # imm = 0xCBF29CE484222325
               	movq	%rdx, (%rcx,%rax,8)
               	incq	%rax
               	cmpl	$0x15, %eax
               	jl	<addr>
               	xorl	%ebx, %ebx
               	callq	<addr>
               	incq	%rbx
               	cmpl	$0x190, %ebx            # imm = 0x190
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rsi,%rcx), %rdi
               	movq	(%rdi), %rdi
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x15, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	incq	%rax
               	popq	%rbx
               	leave
               	retq
