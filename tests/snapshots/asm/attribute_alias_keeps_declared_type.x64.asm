
attribute_alias_keeps_declared_type.x64:	file format elf64-x86-64

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
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	shlq	%rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorl	%eax, %eax
               	retq
