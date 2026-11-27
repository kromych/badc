
vla_parameter.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<rows>:
               	movslq	%edi, %rdi
               	leaq	(%rsi,%rdi), %rax
               	subq	%rsi, %rax
               	cmpq	%rdi, %rax
               	sete	%al
               	movzbq	%al, %rax
               	retq

<sum>:
               	movslq	%edi, %rdi
               	movq	%rdi, %r10
               	shlq	$0x2, %r10
               	xorl	%r9d, %r9d
               	movq	%r9, %rcx
               	xorl	%eax, %eax
               	movq	%r9, %rdx
               	imulq	%r10, %rdx
               	addq	%rsi, %rdx
               	nopl	(%rax)
               	cmpl	%edi, %eax
               	jge	<addr>
               	movl	(%rdx,%rax,4), %r8d
               	addq	%r8, %rcx
               	incq	%rax
               	cmpl	%edi, %eax
               	jl	<addr>
               	incq	%r9
               	cmpl	$0x2, %r9d
               	jl	<addr>
               	movslq	%r10d, %rax
               	movq	%rax, %rdx
               	shrq	$0x3e, %rdx
               	addq	%rdx, %rax
               	sarq	$0x2, %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	addq	%rcx, %rax
               	retq

<main>:
               	subq	$0x68, %rsp
               	leaq	(%rsp), %r8
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%r8)
               	leaq	0x18(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	movups	0x30(%rcx), %xmm14
               	movups	%xmm14, 0x30(%rax)
               	movq	0x40(%rcx), %r10
               	movq	%r10, 0x40(%rax)
               	leaq	0x50(%rsp), %rcx
               	leaq	0x5(%rcx), %rax
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	cmpq	$0x5, %rdx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%r9b
               	movzbq	%r9b, %r9
               	leaq	0x5(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x5, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	orq	%rax, %r9
               	xorl	%edi, %edi
               	movq	%rdi, %rcx
               	imulq	$0xc, %rdi, %rax
               	leaq	(%r8,%rax), %rdx
               	xorl	%eax, %eax
               	movl	(%rdx,%rax,4), %esi
               	addq	%rsi, %rcx
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x3, %eax
               	jl	<addr>
               	incq	%rdi
               	cmpl	$0x2, %edi
               	jl	<addr>
               	leaq	0xbb8(%rcx), %rax
               	cmpl	$0xbcd, %eax            # imm = 0xBCD
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x2, %rax
               	orq	%r9, %rax
               	leaq	0x18(%rsp), %rsi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	imulq	$0x18, %rcx, %rdi
               	addq	%rsi, %rdi
               	movq	(%rdi,%rcx,8), %rdi
               	addq	%rdi, %rdx
               	incq	%rcx
               	cmpl	$0x3, %ecx
               	jl	<addr>
               	leaq	0xc8(%rdx), %rcx
               	addq	$0x7530, %rcx           # imm = 0x7530
               	cmpl	$0x75fe, %ecx           # imm = 0x75FE
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x3, %rcx
               	orq	%rcx, %rax
               	addq	$0x68, %rsp
               	retq
