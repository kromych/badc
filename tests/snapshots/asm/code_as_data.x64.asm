
code_as_data.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<target>:
               	movl	$0x7, %eax
               	retq

<main>:
               	leaq	-<rip>, %rax        # <addr>
               	movslq	(%rax), %rax
               	retq
