
branch_arms_converge.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x3, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rcx
               	xorl	%eax, %eax
               	movl	%eax, -0x10(%rbp)
               	testq	%rcx, %rcx
               	je	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, -0x10(%rbp)
               	movl	-0x10(%rbp), %ecx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leave
               	retq
               	movl	$0x5, %eax
               	leave
               	retq
