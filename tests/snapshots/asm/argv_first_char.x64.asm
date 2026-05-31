
argv_first_char.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movslq	%edi, %r11
               	movq	%rsi, %r9
               	cmpq	$0x2, %r11
               	jge	0x40024e <.text+0x2e>
               	xorq	%rax, %rax
               	retq
               	movq	%r9, %r8
               	addq	$0x8, %r8
               	movq	(%r8), %r9
               	movzbq	(%r9), %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
