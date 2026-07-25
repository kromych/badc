
inline_asm_x64_align.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

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
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movl	$0x5, %eax
               	nopw	(%rax,%rax)
               	addl	$0x6, %eax
               	movq	-0x18(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x20(%rbp), %rax
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movl	$0x7, %eax
               	nopw	(%rax,%rax)
               	addl	$0x8, %eax
               	movq	-0x18(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x20(%rbp), %rax
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movl	$0x9, %eax
               	addl	$0x4, %eax
               	movq	-0x18(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x20(%rbp), %rax
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0xd, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
