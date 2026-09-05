
inline_asm_x64_sse.x64:	file format elf64-x86-64

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
               	subq	$0x400, %rsp            # imm = 0x400
               	movq	%rbx, (%rsp)
               	movl	$0x13, %eax
               	movl	$0x17, %ecx
               	leaq	-0x1e8(%rbp), %rdx
               	movups	%xmm0, -0x280(%rbp,%riz)
               	movups	%xmm1, -0x270(%rbp,%riz)
               	movq	%rax, -0x260(%rbp)
               	movq	%rcx, -0x258(%rbp)
               	movq	%rbx, -0x250(%rbp)
               	movq	%rdx, -0x248(%rbp)
               	movq	%rax, -0x240(%rbp)
               	movq	%rcx, -0x238(%rbp)
               	movq	-0x240(%rbp), %rbx
               	movq	-0x238(%rbp), %rcx
               	movd	%ebx, %xmm0
               	movd	%ecx, %xmm1
               	paddd	%xmm1, %xmm0
               	movd	%xmm0, %eax
               	movq	-0x248(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x260(%rbp), %rax
               	movq	-0x258(%rbp), %rcx
               	movq	-0x250(%rbp), %rbx
               	movups	-0x280(%rbp,%riz), %xmm0
               	movups	-0x270(%rbp,%riz), %xmm1
               	movslq	-0x1e8(%rbp), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x400, %rsp            # imm = 0x400
               	popq	%rbp
               	retq
               	movl	$0x17, %eax
               	leaq	-0x1e8(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	%xmm0, -0x280(%rbp,%riz)
               	movq	%rax, -0x270(%rbp)
               	movq	%rcx, -0x268(%rbp)
               	movq	%rbx, -0x260(%rbp)
               	movq	%rcx, -0x258(%rbp)
               	movq	%rax, -0x250(%rbp)
               	movq	%rdx, -0x248(%rbp)
               	movq	-0x250(%rbp), %rbx
               	movq	-0x248(%rbp), %rcx
               	movd	%ebx, %xmm0
               	paddd	<rip>, %xmm0
               	movd	%xmm0, %eax
               	movq	-0x258(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x270(%rbp), %rax
               	movq	-0x268(%rbp), %rcx
               	movq	-0x260(%rbp), %rbx
               	movups	-0x280(%rbp,%riz), %xmm0
               	movslq	-0x1e8(%rbp), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x400, %rsp            # imm = 0x400
               	popq	%rbp
               	retq
               	movl	$0x2a, %ecx
               	leaq	-0x1e0(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movl	%ecx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	%ecx, 0x8(%rax)
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x1d0(%rbp), %rcx
               	movups	%xmm0, -0x280(%rbp,%riz)
               	movq	%rax, -0x270(%rbp)
               	movq	%rbx, -0x268(%rbp)
               	movq	%rcx, -0x260(%rbp)
               	movq	%rax, -0x258(%rbp)
               	movq	-0x260(%rbp), %rax
               	movq	-0x258(%rbp), %rbx
               	movdqu	(%rbx), %xmm0
               	movdqu	%xmm0, (%rax)
               	movq	-0x270(%rbp), %rax
               	movq	-0x268(%rbp), %rbx
               	movups	-0x280(%rbp,%riz), %xmm0
               	leaq	-0x1d0(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x400, %rsp            # imm = 0x400
               	popq	%rbp
               	retq
               	movl	$0x15, %eax
               	leaq	-0x1e8(%rbp), %rcx
               	movups	%xmm0, -0x280(%rbp,%riz)
               	movq	%rax, -0x270(%rbp)
               	movq	%rbx, -0x268(%rbp)
               	movq	%rcx, -0x260(%rbp)
               	movq	%rax, -0x258(%rbp)
               	movq	-0x258(%rbp), %rbx
               	movd	%ebx, %xmm0
               	pslld	$0x1, %xmm0
               	movd	%xmm0, %eax
               	movq	-0x260(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x270(%rbp), %rax
               	movq	-0x268(%rbp), %rbx
               	movups	-0x280(%rbp,%riz), %xmm0
               	movslq	-0x1e8(%rbp), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x400, %rsp            # imm = 0x400
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	movl	$0x2a, %ecx
               	leaq	-0x1e8(%rbp), %rdx
               	movups	%xmm0, -0x280(%rbp,%riz)
               	movups	%xmm1, -0x270(%rbp,%riz)
               	movq	%rax, -0x260(%rbp)
               	movq	%rcx, -0x258(%rbp)
               	movq	%rbx, -0x250(%rbp)
               	movq	%rdx, -0x248(%rbp)
               	movq	%rax, -0x240(%rbp)
               	movq	%rcx, -0x238(%rbp)
               	movq	-0x240(%rbp), %rbx
               	movq	-0x238(%rbp), %rcx
               	movd	%ebx, %xmm0
               	movd	%ecx, %xmm1
               	punpckldq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
               	pshufd	$0x1, %xmm0, %xmm0      # xmm0 = xmm0[1,0,0,0]
               	movd	%xmm0, %eax
               	movq	-0x248(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x260(%rbp), %rax
               	movq	-0x258(%rbp), %rcx
               	movq	-0x250(%rbp), %rbx
               	movups	-0x280(%rbp,%riz), %xmm0
               	movups	-0x270(%rbp,%riz), %xmm1
               	movslq	-0x1e8(%rbp), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x400, %rsp            # imm = 0x400
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	leaq	-0x1e8(%rbp), %rcx
               	movups	%xmm0, -0x280(%rbp,%riz)
               	movq	%rax, -0x270(%rbp)
               	movq	%rbx, -0x268(%rbp)
               	movq	%rcx, -0x260(%rbp)
               	movq	%rax, -0x258(%rbp)
               	movq	-0x258(%rbp), %rbx
               	movq	%rbx, %xmm0
               	movq	%xmm0, %rax
               	movq	-0x260(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x270(%rbp), %rax
               	movq	-0x268(%rbp), %rbx
               	movups	-0x280(%rbp,%riz), %xmm0
               	movq	-0x1e8(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	addq	$0x400, %rsp            # imm = 0x400
               	popq	%rbp
               	retq
               	leaq	-0x1e0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	%xmm0, -0x280(%rbp,%riz)
               	movq	%rax, -0x270(%rbp)
               	movq	%rbx, -0x268(%rbp)
               	movq	%rax, -0x260(%rbp)
               	movq	%rcx, -0x258(%rbp)
               	movq	-0x260(%rbp), %rax
               	movq	-0x258(%rbp), %rbx
               	movdqu	<rip>, %xmm0
               	cvtdq2ps	%xmm0, %xmm0
               	cvtps2dq	%xmm0, %xmm0
               	shufps	$0x1b, %xmm0, %xmm0     # xmm0 = xmm0[3,2,1,0]
               	movdqu	%xmm0, (%rax)
               	movq	-0x270(%rbp), %rax
               	movq	-0x268(%rbp), %rbx
               	movups	-0x280(%rbp,%riz), %xmm0
               	leaq	-0x1e0(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	addq	$0x400, %rsp            # imm = 0x400
               	popq	%rbp
               	retq
               	leaq	-0x3f0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	-0x3e0(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movq	%rcx, %rdx
               	leaq	-0x3d0(%rbp), %rdx
               	movups	%xmm0, -0x280(%rbp,%riz)
               	movups	%xmm1, -0x270(%rbp,%riz)
               	movups	%xmm2, -0x260(%rbp,%riz)
               	movups	%xmm7, -0x250(%rbp,%riz)
               	movq	%rdx, -0x240(%rbp)
               	movq	%rax, -0x238(%rbp)
               	movq	%rcx, -0x230(%rbp)
               	movq	-0x238(%rbp), %r10
               	movups	(%r10,%riz), %xmm1
               	movq	-0x230(%rbp), %r10
               	movups	(%r10,%riz), %xmm2
               	movdqa	%xmm1, %xmm7
               	paddd	%xmm2, %xmm7
               	movdqa	%xmm7, %xmm0
               	movq	-0x240(%rbp), %r10
               	movups	%xmm0, (%r10,%riz)
               	movups	-0x280(%rbp,%riz), %xmm0
               	movups	-0x270(%rbp,%riz), %xmm1
               	movups	-0x260(%rbp,%riz), %xmm2
               	movups	-0x250(%rbp,%riz), %xmm7
               	leaq	-0x3d0(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	addq	$0x400, %rsp            # imm = 0x400
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	leaq	-0x1e8(%rbp), %rcx
               	leaq	-0x1d8(%rbp), %rdx
               	leaq	-0x1e0(%rbp), %rsi
               	leaq	-0x1c8(%rbp), %rdi
               	movl	$0x1, %r8d
               	xorq	%r9, %r9
               	movq	%rax, -0x280(%rbp)
               	movq	%rcx, -0x278(%rbp)
               	movq	%rdx, -0x270(%rbp)
               	movq	%rbx, -0x268(%rbp)
               	movq	%rcx, -0x260(%rbp)
               	movq	%rdx, -0x258(%rbp)
               	movq	%rsi, -0x250(%rbp)
               	movq	%rdi, -0x248(%rbp)
               	movq	%r8, -0x240(%rbp)
               	movq	%r9, -0x238(%rbp)
               	movq	-0x240(%rbp), %rax
               	movq	-0x238(%rbp), %rcx
               	cpuid
               	movq	-0x260(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x258(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x250(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x248(%rbp), %r10
               	movl	%edx, (%r10)
               	movq	-0x280(%rbp), %rax
               	movq	-0x278(%rbp), %rcx
               	movq	-0x270(%rbp), %rdx
               	movq	-0x268(%rbp), %rbx
               	movl	-0x1e0(%rbp), %ecx
               	shrq	$0x1c, %rcx
               	andq	$0x1, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x3c0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	-0x3b0(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movq	%rcx, %rdx
               	leaq	-0x3a0(%rbp), %rdx
               	movups	%xmm0, -0x280(%rbp,%riz)
               	movups	%xmm1, -0x270(%rbp,%riz)
               	movups	%xmm2, -0x260(%rbp,%riz)
               	movq	%rdx, -0x250(%rbp)
               	movq	%rax, -0x248(%rbp)
               	movq	%rcx, -0x240(%rbp)
               	movq	-0x248(%rbp), %r10
               	movups	(%r10,%riz), %xmm1
               	movq	-0x240(%rbp), %r10
               	movups	(%r10,%riz), %xmm2
               	vpaddd	%xmm2, %xmm1, %xmm0
               	movq	-0x250(%rbp), %r10
               	movups	%xmm0, (%r10,%riz)
               	movups	-0x280(%rbp,%riz), %xmm0
               	movups	-0x270(%rbp,%riz), %xmm1
               	movups	-0x260(%rbp,%riz), %xmm2
               	leaq	-0x3a0(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	movslq	%eax, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	addq	$0x400, %rsp            # imm = 0x400
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	leaq	-0x1e8(%rbp), %rcx
               	leaq	-0x1d8(%rbp), %rdx
               	leaq	-0x1e0(%rbp), %rsi
               	leaq	-0x1c8(%rbp), %rdi
               	movl	$0x1, %r8d
               	xorq	%r9, %r9
               	movq	%rax, -0x280(%rbp)
               	movq	%rcx, -0x278(%rbp)
               	movq	%rdx, -0x270(%rbp)
               	movq	%rbx, -0x268(%rbp)
               	movq	%rcx, -0x260(%rbp)
               	movq	%rdx, -0x258(%rbp)
               	movq	%rsi, -0x250(%rbp)
               	movq	%rdi, -0x248(%rbp)
               	movq	%r8, -0x240(%rbp)
               	movq	%r9, -0x238(%rbp)
               	movq	-0x240(%rbp), %rax
               	movq	-0x238(%rbp), %rcx
               	cpuid
               	movq	-0x260(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x258(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x250(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x248(%rbp), %r10
               	movl	%edx, (%r10)
               	movq	-0x280(%rbp), %rax
               	movq	-0x278(%rbp), %rcx
               	movq	-0x270(%rbp), %rdx
               	movq	-0x268(%rbp), %rbx
               	movl	-0x1e0(%rbp), %ecx
               	shrq	$0x1c, %rcx
               	andq	$0x1, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x160(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	%xmm0, -0x280(%rbp,%riz)
               	movq	%rax, -0x270(%rbp)
               	movq	%rbx, -0x268(%rbp)
               	movq	%rax, -0x260(%rbp)
               	movq	%rcx, -0x258(%rbp)
               	movq	-0x260(%rbp), %rax
               	movq	-0x258(%rbp), %rbx
               	vmovdqu	<rip>, %xmm0
               	vmovdqu	%xmm0, (%rax)
               	movq	-0x270(%rbp), %rax
               	movq	-0x268(%rbp), %rbx
               	movups	-0x280(%rbp,%riz), %xmm0
               	leaq	-0x390(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	-0x380(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	%xmm0, -0x280(%rbp,%riz)
               	movups	%xmm1, -0x270(%rbp,%riz)
               	movq	%rax, -0x260(%rbp)
               	movq	%rcx, -0x258(%rbp)
               	movq	%rax, -0x250(%rbp)
               	movq	%rdx, -0x248(%rbp)
               	movq	-0x250(%rbp), %r10
               	movups	(%r10,%riz), %xmm1
               	movq	-0x248(%rbp), %rax
               	vpaddd	<rip>, %xmm1, %xmm0
               	movq	-0x258(%rbp), %r10
               	movups	%xmm0, (%r10,%riz)
               	movq	-0x260(%rbp), %rax
               	movups	-0x280(%rbp,%riz), %xmm0
               	movups	-0x270(%rbp,%riz), %xmm1
               	leaq	-0x160(%rbp), %rax
               	movslq	(%rax), %rcx
               	movslq	0xc(%rax), %rax
               	addq	%rcx, %rax
               	subq	$0x2a, %rax
               	leaq	-0x380(%rbp), %rcx
               	movslq	0xc(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	addq	$0x400, %rsp            # imm = 0x400
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	leaq	-0x1e8(%rbp), %rcx
               	leaq	-0x1d8(%rbp), %rdx
               	leaq	-0x1e0(%rbp), %rsi
               	leaq	-0x1c8(%rbp), %rdi
               	movl	$0x1, %r8d
               	xorq	%r9, %r9
               	movq	%rax, -0x280(%rbp)
               	movq	%rcx, -0x278(%rbp)
               	movq	%rdx, -0x270(%rbp)
               	movq	%rbx, -0x268(%rbp)
               	movq	%rcx, -0x260(%rbp)
               	movq	%rdx, -0x258(%rbp)
               	movq	%rsi, -0x250(%rbp)
               	movq	%rdi, -0x248(%rbp)
               	movq	%r8, -0x240(%rbp)
               	movq	%r9, -0x238(%rbp)
               	movq	-0x240(%rbp), %rax
               	movq	-0x238(%rbp), %rcx
               	cpuid
               	movq	-0x260(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x258(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x250(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x248(%rbp), %r10
               	movl	%edx, (%r10)
               	movq	-0x280(%rbp), %rax
               	movq	-0x278(%rbp), %rcx
               	movq	-0x270(%rbp), %rdx
               	movq	-0x268(%rbp), %rbx
               	movl	-0x1e0(%rbp), %ecx
               	shrq	$0x1c, %rcx
               	andq	$0x1, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x370(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	-0x360(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movq	%rcx, %rdx
               	leaq	-0x350(%rbp), %rdx
               	movups	%xmm0, -0x280(%rbp,%riz)
               	movups	%xmm1, -0x270(%rbp,%riz)
               	movups	%xmm2, -0x260(%rbp,%riz)
               	movq	%rdx, -0x250(%rbp)
               	movq	%rax, -0x248(%rbp)
               	movq	%rcx, -0x240(%rbp)
               	movq	-0x248(%rbp), %r10
               	movups	(%r10,%riz), %xmm1
               	movq	-0x240(%rbp), %r10
               	movups	(%r10,%riz), %xmm2
               	vpmulld	%xmm2, %xmm1, %xmm0
               	movq	-0x250(%rbp), %r10
               	movups	%xmm0, (%r10,%riz)
               	movups	-0x280(%rbp,%riz), %xmm0
               	movups	-0x270(%rbp,%riz), %xmm1
               	movups	-0x260(%rbp,%riz), %xmm2
               	leaq	-0x340(%rbp), %rax
               	leaq	-0x350(%rbp), %rcx
               	movups	%xmm0, -0x280(%rbp,%riz)
               	movups	%xmm1, -0x270(%rbp,%riz)
               	movq	%rax, -0x260(%rbp)
               	movq	%rcx, -0x258(%rbp)
               	movq	-0x258(%rbp), %r10
               	movups	(%r10,%riz), %xmm1
               	vpshufd	$0x1b, %xmm1, %xmm0     # xmm0 = xmm1[3,2,1,0]
               	movq	-0x260(%rbp), %r10
               	movups	%xmm0, (%r10,%riz)
               	movups	-0x280(%rbp,%riz), %xmm0
               	movups	-0x270(%rbp,%riz), %xmm1
               	leaq	-0x340(%rbp), %rax
               	movslq	(%rax), %rax
               	movslq	%eax, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	addq	$0x400, %rsp            # imm = 0x400
               	popq	%rbp
               	retq
               	movl	$0x2a, %ecx
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x38(%rbp), %rsi
               	leaq	-0x30(%rbp), %rdi
               	leaq	-0x28(%rbp), %r8
               	movl	$0x1, %r9d
               	xorq	%rax, %rax
               	movq	%rax, -0x280(%rbp)
               	movq	%rcx, -0x278(%rbp)
               	movq	%rdx, -0x270(%rbp)
               	movq	%rbx, -0x268(%rbp)
               	movq	%rdx, -0x260(%rbp)
               	movq	%rsi, -0x258(%rbp)
               	movq	%rdi, -0x250(%rbp)
               	movq	%r8, -0x248(%rbp)
               	movq	%r9, -0x240(%rbp)
               	movq	%rax, -0x238(%rbp)
               	movq	-0x240(%rbp), %rax
               	movq	-0x238(%rbp), %rcx
               	cpuid
               	movq	-0x260(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x258(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x250(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x248(%rbp), %r10
               	movl	%edx, (%r10)
               	movq	-0x280(%rbp), %rax
               	movq	-0x278(%rbp), %rcx
               	movq	-0x270(%rbp), %rdx
               	movq	-0x268(%rbp), %rbx
               	leaq	-0x1e8(%rbp), %rdx
               	leaq	-0x1d8(%rbp), %rsi
               	leaq	-0x1e0(%rbp), %rdi
               	leaq	-0x1c8(%rbp), %r8
               	movl	$0x1, %r9d
               	xorq	%rbx, %rbx
               	movq	%rax, -0x280(%rbp)
               	movq	%rcx, -0x278(%rbp)
               	movq	%rdx, -0x270(%rbp)
               	movq	%rbx, -0x268(%rbp)
               	movq	%rdx, -0x260(%rbp)
               	movq	%rsi, -0x258(%rbp)
               	movq	%rdi, -0x250(%rbp)
               	movq	%r8, -0x248(%rbp)
               	movq	%r9, -0x240(%rbp)
               	movq	%rbx, -0x238(%rbp)
               	movq	-0x240(%rbp), %rax
               	movq	-0x238(%rbp), %rcx
               	cpuid
               	movq	-0x260(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x258(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x250(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x248(%rbp), %r10
               	movl	%edx, (%r10)
               	movq	-0x280(%rbp), %rax
               	movq	-0x278(%rbp), %rcx
               	movq	-0x270(%rbp), %rdx
               	movq	-0x268(%rbp), %rbx
               	movl	-0x1e0(%rbp), %edx
               	shrq	$0x1c, %rdx
               	andq	$0x1, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	-0x30(%rbp), %eax
               	shrq	$0xc, %rax
               	andq	$0x1, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x330(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	-0x320(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movq	%rcx, %rdx
               	leaq	-0x310(%rbp), %rdx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rsi
               	leaq	-0x300(%rbp), %rsi
               	movups	%xmm0, -0x280(%rbp,%riz)
               	movups	%xmm1, -0x270(%rbp,%riz)
               	movups	%xmm2, -0x260(%rbp,%riz)
               	movups	%xmm3, -0x250(%rbp,%riz)
               	movups	%xmm4, -0x240(%rbp,%riz)
               	movups	%xmm5, -0x230(%rbp,%riz)
               	movups	%xmm6, -0x220(%rbp,%riz)
               	movq	%rsi, -0x210(%rbp)
               	movq	%rax, -0x208(%rbp)
               	movq	%rcx, -0x200(%rbp)
               	movq	%rdx, -0x1f8(%rbp)
               	movq	-0x208(%rbp), %r10
               	movups	(%r10,%riz), %xmm4
               	movq	-0x200(%rbp), %r10
               	movups	(%r10,%riz), %xmm5
               	movq	-0x1f8(%rbp), %r10
               	movups	(%r10,%riz), %xmm6
               	cvtdq2ps	%xmm4, %xmm0
               	cvtdq2ps	%xmm5, %xmm1
               	cvtdq2ps	%xmm6, %xmm2
               	vfmadd231ps	%xmm0, %xmm1, %xmm2 # xmm2 = (xmm1 * xmm0) + xmm2
               	cvtps2dq	%xmm2, %xmm3
               	movq	-0x210(%rbp), %r10
               	movups	%xmm3, (%r10,%riz)
               	movups	-0x280(%rbp,%riz), %xmm0
               	movups	-0x270(%rbp,%riz), %xmm1
               	movups	-0x260(%rbp,%riz), %xmm2
               	movups	-0x250(%rbp,%riz), %xmm3
               	movups	-0x240(%rbp,%riz), %xmm4
               	movups	-0x230(%rbp,%riz), %xmm5
               	movups	-0x220(%rbp,%riz), %xmm6
               	leaq	-0x300(%rbp), %rax
               	movslq	0xc(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	addq	$0x400, %rsp            # imm = 0x400
               	popq	%rbp
               	retq
               	movl	$0x2a, %ecx
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x18(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x8(%rbp), %r8
               	movl	$0x7, %r9d
               	xorq	%rax, %rax
               	movq	%rax, -0x280(%rbp)
               	movq	%rcx, -0x278(%rbp)
               	movq	%rdx, -0x270(%rbp)
               	movq	%rbx, -0x268(%rbp)
               	movq	%rdx, -0x260(%rbp)
               	movq	%rsi, -0x258(%rbp)
               	movq	%rdi, -0x250(%rbp)
               	movq	%r8, -0x248(%rbp)
               	movq	%r9, -0x240(%rbp)
               	movq	%rax, -0x238(%rbp)
               	movq	-0x240(%rbp), %rax
               	movq	-0x238(%rbp), %rcx
               	cpuid
               	movq	-0x260(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x258(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x250(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x248(%rbp), %r10
               	movl	%edx, (%r10)
               	movq	-0x280(%rbp), %rax
               	movq	-0x278(%rbp), %rcx
               	movq	-0x270(%rbp), %rdx
               	movq	-0x268(%rbp), %rbx
               	leaq	-0x1e8(%rbp), %rdx
               	leaq	-0x1d8(%rbp), %rsi
               	leaq	-0x1e0(%rbp), %rdi
               	leaq	-0x1c8(%rbp), %r8
               	movl	$0x1, %r9d
               	xorq	%rbx, %rbx
               	movq	%rax, -0x280(%rbp)
               	movq	%rcx, -0x278(%rbp)
               	movq	%rdx, -0x270(%rbp)
               	movq	%rbx, -0x268(%rbp)
               	movq	%rdx, -0x260(%rbp)
               	movq	%rsi, -0x258(%rbp)
               	movq	%rdi, -0x250(%rbp)
               	movq	%r8, -0x248(%rbp)
               	movq	%r9, -0x240(%rbp)
               	movq	%rbx, -0x238(%rbp)
               	movq	-0x240(%rbp), %rax
               	movq	-0x238(%rbp), %rcx
               	cpuid
               	movq	-0x260(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x258(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x250(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x248(%rbp), %r10
               	movl	%edx, (%r10)
               	movq	-0x280(%rbp), %rax
               	movq	-0x278(%rbp), %rcx
               	movq	-0x270(%rbp), %rdx
               	movq	-0x268(%rbp), %rbx
               	movl	-0x1e0(%rbp), %edx
               	shrq	$0x1c, %rdx
               	andq	$0x1, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	-0x18(%rbp), %eax
               	shrq	$0x5, %rax
               	andq	$0x1, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x2f0(%rbp), %rax
               	movl	$0x15, %ecx
               	movups	%xmm0, -0x280(%rbp,%riz)
               	movups	%xmm1, -0x270(%rbp,%riz)
               	movups	%xmm2, -0x260(%rbp,%riz)
               	movq	%rax, -0x250(%rbp)
               	movq	%rax, -0x248(%rbp)
               	movq	%rcx, -0x240(%rbp)
               	movq	-0x240(%rbp), %rax
               	movd	%eax, %xmm0
               	vpbroadcastd	%xmm0, %xmm1
               	vpaddd	%xmm1, %xmm1, %xmm2
               	movq	-0x248(%rbp), %r10
               	movups	%xmm2, (%r10,%riz)
               	movq	-0x250(%rbp), %rax
               	movups	-0x280(%rbp,%riz), %xmm0
               	movups	-0x270(%rbp,%riz), %xmm1
               	movups	-0x260(%rbp,%riz), %xmm2
               	leaq	-0x2f0(%rbp), %rax
               	movslq	0x8(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	addq	$0x400, %rsp            # imm = 0x400
               	popq	%rbp
               	retq
               	movl	$0x2a, %ecx
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x18(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x8(%rbp), %r8
               	movl	$0x7, %r9d
               	xorq	%rax, %rax
               	movq	%rax, -0x280(%rbp)
               	movq	%rcx, -0x278(%rbp)
               	movq	%rdx, -0x270(%rbp)
               	movq	%rbx, -0x268(%rbp)
               	movq	%rdx, -0x260(%rbp)
               	movq	%rsi, -0x258(%rbp)
               	movq	%rdi, -0x250(%rbp)
               	movq	%r8, -0x248(%rbp)
               	movq	%r9, -0x240(%rbp)
               	movq	%rax, -0x238(%rbp)
               	movq	-0x240(%rbp), %rax
               	movq	-0x238(%rbp), %rcx
               	cpuid
               	movq	-0x260(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x258(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x250(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x248(%rbp), %r10
               	movl	%edx, (%r10)
               	movq	-0x280(%rbp), %rax
               	movq	-0x278(%rbp), %rcx
               	movq	-0x270(%rbp), %rdx
               	movq	-0x268(%rbp), %rbx
               	leaq	-0x1e8(%rbp), %rdx
               	leaq	-0x1d8(%rbp), %rsi
               	leaq	-0x1e0(%rbp), %rdi
               	leaq	-0x1c8(%rbp), %r8
               	movl	$0x1, %r9d
               	xorq	%rbx, %rbx
               	movq	%rax, -0x280(%rbp)
               	movq	%rcx, -0x278(%rbp)
               	movq	%rdx, -0x270(%rbp)
               	movq	%rbx, -0x268(%rbp)
               	movq	%rdx, -0x260(%rbp)
               	movq	%rsi, -0x258(%rbp)
               	movq	%rdi, -0x250(%rbp)
               	movq	%r8, -0x248(%rbp)
               	movq	%r9, -0x240(%rbp)
               	movq	%rbx, -0x238(%rbp)
               	movq	-0x240(%rbp), %rax
               	movq	-0x238(%rbp), %rcx
               	cpuid
               	movq	-0x260(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x258(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x250(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x248(%rbp), %r10
               	movl	%edx, (%r10)
               	movq	-0x280(%rbp), %rax
               	movq	-0x278(%rbp), %rcx
               	movq	-0x270(%rbp), %rdx
               	movq	-0x268(%rbp), %rbx
               	movl	-0x1e0(%rbp), %edx
               	shrq	$0x1c, %rdx
               	andq	$0x1, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	-0x18(%rbp), %eax
               	shrq	$0x5, %rax
               	andq	$0x1, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x2e0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	-0x2d0(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movq	%rcx, %rdx
               	leaq	-0x2c0(%rbp), %rdx
               	movups	%xmm0, -0x280(%rbp,%riz)
               	movups	%xmm1, -0x270(%rbp,%riz)
               	movups	%xmm2, -0x260(%rbp,%riz)
               	movq	%rdx, -0x250(%rbp)
               	movq	%rax, -0x248(%rbp)
               	movq	%rcx, -0x240(%rbp)
               	movq	-0x248(%rbp), %r10
               	movups	(%r10,%riz), %xmm1
               	movq	-0x240(%rbp), %r10
               	movups	(%r10,%riz), %xmm2
               	vpsllvd	%xmm2, %xmm1, %xmm0
               	movq	-0x250(%rbp), %r10
               	movups	%xmm0, (%r10,%riz)
               	movups	-0x280(%rbp,%riz), %xmm0
               	movups	-0x270(%rbp,%riz), %xmm1
               	movups	-0x260(%rbp,%riz), %xmm2
               	leaq	-0x2c0(%rbp), %rax
               	movslq	0xc(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	addq	$0x400, %rsp            # imm = 0x400
               	popq	%rbp
               	retq
               	movl	$0x2a, %ecx
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x18(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x8(%rbp), %r8
               	movl	$0x7, %r9d
               	xorq	%rax, %rax
               	movq	%rax, -0x280(%rbp)
               	movq	%rcx, -0x278(%rbp)
               	movq	%rdx, -0x270(%rbp)
               	movq	%rbx, -0x268(%rbp)
               	movq	%rdx, -0x260(%rbp)
               	movq	%rsi, -0x258(%rbp)
               	movq	%rdi, -0x250(%rbp)
               	movq	%r8, -0x248(%rbp)
               	movq	%r9, -0x240(%rbp)
               	movq	%rax, -0x238(%rbp)
               	movq	-0x240(%rbp), %rax
               	movq	-0x238(%rbp), %rcx
               	cpuid
               	movq	-0x260(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x258(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x250(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x248(%rbp), %r10
               	movl	%edx, (%r10)
               	movq	-0x280(%rbp), %rax
               	movq	-0x278(%rbp), %rcx
               	movq	-0x270(%rbp), %rdx
               	movq	-0x268(%rbp), %rbx
               	leaq	-0x1e8(%rbp), %rdx
               	leaq	-0x1d8(%rbp), %rsi
               	leaq	-0x1e0(%rbp), %rdi
               	leaq	-0x1c8(%rbp), %r8
               	movl	$0x1, %r9d
               	xorq	%rbx, %rbx
               	movq	%rax, -0x280(%rbp)
               	movq	%rcx, -0x278(%rbp)
               	movq	%rdx, -0x270(%rbp)
               	movq	%rbx, -0x268(%rbp)
               	movq	%rdx, -0x260(%rbp)
               	movq	%rsi, -0x258(%rbp)
               	movq	%rdi, -0x250(%rbp)
               	movq	%r8, -0x248(%rbp)
               	movq	%r9, -0x240(%rbp)
               	movq	%rbx, -0x238(%rbp)
               	movq	-0x240(%rbp), %rax
               	movq	-0x238(%rbp), %rcx
               	cpuid
               	movq	-0x260(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x258(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x250(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x248(%rbp), %r10
               	movl	%edx, (%r10)
               	movq	-0x280(%rbp), %rax
               	movq	-0x278(%rbp), %rcx
               	movq	-0x270(%rbp), %rdx
               	movq	-0x268(%rbp), %rbx
               	movl	-0x1e0(%rbp), %edx
               	shrq	$0x1c, %rdx
               	andq	$0x1, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	-0x18(%rbp), %eax
               	shrq	$0x5, %rax
               	andq	$0x1, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x2b0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	-0x2a0(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movq	%rcx, %rdx
               	leaq	-0x290(%rbp), %rdx
               	movups	%xmm0, -0x280(%rbp,%riz)
               	movups	%xmm1, -0x270(%rbp,%riz)
               	movups	%xmm2, -0x260(%rbp,%riz)
               	movq	%rdx, -0x250(%rbp)
               	movq	%rax, -0x248(%rbp)
               	movq	%rcx, -0x240(%rbp)
               	movq	-0x248(%rbp), %r10
               	movups	(%r10,%riz), %xmm1
               	movq	-0x240(%rbp), %r10
               	movups	(%r10,%riz), %xmm2
               	vpblendd	$0x8, %xmm2, %xmm1, %xmm0 # xmm0 = xmm1[0,1,2],xmm2[3]
               	movq	-0x250(%rbp), %r10
               	movups	%xmm0, (%r10,%riz)
               	movups	-0x280(%rbp,%riz), %xmm0
               	movups	-0x270(%rbp,%riz), %xmm1
               	movups	-0x260(%rbp,%riz), %xmm2
               	leaq	-0x290(%rbp), %rax
               	movslq	0xc(%rax), %rcx
               	movslq	(%rax), %rax
               	addq	%rcx, %rax
               	decq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	addq	$0x400, %rsp            # imm = 0x400
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	addq	$0x400, %rsp            # imm = 0x400
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
