
asm_empty_barrier.x64:	file format elf64-x86-64

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
               	movl	$0x29, %eax
               	movl	%eax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x10(%rbp), %rax
               	movslq	-0x10(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x10(%rbp)
               	leaq	<rip>, %rcx
               	movl	%eax, (%rcx)
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x20(%rbp)
               	movq	-0x20(%rbp), %r10
               	movl	(%r10), %eax
               	movq	-0x20(%rbp), %r10
               	movl	%eax, (%r10)
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x1234, %eax           # imm = 0x1234
               	leaq	-0x8(%rbp), %rcx
               	movq	%rcx, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	-0x18(%rbp), %rax
               	movq	-0x20(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x1234, %rax           # imm = 0x1234
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movq	-0x18(%rbp), %rax
               	movq	-0x20(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x8(%rbp), %rax
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x5678, %eax           # imm = 0x5678
               	leaq	-0x8(%rbp), %rcx
               	movq	%rcx, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	-0x18(%rbp), %rax
               	movq	-0x20(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x5678, %rax           # imm = 0x5678
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	subq	$0x2a, %rax
               	movslq	%eax, %rax
               	leave
               	retq
