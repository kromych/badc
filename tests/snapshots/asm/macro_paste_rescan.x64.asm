
macro_paste_rescan.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movl	$0x3, %r11d
               	cmpq	$0x3, %r11
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movl	$0x3, %r11d
               	cmpq	$0x3, %r11
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movl	$0x32, %r11d
               	movslq	%r11d, %r11
               	cmpq	$0x32, %r11
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movl	$0x11, %r11d
               	movslq	%r11d, %r11
               	cmpq	$0x11, %r11
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	movl	$0x3, %r11d
               	movslq	%r11d, %r11
               	cmpq	$0x3, %r11
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
