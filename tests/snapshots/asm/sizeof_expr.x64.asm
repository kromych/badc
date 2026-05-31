
sizeof_expr.x64:	file format elf64-x86-64

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
               	movl	$0x1, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400263 <.text+0x43>
               	movl	$0x2, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400279 <.text+0x59>
               	movl	$0x3, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x40028f <.text+0x6f>
               	movl	$0x4, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4002a5 <.text+0x85>
               	movl	$0x5, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4002bb <.text+0x9b>
               	movl	$0x6, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4002d1 <.text+0xb1>
               	movl	$0x7, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4002e7 <.text+0xc7>
               	movl	$0x8, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4002fd <.text+0xdd>
               	movl	$0x9, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
