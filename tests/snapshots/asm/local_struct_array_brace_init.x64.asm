
local_struct_array_brace_init.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	leaq	-0x68(%rbp), %rdx
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdx)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rdx)
               	movq	0x20(%rax), %rcx
               	movq	%rcx, 0x20(%rdx)
               	movq	0x28(%rax), %rcx
               	movq	%rcx, 0x28(%rdx)
               	popq	%rcx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdx, %rsi
               	movq	0x8(%rsi), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpq	$0xc, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x68(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	leaq	-0x38(%rbp), %rcx
               	movq	%rcx, (%rax)
               	movq	$0x10, 0x8(%rax)
               	leaq	-0x28(%rbp), %rcx
               	movq	%rcx, 0x10(%rax)
               	movq	$0x20, 0x18(%rax)
               	leaq	-0x8(%rbp), %rcx
               	movq	%rcx, 0x20(%rax)
               	movq	$0x8, 0x28(%rax)
               	leaq	-0x68(%rbp), %rdx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdx, %rsi
               	movq	0x8(%rsi), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpq	$0x38, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x68(%rbp), %rax
               	movq	(%rax), %rcx
               	leaq	-0x38(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movq	0x10(%rax), %rcx
               	leaq	-0x28(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movq	0x20(%rax), %rcx
               	leaq	-0x8(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movq	0x28(%rax), %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
