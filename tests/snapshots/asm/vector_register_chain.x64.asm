
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
               	leaq	(%rdi), %rax
               	movzbq	(%rax), %rax
               	addq	$0x0, %rax
               	movl	%eax, %eax
               	movzbq	0x1(%rdi), %rcx
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	movzbq	0x2(%rdi), %rcx
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	movzbq	0x3(%rdi), %rcx
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	movzbq	0x4(%rdi), %rcx
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	movzbq	0x5(%rdi), %rcx
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	movzbq	0x6(%rdi), %rcx
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	movzbq	0x7(%rdi), %rcx
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	movzbq	0x8(%rdi), %rcx
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	movzbq	0x9(%rdi), %rcx
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	movzbq	0xa(%rdi), %rcx
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	movzbq	0xb(%rdi), %rcx
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	movzbq	0xc(%rdi), %rcx
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	movzbq	0xd(%rdi), %rcx
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	movzbq	0xe(%rdi), %rcx
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	movzbq	0xf(%rdi), %rcx
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	retq

<syndrome>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movq	%rdx, %rbx
               	movq	%r8, %r14
               	movq	%rcx, %r13
               	leaq	-0x18(%rbp), %rax
               	movabsq	$0x1d1d1d1d1d1d1d1d, %rcx # imm = 0x1D1D1D1D1D1D1D1D
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	movdqu	(%rax), %xmm0
               	movups	%xmm0, -0x50(%rbp,%riz)
               	xorq	%r12, %r12
               	movq	%r12, %rsi
               	jmp	<addr>
               	movq	0x18(%rbx), %rax
               	movslq	%r12d, %rcx
               	addq	%rcx, %rax
               	movdqu	(%rax), %xmm0
               	movups	%xmm0, -0x30(%rbp,%riz)
               	movl	$0x2, %ecx
               	movups	0x50(%rsp), %xmm14
               	movups	%xmm14, 0x40(%rsp)
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	(%rbx,%rax,8), %rax
               	movslq	%r12d, %rdx
               	addq	%rdx, %rax
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
               	movslq	%ecx, %rax
               	leaq	-0x1(%rax), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	movl	%esi, %r15d
               	movq	0x18(%rbx), %rax
               	movslq	%r12d, %rcx
               	leaq	(%rax,%rcx), %rdi
               	callq	<addr>
               	leaq	(%r15,%rax), %rcx
               	movslq	%r12d, %rax
               	addq	%r13, %rax
               	movups	0x40(%rsp), %xmm0
               	movdqu	%xmm0, (%rax)
               	movslq	%r12d, %rax
               	addq	%r14, %rax
               	movups	0x50(%rsp), %xmm0
               	movdqu	%xmm0, (%rax)
               	movl	%ecx, %ecx
               	movups	0x50(%rsp), %xmm0
               	movq	%xmm0, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	andq	$0xff, %rax
               	leaq	(%rcx,%rax), %rsi
               	addq	$0x10, %r12
               	cmpl	$0x30, %r12d
               	jl	<addr>
               	movl	%esi, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%r8, %r8
               	leaq	<rip>, %r9
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rax
               	movslq	%r8d, %rcx
               	imulq	$0x30, %rcx, %rbx
               	leaq	(%r9,%rbx), %rdx
               	movq	%rdx, (%rax,%rcx,8)
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%r9,%rbx), %rsi
               	movslq	%eax, %rdx
               	leaq	(%rsi,%rdx), %r12
               	leaq	0x3(%rcx), %rsi
               	imulq	%rdx, %rsi
               	imulq	$0x25, %rsi, %rsi
               	imulq	$0xb, %rcx, %rdi
               	addq	%rdi, %rsi
               	addq	$0x5, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%r12)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x30, %eax
               	jl	<addr>
               	leaq	0x1(%rcx), %r8
               	cmpl	$0x4, %r8d
               	jl	<addr>
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rdx
               	movq	%rdi, %rax
               	jmp	<addr>
               	leaq	0x90(%rdx), %rsi
               	movslq	%eax, %rcx
               	addq	%rcx, %rsi
               	movzbq	(%rsi), %rsi
               	movq	%rsi, %r8
               	andq	$0xff, %r8
               	leaq	0x60(%rdx), %rsi
               	leaq	(%rsi,%rcx), %r9
               	movzbq	(%r9), %rbx
               	xorq	%r8, %rbx
               	andq	$0xff, %r8
               	andq	$0xff, %r8
               	movq	%r8, %r12
               	shlq	%r12
               	movslq	%r12d, %r12
               	andq	$0x80, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movl	$0x1d, %r8d
               	xorq	%r12, %r8
               	andq	$0xff, %r8
               	movzbq	(%r9), %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	andq	$0xff, %rbx
               	leaq	0x30(%rdx), %r8
               	leaq	(%r8,%rcx), %r9
               	movzbq	(%r9), %r12
               	xorq	%r12, %rbx
               	andq	$0xff, %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, %r12
               	shlq	%r12
               	movslq	%r12d, %r12
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	xorq	%r12, %rsi
               	movq	%rsi, %r12
               	andq	$0xff, %r12
               	movzbq	(%r9), %rsi
               	xorq	%r12, %rsi
               	andq	$0xff, %rsi
               	andq	$0xff, %rbx
               	leaq	(%rdx), %r8
               	leaq	(%r8,%rcx), %r9
               	movzbq	(%r9), %r12
               	xorq	%r12, %rbx
               	andq	$0xff, %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, %r12
               	shlq	%r12
               	movslq	%r12d, %r12
               	andq	$0x80, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1d, %esi
               	xorq	%r12, %rsi
               	movq	%rsi, %r12
               	andq	$0xff, %r12
               	movzbq	(%r9), %rsi
               	xorq	%r12, %rsi
               	andq	$0xff, %rsi
               	leaq	-0x80(%rbp), %r8
               	addq	%rcx, %r8
               	movq	%rbx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%r8)
               	leaq	-0x50(%rbp), %r8
               	addq	%rcx, %r8
               	andq	$0xff, %rsi
               	movb	%sil, (%r8)
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	movq	%rdi, %r8
               	jmp	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x30, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	addq	$0x90, %rax
               	leaq	(%rax), %rdi
               	callq	<addr>
               	leaq	-0x50(%rbp), %rcx
               	addq	$0x0, %rcx
               	movzbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	addq	$0x0, %rax
               	movl	%eax, %ebx
               	leaq	<rip>, %rax
               	addq	$0x90, %rax
               	leaq	0x10(%rax), %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x50(%rbp), %rax
               	movzbq	0x10(%rax), %rax
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	addq	%rbx, %rax
               	movl	%eax, %ebx
               	leaq	<rip>, %rax
               	addq	$0x90, %rax
               	leaq	0x20(%rax), %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x50(%rbp), %rax
               	movzbq	0x20(%rax), %rax
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	addq	%rax, %rbx
               	movl	$0x4, %edi
               	movl	$0x30, %esi
               	leaq	-0x20(%rbp), %rdx
               	leaq	<rip>, %rcx
               	leaq	<rip>, %r8
               	callq	<addr>
               	movq	%rax, %r9
               	xorq	%rax, %rax
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	-0x80(%rbp), %r8
               	addq	%rcx, %r8
               	movzbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	-0x50(%rbp), %r8
               	addq	%rcx, %r8
               	movzbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x30, %eax
               	jl	<addr>
               	movl	%r9d, %eax
               	movl	%ebx, %ecx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
