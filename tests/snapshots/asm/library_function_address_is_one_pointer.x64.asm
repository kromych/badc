
library_function_address_is_one_pointer.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x18, %rsp
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	<rip>, %rdi
               	callq	*%rax
               	movq	%rax, 0x8(%rsp)
               	movq	<rip>, %rax # <addr>
               	leaq	<rip>, %rdi
               	callq	*%rax
               	movq	0x8(%rsp), %r10
               	addq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	movq	<rip>, %rax # <addr>
               	leaq	<rip>, %rdi
               	callq	*%rax
               	movq	%rax, %r10
               	movq	0x8(%rsp), %rax
               	addq	%r10, %rax
               	xorl	%ecx, %ecx
               	movl	$0x2, %edx
               	cmpq	$0x6, %rax
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	addq	$0x18, %rsp
               	retq
