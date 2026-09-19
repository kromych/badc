
inline_indirect_call_region_share.x64:	file format elf64-x86-64

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

<twice>:
               	movq	(%rdi), %rax
               	shlq	%rax
               	movq	%rax, (%rdi)
               	retq

<negate>:
               	movq	(%rdi), %rax
               	imulq	$-0x1, %rax, %rax
               	movq	%rax, (%rdi)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x20(%rbp), %rax
               	movq	$0x3, (%rax)
               	movq	$0x4, 0x8(%rax)
               	movq	$0x5, 0x10(%rax)
               	movq	$0x6, 0x18(%rax)
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	callq	*%rax
               	leaq	-0x20(%rbp), %rax
               	leaq	0x18(%rax), %rdi
               	movq	(%rbx), %rax
               	callq	*%rax
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x10(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x18(%rax), %rdx
               	leaq	(%rcx,%rdx), %r12
               	leaq	<rip>, %rcx
               	leaq	-<rip>, %rdx       # <addr>
               	movq	%rdx, (%rcx)
               	movq	$0xa, (%rax)
               	movq	$0xb, 0x8(%rax)
               	movq	$0xc, 0x10(%rax)
               	leaq	-0x20(%rbp), %rax
               	movq	$0xd, 0x18(%rax)
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	callq	*%rax
               	leaq	-0x20(%rbp), %rax
               	leaq	0x18(%rax), %rdi
               	movq	(%rbx), %rax
               	callq	*%rax
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x10(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x18(%rax), %rax
               	addq	%rcx, %rax
               	cmpq	$0x1c, %r12
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	cmpq	$-0x2, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
