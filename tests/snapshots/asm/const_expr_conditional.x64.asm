
const_expr_conditional.x64:	file format elf64-x86-64

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
               	leaq	-0x10(%rbp), %r11
               	movl	$0x5, %r9d
               	movl	%r9d, (%r11)
               	leaq	-0x10(%rbp), %r8
               	addq	$0x4, %r8
               	movl	$0x7, %r9d
               	movl	%r9d, (%r8)
               	leaq	-0x10(%rbp), %r11
               	addq	$0x8, %r11
               	movl	$0xe, %r9d
               	movl	%r9d, (%r11)
               	leaq	-0x10(%rbp), %r8
               	addq	$0xc, %r8
               	movl	$0x1, %r9d
               	movl	%r9d, (%r8)
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r11
               	leaq	-0x10(%rbp), %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %r9
               	addq	%r9, %r11
               	movslq	%r11d, %r11
               	leaq	-0x10(%rbp), %r9
               	addq	$0x8, %r9
               	movslq	(%r9), %r9
               	addq	%r9, %r11
               	movslq	%r11d, %r11
               	leaq	-0x10(%rbp), %r9
               	addq	$0xc, %r9
               	movslq	(%r9), %r9
               	addq	%r9, %r11
               	movslq	%r11d, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
