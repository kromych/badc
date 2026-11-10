
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
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	vmovups	(%rsp), %ymm2
               	pcmpeqb	%xmm2, %xmm0
               	pmovmskb	%xmm0, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	vmovups	(%rsp), %ymm0
               	vextracti128	$0x1, %ymm0, %xmm0
               	pcmpeqb	%xmm1, %xmm0
               	pmovmskb	%xmm0, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	sete	%al
               	movzbq	%al, %rax
               	vzeroupper
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movabsq	$0x7b5b546573745665, %rcx # imm = 0x7B5B546573745665
               	movabsq	$0x63746f725d53475d, %rdx # imm = 0x63746F725D53475D
               	xorl	%eax, %eax
               	vmovq	%rdx, %xmm0
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %rcx, %xmm14, %xmm14
               	movups	%xmm14, -0x50(%rbp)
               	movabsq	$0x123456789abcdef, %rcx # imm = 0x123456789ABCDEF
               	movabsq	$0xf1e2d3c4b5a6978, %rdx # imm = 0xF1E2D3C4B5A6978
               	vmovq	%rdx, %xmm0
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %rcx, %xmm14, %xmm14
               	movups	%xmm14, -0x60(%rbp)
               	movabsq	$0x4869285368617929, %rcx # imm = 0x4869285368617929
               	movabsq	$0x5b477565726f6e5d, %rdx # imm = 0x5B477565726F6E5D
               	vmovq	%rdx, %xmm0
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %rcx, %xmm14, %xmm14
               	movups	%xmm14, -0x70(%rbp)
               	movabsq	$0x1122334455667788, %rcx # imm = 0x1122334455667788
               	movabsq	$-0x6655443322110100, %rdx # imm = 0x99AABBCCDDEEFF00
               	vmovq	%rdx, %xmm0
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %rcx, %xmm14, %xmm14
               	movups	%xmm14, -0x80(%rbp)
               	movups	-0x50(%rbp), %xmm2
               	vmovdqa	%xmm2, %xmm0
               	movups	-0x60(%rbp), %xmm3
               	vinserti128	$0x1, %xmm3, %ymm0, %ymm14
               	vmovups	%ymm14, -0x20(%rbp)
               	movups	-0x70(%rbp), %xmm4
               	vmovdqa	%xmm4, %xmm0
               	movups	-0x80(%rbp), %xmm5
               	vinserti128	$0x1, %xmm5, %ymm0, %ymm14
               	vmovups	%ymm14, -0x40(%rbp)
               	leaq	(%rsp), %r9
               	vmovups	-0x20(%rbp), %ymm0
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpextrq	$0x0, %xmm15, %rcx
               	vmovq	%rcx, %xmm1
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpextrq	$0x1, %xmm15, %rcx
               	movapd	%xmm1, %xmm6
               	vpinsrq	$0x1, %rcx, %xmm6, %xmm6
               	vmovups	-0x40(%rbp), %ymm1
               	vextracti128	$0x0, %ymm1, %xmm15
               	vpextrq	$0x0, %xmm15, %rcx
               	vmovq	%rcx, %xmm7
               	vextracti128	$0x0, %ymm1, %xmm15
               	vpextrq	$0x1, %xmm15, %rax
               	vpinsrq	$0x1, %rax, %xmm7, %xmm7
               	aesenc	%xmm7, %xmm6
               	xorl	%eax, %eax
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpextrq	$0x0, %xmm15, %rcx
               	vmovq	%rcx, %xmm7
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpextrq	$0x1, %xmm15, %rcx
               	movapd	%xmm7, %xmm0
               	vpinsrq	$0x1, %rcx, %xmm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm15
               	vpextrq	$0x0, %xmm15, %rcx
               	vmovq	%rcx, %xmm7
               	vextracti128	$0x1, %ymm1, %xmm15
               	vpextrq	$0x1, %xmm15, %rcx
               	movapd	%xmm7, %xmm1
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	aesenc	%xmm1, %xmm0
               	vpextrq	$0x0, %xmm6, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm6, %rax
               	vextracti128	$0x0, %ymm1, %xmm15
               	vpinsrq	$0x1, %rax, %xmm15, %xmm15
               	vinserti128	$0x0, %xmm15, %ymm1, %ymm1
               	vpextrq	$0x0, %xmm0, %rax
               	vextracti128	$0x1, %ymm1, %xmm15
               	vpinsrq	$0x0, %rax, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm1, %ymm1
               	vpextrq	$0x1, %xmm0, %rax
               	vmovaps	%ymm1, %ymm0
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpinsrq	$0x1, %rax, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
               	vmovups	%ymm0, (%rsp)
               	leaq	0x20(%rsp), %rax
               	movapd	%xmm2, %xmm0
               	aesenc	%xmm4, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x30(%rsp), %rcx
               	movapd	%xmm3, %xmm0
               	aesenc	%xmm5, %xmm0
               	movups	%xmm0, 0x30(%rsp)
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
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	vzeroupper
               	leave
               	retq
               	leaq	(%rsp), %r9
               	xorl	%eax, %eax
               	vmovups	-0x20(%rbp), %ymm0
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpextrq	$0x0, %xmm15, %rcx
               	vmovq	%rcx, %xmm1
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpextrq	$0x1, %xmm15, %rcx
               	movapd	%xmm1, %xmm2
               	vpinsrq	$0x1, %rcx, %xmm2, %xmm2
               	vmovups	-0x40(%rbp), %ymm1
               	vextracti128	$0x0, %ymm1, %xmm15
               	vpextrq	$0x0, %xmm15, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x0, %ymm1, %xmm15
               	vpextrq	$0x1, %xmm15, %rcx
               	vpinsrq	$0x1, %rcx, %xmm3, %xmm3
               	aesenclast	%xmm3, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpextrq	$0x0, %xmm15, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpextrq	$0x1, %xmm15, %rcx
               	movapd	%xmm3, %xmm0
               	vpinsrq	$0x1, %rcx, %xmm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm15
               	vpextrq	$0x0, %xmm15, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm1, %xmm15
               	vpextrq	$0x1, %xmm15, %rcx
               	movapd	%xmm3, %xmm1
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	aesenclast	%xmm1, %xmm0
               	vpextrq	$0x0, %xmm2, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm2, %rax
               	vextracti128	$0x0, %ymm1, %xmm15
               	vpinsrq	$0x1, %rax, %xmm15, %xmm15
               	vinserti128	$0x0, %xmm15, %ymm1, %ymm1
               	vpextrq	$0x0, %xmm0, %rax
               	vextracti128	$0x1, %ymm1, %xmm15
               	vpinsrq	$0x0, %rax, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm1, %ymm1
               	vpextrq	$0x1, %xmm0, %rax
               	vmovaps	%ymm1, %ymm0
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpinsrq	$0x1, %rax, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
               	vmovups	%ymm0, (%rsp)
               	leaq	0x20(%rsp), %rax
               	movups	-0x70(%rbp), %xmm14
               	movups	-0x50(%rbp), %xmm0
               	aesenclast	%xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x30(%rsp), %rcx
               	movups	-0x80(%rbp), %xmm14
               	movups	-0x60(%rbp), %xmm0
               	aesenclast	%xmm14, %xmm0
               	movups	%xmm0, 0x30(%rsp)
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
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	vzeroupper
               	leave
               	retq
               	leaq	(%rsp), %r9
               	xorl	%eax, %eax
               	vmovups	-0x20(%rbp), %ymm0
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpextrq	$0x0, %xmm15, %rcx
               	vmovq	%rcx, %xmm1
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpextrq	$0x1, %xmm15, %rcx
               	movapd	%xmm1, %xmm2
               	vpinsrq	$0x1, %rcx, %xmm2, %xmm2
               	vmovups	-0x40(%rbp), %ymm1
               	vextracti128	$0x0, %ymm1, %xmm15
               	vpextrq	$0x0, %xmm15, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x0, %ymm1, %xmm15
               	vpextrq	$0x1, %xmm15, %rcx
               	vpinsrq	$0x1, %rcx, %xmm3, %xmm3
               	aesdec	%xmm3, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpextrq	$0x0, %xmm15, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpextrq	$0x1, %xmm15, %rcx
               	movapd	%xmm3, %xmm0
               	vpinsrq	$0x1, %rcx, %xmm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm15
               	vpextrq	$0x0, %xmm15, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm1, %xmm15
               	vpextrq	$0x1, %xmm15, %rcx
               	movapd	%xmm3, %xmm1
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	aesdec	%xmm1, %xmm0
               	vpextrq	$0x0, %xmm2, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm2, %rax
               	vextracti128	$0x0, %ymm1, %xmm15
               	vpinsrq	$0x1, %rax, %xmm15, %xmm15
               	vinserti128	$0x0, %xmm15, %ymm1, %ymm1
               	vpextrq	$0x0, %xmm0, %rax
               	vextracti128	$0x1, %ymm1, %xmm15
               	vpinsrq	$0x0, %rax, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm1, %ymm1
               	vpextrq	$0x1, %xmm0, %rax
               	vmovaps	%ymm1, %ymm0
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpinsrq	$0x1, %rax, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
               	vmovups	%ymm0, (%rsp)
               	leaq	0x20(%rsp), %rax
               	movups	-0x70(%rbp), %xmm14
               	movups	-0x50(%rbp), %xmm0
               	aesdec	%xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x30(%rsp), %rcx
               	movups	-0x80(%rbp), %xmm14
               	movups	-0x60(%rbp), %xmm0
               	aesdec	%xmm14, %xmm0
               	movups	%xmm0, 0x30(%rsp)
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
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	vzeroupper
               	leave
               	retq
               	leaq	(%rsp), %r9
               	xorl	%eax, %eax
               	vmovups	-0x20(%rbp), %ymm0
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpextrq	$0x0, %xmm15, %rcx
               	vmovq	%rcx, %xmm1
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpextrq	$0x1, %xmm15, %rcx
               	movapd	%xmm1, %xmm2
               	vpinsrq	$0x1, %rcx, %xmm2, %xmm2
               	vmovups	-0x40(%rbp), %ymm1
               	vextracti128	$0x0, %ymm1, %xmm15
               	vpextrq	$0x0, %xmm15, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x0, %ymm1, %xmm15
               	vpextrq	$0x1, %xmm15, %rcx
               	vpinsrq	$0x1, %rcx, %xmm3, %xmm3
               	aesdeclast	%xmm3, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpextrq	$0x0, %xmm15, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpextrq	$0x1, %xmm15, %rcx
               	movapd	%xmm3, %xmm0
               	vpinsrq	$0x1, %rcx, %xmm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm15
               	vpextrq	$0x0, %xmm15, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm1, %xmm15
               	vpextrq	$0x1, %xmm15, %rcx
               	movapd	%xmm3, %xmm1
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	aesdeclast	%xmm1, %xmm0
               	vpextrq	$0x0, %xmm2, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm2, %rax
               	vextracti128	$0x0, %ymm1, %xmm15
               	vpinsrq	$0x1, %rax, %xmm15, %xmm15
               	vinserti128	$0x0, %xmm15, %ymm1, %ymm1
               	vpextrq	$0x0, %xmm0, %rax
               	vextracti128	$0x1, %ymm1, %xmm15
               	vpinsrq	$0x0, %rax, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm1, %ymm1
               	vpextrq	$0x1, %xmm0, %rax
               	vmovaps	%ymm1, %ymm0
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpinsrq	$0x1, %rax, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
               	vmovups	%ymm0, (%rsp)
               	leaq	0x20(%rsp), %rax
               	movups	-0x70(%rbp), %xmm14
               	movups	-0x50(%rbp), %xmm0
               	aesdeclast	%xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x30(%rsp), %rcx
               	movups	-0x80(%rbp), %xmm14
               	movups	-0x60(%rbp), %xmm0
               	aesdeclast	%xmm14, %xmm0
               	movups	%xmm0, 0x30(%rsp)
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
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	vzeroupper
               	leave
               	retq
               	leaq	(%rsp), %r9
               	xorl	%eax, %eax
               	vmovups	-0x20(%rbp), %ymm0
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpextrq	$0x0, %xmm15, %rcx
               	vmovq	%rcx, %xmm1
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpextrq	$0x1, %xmm15, %rcx
               	movapd	%xmm1, %xmm2
               	vpinsrq	$0x1, %rcx, %xmm2, %xmm2
               	vmovups	-0x40(%rbp), %ymm1
               	vextracti128	$0x0, %ymm1, %xmm15
               	vpextrq	$0x0, %xmm15, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x0, %ymm1, %xmm15
               	vpextrq	$0x1, %xmm15, %rcx
               	vpinsrq	$0x1, %rcx, %xmm3, %xmm3
               	pclmulqdq	$0x0, %xmm3, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpextrq	$0x0, %xmm15, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpextrq	$0x1, %xmm15, %rcx
               	movapd	%xmm3, %xmm0
               	vpinsrq	$0x1, %rcx, %xmm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm15
               	vpextrq	$0x0, %xmm15, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm1, %xmm15
               	vpextrq	$0x1, %xmm15, %rcx
               	movapd	%xmm3, %xmm1
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	pclmulqdq	$0x0, %xmm1, %xmm0
               	vpextrq	$0x0, %xmm2, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm2, %rax
               	vextracti128	$0x0, %ymm1, %xmm15
               	vpinsrq	$0x1, %rax, %xmm15, %xmm15
               	vinserti128	$0x0, %xmm15, %ymm1, %ymm1
               	vpextrq	$0x0, %xmm0, %rax
               	vextracti128	$0x1, %ymm1, %xmm15
               	vpinsrq	$0x0, %rax, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm1, %ymm1
               	vpextrq	$0x1, %xmm0, %rax
               	vmovaps	%ymm1, %ymm0
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpinsrq	$0x1, %rax, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
               	vmovups	%ymm0, (%rsp)
               	leaq	0x20(%rsp), %rax
               	movups	-0x70(%rbp), %xmm14
               	movups	-0x50(%rbp), %xmm0
               	pclmulqdq	$0x0, %xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x30(%rsp), %rcx
               	movups	-0x80(%rbp), %xmm14
               	movups	-0x60(%rbp), %xmm0
               	pclmulqdq	$0x0, %xmm14, %xmm0
               	movups	%xmm0, 0x30(%rsp)
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
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x5, %eax
               	vzeroupper
               	leave
               	retq
               	leaq	(%rsp), %r9
               	xorl	%eax, %eax
               	vmovups	-0x20(%rbp), %ymm0
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpextrq	$0x0, %xmm15, %rcx
               	vmovq	%rcx, %xmm1
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpextrq	$0x1, %xmm15, %rcx
               	movapd	%xmm1, %xmm2
               	vpinsrq	$0x1, %rcx, %xmm2, %xmm2
               	vmovups	-0x40(%rbp), %ymm1
               	vextracti128	$0x0, %ymm1, %xmm15
               	vpextrq	$0x0, %xmm15, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x0, %ymm1, %xmm15
               	vpextrq	$0x1, %xmm15, %rcx
               	vpinsrq	$0x1, %rcx, %xmm3, %xmm3
               	pclmulqdq	$0x11, %xmm3, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpextrq	$0x0, %xmm15, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpextrq	$0x1, %xmm15, %rcx
               	movapd	%xmm3, %xmm0
               	vpinsrq	$0x1, %rcx, %xmm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm15
               	vpextrq	$0x0, %xmm15, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm1, %xmm15
               	vpextrq	$0x1, %xmm15, %rcx
               	movapd	%xmm3, %xmm1
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	pclmulqdq	$0x11, %xmm1, %xmm0
               	vpextrq	$0x0, %xmm2, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm2, %rax
               	vextracti128	$0x0, %ymm1, %xmm15
               	vpinsrq	$0x1, %rax, %xmm15, %xmm15
               	vinserti128	$0x0, %xmm15, %ymm1, %ymm1
               	vpextrq	$0x0, %xmm0, %rax
               	vextracti128	$0x1, %ymm1, %xmm15
               	vpinsrq	$0x0, %rax, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm1, %ymm1
               	vpextrq	$0x1, %xmm0, %rax
               	vmovaps	%ymm1, %ymm0
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpinsrq	$0x1, %rax, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
               	vmovups	%ymm0, (%rsp)
               	leaq	0x20(%rsp), %rax
               	movups	-0x70(%rbp), %xmm14
               	movups	-0x50(%rbp), %xmm0
               	pclmulqdq	$0x11, %xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x30(%rsp), %rcx
               	movups	-0x80(%rbp), %xmm14
               	movups	-0x60(%rbp), %xmm0
               	pclmulqdq	$0x11, %xmm14, %xmm0
               	movups	%xmm0, 0x30(%rsp)
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
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x6, %eax
               	vzeroupper
               	leave
               	retq
               	movabsq	$-0x57cee3d060245c3b, %rcx # imm = 0xA8311C2F9FDBA3C5
               	movabsq	$-0x74efb4a721281a6b, %rdx # imm = 0x8B104B58DED7E595
               	xorl	%eax, %eax
               	vmovq	%rdx, %xmm0
               	movapd	%xmm0, %xmm3
               	vpinsrq	$0x1, %rcx, %xmm3, %xmm3
               	vmovups	-0x20(%rbp), %ymm0
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpextrq	$0x0, %xmm15, %rcx
               	vmovq	%rcx, %xmm1
               	vextracti128	$0x0, %ymm0, %xmm15
               	vpextrq	$0x1, %xmm15, %rcx
               	movapd	%xmm1, %xmm2
               	vpinsrq	$0x1, %rcx, %xmm2, %xmm2
               	vmovups	-0x40(%rbp), %ymm1
               	vextracti128	$0x0, %ymm1, %xmm15
               	vpextrq	$0x0, %xmm15, %rcx
               	vmovq	%rcx, %xmm4
               	vextracti128	$0x0, %ymm1, %xmm15
               	vpextrq	$0x1, %xmm15, %rcx
               	vpinsrq	$0x1, %rcx, %xmm4, %xmm4
               	aesenc	%xmm4, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpextrq	$0x0, %xmm15, %rcx
               	vmovq	%rcx, %xmm4
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpextrq	$0x1, %xmm15, %rcx
               	movapd	%xmm4, %xmm0
               	vpinsrq	$0x1, %rcx, %xmm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm15
               	vpextrq	$0x0, %xmm15, %rcx
               	vmovq	%rcx, %xmm4
               	vextracti128	$0x1, %ymm1, %xmm15
               	vpextrq	$0x1, %xmm15, %rcx
               	movapd	%xmm4, %xmm1
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	aesenc	%xmm1, %xmm0
               	vpextrq	$0x0, %xmm2, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm2, %rax
               	vextracti128	$0x0, %ymm1, %xmm15
               	vpinsrq	$0x1, %rax, %xmm15, %xmm15
               	vinserti128	$0x0, %xmm15, %ymm1, %ymm1
               	vpextrq	$0x0, %xmm0, %rax
               	vextracti128	$0x1, %ymm1, %xmm15
               	vpinsrq	$0x0, %rax, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm1, %ymm1
               	vpextrq	$0x1, %xmm0, %rax
               	vmovaps	%ymm1, %ymm0
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpinsrq	$0x1, %rax, %xmm15, %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
               	pcmpeqb	%xmm3, %xmm0
               	pmovmskb	%xmm0, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	jne	<addr>
               	xorl	%eax, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x7, %eax
               	jmp	<addr>
