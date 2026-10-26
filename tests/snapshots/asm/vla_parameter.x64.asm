
vla_parameter.x64:	file format elf64-x86-64

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

<rows>:
               	movslq	%edi, %rdi
               	cmpl	%edi, %edi
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	(%rsi,%rdi), %rax
               	subq	%rsi, %rax
               	cmpq	%rdi, %rax
               	sete	%al
               	movzbq	%al, %rax
               	retq

<sum>:
               	movslq	%edi, %rdi
               	movq	%rdi, %r8
               	shlq	$0x2, %r8
               	xorl	%edx, %edx
               	movq	%rdx, %rcx
               	xorl	%eax, %eax
               	cmpl	%edi, %eax
               	jge	<addr>
               	movq	%rdx, %r9
               	imulq	%r8, %r9
               	addq	%rsi, %r9
               	movl	(%r9,%rax,4), %r9d
               	addq	%r9, %rcx
               	incq	%rax
               	cmpl	%edi, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x2, %edx
               	jl	<addr>
               	movslq	%r8d, %rax
               	movq	%rax, %rdx
               	shrq	$0x3e, %rdx
               	addq	%rdx, %rax
               	sarq	$0x2, %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	addq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	-0x60(%rbp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%rsi)
               	leaq	-0x48(%rbp), %rax
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
               	leaq	-0x10(%rbp), %rcx
               	leaq	0x5(%rcx), %rax
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	cmpq	$0x5, %rdx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	0x5(%rax), %rdx
               	subq	%rax, %rdx
               	cmpq	$0x5, %rdx
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	movq	%rcx, %r8
               	orq	%rax, %r8
               	xorl	%edx, %edx
               	movq	%rdx, %rcx
               	xorl	%eax, %eax
               	imulq	$0xc, %rdx, %rdi
               	addq	%rsi, %rdi
               	movl	(%rdi,%rax,4), %edi
               	addq	%rdi, %rcx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x2, %edx
               	jl	<addr>
               	leaq	0xbb8(%rcx), %rax
               	cmpl	$0xbcd, %eax            # imm = 0xBCD
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x2, %rax
               	movq	%r8, %rdi
               	orq	%rax, %rdi
               	leaq	-0x48(%rbp), %rdx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	imulq	$0x18, %rax, %rsi
               	addq	%rdx, %rsi
               	movq	(%rsi,%rax,8), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	leaq	0xc8(%rcx), %rax
               	addq	$0x7530, %rax           # imm = 0x7530
               	cmpl	$0x75fe, %eax           # imm = 0x75FE
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x3, %rax
               	orq	%rdi, %rax
               	leave
               	retq
