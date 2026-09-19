
arrays_basic.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	leaq	-0x18(%rbp), %rdx
               	movl	$0x1, (%rdx)
               	movl	$0x2, 0x4(%rdx)
               	movl	$0x3, 0x8(%rdx)
               	movl	$0x4, 0xc(%rdx)
               	movl	$0x5, 0x10(%rdx)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movslq	(%rdx,%rax,4), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	cmpl	$0xf, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	$0x0, (%rax)
               	movl	$0xa, 0x4(%rax)
               	movl	$0x14, 0x8(%rax)
               	movl	$0x1e, 0xc(%rax)
               	movl	$0x28, 0x10(%rax)
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rsi
               	addq	%rsi, %rcx
               	movslq	0x8(%rax), %rsi
               	addq	%rsi, %rcx
               	movslq	0xc(%rax), %rsi
               	addq	%rsi, %rcx
               	movslq	0x10(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0x64, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movb	$0x68, (%rax)
               	movl	$0x69, %ecx
               	movb	%cl, 0x1(%rax)
               	movb	$0x0, 0x2(%rax)
               	movsbq	%cl, %rcx
               	cmpl	$0x69, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	cmpb	$0x0, 0x2(%rax)
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
