
variable_shadowing.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movl	$0xa, %r11d
               	movl	$0x1, %r9d
               	cmpq	$0x0, %r9
               	je	0x400255 <.text+0x35>
               	jmp	0x400255 <.text+0x35>
               	movslq	%r11d, %rax
               	retq
               	addb	%al, (%rax)
