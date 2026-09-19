
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
               	leaq	(%rdx), %rax
               	movl	$0x1, (%rax)
               	movl	$0x2, 0x4(%rdx)
               	movl	$0x3, 0x8(%rdx)
               	movl	$0x4, 0xc(%rdx)
               	movl	$0x5, 0x10(%rdx)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	$0x5, %eax
               	jge	<addr>
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
               	addq	$0x0, %rax
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0xa, 0x4(%rax)
               	leaq	<rip>, %rax
               	movl	$0x14, 0x8(%rax)
               	leaq	<rip>, %rax
               	movl	$0x1e, 0xc(%rax)
               	leaq	<rip>, %rax
               	movl	$0x28, 0x10(%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	movslq	0x4(%rax), %rsi
               	addq	%rsi, %rdx
               	movslq	0x8(%rax), %rsi
               	addq	%rsi, %rdx
               	movslq	0xc(%rax), %rsi
               	addq	%rsi, %rdx
               	movslq	0x10(%rax), %rax
               	addq	%rdx, %rax
               	cmpl	$0x64, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movb	$0x68, (%rax)
               	movb	$0x69, 0x1(%rax)
               	movb	%cl, 0x2(%rax)
               	leaq	<rip>, %rax
               	movsbq	0x1(%rax), %rax
               	cmpl	$0x69, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	cmpb	$0x0, 0x2(%rax)
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rdx
               	movslq	0x4(%rax), %rsi
               	addq	%rsi, %rdx
               	movslq	0x8(%rax), %rax
               	addq	%rdx, %rax
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	movq	%rcx, %rax
               	leave
               	retq
