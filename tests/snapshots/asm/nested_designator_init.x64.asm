
nested_designator_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	<rip>, %r11
               	movslq	(%r11), %r9
               	cmpq	$0x1, %r9
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %r9
               	cmpq	$0x2, %r9
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %r9
               	addq	$0x8, %r9
               	movslq	(%r9), %r9
               	cmpq	$0x3, %r9
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addq	$0xc, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x4, %r11
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %r11d
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %r9
               	pushq	%r11
               	movq	(%r9), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%r9), %r11
               	movq	%r11, 0x8(%rax)
               	popq	%r11
               	leaq	-0x18(%rbp), %rax
               	movl	%r11d, (%rax)
               	movl	$0x14, %r9d
               	leaq	-0x18(%rbp), %rax
               	addq	$0x4, %rax
               	movl	%r9d, (%rax)
               	movl	$0x1e, %r11d
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	movl	%r11d, (%rax)
               	movl	$0x28, %r9d
               	leaq	-0x18(%rbp), %rax
               	addq	$0xc, %rax
               	movl	%r9d, (%rax)
               	leaq	-0x18(%rbp), %r11
               	movslq	(%r11), %r11
               	cmpq	$0xa, %r11
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x14, %r11
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x1e, %r11
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	addq	$0xc, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x28, %r11
               	je	<addr>
               	movl	$0x18, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
