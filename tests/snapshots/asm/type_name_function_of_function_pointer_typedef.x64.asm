
type_name_function_of_function_pointer_typedef.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	addq	$0x3, %rcx
               	movl	%ecx, (%rax)
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movslq	(%rax), %rcx
               	addq	$0x4, %rcx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	xorl	%eax, %eax
               	retq
