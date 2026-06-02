
array_init_constant_expression.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	leaq	<rip>, %r11
               	movslq	(%r11), %r9
               	cmpq	$0x10, %r9
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movq	%r11, %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %r9
               	cmpq	$0x80, %r9
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	addq	$0x8, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x4, %r11
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	leaq	<rip>, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x90, %r11
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x94, %r11
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x10, %r11
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	leaq	<rip>, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x100, %r11            # imm = 0x100
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x40, %r11
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	leaq	<rip>, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x11, %r11
               	je	<addr>
               	movl	$0x13, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x70, %r11
               	je	<addr>
               	movl	$0x14, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x30, %r11
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	leaq	<rip>, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x90, %r11
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x10, %r11
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x4, %r11
               	je	<addr>
               	movl	$0x18, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0xc, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x14, %r11
               	je	<addr>
               	movl	$0x19, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
