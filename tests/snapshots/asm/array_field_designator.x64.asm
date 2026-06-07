
array_field_designator.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	%rcx, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	%rcx, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	%rcx, %rax
               	addq	$0xc, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	addq	$0x10, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0x32, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
