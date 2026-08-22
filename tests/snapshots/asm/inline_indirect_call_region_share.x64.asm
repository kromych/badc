
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
               	xorq	%rax, %rax
               	retq

<negate>:
               	movq	(%rdi), %rax
               	imulq	$-0x1, %rax, %rax
               	movq	%rax, (%rdi)
               	xorq	%rax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x3, %eax
               	leaq	-0x20(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x4, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x5, %ecx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x6, %ecx
               	movq	%rcx, 0x18(%rax)
               	leaq	-0x20(%rbp), %rax
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
               	leaq	-0x20(%rbp), %rax
               	movq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	0x10(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	0x18(%rax), %rax
               	leaq	(%rcx,%rax), %r12
               	leaq	<rip>, %rax
               	leaq	-<rip>, %rcx       # <addr>
               	movq	%rcx, (%rax)
               	movl	$0xa, %eax
               	leaq	-0x20(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x20(%rbp), %rax
               	movl	$0xb, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0xc, %ecx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0xd, %ecx
               	movq	%rcx, 0x18(%rax)
               	leaq	-0x20(%rbp), %rax
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
               	leaq	-0x20(%rbp), %rax
               	movq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	0x10(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	0x18(%rax), %rax
               	addq	%rax, %rcx
               	cmpq	$0x1c, %r12
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	cmpq	$-0x2, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
