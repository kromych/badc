
return_value_in_callee_saved.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<hop_return_n>:
               	movslq	%edi, %rdi
               	cmpq	$0x2, %rdi
               	jge	<addr>
               	movslq	%edi, %rax
               	retq
               	movslq	%edi, %rax
               	retq

<hop>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x7, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
