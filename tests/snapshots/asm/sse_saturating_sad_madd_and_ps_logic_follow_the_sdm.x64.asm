
sse_saturating_sad_madd_and_ps_logic_follow_the_sdm.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2b8, %rsp            # imm = 0x2B8
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r10d, %r10d
               	movq	%r10, 0x250(%rsp)
               	leaq	-0x70(%rbp), %rdx
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
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x70(%rbp), %r9
               	leaq	-0x60(%rbp), %rbx
               	leaq	-0x2b0(%rbp), %rax
               	movups	(%r9), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x2a0(%rbp), %rcx
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x290(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movups	%xmm14, 0x10(%rdx)
               	movups	%xmm14, 0x20(%rdx)
               	movups	%xmm14, 0x30(%rdx)
               	movups	%xmm14, 0x40(%rdx)
               	movups	%xmm14, 0x50(%rdx)
               	movups	%xmm14, 0x60(%rdx)
               	movups	%xmm14, 0x70(%rdx)
               	leaq	-0x210(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	paddsb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x2b0(%rbp), %rax
               	leaq	-0x2a0(%rbp), %rdx
               	leaq	-0x200(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	paddsw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x290(%rbp), %rdx
               	leaq	0x10(%rdx), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0x2a0(%rbp), %rsi
               	leaq	-0x1f0(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rsi), %xmm14
               	paddusb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	0x20(%rdx), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x2b0(%rbp), %rax
               	leaq	-0x2a0(%rbp), %rdx
               	leaq	-0x1e0(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	paddusw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x290(%rbp), %rdx
               	leaq	0x30(%rdx), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0x2a0(%rbp), %rsi
               	leaq	-0x1d0(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rsi), %xmm14
               	psubsb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	0x40(%rdx), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x2b0(%rbp), %rax
               	leaq	-0x2a0(%rbp), %rdx
               	leaq	-0x1c0(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	psubsw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x290(%rbp), %rdx
               	leaq	0x50(%rdx), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0x2a0(%rbp), %rsi
               	leaq	-0x1b0(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rsi), %xmm14
               	psubusb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	0x60(%rdx), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x2b0(%rbp), %rcx
               	leaq	-0x2a0(%rbp), %rdx
               	leaq	-0x1a0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	psubusw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x290(%rbp), %rcx
               	addq	$0x70, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%r10d, %r10d
               	movq	%r10, 0x258(%rsp)
               	movq	0x258(%rsp), %rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	testb	$0x1, %al
               	je	<addr>
               	movl	$0x2, %r8d
               	movq	0x258(%rsp), %rax
               	movq	%rax, %rdi
               	andq	$0x2, %rdi
               	cmpl	$0x4, %eax
               	setge	%r14b
               	movzbq	%r14b, %r14
               	testl	%edi, %edi
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%r8, %rcx
               	shlq	$0x3, %rcx
               	decq	%rcx
               	shlxq	%rcx, %rax, %rax
               	movq	%rax, %r12
               	negq	%r12
               	testl	%edi, %edi
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%r8, %rcx
               	shlq	$0x3, %rcx
               	decq	%rcx
               	shlxq	%rcx, %rax, %rax
               	leaq	-0x1(%rax), %r13
               	leaq	-0x50(%rbp), %rax
               	leaq	-0x290(%rbp), %rcx
               	movq	0x258(%rsp), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x10, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%eax, %ecx
               	jge	<addr>
               	cmpl	$0x1, %r8d
               	jne	<addr>
               	testl	%edi, %edi
               	jne	<addr>
               	movzbq	(%r9,%rcx), %rax
               	movsbq	%al, %rax
               	cmpl	$0x1, %r8d
               	jne	<addr>
               	testl	%edi, %edi
               	jne	<addr>
               	movzbq	(%rbx,%rcx), %rdx
               	movsbq	%dl, %rdx
               	testq	%r14, %r14
               	je	<addr>
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	cmpq	%r12, %rsi
               	jge	<addr>
               	movq	%r12, %rsi
               	leaq	-0x50(%rbp), %rax
               	cmpl	$0x1, %r8d
               	jne	<addr>
               	testl	%edi, %edi
               	jne	<addr>
               	movzbq	(%rax,%rcx), %rax
               	movsbq	%al, %rax
               	cmpq	%rsi, %rax
               	je	<addr>
               	jmp	<addr>
               	movzbq	(%rax,%rcx), %rax
               	jmp	<addr>
               	movq	%rcx, %rdx
               	shlq	%rdx
               	movslq	%edx, %rdx
               	movzbq	(%rax,%rdx), %r15
               	incq	%rdx
               	movslq	%edx, %rdx
               	movzbq	(%rax,%rdx), %rax
               	shlq	$0x8, %rax
               	orq	%r15, %rax
               	testl	%edi, %edi
               	jne	<addr>
               	movswq	%ax, %rax
               	jmp	<addr>
               	cmpq	%r13, %rsi
               	jle	<addr>
               	movq	%r13, %rsi
               	jmp	<addr>
               	leaq	(%rax,%rdx), %rsi
               	jmp	<addr>
               	movzbq	(%rbx,%rcx), %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	shlq	%rdx
               	movslq	%edx, %rdx
               	movzbq	(%rbx,%rdx), %rsi
               	incq	%rdx
               	movslq	%edx, %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	shlq	$0x8, %rdx
               	orq	%rsi, %rdx
               	testl	%edi, %edi
               	jne	<addr>
               	movswq	%dx, %rdx
               	jmp	<addr>
               	movzbq	(%r9,%rcx), %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	shlq	%rax
               	movslq	%eax, %rax
               	movzbq	(%r9,%rax), %rdx
               	incq	%rax
               	movslq	%eax, %rax
               	movzbq	(%r9,%rax), %rax
               	shlq	$0x8, %rax
               	orq	%rdx, %rax
               	testl	%edi, %edi
               	jne	<addr>
               	movswq	%ax, %rax
               	jmp	<addr>
               	incq	%rcx
               	movl	$0x10, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%eax, %ecx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%r8, %rcx
               	shlq	$0x3, %rcx
               	shlxq	%rcx, %rax, %rax
               	leaq	-0x1(%rax), %r13
               	jmp	<addr>
               	xorl	%r12d, %r12d
               	jmp	<addr>
               	movl	$0x1, %r8d
               	jmp	<addr>
               	movq	0x258(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0x258(%rsp)
               	movq	0x258(%rsp), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x70(%rbp), %rdx
               	leaq	-0x60(%rbp), %rsi
               	leaq	-0x2a0(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x290(%rbp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x170(%rbp), %rdi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	psadbw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	leaq	-0x190(%rbp), %rcx
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x290(%rbp), %r8
               	leaq	-0x160(%rbp), %rdi
               	movdqu	(%rax), %xmm15
               	movdqu	(%r8), %xmm14
               	pmaddubsw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	leaq	-0x180(%rbp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x30(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	-0x40(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%edi, %edi
               	xorl	%eax, %eax
               	movq	%rax, %r8
               	movq	%rdi, %rcx
               	shlq	$0x3, %rcx
               	addq	%rax, %rcx
               	movzbq	(%rdx,%rcx), %r9
               	movzbq	(%rsi,%rcx), %rbx
               	cmpl	%ebx, %r9d
               	jle	<addr>
               	movzbq	(%rdx,%rcx), %r9
               	movzbq	(%rsi,%rcx), %rcx
               	negq	%rcx
               	addq	%r9, %rcx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	shlq	$0x3, %rcx
               	addq	%rax, %rcx
               	movzbq	(%rsi,%rcx), %r9
               	movzbq	(%rdx,%rcx), %rcx
               	negq	%rcx
               	addq	%r9, %rcx
               	addq	%rcx, %r8
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x78(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	movq	%rdi, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x78(%rbp), %rax
               	cmpq	%r8, %rax
               	jne	<addr>
               	incq	%rdi
               	cmpl	$0x2, %edi
               	jl	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	%rcx
               	movzbq	(%rdx,%rcx), %rdi
               	movzbq	(%rsi,%rcx), %r8
               	movsbq	%r8b, %r8
               	imulq	%r8, %rdi
               	leaq	0x1(%rcx), %r8
               	movzbq	(%rdx,%r8), %r9
               	movzbq	(%rsi,%r8), %rbx
               	movsbq	%bl, %rbx
               	imulq	%rbx, %r9
               	addq	%rdi, %r9
               	movq	$-0x8000, %rdi          # imm = 0x8000
               	movl	$0x7fff, %ebx           # imm = 0x7FFF
               	cmpq	%rdi, %r9
               	jge	<addr>
               	leaq	-0x40(%rbp), %r9
               	movzbq	(%r9,%rcx), %rcx
               	movzbq	(%r9,%r8), %r8
               	shlq	$0x8, %r8
               	orq	%r8, %rcx
               	movswq	%cx, %rcx
               	cmpl	%edi, %ecx
               	je	<addr>
               	jmp	<addr>
               	cmpq	%rbx, %r9
               	jle	<addr>
               	movq	%rbx, %rdi
               	jmp	<addr>
               	movq	%r9, %rdi
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x70(%rbp), %rsi
               	leaq	-0x60(%rbp), %rdx
               	leaq	-0x100(%rbp), %rax
               	movdqu	(%rsi), %xmm15
               	movdqu	%xmm15, (%rax)
               	movups	-0x100(%rbp), %xmm0
               	leaq	-0x2a0(%rbp), %rdi
               	movups	%xmm0, -0x2a0(%rbp)
               	leaq	-0xf0(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movups	-0xf0(%rbp), %xmm0
               	leaq	-0x150(%rbp), %r8
               	movups	%xmm0, -0x150(%rbp)
               	leaq	-0x140(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	leaq	-0xe0(%rbp), %rcx
               	movdqu	(%rdi), %xmm15
               	movdqu	(%r8), %xmm14
               	andps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x2a0(%rbp), %rax
               	leaq	-0x150(%rbp), %rdi
               	leaq	-0xd0(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdi), %xmm14
               	andnps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x140(%rbp), %rdi
               	leaq	0x10(%rdi), %r8
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	-0x150(%rbp), %r8
               	leaq	-0xc0(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%r8), %xmm14
               	orps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	0x20(%rdi), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x2a0(%rbp), %rcx
               	leaq	-0x150(%rbp), %rdi
               	leaq	-0xb0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdi), %xmm14
               	xorps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x140(%rbp), %rcx
               	addq	$0x30, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%edi, %edi
               	leaq	-0x30(%rbp), %r8
               	leaq	-0x140(%rbp), %rax
               	movq	%rdi, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rax
               	movups	(%rax), %xmm0
               	leaq	-0x290(%rbp), %rax
               	movups	%xmm0, -0x290(%rbp)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%r8)
               	xorl	%eax, %eax
               	testl	%edi, %edi
               	jne	<addr>
               	movzbq	(%rsi,%rax), %rcx
               	movzbq	(%rdx,%rax), %r9
               	andq	%r9, %rcx
               	movzbq	(%r8,%rax), %r9
               	cmpl	%ecx, %r9d
               	je	<addr>
               	jmp	<addr>
               	cmpl	$0x1, %edi
               	jne	<addr>
               	movzbq	(%rsi,%rax), %rcx
               	xorq	$-0x1, %rcx
               	andq	$0xff, %rcx
               	movzbq	(%rdx,%rax), %r9
               	andq	%r9, %rcx
               	jmp	<addr>
               	cmpl	$0x2, %edi
               	jne	<addr>
               	movzbq	(%rsi,%rax), %rcx
               	movzbq	(%rdx,%rax), %r9
               	orq	%r9, %rcx
               	jmp	<addr>
               	movzbq	(%rsi,%rax), %rcx
               	movzbq	(%rdx,%rax), %r9
               	xorq	%r9, %rcx
               	movzbq	(%r8,%rax), %r9
               	cmpl	%ecx, %r9d
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	incq	%rdi
               	cmpl	$0x4, %edi
               	jl	<addr>
               	movups	-0x2a0(%rbp), %xmm0
               	leaq	-0x30(%rbp), %rdi
               	leaq	-0x290(%rbp), %rax
               	movups	%xmm0, -0x290(%rbp)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x250(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0x250(%rsp)
               	movq	0x250(%rsp), %rax
               	cmpl	$0xc8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x8c, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x8b, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x8a, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
