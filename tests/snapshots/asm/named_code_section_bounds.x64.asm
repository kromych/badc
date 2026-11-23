
named_code_section_bounds.x64:	file format elf64-x86-64

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

<outside>:
               	leaq	-0x1(%rdi), %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rax # <addr>
               	cmpq	%rax, %rcx
               	jb	<addr>
               	leaq	<rip>, %rdx # <addr>
               	cmpq	%rdx, %rcx
               	jae	<addr>
               	leaq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	jb	<addr>
               	cmpq	%rdx, %rcx
               	jb	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	jb	<addr>
               	cmpq	%rdx, %rcx
               	jae	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	jmp	<addr>

<first>:
               	leaq	0x1(%rdi), %rax
               	retq

<second>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	shlq	%rax
               	popq	%rbp
               	retq
