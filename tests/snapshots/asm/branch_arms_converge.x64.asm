
branch_arms_converge.x64:	file format elf64-x86-64

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

<same_constant>:
               	movl	$0x2, %eax
               	retq

<both_arms_assign>:
               	movl	$0x5, %eax
               	retq

<or_true>:
               	movl	$0x1, %eax
               	retq

<and_false>:
               	xorl	%eax, %eax
               	retq

<keeps_values>:
               	movl	$0x1, %eax
               	movl	$0x2, %ecx
               	testl	%edi, %edi
               	cmovneq	%rcx, %rax
               	retq

<keeps_store>:
               	testl	%edi, %edi
               	je	<addr>
               	movl	$0x1, (%rsi)
               	xorl	%eax, %eax
               	retq

<main>:
               	subq	$0x18, %rsp
               	movl	$0x3, 0x8(%rsp)
               	movslq	0x8(%rsp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x7, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x5, %eax
               	addq	$0x18, %rsp
               	retq
