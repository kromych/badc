
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
               	leaq	<rip>, %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x80, %rax
               	je	<addr>
               	movl	$0xc, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x4, %r9
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	leaq	<rip>, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x90, %rax
               	je	<addr>
               	movl	$0xe, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	<rip>, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x94, %r9
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	leaq	<rip>, %r9
               	addq	$0x8, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0x10, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x100, %r9             # imm = 0x100
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	leaq	<rip>, %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x40, %rax
               	je	<addr>
               	movl	$0x12, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x11, %r9
               	je	<addr>
               	movl	$0x13, %eax
               	retq
               	leaq	<rip>, %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x70, %rax
               	je	<addr>
               	movl	$0x14, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x30, %r9
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	leaq	<rip>, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x90, %rax
               	je	<addr>
               	movl	$0x16, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	<rip>, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x10, %r9
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	leaq	<rip>, %r9
               	addq	$0x8, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x18, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	<rip>, %rax
               	addq	$0xc, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x14, %r9
               	je	<addr>
               	movl	$0x19, %eax
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	retq
