
enum_tag_types.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<classify>:
               	leaq	0x64(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	xorq	%rax, %rax
               	retq
               	movl	$0x1, %eax
               	retq
               	movl	$0x2, %eax
               	retq
               	movl	$0x3, %eax
               	retq
               	movl	$0x4, %eax
               	retq
               	movl	$0x5, %eax
               	retq
               	movl	$0x6, %eax
               	retq
               	movl	$0x7, %eax
               	retq
               	movl	$0x8, %eax
               	retq
               	movl	$0x9, %eax
               	retq
               	movl	$0xa, %eax
               	retq
               	movl	$0xb, %eax
               	retq
               	addb	%al, (%rax)
