
local_label.x64:	file format elf64-x86-64

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

<label_address>:
               	leaq	<rip>, %rax # <addr>
               	testl	%edi, %edi
               	je	<addr>
               	jmpq	*%rax
               	movl	$0x8, %eax
               	retq
               	movl	$0x7, %eax
               	retq

<main>:
               	pushq	%rax
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%r11
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
