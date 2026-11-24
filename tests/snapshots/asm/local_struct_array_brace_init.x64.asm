
local_struct_array_brace_init.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x78, %rsp
               	leaq	0x40(%rsp), %rdx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movups	0x20(%rax), %xmm14
               	movups	%xmm14, 0x20(%rdx)
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
               	addq	$0x78, %rsp
               	retq
               	leaq	0x10(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movq	%rax, 0x40(%rsp)
               	movq	$0x10, 0x48(%rsp)
               	leaq	0x20(%rsp), %rax
               	movq	%rax, 0x50(%rsp)
               	movq	$0x20, 0x58(%rsp)
               	leaq	0x8(%rsp), %rax
               	movq	%rax, 0x60(%rsp)
               	movq	$0x8, 0x68(%rsp)
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
               	addq	$0x78, %rsp
               	retq
               	movq	0x40(%rsp), %rax
               	leaq	0x10(%rsp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x78, %rsp
               	retq
               	movq	0x50(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x78, %rsp
               	retq
               	movq	0x60(%rsp), %rax
               	leaq	0x8(%rsp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x78, %rsp
               	retq
               	movq	0x68(%rsp), %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x78, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x78, %rsp
               	retq
