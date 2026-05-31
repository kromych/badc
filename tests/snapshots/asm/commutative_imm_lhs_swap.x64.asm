
commutative_imm_lhs_swap.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movl	$0x7, %r11d
               	movslq	%r11d, %r9
               	shlq	$0x2, %r9
               	movslq	%r9d, %r9
               	cmpq	$0x1c, %r9
               	je	0x40025a <.text+0x3a>
               	movl	$0x1, %eax
               	retq
               	movslq	%r11d, %r9
               	addq	$0x3, %r9
               	movslq	%r9d, %r9
               	cmpq	$0xa, %r9
               	je	0x40027a <.text+0x5a>
               	movl	$0x2, %eax
               	retq
               	movslq	%r11d, %r9
               	andq	$0xf0, %r9
               	cmpq	$0x0, %r9
               	je	0x400297 <.text+0x77>
               	movl	$0x3, %eax
               	retq
               	movslq	%r11d, %r9
               	orq	$0x10, %r9
               	cmpq	$0x17, %r9
               	je	0x4002b4 <.text+0x94>
               	movl	$0x4, %eax
               	retq
               	movslq	%r11d, %r9
               	xorq	$0xff, %r9
               	cmpq	$0xf8, %r9
               	je	0x4002d1 <.text+0xb1>
               	movl	$0x5, %eax
               	retq
               	movslq	%r11d, %r9
               	cmpq	$0x1, %r9
               	sete	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x0, %r9
               	je	0x4002f6 <.text+0xd6>
               	movl	$0x6, %eax
               	retq
               	movslq	%r11d, %r9
               	cmpq	$0x1, %r9
               	setne	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x1, %r9
               	je	0x40031b <.text+0xfb>
               	movl	$0x7, %eax
               	retq
               	movl	$0xa, %r9d
               	movslq	%r11d, %rax
               	subq	%rax, %r9
               	movslq	%r9d, %r9
               	cmpq	$0x3, %r9
               	je	0x40033d <.text+0x11d>
               	movl	$0x8, %eax
               	retq
               	movslq	%r11d, %r11
               	cmpq	$0x8, %r11
               	setl	%r11b
               	movzbq	%r11b, %r11
               	cmpq	$0x0, %r11
               	jne	0x400362 <.text+0x142>
               	movl	$0x9, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
               	addb	%al, (%rax)
