
attribute_section_placement.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x7, %rax
               	subq	$0x2a, %rax
               	movslq	%eax, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, 0x7(%rax)

<boot>:
               	movl	$0x7, %eax
               	retq
