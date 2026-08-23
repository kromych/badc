
argv_first_char.x64:	file format elf64-x86-64

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

<main>:
               	cmpl	$0x2, %edi
               	jge	<addr>
               	xorq	%rax, %rax
               	retq
               	movq	0x8(%rsi), %rax
               	movsbq	(%rax), %rax
               	retq
