
struct_basic.x64:	file format elf64-x86-64

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
               	movl	$0x8, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x3, %r9d
               	movl	%r9d, (%rax)
               	movq	%rax, %r8
               	addq	$0x4, %r8
               	movl	$0x4, %r9d
               	movl	%r9d, (%r8)
               	movslq	(%rax), %r11
               	movslq	(%rax), %r9
               	imulq	%r9, %r11
               	movslq	%r11d, %r11
               	addq	$0x4, %rax
               	movslq	(%rax), %r9
               	movslq	(%rax), %rax
               	imulq	%rax, %r9
               	movslq	%r9d, %r9
               	addq	%r9, %r11
               	movslq	%r11d, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
