
large_stack_frame.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %rdi
               	movslq	%edi, %rdi
               	addq	$0x1, %rdi
               	movslq	%edi, %rdi
               	movslq	%edi, %rdi
               	addq	$0x1, %rdi
               	movslq	%edi, %rdi
               	movslq	%edi, %rax
               	retq
               	movl	$0x28, %r11d
               	movslq	%r11d, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	movslq	%r11d, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	movslq	%r11d, %r11
               	movslq	%r11d, %rax
               	retq
