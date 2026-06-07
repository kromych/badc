
tentative_definitions.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rcx
               	movq	%rdx, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	addq	$0x8, %rdx
               	movslq	(%rdx), %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
