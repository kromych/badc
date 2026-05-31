
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
               	leaq	<rip>, %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xc, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x2, %r9
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	leaq	<rip>, %r9
               	addq	$0xc, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0xe, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x4, %r9
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	leaq	<rip>, %r9
               	addq	$0x14, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x10, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	<rip>, %rax
               	addq	$0x18, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x6, %r9
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	leaq	<rip>, %r9
               	addq	$0x1c, %r9
               	movslq	(%r9), %rax
               	cmpq	$0xc8, %rax
               	je	<addr>
               	movl	$0x12, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %r9
               	cmpq	$0xa, %r9
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	leaq	<rip>, %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x16, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x1e, %r9
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	leaq	<rip>, %r9
               	addq	$0xc, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x28, %rax
               	je	<addr>
               	movl	$0x18, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x7, %r9
               	je	<addr>
               	movl	$0x1f, %eax
               	retq
               	leaq	<rip>, %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x20, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x9, %r9
               	je	<addr>
               	movl	$0x21, %eax
               	retq
               	leaq	<rip>, %r9
               	addq	$0xc, %r9
               	movslq	(%r9), %rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x22, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	movslq	(%rax), %r9
               	cmpq	$0xd, %r9
               	je	<addr>
               	movl	$0x23, %eax
               	retq
               	leaq	<rip>, %r9
               	addq	$0x14, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x11, %rax
               	je	<addr>
               	movl	$0x24, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	<rip>, %rax
               	addq	$0x18, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x13, %r9
               	je	<addr>
               	movl	$0x25, %eax
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	retq
               	addb	%al, (%rax)
