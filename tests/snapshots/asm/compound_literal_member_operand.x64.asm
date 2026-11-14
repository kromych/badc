
compound_literal_member_operand.x64:	file format elf64-x86-64

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

<ne_rhs>:
               	movq	%rdi, %rax
               	cmpl	$-0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	retq

<eq_rhs>:
               	movq	%rdi, %rax
               	cmpl	$-0x1, %eax
               	sete	%al
               	movzbq	%al, %rax
               	retq

<add_rhs>:
               	movq	%rdi, %rax
               	decq	%rax
               	retq

<swapped>:
               	movq	%rdi, %rax
               	cmpl	$-0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	retq

<main>:
               	xorl	%eax, %eax
               	retq
