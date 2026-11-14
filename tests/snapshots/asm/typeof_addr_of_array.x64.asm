
typeof_addr_of_array.x64:	file format elf64-x86-64

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
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x14, %ecx
               	jne	<addr>
               	movl	<rip>, %edx # <addr>
               	cmpl	$0x1e, %edx
               	jne	<addr>
               	movl	<rip>, %esi # <addr>
               	cmpl	$0x28, %esi
               	jne	<addr>
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	cmpl	$0x14, %ecx
               	jne	<addr>
               	cmpl	$0x1e, %edx
               	jne	<addr>
               	cmpl	$0x28, %esi
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
