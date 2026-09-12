
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
               	subq	$0x3a0, %rsp            # imm = 0x3A0
               	movq	%rbx, (%rsp)
               	movl	$0x13, %eax
               	movl	$0x17, %ecx
               	leaq	-0x1e8(%rbp), %rdx
               	movq	%rdx, -0x220(%rbp)
               	movq	%rax, -0x218(%rbp)
               	movq	%rcx, -0x210(%rbp)
               	movq	-0x218(%rbp), %rbx
               	movq	-0x210(%rbp), %rcx
               	movd	%ebx, %xmm0
               	movd	%ecx, %xmm1
               	paddd	%xmm1, %xmm0
               	movd	%xmm0, %eax
               	movq	-0x220(%rbp), %r10
               	movl	%eax, (%r10)
               	movslq	-0x1e8(%rbp), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x17, %eax
               	leaq	-0x1e8(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movq	%rcx, -0x220(%rbp)
               	movq	%rax, -0x218(%rbp)
               	movq	%rdx, -0x210(%rbp)
               	movq	-0x218(%rbp), %rbx
               	movq	-0x210(%rbp), %rcx
               	movd	%ebx, %xmm0
               	paddd	<rip>, %xmm0
               	movd	%xmm0, %eax
               	movq	-0x220(%rbp), %r10
               	movl	%eax, (%r10)
               	movslq	-0x1e8(%rbp), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
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
               	movq	%rcx, -0x220(%rbp)
               	movq	%rax, -0x218(%rbp)
               	movq	-0x220(%rbp), %rax
               	movq	-0x218(%rbp), %rbx
               	movdqu	(%rbx), %xmm0
               	movdqu	%xmm0, (%rax)
               	leaq	-0x1d0(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x15, %eax
               	leaq	-0x1e8(%rbp), %rcx
               	movq	%rcx, -0x220(%rbp)
               	movq	%rax, -0x218(%rbp)
               	movq	-0x218(%rbp), %rbx
               	movd	%ebx, %xmm0
               	pslld	$0x1, %xmm0
               	movd	%xmm0, %eax
               	movq	-0x220(%rbp), %r10
               	movl	%eax, (%r10)
               	movslq	-0x1e8(%rbp), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x7, %eax
               	movl	$0x2a, %ecx
               	leaq	-0x1e8(%rbp), %rdx
               	movq	%rdx, -0x220(%rbp)
               	movq	%rax, -0x218(%rbp)
               	movq	%rcx, -0x210(%rbp)
               	movq	-0x218(%rbp), %rbx
               	movq	-0x210(%rbp), %rcx
               	movd	%ebx, %xmm0
               	movd	%ecx, %xmm1
               	punpckldq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
               	pshufd	$0x1, %xmm0, %xmm0      # xmm0 = xmm0[1,0,0,0]
               	movd	%xmm0, %eax
               	movq	-0x220(%rbp), %r10
               	movl	%eax, (%r10)
               	movslq	-0x1e8(%rbp), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	leaq	-0x1e8(%rbp), %rcx
               	movq	%rcx, -0x220(%rbp)
               	movq	%rax, -0x218(%rbp)
               	movq	-0x218(%rbp), %rbx
               	movq	%rbx, %xmm0
               	movq	%xmm0, %rax
               	movq	-0x220(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x1e8(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x1e0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rax, -0x220(%rbp)
               	movq	%rcx, -0x218(%rbp)
               	movq	-0x220(%rbp), %rax
               	movq	-0x218(%rbp), %rbx
               	movdqu	<rip>, %xmm0
               	cvtdq2ps	%xmm0, %xmm0
               	cvtps2dq	%xmm0, %xmm0
               	shufps	$0x1b, %xmm0, %xmm0     # xmm0 = xmm0[3,2,1,0]
               	movdqu	%xmm0, (%rax)
               	leaq	-0x1e0(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x390(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x380(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x370(%rbp), %rdx
               	movq	%rdx, -0x220(%rbp)
               	movq	%rax, -0x218(%rbp)
               	movq	%rcx, -0x210(%rbp)
               	movq	-0x218(%rbp), %r10
               	movups	(%r10,%riz), %xmm1
               	movq	-0x210(%rbp), %r10
               	movups	(%r10,%riz), %xmm2
               	movdqa	%xmm1, %xmm7
               	paddd	%xmm2, %xmm7
               	movdqa	%xmm7, %xmm0
               	movq	-0x220(%rbp), %r10
               	movups	%xmm0, (%r10,%riz)
               	leaq	-0x370(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %esi
               	leaq	-0x1e8(%rbp), %rax
               	leaq	-0x1d8(%rbp), %rcx
               	leaq	-0x1e0(%rbp), %rdx
               	leaq	-0x1c8(%rbp), %rdi
               	movl	$0x1, %r8d
               	xorq	%r9, %r9
               	movq	%rax, -0x220(%rbp)
               	movq	%rcx, -0x218(%rbp)
               	movq	%rdx, -0x210(%rbp)
               	movq	%rdi, -0x208(%rbp)
               	movq	%r8, -0x200(%rbp)
               	movq	%r9, -0x1f8(%rbp)
               	movq	-0x200(%rbp), %rax
               	movq	-0x1f8(%rbp), %rcx
               	cpuid
               	movq	-0x220(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x218(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x210(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x208(%rbp), %r10
               	movl	%edx, (%r10)
               	movl	-0x1e0(%rbp), %eax
               	shrq	$0x1c, %rax
               	andq	$0x1, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x360(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x350(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x340(%rbp), %rdx
               	movq	%rdx, -0x220(%rbp)
               	movq	%rax, -0x218(%rbp)
               	movq	%rcx, -0x210(%rbp)
               	movq	-0x218(%rbp), %r10
               	movups	(%r10,%riz), %xmm1
               	movq	-0x210(%rbp), %r10
               	movups	(%r10,%riz), %xmm2
               	vpaddd	%xmm2, %xmm1, %xmm0
               	movq	-0x220(%rbp), %r10
               	movups	%xmm0, (%r10,%riz)
               	leaq	-0x340(%rbp), %rax
               	movslq	0xc(%rax), %rsi
               	movslq	%esi, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %esi
               	leaq	-0x1e8(%rbp), %rax
               	leaq	-0x1d8(%rbp), %rcx
               	leaq	-0x1e0(%rbp), %rdx
               	leaq	-0x1c8(%rbp), %rdi
               	movl	$0x1, %r8d
               	xorq	%r9, %r9
               	movq	%rax, -0x220(%rbp)
               	movq	%rcx, -0x218(%rbp)
               	movq	%rdx, -0x210(%rbp)
               	movq	%rdi, -0x208(%rbp)
               	movq	%r8, -0x200(%rbp)
               	movq	%r9, -0x1f8(%rbp)
               	movq	-0x200(%rbp), %rax
               	movq	-0x1f8(%rbp), %rcx
               	cpuid
               	movq	-0x220(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x218(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x210(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x208(%rbp), %r10
               	movl	%edx, (%r10)
               	movl	-0x1e0(%rbp), %eax
               	shrq	$0x1c, %rax
               	andq	$0x1, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x160(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rax, -0x220(%rbp)
               	movq	%rcx, -0x218(%rbp)
               	movq	-0x220(%rbp), %rax
               	movq	-0x218(%rbp), %rbx
               	vmovdqu	<rip>, %xmm0
               	vmovdqu	%xmm0, (%rax)
               	leaq	-0x330(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x320(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movq	%rcx, -0x220(%rbp)
               	movq	%rax, -0x218(%rbp)
               	movq	%rdx, -0x210(%rbp)
               	movq	-0x218(%rbp), %r10
               	movups	(%r10,%riz), %xmm1
               	movq	-0x210(%rbp), %rax
               	vpaddd	<rip>, %xmm1, %xmm0
               	movq	-0x220(%rbp), %r10
               	movups	%xmm0, (%r10,%riz)
               	leaq	-0x160(%rbp), %rax
               	movslq	(%rax), %rcx
               	movslq	0xc(%rax), %rax
               	addq	%rcx, %rax
               	subq	$0x2a, %rax
               	leaq	-0x320(%rbp), %rcx
               	movslq	0xc(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rsi
               	movslq	%esi, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %esi
               	leaq	-0x1e8(%rbp), %rax
               	leaq	-0x1d8(%rbp), %rcx
               	leaq	-0x1e0(%rbp), %rdx
               	leaq	-0x1c8(%rbp), %rdi
               	movl	$0x1, %r8d
               	xorq	%r9, %r9
               	movq	%rax, -0x220(%rbp)
               	movq	%rcx, -0x218(%rbp)
               	movq	%rdx, -0x210(%rbp)
               	movq	%rdi, -0x208(%rbp)
               	movq	%r8, -0x200(%rbp)
               	movq	%r9, -0x1f8(%rbp)
               	movq	-0x200(%rbp), %rax
               	movq	-0x1f8(%rbp), %rcx
               	cpuid
               	movq	-0x220(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x218(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x210(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x208(%rbp), %r10
               	movl	%edx, (%r10)
               	movl	-0x1e0(%rbp), %eax
               	shrq	$0x1c, %rax
               	andq	$0x1, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x310(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x300(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x2f0(%rbp), %rdx
               	movq	%rdx, -0x220(%rbp)
               	movq	%rax, -0x218(%rbp)
               	movq	%rcx, -0x210(%rbp)
               	movq	-0x218(%rbp), %r10
               	movups	(%r10,%riz), %xmm1
               	movq	-0x210(%rbp), %r10
               	movups	(%r10,%riz), %xmm2
               	vpmulld	%xmm2, %xmm1, %xmm0
               	movq	-0x220(%rbp), %r10
               	movups	%xmm0, (%r10,%riz)
               	leaq	-0x2e0(%rbp), %rax
               	leaq	-0x2f0(%rbp), %rcx
               	movq	%rax, -0x220(%rbp)
               	movq	%rcx, -0x218(%rbp)
               	movq	-0x218(%rbp), %r10
               	movups	(%r10,%riz), %xmm1
               	vpshufd	$0x1b, %xmm1, %xmm0     # xmm0 = xmm1[3,2,1,0]
               	movq	-0x220(%rbp), %r10
               	movups	%xmm0, (%r10,%riz)
               	leaq	-0x2e0(%rbp), %rax
               	movslq	(%rax), %rsi
               	movslq	%esi, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %edi
               	leaq	-0x40(%rbp), %rax
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x28(%rbp), %r8
               	movl	$0x1, %r9d
               	xorq	%rsi, %rsi
               	movq	%rax, -0x220(%rbp)
               	movq	%rcx, -0x218(%rbp)
               	movq	%rdx, -0x210(%rbp)
               	movq	%r8, -0x208(%rbp)
               	movq	%r9, -0x200(%rbp)
               	movq	%rsi, -0x1f8(%rbp)
               	movq	-0x200(%rbp), %rax
               	movq	-0x1f8(%rbp), %rcx
               	cpuid
               	movq	-0x220(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x218(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x210(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x208(%rbp), %r10
               	movl	%edx, (%r10)
               	leaq	-0x1e8(%rbp), %rax
               	leaq	-0x1d8(%rbp), %rcx
               	leaq	-0x1e0(%rbp), %rdx
               	leaq	-0x1c8(%rbp), %r8
               	movl	$0x1, %r9d
               	xorq	%rbx, %rbx
               	movq	%rax, -0x220(%rbp)
               	movq	%rcx, -0x218(%rbp)
               	movq	%rdx, -0x210(%rbp)
               	movq	%r8, -0x208(%rbp)
               	movq	%r9, -0x200(%rbp)
               	movq	%rbx, -0x1f8(%rbp)
               	movq	-0x200(%rbp), %rax
               	movq	-0x1f8(%rbp), %rcx
               	cpuid
               	movq	-0x220(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x218(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x210(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x208(%rbp), %r10
               	movl	%edx, (%r10)
               	movl	-0x1e0(%rbp), %eax
               	shrq	$0x1c, %rax
               	andq	$0x1, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	-0x30(%rbp), %eax
               	shrq	$0xc, %rax
               	andq	$0x1, %rax
               	testl	%eax, %eax
               	setne	%sil
               	movzbq	%sil, %rsi
               	movslq	%esi, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x2d0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x2c0(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x2b0(%rbp), %rdx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	-0x2a0(%rbp), %rsi
               	movq	%rsi, -0x220(%rbp)
               	movq	%rax, -0x218(%rbp)
               	movq	%rcx, -0x210(%rbp)
               	movq	%rdx, -0x208(%rbp)
               	movq	-0x218(%rbp), %r10
               	movups	(%r10,%riz), %xmm4
               	movq	-0x210(%rbp), %r10
               	movups	(%r10,%riz), %xmm5
               	movq	-0x208(%rbp), %r10
               	movups	(%r10,%riz), %xmm6
               	cvtdq2ps	%xmm4, %xmm0
               	cvtdq2ps	%xmm5, %xmm1
               	cvtdq2ps	%xmm6, %xmm2
               	vfmadd231ps	%xmm0, %xmm1, %xmm2 # xmm2 = (xmm1 * xmm0) + xmm2
               	cvtps2dq	%xmm2, %xmm3
               	movq	-0x220(%rbp), %r10
               	movups	%xmm3, (%r10,%riz)
               	leaq	-0x2a0(%rbp), %rax
               	movslq	0xc(%rax), %rdi
               	movslq	%edi, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %edi
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	leaq	-0x8(%rbp), %r8
               	movl	$0x7, %r9d
               	xorq	%rsi, %rsi
               	movq	%rax, -0x220(%rbp)
               	movq	%rcx, -0x218(%rbp)
               	movq	%rdx, -0x210(%rbp)
               	movq	%r8, -0x208(%rbp)
               	movq	%r9, -0x200(%rbp)
               	movq	%rsi, -0x1f8(%rbp)
               	movq	-0x200(%rbp), %rax
               	movq	-0x1f8(%rbp), %rcx
               	cpuid
               	movq	-0x220(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x218(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x210(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x208(%rbp), %r10
               	movl	%edx, (%r10)
               	leaq	-0x1e8(%rbp), %rax
               	leaq	-0x1d8(%rbp), %rcx
               	leaq	-0x1e0(%rbp), %rdx
               	leaq	-0x1c8(%rbp), %r8
               	movl	$0x1, %r9d
               	xorq	%rbx, %rbx
               	movq	%rax, -0x220(%rbp)
               	movq	%rcx, -0x218(%rbp)
               	movq	%rdx, -0x210(%rbp)
               	movq	%r8, -0x208(%rbp)
               	movq	%r9, -0x200(%rbp)
               	movq	%rbx, -0x1f8(%rbp)
               	movq	-0x200(%rbp), %rax
               	movq	-0x1f8(%rbp), %rcx
               	cpuid
               	movq	-0x220(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x218(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x210(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x208(%rbp), %r10
               	movl	%edx, (%r10)
               	movl	-0x1e0(%rbp), %eax
               	shrq	$0x1c, %rax
               	andq	$0x1, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	-0x18(%rbp), %eax
               	shrq	$0x5, %rax
               	andq	$0x1, %rax
               	testl	%eax, %eax
               	setne	%sil
               	movzbq	%sil, %rsi
               	movslq	%esi, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x290(%rbp), %rax
               	movl	$0x15, %ecx
               	movq	%rax, -0x220(%rbp)
               	movq	%rcx, -0x218(%rbp)
               	movq	-0x218(%rbp), %rax
               	movd	%eax, %xmm0
               	vpbroadcastd	%xmm0, %xmm1
               	vpaddd	%xmm1, %xmm1, %xmm2
               	movq	-0x220(%rbp), %r10
               	movups	%xmm2, (%r10,%riz)
               	leaq	-0x290(%rbp), %rax
               	movslq	0x8(%rax), %rdi
               	movslq	%edi, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %edi
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	leaq	-0x8(%rbp), %r8
               	movl	$0x7, %r9d
               	xorq	%rsi, %rsi
               	movq	%rax, -0x220(%rbp)
               	movq	%rcx, -0x218(%rbp)
               	movq	%rdx, -0x210(%rbp)
               	movq	%r8, -0x208(%rbp)
               	movq	%r9, -0x200(%rbp)
               	movq	%rsi, -0x1f8(%rbp)
               	movq	-0x200(%rbp), %rax
               	movq	-0x1f8(%rbp), %rcx
               	cpuid
               	movq	-0x220(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x218(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x210(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x208(%rbp), %r10
               	movl	%edx, (%r10)
               	leaq	-0x1e8(%rbp), %rax
               	leaq	-0x1d8(%rbp), %rcx
               	leaq	-0x1e0(%rbp), %rdx
               	leaq	-0x1c8(%rbp), %r8
               	movl	$0x1, %r9d
               	xorq	%rbx, %rbx
               	movq	%rax, -0x220(%rbp)
               	movq	%rcx, -0x218(%rbp)
               	movq	%rdx, -0x210(%rbp)
               	movq	%r8, -0x208(%rbp)
               	movq	%r9, -0x200(%rbp)
               	movq	%rbx, -0x1f8(%rbp)
               	movq	-0x200(%rbp), %rax
               	movq	-0x1f8(%rbp), %rcx
               	cpuid
               	movq	-0x220(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x218(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x210(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x208(%rbp), %r10
               	movl	%edx, (%r10)
               	movl	-0x1e0(%rbp), %eax
               	shrq	$0x1c, %rax
               	andq	$0x1, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	-0x18(%rbp), %eax
               	shrq	$0x5, %rax
               	andq	$0x1, %rax
               	testl	%eax, %eax
               	setne	%sil
               	movzbq	%sil, %rsi
               	movslq	%esi, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x280(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x270(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x260(%rbp), %rdx
               	movq	%rdx, -0x220(%rbp)
               	movq	%rax, -0x218(%rbp)
               	movq	%rcx, -0x210(%rbp)
               	movq	-0x218(%rbp), %r10
               	movups	(%r10,%riz), %xmm1
               	movq	-0x210(%rbp), %r10
               	movups	(%r10,%riz), %xmm2
               	vpsllvd	%xmm2, %xmm1, %xmm0
               	movq	-0x220(%rbp), %r10
               	movups	%xmm0, (%r10,%riz)
               	leaq	-0x260(%rbp), %rax
               	movslq	0xc(%rax), %rdi
               	movslq	%edi, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %edi
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	leaq	-0x8(%rbp), %r8
               	movl	$0x7, %r9d
               	xorq	%rsi, %rsi
               	movq	%rax, -0x220(%rbp)
               	movq	%rcx, -0x218(%rbp)
               	movq	%rdx, -0x210(%rbp)
               	movq	%r8, -0x208(%rbp)
               	movq	%r9, -0x200(%rbp)
               	movq	%rsi, -0x1f8(%rbp)
               	movq	-0x200(%rbp), %rax
               	movq	-0x1f8(%rbp), %rcx
               	cpuid
               	movq	-0x220(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x218(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x210(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x208(%rbp), %r10
               	movl	%edx, (%r10)
               	leaq	-0x1e8(%rbp), %rax
               	leaq	-0x1d8(%rbp), %rcx
               	leaq	-0x1e0(%rbp), %rdx
               	leaq	-0x1c8(%rbp), %r8
               	movl	$0x1, %r9d
               	xorq	%rbx, %rbx
               	movq	%rax, -0x220(%rbp)
               	movq	%rcx, -0x218(%rbp)
               	movq	%rdx, -0x210(%rbp)
               	movq	%r8, -0x208(%rbp)
               	movq	%r9, -0x200(%rbp)
               	movq	%rbx, -0x1f8(%rbp)
               	movq	-0x200(%rbp), %rax
               	movq	-0x1f8(%rbp), %rcx
               	cpuid
               	movq	-0x220(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x218(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x210(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x208(%rbp), %r10
               	movl	%edx, (%r10)
               	movl	-0x1e0(%rbp), %eax
               	shrq	$0x1c, %rax
               	andq	$0x1, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	-0x18(%rbp), %eax
               	shrq	$0x5, %rax
               	andq	$0x1, %rax
               	testl	%eax, %eax
               	setne	%sil
               	movzbq	%sil, %rsi
               	movslq	%esi, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x250(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x240(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x230(%rbp), %rdx
               	movq	%rdx, -0x220(%rbp)
               	movq	%rax, -0x218(%rbp)
               	movq	%rcx, -0x210(%rbp)
               	movq	-0x218(%rbp), %r10
               	movups	(%r10,%riz), %xmm1
               	movq	-0x210(%rbp), %r10
               	movups	(%r10,%riz), %xmm2
               	vpblendd	$0x8, %xmm2, %xmm1, %xmm0 # xmm0 = xmm1[0,1,2],xmm2[3]
               	movq	-0x220(%rbp), %r10
               	movups	%xmm0, (%r10,%riz)
               	leaq	-0x230(%rbp), %rax
               	movslq	0xc(%rax), %rcx
               	movslq	(%rax), %rax
               	addq	%rcx, %rax
               	decq	%rax
               	movslq	%eax, %rdi
               	movslq	%edi, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	leave
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
