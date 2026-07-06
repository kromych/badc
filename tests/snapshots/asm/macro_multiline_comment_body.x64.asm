
macro_multiline_comment_body.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	xorq	%rcx, %rcx
               	movl	$0x7, %ecx
               	movslq	%ecx, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x4d2, %rax            # imm = 0x4D2
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	movl	$0x63, %ecx
               	jmp	<addr>
               	addb	%al, (%rax)
