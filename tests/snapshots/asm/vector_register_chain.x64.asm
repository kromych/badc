
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
               	leaq	-0x10(%rbp), %rax
               	movabsq	$0x1d1d1d1d1d1d1d1d, %rcx # imm = 0x1D1D1D1D1D1D1D1D
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movdqu	(%rax), %xmm0
               	movups	%xmm0, -0x40(%rbp)
               	xorl	%ebx, %ebx
               	movq	%rbx, %r13
               	movq	0x18(%r12), %rax
               	addq	%rbx, %rax
               	movdqu	(%rax), %xmm0
               	movups	%xmm0, -0x20(%rbp)
               	movl	$0x2, %esi
               	movups	0x50(%rsp), %xmm14
               	movups	%xmm14, 0x40(%rsp)
               	movq	(%r12,%rsi,8), %rax
               	addq	%rbx, %rax
               	movdqu	(%rax), %xmm0
               	movapd	%xmm0, %xmm2
               	movups	0x40(%rsp), %xmm14
               	pxor	%xmm2, %xmm14
               	movups	%xmm14, -0x30(%rbp)
               	movups	0x50(%rsp), %xmm1
               	pxor	%xmm0, %xmm0
               	pcmpgtb	%xmm1, %xmm0
               	movups	0x50(%rsp), %xmm1
               	paddb	%xmm1, %xmm1
               	movups	0x30(%rsp), %xmm14
               	pand	%xmm14, %xmm0
               	pxor	%xmm0, %xmm1
               	movapd	%xmm1, %xmm14
               	pxor	%xmm2, %xmm14
               	movups	%xmm14, -0x20(%rbp)
               	decq	%rsi
               	testl	%esi, %esi
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
               	movups	0x50(%rsp), %xmm14
               	movq	%xmm14, %rax
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
               	subq	$0x88, %rsp
               	pushq	%rbx
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8
               	leaq	-0x20(%rbp), %rax
               	imulq	$0x30, %rcx, %rdx
               	addq	%r8, %rdx
               	movq	%rdx, (%rax,%rcx,8)
               	xorl	%eax, %eax
               	leaq	0x3(%rcx), %rsi
               	imulq	%rax, %rsi
               	imulq	$0x25, %rsi, %rsi
               	imulq	$0xb, %rcx, %rdi
               	addq	%rdi, %rsi
               	addq	$0x5, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x30, %eax
               	jl	<addr>
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%esi, %esi
               	leaq	<rip>, %rcx
               	movq	%rsi, %rax
               	leaq	0x90(%rcx), %rdx
               	movzbq	(%rdx,%rax), %rdx
               	leaq	0x60(%rcx), %rdi
               	movzbq	(%rdi,%rax), %r8
               	xorq	%rdx, %r8
               	movq	%rdx, %r9
               	shlq	%r9
               	testb	$-0x80, %dl
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%r9, %rdx
               	andq	$0xff, %rdx
               	movzbq	(%rdi,%rax), %rdi
               	xorq	%rdi, %rdx
               	leaq	0x30(%rcx), %rdi
               	movzbq	(%rdi,%rax), %rdi
               	xorq	%r8, %rdi
               	movq	%rdx, %r8
               	shlq	%r8
               	testb	$-0x80, %dl
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%r8, %rdx
               	andq	$0xff, %rdx
               	leaq	0x30(%rcx), %r8
               	movzbq	(%r8,%rax), %r8
               	xorq	%r8, %rdx
               	movzbq	(%rcx,%rax), %r8
               	xorq	%r8, %rdi
               	movq	%rdx, %r8
               	shlq	%r8
               	testb	$-0x80, %dl
               	je	<addr>
               	movl	$0x1d, %edx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	movq	%rsi, %rdx
               	jmp	<addr>
               	xorq	%r8, %rdx
               	andq	$0xff, %rdx
               	movzbq	(%rcx,%rax), %r8
               	xorq	%r8, %rdx
               	leaq	-0x80(%rbp), %r8
               	movb	%dil, (%r8,%rax)
               	leaq	-0x50(%rbp), %rdi
               	movb	%dl, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x30, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	leaq	0x90(%rax), %rdi
               	callq	<addr>
               	leaq	-0x50(%rbp), %rcx
               	movzbq	(%rcx), %rcx
               	leaq	(%rax,%rcx), %rbx
               	leaq	<rip>, %rax
               	addq	$0x90, %rax
               	leaq	0x10(%rax), %rdi
               	callq	<addr>
               	leaq	-0x50(%rbp), %rcx
               	movzbq	0x10(%rcx), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	leaq	<rip>, %rax
               	addq	$0x90, %rax
               	leaq	0x20(%rax), %rdi
               	callq	<addr>
               	leaq	-0x50(%rbp), %rcx
               	movzbq	0x20(%rcx), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	movl	$0x4, %edi
               	movl	$0x30, %esi
               	leaq	-0x20(%rbp), %rdx
               	leaq	<rip>, %rcx
               	leaq	<rip>, %r8
               	callq	<addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movzbq	(%rdx,%rcx), %rdi
               	leaq	-0x80(%rbp), %r8
               	movzbq	(%r8,%rcx), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	movzbq	(%rsi,%rcx), %rdi
               	leaq	-0x50(%rbp), %r8
               	movzbq	(%r8,%rcx), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x30, %ecx
               	jl	<addr>
               	cmpl	%ebx, %eax
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
