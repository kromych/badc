
argv_first_char.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %rax
               	movq	%rsi, %rcx
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	jge	<addr>
               	xorq	%rax, %rax
               	retq
               	movq	%rcx, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	retq
