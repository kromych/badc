
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
               	subq	$0x48, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdx, %r12
               	movq	%r8, %r15
               	movq	%rcx, %r14
               	movabsq	$0x1d1d1d1d1d1d1d1d, %rax # imm = 0x1D1D1D1D1D1D1D1D
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movdqu	(%rax), %xmm0
               	movapd	%xmm0, %xmm5
               	xorl	%ebx, %ebx
               	movq	%rbx, %r13
               	movq	0x18(%r12), %rax
               	addq	%rbx, %rax
               	movdqu	(%rax), %xmm0
               	movapd	%xmm0, %xmm2
               	movl	$0x2, %esi
               	movapd	%xmm2, %xmm3
               	movq	(%r12,%rsi,8), %rax
               	addq	%rbx, %rax
               	movdqu	(%rax), %xmm0
               	movapd	%xmm0, %xmm4
               	pxor	%xmm4, %xmm3
               	movapd	%xmm2, %xmm1
               	pxor	%xmm0, %xmm0
               	pcmpgtb	%xmm1, %xmm0
               	movapd	%xmm2, %xmm1
               	paddb	%xmm1, %xmm1
               	pand	%xmm5, %xmm0
               	pxor	%xmm0, %xmm1
               	movapd	%xmm1, %xmm2
               	pxor	%xmm4, %xmm2
               	decq	%rsi
               	testl	%esi, %esi
               	jge	<addr>
               	movq	0x18(%r12), %rax
               	leaq	(%rax,%rbx), %rdi
               	movups	%xmm5, 0x50(%rsp)
               	movups	%xmm2, 0x40(%rsp)
               	movups	%xmm3, 0x30(%rsp)
               	callq	<addr>
               	movups	0x50(%rsp), %xmm5
               	movups	0x40(%rsp), %xmm2
               	movups	0x30(%rsp), %xmm3
               	leaq	(%r13,%rax), %rcx
               	leaq	(%r14,%rbx), %rax
               	movapd	%xmm3, %xmm0
               	movdqu	%xmm0, (%rax)
               	leaq	(%r15,%rbx), %rax
               	movapd	%xmm2, %xmm0
               	movdqu	%xmm0, (%rax)
               	movq	%xmm2, %rax
               	andq	$0xff, %rax
               	leaq	(%rcx,%rax), %r13
               	addq	$0x10, %rbx
               	cmpl	$0x30, %ebx
               	jl	<addr>
               	movq	%r13, %rax
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
               	subq	$0x80, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r8d, %r8d
               	leaq	<rip>, %r9 # <addr>
               	imulq	$0x30, %r8, %rcx
               	addq	%r9, %rcx
               	movq	%rcx, -0x80(%rbp,%r8,8)
               	xorl	%eax, %eax
               	leaq	0x3(%r8), %rdx
               	imulq	$0xb, %r8, %rsi
               	movq	%rax, %rdi
               	imulq	%rdx, %rdi
               	imulq	$0x25, %rdi, %rdi
               	addq	%rsi, %rdi
               	addq	$0x5, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x30, %eax
               	jl	<addr>
               	incq	%r8
               	cmpl	$0x4, %r8d
               	jl	<addr>
               	xorl	%esi, %esi
               	leaq	<rip>, %rdx # <addr>
               	leaq	0x90(%rdx), %r9
               	leaq	0x60(%rdx), %rdi
               	leaq	0x30(%rdx), %r8
               	movq	%rsi, %rax
               	movzbq	(%r9,%rax), %rcx
               	movzbq	(%rdi,%rax), %rbx
               	xorq	%rcx, %rbx
               	movq	%rcx, %r12
               	shlq	%r12
               	movl	$0x1d, %r13d
               	testb	$-0x80, %cl
               	cmoveq	%rsi, %r13
               	xorq	%r13, %r12
               	movq	%r12, %rcx
               	andq	$0xff, %rcx
               	movzbq	(%rdi,%rax), %r12
               	xorq	%r12, %rcx
               	movzbq	(%r8,%rax), %r12
               	xorq	%r12, %rbx
               	movq	%rcx, %r12
               	shlq	%r12
               	movl	$0x1d, %r13d
               	xorl	%r14d, %r14d
               	testb	$-0x80, %cl
               	cmoveq	%r14, %r13
               	xorq	%r13, %r12
               	movq	%r12, %rcx
               	andq	$0xff, %rcx
               	movzbq	(%r8,%rax), %r12
               	xorq	%r12, %rcx
               	movzbq	(%rdx,%rax), %r12
               	xorq	%r12, %rbx
               	movq	%rcx, %r12
               	shlq	%r12
               	movl	$0x1d, %r13d
               	xorl	%r14d, %r14d
               	testb	$-0x80, %cl
               	cmoveq	%r14, %r13
               	xorq	%r13, %r12
               	andq	$0xff, %r12
               	movzbq	(%rdx,%rax), %rcx
               	xorq	%r12, %rcx
               	movb	%bl, -0x60(%rbp,%rax)
               	movb	%cl, -0x30(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x30, %eax
               	jl	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x90(%rax), %rdi
               	callq	<addr>
               	movzbq	-0x30(%rbp), %rcx
               	leaq	(%rax,%rcx), %rbx
               	leaq	<rip>, %rax # <addr>
               	addq	$0x90, %rax
               	leaq	0x10(%rax), %rdi
               	callq	<addr>
               	movzbq	-0x20(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	leaq	<rip>, %rax # <addr>
               	addq	$0x90, %rax
               	leaq	0x20(%rax), %rdi
               	callq	<addr>
               	movzbq	-0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	movl	$0x4, %edi
               	movl	$0x30, %esi
               	leaq	-0x80(%rbp), %rdx
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %r8 # <addr>
               	callq	<addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movzbq	(%rdx,%rcx), %rdi
               	movzbq	-0x60(%rbp,%rcx), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	movzbq	(%rsi,%rcx), %rdi
               	movzbq	-0x30(%rbp,%rcx), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x30, %ecx
               	jl	<addr>
               	cmpl	%ebx, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
