
predefined_constants.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400247 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100d0
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x40025d <.text+0x2d>
               	movl	$0x1, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400273 <.text+0x43>
               	movl	$0x2, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400289 <.text+0x59>
               	movl	$0x3, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x40029f <.text+0x6f>
               	movl	$0x4, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4002b5 <.text+0x85>
               	movl	$0x5, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4002cb <.text+0x9b>
               	movl	$0x6, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4002e1 <.text+0xb1>
               	movl	$0x7, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4002f7 <.text+0xc7>
               	movl	$0x8, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x40030d <.text+0xdd>
               	movl	$0x9, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400323 <.text+0xf3>
               	movl	$0xa, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x40033d <.text+0x10d>
               	movl	$0xb, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x400357 <.text+0x127>
               	movl	$0xc, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x400371 <.text+0x141>
               	movl	$0xd, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
