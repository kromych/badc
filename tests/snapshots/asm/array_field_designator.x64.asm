
array_field_designator.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpq	$0xa, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movslq	0x4(%rax), %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movslq	0x8(%rax), %rcx
               	cmpq	$0x1e, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movslq	0xc(%rax), %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movslq	0x10(%rax), %rax
               	cmpq	$0x32, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
