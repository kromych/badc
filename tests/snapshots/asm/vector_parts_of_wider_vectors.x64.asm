
vector_parts_of_wider_vectors.x64:	file format elf64-x86-64

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

<lo>:
               	vzeroupper
               	retq

<hi>:
               	vextracti128	$0x1, %ymm0, %xmm0
               	vzeroupper
               	retq

<swapped>:
               	vpextrq	$0x1, %xmm0, %rax
               	vmovq	%rax, %xmm1
               	vmovq	%xmm0, %rax
               	movapd	%xmm1, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vzeroupper
               	retq

<mixed>:
               	vmovq	%xmm0, %rax
               	vmovq	%rax, %xmm1
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm1, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vzeroupper
               	retq

<top>:
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	retq

<bottom>:
               	retq

<upper>:
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	$0x64, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	leaq	(%rsp), %r9
               	movq	%rax, (%rsp)
               	movq	-0x8(%rbp), %rax
               	incq	%rax
               	movq	%rax, 0x8(%rsp)
               	movq	-0x8(%rbp), %rax
               	addq	$0x2, %rax
               	movq	%rax, 0x10(%rsp)
               	movq	-0x8(%rbp), %rax
               	addq	$0x3, %rax
               	movq	%rax, 0x18(%rsp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	vmovq	%xmm0, %rax
               	cmpq	$0x64, %rax
               	jne	<addr>
               	vpextrq	$0x1, %xmm0, %rax
               	cmpq	$0x65, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	(%rsp), %r9
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	vmovq	%xmm0, %rax
               	cmpq	$0x66, %rax
               	jne	<addr>
               	vpextrq	$0x1, %xmm0, %rax
               	cmpq	$0x67, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	(%rsp), %r9
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	vmovq	%xmm0, %rax
               	cmpq	$0x65, %rax
               	jne	<addr>
               	vpextrq	$0x1, %xmm0, %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	(%rsp), %r9
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	vmovq	%xmm0, %rax
               	cmpq	$0x64, %rax
               	jne	<addr>
               	vpextrq	$0x1, %xmm0, %rax
               	cmpq	$0x67, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	-0x8(%rbp), %rax
               	leaq	(%rsp), %r9
               	movl	%eax, (%rsp)
               	movq	-0x8(%rbp), %rax
               	shlq	%rax
               	movl	%eax, 0x4(%rsp)
               	movq	-0x8(%rbp), %rax
               	leaq	(%rax,%rax,2), %rax
               	movl	%eax, 0x8(%rsp)
               	movq	-0x8(%rbp), %rax
               	shlq	$0x2, %rax
               	movl	%eax, 0xc(%rsp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	jne	<addr>
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x190, %rax            # imm = 0x190
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	(%rsp), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x64, %rax
               	jne	<addr>
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0xc8, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	(%rsp), %rcx
               	movq	-0x8(%rbp), %rdx
               	addq	%rax, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	(%rsp), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movsd	%xmm0, -0x10(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	movq	-0x8(%rbp), %rsi
               	addq	$0x8, %rsi
               	addq	%rax, %rsi
               	andq	$0xff, %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x7, %eax
               	leave
               	retq
