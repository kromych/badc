
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
               	movslq	%edi, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rdi, %rcx
               	negq	%rcx
               	leaq	-<rip>, %rdx # <addr>
               	leaq	<rip>, %rax # <addr>
               	movl	%ecx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%edi, %edi
               	callq	<addr>
               	leaq	<rip>, %rax # <addr>
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	cmpq	$0x0, 0x8(%rax)
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$-0x3, %ecx
               	jne	<addr>
               	cmpq	$0x0, 0x8(%rax)
               	jne	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
