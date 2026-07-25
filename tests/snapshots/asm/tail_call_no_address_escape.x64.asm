
tail_call_no_address_escape.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x11, %eax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x11, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
