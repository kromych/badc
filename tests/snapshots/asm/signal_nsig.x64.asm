
signal_nsig.x64:	file format elf64-x86-64

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
               	subq	$0x110, %rsp            # imm = 0x110
               	leaq	-0x110(%rbp), %rax
               	addq	$0x108, %rax            # imm = 0x108
               	leaq	-0x110(%rbp), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x104, %rax            # imm = 0x104
               	jge	<addr>
               	movl	$0x5, %eax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
