
type_warning_return.x64:	file format elf64-x86-64

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

<ret_ptr_as_int>:
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	retq

<ret_int_as_ptr>:
               	movslq	%edi, %rax
               	retq

<ret_null>:
               	xorl	%eax, %eax
               	retq

<ret_ok>:
               	movq	%rdi, %rax
               	retq

<main>:
               	xorl	%eax, %eax
               	retq
