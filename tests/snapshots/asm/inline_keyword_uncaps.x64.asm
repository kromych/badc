
inline_keyword_uncaps.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rdi, %r11
               	addq	$0x1, %r11
               	addq	$0x2, %r11
               	addq	$0x3, %r11
               	addq	$0x4, %r11
               	addq	$0x5, %r11
               	addq	$0x6, %r11
               	addq	$0x7, %r11
               	addq	$0x8, %r11
               	addq	$0x9, %r11
               	addq	$0xa, %r11
               	addq	$0xb, %r11
               	addq	$0xc, %r11
               	addq	$0xd, %r11
               	addq	$0xe, %r11
               	addq	$0xf, %r11
               	movq	%r11, %rax
               	addq	$0x10, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorq	%r11, %r11
               	addq	$0x1, %r11
               	addq	$0x2, %r11
               	addq	$0x3, %r11
               	addq	$0x4, %r11
               	addq	$0x5, %r11
               	addq	$0x6, %r11
               	addq	$0x7, %r11
               	addq	$0x8, %r11
               	addq	$0x9, %r11
               	addq	$0xa, %r11
               	addq	$0xb, %r11
               	addq	$0xc, %r11
               	addq	$0xd, %r11
               	addq	$0xe, %r11
               	addq	$0xf, %r11
               	addq	$0x10, %r11
               	movl	$0x64, %r9d
               	addq	$0x1, %r9
               	addq	$0x2, %r9
               	addq	$0x3, %r9
               	addq	$0x4, %r9
               	addq	$0x5, %r9
               	addq	$0x6, %r9
               	addq	$0x7, %r9
               	addq	$0x8, %r9
               	addq	$0x9, %r9
               	addq	$0xa, %r9
               	addq	$0xb, %r9
               	addq	$0xc, %r9
               	addq	$0xd, %r9
               	addq	$0xe, %r9
               	addq	$0xf, %r9
               	addq	$0x10, %r9
               	addq	%r9, %r11
               	cmpq	$0x174, %r11            # imm = 0x174
               	jne	<addr>
               	xorq	%r9, %r9
               	movq	%r9, -0x18(%rbp)
               	jmp	<addr>
               	movl	$0x1, %r9d
               	movq	%r9, -0x18(%rbp)
               	jmp	<addr>
               	movq	-0x18(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
