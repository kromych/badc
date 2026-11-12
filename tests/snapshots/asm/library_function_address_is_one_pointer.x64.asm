
library_function_address_is_one_pointer.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	callq	*%rax
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	addq	%rax, %rbx
               	leaq	<rip>, %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	addq	%rbx, %rax
               	xorl	%ecx, %ecx
               	movl	$0x2, %edx
               	cmpq	$0x6, %rax
               	movq	%rdx, %rax
               	cmoveq	%rcx, %rax
               	popq	%rbx
               	leave
               	retq
