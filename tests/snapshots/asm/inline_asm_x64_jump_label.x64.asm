
inline_asm_x64_jump_label.x64:	file format elf64-x86-64

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
               	jmp	<addr>
               	movl	$0x2, %eax
               	movslq	%eax, %rax
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
