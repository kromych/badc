
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
               	vmovdqa	%xmm0, %xmm3
               	vpcmpeqb	%xmm1, %xmm3, %xmm1
               	pmovmskb	%xmm1, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpcmpeqb	%xmm2, %xmm0, %xmm0
               	pmovmskb	%xmm0, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	sete	%al
               	movzbq	%al, %rax
               	vzeroupper
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, -0x50(%rbp)
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, -0x60(%rbp)
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, -0x70(%rbp)
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
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
               	vmovups	-0x20(%rbp), %ymm0
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm1, %xmm6
               	vpinsrq	$0x1, %rax, %xmm6, %xmm6
               	vmovups	-0x40(%rbp), %ymm1
               	vmovq	%xmm1, %rcx
               	vmovq	%rcx, %xmm7
               	vpextrq	$0x1, %xmm1, %rax
               	vpinsrq	$0x1, %rax, %xmm7, %xmm7
               	vaesenc	%xmm7, %xmm6, %xmm6
               	vextracti128	$0x1, %ymm0, %xmm7
               	vmovq	%xmm7, %rcx
               	vmovq	%rcx, %xmm7
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm7, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm7
               	vmovq	%xmm7, %rcx
               	vmovq	%rcx, %xmm7
               	vextracti128	$0x1, %ymm1, %xmm1
               	vpextrq	$0x1, %xmm1, %rax
               	movapd	%xmm7, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vaesenc	%xmm1, %xmm0, %xmm0
               	vmovq	%xmm6, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm6, %rcx
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	vmovdqa	%xmm1, %xmm1
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm6
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm6, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	(%rsp), %r9
               	vmovups	%ymm0, (%rsp)
               	leaq	0x20(%rsp), %rax
               	vaesenc	%xmm4, %xmm2, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x30(%rsp), %rcx
               	vaesenc	%xmm5, %xmm3, %xmm0
               	movups	%xmm0, 0x30(%rsp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	vzeroupper
               	leave
               	retq
               	vmovups	-0x20(%rbp), %ymm0
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm1, %xmm2
               	vpinsrq	$0x1, %rax, %xmm2, %xmm2
               	vmovups	-0x40(%rbp), %ymm1
               	vmovq	%xmm1, %rcx
               	vmovq	%rcx, %xmm3
               	vpextrq	$0x1, %xmm1, %rax
               	vpinsrq	$0x1, %rax, %xmm3, %xmm3
               	vaesenclast	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm3
               	vmovq	%xmm3, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm3, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm3
               	vmovq	%xmm3, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm1, %xmm1
               	vpextrq	$0x1, %xmm1, %rax
               	movapd	%xmm3, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vaesenclast	%xmm1, %xmm0, %xmm0
               	vmovq	%xmm2, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm2, %rcx
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	vmovdqa	%xmm1, %xmm1
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm2
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	(%rsp), %r9
               	vmovups	%ymm0, (%rsp)
               	leaq	0x20(%rsp), %rax
               	movups	-0x50(%rbp), %xmm14
               	movups	-0x70(%rbp), %xmm15
               	vaesenclast	%xmm15, %xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x30(%rsp), %rcx
               	movups	-0x60(%rbp), %xmm14
               	movups	-0x80(%rbp), %xmm15
               	vaesenclast	%xmm15, %xmm14, %xmm0
               	movups	%xmm0, 0x30(%rsp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	vzeroupper
               	leave
               	retq
               	vmovups	-0x20(%rbp), %ymm0
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm1, %xmm2
               	vpinsrq	$0x1, %rax, %xmm2, %xmm2
               	vmovups	-0x40(%rbp), %ymm1
               	vmovq	%xmm1, %rcx
               	vmovq	%rcx, %xmm3
               	vpextrq	$0x1, %xmm1, %rax
               	vpinsrq	$0x1, %rax, %xmm3, %xmm3
               	vaesdec	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm3
               	vmovq	%xmm3, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm3, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm3
               	vmovq	%xmm3, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm1, %xmm1
               	vpextrq	$0x1, %xmm1, %rax
               	movapd	%xmm3, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vaesdec	%xmm1, %xmm0, %xmm0
               	vmovq	%xmm2, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm2, %rcx
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	vmovdqa	%xmm1, %xmm1
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm2
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	(%rsp), %r9
               	vmovups	%ymm0, (%rsp)
               	leaq	0x20(%rsp), %rax
               	movups	-0x50(%rbp), %xmm14
               	movups	-0x70(%rbp), %xmm15
               	vaesdec	%xmm15, %xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x30(%rsp), %rcx
               	movups	-0x60(%rbp), %xmm14
               	movups	-0x80(%rbp), %xmm15
               	vaesdec	%xmm15, %xmm14, %xmm0
               	movups	%xmm0, 0x30(%rsp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	vzeroupper
               	leave
               	retq
               	vmovups	-0x20(%rbp), %ymm0
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm1, %xmm2
               	vpinsrq	$0x1, %rax, %xmm2, %xmm2
               	vmovups	-0x40(%rbp), %ymm1
               	vmovq	%xmm1, %rcx
               	vmovq	%rcx, %xmm3
               	vpextrq	$0x1, %xmm1, %rax
               	vpinsrq	$0x1, %rax, %xmm3, %xmm3
               	vaesdeclast	%xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm3
               	vmovq	%xmm3, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm3, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm3
               	vmovq	%xmm3, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm1, %xmm1
               	vpextrq	$0x1, %xmm1, %rax
               	movapd	%xmm3, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vaesdeclast	%xmm1, %xmm0, %xmm0
               	vmovq	%xmm2, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm2, %rcx
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	vmovdqa	%xmm1, %xmm1
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm2
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	(%rsp), %r9
               	vmovups	%ymm0, (%rsp)
               	leaq	0x20(%rsp), %rax
               	movups	-0x50(%rbp), %xmm14
               	movups	-0x70(%rbp), %xmm15
               	vaesdeclast	%xmm15, %xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x30(%rsp), %rcx
               	movups	-0x60(%rbp), %xmm14
               	movups	-0x80(%rbp), %xmm15
               	vaesdeclast	%xmm15, %xmm14, %xmm0
               	movups	%xmm0, 0x30(%rsp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	vzeroupper
               	leave
               	retq
               	vmovups	-0x20(%rbp), %ymm0
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm1, %xmm2
               	vpinsrq	$0x1, %rax, %xmm2, %xmm2
               	vmovups	-0x40(%rbp), %ymm1
               	vmovq	%xmm1, %rcx
               	vmovq	%rcx, %xmm3
               	vpextrq	$0x1, %xmm1, %rax
               	vpinsrq	$0x1, %rax, %xmm3, %xmm3
               	vpclmulqdq	$0x0, %xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm3
               	vmovq	%xmm3, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm3, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm3
               	vmovq	%xmm3, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm1, %xmm1
               	vpextrq	$0x1, %xmm1, %rax
               	movapd	%xmm3, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vpclmulqdq	$0x0, %xmm1, %xmm0, %xmm0
               	vmovq	%xmm2, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm2, %rcx
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	vmovdqa	%xmm1, %xmm1
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm2
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	(%rsp), %r9
               	vmovups	%ymm0, (%rsp)
               	leaq	0x20(%rsp), %rax
               	movups	-0x50(%rbp), %xmm14
               	movups	-0x70(%rbp), %xmm15
               	vpclmulqdq	$0x0, %xmm15, %xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x30(%rsp), %rcx
               	movups	-0x60(%rbp), %xmm14
               	movups	-0x80(%rbp), %xmm15
               	vpclmulqdq	$0x0, %xmm15, %xmm14, %xmm0
               	movups	%xmm0, 0x30(%rsp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x5, %eax
               	vzeroupper
               	leave
               	retq
               	vmovups	-0x20(%rbp), %ymm0
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm1, %xmm2
               	vpinsrq	$0x1, %rax, %xmm2, %xmm2
               	vmovups	-0x40(%rbp), %ymm1
               	vmovq	%xmm1, %rcx
               	vmovq	%rcx, %xmm3
               	vpextrq	$0x1, %xmm1, %rax
               	vpinsrq	$0x1, %rax, %xmm3, %xmm3
               	vpclmulqdq	$0x11, %xmm3, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm3
               	vmovq	%xmm3, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm3, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm3
               	vmovq	%xmm3, %rcx
               	vmovq	%rcx, %xmm3
               	vextracti128	$0x1, %ymm1, %xmm1
               	vpextrq	$0x1, %xmm1, %rax
               	movapd	%xmm3, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vpclmulqdq	$0x11, %xmm1, %xmm0, %xmm0
               	vmovq	%xmm2, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm2, %rcx
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	vmovdqa	%xmm1, %xmm1
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm2
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	(%rsp), %r9
               	vmovups	%ymm0, (%rsp)
               	leaq	0x20(%rsp), %rax
               	movups	-0x50(%rbp), %xmm14
               	movups	-0x70(%rbp), %xmm15
               	vpclmulqdq	$0x11, %xmm15, %xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x30(%rsp), %rcx
               	movups	-0x60(%rbp), %xmm14
               	movups	-0x80(%rbp), %xmm15
               	vpclmulqdq	$0x11, %xmm15, %xmm14, %xmm0
               	movups	%xmm0, 0x30(%rsp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x6, %eax
               	vzeroupper
               	leave
               	retq
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm3
               	vmovups	-0x20(%rbp), %ymm0
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm1, %xmm2
               	vpinsrq	$0x1, %rax, %xmm2, %xmm2
               	vmovups	-0x40(%rbp), %ymm1
               	vmovq	%xmm1, %rcx
               	vmovq	%rcx, %xmm4
               	vpextrq	$0x1, %xmm1, %rax
               	vpinsrq	$0x1, %rax, %xmm4, %xmm4
               	vaesenc	%xmm4, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm4
               	vmovq	%xmm4, %rcx
               	vmovq	%rcx, %xmm4
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm4, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm4
               	vmovq	%xmm4, %rcx
               	vmovq	%rcx, %xmm4
               	vextracti128	$0x1, %ymm1, %xmm1
               	vpextrq	$0x1, %xmm1, %rax
               	movapd	%xmm4, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vaesenc	%xmm1, %xmm0, %xmm0
               	xorl	%eax, %eax
               	vmovq	%xmm2, %rcx
               	vmovq	%rcx, %xmm1
               	vpextrq	$0x1, %xmm2, %rcx
               	vpinsrq	$0x1, %rcx, %xmm1, %xmm1
               	vmovdqa	%xmm1, %xmm1
               	vmovq	%xmm0, %rcx
               	vmovq	%rcx, %xmm2
               	vpextrq	$0x1, %xmm0, %rcx
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rcx, %xmm0, %xmm0
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vpcmpeqb	%xmm3, %xmm0, %xmm0
               	pmovmskb	%xmm0, %ecx
               	movl	$0x7, %edx
               	cmpl	$0xffff, %ecx           # imm = 0xFFFF
               	cmovneq	%rdx, %rax
               	vzeroupper
               	leave
               	retq
