
octal_literal.x64:	file format elf64-x86-64

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
               	movl	$0x1e4, %r11d           # imm = 0x1E4
               	cmpq	$0x1e4, %r11            # imm = 0x1E4
               	je	0x4002ce <.text+0x9e>
               	movl	$0x6, %eax
               	retq
               	movl	$0x180, %r11d           # imm = 0x180
               	cmpq	$0x180, %r11            # imm = 0x180
               	je	0x4002e7 <.text+0xb7>
               	movl	$0x7, %eax
               	retq
               	movabsq	$-0x1a5, %r11           # imm = 0xFE5B
               	cmpq	$-0x1a5, %r11           # imm = 0xFE5B
               	je	0x400304 <.text+0xd4>
               	movl	$0x8, %eax
               	retq
               	movl	$0x2a, %r11d
               	movq	%r11, %rax
               	retq
               	addb	%al, 0x41(%rdx)
