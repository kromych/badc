
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
               	movl	$0x3, %edi
               	movl	%edi, (%rax)
               	movq	%rax, %r8
               	addq	$0x4, %r8
               	movl	$0x4, %edi
               	movl	%edi, (%r8)
               	movslq	(%rax), %r11
               	movslq	(%rax), %rdi
               	imulq	%rdi, %r11
               	movslq	%r11d, %r11
               	addq	$0x4, %rax
               	movslq	(%rax), %rdi
               	movslq	(%rax), %rax
               	imulq	%rax, %rdi
               	movslq	%edi, %rdi
               	addq	%rdi, %r11
               	movslq	%r11d, %r11
               	movq	%r11, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
