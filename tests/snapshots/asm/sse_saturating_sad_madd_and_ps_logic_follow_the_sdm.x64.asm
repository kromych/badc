
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

<check_sad_madd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x60(%rbp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x50(%rbp), %xmm1
               	psadbw	%xmm0, %xmm1
               	leaq	-0x40(%rbp), %rax
               	movups	%xmm1, -0x40(%rbp)
               	movups	-0x50(%rbp), %xmm1
               	pmaddubsw	%xmm1, %xmm0
               	leaq	-0x50(%rbp), %rcx
               	movups	%xmm0, -0x50(%rbp)
               	leaq	-0x20(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x10(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%r9d, %r9d
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	movq	%r9, %r8
               	shlq	$0x3, %r8
               	leaq	(%r8,%rax), %rcx
               	movzbq	(%rdi,%rcx), %rbx
               	movzbq	(%rsi,%rcx), %r12
               	cmpl	%r12d, %ebx
               	jle	<addr>
               	movzbq	(%rdi,%rcx), %r8
               	movzbq	(%rsi,%rcx), %rcx
               	negq	%rcx
               	addq	%r8, %rcx
               	jmp	<addr>
               	leaq	(%r8,%rax), %rcx
               	movzbq	(%rsi,%rcx), %r8
               	movzbq	(%rdi,%rcx), %rcx
               	negq	%rcx
               	addq	%r8, %rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	%r9, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x28(%rbp), %rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	incq	%r9
               	cmpl	$0x2, %r9d
               	jl	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	%rcx
               	movzbq	(%rdi,%rcx), %rdx
               	movzbq	(%rsi,%rcx), %r8
               	movsbq	%r8b, %r8
               	imulq	%r8, %rdx
               	leaq	0x1(%rcx), %r8
               	movzbq	(%rdi,%r8), %r9
               	movzbq	(%rsi,%r8), %rbx
               	movsbq	%bl, %rbx
               	imulq	%rbx, %r9
               	addq	%rdx, %r9
               	movq	$-0x8000, %rdx          # imm = 0x8000
               	movl	$0x7fff, %ebx           # imm = 0x7FFF
               	cmpq	%rdx, %r9
               	jge	<addr>
               	leaq	-0x10(%rbp), %r9
               	movzbq	(%r9,%rcx), %rcx
               	movzbq	(%r9,%r8), %r8
               	shlq	$0x8, %r8
               	orq	%r8, %rcx
               	movswq	%cx, %rcx
               	cmpl	%edx, %ecx
               	je	<addr>
               	jmp	<addr>
               	cmpq	%rbx, %r9
               	jle	<addr>
               	movq	%rbx, %rdx
               	jmp	<addr>
               	movq	%r9, %rdx
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<check_ps_logic>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movups	(%rdi), %xmm1
               	movups	(%rsi), %xmm0
               	leaq	-0x50(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movapd	%xmm1, %xmm2
               	andps	%xmm0, %xmm2
               	movups	%xmm2, -0x50(%rbp)
               	movapd	%xmm1, %xmm2
               	andnps	%xmm0, %xmm2
               	movups	%xmm2, -0x40(%rbp)
               	movapd	%xmm1, %xmm2
               	orps	%xmm0, %xmm2
               	movups	%xmm2, -0x30(%rbp)
               	xorps	%xmm1, %xmm0
               	movups	%xmm0, -0x20(%rbp)
               	xorl	%edx, %edx
               	leaq	-0x10(%rbp), %r8
               	leaq	-0x50(%rbp), %rax
               	movq	%rdx, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rax
               	movups	(%rax), %xmm0
               	movups	%xmm0, (%r8)
               	xorl	%eax, %eax
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	(%rdi,%rax), %rcx
               	movzbq	(%rsi,%rax), %r9
               	andq	%r9, %rcx
               	movzbq	(%r8,%rax), %r9
               	cmpl	%ecx, %r9d
               	je	<addr>
               	jmp	<addr>
               	cmpl	$0x1, %edx
               	jne	<addr>
               	movzbq	(%rdi,%rax), %rcx
               	xorq	$-0x1, %rcx
               	andq	$0xff, %rcx
               	movzbq	(%rsi,%rax), %r9
               	andq	%r9, %rcx
               	jmp	<addr>
               	cmpl	$0x2, %edx
               	jne	<addr>
               	movzbq	(%rdi,%rax), %rcx
               	movzbq	(%rsi,%rax), %r9
               	orq	%r9, %rcx
               	jmp	<addr>
               	movzbq	(%rdi,%rax), %rcx
               	movzbq	(%rsi,%rax), %r9
               	xorq	%r9, %rcx
               	movzbq	(%r8,%rax), %r9
               	cmpl	%ecx, %r9d
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x4, %edx
               	jl	<addr>
               	leaq	-0x10(%rbp), %rax
               	movups	%xmm1, (%rax)
               	movl	$0x10, %edx
               	movq	%rdi, %rsi
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	leave
               	retq
               	movl	$0x1, %eax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r10d, %r10d
               	movq	%r10, 0xe0(%rsp)
               	leaq	-0x30(%rbp), %rdx
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
               	leaq	-0x20(%rbp), %rdx
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
               	leaq	-0x30(%rbp), %r9
               	leaq	-0x20(%rbp), %rbx
               	leaq	-0xf0(%rbp), %rax
               	movups	(%r9), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xe0(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xd0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	movups	%xmm14, 0x60(%rax)
               	movups	%xmm14, 0x70(%rax)
               	movups	-0xf0(%rbp), %xmm0
               	movups	-0xe0(%rbp), %xmm1
               	paddsb	%xmm0, %xmm1
               	movups	%xmm1, -0xd0(%rbp)
               	movups	-0xe0(%rbp), %xmm1
               	paddsw	%xmm1, %xmm0
               	movups	%xmm0, -0xc0(%rbp)
               	movups	-0xf0(%rbp), %xmm0
               	movups	-0xe0(%rbp), %xmm1
               	movapd	%xmm0, %xmm2
               	paddusb	%xmm1, %xmm2
               	movups	%xmm2, -0xb0(%rbp)
               	paddusw	%xmm1, %xmm0
               	movups	%xmm0, -0xa0(%rbp)
               	movups	-0xf0(%rbp), %xmm0
               	movups	-0xe0(%rbp), %xmm1
               	movapd	%xmm0, %xmm2
               	psubsb	%xmm1, %xmm2
               	movups	%xmm2, -0x90(%rbp)
               	psubsw	%xmm1, %xmm0
               	movups	%xmm0, -0x80(%rbp)
               	movups	-0xf0(%rbp), %xmm0
               	movups	-0xe0(%rbp), %xmm1
               	movapd	%xmm0, %xmm2
               	psubusb	%xmm1, %xmm2
               	movups	%xmm2, -0x70(%rbp)
               	psubusw	%xmm1, %xmm0
               	movups	%xmm0, -0x60(%rbp)
               	xorl	%r10d, %r10d
               	movq	%r10, 0xe8(%rsp)
               	movq	0xe8(%rsp), %rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	testb	$0x1, %al
               	je	<addr>
               	movl	$0x2, %r8d
               	movq	0xe8(%rsp), %rax
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
               	leaq	-0x10(%rbp), %rax
               	leaq	-0xd0(%rbp), %rcx
               	movq	0xe8(%rsp), %rdx
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
               	leaq	-0x10(%rbp), %rax
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
               	movq	0xe8(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0xe8(%rsp)
               	movq	0xe8(%rsp), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x30(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	0xe0(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xe0(%rsp), %rax
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
