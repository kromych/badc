
cast_to_struct_pointer.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x2a, %ecx
               	movl	%ecx, (%rax)
               	xorq	%rdx, %rdx
               	movq	%rdx, 0x8(%rax)
               	movslq	%ecx, %rax
               	popq	%rbp
               	retq
