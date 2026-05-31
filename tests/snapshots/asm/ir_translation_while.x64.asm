
ir_translation_while.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	jmp	0x40023c <.text+0x1c>
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400252 <.text+0x32>
               	movl	$0x1, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
               	addb	%al, (%rax)
