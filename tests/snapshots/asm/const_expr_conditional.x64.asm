
const_expr_conditional.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400247 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100d0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %r11
               	movl	$0x5, %r9d
               	movl	%r9d, (%r11)
               	leaq	-0x10(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x4, %r9
               	movl	$0x7, %r8d
               	movl	%r8d, (%r9)
               	leaq	-0x10(%rbp), %r11
               	movq	%r11, %r8
               	addq	$0x8, %r8
               	movl	$0xe, %r11d
               	movl	%r11d, (%r8)
               	leaq	-0x10(%rbp), %r9
               	movq	%r9, %r11
               	addq	$0xc, %r11
               	movl	$0x1, %r9d
               	movl	%r9d, (%r11)
               	leaq	-0x10(%rbp), %r8
               	movslq	(%r8), %r9
               	leaq	-0x10(%rbp), %r8
               	movq	%r8, %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %r8
               	movq	%r9, %r11
               	addq	%r8, %r11
               	movslq	%r11d, %r11
               	leaq	-0x10(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x8, %r9
               	movslq	(%r9), %r8
               	movq	%r11, %r9
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	leaq	-0x10(%rbp), %r8
               	movq	%r8, %r11
               	addq	$0xc, %r11
               	movslq	(%r11), %r8
               	movq	%r9, %r11
               	addq	%r8, %r11
               	movslq	%r11d, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
