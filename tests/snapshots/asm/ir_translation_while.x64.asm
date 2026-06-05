
ir_translation_while.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	retq
               	xorq	%rax, %rax
               	retq
