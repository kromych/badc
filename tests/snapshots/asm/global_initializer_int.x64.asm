
global_initializer_int.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	leaq	<rip>, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x2a, %r11
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x63, %r11
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %r11
               	movslq	(%r11), %r11
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	%rax, %r11
               	movslq	%r11d, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
