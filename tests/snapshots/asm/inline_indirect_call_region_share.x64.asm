
inline_indirect_call_region_share.x64:	file format elf64-x86-64

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

<twice>:
               	movq	(%rdi), %rax
               	shlq	%rax
               	movq	%rax, (%rdi)
               	retq

<negate>:
               	movq	(%rdi), %rax
               	negq	%rax
               	movq	%rax, (%rdi)
               	retq

<main>:
               	subq	$0x38, %rsp
               	leaq	0x10(%rsp), %rax
               	movq	$0x3, 0x10(%rsp)
               	movq	$0x4, 0x18(%rsp)
               	movq	$0x5, 0x20(%rsp)
               	movq	$0x6, 0x28(%rsp)
               	leaq	0x8(%rax), %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	leaq	0x10(%rsp), %rax
               	leaq	0x18(%rax), %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	leaq	0x10(%rsp), %rax
               	movq	0x10(%rsp), %rcx
               	movq	0x18(%rsp), %rdx
               	addq	%rdx, %rcx
               	movq	0x20(%rsp), %rdx
               	addq	%rdx, %rcx
               	movq	0x28(%rsp), %rdx
               	leaq	(%rcx,%rdx), %r10
               	movq	%r10, 0x8(%rsp)
               	leaq	-<rip>, %rcx # <addr>
               	movq	%rcx, <rip> # <addr>
               	movq	$0xa, 0x10(%rsp)
               	movq	$0xb, 0x18(%rsp)
               	movq	$0xc, 0x20(%rsp)
               	movq	$0xd, 0x28(%rsp)
               	leaq	0x8(%rax), %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	leaq	0x10(%rsp), %rax
               	leaq	0x18(%rax), %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movq	0x10(%rsp), %rax
               	movq	0x18(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x20(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x28(%rsp), %rcx
               	addq	%rax, %rcx
               	movq	0x8(%rsp), %rax
               	cmpq	$0x1c, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x38, %rsp
               	retq
               	cmpq	$-0x2, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	$0x2a, %eax
               	addq	$0x38, %rsp
               	retq
