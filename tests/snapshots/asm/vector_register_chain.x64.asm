
vector_register_chain.x64:	file format elf64-x86-64

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

<block_sum>:
               	movzbq	(%rdi), %rax
               	movzbq	0x1(%rdi), %rcx
               	addq	%rcx, %rax
               	movzbq	0x2(%rdi), %rcx
               	addq	%rcx, %rax
               	movzbq	0x3(%rdi), %rcx
               	addq	%rcx, %rax
               	movzbq	0x4(%rdi), %rcx
               	addq	%rcx, %rax
               	movzbq	0x5(%rdi), %rcx
               	addq	%rcx, %rax
               	movzbq	0x6(%rdi), %rcx
               	addq	%rcx, %rax
               	movzbq	0x7(%rdi), %rcx
               	addq	%rcx, %rax
               	movzbq	0x8(%rdi), %rcx
               	addq	%rcx, %rax
               	movzbq	0x9(%rdi), %rcx
               	addq	%rcx, %rax
               	movzbq	0xa(%rdi), %rcx
               	addq	%rcx, %rax
               	movzbq	0xb(%rdi), %rcx
               	addq	%rcx, %rax
               	movzbq	0xc(%rdi), %rcx
               	addq	%rcx, %rax
               	movzbq	0xd(%rdi), %rcx
               	addq	%rcx, %rax
               	movzbq	0xe(%rdi), %rcx
               	addq	%rcx, %rax
               	movzbq	0xf(%rdi), %rcx
               	addq	%rcx, %rax
               	retq

<syndrome>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdx, %r12
               	movq	%r8, %r15
               	movq	%rcx, %r14
               	leaq	-0x18(%rbp), %rax
               	movabsq	$0x1d1d1d1d1d1d1d1d, %rcx # imm = 0x1D1D1D1D1D1D1D1D
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	movdqu	(%rax), %xmm0
               	movups	%xmm0, -0x50(%rbp,%riz)
               	xorl	%ebx, %ebx
               	movq	%rbx, %r13
               	cmpl	$0x30, %ebx
               	jge	<addr>
               	movq	0x18(%r12), %rax
               	addq	%rbx, %rax
               	movdqu	(%rax), %xmm0
               	movups	%xmm0, -0x30(%rbp,%riz)
               	movl	$0x2, %ecx
               	movups	0x50(%rsp), %xmm14
               	movups	%xmm14, 0x40(%rsp)
               	testl	%ecx, %ecx
               	jl	<addr>
               	movq	(%r12,%rcx,8), %rax
               	addq	%rbx, %rax
               	movdqu	(%rax), %xmm0
               	movapd	%xmm0, %xmm3
               	movapd	%xmm3, %xmm2
               	movups	0x40(%rsp), %xmm1
               	movdqa	%xmm1, %xmm0
               	pxor	%xmm2, %xmm0
               	movups	%xmm0, -0x40(%rbp,%riz)
               	movups	0x50(%rsp), %xmm1
               	pxor	%xmm0, %xmm0
               	pcmpgtb	%xmm1, %xmm0
               	movapd	%xmm0, %xmm1
               	movups	0x50(%rsp), %xmm0
               	paddb	%xmm0, %xmm0
               	movapd	%xmm0, %xmm4
               	movups	0x30(%rsp), %xmm2
               	movdqa	%xmm1, %xmm0
               	pand	%xmm2, %xmm0
               	movapd	%xmm4, %xmm1
               	movapd	%xmm0, %xmm2
               	movdqa	%xmm1, %xmm0
               	pxor	%xmm2, %xmm0
               	movapd	%xmm0, %xmm1
               	movapd	%xmm3, %xmm2
               	movdqa	%xmm1, %xmm0
               	pxor	%xmm2, %xmm0
               	movups	%xmm0, -0x30(%rbp,%riz)
               	decq	%rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	movq	0x18(%r12), %rax
               	leaq	(%rax,%rbx), %rdi
               	callq	<addr>
               	leaq	(%r13,%rax), %rcx
               	leaq	(%r14,%rbx), %rax
               	movups	0x40(%rsp), %xmm0
               	movdqu	%xmm0, (%rax)
               	leaq	(%r15,%rbx), %rax
               	movups	0x50(%rsp), %xmm0
               	movdqu	%xmm0, (%rax)
               	movups	0x50(%rsp), %xmm0
               	movq	%xmm0, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	andq	$0xff, %rax
               	leaq	(%rcx,%rax), %r13
               	addq	$0x10, %rbx
               	cmpl	$0x30, %ebx
               	jl	<addr>
               	movl	%r13d, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x88, %rsp
               	pushq	%rbx
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8
               	cmpl	$0x4, %ecx
               	jge	<addr>
               	leaq	-0x20(%rbp), %rax
               	imulq	$0x30, %rcx, %r9
               	leaq	(%r8,%r9), %rdx
               	movq	%rdx, (%rax,%rcx,8)
               	xorl	%eax, %eax
               	cmpl	$0x30, %eax
               	jge	<addr>
               	leaq	(%r8,%r9), %rdi
               	leaq	0x3(%rcx), %rdx
               	imulq	%rax, %rdx
               	imulq	$0x25, %rdx, %rdx
               	imulq	$0xb, %rcx, %rsi
               	addq	%rsi, %rdx
               	addq	$0x5, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x30, %eax
               	jl	<addr>
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%edi, %edi
               	leaq	<rip>, %rcx
               	movq	%rdi, %rax
               	cmpl	$0x30, %eax
               	jge	<addr>
               	leaq	0x90(%rcx), %rdx
               	movzbq	(%rdx,%rax), %rdx
               	leaq	0x60(%rcx), %rsi
               	movzbq	(%rsi,%rax), %r8
               	xorq	%rdx, %r8
               	movq	%rdx, %r9
               	shlq	%r9
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%r9, %rdx
               	andq	$0xff, %rdx
               	movzbq	(%rsi,%rax), %rsi
               	xorq	%rsi, %rdx
               	leaq	0x30(%rcx), %rsi
               	movzbq	(%rsi,%rax), %r9
               	xorq	%r9, %r8
               	movq	%rdx, %r9
               	shlq	%r9
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%r9, %rdx
               	andq	$0xff, %rdx
               	movzbq	(%rsi,%rax), %rsi
               	xorq	%rsi, %rdx
               	movzbq	(%rcx,%rax), %rsi
               	xorq	%r8, %rsi
               	movq	%rdx, %r8
               	shlq	%r8
               	andq	$0x80, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %edx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	movq	%rdi, %rdx
               	jmp	<addr>
               	movq	%rdi, %rdx
               	jmp	<addr>
               	xorq	%r8, %rdx
               	andq	$0xff, %rdx
               	movzbq	(%rcx,%rax), %r8
               	xorq	%r8, %rdx
               	leaq	-0x80(%rbp), %r8
               	movb	%sil, (%r8,%rax)
               	leaq	-0x50(%rbp), %rsi
               	movb	%dl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x30, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	leaq	0x90(%rax), %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x50(%rbp), %rax
               	movzbq	(%rax), %rax
               	leaq	(%rcx,%rax), %rbx
               	leaq	<rip>, %rax
               	addq	$0x90, %rax
               	leaq	0x10(%rax), %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x50(%rbp), %rax
               	movzbq	0x10(%rax), %rax
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	leaq	<rip>, %rax
               	addq	$0x90, %rax
               	leaq	0x20(%rax), %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x50(%rbp), %rax
               	movzbq	0x20(%rax), %rax
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	movl	$0x4, %edi
               	movl	$0x30, %esi
               	leaq	-0x20(%rbp), %rdx
               	leaq	<rip>, %rcx
               	leaq	<rip>, %r8
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	cmpl	$0x30, %eax
               	jge	<addr>
               	movzbq	(%rcx,%rax), %rdi
               	leaq	-0x80(%rbp), %rsi
               	movzbq	(%rsi,%rax), %rsi
               	cmpl	%esi, %edi
               	jne	<addr>
               	movzbq	(%rdx,%rax), %rdi
               	leaq	-0x50(%rbp), %rsi
               	movzbq	(%rsi,%rax), %rsi
               	cmpl	%esi, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x30, %eax
               	jl	<addr>
               	cmpl	%ebx, %r8d
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
