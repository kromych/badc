
gcc_vector_array_whole_value_init.x64:	file format elf64-x86-64

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

<lane>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movups	%xmm0, -0x20(%rbp,%riz)
               	movq	%rdi, %rsi
               	movslq	%esi, %rsi
               	leaq	-0x20(%rbp), %rax
               	addq	%rsi, %rax
               	movzbq	(%rax), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x530, %rsp            # imm = 0x530
               	leaq	-0x530(%rbp), %rcx
               	leaq	<rip>, %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x520(%rbp), %rdx
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x510(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	leaq	-0x500(%rbp), %rax
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rsi, 0x18(%rax)
               	movq	%rsi, 0x20(%rax)
               	movq	%rsi, 0x28(%rax)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	0x10(%rax), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	addq	$0x20, %rax
               	pushq	%rcx
               	movq	(%rdi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x500(%rbp), %rdi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x500(%rbp), %rdi
               	movl	$0xf, %esi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x10, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x500(%rbp), %rax
               	leaq	0x10(%rax), %rdi
               	xorq	%rsi, %rsi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x15, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x500(%rbp), %rax
               	leaq	0x10(%rax), %rdi
               	movl	$0xf, %esi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x24, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x500(%rbp), %rax
               	leaq	0x20(%rax), %rdi
               	xorq	%rsi, %rsi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x29, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x500(%rbp), %rax
               	leaq	0x20(%rax), %rdi
               	movl	$0xf, %esi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x38, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x4d0(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rdi)
               	movq	%rsi, 0x8(%rdi)
               	movq	%rsi, 0x10(%rdi)
               	movq	%rsi, 0x18(%rdi)
               	movq	%rsi, 0x20(%rdi)
               	movq	%rsi, 0x28(%rdi)
               	leaq	-0x530(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	leaq	-0x520(%rbp), %rax
               	leaq	0x10(%rdi), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x510(%rbp), %rax
               	leaq	0x20(%rdi), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x4d0(%rbp), %rdi
               	movl	$0xf, %esi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x10, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x4d0(%rbp), %rax
               	leaq	0x10(%rax), %rdi
               	xorq	%rsi, %rsi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x15, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x4d0(%rbp), %rax
               	leaq	0x10(%rax), %rdi
               	movl	$0xf, %esi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x24, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x4d0(%rbp), %rax
               	leaq	0x20(%rax), %rdi
               	xorq	%rsi, %rsi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x29, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x4d0(%rbp), %rax
               	leaq	0x20(%rax), %rdi
               	movl	$0xf, %esi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x38, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x4a0(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rdi)
               	movq	%rsi, 0x8(%rdi)
               	movq	%rsi, 0x10(%rdi)
               	movq	%rsi, 0x18(%rdi)
               	movq	%rsi, 0x20(%rdi)
               	movq	%rsi, 0x28(%rdi)
               	leaq	-0x530(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	leaq	-0x520(%rbp), %rax
               	leaq	0x10(%rdi), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x510(%rbp), %rax
               	leaq	0x20(%rdi), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x4a0(%rbp), %rax
               	leaq	0x20(%rax), %rdi
               	movl	$0xf, %esi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x38, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x470(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rdi)
               	movq	%rsi, 0x8(%rdi)
               	movq	%rsi, 0x10(%rdi)
               	movq	%rsi, 0x18(%rdi)
               	movq	%rsi, 0x20(%rdi)
               	movq	%rsi, 0x28(%rdi)
               	leaq	-0x510(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x29, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x470(%rbp), %rax
               	leaq	0x10(%rax), %rdi
               	xorq	%rsi, %rsi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x470(%rbp), %rax
               	leaq	0x20(%rax), %rdi
               	movl	$0xf, %esi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x440(%rbp), %rax
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rsi, 0x18(%rax)
               	movl	$0x7, %ecx
               	movb	%cl, (%rax)
               	movb	%cl, 0x1(%rax)
               	movb	%cl, 0x2(%rax)
               	movb	%cl, 0x3(%rax)
               	movb	%cl, 0x4(%rax)
               	leaq	-0x440(%rbp), %rax
               	movb	%cl, 0x5(%rax)
               	movb	%cl, 0x6(%rax)
               	movb	%cl, 0x7(%rax)
               	movb	%cl, 0x8(%rax)
               	movb	%cl, 0x9(%rax)
               	movb	%cl, 0xa(%rax)
               	leaq	-0x440(%rbp), %rax
               	movb	%cl, 0xb(%rax)
               	movb	%cl, 0xc(%rax)
               	movb	%cl, 0xd(%rax)
               	movb	%cl, 0xe(%rax)
               	movb	%cl, 0xf(%rax)
               	leaq	-0x520(%rbp), %rcx
               	addq	$0x10, %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x440(%rbp), %rdi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x7, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x440(%rbp), %rdi
               	movl	$0xf, %esi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x7, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	leaq	-0x440(%rbp), %rax
               	leaq	0x10(%rax), %rdi
               	xorq	%rsi, %rsi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x15, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x440(%rbp), %rax
               	leaq	0x10(%rax), %rdi
               	movl	$0xf, %esi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x24, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	leaq	-0x420(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movl	$0x3, %ecx
               	movb	%cl, (%rax)
               	movb	%cl, 0x1(%rax)
               	movb	%cl, 0x2(%rax)
               	movb	%cl, 0x3(%rax)
               	movb	%cl, 0x4(%rax)
               	movb	%cl, 0x5(%rax)
               	leaq	-0x420(%rbp), %rax
               	movb	%cl, 0x6(%rax)
               	movb	%cl, 0x7(%rax)
               	movb	%cl, 0x8(%rax)
               	movb	%cl, 0x9(%rax)
               	movb	%cl, 0xa(%rax)
               	movb	%cl, 0xb(%rax)
               	movb	%cl, 0xc(%rax)
               	leaq	-0x420(%rbp), %rdi
               	movb	%cl, 0xd(%rdi)
               	movb	%cl, 0xe(%rdi)
               	movb	%cl, 0xf(%rdi)
               	leaq	-0x530(%rbp), %rax
               	leaq	0x10(%rdi), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movl	$0x7, %esi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x3, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x420(%rbp), %rax
               	leaq	0x10(%rax), %rdi
               	movl	$0x7, %esi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	-0x400(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rdi)
               	movq	%rsi, 0x8(%rdi)
               	movq	%rsi, 0x10(%rdi)
               	movq	%rsi, 0x18(%rdi)
               	movq	%rsi, 0x20(%rdi)
               	movq	%rsi, 0x28(%rdi)
               	leaq	-0x530(%rbp), %rax
               	leaq	0x20(%rdi), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x520(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x15, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x400(%rbp), %rax
               	leaq	0x20(%rax), %rdi
               	xorq	%rsi, %rsi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	-0x400(%rbp), %rax
               	leaq	0x10(%rax), %rdi
               	xorq	%rsi, %rsi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x400(%rbp), %rax
               	leaq	0x10(%rax), %rdi
               	movl	$0xf, %esi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	leaq	-0x3d0(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rdi)
               	movq	%rsi, 0x8(%rdi)
               	movq	%rsi, 0x10(%rdi)
               	movq	%rsi, 0x18(%rdi)
               	movq	%rsi, 0x20(%rdi)
               	movq	%rsi, 0x28(%rdi)
               	leaq	-0x510(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	leaq	0x10(%rdi), %rax
               	pushq	%rcx
               	movq	(%rdi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	0x20(%rdi), %rax
               	pushq	%rcx
               	movq	(%rdi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x29, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x3d0(%rbp), %rax
               	leaq	0x10(%rax), %rdi
               	movl	$0x9, %esi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x32, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x3d0(%rbp), %rax
               	leaq	0x20(%rax), %rdi
               	movl	$0xf, %esi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x38, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	-0x3a0(%rbp), %rax
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rsi, 0x18(%rax)
               	movq	%rsi, 0x20(%rax)
               	movq	%rsi, 0x28(%rax)
               	movq	%rsi, 0x30(%rax)
               	movq	%rsi, 0x38(%rax)
               	leaq	-0x530(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rdx
               	leaq	-0x520(%rbp), %rdx
               	leaq	0x10(%rax), %rdi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rdx
               	leaq	-0x510(%rbp), %rdx
               	leaq	0x20(%rax), %rdi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rdx
               	addq	$0x30, %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x3a0(%rbp), %rdi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x3a0(%rbp), %rax
               	xorq	%rsi, %rsi
               	leaq	0x10(%rax), %rdi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x15, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	leaq	-0x3a0(%rbp), %rax
               	leaq	0x20(%rax), %rdi
               	xorq	%rsi, %rsi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x29, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x3a0(%rbp), %rax
               	leaq	0x30(%rax), %rdi
               	movl	$0xf, %esi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x10, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	leaq	-0x360(%rbp), %rax
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rsi, 0x18(%rax)
               	movq	%rsi, 0x20(%rax)
               	movq	%rsi, 0x28(%rax)
               	movq	%rsi, 0x30(%rax)
               	movq	%rsi, 0x38(%rax)
               	movq	%rsi, 0x40(%rax)
               	movq	%rsi, 0x48(%rax)
               	movq	%rsi, 0x50(%rax)
               	movq	%rsi, 0x58(%rax)
               	leaq	-0x530(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	-0x520(%rbp), %rcx
               	leaq	0x10(%rax), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	-0x510(%rbp), %rdx
               	leaq	0x20(%rax), %rdi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	leaq	0x30(%rax), %rdi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rdx
               	addq	$0x40, %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x530(%rbp), %rax
               	leaq	-0x360(%rbp), %rdi
               	leaq	0x50(%rdi), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x360(%rbp), %rax
               	xorq	%rsi, %rsi
               	leaq	0x20(%rax), %rdi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x29, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	leaq	-0x360(%rbp), %rax
               	leaq	0x30(%rax), %rdi
               	xorq	%rsi, %rsi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x29, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x360(%rbp), %rax
               	leaq	0x50(%rax), %rdi
               	xorq	%rsi, %rsi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	leaq	-0x300(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rdi)
               	movq	%rsi, 0x8(%rdi)
               	movq	%rsi, 0x10(%rdi)
               	movq	%rsi, 0x18(%rdi)
               	movq	%rsi, 0x20(%rdi)
               	movq	%rsi, 0x28(%rdi)
               	movq	%rsi, 0x30(%rdi)
               	movq	%rsi, 0x38(%rdi)
               	leaq	-0x530(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movl	$0x5, %eax
               	movl	%eax, 0x10(%rdi)
               	leaq	-0x520(%rbp), %rax
               	leaq	0x20(%rdi), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movl	$0x6, %eax
               	movl	%eax, 0x30(%rdi)
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x300(%rbp), %rax
               	movslq	0x10(%rax), %rcx
               	cmpl	$0x5, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	leaq	0x20(%rax), %rdi
               	movl	$0xf, %esi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x24, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x300(%rbp), %rax
               	movslq	0x30(%rax), %rax
               	cmpl	$0x6, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	leaq	-0x2c0(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdi)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movl	$0xf, %esi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x2c0(%rbp), %rax
               	leaq	0x10(%rax), %rdi
               	xorq	%rsi, %rsi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x2, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	leaq	0x10(%rax), %rdi
               	xorq	%rsi, %rsi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x9, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movl	$0xf, %esi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
