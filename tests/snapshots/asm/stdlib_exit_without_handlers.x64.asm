
stdlib_exit_without_handlers.x64:	file format elf64-x86-64

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

<handler>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x2, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	-<rip>, %rdi       # <addr>
               	xorl	%esi, %esi
               	movq	%rsi, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x7, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
