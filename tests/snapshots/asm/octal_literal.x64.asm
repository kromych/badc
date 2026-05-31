
octal_literal.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
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
               	movl	$0x1e4, %r11d           # imm = 0x1E4
               	cmpq	$0x1e4, %r11            # imm = 0x1E4
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movl	$0x180, %r11d           # imm = 0x180
               	cmpq	$0x180, %r11            # imm = 0x180
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movabsq	$-0x1a5, %r11           # imm = 0xFE5B
               	cmpq	$-0x1a5, %r11           # imm = 0xFE5B
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	movl	$0x2a, %r11d
               	movq	%r11, %rax
               	retq
               	addb	%al, 0x41(%rdx)
