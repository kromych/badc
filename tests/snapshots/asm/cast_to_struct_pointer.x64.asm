
cast_to_struct_pointer.x64:	file format elf64-x86-64

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
               	pushq	%rax
               	movl	$0x10, %edi
               	callq	<addr>
               	movl	$0x2a, %ecx
               	movl	%ecx, (%rax)
               	movq	$0x0, 0x8(%rax)
               	movq	%rcx, %rax
               	popq	%r11
               	retq
