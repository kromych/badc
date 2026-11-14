
fnptr_array_call.x64:	file format elf64-x86-64

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

<r1>:
               	movl	$0x29, %eax
               	retq

<r2>:
               	movl	$0x2a, %eax
               	retq

<mk1>:
               	leaq	<rip>, %rax # <addr>
               	retq

<mk2>:
               	leaq	<rip>, %rax # <addr>
               	retq

<pick>:
               	leaq	0x1(%rdi), %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	cmpl	$0x29, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movl	(%rax), %eax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movl	(%rax), %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
