
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

<check_saturating>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x148, %rsp            # imm = 0x148
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x140(%rbp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x130(%rbp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x120(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movups	%xmm14, 0x10(%rdx)
               	movups	%xmm14, 0x20(%rdx)
               	movups	%xmm14, 0x30(%rdx)
               	movups	%xmm14, 0x40(%rdx)
               	movups	%xmm14, 0x50(%rdx)
               	movups	%xmm14, 0x60(%rdx)
               	movups	%xmm14, 0x70(%rdx)
               	leaq	-0xa0(%rbp), %r8
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	paddsb	%xmm14, %xmm15
               	movdqu	%xmm15, (%r8)
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x130(%rbp), %rcx
               	leaq	-0x90(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	paddsw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x120(%rbp), %rax
               	leaq	0x10(%rax), %r8
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x80(%rbp), %r8
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rcx), %xmm14
               	paddusb	%xmm14, %xmm15
               	movdqu	%xmm15, (%r8)
               	addq	$0x20, %rax
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x130(%rbp), %rax
               	leaq	-0x70(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rax), %xmm14
               	paddusw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x120(%rbp), %rdx
               	leaq	0x30(%rdx), %r8
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	-0x140(%rbp), %rcx
               	leaq	-0x60(%rbp), %r8
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	psubsb	%xmm14, %xmm15
               	movdqu	%xmm15, (%r8)
               	leaq	0x40(%rdx), %rax
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x130(%rbp), %rax
               	leaq	-0x50(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	psubsw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x120(%rbp), %rcx
               	leaq	0x50(%rcx), %r8
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x40(%rbp), %r8
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rax), %xmm14
               	psubusb	%xmm14, %xmm15
               	movdqu	%xmm15, (%r8)
               	leaq	0x60(%rcx), %rax
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x130(%rbp), %rcx
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rcx), %xmm14
               	psubusw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x120(%rbp), %rcx
               	addq	$0x70, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%r10d, %r10d
               	movq	%r10, 0x158(%rsp)
               	movq	0x158(%rsp), %rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	testb	$0x1, %al
               	je	<addr>
               	movl	$0x2, %ebx
               	movq	0x158(%rsp), %rax
               	movq	%rax, %r9
               	andq	$0x2, %r9
               	cmpl	$0x4, %eax
               	setge	%r14b
               	movzbq	%r14b, %r14
               	testl	%r9d, %r9d
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	decq	%rcx
               	shlxq	%rcx, %rax, %rax
               	movq	%rax, %r12
               	negq	%r12
               	testl	%r9d, %r9d
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	decq	%rcx
               	shlxq	%rcx, %rax, %rax
               	leaq	-0x1(%rax), %r13
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x120(%rbp), %rcx
               	movq	0x158(%rsp), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0x10, %eax
               	cltd
               	idivl	%ebx
               	cmpl	%eax, %ecx
               	jge	<addr>
               	cmpl	$0x1, %ebx
               	jne	<addr>
               	testl	%r9d, %r9d
               	jne	<addr>
               	movzbq	(%rdi,%rcx), %rax
               	movsbq	%al, %rax
               	cmpl	$0x1, %ebx
               	jne	<addr>
               	testl	%r9d, %r9d
               	jne	<addr>
               	movzbq	(%rsi,%rcx), %rdx
               	movsbq	%dl, %rdx
               	testq	%r14, %r14
               	je	<addr>
               	movq	%rax, %r8
               	subq	%rdx, %r8
               	cmpq	%r12, %r8
               	jge	<addr>
               	movq	%r12, %r8
               	leaq	-0x10(%rbp), %rax
               	cmpl	$0x1, %ebx
               	jne	<addr>
               	testl	%r9d, %r9d
               	jne	<addr>
               	movzbq	(%rax,%rcx), %rax
               	movsbq	%al, %rax
               	cmpq	%r8, %rax
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
               	testl	%r9d, %r9d
               	jne	<addr>
               	movswq	%ax, %rax
               	jmp	<addr>
               	cmpq	%r13, %r8
               	jle	<addr>
               	movq	%r13, %r8
               	jmp	<addr>
               	leaq	(%rax,%rdx), %r8
               	jmp	<addr>
               	movzbq	(%rsi,%rcx), %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	shlq	%rdx
               	movslq	%edx, %rdx
               	movzbq	(%rsi,%rdx), %r8
               	incq	%rdx
               	movslq	%edx, %rdx
               	movzbq	(%rsi,%rdx), %rdx
               	shlq	$0x8, %rdx
               	orq	%r8, %rdx
               	testl	%r9d, %r9d
               	jne	<addr>
               	movswq	%dx, %rdx
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
               	testl	%r9d, %r9d
               	jne	<addr>
               	movswq	%ax, %rax
               	jmp	<addr>
               	incq	%rcx
               	movl	$0x10, %eax
               	cltd
               	idivl	%ebx
               	cmpl	%eax, %ecx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	shlxq	%rcx, %rax, %rax
               	leaq	-0x1(%rax), %r13
               	jmp	<addr>
               	xorl	%r12d, %r12d
               	jmp	<addr>
               	movl	$0x1, %ebx
               	jmp	<addr>
               	movq	0x158(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0x158(%rsp)
               	movq	0x158(%rsp), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<check_ps_logic>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	leaq	-0xa0(%rbp), %rax
               	movdqu	(%rdi), %xmm15
               	movdqu	%xmm15, (%rax)
               	movups	-0xa0(%rbp), %xmm0
               	leaq	-0x100(%rbp), %rax
               	movups	%xmm0, -0x100(%rbp)
               	leaq	-0x90(%rbp), %rcx
               	movdqu	(%rsi), %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	-0x90(%rbp), %xmm0
               	leaq	-0xf0(%rbp), %r8
               	movups	%xmm0, -0xf0(%rbp)
               	leaq	-0xe0(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movups	%xmm14, 0x20(%rcx)
               	movups	%xmm14, 0x30(%rcx)
               	leaq	-0x80(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%r8), %xmm14
               	andps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xf0(%rbp), %rcx
               	leaq	-0x70(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	andnps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0xe0(%rbp), %rax
               	leaq	0x10(%rax), %r8
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	-0x100(%rbp), %rdx
               	leaq	-0x60(%rbp), %r8
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rcx), %xmm14
               	orps	%xmm14, %xmm15
               	movdqu	%xmm15, (%r8)
               	addq	$0x20, %rax
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xf0(%rbp), %rcx
               	leaq	-0x50(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rcx), %xmm14
               	xorps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0xe0(%rbp), %rcx
               	addq	$0x30, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%edx, %edx
               	leaq	-0x30(%rbp), %r8
               	leaq	-0xe0(%rbp), %rax
               	movq	%rdx, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rax
               	movups	(%rax), %xmm0
               	leaq	-0x40(%rbp), %rax
               	movups	%xmm0, -0x40(%rbp)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%r8)
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
               	movups	-0x100(%rbp), %xmm0
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	movups	%xmm0, -0x40(%rbp)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
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
               	subq	$0xb8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r13d, %r13d
               	leaq	-0x40(%rbp), %rdx
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
               	leaq	-0x40(%rbp), %rdi
               	leaq	-0x30(%rbp), %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0xb0(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xa0(%rbp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x70(%rbp), %rdi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	psadbw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	leaq	-0x90(%rbp), %rcx
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xa0(%rbp), %r8
               	leaq	-0x60(%rbp), %rdi
               	movdqu	(%rax), %xmm15
               	movdqu	(%r8), %xmm14
               	pmaddubsw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	leaq	-0x80(%rbp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	-0x10(%rbp), %rcx
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
               	leaq	-0x48(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	%rdi, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x48(%rbp), %rax
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
               	leaq	-0x10(%rbp), %r9
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
               	leaq	-0x40(%rbp), %rdi
               	leaq	-0x30(%rbp), %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	incq	%r13
               	cmpl	$0xc8, %r13d
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x8c, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x8b, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x8a, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
