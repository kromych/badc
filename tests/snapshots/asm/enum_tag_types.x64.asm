
enum_tag_types.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %r11
               	addq	$0x64, %r11
               	movslq	%r11d, %rax
               	retq
               	movl	$0x1, %r11d
               	movslq	%r11d, %r11
               	cmpq	$0x1, %r11
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	$0x1, %r11d
               	movslq	%r11d, %r11
               	cmpq	$0x1, %r11
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	movl	$0x2, %r11d
               	addq	$0x64, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x66, %r11
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	movl	$0x2a, %r11d
               	addq	$0x64, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x8e, %r11
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
