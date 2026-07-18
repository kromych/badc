
extern_in_function.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<negate>:
               	imulq	$-0x1, %rdi, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<main>:
               	xorq	%rax, %rax
               	retq
