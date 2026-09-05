
packed_union_tail_padding.x64:	file format elf64-x86-64

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
               	subq	$0xe0, %rsp
               	leaq	-0x20(%rbp), %rax
               	leaq	0x10(%rax), %rcx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	leaq	-0x98(%rbp), %rax
               	leaq	0x3c(%rax), %rcx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	-0xd8(%rbp), %rax
               	movl	$0x7, %ecx
               	movb	%cl, 0x3b(%rax)
               	movzbq	0x3b(%rax), %rax
               	xorq	$0x7, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
