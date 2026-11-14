
optimize_keeps_assert.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<__c5_assert_fail>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x7, %ecx
               	leaq	<rip>, %rax
               	movq	%rsi, %rdx
               	movq	%rdi, %rsi
               	movq	%rax, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x7, %edx
               	callq	<addr>
               	ud2
