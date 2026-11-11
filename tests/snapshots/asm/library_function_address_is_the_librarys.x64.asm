
library_function_address_is_the_librarys.x64:	file format elf64-x86-64

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
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	xorl	%edx, %edx
               	movl	$0x3, %esi
               	cmpq	%rcx, %rax
               	movq	%rsi, %rax
               	cmoveq	%rdx, %rax
               	popq	%rbp
               	retq
