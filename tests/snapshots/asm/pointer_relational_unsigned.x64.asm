
pointer_relational_unsigned.x64:	file format elf64-x86-64

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
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	ja	<addr>
               	movl	$0x1, %eax
               	retq
               	cmpq	%rax, %rcx
               	jbe	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpq	%rcx, %rax
               	jae	<addr>
               	movl	$0x3, %eax
               	retq
               	cmpq	%rcx, %rax
               	ja	<addr>
               	movl	$0x4, %eax
               	retq
               	cmpq	%rcx, %rax
               	jae	<addr>
               	movl	$0x5, %eax
               	retq
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	$0xa, %eax
               	retq
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	$0xb, %eax
               	retq
               	xorl	%eax, %eax
               	retq
