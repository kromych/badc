
counted_loops_close_on_their_step.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	nopl	(%rax,%rax)
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
               	subq	$0x18, %rsp
               	movq	$0x0, 0x8(%rsp)
               	movq	$0x0, (%rsp)
               	jmp	<addr>
               	movq	0x8(%rsp), %rax
               	leaq	(%rax,%rax,4), %rax
               	movq	(%rsp), %rcx
               	movzbq	(%rdi,%rcx), %rcx
               	addq	%rcx, %rax
               	movq	%rax, 0x8(%rsp)
               	movq	(%rsp), %rax
               	incq	%rax
               	movq	%rax, (%rsp)
               	movq	(%rsp), %rax
               	cmpq	%rsi, %rax
               	jb	<addr>
               	movq	0x8(%rsp), %rax
               	addq	$0x18, %rsp
               	retq

<negatives>:
               	cmpq	$-0x7, %rdi
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	$-0xfff, %rdi           # imm = 0xF001
               	setne	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	addq	%rax, %rcx
               	cmpq	$-0x1000, %rdi          # imm = 0xF000
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %rcx
               	cmpl	$-0x1, %esi
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %rcx
               	cmpq	$-0x64, %rdi
               	setl	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	addq	%rcx, %rax
               	retq

<main>:
               	subq	$0xe8, %rsp
               	xorl	%eax, %eax
               	imulq	$0x1d, %rax, %rcx
               	addq	$0x3, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x18(%rsp,%rax)
               	incq	%rax
               	cmpl	$0xc8, %eax
               	jl	<addr>
               	leaq	0x18(%rsp), %rdi
               	movl	$0xc8, %esi
               	callq	<addr>
               	movq	%rax, 0x8(%rsp)
               	leaq	0x18(%rsp), %rdi
               	movl	$0xc8, %esi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x8(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xe8, %rsp
               	retq
               	leaq	0x18(%rsp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xe8, %rsp
               	retq
               	leaq	0x18(%rsp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	leaq	0x18(%rsp), %rdi
               	movzbq	0x18(%rsp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xe8, %rsp
               	retq
               	movl	$0xc8, %esi
               	callq	<addr>
               	movq	%rax, 0x8(%rsp)
               	leaq	0x18(%rsp), %rdi
               	movl	$0xc8, %esi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x8(%rsp), %rax
               	cmpl	%r10d, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xe8, %rsp
               	retq
               	leaq	0x18(%rsp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0xe8, %rsp
               	retq
               	leaq	0x18(%rsp), %rdi
               	movl	$0xc8, %esi
               	callq	<addr>
               	movq	%rax, 0x8(%rsp)
               	leaq	0x18(%rsp), %rdi
               	movl	$0xc8, %esi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x8(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0xe8, %rsp
               	retq
               	leaq	0x18(%rsp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	leaq	0x18(%rsp), %rdi
               	movzbq	0x18(%rsp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0xe8, %rsp
               	retq
               	movl	$0xc8, %esi
               	callq	<addr>
               	movq	%rax, 0x8(%rsp)
               	leaq	0x18(%rsp), %rdi
               	movl	$0xc7, %esi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x8(%rsp), %rax
               	cmpl	%r10d, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0xe8, %rsp
               	retq
               	leaq	0x18(%rsp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0xe8, %rsp
               	retq
               	movzbq	0x18(%rsp), %rax
               	shlq	$0x4, %rax
               	movzbq	0x19(%rsp), %rcx
               	shlq	$0x3, %rcx
               	xorq	%rcx, %rax
               	movzbq	0x1a(%rsp), %rcx
               	shlq	$0x2, %rcx
               	xorq	%rcx, %rax
               	movzbq	0x1b(%rsp), %rcx
               	shlq	%rcx
               	xorq	%rcx, %rax
               	movzbq	0x1c(%rsp), %rcx
               	xorq	%rcx, %rax
               	movzbq	0x1d(%rsp), %rcx
               	shlq	$0x7, %rcx
               	xorq	%rcx, %rax
               	movzbq	0x1e(%rsp), %rcx
               	shlq	$0x6, %rcx
               	xorq	%rcx, %rax
               	movzbq	0x1f(%rsp), %rcx
               	shlq	$0x5, %rcx
               	xorq	%rcx, %rax
               	movzbq	0x20(%rsp), %rcx
               	shlq	$0x4, %rcx
               	xorq	%rcx, %rax
               	leaq	0x18(%rsp), %rdi
               	movzbq	0x21(%rsp), %rcx
               	shlq	$0x3, %rcx
               	xorq	%rcx, %rax
               	movzbq	0x22(%rsp), %rcx
               	shlq	$0x2, %rcx
               	xorq	%rcx, %rax
               	movzbq	0x23(%rsp), %rcx
               	shlq	%rcx
               	xorq	%rcx, %rax
               	movzbq	0x24(%rsp), %rcx
               	movq	%rax, %r10
               	xorq	%rcx, %r10
               	movq	%r10, 0x8(%rsp)
               	movl	$0xd, %esi
               	callq	<addr>
               	cmpl	0x8(%rsp), %eax
               	jne	<addr>
               	leaq	0x18(%rsp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0xe8, %rsp
               	retq
               	movq	$0x1, 0x10(%rsp)
               	leaq	0x18(%rsp), %rdi
               	movl	$0xa, %esi
               	leaq	0x10(%rsp), %rdx
               	callq	<addr>
               	movzbq	0x18(%rsp), %rcx
               	movzbq	0x19(%rsp), %rdx
               	addq	%rdx, %rcx
               	movzbq	0x1a(%rsp), %rdx
               	addq	%rdx, %rcx
               	movzbq	0x1b(%rsp), %rdx
               	addq	%rdx, %rcx
               	movzbq	0x1c(%rsp), %rdx
               	addq	%rdx, %rcx
               	movzbq	0x1d(%rsp), %rdx
               	addq	%rdx, %rcx
               	movzbq	0x1e(%rsp), %rdx
               	addq	%rdx, %rcx
               	movzbq	0x1f(%rsp), %rdx
               	addq	%rdx, %rcx
               	movzbq	0x20(%rsp), %rdx
               	addq	%rdx, %rcx
               	movzbq	0x21(%rsp), %rdx
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0xe8, %rsp
               	retq
               	movq	0x10(%rsp), %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0xe8, %rsp
               	retq
               	movq	$-0x7, %rdi
               	movq	$-0x1, %rsi
               	callq	<addr>
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0xe8, %rsp
               	retq
               	movq	$-0xfff, %rdi           # imm = 0xF001
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0xe8, %rsp
               	retq
               	movq	$-0x1000, %rdi          # imm = 0xF000
               	movl	$0x5, %esi
               	callq	<addr>
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0xe8, %rsp
               	retq
               	movl	$0x7, %edi
               	movq	$-0x1, %rsi
               	callq	<addr>
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0xe8, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0xe8, %rsp
               	retq
