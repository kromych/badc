
inline_struct_param_write.x64:	file format elf64-x86-64

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

<use_bump>:
               	movq	(%rdi), %rax
               	addq	$0x6, %rax
               	imulq	$0x64, %rax, %rax
               	addq	$0x6, %rax
               	retq

<use_overwrite>:
               	movq	(%rdi), %rax
               	movq	0x8(%rdi), %rcx
               	imulq	$0xa, %rax, %rax
               	addq	%rcx, %rax
               	retq

<use_alias>:
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0x7, 0x10(%rax)
               	leaq	0xa410(%rcx), %rax
               	retq

<use_shuffle>:
               	movq	(%rdi), %rax
               	movq	0x8(%rdi), %rcx
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	-0x28(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movq	0x20(%rax), %r10
               	movq	%r10, 0x20(%rdi)
               	movl	$0x6, %esi
               	callq	<addr>
               	cmpq	$0x2c2, %rax            # imm = 0x2C2
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %rax
               	movq	(%rax), %rcx
               	cmpq	$0x1, %rcx
               	jne	<addr>
               	movq	0x20(%rax), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	$0x3, (%rax)
               	movq	$0x4, 0x8(%rax)
               	leaq	-0x48(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	callq	<addr>
               	cmpq	$0x59, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpq	$0x3, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	leaq	-0x28(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	0x20(%rcx), %r10
               	movq	%r10, 0x20(%rax)
               	callq	<addr>
               	cmpq	$0xa411, %rax           # imm = 0xA411
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x10(%rax), %rcx
               	cmpq	$0x7, %rcx
               	jne	<addr>
               	movq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	callq	<addr>
               	cmpq	$0x34, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
