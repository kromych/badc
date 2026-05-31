
argv_first_char.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %r11
               	movq	%rsi, %r9
               	cmpq	$0x2, %r11
               	jge	<addr>
               	xorq	%rax, %rax
               	retq
               	addq	$0x8, %r9
               	movq	(%r9), %r9
               	movzbq	(%r9), %rax
               	retq
               	addb	%al, (%rax)
