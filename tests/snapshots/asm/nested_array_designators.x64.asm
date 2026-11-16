
nested_array_designators.x64:	file format elf64-x86-64

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
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x28, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x29, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x2a, %eax
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	xorl	%eax, %eax
               	retq
