
tentative_definitions.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	leaq	<rip>, %r11
               	movslq	(%r11), %r9
               	cmpq	$0x3, %r9
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %r9
               	movslq	(%r9), %rax
               	movq	%r9, %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %rdi
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	addq	$0x8, %r9
               	movslq	(%r9), %rdi
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x2, %edi
               	movq	%rdi, %rax
               	retq
               	xorq	%rax, %rax
               	retq
