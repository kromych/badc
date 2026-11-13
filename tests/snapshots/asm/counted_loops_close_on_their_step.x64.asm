
counted_loops_close_on_their_step.x64:	file format elf64-x86-64

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

<post64>:
               	xorl	%eax, %eax
               	subq	$0x1, %rsi
               	jb	<addr>
               	leaq	(%rax,%rax,4), %rax
               	incq	%rdi
               	movzbq	-0x1(%rdi), %rcx
               	addq	%rcx, %rax
               	subq	$0x1, %rsi
               	jae	<addr>
               	retq

<post32>:
               	xorl	%eax, %eax
               	movl	%esi, %ecx
               	movq	%rcx, %rsi
               	subq	$0x1, %rsi
               	jb	<addr>
               	leaq	(%rax,%rax,4), %rax
               	incq	%rdi
               	movzbq	-0x1(%rdi), %rcx
               	addq	%rcx, %rax
               	movl	%esi, %ecx
               	movq	%rcx, %rsi
               	subq	$0x1, %rsi
               	jae	<addr>
               	retq

<post_int>:
               	movslq	%esi, %rsi
               	xorl	%eax, %eax
               	subq	$0x1, %rsi
               	jb	<addr>
               	incq	%rdi
               	movzbq	-0x1(%rdi), %rcx
               	movq	%rsi, %rdx
               	andq	$0x7, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	xorq	%rcx, %rax
               	subq	$0x1, %rsi
               	jae	<addr>
               	retq

<pre64>:
               	xorl	%eax, %eax
               	leaq	(%rax,%rax,4), %rax
               	incq	%rdi
               	movzbq	-0x1(%rdi), %rcx
               	addq	%rcx, %rax
               	subq	$0x1, %rsi
               	jne	<addr>
               	retq

<pre32>:
               	xorl	%eax, %eax
               	subl	$0x1, %esi
               	je	<addr>
               	leaq	(%rax,%rax,4), %rax
               	incq	%rdi
               	movzbq	-0x1(%rdi), %rcx
               	addq	%rcx, %rax
               	subl	$0x1, %esi
               	jne	<addr>
               	retq

<kept>:
               	xorl	%eax, %eax
               	subq	$0x1, %rsi
               	jb	<addr>
               	incq	%rdi
               	movzbq	-0x1(%rdi), %rcx
               	addq	%rcx, %rax
               	subq	$0x1, %rsi
               	jae	<addr>
               	movq	%rsi, (%rdx)
               	retq

<reference>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	$0x0, -0x8(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x8(%rbp), %rax
               	leaq	(%rax,%rax,4), %rax
               	movq	-0x10(%rbp), %rcx
               	movzbq	(%rdi,%rcx), %rcx
               	addq	%rcx, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x10(%rbp), %rax
               	incq	%rax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	cmpq	%rsi, %rax
               	jb	<addr>
               	movq	-0x8(%rbp), %rax
               	leave
               	retq

<negatives>:
               	cmpq	$-0x7, %rdi
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$-0xfff, %rdi           # imm = 0xF001
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	addq	%rcx, %rax
               	cmpq	$-0x1000, %rdi          # imm = 0xF000
               	sete	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	cmpl	$-0x1, %esi
               	sete	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	$-0x64, %rdi
               	setl	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	xorl	%eax, %eax
               	leaq	-0xc8(%rbp), %rcx
               	imulq	$0x1d, %rax, %rdx
               	addq	$0x3, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0xc8, %eax
               	jl	<addr>
               	leaq	-0xc8(%rbp), %rdi
               	movl	$0xc8, %esi
               	callq	<addr>
               	movq	%rax, 0x8(%rsp)
               	leaq	-0xc8(%rbp), %rdi
               	movl	$0xc8, %esi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x8(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0xc8(%rbp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0xc8(%rbp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	leaq	-0xc8(%rbp), %rdi
               	movzbq	-0xc8(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0xc8, %esi
               	callq	<addr>
               	movq	%rax, 0x8(%rsp)
               	leaq	-0xc8(%rbp), %rdi
               	movl	$0xc8, %esi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x8(%rsp), %rax
               	cmpl	%r10d, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0xc8(%rbp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0xc8(%rbp), %rdi
               	movl	$0xc8, %esi
               	callq	<addr>
               	movq	%rax, 0x8(%rsp)
               	leaq	-0xc8(%rbp), %rdi
               	movl	$0xc8, %esi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x8(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0xc8(%rbp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	leaq	-0xc8(%rbp), %rdi
               	movzbq	-0xc8(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	$0xc8, %esi
               	callq	<addr>
               	movq	%rax, 0x8(%rsp)
               	leaq	-0xc8(%rbp), %rdi
               	movl	$0xc7, %esi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x8(%rsp), %rax
               	cmpl	%r10d, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0xc8(%rbp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movzbq	-0xc8(%rbp), %rax
               	shlq	$0x4, %rax
               	movzbq	-0xc7(%rbp), %rcx
               	shlq	$0x3, %rcx
               	xorq	%rcx, %rax
               	movzbq	-0xc6(%rbp), %rcx
               	shlq	$0x2, %rcx
               	xorq	%rcx, %rax
               	movzbq	-0xc5(%rbp), %rcx
               	shlq	%rcx
               	xorq	%rcx, %rax
               	movzbq	-0xc4(%rbp), %rcx
               	xorq	%rcx, %rax
               	movzbq	-0xc3(%rbp), %rcx
               	shlq	$0x7, %rcx
               	xorq	%rcx, %rax
               	movzbq	-0xc2(%rbp), %rcx
               	shlq	$0x6, %rcx
               	xorq	%rcx, %rax
               	leaq	-0xc8(%rbp), %rdi
               	movzbq	-0xc1(%rbp), %rcx
               	shlq	$0x5, %rcx
               	xorq	%rcx, %rax
               	movzbq	-0xc0(%rbp), %rcx
               	shlq	$0x4, %rcx
               	xorq	%rcx, %rax
               	movzbq	-0xbf(%rbp), %rcx
               	shlq	$0x3, %rcx
               	xorq	%rcx, %rax
               	movzbq	-0xbe(%rbp), %rcx
               	shlq	$0x2, %rcx
               	xorq	%rcx, %rax
               	movzbq	-0xbd(%rbp), %rcx
               	shlq	%rcx
               	xorq	%rcx, %rax
               	movzbq	-0xbc(%rbp), %rcx
               	movq	%rax, %r10
               	xorq	%rcx, %r10
               	movq	%r10, 0x8(%rsp)
               	movl	$0xd, %esi
               	callq	<addr>
               	cmpl	0x8(%rsp), %eax
               	jne	<addr>
               	leaq	-0xc8(%rbp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movq	$0x1, -0xd0(%rbp)
               	leaq	-0xc8(%rbp), %rdi
               	movl	$0xa, %esi
               	leaq	-0xd0(%rbp), %rdx
               	callq	<addr>
               	movzbq	-0xc8(%rbp), %rcx
               	movzbq	-0xc7(%rbp), %rdx
               	addq	%rdx, %rcx
               	movzbq	-0xc6(%rbp), %rdx
               	addq	%rdx, %rcx
               	movzbq	-0xc5(%rbp), %rdx
               	addq	%rdx, %rcx
               	movzbq	-0xc4(%rbp), %rdx
               	addq	%rdx, %rcx
               	movzbq	-0xc3(%rbp), %rdx
               	addq	%rdx, %rcx
               	movzbq	-0xc2(%rbp), %rdx
               	addq	%rdx, %rcx
               	movzbq	-0xc1(%rbp), %rdx
               	addq	%rdx, %rcx
               	movzbq	-0xc0(%rbp), %rdx
               	addq	%rdx, %rcx
               	movzbq	-0xbf(%rbp), %rdx
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movq	-0xd0(%rbp), %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movq	$-0x7, %rdi
               	movq	$-0x1, %rsi
               	callq	<addr>
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movq	$-0xfff, %rdi           # imm = 0xF001
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movq	$-0x1000, %rdi          # imm = 0xF000
               	movl	$0x5, %esi
               	callq	<addr>
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movl	$0x7, %edi
               	movq	$-0x1, %rsi
               	callq	<addr>
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
