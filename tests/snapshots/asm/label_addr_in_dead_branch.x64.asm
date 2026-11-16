
label_addr_in_dead_branch.x64:	file format elf64-x86-64

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

<report>:
               	testl	%edi, %edi
               	je	<addr>
               	movq	%rdi, %rax
               	negq	%rax
               	leaq	-<rip>, %rcx # <addr>
               	movl	%eax, <rip> # <addr>
               	movq	%rcx, <rip> # <addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%edi, %edi
               	callq	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
