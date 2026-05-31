
arithmetic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movl	$0x1e, %r11d
               	movslq	%r11d, %r11
               	shlq	$0x1, %r11
               	movslq	%r11d, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
