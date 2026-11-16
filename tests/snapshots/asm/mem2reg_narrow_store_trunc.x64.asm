
mem2reg_narrow_store_trunc.x64:	file format elf64-x86-64

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

<check>:
               	movsbq	%dil, %rax
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	cmpl	$0x2c, %eax
               	movq	%rdx, %rax
               	cmoveq	%rcx, %rax
               	retq

<main>:
               	xorl	%eax, %eax
               	retq
