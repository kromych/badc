
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

<same>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movups	%xmm0, -0x30(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x20(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	movzbq	-0x10(%rbp), %rax
               	movzbq	(%rdi), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movzbq	-0xf(%rbp), %rax
               	movzbq	0x1(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movzbq	-0xe(%rbp), %rax
               	movzbq	0x2(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movzbq	-0xd(%rbp), %rax
               	movzbq	0x3(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movzbq	-0xc(%rbp), %rax
               	movzbq	0x4(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movzbq	-0xb(%rbp), %rax
               	movzbq	0x5(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movzbq	-0xa(%rbp), %rax
               	movzbq	0x6(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movzbq	-0x9(%rbp), %rax
               	movzbq	0x7(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movzbq	-0x8(%rbp), %rax
               	movzbq	0x8(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movzbq	-0x7(%rbp), %rax
               	movzbq	0x9(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movzbq	-0x6(%rbp), %rax
               	movzbq	0xa(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movzbq	-0x5(%rbp), %rax
               	movzbq	0xb(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movzbq	-0x4(%rbp), %rax
               	movzbq	0xc(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movzbq	-0x3(%rbp), %rax
               	movzbq	0xd(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movzbq	-0x2(%rbp), %rax
               	movzbq	0xe(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movzbq	-0x1(%rbp), %rax
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
               	subq	$0x2b0, %rsp            # imm = 0x2B0
               	leaq	-0x2b0(%rbp), %rcx
               	leaq	<rip>, %rdx      # <addr>
               	leaq	-0x1f0(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x1e0(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	aeskeygenassist	$0x1, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0xb0(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xa0(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x90(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x70(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x200(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x60(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rax)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x200(%rbp), %rax
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xb0(%rbp), %rax
               	leaq	-0x200(%rbp), %rdx
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	-0x10(%rbp), %xmm0
               	movups	%xmm0, -0x2a0(%rbp)
               	leaq	-0x2b0(%rbp), %rdx
               	addq	$0x10, %rdx
               	leaq	-0x1d0(%rbp), %rsi
               	movdqu	(%rdx), %xmm14
               	aeskeygenassist	$0x2, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xa0(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rdx
               	movdqu	(%rax), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x70(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x200(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x60(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x50(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x200(%rbp), %rax
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xb0(%rbp), %rax
               	leaq	-0x200(%rbp), %rdx
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	-0x10(%rbp), %xmm0
               	movups	%xmm0, -0x290(%rbp)
               	leaq	-0x2b0(%rbp), %rdx
               	addq	$0x20, %rdx
               	leaq	-0x1c0(%rbp), %rsi
               	movdqu	(%rdx), %xmm14
               	aeskeygenassist	$0x4, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xa0(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rdx
               	movdqu	(%rax), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x70(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x200(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x60(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x50(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x200(%rbp), %rax
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xb0(%rbp), %rax
               	leaq	-0x200(%rbp), %rdx
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	-0x10(%rbp), %xmm0
               	movups	%xmm0, -0x280(%rbp)
               	leaq	-0x2b0(%rbp), %rdx
               	addq	$0x30, %rdx
               	leaq	-0x1b0(%rbp), %rsi
               	movdqu	(%rdx), %xmm14
               	aeskeygenassist	$0x8, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xa0(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rdx
               	movdqu	(%rax), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x70(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x200(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x60(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x50(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x200(%rbp), %rax
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xb0(%rbp), %rax
               	leaq	-0x200(%rbp), %rdx
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	-0x10(%rbp), %xmm0
               	movups	%xmm0, -0x270(%rbp)
               	leaq	-0x2b0(%rbp), %rdx
               	addq	$0x40, %rdx
               	leaq	-0x1a0(%rbp), %rsi
               	movdqu	(%rdx), %xmm14
               	aeskeygenassist	$0x10, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xa0(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rdx
               	movdqu	(%rax), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x70(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x200(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x60(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x50(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x200(%rbp), %rax
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xb0(%rbp), %rax
               	leaq	-0x200(%rbp), %rdx
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	-0x10(%rbp), %xmm0
               	movups	%xmm0, -0x260(%rbp)
               	leaq	-0x2b0(%rbp), %rdx
               	addq	$0x50, %rdx
               	leaq	-0x190(%rbp), %rsi
               	movdqu	(%rdx), %xmm14
               	aeskeygenassist	$0x20, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xa0(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rdx
               	movdqu	(%rax), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x70(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x200(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x60(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x50(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x200(%rbp), %rax
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xb0(%rbp), %rax
               	leaq	-0x200(%rbp), %rdx
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	-0x10(%rbp), %xmm0
               	movups	%xmm0, -0x250(%rbp)
               	leaq	-0x2b0(%rbp), %rdx
               	addq	$0x60, %rdx
               	leaq	-0x180(%rbp), %rsi
               	movdqu	(%rdx), %xmm14
               	aeskeygenassist	$0x40, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xa0(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rdx
               	movdqu	(%rax), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x70(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x200(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x60(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x50(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x200(%rbp), %rax
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xb0(%rbp), %rax
               	leaq	-0x200(%rbp), %rdx
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	-0x10(%rbp), %xmm0
               	movups	%xmm0, -0x240(%rbp)
               	leaq	-0x2b0(%rbp), %rdx
               	addq	$0x70, %rdx
               	leaq	-0x170(%rbp), %rsi
               	movdqu	(%rdx), %xmm14
               	aeskeygenassist	$0x80, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xa0(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rdx
               	movdqu	(%rax), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x70(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x200(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x60(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x50(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x200(%rbp), %rax
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xb0(%rbp), %rax
               	leaq	-0x200(%rbp), %rdx
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	-0x10(%rbp), %xmm0
               	movups	%xmm0, -0x230(%rbp)
               	leaq	-0x2b0(%rbp), %rdx
               	addq	$0x80, %rdx
               	leaq	-0x160(%rbp), %rsi
               	movdqu	(%rdx), %xmm14
               	aeskeygenassist	$0x1b, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xa0(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rdx
               	movdqu	(%rax), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x70(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x200(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x60(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x50(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x200(%rbp), %rax
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xb0(%rbp), %rax
               	leaq	-0x200(%rbp), %rdx
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	-0x10(%rbp), %xmm0
               	movups	%xmm0, -0x220(%rbp)
               	leaq	-0x2b0(%rbp), %rdx
               	addq	$0x90, %rdx
               	leaq	-0x150(%rbp), %rsi
               	movdqu	(%rdx), %xmm14
               	aeskeygenassist	$0x36, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xa0(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rdx
               	movdqu	(%rax), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x70(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x200(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x60(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x50(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x200(%rbp), %rax
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xb0(%rbp), %rax
               	leaq	-0x200(%rbp), %rdx
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	-0x10(%rbp), %xmm0
               	movups	%xmm0, -0x210(%rbp)
               	leaq	-0x200(%rbp), %rcx
               	leaq	<rip>, %rdx      # <addr>
               	leaq	-0x140(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x2b0(%rbp), %rdx
               	leaq	-0x130(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0x1, %eax
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdx, %rsi
               	leaq	-0x120(%rbp), %rdi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	aesenc	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	leaq	-0x120(%rbp), %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	incq	%rax
               	cmpl	$0xa, %eax
               	jl	<addr>
               	leaq	-0x200(%rbp), %r9
               	leaq	-0x2b0(%rbp), %rax
               	leaq	0xa0(%rax), %rcx
               	leaq	-0x110(%rbp), %rax
               	movdqu	(%r9), %xmm15
               	movdqu	(%rcx), %xmm14
               	aesenclast	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	<rip>, %rdi      # <addr>
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	leaq	-0x200(%rbp), %rcx
               	leaq	<rip>, %rdx      # <addr>
               	leaq	-0x100(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x2b0(%rbp), %rdx
               	leaq	0xa0(%rdx), %rdi
               	leaq	-0xf0(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdi), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0x9, %eax
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdx, %rsi
               	leaq	-0xe0(%rbp), %rdi
               	movdqu	(%rsi), %xmm14
               	aesimc	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	leaq	-0xe0(%rbp), %rsi
               	leaq	-0xd0(%rbp), %rdi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	aesdec	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	leaq	-0xd0(%rbp), %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	decq	%rax
               	testl	%eax, %eax
               	jg	<addr>
               	leaq	-0x200(%rbp), %r9
               	leaq	-0x2b0(%rbp), %rcx
               	leaq	-0xc0(%rbp), %rax
               	movdqu	(%r9), %xmm15
               	movdqu	(%rcx), %xmm14
               	aesdeclast	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	<rip>, %rdi      # <addr>
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x720, %rsp            # imm = 0x720
               	leaq	-0x720(%rbp), %rax
               	movl	$0x1, -0x720(%rbp)
               	movl	$0x2, -0x71c(%rbp)
               	movl	$0x3, -0x718(%rbp)
               	movl	$0x4, -0x714(%rbp)
               	leaq	-0x710(%rbp), %rdx
               	movl	$0x64, -0x710(%rbp)
               	movl	$0xc8, -0x70c(%rbp)
               	movl	$0x12c, -0x708(%rbp)    # imm = 0x12C
               	movl	$0x190, -0x704(%rbp)    # imm = 0x190
               	leaq	-0x58(%rbp), %rsi
               	leaq	-0x6f0(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	paddd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	movl	-0x58(%rbp), %ecx
               	xorq	$0x65, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	-0x54(%rbp), %ecx
               	xorq	$0xca, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	-0x50(%rbp), %ecx
               	xorq	$0x12f, %rcx            # imm = 0x12F
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x4c(%rbp), %ecx
               	xorq	$0x194, %rcx            # imm = 0x194
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x720(%rbp), %rsi
               	leaq	-0x710(%rbp), %rdi
               	leaq	-0x6e0(%rbp), %rcx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rdi), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rax
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movl	-0x58(%rbp), %ecx
               	cmpl	$0x65, %ecx
               	jne	<addr>
               	movl	-0x4c(%rbp), %ecx
               	cmpl	$0x194, %ecx            # imm = 0x194
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x58(%rbp), %rdx
               	leaq	-0x720(%rbp), %rsi
               	leaq	-0x710(%rbp), %rdi
               	leaq	-0x6d0(%rbp), %rcx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rdi), %xmm14
               	por	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movl	-0x54(%rbp), %eax
               	cmpl	$0xca, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x58(%rbp), %rdx
               	leaq	-0x720(%rbp), %rcx
               	leaq	-0x710(%rbp), %rsi
               	leaq	-0x6c0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pand	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	cmpl	$0x0, -0x50(%rbp)
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0xffffffff, -0x720(%rbp) # imm = 0xFFFFFFFF
               	movl	$0x0, -0x71c(%rbp)
               	movl	$0xffffffff, -0x718(%rbp) # imm = 0xFFFFFFFF
               	movl	$0x0, -0x714(%rbp)
               	movl	$0x1, -0x710(%rbp)
               	movl	$0x0, -0x70c(%rbp)
               	movl	$0x0, -0x708(%rbp)
               	movl	$0x0, -0x704(%rbp)
               	leaq	-0x58(%rbp), %rcx
               	leaq	-0x720(%rbp), %rax
               	leaq	-0x710(%rbp), %rsi
               	leaq	-0x6b0(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rsi), %xmm14
               	paddd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x80(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	cmpl	$0x0, -0x58(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x54(%rbp)
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x720(%rbp), %rdx
               	leaq	-0x710(%rbp), %rsi
               	leaq	-0x6a0(%rbp), %rdi
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rsi), %xmm14
               	paddq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rax
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x58(%rbp), %rdi
               	cmpl	$0x0, -0x58(%rbp)
               	jne	<addr>
               	movl	-0x54(%rbp), %ecx
               	xorq	$0x1, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x690(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rsi), %xmm14
               	paddq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x710(%rbp), %rsi
               	leaq	-0x680(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	psubq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdi)
               	movl	-0x58(%rbp), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	jne	<addr>
               	leaq	-0x58(%rbp), %rcx
               	cmpl	$0x0, -0x54(%rbp)
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x720(%rbp), %rax
               	movl	$0xddeeff00, -0x720(%rbp) # imm = 0xDDEEFF00
               	movl	$0x99aabbcc, -0x71c(%rbp) # imm = 0x99AABBCC
               	movl	$0x55667788, -0x718(%rbp) # imm = 0x55667788
               	movl	$0x11223344, -0x714(%rbp) # imm = 0x11223344
               	leaq	-0x670(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	pslld	$0x4, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x80(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	movl	-0x4c(%rbp), %edx
               	cmpl	$0x12233440, %edx       # imm = 0x12233440
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x720(%rbp), %rdx
               	leaq	-0x660(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	psrld	$0x4, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x58(%rbp), %rcx
               	movl	-0x4c(%rbp), %eax
               	cmpl	$0x1122334, %eax        # imm = 0x1122334
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x8, %eax
               	leaq	-0x650(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	movq	%rax, %xmm14
               	psrld	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x80(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	movl	-0x4c(%rbp), %edx
               	cmpl	$0x112233, %edx         # imm = 0x112233
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	leaq	-0x720(%rbp), %rdx
               	leaq	-0x640(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	psrld	$0x20, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x58(%rbp), %rcx
               	cmpl	$0x0, -0x58(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x4c(%rbp)
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	leaq	-0x630(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	psllq	$0x8, %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x80(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	movl	-0x58(%rbp), %edx
               	movl	$0xeeff0000, %r11d      # imm = 0xEEFF0000
               	cmpl	%r11d, %edx
               	jne	<addr>
               	movl	-0x54(%rbp), %edx
               	movl	$0xaabbccdd, %r11d      # imm = 0xAABBCCDD
               	cmpl	%r11d, %edx
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	-0x720(%rbp), %rdx
               	leaq	-0x620(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	psrlq	$0x8, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rax
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x58(%rbp), %rsi
               	movl	-0x58(%rbp), %ecx
               	movl	$0xccddeeff, %r11d      # imm = 0xCCDDEEFF
               	cmpl	%r11d, %ecx
               	jne	<addr>
               	movl	-0x54(%rbp), %ecx
               	cmpl	$0x99aabb, %ecx         # imm = 0x99AABB
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	-0x610(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	cmpl	$0x0, -0x58(%rbp)
               	jne	<addr>
               	movl	-0x54(%rbp), %eax
               	movl	$0xddeeff00, %r11d      # imm = 0xDDEEFF00
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	leaq	-0x720(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movb	$0x0, -0x720(%rbp)
               	movb	$0x1, -0x71f(%rbp)
               	movb	$0x2, -0x71e(%rbp)
               	movb	$0x3, -0x71d(%rbp)
               	movb	$0x4, -0x71c(%rbp)
               	movb	$0x5, -0x71b(%rbp)
               	movb	$0x6, -0x71a(%rbp)
               	movb	$0x7, -0x719(%rbp)
               	movb	$0x8, -0x718(%rbp)
               	movb	$0x9, -0x717(%rbp)
               	movb	$0xa, -0x716(%rbp)
               	movb	$0xb, -0x715(%rbp)
               	movb	$0xc, -0x714(%rbp)
               	movb	$0xd, -0x713(%rbp)
               	movb	$0xe, -0x712(%rbp)
               	movb	$0xf, -0x711(%rbp)
               	leaq	-0x68(%rbp), %rdx
               	leaq	-0x720(%rbp), %rcx
               	leaq	-0x600(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	psllw	$0x8, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	cmpb	$0x0, -0x68(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x67(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x66(%rbp)
               	jne	<addr>
               	movzbq	-0x65(%rbp), %rax
               	xorq	$0x2, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	-0x68(%rbp), %rcx
               	leaq	-0x720(%rbp), %rdx
               	leaq	-0x5f0(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	psrlw	$0x8, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x80(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rcx)
               	movzbq	-0x68(%rbp), %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpb	$0x0, -0x67(%rbp)
               	jne	<addr>
               	movzbq	-0x66(%rbp), %rax
               	xorq	$0x3, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	leaq	-0x720(%rbp), %rdx
               	leaq	-0x5e0(%rbp), %rsi
               	movdqu	(%rdx), %xmm14
               	pshuflw	$0x1b, %xmm14, %xmm15   # xmm15 = xmm14[3,2,1,0,4,5,6,7]
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x80(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x68(%rbp), %rsi
               	movzbq	-0x68(%rbp), %rcx
               	xorq	$0x6, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	-0x67(%rbp), %rcx
               	xorq	$0x7, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpb	$0x0, -0x62(%rbp)
               	jne	<addr>
               	movzbq	-0x61(%rbp), %rcx
               	xorq	$0x1, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	-0x60(%rbp), %rcx
               	xorq	$0x8, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	leaq	-0x5d0(%rbp), %rcx
               	movdqu	(%rdx), %xmm14
               	pshufhw	$0x1b, %xmm14, %xmm15   # xmm15 = xmm14[0,1,2,3,7,6,5,4]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rax
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	cmpb	$0x0, -0x68(%rbp)
               	jne	<addr>
               	movzbq	-0x60(%rbp), %rcx
               	xorq	$0xe, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	-0x5f(%rbp), %rcx
               	xorq	$0xf, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	-0x5a(%rbp), %rcx
               	xorq	$0x8, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	-0x59(%rbp), %rcx
               	xorq	$0x9, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	leaq	-0x720(%rbp), %rdx
               	movl	$0x0, -0x720(%rbp)
               	movl	$0x1, -0x71c(%rbp)
               	movl	$0x2, -0x718(%rbp)
               	movl	$0x3, -0x714(%rbp)
               	leaq	-0x58(%rbp), %rsi
               	leaq	-0x5c0(%rbp), %rcx
               	movdqu	(%rdx), %xmm14
               	pshufd	$0x93, %xmm14, %xmm15   # xmm15 = xmm14[3,0,1,2]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	movl	-0x58(%rbp), %eax
               	xorq	$0x3, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, -0x54(%rbp)
               	jne	<addr>
               	movl	-0x50(%rbp), %eax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	-0x4c(%rbp), %eax
               	xorq	$0x2, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	leaq	-0x720(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movb	$0x0, -0x720(%rbp)
               	movb	$0x1, -0x71f(%rbp)
               	movb	$0x2, -0x71e(%rbp)
               	movb	$0x3, -0x71d(%rbp)
               	movb	$0x4, -0x71c(%rbp)
               	movb	$0x5, -0x71b(%rbp)
               	movb	$0x6, -0x71a(%rbp)
               	movb	$0x7, -0x719(%rbp)
               	movb	$0x8, -0x718(%rbp)
               	movb	$0x9, -0x717(%rbp)
               	movb	$0xa, -0x716(%rbp)
               	movb	$0xb, -0x715(%rbp)
               	movb	$0xc, -0x714(%rbp)
               	movb	$0xd, -0x713(%rbp)
               	movb	$0xe, -0x712(%rbp)
               	movb	$0xf, -0x711(%rbp)
               	leaq	-0x710(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movb	$0xf, -0x710(%rbp)
               	movb	$0xe, -0x70f(%rbp)
               	movb	$0xd, -0x70e(%rbp)
               	movb	$0xc, -0x70d(%rbp)
               	movb	$0xb, -0x70c(%rbp)
               	movb	$0xa, -0x70b(%rbp)
               	movb	$0x9, -0x70a(%rbp)
               	movb	$0x8, -0x709(%rbp)
               	movb	$0x7, -0x708(%rbp)
               	movb	$0x6, -0x707(%rbp)
               	movb	$0x5, -0x706(%rbp)
               	movb	$0x4, -0x705(%rbp)
               	movb	$0x3, -0x704(%rbp)
               	movb	$0x2, -0x703(%rbp)
               	movb	$0x1, -0x702(%rbp)
               	movb	$-0x80, -0x701(%rbp)
               	leaq	-0x68(%rbp), %rdx
               	leaq	-0x720(%rbp), %rcx
               	leaq	-0x710(%rbp), %rsi
               	leaq	-0x5b0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pshufb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movzbq	-0x68(%rbp), %rax
               	xorq	$0xf, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	-0x5a(%rbp), %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpb	$0x0, -0x59(%rbp)
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	leaq	-0x720(%rbp), %rdx
               	movl	$0x1, -0x720(%rbp)
               	movl	$0x1, -0x71c(%rbp)
               	movl	$0x9, -0x718(%rbp)
               	movl	$0x9, -0x714(%rbp)
               	leaq	-0x710(%rbp), %rsi
               	movl	$0x2, -0x710(%rbp)
               	movl	$0x2, -0x70c(%rbp)
               	movl	$0x8, -0x708(%rbp)
               	movl	$0x8, -0x704(%rbp)
               	leaq	-0x58(%rbp), %rdi
               	leaq	-0x5a0(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rsi), %xmm14
               	punpcklqdq	%xmm14, %xmm15  # xmm15 = xmm15[0],xmm14[0]
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdi)
               	movl	-0x58(%rbp), %ecx
               	xorq	$0x1, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	-0x54(%rbp), %ecx
               	xorq	$0x1, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	-0x50(%rbp), %ecx
               	xorq	$0x2, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	-0x58(%rbp), %rsi
               	movl	-0x4c(%rbp), %ecx
               	xorq	$0x2, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	leaq	-0x720(%rbp), %rcx
               	leaq	-0x590(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rcx), %xmm14
               	pcmpeqq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rax
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	movl	-0x58(%rbp), %ecx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %ecx
               	jne	<addr>
               	movl	-0x4c(%rbp), %ecx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %ecx
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	leaq	-0x58(%rbp), %rdx
               	leaq	-0x720(%rbp), %rsi
               	leaq	-0x710(%rbp), %rdi
               	leaq	-0x580(%rbp), %rcx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rdi), %xmm14
               	pcmpeqq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdx)
               	cmpl	$0x0, -0x58(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x4c(%rbp)
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	leaq	-0x720(%rbp), %rax
               	movl	$0x11112222, -0x720(%rbp) # imm = 0x11112222
               	movl	$0x33334444, -0x71c(%rbp) # imm = 0x33334444
               	movl	$0x55556666, -0x718(%rbp) # imm = 0x55556666
               	movl	$0x77778888, -0x714(%rbp) # imm = 0x77778888
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pextrw	$0x0, %xmm14, %r11d
               	movl	%r11d, (%rcx)
               	movl	-0x20(%rbp), %ecx
               	cmpl	$0x2222, %ecx           # imm = 0x2222
               	jne	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pextrw	$0x7, %xmm14, %r11d
               	movl	%r11d, (%rcx)
               	movl	-0x18(%rbp), %ecx
               	cmpl	$0x7777, %ecx           # imm = 0x7777
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pextrd	$0x2, %xmm14, %r11d
               	movl	%r11d, (%rcx)
               	movl	-0x10(%rbp), %eax
               	cmpl	$0x55556666, %eax       # imm = 0x55556666
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	leaq	-0x58(%rbp), %rdx
               	leaq	-0x720(%rbp), %rcx
               	movl	$0xa0b0c0d, %esi        # imm = 0xA0B0C0D
               	leaq	-0x570(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	pinsrd	$0x1, %esi, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movl	-0x54(%rbp), %eax
               	cmpl	$0xa0b0c0d, %eax        # imm = 0xA0B0C0D
               	jne	<addr>
               	movl	-0x58(%rbp), %eax
               	cmpl	$0x11112222, %eax       # imm = 0x11112222
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	movq	$0x3, -0x720(%rbp)
               	movq	$0x0, -0x718(%rbp)
               	leaq	-0x710(%rbp), %rdi
               	movq	$0x0, -0x710(%rbp)
               	movq	$0x3, -0x708(%rbp)
               	leaq	-0x720(%rbp), %rcx
               	leaq	-0x560(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rcx), %xmm14
               	pclmulqdq	$0x0, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x80(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x58(%rbp), %rsi
               	movl	-0x58(%rbp), %edx
               	xorq	$0x5, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	cmpl	$0x0, -0x54(%rbp)
               	je	<addr>
               	movl	$0x1b, %eax
               	leave
               	retq
               	leaq	-0x550(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdi), %xmm14
               	pclmulqdq	$0x10, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	movl	-0x58(%rbp), %eax
               	xorq	$0x5, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1c, %eax
               	leave
               	retq
               	movl	$0x1, -0x720(%rbp)
               	movl	$0x2, -0x71c(%rbp)
               	movl	$0x3, -0x718(%rbp)
               	movl	$0x4, -0x714(%rbp)
               	movl	$0x5, -0x710(%rbp)
               	movl	$0x6, -0x70c(%rbp)
               	movl	$0x7, -0x708(%rbp)
               	movl	$0x8, -0x704(%rbp)
               	leaq	-0x540(%rbp), %rax
               	movups	-0x720(%rbp), %xmm0
               	movups	%xmm0, -0x540(%rbp)
               	leaq	-0x530(%rbp), %rcx
               	movups	-0x710(%rbp), %xmm0
               	movups	%xmm0, -0x530(%rbp)
               	leaq	-0x520(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	shufpd	$0x1, %xmm14, %xmm15    # xmm15 = xmm15[1],xmm14[0]
               	movdqu	%xmm15, (%rdx)
               	movups	-0x520(%rbp), %xmm0
               	leaq	-0x58(%rbp), %rax
               	leaq	-0x80(%rbp), %rcx
               	movups	%xmm0, -0x80(%rbp)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	-0x58(%rbp), %ecx
               	xorq	$0x3, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	-0x54(%rbp), %ecx
               	xorq	$0x4, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	-0x50(%rbp), %ecx
               	xorq	$0x5, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	-0x4c(%rbp), %ecx
               	xorq	$0x6, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1d, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rdx
               	movq	$0x0, -0x80(%rbp)
               	movq	$0x0, -0x78(%rbp)
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rax)
               	cmpl	$0x0, -0x58(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x54(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x50(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x4c(%rbp)
               	je	<addr>
               	movl	$0x1e, %eax
               	leave
               	retq
               	movb	$0x1, -0x68(%rbp)
               	movb	$0x8, -0x67(%rbp)
               	movb	$0xf, -0x66(%rbp)
               	movb	$0x16, -0x65(%rbp)
               	movb	$0x1d, -0x64(%rbp)
               	movb	$0x24, -0x63(%rbp)
               	movb	$0x2b, -0x62(%rbp)
               	movb	$0x32, -0x61(%rbp)
               	movb	$0x39, -0x60(%rbp)
               	movb	$0x40, -0x5f(%rbp)
               	movb	$0x47, -0x5e(%rbp)
               	movb	$0x4e, -0x5d(%rbp)
               	movb	$0x55, -0x5c(%rbp)
               	movb	$0x5c, -0x5b(%rbp)
               	leaq	-0x68(%rbp), %rdi
               	movb	$0x63, -0x5a(%rbp)
               	movb	$0x6a, -0x59(%rbp)
               	callq	<addr>
               	movups	%xmm0, -0x510(%rbp)
               	leaq	-0x510(%rbp), %rax
               	leaq	-0x720(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x68(%rbp), %rcx
               	movq	$0x0, -0x68(%rbp)
               	movq	$0x0, -0x60(%rbp)
               	leaq	-0x720(%rbp), %rdx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	movzbq	-0x68(%rbp), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1f, %eax
               	leave
               	retq
               	movzbq	-0x67(%rbp), %rax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movzbq	-0x66(%rbp), %rax
               	cmpl	$0xf, %eax
               	jne	<addr>
               	movzbq	-0x65(%rbp), %rax
               	cmpl	$0x16, %eax
               	jne	<addr>
               	movzbq	-0x64(%rbp), %rax
               	cmpl	$0x1d, %eax
               	jne	<addr>
               	movzbq	-0x63(%rbp), %rax
               	cmpl	$0x24, %eax
               	jne	<addr>
               	movzbq	-0x62(%rbp), %rax
               	cmpl	$0x2b, %eax
               	jne	<addr>
               	movzbq	-0x61(%rbp), %rax
               	cmpl	$0x32, %eax
               	jne	<addr>
               	movzbq	-0x60(%rbp), %rax
               	cmpl	$0x39, %eax
               	jne	<addr>
               	movzbq	-0x5f(%rbp), %rax
               	cmpl	$0x40, %eax
               	jne	<addr>
               	movzbq	-0x5e(%rbp), %rax
               	cmpl	$0x47, %eax
               	jne	<addr>
               	movzbq	-0x5d(%rbp), %rax
               	cmpl	$0x4e, %eax
               	jne	<addr>
               	movzbq	-0x5c(%rbp), %rax
               	cmpl	$0x55, %eax
               	jne	<addr>
               	movzbq	-0x5b(%rbp), %rax
               	cmpl	$0x5c, %eax
               	jne	<addr>
               	movzbq	-0x5a(%rbp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	-0x59(%rbp), %rax
               	cmpl	$0x6a, %eax
               	jne	<addr>
               	leaq	-0x510(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movw	$0x0, -0x510(%rbp)
               	movw	$0x1, -0x50e(%rbp)
               	movw	$0x2, -0x50c(%rbp)
               	movw	$0x3, -0x50a(%rbp)
               	leaq	-0x510(%rbp), %r9
               	movw	$0x4, -0x508(%rbp)
               	movw	$0x5, -0x506(%rbp)
               	movw	$0x6, -0x504(%rbp)
               	movw	$0x7, -0x502(%rbp)
               	leaq	<rip>, %rdi      # <addr>
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x21, %eax
               	leave
               	retq
               	leaq	-0x510(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movw	$0x7, -0x510(%rbp)
               	movw	$0x6, -0x50e(%rbp)
               	movw	$0x5, -0x50c(%rbp)
               	movw	$0x4, -0x50a(%rbp)
               	movw	$0x3, -0x508(%rbp)
               	movw	$0x2, -0x506(%rbp)
               	movw	$0x1, -0x504(%rbp)
               	movw	$0x0, -0x502(%rbp)
               	leaq	-0x510(%rbp), %r9
               	leaq	<rip>, %rdi      # <addr>
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x22, %eax
               	leave
               	retq
               	leaq	-0x510(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movb	$0x0, -0x510(%rbp)
               	movb	$0x1, -0x50f(%rbp)
               	movb	$0x2, -0x50e(%rbp)
               	movb	$0x3, -0x50d(%rbp)
               	movb	$0x4, -0x50c(%rbp)
               	movb	$0x5, -0x50b(%rbp)
               	movb	$0x6, -0x50a(%rbp)
               	movb	$0x7, -0x509(%rbp)
               	movb	$0x8, -0x508(%rbp)
               	movb	$0x9, -0x507(%rbp)
               	leaq	-0x510(%rbp), %r9
               	movb	$0xa, -0x506(%rbp)
               	movb	$0xb, -0x505(%rbp)
               	movb	$0xc, -0x504(%rbp)
               	movb	$0xd, -0x503(%rbp)
               	movb	$0xe, -0x502(%rbp)
               	movb	$0xf, -0x501(%rbp)
               	leaq	<rip>, %rdi      # <addr>
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x23, %eax
               	leave
               	retq
               	leaq	-0x510(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movb	$0xf, -0x510(%rbp)
               	movb	$0xe, -0x50f(%rbp)
               	movb	$0xd, -0x50e(%rbp)
               	movb	$0xc, -0x50d(%rbp)
               	movb	$0xb, -0x50c(%rbp)
               	movb	$0xa, -0x50b(%rbp)
               	movb	$0x9, -0x50a(%rbp)
               	movb	$0x8, -0x509(%rbp)
               	movb	$0x7, -0x508(%rbp)
               	movb	$0x6, -0x507(%rbp)
               	movb	$0x5, -0x506(%rbp)
               	movb	$0x4, -0x505(%rbp)
               	movb	$0x3, -0x504(%rbp)
               	movb	$0x2, -0x503(%rbp)
               	movb	$0x1, -0x502(%rbp)
               	movb	$0x0, -0x501(%rbp)
               	leaq	-0x510(%rbp), %r9
               	leaq	<rip>, %rdi      # <addr>
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x24, %eax
               	leave
               	retq
               	leaq	-0x58(%rbp), %rax
               	leaq	-0x80(%rbp), %r8
               	movl	$0x1, -0x80(%rbp)
               	movl	$0x2, -0x7c(%rbp)
               	movl	$0x3, -0x78(%rbp)
               	movl	$0x4, -0x74(%rbp)
               	movdqu	(%r8), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	-0x58(%rbp), %eax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x58(%rbp), %rcx
               	movl	-0x4c(%rbp), %eax
               	xorq	$0x4, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x25, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rdx
               	movl	$0x11223344, -0x80(%rbp) # imm = 0x11223344
               	movl	$0x11223344, -0x7c(%rbp) # imm = 0x11223344
               	movl	$0x11223344, -0x78(%rbp) # imm = 0x11223344
               	movl	$0x11223344, -0x74(%rbp) # imm = 0x11223344
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rcx)
               	movl	-0x58(%rbp), %eax
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	jne	<addr>
               	movl	-0x4c(%rbp), %eax
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	je	<addr>
               	movl	$0x26, %eax
               	leave
               	retq
               	leaq	-0x510(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movw	$0x1234, -0x510(%rbp)   # imm = 0x1234
               	movw	$0x1234, -0x50e(%rbp)   # imm = 0x1234
               	movw	$0x1234, -0x50c(%rbp)   # imm = 0x1234
               	movw	$0x1234, -0x50a(%rbp)   # imm = 0x1234
               	movw	$0x1234, -0x508(%rbp)   # imm = 0x1234
               	leaq	-0x510(%rbp), %rdx
               	movw	$0x1234, -0x506(%rbp)   # imm = 0x1234
               	movw	$0x1234, -0x504(%rbp)   # imm = 0x1234
               	movw	$0x1234, -0x502(%rbp)   # imm = 0x1234
               	leaq	-0x80(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x58(%rbp), %rcx
               	movl	-0x58(%rbp), %eax
               	cmpl	$0x12341234, %eax       # imm = 0x12341234
               	jne	<addr>
               	movl	-0x4c(%rbp), %eax
               	cmpl	$0x12341234, %eax       # imm = 0x12341234
               	je	<addr>
               	movl	$0x27, %eax
               	leave
               	retq
               	leaq	-0x510(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movb	$0x5a, -0x510(%rbp)
               	movb	$0x5a, -0x50f(%rbp)
               	movb	$0x5a, -0x50e(%rbp)
               	movb	$0x5a, -0x50d(%rbp)
               	movb	$0x5a, -0x50c(%rbp)
               	movb	$0x5a, -0x50b(%rbp)
               	movb	$0x5a, -0x50a(%rbp)
               	movb	$0x5a, -0x509(%rbp)
               	movb	$0x5a, -0x508(%rbp)
               	movb	$0x5a, -0x507(%rbp)
               	movb	$0x5a, -0x506(%rbp)
               	leaq	-0x510(%rbp), %rdx
               	movb	$0x5a, -0x505(%rbp)
               	movb	$0x5a, -0x504(%rbp)
               	movb	$0x5a, -0x503(%rbp)
               	movb	$0x5a, -0x502(%rbp)
               	movb	$0x5a, -0x501(%rbp)
               	leaq	-0x80(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x58(%rbp), %ecx
               	cmpl	$0x5a5a5a5a, %ecx       # imm = 0x5A5A5A5A
               	jne	<addr>
               	movl	-0x4c(%rbp), %ecx
               	cmpl	$0x5a5a5a5a, %ecx       # imm = 0x5A5A5A5A
               	je	<addr>
               	movl	$0x28, %eax
               	leave
               	retq
               	movabsq	$0x123456789abcdef, %rcx # imm = 0x123456789ABCDEF
               	movq	%rcx, -0x80(%rbp)
               	movq	%rcx, -0x78(%rbp)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movl	-0x58(%rbp), %eax
               	movl	$0x89abcdef, %r11d      # imm = 0x89ABCDEF
               	cmpl	%r11d, %eax
               	jne	<addr>
               	movl	-0x54(%rbp), %eax
               	cmpl	$0x1234567, %eax        # imm = 0x1234567
               	jne	<addr>
               	leaq	-0x58(%rbp), %rdi
               	movl	-0x4c(%rbp), %eax
               	cmpl	$0x1234567, %eax        # imm = 0x1234567
               	je	<addr>
               	movl	$0x29, %eax
               	leave
               	retq
               	leaq	-0x720(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movb	$-0x1, -0x720(%rbp)
               	movb	$-0x1, -0x71f(%rbp)
               	movb	$-0x1, -0x71e(%rbp)
               	movb	$-0x1, -0x71d(%rbp)
               	movb	$-0x1, -0x71c(%rbp)
               	movb	$-0x1, -0x71b(%rbp)
               	movb	$-0x1, -0x71a(%rbp)
               	movb	$-0x1, -0x719(%rbp)
               	movb	$-0x1, -0x718(%rbp)
               	movb	$-0x1, -0x717(%rbp)
               	movb	$-0x1, -0x716(%rbp)
               	movb	$-0x1, -0x715(%rbp)
               	movb	$-0x1, -0x714(%rbp)
               	movb	$-0x1, -0x713(%rbp)
               	movb	$-0x1, -0x712(%rbp)
               	movb	$-0x1, -0x711(%rbp)
               	leaq	-0x710(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movb	$0x1, -0x710(%rbp)
               	movb	$0x1, -0x70f(%rbp)
               	movb	$0x1, -0x70e(%rbp)
               	movb	$0x1, -0x70d(%rbp)
               	movb	$0x1, -0x70c(%rbp)
               	movb	$0x1, -0x70b(%rbp)
               	movb	$0x1, -0x70a(%rbp)
               	movb	$0x1, -0x709(%rbp)
               	movb	$0x1, -0x708(%rbp)
               	movb	$0x1, -0x707(%rbp)
               	movb	$0x1, -0x706(%rbp)
               	movb	$0x1, -0x705(%rbp)
               	movb	$0x1, -0x704(%rbp)
               	movb	$0x1, -0x703(%rbp)
               	movb	$0x1, -0x702(%rbp)
               	movb	$0x1, -0x701(%rbp)
               	leaq	-0x500(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rcx), %xmm14
               	paddb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x80(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdi)
               	cmpl	$0x0, -0x58(%rbp)
               	jne	<addr>
               	leaq	-0x58(%rbp), %rdi
               	cmpl	$0x0, -0x4c(%rbp)
               	je	<addr>
               	movl	$0x2a, %eax
               	leave
               	retq
               	leaq	-0x4f0(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x4e0(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rcx), %xmm14
               	psubb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdi)
               	movl	-0x58(%rbp), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x2b, %eax
               	leave
               	retq
               	leaq	-0x720(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0xffff, -0x720(%rbp)   # imm = 0xFFFF
               	movw	$0xffff, -0x71e(%rbp)   # imm = 0xFFFF
               	movw	$0xffff, -0x71c(%rbp)   # imm = 0xFFFF
               	movw	$0xffff, -0x71a(%rbp)   # imm = 0xFFFF
               	movw	$0xffff, -0x718(%rbp)   # imm = 0xFFFF
               	movw	$0xffff, -0x716(%rbp)   # imm = 0xFFFF
               	movw	$0xffff, -0x714(%rbp)   # imm = 0xFFFF
               	movw	$0xffff, -0x712(%rbp)   # imm = 0xFFFF
               	leaq	-0x58(%rbp), %rdx
               	leaq	-0x4d0(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movw	$0x1, -0x4d0(%rbp)
               	movw	$0x1, -0x4ce(%rbp)
               	movw	$0x1, -0x4cc(%rbp)
               	movw	$0x1, -0x4ca(%rbp)
               	leaq	-0x4d0(%rbp), %rsi
               	movw	$0x1, -0x4c8(%rbp)
               	movw	$0x1, -0x4c6(%rbp)
               	movw	$0x1, -0x4c4(%rbp)
               	movw	$0x1, -0x4c2(%rbp)
               	leaq	-0x4c0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	paddw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x58(%rbp), %rdx
               	cmpl	$0x0, -0x58(%rbp)
               	je	<addr>
               	movl	$0x2c, %eax
               	leave
               	retq
               	leaq	-0x4b0(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x4a0(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movw	$0x1, -0x4a0(%rbp)
               	movw	$0x1, -0x49e(%rbp)
               	movw	$0x1, -0x49c(%rbp)
               	movw	$0x1, -0x49a(%rbp)
               	leaq	-0x4a0(%rbp), %rsi
               	movw	$0x1, -0x498(%rbp)
               	movw	$0x1, -0x496(%rbp)
               	movw	$0x1, -0x494(%rbp)
               	movw	$0x1, -0x492(%rbp)
               	leaq	-0x490(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	psubw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x58(%rbp), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x2d, %eax
               	leave
               	retq
               	leaq	-0x480(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0x5, -0x480(%rbp)
               	movl	$0x5, -0x47c(%rbp)
               	movl	$0x5, -0x478(%rbp)
               	movl	$0x5, -0x474(%rbp)
               	leaq	-0x470(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movl	$0x7, -0x470(%rbp)
               	movl	$0x7, -0x46c(%rbp)
               	movl	$0x7, -0x468(%rbp)
               	movl	$0x7, -0x464(%rbp)
               	leaq	-0x470(%rbp), %rsi
               	leaq	-0x460(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	psubd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x58(%rbp), %eax
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x2e, %eax
               	leave
               	retq
               	leaq	-0x450(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0x1234, -0x450(%rbp)   # imm = 0x1234
               	movw	$0x1234, -0x44e(%rbp)   # imm = 0x1234
               	movw	$0x1234, -0x44c(%rbp)   # imm = 0x1234
               	movw	$0x1234, -0x44a(%rbp)   # imm = 0x1234
               	movw	$0x1234, -0x448(%rbp)   # imm = 0x1234
               	leaq	-0x450(%rbp), %rcx
               	movw	$0x1234, -0x446(%rbp)   # imm = 0x1234
               	movw	$0x1234, -0x444(%rbp)   # imm = 0x1234
               	movw	$0x1234, -0x442(%rbp)   # imm = 0x1234
               	leaq	-0x440(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movw	$0x3, -0x440(%rbp)
               	movw	$0x3, -0x43e(%rbp)
               	movw	$0x3, -0x43c(%rbp)
               	movw	$0x3, -0x43a(%rbp)
               	leaq	-0x440(%rbp), %rsi
               	movw	$0x3, -0x438(%rbp)
               	movw	$0x3, -0x436(%rbp)
               	movw	$0x3, -0x434(%rbp)
               	movw	$0x3, -0x432(%rbp)
               	leaq	-0x430(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pmullw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x58(%rbp), %eax
               	cmpl	$0x369c369c, %eax       # imm = 0x369C369C
               	je	<addr>
               	movl	$0x2f, %eax
               	leave
               	retq
               	leaq	-0x420(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0xf000, -0x420(%rbp)   # imm = 0xF000
               	movw	$0xf000, -0x41e(%rbp)   # imm = 0xF000
               	movw	$0xf000, -0x41c(%rbp)   # imm = 0xF000
               	movw	$0xf000, -0x41a(%rbp)   # imm = 0xF000
               	movw	$0xf000, -0x418(%rbp)   # imm = 0xF000
               	leaq	-0x420(%rbp), %rcx
               	movw	$0xf000, -0x416(%rbp)   # imm = 0xF000
               	movw	$0xf000, -0x414(%rbp)   # imm = 0xF000
               	movw	$0xf000, -0x412(%rbp)   # imm = 0xF000
               	leaq	-0x410(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movw	$0x10, -0x410(%rbp)
               	movw	$0x10, -0x40e(%rbp)
               	movw	$0x10, -0x40c(%rbp)
               	movw	$0x10, -0x40a(%rbp)
               	leaq	-0x410(%rbp), %rsi
               	movw	$0x10, -0x408(%rbp)
               	movw	$0x10, -0x406(%rbp)
               	movw	$0x10, -0x404(%rbp)
               	movw	$0x10, -0x402(%rbp)
               	leaq	-0x400(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pmulhw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x58(%rbp), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x30, %eax
               	leave
               	retq
               	leaq	-0x3f0(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0x1000, -0x3f0(%rbp)   # imm = 0x1000
               	movw	$0x1000, -0x3ee(%rbp)   # imm = 0x1000
               	movw	$0x1000, -0x3ec(%rbp)   # imm = 0x1000
               	movw	$0x1000, -0x3ea(%rbp)   # imm = 0x1000
               	movw	$0x1000, -0x3e8(%rbp)   # imm = 0x1000
               	leaq	-0x3f0(%rbp), %rcx
               	movw	$0x1000, -0x3e6(%rbp)   # imm = 0x1000
               	movw	$0x1000, -0x3e4(%rbp)   # imm = 0x1000
               	movw	$0x1000, -0x3e2(%rbp)   # imm = 0x1000
               	leaq	-0x3e0(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movw	$0x10, -0x3e0(%rbp)
               	movw	$0x10, -0x3de(%rbp)
               	movw	$0x10, -0x3dc(%rbp)
               	movw	$0x10, -0x3da(%rbp)
               	leaq	-0x3e0(%rbp), %rsi
               	movw	$0x10, -0x3d8(%rbp)
               	movw	$0x10, -0x3d6(%rbp)
               	movw	$0x10, -0x3d4(%rbp)
               	movw	$0x10, -0x3d2(%rbp)
               	leaq	-0x3d0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pmulhw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x58(%rbp), %eax
               	cmpl	$0x10001, %eax          # imm = 0x10001
               	je	<addr>
               	movl	$0x31, %eax
               	leave
               	retq
               	leaq	-0x720(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	$0x1, -0x720(%rbp)
               	movw	$0x2, -0x71e(%rbp)
               	movw	$0x3, -0x71c(%rbp)
               	movw	$0x4, -0x71a(%rbp)
               	movw	$0x5, -0x718(%rbp)
               	movw	$0x6, -0x716(%rbp)
               	movw	$0x7, -0x714(%rbp)
               	movw	$0x8, -0x712(%rbp)
               	leaq	-0x720(%rbp), %rcx
               	leaq	-0x3c0(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movw	$0xfffe, -0x3c0(%rbp)   # imm = 0xFFFE
               	movw	$0xfffe, -0x3be(%rbp)   # imm = 0xFFFE
               	movw	$0xfffe, -0x3bc(%rbp)   # imm = 0xFFFE
               	movw	$0xfffe, -0x3ba(%rbp)   # imm = 0xFFFE
               	leaq	-0x3c0(%rbp), %rsi
               	movw	$0xfffe, -0x3b8(%rbp)   # imm = 0xFFFE
               	movw	$0xfffe, -0x3b6(%rbp)   # imm = 0xFFFE
               	movw	$0xfffe, -0x3b4(%rbp)   # imm = 0xFFFE
               	movw	$0xfffe, -0x3b2(%rbp)   # imm = 0xFFFE
               	leaq	-0x3b0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pmaddwd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movl	-0x58(%rbp), %eax
               	movl	$0xfffffffa, %r11d      # imm = 0xFFFFFFFA
               	cmpl	%r11d, %eax
               	jne	<addr>
               	movl	-0x4c(%rbp), %eax
               	movl	$0xffffffe2, %r11d      # imm = 0xFFFFFFE2
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x32, %eax
               	leave
               	retq
               	leaq	-0x68(%rbp), %rdx
               	leaq	-0x3a0(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0x12c, -0x3a0(%rbp)    # imm = 0x12C
               	movw	$0x12c, -0x39e(%rbp)    # imm = 0x12C
               	movw	$0x12c, -0x39c(%rbp)    # imm = 0x12C
               	movw	$0x12c, -0x39a(%rbp)    # imm = 0x12C
               	movw	$0x12c, -0x398(%rbp)    # imm = 0x12C
               	leaq	-0x3a0(%rbp), %rcx
               	movw	$0x12c, -0x396(%rbp)    # imm = 0x12C
               	movw	$0x12c, -0x394(%rbp)    # imm = 0x12C
               	movw	$0x12c, -0x392(%rbp)    # imm = 0x12C
               	leaq	-0x390(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movw	$0xfed4, -0x390(%rbp)   # imm = 0xFED4
               	movw	$0xfed4, -0x38e(%rbp)   # imm = 0xFED4
               	movw	$0xfed4, -0x38c(%rbp)   # imm = 0xFED4
               	movw	$0xfed4, -0x38a(%rbp)   # imm = 0xFED4
               	leaq	-0x390(%rbp), %rsi
               	movw	$0xfed4, -0x388(%rbp)   # imm = 0xFED4
               	movw	$0xfed4, -0x386(%rbp)   # imm = 0xFED4
               	movw	$0xfed4, -0x384(%rbp)   # imm = 0xFED4
               	movw	$0xfed4, -0x382(%rbp)   # imm = 0xFED4
               	leaq	-0x380(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	packsswb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x68(%rbp), %rdx
               	movzbq	-0x68(%rbp), %rax
               	xorq	$0x7f, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	-0x61(%rbp), %rax
               	xorq	$0x7f, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	-0x60(%rbp), %rax
               	xorq	$0x80, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	-0x59(%rbp), %rax
               	xorq	$0x80, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x33, %eax
               	leave
               	retq
               	leaq	-0x370(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0x12c, -0x370(%rbp)    # imm = 0x12C
               	movw	$0x12c, -0x36e(%rbp)    # imm = 0x12C
               	movw	$0x12c, -0x36c(%rbp)    # imm = 0x12C
               	movw	$0x12c, -0x36a(%rbp)    # imm = 0x12C
               	movw	$0x12c, -0x368(%rbp)    # imm = 0x12C
               	leaq	-0x370(%rbp), %rcx
               	movw	$0x12c, -0x366(%rbp)    # imm = 0x12C
               	movw	$0x12c, -0x364(%rbp)    # imm = 0x12C
               	movw	$0x12c, -0x362(%rbp)    # imm = 0x12C
               	leaq	-0x360(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movw	$0xfffb, -0x360(%rbp)   # imm = 0xFFFB
               	movw	$0xfffb, -0x35e(%rbp)   # imm = 0xFFFB
               	movw	$0xfffb, -0x35c(%rbp)   # imm = 0xFFFB
               	movw	$0xfffb, -0x35a(%rbp)   # imm = 0xFFFB
               	leaq	-0x360(%rbp), %rsi
               	movw	$0xfffb, -0x358(%rbp)   # imm = 0xFFFB
               	movw	$0xfffb, -0x356(%rbp)   # imm = 0xFFFB
               	movw	$0xfffb, -0x354(%rbp)   # imm = 0xFFFB
               	movw	$0xfffb, -0x352(%rbp)   # imm = 0xFFFB
               	leaq	-0x350(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	packuswb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x68(%rbp), %rdx
               	movzbq	-0x68(%rbp), %rax
               	xorq	$0xff, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	-0x61(%rbp), %rax
               	xorq	$0xff, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpb	$0x0, -0x60(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x59(%rbp)
               	je	<addr>
               	movl	$0x34, %eax
               	leave
               	retq
               	leaq	-0x340(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0x11170, -0x340(%rbp)  # imm = 0x11170
               	movl	$0x11170, -0x33c(%rbp)  # imm = 0x11170
               	movl	$0x11170, -0x338(%rbp)  # imm = 0x11170
               	movl	$0x11170, -0x334(%rbp)  # imm = 0x11170
               	leaq	-0x330(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movl	$0xfffeee90, -0x330(%rbp) # imm = 0xFFFEEE90
               	movl	$0xfffeee90, -0x32c(%rbp) # imm = 0xFFFEEE90
               	movl	$0xfffeee90, -0x328(%rbp) # imm = 0xFFFEEE90
               	movl	$0xfffeee90, -0x324(%rbp) # imm = 0xFFFEEE90
               	leaq	-0x330(%rbp), %rsi
               	leaq	-0x320(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	packssdw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x68(%rbp), %rsi
               	movzbq	-0x68(%rbp), %rax
               	xorq	$0xff, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	-0x67(%rbp), %rax
               	xorq	$0x7f, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpb	$0x0, -0x60(%rbp)
               	jne	<addr>
               	movzbq	-0x5f(%rbp), %rax
               	xorq	$0x80, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x35, %eax
               	leave
               	retq
               	leaq	-0x720(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movb	$0x0, -0x720(%rbp)
               	movb	$0x1, -0x71f(%rbp)
               	movb	$0x2, -0x71e(%rbp)
               	movb	$0x3, -0x71d(%rbp)
               	movb	$0x4, -0x71c(%rbp)
               	movb	$0x5, -0x71b(%rbp)
               	movb	$0x6, -0x71a(%rbp)
               	movb	$0x7, -0x719(%rbp)
               	movb	$0x8, -0x718(%rbp)
               	movb	$0x9, -0x717(%rbp)
               	movb	$0xa, -0x716(%rbp)
               	movb	$0xb, -0x715(%rbp)
               	movb	$0xc, -0x714(%rbp)
               	movb	$0xd, -0x713(%rbp)
               	movb	$0xe, -0x712(%rbp)
               	movb	$0xf, -0x711(%rbp)
               	leaq	-0x720(%rbp), %rcx
               	leaq	-0x310(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x300(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	punpcklbw	%xmm14, %xmm15  # xmm15 = xmm15[0],xmm14[0],xmm15[1],xmm14[1],xmm15[2],xmm14[2],xmm15[3],xmm14[3],xmm15[4],xmm14[4],xmm15[5],xmm14[5],xmm15[6],xmm14[6],xmm15[7],xmm14[7]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x80(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x68(%rbp), %rdi
               	cmpb	$0x0, -0x68(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x67(%rbp)
               	jne	<addr>
               	movzbq	-0x66(%rbp), %rdx
               	xorq	$0x1, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	-0x5a(%rbp), %rdx
               	xorq	$0x7, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	cmpb	$0x0, -0x59(%rbp)
               	je	<addr>
               	movl	$0x36, %eax
               	leave
               	retq
               	leaq	-0x2f0(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x2e0(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	punpckhbw	%xmm14, %xmm15  # xmm15 = xmm15[8],xmm14[8],xmm15[9],xmm14[9],xmm15[10],xmm14[10],xmm15[11],xmm14[11],xmm15[12],xmm14[12],xmm15[13],xmm14[13],xmm15[14],xmm14[14],xmm15[15],xmm14[15]
               	movdqu	%xmm15, (%rsi)
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rax
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdi)
               	leaq	-0x68(%rbp), %rsi
               	movzbq	-0x68(%rbp), %rcx
               	xorq	$0x8, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpb	$0x0, -0x67(%rbp)
               	jne	<addr>
               	movzbq	-0x5a(%rbp), %rcx
               	xorq	$0xf, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpb	$0x0, -0x59(%rbp)
               	je	<addr>
               	movl	$0x37, %eax
               	leave
               	retq
               	leaq	-0x720(%rbp), %rdi
               	leaq	-0x2d0(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x2c0(%rbp), %rdx
               	movdqu	(%rdi), %xmm15
               	movdqu	(%rcx), %xmm14
               	punpcklwd	%xmm14, %xmm15  # xmm15 = xmm15[0],xmm14[0],xmm15[1],xmm14[1],xmm15[2],xmm14[2],xmm15[3],xmm14[3]
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	cmpb	$0x0, -0x68(%rbp)
               	jne	<addr>
               	leaq	-0x68(%rbp), %rdx
               	movzbq	-0x67(%rbp), %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpb	$0x0, -0x66(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x65(%rbp)
               	jne	<addr>
               	movzbq	-0x64(%rbp), %rax
               	xorq	$0x2, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x38, %eax
               	leave
               	retq
               	leaq	-0x720(%rbp), %rsi
               	leaq	-0x2b0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x2a0(%rbp), %rcx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rax), %xmm14
               	punpckhwd	%xmm14, %xmm15  # xmm15 = xmm15[4],xmm14[4],xmm15[5],xmm14[5],xmm15[6],xmm14[6],xmm15[7],xmm14[7]
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movzbq	-0x68(%rbp), %rcx
               	xorq	$0x8, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	-0x67(%rbp), %rcx
               	xorq	$0x9, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpb	$0x0, -0x66(%rbp)
               	jne	<addr>
               	movzbq	-0x64(%rbp), %rcx
               	xorq	$0xa, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x39, %eax
               	leave
               	retq
               	leaq	-0x720(%rbp), %rdx
               	movl	$0x1, -0x720(%rbp)
               	movl	$0x2, -0x71c(%rbp)
               	movl	$0x3, -0x718(%rbp)
               	movl	$0x4, -0x714(%rbp)
               	leaq	-0x710(%rbp), %rsi
               	movl	$0x5, -0x710(%rbp)
               	movl	$0x6, -0x70c(%rbp)
               	movl	$0x7, -0x708(%rbp)
               	movl	$0x8, -0x704(%rbp)
               	leaq	-0x58(%rbp), %rdi
               	leaq	-0x290(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rsi), %xmm14
               	punpckldq	%xmm14, %xmm15  # xmm15 = xmm15[0],xmm14[0],xmm15[1],xmm14[1]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rax
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdi)
               	movl	-0x58(%rbp), %ecx
               	xorq	$0x1, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	-0x54(%rbp), %ecx
               	xorq	$0x5, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x50(%rbp), %ecx
               	xorq	$0x2, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	-0x4c(%rbp), %ecx
               	xorq	$0x6, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x3a, %eax
               	leave
               	retq
               	leaq	-0x720(%rbp), %rsi
               	leaq	-0x710(%rbp), %rdi
               	leaq	-0x280(%rbp), %rcx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rdi), %xmm14
               	punpckhdq	%xmm14, %xmm15  # xmm15 = xmm15[2],xmm14[2],xmm15[3],xmm14[3]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movl	-0x58(%rbp), %eax
               	xorq	$0x3, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x54(%rbp), %eax
               	xorq	$0x7, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	-0x50(%rbp), %eax
               	xorq	$0x4, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	-0x4c(%rbp), %eax
               	xorq	$0x8, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3b, %eax
               	leave
               	retq
               	leaq	-0x720(%rbp), %rcx
               	leaq	-0x710(%rbp), %rsi
               	leaq	-0x270(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	punpckhqdq	%xmm14, %xmm15  # xmm15 = xmm15[1],xmm14[1]
               	movdqu	%xmm15, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movl	-0x58(%rbp), %eax
               	xorq	$0x3, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	-0x54(%rbp), %eax
               	xorq	$0x4, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	-0x50(%rbp), %eax
               	xorq	$0x7, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x4c(%rbp), %eax
               	xorq	$0x8, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3c, %eax
               	leave
               	retq
               	leaq	-0x260(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0xfff0, -0x260(%rbp)   # imm = 0xFFF0
               	movw	$0xfff0, -0x25e(%rbp)   # imm = 0xFFF0
               	movw	$0xfff0, -0x25c(%rbp)   # imm = 0xFFF0
               	movw	$0xfff0, -0x25a(%rbp)   # imm = 0xFFF0
               	movw	$0xfff0, -0x258(%rbp)   # imm = 0xFFF0
               	leaq	-0x260(%rbp), %rcx
               	movw	$0xfff0, -0x256(%rbp)   # imm = 0xFFF0
               	movw	$0xfff0, -0x254(%rbp)   # imm = 0xFFF0
               	movw	$0xfff0, -0x252(%rbp)   # imm = 0xFFF0
               	leaq	-0x250(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	psraw	$0x2, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x58(%rbp), %eax
               	movl	$0xfffcfffc, %r11d      # imm = 0xFFFCFFFC
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x3d, %eax
               	leave
               	retq
               	leaq	-0x240(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0xfff0, -0x240(%rbp)   # imm = 0xFFF0
               	movw	$0xfff0, -0x23e(%rbp)   # imm = 0xFFF0
               	movw	$0xfff0, -0x23c(%rbp)   # imm = 0xFFF0
               	movw	$0xfff0, -0x23a(%rbp)   # imm = 0xFFF0
               	movw	$0xfff0, -0x238(%rbp)   # imm = 0xFFF0
               	leaq	-0x240(%rbp), %rcx
               	movw	$0xfff0, -0x236(%rbp)   # imm = 0xFFF0
               	movw	$0xfff0, -0x234(%rbp)   # imm = 0xFFF0
               	movw	$0xfff0, -0x232(%rbp)   # imm = 0xFFF0
               	leaq	-0x230(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	psraw	$0x20, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x58(%rbp), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x3e, %eax
               	leave
               	retq
               	leaq	-0x220(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0xfffffff0, -0x220(%rbp) # imm = 0xFFFFFFF0
               	movl	$0xfffffff0, -0x21c(%rbp) # imm = 0xFFFFFFF0
               	movl	$0xfffffff0, -0x218(%rbp) # imm = 0xFFFFFFF0
               	movl	$0xfffffff0, -0x214(%rbp) # imm = 0xFFFFFFF0
               	leaq	-0x210(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	psrad	$0x2, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x58(%rbp), %eax
               	movl	$0xfffffffc, %r11d      # imm = 0xFFFFFFFC
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x3f, %eax
               	leave
               	retq
               	movl	$0x3, %ecx
               	leaq	-0x200(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movl	$0xffffffc0, -0x200(%rbp) # imm = 0xFFFFFFC0
               	movl	$0xffffffc0, -0x1fc(%rbp) # imm = 0xFFFFFFC0
               	movl	$0xffffffc0, -0x1f8(%rbp) # imm = 0xFFFFFFC0
               	movl	$0xffffffc0, -0x1f4(%rbp) # imm = 0xFFFFFFC0
               	leaq	-0x200(%rbp), %rsi
               	leaq	-0x1f0(%rbp), %rax
               	movdqu	(%rsi), %xmm15
               	movq	%rcx, %xmm14
               	psrad	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movl	-0x58(%rbp), %eax
               	movl	$0xfffffff8, %r11d      # imm = 0xFFFFFFF8
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x40, %eax
               	leave
               	retq
               	leaq	-0x720(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movb	$0x0, -0x720(%rbp)
               	movb	$0x1, -0x71f(%rbp)
               	movb	$0x2, -0x71e(%rbp)
               	movb	$0x3, -0x71d(%rbp)
               	movb	$0x4, -0x71c(%rbp)
               	movb	$0x5, -0x71b(%rbp)
               	movb	$0x6, -0x71a(%rbp)
               	movb	$0x7, -0x719(%rbp)
               	movb	$0x8, -0x718(%rbp)
               	movb	$0x9, -0x717(%rbp)
               	movb	$0xa, -0x716(%rbp)
               	movb	$0xb, -0x715(%rbp)
               	movb	$0xc, -0x714(%rbp)
               	movb	$0xd, -0x713(%rbp)
               	movb	$0xe, -0x712(%rbp)
               	movb	$0xf, -0x711(%rbp)
               	leaq	-0x68(%rbp), %rdx
               	leaq	-0x1e0(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	psrldq	$0x3, %xmm15            # xmm15 = xmm15[3,4,5,6,7,8,9,10,11,12,13,14,15],zero,zero,zero
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movzbq	-0x68(%rbp), %rax
               	xorq	$0x3, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	-0x5c(%rbp), %rax
               	xorq	$0xf, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpb	$0x0, -0x5b(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x59(%rbp)
               	je	<addr>
               	movl	$0x41, %eax
               	leave
               	retq
               	leaq	-0x68(%rbp), %rdx
               	leaq	-0x720(%rbp), %rcx
               	movl	$0xbeef, %esi           # imm = 0xBEEF
               	leaq	-0x1d0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	pinsrw	$0x2, %esi, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movzbq	-0x64(%rbp), %rax
               	xorq	$0xef, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	-0x63(%rbp), %rax
               	xorq	$0xbe, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	-0x62(%rbp), %rax
               	xorq	$0x6, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x42, %eax
               	leave
               	retq
               	leaq	-0x1c0(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movb	$-0x80, -0x1c0(%rbp)
               	movb	$-0x80, -0x1bf(%rbp)
               	movb	$-0x80, -0x1be(%rbp)
               	movb	$-0x80, -0x1bd(%rbp)
               	movb	$-0x80, -0x1bc(%rbp)
               	movb	$-0x80, -0x1bb(%rbp)
               	movb	$-0x80, -0x1ba(%rbp)
               	movb	$-0x80, -0x1b9(%rbp)
               	movb	$-0x80, -0x1b8(%rbp)
               	movb	$-0x80, -0x1b7(%rbp)
               	movb	$-0x80, -0x1b6(%rbp)
               	movb	$-0x80, -0x1b5(%rbp)
               	movb	$-0x80, -0x1b4(%rbp)
               	leaq	-0x1c0(%rbp), %rcx
               	movb	$-0x80, -0x1b3(%rbp)
               	movb	$-0x80, -0x1b2(%rbp)
               	movb	$-0x80, -0x1b1(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	pmovmskb	%xmm14, %r11d
               	movl	%r11d, (%rax)
               	movl	-0x8(%rbp), %ecx
               	cmpl	$0xffff, %ecx           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x43, %eax
               	leave
               	retq
               	leaq	-0x1b0(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm14
               	pmovmskb	%xmm14, %r11d
               	movl	%r11d, (%rax)
               	cmpl	$0x0, -0x8(%rbp)
               	je	<addr>
               	movl	$0x44, %eax
               	leave
               	retq
               	leaq	-0x1a0(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movb	$-0x80, -0x1a0(%rbp)
               	movb	$0x0, -0x19f(%rbp)
               	movb	$0x0, -0x19e(%rbp)
               	movb	$0x0, -0x19d(%rbp)
               	movb	$0x0, -0x19c(%rbp)
               	movb	$0x0, -0x19b(%rbp)
               	movb	$0x0, -0x19a(%rbp)
               	movb	$0x0, -0x199(%rbp)
               	movb	$0x0, -0x198(%rbp)
               	movb	$0x0, -0x197(%rbp)
               	movb	$0x0, -0x196(%rbp)
               	movb	$0x0, -0x195(%rbp)
               	movb	$0x0, -0x194(%rbp)
               	leaq	-0x1a0(%rbp), %rcx
               	movb	$0x0, -0x193(%rbp)
               	movb	$0x0, -0x192(%rbp)
               	movb	$-0x80, -0x191(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	pmovmskb	%xmm14, %r11d
               	movl	%r11d, (%rax)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x8001, %eax           # imm = 0x8001
               	je	<addr>
               	movl	$0x45, %eax
               	leave
               	retq
               	leaq	-0x58(%rbp), %rdx
               	leaq	-0x190(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movb	$0xf, -0x190(%rbp)
               	movb	$0xf, -0x18f(%rbp)
               	movb	$0xf, -0x18e(%rbp)
               	movb	$0xf, -0x18d(%rbp)
               	movb	$0xf, -0x18c(%rbp)
               	movb	$0xf, -0x18b(%rbp)
               	movb	$0xf, -0x18a(%rbp)
               	movb	$0xf, -0x189(%rbp)
               	movb	$0xf, -0x188(%rbp)
               	movb	$0xf, -0x187(%rbp)
               	movb	$0xf, -0x186(%rbp)
               	leaq	-0x190(%rbp), %rsi
               	movb	$0xf, -0x185(%rbp)
               	movb	$0xf, -0x184(%rbp)
               	movb	$0xf, -0x183(%rbp)
               	movb	$0xf, -0x182(%rbp)
               	movb	$0xf, -0x181(%rbp)
               	leaq	-0x180(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movb	$0x33, -0x180(%rbp)
               	movb	$0x33, -0x17f(%rbp)
               	movb	$0x33, -0x17e(%rbp)
               	movb	$0x33, -0x17d(%rbp)
               	movb	$0x33, -0x17c(%rbp)
               	movb	$0x33, -0x17b(%rbp)
               	movb	$0x33, -0x17a(%rbp)
               	movb	$0x33, -0x179(%rbp)
               	movb	$0x33, -0x178(%rbp)
               	movb	$0x33, -0x177(%rbp)
               	movb	$0x33, -0x176(%rbp)
               	movb	$0x33, -0x175(%rbp)
               	movb	$0x33, -0x174(%rbp)
               	movb	$0x33, -0x173(%rbp)
               	leaq	-0x180(%rbp), %rdi
               	movb	$0x33, -0x172(%rbp)
               	movb	$0x33, -0x171(%rbp)
               	leaq	-0x170(%rbp), %rcx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rdi), %xmm14
               	pandn	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x58(%rbp), %rsi
               	movl	-0x58(%rbp), %ecx
               	cmpl	$0x30303030, %ecx       # imm = 0x30303030
               	je	<addr>
               	movl	$0x46, %eax
               	leave
               	retq
               	leaq	-0x720(%rbp), %rcx
               	leaq	-0x160(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rcx), %xmm14
               	pcmpeqb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	movl	-0x58(%rbp), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	jne	<addr>
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x4c(%rbp), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x47, %eax
               	leave
               	retq
               	leaq	-0x150(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0x7, -0x150(%rbp)
               	movw	$0x7, -0x14e(%rbp)
               	movw	$0x7, -0x14c(%rbp)
               	movw	$0x7, -0x14a(%rbp)
               	movw	$0x7, -0x148(%rbp)
               	leaq	-0x150(%rbp), %rcx
               	movw	$0x7, -0x146(%rbp)
               	movw	$0x7, -0x144(%rbp)
               	movw	$0x7, -0x142(%rbp)
               	leaq	-0x140(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movw	$0x8, -0x140(%rbp)
               	movw	$0x8, -0x13e(%rbp)
               	movw	$0x8, -0x13c(%rbp)
               	movw	$0x8, -0x13a(%rbp)
               	leaq	-0x140(%rbp), %rsi
               	movw	$0x8, -0x138(%rbp)
               	movw	$0x8, -0x136(%rbp)
               	movw	$0x8, -0x134(%rbp)
               	movw	$0x8, -0x132(%rbp)
               	leaq	-0x130(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pcmpeqw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x58(%rbp), %rdx
               	cmpl	$0x0, -0x58(%rbp)
               	je	<addr>
               	movl	$0x48, %eax
               	leave
               	retq
               	leaq	-0x120(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0x7, -0x120(%rbp)
               	movl	$0x7, -0x11c(%rbp)
               	movl	$0x7, -0x118(%rbp)
               	movl	$0x7, -0x114(%rbp)
               	leaq	-0x110(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movl	$0x7, -0x110(%rbp)
               	movl	$0x7, -0x10c(%rbp)
               	movl	$0x7, -0x108(%rbp)
               	movl	$0x7, -0x104(%rbp)
               	leaq	-0x110(%rbp), %rsi
               	leaq	-0x100(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pcmpeqd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x58(%rbp), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x49, %eax
               	leave
               	retq
               	leaq	-0xf0(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0xffff, -0xf0(%rbp)    # imm = 0xFFFF
               	movw	$0xffff, -0xee(%rbp)    # imm = 0xFFFF
               	movw	$0xffff, -0xec(%rbp)    # imm = 0xFFFF
               	movw	$0xffff, -0xea(%rbp)    # imm = 0xFFFF
               	movw	$0xffff, -0xe8(%rbp)    # imm = 0xFFFF
               	leaq	-0xf0(%rbp), %rcx
               	movw	$0xffff, -0xe6(%rbp)    # imm = 0xFFFF
               	movw	$0xffff, -0xe4(%rbp)    # imm = 0xFFFF
               	movw	$0xffff, -0xe2(%rbp)    # imm = 0xFFFF
               	leaq	-0xe0(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movw	$0xfffe, -0xe0(%rbp)    # imm = 0xFFFE
               	movw	$0xfffe, -0xde(%rbp)    # imm = 0xFFFE
               	movw	$0xfffe, -0xdc(%rbp)    # imm = 0xFFFE
               	movw	$0xfffe, -0xda(%rbp)    # imm = 0xFFFE
               	leaq	-0xe0(%rbp), %rsi
               	movw	$0xfffe, -0xd8(%rbp)    # imm = 0xFFFE
               	movw	$0xfffe, -0xd6(%rbp)    # imm = 0xFFFE
               	movw	$0xfffe, -0xd4(%rbp)    # imm = 0xFFFE
               	movw	$0xfffe, -0xd2(%rbp)    # imm = 0xFFFE
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pcmpgtw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x58(%rbp), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x4a, %eax
               	leave
               	retq
               	leaq	-0xc0(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0xfffffffe, -0xc0(%rbp) # imm = 0xFFFFFFFE
               	movl	$0xfffffffe, -0xbc(%rbp) # imm = 0xFFFFFFFE
               	movl	$0xfffffffe, -0xb8(%rbp) # imm = 0xFFFFFFFE
               	movl	$0xfffffffe, -0xb4(%rbp) # imm = 0xFFFFFFFE
               	leaq	-0xb0(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movl	$0xffffffff, -0xb0(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0xac(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0xa8(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0xa4(%rbp) # imm = 0xFFFFFFFF
               	leaq	-0xb0(%rbp), %rsi
               	leaq	-0xa0(%rbp), %rax
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rcx), %xmm14
               	pcmpgtd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movl	-0x58(%rbp), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x4b, %eax
               	leave
               	retq
               	movb	$0x1, -0x68(%rbp)
               	movb	$0x2, -0x67(%rbp)
               	movb	$0x3, -0x66(%rbp)
               	movb	$0x4, -0x65(%rbp)
               	movb	$0x5, -0x64(%rbp)
               	movb	$0x6, -0x63(%rbp)
               	movb	$0x7, -0x62(%rbp)
               	movb	$0x8, -0x61(%rbp)
               	movb	$0x9, -0x60(%rbp)
               	movb	$0xa, -0x5f(%rbp)
               	movb	$0xb, -0x5e(%rbp)
               	movb	$0xc, -0x5d(%rbp)
               	movb	$0xd, -0x5c(%rbp)
               	movb	$0xe, -0x5b(%rbp)
               	movb	$0xf, -0x5a(%rbp)
               	movb	$0x10, -0x59(%rbp)
               	leaq	-0x58(%rbp), %rax
               	movq	-0x68(%rbp), %rcx
               	leaq	-0x80(%rbp), %rsi
               	movq	%rcx, -0x80(%rbp)
               	movq	$0x0, -0x78(%rbp)
               	movdqu	(%rsi), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	-0x58(%rbp), %eax
               	cmpl	$0x4030201, %eax        # imm = 0x4030201
               	jne	<addr>
               	movl	-0x54(%rbp), %eax
               	cmpl	$0x8070605, %eax        # imm = 0x8070605
               	jne	<addr>
               	cmpl	$0x0, -0x50(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x4c(%rbp)
               	je	<addr>
               	movl	$0x4c, %eax
               	leave
               	retq
               	movabsq	$-0x1111111111111112, %rax # imm = 0xEEEEEEEEEEEEEEEE
               	movq	%rax, -0x68(%rbp)
               	movq	%rax, -0x60(%rbp)
               	leaq	-0x510(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x1, -0x510(%rbp)
               	movl	$0x2, -0x50c(%rbp)
               	movl	$0x3, -0x508(%rbp)
               	movl	$0x4, -0x504(%rbp)
               	movq	-0x510(%rbp), %rax
               	movq	%rax, -0x68(%rbp)
               	leaq	-0x68(%rbp), %rdx
               	movzbq	-0x68(%rbp), %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	-0x64(%rbp), %rax
               	xorq	$0x2, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	-0x60(%rbp), %rax
               	xorq	$0xee, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4d, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	leaq	-0x720(%rbp), %rsi
               	leaq	-0x510(%rbp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x90(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdx)
               	cmpb	$0x0, -0x68(%rbp)
               	je	<addr>
               	movl	$0x4e, %eax
               	leave
               	retq
               	movzbq	-0x67(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movzbq	-0x66(%rbp), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movzbq	-0x65(%rbp), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movzbq	-0x64(%rbp), %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movzbq	-0x63(%rbp), %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movzbq	-0x62(%rbp), %rax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movzbq	-0x61(%rbp), %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movzbq	-0x60(%rbp), %rax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movzbq	-0x5f(%rbp), %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movzbq	-0x5e(%rbp), %rax
               	cmpl	$0xa, %eax
               	jne	<addr>
               	movzbq	-0x5d(%rbp), %rax
               	cmpl	$0xb, %eax
               	jne	<addr>
               	movzbq	-0x5c(%rbp), %rax
               	cmpl	$0xc, %eax
               	jne	<addr>
               	movzbq	-0x5b(%rbp), %rax
               	cmpl	$0xd, %eax
               	jne	<addr>
               	movzbq	-0x5a(%rbp), %rax
               	cmpl	$0xe, %eax
               	jne	<addr>
               	movzbq	-0x59(%rbp), %rax
               	cmpl	$0xf, %eax
               	jne	<addr>
               	leaq	-0x58(%rbp), %rcx
               	leaq	-0x80(%rbp), %rdx
               	movl	$0xffffffff, -0x80(%rbp) # imm = 0xFFFFFFFF
               	movl	$0x0, -0x7c(%rbp)
               	movl	$0x0, -0x78(%rbp)
               	movl	$0x0, -0x74(%rbp)
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rcx)
               	movl	-0x58(%rbp), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	jne	<addr>
               	cmpl	$0x0, -0x54(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x4c(%rbp)
               	je	<addr>
               	movl	$0x50, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0x38(%rbp), %rdx
               	leaq	0x1(%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	-0x700(%rbp), %rax
               	leaq	-0x38(%rbp), %rcx
               	leaq	0x3(%rcx), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x68(%rbp), %rsi
               	leaq	-0x80(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rsi)
               	movzbq	-0x68(%rbp), %rax
               	xorq	$0x4, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	-0x59(%rbp), %rax
               	xorq	$0x13, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x51, %eax
               	leave
               	retq
               	leaq	0x5(%rcx), %rax
               	movq	$0x0, (%rax)
               	movq	$0x0, 0x8(%rax)
               	movzbq	-0x34(%rbp), %rax
               	xorq	$0x5, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	-0x23(%rbp), %rax
               	xorq	$0x16, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x52, %eax
               	leave
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x53, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
