
expression_precedence.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movl	$0xc, %r11d
               	movslq	%r11d, %r11
               	movq	%r11, %r9
               	addq	$0x2, %r9
               	movslq	%r9d, %r9
               	cmpq	$0xe, %r9
               	sete	%al
               	movzbq	%al, %rax
               	retq
               	addb	%al, (%rax)
