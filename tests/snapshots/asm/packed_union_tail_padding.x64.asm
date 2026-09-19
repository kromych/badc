
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
               	subq	%rax, %rcx
               	cmpq	$0x10, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	leaq	-0x98(%rbp), %rax
               	leaq	0x3c(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x3c, %rcx
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	-0xd8(%rbp), %rax
               	movb	$0x7, 0x3b(%rax)
               	movzbq	0x3b(%rax), %rax
               	xorq	$0x7, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
