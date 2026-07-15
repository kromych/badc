
switch_nested_case_in_compound.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorq	%rax, %rax
               	movl	$0x7, %eax
               	movl	$0x1064, %eax           # imm = 0x1064
               	movl	$0x106b, %eax           # imm = 0x106B
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
