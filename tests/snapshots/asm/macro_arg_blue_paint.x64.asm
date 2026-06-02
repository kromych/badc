
macro_arg_blue_paint.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	movq	%r9, (%r11)
               	xorq	%rax, %rax
               	retq
               	movq	%rdi, %r11
               	movq	(%r11), %r11
               	movslq	(%r11), %rax
               	retq
               	movq	%rdi, %r11
               	movq	(%r11), %r11
               	movslq	(%r11), %rax
               	retq
               	movq	%rdi, %r11
               	movq	(%r11), %r11
               	movslq	(%r11), %r11
               	addq	$0x7, %r11
               	movslq	%r11d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %r11
               	movl	$0x64, %r9d
               	movl	%r9d, (%r11)
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x8(%rbp), %rsi
               	callq	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0xb, %edi
               	movq	%rdi, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0xc, %edi
               	movq	%rdi, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	addq	$0x7, %rax
               	movslq	%eax, %rax
               	cmpq	$0x6b, %rax
               	je	<addr>
               	movl	$0xd, %edi
               	movq	%rdi, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
