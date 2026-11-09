
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
               	subq	$0x210, %rsp            # imm = 0x210
               	leaq	-0x210(%rbp), %rcx
               	leaq	<rip>, %rdx # <addr>
               	leaq	-0x150(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x140(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	aeskeygenassist	$0x1, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x90(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x50(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x70(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x60(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x160(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rax)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x60(%rbp), %rax
               	leaq	-0xa0(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x90(%rbp), %rax
               	leaq	-0x60(%rbp), %rdx
               	leaq	-0x150(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	-0x10(%rbp), %xmm0
               	movups	%xmm0, -0x200(%rbp)
               	leaq	-0x210(%rbp), %rdx
               	addq	$0x10, %rdx
               	leaq	-0x130(%rbp), %rsi
               	movdqu	(%rdx), %xmm14
               	aeskeygenassist	$0x2, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rdx
               	movdqu	(%rax), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x60(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x160(%rbp), %rdx
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
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x60(%rbp), %rax
               	leaq	-0xa0(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x90(%rbp), %rax
               	leaq	-0x60(%rbp), %rdx
               	leaq	-0x150(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	-0x10(%rbp), %xmm0
               	movups	%xmm0, -0x1f0(%rbp)
               	leaq	-0x210(%rbp), %rdx
               	addq	$0x20, %rdx
               	leaq	-0x120(%rbp), %rsi
               	movdqu	(%rdx), %xmm14
               	aeskeygenassist	$0x4, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rdx
               	movdqu	(%rax), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x60(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x160(%rbp), %rdx
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
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x60(%rbp), %rax
               	leaq	-0xa0(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x90(%rbp), %rax
               	leaq	-0x60(%rbp), %rdx
               	leaq	-0x150(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	-0x10(%rbp), %xmm0
               	movups	%xmm0, -0x1e0(%rbp)
               	leaq	-0x210(%rbp), %rdx
               	addq	$0x30, %rdx
               	leaq	-0x110(%rbp), %rsi
               	movdqu	(%rdx), %xmm14
               	aeskeygenassist	$0x8, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rdx
               	movdqu	(%rax), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x60(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x160(%rbp), %rdx
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
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x60(%rbp), %rax
               	leaq	-0xa0(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x90(%rbp), %rax
               	leaq	-0x60(%rbp), %rdx
               	leaq	-0x150(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	-0x10(%rbp), %xmm0
               	movups	%xmm0, -0x1d0(%rbp)
               	leaq	-0x210(%rbp), %rdx
               	addq	$0x40, %rdx
               	leaq	-0x100(%rbp), %rsi
               	movdqu	(%rdx), %xmm14
               	aeskeygenassist	$0x10, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rdx
               	movdqu	(%rax), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x60(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x160(%rbp), %rdx
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
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x60(%rbp), %rax
               	leaq	-0xa0(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x90(%rbp), %rax
               	leaq	-0x60(%rbp), %rdx
               	leaq	-0x150(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	-0x10(%rbp), %xmm0
               	movups	%xmm0, -0x1c0(%rbp)
               	leaq	-0x210(%rbp), %rdx
               	addq	$0x50, %rdx
               	leaq	-0xf0(%rbp), %rsi
               	movdqu	(%rdx), %xmm14
               	aeskeygenassist	$0x20, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rdx
               	movdqu	(%rax), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x60(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x160(%rbp), %rdx
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
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x60(%rbp), %rax
               	leaq	-0xa0(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x90(%rbp), %rax
               	leaq	-0x60(%rbp), %rdx
               	leaq	-0x150(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	-0x10(%rbp), %xmm0
               	movups	%xmm0, -0x1b0(%rbp)
               	leaq	-0x210(%rbp), %rdx
               	addq	$0x60, %rdx
               	leaq	-0xe0(%rbp), %rsi
               	movdqu	(%rdx), %xmm14
               	aeskeygenassist	$0x40, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rdx
               	movdqu	(%rax), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x60(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x160(%rbp), %rdx
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
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x60(%rbp), %rax
               	leaq	-0xa0(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x90(%rbp), %rax
               	leaq	-0x60(%rbp), %rdx
               	leaq	-0x150(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	-0x10(%rbp), %xmm0
               	movups	%xmm0, -0x1a0(%rbp)
               	leaq	-0x210(%rbp), %rdx
               	addq	$0x70, %rdx
               	leaq	-0xd0(%rbp), %rsi
               	movdqu	(%rdx), %xmm14
               	aeskeygenassist	$0x80, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rdx
               	movdqu	(%rax), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x60(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x160(%rbp), %rdx
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
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x60(%rbp), %rax
               	leaq	-0xa0(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x90(%rbp), %rax
               	leaq	-0x60(%rbp), %rdx
               	leaq	-0x150(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	-0x10(%rbp), %xmm0
               	movups	%xmm0, -0x190(%rbp)
               	leaq	-0x210(%rbp), %rdx
               	addq	$0x80, %rdx
               	leaq	-0xc0(%rbp), %rsi
               	movdqu	(%rdx), %xmm14
               	aeskeygenassist	$0x1b, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rdx
               	movdqu	(%rax), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x60(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x160(%rbp), %rdx
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
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x60(%rbp), %rax
               	leaq	-0xa0(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x90(%rbp), %rax
               	leaq	-0x60(%rbp), %rdx
               	leaq	-0x150(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	-0x10(%rbp), %xmm0
               	movups	%xmm0, -0x180(%rbp)
               	leaq	-0x210(%rbp), %rdx
               	addq	$0x90, %rdx
               	leaq	-0xb0(%rbp), %rsi
               	movdqu	(%rdx), %xmm14
               	aeskeygenassist	$0x36, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rdx
               	movdqu	(%rax), %xmm14
               	pshufd	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[3,3,3,3]
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x60(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x160(%rbp), %rdx
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
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x60(%rbp), %rax
               	leaq	-0xa0(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pslldq	$0x4, %xmm15            # xmm15 = zero,zero,zero,zero,xmm15[0,1,2,3,4,5,6,7,8,9,10,11]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x90(%rbp), %rax
               	leaq	-0x60(%rbp), %rdx
               	leaq	-0x150(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	-0x10(%rbp), %xmm0
               	movups	%xmm0, -0x170(%rbp)
               	leaq	-0x160(%rbp), %rcx
               	leaq	<rip>, %rdx # <addr>
               	leaq	-0xa0(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x210(%rbp), %rdx
               	leaq	-0x150(%rbp), %rsi
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
               	leaq	-0x150(%rbp), %rdi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	aesenc	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	leaq	-0x150(%rbp), %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	incq	%rax
               	cmpl	$0xa, %eax
               	jl	<addr>
               	leaq	-0x160(%rbp), %r9
               	leaq	-0x210(%rbp), %rax
               	leaq	0xa0(%rax), %rcx
               	leaq	-0x150(%rbp), %rax
               	movdqu	(%r9), %xmm15
               	movdqu	(%rcx), %xmm14
               	aesenclast	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	<rip>, %rdi # <addr>
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	leaq	-0x160(%rbp), %rcx
               	leaq	<rip>, %rdx # <addr>
               	leaq	-0xa0(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x210(%rbp), %rdx
               	leaq	0xa0(%rdx), %rdi
               	leaq	-0x150(%rbp), %rsi
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
               	leaq	-0xa0(%rbp), %rdi
               	movdqu	(%rsi), %xmm14
               	aesimc	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	leaq	-0xa0(%rbp), %rsi
               	leaq	-0x150(%rbp), %rdi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	aesdec	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	leaq	-0x150(%rbp), %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	decq	%rax
               	testl	%eax, %eax
               	jg	<addr>
               	leaq	-0x160(%rbp), %r9
               	leaq	-0x210(%rbp), %rcx
               	leaq	-0x150(%rbp), %rax
               	movdqu	(%r9), %xmm15
               	movdqu	(%rcx), %xmm14
               	aesdeclast	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	<rip>, %rdi # <addr>
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x270, %rsp            # imm = 0x270
               	leaq	-0x270(%rbp), %rax
               	movl	$0x1, -0x270(%rbp)
               	movl	$0x2, -0x26c(%rbp)
               	movl	$0x3, -0x268(%rbp)
               	movl	$0x4, -0x264(%rbp)
               	leaq	-0x260(%rbp), %rdx
               	movl	$0x64, -0x260(%rbp)
               	movl	$0xc8, -0x25c(%rbp)
               	movl	$0x12c, -0x258(%rbp)    # imm = 0x12C
               	movl	$0x190, -0x254(%rbp)    # imm = 0x190
               	leaq	-0x58(%rbp), %rsi
               	leaq	-0x240(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	paddd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x130(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	movl	-0x58(%rbp), %ecx
               	cmpl	$0x65, %ecx
               	jne	<addr>
               	movl	-0x54(%rbp), %ecx
               	cmpl	$0xca, %ecx
               	jne	<addr>
               	movl	-0x50(%rbp), %ecx
               	cmpl	$0x12f, %ecx            # imm = 0x12F
               	jne	<addr>
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x4c(%rbp), %ecx
               	cmpl	$0x194, %ecx            # imm = 0x194
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x270(%rbp), %rsi
               	leaq	-0x260(%rbp), %rdi
               	leaq	-0x240(%rbp), %rcx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rdi), %xmm14
               	pxor	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x130(%rbp), %rax
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
               	leaq	-0x270(%rbp), %rsi
               	leaq	-0x260(%rbp), %rdi
               	leaq	-0x240(%rbp), %rcx
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
               	leaq	-0x270(%rbp), %rcx
               	leaq	-0x260(%rbp), %rsi
               	leaq	-0x240(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pand	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x130(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	cmpl	$0x0, -0x50(%rbp)
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0xffffffff, -0x270(%rbp) # imm = 0xFFFFFFFF
               	movl	$0x0, -0x26c(%rbp)
               	movl	$0xffffffff, -0x268(%rbp) # imm = 0xFFFFFFFF
               	movl	$0x0, -0x264(%rbp)
               	movl	$0x1, -0x260(%rbp)
               	movl	$0x0, -0x25c(%rbp)
               	movl	$0x0, -0x258(%rbp)
               	movl	$0x0, -0x254(%rbp)
               	leaq	-0x58(%rbp), %rcx
               	leaq	-0x270(%rbp), %rax
               	leaq	-0x260(%rbp), %rsi
               	leaq	-0x240(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rsi), %xmm14
               	paddd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x130(%rbp), %rax
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
               	leaq	-0x270(%rbp), %rdx
               	leaq	-0x260(%rbp), %rsi
               	leaq	-0x240(%rbp), %rdi
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rsi), %xmm14
               	paddq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x130(%rbp), %rax
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x58(%rbp), %rdi
               	cmpl	$0x0, -0x58(%rbp)
               	jne	<addr>
               	movl	-0x54(%rbp), %ecx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x230(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rsi), %xmm14
               	paddq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x260(%rbp), %rsi
               	leaq	-0x240(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	psubq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdi)
               	movl	-0x58(%rbp), %eax
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	leaq	-0x58(%rbp), %rcx
               	cmpl	$0x0, -0x54(%rbp)
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x270(%rbp), %rax
               	movl	$0xddeeff00, -0x270(%rbp) # imm = 0xDDEEFF00
               	movl	$0x99aabbcc, -0x26c(%rbp) # imm = 0x99AABBCC
               	movl	$0x55667788, -0x268(%rbp) # imm = 0x55667788
               	movl	$0x11223344, -0x264(%rbp) # imm = 0x11223344
               	leaq	-0x220(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	pslld	$0x4, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x130(%rbp), %rax
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
               	leaq	-0x270(%rbp), %rdx
               	leaq	-0x210(%rbp), %rsi
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
               	leaq	-0x200(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	movq	%rax, %xmm14
               	psrld	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x130(%rbp), %rax
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
               	leaq	-0x270(%rbp), %rdx
               	leaq	-0x1f0(%rbp), %rsi
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
               	leaq	-0x1e0(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	psllq	$0x8, %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x130(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	movl	-0x58(%rbp), %edx
               	cmpl	$0xeeff0000, %edx       # imm = 0xEEFF0000
               	jne	<addr>
               	movl	-0x54(%rbp), %edx
               	cmpl	$0xaabbccdd, %edx       # imm = 0xAABBCCDD
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	-0x270(%rbp), %rdx
               	leaq	-0x1d0(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	psrlq	$0x8, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x130(%rbp), %rax
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x58(%rbp), %rsi
               	movl	-0x58(%rbp), %ecx
               	cmpl	$0xccddeeff, %ecx       # imm = 0xCCDDEEFF
               	jne	<addr>
               	movl	-0x54(%rbp), %ecx
               	cmpl	$0x99aabb, %ecx         # imm = 0x99AABB
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	-0x1c0(%rbp), %rcx
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
               	cmpl	$0xddeeff00, %eax       # imm = 0xDDEEFF00
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	leaq	-0x270(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movb	$0x0, -0x270(%rbp)
               	movb	$0x1, -0x26f(%rbp)
               	movb	$0x2, -0x26e(%rbp)
               	movb	$0x3, -0x26d(%rbp)
               	movb	$0x4, -0x26c(%rbp)
               	movb	$0x5, -0x26b(%rbp)
               	movb	$0x6, -0x26a(%rbp)
               	movb	$0x7, -0x269(%rbp)
               	movb	$0x8, -0x268(%rbp)
               	movb	$0x9, -0x267(%rbp)
               	movb	$0xa, -0x266(%rbp)
               	movb	$0xb, -0x265(%rbp)
               	movb	$0xc, -0x264(%rbp)
               	movb	$0xd, -0x263(%rbp)
               	movb	$0xe, -0x262(%rbp)
               	movb	$0xf, -0x261(%rbp)
               	leaq	-0x68(%rbp), %rdx
               	leaq	-0x270(%rbp), %rcx
               	leaq	-0x1b0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	psllw	$0x8, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x130(%rbp), %rcx
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
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	-0x68(%rbp), %rcx
               	leaq	-0x270(%rbp), %rdx
               	leaq	-0x1a0(%rbp), %rax
               	movdqu	(%rdx), %xmm15
               	psrlw	$0x8, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x130(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rcx)
               	movzbq	-0x68(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	cmpb	$0x0, -0x67(%rbp)
               	jne	<addr>
               	movzbq	-0x66(%rbp), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	leaq	-0x270(%rbp), %rdx
               	leaq	-0x190(%rbp), %rsi
               	movdqu	(%rdx), %xmm14
               	pshuflw	$0x1b, %xmm14, %xmm15   # xmm15 = xmm14[3,2,1,0,4,5,6,7]
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x130(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x68(%rbp), %rsi
               	movzbq	-0x68(%rbp), %rcx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movzbq	-0x67(%rbp), %rcx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	cmpb	$0x0, -0x62(%rbp)
               	jne	<addr>
               	movzbq	-0x61(%rbp), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movzbq	-0x60(%rbp), %rcx
               	cmpl	$0x8, %ecx
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	leaq	-0x180(%rbp), %rcx
               	movdqu	(%rdx), %xmm14
               	pshufhw	$0x1b, %xmm14, %xmm15   # xmm15 = xmm14[0,1,2,3,7,6,5,4]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x130(%rbp), %rax
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	cmpb	$0x0, -0x68(%rbp)
               	jne	<addr>
               	movzbq	-0x60(%rbp), %rcx
               	cmpl	$0xe, %ecx
               	jne	<addr>
               	movzbq	-0x5f(%rbp), %rcx
               	cmpl	$0xf, %ecx
               	jne	<addr>
               	movzbq	-0x5a(%rbp), %rcx
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	movzbq	-0x59(%rbp), %rcx
               	cmpl	$0x9, %ecx
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	leaq	-0x270(%rbp), %rdx
               	movl	$0x0, -0x270(%rbp)
               	movl	$0x1, -0x26c(%rbp)
               	movl	$0x2, -0x268(%rbp)
               	movl	$0x3, -0x264(%rbp)
               	leaq	-0x58(%rbp), %rsi
               	leaq	-0x170(%rbp), %rcx
               	movdqu	(%rdx), %xmm14
               	pshufd	$0x93, %xmm14, %xmm15   # xmm15 = xmm14[3,0,1,2]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	movl	-0x58(%rbp), %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	cmpl	$0x0, -0x54(%rbp)
               	jne	<addr>
               	movl	-0x50(%rbp), %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	-0x4c(%rbp), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	leaq	-0x270(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movb	$0x0, -0x270(%rbp)
               	movb	$0x1, -0x26f(%rbp)
               	movb	$0x2, -0x26e(%rbp)
               	movb	$0x3, -0x26d(%rbp)
               	movb	$0x4, -0x26c(%rbp)
               	movb	$0x5, -0x26b(%rbp)
               	movb	$0x6, -0x26a(%rbp)
               	movb	$0x7, -0x269(%rbp)
               	movb	$0x8, -0x268(%rbp)
               	movb	$0x9, -0x267(%rbp)
               	movb	$0xa, -0x266(%rbp)
               	movb	$0xb, -0x265(%rbp)
               	movb	$0xc, -0x264(%rbp)
               	movb	$0xd, -0x263(%rbp)
               	movb	$0xe, -0x262(%rbp)
               	movb	$0xf, -0x261(%rbp)
               	leaq	-0x260(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movb	$0xf, -0x260(%rbp)
               	movb	$0xe, -0x25f(%rbp)
               	movb	$0xd, -0x25e(%rbp)
               	movb	$0xc, -0x25d(%rbp)
               	movb	$0xb, -0x25c(%rbp)
               	movb	$0xa, -0x25b(%rbp)
               	movb	$0x9, -0x25a(%rbp)
               	movb	$0x8, -0x259(%rbp)
               	movb	$0x7, -0x258(%rbp)
               	movb	$0x6, -0x257(%rbp)
               	movb	$0x5, -0x256(%rbp)
               	movb	$0x4, -0x255(%rbp)
               	movb	$0x3, -0x254(%rbp)
               	movb	$0x2, -0x253(%rbp)
               	movb	$0x1, -0x252(%rbp)
               	movb	$-0x80, -0x251(%rbp)
               	leaq	-0x68(%rbp), %rdx
               	leaq	-0x270(%rbp), %rcx
               	leaq	-0x260(%rbp), %rsi
               	leaq	-0x240(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pshufb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x130(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movzbq	-0x68(%rbp), %rax
               	cmpl	$0xf, %eax
               	jne	<addr>
               	movzbq	-0x5a(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	cmpb	$0x0, -0x59(%rbp)
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	leaq	-0x270(%rbp), %rdx
               	movl	$0x1, -0x270(%rbp)
               	movl	$0x1, -0x26c(%rbp)
               	movl	$0x9, -0x268(%rbp)
               	movl	$0x9, -0x264(%rbp)
               	leaq	-0x260(%rbp), %rsi
               	movl	$0x2, -0x260(%rbp)
               	movl	$0x2, -0x25c(%rbp)
               	movl	$0x8, -0x258(%rbp)
               	movl	$0x8, -0x254(%rbp)
               	leaq	-0x58(%rbp), %rdi
               	leaq	-0x240(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rsi), %xmm14
               	punpcklqdq	%xmm14, %xmm15  # xmm15 = xmm15[0],xmm14[0]
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x130(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdi)
               	movl	-0x58(%rbp), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	-0x54(%rbp), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	-0x50(%rbp), %ecx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	leaq	-0x58(%rbp), %rsi
               	movl	-0x4c(%rbp), %ecx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	leaq	-0x270(%rbp), %rcx
               	leaq	-0x240(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rcx), %xmm14
               	pcmpeqq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x130(%rbp), %rax
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	movl	-0x58(%rbp), %ecx
               	cmpl	$-0x1, %ecx
               	jne	<addr>
               	movl	-0x4c(%rbp), %ecx
               	cmpl	$-0x1, %ecx
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	leaq	-0x58(%rbp), %rdx
               	leaq	-0x270(%rbp), %rsi
               	leaq	-0x260(%rbp), %rdi
               	leaq	-0x240(%rbp), %rcx
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
               	leaq	-0x270(%rbp), %rax
               	movl	$0x11112222, -0x270(%rbp) # imm = 0x11112222
               	movl	$0x33334444, -0x26c(%rbp) # imm = 0x33334444
               	movl	$0x55556666, -0x268(%rbp) # imm = 0x55556666
               	movl	$0x77778888, -0x264(%rbp) # imm = 0x77778888
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
               	leaq	-0x270(%rbp), %rcx
               	movl	$0xa0b0c0d, %esi        # imm = 0xA0B0C0D
               	leaq	-0x160(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	pinsrd	$0x1, %esi, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x130(%rbp), %rcx
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
               	movq	$0x3, -0x270(%rbp)
               	movq	$0x0, -0x268(%rbp)
               	leaq	-0x260(%rbp), %rdi
               	movq	$0x0, -0x260(%rbp)
               	movq	$0x3, -0x258(%rbp)
               	leaq	-0x270(%rbp), %rcx
               	leaq	-0x150(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rcx), %xmm14
               	pclmulqdq	$0x0, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x130(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x58(%rbp), %rsi
               	movl	-0x58(%rbp), %edx
               	cmpl	$0x5, %edx
               	jne	<addr>
               	cmpl	$0x0, -0x54(%rbp)
               	je	<addr>
               	movl	$0x1b, %eax
               	leave
               	retq
               	leaq	-0x140(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdi), %xmm14
               	pclmulqdq	$0x10, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	movl	-0x58(%rbp), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x1c, %eax
               	leave
               	retq
               	movl	$0x1, -0x270(%rbp)
               	movl	$0x2, -0x26c(%rbp)
               	movl	$0x3, -0x268(%rbp)
               	movl	$0x4, -0x264(%rbp)
               	movl	$0x5, -0x260(%rbp)
               	movl	$0x6, -0x25c(%rbp)
               	movl	$0x7, -0x258(%rbp)
               	movl	$0x8, -0x254(%rbp)
               	leaq	-0x240(%rbp), %rax
               	movups	-0x270(%rbp), %xmm0
               	movups	%xmm0, -0x240(%rbp)
               	leaq	-0x130(%rbp), %rcx
               	movups	-0x260(%rbp), %xmm0
               	movups	%xmm0, -0x130(%rbp)
               	leaq	-0x120(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	shufpd	$0x1, %xmm14, %xmm15    # xmm15 = xmm15[1],xmm14[0]
               	movdqu	%xmm15, (%rdx)
               	movups	-0x120(%rbp), %xmm0
               	leaq	-0x58(%rbp), %rax
               	leaq	-0x130(%rbp), %rcx
               	movups	%xmm0, -0x130(%rbp)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	-0x58(%rbp), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	-0x54(%rbp), %ecx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movl	-0x50(%rbp), %ecx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	-0x4c(%rbp), %ecx
               	cmpl	$0x6, %ecx
               	je	<addr>
               	movl	$0x1d, %eax
               	leave
               	retq
               	leaq	-0x130(%rbp), %rdx
               	movq	$0x0, -0x130(%rbp)
               	movq	$0x0, -0x128(%rbp)
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
               	movups	%xmm0, -0x130(%rbp)
               	leaq	-0x130(%rbp), %rax
               	leaq	-0x270(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x68(%rbp), %rcx
               	movq	$0x0, -0x68(%rbp)
               	movq	$0x0, -0x60(%rbp)
               	leaq	-0x270(%rbp), %rdx
               	leaq	-0x130(%rbp), %rax
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
               	leaq	-0x130(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movw	$0x0, -0x130(%rbp)
               	movw	$0x1, -0x12e(%rbp)
               	movw	$0x2, -0x12c(%rbp)
               	movw	$0x3, -0x12a(%rbp)
               	leaq	-0x130(%rbp), %r9
               	movw	$0x4, -0x128(%rbp)
               	movw	$0x5, -0x126(%rbp)
               	movw	$0x6, -0x124(%rbp)
               	movw	$0x7, -0x122(%rbp)
               	leaq	<rip>, %rdi # <addr>
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x21, %eax
               	leave
               	retq
               	leaq	-0x130(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movw	$0x7, -0x130(%rbp)
               	movw	$0x6, -0x12e(%rbp)
               	movw	$0x5, -0x12c(%rbp)
               	movw	$0x4, -0x12a(%rbp)
               	movw	$0x3, -0x128(%rbp)
               	movw	$0x2, -0x126(%rbp)
               	movw	$0x1, -0x124(%rbp)
               	movw	$0x0, -0x122(%rbp)
               	leaq	-0x130(%rbp), %r9
               	leaq	<rip>, %rdi # <addr>
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x22, %eax
               	leave
               	retq
               	leaq	-0x130(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movb	$0x0, -0x130(%rbp)
               	movb	$0x1, -0x12f(%rbp)
               	movb	$0x2, -0x12e(%rbp)
               	movb	$0x3, -0x12d(%rbp)
               	movb	$0x4, -0x12c(%rbp)
               	movb	$0x5, -0x12b(%rbp)
               	movb	$0x6, -0x12a(%rbp)
               	movb	$0x7, -0x129(%rbp)
               	movb	$0x8, -0x128(%rbp)
               	movb	$0x9, -0x127(%rbp)
               	leaq	-0x130(%rbp), %r9
               	movb	$0xa, -0x126(%rbp)
               	movb	$0xb, -0x125(%rbp)
               	movb	$0xc, -0x124(%rbp)
               	movb	$0xd, -0x123(%rbp)
               	movb	$0xe, -0x122(%rbp)
               	movb	$0xf, -0x121(%rbp)
               	leaq	<rip>, %rdi # <addr>
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x23, %eax
               	leave
               	retq
               	leaq	-0x130(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movb	$0xf, -0x130(%rbp)
               	movb	$0xe, -0x12f(%rbp)
               	movb	$0xd, -0x12e(%rbp)
               	movb	$0xc, -0x12d(%rbp)
               	movb	$0xb, -0x12c(%rbp)
               	movb	$0xa, -0x12b(%rbp)
               	movb	$0x9, -0x12a(%rbp)
               	movb	$0x8, -0x129(%rbp)
               	movb	$0x7, -0x128(%rbp)
               	movb	$0x6, -0x127(%rbp)
               	movb	$0x5, -0x126(%rbp)
               	movb	$0x4, -0x125(%rbp)
               	movb	$0x3, -0x124(%rbp)
               	movb	$0x2, -0x123(%rbp)
               	movb	$0x1, -0x122(%rbp)
               	movb	$0x0, -0x121(%rbp)
               	leaq	-0x130(%rbp), %r9
               	leaq	<rip>, %rdi # <addr>
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x24, %eax
               	leave
               	retq
               	leaq	-0x58(%rbp), %rax
               	leaq	-0x130(%rbp), %r8
               	movl	$0x1, -0x130(%rbp)
               	movl	$0x2, -0x12c(%rbp)
               	movl	$0x3, -0x128(%rbp)
               	movl	$0x4, -0x124(%rbp)
               	movdqu	(%r8), %xmm15
               	movdqu	%xmm15, (%rax)
               	movl	-0x58(%rbp), %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x58(%rbp), %rcx
               	movl	-0x4c(%rbp), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x25, %eax
               	leave
               	retq
               	leaq	-0x130(%rbp), %rdx
               	movl	$0x11223344, -0x130(%rbp) # imm = 0x11223344
               	movl	$0x11223344, -0x12c(%rbp) # imm = 0x11223344
               	movl	$0x11223344, -0x128(%rbp) # imm = 0x11223344
               	movl	$0x11223344, -0x124(%rbp) # imm = 0x11223344
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
               	leaq	-0x240(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movw	$0x1234, -0x240(%rbp)   # imm = 0x1234
               	movw	$0x1234, -0x23e(%rbp)   # imm = 0x1234
               	movw	$0x1234, -0x23c(%rbp)   # imm = 0x1234
               	movw	$0x1234, -0x23a(%rbp)   # imm = 0x1234
               	movw	$0x1234, -0x238(%rbp)   # imm = 0x1234
               	leaq	-0x240(%rbp), %rdx
               	movw	$0x1234, -0x236(%rbp)   # imm = 0x1234
               	movw	$0x1234, -0x234(%rbp)   # imm = 0x1234
               	movw	$0x1234, -0x232(%rbp)   # imm = 0x1234
               	leaq	-0x130(%rbp), %rax
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
               	leaq	-0x240(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movb	$0x5a, -0x240(%rbp)
               	movb	$0x5a, -0x23f(%rbp)
               	movb	$0x5a, -0x23e(%rbp)
               	movb	$0x5a, -0x23d(%rbp)
               	movb	$0x5a, -0x23c(%rbp)
               	movb	$0x5a, -0x23b(%rbp)
               	movb	$0x5a, -0x23a(%rbp)
               	movb	$0x5a, -0x239(%rbp)
               	movb	$0x5a, -0x238(%rbp)
               	movb	$0x5a, -0x237(%rbp)
               	movb	$0x5a, -0x236(%rbp)
               	leaq	-0x240(%rbp), %rdx
               	movb	$0x5a, -0x235(%rbp)
               	movb	$0x5a, -0x234(%rbp)
               	movb	$0x5a, -0x233(%rbp)
               	movb	$0x5a, -0x232(%rbp)
               	movb	$0x5a, -0x231(%rbp)
               	leaq	-0x130(%rbp), %rax
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
               	movq	%rcx, -0x130(%rbp)
               	movq	%rcx, -0x128(%rbp)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movl	-0x58(%rbp), %eax
               	cmpl	$0x89abcdef, %eax       # imm = 0x89ABCDEF
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
               	leaq	-0x270(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movb	$-0x1, -0x270(%rbp)
               	movb	$-0x1, -0x26f(%rbp)
               	movb	$-0x1, -0x26e(%rbp)
               	movb	$-0x1, -0x26d(%rbp)
               	movb	$-0x1, -0x26c(%rbp)
               	movb	$-0x1, -0x26b(%rbp)
               	movb	$-0x1, -0x26a(%rbp)
               	movb	$-0x1, -0x269(%rbp)
               	movb	$-0x1, -0x268(%rbp)
               	movb	$-0x1, -0x267(%rbp)
               	movb	$-0x1, -0x266(%rbp)
               	movb	$-0x1, -0x265(%rbp)
               	movb	$-0x1, -0x264(%rbp)
               	movb	$-0x1, -0x263(%rbp)
               	movb	$-0x1, -0x262(%rbp)
               	movb	$-0x1, -0x261(%rbp)
               	leaq	-0x260(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movb	$0x1, -0x260(%rbp)
               	movb	$0x1, -0x25f(%rbp)
               	movb	$0x1, -0x25e(%rbp)
               	movb	$0x1, -0x25d(%rbp)
               	movb	$0x1, -0x25c(%rbp)
               	movb	$0x1, -0x25b(%rbp)
               	movb	$0x1, -0x25a(%rbp)
               	movb	$0x1, -0x259(%rbp)
               	movb	$0x1, -0x258(%rbp)
               	movb	$0x1, -0x257(%rbp)
               	movb	$0x1, -0x256(%rbp)
               	movb	$0x1, -0x255(%rbp)
               	movb	$0x1, -0x254(%rbp)
               	movb	$0x1, -0x253(%rbp)
               	movb	$0x1, -0x252(%rbp)
               	movb	$0x1, -0x251(%rbp)
               	leaq	-0x240(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rcx), %xmm14
               	paddb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	-0x130(%rbp), %rax
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
               	leaq	-0x230(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x240(%rbp), %rsi
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rcx), %xmm14
               	psubb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdi)
               	movl	-0x58(%rbp), %eax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x2b, %eax
               	leave
               	retq
               	leaq	-0x270(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0xffff, -0x270(%rbp)   # imm = 0xFFFF
               	movw	$0xffff, -0x26e(%rbp)   # imm = 0xFFFF
               	movw	$0xffff, -0x26c(%rbp)   # imm = 0xFFFF
               	movw	$0xffff, -0x26a(%rbp)   # imm = 0xFFFF
               	movw	$0xffff, -0x268(%rbp)   # imm = 0xFFFF
               	movw	$0xffff, -0x266(%rbp)   # imm = 0xFFFF
               	movw	$0xffff, -0x264(%rbp)   # imm = 0xFFFF
               	movw	$0xffff, -0x262(%rbp)   # imm = 0xFFFF
               	leaq	-0x58(%rbp), %rdx
               	leaq	-0x230(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movw	$0x1, -0x230(%rbp)
               	movw	$0x1, -0x22e(%rbp)
               	movw	$0x1, -0x22c(%rbp)
               	movw	$0x1, -0x22a(%rbp)
               	leaq	-0x230(%rbp), %rsi
               	movw	$0x1, -0x228(%rbp)
               	movw	$0x1, -0x226(%rbp)
               	movw	$0x1, -0x224(%rbp)
               	movw	$0x1, -0x222(%rbp)
               	leaq	-0x240(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	paddw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x130(%rbp), %rcx
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
               	leaq	-0x110(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x230(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movw	$0x1, -0x230(%rbp)
               	movw	$0x1, -0x22e(%rbp)
               	movw	$0x1, -0x22c(%rbp)
               	movw	$0x1, -0x22a(%rbp)
               	leaq	-0x230(%rbp), %rsi
               	movw	$0x1, -0x228(%rbp)
               	movw	$0x1, -0x226(%rbp)
               	movw	$0x1, -0x224(%rbp)
               	movw	$0x1, -0x222(%rbp)
               	leaq	-0x240(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	psubw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x130(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x58(%rbp), %eax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x2d, %eax
               	leave
               	retq
               	leaq	-0x110(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0x5, -0x110(%rbp)
               	movl	$0x5, -0x10c(%rbp)
               	movl	$0x5, -0x108(%rbp)
               	movl	$0x5, -0x104(%rbp)
               	leaq	-0x230(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movl	$0x7, -0x230(%rbp)
               	movl	$0x7, -0x22c(%rbp)
               	movl	$0x7, -0x228(%rbp)
               	movl	$0x7, -0x224(%rbp)
               	leaq	-0x230(%rbp), %rsi
               	leaq	-0x240(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	psubd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x130(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x58(%rbp), %eax
               	cmpl	$-0x2, %eax
               	je	<addr>
               	movl	$0x2e, %eax
               	leave
               	retq
               	leaq	-0x110(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0x1234, -0x110(%rbp)   # imm = 0x1234
               	movw	$0x1234, -0x10e(%rbp)   # imm = 0x1234
               	movw	$0x1234, -0x10c(%rbp)   # imm = 0x1234
               	movw	$0x1234, -0x10a(%rbp)   # imm = 0x1234
               	movw	$0x1234, -0x108(%rbp)   # imm = 0x1234
               	leaq	-0x110(%rbp), %rcx
               	movw	$0x1234, -0x106(%rbp)   # imm = 0x1234
               	movw	$0x1234, -0x104(%rbp)   # imm = 0x1234
               	movw	$0x1234, -0x102(%rbp)   # imm = 0x1234
               	leaq	-0x230(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movw	$0x3, -0x230(%rbp)
               	movw	$0x3, -0x22e(%rbp)
               	movw	$0x3, -0x22c(%rbp)
               	movw	$0x3, -0x22a(%rbp)
               	leaq	-0x230(%rbp), %rsi
               	movw	$0x3, -0x228(%rbp)
               	movw	$0x3, -0x226(%rbp)
               	movw	$0x3, -0x224(%rbp)
               	movw	$0x3, -0x222(%rbp)
               	leaq	-0x240(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pmullw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x130(%rbp), %rcx
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
               	leaq	-0x110(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0xf000, -0x110(%rbp)   # imm = 0xF000
               	movw	$0xf000, -0x10e(%rbp)   # imm = 0xF000
               	movw	$0xf000, -0x10c(%rbp)   # imm = 0xF000
               	movw	$0xf000, -0x10a(%rbp)   # imm = 0xF000
               	movw	$0xf000, -0x108(%rbp)   # imm = 0xF000
               	leaq	-0x110(%rbp), %rcx
               	movw	$0xf000, -0x106(%rbp)   # imm = 0xF000
               	movw	$0xf000, -0x104(%rbp)   # imm = 0xF000
               	movw	$0xf000, -0x102(%rbp)   # imm = 0xF000
               	leaq	-0x230(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movw	$0x10, -0x230(%rbp)
               	movw	$0x10, -0x22e(%rbp)
               	movw	$0x10, -0x22c(%rbp)
               	movw	$0x10, -0x22a(%rbp)
               	leaq	-0x230(%rbp), %rsi
               	movw	$0x10, -0x228(%rbp)
               	movw	$0x10, -0x226(%rbp)
               	movw	$0x10, -0x224(%rbp)
               	movw	$0x10, -0x222(%rbp)
               	leaq	-0x240(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pmulhw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x130(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x58(%rbp), %eax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x30, %eax
               	leave
               	retq
               	leaq	-0x110(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0x1000, -0x110(%rbp)   # imm = 0x1000
               	movw	$0x1000, -0x10e(%rbp)   # imm = 0x1000
               	movw	$0x1000, -0x10c(%rbp)   # imm = 0x1000
               	movw	$0x1000, -0x10a(%rbp)   # imm = 0x1000
               	movw	$0x1000, -0x108(%rbp)   # imm = 0x1000
               	leaq	-0x110(%rbp), %rcx
               	movw	$0x1000, -0x106(%rbp)   # imm = 0x1000
               	movw	$0x1000, -0x104(%rbp)   # imm = 0x1000
               	movw	$0x1000, -0x102(%rbp)   # imm = 0x1000
               	leaq	-0x230(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movw	$0x10, -0x230(%rbp)
               	movw	$0x10, -0x22e(%rbp)
               	movw	$0x10, -0x22c(%rbp)
               	movw	$0x10, -0x22a(%rbp)
               	leaq	-0x230(%rbp), %rsi
               	movw	$0x10, -0x228(%rbp)
               	movw	$0x10, -0x226(%rbp)
               	movw	$0x10, -0x224(%rbp)
               	movw	$0x10, -0x222(%rbp)
               	leaq	-0x240(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pmulhw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x130(%rbp), %rcx
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
               	leaq	-0x270(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	$0x1, -0x270(%rbp)
               	movw	$0x2, -0x26e(%rbp)
               	movw	$0x3, -0x26c(%rbp)
               	movw	$0x4, -0x26a(%rbp)
               	movw	$0x5, -0x268(%rbp)
               	movw	$0x6, -0x266(%rbp)
               	movw	$0x7, -0x264(%rbp)
               	movw	$0x8, -0x262(%rbp)
               	leaq	-0x270(%rbp), %rcx
               	leaq	-0x230(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movw	$0xfffe, -0x230(%rbp)   # imm = 0xFFFE
               	movw	$0xfffe, -0x22e(%rbp)   # imm = 0xFFFE
               	movw	$0xfffe, -0x22c(%rbp)   # imm = 0xFFFE
               	movw	$0xfffe, -0x22a(%rbp)   # imm = 0xFFFE
               	leaq	-0x230(%rbp), %rsi
               	movw	$0xfffe, -0x228(%rbp)   # imm = 0xFFFE
               	movw	$0xfffe, -0x226(%rbp)   # imm = 0xFFFE
               	movw	$0xfffe, -0x224(%rbp)   # imm = 0xFFFE
               	movw	$0xfffe, -0x222(%rbp)   # imm = 0xFFFE
               	leaq	-0x240(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pmaddwd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x130(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movl	-0x58(%rbp), %eax
               	cmpl	$-0x6, %eax
               	jne	<addr>
               	movl	-0x4c(%rbp), %eax
               	cmpl	$-0x1e, %eax
               	je	<addr>
               	movl	$0x32, %eax
               	leave
               	retq
               	leaq	-0x68(%rbp), %rdx
               	leaq	-0x110(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0x12c, -0x110(%rbp)    # imm = 0x12C
               	movw	$0x12c, -0x10e(%rbp)    # imm = 0x12C
               	movw	$0x12c, -0x10c(%rbp)    # imm = 0x12C
               	movw	$0x12c, -0x10a(%rbp)    # imm = 0x12C
               	movw	$0x12c, -0x108(%rbp)    # imm = 0x12C
               	leaq	-0x110(%rbp), %rcx
               	movw	$0x12c, -0x106(%rbp)    # imm = 0x12C
               	movw	$0x12c, -0x104(%rbp)    # imm = 0x12C
               	movw	$0x12c, -0x102(%rbp)    # imm = 0x12C
               	leaq	-0x230(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movw	$0xfed4, -0x230(%rbp)   # imm = 0xFED4
               	movw	$0xfed4, -0x22e(%rbp)   # imm = 0xFED4
               	movw	$0xfed4, -0x22c(%rbp)   # imm = 0xFED4
               	movw	$0xfed4, -0x22a(%rbp)   # imm = 0xFED4
               	leaq	-0x230(%rbp), %rsi
               	movw	$0xfed4, -0x228(%rbp)   # imm = 0xFED4
               	movw	$0xfed4, -0x226(%rbp)   # imm = 0xFED4
               	movw	$0xfed4, -0x224(%rbp)   # imm = 0xFED4
               	movw	$0xfed4, -0x222(%rbp)   # imm = 0xFED4
               	leaq	-0x240(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	packsswb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x130(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x68(%rbp), %rdx
               	movzbq	-0x68(%rbp), %rax
               	cmpl	$0x7f, %eax
               	jne	<addr>
               	movzbq	-0x61(%rbp), %rax
               	cmpl	$0x7f, %eax
               	jne	<addr>
               	movzbq	-0x60(%rbp), %rax
               	cmpl	$0x80, %eax
               	jne	<addr>
               	movzbq	-0x59(%rbp), %rax
               	cmpl	$0x80, %eax
               	je	<addr>
               	movl	$0x33, %eax
               	leave
               	retq
               	leaq	-0x110(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0x12c, -0x110(%rbp)    # imm = 0x12C
               	movw	$0x12c, -0x10e(%rbp)    # imm = 0x12C
               	movw	$0x12c, -0x10c(%rbp)    # imm = 0x12C
               	movw	$0x12c, -0x10a(%rbp)    # imm = 0x12C
               	movw	$0x12c, -0x108(%rbp)    # imm = 0x12C
               	leaq	-0x110(%rbp), %rcx
               	movw	$0x12c, -0x106(%rbp)    # imm = 0x12C
               	movw	$0x12c, -0x104(%rbp)    # imm = 0x12C
               	movw	$0x12c, -0x102(%rbp)    # imm = 0x12C
               	leaq	-0x230(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movw	$0xfffb, -0x230(%rbp)   # imm = 0xFFFB
               	movw	$0xfffb, -0x22e(%rbp)   # imm = 0xFFFB
               	movw	$0xfffb, -0x22c(%rbp)   # imm = 0xFFFB
               	movw	$0xfffb, -0x22a(%rbp)   # imm = 0xFFFB
               	leaq	-0x230(%rbp), %rsi
               	movw	$0xfffb, -0x228(%rbp)   # imm = 0xFFFB
               	movw	$0xfffb, -0x226(%rbp)   # imm = 0xFFFB
               	movw	$0xfffb, -0x224(%rbp)   # imm = 0xFFFB
               	movw	$0xfffb, -0x222(%rbp)   # imm = 0xFFFB
               	leaq	-0x240(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	packuswb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x130(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x68(%rbp), %rdx
               	movzbq	-0x68(%rbp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movzbq	-0x61(%rbp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	cmpb	$0x0, -0x60(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x59(%rbp)
               	je	<addr>
               	movl	$0x34, %eax
               	leave
               	retq
               	leaq	-0x110(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0x11170, -0x110(%rbp)  # imm = 0x11170
               	movl	$0x11170, -0x10c(%rbp)  # imm = 0x11170
               	movl	$0x11170, -0x108(%rbp)  # imm = 0x11170
               	movl	$0x11170, -0x104(%rbp)  # imm = 0x11170
               	leaq	-0x230(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movl	$0xfffeee90, -0x230(%rbp) # imm = 0xFFFEEE90
               	movl	$0xfffeee90, -0x22c(%rbp) # imm = 0xFFFEEE90
               	movl	$0xfffeee90, -0x228(%rbp) # imm = 0xFFFEEE90
               	movl	$0xfffeee90, -0x224(%rbp) # imm = 0xFFFEEE90
               	leaq	-0x230(%rbp), %rsi
               	leaq	-0x240(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	packssdw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x130(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x68(%rbp), %rsi
               	movzbq	-0x68(%rbp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movzbq	-0x67(%rbp), %rax
               	cmpl	$0x7f, %eax
               	jne	<addr>
               	cmpb	$0x0, -0x60(%rbp)
               	jne	<addr>
               	movzbq	-0x5f(%rbp), %rax
               	cmpl	$0x80, %eax
               	je	<addr>
               	movl	$0x35, %eax
               	leave
               	retq
               	leaq	-0x270(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movb	$0x0, -0x270(%rbp)
               	movb	$0x1, -0x26f(%rbp)
               	movb	$0x2, -0x26e(%rbp)
               	movb	$0x3, -0x26d(%rbp)
               	movb	$0x4, -0x26c(%rbp)
               	movb	$0x5, -0x26b(%rbp)
               	movb	$0x6, -0x26a(%rbp)
               	movb	$0x7, -0x269(%rbp)
               	movb	$0x8, -0x268(%rbp)
               	movb	$0x9, -0x267(%rbp)
               	movb	$0xa, -0x266(%rbp)
               	movb	$0xb, -0x265(%rbp)
               	movb	$0xc, -0x264(%rbp)
               	movb	$0xd, -0x263(%rbp)
               	movb	$0xe, -0x262(%rbp)
               	movb	$0xf, -0x261(%rbp)
               	leaq	-0x270(%rbp), %rcx
               	leaq	-0x230(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x240(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	punpcklbw	%xmm14, %xmm15  # xmm15 = xmm15[0],xmm14[0],xmm15[1],xmm14[1],xmm15[2],xmm14[2],xmm15[3],xmm14[3],xmm15[4],xmm14[4],xmm15[5],xmm14[5],xmm15[6],xmm14[6],xmm15[7],xmm14[7]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x130(%rbp), %rax
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
               	cmpl	$0x1, %edx
               	jne	<addr>
               	movzbq	-0x5a(%rbp), %rdx
               	cmpl	$0x7, %edx
               	jne	<addr>
               	cmpb	$0x0, -0x59(%rbp)
               	je	<addr>
               	movl	$0x36, %eax
               	leave
               	retq
               	leaq	-0x230(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x240(%rbp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	punpckhbw	%xmm14, %xmm15  # xmm15 = xmm15[8],xmm14[8],xmm15[9],xmm14[9],xmm15[10],xmm14[10],xmm15[11],xmm14[11],xmm15[12],xmm14[12],xmm15[13],xmm14[13],xmm15[14],xmm14[14],xmm15[15],xmm14[15]
               	movdqu	%xmm15, (%rsi)
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x130(%rbp), %rax
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdi)
               	leaq	-0x68(%rbp), %rsi
               	movzbq	-0x68(%rbp), %rcx
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	cmpb	$0x0, -0x67(%rbp)
               	jne	<addr>
               	movzbq	-0x5a(%rbp), %rcx
               	cmpl	$0xf, %ecx
               	jne	<addr>
               	cmpb	$0x0, -0x59(%rbp)
               	je	<addr>
               	movl	$0x37, %eax
               	leave
               	retq
               	leaq	-0x270(%rbp), %rdi
               	leaq	-0x230(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x240(%rbp), %rdx
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
               	cmpl	$0x1, %eax
               	jne	<addr>
               	cmpb	$0x0, -0x66(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x65(%rbp)
               	jne	<addr>
               	movzbq	-0x64(%rbp), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x38, %eax
               	leave
               	retq
               	leaq	-0x270(%rbp), %rsi
               	leaq	-0x230(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x240(%rbp), %rcx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rax), %xmm14
               	punpckhwd	%xmm14, %xmm15  # xmm15 = xmm15[4],xmm14[4],xmm15[5],xmm14[5],xmm15[6],xmm14[6],xmm15[7],xmm14[7]
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x130(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movzbq	-0x68(%rbp), %rcx
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	movzbq	-0x67(%rbp), %rcx
               	cmpl	$0x9, %ecx
               	jne	<addr>
               	cmpb	$0x0, -0x66(%rbp)
               	jne	<addr>
               	movzbq	-0x64(%rbp), %rcx
               	cmpl	$0xa, %ecx
               	je	<addr>
               	movl	$0x39, %eax
               	leave
               	retq
               	leaq	-0x270(%rbp), %rdx
               	movl	$0x1, -0x270(%rbp)
               	movl	$0x2, -0x26c(%rbp)
               	movl	$0x3, -0x268(%rbp)
               	movl	$0x4, -0x264(%rbp)
               	leaq	-0x260(%rbp), %rsi
               	movl	$0x5, -0x260(%rbp)
               	movl	$0x6, -0x25c(%rbp)
               	movl	$0x7, -0x258(%rbp)
               	movl	$0x8, -0x254(%rbp)
               	leaq	-0x58(%rbp), %rdi
               	leaq	-0x240(%rbp), %rcx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rsi), %xmm14
               	punpckldq	%xmm14, %xmm15  # xmm15 = xmm15[0],xmm14[0],xmm15[1],xmm14[1]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x130(%rbp), %rax
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdi)
               	movl	-0x58(%rbp), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	-0x54(%rbp), %ecx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x50(%rbp), %ecx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movl	-0x4c(%rbp), %ecx
               	cmpl	$0x6, %ecx
               	je	<addr>
               	movl	$0x3a, %eax
               	leave
               	retq
               	leaq	-0x270(%rbp), %rsi
               	leaq	-0x260(%rbp), %rdi
               	leaq	-0x240(%rbp), %rcx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rdi), %xmm14
               	punpckhdq	%xmm14, %xmm15  # xmm15 = xmm15[2],xmm14[2],xmm15[3],xmm14[3]
               	movdqu	%xmm15, (%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movl	-0x58(%rbp), %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x54(%rbp), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movl	-0x50(%rbp), %eax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movl	-0x4c(%rbp), %eax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x3b, %eax
               	leave
               	retq
               	leaq	-0x270(%rbp), %rcx
               	leaq	-0x260(%rbp), %rsi
               	leaq	-0x240(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	punpckhqdq	%xmm14, %xmm15  # xmm15 = xmm15[1],xmm14[1]
               	movdqu	%xmm15, (%rax)
               	leaq	-0x130(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movl	-0x58(%rbp), %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movl	-0x54(%rbp), %eax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movl	-0x50(%rbp), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x4c(%rbp), %eax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x3c, %eax
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
               	leaq	-0x100(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	psraw	$0x2, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x130(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x58(%rbp), %eax
               	cmpl	$0xfffcfffc, %eax       # imm = 0xFFFCFFFC
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
               	leaq	-0xf0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	psraw	$0x20, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x130(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x58(%rbp), %eax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x3e, %eax
               	leave
               	retq
               	leaq	-0x240(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0xfffffff0, -0x240(%rbp) # imm = 0xFFFFFFF0
               	movl	$0xfffffff0, -0x23c(%rbp) # imm = 0xFFFFFFF0
               	movl	$0xfffffff0, -0x238(%rbp) # imm = 0xFFFFFFF0
               	movl	$0xfffffff0, -0x234(%rbp) # imm = 0xFFFFFFF0
               	leaq	-0xe0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	psrad	$0x2, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x130(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x58(%rbp), %eax
               	cmpl	$-0x4, %eax
               	je	<addr>
               	movl	$0x3f, %eax
               	leave
               	retq
               	movl	$0x3, %ecx
               	leaq	-0x240(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movl	$0xffffffc0, -0x240(%rbp) # imm = 0xFFFFFFC0
               	movl	$0xffffffc0, -0x23c(%rbp) # imm = 0xFFFFFFC0
               	movl	$0xffffffc0, -0x238(%rbp) # imm = 0xFFFFFFC0
               	movl	$0xffffffc0, -0x234(%rbp) # imm = 0xFFFFFFC0
               	leaq	-0x240(%rbp), %rsi
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rsi), %xmm15
               	movq	%rcx, %xmm14
               	psrad	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x130(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movl	-0x58(%rbp), %eax
               	cmpl	$-0x8, %eax
               	je	<addr>
               	movl	$0x40, %eax
               	leave
               	retq
               	leaq	-0x270(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movb	$0x0, -0x270(%rbp)
               	movb	$0x1, -0x26f(%rbp)
               	movb	$0x2, -0x26e(%rbp)
               	movb	$0x3, -0x26d(%rbp)
               	movb	$0x4, -0x26c(%rbp)
               	movb	$0x5, -0x26b(%rbp)
               	movb	$0x6, -0x26a(%rbp)
               	movb	$0x7, -0x269(%rbp)
               	movb	$0x8, -0x268(%rbp)
               	movb	$0x9, -0x267(%rbp)
               	movb	$0xa, -0x266(%rbp)
               	movb	$0xb, -0x265(%rbp)
               	movb	$0xc, -0x264(%rbp)
               	movb	$0xd, -0x263(%rbp)
               	movb	$0xe, -0x262(%rbp)
               	movb	$0xf, -0x261(%rbp)
               	leaq	-0x68(%rbp), %rdx
               	leaq	-0xc0(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	psrldq	$0x3, %xmm15            # xmm15 = xmm15[3,4,5,6,7,8,9,10,11,12,13,14,15],zero,zero,zero
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x130(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movzbq	-0x68(%rbp), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movzbq	-0x5c(%rbp), %rax
               	cmpl	$0xf, %eax
               	jne	<addr>
               	cmpb	$0x0, -0x5b(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x59(%rbp)
               	je	<addr>
               	movl	$0x41, %eax
               	leave
               	retq
               	leaq	-0x68(%rbp), %rdx
               	leaq	-0x270(%rbp), %rcx
               	movl	$0xbeef, %esi           # imm = 0xBEEF
               	leaq	-0xb0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	pinsrw	$0x2, %esi, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x130(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movzbq	-0x64(%rbp), %rax
               	cmpl	$0xef, %eax
               	jne	<addr>
               	movzbq	-0x63(%rbp), %rax
               	cmpl	$0xbe, %eax
               	jne	<addr>
               	movzbq	-0x62(%rbp), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x42, %eax
               	leave
               	retq
               	leaq	-0xa0(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movb	$-0x80, -0xa0(%rbp)
               	movb	$-0x80, -0x9f(%rbp)
               	movb	$-0x80, -0x9e(%rbp)
               	movb	$-0x80, -0x9d(%rbp)
               	movb	$-0x80, -0x9c(%rbp)
               	movb	$-0x80, -0x9b(%rbp)
               	movb	$-0x80, -0x9a(%rbp)
               	movb	$-0x80, -0x99(%rbp)
               	movb	$-0x80, -0x98(%rbp)
               	movb	$-0x80, -0x97(%rbp)
               	movb	$-0x80, -0x96(%rbp)
               	movb	$-0x80, -0x95(%rbp)
               	movb	$-0x80, -0x94(%rbp)
               	leaq	-0xa0(%rbp), %rcx
               	movb	$-0x80, -0x93(%rbp)
               	movb	$-0x80, -0x92(%rbp)
               	movb	$-0x80, -0x91(%rbp)
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
               	leaq	-0x90(%rbp), %rcx
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
               	leaq	-0x80(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movb	$-0x80, -0x80(%rbp)
               	movb	$0x0, -0x7f(%rbp)
               	movb	$0x0, -0x7e(%rbp)
               	movb	$0x0, -0x7d(%rbp)
               	movb	$0x0, -0x7c(%rbp)
               	movb	$0x0, -0x7b(%rbp)
               	movb	$0x0, -0x7a(%rbp)
               	movb	$0x0, -0x79(%rbp)
               	movb	$0x0, -0x78(%rbp)
               	movb	$0x0, -0x77(%rbp)
               	movb	$0x0, -0x76(%rbp)
               	movb	$0x0, -0x75(%rbp)
               	movb	$0x0, -0x74(%rbp)
               	leaq	-0x80(%rbp), %rcx
               	movb	$0x0, -0x73(%rbp)
               	movb	$0x0, -0x72(%rbp)
               	movb	$-0x80, -0x71(%rbp)
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
               	leaq	-0x110(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movb	$0xf, -0x110(%rbp)
               	movb	$0xf, -0x10f(%rbp)
               	movb	$0xf, -0x10e(%rbp)
               	movb	$0xf, -0x10d(%rbp)
               	movb	$0xf, -0x10c(%rbp)
               	movb	$0xf, -0x10b(%rbp)
               	movb	$0xf, -0x10a(%rbp)
               	movb	$0xf, -0x109(%rbp)
               	movb	$0xf, -0x108(%rbp)
               	movb	$0xf, -0x107(%rbp)
               	movb	$0xf, -0x106(%rbp)
               	leaq	-0x110(%rbp), %rsi
               	movb	$0xf, -0x105(%rbp)
               	movb	$0xf, -0x104(%rbp)
               	movb	$0xf, -0x103(%rbp)
               	movb	$0xf, -0x102(%rbp)
               	movb	$0xf, -0x101(%rbp)
               	leaq	-0x230(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movb	$0x33, -0x230(%rbp)
               	movb	$0x33, -0x22f(%rbp)
               	movb	$0x33, -0x22e(%rbp)
               	movb	$0x33, -0x22d(%rbp)
               	movb	$0x33, -0x22c(%rbp)
               	movb	$0x33, -0x22b(%rbp)
               	movb	$0x33, -0x22a(%rbp)
               	movb	$0x33, -0x229(%rbp)
               	movb	$0x33, -0x228(%rbp)
               	movb	$0x33, -0x227(%rbp)
               	movb	$0x33, -0x226(%rbp)
               	movb	$0x33, -0x225(%rbp)
               	movb	$0x33, -0x224(%rbp)
               	movb	$0x33, -0x223(%rbp)
               	leaq	-0x230(%rbp), %rdi
               	movb	$0x33, -0x222(%rbp)
               	movb	$0x33, -0x221(%rbp)
               	leaq	-0x240(%rbp), %rcx
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rdi), %xmm14
               	pandn	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x130(%rbp), %rax
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
               	leaq	-0x270(%rbp), %rcx
               	leaq	-0x240(%rbp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rcx), %xmm14
               	pcmpeqb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rsi)
               	movl	-0x58(%rbp), %eax
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x4c(%rbp), %eax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x47, %eax
               	leave
               	retq
               	leaq	-0x110(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0x7, -0x110(%rbp)
               	movw	$0x7, -0x10e(%rbp)
               	movw	$0x7, -0x10c(%rbp)
               	movw	$0x7, -0x10a(%rbp)
               	movw	$0x7, -0x108(%rbp)
               	leaq	-0x110(%rbp), %rcx
               	movw	$0x7, -0x106(%rbp)
               	movw	$0x7, -0x104(%rbp)
               	movw	$0x7, -0x102(%rbp)
               	leaq	-0x230(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movw	$0x8, -0x230(%rbp)
               	movw	$0x8, -0x22e(%rbp)
               	movw	$0x8, -0x22c(%rbp)
               	movw	$0x8, -0x22a(%rbp)
               	leaq	-0x230(%rbp), %rsi
               	movw	$0x8, -0x228(%rbp)
               	movw	$0x8, -0x226(%rbp)
               	movw	$0x8, -0x224(%rbp)
               	movw	$0x8, -0x222(%rbp)
               	leaq	-0x240(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pcmpeqw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x130(%rbp), %rcx
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
               	leaq	-0x110(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0x7, -0x110(%rbp)
               	movl	$0x7, -0x10c(%rbp)
               	movl	$0x7, -0x108(%rbp)
               	movl	$0x7, -0x104(%rbp)
               	leaq	-0x230(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movl	$0x7, -0x230(%rbp)
               	movl	$0x7, -0x22c(%rbp)
               	movl	$0x7, -0x228(%rbp)
               	movl	$0x7, -0x224(%rbp)
               	leaq	-0x230(%rbp), %rsi
               	leaq	-0x240(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pcmpeqd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x130(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x58(%rbp), %eax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x49, %eax
               	leave
               	retq
               	leaq	-0x110(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movw	$0xffff, -0x110(%rbp)   # imm = 0xFFFF
               	movw	$0xffff, -0x10e(%rbp)   # imm = 0xFFFF
               	movw	$0xffff, -0x10c(%rbp)   # imm = 0xFFFF
               	movw	$0xffff, -0x10a(%rbp)   # imm = 0xFFFF
               	movw	$0xffff, -0x108(%rbp)   # imm = 0xFFFF
               	leaq	-0x110(%rbp), %rcx
               	movw	$0xffff, -0x106(%rbp)   # imm = 0xFFFF
               	movw	$0xffff, -0x104(%rbp)   # imm = 0xFFFF
               	movw	$0xffff, -0x102(%rbp)   # imm = 0xFFFF
               	leaq	-0x230(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movw	$0xfffe, -0x230(%rbp)   # imm = 0xFFFE
               	movw	$0xfffe, -0x22e(%rbp)   # imm = 0xFFFE
               	movw	$0xfffe, -0x22c(%rbp)   # imm = 0xFFFE
               	movw	$0xfffe, -0x22a(%rbp)   # imm = 0xFFFE
               	leaq	-0x230(%rbp), %rsi
               	movw	$0xfffe, -0x228(%rbp)   # imm = 0xFFFE
               	movw	$0xfffe, -0x226(%rbp)   # imm = 0xFFFE
               	movw	$0xfffe, -0x224(%rbp)   # imm = 0xFFFE
               	movw	$0xfffe, -0x222(%rbp)   # imm = 0xFFFE
               	leaq	-0x240(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pcmpgtw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x130(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x58(%rbp), %rdx
               	movl	-0x58(%rbp), %eax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x4a, %eax
               	leave
               	retq
               	leaq	-0x110(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0xfffffffe, -0x110(%rbp) # imm = 0xFFFFFFFE
               	movl	$0xfffffffe, -0x10c(%rbp) # imm = 0xFFFFFFFE
               	movl	$0xfffffffe, -0x108(%rbp) # imm = 0xFFFFFFFE
               	movl	$0xfffffffe, -0x104(%rbp) # imm = 0xFFFFFFFE
               	leaq	-0x230(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movl	$0xffffffff, -0x230(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0x22c(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0x228(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0x224(%rbp) # imm = 0xFFFFFFFF
               	leaq	-0x230(%rbp), %rsi
               	leaq	-0x240(%rbp), %rax
               	movdqu	(%rsi), %xmm15
               	movdqu	(%rcx), %xmm14
               	pcmpgtd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x130(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rdx)
               	movl	-0x58(%rbp), %eax
               	cmpl	$-0x1, %eax
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
               	leaq	-0x130(%rbp), %rsi
               	movq	%rcx, -0x130(%rbp)
               	movq	$0x0, -0x128(%rbp)
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
               	leaq	-0x130(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x1, -0x130(%rbp)
               	movl	$0x2, -0x12c(%rbp)
               	movl	$0x3, -0x128(%rbp)
               	movl	$0x4, -0x124(%rbp)
               	movq	-0x130(%rbp), %rax
               	movq	%rax, -0x68(%rbp)
               	leaq	-0x68(%rbp), %rdx
               	movzbq	-0x68(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movzbq	-0x64(%rbp), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movzbq	-0x60(%rbp), %rax
               	cmpl	$0xee, %eax
               	je	<addr>
               	movl	$0x4d, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	-0x270(%rbp), %rsi
               	leaq	-0x130(%rbp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	movdqu	(%rcx), %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x240(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x130(%rbp), %rax
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
               	leaq	-0x130(%rbp), %rdx
               	movl	$0xffffffff, -0x130(%rbp) # imm = 0xFFFFFFFF
               	movl	$0x0, -0x12c(%rbp)
               	movl	$0x0, -0x128(%rbp)
               	movl	$0x0, -0x124(%rbp)
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rcx)
               	movl	-0x58(%rbp), %eax
               	cmpl	$-0x1, %eax
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
               	leaq	-0x250(%rbp), %rax
               	leaq	-0x38(%rbp), %rcx
               	leaq	0x3(%rcx), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x68(%rbp), %rsi
               	leaq	-0x130(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%rsi)
               	movzbq	-0x68(%rbp), %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movzbq	-0x59(%rbp), %rax
               	cmpl	$0x13, %eax
               	je	<addr>
               	movl	$0x51, %eax
               	leave
               	retq
               	leaq	0x5(%rcx), %rax
               	movq	$0x0, (%rax)
               	movq	$0x0, 0x8(%rax)
               	movzbq	-0x34(%rbp), %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movzbq	-0x23(%rbp), %rax
               	cmpl	$0x16, %eax
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
