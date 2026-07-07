
inline_keyword_uncaps.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<widen>:
               	leaq	0x1(%rdi), %rax
               	addq	$0x2, %rax
               	addq	$0x3, %rax
               	addq	$0x4, %rax
               	addq	$0x5, %rax
               	addq	$0x6, %rax
               	addq	$0x7, %rax
               	addq	$0x8, %rax
               	addq	$0x9, %rax
               	addq	$0xa, %rax
               	addq	$0xb, %rax
               	addq	$0xc, %rax
               	addq	$0xd, %rax
               	addq	$0xe, %rax
               	addq	$0xf, %rax
               	addq	$0x10, %rax
               	retq

<main>:
               	xorq	%rax, %rax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
