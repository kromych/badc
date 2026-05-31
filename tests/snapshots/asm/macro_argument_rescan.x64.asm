
macro_argument_rescan.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movl	$0x7, %r11d
               	movslq	%r11d, %r11
               	cmpq	$0x7, %r11
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x4, %r11d
               	movslq	%r11d, %r11
               	cmpq	$0x4, %r11
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0x7b, %r11d
               	movslq	%r11d, %r11
               	cmpq	$0x7b, %r11
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
               	addb	%al, 0x41(%rdx)
