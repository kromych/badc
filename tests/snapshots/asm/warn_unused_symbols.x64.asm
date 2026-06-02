
warn_unused_symbols.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	shlq	$0x1, %rdi
               	movslq	%edi, %rdi
               	movslq	%edi, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movl	$0x5, %r11d
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	movslq	%r11d, %r11
               	shlq	$0x1, %r11
               	movslq	%r11d, %r11
               	movslq	%r11d, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
