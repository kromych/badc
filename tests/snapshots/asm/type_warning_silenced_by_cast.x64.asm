
type_warning_silenced_by_cast.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movl	$0x5, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
