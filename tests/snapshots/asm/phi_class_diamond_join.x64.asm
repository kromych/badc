
phi_class_diamond_join.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<test>:
               	movslq	%edi, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	0x1(%rsi), %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq
               	leaq	-0x1(%rdx), %rax
               	movslq	%eax, %rax
               	jmp	<addr>

<main>:
               	movl	$0xb, %eax
               	movl	$0x13, %eax
               	movl	$0x1e, %eax
               	retq
