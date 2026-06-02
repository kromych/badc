
array_field_designator.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	leaq	<rip>, %r11
               	movslq	(%r11), %r9
               	cmpq	$0xa, %r9
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	%r11, %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	%r11, %r9
               	addq	$0x8, %r9
               	movslq	(%r9), %r9
               	cmpq	$0x1e, %r9
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	%r11, %r9
               	addq	$0xc, %r9
               	movslq	(%r9), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	addq	$0x10, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x32, %r11
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
