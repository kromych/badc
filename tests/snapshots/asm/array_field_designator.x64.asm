
array_field_designator.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	leaq	<rip>, %r11
               	movslq	(%r11), %r11
               	cmpq	$0xa, %r11
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x1e, %r11
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0xc, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0x10, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x32, %r11
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
