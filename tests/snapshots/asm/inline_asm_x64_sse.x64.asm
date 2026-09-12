
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
               	subq	$0x370, %rsp            # imm = 0x370
               	movq	%rbx, (%rsp)
               	movl	$0x13, %ebx
               	movl	$0x17, %ecx
               	movd	%ebx, %xmm0
               	movd	%ecx, %xmm1
               	paddd	%xmm1, %xmm0
               	movd	%xmm0, %eax
               	movl	%eax, -0x1e8(%rbp)
               	movslq	-0x1e8(%rbp), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x17, %ebx
               	movd	%ebx, %xmm0
               	paddd	<rip>, %xmm0
               	movd	%xmm0, %eax
               	movl	%eax, -0x1e8(%rbp)
               	movslq	-0x1e8(%rbp), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %ecx
               	leaq	-0x1e0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	%ecx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	%ecx, 0x8(%rax)
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x1d0(%rbp), %rax
               	leaq	-0x1e0(%rbp), %rbx
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
               	movl	$0x15, %ebx
               	movd	%ebx, %xmm0
               	pslld	$0x1, %xmm0
               	movd	%xmm0, %eax
               	movl	%eax, -0x1e8(%rbp)
               	movslq	-0x1e8(%rbp), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x7, %ebx
               	movl	$0x2a, %ecx
               	movd	%ebx, %xmm0
               	movd	%ecx, %xmm1
               	punpckldq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
               	pshufd	$0x1, %xmm0, %xmm0      # xmm0 = xmm0[1,0,0,0]
               	movd	%xmm0, %eax
               	movl	%eax, -0x1e8(%rbp)
               	movslq	-0x1e8(%rbp), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %ebx
               	movq	%rbx, %xmm0
               	movq	%xmm0, %rax
               	movq	%rax, -0x1e8(%rbp)
               	movq	-0x1e8(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x1e0(%rbp), %rax
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
               	leaq	-0x360(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x350(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movups	-0x360(%rbp,%riz), %xmm1
               	movups	-0x350(%rbp,%riz), %xmm2
               	movdqa	%xmm1, %xmm7
               	paddd	%xmm2, %xmm7
               	movdqa	%xmm7, %xmm0
               	movups	%xmm0, -0x340(%rbp,%riz)
               	leaq	-0x340(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %esi
               	movl	$0x1, %eax
               	xorq	%rcx, %rcx
               	cpuid
               	movl	%eax, -0x1e8(%rbp)
               	movl	%ebx, -0x1d8(%rbp)
               	movl	%ecx, -0x1e0(%rbp)
               	movl	%edx, -0x1c8(%rbp)
               	movl	-0x1e0(%rbp), %eax
               	shrq	$0x1c, %rax
               	andq	$0x1, %rax
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
               	leaq	-0x320(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movups	-0x330(%rbp,%riz), %xmm1
               	movups	-0x320(%rbp,%riz), %xmm2
               	vpaddd	%xmm2, %xmm1, %xmm0
               	movups	%xmm0, -0x310(%rbp,%riz)
               	leaq	-0x310(%rbp), %rax
               	movslq	0xc(%rax), %rsi
               	movslq	%esi, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %esi
               	movl	$0x1, %eax
               	xorq	%rcx, %rcx
               	cpuid
               	movl	%eax, -0x1e8(%rbp)
               	movl	%ebx, -0x1d8(%rbp)
               	movl	%ecx, -0x1e0(%rbp)
               	movl	%edx, -0x1c8(%rbp)
               	movl	-0x1e0(%rbp), %eax
               	shrq	$0x1c, %rax
               	andq	$0x1, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x160(%rbp), %rax
               	vmovdqu	<rip>, %xmm0
               	vmovdqu	%xmm0, (%rax)
               	leaq	-0x300(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movups	-0x300(%rbp,%riz), %xmm1
               	vpaddd	<rip>, %xmm1, %xmm0
               	movups	%xmm0, -0x2f0(%rbp,%riz)
               	leaq	-0x160(%rbp), %rax
               	movslq	(%rax), %rcx
               	movslq	0xc(%rax), %rax
               	addq	%rcx, %rax
               	subq	$0x2a, %rax
               	leaq	-0x2f0(%rbp), %rcx
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
               	movl	$0x1, %eax
               	xorq	%rcx, %rcx
               	cpuid
               	movl	%eax, -0x1e8(%rbp)
               	movl	%ebx, -0x1d8(%rbp)
               	movl	%ecx, -0x1e0(%rbp)
               	movl	%edx, -0x1c8(%rbp)
               	movl	-0x1e0(%rbp), %eax
               	shrq	$0x1c, %rax
               	andq	$0x1, %rax
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
               	leaq	-0x2d0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movups	-0x2e0(%rbp,%riz), %xmm1
               	movups	-0x2d0(%rbp,%riz), %xmm2
               	vpmulld	%xmm2, %xmm1, %xmm0
               	movups	%xmm0, -0x2c0(%rbp,%riz)
               	movups	-0x2c0(%rbp,%riz), %xmm1
               	vpshufd	$0x1b, %xmm1, %xmm0     # xmm0 = xmm1[3,2,1,0]
               	movups	%xmm0, -0x2b0(%rbp,%riz)
               	leaq	-0x2b0(%rbp), %rax
               	movslq	(%rax), %rsi
               	movslq	%esi, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %esi
               	xorq	%rdi, %rdi
               	movl	$0x1, %eax
               	xorq	%rcx, %rcx
               	cpuid
               	movl	%eax, -0x40(%rbp)
               	movl	%ebx, -0x38(%rbp)
               	movl	%ecx, -0x30(%rbp)
               	movl	%edx, -0x28(%rbp)
               	movl	$0x1, %eax
               	xorq	%rcx, %rcx
               	cpuid
               	movl	%eax, -0x1e8(%rbp)
               	movl	%ebx, -0x1d8(%rbp)
               	movl	%ecx, -0x1e0(%rbp)
               	movl	%edx, -0x1c8(%rbp)
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
               	setne	%dil
               	movzbq	%dil, %rdi
               	movslq	%edi, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x2a0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x290(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x280(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movups	-0x2a0(%rbp,%riz), %xmm4
               	movups	-0x290(%rbp,%riz), %xmm5
               	movups	-0x280(%rbp,%riz), %xmm6
               	cvtdq2ps	%xmm4, %xmm0
               	cvtdq2ps	%xmm5, %xmm1
               	cvtdq2ps	%xmm6, %xmm2
               	vfmadd231ps	%xmm0, %xmm1, %xmm2 # xmm2 = (xmm1 * xmm0) + xmm2
               	cvtps2dq	%xmm2, %xmm3
               	movups	%xmm3, -0x270(%rbp,%riz)
               	leaq	-0x270(%rbp), %rax
               	movslq	0xc(%rax), %rsi
               	movslq	%esi, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %esi
               	xorq	%rdi, %rdi
               	movl	$0x7, %eax
               	xorq	%rcx, %rcx
               	cpuid
               	movl	%eax, -0x20(%rbp)
               	movl	%ebx, -0x18(%rbp)
               	movl	%ecx, -0x10(%rbp)
               	movl	%edx, -0x8(%rbp)
               	movl	$0x1, %eax
               	xorq	%rcx, %rcx
               	cpuid
               	movl	%eax, -0x1e8(%rbp)
               	movl	%ebx, -0x1d8(%rbp)
               	movl	%ecx, -0x1e0(%rbp)
               	movl	%edx, -0x1c8(%rbp)
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
               	setne	%dil
               	movzbq	%dil, %rdi
               	movslq	%edi, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	movd	%eax, %xmm0
               	vpbroadcastd	%xmm0, %xmm1
               	vpaddd	%xmm1, %xmm1, %xmm2
               	movups	%xmm2, -0x260(%rbp,%riz)
               	leaq	-0x260(%rbp), %rax
               	movslq	0x8(%rax), %rsi
               	movslq	%esi, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %esi
               	xorq	%rdi, %rdi
               	movl	$0x7, %eax
               	xorq	%rcx, %rcx
               	cpuid
               	movl	%eax, -0x20(%rbp)
               	movl	%ebx, -0x18(%rbp)
               	movl	%ecx, -0x10(%rbp)
               	movl	%edx, -0x8(%rbp)
               	movl	$0x1, %eax
               	xorq	%rcx, %rcx
               	cpuid
               	movl	%eax, -0x1e8(%rbp)
               	movl	%ebx, -0x1d8(%rbp)
               	movl	%ecx, -0x1e0(%rbp)
               	movl	%edx, -0x1c8(%rbp)
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
               	setne	%dil
               	movzbq	%dil, %rdi
               	movslq	%edi, %rax
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
               	leaq	-0x240(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movups	-0x250(%rbp,%riz), %xmm1
               	movups	-0x240(%rbp,%riz), %xmm2
               	vpsllvd	%xmm2, %xmm1, %xmm0
               	movups	%xmm0, -0x230(%rbp,%riz)
               	leaq	-0x230(%rbp), %rax
               	movslq	0xc(%rax), %rsi
               	movslq	%esi, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %esi
               	xorq	%rdi, %rdi
               	movl	$0x7, %eax
               	xorq	%rcx, %rcx
               	cpuid
               	movl	%eax, -0x20(%rbp)
               	movl	%ebx, -0x18(%rbp)
               	movl	%ecx, -0x10(%rbp)
               	movl	%edx, -0x8(%rbp)
               	movl	$0x1, %eax
               	xorq	%rcx, %rcx
               	cpuid
               	movl	%eax, -0x1e8(%rbp)
               	movl	%ebx, -0x1d8(%rbp)
               	movl	%ecx, -0x1e0(%rbp)
               	movl	%edx, -0x1c8(%rbp)
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
               	setne	%dil
               	movzbq	%dil, %rdi
               	movslq	%edi, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x220(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x210(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movups	-0x220(%rbp,%riz), %xmm1
               	movups	-0x210(%rbp,%riz), %xmm2
               	vpblendd	$0x8, %xmm2, %xmm1, %xmm0 # xmm0 = xmm1[0,1,2],xmm2[3]
               	movups	%xmm0, -0x200(%rbp,%riz)
               	leaq	-0x200(%rbp), %rax
               	movslq	0xc(%rax), %rcx
               	movslq	(%rax), %rax
               	addq	%rcx, %rax
               	decq	%rax
               	movslq	%eax, %rsi
               	movslq	%esi, %rax
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
