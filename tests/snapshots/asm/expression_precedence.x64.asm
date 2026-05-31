
expression_precedence.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movl	$0xc, %r11d
               	movslq	%r11d, %r11
               	addq	$0x2, %r11
               	movslq	%r11d, %r11
               	cmpq	$0xe, %r11
               	sete	%al
               	movzbq	%al, %rax
               	retq
               	addb	%al, 0x41(%rdx)
