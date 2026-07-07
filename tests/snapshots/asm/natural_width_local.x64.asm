
natural_width_local.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	addq	$0x4, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	addq	$0x8, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	addb	%al, (%rax)
