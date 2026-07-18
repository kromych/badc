
tail_call_no_address_escape.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<wrap>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rdi, 0x10(%rbp)
               	leaq	0x10(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x11, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x11, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
