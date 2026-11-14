
x86_fma_nan_operands_keep_their_sign.x64:	file format elf64-x86-64

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

<bits>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movss	%xmm0, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	leave
               	retq

<val>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm0
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movl	$0x7fc00001, %edi       # imm = 0x7FC00001
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm14
               	movups	%xmm14, -0x10(%rbp)
               	movl	$0x3f800000, %edi       # imm = 0x3F800000
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x10(%rbp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x10(%rbp)
               	movl	$0x7f800003, %edi       # imm = 0x7F800003
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x10(%rbp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x10(%rbp)
               	movl	$0x7fc00001, %edi       # imm = 0x7FC00001
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x10(%rbp), %xmm14
               	vpinsrd	$0x3, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x10(%rbp)
               	movl	$0x40000000, %edi       # imm = 0x40000000
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm14
               	movups	%xmm14, -0x20(%rbp)
               	movl	$0x40000000, %edi       # imm = 0x40000000
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x20(%rbp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x20(%rbp)
               	movl	$0x40000000, %edi       # imm = 0x40000000
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x20(%rbp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x20(%rbp)
               	movl	$0xffc00002, %edi       # imm = 0xFFC00002
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x20(%rbp), %xmm14
               	vpinsrd	$0x3, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x20(%rbp)
               	movl	$0x3f800000, %edi       # imm = 0x3F800000
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm14
               	movups	%xmm14, -0x30(%rbp)
               	movl	$0xffc00002, %edi       # imm = 0xFFC00002
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x30(%rbp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x30(%rbp)
               	movl	$0x7fc00001, %edi       # imm = 0x7FC00001
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x30(%rbp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x30(%rbp)
               	movl	$0x3f800000, %edi       # imm = 0x3F800000
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x30(%rbp), %xmm14
               	vpinsrd	$0x3, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x30(%rbp)
               	movapd	%xmm14, %xmm0
               	movups	-0x10(%rbp), %xmm1
               	movups	-0x20(%rbp), %xmm2
               	vmovaps	%ymm0, %ymm3
               	vfmadd231ps	%xmm2, %xmm1, %xmm3 # xmm3 = (xmm1 * xmm2) + xmm3
               	movups	%xmm3, (%rsp)
               	vmovaps	%ymm0, %ymm3
               	vfmsub231ps	%xmm2, %xmm1, %xmm3 # xmm3 = (xmm1 * xmm2) - xmm3
               	movups	%xmm3, 0x10(%rsp)
               	vmovaps	%ymm0, %ymm3
               	vfnmadd231ps	%xmm2, %xmm1, %xmm3 # xmm3 = -(xmm1 * xmm2) + xmm3
               	movups	%xmm3, 0x20(%rsp)
               	vmovaps	%ymm0, %ymm3
               	vfnmsub231ps	%xmm2, %xmm1, %xmm3 # xmm3 = -(xmm1 * xmm2) - xmm3
               	movups	%xmm3, 0x30(%rsp)
               	vmovaps	%ymm0, %ymm3
               	vfmaddsub231ps	%xmm2, %xmm1, %xmm3 # xmm3 = (xmm1 * xmm2) +/- xmm3
               	movups	%xmm3, 0x40(%rsp)
               	vfmsubadd231ps	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm2) -/+ xmm0
               	movups	%xmm0, 0x50(%rsp)
               	xorl	%ebx, %ebx
               	leaq	(%rsp), %rax
               	movq	%rbx, %r12
               	shlq	$0x4, %r12
               	addq	%r12, %rax
               	movss	(%rax), %xmm0
               	vzeroupper
               	callq	<addr>
               	cmpl	$0x7fc00001, %eax       # imm = 0x7FC00001
               	jne	<addr>
               	leaq	(%rsp), %rax
               	addq	%r12, %rax
               	movss	0x4(%rax), %xmm0
               	vzeroupper
               	callq	<addr>
               	cmpl	$0xffc00002, %eax       # imm = 0xFFC00002
               	jne	<addr>
               	leaq	(%rsp), %rax
               	movq	%rbx, %r12
               	shlq	$0x4, %r12
               	addq	%r12, %rax
               	movss	0x8(%rax), %xmm0
               	vzeroupper
               	callq	<addr>
               	cmpl	$0x7fc00003, %eax       # imm = 0x7FC00003
               	jne	<addr>
               	leaq	(%rsp), %rax
               	addq	%r12, %rax
               	movss	0xc(%rax), %xmm0
               	vzeroupper
               	callq	<addr>
               	cmpl	$0x7fc00001, %eax       # imm = 0x7FC00001
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x6, %ebx
               	jl	<addr>
               	movups	-0x10(%rbp), %xmm0
               	vmovdqa	%xmm0, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	movups	-0x20(%rbp), %xmm1
               	vmovdqa	%xmm1, %xmm2
               	vinserti128	$0x1, %xmm1, %ymm2, %ymm1
               	movups	-0x30(%rbp), %xmm2
               	vmovdqa	%xmm2, %xmm3
               	vinserti128	$0x1, %xmm2, %ymm3, %ymm2
               	vmovaps	%ymm2, %ymm3
               	vfnmadd231ps	%ymm1, %ymm0, %ymm3 # ymm3 = -(ymm0 * ymm1) + ymm3
               	vmovups	%ymm3, (%rsp)
               	vmovaps	%ymm2, %ymm3
               	vfmsub231ps	%ymm1, %ymm0, %ymm3 # ymm3 = (ymm0 * ymm1) - ymm3
               	vmovups	%ymm3, 0x20(%rsp)
               	vfmsubadd231ps	%ymm1, %ymm0, %ymm2 # ymm2 = (ymm0 * ymm1) -/+ ymm2
               	vmovups	%ymm2, 0x40(%rsp)
               	xorl	%ebx, %ebx
               	leaq	(%rsp), %rax
               	movq	%rbx, %r12
               	shlq	$0x5, %r12
               	addq	%r12, %rax
               	movss	(%rax), %xmm0
               	vzeroupper
               	callq	<addr>
               	cmpl	$0x7fc00001, %eax       # imm = 0x7FC00001
               	jne	<addr>
               	leaq	(%rsp), %rax
               	addq	%r12, %rax
               	movss	0x4(%rax), %xmm0
               	vzeroupper
               	callq	<addr>
               	cmpl	$0xffc00002, %eax       # imm = 0xFFC00002
               	jne	<addr>
               	leaq	(%rsp), %rax
               	movq	%rbx, %r12
               	shlq	$0x5, %r12
               	addq	%r12, %rax
               	movss	0x8(%rax), %xmm0
               	vzeroupper
               	callq	<addr>
               	cmpl	$0x7fc00003, %eax       # imm = 0x7FC00003
               	jne	<addr>
               	leaq	(%rsp), %rax
               	addq	%r12, %rax
               	movss	0xc(%rax), %xmm0
               	vzeroupper
               	callq	<addr>
               	cmpl	$0x7fc00001, %eax       # imm = 0x7FC00001
               	jne	<addr>
               	leaq	(%rsp), %rax
               	movq	%rbx, %r12
               	shlq	$0x5, %r12
               	addq	%r12, %rax
               	movss	0x10(%rax), %xmm0
               	vzeroupper
               	callq	<addr>
               	cmpl	$0x7fc00001, %eax       # imm = 0x7FC00001
               	jne	<addr>
               	leaq	(%rsp), %rax
               	addq	%r12, %rax
               	movss	0x14(%rax), %xmm0
               	vzeroupper
               	callq	<addr>
               	cmpl	$0xffc00002, %eax       # imm = 0xFFC00002
               	jne	<addr>
               	leaq	(%rsp), %rax
               	movq	%rbx, %r12
               	shlq	$0x5, %r12
               	addq	%r12, %rax
               	movss	0x18(%rax), %xmm0
               	vzeroupper
               	callq	<addr>
               	cmpl	$0x7fc00003, %eax       # imm = 0x7FC00003
               	jne	<addr>
               	leaq	(%rsp), %rax
               	addq	%r12, %rax
               	movss	0x1c(%rax), %xmm0
               	vzeroupper
               	callq	<addr>
               	cmpl	$0x7fc00001, %eax       # imm = 0x7FC00001
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x3, %ebx
               	jl	<addr>
               	movabsq	$0x7ff8000000000001, %rdi # imm = 0x7FF8000000000001
               	movabsq	$-0x7fffffffffffe, %rcx # imm = 0xFFF8000000000002
               	movq	%rdi, %xmm15
               	vmovq	%xmm15, %r11
               	vmovq	%r11, %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	vmovq	%xmm15, %r11
               	vpinsrq	$0x1, %r11, %xmm0, %xmm0
               	vmovdqa	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	vmovq	%xmm15, %r11
               	vmovq	%r11, %xmm1
               	movq	%rcx, %xmm15
               	vmovq	%xmm15, %r11
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm1
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movq	%rdx, %xmm15
               	vmovq	%xmm15, %r11
               	vmovq	%r11, %xmm0
               	movq	%rdx, %xmm15
               	vmovq	%xmm15, %r11
               	vpinsrq	$0x1, %r11, %xmm0, %xmm0
               	vmovdqa	%xmm0, %xmm0
               	movq	%rcx, %xmm15
               	vmovq	%xmm15, %r11
               	vmovq	%r11, %xmm2
               	movq	%rdx, %xmm15
               	vmovq	%xmm15, %r11
               	vpinsrq	$0x1, %r11, %xmm2, %xmm2
               	vinserti128	$0x1, %xmm2, %ymm0, %ymm2
               	movq	%rax, %xmm15
               	vmovq	%xmm15, %r11
               	vmovq	%r11, %xmm0
               	movabsq	$-0x7fffffffffffe, %rax # imm = 0xFFF8000000000002
               	movq	%rax, %xmm15
               	vmovq	%xmm15, %r11
               	vpinsrq	$0x1, %r11, %xmm0, %xmm0
               	vmovdqa	%xmm0, %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	vmovq	%xmm15, %r11
               	vmovq	%r11, %xmm3
               	movabsq	$0x7ff8000000000001, %rax # imm = 0x7FF8000000000001
               	movq	%rax, %xmm15
               	vmovq	%xmm15, %r11
               	vpinsrq	$0x1, %r11, %xmm3, %xmm3
               	vinserti128	$0x1, %xmm3, %ymm0, %ymm3
               	vmovaps	%ymm3, %ymm0
               	vfnmsub231pd	%ymm2, %ymm1, %ymm0 # ymm0 = -(ymm1 * ymm2) - ymm0
               	leaq	(%rsp), %r8
               	vmovups	%ymm0, (%rsp)
               	vmovaps	%ymm3, %ymm0
               	vfmsub231pd	%ymm2, %ymm1, %ymm0 # ymm0 = (ymm1 * ymm2) - ymm0
               	vmovups	%ymm0, 0x20(%rsp)
               	vmovaps	%ymm3, %ymm0
               	vfmaddsub231pd	%ymm2, %ymm1, %ymm0 # ymm0 = (ymm1 * ymm2) +/- ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	vmovaps	%ymm3, %ymm0
               	vfnmadd231pd	%ymm2, %ymm1, %ymm0 # ymm0 = -(ymm1 * ymm2) + ymm0
               	vmovups	%ymm0, 0x60(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	$0x5, %rdx
               	leaq	(%r8,%rdx), %rsi
               	movsd	(%rsi), %xmm0
               	movq	%xmm0, %r9
               	cmpq	%rdi, %r9
               	jne	<addr>
               	movsd	0x8(%rsi), %xmm0
               	movq	%xmm0, %rsi
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	leaq	(%rsp), %rsi
               	addq	%rsi, %rdx
               	movsd	0x10(%rdx), %xmm0
               	movq	%xmm0, %rdx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	leaq	(%rsp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x5, %rsi
               	addq	%rsi, %rdx
               	movsd	0x18(%rdx), %xmm0
               	movq	%xmm0, %rdx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	vmovdqa	%xmm1, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vmovdqa	%xmm3, %xmm2
               	vmovaps	%ymm2, %ymm14
               	vfnmadd231pd	%xmm1, %xmm0, %xmm14 # xmm14 = -(xmm0 * xmm1) + xmm14
               	vmovaps	%ymm14, %ymm0
               	vpermilpd	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0]
               	movq	%xmm1, %rax
               	cmpq	%rdi, %rax
               	jne	<addr>
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	movq	%xmm0, %rax
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	vzeroupper
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	vzeroupper
               	leave
               	retq
               	addq	$0xa, %rax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	vzeroupper
               	leave
               	retq
               	leaq	0x7(%rbx), %rax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	vzeroupper
               	leave
               	retq
               	leaq	0x1(%rbx), %rax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	vzeroupper
               	leave
               	retq
