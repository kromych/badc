
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
               	subq	$0x2f8, %rsp            # imm = 0x2F8
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r10d, %r10d
               	movq	%r10, 0x270(%rsp)
               	leaq	-0x80(%rbp), %rdx
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
               	leaq	-0x80(%rbp), %r13
               	leaq	-0x70(%rbp), %r14
               	leaq	-0x2f0(%rbp), %rdi
               	movl	$0x10, %edx
               	movq	%r13, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x2e0(%rbp), %rdi
               	movl	$0x10, %edx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x2d0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	movups	%xmm14, 0x60(%rax)
               	movups	%xmm14, 0x70(%rax)
               	leaq	-0x2f0(%rbp), %rdx
               	leaq	-0x2e0(%rbp), %rsi
               	leaq	-0x250(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rsi), %xmm14
               	paddsb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x2f0(%rbp), %rax
               	leaq	-0x2e0(%rbp), %rdx
               	leaq	-0x240(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	paddsw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x2d0(%rbp), %rdx
               	leaq	0x10(%rdx), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0x2e0(%rbp), %rsi
               	leaq	-0x230(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rsi), %xmm14
               	paddusb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	0x20(%rdx), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x2f0(%rbp), %rax
               	leaq	-0x2e0(%rbp), %rdx
               	leaq	-0x220(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	paddusw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x2d0(%rbp), %rdx
               	leaq	0x30(%rdx), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0x2e0(%rbp), %rsi
               	leaq	-0x210(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rsi), %xmm14
               	psubsb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	0x40(%rdx), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x2f0(%rbp), %rax
               	leaq	-0x2e0(%rbp), %rdx
               	leaq	-0x200(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	psubsw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x2d0(%rbp), %rdx
               	leaq	0x50(%rdx), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0x2e0(%rbp), %rsi
               	leaq	-0x1f0(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rsi), %xmm14
               	psubusb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	0x60(%rdx), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x2f0(%rbp), %rcx
               	leaq	-0x2e0(%rbp), %rdx
               	leaq	-0x1e0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	psubusw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x2d0(%rbp), %rcx
               	addq	$0x70, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%r10d, %r10d
               	movq	%r10, 0x278(%rsp)
               	movq	0x278(%rsp), %rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	testb	$0x1, %al
               	je	<addr>
               	movl	$0x2, %r12d
               	movq	0x278(%rsp), %rax
               	movq	%rax, %rbx
               	andq	$0x2, %rbx
               	cmpl	$0x4, %eax
               	setge	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x280(%rsp)
               	testl	%ebx, %ebx
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%r12, %rcx
               	shlq	$0x3, %rcx
               	decq	%rcx
               	shlxq	%rcx, %rax, %rax
               	movq	%rax, %r15
               	negq	%r15
               	testl	%ebx, %ebx
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%r12, %rcx
               	shlq	$0x3, %rcx
               	decq	%rcx
               	shlxq	%rcx, %rax, %rax
               	leaq	-0x1(%rax), %r10
               	movq	%r10, 0x288(%rsp)
               	leaq	-0x60(%rbp), %rdi
               	leaq	-0x2d0(%rbp), %rax
               	movq	0x278(%rsp), %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rax,%rcx), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x10, %eax
               	cltd
               	idivl	%r12d
               	cmpl	%eax, %ecx
               	jge	<addr>
               	cmpl	$0x1, %r12d
               	jne	<addr>
               	testl	%ebx, %ebx
               	jne	<addr>
               	movzbq	(%r13,%rcx), %rax
               	movsbq	%al, %rax
               	cmpl	$0x1, %r12d
               	jne	<addr>
               	testl	%ebx, %ebx
               	jne	<addr>
               	movzbq	(%r14,%rcx), %rdx
               	movsbq	%dl, %rdx
               	movq	0x280(%rsp), %r10
               	testq	%r10, %r10
               	je	<addr>
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	cmpq	%r15, %rsi
               	jge	<addr>
               	movq	%r15, %rsi
               	leaq	-0x60(%rbp), %rax
               	cmpl	$0x1, %r12d
               	jne	<addr>
               	testl	%ebx, %ebx
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
               	movzbq	(%rax,%rdx), %rdi
               	incq	%rdx
               	movslq	%edx, %rdx
               	movzbq	(%rax,%rdx), %rax
               	shlq	$0x8, %rax
               	orq	%rdi, %rax
               	testl	%ebx, %ebx
               	jne	<addr>
               	movswq	%ax, %rax
               	jmp	<addr>
               	cmpq	0x288(%rsp), %rsi
               	jle	<addr>
               	movq	0x288(%rsp), %rsi
               	jmp	<addr>
               	leaq	(%rax,%rdx), %rsi
               	jmp	<addr>
               	movzbq	(%r14,%rcx), %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	shlq	%rdx
               	movslq	%edx, %rdx
               	movzbq	(%r14,%rdx), %rsi
               	incq	%rdx
               	movslq	%edx, %rdx
               	movzbq	(%r14,%rdx), %rdx
               	shlq	$0x8, %rdx
               	orq	%rsi, %rdx
               	testl	%ebx, %ebx
               	jne	<addr>
               	movswq	%dx, %rdx
               	jmp	<addr>
               	movzbq	(%r13,%rcx), %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	shlq	%rax
               	movslq	%eax, %rax
               	movzbq	(%r13,%rax), %rdx
               	incq	%rax
               	movslq	%eax, %rax
               	movzbq	(%r13,%rax), %rax
               	shlq	$0x8, %rax
               	orq	%rdx, %rax
               	testl	%ebx, %ebx
               	jne	<addr>
               	movswq	%ax, %rax
               	jmp	<addr>
               	incq	%rcx
               	movl	$0x10, %eax
               	cltd
               	idivl	%r12d
               	cmpl	%eax, %ecx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%r12, %rcx
               	shlq	$0x3, %rcx
               	shlxq	%rcx, %rax, %rax
               	leaq	-0x1(%rax), %r10
               	movq	%r10, 0x288(%rsp)
               	jmp	<addr>
               	xorl	%r15d, %r15d
               	jmp	<addr>
               	movl	$0x1, %r12d
               	jmp	<addr>
               	movq	0x278(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0x278(%rsp)
               	movq	0x278(%rsp), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x80(%rbp), %rbx
               	leaq	-0x70(%rbp), %r12
               	leaq	-0x1d0(%rbp), %rdi
               	movl	$0x10, %edx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x1c0(%rbp), %rdi
               	movl	$0x10, %edx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x1d0(%rbp), %rax
               	leaq	-0x1c0(%rbp), %rdx
               	leaq	-0x190(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	psadbw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x1b0(%rbp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0x1c0(%rbp), %rdx
               	leaq	-0x180(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pmaddubsw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x1a0(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x30(%rbp), %rdi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x1a0(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%r13d, %r13d
               	xorl	%eax, %eax
               	movq	%rax, %r14
               	movq	%r13, %rcx
               	shlq	$0x3, %rcx
               	addq	%rax, %rcx
               	movzbq	(%rbx,%rcx), %rdx
               	movzbq	(%r12,%rcx), %rsi
               	cmpl	%esi, %edx
               	jle	<addr>
               	movzbq	(%rbx,%rcx), %rdx
               	movzbq	(%r12,%rcx), %rsi
               	movq	%rdx, %rcx
               	subq	%rsi, %rcx
               	jmp	<addr>
               	movq	%r13, %rcx
               	shlq	$0x3, %rcx
               	addq	%rax, %rcx
               	movzbq	(%r12,%rcx), %rdx
               	movzbq	(%rbx,%rcx), %rsi
               	movq	%rdx, %rcx
               	subq	%rsi, %rcx
               	addq	%rcx, %r14
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x88(%rbp), %rdi
               	leaq	-0x30(%rbp), %rax
               	movl	$0x8, %edx
               	movq	%r13, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rax,%rcx), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0x88(%rbp), %rax
               	cmpq	%r14, %rax
               	jne	<addr>
               	incq	%r13
               	cmpl	$0x2, %r13d
               	jl	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	%rcx
               	movzbq	(%rbx,%rcx), %rdx
               	movzbq	(%r12,%rcx), %rsi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	leaq	0x1(%rcx), %rsi
               	movzbq	(%rbx,%rsi), %rdi
               	movzbq	(%r12,%rsi), %r8
               	movsbq	%r8b, %r8
               	imulq	%r8, %rdi
               	addq	%rdx, %rdi
               	movq	$-0x8000, %rdx          # imm = 0x8000
               	movl	$0x7fff, %r8d           # imm = 0x7FFF
               	cmpq	%rdx, %rdi
               	jge	<addr>
               	leaq	-0x50(%rbp), %rdi
               	movzbq	(%rdi,%rcx), %rcx
               	movzbq	(%rdi,%rsi), %rsi
               	shlq	$0x8, %rsi
               	orq	%rsi, %rcx
               	movswq	%cx, %rcx
               	cmpl	%edx, %ecx
               	je	<addr>
               	jmp	<addr>
               	cmpq	%r8, %rdi
               	jle	<addr>
               	movq	%r8, %rdx
               	jmp	<addr>
               	movq	%rdi, %rdx
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x80(%rbp), %rsi
               	leaq	-0x70(%rbp), %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rsi), %xmm15
               	movdqu	%xmm15, (%rax)
               	movups	-0x110(%rbp), %xmm0
               	leaq	-0x170(%rbp), %rdi
               	movups	%xmm0, -0x170(%rbp)
               	leaq	-0x100(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movups	-0x100(%rbp), %xmm0
               	leaq	-0x160(%rbp), %r8
               	movups	%xmm0, -0x160(%rbp)
               	leaq	-0x150(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	leaq	-0xf0(%rbp), %rcx
               	movdqu	(%rdi), %xmm15
               	movdqu	(%r8), %xmm14
               	andps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x170(%rbp), %rax
               	leaq	-0x160(%rbp), %rdi
               	leaq	-0xe0(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdi), %xmm14
               	andnps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x150(%rbp), %rdi
               	leaq	0x10(%rdi), %r8
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	-0x160(%rbp), %r8
               	leaq	-0xd0(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%r8), %xmm14
               	orps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	0x20(%rdi), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x170(%rbp), %rcx
               	leaq	-0x160(%rbp), %rdi
               	leaq	-0xc0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdi), %xmm14
               	xorps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x150(%rbp), %rcx
               	addq	$0x30, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%edi, %edi
               	leaq	-0x40(%rbp), %r8
               	leaq	-0x150(%rbp), %rax
               	movq	%rdi, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rax
               	movups	(%rax), %xmm0
               	leaq	-0x2d0(%rbp), %rax
               	movups	%xmm0, -0x2d0(%rbp)
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
               	movups	-0x170(%rbp), %xmm0
               	leaq	-0x30(%rbp), %rdi
               	leaq	-0x2d0(%rbp), %rax
               	movups	%xmm0, -0x2d0(%rbp)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x270(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0x270(%rsp)
               	movq	0x270(%rsp), %rax
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
