
switch_statement.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	xorq	%rax, %rax
               	movl	$0x14, %eax
               	addq	$0x5, %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	retq
               	movl	$0xa, %eax
               	jmp	<addr>
               	movl	$0x64, %eax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
