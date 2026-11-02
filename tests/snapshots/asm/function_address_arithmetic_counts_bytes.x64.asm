
function_address_arithmetic_counts_bytes.x64:	file format elf64-x86-64

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

<g>:
               	movl	$0x1, %eax
               	retq

<after>:
               	movl	$0x2, %eax
               	retq

<main>:
               	leaq	-<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rcx
               	movq	<rip>, %rdx # <addr>
               	subq	%rax, %rdx
               	cmpq	$0x1, %rdx
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	subq	%rax, %rdx
               	cmpq	$-0x2, %rdx
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	subq	%rax, %rdx
               	cmpq	$0x3, %rdx
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	subq	%rax, %rdx
               	cmpq	$0x1, %rdx
               	jne	<addr>
               	subq	%rax, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	<rip>, %rcx # <addr>
               	leaq	-<rip>, %rdx # <addr>
               	subq	%rdx, %rcx
               	cmpq	$-0x2, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	subq	%rax, %rcx
               	cmpq	$0x3, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	leaq	-<rip>, %rax # <addr>
               	subq	%rax, %rcx
               	cmpq	$0x3, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	<rip>, %rcx # <addr>
               	subq	%rax, %rcx
               	cmpq	$-0x4, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	subq	%rax, %rcx
               	cmpq	$0x6, %rcx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	subq	%rcx, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorl	%eax, %eax
               	retq
