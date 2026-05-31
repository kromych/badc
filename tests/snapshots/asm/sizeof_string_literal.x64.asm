
sizeof_string_literal.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x40024d <.text+0x2d>
               	movl	$0xb, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400263 <.text+0x43>
               	movl	$0xc, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400279 <.text+0x59>
               	movl	$0xd, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x40028f <.text+0x6f>
               	movl	$0xe, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4002a5 <.text+0x85>
               	movl	$0xf, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4002bb <.text+0x9b>
               	movl	$0x10, %eax
               	retq
               	movl	$0x5, %r11d
               	movslq	%r11d, %r11
               	cmpq	$0x5, %r11
               	je	0x4002db <.text+0xbb>
               	movl	$0x11, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	retq
