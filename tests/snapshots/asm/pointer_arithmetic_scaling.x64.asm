
pointer_arithmetic_scaling.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x64, %r11d
               	movq	%r11, %rax
               	addq	$0x4, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
