
inline_asm_x64_label_directive.x64:	file format elf64-x86-64

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
               	movl	$0x16, %eax
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x4d, %eax
               	cmpl	$0x4d, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0xf, %eax
               	jmp	<addr>
               	movl	$0x0, %eax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x2a, %eax
               	retq
