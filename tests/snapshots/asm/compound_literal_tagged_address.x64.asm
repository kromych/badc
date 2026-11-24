
compound_literal_tagged_address.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	orq	$0x1, %rcx
               	movq	%rcx, 0x8(%rsp)
               	movq	0x8(%rsp), %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	0x8(%rsp), %rcx
               	andq	$-0x2, %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	shrq	$0x2, %rax
               	movq	%rax, 0x8(%rsp)
               	movq	0x8(%rsp), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1e, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
