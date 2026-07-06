
sizeof_string_literal.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	xorq	%rax, %rax
               	retq
               	movl	$0xb, %eax
               	retq
               	movl	$0xc, %eax
               	retq
               	movl	$0xd, %eax
               	retq
               	movl	$0xe, %eax
               	retq
               	movl	$0xf, %eax
               	retq
               	movl	$0x10, %eax
               	retq
               	movl	$0x11, %eax
               	retq
               	addb	%al, (%rax)
