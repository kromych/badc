
paren_comma_side_effect.x64:	file format elf64-x86-64

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

<__c5_lazy_stream>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	popq	%rbp
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	popq	%rbp
               	retq

<main>:
               	movl	$0x0, <rip> # <addr>
               	movl	$0x7, <rip> # <addr>
               	movl	$0x1, <rip> # <addr>
               	movl	$0xb, <rip> # <addr>
               	movl	$0xd, <rip> # <addr>
               	xorl	%eax, %eax
               	retq
