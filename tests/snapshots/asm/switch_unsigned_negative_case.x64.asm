
switch_unsigned_negative_case.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movl	$0x64, %eax
               	movl	$0xc8, %eax
               	movl	$0x5, %eax
               	movl	$0x3e7, %eax            # imm = 0x3E7
               	movl	$0x3e7, %eax            # imm = 0x3E7
               	movl	$0x7, %eax
               	movl	$0x3e7, %eax            # imm = 0x3E7
               	movl	$0x3, %eax
               	movl	$0x64, %eax
               	movl	$0xc8, %eax
               	movl	$0x3e7, %eax            # imm = 0x3E7
               	xorq	%rax, %rax
               	retq
