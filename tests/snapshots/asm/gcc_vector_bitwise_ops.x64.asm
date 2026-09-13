
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
               	movq	%rdi, %rsi
               	leaq	-0x20(%rbp), %rax
               	leaq	(%rax), %rcx
               	movzbq	(%rcx), %rcx
               	leaq	(%rsi), %rdx
               	movzbq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	je	<addr>
               	xorq	%rax, %rax
               	leave
               	retq
               	movzbq	0x1(%rax), %rcx
               	movzbq	0x1(%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x2(%rax), %rcx
               	movzbq	0x2(%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x3(%rax), %rcx
               	movzbq	0x3(%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x4(%rax), %rcx
               	movzbq	0x4(%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x5(%rax), %rcx
               	movzbq	0x5(%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x6(%rax), %rcx
               	movzbq	0x6(%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x7(%rax), %rcx
               	movzbq	0x7(%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x8(%rax), %rcx
               	movzbq	0x8(%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x9(%rax), %rcx
               	movzbq	0x9(%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0xa(%rax), %rcx
               	movzbq	0xa(%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0xb(%rax), %rcx
               	movzbq	0xb(%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0xc(%rax), %rcx
               	movzbq	0xc(%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0xd(%rax), %rcx
               	movzbq	0xd(%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0xe(%rax), %rcx
               	movzbq	0xe(%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	movzbq	0xf(%rsi), %rcx
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
               	movq	%r12, 0x8(%rsp)
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
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rsi
               	movslq	%ecx, %rax
               	leaq	(%rsi,%rax), %r9
               	leaq	(%rbx,%rax), %rsi
               	movzbq	(%rsi), %r8
               	leaq	(%rdx,%rax), %rdi
               	movzbq	(%rdi), %r12
               	xorq	%r12, %r8
               	movb	%r8b, (%r9)
               	leaq	-0x70(%rbp), %r8
               	addq	%rax, %r8
               	movzbq	(%rsi), %r9
               	movzbq	(%rdi), %rdi
               	andq	%r9, %rdi
               	movb	%dil, (%r8)
               	leaq	-0x60(%rbp), %rdi
               	addq	%rax, %rdi
               	movzbq	(%rsi), %rsi
               	leaq	(%rdx,%rax), %r8
               	movzbq	(%r8), %r8
               	orq	%r8, %rsi
               	movb	%sil, (%rdi)
               	leaq	0x1(%rax), %rcx
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	leaq	-0x150(%rbp), %rax
               	leaq	-0x140(%rbp), %rcx
               	leaq	-0xb0(%rbp), %rdi
               	movq	(%rax), %rdx
               	movq	(%rcx), %rsi
               	xorq	%rsi, %rdx
               	movq	%rdx, (%rdi)
               	movq	0x8(%rax), %rax
               	movq	0x8(%rcx), %rcx
               	xorq	%rcx, %rax
               	movq	%rax, 0x8(%rdi)
               	leaq	-0x80(%rbp), %rsi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x150(%rbp), %rax
               	leaq	-0x140(%rbp), %rcx
               	leaq	-0xb0(%rbp), %rdi
               	movq	(%rax), %rdx
               	movq	(%rcx), %rsi
               	andq	%rsi, %rdx
               	movq	%rdx, (%rdi)
               	movq	0x8(%rax), %rax
               	movq	0x8(%rcx), %rcx
               	andq	%rcx, %rax
               	movq	%rax, 0x8(%rdi)
               	leaq	-0x70(%rbp), %rsi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x150(%rbp), %rax
               	leaq	-0x140(%rbp), %rcx
               	leaq	-0xb0(%rbp), %rdi
               	movq	(%rax), %rdx
               	movq	(%rcx), %rsi
               	orq	%rsi, %rdx
               	movq	%rdx, (%rdi)
               	movq	0x8(%rax), %rax
               	movq	0x8(%rcx), %rcx
               	orq	%rcx, %rax
               	movq	%rax, 0x8(%rdi)
               	leaq	-0x60(%rbp), %rsi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
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
               	leaq	-0xb0(%rbp), %rdi
               	xorq	%rsi, %rdx
               	movq	%rdx, (%rdi)
               	movq	0x8(%rax), %rax
               	xorq	%rcx, %rax
               	movq	%rax, 0x8(%rdi)
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x150(%rbp), %rax
               	leaq	-0x130(%rbp), %rdi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	leaq	-0x140(%rbp), %rax
               	movq	(%rdi), %rcx
               	movq	(%rax), %rdx
               	xorq	%rdx, %rcx
               	movq	0x8(%rdi), %rdx
               	movq	0x8(%rax), %rax
               	xorq	%rdx, %rax
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	leaq	-0x80(%rbp), %rsi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x130(%rbp), %rdi
               	leaq	-0x150(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	leaq	-0x140(%rbp), %rax
               	movq	(%rdi), %rcx
               	movq	(%rax), %rdx
               	andq	%rdx, %rcx
               	movq	0x8(%rdi), %rdx
               	movq	0x8(%rax), %rax
               	andq	%rdx, %rax
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	leaq	-0x70(%rbp), %rsi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x130(%rbp), %rdi
               	leaq	-0x150(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	leaq	-0x140(%rbp), %rax
               	movq	(%rdi), %rcx
               	movq	(%rax), %rdx
               	orq	%rdx, %rcx
               	movq	0x8(%rdi), %rdx
               	movq	0x8(%rax), %rax
               	orq	%rdx, %rax
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	leaq	-0x60(%rbp), %rsi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
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
               	leaq	-0x100(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	leaq	-0x80(%rbp), %rsi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
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
               	testq	%rcx, %rcx
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
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xe0(%rbp), %rcx
               	leaq	(%rdx), %rax
               	movl	$0x1, %esi
               	movb	%sil, (%rax)
               	leaq	(%rcx), %rax
               	movl	$0xc8, %esi
               	movb	%sil, (%rax)
               	movl	$0x8, %eax
               	movb	%al, 0x1(%rdx)
               	movl	$0xc7, %eax
               	movb	%al, 0x1(%rcx)
               	movl	$0xf, %eax
               	movb	%al, 0x2(%rdx)
               	movl	$0xc6, %eax
               	movb	%al, 0x2(%rcx)
               	movl	$0x16, %eax
               	movb	%al, 0x3(%rdx)
               	movl	$0xc5, %eax
               	movb	%al, 0x3(%rcx)
               	movl	$0x1d, %eax
               	movb	%al, 0x4(%rdx)
               	movl	$0xc4, %eax
               	movb	%al, 0x4(%rcx)
               	movl	$0x24, %eax
               	movb	%al, 0x5(%rdx)
               	movl	$0xc3, %eax
               	movb	%al, 0x5(%rcx)
               	movl	$0x2b, %eax
               	movb	%al, 0x6(%rdx)
               	movl	$0xc2, %eax
               	movb	%al, 0x6(%rcx)
               	movl	$0x32, %eax
               	movb	%al, 0x7(%rdx)
               	movl	$0xc1, %eax
               	movb	%al, 0x7(%rcx)
               	movl	$0x39, %eax
               	movb	%al, 0x8(%rdx)
               	movl	$0xc0, %eax
               	movb	%al, 0x8(%rcx)
               	movl	$0x40, %eax
               	movb	%al, 0x9(%rdx)
               	movl	$0xbf, %eax
               	movb	%al, 0x9(%rcx)
               	movl	$0x47, %eax
               	movb	%al, 0xa(%rdx)
               	movl	$0xbe, %eax
               	movb	%al, 0xa(%rcx)
               	movl	$0x4e, %eax
               	movb	%al, 0xb(%rdx)
               	movl	$0xbd, %eax
               	movb	%al, 0xb(%rcx)
               	movl	$0x55, %eax
               	movb	%al, 0xc(%rdx)
               	movl	$0xbc, %eax
               	movb	%al, 0xc(%rcx)
               	movl	$0x5c, %eax
               	movb	%al, 0xd(%rdx)
               	movl	$0xbb, %eax
               	movb	%al, 0xd(%rcx)
               	movl	$0x63, %eax
               	movb	%al, 0xe(%rdx)
               	movl	$0xba, %eax
               	movb	%al, 0xe(%rcx)
               	movl	$0x6a, %eax
               	movb	%al, 0xf(%rdx)
               	movl	$0xb9, %eax
               	movb	%al, 0xf(%rcx)
               	leaq	-0xd0(%rbp), %r8
               	movq	(%rdx), %rax
               	movq	0x8(%rdx), %rsi
               	movq	(%rcx), %rdi
               	xorq	%rdi, %rax
               	movq	0x8(%rcx), %rdi
               	xorq	%rdi, %rsi
               	movq	%rax, (%r8)
               	movq	%rsi, 0x8(%r8)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rsi
               	leaq	(%r8,%rsi), %rdi
               	movzbq	(%rdi), %r9
               	leaq	(%rdx,%rsi), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rcx,%rsi), %rbx
               	movzbq	(%rbx), %rbx
               	xorq	%rbx, %rdi
               	cmpl	%edi, %r9d
               	jne	<addr>
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
