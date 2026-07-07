
do_while.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	xorq	%rax, %rax
               	incq	%rax
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	jmp	<addr>
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
