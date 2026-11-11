
phi_class_diamond_join.x64:	file format elf64-x86-64

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

<test>:
               	movslq	%edi, %rdi
               	movslq	%edx, %rdx
               	movslq	%esi, %rsi
               	leaq	0x1(%rsi), %rax
               	leaq	-0x1(%rdx), %rcx
               	testq	%rdi, %rdi
               	cmoveq	%rcx, %rax
               	retq

<main>:
               	movl	$0x1e, %eax
               	retq
