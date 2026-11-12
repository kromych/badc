
local_aggregate_runtime_init.x64:	file format elf64-x86-64

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

<opaque>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x18(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	$0x0, 0x10(%rax)
               	leaq	<rip>, %rcx # <addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x18(%rbp)
               	movb	$0x68, -0x14(%rbp)
               	movb	$0x6f, -0x13(%rbp)
               	movb	$0x6c, -0x12(%rbp)
               	movb	$0x61, -0x11(%rbp)
               	movb	$0x0, -0x10(%rbp)
               	movb	$0x0, -0xf(%rbp)
               	movb	$0x0, -0xe(%rbp)
               	movb	$0x0, -0xd(%rbp)
               	movb	$0x0, -0xc(%rbp)
               	movb	$0x0, -0xb(%rbp)
               	leaq	-0x18(%rbp), %rdi
               	movq	%rcx, -0x8(%rbp)
               	callq	<addr>
               	movl	(%rax), %ecx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movsbq	0x4(%rax), %rcx
               	cmpl	$0x68, %ecx
               	jne	<addr>
               	movsbq	0x5(%rax), %rcx
               	cmpl	$0x6f, %ecx
               	jne	<addr>
               	movsbq	0x6(%rax), %rcx
               	cmpl	$0x6c, %ecx
               	jne	<addr>
               	movsbq	0x7(%rax), %rcx
               	cmpl	$0x61, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	cmpb	$0x0, 0x8(%rax)
               	jne	<addr>
               	cmpb	$0x0, 0xd(%rax)
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	0x10(%rax), %rax
               	leaq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	leaq	-0x28(%rbp), %rdi
               	movl	%eax, -0x28(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x24(%rbp)
               	movl	$0x5, -0x20(%rbp)
               	callq	<addr>
               	movl	(%rax), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rcx
               	cmpl	$0x6f, %ecx
               	jne	<addr>
               	movsbq	0x1(%rax), %rax
               	cmpl	$0x6b, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
