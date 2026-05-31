
global_initializer_pointer.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	leaq	<rip>, %r11
               	movq	(%r11), %r11
               	movslq	(%r11), %r11
               	cmpq	$0x7, %r11
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %r11
               	movl	$0xb, %eax
               	movl	%eax, (%r11)
               	leaq	<rip>, %r8
               	movq	(%r8), %r8
               	movslq	(%r8), %r8
               	cmpq	$0xb, %r8
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorq	%r8, %r8
               	movq	%r8, %rax
               	retq
               	addb	%al, (%rax)
