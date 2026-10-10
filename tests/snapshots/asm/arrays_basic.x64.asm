
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
               	movl	$0x1, -0x18(%rbp)
               	movl	$0x2, -0x14(%rbp)
               	movl	$0x3, -0x10(%rbp)
               	movl	$0x4, -0xc(%rbp)
               	movl	$0x5, -0x8(%rbp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movl	(%rdx,%rax,4), %esi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	cmpl	$0xf, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	$0x0, (%rax)
               	movl	$0xa, 0x4(%rax)
               	movl	$0x14, 0x8(%rax)
               	movl	$0x1e, 0xc(%rax)
               	movl	$0x28, 0x10(%rax)
               	movl	(%rax), %edx
               	movl	0x4(%rax), %esi
               	addq	%rsi, %rdx
               	movl	0x8(%rax), %esi
               	addq	%rsi, %rdx
               	movl	0xc(%rax), %esi
               	addq	%rsi, %rdx
               	movl	0x10(%rax), %eax
               	addq	%rdx, %rax
               	cmpl	$0x64, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movb	$0x68, (%rax)
               	movl	$0x69, %edx
               	movb	%dl, 0x1(%rax)
               	movb	$0x0, 0x2(%rax)
               	movsbq	%dl, %rcx
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
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	addq	%rdx, %rcx
               	movl	0x8(%rax), %eax
               	addq	%rcx, %rax
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
