
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
               	jmp	<addr>
               	movl	$0x1, %eax
               	retq
               	jmp	<addr>
               	movl	$0x2, %eax
               	retq
               	jmp	<addr>
               	movl	$0x3, %eax
               	retq
               	jmp	<addr>
               	movl	$0x4, %eax
               	retq
               	jmp	<addr>
               	movl	$0x5, %eax
               	retq
               	jmp	<addr>
               	movl	$0x6, %eax
               	retq
               	jmp	<addr>
               	movl	$0x7, %eax
               	retq
               	jmp	<addr>
               	movl	$0x8, %eax
               	retq
               	jmp	<addr>
               	movl	$0x9, %eax
               	retq
               	jmp	<addr>
               	movl	$0xa, %eax
               	retq
               	jmp	<addr>
               	movl	$0xb, %eax
               	retq
               	xorq	%rax, %rax
               	retq
