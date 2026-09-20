
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
               	movups	%xmm0, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<_mm_castsi128_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movups	%xmm0, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<same>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movups	%xmm0, -0x50(%rbp)
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
               	movzbq	(%rax), %rcx
               	movzbq	(%rdi), %rdx
               	cmpl	%edx, %ecx
               	je	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movzbq	0x1(%rax), %rcx
               	movzbq	0x1(%rdi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x2(%rax), %rax
               	movzbq	0x2(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movzbq	0x3(%rax), %rcx
               	movzbq	0x3(%rdi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x4(%rax), %rcx
               	movzbq	0x4(%rdi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x5(%rax), %rcx
               	movzbq	0x5(%rdi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x6(%rax), %rcx
               	movzbq	0x6(%rdi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x7(%rax), %rcx
               	movzbq	0x7(%rdi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x8(%rax), %rax
               	movzbq	0x8(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movzbq	0x9(%rax), %rcx
               	movzbq	0x9(%rdi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0xa(%rax), %rcx
               	movzbq	0xa(%rdi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0xb(%rax), %rcx
               	movzbq	0xb(%rdi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0xc(%rax), %rcx
               	movzbq	0xc(%rdi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0xd(%rax), %rcx
               	movzbq	0xd(%rdi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0xe(%rax), %rax
               	movzbq	0xe(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movzbq	0xf(%rax), %rax
               	movzbq	0xf(%rdi), %rcx
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
               	movups	(%rcx), %xmm0
               	leave
               	retq

<aes128_known_answer>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x3c0, %rsp            # imm = 0x3C0
               	leaq	-0x3c0(%rbp), %rax
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
               	leaq	-0x1f0(%rbp), %rdx
               	movdqu	(%rax), %xmm14
               	aeskeygenassist	$0x1, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x300(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x2f0(%rbp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	leaq	-0x80(%rbp), %rdx
               	movdqu	(%rsi), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x2e0(%rbp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	leaq	-0x70(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x2d0(%rbp), %rdx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	-0x60(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x50(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	-0x300(%rbp), %rdx
               	leaq	-0x2d0(%rbp), %rcx
               	leaq	-0x40(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	-0x30(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x300(%rbp), %rcx
               	leaq	-0x2d0(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x2e0(%rbp), %rdx
               	leaq	-0x10(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rsi), %xmm0
               	movups	%xmm0, 0x10(%rax)
               	leaq	-0x3c0(%rbp), %rsi
               	leaq	0x10(%rsi), %rax
               	leaq	-0x1e0(%rbp), %rdi
               	movdqu	(%rax), %xmm14
               	aeskeygenassist	$0x2, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x2f0(%rbp), %rax
               	pushq	%rcx
               	movq	(%rdi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x80(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	-0x300(%rbp), %rcx
               	leaq	-0x70(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x2d0(%rbp), %rax
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
               	leaq	-0x300(%rbp), %rcx
               	leaq	-0x2d0(%rbp), %rax
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
               	leaq	-0x300(%rbp), %rax
               	leaq	-0x2d0(%rbp), %rdx
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
               	leaq	-0x2e0(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm0
               	movups	%xmm0, 0x20(%rsi)
               	leaq	-0x3c0(%rbp), %rdx
               	leaq	0x20(%rdx), %rsi
               	leaq	-0x1d0(%rbp), %rdi
               	movdqu	(%rsi), %xmm14
               	aeskeygenassist	$0x4, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x2f0(%rbp), %rax
               	pushq	%rcx
               	movq	(%rdi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x80(%rbp), %rsi
               	movdqu	(%rax), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x300(%rbp), %rcx
               	leaq	-0x70(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x2d0(%rbp), %rax
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x60(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
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
               	leaq	-0x300(%rbp), %rcx
               	leaq	-0x2d0(%rbp), %rax
               	leaq	-0x40(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
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
               	leaq	-0x300(%rbp), %rax
               	leaq	-0x2d0(%rbp), %rsi
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
               	leaq	-0x2e0(%rbp), %rcx
               	leaq	-0x10(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rsi), %xmm0
               	movups	%xmm0, 0x30(%rdx)
               	leaq	-0x3c0(%rbp), %rdx
               	leaq	0x30(%rdx), %rsi
               	leaq	-0x1c0(%rbp), %rdi
               	movdqu	(%rsi), %xmm14
               	aeskeygenassist	$0x8, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x2f0(%rbp), %rax
               	pushq	%rcx
               	movq	(%rdi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x80(%rbp), %rsi
               	movdqu	(%rax), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x300(%rbp), %rcx
               	leaq	-0x70(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x2d0(%rbp), %rax
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x60(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
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
               	leaq	-0x300(%rbp), %rcx
               	leaq	-0x2d0(%rbp), %rax
               	leaq	-0x40(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
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
               	leaq	-0x300(%rbp), %rax
               	leaq	-0x2d0(%rbp), %rsi
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
               	leaq	-0x2e0(%rbp), %rcx
               	leaq	-0x10(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rsi), %xmm0
               	movups	%xmm0, 0x40(%rdx)
               	leaq	-0x3c0(%rbp), %rdx
               	leaq	0x40(%rdx), %rsi
               	leaq	-0x1b0(%rbp), %rdi
               	movdqu	(%rsi), %xmm14
               	aeskeygenassist	$0x10, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x2f0(%rbp), %rax
               	pushq	%rcx
               	movq	(%rdi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x80(%rbp), %rsi
               	movdqu	(%rax), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x300(%rbp), %rcx
               	leaq	-0x70(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x2d0(%rbp), %rax
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x60(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
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
               	leaq	-0x300(%rbp), %rcx
               	leaq	-0x2d0(%rbp), %rax
               	leaq	-0x40(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
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
               	leaq	-0x300(%rbp), %rax
               	leaq	-0x2d0(%rbp), %rsi
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
               	leaq	-0x2e0(%rbp), %rcx
               	leaq	-0x10(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rsi), %xmm0
               	movups	%xmm0, 0x50(%rdx)
               	leaq	-0x3c0(%rbp), %rdx
               	leaq	0x50(%rdx), %rsi
               	leaq	-0x1a0(%rbp), %rdi
               	movdqu	(%rsi), %xmm14
               	aeskeygenassist	$0x20, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x2f0(%rbp), %rax
               	pushq	%rcx
               	movq	(%rdi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x80(%rbp), %rsi
               	movdqu	(%rax), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x300(%rbp), %rcx
               	leaq	-0x70(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x2d0(%rbp), %rax
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x60(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
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
               	leaq	-0x300(%rbp), %rcx
               	leaq	-0x2d0(%rbp), %rax
               	leaq	-0x40(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
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
               	leaq	-0x300(%rbp), %rax
               	leaq	-0x2d0(%rbp), %rsi
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
               	leaq	-0x2e0(%rbp), %rcx
               	leaq	-0x10(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rsi), %xmm0
               	movups	%xmm0, 0x60(%rdx)
               	leaq	-0x3c0(%rbp), %rdx
               	leaq	0x60(%rdx), %rsi
               	leaq	-0x190(%rbp), %rdi
               	movdqu	(%rsi), %xmm14
               	aeskeygenassist	$0x40, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x2f0(%rbp), %rax
               	pushq	%rcx
               	movq	(%rdi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x80(%rbp), %rsi
               	movdqu	(%rax), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x300(%rbp), %rcx
               	leaq	-0x70(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x2d0(%rbp), %rax
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x60(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
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
               	leaq	-0x300(%rbp), %rcx
               	leaq	-0x2d0(%rbp), %rax
               	leaq	-0x40(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
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
               	leaq	-0x300(%rbp), %rax
               	leaq	-0x2d0(%rbp), %rsi
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
               	leaq	-0x2e0(%rbp), %rcx
               	leaq	-0x10(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rsi), %xmm0
               	movups	%xmm0, 0x70(%rdx)
               	leaq	-0x3c0(%rbp), %rdx
               	leaq	0x70(%rdx), %rsi
               	leaq	-0x180(%rbp), %rdi
               	movdqu	(%rsi), %xmm14
               	aeskeygenassist	$0x80, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x2f0(%rbp), %rax
               	pushq	%rcx
               	movq	(%rdi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x80(%rbp), %rsi
               	movdqu	(%rax), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x300(%rbp), %rcx
               	leaq	-0x70(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x2d0(%rbp), %rax
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x60(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
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
               	leaq	-0x300(%rbp), %rcx
               	leaq	-0x2d0(%rbp), %rax
               	leaq	-0x40(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
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
               	leaq	-0x300(%rbp), %rax
               	leaq	-0x2d0(%rbp), %rsi
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
               	leaq	-0x2e0(%rbp), %rcx
               	leaq	-0x10(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rsi), %xmm0
               	movups	%xmm0, 0x80(%rdx)
               	leaq	-0x3c0(%rbp), %rdx
               	leaq	0x80(%rdx), %rsi
               	leaq	-0x170(%rbp), %rdi
               	movdqu	(%rsi), %xmm14
               	aeskeygenassist	$0x1b, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x2f0(%rbp), %rax
               	pushq	%rcx
               	movq	(%rdi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x80(%rbp), %rsi
               	movdqu	(%rax), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x300(%rbp), %rcx
               	leaq	-0x70(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x2d0(%rbp), %rax
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x60(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
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
               	leaq	-0x300(%rbp), %rcx
               	leaq	-0x2d0(%rbp), %rax
               	leaq	-0x40(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
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
               	leaq	-0x300(%rbp), %rax
               	leaq	-0x2d0(%rbp), %rsi
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
               	leaq	-0x2e0(%rbp), %rcx
               	leaq	-0x10(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rsi), %xmm0
               	movups	%xmm0, 0x90(%rdx)
               	leaq	-0x3c0(%rbp), %rdx
               	leaq	0x90(%rdx), %rsi
               	leaq	-0x160(%rbp), %rdi
               	movdqu	(%rsi), %xmm14
               	aeskeygenassist	$0x36, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x2f0(%rbp), %rax
               	pushq	%rcx
               	movq	(%rdi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x80(%rbp), %rsi
               	movdqu	(%rax), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x300(%rbp), %rcx
               	leaq	-0x70(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x2d0(%rbp), %rax
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x60(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
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
               	leaq	-0x300(%rbp), %rcx
               	leaq	-0x2d0(%rbp), %rax
               	leaq	-0x40(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
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
               	leaq	-0x300(%rbp), %rax
               	leaq	-0x2d0(%rbp), %rsi
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
               	leaq	-0x2e0(%rbp), %rsi
               	leaq	-0x10(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rsi), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm0
               	movups	%xmm0, 0xa0(%rdx)
               	leaq	-0x310(%rbp), %rcx
               	leaq	<rip>, %rdx
               	leaq	-0x150(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x3c0(%rbp), %rdx
               	leaq	-0x140(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movl	$0x1, %eax
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdx, %rsi
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
               	incq	%rax
               	cmpl	$0xa, %eax
               	jl	<addr>
               	leaq	-0x310(%rbp), %r9
               	leaq	-0x3c0(%rbp), %rax
               	leaq	0xa0(%rax), %rcx
               	leaq	-0x120(%rbp), %rax
               	movdqu	(%r9), %xmm15
               	movdqu	(%rcx), %xmm14
               	aesenclast	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r9)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r9)
               	popq	%rcx
               	leaq	<rip>, %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	leaq	-0x310(%rbp), %rcx
               	leaq	<rip>, %rdx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x3c0(%rbp), %rdx
               	leaq	0xa0(%rdx), %rdi
               	leaq	-0x100(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdi), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movl	$0x9, %eax
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdx, %rsi
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
               	decq	%rax
               	testl	%eax, %eax
               	jg	<addr>
               	leaq	-0x310(%rbp), %r9
               	leaq	-0x3c0(%rbp), %rcx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%r9), %xmm15
               	movdqu	(%rcx), %xmm14
               	aesdeclast	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r9)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r9)
               	popq	%rcx
               	leaq	<rip>, %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x7b0, %rsp            # imm = 0x7B0
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x7b0(%rbp), %rax
               	movl	$0x1, (%rax)
               	movl	$0x2, 0x4(%rax)
               	movl	$0x3, 0x8(%rax)
               	movl	$0x4, 0xc(%rax)
               	leaq	-0x7a0(%rbp), %rcx
               	movl	$0x64, (%rcx)
               	movl	$0xc8, 0x4(%rcx)
               	movl	$0x12c, 0x8(%rcx)       # imm = 0x12C
               	movl	$0x190, 0xc(%rcx)       # imm = 0x190
               	leaq	-0x708(%rbp), %rdx
               	leaq	-0x6a0(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	paddd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x770(%rbp), %rcx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movl	(%rdx), %eax
               	xorq	$0x65, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	0x4(%rdx), %eax
               	xorq	$0xca, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	0x8(%rdx), %eax
               	xorq	$0x12f, %rax            # imm = 0x12F
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x708(%rbp), %rax
               	movl	0xc(%rax), %edx
               	xorq	$0x194, %rdx            # imm = 0x194
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x7b0(%rbp), %rsi
               	leaq	-0x7a0(%rbp), %rdi
               	leaq	-0x690(%rbp), %rdx
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
               	leaq	-0x770(%rbp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	(%rax), %edx
               	cmpl	$0x65, %edx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	cmpl	$0x194, %eax            # imm = 0x194
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x708(%rbp), %rax
               	leaq	-0x7b0(%rbp), %rsi
               	leaq	-0x7a0(%rbp), %rdi
               	leaq	-0x680(%rbp), %rdx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rdi), %xmm14
               	por	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	0x4(%rax), %eax
               	cmpl	$0xca, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x708(%rbp), %rdx
               	leaq	-0x7b0(%rbp), %rax
               	leaq	-0x7a0(%rbp), %rcx
               	leaq	-0x670(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pand	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x770(%rbp), %rdi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movdqu	(%rdi), %xmm15
               	movdqu	%xmm15, (%rdx)
               	cmpl	$0x0, 0x8(%rdx)
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0xffffffff, (%rax)     # imm = 0xFFFFFFFF
               	movl	$0x0, 0x4(%rax)
               	movl	$0xffffffff, 0x8(%rax)  # imm = 0xFFFFFFFF
               	movl	$0x0, 0xc(%rax)
               	movl	$0x1, (%rcx)
               	movl	$0x0, 0x4(%rcx)
               	movl	$0x0, 0x8(%rcx)
               	movl	$0x0, 0xc(%rcx)
               	leaq	-0x708(%rbp), %rax
               	leaq	-0x7b0(%rbp), %rcx
               	leaq	-0x7a0(%rbp), %rsi
               	leaq	-0x660(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	paddd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x770(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	cmpl	$0x0, 0x4(%rax)
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x7b0(%rbp), %rdx
               	leaq	-0x7a0(%rbp), %rsi
               	leaq	-0x650(%rbp), %rdi
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
               	leaq	-0x770(%rbp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x708(%rbp), %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	0x4(%rax), %edi
               	xorq	$0x1, %rdi
               	testl	%edi, %edi
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x640(%rbp), %rdi
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rsi), %xmm14
               	paddq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	leaq	-0x7a0(%rbp), %rsi
               	leaq	-0x630(%rbp), %rdx
               	movdqu	(%rdi), %xmm15
               	movdqu	(%rsi), %xmm14
               	psubq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
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
               	leaq	-0x708(%rbp), %rcx
               	cmpl	$0x0, 0x4(%rcx)
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x7b0(%rbp), %rax
               	movl	$0xddeeff00, (%rax)     # imm = 0xDDEEFF00
               	movl	$0x99aabbcc, 0x4(%rax)  # imm = 0x99AABBCC
               	movl	$0x55667788, 0x8(%rax)  # imm = 0x55667788
               	movl	$0x11223344, 0xc(%rax)  # imm = 0x11223344
               	leaq	-0x620(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	pslld	$0x4, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x770(%rbp), %rax
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	movl	0xc(%rcx), %edx
               	cmpl	$0x12233440, %edx       # imm = 0x12233440
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x7b0(%rbp), %rdx
               	leaq	-0x610(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	psrld	$0x4, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x708(%rbp), %rax
               	movl	0xc(%rax), %ecx
               	cmpl	$0x1122334, %ecx        # imm = 0x1122334
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x8, %ecx
               	leaq	-0x600(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	movq	%rcx, %xmm14
               	psrld	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x770(%rbp), %rcx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	0xc(%rax), %edx
               	cmpl	$0x112233, %edx         # imm = 0x112233
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x7b0(%rbp), %rdx
               	leaq	-0x5f0(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	psrld	$0x20, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x708(%rbp), %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	cmpl	$0x0, 0xc(%rax)
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x5e0(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	psllq	$0x8, %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x770(%rbp), %rcx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	(%rax), %edx
               	movl	$0xeeff0000, %r11d      # imm = 0xEEFF0000
               	cmpl	%r11d, %edx
               	jne	<addr>
               	movl	0x4(%rax), %edx
               	movl	$0xaabbccdd, %r11d      # imm = 0xAABBCCDD
               	cmpl	%r11d, %edx
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x7b0(%rbp), %rdx
               	leaq	-0x5d0(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	psrlq	$0x8, %xmm15
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x770(%rbp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x708(%rbp), %rax
               	movl	(%rax), %esi
               	movl	$0xccddeeff, %r11d      # imm = 0xCCDDEEFF
               	cmpl	%r11d, %esi
               	jne	<addr>
               	movl	0x4(%rax), %esi
               	cmpl	$0x99aabb, %esi         # imm = 0x99AABB
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x5c0(%rbp), %rsi
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
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	leaq	-0x708(%rbp), %rax
               	movl	0x4(%rax), %eax
               	movl	$0xddeeff00, %r11d      # imm = 0xDDEEFF00
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x7b0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movb	$0x0, (%rax)
               	movb	$0x1, 0x1(%rax)
               	movb	$0x2, 0x2(%rax)
               	movb	$0x3, 0x3(%rax)
               	movb	$0x4, 0x4(%rax)
               	movb	$0x5, 0x5(%rax)
               	movb	$0x6, 0x6(%rax)
               	movb	$0x7, 0x7(%rax)
               	movb	$0x8, 0x8(%rax)
               	movb	$0x9, 0x9(%rax)
               	movb	$0xa, 0xa(%rax)
               	movb	$0xb, 0xb(%rax)
               	movb	$0xc, 0xc(%rax)
               	movb	$0xd, 0xd(%rax)
               	movb	$0xe, 0xe(%rax)
               	movb	$0xf, 0xf(%rax)
               	leaq	-0x718(%rbp), %rax
               	leaq	-0x7b0(%rbp), %rdx
               	leaq	-0x5b0(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	psllw	$0x8, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x770(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rax)
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	cmpb	$0x0, 0x1(%rax)
               	jne	<addr>
               	cmpb	$0x0, 0x2(%rax)
               	jne	<addr>
               	movzbq	0x3(%rax), %rax
               	xorq	$0x2, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x718(%rbp), %rax
               	leaq	-0x7b0(%rbp), %rdx
               	leaq	-0x5a0(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	psrlw	$0x8, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x770(%rbp), %rdx
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
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpb	$0x0, 0x1(%rax)
               	jne	<addr>
               	movzbq	0x2(%rax), %rcx
               	xorq	$0x3, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x7b0(%rbp), %rdx
               	leaq	-0x590(%rbp), %rsi
               	movdqu	(%rdx), %xmm14
               	pshuflw	$0x1b, %xmm14, %xmm15   # xmm15 = xmm14[3,2,1,0,4,5,6,7]
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x770(%rbp), %rcx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x718(%rbp), %rax
               	movzbq	(%rax), %rsi
               	xorq	$0x6, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	movzbq	0x1(%rax), %rsi
               	xorq	$0x7, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	cmpb	$0x0, 0x6(%rax)
               	jne	<addr>
               	movzbq	0x7(%rax), %rsi
               	xorq	$0x1, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	movzbq	0x8(%rax), %rsi
               	xorq	$0x8, %rsi
               	testl	%esi, %esi
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x580(%rbp), %rsi
               	movdqu	(%rdx), %xmm14
               	pshufhw	$0x1b, %xmm14, %xmm15   # xmm15 = xmm14[0,1,2,3,7,6,5,4]
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x770(%rbp), %rdx
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x718(%rbp), %rax
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movzbq	0x8(%rax), %rcx
               	xorq	$0xe, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x9(%rax), %rcx
               	xorq	$0xf, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0xe(%rax), %rcx
               	xorq	$0x8, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	xorq	$0x9, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x7b0(%rbp), %rax
               	movl	$0x0, (%rax)
               	movl	$0x1, 0x4(%rax)
               	movl	$0x2, 0x8(%rax)
               	movl	$0x3, 0xc(%rax)
               	leaq	-0x708(%rbp), %rcx
               	leaq	-0x570(%rbp), %rsi
               	movdqu	(%rax), %xmm14
               	pshufd	$0x93, %xmm14, %xmm15   # xmm15 = xmm14[3,0,1,2]
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rcx)
               	movl	(%rcx), %eax
               	xorq	$0x3, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, 0x4(%rcx)
               	jne	<addr>
               	movl	0x8(%rcx), %eax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x708(%rbp), %rax
               	movl	0xc(%rax), %eax
               	xorq	$0x2, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x7b0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movb	$0x0, (%rax)
               	movb	$0x1, 0x1(%rax)
               	movb	$0x2, 0x2(%rax)
               	movb	$0x3, 0x3(%rax)
               	movb	$0x4, 0x4(%rax)
               	movb	$0x5, 0x5(%rax)
               	movb	$0x6, 0x6(%rax)
               	movb	$0x7, 0x7(%rax)
               	movb	$0x8, 0x8(%rax)
               	movb	$0x9, 0x9(%rax)
               	movb	$0xa, 0xa(%rax)
               	movb	$0xb, 0xb(%rax)
               	movb	$0xc, 0xc(%rax)
               	movb	$0xd, 0xd(%rax)
               	movb	$0xe, 0xe(%rax)
               	movb	$0xf, 0xf(%rax)
               	leaq	-0x7a0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movb	$0xf, (%rax)
               	movb	$0xe, 0x1(%rax)
               	movb	$0xd, 0x2(%rax)
               	movb	$0xc, 0x3(%rax)
               	movb	$0xb, 0x4(%rax)
               	movb	$0xa, 0x5(%rax)
               	movb	$0x9, 0x6(%rax)
               	movb	$0x8, 0x7(%rax)
               	movb	$0x7, 0x8(%rax)
               	movb	$0x6, 0x9(%rax)
               	movb	$0x5, 0xa(%rax)
               	movb	$0x4, 0xb(%rax)
               	movb	$0x3, 0xc(%rax)
               	movb	$0x2, 0xd(%rax)
               	movb	$0x1, 0xe(%rax)
               	movb	$-0x80, 0xf(%rax)
               	leaq	-0x718(%rbp), %rax
               	leaq	-0x7b0(%rbp), %rdx
               	leaq	-0x7a0(%rbp), %rsi
               	leaq	-0x560(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pshufb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x770(%rbp), %rdx
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
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0xe(%rax), %rcx
               	xorq	$0x1, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpb	$0x0, 0xf(%rax)
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x7b0(%rbp), %rax
               	movl	$0x1, (%rax)
               	movl	$0x1, 0x4(%rax)
               	movl	$0x9, 0x8(%rax)
               	movl	$0x9, 0xc(%rax)
               	leaq	-0x7a0(%rbp), %rcx
               	movl	$0x2, (%rcx)
               	movl	$0x2, 0x4(%rcx)
               	movl	$0x8, 0x8(%rcx)
               	movl	$0x8, 0xc(%rcx)
               	leaq	-0x708(%rbp), %rdx
               	leaq	-0x550(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	punpcklqdq	%xmm14, %xmm15  # xmm15 = xmm15[0],xmm14[0]
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x770(%rbp), %rcx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movl	(%rdx), %eax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	0x4(%rdx), %eax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	0x8(%rdx), %eax
               	xorq	$0x2, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x708(%rbp), %rax
               	movl	0xc(%rax), %edx
               	xorq	$0x2, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x7b0(%rbp), %rdx
               	leaq	-0x540(%rbp), %rsi
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
               	leaq	-0x770(%rbp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	(%rax), %edx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %edx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x708(%rbp), %rax
               	leaq	-0x7b0(%rbp), %rsi
               	leaq	-0x7a0(%rbp), %rdi
               	leaq	-0x530(%rbp), %rdx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rdi), %xmm14
               	pcmpeqq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	leaq	-0x708(%rbp), %rax
               	cmpl	$0x0, 0xc(%rax)
               	je	<addr>
               	movl	$0x17, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x7b0(%rbp), %rax
               	movl	$0x11112222, (%rax)     # imm = 0x11112222
               	movl	$0x33334444, 0x4(%rax)  # imm = 0x33334444
               	movl	$0x55556666, 0x8(%rax)  # imm = 0x55556666
               	movl	$0x77778888, 0xc(%rax)  # imm = 0x77778888
               	leaq	-0x520(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pextrw	$0x0, %xmm14, %r11d
               	movl	%r11d, (%rcx)
               	movslq	(%rcx), %rcx
               	cmpl	$0x2222, %ecx           # imm = 0x2222
               	jne	<addr>
               	leaq	-0x518(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pextrw	$0x7, %xmm14, %r11d
               	movl	%r11d, (%rcx)
               	movslq	(%rcx), %rcx
               	cmpl	$0x7777, %ecx           # imm = 0x7777
               	je	<addr>
               	movl	$0x18, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x510(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pextrd	$0x2, %xmm14, %r11d
               	movl	%r11d, (%rcx)
               	movslq	(%rcx), %rax
               	cmpl	$0x55556666, %eax       # imm = 0x55556666
               	je	<addr>
               	movl	$0x19, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x708(%rbp), %rax
               	leaq	-0x7b0(%rbp), %rcx
               	movl	$0xa0b0c0d, %esi        # imm = 0xA0B0C0D
               	leaq	-0x508(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	pinsrd	$0x1, %esi, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x770(%rbp), %rsi
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
               	movl	(%rax), %edx
               	cmpl	$0x11112222, %edx       # imm = 0x11112222
               	je	<addr>
               	movl	$0x1a, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	$0x3, (%rcx)
               	movq	$0x0, 0x8(%rcx)
               	leaq	-0x7a0(%rbp), %rdx
               	movq	$0x0, (%rdx)
               	movq	$0x3, 0x8(%rdx)
               	leaq	-0x7b0(%rbp), %rsi
               	leaq	-0x4f8(%rbp), %rdi
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rsi), %xmm14
               	pclmulqdq	$0x0, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	leaq	-0x770(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x708(%rbp), %rax
               	movl	(%rax), %edi
               	xorq	$0x5, %rdi
               	testl	%edi, %edi
               	jne	<addr>
               	cmpl	$0x0, 0x4(%rax)
               	je	<addr>
               	movl	$0x1b, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x4e8(%rbp), %rdi
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rdx), %xmm14
               	pclmulqdq	$0x10, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	(%rax), %eax
               	xorq	$0x5, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1c, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x7b0(%rbp), %r9
               	movl	$0x1, (%r9)
               	movl	$0x2, 0x4(%r9)
               	movl	$0x3, 0x8(%r9)
               	movl	$0x4, 0xc(%r9)
               	leaq	-0x7a0(%rbp), %rax
               	movl	$0x5, (%rax)
               	movl	$0x6, 0x4(%rax)
               	movl	$0x7, 0x8(%rax)
               	movl	$0x8, 0xc(%rax)
               	leaq	-0x790(%rbp), %rbx
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, -0x4d8(%rbp)
               	leaq	-0x4d8(%rbp), %r12
               	leaq	-0x7a0(%rbp), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, -0x4c8(%rbp)
               	leaq	-0x4c8(%rbp), %rax
               	leaq	-0x4b8(%rbp), %r9
               	movdqu	(%r12), %xmm15
               	movdqu	(%rax), %xmm14
               	shufpd	$0x1, %xmm14, %xmm15    # xmm15 = xmm15[1],xmm14[0]
               	movdqu	%xmm15, (%r9)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, -0x728(%rbp)
               	leaq	-0x728(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	leaq	-0x708(%rbp), %rax
               	leaq	-0x790(%rbp), %rdx
               	leaq	-0x770(%rbp), %rcx
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
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	xorq	$0x4, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %ecx
               	xorq	$0x5, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	xorq	$0x6, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1d, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x708(%rbp), %rax
               	leaq	-0x770(%rbp), %rcx
               	movq	$0x0, (%rcx)
               	movq	$0x0, 0x8(%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	cmpl	$0x0, 0x4(%rax)
               	jne	<addr>
               	cmpl	$0x0, 0x8(%rax)
               	jne	<addr>
               	leaq	-0x708(%rbp), %rax
               	cmpl	$0x0, 0xc(%rax)
               	je	<addr>
               	movl	$0x1e, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x718(%rbp), %rax
               	movb	$0x1, (%rax)
               	movb	$0x8, 0x1(%rax)
               	movb	$0xf, 0x2(%rax)
               	movb	$0x16, 0x3(%rax)
               	movb	$0x1d, 0x4(%rax)
               	movb	$0x24, 0x5(%rax)
               	movb	$0x2b, 0x6(%rax)
               	leaq	-0x718(%rbp), %rax
               	movb	$0x32, 0x7(%rax)
               	movb	$0x39, 0x8(%rax)
               	movb	$0x40, 0x9(%rax)
               	movb	$0x47, 0xa(%rax)
               	movb	$0x4e, 0xb(%rax)
               	movb	$0x55, 0xc(%rax)
               	movb	$0x5c, 0xd(%rax)
               	leaq	-0x718(%rbp), %rdi
               	movb	$0x63, 0xe(%rdi)
               	movb	$0x6a, 0xf(%rdi)
               	leaq	-0x7b0(%rbp), %rbx
               	callq	<addr>
               	movups	%xmm0, -0x728(%rbp)
               	leaq	-0x728(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	leaq	-0x718(%rbp), %rax
               	movq	$0x0, (%rax)
               	movq	$0x0, 0x8(%rax)
               	leaq	-0x7b0(%rbp), %rdx
               	leaq	-0x770(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movzbq	(%rax), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x1f, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movzbq	0x1(%rax), %rcx
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	movzbq	0x2(%rax), %rcx
               	cmpl	$0xf, %ecx
               	jne	<addr>
               	movzbq	0x3(%rax), %rax
               	cmpl	$0x16, %eax
               	jne	<addr>
               	leaq	-0x718(%rbp), %rax
               	movzbq	0x4(%rax), %rcx
               	cmpl	$0x1d, %ecx
               	jne	<addr>
               	movzbq	0x5(%rax), %rcx
               	cmpl	$0x24, %ecx
               	jne	<addr>
               	movzbq	0x6(%rax), %rcx
               	cmpl	$0x2b, %ecx
               	jne	<addr>
               	movzbq	0x7(%rax), %rcx
               	cmpl	$0x32, %ecx
               	jne	<addr>
               	movzbq	0x8(%rax), %rcx
               	cmpl	$0x39, %ecx
               	jne	<addr>
               	movzbq	0x9(%rax), %rcx
               	cmpl	$0x40, %ecx
               	jne	<addr>
               	movzbq	0xa(%rax), %rcx
               	cmpl	$0x47, %ecx
               	jne	<addr>
               	movzbq	0xb(%rax), %rax
               	cmpl	$0x4e, %eax
               	jne	<addr>
               	leaq	-0x718(%rbp), %rax
               	movzbq	0xc(%rax), %rcx
               	cmpl	$0x55, %ecx
               	jne	<addr>
               	movzbq	0xd(%rax), %rcx
               	cmpl	$0x5c, %ecx
               	jne	<addr>
               	movzbq	0xe(%rax), %rcx
               	cmpl	$0x63, %ecx
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	cmpl	$0x6a, %eax
               	jne	<addr>
               	leaq	-0x728(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	$0x0, (%rax)
               	leaq	-0x728(%rbp), %rax
               	movw	$0x1, 0x2(%rax)
               	movw	$0x2, 0x4(%rax)
               	movw	$0x3, 0x6(%rax)
               	leaq	-0x728(%rbp), %r9
               	movw	$0x4, 0x8(%r9)
               	movw	$0x5, 0xa(%r9)
               	movw	$0x6, 0xc(%r9)
               	movw	$0x7, 0xe(%r9)
               	leaq	<rip>, %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x21, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x728(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	$0x7, -0x728(%rbp)
               	leaq	-0x728(%rbp), %rbx
               	movw	$0x6, 0x2(%rbx)
               	leaq	-0x728(%rbp), %rax
               	movw	$0x5, 0x4(%rax)
               	movw	$0x4, 0x6(%rax)
               	leaq	-0x728(%rbp), %rax
               	movw	$0x3, 0x8(%rax)
               	movw	$0x2, 0xa(%rax)
               	movw	$0x1, 0xc(%rax)
               	movw	$0x0, 0xe(%rax)
               	leaq	-0x728(%rbp), %r9
               	leaq	<rip>, %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x22, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x728(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movb	$0x0, (%rax)
               	leaq	-0x728(%rbp), %rax
               	movb	$0x1, 0x1(%rax)
               	movb	$0x2, 0x2(%rax)
               	movb	$0x3, 0x3(%rax)
               	leaq	-0x728(%rbp), %rax
               	movb	$0x4, 0x4(%rax)
               	movb	$0x5, 0x5(%rax)
               	movb	$0x6, 0x6(%rax)
               	movb	$0x7, 0x7(%rax)
               	movb	$0x8, 0x8(%rax)
               	movb	$0x9, 0x9(%rax)
               	leaq	-0x728(%rbp), %r9
               	movb	$0xa, 0xa(%r9)
               	movb	$0xb, 0xb(%r9)
               	movb	$0xc, 0xc(%r9)
               	movb	$0xd, 0xd(%r9)
               	movb	$0xe, 0xe(%r9)
               	movb	$0xf, 0xf(%r9)
               	leaq	<rip>, %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x23, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x728(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movb	$0xf, -0x728(%rbp)
               	leaq	-0x728(%rbp), %rbx
               	movb	$0xe, 0x1(%rbx)
               	leaq	-0x728(%rbp), %rbx
               	movb	$0xd, 0x2(%rbx)
               	leaq	-0x728(%rbp), %rbx
               	movb	$0xc, 0x3(%rbx)
               	leaq	-0x728(%rbp), %rbx
               	movb	$0xb, 0x4(%rbx)
               	leaq	-0x728(%rbp), %rbx
               	movb	$0xa, 0x5(%rbx)
               	leaq	-0x728(%rbp), %rbx
               	movb	$0x9, 0x6(%rbx)
               	leaq	-0x728(%rbp), %rbx
               	movb	$0x8, 0x7(%rbx)
               	leaq	-0x728(%rbp), %rbx
               	movb	$0x7, 0x8(%rbx)
               	leaq	-0x728(%rbp), %rbx
               	movb	$0x6, 0x9(%rbx)
               	leaq	-0x728(%rbp), %rax
               	movb	$0x5, 0xa(%rax)
               	movb	$0x4, 0xb(%rax)
               	leaq	-0x728(%rbp), %rax
               	movb	$0x3, 0xc(%rax)
               	movb	$0x2, 0xd(%rax)
               	movb	$0x1, 0xe(%rax)
               	movb	$0x0, 0xf(%rax)
               	leaq	-0x728(%rbp), %r9
               	leaq	<rip>, %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x24, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x708(%rbp), %rcx
               	leaq	-0x770(%rbp), %rax
               	movl	$0x1, (%rax)
               	movl	$0x2, 0x4(%rax)
               	movl	$0x3, 0x8(%rax)
               	movl	$0x4, 0xc(%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	movl	(%rcx), %eax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x708(%rbp), %rdx
               	movl	0xc(%rdx), %eax
               	xorq	$0x4, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x25, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x770(%rbp), %rax
               	movl	$0x11223344, (%rax)     # imm = 0x11223344
               	movl	$0x11223344, 0x4(%rax)  # imm = 0x11223344
               	movl	$0x11223344, 0x8(%rax)  # imm = 0x11223344
               	movl	$0x11223344, 0xc(%rax)  # imm = 0x11223344
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movl	(%rdx), %eax
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	jne	<addr>
               	movl	0xc(%rdx), %eax
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	je	<addr>
               	movl	$0x26, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x728(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0x1234, (%rcx)         # imm = 0x1234
               	movw	$0x1234, 0x2(%rcx)      # imm = 0x1234
               	movw	$0x1234, 0x4(%rcx)      # imm = 0x1234
               	movw	$0x1234, 0x6(%rcx)      # imm = 0x1234
               	movw	$0x1234, 0x8(%rcx)      # imm = 0x1234
               	leaq	-0x728(%rbp), %rcx
               	movw	$0x1234, 0xa(%rcx)      # imm = 0x1234
               	movw	$0x1234, 0xc(%rcx)      # imm = 0x1234
               	movw	$0x1234, 0xe(%rcx)      # imm = 0x1234
               	leaq	-0x770(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x708(%rbp), %rdx
               	movl	(%rdx), %eax
               	cmpl	$0x12341234, %eax       # imm = 0x12341234
               	jne	<addr>
               	movl	0xc(%rdx), %eax
               	cmpl	$0x12341234, %eax       # imm = 0x12341234
               	je	<addr>
               	movl	$0x27, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movb	$0x5a, (%rcx)
               	leaq	-0x728(%rbp), %rcx
               	movb	$0x5a, 0x1(%rcx)
               	movb	$0x5a, 0x2(%rcx)
               	movb	$0x5a, 0x3(%rcx)
               	movb	$0x5a, 0x4(%rcx)
               	movb	$0x5a, 0x5(%rcx)
               	movb	$0x5a, 0x6(%rcx)
               	leaq	-0x728(%rbp), %rcx
               	movb	$0x5a, 0x7(%rcx)
               	movb	$0x5a, 0x8(%rcx)
               	movb	$0x5a, 0x9(%rcx)
               	movb	$0x5a, 0xa(%rcx)
               	movb	$0x5a, 0xb(%rcx)
               	movb	$0x5a, 0xc(%rcx)
               	leaq	-0x728(%rbp), %rcx
               	movb	$0x5a, 0xd(%rcx)
               	movb	$0x5a, 0xe(%rcx)
               	movb	$0x5a, 0xf(%rcx)
               	leaq	-0x770(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x708(%rbp), %rcx
               	movl	(%rcx), %edx
               	cmpl	$0x5a5a5a5a, %edx       # imm = 0x5A5A5A5A
               	jne	<addr>
               	movl	0xc(%rcx), %edx
               	cmpl	$0x5a5a5a5a, %edx       # imm = 0x5A5A5A5A
               	je	<addr>
               	movl	$0x28, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movabsq	$0x123456789abcdef, %rdx # imm = 0x123456789ABCDEF
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	movl	(%rcx), %eax
               	movl	$0x89abcdef, %r11d      # imm = 0x89ABCDEF
               	cmpl	%r11d, %eax
               	jne	<addr>
               	movl	0x4(%rcx), %eax
               	cmpl	$0x1234567, %eax        # imm = 0x1234567
               	jne	<addr>
               	leaq	-0x708(%rbp), %rsi
               	movl	0xc(%rsi), %eax
               	cmpl	$0x1234567, %eax        # imm = 0x1234567
               	je	<addr>
               	movl	$0x29, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x7b0(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movb	$-0x1, (%rcx)
               	movb	$-0x1, 0x1(%rcx)
               	movb	$-0x1, 0x2(%rcx)
               	movb	$-0x1, 0x3(%rcx)
               	movb	$-0x1, 0x4(%rcx)
               	movb	$-0x1, 0x5(%rcx)
               	movb	$-0x1, 0x6(%rcx)
               	movb	$-0x1, 0x7(%rcx)
               	movb	$-0x1, 0x8(%rcx)
               	movb	$-0x1, 0x9(%rcx)
               	movb	$-0x1, 0xa(%rcx)
               	movb	$-0x1, 0xb(%rcx)
               	movb	$-0x1, 0xc(%rcx)
               	movb	$-0x1, 0xd(%rcx)
               	movb	$-0x1, 0xe(%rcx)
               	movb	$-0x1, 0xf(%rcx)
               	leaq	-0x7a0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movb	$0x1, (%rax)
               	movb	$0x1, 0x1(%rax)
               	movb	$0x1, 0x2(%rax)
               	movb	$0x1, 0x3(%rax)
               	movb	$0x1, 0x4(%rax)
               	movb	$0x1, 0x5(%rax)
               	movb	$0x1, 0x6(%rax)
               	movb	$0x1, 0x7(%rax)
               	movb	$0x1, 0x8(%rax)
               	movb	$0x1, 0x9(%rax)
               	movb	$0x1, 0xa(%rax)
               	movb	$0x1, 0xb(%rax)
               	movb	$0x1, 0xc(%rax)
               	movb	$0x1, 0xd(%rax)
               	movb	$0x1, 0xe(%rax)
               	movb	$0x1, 0xf(%rax)
               	leaq	-0x4a8(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	paddb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x770(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rsi)
               	cmpl	$0x0, (%rsi)
               	jne	<addr>
               	leaq	-0x708(%rbp), %rdx
               	cmpl	$0x0, 0xc(%rdx)
               	je	<addr>
               	movl	$0x2a, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x498(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0x488(%rbp), %rdi
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rax), %xmm14
               	psubb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movl	(%rdx), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x2b, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x7b0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	$0xffff, (%rax)         # imm = 0xFFFF
               	movw	$0xffff, 0x2(%rax)      # imm = 0xFFFF
               	movw	$0xffff, 0x4(%rax)      # imm = 0xFFFF
               	movw	$0xffff, 0x6(%rax)      # imm = 0xFFFF
               	movw	$0xffff, 0x8(%rax)      # imm = 0xFFFF
               	movw	$0xffff, 0xa(%rax)      # imm = 0xFFFF
               	movw	$0xffff, 0xc(%rax)      # imm = 0xFFFF
               	movw	$0xffff, 0xe(%rax)      # imm = 0xFFFF
               	leaq	-0x708(%rbp), %rsi
               	leaq	-0x478(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movw	$0x1, (%rdx)
               	movw	$0x1, 0x2(%rdx)
               	movw	$0x1, 0x4(%rdx)
               	movw	$0x1, 0x6(%rdx)
               	leaq	-0x478(%rbp), %rdx
               	movw	$0x1, 0x8(%rdx)
               	movw	$0x1, 0xa(%rdx)
               	movw	$0x1, 0xc(%rdx)
               	movw	$0x1, 0xe(%rdx)
               	leaq	-0x468(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	paddw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x770(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x708(%rbp), %rdx
               	cmpl	$0x0, (%rdx)
               	je	<addr>
               	movl	$0x2c, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x458(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0x448(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0x1, (%rcx)
               	movw	$0x1, 0x2(%rcx)
               	movw	$0x1, 0x4(%rcx)
               	movw	$0x1, 0x6(%rcx)
               	leaq	-0x448(%rbp), %rcx
               	movw	$0x1, 0x8(%rcx)
               	movw	$0x1, 0xa(%rcx)
               	movw	$0x1, 0xc(%rcx)
               	movw	$0x1, 0xe(%rcx)
               	leaq	-0x438(%rbp), %rax
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rcx), %xmm14
               	psubw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x770(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x708(%rbp), %rsi
               	movl	(%rsi), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x2d, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x428(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0x5, (%rax)
               	movl	$0x5, 0x4(%rax)
               	movl	$0x5, 0x8(%rax)
               	movl	$0x5, 0xc(%rax)
               	leaq	-0x418(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0x7, (%rcx)
               	movl	$0x7, 0x4(%rcx)
               	movl	$0x7, 0x8(%rcx)
               	movl	$0x7, 0xc(%rcx)
               	leaq	-0x418(%rbp), %rdx
               	leaq	-0x408(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	psubd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x770(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x708(%rbp), %rsi
               	movl	(%rsi), %eax
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x2e, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x3f8(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0x1234, (%rcx)         # imm = 0x1234
               	movw	$0x1234, 0x2(%rcx)      # imm = 0x1234
               	movw	$0x1234, 0x4(%rcx)      # imm = 0x1234
               	movw	$0x1234, 0x6(%rcx)      # imm = 0x1234
               	movw	$0x1234, 0x8(%rcx)      # imm = 0x1234
               	leaq	-0x3f8(%rbp), %rdx
               	movw	$0x1234, 0xa(%rdx)      # imm = 0x1234
               	movw	$0x1234, 0xc(%rdx)      # imm = 0x1234
               	movw	$0x1234, 0xe(%rdx)      # imm = 0x1234
               	leaq	-0x3e8(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0x3, (%rcx)
               	movw	$0x3, 0x2(%rcx)
               	movw	$0x3, 0x4(%rcx)
               	movw	$0x3, 0x6(%rcx)
               	leaq	-0x3e8(%rbp), %rcx
               	movw	$0x3, 0x8(%rcx)
               	movw	$0x3, 0xa(%rcx)
               	movw	$0x3, 0xc(%rcx)
               	movw	$0x3, 0xe(%rcx)
               	leaq	-0x3d8(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rcx), %xmm14
               	pmullw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x770(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x708(%rbp), %rsi
               	movl	(%rsi), %eax
               	cmpl	$0x369c369c, %eax       # imm = 0x369C369C
               	je	<addr>
               	movl	$0x2f, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x3c8(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0xf000, (%rcx)         # imm = 0xF000
               	movw	$0xf000, 0x2(%rcx)      # imm = 0xF000
               	movw	$0xf000, 0x4(%rcx)      # imm = 0xF000
               	movw	$0xf000, 0x6(%rcx)      # imm = 0xF000
               	movw	$0xf000, 0x8(%rcx)      # imm = 0xF000
               	leaq	-0x3c8(%rbp), %rdx
               	movw	$0xf000, 0xa(%rdx)      # imm = 0xF000
               	movw	$0xf000, 0xc(%rdx)      # imm = 0xF000
               	movw	$0xf000, 0xe(%rdx)      # imm = 0xF000
               	leaq	-0x3b8(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0x10, (%rcx)
               	movw	$0x10, 0x2(%rcx)
               	movw	$0x10, 0x4(%rcx)
               	movw	$0x10, 0x6(%rcx)
               	leaq	-0x3b8(%rbp), %rcx
               	movw	$0x10, 0x8(%rcx)
               	movw	$0x10, 0xa(%rcx)
               	movw	$0x10, 0xc(%rcx)
               	movw	$0x10, 0xe(%rcx)
               	leaq	-0x3a8(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rcx), %xmm14
               	pmulhw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x770(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x708(%rbp), %rsi
               	movl	(%rsi), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x30, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x398(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0x1000, (%rcx)         # imm = 0x1000
               	movw	$0x1000, 0x2(%rcx)      # imm = 0x1000
               	movw	$0x1000, 0x4(%rcx)      # imm = 0x1000
               	movw	$0x1000, 0x6(%rcx)      # imm = 0x1000
               	movw	$0x1000, 0x8(%rcx)      # imm = 0x1000
               	leaq	-0x398(%rbp), %rdx
               	movw	$0x1000, 0xa(%rdx)      # imm = 0x1000
               	movw	$0x1000, 0xc(%rdx)      # imm = 0x1000
               	movw	$0x1000, 0xe(%rdx)      # imm = 0x1000
               	leaq	-0x388(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0x10, (%rcx)
               	movw	$0x10, 0x2(%rcx)
               	movw	$0x10, 0x4(%rcx)
               	movw	$0x10, 0x6(%rcx)
               	leaq	-0x388(%rbp), %rcx
               	movw	$0x10, 0x8(%rcx)
               	movw	$0x10, 0xa(%rcx)
               	movw	$0x10, 0xc(%rcx)
               	movw	$0x10, 0xe(%rcx)
               	leaq	-0x378(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rcx), %xmm14
               	pmulhw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x770(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x708(%rbp), %rdx
               	movl	(%rdx), %eax
               	cmpl	$0x10001, %eax          # imm = 0x10001
               	je	<addr>
               	movl	$0x31, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x7b0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	$0x1, (%rax)
               	movw	$0x2, 0x2(%rax)
               	movw	$0x3, 0x4(%rax)
               	movw	$0x4, 0x6(%rax)
               	movw	$0x5, 0x8(%rax)
               	movw	$0x6, 0xa(%rax)
               	movw	$0x7, 0xc(%rax)
               	movw	$0x8, 0xe(%rax)
               	leaq	-0x7b0(%rbp), %rsi
               	leaq	-0x368(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0xfffe, (%rcx)         # imm = 0xFFFE
               	movw	$0xfffe, 0x2(%rcx)      # imm = 0xFFFE
               	movw	$0xfffe, 0x4(%rcx)      # imm = 0xFFFE
               	movw	$0xfffe, 0x6(%rcx)      # imm = 0xFFFE
               	leaq	-0x368(%rbp), %rcx
               	movw	$0xfffe, 0x8(%rcx)      # imm = 0xFFFE
               	movw	$0xfffe, 0xa(%rcx)      # imm = 0xFFFE
               	movw	$0xfffe, 0xc(%rcx)      # imm = 0xFFFE
               	movw	$0xfffe, 0xe(%rcx)      # imm = 0xFFFE
               	leaq	-0x358(%rbp), %rax
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rcx), %xmm14
               	pmaddwd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x770(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x708(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	$0xfffffffa, %r11d      # imm = 0xFFFFFFFA
               	cmpl	%r11d, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	movl	$0xffffffe2, %r11d      # imm = 0xFFFFFFE2
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x32, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x718(%rbp), %rsi
               	leaq	-0x348(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0x12c, (%rcx)          # imm = 0x12C
               	movw	$0x12c, 0x2(%rcx)       # imm = 0x12C
               	movw	$0x12c, 0x4(%rcx)       # imm = 0x12C
               	movw	$0x12c, 0x6(%rcx)       # imm = 0x12C
               	movw	$0x12c, 0x8(%rcx)       # imm = 0x12C
               	leaq	-0x348(%rbp), %rdx
               	movw	$0x12c, 0xa(%rdx)       # imm = 0x12C
               	movw	$0x12c, 0xc(%rdx)       # imm = 0x12C
               	movw	$0x12c, 0xe(%rdx)       # imm = 0x12C
               	leaq	-0x338(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0xfed4, (%rcx)         # imm = 0xFED4
               	movw	$0xfed4, 0x2(%rcx)      # imm = 0xFED4
               	movw	$0xfed4, 0x4(%rcx)      # imm = 0xFED4
               	movw	$0xfed4, 0x6(%rcx)      # imm = 0xFED4
               	leaq	-0x338(%rbp), %rcx
               	movw	$0xfed4, 0x8(%rcx)      # imm = 0xFED4
               	movw	$0xfed4, 0xa(%rcx)      # imm = 0xFED4
               	movw	$0xfed4, 0xc(%rcx)      # imm = 0xFED4
               	movw	$0xfed4, 0xe(%rcx)      # imm = 0xFED4
               	leaq	-0x328(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rcx), %xmm14
               	packsswb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x770(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x718(%rbp), %rdx
               	movzbq	(%rdx), %rax
               	xorq	$0x7f, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	0x7(%rdx), %rax
               	xorq	$0x7f, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	0x8(%rdx), %rax
               	xorq	$0x80, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	0xf(%rdx), %rax
               	xorq	$0x80, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x33, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x318(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0x12c, (%rcx)          # imm = 0x12C
               	movw	$0x12c, 0x2(%rcx)       # imm = 0x12C
               	movw	$0x12c, 0x4(%rcx)       # imm = 0x12C
               	movw	$0x12c, 0x6(%rcx)       # imm = 0x12C
               	movw	$0x12c, 0x8(%rcx)       # imm = 0x12C
               	leaq	-0x318(%rbp), %rsi
               	movw	$0x12c, 0xa(%rsi)       # imm = 0x12C
               	movw	$0x12c, 0xc(%rsi)       # imm = 0x12C
               	movw	$0x12c, 0xe(%rsi)       # imm = 0x12C
               	leaq	-0x308(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0xfffb, (%rcx)         # imm = 0xFFFB
               	movw	$0xfffb, 0x2(%rcx)      # imm = 0xFFFB
               	movw	$0xfffb, 0x4(%rcx)      # imm = 0xFFFB
               	movw	$0xfffb, 0x6(%rcx)      # imm = 0xFFFB
               	leaq	-0x308(%rbp), %rcx
               	movw	$0xfffb, 0x8(%rcx)      # imm = 0xFFFB
               	movw	$0xfffb, 0xa(%rcx)      # imm = 0xFFFB
               	movw	$0xfffb, 0xc(%rcx)      # imm = 0xFFFB
               	movw	$0xfffb, 0xe(%rcx)      # imm = 0xFFFB
               	leaq	-0x2f8(%rbp), %rax
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rcx), %xmm14
               	packuswb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x770(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x718(%rbp), %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0xff, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	0x7(%rcx), %rax
               	xorq	$0xff, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpb	$0x0, 0x8(%rcx)
               	jne	<addr>
               	cmpb	$0x0, 0xf(%rcx)
               	je	<addr>
               	movl	$0x34, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x2e8(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0x11170, (%rax)        # imm = 0x11170
               	movl	$0x11170, 0x4(%rax)     # imm = 0x11170
               	movl	$0x11170, 0x8(%rax)     # imm = 0x11170
               	movl	$0x11170, 0xc(%rax)     # imm = 0x11170
               	leaq	-0x2d8(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0xfffeee90, (%rdx)     # imm = 0xFFFEEE90
               	movl	$0xfffeee90, 0x4(%rdx)  # imm = 0xFFFEEE90
               	movl	$0xfffeee90, 0x8(%rdx)  # imm = 0xFFFEEE90
               	movl	$0xfffeee90, 0xc(%rdx)  # imm = 0xFFFEEE90
               	leaq	-0x2d8(%rbp), %rsi
               	leaq	-0x2c8(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rsi), %xmm14
               	packssdw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x770(%rbp), %rax
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x718(%rbp), %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0xff, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	0x1(%rcx), %rax
               	xorq	$0x7f, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpb	$0x0, 0x8(%rcx)
               	jne	<addr>
               	movzbq	0x9(%rcx), %rax
               	xorq	$0x80, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x35, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x7b0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movb	$0x0, (%rax)
               	movb	$0x1, 0x1(%rax)
               	movb	$0x2, 0x2(%rax)
               	movb	$0x3, 0x3(%rax)
               	movb	$0x4, 0x4(%rax)
               	movb	$0x5, 0x5(%rax)
               	movb	$0x6, 0x6(%rax)
               	movb	$0x7, 0x7(%rax)
               	movb	$0x8, 0x8(%rax)
               	movb	$0x9, 0x9(%rax)
               	movb	$0xa, 0xa(%rax)
               	movb	$0xb, 0xb(%rax)
               	movb	$0xc, 0xc(%rax)
               	movb	$0xd, 0xd(%rax)
               	movb	$0xe, 0xe(%rax)
               	movb	$0xf, 0xf(%rax)
               	leaq	-0x7b0(%rbp), %rsi
               	leaq	-0x2b8(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x2a8(%rbp), %rdi
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rax), %xmm14
               	punpcklbw	%xmm14, %xmm15  # xmm15 = xmm15[0],xmm14[0],xmm15[1],xmm14[1],xmm15[2],xmm14[2],xmm15[3],xmm14[3],xmm15[4],xmm14[4],xmm15[5],xmm14[5],xmm15[6],xmm14[6],xmm15[7],xmm14[7]
               	movdqu	%xmm15, (%rdi)
               	leaq	-0x770(%rbp), %rdx
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rdi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x718(%rbp), %rax
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	cmpb	$0x0, 0x1(%rax)
               	jne	<addr>
               	movzbq	0x2(%rax), %rcx
               	xorq	$0x1, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0xe(%rax), %rcx
               	xorq	$0x7, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpb	$0x0, 0xf(%rax)
               	je	<addr>
               	movl	$0x36, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x298(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x288(%rbp), %rdi
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rcx), %xmm14
               	punpckhbw	%xmm14, %xmm15  # xmm15 = xmm15[8],xmm14[8],xmm15[9],xmm14[9],xmm15[10],xmm14[10],xmm15[11],xmm14[11],xmm15[12],xmm14[12],xmm15[13],xmm14[13],xmm15[14],xmm14[14],xmm15[15],xmm14[15]
               	movdqu	%xmm15, (%rdi)
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rdi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	-0x770(%rbp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x718(%rbp), %rax
               	movzbq	(%rax), %rdx
               	xorq	$0x8, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	cmpb	$0x0, 0x1(%rax)
               	jne	<addr>
               	movzbq	0xe(%rax), %rdx
               	xorq	$0xf, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	cmpb	$0x0, 0xf(%rax)
               	je	<addr>
               	movl	$0x37, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x7b0(%rbp), %rdi
               	leaq	-0x278(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x268(%rbp), %rsi
               	movdqu	(%rdi), %xmm15
               	movdqu	(%rdx), %xmm14
               	punpcklwd	%xmm14, %xmm15  # xmm15 = xmm15[0],xmm14[0],xmm15[1],xmm14[1],xmm15[2],xmm14[2],xmm15[3],xmm14[3]
               	movdqu	%xmm15, (%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	leaq	-0x718(%rbp), %rax
               	movzbq	0x1(%rax), %rcx
               	xorq	$0x1, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpb	$0x0, 0x2(%rax)
               	jne	<addr>
               	cmpb	$0x0, 0x3(%rax)
               	jne	<addr>
               	movzbq	0x4(%rax), %rcx
               	xorq	$0x2, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x38, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x7b0(%rbp), %rdx
               	leaq	-0x258(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x248(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rcx), %xmm14
               	punpckhwd	%xmm14, %xmm15  # xmm15 = xmm15[4],xmm14[4],xmm15[5],xmm14[5],xmm15[6],xmm14[6],xmm15[7],xmm14[7]
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x770(%rbp), %rdx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movzbq	(%rax), %rcx
               	xorq	$0x8, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x1(%rax), %rcx
               	xorq	$0x9, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpb	$0x0, 0x2(%rax)
               	jne	<addr>
               	leaq	-0x718(%rbp), %rax
               	movzbq	0x4(%rax), %rax
               	xorq	$0xa, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x39, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x7b0(%rbp), %rax
               	movl	$0x1, (%rax)
               	movl	$0x2, 0x4(%rax)
               	movl	$0x3, 0x8(%rax)
               	movl	$0x4, 0xc(%rax)
               	leaq	-0x7a0(%rbp), %rcx
               	movl	$0x5, (%rcx)
               	movl	$0x6, 0x4(%rcx)
               	movl	$0x7, 0x8(%rcx)
               	movl	$0x8, 0xc(%rcx)
               	leaq	-0x708(%rbp), %rsi
               	leaq	-0x238(%rbp), %rdi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	punpckldq	%xmm14, %xmm15  # xmm15 = xmm15[0],xmm14[0],xmm15[1],xmm14[1]
               	movdqu	%xmm15, (%rdi)
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rdi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	-0x770(%rbp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rsi)
               	movl	(%rsi), %eax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	0x4(%rsi), %eax
               	xorq	$0x5, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x708(%rbp), %rax
               	movl	0x8(%rax), %edx
               	xorq	$0x2, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movl	0xc(%rax), %edx
               	xorq	$0x6, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x3a, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x7b0(%rbp), %rsi
               	leaq	-0x7a0(%rbp), %rdi
               	leaq	-0x228(%rbp), %rdx
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
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	(%rax), %eax
               	xorq	$0x3, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x708(%rbp), %rax
               	movl	0x4(%rax), %ecx
               	xorq	$0x7, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %ecx
               	xorq	$0x4, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %ecx
               	xorq	$0x8, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x3b, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x7b0(%rbp), %rdx
               	leaq	-0x7a0(%rbp), %rsi
               	leaq	-0x218(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rsi), %xmm14
               	punpckhqdq	%xmm14, %xmm15  # xmm15 = xmm15[1],xmm14[1]
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x770(%rbp), %rdx
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
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	xorq	$0x4, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %eax
               	xorq	$0x7, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x708(%rbp), %rdx
               	movl	0xc(%rdx), %eax
               	xorq	$0x8, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3c, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x208(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0xfff0, (%rcx)         # imm = 0xFFF0
               	movw	$0xfff0, 0x2(%rcx)      # imm = 0xFFF0
               	movw	$0xfff0, 0x4(%rcx)      # imm = 0xFFF0
               	movw	$0xfff0, 0x6(%rcx)      # imm = 0xFFF0
               	movw	$0xfff0, 0x8(%rcx)      # imm = 0xFFF0
               	leaq	-0x208(%rbp), %rcx
               	movw	$0xfff0, 0xa(%rcx)      # imm = 0xFFF0
               	movw	$0xfff0, 0xc(%rcx)      # imm = 0xFFF0
               	movw	$0xfff0, 0xe(%rcx)      # imm = 0xFFF0
               	leaq	-0x1f8(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	psraw	$0x2, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x770(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x708(%rbp), %rdx
               	movl	(%rdx), %eax
               	movl	$0xfffcfffc, %r11d      # imm = 0xFFFCFFFC
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x3d, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x1e8(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0xfff0, (%rcx)         # imm = 0xFFF0
               	movw	$0xfff0, 0x2(%rcx)      # imm = 0xFFF0
               	movw	$0xfff0, 0x4(%rcx)      # imm = 0xFFF0
               	movw	$0xfff0, 0x6(%rcx)      # imm = 0xFFF0
               	movw	$0xfff0, 0x8(%rcx)      # imm = 0xFFF0
               	leaq	-0x1e8(%rbp), %rcx
               	movw	$0xfff0, 0xa(%rcx)      # imm = 0xFFF0
               	movw	$0xfff0, 0xc(%rcx)      # imm = 0xFFF0
               	movw	$0xfff0, 0xe(%rcx)      # imm = 0xFFF0
               	leaq	-0x1d8(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	psraw	$0x20, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x770(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x708(%rbp), %rdx
               	movl	(%rdx), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x3e, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x1c8(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0xfffffff0, (%rax)     # imm = 0xFFFFFFF0
               	movl	$0xfffffff0, 0x4(%rax)  # imm = 0xFFFFFFF0
               	movl	$0xfffffff0, 0x8(%rax)  # imm = 0xFFFFFFF0
               	movl	$0xfffffff0, 0xc(%rax)  # imm = 0xFFFFFFF0
               	leaq	-0x1b8(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	psrad	$0x2, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x770(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x708(%rbp), %rdx
               	movl	(%rdx), %eax
               	movl	$0xfffffffc, %r11d      # imm = 0xFFFFFFFC
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x3f, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x3, %esi
               	leaq	-0x1a8(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0xffffffc0, (%rax)     # imm = 0xFFFFFFC0
               	movl	$0xffffffc0, 0x4(%rax)  # imm = 0xFFFFFFC0
               	movl	$0xffffffc0, 0x8(%rax)  # imm = 0xFFFFFFC0
               	movl	$0xffffffc0, 0xc(%rax)  # imm = 0xFFFFFFC0
               	leaq	-0x1a8(%rbp), %rcx
               	leaq	-0x198(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movq	%rsi, %xmm14
               	psrad	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x770(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movl	-0x708(%rbp), %eax
               	movl	$0xfffffff8, %r11d      # imm = 0xFFFFFFF8
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x40, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x7b0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movb	$0x0, (%rax)
               	movb	$0x1, 0x1(%rax)
               	movb	$0x2, 0x2(%rax)
               	movb	$0x3, 0x3(%rax)
               	movb	$0x4, 0x4(%rax)
               	movb	$0x5, 0x5(%rax)
               	movb	$0x6, 0x6(%rax)
               	movb	$0x7, 0x7(%rax)
               	movb	$0x8, 0x8(%rax)
               	movb	$0x9, 0x9(%rax)
               	movb	$0xa, 0xa(%rax)
               	movb	$0xb, 0xb(%rax)
               	movb	$0xc, 0xc(%rax)
               	movb	$0xd, 0xd(%rax)
               	movb	$0xe, 0xe(%rax)
               	movb	$0xf, 0xf(%rax)
               	leaq	-0x718(%rbp), %rcx
               	leaq	-0x188(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	psrldq	$0x3, %xmm15            # xmm15 = xmm15[3,4,5,6,7,8,9,10,11,12,13,14,15],zero,zero,zero
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x770(%rbp), %rax
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	movzbq	(%rcx), %rax
               	xorq	$0x3, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	0xc(%rcx), %rax
               	xorq	$0xf, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpb	$0x0, 0xd(%rcx)
               	jne	<addr>
               	cmpb	$0x0, 0xf(%rcx)
               	je	<addr>
               	movl	$0x41, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x718(%rbp), %rax
               	leaq	-0x7b0(%rbp), %rdx
               	movl	$0xbeef, %esi           # imm = 0xBEEF
               	leaq	-0x178(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	pinsrw	$0x2, %esi, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x770(%rbp), %rdx
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
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x5(%rax), %rcx
               	xorq	$0xbe, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x6(%rax), %rax
               	xorq	$0x6, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x42, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x168(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movb	$-0x80, (%rcx)
               	movb	$-0x80, 0x1(%rcx)
               	movb	$-0x80, 0x2(%rcx)
               	movb	$-0x80, 0x3(%rcx)
               	movb	$-0x80, 0x4(%rcx)
               	movb	$-0x80, 0x5(%rcx)
               	leaq	-0x168(%rbp), %rcx
               	movb	$-0x80, 0x6(%rcx)
               	movb	$-0x80, 0x7(%rcx)
               	movb	$-0x80, 0x8(%rcx)
               	movb	$-0x80, 0x9(%rcx)
               	movb	$-0x80, 0xa(%rcx)
               	movb	$-0x80, 0xb(%rcx)
               	movb	$-0x80, 0xc(%rcx)
               	leaq	-0x168(%rbp), %rcx
               	movb	$-0x80, 0xd(%rcx)
               	movb	$-0x80, 0xe(%rcx)
               	movb	$-0x80, 0xf(%rcx)
               	leaq	-0x18(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	pmovmskb	%xmm14, %r11d
               	movl	%r11d, (%rax)
               	movslq	(%rax), %rcx
               	cmpl	$0xffff, %ecx           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x43, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x158(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm14
               	pmovmskb	%xmm14, %r11d
               	movl	%r11d, (%rax)
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x44, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x148(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movb	$-0x80, (%rcx)
               	leaq	-0x148(%rbp), %rcx
               	movb	$0x0, 0x1(%rcx)
               	movb	$0x0, 0x2(%rcx)
               	movb	$0x0, 0x3(%rcx)
               	leaq	-0x148(%rbp), %rcx
               	movb	$0x0, 0x4(%rcx)
               	movb	$0x0, 0x5(%rcx)
               	movb	$0x0, 0x6(%rcx)
               	movb	$0x0, 0x7(%rcx)
               	movb	$0x0, 0x8(%rcx)
               	leaq	-0x148(%rbp), %rcx
               	movb	$0x0, 0x9(%rcx)
               	movb	$0x0, 0xa(%rcx)
               	movb	$0x0, 0xb(%rcx)
               	movb	$0x0, 0xc(%rcx)
               	leaq	-0x148(%rbp), %rcx
               	movb	$0x0, 0xd(%rcx)
               	movb	$0x0, 0xe(%rcx)
               	movb	$-0x80, 0xf(%rcx)
               	leaq	-0x18(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	pmovmskb	%xmm14, %r11d
               	movl	%r11d, (%rax)
               	movslq	(%rax), %rax
               	cmpl	$0x8001, %eax           # imm = 0x8001
               	je	<addr>
               	movl	$0x45, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x708(%rbp), %rdi
               	leaq	-0x138(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movb	$0xf, (%rcx)
               	movb	$0xf, 0x1(%rcx)
               	movb	$0xf, 0x2(%rcx)
               	movb	$0xf, 0x3(%rcx)
               	movb	$0xf, 0x4(%rcx)
               	leaq	-0x138(%rbp), %rcx
               	movb	$0xf, 0x5(%rcx)
               	movb	$0xf, 0x6(%rcx)
               	movb	$0xf, 0x7(%rcx)
               	movb	$0xf, 0x8(%rcx)
               	movb	$0xf, 0x9(%rcx)
               	movb	$0xf, 0xa(%rcx)
               	leaq	-0x138(%rbp), %rcx
               	movb	$0xf, 0xb(%rcx)
               	movb	$0xf, 0xc(%rcx)
               	movb	$0xf, 0xd(%rcx)
               	movb	$0xf, 0xe(%rcx)
               	movb	$0xf, 0xf(%rcx)
               	leaq	-0x128(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movb	$0x33, (%rdx)
               	movb	$0x33, 0x1(%rdx)
               	movb	$0x33, 0x2(%rdx)
               	movb	$0x33, 0x3(%rdx)
               	leaq	-0x128(%rbp), %rdx
               	movb	$0x33, 0x4(%rdx)
               	movb	$0x33, 0x5(%rdx)
               	movb	$0x33, 0x6(%rdx)
               	movb	$0x33, 0x7(%rdx)
               	movb	$0x33, 0x8(%rdx)
               	leaq	-0x128(%rbp), %rdx
               	movb	$0x33, 0x9(%rdx)
               	movb	$0x33, 0xa(%rdx)
               	movb	$0x33, 0xb(%rdx)
               	movb	$0x33, 0xc(%rdx)
               	movb	$0x33, 0xd(%rdx)
               	leaq	-0x128(%rbp), %rdx
               	movb	$0x33, 0xe(%rdx)
               	movb	$0x33, 0xf(%rdx)
               	leaq	-0x118(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pandn	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x770(%rbp), %rax
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdi)
               	leaq	-0x708(%rbp), %rcx
               	movl	(%rcx), %edx
               	cmpl	$0x30303030, %edx       # imm = 0x30303030
               	je	<addr>
               	movl	$0x46, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x7b0(%rbp), %rdx
               	leaq	-0x108(%rbp), %rsi
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
               	leaq	-0x708(%rbp), %rsi
               	movl	0xc(%rsi), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x47, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0xf8(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0x7, (%rcx)
               	movw	$0x7, 0x2(%rcx)
               	movw	$0x7, 0x4(%rcx)
               	movw	$0x7, 0x6(%rcx)
               	movw	$0x7, 0x8(%rcx)
               	leaq	-0xf8(%rbp), %rdx
               	movw	$0x7, 0xa(%rdx)
               	movw	$0x7, 0xc(%rdx)
               	movw	$0x7, 0xe(%rdx)
               	leaq	-0xe8(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0x8, (%rcx)
               	movw	$0x8, 0x2(%rcx)
               	movw	$0x8, 0x4(%rcx)
               	movw	$0x8, 0x6(%rcx)
               	leaq	-0xe8(%rbp), %rcx
               	movw	$0x8, 0x8(%rcx)
               	movw	$0x8, 0xa(%rcx)
               	movw	$0x8, 0xc(%rcx)
               	movw	$0x8, 0xe(%rcx)
               	leaq	-0xd8(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rcx), %xmm14
               	pcmpeqw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x770(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x708(%rbp), %rsi
               	cmpl	$0x0, (%rsi)
               	je	<addr>
               	movl	$0x48, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0xc8(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0x7, (%rax)
               	movl	$0x7, 0x4(%rax)
               	movl	$0x7, 0x8(%rax)
               	movl	$0x7, 0xc(%rax)
               	leaq	-0xb8(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0x7, (%rcx)
               	movl	$0x7, 0x4(%rcx)
               	movl	$0x7, 0x8(%rcx)
               	movl	$0x7, 0xc(%rcx)
               	leaq	-0xb8(%rbp), %rdx
               	leaq	-0xa8(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pcmpeqd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x770(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x708(%rbp), %rsi
               	movl	(%rsi), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x49, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x98(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0xffff, (%rcx)         # imm = 0xFFFF
               	movw	$0xffff, 0x2(%rcx)      # imm = 0xFFFF
               	movw	$0xffff, 0x4(%rcx)      # imm = 0xFFFF
               	movw	$0xffff, 0x6(%rcx)      # imm = 0xFFFF
               	movw	$0xffff, 0x8(%rcx)      # imm = 0xFFFF
               	leaq	-0x98(%rbp), %rdx
               	movw	$0xffff, 0xa(%rdx)      # imm = 0xFFFF
               	movw	$0xffff, 0xc(%rdx)      # imm = 0xFFFF
               	movw	$0xffff, 0xe(%rdx)      # imm = 0xFFFF
               	leaq	-0x88(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0xfffe, (%rcx)         # imm = 0xFFFE
               	movw	$0xfffe, 0x2(%rcx)      # imm = 0xFFFE
               	movw	$0xfffe, 0x4(%rcx)      # imm = 0xFFFE
               	movw	$0xfffe, 0x6(%rcx)      # imm = 0xFFFE
               	leaq	-0x88(%rbp), %rcx
               	movw	$0xfffe, 0x8(%rcx)      # imm = 0xFFFE
               	movw	$0xfffe, 0xa(%rcx)      # imm = 0xFFFE
               	movw	$0xfffe, 0xc(%rcx)      # imm = 0xFFFE
               	movw	$0xfffe, 0xe(%rcx)      # imm = 0xFFFE
               	leaq	-0x78(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rcx), %xmm14
               	pcmpgtw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x770(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x708(%rbp), %rsi
               	movl	(%rsi), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x4a, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x68(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0xfffffffe, (%rax)     # imm = 0xFFFFFFFE
               	movl	$0xfffffffe, 0x4(%rax)  # imm = 0xFFFFFFFE
               	movl	$0xfffffffe, 0x8(%rax)  # imm = 0xFFFFFFFE
               	movl	$0xfffffffe, 0xc(%rax)  # imm = 0xFFFFFFFE
               	leaq	-0x58(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0xffffffff, (%rcx)     # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x4(%rcx)  # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x8(%rcx)  # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xc(%rcx)  # imm = 0xFFFFFFFF
               	leaq	-0x58(%rbp), %rdx
               	leaq	-0x48(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rax), %xmm14
               	pcmpgtd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x770(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	movl	-0x708(%rbp), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x4b, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x718(%rbp), %rax
               	movb	$0x1, (%rax)
               	movb	$0x2, 0x1(%rax)
               	movb	$0x3, 0x2(%rax)
               	movb	$0x4, 0x3(%rax)
               	movb	$0x5, 0x4(%rax)
               	movb	$0x6, 0x5(%rax)
               	movb	$0x7, 0x6(%rax)
               	leaq	-0x718(%rbp), %rax
               	movb	$0x8, 0x7(%rax)
               	movb	$0x9, 0x8(%rax)
               	movb	$0xa, 0x9(%rax)
               	movb	$0xb, 0xa(%rax)
               	movb	$0xc, 0xb(%rax)
               	movb	$0xd, 0xc(%rax)
               	movb	$0xe, 0xd(%rax)
               	leaq	-0x718(%rbp), %rcx
               	movb	$0xf, 0xe(%rcx)
               	movb	$0x10, 0xf(%rcx)
               	leaq	-0x708(%rbp), %rax
               	movq	(%rcx), %rdx
               	leaq	-0x770(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	$0x0, 0x8(%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	(%rax), %ecx
               	cmpl	$0x4030201, %ecx        # imm = 0x4030201
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x8070605, %ecx        # imm = 0x8070605
               	jne	<addr>
               	cmpl	$0x0, 0x8(%rax)
               	jne	<addr>
               	leaq	-0x708(%rbp), %rax
               	cmpl	$0x0, 0xc(%rax)
               	je	<addr>
               	movl	$0x4c, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x718(%rbp), %rax
               	movabsq	$-0x1111111111111112, %rcx # imm = 0xEEEEEEEEEEEEEEEE
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x728(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0x1, (%rcx)
               	movl	$0x2, 0x4(%rcx)
               	leaq	-0x728(%rbp), %rcx
               	movl	$0x3, 0x8(%rcx)
               	movl	$0x4, 0xc(%rcx)
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x718(%rbp), %rax
               	movzbq	(%rax), %rcx
               	xorq	$0x1, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x4(%rax), %rcx
               	xorq	$0x2, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x8(%rax), %rcx
               	xorq	$0xee, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x4d, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rcx
               	leaq	-0x7b0(%rbp), %rsi
               	leaq	-0x740(%rbp), %rdx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x38(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x770(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movl	$0x4e, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movzbq	0x1(%rax), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x718(%rbp), %rax
               	movzbq	0x2(%rax), %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
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
               	movzbq	0x9(%rax), %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	leaq	-0x718(%rbp), %rax
               	movzbq	0xa(%rax), %rcx
               	cmpl	$0xa, %ecx
               	jne	<addr>
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
               	leaq	-0x708(%rbp), %rcx
               	leaq	-0x770(%rbp), %rax
               	movl	$0xffffffff, (%rax)     # imm = 0xFFFFFFFF
               	movl	$0x0, 0x4(%rax)
               	movl	$0x0, 0x8(%rax)
               	movl	$0x0, 0xc(%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	movl	(%rcx), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	jne	<addr>
               	cmpl	$0x0, 0x4(%rcx)
               	jne	<addr>
               	cmpl	$0x0, 0xc(%rcx)
               	je	<addr>
               	movl	$0x50, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0x6b8(%rbp), %rdx
               	leaq	0x1(%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	-0x780(%rbp), %rdx
               	leaq	-0x6b8(%rbp), %rax
               	leaq	0x3(%rax), %rcx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	-0x718(%rbp), %rcx
               	leaq	-0x770(%rbp), %rsi
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
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	0xf(%rcx), %rcx
               	xorq	$0x13, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x51, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	0x5(%rax), %rcx
               	movq	$0x0, (%rcx)
               	movq	$0x0, 0x8(%rcx)
               	movzbq	0x4(%rax), %rax
               	xorq	$0x5, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x6b8(%rbp), %rax
               	movzbq	0x15(%rax), %rax
               	xorq	$0x16, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x52, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x53, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
