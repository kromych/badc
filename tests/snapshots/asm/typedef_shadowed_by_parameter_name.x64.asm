
typedef_shadowed_by_parameter_name.x64:	file format elf64-x86-64

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
               	addb	%al, (%rax)
