
array_init_constant_expression.x64:	file format elf64-x86-64

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
               	movslq	(%rax), %rcx
               	cmpl	$0x10, %ecx
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movslq	0x4(%rax), %rcx
               	cmpl	$0x80, %ecx
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movslq	0x8(%rax), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x90, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x94, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x100, %eax            # imm = 0x100
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x40, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x11, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x70, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x30, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x90, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x18, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x19, %eax
               	retq
               	xorq	%rax, %rax
               	retq
