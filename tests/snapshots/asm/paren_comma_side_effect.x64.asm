
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
               	leaq	<rip>, %rax # <addr>
               	cmpq	$0x0, 0x10(%rax)
               	je	<addr>
               	movq	0x10(%rax), %rax
               	popq	%rbp
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rax), %rax
               	movq	%rax, 0x10(%rcx)
               	leaq	<rip>, %rax # <addr>
               	movq	0x10(%rax), %rax
               	popq	%rbp
               	retq

<main>:
               	leaq	<rip>, %rax # <addr>
               	movl	$0x0, (%rax)
               	movl	$0x7, (%rax)
               	movl	$0x1, (%rax)
               	movl	$0xb, (%rax)
               	movl	$0xd, (%rax)
               	xorl	%eax, %eax
               	retq
