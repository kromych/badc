
typedef_array_comma_list.x64:	file format elf64-x86-64

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
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	$0x2a, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	xorl	%eax, %eax
               	retq
