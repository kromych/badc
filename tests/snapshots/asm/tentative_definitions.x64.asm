
tentative_definitions.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	leaq	<rip>, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x3, %r11
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %r11
               	movslq	(%r11), %rax
               	movq	%r11, %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %r8
               	addq	%r8, %rax
               	movslq	%eax, %rax
               	addq	$0x8, %r11
               	movslq	(%r11), %r11
               	addq	%r11, %rax
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x2, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
