
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
               	subq	$0x338, %rsp            # imm = 0x338
               	pushq	%rbx
               	movl	$0x13, %ebx
               	movl	$0x17, %ecx
               	movd	%ebx, %xmm0
               	movd	%ecx, %xmm1
               	paddd	%xmm1, %xmm0
               	movd	%xmm0, %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x17, %ebx
               	movd	%ebx, %xmm0
               	paddd	<rip>, %xmm0
               	movd	%xmm0, %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x1c0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0x2a, (%rax)
               	movl	$0x2a, 0x4(%rax)
               	movl	$0x2a, 0x8(%rax)
               	movl	$0x2a, 0xc(%rax)
               	leaq	-0x1b0(%rbp), %rax
               	leaq	-0x1c0(%rbp), %rbx
               	movdqu	(%rbx), %xmm0
               	movdqu	%xmm0, (%rax)
               	movslq	-0x1b0(%rbp), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x15, %ebx
               	movd	%ebx, %xmm0
               	pslld	$0x1, %xmm0
               	movd	%xmm0, %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7, %ebx
               	movl	$0x2a, %ecx
               	movd	%ebx, %xmm0
               	movd	%ecx, %xmm1
               	punpckldq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
               	pshufd	$0x1, %xmm0, %xmm0      # xmm0 = xmm0[1,0,0,0]
               	movd	%xmm0, %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %ebx
               	movq	%rbx, %xmm0
               	movq	%xmm0, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x1c0(%rbp), %rax
               	movdqu	<rip>, %xmm0
               	cvtdq2ps	%xmm0, %xmm0
               	cvtps2dq	%xmm0, %xmm0
               	shufps	$0x1b, %xmm0, %xmm0     # xmm0 = xmm0[3,2,1,0]
               	movdqu	%xmm0, (%rax)
               	movslq	-0x1c0(%rbp), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x330(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x320(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x330(%rbp), %xmm1
               	movups	-0x320(%rbp), %xmm2
               	movdqa	%xmm1, %xmm7
               	paddd	%xmm2, %xmm7
               	movdqa	%xmm7, %xmm0
               	movups	%xmm0, -0x310(%rbp)
               	leaq	-0x310(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	%ebx, -0x1b8(%rbp)
               	movl	%ecx, -0x1c0(%rbp)
               	movl	%edx, -0x1a8(%rbp)
               	movl	-0x1c0(%rbp), %eax
               	shrq	$0x1c, %rax
               	testb	$0x1, %al
               	je	<addr>
               	leaq	-0x300(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x2f0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x300(%rbp), %xmm1
               	movups	-0x2f0(%rbp), %xmm2
               	vpaddd	%xmm2, %xmm1, %xmm0
               	movups	%xmm0, -0x2e0(%rbp)
               	leaq	-0x2e0(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	%ebx, -0x1b8(%rbp)
               	movl	%ecx, -0x1c0(%rbp)
               	movl	%edx, -0x1a8(%rbp)
               	movl	-0x1c0(%rbp), %eax
               	shrq	$0x1c, %rax
               	testb	$0x1, %al
               	je	<addr>
               	leaq	-0x140(%rbp), %rax
               	vmovdqu	<rip>, %xmm0
               	vmovdqu	%xmm0, (%rax)
               	leaq	-0x2d0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x2d0(%rbp), %xmm1
               	vpaddd	<rip>, %xmm1, %xmm0
               	movups	%xmm0, -0x2c0(%rbp)
               	leaq	-0x140(%rbp), %rax
               	movslq	(%rax), %rcx
               	movslq	0xc(%rax), %rax
               	addq	%rcx, %rax
               	subq	$0x2a, %rax
               	leaq	-0x2c0(%rbp), %rcx
               	movslq	0xc(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	%ebx, -0x1b8(%rbp)
               	movl	%ecx, -0x1c0(%rbp)
               	movl	%edx, -0x1a8(%rbp)
               	movl	-0x1c0(%rbp), %eax
               	shrq	$0x1c, %rax
               	testb	$0x1, %al
               	je	<addr>
               	leaq	-0x2b0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x2a0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x2b0(%rbp), %xmm1
               	movups	-0x2a0(%rbp), %xmm2
               	vpmulld	%xmm2, %xmm1, %xmm0
               	movapd	%xmm0, %xmm1
               	vpshufd	$0x1b, %xmm1, %xmm0     # xmm0 = xmm1[3,2,1,0]
               	movups	%xmm0, -0x280(%rbp)
               	movslq	-0x280(%rbp), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	%ebx, -0x30(%rbp)
               	movl	%ecx, -0x28(%rbp)
               	movl	%edx, -0x20(%rbp)
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	%ebx, -0x1b8(%rbp)
               	movl	%ecx, -0x1c0(%rbp)
               	movl	%edx, -0x1a8(%rbp)
               	movl	-0x1c0(%rbp), %eax
               	shrq	$0x1c, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movl	-0x28(%rbp), %eax
               	shrq	$0xc, %rax
               	testb	$0x1, %al
               	je	<addr>
               	leaq	-0x270(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x260(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x250(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x270(%rbp), %xmm4
               	movups	-0x260(%rbp), %xmm5
               	movups	-0x250(%rbp), %xmm6
               	cvtdq2ps	%xmm4, %xmm0
               	cvtdq2ps	%xmm5, %xmm1
               	cvtdq2ps	%xmm6, %xmm2
               	vfmadd231ps	%xmm0, %xmm1, %xmm2 # xmm2 = (xmm1 * xmm0) + xmm2
               	cvtps2dq	%xmm2, %xmm3
               	movups	%xmm3, -0x240(%rbp)
               	leaq	-0x240(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	%ebx, -0x18(%rbp)
               	movl	%ecx, -0x10(%rbp)
               	movl	%edx, -0x8(%rbp)
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	%ebx, -0x1b8(%rbp)
               	movl	%ecx, -0x1c0(%rbp)
               	movl	%edx, -0x1a8(%rbp)
               	movl	-0x1c0(%rbp), %eax
               	shrq	$0x1c, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movl	-0x18(%rbp), %eax
               	shrq	$0x5, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movl	$0x15, %eax
               	movd	%eax, %xmm0
               	vpbroadcastd	%xmm0, %xmm1
               	vpaddd	%xmm1, %xmm1, %xmm2
               	movups	%xmm2, -0x230(%rbp)
               	leaq	-0x230(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	%ebx, -0x18(%rbp)
               	movl	%ecx, -0x10(%rbp)
               	movl	%edx, -0x8(%rbp)
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	%ebx, -0x1b8(%rbp)
               	movl	%ecx, -0x1c0(%rbp)
               	movl	%edx, -0x1a8(%rbp)
               	movl	-0x1c0(%rbp), %eax
               	shrq	$0x1c, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movl	-0x18(%rbp), %eax
               	shrq	$0x5, %rax
               	testb	$0x1, %al
               	je	<addr>
               	leaq	-0x220(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x210(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x220(%rbp), %xmm1
               	movups	-0x210(%rbp), %xmm2
               	vpsllvd	%xmm2, %xmm1, %xmm0
               	movups	%xmm0, -0x200(%rbp)
               	leaq	-0x200(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	%ebx, -0x18(%rbp)
               	movl	%ecx, -0x10(%rbp)
               	movl	%edx, -0x8(%rbp)
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	%ebx, -0x1b8(%rbp)
               	movl	%ecx, -0x1c0(%rbp)
               	movl	%edx, -0x1a8(%rbp)
               	movl	-0x1c0(%rbp), %eax
               	shrq	$0x1c, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movl	-0x18(%rbp), %eax
               	shrq	$0x5, %rax
               	testb	$0x1, %al
               	je	<addr>
               	leaq	-0x1f0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x1e0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x1f0(%rbp), %xmm1
               	movups	-0x1e0(%rbp), %xmm2
               	vpblendd	$0x8, %xmm2, %xmm1, %xmm0 # xmm0 = xmm1[0,1,2],xmm2[3]
               	movups	%xmm0, -0x1d0(%rbp)
               	leaq	-0x1d0(%rbp), %rax
               	movslq	0xc(%rax), %rcx
               	movslq	(%rax), %rax
               	addq	%rcx, %rax
               	decq	%rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
