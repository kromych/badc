
x86_vaes_and_vpclmulqdq_act_per_lane.x64:	file format elf64-x86-64

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

<lanes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movups	%xmm0, 0x20(%rsp)
               	movups	%xmm1, 0x30(%rsp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	leaq	0x40(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movups	0x40(%rsp), %xmm0
               	leaq	0x20(%rsp), %rax
               	leaq	0x50(%rsp), %rdx
               	movups	%xmm0, 0x50(%rsp)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x60(%rsp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rcx), %xmm14
               	pcmpeqb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x8(%rbp), %rdx
               	movdqu	(%rax), %xmm14
               	pmovmskb	%xmm14, %r11d
               	movl	%r11d, (%rdx)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	0x10(%rsp), %rax
               	movq	0x18(%rsp), %rdx
               	leaq	0x40(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%rax, 0x40(%rsp)
               	movq	%rdx, 0x48(%rsp)
               	movups	0x40(%rsp), %xmm0
               	leaq	0x30(%rsp), %rax
               	movups	%xmm0, 0x50(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x50(%rsp), %rcx
               	leaq	0x40(%rsp), %rdx
               	leaq	0x60(%rsp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pcmpeqb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x8(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pmovmskb	%xmm14, %r11d
               	movl	%r11d, (%rcx)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x400, %rsp            # imm = 0x400
               	andq	$-0x20, %rsp
               	movabsq	$0x7b5b546573745665, %rax # imm = 0x7B5B546573745665
               	movabsq	$0x63746f725d53475d, %rcx # imm = 0x63746F725D53475D
               	movq	%rcx, 0x80(%rsp)
               	movq	%rax, 0x88(%rsp)
               	movabsq	$0x123456789abcdef, %rax # imm = 0x123456789ABCDEF
               	movabsq	$0xf1e2d3c4b5a6978, %rcx # imm = 0xF1E2D3C4B5A6978
               	movq	%rcx, 0x90(%rsp)
               	movq	%rax, 0x98(%rsp)
               	movabsq	$0x4869285368617929, %rax # imm = 0x4869285368617929
               	movabsq	$0x5b477565726f6e5d, %rcx # imm = 0x5B477565726F6E5D
               	movq	%rcx, 0xa0(%rsp)
               	movq	%rax, 0xa8(%rsp)
               	movabsq	$0x1122334455667788, %rax # imm = 0x1122334455667788
               	movabsq	$-0x6655443322110100, %rcx # imm = 0x99AABBCCDDEEFF00
               	movq	%rcx, 0xb0(%rsp)
               	movq	%rax, 0xb8(%rsp)
               	movq	0x90(%rsp), %rax
               	movq	0x98(%rsp), %rcx
               	movq	0x80(%rsp), %rdx
               	movq	0x88(%rsp), %rsi
               	movq	%rdx, (%rsp)
               	movq	%rsi, 0x8(%rsp)
               	movq	%rax, 0x10(%rsp)
               	movq	%rcx, 0x18(%rsp)
               	movq	0xb0(%rsp), %rbx
               	movq	0xb8(%rsp), %r12
               	movq	0xa0(%rsp), %r13
               	movq	0xa8(%rsp), %r14
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x3d0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0x3d0(%rsp)
               	movq	%rcx, 0x3d8(%rsp)
               	movups	0x3d0(%rsp), %xmm0
               	movups	%xmm0, 0x250(%rsp)
               	leaq	0x250(%rsp), %rax
               	leaq	0x3d0(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%r13, 0x3d0(%rsp)
               	movq	%r14, 0x3d8(%rsp)
               	movups	0x3d0(%rsp), %xmm0
               	movups	%xmm0, 0x260(%rsp)
               	leaq	0x260(%rsp), %rcx
               	leaq	0x270(%rsp), %rdi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	aesenc	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	leaq	0x3e0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0x3e0(%rsp)
               	movq	%rsi, 0x3e8(%rsp)
               	movups	0x3e0(%rsp), %xmm0
               	movups	%xmm0, 0x280(%rsp)
               	leaq	0x280(%rsp), %rax
               	leaq	0x3e0(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%rbx, 0x3e0(%rsp)
               	movq	%r12, 0x3e8(%rsp)
               	movups	0x3e0(%rsp), %xmm0
               	movups	%xmm0, 0x290(%rsp)
               	leaq	0x290(%rsp), %rcx
               	leaq	0x2a0(%rsp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	aesenc	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movq	0x270(%rsp), %rsi
               	movq	0x278(%rsp), %rax
               	movq	0x2a0(%rsp), %rcx
               	movq	0x2a8(%rsp), %rdx
               	leaq	0x60(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movq	%rsi, 0x60(%rsp)
               	movq	%rax, 0x68(%rsp)
               	movq	%rcx, 0x70(%rsp)
               	movq	%rdx, 0x78(%rsp)
               	movq	0x60(%rsp), %rsi
               	movq	%rsi, 0x40(%rsp)
               	movq	%rax, 0x48(%rsp)
               	movq	%rcx, 0x50(%rsp)
               	movq	%rdx, 0x58(%rsp)
               	leaq	0x40(%rsp), %r9
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	leaq	0xd0(%rsp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	aesenc	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	0xd0(%rsp), %rax
               	leaq	0x90(%rsp), %rcx
               	leaq	0xb0(%rsp), %rdx
               	leaq	0xe0(%rsp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	aesenc	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	0xe0(%rsp), %rcx
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%rcx, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x3d0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0x3d0(%rsp)
               	movq	%rcx, 0x3d8(%rsp)
               	movups	0x3d0(%rsp), %xmm0
               	movups	%xmm0, 0x2b0(%rsp)
               	leaq	0x2b0(%rsp), %rax
               	leaq	0x3d0(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%r13, 0x3d0(%rsp)
               	movq	%r14, 0x3d8(%rsp)
               	movups	0x3d0(%rsp), %xmm0
               	movups	%xmm0, 0x2c0(%rsp)
               	leaq	0x2c0(%rsp), %rcx
               	leaq	0x2d0(%rsp), %rdi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	aesenclast	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	leaq	0x3e0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0x3e0(%rsp)
               	movq	%rsi, 0x3e8(%rsp)
               	movups	0x3e0(%rsp), %xmm0
               	movups	%xmm0, 0x2e0(%rsp)
               	leaq	0x2e0(%rsp), %rax
               	leaq	0x3e0(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%rbx, 0x3e0(%rsp)
               	movq	%r12, 0x3e8(%rsp)
               	movups	0x3e0(%rsp), %xmm0
               	movups	%xmm0, 0x2f0(%rsp)
               	leaq	0x2f0(%rsp), %rcx
               	leaq	0x300(%rsp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	aesenclast	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movq	0x2d0(%rsp), %rsi
               	movq	0x2d8(%rsp), %rax
               	movq	0x300(%rsp), %rcx
               	movq	0x308(%rsp), %rdx
               	leaq	0x60(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movq	%rsi, 0x60(%rsp)
               	movq	%rax, 0x68(%rsp)
               	movq	%rcx, 0x70(%rsp)
               	movq	%rdx, 0x78(%rsp)
               	movq	0x60(%rsp), %rsi
               	movq	%rsi, 0x40(%rsp)
               	movq	%rax, 0x48(%rsp)
               	movq	%rcx, 0x50(%rsp)
               	movq	%rdx, 0x58(%rsp)
               	leaq	0x40(%rsp), %r9
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	leaq	0xf0(%rsp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	aesenclast	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	0xf0(%rsp), %rax
               	leaq	0x90(%rsp), %rcx
               	leaq	0xb0(%rsp), %rdx
               	leaq	0x100(%rsp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	aesenclast	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	0x100(%rsp), %rcx
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%rcx, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x3d0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0x3d0(%rsp)
               	movq	%rcx, 0x3d8(%rsp)
               	movups	0x3d0(%rsp), %xmm0
               	movups	%xmm0, 0x310(%rsp)
               	leaq	0x310(%rsp), %rax
               	leaq	0x3d0(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%r13, 0x3d0(%rsp)
               	movq	%r14, 0x3d8(%rsp)
               	movups	0x3d0(%rsp), %xmm0
               	movups	%xmm0, 0x320(%rsp)
               	leaq	0x320(%rsp), %rcx
               	leaq	0x330(%rsp), %rdi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	aesdec	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	leaq	0x3e0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0x3e0(%rsp)
               	movq	%rsi, 0x3e8(%rsp)
               	movups	0x3e0(%rsp), %xmm0
               	movups	%xmm0, 0x340(%rsp)
               	leaq	0x340(%rsp), %rax
               	leaq	0x3e0(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%rbx, 0x3e0(%rsp)
               	movq	%r12, 0x3e8(%rsp)
               	movups	0x3e0(%rsp), %xmm0
               	movups	%xmm0, 0x350(%rsp)
               	leaq	0x350(%rsp), %rcx
               	leaq	0x360(%rsp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	aesdec	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movq	0x330(%rsp), %rsi
               	movq	0x338(%rsp), %rax
               	movq	0x360(%rsp), %rcx
               	movq	0x368(%rsp), %rdx
               	leaq	0x60(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movq	%rsi, 0x60(%rsp)
               	movq	%rax, 0x68(%rsp)
               	movq	%rcx, 0x70(%rsp)
               	movq	%rdx, 0x78(%rsp)
               	movq	0x60(%rsp), %rsi
               	movq	%rsi, 0x40(%rsp)
               	movq	%rax, 0x48(%rsp)
               	movq	%rcx, 0x50(%rsp)
               	movq	%rdx, 0x58(%rsp)
               	leaq	0x40(%rsp), %r9
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	leaq	0x110(%rsp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	aesdec	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	0x110(%rsp), %rax
               	leaq	0x90(%rsp), %rcx
               	leaq	0xb0(%rsp), %rdx
               	leaq	0x120(%rsp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	aesdec	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	0x120(%rsp), %rcx
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%rcx, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x3d0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0x3d0(%rsp)
               	movq	%rcx, 0x3d8(%rsp)
               	movups	0x3d0(%rsp), %xmm0
               	movups	%xmm0, 0x370(%rsp)
               	leaq	0x370(%rsp), %rax
               	leaq	0x3d0(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%r13, 0x3d0(%rsp)
               	movq	%r14, 0x3d8(%rsp)
               	movups	0x3d0(%rsp), %xmm0
               	movups	%xmm0, 0x380(%rsp)
               	leaq	0x380(%rsp), %rcx
               	leaq	0x390(%rsp), %rdi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	aesdeclast	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	leaq	0x3e0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0x3e0(%rsp)
               	movq	%rsi, 0x3e8(%rsp)
               	movups	0x3e0(%rsp), %xmm0
               	movups	%xmm0, 0x3a0(%rsp)
               	leaq	0x3a0(%rsp), %rax
               	leaq	0x3e0(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%rbx, 0x3e0(%rsp)
               	movq	%r12, 0x3e8(%rsp)
               	movups	0x3e0(%rsp), %xmm0
               	movups	%xmm0, 0x3b0(%rsp)
               	leaq	0x3b0(%rsp), %rcx
               	leaq	0x3c0(%rsp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	aesdeclast	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movq	0x390(%rsp), %rsi
               	movq	0x398(%rsp), %rax
               	movq	0x3c0(%rsp), %rcx
               	movq	0x3c8(%rsp), %rdx
               	leaq	0x60(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movq	%rsi, 0x60(%rsp)
               	movq	%rax, 0x68(%rsp)
               	movq	%rcx, 0x70(%rsp)
               	movq	%rdx, 0x78(%rsp)
               	movq	0x60(%rsp), %rsi
               	movq	%rsi, 0x40(%rsp)
               	movq	%rax, 0x48(%rsp)
               	movq	%rcx, 0x50(%rsp)
               	movq	%rdx, 0x58(%rsp)
               	leaq	0x40(%rsp), %r9
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	leaq	0x130(%rsp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	aesdeclast	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	0x130(%rsp), %rax
               	leaq	0x90(%rsp), %rcx
               	leaq	0xb0(%rsp), %rdx
               	leaq	0x140(%rsp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	aesdeclast	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	leaq	0x140(%rsp), %rcx
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%rcx, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x40(%rsp), %rdi
               	leaq	0x3d0(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rax, 0x3d0(%rsp)
               	movq	%rcx, 0x3d8(%rsp)
               	movups	0x3d0(%rsp), %xmm0
               	movups	%xmm0, 0x150(%rsp)
               	leaq	0x150(%rsp), %rax
               	leaq	0x3d0(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%r13, 0x3d0(%rsp)
               	movq	%r14, 0x3d8(%rsp)
               	movups	0x3d0(%rsp), %xmm0
               	movups	%xmm0, 0x160(%rsp)
               	leaq	0x160(%rsp), %rcx
               	leaq	0x170(%rsp), %r8
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pclmulqdq	$0x0, %xmm14, %xmm15
               	movdqu	%xmm15, (%r8)
               	leaq	0x3e0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0x3e0(%rsp)
               	movq	%rsi, 0x3e8(%rsp)
               	movups	0x3e0(%rsp), %xmm0
               	movups	%xmm0, 0x180(%rsp)
               	leaq	0x180(%rsp), %rax
               	leaq	0x3e0(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%rbx, 0x3e0(%rsp)
               	movq	%r12, 0x3e8(%rsp)
               	movups	0x3e0(%rsp), %xmm0
               	movups	%xmm0, 0x190(%rsp)
               	leaq	0x190(%rsp), %rcx
               	leaq	0x1a0(%rsp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pclmulqdq	$0x0, %xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movq	0x170(%rsp), %rax
               	movq	0x178(%rsp), %rcx
               	movq	0x1a0(%rsp), %rdx
               	movq	0x1a8(%rsp), %rsi
               	leaq	0x60(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movups	%xmm14, 0x10(%r8)
               	movq	%rax, 0x60(%rsp)
               	movq	%rcx, 0x68(%rsp)
               	movq	%rdx, 0x70(%rsp)
               	leaq	0x60(%rsp), %rax
               	movq	%rsi, 0x78(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x40(%rsp), %rcx
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rdx
               	leaq	0x1b0(%rsp), %r9
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pclmulqdq	$0x0, %xmm14, %xmm15
               	movdqu	%xmm15, (%r9)
               	leaq	0x90(%rsp), %rdx
               	leaq	0xb0(%rsp), %rsi
               	leaq	0x1c0(%rsp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pclmulqdq	$0x0, %xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	subq	$0x20, %rsp
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x5, %eax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x40(%rsp), %rax
               	movq	0x20(%rsp), %rcx
               	movq	0x28(%rsp), %rdx
               	leaq	0x3d0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%rcx, 0x3d0(%rsp)
               	movq	%rdx, 0x3d8(%rsp)
               	leaq	0x1d0(%rsp), %rcx
               	movups	0x3d0(%rsp), %xmm0
               	movups	%xmm0, 0x1d0(%rsp)
               	leaq	0x3d0(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%r13, 0x3d0(%rsp)
               	movq	%r14, 0x3d8(%rsp)
               	movups	0x3d0(%rsp), %xmm0
               	movups	%xmm0, 0x1e0(%rsp)
               	leaq	0x1e0(%rsp), %rdx
               	leaq	0x1f0(%rsp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pclmulqdq	$0x11, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	0x30(%rsp), %rcx
               	movq	0x38(%rsp), %rdx
               	leaq	0x3e0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%rcx, 0x3e0(%rsp)
               	movq	%rdx, 0x3e8(%rsp)
               	movups	0x3e0(%rsp), %xmm0
               	movups	%xmm0, 0x200(%rsp)
               	leaq	0x200(%rsp), %rcx
               	leaq	0x3e0(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rbx, 0x3e0(%rsp)
               	movq	%r12, 0x3e8(%rsp)
               	movups	0x3e0(%rsp), %xmm0
               	movups	%xmm0, 0x210(%rsp)
               	leaq	0x210(%rsp), %rdx
               	leaq	0x220(%rsp), %rsi
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pclmulqdq	$0x11, %xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	0x1f0(%rsp), %rcx
               	movq	0x1f8(%rsp), %rdx
               	movq	0x220(%rsp), %rsi
               	movq	0x228(%rsp), %rdi
               	leaq	0x60(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movups	%xmm14, 0x10(%r8)
               	movq	%rcx, 0x60(%rsp)
               	movq	%rdx, 0x68(%rsp)
               	movq	%rsi, 0x70(%rsp)
               	leaq	0x60(%rsp), %rcx
               	movq	%rdi, 0x78(%rsp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x40(%rsp), %rcx
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rdx
               	leaq	0x230(%rsp), %r9
               	movdqu	(%rax), %xmm15
               	movdqu	(%rdx), %xmm14
               	pclmulqdq	$0x11, %xmm14, %xmm15
               	movdqu	%xmm15, (%r9)
               	leaq	0x90(%rsp), %rdx
               	leaq	0xb0(%rsp), %rsi
               	leaq	0x240(%rsp), %rax
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pclmulqdq	$0x11, %xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	subq	$0x20, %rsp
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x6, %eax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movabsq	$-0x57cee3d060245c3b, %rax # imm = 0xA8311C2F9FDBA3C5
               	movabsq	$-0x74efb4a721281a6b, %rcx # imm = 0x8B104B58DED7E595
               	movq	%rcx, 0xc0(%rsp)
               	movq	%rax, 0xc8(%rsp)
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x3d0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0x3d0(%rsp)
               	movq	%rcx, 0x3d8(%rsp)
               	movups	0x3d0(%rsp), %xmm0
               	movups	%xmm0, 0x250(%rsp)
               	leaq	0x250(%rsp), %rax
               	leaq	0x3d0(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%r13, 0x3d0(%rsp)
               	movq	%r14, 0x3d8(%rsp)
               	leaq	0x260(%rsp), %rcx
               	movups	0x3d0(%rsp), %xmm0
               	movups	%xmm0, 0x260(%rsp)
               	leaq	0x270(%rsp), %rdi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	aesenc	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdi)
               	leaq	0x3e0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0x3e0(%rsp)
               	movq	%rsi, 0x3e8(%rsp)
               	leaq	0x3e0(%rsp), %rax
               	leaq	0x280(%rsp), %rcx
               	movups	0x3e0(%rsp), %xmm0
               	movups	%xmm0, 0x280(%rsp)
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rbx, 0x3e0(%rsp)
               	movq	%r12, 0x3e8(%rsp)
               	leaq	0x290(%rsp), %rax
               	movups	0x3e0(%rsp), %xmm0
               	movups	%xmm0, 0x290(%rsp)
               	leaq	0x2a0(%rsp), %rdx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	aesenc	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movq	0x270(%rsp), %rcx
               	movq	0x278(%rsp), %rax
               	movq	0x2a0(%rsp), %rdx
               	movq	0x2a8(%rsp), %rsi
               	leaq	0x60(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movq	%rcx, 0x60(%rsp)
               	movq	%rax, 0x68(%rsp)
               	movq	%rdx, 0x70(%rsp)
               	movq	%rsi, 0x78(%rsp)
               	movq	0x60(%rsp), %rcx
               	leaq	0x60(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rcx, 0x60(%rsp)
               	movq	%rax, 0x68(%rsp)
               	movups	0x60(%rsp), %xmm0
               	leaq	0xc0(%rsp), %rcx
               	leaq	0x40(%rsp), %rdx
               	movups	%xmm0, 0x40(%rsp)
               	leaq	0x60(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x3f0(%rsp), %rcx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rax), %xmm14
               	pcmpeqb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x8(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	pmovmskb	%xmm14, %r11d
               	movl	%r11d, (%rax)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	jne	<addr>
               	xorl	%eax, %eax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x7, %eax
               	jmp	<addr>
