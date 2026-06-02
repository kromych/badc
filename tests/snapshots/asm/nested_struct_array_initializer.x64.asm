
nested_struct_array_initializer.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	leaq	<rip>, %r11
               	movslq	(%r11), %r9
               	cmpq	$0x64, %r9
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movq	%r11, %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %r9
               	cmpq	$0x1, %r9
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movq	%r11, %r9
               	addq	$0x8, %r9
               	movslq	(%r9), %r9
               	cmpq	$0x2, %r9
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movq	%r11, %r9
               	addq	$0xc, %r9
               	movslq	(%r9), %r9
               	cmpq	$0x3, %r9
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	movq	%r11, %r9
               	addq	$0x10, %r9
               	movslq	(%r9), %r9
               	cmpq	$0x4, %r9
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	movq	%r11, %r9
               	addq	$0x14, %r9
               	movslq	(%r9), %r9
               	cmpq	$0x5, %r9
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	movq	%r11, %r9
               	addq	$0x18, %r9
               	movslq	(%r9), %r9
               	cmpq	$0x6, %r9
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	addq	$0x1c, %r11
               	movslq	(%r11), %r11
               	cmpq	$0xc8, %r11
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	leaq	<rip>, %r11
               	movslq	(%r11), %r11
               	cmpq	$0xa, %r11
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x14, %r11
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x1e, %r11
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0xc, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x28, %r11
               	je	<addr>
               	movl	$0x18, %eax
               	retq
               	leaq	<rip>, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x7, %r11
               	je	<addr>
               	movl	$0x1f, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x8, %r11
               	je	<addr>
               	movl	$0x20, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x9, %r11
               	je	<addr>
               	movl	$0x21, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0xc, %r11
               	movslq	(%r11), %r11
               	cmpq	$0xb, %r11
               	je	<addr>
               	movl	$0x22, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0x10, %r11
               	movslq	(%r11), %r11
               	cmpq	$0xd, %r11
               	je	<addr>
               	movl	$0x23, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0x14, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x11, %r11
               	je	<addr>
               	movl	$0x24, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0x18, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x13, %r11
               	je	<addr>
               	movl	$0x25, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
               	addb	%al, 0x41(%rdx)
