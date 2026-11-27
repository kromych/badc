
object_size_of_a_dereferenced_pointer_variable.x64:	file format elf64-x86-64

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

<check>:
               	xorl	%eax, %eax
               	retq

<main>:
               	subq	$0x18, %rsp
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	addq	$0x18, %rsp
               	retq
