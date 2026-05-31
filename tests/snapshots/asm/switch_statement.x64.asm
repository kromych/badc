
switch_statement.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x2, %r11d
               	xorq	%r9, %r9
               	movl	%r9d, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %r9d
               	movl	%r9d, -0x10(%rbp)
               	jmp	<addr>
               	movl	$0x14, %r9d
               	movl	%r9d, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r9
               	addq	$0x5, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x10(%rbp)
               	jmp	<addr>
               	movl	$0x64, %r9d
               	movl	%r9d, -0x10(%rbp)
               	jmp	<addr>
               	cmpq	$0x1, %r11
               	je	<addr>
               	cmpq	$0x2, %r11
               	je	<addr>
               	cmpq	$0x3, %r11
               	je	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
