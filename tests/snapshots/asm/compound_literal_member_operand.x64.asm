
compound_literal_member_operand.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	cmpl	$-0x1, %edi
               	setne	%al
               	movzbq	%al, %rax
               	retq

<eq_rhs>:
               	cmpl	$-0x1, %edi
               	sete	%al
               	movzbq	%al, %rax
               	retq

<add_rhs>:
               	leaq	-0x1(%rdi), %rax
               	retq

<swapped>:
               	cmpl	$-0x1, %edi
               	setne	%al
               	movzbq	%al, %rax
               	retq

<main>:
               	xorl	%eax, %eax
               	retq
