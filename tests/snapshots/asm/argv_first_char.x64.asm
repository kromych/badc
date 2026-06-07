
argv_first_char.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %rdi
               	cmpq	$0x2, %rdi
               	jge	<addr>
               	xorq	%rax, %rax
               	retq
               	movq	0x8(%rsi), %rax
               	movzbq	(%rax), %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
