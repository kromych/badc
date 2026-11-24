
packed_union_tail_padding.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x88, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x10(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x10, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x88, %rsp
               	retq
               	leaq	0x8(%rsp), %rax
               	leaq	0x3c(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x3c, %rcx
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x88, %rsp
               	retq
               	movb	$0x7, 0x7b(%rsp)
               	xorl	%eax, %eax
               	addq	$0x88, %rsp
               	retq
