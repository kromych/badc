
division_under_contradictory_guards.x64:	file format elf64-x86-64

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

<sdiv_dead>:
               	cmpl	$0x5, %esi
               	movl	$0x7, %eax
               	retq

<udiv_dead>:
               	movl	$0x7, %eax
               	retq

<srem_dead>:
               	movl	$0x7, %eax
               	retq

<urem_dead>:
               	cmpl	$0x5, %esi
               	movl	$0x7, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x7, %edi
               	movl	$0x9, %esi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	jne	<addr>
               	movl	$0x7, %edi
               	movl	$0x9, %esi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x7, %edi
               	movl	$0x9, %esi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	jne	<addr>
               	movl	$0x7, %edi
               	movl	$0x9, %esi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x7, %edi
               	movl	$0x2, %esi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	jne	<addr>
               	movl	$0x7, %edi
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
