
global_initializer_int.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	leaq	<rip>, %r11
               	movslq	(%r11), %r9
               	cmpq	$0x2a, %r9
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %r9
               	leaq	<rip>, %rax
               	movslq	(%rax), %r8
               	addq	%r8, %r9
               	movslq	%r9d, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
