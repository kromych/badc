
do_while_zero_returns.x64:	file format elf64-x86-64

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

<from_value>:
               	testl	%edi, %edi
               	jge	<addr>
               	movq	%rdi, %rax
               	negq	%rax
               	retq
               	leaq	0x1(%rdi), %rax
               	retq

<classify>:
               	testl	%edi, %edi
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x1, %eax
               	movq	$-0x1, %rcx
               	testl	%edi, %edi
               	cmovleq	%rcx, %rax
               	retq

<main>:
               	xorl	%eax, %eax
               	retq
