
nested_function_calls.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<add>:
               	leaq	(%rdi,%rsi), %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	movl	$0xa, %eax
               	movl	$0x14, %ecx
               	addq	%rcx, %rax
               	movl	$0x1e, %edx
               	movl	$0x28, %esi
               	addq	%rsi, %rdx
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
