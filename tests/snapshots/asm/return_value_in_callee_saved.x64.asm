
return_value_in_callee_saved.x64:	file format elf64-x86-64

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

<hop_return_n>:
               	cmpl	$0x2, %edi
               	jge	<addr>
               	movslq	%edi, %rax
               	retq
               	movslq	%edi, %rax
               	retq

<hop>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	movl	$0x7, %eax
               	movl	$0x7, %eax
               	retq
