
array_initializers.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rcx
               	cmpl	$0x68, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movsbq	0x4(%rax), %rcx
               	cmpl	$0x6f, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpb	$0x0, 0x5(%rax)
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x8(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0xc(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x10(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0x1c, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x68, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	0x1(%rax), %rax
               	cmpl	$0x69, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax
               	cmpb	$0x0, 0x2(%rax)
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	leaq	<rip>, %rax
               	cmpb	$0x0, 0xf(%rax)
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	leaq	<rip>, %rax
               	cmpl	$0x0, 0xc(%rax)
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	leaq	<rip>, %rax
               	cmpl	$0x0, 0x10(%rax)
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x61, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x62, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	0x10(%rax), %rax
               	movsbq	0x4(%rax), %rax
               	cmpl	$0x61, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	xorl	%eax, %eax
               	retq
