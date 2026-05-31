
variable_shadowing.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movl	$0xa, %r11d
               	movl	$0x1, %r9d
               	cmpq	$0x0, %r9
               	je	<addr>
               	jmp	<addr>
               	movslq	%r11d, %rax
               	retq
               	addb	%al, (%rax)
