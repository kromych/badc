
attribute_alias_target_later.x64:	file format elf64-x86-64

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

<probe_generic>:
               	movl	<rip>, %eax # <addr>
               	addq	%rdi, %rax
               	movl	%eax, <rip> # <addr>
               	retq

<after_alias>:
               	movl	$0x5, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x1, %edi
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	addq	$0x4, %rax
               	movl	%eax, <rip> # <addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
