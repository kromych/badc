
unsigned_arith_high_half.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

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
               	xorq	%rax, %rax
               	retq
