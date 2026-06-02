
multi_declarator_prototypes.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %rax
               	retq
               	movslq	%edi, %r11
               	shlq	$0x1, %r11
               	movslq	%r11d, %rax
               	retq
               	leaq	<rip>, %r11
               	movl	$0xa, %r9d
               	movl	%r9d, (%r11)
               	movl	$0x3, %r8d
               	cmpq	$0x3, %r8
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x3, %r8d
               	shlq	$0x1, %r8
               	movslq	%r8d, %r8
               	cmpq	$0x6, %r8
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movslq	(%r11), %r11
               	cmpq	$0xa, %r11
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
