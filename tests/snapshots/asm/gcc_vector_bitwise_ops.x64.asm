
gcc_vector_bitwise_ops.x64:	file format elf64-x86-64

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

<same16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movups	%xmm0, -0x20(%rbp,%riz)
               	leaq	-0x20(%rbp), %rax
               	leaq	(%rax), %rcx
               	movzbq	(%rcx), %rcx
               	leaq	(%rdi), %rdx
               	movzbq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	je	<addr>
               	xorq	%rax, %rax
               	leave
               	retq
               	movzbq	0x1(%rax), %rcx
               	movzbq	0x1(%rdi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x2(%rax), %rcx
               	movzbq	0x2(%rdi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x3(%rax), %rcx
               	movzbq	0x3(%rdi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x4(%rax), %rcx
               	movzbq	0x4(%rdi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x5(%rax), %rcx
               	movzbq	0x5(%rdi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x6(%rax), %rcx
               	movzbq	0x6(%rdi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x7(%rax), %rcx
               	movzbq	0x7(%rdi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x8(%rax), %rcx
               	movzbq	0x8(%rdi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x9(%rax), %rcx
               	movzbq	0x9(%rdi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0xa(%rax), %rcx
               	movzbq	0xa(%rdi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0xb(%rax), %rcx
               	movzbq	0xb(%rdi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0xc(%rax), %rcx
               	movzbq	0xc(%rdi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0xd(%rax), %rcx
               	movzbq	0xd(%rdi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0xe(%rax), %rcx
               	movzbq	0xe(%rdi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	movzbq	0xf(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x160, %rsp            # imm = 0x160
               	movq	%rbx, (%rsp)
               	leaq	-0x150(%rbp), %rbx
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	leaq	-0x140(%rbp), %rdx
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	xorq	%rcx, %rcx
               	cmpl	$0x10, %ecx
               	jge	<addr>
               	leaq	-0x80(%rbp), %rsi
               	movslq	%ecx, %rax
               	movzbq	(%rbx,%rax), %rdi
               	movzbq	(%rdx,%rax), %r8
               	xorq	%r8, %rdi
               	movb	%dil, (%rsi,%rax)
               	leaq	-0x70(%rbp), %rsi
               	movzbq	(%rbx,%rax), %rdi
               	movzbq	(%rdx,%rax), %r8
               	andq	%r8, %rdi
               	movb	%dil, (%rsi,%rax)
               	leaq	-0x60(%rbp), %rsi
               	movzbq	(%rbx,%rax), %rdi
               	movzbq	(%rdx,%rax), %r8
               	orq	%r8, %rdi
               	movb	%dil, (%rsi,%rax)
               	incq	%rcx
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	leaq	-0x150(%rbp), %rax
               	leaq	-0x140(%rbp), %rcx
               	leaq	-0xb0(%rbp), %r9
               	movq	(%rax), %rdx
               	movq	(%rcx), %rsi
               	xorq	%rsi, %rdx
               	movq	%rdx, (%r9)
               	movq	0x8(%rax), %rax
               	movq	0x8(%rcx), %rcx
               	xorq	%rcx, %rax
               	movq	%rax, 0x8(%r9)
               	leaq	-0x80(%rbp), %rdi
               	movq	%r9, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x150(%rbp), %rax
               	leaq	-0x140(%rbp), %rcx
               	leaq	-0xb0(%rbp), %r9
               	movq	(%rax), %rdx
               	movq	(%rcx), %rsi
               	andq	%rsi, %rdx
               	movq	%rdx, (%r9)
               	movq	0x8(%rax), %rax
               	movq	0x8(%rcx), %rcx
               	andq	%rcx, %rax
               	movq	%rax, 0x8(%r9)
               	leaq	-0x70(%rbp), %rdi
               	movq	%r9, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x150(%rbp), %rax
               	leaq	-0x140(%rbp), %rcx
               	leaq	-0xb0(%rbp), %r9
               	movq	(%rax), %rdx
               	movq	(%rcx), %rsi
               	orq	%rsi, %rdx
               	movq	%rdx, (%r9)
               	movq	0x8(%rax), %rax
               	movq	0x8(%rcx), %rcx
               	orq	%rcx, %rax
               	movq	%rax, 0x8(%r9)
               	leaq	-0x60(%rbp), %rdi
               	movq	%r9, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x150(%rbp), %rcx
               	leaq	-0x140(%rbp), %rax
               	movq	(%rcx), %rsi
               	movq	(%rax), %rdx
               	xorq	%rdx, %rsi
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rax), %rdi
               	xorq	%rdi, %rcx
               	leaq	-0xb0(%rbp), %r9
               	xorq	%rsi, %rdx
               	movq	%rdx, (%r9)
               	movq	0x8(%rax), %rax
               	xorq	%rcx, %rax
               	movq	%rax, 0x8(%r9)
               	movq	%r9, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x150(%rbp), %rax
               	leaq	-0x130(%rbp), %r9
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r9)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r9)
               	popq	%rcx
               	leaq	-0x140(%rbp), %rax
               	movq	(%r9), %rcx
               	movq	(%rax), %rdx
               	xorq	%rdx, %rcx
               	movq	0x8(%r9), %rdx
               	movq	0x8(%rax), %rax
               	xorq	%rdx, %rax
               	movq	%rcx, (%r9)
               	movq	%rax, 0x8(%r9)
               	leaq	-0x80(%rbp), %rdi
               	movq	%r9, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x130(%rbp), %r9
               	leaq	-0x150(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r9)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r9)
               	popq	%rcx
               	leaq	-0x140(%rbp), %rax
               	movq	(%r9), %rcx
               	movq	(%rax), %rdx
               	andq	%rdx, %rcx
               	movq	0x8(%r9), %rdx
               	movq	0x8(%rax), %rax
               	andq	%rdx, %rax
               	movq	%rcx, (%r9)
               	movq	%rax, 0x8(%r9)
               	leaq	-0x70(%rbp), %rdi
               	movq	%r9, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x130(%rbp), %r9
               	leaq	-0x150(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r9)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r9)
               	popq	%rcx
               	leaq	-0x140(%rbp), %rax
               	movq	(%r9), %rcx
               	movq	(%rax), %rdx
               	orq	%rdx, %rcx
               	movq	0x8(%r9), %rdx
               	movq	0x8(%rax), %rax
               	orq	%rdx, %rax
               	movq	%rcx, (%r9)
               	movq	%rax, 0x8(%r9)
               	leaq	-0x60(%rbp), %rdi
               	movq	%r9, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x150(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	leaq	-0x140(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	leaq	-0x100(%rbp), %r9
               	movq	%rcx, (%r9)
               	movq	%rax, 0x8(%r9)
               	leaq	-0x80(%rbp), %rdi
               	movq	%r9, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xa8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	movabsq	$0x8f806fa04fc02fe, %rcx # imm = 0x8F806FA04FC02FE
               	movq	%rcx, (%rax)
               	movzbq	(%rax), %rcx
               	xorq	$0xfe, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x1(%rax), %rcx
               	xorq	$0x2, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x7(%rax), %rax
               	xorq	$0x8, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xf0(%rbp), %rsi
               	leaq	-0xe0(%rbp), %rdx
               	leaq	(%rsi), %rax
               	movl	$0x1, %ecx
               	movb	%cl, (%rax)
               	leaq	(%rdx), %rax
               	movl	$0xc8, %ecx
               	movb	%cl, (%rax)
               	movl	$0x8, %eax
               	movb	%al, 0x1(%rsi)
               	movl	$0xc7, %eax
               	movb	%al, 0x1(%rdx)
               	movl	$0xf, %eax
               	movb	%al, 0x2(%rsi)
               	movl	$0xc6, %eax
               	movb	%al, 0x2(%rdx)
               	movl	$0x16, %eax
               	movb	%al, 0x3(%rsi)
               	movl	$0xc5, %eax
               	movb	%al, 0x3(%rdx)
               	movl	$0x1d, %eax
               	movb	%al, 0x4(%rsi)
               	movl	$0xc4, %eax
               	movb	%al, 0x4(%rdx)
               	movl	$0x24, %eax
               	movb	%al, 0x5(%rsi)
               	movl	$0xc3, %eax
               	movb	%al, 0x5(%rdx)
               	movl	$0x2b, %eax
               	movb	%al, 0x6(%rsi)
               	movl	$0xc2, %eax
               	movb	%al, 0x6(%rdx)
               	movl	$0x32, %eax
               	movb	%al, 0x7(%rsi)
               	movl	$0xc1, %eax
               	movb	%al, 0x7(%rdx)
               	movl	$0x39, %eax
               	movb	%al, 0x8(%rsi)
               	movl	$0xc0, %eax
               	movb	%al, 0x8(%rdx)
               	movl	$0x40, %eax
               	movb	%al, 0x9(%rsi)
               	movl	$0xbf, %eax
               	movb	%al, 0x9(%rdx)
               	movl	$0x47, %eax
               	movb	%al, 0xa(%rsi)
               	movl	$0xbe, %eax
               	movb	%al, 0xa(%rdx)
               	movl	$0x4e, %eax
               	movb	%al, 0xb(%rsi)
               	movl	$0xbd, %eax
               	movb	%al, 0xb(%rdx)
               	movl	$0x55, %eax
               	movb	%al, 0xc(%rsi)
               	movl	$0xbc, %eax
               	movb	%al, 0xc(%rdx)
               	movl	$0x5c, %eax
               	movb	%al, 0xd(%rsi)
               	movl	$0xbb, %eax
               	movb	%al, 0xd(%rdx)
               	movl	$0x63, %eax
               	movb	%al, 0xe(%rsi)
               	movl	$0xba, %eax
               	movb	%al, 0xe(%rdx)
               	movl	$0x6a, %eax
               	movb	%al, 0xf(%rsi)
               	movl	$0xb9, %eax
               	movb	%al, 0xf(%rdx)
               	leaq	-0xd0(%rbp), %rdi
               	movq	(%rsi), %rax
               	movq	0x8(%rsi), %rcx
               	movq	(%rdx), %r8
               	xorq	%r8, %rax
               	movq	0x8(%rdx), %r8
               	xorq	%r8, %rcx
               	movq	%rax, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	xorq	%rax, %rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	movslq	%eax, %rcx
               	movzbq	(%rdi,%rcx), %r8
               	movzbq	(%rsi,%rcx), %r9
               	movzbq	(%rdx,%rcx), %rcx
               	xorq	%r9, %rcx
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
