
asm_memory_barrier_forwarding.x64:	file format elf64-x86-64

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
               	movl	$0x7, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	cmpl	$0x8, %eax
               	movq	%rdx, %rax
               	cmoveq	%rcx, %rax
               	retq
