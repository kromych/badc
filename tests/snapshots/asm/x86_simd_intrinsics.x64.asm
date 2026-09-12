
x86_simd_intrinsics.x64:	file format elf64-x86-64

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

<_mm_castpd_si128>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movups	%xmm0, -0x20(%rbp,%riz)
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, %rcx
               	movups	(%rcx,%riz), %xmm0
               	leave
               	retq

<_mm_castsi128_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movups	%xmm0, -0x20(%rbp,%riz)
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, %rcx
               	movups	(%rcx,%riz), %xmm0
               	leave
               	retq

<same>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movups	%xmm0, -0x50(%rbp,%riz)
               	movq	%rdi, %rsi
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x50(%rbp), %rdx
               	leaq	-0x40(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
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
               	movzbq	0x2(%rax), %rax
               	movzbq	0x2(%rsi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
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
               	movzbq	0x8(%rax), %rax
               	movzbq	0x8(%rsi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
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
               	movzbq	0xe(%rax), %rax
               	movzbq	0xe(%rsi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movzbq	0xf(%rax), %rax
               	movzbq	0xf(%rsi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq

<load>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	movdqu	(%rdi), %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movups	(%rcx,%riz), %xmm0
               	leave
               	retq

<aes128_known_answer>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x3d0, %rsp            # imm = 0x3D0
               	leaq	-0x3d0(%rbp), %rax
               	leaq	<rip>, %rdx
               	leaq	-0x200(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	0x10(%rax), %r8
               	leaq	-0x1f0(%rbp), %rdx
               	movdqu	(%rax), %xmm14
               	aeskeygenassist	$0x1, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x310(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x300(%rbp), %rax
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x80(%rbp), %rdx
               	movdqu	(%rax), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x2f0(%rbp), %rax
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x70(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x2e0(%rbp), %rax
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x60(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x50(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x310(%rbp), %rcx
               	leaq	-0x2e0(%rbp), %rax
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x30(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x310(%rbp), %rax
               	leaq	-0x2e0(%rbp), %rsi
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rsi), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x2f0(%rbp), %rdi
               	leaq	-0x10(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdi), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x2d0(%rbp), %rax
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r8)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r8)
               	popq	%rcx
               	leaq	-0x3d0(%rbp), %rax
               	leaq	0x20(%rax), %r8
               	leaq	0x10(%rax), %rcx
               	leaq	-0x1e0(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	aeskeygenassist	$0x2, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x310(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x300(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x80(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	leaq	-0x70(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	leaq	-0x310(%rbp), %rsi
               	leaq	-0x2e0(%rbp), %rcx
               	leaq	-0x60(%rbp), %rdx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x50(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x310(%rbp), %rcx
               	leaq	-0x2e0(%rbp), %rax
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x30(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x310(%rbp), %rax
               	leaq	-0x2e0(%rbp), %rsi
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rsi), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x2f0(%rbp), %rdi
               	leaq	-0x10(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdi), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x2d0(%rbp), %rax
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r8)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r8)
               	popq	%rcx
               	leaq	-0x3d0(%rbp), %rax
               	leaq	0x30(%rax), %r8
               	leaq	0x20(%rax), %rcx
               	leaq	-0x1d0(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	aeskeygenassist	$0x4, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x310(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x300(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x80(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	leaq	-0x70(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	leaq	-0x310(%rbp), %rsi
               	leaq	-0x2e0(%rbp), %rcx
               	leaq	-0x60(%rbp), %rdx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x50(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x310(%rbp), %rcx
               	leaq	-0x2e0(%rbp), %rax
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x30(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x310(%rbp), %rax
               	leaq	-0x2e0(%rbp), %rsi
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rsi), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x2f0(%rbp), %rdi
               	leaq	-0x10(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdi), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x2d0(%rbp), %rax
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r8)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r8)
               	popq	%rcx
               	leaq	-0x3d0(%rbp), %rax
               	leaq	0x40(%rax), %r8
               	leaq	0x30(%rax), %rcx
               	leaq	-0x1c0(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	aeskeygenassist	$0x8, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x310(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x300(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x80(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	leaq	-0x70(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	leaq	-0x310(%rbp), %rsi
               	leaq	-0x2e0(%rbp), %rcx
               	leaq	-0x60(%rbp), %rdx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x50(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x310(%rbp), %rcx
               	leaq	-0x2e0(%rbp), %rax
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x30(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x310(%rbp), %rax
               	leaq	-0x2e0(%rbp), %rsi
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rsi), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x2f0(%rbp), %rdi
               	leaq	-0x10(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdi), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x2d0(%rbp), %rax
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r8)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r8)
               	popq	%rcx
               	leaq	-0x3d0(%rbp), %rax
               	leaq	0x50(%rax), %r8
               	leaq	0x40(%rax), %rcx
               	leaq	-0x1b0(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	aeskeygenassist	$0x10, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x310(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x300(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x80(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	leaq	-0x70(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	leaq	-0x310(%rbp), %rsi
               	leaq	-0x2e0(%rbp), %rcx
               	leaq	-0x60(%rbp), %rdx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x50(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x310(%rbp), %rcx
               	leaq	-0x2e0(%rbp), %rax
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x30(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x310(%rbp), %rax
               	leaq	-0x2e0(%rbp), %rsi
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rsi), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x2f0(%rbp), %rdi
               	leaq	-0x10(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdi), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x2d0(%rbp), %rax
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r8)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r8)
               	popq	%rcx
               	leaq	-0x3d0(%rbp), %rax
               	leaq	0x60(%rax), %r8
               	leaq	0x50(%rax), %rcx
               	leaq	-0x1a0(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	aeskeygenassist	$0x20, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x310(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x300(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x80(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	leaq	-0x70(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	leaq	-0x310(%rbp), %rsi
               	leaq	-0x2e0(%rbp), %rcx
               	leaq	-0x60(%rbp), %rdx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x50(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x310(%rbp), %rcx
               	leaq	-0x2e0(%rbp), %rax
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x30(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x310(%rbp), %rax
               	leaq	-0x2e0(%rbp), %rsi
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rsi), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x2f0(%rbp), %rdi
               	leaq	-0x10(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdi), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x2d0(%rbp), %rax
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r8)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r8)
               	popq	%rcx
               	leaq	-0x3d0(%rbp), %rax
               	leaq	0x70(%rax), %r8
               	leaq	0x60(%rax), %rcx
               	leaq	-0x190(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	aeskeygenassist	$0x40, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x310(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x300(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x80(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	leaq	-0x70(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	leaq	-0x310(%rbp), %rsi
               	leaq	-0x2e0(%rbp), %rcx
               	leaq	-0x60(%rbp), %rdx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x50(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x310(%rbp), %rcx
               	leaq	-0x2e0(%rbp), %rax
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x30(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x310(%rbp), %rax
               	leaq	-0x2e0(%rbp), %rsi
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rsi), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x2f0(%rbp), %rdi
               	leaq	-0x10(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdi), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x2d0(%rbp), %rax
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r8)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r8)
               	popq	%rcx
               	leaq	-0x3d0(%rbp), %rax
               	leaq	0x80(%rax), %r8
               	leaq	0x70(%rax), %rcx
               	leaq	-0x180(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	aeskeygenassist	$0x80, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x310(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x300(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x80(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	leaq	-0x70(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	leaq	-0x310(%rbp), %rsi
               	leaq	-0x2e0(%rbp), %rcx
               	leaq	-0x60(%rbp), %rdx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x50(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x310(%rbp), %rcx
               	leaq	-0x2e0(%rbp), %rax
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x30(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x310(%rbp), %rax
               	leaq	-0x2e0(%rbp), %rsi
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rsi), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x2f0(%rbp), %rdi
               	leaq	-0x10(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdi), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x2d0(%rbp), %rax
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r8)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r8)
               	popq	%rcx
               	leaq	-0x3d0(%rbp), %rax
               	leaq	0x90(%rax), %r8
               	leaq	0x80(%rax), %rcx
               	leaq	-0x170(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	aeskeygenassist	$0x1b, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x310(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x300(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x80(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	leaq	-0x70(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	leaq	-0x310(%rbp), %rsi
               	leaq	-0x2e0(%rbp), %rcx
               	leaq	-0x60(%rbp), %rdx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x50(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x310(%rbp), %rcx
               	leaq	-0x2e0(%rbp), %rax
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x30(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x310(%rbp), %rax
               	leaq	-0x2e0(%rbp), %rsi
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rsi), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x2f0(%rbp), %rdi
               	leaq	-0x10(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdi), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x2d0(%rbp), %rax
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r8)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r8)
               	popq	%rcx
               	leaq	-0x3d0(%rbp), %rax
               	leaq	0xa0(%rax), %r8
               	leaq	0x90(%rax), %rcx
               	leaq	-0x160(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	aeskeygenassist	$0x36, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x310(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x300(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x80(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	leaq	-0x70(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	leaq	-0x310(%rbp), %rsi
               	leaq	-0x2e0(%rbp), %rcx
               	leaq	-0x60(%rbp), %rdx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x50(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x310(%rbp), %rcx
               	leaq	-0x2e0(%rbp), %rax
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x30(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x310(%rbp), %rax
               	leaq	-0x2e0(%rbp), %rdx
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x2f0(%rbp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x2d0(%rbp), %rax
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r8)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r8)
               	popq	%rcx
               	leaq	-0x320(%rbp), %rcx
               	leaq	<rip>, %rdx
               	leaq	-0x150(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x3d0(%rbp), %rsi
               	leaq	-0x140(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rsi), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	-0x3d0(%rbp), %rsi
               	movslq	%eax, %rdx
               	movq	%rdx, %rdi
               	shlq	$0x4, %rdi
               	addq	%rdi, %rsi
               	leaq	-0x130(%rbp), %rdi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	aesenc	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	leaq	-0x130(%rbp), %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	0x1(%rdx), %rax
               	cmpl	$0xa, %eax
               	jl	<addr>
               	leaq	-0x320(%rbp), %rdi
               	leaq	-0x3d0(%rbp), %rax
               	leaq	0xa0(%rax), %rcx
               	leaq	-0x120(%rbp), %rax
               	movdqu	(%rdi), %xmm15
               	movdqu	(%rcx), %xmm14
               	aesenclast	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	leaq	<rip>, %rsi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	leave
               	retq
               	leaq	-0x320(%rbp), %rcx
               	leaq	<rip>, %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x3d0(%rbp), %rdx
               	leaq	0xa0(%rdx), %rsi
               	leaq	-0x100(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rsi), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movl	$0x9, %eax
               	jmp	<addr>
               	leaq	-0x3d0(%rbp), %rsi
               	movslq	%eax, %rdx
               	movq	%rdx, %rdi
               	shlq	$0x4, %rdi
               	addq	%rdi, %rsi
               	leaq	-0xf0(%rbp), %rdi
               	movdqu	(%rsi), %xmm14
               	aesimc	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	leaq	-0xf0(%rbp), %rsi
               	leaq	-0xe0(%rbp), %rdi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	aesdec	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	leaq	-0xe0(%rbp), %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x1(%rdx), %rax
               	testl	%eax, %eax
               	jg	<addr>
               	leaq	-0x320(%rbp), %rdi
               	leaq	-0x3d0(%rbp), %rcx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rdi), %xmm15
               	movdqu	(%rcx), %xmm14
               	aesdeclast	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	leaq	<rip>, %rsi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x7d0, %rsp            # imm = 0x7D0
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x7c0(%rbp), %rcx
               	movl	$0x4, %edx
               	movl	$0x3, %esi
               	movl	$0x2, %edi
               	movl	$0x1, %r8d
               	leaq	-0x738(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	%r8d, (%rax)
               	movl	%edi, 0x4(%rax)
               	leaq	-0x738(%rbp), %rax
               	movl	%esi, 0x8(%rax)
               	movl	%edx, 0xc(%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x7b0(%rbp), %rcx
               	movl	$0x190, %edx            # imm = 0x190
               	movl	$0x12c, %esi            # imm = 0x12C
               	movl	$0xc8, %edi
               	movl	$0x64, %r8d
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	%r8d, (%rax)
               	leaq	-0x738(%rbp), %rax
               	movl	%edi, 0x4(%rax)
               	movl	%esi, 0x8(%rax)
               	movl	%edx, 0xc(%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x718(%rbp), %rax
               	leaq	-0x7c0(%rbp), %rcx
               	leaq	-0x7b0(%rbp), %rsi
               	leaq	-0x6b0(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	paddd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x780(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	(%rax), %edx
               	xorq	$0x65, %rdx
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	0x4(%rax), %edx
               	xorq	$0xca, %rdx
               	movl	%edx, %edx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	0x8(%rax), %eax
               	xorq	$0x12f, %rax            # imm = 0x12F
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x718(%rbp), %rax
               	movl	0xc(%rax), %edx
               	xorq	$0x194, %rdx            # imm = 0x194
               	movl	%edx, %edx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x7c0(%rbp), %rsi
               	leaq	-0x7b0(%rbp), %rdi
               	leaq	-0x6a0(%rbp), %rdx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rdi), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x780(%rbp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	(%rax), %ecx
               	cmpl	$0x65, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	cmpl	$0x194, %eax            # imm = 0x194
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x718(%rbp), %rax
               	leaq	-0x7c0(%rbp), %rdx
               	leaq	-0x7b0(%rbp), %rcx
               	leaq	-0x690(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rcx), %xmm14
               	por	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x780(%rbp), %rcx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	0x4(%rax), %esi
               	cmpl	$0xca, %esi
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x7b0(%rbp), %rdi
               	leaq	-0x680(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rdi), %xmm14
               	pand	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x780(%rbp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x718(%rbp), %rax
               	movl	0x8(%rax), %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x7c0(%rbp), %rsi
               	xorq	%rcx, %rcx
               	movabsq	$-0x1, %rdx
               	leaq	-0x738(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	%edx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x738(%rbp), %rax
               	movl	%edx, 0x8(%rax)
               	movl	%ecx, 0xc(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	leaq	-0x7b0(%rbp), %rdx
               	xorq	%rcx, %rcx
               	movl	$0x1, %esi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	%esi, (%rax)
               	leaq	-0x738(%rbp), %rax
               	movl	%ecx, 0x4(%rax)
               	movl	%ecx, 0x8(%rax)
               	movl	%ecx, 0xc(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	leaq	-0x718(%rbp), %rax
               	leaq	-0x7c0(%rbp), %rcx
               	leaq	-0x7b0(%rbp), %rsi
               	leaq	-0x670(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	paddd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x780(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	(%rax), %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	0x4(%rax), %edx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x7c0(%rbp), %rdx
               	leaq	-0x7b0(%rbp), %rsi
               	leaq	-0x660(%rbp), %rdi
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rsi), %xmm14
               	paddq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x780(%rbp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x718(%rbp), %rax
               	movl	(%rax), %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	xorq	$0x1, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x650(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rsi), %xmm14
               	paddq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x7b0(%rbp), %rsi
               	leaq	-0x640(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	psubq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x780(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	(%rax), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	jne	<addr>
               	leaq	-0x718(%rbp), %rax
               	movl	0x4(%rax), %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x7c0(%rbp), %rcx
               	movl	$0x11223344, %edx       # imm = 0x11223344
               	movl	$0x55667788, %esi       # imm = 0x55667788
               	movabsq	$-0x66554434, %rdi      # imm = 0x99AABBCC
               	movabsq	$-0x22110100, %r8       # imm = 0xDDEEFF00
               	leaq	-0x738(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	%r8d, (%rax)
               	movl	%edi, 0x4(%rax)
               	leaq	-0x738(%rbp), %rax
               	movl	%esi, 0x8(%rax)
               	movl	%edx, 0xc(%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x718(%rbp), %rax
               	leaq	-0x7c0(%rbp), %rdx
               	leaq	-0x630(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	pslld	$0x4, %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x780(%rbp), %rcx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	0xc(%rax), %esi
               	cmpl	$0x12233440, %esi       # imm = 0x12233440
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x620(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	psrld	$0x4, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x780(%rbp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x718(%rbp), %rax
               	movl	0xc(%rax), %ecx
               	cmpl	$0x1122334, %ecx        # imm = 0x1122334
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x8, %ecx
               	leaq	-0x7c0(%rbp), %rdx
               	leaq	-0x610(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	movq	%rcx, %xmm14
               	psrld	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x780(%rbp), %rcx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	0xc(%rax), %esi
               	cmpl	$0x112233, %esi         # imm = 0x112233
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x600(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	psrld	$0x20, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x780(%rbp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x718(%rbp), %rax
               	movl	(%rax), %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0xc(%rax), %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x7c0(%rbp), %rcx
               	leaq	-0x5f0(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	psllq	$0x8, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x780(%rbp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movdqu	(%rsi), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	(%rax), %edx
               	movl	$0xeeff0000, %r11d      # imm = 0xEEFF0000
               	cmpl	%r11d, %edx
               	jne	<addr>
               	movl	0x4(%rax), %edx
               	movl	$0xaabbccdd, %r11d      # imm = 0xAABBCCDD
               	cmpl	%r11d, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x5e0(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	psrlq	$0x8, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x780(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x718(%rbp), %rax
               	movl	(%rax), %edx
               	movl	$0xccddeeff, %r11d      # imm = 0xCCDDEEFF
               	cmpl	%r11d, %edx
               	jne	<addr>
               	movl	0x4(%rax), %edx
               	cmpl	$0x99aabb, %edx         # imm = 0x99AABB
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x7c0(%rbp), %rdx
               	leaq	-0x5d0(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	(%rax), %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0x4(%rax), %eax
               	movl	$0xddeeff00, %r11d      # imm = 0xDDEEFF00
               	cmpl	%r11d, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0xf, %ecx
               	movl	$0xe, %esi
               	movl	$0xd, %edi
               	movl	$0xc, %r8d
               	movl	$0xb, %r9d
               	movl	$0xa, %ebx
               	leaq	-0x738(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	xorq	%rax, %rax
               	leaq	-0x738(%rbp), %r12
               	movb	%al, (%r12)
               	movl	$0x1, %r12d
               	leaq	-0x738(%rbp), %rax
               	movb	%r12b, 0x1(%rax)
               	movl	$0x2, %r12d
               	leaq	-0x738(%rbp), %rax
               	movb	%r12b, 0x2(%rax)
               	movl	$0x3, %r12d
               	leaq	-0x738(%rbp), %rax
               	movb	%r12b, 0x3(%rax)
               	movl	$0x4, %r12d
               	leaq	-0x738(%rbp), %rax
               	movb	%r12b, 0x4(%rax)
               	movl	$0x5, %r12d
               	leaq	-0x738(%rbp), %rax
               	movb	%r12b, 0x5(%rax)
               	movl	$0x6, %r12d
               	leaq	-0x738(%rbp), %rax
               	movb	%r12b, 0x6(%rax)
               	movl	$0x7, %r12d
               	leaq	-0x738(%rbp), %rax
               	movb	%r12b, 0x7(%rax)
               	movl	$0x8, %r12d
               	leaq	-0x738(%rbp), %rax
               	movb	%r12b, 0x8(%rax)
               	movl	$0x9, %r12d
               	leaq	-0x738(%rbp), %rax
               	movb	%r12b, 0x9(%rax)
               	leaq	-0x738(%rbp), %rax
               	movb	%bl, 0xa(%rax)
               	leaq	-0x738(%rbp), %rax
               	movb	%r9b, 0xb(%rax)
               	movb	%r8b, 0xc(%rax)
               	leaq	-0x738(%rbp), %rax
               	movb	%dil, 0xd(%rax)
               	movb	%sil, 0xe(%rax)
               	movb	%cl, 0xf(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	leaq	-0x728(%rbp), %rax
               	leaq	-0x7c0(%rbp), %rdx
               	leaq	-0x5c0(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	psllw	$0x8, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x780(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movzbq	(%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x1(%rax), %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x2(%rax), %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x3(%rax), %rax
               	xorq	$0x2, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x728(%rbp), %rax
               	leaq	-0x7c0(%rbp), %rdx
               	leaq	-0x5b0(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	psrlw	$0x8, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x780(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movzbq	(%rax), %rcx
               	xorq	$0x1, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x1(%rax), %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x2(%rax), %rcx
               	xorq	$0x3, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x10, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x7c0(%rbp), %rsi
               	leaq	-0x5a0(%rbp), %rdx
               	movdqu	(%rsi), %xmm14
               	pshuflw	$0x1b, %xmm14, %xmm15   # xmm15 = xmm14[3,2,1,0,4,5,6,7]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x780(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x728(%rbp), %rax
               	movzbq	(%rax), %rdx
               	xorq	$0x6, %rdx
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x1(%rax), %rdx
               	xorq	$0x7, %rdx
               	movl	%edx, %edx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x6(%rax), %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x7(%rax), %rdx
               	xorq	$0x1, %rdx
               	movl	%edx, %edx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x8(%rax), %rdx
               	xorq	$0x8, %rdx
               	movl	%edx, %edx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x11, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x590(%rbp), %rdx
               	movdqu	(%rsi), %xmm14
               	pshufhw	$0x1b, %xmm14, %xmm15   # xmm15 = xmm14[0,1,2,3,7,6,5,4]
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x780(%rbp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x728(%rbp), %rax
               	movzbq	(%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x8(%rax), %rcx
               	xorq	$0xe, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x9(%rax), %rcx
               	xorq	$0xf, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xe(%rax), %rcx
               	xorq	$0x8, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	xorq	$0x9, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x7c0(%rbp), %rcx
               	movl	$0x3, %edx
               	movl	$0x2, %esi
               	movl	$0x1, %edi
               	xorq	%r8, %r8
               	leaq	-0x738(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	%r8d, (%rax)
               	movl	%edi, 0x4(%rax)
               	leaq	-0x738(%rbp), %rax
               	movl	%esi, 0x8(%rax)
               	movl	%edx, 0xc(%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x718(%rbp), %rax
               	leaq	-0x7c0(%rbp), %rdx
               	leaq	-0x580(%rbp), %rcx
               	movdqu	(%rdx), %xmm14
               	pshufd	$0x93, %xmm14, %xmm15   # xmm15 = xmm14[3,0,1,2]
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x780(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	(%rax), %ecx
               	xorq	$0x3, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0x8(%rax), %ecx
               	xorq	$0x1, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	xorq	$0x2, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x7c0(%rbp), %rcx
               	movl	$0xf, %edx
               	movl	$0xe, %esi
               	movl	$0xd, %edi
               	movl	$0xc, %r8d
               	movl	$0xb, %r9d
               	movl	$0xa, %ebx
               	leaq	-0x738(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	xorq	%rax, %rax
               	leaq	-0x738(%rbp), %r12
               	movb	%al, (%r12)
               	movl	$0x1, %r12d
               	leaq	-0x738(%rbp), %rax
               	movb	%r12b, 0x1(%rax)
               	movl	$0x2, %r12d
               	leaq	-0x738(%rbp), %rax
               	movb	%r12b, 0x2(%rax)
               	movl	$0x3, %r12d
               	leaq	-0x738(%rbp), %rax
               	movb	%r12b, 0x3(%rax)
               	movl	$0x4, %r12d
               	leaq	-0x738(%rbp), %rax
               	movb	%r12b, 0x4(%rax)
               	movl	$0x5, %r12d
               	leaq	-0x738(%rbp), %rax
               	movb	%r12b, 0x5(%rax)
               	movl	$0x6, %r12d
               	leaq	-0x738(%rbp), %rax
               	movb	%r12b, 0x6(%rax)
               	movl	$0x7, %r12d
               	leaq	-0x738(%rbp), %rax
               	movb	%r12b, 0x7(%rax)
               	movl	$0x8, %r12d
               	leaq	-0x738(%rbp), %rax
               	movb	%r12b, 0x8(%rax)
               	movl	$0x9, %r12d
               	leaq	-0x738(%rbp), %rax
               	movb	%r12b, 0x9(%rax)
               	leaq	-0x738(%rbp), %rax
               	movb	%bl, 0xa(%rax)
               	leaq	-0x738(%rbp), %rax
               	movb	%r9b, 0xb(%rax)
               	movb	%r8b, 0xc(%rax)
               	leaq	-0x738(%rbp), %rax
               	movb	%dil, 0xd(%rax)
               	movb	%sil, 0xe(%rax)
               	movb	%dl, 0xf(%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x7b0(%rbp), %rcx
               	movabsq	$-0x80, %rdx
               	movl	$0x1, %esi
               	movl	$0x2, %edi
               	movl	$0x3, %r8d
               	movl	$0x4, %r9d
               	movl	$0x5, %ebx
               	leaq	-0x738(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0xf, %eax
               	leaq	-0x738(%rbp), %r12
               	movb	%al, (%r12)
               	movl	$0xe, %r12d
               	leaq	-0x738(%rbp), %rax
               	movb	%r12b, 0x1(%rax)
               	movl	$0xd, %r12d
               	leaq	-0x738(%rbp), %rax
               	movb	%r12b, 0x2(%rax)
               	movl	$0xc, %r12d
               	leaq	-0x738(%rbp), %rax
               	movb	%r12b, 0x3(%rax)
               	movl	$0xb, %r12d
               	leaq	-0x738(%rbp), %rax
               	movb	%r12b, 0x4(%rax)
               	movl	$0xa, %r12d
               	leaq	-0x738(%rbp), %rax
               	movb	%r12b, 0x5(%rax)
               	movl	$0x9, %r12d
               	leaq	-0x738(%rbp), %rax
               	movb	%r12b, 0x6(%rax)
               	movl	$0x8, %r12d
               	leaq	-0x738(%rbp), %rax
               	movb	%r12b, 0x7(%rax)
               	movl	$0x7, %r12d
               	leaq	-0x738(%rbp), %rax
               	movb	%r12b, 0x8(%rax)
               	movl	$0x6, %r12d
               	leaq	-0x738(%rbp), %rax
               	movb	%r12b, 0x9(%rax)
               	leaq	-0x738(%rbp), %rax
               	movb	%bl, 0xa(%rax)
               	leaq	-0x738(%rbp), %rax
               	movb	%r9b, 0xb(%rax)
               	movb	%r8b, 0xc(%rax)
               	leaq	-0x738(%rbp), %rax
               	movb	%dil, 0xd(%rax)
               	movb	%sil, 0xe(%rax)
               	movb	%dl, 0xf(%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x728(%rbp), %rax
               	leaq	-0x7c0(%rbp), %rdx
               	leaq	-0x7b0(%rbp), %rsi
               	leaq	-0x570(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pshufb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x780(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movzbq	(%rax), %rcx
               	xorq	$0xf, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xe(%rax), %rcx
               	xorq	$0x1, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x7c0(%rbp), %rsi
               	movl	$0x9, %ecx
               	movl	$0x1, %edx
               	leaq	-0x738(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	%edx, (%rax)
               	movl	%edx, 0x4(%rax)
               	leaq	-0x738(%rbp), %rax
               	movl	%ecx, 0x8(%rax)
               	movl	%ecx, 0xc(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	leaq	-0x7b0(%rbp), %rsi
               	movl	$0x8, %ecx
               	movl	$0x2, %edx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	%edx, (%rax)
               	leaq	-0x738(%rbp), %rax
               	movl	%edx, 0x4(%rax)
               	movl	%ecx, 0x8(%rax)
               	movl	%ecx, 0xc(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	leaq	-0x718(%rbp), %rax
               	leaq	-0x7c0(%rbp), %rcx
               	leaq	-0x7b0(%rbp), %rsi
               	leaq	-0x560(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	punpcklqdq	%xmm14, %xmm15  # xmm15 = xmm15[0],xmm14[0]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x780(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	(%rax), %edx
               	xorq	$0x1, %rdx
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	0x4(%rax), %edx
               	xorq	$0x1, %rdx
               	movl	%edx, %edx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	0x8(%rax), %eax
               	xorq	$0x2, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x718(%rbp), %rax
               	movl	0xc(%rax), %edx
               	xorq	$0x2, %rdx
               	movl	%edx, %edx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x15, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x7c0(%rbp), %rdx
               	leaq	-0x550(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pcmpeqq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x780(%rbp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	(%rax), %ecx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x718(%rbp), %rax
               	leaq	-0x7c0(%rbp), %rcx
               	leaq	-0x7b0(%rbp), %rsi
               	leaq	-0x540(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pcmpeqq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x780(%rbp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movdqu	(%rsi), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	(%rax), %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x77778888, %edx       # imm = 0x77778888
               	movl	$0x55556666, %esi       # imm = 0x55556666
               	movl	$0x33334444, %edi       # imm = 0x33334444
               	movl	$0x11112222, %r8d       # imm = 0x11112222
               	leaq	-0x738(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	%r8d, (%rax)
               	movl	%edi, 0x4(%rax)
               	leaq	-0x738(%rbp), %rax
               	movl	%esi, 0x8(%rax)
               	movl	%edx, 0xc(%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x7c0(%rbp), %rcx
               	leaq	-0x530(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	pextrw	$0x0, %xmm14, %r11d
               	movl	%r11d, (%rax)
               	movslq	(%rax), %rax
               	cmpl	$0x2222, %eax           # imm = 0x2222
               	jne	<addr>
               	leaq	-0x528(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	pextrw	$0x7, %xmm14, %r11d
               	movl	%r11d, (%rax)
               	movslq	(%rax), %rax
               	cmpl	$0x7777, %eax           # imm = 0x7777
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x520(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	pextrd	$0x2, %xmm14, %r11d
               	movl	%r11d, (%rax)
               	movslq	(%rax), %rax
               	cmpl	$0x55556666, %eax       # imm = 0x55556666
               	je	<addr>
               	movl	$0x19, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x718(%rbp), %rax
               	movl	$0xa0b0c0d, %esi        # imm = 0xA0B0C0D
               	leaq	-0x518(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	pinsrd	$0x1, %esi, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x780(%rbp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movdqu	(%rsi), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	0x4(%rax), %edx
               	cmpl	$0xa0b0c0d, %edx        # imm = 0xA0B0C0D
               	jne	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x11112222, %eax       # imm = 0x11112222
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	xorq	%rdx, %rdx
               	movl	$0x3, %esi
               	leaq	-0x738(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rsi, (%rax)
               	movq	%rdx, 0x8(%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x7b0(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x738(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x718(%rbp), %rax
               	leaq	-0x7c0(%rbp), %rcx
               	leaq	-0x508(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rcx), %xmm14
               	pclmulqdq	$0x0, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x780(%rbp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movdqu	(%rsi), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	(%rax), %edx
               	xorq	$0x5, %rdx
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	0x4(%rax), %edx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1b, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x7b0(%rbp), %rsi
               	leaq	-0x4f8(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pclmulqdq	$0x10, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x780(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x718(%rbp), %rax
               	movl	(%rax), %eax
               	xorq	$0x5, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1c, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x7c0(%rbp), %rcx
               	movl	$0x4, %edx
               	movl	$0x3, %esi
               	movl	$0x2, %edi
               	movl	$0x1, %r8d
               	leaq	-0x738(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	%r8d, (%rax)
               	movl	%edi, 0x4(%rax)
               	leaq	-0x738(%rbp), %rax
               	movl	%esi, 0x8(%rax)
               	movl	%edx, 0xc(%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x7b0(%rbp), %rcx
               	movl	$0x8, %edx
               	movl	$0x7, %esi
               	movl	$0x6, %edi
               	movl	$0x5, %r8d
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	%r8d, (%rax)
               	leaq	-0x738(%rbp), %rax
               	movl	%edi, 0x4(%rax)
               	movl	%esi, 0x8(%rax)
               	movl	%edx, 0xc(%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x7a0(%rbp), %rbx
               	leaq	-0x7c0(%rbp), %rdi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	movups	%xmm0, -0x4e8(%rbp,%riz)
               	leaq	-0x4e8(%rbp), %r12
               	leaq	-0x7b0(%rbp), %rdi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	movups	%xmm0, -0x4d8(%rbp,%riz)
               	leaq	-0x4d8(%rbp), %rax
               	leaq	-0x4c8(%rbp), %rdi
               	movdqu	(%r12), %xmm15
               	movdqu	(%rax), %xmm14
               	shufpd	$0x1, %xmm14, %xmm15    # xmm15 = xmm15[1],xmm14[0]
               	movdqu	%xmm15, (%rdi)
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	callq	<addr>
               	movups	%xmm0, -0x738(%rbp,%riz)
               	leaq	-0x738(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	leaq	-0x718(%rbp), %rax
               	leaq	-0x7a0(%rbp), %rdx
               	leaq	-0x780(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	(%rax), %ecx
               	xorq	$0x3, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	xorq	$0x4, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0x8(%rax), %ecx
               	xorq	$0x5, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	xorq	$0x6, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1d, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x718(%rbp), %rax
               	leaq	-0x738(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x780(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	(%rax), %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0x8(%rax), %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1e, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x728(%rbp), %rax
               	leaq	(%rax), %rcx
               	movl	$0x1, %edx
               	movb	%dl, (%rcx)
               	movl	$0x8, %ecx
               	movb	%cl, 0x1(%rax)
               	movl	$0xf, %ecx
               	movb	%cl, 0x2(%rax)
               	movl	$0x16, %ecx
               	movb	%cl, 0x3(%rax)
               	movl	$0x1d, %ecx
               	movb	%cl, 0x4(%rax)
               	movl	$0x24, %ecx
               	movb	%cl, 0x5(%rax)
               	movl	$0x2b, %ecx
               	movb	%cl, 0x6(%rax)
               	leaq	-0x728(%rbp), %rax
               	movl	$0x32, %ecx
               	movb	%cl, 0x7(%rax)
               	movl	$0x39, %ecx
               	movb	%cl, 0x8(%rax)
               	movl	$0x40, %ecx
               	movb	%cl, 0x9(%rax)
               	movl	$0x47, %ecx
               	movb	%cl, 0xa(%rax)
               	movl	$0x4e, %ecx
               	movb	%cl, 0xb(%rax)
               	movl	$0x55, %ecx
               	movb	%cl, 0xc(%rax)
               	movl	$0x5c, %ecx
               	movb	%cl, 0xd(%rax)
               	leaq	-0x728(%rbp), %rdi
               	movl	$0x63, %eax
               	movb	%al, 0xe(%rdi)
               	movl	$0x6a, %eax
               	movb	%al, 0xf(%rdi)
               	leaq	-0x7c0(%rbp), %rbx
               	callq	<addr>
               	movups	%xmm0, -0x738(%rbp,%riz)
               	leaq	-0x738(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	xorq	%rax, %rax
               	leaq	-0x728(%rbp), %rsi
               	movq	%rax, (%rsi)
               	movq	%rax, 0x8(%rsi)
               	leaq	-0x7c0(%rbp), %rdx
               	leaq	-0x780(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rsi)
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdi
               	imulq	$0x7, %rcx, %rdx
               	incq	%rdx
               	andq	$0xff, %rdx
               	cmpl	%edx, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorq	%rcx, %rcx
               	movl	$0x1, %edx
               	movl	$0x2, %esi
               	movl	$0x3, %edi
               	movl	$0x4, %r8d
               	movl	$0x5, %r9d
               	leaq	-0x738(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	%cx, (%rax)
               	leaq	-0x738(%rbp), %rax
               	movw	%dx, 0x2(%rax)
               	movw	%si, 0x4(%rax)
               	movw	%di, 0x6(%rax)
               	leaq	-0x738(%rbp), %rdi
               	movw	%r8w, 0x8(%rdi)
               	movw	%r9w, 0xa(%rdi)
               	movl	$0x6, %eax
               	movw	%ax, 0xc(%rdi)
               	movl	$0x7, %eax
               	movw	%ax, 0xe(%rdi)
               	leaq	<rip>, %rsi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x21, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	xorq	%rcx, %rcx
               	movl	$0x1, %edx
               	movl	$0x2, %esi
               	movl	$0x3, %edi
               	movl	$0x4, %r8d
               	movl	$0x5, %r9d
               	leaq	-0x738(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0x7, %eax
               	leaq	-0x738(%rbp), %rbx
               	movw	%ax, (%rbx)
               	movl	$0x6, %ebx
               	leaq	-0x738(%rbp), %rax
               	movw	%bx, 0x2(%rax)
               	leaq	-0x738(%rbp), %rax
               	movw	%r9w, 0x4(%rax)
               	movw	%r8w, 0x6(%rax)
               	leaq	-0x738(%rbp), %rax
               	movw	%di, 0x8(%rax)
               	movw	%si, 0xa(%rax)
               	movw	%dx, 0xc(%rax)
               	movw	%cx, 0xe(%rax)
               	leaq	-0x738(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x22, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	xorq	%rcx, %rcx
               	movl	$0x1, %edx
               	movl	$0x2, %esi
               	movl	$0x3, %edi
               	movl	$0x4, %r8d
               	movl	$0x5, %r9d
               	leaq	-0x738(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movb	%cl, (%rax)
               	leaq	-0x738(%rbp), %rax
               	movb	%dl, 0x1(%rax)
               	movb	%sil, 0x2(%rax)
               	movb	%dil, 0x3(%rax)
               	leaq	-0x738(%rbp), %rax
               	movb	%r8b, 0x4(%rax)
               	movb	%r9b, 0x5(%rax)
               	movl	$0x6, %ecx
               	movb	%cl, 0x6(%rax)
               	movl	$0x7, %ecx
               	movb	%cl, 0x7(%rax)
               	movl	$0x8, %ecx
               	movb	%cl, 0x8(%rax)
               	movl	$0x9, %ecx
               	movb	%cl, 0x9(%rax)
               	movl	$0xa, %eax
               	leaq	-0x738(%rbp), %rdi
               	movb	%al, 0xa(%rdi)
               	movl	$0xb, %eax
               	movb	%al, 0xb(%rdi)
               	movl	$0xc, %eax
               	movb	%al, 0xc(%rdi)
               	movl	$0xd, %eax
               	movb	%al, 0xd(%rdi)
               	movl	$0xe, %eax
               	movb	%al, 0xe(%rdi)
               	movl	$0xf, %eax
               	movb	%al, 0xf(%rdi)
               	leaq	<rip>, %rsi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x23, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	xorq	%rcx, %rcx
               	movl	$0x1, %edx
               	movl	$0x2, %esi
               	movl	$0x3, %edi
               	movl	$0x4, %r8d
               	movl	$0x5, %r9d
               	leaq	-0x738(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0xf, %eax
               	leaq	-0x738(%rbp), %rbx
               	movb	%al, (%rbx)
               	movl	$0xe, %ebx
               	leaq	-0x738(%rbp), %rax
               	movb	%bl, 0x1(%rax)
               	movl	$0xd, %ebx
               	leaq	-0x738(%rbp), %rax
               	movb	%bl, 0x2(%rax)
               	movl	$0xc, %ebx
               	leaq	-0x738(%rbp), %rax
               	movb	%bl, 0x3(%rax)
               	movl	$0xb, %ebx
               	leaq	-0x738(%rbp), %rax
               	movb	%bl, 0x4(%rax)
               	movl	$0xa, %ebx
               	leaq	-0x738(%rbp), %rax
               	movb	%bl, 0x5(%rax)
               	movl	$0x9, %ebx
               	leaq	-0x738(%rbp), %rax
               	movb	%bl, 0x6(%rax)
               	movl	$0x8, %ebx
               	leaq	-0x738(%rbp), %rax
               	movb	%bl, 0x7(%rax)
               	movl	$0x7, %ebx
               	leaq	-0x738(%rbp), %rax
               	movb	%bl, 0x8(%rax)
               	movl	$0x6, %ebx
               	leaq	-0x738(%rbp), %rax
               	movb	%bl, 0x9(%rax)
               	leaq	-0x738(%rbp), %rax
               	movb	%r9b, 0xa(%rax)
               	movb	%r8b, 0xb(%rax)
               	leaq	-0x738(%rbp), %rax
               	movb	%dil, 0xc(%rax)
               	movb	%sil, 0xd(%rax)
               	movb	%dl, 0xe(%rax)
               	movb	%cl, 0xf(%rax)
               	leaq	-0x738(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movq	%rdi, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x24, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x718(%rbp), %rdx
               	movl	$0x1, %ecx
               	movl	$0x2, %esi
               	movl	$0x3, %edi
               	movl	$0x4, %r8d
               	leaq	-0x738(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	%ecx, (%rax)
               	movl	%esi, 0x4(%rax)
               	leaq	-0x738(%rbp), %rax
               	movl	%edi, 0x8(%rax)
               	movl	%r8d, 0xc(%rax)
               	leaq	-0x780(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x718(%rbp), %rdx
               	movl	(%rdx), %esi
               	xorq	$0x1, %rsi
               	movl	%esi, %esi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movl	0xc(%rdx), %esi
               	xorq	$0x4, %rsi
               	movl	%esi, %esi
               	testl	%esi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x25, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x11223344, %esi       # imm = 0x11223344
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	%esi, (%rax)
               	leaq	-0x738(%rbp), %rax
               	movl	%esi, 0x4(%rax)
               	movl	%esi, 0x8(%rax)
               	movl	%esi, 0xc(%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x718(%rbp), %rsi
               	movl	(%rsi), %eax
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	jne	<addr>
               	movl	0xc(%rsi), %eax
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x26, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x1234, %edx           # imm = 0x1234
               	leaq	-0x738(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	%dx, (%rax)
               	movw	%dx, 0x2(%rax)
               	movw	%dx, 0x4(%rax)
               	movw	%dx, 0x6(%rax)
               	movw	%dx, 0x8(%rax)
               	leaq	-0x738(%rbp), %rcx
               	movw	%dx, 0xa(%rcx)
               	movw	%dx, 0xc(%rcx)
               	movw	%dx, 0xe(%rcx)
               	leaq	-0x780(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x718(%rbp), %rdx
               	movl	(%rdx), %eax
               	cmpl	$0x12341234, %eax       # imm = 0x12341234
               	jne	<addr>
               	movl	0xc(%rdx), %eax
               	cmpl	$0x12341234, %eax       # imm = 0x12341234
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x27, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x5a, %eax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movb	%al, (%rcx)
               	leaq	-0x738(%rbp), %rcx
               	movb	%al, 0x1(%rcx)
               	movb	%al, 0x2(%rcx)
               	movb	%al, 0x3(%rcx)
               	movb	%al, 0x4(%rcx)
               	movb	%al, 0x5(%rcx)
               	movb	%al, 0x6(%rcx)
               	leaq	-0x738(%rbp), %rcx
               	movb	%al, 0x7(%rcx)
               	movb	%al, 0x8(%rcx)
               	movb	%al, 0x9(%rcx)
               	movb	%al, 0xa(%rcx)
               	movb	%al, 0xb(%rcx)
               	movb	%al, 0xc(%rcx)
               	leaq	-0x738(%rbp), %rcx
               	movb	%al, 0xd(%rcx)
               	movb	%al, 0xe(%rcx)
               	movb	%al, 0xf(%rcx)
               	leaq	-0x780(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x718(%rbp), %rdx
               	movl	(%rdx), %esi
               	cmpl	$0x5a5a5a5a, %esi       # imm = 0x5A5A5A5A
               	jne	<addr>
               	movl	0xc(%rdx), %esi
               	cmpl	$0x5a5a5a5a, %esi       # imm = 0x5A5A5A5A
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x28, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movabsq	$0x123456789abcdef, %rsi # imm = 0x123456789ABCDEF
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%rsi, (%rcx)
               	leaq	-0x738(%rbp), %rcx
               	movq	%rsi, 0x8(%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x718(%rbp), %rax
               	movl	(%rax), %edx
               	movl	$0x89abcdef, %r11d      # imm = 0x89ABCDEF
               	cmpl	%r11d, %edx
               	jne	<addr>
               	movl	0x4(%rax), %edx
               	cmpl	$0x1234567, %edx        # imm = 0x1234567
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	cmpl	$0x1234567, %eax        # imm = 0x1234567
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x29, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x7c0(%rbp), %rdx
               	movabsq	$-0x1, %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movb	%al, (%rcx)
               	leaq	-0x738(%rbp), %rcx
               	movb	%al, 0x1(%rcx)
               	movb	%al, 0x2(%rcx)
               	movb	%al, 0x3(%rcx)
               	movb	%al, 0x4(%rcx)
               	movb	%al, 0x5(%rcx)
               	movb	%al, 0x6(%rcx)
               	leaq	-0x738(%rbp), %rcx
               	movb	%al, 0x7(%rcx)
               	movb	%al, 0x8(%rcx)
               	movb	%al, 0x9(%rcx)
               	movb	%al, 0xa(%rcx)
               	movb	%al, 0xb(%rcx)
               	movb	%al, 0xc(%rcx)
               	leaq	-0x738(%rbp), %rcx
               	movb	%al, 0xd(%rcx)
               	movb	%al, 0xe(%rcx)
               	movb	%al, 0xf(%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	-0x7b0(%rbp), %rdx
               	movl	$0x1, %eax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movb	%al, (%rcx)
               	leaq	-0x738(%rbp), %rcx
               	movb	%al, 0x1(%rcx)
               	movb	%al, 0x2(%rcx)
               	movb	%al, 0x3(%rcx)
               	movb	%al, 0x4(%rcx)
               	movb	%al, 0x5(%rcx)
               	movb	%al, 0x6(%rcx)
               	leaq	-0x738(%rbp), %rcx
               	movb	%al, 0x7(%rcx)
               	movb	%al, 0x8(%rcx)
               	movb	%al, 0x9(%rcx)
               	movb	%al, 0xa(%rcx)
               	movb	%al, 0xb(%rcx)
               	movb	%al, 0xc(%rcx)
               	leaq	-0x738(%rbp), %rcx
               	movb	%al, 0xd(%rcx)
               	movb	%al, 0xe(%rcx)
               	movb	%al, 0xf(%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	-0x718(%rbp), %rax
               	leaq	-0x7c0(%rbp), %rcx
               	leaq	-0x7b0(%rbp), %rsi
               	leaq	-0x4b8(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	paddb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x780(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	(%rax), %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	0xc(%rax), %edx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x4a8(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x7b0(%rbp), %rdi
               	leaq	-0x498(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rdi), %xmm14
               	psubb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x780(%rbp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x718(%rbp), %rax
               	movl	(%rax), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x2b, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x7c0(%rbp), %rdx
               	movabsq	$-0x1, %rcx
               	leaq	-0x738(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	movw	%cx, 0x8(%rax)
               	leaq	-0x738(%rbp), %rax
               	movw	%cx, 0xa(%rax)
               	movw	%cx, 0xc(%rax)
               	movw	%cx, 0xe(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	leaq	-0x718(%rbp), %rdx
               	leaq	-0x7c0(%rbp), %rsi
               	movl	$0x1, %ecx
               	leaq	-0x488(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	leaq	-0x488(%rbp), %rax
               	movw	%cx, 0x8(%rax)
               	movw	%cx, 0xa(%rax)
               	movw	%cx, 0xc(%rax)
               	movw	%cx, 0xe(%rax)
               	leaq	-0x478(%rbp), %rcx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rax), %xmm14
               	paddw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x780(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x718(%rbp), %rdx
               	movl	(%rdx), %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2c, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x468(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movl	$0x1, %ecx
               	leaq	-0x458(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	leaq	-0x458(%rbp), %rax
               	movw	%cx, 0x8(%rax)
               	movw	%cx, 0xa(%rax)
               	movw	%cx, 0xc(%rax)
               	movw	%cx, 0xe(%rax)
               	leaq	-0x448(%rbp), %rcx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rax), %xmm14
               	psubw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x780(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x718(%rbp), %rsi
               	movl	(%rsi), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x2d, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x5, %ecx
               	leaq	-0x438(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	%ecx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	%ecx, 0x8(%rax)
               	movl	%ecx, 0xc(%rax)
               	movl	$0x7, %edx
               	leaq	-0x428(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	%edx, (%rcx)
               	movl	%edx, 0x4(%rcx)
               	movl	%edx, 0x8(%rcx)
               	movl	%edx, 0xc(%rcx)
               	leaq	-0x428(%rbp), %rdx
               	leaq	-0x418(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	psubd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x780(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x718(%rbp), %rsi
               	movl	(%rsi), %eax
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x2e, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x1234, %ecx           # imm = 0x1234
               	leaq	-0x408(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	movw	%cx, 0x8(%rax)
               	leaq	-0x408(%rbp), %rdx
               	movw	%cx, 0xa(%rdx)
               	movw	%cx, 0xc(%rdx)
               	movw	%cx, 0xe(%rdx)
               	movl	$0x3, %ecx
               	leaq	-0x3f8(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	leaq	-0x3f8(%rbp), %rax
               	movw	%cx, 0x8(%rax)
               	movw	%cx, 0xa(%rax)
               	movw	%cx, 0xc(%rax)
               	movw	%cx, 0xe(%rax)
               	leaq	-0x3e8(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rax), %xmm14
               	pmullw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x780(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x718(%rbp), %rsi
               	movl	(%rsi), %eax
               	cmpl	$0x369c369c, %eax       # imm = 0x369C369C
               	je	<addr>
               	movl	$0x2f, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movabsq	$-0x1000, %rcx          # imm = 0xF000
               	leaq	-0x3d8(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	movw	%cx, 0x8(%rax)
               	leaq	-0x3d8(%rbp), %rdx
               	movw	%cx, 0xa(%rdx)
               	movw	%cx, 0xc(%rdx)
               	movw	%cx, 0xe(%rdx)
               	movl	$0x10, %ecx
               	leaq	-0x3c8(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	leaq	-0x3c8(%rbp), %rax
               	movw	%cx, 0x8(%rax)
               	movw	%cx, 0xa(%rax)
               	movw	%cx, 0xc(%rax)
               	movw	%cx, 0xe(%rax)
               	leaq	-0x3b8(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rax), %xmm14
               	pmulhw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x780(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x718(%rbp), %rsi
               	movl	(%rsi), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x30, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x1000, %ecx           # imm = 0x1000
               	leaq	-0x3a8(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	movw	%cx, 0x8(%rax)
               	leaq	-0x3a8(%rbp), %rdx
               	movw	%cx, 0xa(%rdx)
               	movw	%cx, 0xc(%rdx)
               	movw	%cx, 0xe(%rdx)
               	movl	$0x10, %ecx
               	leaq	-0x398(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	leaq	-0x398(%rbp), %rax
               	movw	%cx, 0x8(%rax)
               	movw	%cx, 0xa(%rax)
               	movw	%cx, 0xc(%rax)
               	movw	%cx, 0xe(%rax)
               	leaq	-0x388(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rax), %xmm14
               	pmulhw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x780(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x718(%rbp), %rax
               	movl	(%rax), %eax
               	cmpl	$0x10001, %eax          # imm = 0x10001
               	je	<addr>
               	movl	$0x31, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x7c0(%rbp), %rcx
               	movl	$0x1, %eax
               	movl	$0x2, %edx
               	movl	$0x3, %esi
               	movl	$0x4, %edi
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	leaq	-0x738(%rbp), %rbx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rbx)
               	leaq	-0x738(%rbp), %rbx
               	movw	%ax, (%rbx)
               	leaq	-0x738(%rbp), %rax
               	movw	%dx, 0x2(%rax)
               	movw	%si, 0x4(%rax)
               	leaq	-0x738(%rbp), %rax
               	movw	%di, 0x6(%rax)
               	movw	%r8w, 0x8(%rax)
               	movw	%r9w, 0xa(%rax)
               	movl	$0x7, %edx
               	movw	%dx, 0xc(%rax)
               	movl	$0x8, %edx
               	leaq	-0x738(%rbp), %rax
               	movw	%dx, 0xe(%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x718(%rbp), %rdx
               	leaq	-0x7c0(%rbp), %rsi
               	movabsq	$-0x2, %rcx
               	leaq	-0x378(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	leaq	-0x378(%rbp), %rax
               	movw	%cx, 0x8(%rax)
               	movw	%cx, 0xa(%rax)
               	movw	%cx, 0xc(%rax)
               	movw	%cx, 0xe(%rax)
               	leaq	-0x368(%rbp), %rcx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rax), %xmm14
               	pmaddwd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x780(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x718(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	$0xfffffffa, %r11d      # imm = 0xFFFFFFFA
               	cmpl	%r11d, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	movl	$0xffffffe2, %r11d      # imm = 0xFFFFFFE2
               	cmpl	%r11d, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x32, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x728(%rbp), %rsi
               	movl	$0x12c, %ecx            # imm = 0x12C
               	leaq	-0x358(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	movw	%cx, 0x8(%rax)
               	leaq	-0x358(%rbp), %rdx
               	movw	%cx, 0xa(%rdx)
               	movw	%cx, 0xc(%rdx)
               	movw	%cx, 0xe(%rdx)
               	movabsq	$-0x12c, %rcx           # imm = 0xFED4
               	leaq	-0x348(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	leaq	-0x348(%rbp), %rax
               	movw	%cx, 0x8(%rax)
               	movw	%cx, 0xa(%rax)
               	movw	%cx, 0xc(%rax)
               	movw	%cx, 0xe(%rax)
               	leaq	-0x338(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rax), %xmm14
               	packsswb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x780(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x728(%rbp), %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0x7f, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0x7(%rcx), %rax
               	xorq	$0x7f, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0x8(%rcx), %rax
               	xorq	$0x80, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0xf(%rcx), %rax
               	xorq	$0x80, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x33, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x12c, %edx            # imm = 0x12C
               	leaq	-0x328(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	%dx, (%rax)
               	movw	%dx, 0x2(%rax)
               	movw	%dx, 0x4(%rax)
               	movw	%dx, 0x6(%rax)
               	movw	%dx, 0x8(%rax)
               	leaq	-0x328(%rbp), %rsi
               	movw	%dx, 0xa(%rsi)
               	movw	%dx, 0xc(%rsi)
               	movw	%dx, 0xe(%rsi)
               	movabsq	$-0x5, %rdx
               	leaq	-0x318(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	%dx, (%rax)
               	movw	%dx, 0x2(%rax)
               	movw	%dx, 0x4(%rax)
               	movw	%dx, 0x6(%rax)
               	leaq	-0x318(%rbp), %rax
               	movw	%dx, 0x8(%rax)
               	movw	%dx, 0xa(%rax)
               	movw	%dx, 0xc(%rax)
               	movw	%dx, 0xe(%rax)
               	leaq	-0x308(%rbp), %rdx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rax), %xmm14
               	packuswb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x780(%rbp), %rax
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x728(%rbp), %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0xff, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0x7(%rcx), %rax
               	xorq	$0xff, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0x8(%rcx), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0xf(%rcx), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x34, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x11170, %edx          # imm = 0x11170
               	leaq	-0x2f8(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	%edx, (%rax)
               	movl	%edx, 0x4(%rax)
               	movl	%edx, 0x8(%rax)
               	movl	%edx, 0xc(%rax)
               	movabsq	$-0x11170, %rsi         # imm = 0xFFFEEE90
               	leaq	-0x2e8(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movl	%esi, (%rdx)
               	movl	%esi, 0x4(%rdx)
               	movl	%esi, 0x8(%rdx)
               	movl	%esi, 0xc(%rdx)
               	leaq	-0x2e8(%rbp), %rsi
               	leaq	-0x2d8(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rsi), %xmm14
               	packssdw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x780(%rbp), %rax
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x728(%rbp), %rax
               	movzbq	(%rax), %rcx
               	xorq	$0xff, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x1(%rax), %rcx
               	xorq	$0x7f, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x8(%rax), %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x9(%rax), %rax
               	xorq	$0x80, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x35, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x7c0(%rbp), %rcx
               	xorq	%rax, %rax
               	movl	$0x1, %edx
               	movl	$0x2, %esi
               	movl	$0x3, %edi
               	movl	$0x4, %r8d
               	movl	$0x5, %r9d
               	leaq	-0x738(%rbp), %rbx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rbx)
               	leaq	-0x738(%rbp), %rbx
               	movb	%al, (%rbx)
               	leaq	-0x738(%rbp), %rax
               	movb	%dl, 0x1(%rax)
               	movb	%sil, 0x2(%rax)
               	leaq	-0x738(%rbp), %rax
               	movb	%dil, 0x3(%rax)
               	movb	%r8b, 0x4(%rax)
               	movb	%r9b, 0x5(%rax)
               	movl	$0x6, %edx
               	movb	%dl, 0x6(%rax)
               	movl	$0x7, %edx
               	leaq	-0x738(%rbp), %rax
               	movb	%dl, 0x7(%rax)
               	movl	$0x8, %edx
               	movb	%dl, 0x8(%rax)
               	movl	$0x9, %edx
               	movb	%dl, 0x9(%rax)
               	movl	$0xa, %edx
               	movb	%dl, 0xa(%rax)
               	movl	$0xb, %edx
               	movb	%dl, 0xb(%rax)
               	movl	$0xc, %edx
               	movb	%dl, 0xc(%rax)
               	movl	$0xd, %edx
               	leaq	-0x738(%rbp), %rax
               	movb	%dl, 0xd(%rax)
               	movl	$0xe, %edx
               	movb	%dl, 0xe(%rax)
               	movl	$0xf, %edx
               	movb	%dl, 0xf(%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x728(%rbp), %rax
               	leaq	-0x7c0(%rbp), %rsi
               	leaq	-0x2c8(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x2b8(%rbp), %rdx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rcx), %xmm14
               	punpcklbw	%xmm14, %xmm15  # xmm15 = xmm15[0],xmm14[0],xmm15[1],xmm14[1],xmm15[2],xmm14[2],xmm15[3],xmm14[3],xmm15[4],xmm14[4],xmm15[5],xmm14[5],xmm15[6],xmm14[6],xmm15[7],xmm14[7]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x780(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movzbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x1(%rax), %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x2(%rax), %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x728(%rbp), %rax
               	movzbq	0xe(%rax), %rdx
               	xorq	$0x7, %rdx
               	movl	%edx, %edx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0xf(%rax), %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x36, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x7c0(%rbp), %rdi
               	leaq	-0x2a8(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x298(%rbp), %rsi
               	movdqu	(%rdi), %xmm15
               	movdqu	(%rdx), %xmm14
               	punpckhbw	%xmm14, %xmm15  # xmm15 = xmm15[8],xmm14[8],xmm15[9],xmm14[9],xmm15[10],xmm14[10],xmm15[11],xmm14[11],xmm15[12],xmm14[12],xmm15[13],xmm14[13],xmm15[14],xmm14[14],xmm15[15],xmm14[15]
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x780(%rbp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movzbq	(%rax), %rcx
               	xorq	$0x8, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x1(%rax), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x728(%rbp), %rax
               	movzbq	0xe(%rax), %rcx
               	xorq	$0xf, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xf(%rax), %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x37, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x7c0(%rbp), %rsi
               	leaq	-0x288(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x278(%rbp), %rdx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rcx), %xmm14
               	punpcklwd	%xmm14, %xmm15  # xmm15 = xmm15[0],xmm14[0],xmm15[1],xmm14[1],xmm15[2],xmm14[2],xmm15[3],xmm14[3]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x780(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movzbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x1(%rax), %rdx
               	xorq	$0x1, %rdx
               	movl	%edx, %edx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x2(%rax), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x728(%rbp), %rax
               	movzbq	0x3(%rax), %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x4(%rax), %rdx
               	xorq	$0x2, %rdx
               	movl	%edx, %edx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x38, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x7c0(%rbp), %rdi
               	leaq	-0x268(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x258(%rbp), %rsi
               	movdqu	(%rdi), %xmm15
               	movdqu	(%rdx), %xmm14
               	punpckhwd	%xmm14, %xmm15  # xmm15 = xmm15[4],xmm14[4],xmm15[5],xmm14[5],xmm15[6],xmm14[6],xmm15[7],xmm14[7]
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x780(%rbp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movzbq	(%rax), %rcx
               	xorq	$0x8, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x1(%rax), %rax
               	xorq	$0x9, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x728(%rbp), %rax
               	movzbq	0x2(%rax), %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x4(%rax), %rax
               	xorq	$0xa, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x39, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x7c0(%rbp), %rcx
               	movl	$0x1, %edx
               	movl	$0x2, %esi
               	movl	$0x3, %edi
               	movl	$0x4, %r8d
               	leaq	-0x738(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	%edx, (%rax)
               	movl	%esi, 0x4(%rax)
               	leaq	-0x738(%rbp), %rax
               	movl	%edi, 0x8(%rax)
               	movl	%r8d, 0xc(%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x7b0(%rbp), %rcx
               	movl	$0x5, %edx
               	movl	$0x6, %esi
               	movl	$0x7, %edi
               	movl	$0x8, %r8d
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	%edx, (%rax)
               	leaq	-0x738(%rbp), %rax
               	movl	%esi, 0x4(%rax)
               	movl	%edi, 0x8(%rax)
               	movl	%r8d, 0xc(%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x718(%rbp), %rax
               	leaq	-0x7c0(%rbp), %rcx
               	leaq	-0x7b0(%rbp), %rsi
               	leaq	-0x248(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	punpckldq	%xmm14, %xmm15  # xmm15 = xmm15[0],xmm14[0],xmm15[1],xmm14[1]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x780(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	(%rax), %edx
               	xorq	$0x1, %rdx
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	0x4(%rax), %edx
               	xorq	$0x5, %rdx
               	movl	%edx, %edx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	0x8(%rax), %eax
               	xorq	$0x2, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x718(%rbp), %rax
               	movl	0xc(%rax), %edx
               	xorq	$0x6, %rdx
               	movl	%edx, %edx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x3a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x7c0(%rbp), %rsi
               	leaq	-0x7b0(%rbp), %rdi
               	leaq	-0x238(%rbp), %rdx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rdi), %xmm14
               	punpckhdq	%xmm14, %xmm15  # xmm15 = xmm15[2],xmm14[2],xmm15[3],xmm14[3]
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x780(%rbp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	(%rax), %ecx
               	xorq	$0x3, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0x4(%rax), %eax
               	xorq	$0x7, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x718(%rbp), %rax
               	movl	0x8(%rax), %ecx
               	xorq	$0x4, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0xc(%rax), %ecx
               	xorq	$0x8, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3b, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x7c0(%rbp), %rdx
               	leaq	-0x7b0(%rbp), %rsi
               	leaq	-0x228(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rsi), %xmm14
               	punpckhqdq	%xmm14, %xmm15  # xmm15 = xmm15[1],xmm14[1]
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x780(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	(%rax), %ecx
               	xorq	$0x3, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	xorq	$0x4, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0x8(%rax), %eax
               	xorq	$0x7, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x718(%rbp), %rdx
               	movl	0xc(%rdx), %eax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3c, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movabsq	$-0x10, %rcx
               	leaq	-0x218(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	movw	%cx, 0x8(%rax)
               	leaq	-0x218(%rbp), %rax
               	movw	%cx, 0xa(%rax)
               	movw	%cx, 0xc(%rax)
               	movw	%cx, 0xe(%rax)
               	leaq	-0x208(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	psraw	$0x2, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x780(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x718(%rbp), %rdx
               	movl	(%rdx), %eax
               	movl	$0xfffcfffc, %r11d      # imm = 0xFFFCFFFC
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x3d, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movabsq	$-0x10, %rcx
               	leaq	-0x1f8(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	movw	%cx, 0x8(%rax)
               	leaq	-0x1f8(%rbp), %rax
               	movw	%cx, 0xa(%rax)
               	movw	%cx, 0xc(%rax)
               	movw	%cx, 0xe(%rax)
               	leaq	-0x1e8(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	psraw	$0x20, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x780(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x718(%rbp), %rdx
               	movl	(%rdx), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x3e, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movabsq	$-0x10, %rcx
               	leaq	-0x1d8(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	%ecx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	%ecx, 0x8(%rax)
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x1c8(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	psrad	$0x2, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x780(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x718(%rbp), %rdx
               	movl	(%rdx), %eax
               	movl	$0xfffffffc, %r11d      # imm = 0xFFFFFFFC
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x3f, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x3, %esi
               	movabsq	$-0x40, %rcx
               	leaq	-0x1b8(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	%ecx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	%ecx, 0x8(%rax)
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x1b8(%rbp), %rcx
               	leaq	-0x1a8(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movq	%rsi, %xmm14
               	psrad	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x780(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x718(%rbp), %rax
               	movl	(%rax), %eax
               	movl	$0xfffffff8, %r11d      # imm = 0xFFFFFFF8
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x40, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x7c0(%rbp), %rcx
               	xorq	%rax, %rax
               	movl	$0x1, %edx
               	movl	$0x2, %esi
               	movl	$0x3, %edi
               	movl	$0x4, %r8d
               	movl	$0x5, %r9d
               	leaq	-0x738(%rbp), %rbx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rbx)
               	leaq	-0x738(%rbp), %rbx
               	movb	%al, (%rbx)
               	leaq	-0x738(%rbp), %rax
               	movb	%dl, 0x1(%rax)
               	movb	%sil, 0x2(%rax)
               	leaq	-0x738(%rbp), %rax
               	movb	%dil, 0x3(%rax)
               	movb	%r8b, 0x4(%rax)
               	movb	%r9b, 0x5(%rax)
               	movl	$0x6, %edx
               	movb	%dl, 0x6(%rax)
               	movl	$0x7, %edx
               	leaq	-0x738(%rbp), %rax
               	movb	%dl, 0x7(%rax)
               	movl	$0x8, %edx
               	movb	%dl, 0x8(%rax)
               	movl	$0x9, %edx
               	movb	%dl, 0x9(%rax)
               	movl	$0xa, %edx
               	movb	%dl, 0xa(%rax)
               	movl	$0xb, %edx
               	movb	%dl, 0xb(%rax)
               	movl	$0xc, %edx
               	movb	%dl, 0xc(%rax)
               	movl	$0xd, %edx
               	leaq	-0x738(%rbp), %rax
               	movb	%dl, 0xd(%rax)
               	movl	$0xe, %edx
               	movb	%dl, 0xe(%rax)
               	movl	$0xf, %edx
               	movb	%dl, 0xf(%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x728(%rbp), %rax
               	leaq	-0x7c0(%rbp), %rdx
               	leaq	-0x198(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	psrldq	$0x3, %xmm15            # xmm15 = xmm15[3,4,5,6,7,8,9,10,11,12,13,14,15],zero,zero,zero
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x780(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movzbq	(%rax), %rcx
               	xorq	$0x3, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xc(%rax), %rcx
               	xorq	$0xf, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xd(%rax), %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x41, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x728(%rbp), %rax
               	leaq	-0x7c0(%rbp), %rdx
               	movl	$0xbeef, %esi           # imm = 0xBEEF
               	leaq	-0x188(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	pinsrw	$0x2, %esi, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x780(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movzbq	0x4(%rax), %rcx
               	xorq	$0xef, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x5(%rax), %rcx
               	xorq	$0xbe, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x6(%rax), %rax
               	xorq	$0x6, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x42, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movabsq	$-0x80, %rax
               	leaq	-0x178(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movb	%al, (%rcx)
               	movb	%al, 0x1(%rcx)
               	movb	%al, 0x2(%rcx)
               	movb	%al, 0x3(%rcx)
               	movb	%al, 0x4(%rcx)
               	movb	%al, 0x5(%rcx)
               	leaq	-0x178(%rbp), %rcx
               	movb	%al, 0x6(%rcx)
               	movb	%al, 0x7(%rcx)
               	movb	%al, 0x8(%rcx)
               	movb	%al, 0x9(%rcx)
               	movb	%al, 0xa(%rcx)
               	movb	%al, 0xb(%rcx)
               	movb	%al, 0xc(%rcx)
               	leaq	-0x178(%rbp), %rcx
               	movb	%al, 0xd(%rcx)
               	movb	%al, 0xe(%rcx)
               	movb	%al, 0xf(%rcx)
               	leaq	-0x18(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	pmovmskb	%xmm14, %r11d
               	movl	%r11d, (%rax)
               	movslq	(%rax), %rcx
               	cmpl	$0xffff, %ecx           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x43, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x168(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm14
               	pmovmskb	%xmm14, %r11d
               	movl	%r11d, (%rax)
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x44, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movabsq	$-0x80, %rdx
               	xorq	%rcx, %rcx
               	leaq	-0x158(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movb	%dl, (%rax)
               	leaq	-0x158(%rbp), %rax
               	movb	%cl, 0x1(%rax)
               	movb	%cl, 0x2(%rax)
               	movb	%cl, 0x3(%rax)
               	leaq	-0x158(%rbp), %rax
               	movb	%cl, 0x4(%rax)
               	movb	%cl, 0x5(%rax)
               	xorq	%rcx, %rcx
               	movb	%cl, 0x6(%rax)
               	movb	%cl, 0x7(%rax)
               	movb	%cl, 0x8(%rax)
               	leaq	-0x158(%rbp), %rax
               	movb	%cl, 0x9(%rax)
               	xorq	%rcx, %rcx
               	movb	%cl, 0xa(%rax)
               	movb	%cl, 0xb(%rax)
               	movb	%cl, 0xc(%rax)
               	leaq	-0x158(%rbp), %rax
               	movb	%cl, 0xd(%rax)
               	xorq	%rcx, %rcx
               	movb	%cl, 0xe(%rax)
               	movabsq	$-0x80, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0x18(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pmovmskb	%xmm14, %r11d
               	movl	%r11d, (%rcx)
               	movslq	(%rcx), %rax
               	cmpl	$0x8001, %eax           # imm = 0x8001
               	je	<addr>
               	movl	$0x45, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x718(%rbp), %rdi
               	movl	$0xf, %eax
               	leaq	-0x148(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movb	%al, (%rcx)
               	movb	%al, 0x1(%rcx)
               	movb	%al, 0x2(%rcx)
               	movb	%al, 0x3(%rcx)
               	movb	%al, 0x4(%rcx)
               	leaq	-0x148(%rbp), %rcx
               	movb	%al, 0x5(%rcx)
               	movb	%al, 0x6(%rcx)
               	movb	%al, 0x7(%rcx)
               	movb	%al, 0x8(%rcx)
               	movb	%al, 0x9(%rcx)
               	movb	%al, 0xa(%rcx)
               	leaq	-0x148(%rbp), %rcx
               	movb	%al, 0xb(%rcx)
               	movb	%al, 0xc(%rcx)
               	movb	%al, 0xd(%rcx)
               	movb	%al, 0xe(%rcx)
               	movb	%al, 0xf(%rcx)
               	movl	$0x33, %eax
               	leaq	-0x138(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movb	%al, (%rdx)
               	movb	%al, 0x1(%rdx)
               	movb	%al, 0x2(%rdx)
               	movb	%al, 0x3(%rdx)
               	leaq	-0x138(%rbp), %rdx
               	movb	%al, 0x4(%rdx)
               	movb	%al, 0x5(%rdx)
               	movb	%al, 0x6(%rdx)
               	movb	%al, 0x7(%rdx)
               	movb	%al, 0x8(%rdx)
               	leaq	-0x138(%rbp), %rdx
               	movb	%al, 0x9(%rdx)
               	movb	%al, 0xa(%rdx)
               	movb	%al, 0xb(%rdx)
               	movb	%al, 0xc(%rdx)
               	movb	%al, 0xd(%rdx)
               	leaq	-0x138(%rbp), %rdx
               	movb	%al, 0xe(%rdx)
               	movb	%al, 0xf(%rdx)
               	leaq	-0x128(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pandn	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x780(%rbp), %rax
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdi)
               	leaq	-0x718(%rbp), %rcx
               	movl	(%rcx), %edx
               	cmpl	$0x30303030, %edx       # imm = 0x30303030
               	je	<addr>
               	movl	$0x46, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x7c0(%rbp), %rdx
               	leaq	-0x118(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pcmpeqb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	movl	(%rcx), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	jne	<addr>
               	leaq	-0x718(%rbp), %rsi
               	movl	0xc(%rsi), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x47, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x7, %ecx
               	leaq	-0x108(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	movw	%cx, 0x8(%rax)
               	leaq	-0x108(%rbp), %rdx
               	movw	%cx, 0xa(%rdx)
               	movw	%cx, 0xc(%rdx)
               	movw	%cx, 0xe(%rdx)
               	movl	$0x8, %ecx
               	leaq	-0xf8(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	leaq	-0xf8(%rbp), %rax
               	movw	%cx, 0x8(%rax)
               	movw	%cx, 0xa(%rax)
               	movw	%cx, 0xc(%rax)
               	movw	%cx, 0xe(%rax)
               	leaq	-0xe8(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rax), %xmm14
               	pcmpeqw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x780(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x718(%rbp), %rsi
               	movl	(%rsi), %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x48, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x7, %ecx
               	leaq	-0xd8(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	%ecx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	%ecx, 0x8(%rax)
               	movl	%ecx, 0xc(%rax)
               	movl	$0x7, %edx
               	leaq	-0xc8(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	%edx, (%rcx)
               	movl	%edx, 0x4(%rcx)
               	movl	%edx, 0x8(%rcx)
               	movl	%edx, 0xc(%rcx)
               	leaq	-0xc8(%rbp), %rdx
               	leaq	-0xb8(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pcmpeqd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x780(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x718(%rbp), %rsi
               	movl	(%rsi), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x49, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movabsq	$-0x1, %rcx
               	leaq	-0xa8(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	movw	%cx, 0x8(%rax)
               	leaq	-0xa8(%rbp), %rdx
               	movw	%cx, 0xa(%rdx)
               	movw	%cx, 0xc(%rdx)
               	movw	%cx, 0xe(%rdx)
               	movabsq	$-0x2, %rcx
               	leaq	-0x98(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	%cx, (%rax)
               	movw	%cx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	leaq	-0x98(%rbp), %rax
               	movw	%cx, 0x8(%rax)
               	movw	%cx, 0xa(%rax)
               	movw	%cx, 0xc(%rax)
               	movw	%cx, 0xe(%rax)
               	leaq	-0x88(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rax), %xmm14
               	pcmpgtw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x780(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x718(%rbp), %rsi
               	movl	(%rsi), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x4a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movabsq	$-0x2, %rcx
               	leaq	-0x78(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	%ecx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	%ecx, 0x8(%rax)
               	movl	%ecx, 0xc(%rax)
               	movabsq	$-0x1, %rdx
               	leaq	-0x68(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	%edx, (%rcx)
               	movl	%edx, 0x4(%rcx)
               	movl	%edx, 0x8(%rcx)
               	movl	%edx, 0xc(%rcx)
               	leaq	-0x68(%rbp), %rdx
               	leaq	-0x58(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rax), %xmm14
               	pcmpgtd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x780(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x718(%rbp), %rax
               	movl	(%rax), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x4b, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x728(%rbp), %rax
               	leaq	(%rax), %rcx
               	movl	$0x1, %edx
               	movb	%dl, (%rcx)
               	movl	$0x2, %ecx
               	movb	%cl, 0x1(%rax)
               	movl	$0x3, %ecx
               	movb	%cl, 0x2(%rax)
               	movl	$0x4, %ecx
               	movb	%cl, 0x3(%rax)
               	movl	$0x5, %ecx
               	movb	%cl, 0x4(%rax)
               	movl	$0x6, %ecx
               	movb	%cl, 0x5(%rax)
               	movl	$0x7, %ecx
               	movb	%cl, 0x6(%rax)
               	leaq	-0x728(%rbp), %rax
               	movl	$0x8, %ecx
               	movb	%cl, 0x7(%rax)
               	movl	$0x9, %ecx
               	movb	%cl, 0x8(%rax)
               	movl	$0xa, %ecx
               	movb	%cl, 0x9(%rax)
               	movl	$0xb, %ecx
               	movb	%cl, 0xa(%rax)
               	movl	$0xc, %ecx
               	movb	%cl, 0xb(%rax)
               	movl	$0xd, %ecx
               	movb	%cl, 0xc(%rax)
               	movl	$0xe, %ecx
               	movb	%cl, 0xd(%rax)
               	leaq	-0x728(%rbp), %rax
               	movl	$0xf, %ecx
               	movb	%cl, 0xe(%rax)
               	movl	$0x10, %ecx
               	movb	%cl, 0xf(%rax)
               	leaq	-0x718(%rbp), %rdx
               	leaq	-0x738(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	xorq	%rax, %rax
               	movq	%rax, 0x8(%rcx)
               	leaq	-0x780(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movl	(%rdx), %eax
               	cmpl	$0x4030201, %eax        # imm = 0x4030201
               	jne	<addr>
               	movl	0x4(%rdx), %eax
               	cmpl	$0x8070605, %eax        # imm = 0x8070605
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x718(%rbp), %rax
               	movl	0x8(%rax), %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4c, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x728(%rbp), %rcx
               	movabsq	$-0x1111111111111112, %rax # imm = 0xEEEEEEEEEEEEEEEE
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	movl	$0x1, %edx
               	movl	$0x2, %esi
               	movl	$0x3, %edi
               	movl	$0x4, %r8d
               	leaq	-0x738(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	%edx, (%rax)
               	movl	%esi, 0x4(%rax)
               	leaq	-0x738(%rbp), %rax
               	movl	%edi, 0x8(%rax)
               	movl	%r8d, 0xc(%rax)
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	leaq	-0x728(%rbp), %rax
               	movzbq	(%rax), %rcx
               	xorq	$0x1, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x4(%rax), %rcx
               	xorq	$0x2, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x8(%rax), %rcx
               	xorq	$0xee, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4d, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rcx
               	leaq	-0x7c0(%rbp), %rsi
               	leaq	-0x750(%rbp), %rdx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x48(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x780(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	(%rax), %rcx
               	movzbq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4e, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movzbq	0x1(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movzbq	0x2(%rax), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	-0x728(%rbp), %rax
               	movzbq	0x3(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movzbq	0x4(%rax), %rcx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movzbq	0x5(%rax), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movzbq	0x6(%rax), %rcx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movzbq	0x7(%rax), %rcx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movzbq	0x8(%rax), %rcx
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	movzbq	0x9(%rax), %rcx
               	cmpl	$0x9, %ecx
               	jne	<addr>
               	movzbq	0xa(%rax), %rax
               	cmpl	$0xa, %eax
               	jne	<addr>
               	leaq	-0x728(%rbp), %rax
               	movzbq	0xb(%rax), %rcx
               	cmpl	$0xb, %ecx
               	jne	<addr>
               	movzbq	0xc(%rax), %rcx
               	cmpl	$0xc, %ecx
               	jne	<addr>
               	movzbq	0xd(%rax), %rcx
               	cmpl	$0xd, %ecx
               	jne	<addr>
               	movzbq	0xe(%rax), %rcx
               	cmpl	$0xe, %ecx
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	cmpl	$0xf, %eax
               	jne	<addr>
               	leaq	-0x718(%rbp), %rsi
               	movabsq	$-0x1, %rax
               	leaq	-0x738(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	%eax, (%rcx)
               	xorq	%rax, %rax
               	movl	%eax, 0x4(%rcx)
               	movl	%eax, 0x8(%rcx)
               	movl	%eax, 0xc(%rcx)
               	leaq	-0x780(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x718(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %edx
               	jne	<addr>
               	movl	0x4(%rcx), %edx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	0xc(%rcx), %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x50, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	jmp	<addr>
               	leaq	-0x6c8(%rbp), %rdx
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	0x1(%rcx), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	-0x790(%rbp), %rdx
               	leaq	-0x6c8(%rbp), %rax
               	leaq	0x3(%rax), %rcx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	-0x728(%rbp), %rcx
               	leaq	-0x780(%rbp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movdqu	(%rsi), %xmm15
               	movdqu	%xmm15, (%rcx)
               	movzbq	(%rcx), %rdx
               	xorq	$0x4, %rdx
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0xf(%rcx), %rcx
               	xorq	$0x13, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x51, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	0x5(%rax), %rdx
               	leaq	-0x738(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movzbq	0x4(%rax), %rax
               	xorq	$0x5, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x6c8(%rbp), %rax
               	movzbq	0x5(%rax), %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x14(%rax), %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x15(%rax), %rax
               	xorq	$0x16, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x52, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x53, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x1f, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
