
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
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rax
               	movq	<rip>, %rcx # <addr>
               	movsbq	0x1(%rcx), %rcx
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	movsbq	0x2(%rcx), %rcx
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	addq	$0x3, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	addq	$0x3, %rcx
               	movsbq	0x1(%rcx), %rcx
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	addq	$0x3, %rcx
               	movsbq	0x2(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpl	$0x15, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	0x5(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0xa, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	0xc(%rax), %eax
               	cmpl	$0xd, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	0x10(%rax), %eax
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
               	movq	<rip>, %rcx # <addr>
               	movl	0x4(%rcx), %ecx
               	cmpl	$0x15, %ecx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	movl	0x8(%rcx), %ecx
               	cmpl	$0x16, %ecx
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movl	<rip>, %ecx # <addr>
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
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	0x10(%rax), %eax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	0x8(%rax), %eax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	0x8(%rax), %eax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
