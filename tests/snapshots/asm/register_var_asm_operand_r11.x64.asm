
register_var_asm_operand_r11.x64:	file format elf64-x86-64

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

<mark>:
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	retq

<main>:
               	movl	$0x25, %eax
               	movq	%rax, %r11
               	addq	$0x5, %r11
               	movq	%r11, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x2a, %r11d
               	movq	%r11, <rip>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorl	%eax, %eax
               	retq
