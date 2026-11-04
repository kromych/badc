
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
               	xorq	$0x28, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	xorq	$0x29, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movzbq	<rip>, %rax # <addr>
               	xorq	$0x2a, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	xorl	%eax, %eax
               	retq
