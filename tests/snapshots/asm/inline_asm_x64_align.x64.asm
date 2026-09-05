
inline_asm_x64_align.x64:	file format elf64-x86-64

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
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movl	$0x1, %eax
               	nopl	(%rax)
               	addl	$0x2, %eax
               	movq	-0x18(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x20(%rbp), %rax
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movl	$0x5, %eax
               	nop
               	addl	$0x6, %eax
               	movq	-0x18(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x20(%rbp), %rax
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movl	$0x7, %eax
               	nop
               	addl	$0x8, %eax
               	movq	-0x18(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x20(%rbp), %rax
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movl	$0x9, %eax
               	nop
               	addl	$0x4, %eax
               	movq	-0x18(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x20(%rbp), %rax
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0xd, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
