
inline_asm_a64_operands.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<compute>:
               	leaq	(%rdi,%rsi), %rax
               	shlq	$0x1, %rax
               	retq

<main>:
               	movl	$0x2a, %eax
               	retq
               	addb	%al, 0x41(%rdx)
