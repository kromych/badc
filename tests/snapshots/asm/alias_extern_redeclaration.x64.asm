
alias_extern_redeclaration.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	xorq	%rcx, %rcx
               	xorq	%rcx, %rcx
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	retq
