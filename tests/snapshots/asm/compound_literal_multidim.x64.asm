
compound_literal_multidim.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	movq	(%rax), %rdx
               	movsbq	0x1(%rdx), %rdx
               	addq	%rdx, %rcx
               	movq	(%rax), %rdx
               	movsbq	0x2(%rdx), %rdx
               	addq	%rdx, %rcx
               	movq	(%rax), %rdx
               	addq	$0x3, %rdx
               	movsbq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movq	(%rax), %rdx
               	addq	$0x3, %rdx
               	movsbq	0x1(%rdx), %rdx
               	addq	%rdx, %rcx
               	movq	(%rax), %rdx
               	addq	$0x3, %rdx
               	movsbq	0x2(%rdx), %rdx
               	addq	%rdx, %rcx
               	cmpl	$0x15, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	movsbq	0x5(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0xa, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movslq	0xc(%rcx), %rcx
               	cmpl	$0xd, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	movslq	0x10(%rax), %rax
               	cmpl	$0xe, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rcx
               	leaq	<rip>, %rax
               	movl	(%rax), %r10d
               	movl	%r10d, (%rcx)
               	movzwq	0x4(%rax), %r10
               	movw	%r10w, 0x4(%rcx)
               	leaq	<rip>, %rax
               	movl	(%rax), %r10d
               	movl	%r10d, (%rcx)
               	movzwq	0x4(%rax), %r10
               	movw	%r10w, 0x4(%rcx)
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rdx), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rdx), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	<rip>, %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	movslq	0x4(%rdx), %rdx
               	cmpl	$0x15, %edx
               	jne	<addr>
               	movq	(%rcx), %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpl	$0x16, %ecx
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x18, %ecx
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movl	0x8(%rcx), %r10d
               	movl	%r10d, 0x8(%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x10(%rax), %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
