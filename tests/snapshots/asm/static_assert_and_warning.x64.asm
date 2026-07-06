
static_assert_and_warning.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	xorq	%rax, %rax
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	incq	%rax
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
