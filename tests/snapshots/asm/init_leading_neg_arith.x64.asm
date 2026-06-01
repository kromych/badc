
init_leading_neg_arith.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	leaq	<rip>, %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %r11
               	cmpq	$-0x4650, %r11          # imm = 0xB9B0
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0x18, %r11
               	movslq	(%r11), %r11
               	cmpq	$-0x5460, %r11          # imm = 0xABA0
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0x28, %r11
               	movslq	(%r11), %r11
               	cmpq	$-0x6234, %r11          # imm = 0x9DCC
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0x38, %r11
               	movslq	(%r11), %r11
               	cmpq	$-0x9, %r11
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
               	addb	%al, 0x41(%rdx)
