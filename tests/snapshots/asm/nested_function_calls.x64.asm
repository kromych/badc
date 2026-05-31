
nested_function_calls.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	addq	%r9, %r11
               	movslq	%r11d, %rax
               	retq
               	movl	$0xa, %r11d
               	movl	$0x14, %r9d
               	addq	%r9, %r11
               	movslq	%r11d, %r11
               	movl	$0x1e, %r9d
               	movl	$0x28, %r8d
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	addq	%r9, %r11
               	movslq	%r11d, %rax
               	retq
