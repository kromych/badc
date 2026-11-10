
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
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
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
               	leaq	0x20(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rax, 0x20(%rsp)
               	movq	%rcx, 0x28(%rsp)
               	movups	0x20(%rsp), %xmm2
               	pcmpeqb	%xmm2, %xmm0
               	pmovmskb	%xmm0, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x10(%rsp), %rax
               	movq	0x18(%rsp), %rcx
               	leaq	0x20(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rax, 0x20(%rsp)
               	movq	%rcx, 0x28(%rsp)
               	movups	0x20(%rsp), %xmm0
               	pcmpeqb	%xmm1, %xmm0
               	pmovmskb	%xmm0, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0xe0, %rsp
               	andq	$-0x20, %rsp
               	movabsq	$0x7b5b546573745665, %rax # imm = 0x7B5B546573745665
               	movabsq	$0x63746f725d53475d, %rcx # imm = 0x63746F725D53475D
               	leaq	0x60(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rcx, 0x60(%rsp)
               	movq	%rax, 0x68(%rsp)
               	movups	0x60(%rsp), %xmm14
               	movups	%xmm14, -0x10(%rbp)
               	movabsq	$0x123456789abcdef, %rdx # imm = 0x123456789ABCDEF
               	movabsq	$0xf1e2d3c4b5a6978, %rsi # imm = 0xF1E2D3C4B5A6978
               	leaq	0x60(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rsi, 0x60(%rsp)
               	movq	%rdx, 0x68(%rsp)
               	movups	0x60(%rsp), %xmm14
               	movups	%xmm14, -0x20(%rbp)
               	movabsq	$0x4869285368617929, %rdi # imm = 0x4869285368617929
               	movabsq	$0x5b477565726f6e5d, %r8 # imm = 0x5B477565726F6E5D
               	leaq	0x60(%rsp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movq	%r8, 0x60(%rsp)
               	movq	%rdi, 0x68(%rsp)
               	movups	0x60(%rsp), %xmm14
               	movups	%xmm14, -0x30(%rbp)
               	movabsq	$0x1122334455667788, %r9 # imm = 0x1122334455667788
               	movabsq	$-0x6655443322110100, %rbx # imm = 0x99AABBCCDDEEFF00
               	leaq	0x60(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rbx, 0x60(%rsp)
               	movq	%r9, 0x68(%rsp)
               	movups	0x60(%rsp), %xmm14
               	movups	%xmm14, -0x40(%rbp)
               	movq	%rcx, (%rsp)
               	movq	%rax, 0x8(%rsp)
               	movq	%rsi, 0x10(%rsp)
               	movq	%rdx, 0x18(%rsp)
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x90(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rax, 0x90(%rsp)
               	movq	%rcx, 0x98(%rsp)
               	movups	0x90(%rsp), %xmm0
               	leaq	0x90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r8, 0x90(%rsp)
               	movq	%rdi, 0x98(%rsp)
               	movups	0x90(%rsp), %xmm1
               	aesenc	%xmm1, %xmm0
               	leaq	0xa0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xa0(%rsp)
               	movq	%rsi, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm1
               	leaq	0xa0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rbx, 0xa0(%rsp)
               	movq	%r9, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm2
               	aesenc	%xmm2, %xmm1
               	movups	%xmm0, 0xb0(%rsp)
               	movups	%xmm1, 0xc0(%rsp)
               	leaq	0x60(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	0xb0(%rsp), %rax
               	movq	%rax, 0x60(%rsp)
               	movq	0xb8(%rsp), %rax
               	movq	%rax, 0x68(%rsp)
               	movq	0xc0(%rsp), %rcx
               	movq	%rcx, 0x70(%rsp)
               	movq	0xc8(%rsp), %rdx
               	movq	%rdx, 0x78(%rsp)
               	movq	0x60(%rsp), %rsi
               	movq	%rsi, 0x40(%rsp)
               	movq	%rax, 0x48(%rsp)
               	movq	%rcx, 0x50(%rsp)
               	movq	%rdx, 0x58(%rsp)
               	leaq	0x40(%rsp), %r9
               	leaq	0x80(%rsp), %rax
               	movups	-0x30(%rbp), %xmm14
               	movups	-0x10(%rbp), %xmm0
               	aesenc	%xmm14, %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %rcx
               	movups	-0x40(%rbp), %xmm14
               	movups	-0x20(%rbp), %xmm0
               	aesenc	%xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
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
               	leave
               	retq
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x90(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0x90(%rsp)
               	movq	%rcx, 0x98(%rsp)
               	movups	0x90(%rsp), %xmm0
               	leaq	0x90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movabsq	$0x5b477565726f6e5d, %rax # imm = 0x5B477565726F6E5D
               	movq	%rax, 0x90(%rsp)
               	movabsq	$0x4869285368617929, %rax # imm = 0x4869285368617929
               	movq	%rax, 0x98(%rsp)
               	movups	0x90(%rsp), %xmm1
               	aesenclast	%xmm1, %xmm0
               	leaq	0xa0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xa0(%rsp)
               	movq	%rsi, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm1
               	leaq	0xa0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movabsq	$-0x6655443322110100, %rax # imm = 0x99AABBCCDDEEFF00
               	movq	%rax, 0xa0(%rsp)
               	movabsq	$0x1122334455667788, %rax # imm = 0x1122334455667788
               	movq	%rax, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm2
               	aesenclast	%xmm2, %xmm1
               	movups	%xmm0, 0xb0(%rsp)
               	movups	%xmm1, 0xc0(%rsp)
               	leaq	0x60(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	0xb0(%rsp), %rax
               	movq	%rax, 0x60(%rsp)
               	movq	0xb8(%rsp), %rax
               	movq	%rax, 0x68(%rsp)
               	movq	0xc0(%rsp), %rcx
               	movq	%rcx, 0x70(%rsp)
               	movq	0xc8(%rsp), %rdx
               	movq	%rdx, 0x78(%rsp)
               	movq	0x60(%rsp), %rsi
               	movq	%rsi, 0x40(%rsp)
               	movq	%rax, 0x48(%rsp)
               	movq	%rcx, 0x50(%rsp)
               	movq	%rdx, 0x58(%rsp)
               	leaq	0x40(%rsp), %r9
               	leaq	0x80(%rsp), %rax
               	movups	-0x30(%rbp), %xmm14
               	movups	-0x10(%rbp), %xmm0
               	aesenclast	%xmm14, %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %rcx
               	movups	-0x40(%rbp), %xmm14
               	movups	-0x20(%rbp), %xmm0
               	aesenclast	%xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
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
               	leave
               	retq
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x90(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0x90(%rsp)
               	movq	%rcx, 0x98(%rsp)
               	movups	0x90(%rsp), %xmm0
               	leaq	0x90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movabsq	$0x5b477565726f6e5d, %rax # imm = 0x5B477565726F6E5D
               	movq	%rax, 0x90(%rsp)
               	movabsq	$0x4869285368617929, %rax # imm = 0x4869285368617929
               	movq	%rax, 0x98(%rsp)
               	movups	0x90(%rsp), %xmm1
               	aesdec	%xmm1, %xmm0
               	leaq	0xa0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xa0(%rsp)
               	movq	%rsi, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm1
               	leaq	0xa0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movabsq	$-0x6655443322110100, %rax # imm = 0x99AABBCCDDEEFF00
               	movq	%rax, 0xa0(%rsp)
               	movabsq	$0x1122334455667788, %rax # imm = 0x1122334455667788
               	movq	%rax, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm2
               	aesdec	%xmm2, %xmm1
               	movups	%xmm0, 0xb0(%rsp)
               	movups	%xmm1, 0xc0(%rsp)
               	leaq	0x60(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	0xb0(%rsp), %rax
               	movq	%rax, 0x60(%rsp)
               	movq	0xb8(%rsp), %rax
               	movq	%rax, 0x68(%rsp)
               	movq	0xc0(%rsp), %rcx
               	movq	%rcx, 0x70(%rsp)
               	movq	0xc8(%rsp), %rdx
               	movq	%rdx, 0x78(%rsp)
               	movq	0x60(%rsp), %rsi
               	movq	%rsi, 0x40(%rsp)
               	movq	%rax, 0x48(%rsp)
               	movq	%rcx, 0x50(%rsp)
               	movq	%rdx, 0x58(%rsp)
               	leaq	0x40(%rsp), %r9
               	leaq	0x80(%rsp), %rax
               	movups	-0x30(%rbp), %xmm14
               	movups	-0x10(%rbp), %xmm0
               	aesdec	%xmm14, %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %rcx
               	movups	-0x40(%rbp), %xmm14
               	movups	-0x20(%rbp), %xmm0
               	aesdec	%xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
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
               	leave
               	retq
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x90(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0x90(%rsp)
               	movq	%rcx, 0x98(%rsp)
               	movups	0x90(%rsp), %xmm0
               	leaq	0x90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movabsq	$0x5b477565726f6e5d, %rax # imm = 0x5B477565726F6E5D
               	movq	%rax, 0x90(%rsp)
               	movabsq	$0x4869285368617929, %rax # imm = 0x4869285368617929
               	movq	%rax, 0x98(%rsp)
               	movups	0x90(%rsp), %xmm1
               	aesdeclast	%xmm1, %xmm0
               	leaq	0xa0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xa0(%rsp)
               	movq	%rsi, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm1
               	leaq	0xa0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movabsq	$-0x6655443322110100, %rax # imm = 0x99AABBCCDDEEFF00
               	movq	%rax, 0xa0(%rsp)
               	movabsq	$0x1122334455667788, %rax # imm = 0x1122334455667788
               	movq	%rax, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm2
               	aesdeclast	%xmm2, %xmm1
               	movups	%xmm0, 0xb0(%rsp)
               	movups	%xmm1, 0xc0(%rsp)
               	leaq	0x60(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	0xb0(%rsp), %rax
               	movq	%rax, 0x60(%rsp)
               	movq	0xb8(%rsp), %rax
               	movq	%rax, 0x68(%rsp)
               	movq	0xc0(%rsp), %rcx
               	movq	%rcx, 0x70(%rsp)
               	movq	0xc8(%rsp), %rdx
               	movq	%rdx, 0x78(%rsp)
               	movq	0x60(%rsp), %rsi
               	movq	%rsi, 0x40(%rsp)
               	movq	%rax, 0x48(%rsp)
               	movq	%rcx, 0x50(%rsp)
               	movq	%rdx, 0x58(%rsp)
               	leaq	0x40(%rsp), %r9
               	leaq	0x80(%rsp), %rax
               	movups	-0x30(%rbp), %xmm14
               	movups	-0x10(%rbp), %xmm0
               	aesdeclast	%xmm14, %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %rcx
               	movups	-0x40(%rbp), %xmm14
               	movups	-0x20(%rbp), %xmm0
               	aesdeclast	%xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
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
               	leave
               	retq
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x40(%rsp), %rdi
               	leaq	0x90(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rax, 0x90(%rsp)
               	movq	%rcx, 0x98(%rsp)
               	movups	0x90(%rsp), %xmm0
               	leaq	0x90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movabsq	$0x5b477565726f6e5d, %rax # imm = 0x5B477565726F6E5D
               	movq	%rax, 0x90(%rsp)
               	movabsq	$0x4869285368617929, %rax # imm = 0x4869285368617929
               	movq	%rax, 0x98(%rsp)
               	movups	0x90(%rsp), %xmm1
               	pclmulqdq	$0x0, %xmm1, %xmm0
               	leaq	0xa0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xa0(%rsp)
               	movq	%rsi, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm1
               	leaq	0xa0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movabsq	$-0x6655443322110100, %rax # imm = 0x99AABBCCDDEEFF00
               	movq	%rax, 0xa0(%rsp)
               	movabsq	$0x1122334455667788, %rax # imm = 0x1122334455667788
               	movq	%rax, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm2
               	pclmulqdq	$0x0, %xmm2, %xmm1
               	movups	%xmm0, 0xb0(%rsp)
               	movups	%xmm1, 0xc0(%rsp)
               	leaq	0x60(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	0xb0(%rsp), %rax
               	movq	%rax, 0x60(%rsp)
               	movq	0xb8(%rsp), %rax
               	movq	%rax, 0x68(%rsp)
               	movq	0xc0(%rsp), %rax
               	movq	%rax, 0x70(%rsp)
               	movq	0xc8(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movq	%rax, 0x78(%rsp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x40(%rsp), %r9
               	leaq	0x80(%rsp), %rax
               	movups	-0x30(%rbp), %xmm14
               	movups	-0x10(%rbp), %xmm0
               	pclmulqdq	$0x0, %xmm14, %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %rcx
               	movups	-0x40(%rbp), %xmm14
               	movups	-0x20(%rbp), %xmm0
               	pclmulqdq	$0x0, %xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
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
               	movl	$0x5, %eax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
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
               	leaq	0x90(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%rcx, 0x90(%rsp)
               	movq	%rdx, 0x98(%rsp)
               	movups	0x90(%rsp), %xmm0
               	leaq	0x90(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movabsq	$0x5b477565726f6e5d, %rcx # imm = 0x5B477565726F6E5D
               	movq	%rcx, 0x90(%rsp)
               	movabsq	$0x4869285368617929, %rcx # imm = 0x4869285368617929
               	movq	%rcx, 0x98(%rsp)
               	movups	0x90(%rsp), %xmm1
               	pclmulqdq	$0x11, %xmm1, %xmm0
               	movq	0x30(%rsp), %rcx
               	movq	0x38(%rsp), %rdx
               	leaq	0xa0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%rcx, 0xa0(%rsp)
               	movq	%rdx, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm1
               	leaq	0xa0(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movabsq	$-0x6655443322110100, %rcx # imm = 0x99AABBCCDDEEFF00
               	movq	%rcx, 0xa0(%rsp)
               	movabsq	$0x1122334455667788, %rcx # imm = 0x1122334455667788
               	movq	%rcx, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm2
               	pclmulqdq	$0x11, %xmm2, %xmm1
               	movups	%xmm0, 0xb0(%rsp)
               	movups	%xmm1, 0xc0(%rsp)
               	leaq	0x60(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movq	0xb0(%rsp), %rcx
               	movq	%rcx, 0x60(%rsp)
               	movq	0xb8(%rsp), %rcx
               	movq	%rcx, 0x68(%rsp)
               	movq	0xc0(%rsp), %rcx
               	movq	%rcx, 0x70(%rsp)
               	movq	0xc8(%rsp), %rcx
               	leaq	0x60(%rsp), %rdx
               	movq	%rcx, 0x78(%rsp)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x40(%rsp), %r9
               	leaq	0x80(%rsp), %rax
               	movups	-0x30(%rbp), %xmm14
               	movups	-0x10(%rbp), %xmm0
               	pclmulqdq	$0x11, %xmm14, %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %rcx
               	movups	-0x40(%rbp), %xmm14
               	movups	-0x20(%rbp), %xmm0
               	pclmulqdq	$0x11, %xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
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
               	movl	$0x6, %eax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movabsq	$-0x57cee3d060245c3b, %rax # imm = 0xA8311C2F9FDBA3C5
               	movabsq	$-0x74efb4a721281a6b, %rcx # imm = 0x8B104B58DED7E595
               	leaq	0x40(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rcx, 0x40(%rsp)
               	movq	%rax, 0x48(%rsp)
               	movups	0x40(%rsp), %xmm0
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	0x90(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0x90(%rsp)
               	movq	%rcx, 0x98(%rsp)
               	leaq	0x90(%rsp), %rax
               	movups	0x90(%rsp), %xmm1
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movabsq	$0x5b477565726f6e5d, %rax # imm = 0x5B477565726F6E5D
               	movq	%rax, 0x90(%rsp)
               	movabsq	$0x4869285368617929, %rax # imm = 0x4869285368617929
               	movq	%rax, 0x98(%rsp)
               	movups	0x90(%rsp), %xmm2
               	aesenc	%xmm2, %xmm1
               	leaq	0xa0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xa0(%rsp)
               	movq	%rsi, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm2
               	leaq	0xa0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movabsq	$-0x6655443322110100, %rax # imm = 0x99AABBCCDDEEFF00
               	movq	%rax, 0xa0(%rsp)
               	movabsq	$0x1122334455667788, %rax # imm = 0x1122334455667788
               	movq	%rax, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm3
               	aesenc	%xmm3, %xmm2
               	movups	%xmm1, 0xb0(%rsp)
               	movups	%xmm2, 0xc0(%rsp)
               	leaq	0x60(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	0xb0(%rsp), %rax
               	movq	%rax, 0x60(%rsp)
               	movq	0xb8(%rsp), %rax
               	movq	%rax, 0x68(%rsp)
               	movq	0xc0(%rsp), %rcx
               	movq	%rcx, 0x70(%rsp)
               	movq	0xc8(%rsp), %rcx
               	movq	%rcx, 0x78(%rsp)
               	movq	0x60(%rsp), %rcx
               	leaq	0x60(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rcx, 0x60(%rsp)
               	movq	%rax, 0x68(%rsp)
               	movups	0x60(%rsp), %xmm1
               	pcmpeqb	%xmm1, %xmm0
               	pmovmskb	%xmm0, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	jne	<addr>
               	xorl	%eax, %eax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x7, %eax
               	jmp	<addr>
