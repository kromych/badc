
ptr_to_array_typedef.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax # <addr>
               	movq	$0x2, <rip> # <addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	addq	$0x1e, %rax
               	addq	$0x11, %rax
               	subq	$0x7, %rax
               	retq
