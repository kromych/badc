
zero_length_array.x64:	file format elf64-x86-64

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
               	movl	$0x3, <rip> # <addr>
               	movb	$0xa, <rip> # <addr>
               	movb	$0x14, <rip> # <addr>
               	movb	$0x1e, <rip> # <addr>
               	movl	$0x1, <rip> # <addr>
               	movb	$-0x55, <rip> # <addr>
               	movb	$-0x33, <rip> # <addr>
               	movzwq	<rip>, %rax # <addr>
               	andq	$0xff, %rax
               	cmpl	$0xab, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorl	%eax, %eax
               	retq
