
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
               	subq	$0x30, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movups	(%rdi), %xmm0
               	movups	(%rsi), %xmm1
               	movapd	%xmm0, %xmm2
               	psadbw	%xmm1, %xmm2
               	pmaddubsw	%xmm1, %xmm0
               	movups	%xmm2, -0x20(%rbp)
               	movups	%xmm0, -0x10(%rbp)
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
               	movq	%r9, %rdx
               	cmovgq	%rbx, %rdx
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
               	subq	$0xd8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r10d, %r10d
               	movq	%r10, 0xc0(%rsp)
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
               	leaq	-0x30(%rbp), %rdi
               	leaq	-0x20(%rbp), %r8
               	movups	-0x30(%rbp), %xmm0
               	movups	-0x20(%rbp), %xmm1
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
               	movapd	%xmm0, %xmm2
               	paddsb	%xmm1, %xmm2
               	movups	%xmm2, -0xd0(%rbp)
               	movapd	%xmm0, %xmm2
               	paddsw	%xmm1, %xmm2
               	movups	%xmm2, -0xc0(%rbp)
               	movapd	%xmm0, %xmm2
               	paddusb	%xmm1, %xmm2
               	movups	%xmm2, -0xb0(%rbp)
               	movapd	%xmm0, %xmm2
               	paddusw	%xmm1, %xmm2
               	movups	%xmm2, -0xa0(%rbp)
               	movapd	%xmm0, %xmm2
               	psubsb	%xmm1, %xmm2
               	movups	%xmm2, -0x90(%rbp)
               	movapd	%xmm0, %xmm2
               	psubsw	%xmm1, %xmm2
               	movups	%xmm2, -0x80(%rbp)
               	movapd	%xmm0, %xmm2
               	psubusb	%xmm1, %xmm2
               	movups	%xmm2, -0x70(%rbp)
               	psubusw	%xmm1, %xmm0
               	movups	%xmm0, -0x60(%rbp)
               	xorl	%r15d, %r15d
               	movl	$0x2, %eax
               	movl	$0x1, %ecx
               	testb	$0x1, %r15b
               	movq	%rcx, %rsi
               	cmovneq	%rax, %rsi
               	movq	%r15, %r9
               	andq	$0x2, %r9
               	testl	%r9d, %r9d
               	sete	%bl
               	movzbq	%bl, %rbx
               	testl	%r9d, %r9d
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	decq	%rcx
               	shlxq	%rcx, %rax, %rax
               	movq	%rax, %r12
               	negq	%r12
               	testl	%r9d, %r9d
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	decq	%rcx
               	shlxq	%rcx, %rax, %rax
               	leaq	-0x1(%rax), %r13
               	leaq	-0x10(%rbp), %rax
               	leaq	-0xd0(%rbp), %rcx
               	movq	%r15, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x10, %eax
               	cltd
               	idivl	%esi
               	cmpl	%eax, %ecx
               	jge	<addr>
               	cmpl	$0x1, %esi
               	jne	<addr>
               	testl	%r9d, %r9d
               	jne	<addr>
               	movzbq	(%rdi,%rcx), %rax
               	movsbq	%al, %rax
               	cmpl	$0x1, %esi
               	jne	<addr>
               	testl	%r9d, %r9d
               	jne	<addr>
               	movzbq	(%r8,%rcx), %rdx
               	movsbq	%dl, %rdx
               	movq	%rax, %r14
               	subq	%rdx, %r14
               	addq	%rdx, %rax
               	cmpl	$0x4, %r15d
               	cmovgeq	%r14, %rax
               	cmpq	%r12, %rax
               	jge	<addr>
               	movq	%r12, %rdx
               	leaq	-0x10(%rbp), %rax
               	cmpl	$0x1, %esi
               	jne	<addr>
               	testl	%r9d, %r9d
               	jne	<addr>
               	movzbq	(%rax,%rcx), %rax
               	movsbq	%al, %rax
               	cmpq	%rdx, %rax
               	je	<addr>
               	jmp	<addr>
               	movzbq	(%rax,%rcx), %rax
               	jmp	<addr>
               	movq	%rcx, %r14
               	shlq	%r14
               	movslq	%r14d, %r14
               	movzbq	(%rax,%r14), %r10
               	movq	%r10, 0xc8(%rsp)
               	incq	%r14
               	movslq	%r14d, %r14
               	movzbq	(%rax,%r14), %rax
               	shlq	$0x8, %rax
               	movq	%rax, %r10
               	movq	0xc8(%rsp), %rax
               	orq	%r10, %rax
               	movswq	%ax, %r14
               	testq	%rbx, %rbx
               	cmovneq	%r14, %rax
               	jmp	<addr>
               	cmpq	%r13, %rax
               	movq	%rax, %rdx
               	cmovgq	%r13, %rdx
               	jmp	<addr>
               	movzbq	(%r8,%rcx), %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	shlq	%rdx
               	movslq	%edx, %rdx
               	movzbq	(%r8,%rdx), %r14
               	incq	%rdx
               	movslq	%edx, %rdx
               	movzbq	(%r8,%rdx), %rdx
               	shlq	$0x8, %rdx
               	orq	%r14, %rdx
               	movswq	%dx, %r14
               	testq	%rbx, %rbx
               	cmovneq	%r14, %rdx
               	jmp	<addr>
               	movzbq	(%rdi,%rcx), %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	shlq	%rax
               	movslq	%eax, %rax
               	movzbq	(%rdi,%rax), %rdx
               	incq	%rax
               	movslq	%eax, %rax
               	movzbq	(%rdi,%rax), %rax
               	shlq	$0x8, %rax
               	orq	%rdx, %rax
               	movswq	%ax, %rdx
               	testq	%rbx, %rbx
               	cmovneq	%rdx, %rax
               	jmp	<addr>
               	incq	%rcx
               	movl	$0x10, %eax
               	cltd
               	idivl	%esi
               	cmpl	%eax, %ecx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	shlxq	%rcx, %rax, %rax
               	leaq	-0x1(%rax), %r13
               	jmp	<addr>
               	xorl	%r12d, %r12d
               	jmp	<addr>
               	incq	%r15
               	cmpl	$0x8, %r15d
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
               	movq	0xc0(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0xc0(%rsp)
               	movq	0xc0(%rsp), %rax
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
